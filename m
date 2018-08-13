From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded by
 PSP
Date: Mon, 13 Aug 2018 08:38:51 -0400
Message-ID: <f993f552-1b64-352f-d03f-5a243c5d2c79@amd.com>
References: <1533832302-21440-1-git-send-email-James.Zhu@amd.com>
 <1533832302-21440-5-git-send-email-James.Zhu@amd.com>
 <SN6PR12MB2656E11594EA2BC12BC5B38DE4390@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0677918092=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB2656E11594EA2BC12BC5B38DE4390-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0677918092==
Content-Type: multipart/alternative;
 boundary="------------8C267B830B5EBC596754C5F5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8C267B830B5EBC596754C5F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

PSP engine only allocate space for firmware. 
mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH is for firmware TMR address.

The other two address are for HEAP/Session.


Regards!

James Zhu


On 2018-08-13 12:16 AM, Quan, Evan wrote:
>
> Why only the mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH use the new 
> tmr_mc_addr? And the mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH and 
> mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH still use the old 
> adev->vcn.gpu_addr?
>
>
> Regards,
>
> Evan
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, August 10, 2018 12:31:42 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander; Gao, Likun; Zhu, James; Huang, Ray
> *Subject:* [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware 
> loaded by PSP
> From: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
>
> Setup psp firmware loading for VCN, and make VCN block
> booting from tmr mac address.
>
> Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 38 
> ++++++++++++++++++++++++++-------
>  2 files changed, 40 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 878f62c..77c192a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -111,9 +111,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                          version_major, version_minor, family_id);
>          }
>
> -       bo_size = 
> AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8)
> -                 +  AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
> +       bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_HEAP_SIZE
>                    +  AMDGPU_VCN_SESSION_SIZE * 40;
> +       if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> +               bo_size += 
> AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>          r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.vcpu_bo,
> &adev->vcn.gpu_addr, &adev->vcn.cpu_addr);
> @@ -189,11 +190,13 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>                  unsigned offset;
>
>                  hdr = (const struct common_firmware_header 
> *)adev->vcn.fw->data;
> -               offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -               memcpy_toio(adev->vcn.cpu_addr, adev->vcn.fw->data + 
> offset,
> - le32_to_cpu(hdr->ucode_size_bytes));
> -               size -= le32_to_cpu(hdr->ucode_size_bytes);
> -               ptr += le32_to_cpu(hdr->ucode_size_bytes);
> +               if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> +                       offset = 
> le32_to_cpu(hdr->ucode_array_offset_bytes);
> +                       memcpy_toio(adev->vcn.cpu_addr, 
> adev->vcn.fw->data + offset,
> + le32_to_cpu(hdr->ucode_size_bytes));
> +                       size -= le32_to_cpu(hdr->ucode_size_bytes);
> +                       ptr += le32_to_cpu(hdr->ucode_size_bytes);
> +               }
>                  memset_io(ptr, 0, size);
>          }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 2ce91a7..74c4ef4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -100,6 +100,16 @@ static int vcn_v1_0_sw_init(void *handle)
>          if (r)
>                  return r;
>
> +       if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +               const struct common_firmware_header *hdr;
> +               hdr = (const struct common_firmware_header 
> *)adev->vcn.fw->data;
> + adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = 
> AMDGPU_UCODE_ID_VCN;
> + adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
> +               adev->firmware.fw_size +=
> + ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +               DRM_INFO("PSP loading VCN firmware\n");
> +       }
> +
>          r = amdgpu_vcn_resume(adev);
>          if (r)
>                  return r;
> @@ -265,26 +275,38 @@ static int vcn_v1_0_resume(void *handle)
>  static void vcn_v1_0_mc_resume(struct amdgpu_device *adev)
>  {
>          uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
> -
> -       WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +       uint32_t offset;
> +
> +       if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> + (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));
> +               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> + (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));
> +               WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0);
> +               offset = 0;
> +       } else {
> +               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> lower_32_bits(adev->vcn.gpu_addr));
> -       WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +               WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> upper_32_bits(adev->vcn.gpu_addr));
> -       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
> +               offset = size;
> +               WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
> AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> +       }
> +
>          WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE0, size);
>
>          WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> - lower_32_bits(adev->vcn.gpu_addr + size));
> + lower_32_bits(adev->vcn.gpu_addr + offset));
>          WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> - upper_32_bits(adev->vcn.gpu_addr + size));
> + upper_32_bits(adev->vcn.gpu_addr + offset));
>          WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1, 0);
>          WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE1, 
> AMDGPU_VCN_HEAP_SIZE);
>
>          WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> - lower_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VCN_HEAP_SIZE));
> + lower_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_VCN_HEAP_SIZE));
>          WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> - upper_32_bits(adev->vcn.gpu_addr + size + AMDGPU_VCN_HEAP_SIZE));
> + upper_32_bits(adev->vcn.gpu_addr + offset + AMDGPU_VCN_HEAP_SIZE));
>          WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0);
>          WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE2,
>                          AMDGPU_VCN_STACK_SIZE + 
> (AMDGPU_VCN_SESSION_SIZE * 40));
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------8C267B830B5EBC596754C5F5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><span style="color: rgb(33, 33, 33); font-family:
        wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
        Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:
        14.6667px;">PSP engine only allocate space for </span><span
        style="color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal,
        &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
        sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
          style="color: rgb(33, 33, 33); font-family:
          wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
          WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
          font-size: 14.6667px;">firmware. </span>mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH
        is for firmware TMR address.</span></p>
    <p><span style="color: rgb(33, 33, 33); font-family:
        wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
        Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:
        14.6667px;">The other two address are for HEAP/Session.<br>
      </span></p>
    <p><span style="color: rgb(33, 33, 33); font-family:
        wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
        Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:
        14.6667px;"><br>
      </span></p>
    <p><span style="color: rgb(33, 33, 33); font-family:
        wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
        Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:
        14.6667px;">Regards!</span></p>
    <p><span style="color: rgb(33, 33, 33); font-family:
        wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
        Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:
        14.6667px;">James Zhu<br>
      </span></p>
    <br>
    <div class="moz-cite-prefix">On 2018-08-13 12:16 AM, Quan, Evan
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:SN6PR12MB2656E11594EA2BC12BC5B38DE4390-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Why only the <span
            style="color: rgb(33, 33, 33); font-family:
            wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
            WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
            font-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW/HIGH
            use the new <span style="color: rgb(33, 33, 33);
              font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;,
              &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif,
              EmojiFont; font-size: 14.6667px;">tmr_mc_addr? And the <span
                style="color: rgb(33, 33, 33); font-family:
                wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
                WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
                font-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH
                and <span style="color: rgb(33, 33, 33); font-family:
                  wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
                  WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
                  font-size: 14.6667px;">mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW/HIGH
                  still use the old <span style="color: rgb(33, 33, 33);
                    font-family: wf_segoe-ui_normal, &quot;Segoe
                    UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                    sans-serif, serif, EmojiFont; font-size: 14.6667px;">adev-&gt;vcn.gpu_addr?</span></span></span></span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="color:
            rgb(33, 33, 33); font-family: wf_segoe-ui_normal,
            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
            sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
              style="color: rgb(33, 33, 33); font-family:
              wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
              WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
              font-size: 14.6667px;"><span style="color: rgb(33, 33,
                33); font-family: wf_segoe-ui_normal, &quot;Segoe
                UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
                  style="color: rgb(33, 33, 33); font-family:
                  wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
                  WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
                  font-size: 14.6667px;"><span style="color: rgb(33, 33,
                    33); font-family: wf_segoe-ui_normal, &quot;Segoe
                    UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                    sans-serif, serif, EmojiFont; font-size: 14.6667px;"><br>
                  </span></span></span></span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="color:
            rgb(33, 33, 33); font-family: wf_segoe-ui_normal,
            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
            sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
              style="color: rgb(33, 33, 33); font-family:
              wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
              WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
              font-size: 14.6667px;"><span style="color: rgb(33, 33,
                33); font-family: wf_segoe-ui_normal, &quot;Segoe
                UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
                  style="color: rgb(33, 33, 33); font-family:
                  wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
                  WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
                  font-size: 14.6667px;"><span style="color: rgb(33, 33,
                    33); font-family: wf_segoe-ui_normal, &quot;Segoe
                    UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                    sans-serif, serif, EmojiFont; font-size: 14.6667px;">Regards,</span></span></span></span></span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="color:
            rgb(33, 33, 33); font-family: wf_segoe-ui_normal,
            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
            sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
              style="color: rgb(33, 33, 33); font-family:
              wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
              WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
              font-size: 14.6667px;"><span style="color: rgb(33, 33,
                33); font-family: wf_segoe-ui_normal, &quot;Segoe
                UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                sans-serif, serif, EmojiFont; font-size: 14.6667px;"><span
                  style="color: rgb(33, 33, 33); font-family:
                  wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe
                  WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont;
                  font-size: 14.6667px;"><span style="color: rgb(33, 33,
                    33); font-family: wf_segoe-ui_normal, &quot;Segoe
                    UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,
                    sans-serif, serif, EmojiFont; font-size: 14.6667px;">Evan</span></span></span></span></span></p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Friday, August 10, 2018 12:31:42 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> Deucher, Alexander; Gao, Likun; Zhu, James; Huang,
          Ray<br>
          <b>Subject:</b> [PATCH v2 5/5] drm/amdgpu:add VCN booting with
          firmware loaded by PSP</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">From: Likun Gao
              <a class="moz-txt-link-rfc2396E" href="mailto:Likun.Gao-5C7GfCeVMHo@public.gmane.org">&lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <br>
              Setup psp firmware loading for VCN, and make VCN block<br>
              booting from tmr mac address.<br>
              <br>
              Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              Reviewed-by: Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17
              +++++++++------<br>
               drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 38
              ++++++++++++++++++++++++++-------<br>
               2 files changed, 40 insertions(+), 15 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
              index 878f62c..77c192a 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
              @@ -111,9 +111,10 @@ int amdgpu_vcn_sw_init(struct
              amdgpu_device *adev)<br>
                                       version_major, version_minor,
              family_id);<br>
                       }<br>
               <br>
              -       bo_size =
              AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes)
              + 8)<br>
              -                 +  AMDGPU_VCN_STACK_SIZE +
              AMDGPU_VCN_HEAP_SIZE<br>
              +       bo_size = AMDGPU_VCN_STACK_SIZE +
              AMDGPU_VCN_HEAP_SIZE<br>
                                 +  AMDGPU_VCN_SESSION_SIZE * 40;<br>
              +       if (adev-&gt;firmware.load_type !=
              AMDGPU_FW_LOAD_PSP)<br>
              +               bo_size +=
              AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes)
              + 8);<br>
                       r = amdgpu_bo_create_kernel(adev, bo_size,
              PAGE_SIZE,<br>
                                                  
              AMDGPU_GEM_DOMAIN_VRAM, &amp;adev-&gt;vcn.vcpu_bo,<br>
                                                  
              &amp;adev-&gt;vcn.gpu_addr, &amp;adev-&gt;vcn.cpu_addr);<br>
              @@ -189,11 +190,13 @@ int amdgpu_vcn_resume(struct
              amdgpu_device *adev)<br>
                               unsigned offset;<br>
               <br>
                               hdr = (const struct
              common_firmware_header *)adev-&gt;vcn.fw-&gt;data;<br>
              -               offset =
              le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);<br>
              -               memcpy_toio(adev-&gt;vcn.cpu_addr,
              adev-&gt;vcn.fw-&gt;data + offset,<br>
              -                          
              le32_to_cpu(hdr-&gt;ucode_size_bytes));<br>
              -               size -=
              le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
              -               ptr +=
              le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
              +               if (adev-&gt;firmware.load_type !=
              AMDGPU_FW_LOAD_PSP) {<br>
              +                       offset =
              le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);<br>
              +                       memcpy_toio(adev-&gt;vcn.cpu_addr,
              adev-&gt;vcn.fw-&gt;data + offset,<br>
              +                                  
              le32_to_cpu(hdr-&gt;ucode_size_bytes));<br>
              +                       size -=
              le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
              +                       ptr +=
              le32_to_cpu(hdr-&gt;ucode_size_bytes);<br>
              +               }<br>
                               memset_io(ptr, 0, size);<br>
                       }<br>
               <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
              b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              index 2ce91a7..74c4ef4 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
              @@ -100,6 +100,16 @@ static int vcn_v1_0_sw_init(void
              *handle)<br>
                       if (r)<br>
                               return r;<br>
               <br>
              +       if (adev-&gt;firmware.load_type ==
              AMDGPU_FW_LOAD_PSP) {<br>
              +               const struct common_firmware_header *hdr;<br>
              +               hdr = (const struct common_firmware_header
              *)adev-&gt;vcn.fw-&gt;data;<br>
              +              
              adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id =
              AMDGPU_UCODE_ID_VCN;<br>
              +              
              adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =
              adev-&gt;vcn.fw;<br>
              +               adev-&gt;firmware.fw_size +=<br>
              +                      
              ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
              +               DRM_INFO("PSP loading VCN firmware\n");<br>
              +       }<br>
              +<br>
                       r = amdgpu_vcn_resume(adev);<br>
                       if (r)<br>
                               return r;<br>
              @@ -265,26 +275,38 @@ static int vcn_v1_0_resume(void
              *handle)<br>
               static void vcn_v1_0_mc_resume(struct amdgpu_device
              *adev)<br>
               {<br>
                       uint32_t size =
              AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.fw-&gt;size + 4);<br>
              -<br>
              -       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
              +       uint32_t offset;<br>
              +<br>
              +       if (adev-&gt;firmware.load_type ==
              AMDGPU_FW_LOAD_PSP) {<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
              +                      
              (adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br>
              +                      
              (adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_VCPU_CACHE_OFFSET0, 0);<br>
              +               offset = 0;<br>
              +       } else {<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,<br>
                                      
              lower_32_bits(adev-&gt;vcn.gpu_addr));<br>
              -       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,<br>
                                      
              upper_32_bits(adev-&gt;vcn.gpu_addr));<br>
              -       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,<br>
              +               offset = size;<br>
              +               WREG32_SOC15(UVD, 0,
              mmUVD_VCPU_CACHE_OFFSET0,<br>
                                              
              AMDGPU_UVD_FIRMWARE_OFFSET &gt;&gt; 3);<br>
              +       }<br>
              +<br>
                       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE0,
              size);<br>
               <br>
                       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,<br>
              -                      
              lower_32_bits(adev-&gt;vcn.gpu_addr + size));<br>
              +                      
              lower_32_bits(adev-&gt;vcn.gpu_addr + offset));<br>
                       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,<br>
              -                      
              upper_32_bits(adev-&gt;vcn.gpu_addr + size));<br>
              +                      
              upper_32_bits(adev-&gt;vcn.gpu_addr + offset));<br>
                       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1,
              0);<br>
                       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE1,
              AMDGPU_VCN_HEAP_SIZE);<br>
               <br>
                       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,<br>
              -                      
              lower_32_bits(adev-&gt;vcn.gpu_addr + size +
              AMDGPU_VCN_HEAP_SIZE));<br>
              +                      
              lower_32_bits(adev-&gt;vcn.gpu_addr + offset +
              AMDGPU_VCN_HEAP_SIZE));<br>
                       WREG32_SOC15(UVD, 0,
              mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,<br>
              -                      
              upper_32_bits(adev-&gt;vcn.gpu_addr + size +
              AMDGPU_VCN_HEAP_SIZE));<br>
              +                      
              upper_32_bits(adev-&gt;vcn.gpu_addr + offset +
              AMDGPU_VCN_HEAP_SIZE));<br>
                       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2,
              0);<br>
                       WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE2,<br>
                                       AMDGPU_VCN_STACK_SIZE +
              (AMDGPU_VCN_SESSION_SIZE * 40));<br>
              -- <br>
              2.7.4<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------8C267B830B5EBC596754C5F5--

--===============0677918092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0677918092==--
