From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: set vm size and block size by individual
 gmc by default (v2)
Date: Fri, 7 Apr 2017 10:35:21 +0800
Message-ID: <58E6FAE9.4080209@amd.com>
References: <1491473999-20529-1-git-send-email-Jerry.Zhang@amd.com>
 <04eb5d6d-8d29-82aa-e367-d918e71253d2@vodafone.de>
 <51C2AE07-B2D3-4A81-97FE-A79BDA5DBB8D@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2031889883=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <51C2AE07-B2D3-4A81-97FE-A79BDA5DBB8D-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2031889883==
Content-Type: multipart/alternative;
	boundary="------------040501070107030806070502"

--------------040501070107030806070502
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年04月06日 21:56, Zhang, Jerry wrote:
>
>> 在 2017年4月6日，20:07，Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org 
>> <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> 写道：
>>
>> Am 06.04.2017 um 12:19 schrieb Junwei Zhang:
>>> By default, the value is set by individual gmc.
>>> if a specific value is input, it overrides the global value for all
>>>
>>> v2: create helper funcs
>>>
>>> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org 
>>> <mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>>
>>
>> A few minor issues below, but apart from that looks good to me.
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 
>>> ++++++++++--------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38 
>>> ++++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  6 +----
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  6 +----
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  6 +----
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++++---
>>>  8 files changed, 60 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1d0c742..8fce309 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1039,35 +1039,31 @@ static bool amdgpu_check_pot_argument(int arg)
>>> return (arg & (arg - 1)) == 0;
>>>  }
>>>  -static void amdgpu_get_block_size(struct amdgpu_device *adev)
>>> +static void amdgpu_check_block_size(struct amdgpu_device *adev)
>>>  {
>>> /* defines number of bits in page table versus page directory,
>>> * a page is 4KB so we have 12 bits offset, minimum 9 bits in the
>>> * page table and the remaining bits are in the page directory */
>>> -if (amdgpu_vm_block_size == -1) {
>>> -
>>> -/* Total bits covered by PD + PTs */
>>> -unsigned bits = ilog2(amdgpu_vm_size) + 18;
>>> -
>>> -/* Make sure the PD is 4K in size up to 8GB address space.
>>> -  Above that split equal between PD and PTs */
>>> -if (amdgpu_vm_size <= 8)
>>> -amdgpu_vm_block_size = bits - 9;
>>> -else
>>> -amdgpu_vm_block_size = (bits + 3) / 2;
>>> +if (amdgpu_vm_block_size == -1)
>>> +return;
>>>  -} else if (amdgpu_vm_block_size < 9) {
>>> +if (amdgpu_vm_block_size < 9) {
>>> dev_warn(adev->dev, "VM page table size (%d) too small\n",
>>> amdgpu_vm_block_size);
>>> -amdgpu_vm_block_size = 9;
>>> +goto def_value;
>>> }
>>> if (amdgpu_vm_block_size > 24 ||
>>>    (amdgpu_vm_size * 1024) < (1ull << amdgpu_vm_block_size)) {
>>> dev_warn(adev->dev, "VM page table size (%d) too large\n",
>>> amdgpu_vm_block_size);
>>> -amdgpu_vm_block_size = 9;
>>> +goto def_value;
>>> }
>>> +
>>> +return;
>>> +
>>> +def_value:
>>> +amdgpu_vm_block_size = -1;
>>>  }
>>>    static void amdgpu_check_vm_size(struct amdgpu_device *adev)
>>> @@ -1096,8 +1092,7 @@ static void amdgpu_check_vm_size(struct 
>>> amdgpu_device *adev)
>>> return;
>>>    def_value:
>>> -amdgpu_vm_size = 8;
>>> -dev_info(adev->dev, "set default VM size %dGB\n", amdgpu_vm_size);
>>> +amdgpu_vm_size = -1;
>>>  }
>>>    /**
>>> @@ -1131,7 +1126,7 @@ static void amdgpu_check_arguments(struct 
>>> amdgpu_device *adev)
>>> amdgpu_check_vm_size(adev);
>>>  -amdgpu_get_block_size(adev);
>>> +amdgpu_check_block_size(adev);
>>> if (amdgpu_vram_page_split != -1 && (amdgpu_vram_page_split < 16 ||
>>>    !amdgpu_check_pot_argument(amdgpu_vram_page_split))) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index bfd945b..6238e2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -86,7 +86,7 @@
>>>  unsigned amdgpu_ip_block_mask = 0xffffffff;
>>>  int amdgpu_bapm = -1;
>>>  int amdgpu_deep_color = 0;
>>> -int amdgpu_vm_size = 64;
>>> +int amdgpu_vm_size = -1;
>>>  int amdgpu_vm_block_size = -1;
>>>  int amdgpu_vm_fault_stop = 0;
>>>  int amdgpu_vm_debug = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 8785420..bc2650ef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2064,6 +2064,44 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>> }
>>>  }
>>>  +static uint32_t amdgpu_get_block_size(uint64_t vm_size)
>>
>> Please rename that to amdgpu_vm_get_block_size().
>>
>>> +{
>>> +/* Total bits covered by PD + PTs */
>>> +unsigned bits = ilog2(vm_size) + 18;
>>> +
>>> +/* Make sure the PD is 4K in size up to 8GB address space.
>>> +  Above that split equal between PD and PTs */
>>> +if (vm_size <= 8)
>>> +return (bits - 9);
>>> +else
>>> +return ((bits + 3) / 2);
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_adjust_size - adjust vm size and block size
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @vm_size: the default vm size if it's set auto
>>> + */
>>> +void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint64_t 
>>> vm_size)
>>> +{
>>> +/* adjust vm size firstly */
>>> +if (amdgpu_vm_size == -1)
>>> +adev->vm_manager.vm_size = vm_size;
>>> +else
>>> +adev->vm_manager.vm_size = amdgpu_vm_size;
>>> +
>>> +/* block size depends on vm size */
>>> +if (amdgpu_vm_block_size == -1)
>>> +adev->vm_manager.block_size =
>>> +amdgpu_get_block_size(adev->vm_manager.vm_size);
>>> +else
>>> +adev->vm_manager.block_size = amdgpu_vm_block_size;
>>> +
>>> +DRM_INFO("vm size is %llu GB, block size is %u-bit\n",
>>> +adev->vm_manager.vm_size, adev->vm_manager.block_size);
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_vm_init - initialize a vm instance
>>>   *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 7d01372..6f158d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -234,5 +234,6 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>> uint64_t saddr, uint64_t size);
>>>  void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>>>      struct amdgpu_bo_va *bo_va);
>>> +void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint64_t 
>>> vm_size);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index 30d5c42..631aef3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -849,13 +849,9 @@ static int gmc_v6_0_sw_init(void *handle)
>>> if (r)
>>> return r;
>>>  -adev->vm_manager.vm_size = amdgpu_vm_size;
>>> -adev->vm_manager.block_size = amdgpu_vm_block_size;
>>> +amdgpu_vm_adjust_size(adev, 64);
>>> adev->vm_manager.max_pfn = adev->vm_manager.vm_size << 18;
>>>  -DRM_INFO("vm size is %d GB, block size is %d-bit\n",
>>> -adev->vm_manager.vm_size, adev->vm_manager.block_size);
>>> -
>>> adev->mc.mc_mask = 0xffffffffffULL;
>>> adev->need_dma32 = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 7113765..92abe12 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -1003,13 +1003,9 @@ static int gmc_v7_0_sw_init(void *handle)
>>> * Currently set to 4GB ((1 << 20) 4k pages).
>>> * Max GPUVM size for cayman and SI is 40 bits.
>>> */
>>> -adev->vm_manager.vm_size = amdgpu_vm_size;
>>> -adev->vm_manager.block_size = amdgpu_vm_block_size;
>>> +amdgpu_vm_adjust_size(adev, 64);
>>> adev->vm_manager.max_pfn = adev->vm_manager.vm_size << 18;
>>>  -DRM_INFO("vm size is %d GB, block size is %d-bit\n",
>>> -adev->vm_manager.vm_size, adev->vm_manager.block_size);
>>> -
>>> /* Set the internal MC address mask
>>> * This is the max address of the GPU's
>>> * internal address space.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index b3d1f1b..f2ccefc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1087,13 +1087,9 @@ static int gmc_v8_0_sw_init(void *handle)
>>> * Currently set to 4GB ((1 << 20) 4k pages).
>>> * Max GPUVM size for cayman and SI is 40 bits.
>>> */
>>> -adev->vm_manager.vm_size = amdgpu_vm_size;
>>> -adev->vm_manager.block_size = amdgpu_vm_block_size;
>>> +amdgpu_vm_adjust_size(adev, 64);
>>> adev->vm_manager.max_pfn = adev->vm_manager.vm_size << 18;
>>>  -DRM_INFO("vm size is %d GB, block size is %d-bit\n",
>>> -adev->vm_manager.vm_size, adev->vm_manager.block_size);
>>> -
>>> /* Set the internal MC address mask
>>> * This is the max address of the GPU's
>>> * internal address space.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index e1637d5..77e7784f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -552,8 +552,7 @@ static int gmc_v9_0_sw_init(void *handle)
>>> if (adev->flags & AMD_IS_APU) {
>>> adev->mc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
>>> -adev->vm_manager.vm_size = amdgpu_vm_size;
>>> -adev->vm_manager.block_size = amdgpu_vm_block_size;
>>> +amdgpu_vm_adjust_size(adev, 64);
>>
>> Make sure we also use 1 level page tables in the APU case as well.
>
> I also flashed a idea about it.
> Does APU still uses 1 level page now for gmc v9?
No, it's same as Vega.

David
>
> Jerry
>
>>
>> With that done and the function renamed the patch is Reviewed-by: 
>> Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org 
>> <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>.
>>
>> Regards,
>> Christian.
>>
>>> } else {
>>> /* XXX Don't know how to get VRAM type yet. */
>>> adev->mc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>> @@ -564,11 +563,11 @@ static int gmc_v9_0_sw_init(void *handle)
>>> */
>>> adev->vm_manager.vm_size = 1U << 18;
>>> adev->vm_manager.block_size = 9;
>>> +DRM_INFO("vm size is %llu GB, block size is %u-bit\n",
>>> +adev->vm_manager.vm_size,
>>> +adev->vm_manager.block_size);
>>> }
>>>  -DRM_INFO("vm size is %d GB, block size is %d-bit\n",
>>> -adev->vm_manager.vm_size, adev->vm_manager.block_size);
>>> -
>>> /* This interrupt is VMC page fault.*/
>>> r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_VMC, 0,
>>> &adev->mc.vm_fault);
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------040501070107030806070502
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年04月06日 21:56, Zhang, Jerry
      wrote:<br>
    </div>
    <blockquote cite="mid:51C2AE07-B2D3-4A81-97FE-A79BDA5DBB8D-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <br class="">
      <div>
        <blockquote type="cite" class="">
          <div class="">在 2017年4月6日，20:07，Christian König &lt;<a
              moz-do-not-send="true"
              href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" class="">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
            写道：</div>
          <br class="Apple-interchange-newline">
          <div class=""><span style="font-family: Helvetica; font-size:
              12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;
              float: none; display: inline !important;" class="">Am
              06.04.2017 um 12:19 schrieb Junwei Zhang:</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
              By default, the value is set by individual gmc.<br
                class="">
              if a specific value is input, it overrides the global
              value for all<br class="">
              <br class="">
              v2: create helper funcs<br class="">
              <br class="">
              Signed-off-by: Junwei Zhang &lt;<a moz-do-not-send="true"
                href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" class="">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br
                class="">
            </blockquote>
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">A few minor
              issues below, but apart from that looks good to me.</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
              ---<br class="">
               drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31
              ++++++++++--------------<br class="">
               drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-<br
                class="">
               drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38
              ++++++++++++++++++++++++++++++<br class="">
               drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +<br
                class="">
               drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  6 +----<br
                class="">
               drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  6 +----<br
                class="">
               drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  6 +----<br
                class="">
               drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++++---<br
                class="">
               8 files changed, 60 insertions(+), 39 deletions(-)<br
                class="">
              <br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
              index 1d0c742..8fce309 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                class="">
              @@ -1039,35 +1039,31 @@ static bool
              amdgpu_check_pot_argument(int arg)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>return
              (arg &amp; (arg - 1)) == 0;<br class="">
               }<br class="">
               -static void amdgpu_get_block_size(struct amdgpu_device
              *adev)<br class="">
              +static void amdgpu_check_block_size(struct amdgpu_device
              *adev)<br class="">
               {<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              defines number of bits in page table versus page
              directory,<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* a page is 4KB so
              we have 12 bits offset, minimum 9 bits in the<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* page table and
              the remaining bits are in the page directory */<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (amdgpu_vm_block_size == -1) {<br class="">
              -<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>/*
              Total bits covered by PD + PTs */<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>unsigned
              bits = ilog2(amdgpu_vm_size) + 18;<br class="">
              -<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>/*
              Make sure the PD is 4K in size up to 8GB address space.<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-converted-space"> </span>  Above that split
              equal between PD and PTs */<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>if
              (amdgpu_vm_size &lt;= 8)<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_vm_block_size
              = bits - 9;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>else<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_vm_block_size
              = (bits + 3) / 2;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (amdgpu_vm_block_size == -1)<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>return;<br
                class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>} else if (amdgpu_vm_block_size &lt; 9) {<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (amdgpu_vm_block_size &lt; 9) {<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>dev_warn(adev-&gt;dev,
              "VM page table size (%d) too small\n",<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-converted-space"> </span>amdgpu_vm_block_size);<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_vm_block_size
              = 9;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>goto
              def_value;<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>}<br
                class="">
                 <span class="Apple-tab-span" style="white-space: pre;">
              </span>if (amdgpu_vm_block_size &gt; 24 ||<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>   (amdgpu_vm_size
              * 1024) &lt; (1ull &lt;&lt; amdgpu_vm_block_size)) {<br
                class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>dev_warn(adev-&gt;dev,
              "VM page table size (%d) too large\n",<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-converted-space"> </span>amdgpu_vm_block_size);<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_vm_block_size
              = 9;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>goto
              def_value;<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>}<br
                class="">
              +<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>return;<br
                class="">
              +<br class="">
              +def_value:<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_block_size
              = -1;<br class="">
               }<br class="">
                 static void amdgpu_check_vm_size(struct amdgpu_device
              *adev)<br class="">
              @@ -1096,8 +1092,7 @@ static void
              amdgpu_check_vm_size(struct amdgpu_device *adev)<br
                class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>return;<br
                class="">
                 def_value:<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_size
              = 8;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>dev_info(adev-&gt;dev,
              "set default VM size %dGB\n", amdgpu_vm_size);<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_size
              = -1;<br class="">
               }<br class="">
                 /**<br class="">
              @@ -1131,7 +1126,7 @@ static void
              amdgpu_check_arguments(struct amdgpu_device *adev)<br
                class="">
                 <span class="Apple-tab-span" style="white-space: pre;">
              </span>amdgpu_check_vm_size(adev);<br class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>amdgpu_get_block_size(adev);<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_check_block_size(adev);<br
                class="">
                 <span class="Apple-tab-span" style="white-space: pre;">
              </span>if (amdgpu_vram_page_split != -1 &amp;&amp;
              (amdgpu_vram_page_split &lt; 16 ||<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>   !amdgpu_check_pot_argument(amdgpu_vram_page_split)))
              {<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class="">
              index bfd945b..6238e2e 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class="">
              @@ -86,7 +86,7 @@<br class="">
               unsigned amdgpu_ip_block_mask = 0xffffffff;<br class="">
               int amdgpu_bapm = -1;<br class="">
               int amdgpu_deep_color = 0;<br class="">
              -int amdgpu_vm_size = 64;<br class="">
              +int amdgpu_vm_size = -1;<br class="">
               int amdgpu_vm_block_size = -1;<br class="">
               int amdgpu_vm_fault_stop = 0;<br class="">
               int amdgpu_vm_debug = 0;<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br class="">
              index 8785420..bc2650ef 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br class="">
              @@ -2064,6 +2064,44 @@ void amdgpu_vm_bo_invalidate(struct
              amdgpu_device *adev,<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>}<br
                class="">
               }<br class="">
               +static uint32_t amdgpu_get_block_size(uint64_t vm_size)<br
                class="">
            </blockquote>
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">Please rename
              that to amdgpu_vm_get_block_size().</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
              +{<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              Total bits covered by PD + PTs */<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>unsigned
              bits = ilog2(vm_size) + 18;<br class="">
              +<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              Make sure the PD is 4K in size up to 8GB address space.<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>  Above that split
              equal between PD and PTs */<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (vm_size &lt;= 8)<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>return
              (bits - 9);<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>else<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>return
              ((bits + 3) / 2);<br class="">
              +}<br class="">
              +<br class="">
              +/**<br class="">
              + * amdgpu_vm_adjust_size - adjust vm size and block size<br
                class="">
              + *<br class="">
              + * @adev: amdgpu_device pointer<br class="">
              + * @vm_size: the default vm size if it's set auto<br
                class="">
              + */<br class="">
              +void amdgpu_vm_adjust_size(struct amdgpu_device *adev,
              uint64_t vm_size)<br class="">
              +{<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              adjust vm size firstly */<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (amdgpu_vm_size == -1)<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size
              = vm_size;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>else<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size
              = amdgpu_vm_size;<br class="">
              +<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              block size depends on vm size */<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (amdgpu_vm_block_size == -1)<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.block_size
              =<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_get_block_size(adev-&gt;vm_manager.vm_size);<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>else<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.block_size
              = amdgpu_vm_block_size;<br class="">
              +<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>DRM_INFO("vm
              size is %llu GB, block size is %u-bit\n",<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,
              adev-&gt;vm_manager.block_size);<br class="">
              +}<br class="">
              +<br class="">
               /**<br class="">
                * amdgpu_vm_init - initialize a vm instance<br class="">
                *<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br class="">
              index 7d01372..6f158d6 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br class="">
              @@ -234,5 +234,6 @@ int amdgpu_vm_bo_clear_mappings(struct
              amdgpu_device *adev,<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>uint64_t

              saddr, uint64_t size);<br class="">
               void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,<br
                class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-converted-space"> </span>     struct
              amdgpu_bo_va *bo_va);<br class="">
              +void amdgpu_vm_adjust_size(struct amdgpu_device *adev,
              uint64_t vm_size);<br class="">
                 #endif<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
              b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br class="">
              index 30d5c42..631aef3 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br class="">
              @@ -849,13 +849,9 @@ static int gmc_v6_0_sw_init(void
              *handle)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>if
              (r)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>return
              r;<br class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>adev-&gt;vm_manager.vm_size = amdgpu_vm_size;<br
                class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.block_size
              = amdgpu_vm_block_size;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_adjust_size(adev,
              64);<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.max_pfn
              = adev-&gt;vm_manager.vm_size &lt;&lt; 18;<br class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>DRM_INFO("vm size is %d GB, block size is
              %d-bit\n",<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,
              adev-&gt;vm_manager.block_size);<br class="">
              -<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;mc.mc_mask
              = 0xffffffffffULL;<br class="">
                 <span class="Apple-tab-span" style="white-space: pre;">
              </span>adev-&gt;need_dma32 = false;<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
              b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br class="">
              index 7113765..92abe12 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br class="">
              @@ -1003,13 +1003,9 @@ static int gmc_v7_0_sw_init(void
              *handle)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* Currently set to
              4GB ((1 &lt;&lt; 20) 4k pages).<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* Max GPUVM size
              for cayman and SI is 40 bits.<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>*/<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.vm_size
              = amdgpu_vm_size;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.block_size
              = amdgpu_vm_block_size;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_adjust_size(adev,
              64);<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.max_pfn
              = adev-&gt;vm_manager.vm_size &lt;&lt; 18;<br class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>DRM_INFO("vm size is %d GB, block size is
              %d-bit\n",<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,
              adev-&gt;vm_manager.block_size);<br class="">
              -<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              Set the internal MC address mask<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* This is the max
              address of the GPU's<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* internal address
              space.<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
              b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br class="">
              index b3d1f1b..f2ccefc 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br class="">
              @@ -1087,13 +1087,9 @@ static int gmc_v8_0_sw_init(void
              *handle)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* Currently set to
              4GB ((1 &lt;&lt; 20) 4k pages).<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* Max GPUVM size
              for cayman and SI is 40 bits.<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>*/<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.vm_size
              = amdgpu_vm_size;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.block_size
              = amdgpu_vm_block_size;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span>amdgpu_vm_adjust_size(adev,
              64);<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>adev-&gt;vm_manager.max_pfn
              = adev-&gt;vm_manager.vm_size &lt;&lt; 18;<br class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>DRM_INFO("vm size is %d GB, block size is
              %d-bit\n",<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,
              adev-&gt;vm_manager.block_size);<br class="">
              -<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              Set the internal MC address mask<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* This is the max
              address of the GPU's<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-converted-space"> </span>* internal address
              space.<br class="">
              diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
              b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br class="">
              index e1637d5..77e7784f 100644<br class="">
              --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br class="">
              +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br class="">
              @@ -552,8 +552,7 @@ static int gmc_v9_0_sw_init(void
              *handle)<br class="">
                 <span class="Apple-tab-span" style="white-space: pre;">
              </span>if (adev-&gt;flags &amp; AMD_IS_APU) {<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;mc.vram_type
              = AMDGPU_VRAM_TYPE_UNKNOWN;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size
              = amdgpu_vm_size;<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.block_size
              = amdgpu_vm_block_size;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>amdgpu_vm_adjust_size(adev,
              64);<br class="">
            </blockquote>
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">Make sure we
              also use 1 level page tables in the APU case as well.</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>I also flashed a idea about it.</div>
        <div>Does APU still uses 1 level page now for gmc v9?</div>
      </div>
    </blockquote>
    No, it's same as Vega.<br>
    <br>
    David<br>
    <blockquote cite="mid:51C2AE07-B2D3-4A81-97FE-A79BDA5DBB8D-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <div>
        <div><br class="">
        </div>
        <div>Jerry<br class="">
        </div>
        <br class="">
        <blockquote type="cite" class="">
          <div class=""><br style="font-family: Helvetica; font-size:
              12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">With that done
              and the function renamed the patch is Reviewed-by:
              Christian König &lt;</span><a moz-do-not-send="true"
              href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" style="font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant: normal; font-weight: normal; letter-spacing:
              normal; line-height: normal; orphans: auto; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-stroke-width: 0px;" class="">christian.koenig-5C7GfCeVMHo@public.gmane.org</a><span
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">&gt;.</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">Regards,</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <span style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
              none; display: inline !important;" class="">Christian.</span><br
              style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <br style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant: normal; font-weight:
              normal; letter-spacing: normal; line-height: normal;
              orphans: auto; text-align: start; text-indent: 0px;
              text-transform: none; white-space: normal; widows: auto;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant: normal;
              font-weight: normal; letter-spacing: normal; line-height:
              normal; orphans: auto; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal; widows:
              auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"
              class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>}
              else {<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>/*
              XXX Don't know how to get VRAM type yet. */<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;mc.vram_type
              = AMDGPU_VRAM_TYPE_HBM;<br class="">
              @@ -564,11 +563,11 @@ static int gmc_v9_0_sw_init(void
              *handle)<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-converted-space"> </span>*/<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size
              = 1U &lt;&lt; 18;<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.block_size
              = 9;<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>DRM_INFO("vm
              size is %llu GB, block size is %u-bit\n",<br class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,<br
                class="">
              +<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.block_size);<br
                class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>}<br
                class="">
               -<span class="Apple-tab-span" style="white-space: pre;">
              </span>DRM_INFO("vm size is %d GB, block size is
              %d-bit\n",<br class="">
              -<span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span>adev-&gt;vm_manager.vm_size,
              adev-&gt;vm_manager.block_size);<br class="">
              -<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>/*
              This interrupt is VMC page fault.*/<br class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span>r
              = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_VMC, 0,<br
                class="">
               <span class="Apple-tab-span" style="white-space: pre;"> </span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span><span
                class="Apple-tab-span" style="white-space: pre;"></span>&amp;adev-&gt;mc.vm_fault);</blockquote>
          </div>
        </blockquote>
      </div>
      <br class="">
      <br>
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

--------------040501070107030806070502--

--===============2031889883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2031889883==--
