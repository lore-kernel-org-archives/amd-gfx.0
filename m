From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add missing extern "C" headers
Date: Mon, 15 May 2017 08:47:50 +0200
Message-ID: <a3fb72d3-df0b-dbe6-0e1e-368cac7c865d@vodafone.de>
References: <MWHPR1201MB0045E9D90A0D03FCCFBF7BC1F2E10@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <5a6edb32-1899-697c-156b-ddeaeaa67147@daenzer.net>
 <MWHPR1201MB00458FBE22404D8AF12A043EF2E10@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0066027022=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB00458FBE22404D8AF12A043EF2E10-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0066027022==
Content-Type: multipart/alternative;
 boundary="------------7EF1886BC3041FE93AC2CF2C"

This is a multi-part message in MIME format.
--------------7EF1886BC3041FE93AC2CF2C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Michel you need more coffee :)

And yes, there are two header files. amdgpu_drm.h is the one synced from 
the kernel, amdgpu.h is the one local to libdrm.

Regards,
Christian.

Am 15.05.2017 um 04:39 schrieb Xie, AlexBin:
>
> Hi Michel,
>
>
> This patch was from Nicolai.
>
>
> Though there are two amdgpu.h, one header is in kernel and the other 
> header is in libdrm. But their content are irrelevant. They are not 
> synchronized.
>
>
> I think include/drm/README is not applicable to this case.
>
>
> Thanks,
>
> Alex Bin Xie
>
>
> ------------------------------------------------------------------------
> *From:* Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> *Sent:* Sunday, May 14, 2017 10:09 PM
> *To:* Xie, AlexBin; Haehnle, Nicolai
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH libdrm] amdgpu: add missing extern "C" headers
> On 15/05/17 10:10 AM, Xie, AlexBin wrote:
> >  amdgpu/amdgpu.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> This header is synchronized with the kernel, see include/drm/README.
>
>
> BTW, don't send patches for review as HTML. Ideally use git send-email.
>
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



--------------7EF1886BC3041FE93AC2CF2C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Michel you need more coffee :)<br>
      <br>
      And yes, there are two header files. amdgpu_drm.h is the one
      synced from the kernel, amdgpu.h is the one local to libdrm.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 15.05.2017 um 04:39 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB00458FBE22404D8AF12A043EF2E10-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Hi Michel,</p>
        <p><br>
        </p>
        <p>This patch was from Nicolai.</p>
        <p><br>
        </p>
        <p>Though there are two amdgpu.h, one header is in kernel and
          the other header is in libdrm. But their content are
          irrelevant. They are not synchronized.
          <br>
        </p>
        <p><br>
        </p>
        <p>I think include/drm/README is not applicable to this case.<br>
        </p>
        <br>
        <p>Thanks,</p>
        <p>Alex Bin Xie<br>
        </p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> Michel Dänzer
                <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Sunday, May 14, 2017 10:09 PM<br>
                <b>To:</b> Xie, AlexBin; Haehnle, Nicolai<br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH libdrm] amdgpu: add missing
                extern "C" headers</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">On 15/05/17 10:10 AM, Xie, AlexBin
                wrote:<br>
                &gt;  amdgpu/amdgpu.h | 8 ++++++++<br>
                &gt;  1 file changed, 8 insertions(+)<br>
                <br>
                This header is synchronized with the kernel, see
                include/drm/README.<br>
                <br>
                <br>
                BTW, don't send patches for review as HTML. Ideally use
                git send-email.<br>
                <br>
                <br>
                -- <br>
                Earthling Michel Dänzer               |               <a
                  moz-do-not-send="true" href="http://www.amd.com"
                  id="LPlnk7787" previewremoved="true">
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

--------------7EF1886BC3041FE93AC2CF2C--

--===============0066027022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0066027022==--
