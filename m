From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 16:19:40 +0800
Message-ID: <591C079C.4070902@amd.com>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
 <591BFF33.2010303@amd.com> <20170517075557.GA31947@hr-amur2>
 <591C05B5.4090902@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096630680=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <591C05B5.4090902-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huan,
 Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0096630680==
Content-Type: multipart/alternative;
	boundary="------------010307060204030805040603"

--------------010307060204030805040603
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

see here, I already find dis-advance:
enum amd_ip_block_type {
         AMD_IP_BLOCK_TYPE_COMMON,
         AMD_IP_BLOCK_TYPE_GMC,
         AMD_IP_BLOCK_TYPE_IH,
         AMD_IP_BLOCK_TYPE_SMC,
         AMD_IP_BLOCK_TYPE_PSP,
         AMD_IP_BLOCK_TYPE_DCE,
         AMD_IP_BLOCK_TYPE_GFX,
         AMD_IP_BLOCK_TYPE_SDMA,
         AMD_IP_BLOCK_TYPE_UVD,
         AMD_IP_BLOCK_TYPE_VCE,
         AMD_IP_BLOCK_TYPE_ACP,
         AMD_IP_BLOCK_TYPE_GFXHUB,
         AMD_IP_BLOCK_TYPE_MMHUB
};
resume will follow this sequence.
but initial sequence is :
               amdgpu_ip_block_add(adev, &vega10_common_ip_block);
                 amdgpu_ip_block_add(adev, &gfxhub_v1_0_ip_block);
                 amdgpu_ip_block_add(adev, &mmhub_v1_0_ip_block);
                 amdgpu_ip_block_add(adev, &gmc_v9_0_ip_block);
                 amdgpu_ip_block_add(adev, &vega10_ih_ip_block);
                 if (amdgpu_fw_load_type == 2 || amdgpu_fw_load_type == -1)
                         amdgpu_ip_block_add(adev, &psp_v3_1_ip_block);
                 if (!amdgpu_sriov_vf(adev))
                         amdgpu_ip_block_add(adev, &amdgpu_pp_ip_block);
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                         amdgpu_ip_block_add(adev, &dce_virtual_ip_block);
#if defined(CONFIG_DRM_AMD_DC)
                 else if (amdgpu_device_has_dc_support(adev))
                         amdgpu_ip_block_add(adev, &dm_ip_block);
#else
#       warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
#endif
                 amdgpu_ip_block_add(adev, &gfx_v9_0_ip_block);
                 amdgpu_ip_block_add(adev, &sdma_v4_0_ip_block);
                 amdgpu_ip_block_add(adev, &uvd_v7_0_ip_block);
                 amdgpu_ip_block_add(adev, &vce_v4_0_ip_block);


They are different. I remember I asked you if they are same, don't know 
why you answer 'yes'.

With s3 problem still in there, please do this improvement asap.

Regards,
David Zhou

