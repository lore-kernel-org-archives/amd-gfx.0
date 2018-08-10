From: "S, Shirish" <sshankar-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdpu/vce_v3: skip suspend and resume if powergated
Date: Fri, 10 Aug 2018 12:45:01 +0530
Message-ID: <f68e0bfb-0ad5-8ae7-1b73-c8dc35bc5358@amd.com>
References: <1533881700-10371-1-git-send-email-shirish.s@amd.com>
 <BYAPR12MB2775F1BD12A3F215A6F5C936FB240@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0990311926=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2775F1BD12A3F215A6F5C936FB240-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0990311926==
Content-Type: multipart/alternative;
 boundary="------------5311365E7BC8463906096B8A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5311365E7BC8463906096B8A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/2018 12:02 PM, Zhu, Rex wrote:
>
> I am Ok with the check when call vce_v3_0_hw_fini.
>
>
> But we may still need to call amdpug_vce_suspend/resume.
>
Done in V2. Have moved the check such that both are executed.
Regards,
Shirish S
>
>
> and not sure whether need to do ring test when resume back.
>
>
> Best Regards
>
> Rex
>
> ------------------------------------------------------------------------
> *From:* S, Shirish
> *Sent:* Friday, August 10, 2018 2:15 PM
> *To:* Deucher, Alexander; Zhu, Rex; Liu, Leo
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S, Shirish
> *Subject:* [PATCH] drm/amdpu/vce_v3: skip suspend and resume if 
> powergated
> This patch adds a mechanism by which the VCE 3.0 block
> shall check if it was enabled or in use before suspending,
> if it was powergated while entering suspend then there
> is no need to repeat it in vce_3_0_suspend().
> Similarly, if the block was powergated while entering suspend
> itself then there is no need to resume it.
>
> By this we not only make the suspend and resume sequence
> more efficient, but also optimize the overall amdgpu suspend
> and resume time by reducing the ring intialize and tests
> for unused IP blocks.
>
> Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 07924d4..aa85063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1035,6 +1035,8 @@ struct amdgpu_device {
>
>          /* vce */
>          struct amdgpu_vce               vce;
> +       bool                            is_vce_pg;
> +       bool is_vce_disabled;
>
>          /* vcn */
>          struct amdgpu_vcn               vcn;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index cc6ce6c..822cfd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -326,6 +326,7 @@ static int vce_v3_0_start(struct amdgpu_device *adev)
>          WREG32(mmGRBM_GFX_INDEX, mmGRBM_GFX_INDEX_DEFAULT);
>          mutex_unlock(&adev->grbm_idx_mutex);
>
> +       adev->is_vce_pg = false;
>          return 0;
>  }
>
> @@ -355,6 +356,7 @@ static int vce_v3_0_stop(struct amdgpu_device *adev)
>          WREG32(mmGRBM_GFX_INDEX, mmGRBM_GFX_INDEX_DEFAULT);
>          mutex_unlock(&adev->grbm_idx_mutex);
>
> +       adev->is_vce_pg = true;
>          return 0;
>  }
>
> @@ -506,6 +508,17 @@ static int vce_v3_0_suspend(void *handle)
>          int r;
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> +       /* Proceed with suspend sequence only if VCE is started
> +        * Mark the block as being disabled if its stopped.
> +        */
> +       if (adev->is_vce_pg) {
> +               DRM_DEBUG("VCE is already powergated, not suspending\n");
> +               adev->is_vce_disabled = true;
> +               return 0;
> +       }
> +
> +       adev->is_vce_disabled = false;
> +
>          r = vce_v3_0_hw_fini(adev);
>          if (r)
>                  return r;
> @@ -518,6 +531,14 @@ static int vce_v3_0_resume(void *handle)
>          int r;
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> +       /* Proceed with resume sequence if VCE was enabled
> +        * while suspending.
> +        */
> +       if (adev->is_vce_disabled) {
> +               DRM_DEBUG("VCE is powergated, not resuming the block\n");
> +               return 0;
> +       }
> +
>          r = amdgpu_vce_resume(adev);
>          if (r)
>                  return r;
> -- 
> 2.7.4
>

-- 
Regards,
Shirish S


--------------5311365E7BC8463906096B8A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 8/10/2018 12:02 PM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB2775F1BD12A3F215A6F5C936FB240-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">I am Ok with the check
          when call vce_v3_0_hw_fini.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">But we may still need to
          call amdpug_vce_suspend/resume.</p>
      </div>
    </blockquote>
    Done in V2. Have moved the check such that both are executed.<br>
    Regards,<br>
    Shirish S<br>
    <blockquote type="cite"
