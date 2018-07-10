From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: move cache window setup after power and
 clock resume
Date: Tue, 10 Jul 2018 09:13:31 +0200
Message-ID: <e8e55918-e787-49fb-328b-391ad6d5a899@gmail.com>
References: <20180709161138.5319-1-leo.liu@amd.com>
 <20180709161138.5319-3-leo.liu@amd.com>
 <BN6PR12MB18099B0BE2002A60EDEC16FBF7440@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863935375=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18099B0BE2002A60EDEC16FBF7440-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1863935375==
Content-Type: multipart/alternative;
 boundary="------------85FBE5D61700115AF1D275B5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------85FBE5D61700115AF1D275B5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Looks like the patches should be reordered, e.g. patch #2 should be the 
last.

Apart from that Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

Am 09.07.2018 um 18:54 schrieb Deucher, Alexander:
>
> Series is:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, July 9, 2018 12:11:38 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Liu, Leo
> *Subject:* [PATCH 3/3] drm/amdgpu: move cache window setup after power 
> and clock resume
> To make register read/write reliable. Along with the previous patch,
> VCN will work with dpm disabled case.
>
> Signed-off-by: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index b82c92084b6f..ca4265bc10b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -600,12 +600,12 @@ static int vcn_v1_0_start(struct amdgpu_device 
> *adev)
>          /* disable byte swapping */
>          lmi_swap_cntl = 0;
>
> -       vcn_v1_0_mc_resume(adev);
> -
>          vcn_1_0_disable_static_power_gating(adev);
>          /* disable clock gating */
>          vcn_v1_0_disable_clock_gating(adev);
>
> +       vcn_v1_0_mc_resume(adev);
> +
>          /* disable interupt */
>          WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
>                          ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------85FBE5D61700115AF1D275B5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Looks like the patches should be
      reordered, e.g. patch #2 should be the last.<br>
      <br>
      Apart from that Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.07.2018 um 18:54 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18099B0BE2002A60EDEC16FBF7440-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Series is:</p>
        <p style="margin-top:0;margin-bottom:0">Reviewed-by: Alex
          Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          color="#000000" face="Calibri, sans-serif"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu-5C7GfCeVMHo@public.gmane.org">&lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Monday, July 9, 2018 12:11:38 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> Liu, Leo<br>
          <b>Subject:</b> [PATCH 3/3] drm/amdgpu: move cache window
          setup after power and clock resume</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">To make register read/write reliable.
              Along with the previous patch,<br>
              VCN will work with dpm disabled case.<br>
              <br>
              Signed-off-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu-5C7GfCeVMHo@public.gmane.org">&lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 ++--<br>
               1 file changed, 2 insertions(+), 2 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
              b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              index b82c92084b6f..ca4265bc10b9 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              @@ -600,12 +600,12 @@ static int vcn_v1_0_start(struct
              amdgpu_device *adev)<br>
                       /* disable byte swapping */<br>
                       lmi_swap_cntl = 0;<br>
               <br>
              -       vcn_v1_0_mc_resume(adev);<br>
              -<br>
                       vcn_1_0_disable_static_power_gating(adev);<br>
                       /* disable clock gating */<br>
                       vcn_v1_0_disable_clock_gating(adev);<br>
               <br>
              +       vcn_v1_0_mc_resume(adev);<br>
              +<br>
                       /* disable interupt */<br>
                       WREG32_P(SOC15_REG_OFFSET(UVD, 0,
              mmUVD_MASTINT_EN), 0,<br>
                                       ~UVD_MASTINT_EN__VCPU_EN_MASK);<br>
              -- <br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
      <!--'"--><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------85FBE5D61700115AF1D275B5--

--===============1863935375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1863935375==--
