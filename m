From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: update documentation for amdgpu_drv.c
Date: Thu, 5 Jul 2018 16:54:27 +0200
Message-ID: <131f66f1-8871-de93-2c3a-50b8c15cb9d8@amd.com>
References: <1530728444-32347-1-git-send-email-sonny.jiang@amd.com>
 <7279fc27-0bba-a818-7682-f4e06815b8da@gmail.com>
 <CY4PR12MB1511F4BC97EABF20A34503D8FD400@CY4PR12MB1511.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0715261428=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1511F4BC97EABF20A34503D8FD400-rpdhrqHFk06XKdXwTjA44gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0715261428==
Content-Type: multipart/alternative;
 boundary="------------528DD267A3719E0F5A4077FB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------528DD267A3719E0F5A4077FB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Sounds like my memory fooled me, but we should document that as well.

Christian.

Am 05.07.2018 um 16:47 schrieb Jiang, Sonny:
>
> Change it to,
>
> Value 0 is invalidated, will be adjusted to 10000. Negative values 
> mean 'infinite timeout' (MAX_JIFFY_OFFSET).
>
>
> Thanks,
>
> Sonny
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, July 5, 2018 3:30:28 AM
> *To:* Jiang, Sonny; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH v3] drm/amdgpu: update documentation for 
> amdgpu_drv.c
> Am 04.07.2018 um 20:20 schrieb Sonny Jiang:
> > [SNIP]
> >
> > +/**
> > + * DOC: lockup_timeout (int)
> > + * Set GPU scheduler timeout value in ms. It must be > 0.  The 
> default is 10000.
> > + */
> >   MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms > 0 
> (default 10000)");
> >   module_param_named(lockup_timeout, amdgpu_lockup_timeout, int, 0444);
>
> Actually the description here is incorrect, a value of 0 is handled as
> infinite timeout IIRC. Please fix while at it.
>
> Apart from that the patch is Acked-by: Christian König
> <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Christian.


--------------528DD267A3719E0F5A4077FB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Sounds like my memory fooled me, but we
      should document that as well.<br>
      <br>
      Christian.<br>
      <br>
      Am 05.07.2018 um 16:47 schrieb Jiang, Sonny:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1511F4BC97EABF20A34503D8FD400-rpdhrqHFk06XKdXwTjA44gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Change it to,</p>
        <div>Value 0 is invalidated, will be adjusted to 10000. 
          Negative values mean 'infinite timeout' (MAX_JIFFY_OFFSET).</div>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Thanks,</p>
        <p style="margin-top:0;margin-bottom:0">Sonny<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          color="#000000" face="Calibri, sans-serif"><b>From:</b>
          Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Thursday, July 5, 2018 3:30:28 AM<br>
          <b>To:</b> Jiang, Sonny; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH v3] drm/amdgpu: update
          documentation for amdgpu_drv.c</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Am 04.07.2018 um 20:20 schrieb Sonny
              Jiang:<br>
              &gt; [SNIP]<br>
              &gt;   <br>
              &gt; +/**<br>
              &gt; + * DOC: lockup_timeout (int)<br>
              &gt; + * Set GPU scheduler timeout value in ms. It must be
              &gt; 0.  The default is 10000.<br>
              &gt; + */<br>
              &gt;   MODULE_PARM_DESC(lockup_timeout, "GPU lockup
              timeout in ms &gt; 0 (default 10000)");<br>
              &gt;   module_param_named(lockup_timeout,
              amdgpu_lockup_timeout, int, 0444);<br>
              <br>
              Actually the description here is incorrect, a value of 0
              is handled as <br>
              infinite timeout IIRC. Please fix while at it.<br>
              <br>
              Apart from that the patch is Acked-by: Christian König <br>
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
              <br>
              Christian.<br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------528DD267A3719E0F5A4077FB--

--===============0715261428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0715261428==--
