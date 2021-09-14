package com.sample.mypdfdownload

import android.Manifest
import android.app.DownloadManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.view.View
import android.webkit.PermissionRequest
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.core.content.FileProvider
import com.karumi.dexter.Dexter
import com.karumi.dexter.MultiplePermissionsReport
import com.karumi.dexter.PermissionToken
import com.karumi.dexter.listener.multi.MultiplePermissionsListener
import java.io.File
import java.net.MalformedURLException
import java.net.URL

class MainActivity : AppCompatActivity(),View.OnClickListener {

    lateinit var tvUrl:TextView
    lateinit var btnDownload:Button
    lateinit var btnView:Button

    var url: URL? =null
    var fileName:String="File Name.pdf"
    var filePath="http://www.africau.edu/images/default/sample.pdf"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViews()
        setListeners()
    }

    private fun initViews() {
        tvUrl=findViewById(R.id.tvurl)
        btnDownload=findViewById(R.id.btnDownload)
        btnView=findViewById(R.id.btnView)

        try {
            url=URL(filePath)
        }catch (e:MalformedURLException){
            e.printStackTrace()
        }

        fileName=url!!.path

        fileName=fileName.substring(fileName.lastIndexOf('/')+1)

        tvUrl.text=fileName

    }
    private fun setListeners() {
        btnDownload.setOnClickListener(this)
        btnView.setOnClickListener(this)
    }

    override fun onClick(v: View?) {

        when(v!!.id)
        {
            R.id.btnDownload->
            {
                Dexter.withContext(this@MainActivity)
                    .withPermissions(
                        Manifest.permission.READ_EXTERNAL_STORAGE
                        ,Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    .withListener(object: MultiplePermissionsListener {
                        override fun onPermissionsChecked(report: MultiplePermissionsReport?) {
                            report?.let {
                                if(report.areAllPermissionsGranted()){
                                    downloadingFile()
                                }
                            }
                        }

                        override fun onPermissionRationaleShouldBeShown(
                            p0: MutableList<com.karumi.dexter.listener.PermissionRequest>?,
                            p1: PermissionToken?
                        ) {
                            p1?.continuePermissionRequest()
                        }

                    })
                    .withErrorListener {
                        Toast.makeText(this,"Error occured",Toast.LENGTH_SHORT).show()
                    }
                    .check()



            }

            R.id.btnView->
            {
                var file: File =
                    File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).toString()+"/"+fileName)

                var uri:Uri=FileProvider.getUriForFile(this,"com.sample.mypdfdownload.provider",file)

                var intent:Intent= Intent(Intent.ACTION_VIEW)
                intent.setDataAndType(uri,"application/pdf")
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP )
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                startActivity(intent)
            }
        }

    }

    fun downloadingFile(){
        var request:DownloadManager.Request=DownloadManager.Request(Uri.parse(url.toString()))
        request.setTitle(fileName)
        request.setMimeType("application/pdf")
        request.allowScanningByMediaScanner()
        request.setAllowedOverMetered(true)
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS,fileName)

        var dm:DownloadManager=getSystemService(DOWNLOAD_SERVICE) as DownloadManager

        dm.enqueue(request)
    }

}