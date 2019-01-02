From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/9] PSP cleanup
Date: Wed, 2 Jan 2019 12:59:53 +0100
Message-ID: <e458fa2c-b541-e757-6a7e-34fbc2e3b8fc@gmail.com>
References: <20190102092141.2196-1-evan.quan@amd.com>
 <070000a9-9abf-1c23-9294-03e8ff6041dd@gmail.com>
 <BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0@BYAPR12MB2632.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1106769431=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0-ZGDeBxoHBPk+ukJnzp2+RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Xu,
 Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1106769431==
Content-Type: multipart/alternative;
 boundary="------------89FDA49D647A2C7BAEEB0AD7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------89FDA49D647A2C7BAEEB0AD7
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> I'd prefer to keep the old structures: common interfaces in 
> amdgpu_psp.c/.h, and IP specific ones in IP specific file.
>
That works for me as well.

Key take away from the change overview is this:
> >   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 381 +----------------
> >   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 539 +-----------------------
> >   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 480 +--------------------
That looks like we can move a good bunch of the per IP specific code 
into the common interface. And that is something I really like to see.

No strong opinion if the common code should go into amdgpu_psp.c/h, 
amdgpu_xgmi.c/h or amdgpu_psp_xgmi.c/h.

The only restriction I have is that we should just stick with the 
existing naming convention.

Christian.

