From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBza2lwIGZ3IHBy?=
 =?UTF-8?Q?i_bo_alloc_for_SRIOV?=
Date: Fri, 17 May 2019 09:20:54 +0200
Message-ID: <0f307e3d-3f5f-3766-6db8-e51ab6c2562e@gmail.com>
References: <1558007618-24482-1-git-send-email-yttao@amd.com>
 <MN2PR12MB3039EAC37D6BB17BD3582D77E50B0@MN2PR12MB3039.namprd12.prod.outlook.com>
 <f77131be-9a53-789d-0f1e-c743c80dc11a@amd.com>
 <MN2PR12MB30390AB5467D6A7080AD45C6E50B0@MN2PR12MB3039.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1388032840=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB30390AB5467D6A7080AD45C6E50B0-rweVpJHSKTr/fpeVZQY9RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1388032840==
Content-Type: multipart/alternative;
 boundary="------------963F868BC249EFA50224614C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------963F868BC249EFA50224614C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yintian,

please add this as a code comment to the patch.

Christian.

Am 17.05.19 um 09:17 schrieb Tao, Yintian:
>
> Hi  Christian
>
>
> Many thanks for your review.
>
>
> The background is that this bo is to let psp load sos and sysdrv but 
> under sriov, sos and sysdrv is loaded by VBIOS or hypervisor driver.
>
>
> The reason why not let guest driver to load it under SRIOV is that it 
> is not safe.
>
>
>
> Best Regards
>
> Yintian Tao
>
> ------------------------------------------------------------------------
> *发件人:* Koenig, Christian
> *发送时间:* 2019年5月17日 14:53:35
> *收件人:* Tao, Yintian
> *抄送:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: [PATCH] drm/amdgpu: skip fw pri bo alloc for SRIOV
> Looks good to me now, but I don't know the technical background why this
> BO is not needed under SRIOV.
>
> So this patch is Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Regards,
> Christian.
>
> Am 17.05.19 um 04:41 schrieb Tao, Yintian:
> > Hi Christian
> >
> >
> > I have modified it according to your suggestion. Can you help review 
> this again? Thanks in advance.
> >
> >
> > Best Regards
> > Yintian Tao
> >
> > -----Original Message-----
> > From: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> > Sent: Thursday, May 16, 2019 7:54 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > Subject: [PATCH] drm/amdgpu: skip fw pri bo alloc for SRIOV
> >
> > PSP fw primary buffer is not used under SRIOV.
> > Therefore, we don't need to allocate memory for it.
> >
> > v2: remove superfluous check for amdgpu_bo_free_kernel().
> >
> > Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index c567a55..af9835c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -905,13 +905,16 @@ static int psp_load_fw(struct amdgpu_device *adev)
> >        if (!psp->cmd)
> >                return -ENOMEM;
> >
> > -     ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> > - AMDGPU_GEM_DOMAIN_GTT,
> > - &psp->fw_pri_bo,
> > - &psp->fw_pri_mc_addr,
> > - &psp->fw_pri_buf);
> > -     if (ret)
> > -             goto failed;
> > +     /* this fw pri bo is not used under SRIOV */
> > +     if (!amdgpu_sriov_vf(psp->adev)) {
> > +             ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> > + AMDGPU_GEM_DOMAIN_GTT,
> > + &psp->fw_pri_bo,
> > + &psp->fw_pri_mc_addr,
> > + &psp->fw_pri_buf);
> > +             if (ret)
> > +                     goto failed;
> > +     }
> >
> >        ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, 
> PAGE_SIZE,
> > AMDGPU_GEM_DOMAIN_VRAM,
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------963F868BC249EFA50224614C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Yintian,<br>
      <br>
      please add this as a code comment to the patch.<br>
      <br>
      Christian.<br>
      <br>
      Am 17.05.19 um 09:17 schrieb Tao, Yintian:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB30390AB5467D6A7080AD45C6E50B0-rweVpJHSKTr/fpeVZQY9RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Hi  Christian</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Many thanks for your
          review.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">The background is that
          this bo is to let psp load sos and sysdrv but under sriov, sos
          and sysdrv is loaded by VBIOS or hypervisor driver.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">The reason why not let
          guest driver to load it under SRIOV is that it is not safe.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Yintian Tao</p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>发件人:</b> Koenig,
          Christian<br>
          <b>发送时间:</b> 2019年5月17日 14:53:35<br>
          <b>收件人:</b> Tao, Yintian<br>
          <b>抄送:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>主题:</b> Re: [PATCH] drm/amdgpu: skip fw pri bo alloc for
          SRIOV</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Looks good to me now, but I don't
              know the technical background why this
              <br>
              BO is not needed under SRIOV.<br>
              <br>
              So this patch is Acked-by: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 17.05.19 um 04:41 schrieb Tao, Yintian:<br>
              &gt; Hi Christian<br>
              &gt;<br>
              &gt;<br>
              &gt; I have modified it according to your suggestion. Can
              you help review this again? Thanks in advance.<br>
              &gt;<br>
              &gt;<br>
              &gt; Best Regards<br>
              &gt; Yintian Tao<br>
              &gt;<br>
              &gt; -----Original Message-----<br>
              &gt; From: Yintian Tao <a class="moz-txt-link-rfc2396E" href="mailto:yttao-5C7GfCeVMHo@public.gmane.org">&lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; Sent: Thursday, May 16, 2019 7:54 PM<br>
              &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt; Cc: Tao, Yintian <a class="moz-txt-link-rfc2396E" href="mailto:Yintian.Tao-5C7GfCeVMHo@public.gmane.org">&lt;Yintian.Tao-5C7GfCeVMHo@public.gmane.org&gt;</a>; Liu,
              Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; Subject: [PATCH] drm/amdgpu: skip fw pri bo alloc for
              SRIOV<br>
              &gt;<br>
              &gt; PSP fw primary buffer is not used under SRIOV.<br>
              &gt; Therefore, we don't need to allocate memory for it.<br>
              &gt;<br>
              &gt; v2: remove superfluous check for
              amdgpu_bo_free_kernel().<br>
              &gt;<br>
              &gt; Signed-off-by: Yintian Tao <a class="moz-txt-link-rfc2396E" href="mailto:yttao-5C7GfCeVMHo@public.gmane.org">&lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17
              ++++++++++-------<br>
              &gt;   1 file changed, 10 insertions(+), 7 deletions(-)<br>
              &gt;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
              &gt; index c567a55..af9835c 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
              &gt; @@ -905,13 +905,16 @@ static int psp_load_fw(struct
              amdgpu_device *adev)<br>
              &gt;        if (!psp-&gt;cmd)<br>
              &gt;                return -ENOMEM;<br>
              &gt;   <br>
              &gt; -     ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG,
              PSP_1_MEG,<br>
              &gt; -                                    
              AMDGPU_GEM_DOMAIN_GTT,<br>
              &gt; -                                    
              &amp;psp-&gt;fw_pri_bo,<br>
              &gt; -                                    
              &amp;psp-&gt;fw_pri_mc_addr,<br>
              &gt; -                                    
              &amp;psp-&gt;fw_pri_buf);<br>
              &gt; -     if (ret)<br>
              &gt; -             goto failed;<br>
              &gt; +     /* this fw pri bo is not used under SRIOV */<br>
              &gt; +     if (!amdgpu_sriov_vf(psp-&gt;adev)) {<br>
              &gt; +             ret = amdgpu_bo_create_kernel(adev,
              PSP_1_MEG, PSP_1_MEG,<br>
              &gt; +                                          
              AMDGPU_GEM_DOMAIN_GTT,<br>
              &gt; +                                          
              &amp;psp-&gt;fw_pri_bo,<br>
              &gt; +                                          
              &amp;psp-&gt;fw_pri_mc_addr,<br>
              &gt; +                                          
              &amp;psp-&gt;fw_pri_buf);<br>
              &gt; +             if (ret)<br>
              &gt; +                     goto failed;<br>
              &gt; +     }<br>
              &gt;   <br>
              &gt;        ret = amdgpu_bo_create_kernel(adev,
              PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,<br>
              &gt;                                       
              AMDGPU_GEM_DOMAIN_VRAM,<br>
              <br>
            </div>
          </span></font></div>
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

--------------963F868BC249EFA50224614C--

--===============1388032840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1388032840==--
