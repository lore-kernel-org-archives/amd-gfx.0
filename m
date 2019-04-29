From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: print firmware versions on amdgpu sysfs
Date: Mon, 29 Apr 2019 14:22:03 +0200
Message-ID: <d6c60e91-4311-069b-0612-03337830481d@gmail.com>
References: <355c6cb6-ccf7-ef6f-4f34-0e978b9effe2@amd.com>
 <CY4PR12MB18136C9A3F7719CFD0C50D60F73E0@CY4PR12MB1813.namprd12.prod.outlook.com>
 <BN6PR12MB1618CE8C21ED572094D9BB10853E0@BN6PR12MB1618.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0456384584=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1618CE8C21ED572094D9BB10853E0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Freehill, Chris" <Chris.Freehill-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0456384584==
Content-Type: multipart/alternative;
 boundary="------------56D911CAFF7E38DEC613DAD3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------56D911CAFF7E38DEC613DAD3
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

We just need to keep in mind that sysfs has more restrictions than debugfs.

E.g. one value per file, backward compatibility etc...

Apart from that I don't see any reason to not do it in sysfs.

Christian.

Am 26.04.19 um 20:35 schrieb Russell, Kent:
> The main reasoning and use case for sysfs would be the SMI CLI, since 
> unfortunately there is no ioctl support in there.
>
> Kent
>
> KENT RUSSELL
> Sr. Software Engineer | Linux Compute Kernel
> 1 Commerce Valley Drive East
> Markham, ON L3T 7X6
> O +(1) 289-695-2122 | Ext 72122
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, April 26, 2019 12:18:22 PM
> *To:* Lin, Amber; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Freehill, Chris
> *Subject:* Re: print firmware versions on amdgpu sysfs
> We also expose the firmware versions via ioctl which is what the UMDs 
> uses.  If you'd prefer it in sysfs, we could do that too.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Lin, Amber <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, April 26, 2019 10:14 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Freehill, Chris
> *Subject:* print firmware versions on amdgpu sysfs
> Hi Alex,
>
> Currently we retrieve firmware versions from /sys/kernel/debug but this
> requires debugfs being enabled and superuser privilege. Do you see a
> concern we add firmware versions to amdgpu sysfs at
> /sys/class/drm/cardX/device like vbios_version?
>
> Regards,
> Amber
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------56D911CAFF7E38DEC613DAD3
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">We just need to keep in mind that sysfs
      has more restrictions than debugfs.<br>
      <br>
      E.g. one value per file, backward compatibility etc...<br>
      <br>
      Apart from that I don't see any reason to not do it in sysfs.<br>
      <br>
      Christian. <br>
      <br>
      Am 26.04.19 um 20:35 schrieb Russell, Kent:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1618CE8C21ED572094D9BB10853E0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      The main reasoning and use case for sysfs would be the SMI CLI,
      since unfortunately there is no ioctl support in there.
      <br>
      <br>
      Kent<br>
      <br>
      KENT RUSSELL<br>
      Sr. Software Engineer | Linux Compute Kernel<br>
      1 Commerce Valley Drive East<br>
      Markham, ON L3T 7X6<br>
      O +(1) 289-695-2122 | Ext 72122<br>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Friday, April 26, 2019 12:18:22 PM<br>
          <b>To:</b> Lin, Amber; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> Freehill, Chris<br>
          <b>Subject:</b> Re: print firmware versions on amdgpu sysfs</font>
        <div> </div>
      </div>
      <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          We also expose the firmware versions via ioctl which is what
          the UMDs uses.  If you'd prefer it in sysfs, we could do that
          too.<br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          Alex</div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
            behalf of Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin-5C7GfCeVMHo@public.gmane.org">&lt;Amber.Lin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Friday, April 26, 2019 10:14 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Cc:</b> Freehill, Chris<br>
            <b>Subject:</b> print firmware versions on amdgpu sysfs</font>
          <div> </div>
        </div>
        <div class="x_BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="x_PlainText">Hi Alex,<br>
                <br>
                Currently we retrieve firmware versions from
                /sys/kernel/debug but this <br>
                requires debugfs being enabled and superuser privilege.
                Do you see a <br>
                concern we add firmware versions to amdgpu sysfs at <br>
                /sys/class/drm/cardX/device like vbios_version?<br>
                <br>
                Regards,<br>
                Amber<br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------56D911CAFF7E38DEC613DAD3--

--===============0456384584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0456384584==--