On 2017年05月17日 16:11, zhoucm1 wrote:
>
>
> On 2017年05月17日 15:55, Huang Rui wrote:
>> On Wed, May 17, 2017 at 03:43:47PM +0800, Zhou, David(ChunMing) wrote:
>>> By this change, I suggest to remove mmhub/gfxhub_v1_0_ip_funcs and 
>>> their
>>> IP block, unify them to gmc ip block, this way we cannot lost setting
>>> when resume back.
>>>
>>  From hw side, wo won't have real gmc since this chip, mmhub and 
>> gfxhub(gc)
>> instead of it. Maybe we would better to align with hw desgin.
> I don't see any advance, as you said, we still have gmc block in 
> soc15, why not unify mmhub/gfxhub calls to gmc block?
> We can keep mmhub/gfxhub_xxx.c file, but ip_funciton isn't necessary.
>
> Regards,
> David Zhou
>>
>> Thanks,
>> Rui
>>
>>> Regards,
>>> David Zhou
>>>
>>> On 2017年05月17日 15:38, Huang Rui wrote:
>>>> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c 
>>>> b/drivers/gpu/drm/amd/
>>> amdgpu/gfxhub_v1_0.c
>>>> index 005075f..41313514 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>>>> @@ -368,7 +368,7 @@ static int gfxhub_v1_0_suspend(void *handle)
>>>>      static int gfxhub_v1_0_resume(void *handle)
>>>>    {
>>>> -     return 0;
>>>> +     return gfxhub_v1_0_hw_init(handle);
>>>>    }
>>>>      static bool gfxhub_v1_0_is_idle(void *handle)
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------010307060204030805040603
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    see here, I already find dis-advance:<br>
    enum amd_ip_block_type {<br>
    <font color="#cc0000">        AMD_IP_BLOCK_TYPE_COMMON,<br>
              AMD_IP_BLOCK_TYPE_GMC,</font><br>
            AMD_IP_BLOCK_TYPE_IH,<br>
            AMD_IP_BLOCK_TYPE_SMC,<br>
            AMD_IP_BLOCK_TYPE_PSP,            <br>
            AMD_IP_BLOCK_TYPE_DCE,<br>
            AMD_IP_BLOCK_TYPE_GFX,<br>
            AMD_IP_BLOCK_TYPE_SDMA,<br>
            AMD_IP_BLOCK_TYPE_UVD,<br>
            AMD_IP_BLOCK_TYPE_VCE,<br>
            AMD_IP_BLOCK_TYPE_ACP,<br>
    <font color="#cc0000">        AMD_IP_BLOCK_TYPE_GFXHUB,<br>
              AMD_IP_BLOCK_TYPE_MMHUB</font><br>
    };<br>
    resume will follow this sequence.<br>
    but initial sequence is :<br>
                  amdgpu_ip_block_add(adev,
    &amp;vega10_common_ip_block);<br>
    <font color="#cc0000">                amdgpu_ip_block_add(adev,
      &amp;gfxhub_v1_0_ip_block);<br>
                      amdgpu_ip_block_add(adev,
      &amp;mmhub_v1_0_ip_block);<br>
                      amdgpu_ip_block_add(adev, &amp;gmc_v9_0_ip_block);</font><br>
                    amdgpu_ip_block_add(adev, &amp;vega10_ih_ip_block);<br>
                    if (amdgpu_fw_load_type == 2 || amdgpu_fw_load_type
    == -1)<br>
                            amdgpu_ip_block_add(adev,
    &amp;psp_v3_1_ip_block);<br>
                    if (!amdgpu_sriov_vf(adev))<br>
                            amdgpu_ip_block_add(adev,
    &amp;amdgpu_pp_ip_block);<br>
                    if (adev-&gt;enable_virtual_display ||
    amdgpu_sriov_vf(adev))<br>
                            amdgpu_ip_block_add(adev,
    &amp;dce_virtual_ip_block);<br>
    #if defined(CONFIG_DRM_AMD_DC)<br>
                    else if (amdgpu_device_has_dc_support(adev))<br>
                            amdgpu_ip_block_add(adev, &amp;dm_ip_block);<br>
    #else<br>
    #       warning "Enable CONFIG_DRM_AMD_DC for display support on
    SOC15."<br>
    #endif<br>
                    amdgpu_ip_block_add(adev, &amp;gfx_v9_0_ip_block);<br>
                    amdgpu_ip_block_add(adev, &amp;sdma_v4_0_ip_block);<br>
                    amdgpu_ip_block_add(adev, &amp;uvd_v7_0_ip_block);<br>
                    amdgpu_ip_block_add(adev, &amp;vce_v4_0_ip_block);<br>
    <br>
    <br>
    They are different. I remember I asked you if they are same, don't
    know why you answer 'yes'.<br>
    <br>
    With s3 problem still in there, please do this improvement asap.<br>
    <br>
    Regards,<br>
    David Zhou<br>
    <br>
    <div class="moz-cite-prefix">On 2017年05月17日 16:11, zhoucm1 wrote:<br>
    </div>
    <blockquote cite="mid:591C05B5.4090902-5C7GfCeVMHo@public.gmane.org" type="cite">
      <br>
      <br>
      On 2017年05月17日 15:55, Huang Rui wrote:
      <br>
      <blockquote type="cite">On Wed, May 17, 2017 at 03:43:47PM +0800,
        Zhou, David(ChunMing) wrote:
        <br>
        <blockquote type="cite">By this change, I suggest to remove
          mmhub/gfxhub_v1_0_ip_funcs and their
          <br>
          IP block, unify them to gmc ip block, this way we cannot lost
          setting
          <br>
          when resume back.
          <br>
          <br>
        </blockquote>
         From hw side, wo won't have real gmc since this chip, mmhub and
        gfxhub(gc)
        <br>
        instead of it. Maybe we would better to align with hw desgin.
        <br>
      </blockquote>
      I don't see any advance, as you said, we still have gmc block in
      soc15, why not unify mmhub/gfxhub calls to gmc block?
      <br>
      We can keep mmhub/gfxhub_xxx.c file, but ip_funciton isn't
      necessary.
      <br>
      <br>
      Regards,
      <br>
      David Zhou
      <br>
      <blockquote type="cite">
        <br>
        Thanks,
        <br>
        Rui
        <br>
        <br>
        <blockquote type="cite">Regards,
          <br>
          David Zhou
          <br>
          <br>
          On 2017年05月17日 15:38, Huang Rui wrote:
          <br>
          <blockquote type="cite">Signed-off-by: Huang Rui
            <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a>
            <br>
            ---
            <br>
               drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 2 +-
            <br>
               1 file changed, 1 insertion(+), 1 deletion(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
            b/drivers/gpu/drm/amd/
            <br>
          </blockquote>
          amdgpu/gfxhub_v1_0.c
          <br>
          <blockquote type="cite">index 005075f..41313514 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
            <br>
            @@ -368,7 +368,7 @@ static int gfxhub_v1_0_suspend(void
            *handle)
            <br>
                 static int gfxhub_v1_0_resume(void *handle)
            <br>
               {
            <br>
            -     return 0;
            <br>
            +     return gfxhub_v1_0_hw_init(handle);
            <br>
               }
            <br>
                 static bool gfxhub_v1_0_is_idle(void *handle)
            <br>
          </blockquote>
        </blockquote>
        _______________________________________________
        <br>
        amd-gfx mailing list
        <br>
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
        <br>
        <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
        <br>
      </blockquote>
      <br>
      _______________________________________________
      <br>
      amd-gfx mailing list
      <br>
      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
      <br>
      <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------010307060204030805040603--

--===============0096630680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0096630680==--