Am 02.01.19 um 11:21 schrieb Zhang, Hawking:
>
> I'd prefer to keep the old structures: common interfaces in 
> amdgpu_psp.c/.h, and IP specific ones in IP specific file.
>
>
> No matter it's something related to ASD,TMR, or XGMI.etc, all of these 
> are just communication/handshake jobs between driver and psp fw. 
> Driver plays messenger role with several psp cmd that are shared among 
> ASIC generations. a unified amdgpu_psp.c file is good enough to hold 
> all the common stuffs.
>
>
> Regards,
> Hawking
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Wednesday, January 2, 2019 6:01:56 PM
> *To:* Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander; Xu, Feifei; Huang, Ray; Zhang, Hawking
> *Subject:* Re: [PATCH 0/9] PSP cleanup
> The general idea looks good, but can we change the file and symbol
> naming a bit?
>
> So far we have named all non-ip version related functions amdgpu_* and
> ip related functions ip_version.
>
> E.g. following this xgmi functions should go into amdgpu_xgmi.c and not
> psp_xgmi.c
>
> Christian.
>
> Am 02.01.19 um 10:21 schrieb Evan Quan:
> > *** BLURB HERE ***
> >
> > Evan Quan (9):
> >    drm/amdgpu: separate the PSP ring related APIs
> >    drm/amdgpu: separate commonly used PSP APIs
> >    drm/amdgpu: separate the xgmi related APIs
> >    drm/amdgpu: separate the tmr related APIs
> >    drm/amdgpu: separate the asd related APIs
> >    drm/amdgpu: drop useless PSP APIs and structures
> >    drm/amdgpu: check PSP support before adding the ip block
> >    drm/amdgpu: make PSP sub modules(ASD/XGMI/TMR) support configurable
> >    drm/amdgpu: move psp_funcs related to a more proper place
> >
> >   drivers/gpu/drm/amd/amdgpu/Makefile     |   7 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 504 +++-------------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  93 +---
> >   drivers/gpu/drm/amd/amdgpu/psp_asd.c    |  86 ++++
> >   drivers/gpu/drm/amd/amdgpu/psp_asd.h    |  32 ++
> >   drivers/gpu/drm/amd/amdgpu/psp_cmn.c    | 289 +++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/psp_cmn.h    |  84 ++++
> >   drivers/gpu/drm/amd/amdgpu/psp_funcs.h  |  98 +++++
> >   drivers/gpu/drm/amd/amdgpu/psp_ring.c   | 354 ++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/psp_ring.h   |  43 ++
> >   drivers/gpu/drm/amd/amdgpu/psp_tmr.c    |  84 ++++
> >   drivers/gpu/drm/amd/amdgpu/psp_tmr.h    |  32 ++
> >   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 381 +----------------
> >   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 539 +-----------------------
> >   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 480 +--------------------
> >   drivers/gpu/drm/amd/amdgpu/psp_xgmi.c   | 207 +++++++++
> >   drivers/gpu/drm/amd/amdgpu/psp_xgmi.h   |  33 ++
> >   drivers/gpu/drm/amd/amdgpu/soc15.c      |  13 +-
> >   18 files changed, 1493 insertions(+), 1866 deletions(-)
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_asd.h
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_cmn.h
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_funcs.h
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_ring.h
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_tmr.h
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_xgmi.h
> >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------89FDA49D647A2C7BAEEB0AD7
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p style="margin-top: 0px; margin-bottom: 0px;">I'd prefer to
          keep the old structures: common interfaces in amdgpu_psp.c/.h,
          and IP specific ones in IP specific file.</p>
      </blockquote>
      That works for me as well.<br>
      <br>
      Key take away from the change overview is this:<font size="2"><span
          style="font-size:11pt;"></span></font><br>
      <font size="2"><span style="font-size:11pt;"></span></font>
      <blockquote type="cite"><font size="2"><span
            style="font-size:11pt;">
            &gt;   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 381
            +----------------<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 539
            +-----------------------<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 480
            +--------------------</span></font></blockquote>
      That looks like we can move a good bunch of the per IP specific
      code into the common interface. And that is something I really
      like to see.<br>
      <br>
      No strong opinion if the common code should go into
      amdgpu_psp.c/h, amdgpu_xgmi.c/h or amdgpu_psp_xgmi.c/h.<br>
      <br>
      The only restriction I have is that we should just stick with the
      existing naming convention.<br>
      <br>
      Christian.<br>
      <br>
      Am 02.01.19 um 11:21 schrieb Zhang, Hawking:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB2632A5BB82C2FCE97AF9E7ECFC8C0-ZGDeBxoHBPk+ukJnzp2+RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top: 0px; margin-bottom: 0px;">I'd prefer to
          keep the old structures: common interfaces in amdgpu_psp.c/.h,
          and IP specific ones in IP specific file.</p>
        <p style="margin-top: 0px; margin-bottom: 0px;"><br>
        </p>
        <p style="margin-top: 0px; margin-bottom: 0px;">No matter it's
          something related to ASD,TMR, or XGMI.etc, all of these are
          just communication/handshake jobs between driver and psp fw.
          Driver plays messenger role with several psp cmd that are
          shared among ASIC generations. a unified amdgpu_psp.c file is
          good enough to hold all the common stuffs.
        </p>
        <p style="margin-top: 0px; margin-bottom: 0px;"><br>
        </p>
        <p style="margin-top: 0px; margin-bottom: 0px;">Regards,<br>
          Hawking<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Wednesday, January 2, 2019 6:01:56 PM<br>
          <b>To:</b> Quan, Evan; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> Deucher, Alexander; Xu, Feifei; Huang, Ray; Zhang,
          Hawking<br>
          <b>Subject:</b> Re: [PATCH 0/9] PSP cleanup</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">The general idea looks good, but can
              we change the file and symbol
              <br>
              naming a bit?<br>
              <br>
              So far we have named all non-ip version related functions
              amdgpu_* and <br>
              ip related functions ip_version.<br>
              <br>
              E.g. following this xgmi functions should go into
              amdgpu_xgmi.c and not <br>
              psp_xgmi.c<br>
              <br>
              Christian.<br>
              <br>
              Am 02.01.19 um 10:21 schrieb Evan Quan:<br>
              &gt; *** BLURB HERE ***<br>
              &gt;<br>
              &gt; Evan Quan (9):<br>
              &gt;    drm/amdgpu: separate the PSP ring related APIs<br>
              &gt;    drm/amdgpu: separate commonly used PSP APIs<br>
              &gt;    drm/amdgpu: separate the xgmi related APIs<br>
              &gt;    drm/amdgpu: separate the tmr related APIs<br>
              &gt;    drm/amdgpu: separate the asd related APIs<br>
              &gt;    drm/amdgpu: drop useless PSP APIs and structures<br>
              &gt;    drm/amdgpu: check PSP support before adding the ip
              block<br>
              &gt;    drm/amdgpu: make PSP sub modules(ASD/XGMI/TMR)
              support configurable<br>
              &gt;    drm/amdgpu: move psp_funcs related to a more
              proper place<br>
              &gt;<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/Makefile     |   7 +-<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 504
              +++-------------------<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  93 +---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_asd.c    |  86 ++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_asd.h    |  32 ++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_cmn.c    | 289
              +++++++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_cmn.h    |  84 ++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_funcs.h  |  98 +++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_ring.c   | 354
              ++++++++++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_ring.h   |  43 ++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_tmr.c    |  84 ++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_tmr.h    |  32 ++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 381
              +----------------<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 539
              +-----------------------<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 480
              +--------------------<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_xgmi.c   | 207
              +++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/psp_xgmi.h   |  33 ++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/soc15.c      |  13 +-<br>
              &gt;   18 files changed, 1493 insertions(+), 1866
              deletions(-)<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_asd.c<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_asd.h<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_cmn.c<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_cmn.h<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_funcs.h<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_ring.c<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_ring.h<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_tmr.c<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_tmr.h<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_xgmi.c<br>
              &gt;   create mode 100644
              drivers/gpu/drm/amd/amdgpu/psp_xgmi.h<br>
              &gt;<br>
              <br>
            </div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------89FDA49D647A2C7BAEEB0AD7--

--===============1106769431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1106769431==--
