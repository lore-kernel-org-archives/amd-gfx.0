From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterruptible
 waits for cleanup
Date: Mon, 1 May 2017 16:28:14 +0200
Message-ID: <064b2ea6-1b57-0c4d-0818-6eb017887e55@vodafone.de>
References: <mailman.1551.1493369856.21890.amd-gfx@lists.freedesktop.org>
 <MWHPR1201MB0045C097101B0EDA13F28BD9F2130@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <73b82af4-7903-512e-fe61-f05ebf18381f@daenzer.net>
 <MWHPR1201MB004532EF4E87E5503BEAC217F2140@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1719070273=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB004532EF4E87E5503BEAC217F2140-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1719070273==
Content-Type: multipart/alternative;
 boundary="------------3CF0B9E966B43D8F1AF9457A"

This is a multi-part message in MIME format.
--------------3CF0B9E966B43D8F1AF9457A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.05.2017 um 02:13 schrieb Xie, AlexBin:
>
> On 28/04/17 11:12 PM, Xie, AlexBin wrote:
>
> >> Am 28.04.2017 um 10:47 schrieb Michel Dänzer:
> >>> From: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >>>
> >>> Some of these paths probably cannot be interrupted by a signal anyway.
> >>> Those that can would fail to clean up things if they actually got
> >>> interrupted.
> >>>
> >>> Signed-off-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >>
> >> Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >
> > Alex X: Just a reminder: amdgpu_unpin_work_func is called by work queue.
> > Signal is blocked already. un-interruptible waiting might slow thing
> > down very slightly.
>
> How so?
>
> Alex X: I said "might". If you think it is not slower, it is fine for me.
> My real concern is that the signals are blocked for work queue 
> already. We don't need this change to avoid unnecessary risk.
> In theory, I am not against this change.

I have to agree with that. For waits from work queues it is usually best 
to implicitly use un-interruptible waits for documentation purposes.

In other words even when we are sure that the code can't receive a 
signal we should write it conservatively.

Christian.

>
> -- 
> Earthling Michel Dänzer               | http://www.amd.com 
> <http://www.amd.com>
> Libre software enthusiast             |             Mesa and X developer
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------3CF0B9E966B43D8F1AF9457A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 01.05.2017 um 02:13 schrieb Xie,
      AlexBin:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB004532EF4E87E5503BEAC217F2140-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p><span style="font-size: 10pt;">On 28/04/17 11:12 PM, Xie,
            AlexBin wrote:</span><br>
        </p>
        <div style="color: rgb(0, 0, 0);"><font size="2"><span
              style="font-size:10pt;">
              <div class="PlainText">&gt;&gt; Am 28.04.2017 um 10:47
                schrieb Michel Dänzer:<br>
                &gt;&gt;&gt; From: Michel Dänzer
                <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; Some of these paths probably cannot be
                interrupted by a signal anyway.<br>
                &gt;&gt;&gt; Those that can would fail to clean up
                things if they actually got<br>
                &gt;&gt;&gt; interrupted.<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; Signed-off-by: Michel Dänzer
                <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt; <br>
                &gt;&gt; Reviewed-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; <br>
                &gt; Alex X: Just a reminder: amdgpu_unpin_work_func is
                called by work queue.<br>
                &gt; Signal is blocked already. un-interruptible waiting
                might slow thing<br>
                &gt; down very slightly.<br>
                <br>
                How so?<br>
                <br>
                Alex X: I said "might". If you think it is not slower,
                it is fine for me.</div>
              <div class="PlainText">My real concern is that the signals
                are blocked for work queue already. We don't need this
                change to avoid unnecessary risk.</div>
              <div class="PlainText">In theory, I am not against this
                change.</div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
    I have to agree with that. For waits from work queues it is usually
    best to implicitly use un-interruptible waits for documentation
    purposes.<br>
    <br>
    In other words even when we are sure that the code can't receive a
    signal we should write it conservatively.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:MWHPR1201MB004532EF4E87E5503BEAC217F2140-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <div style="color: rgb(0, 0, 0);"><font size="2"><span
              style="font-size:10pt;">
              <div class="PlainText"><br>
                -- <br>
                Earthling Michel Dänzer               |               <a
                  moz-do-not-send="true" href="http://www.amd.com"
                  id="LPlnk108541" previewremoved="true">
                  http://www.amd.com</a><br>
                Libre software enthusiast             |             Mesa
                and X developer<br>
              </div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------3CF0B9E966B43D8F1AF9457A--

--===============1719070273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1719070273==--