cite="mid:BYAPR12MB2775F1BD12A3F215A6F5C936FB240-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0"><br>
          and not sure whether need to do ring test when resume back.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex<br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b> S,
              Shirish<br>
              <b>Sent:</b> Friday, August 10, 2018 2:15 PM<br>
              <b>To:</b> Deucher, Alexander; Zhu, Rex; Liu, Leo<br>
              <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; S, Shirish<br>
              <b>Subject:</b> [PATCH] drm/amdpu/vce_v3: skip suspend and
              resume if powergated</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">This patch adds a mechanism by
                  which the VCE 3.0 block<br>
                  shall check if it was enabled or in use before
                  suspending,<br>
                  if it was powergated while entering suspend then there<br>
                  is no need to repeat it in vce_3_0_suspend().<br>
                  Similarly, if the block was powergated while entering
                  suspend<br>
                  itself then there is no need to resume it.<br>
                  <br>
                  By this we not only make the suspend and resume
                  sequence<br>
                  more efficient, but also optimize the overall amdgpu
                  suspend<br>
                  and resume time by reducing the ring intialize and
                  tests<br>
                  for unused IP blocks.<br>
                  <br>
                  Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">&lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 ++<br>
                   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 21
                  +++++++++++++++++++++<br>
                   2 files changed, 23 insertions(+)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  index 07924d4..aa85063 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  @@ -1035,6 +1035,8 @@ struct amdgpu_device {<br>
                   <br>
                           /* vce */<br>
                           struct amdgpu_vce               vce;<br>
                  +       bool                            is_vce_pg;<br>
                  +       bool                           
                  is_vce_disabled;<br>
                   <br>
                           /* vcn */<br>
                           struct amdgpu_vcn               vcn;<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
                  b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
                  index cc6ce6c..822cfd6 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
                  @@ -326,6 +326,7 @@ static int vce_v3_0_start(struct
                  amdgpu_device *adev)<br>
                           WREG32(mmGRBM_GFX_INDEX,
                  mmGRBM_GFX_INDEX_DEFAULT);<br>
                           mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                   <br>
                  +       adev-&gt;is_vce_pg = false;<br>
                           return 0;<br>
                   }<br>
                   <br>
                  @@ -355,6 +356,7 @@ static int vce_v3_0_stop(struct
                  amdgpu_device *adev)<br>
                           WREG32(mmGRBM_GFX_INDEX,
                  mmGRBM_GFX_INDEX_DEFAULT);<br>
                           mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                   <br>
                  +       adev-&gt;is_vce_pg = true;<br>
                           return 0;<br>
                   }<br>
                   <br>
                  @@ -506,6 +508,17 @@ static int vce_v3_0_suspend(void
                  *handle)<br>
                           int r;<br>
                           struct amdgpu_device *adev = (struct
                  amdgpu_device *)handle;<br>
                   <br>
                  +       /* Proceed with suspend sequence only if VCE
                  is started<br>
                  +        * Mark the block as being disabled if its
                  stopped.<br>
                  +        */<br>
                  +       if (adev-&gt;is_vce_pg) {<br>
                  +               DRM_DEBUG("VCE is already powergated,
                  not suspending\n");<br>
                  +               adev-&gt;is_vce_disabled = true;<br>
                  +               return 0;<br>
                  +       }<br>
                  +<br>
                  +       adev-&gt;is_vce_disabled = false;<br>
                  +<br>
                           r = vce_v3_0_hw_fini(adev);<br>
                           if (r)<br>
                                   return r;<br>
                  @@ -518,6 +531,14 @@ static int vce_v3_0_resume(void
                  *handle)<br>
                           int r;<br>
                           struct amdgpu_device *adev = (struct
                  amdgpu_device *)handle;<br>
                   <br>
                  +       /* Proceed with resume sequence if VCE was
                  enabled<br>
                  +        * while suspending.<br>
                  +        */<br>
                  +       if (adev-&gt;is_vce_disabled) {<br>
                  +               DRM_DEBUG("VCE is powergated, not
                  resuming the block\n");<br>
                  +               return 0;<br>
                  +       }<br>
                  +<br>
                           r = amdgpu_vce_resume(adev);<br>
                           if (r)<br>
                                   return r;<br>
                  -- <br>
                  2.7.4<br>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Regards,
Shirish S</pre>
  </body>
</html>

--------------5311365E7BC8463906096B8A--

--===============0990311926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0990311926==--
