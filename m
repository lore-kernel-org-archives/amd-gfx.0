From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
Date: Fri, 21 Apr 2017 09:11:24 +0200
Message-ID: <af065740-e219-fccb-4dac-d46f3472f4aa@vodafone.de>
References: <1492119298-8526-1-git-send-email-AlexBin.Xie@amd.com>
 <58F0495D.60607@amd.com>
 <MWHPR1201MB0045DE55E81D0FF5CE76671FF2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <58F57C14.20403@amd.com>
 <MWHPR1201MB00452889FF2C7FDC55630B4BF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <7807726d-7318-b72f-1a14-2b37a73988bf@vodafone.de>
 <MWHPR1201MB00451DFD2A06BBA3CD6F928EF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <MWHPR1201MB004553768BCAC951D28A347AF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <4509f79a-ffd5-eb40-117c-84ea02cbf5cd@vodafone.de>
 <MWHPR1201MB0045EC51F6CE7C6C4283888CF2180@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <2b43e2a9-0c79-f945-c835-0cfc486304c8@vodafone.de>
 <MWHPR1201MB0045B04F77E1F1C6D37D24FBF2180@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <96809715-3c78-3784-fbeb-57a00359e3f3@vodafone.de>
 <MWHPR1201MB004568A33CBF287710759301F21B0@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734377622=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB004568A33CBF287710759301F21B0-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1734377622==
Content-Type: multipart/alternative;
 boundary="------------8CEDB8DD76852259471AAC51"

This is a multi-part message in MIME format.
--------------8CEDB8DD76852259471AAC51
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

> No. For the current source code, I think the premap and no-op is not 
> working.
>
Indeed, we don't set bo->mem.bus.addr in amdgpu_ttm_io_mem_reserve() any 
more. Felix will probably want to fix that for the KFD branch.

Anyway, as I said not unmapping the page tables is harmless compared to 
not releasing the memory backing it.

So please just do as I told you and change the interruptible reservation 
to a non-interruptible.

Regards,
Christian.

Am 20.04.2017 um 23:56 schrieb Xie, AlexBin:
>
> Hi Christian,
>
>
> I read amdgpu_ttm_io_mem_reserve() and amdgpu_ttm_io_mem_free() and 
> relevant codes from amdgpu_vram_scratch_init and 
> amdgpu_vram_scratch_fini.
>
>
> No. For the current source code, I think the premap and no-op is not 
> working.
>
>
> I add printk to prove. You can see bo_kmap_type is an invalid value. 
> ioremap_wc is really called to map the IO range into vmalloc space.
>
>
> ...
>
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759623] 
> entering amdgpu_vram_scratch_init.
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759631] 
> scratch ioremap_wc
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759631] 
> bo_kmap_type = 129
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759632] bus 
> address =           (null)
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759632] 
> is_iomem = 1
> Apr 20 16:31:18 axie-System-Product-Name kernel: [  106.759633] 
> leaving amdgpu_vram_scratch_init.
> ...
>
> I don't have log on rmmod AMDGPU yet. There are quite some settings to 
> make that happen in my computer.
> I think they are symemtric. Both mapping and unmapping are not no-op.
>
> Here is the printk patch for your reference.
>
> From 25f95239c23225008e4b59f30b9b5363fb321f94 Mon Sep 17 00:00:00 2001
> From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> Date: Thu, 20 Apr 2017 17:48:49 -0400
> Subject: [PATCH] A hack to trace premap and noop.
>
> Change-Id: I61fbbdbd82f62433e229b2e7e97be7a780ea8afa
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/ttm/ttm_bo.c               |  1 +
>  drivers/gpu/drm/ttm/ttm_bo_util.c          | 29 
> ++++++++++++++++++++++++++---
>  include/drm/ttm/ttm_bo_api.h               |  1 +
>  4 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fbb4afb..a537ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -313,6 +313,7 @@ static void amdgpu_block_invalid_wreg(struct 
> amdgpu_device *adev,
>  static int amdgpu_vram_scratch_init(struct amdgpu_device *adev)
>  {
> int r;
> +printk("entering amdgpu_vram_scratch_init.");
> if (adev->vram_scratch.robj == NULL) {
> r = amdgpu_bo_create(adev, AMDGPU_GPU_PAGE_SIZE,
> @@ -340,16 +341,36 @@ static int amdgpu_vram_scratch_init(struct 
> amdgpu_device *adev)
> amdgpu_bo_unpin(adev->vram_scratch.robj);
> amdgpu_bo_unreserve(adev->vram_scratch.robj);
> +/* Would like a printk to see if map / unmap is noop*/
> +adev->vram_scratch.robj->tbo.mem.bus.printk = true;
> +
> +if (adev->vram_scratch.robj->kmap.bo_kmap_type == ttm_bo_map_premapped)
> +printk("amdgpu_vram_scratch premapped!");
> +
> +printk("bo_kmap_type = %d", adev->vram_scratch.robj->kmap.bo_kmap_type);
> +printk("bus address = %p", adev->vram_scratch.robj->tbo.mem.bus.addr);
> +printk("is_iomem = %d", adev->vram_scratch.robj->tbo.mem.bus.is_iomem);
> +printk("leaving amdgpu_vram_scratch_init.");
> +
> return r;
>  }
>  static void amdgpu_vram_scratch_fini(struct amdgpu_device *adev)
>  {
> int r;
> +printk("entering amdgpu_vram_scratch_fini.");
> if (adev->vram_scratch.robj == NULL) {
> return;
> }
> +
> +if (adev->vram_scratch.robj->kmap.bo_kmap_type == ttm_bo_map_premapped)
> +printk("amdgpu_vram_scratch premapped!");
> +
> +printk("bo_kmap_type = %d", adev->vram_scratch.robj->kmap.bo_kmap_type);
> +printk("bus address = %p", adev->vram_scratch.robj->tbo.mem.bus.addr);
> +printk("is_iomem = %d", adev->vram_scratch.robj->tbo.mem.bus.is_iomem);
> +
> r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
> if (likely(r == 0)) {
> amdgpu_bo_kunmap(adev->vram_scratch.robj);
> @@ -357,6 +378,7 @@ static void amdgpu_vram_scratch_fini(struct 
> amdgpu_device *adev)
> amdgpu_bo_unreserve(adev->vram_scratch.robj);
> }
> amdgpu_bo_unref(&adev->vram_scratch.robj);
> +printk("leaving amdgpu_vram_scratch_fini.");
>  }
>  /**
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 989b98b..9b05d54 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1178,6 +1178,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
> bo->mem.page_alignment = page_alignment;
> bo->mem.bus.io_reserved_vm = false;
> bo->mem.bus.io_reserved_count = 0;
> +bo->mem.bus.printk = false;
> bo->moving = NULL;
> bo->mem.placement = (TTM_PL_FLAG_SYSTEM | TTM_PL_FLAG_CACHED);
> bo->persistent_swap_storage = persistent_swap_storage;
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c 
> b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index bf6e216..9d06952 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -526,14 +526,24 @@ static int ttm_bo_ioremap(struct 
> ttm_buffer_object *bo,
> if (bo->mem.bus.addr) {
> map->bo_kmap_type = ttm_bo_map_premapped;
> map->virtual = (void *)(((u8 *)bo->mem.bus.addr) + offset);
> +if (bo->mem.bus.printk)
> +printk ("scratch premapping");
> +
> } else {
> map->bo_kmap_type = ttm_bo_map_iomap;
> -if (mem->placement & TTM_PL_FLAG_WC)
> +if (mem->placement & TTM_PL_FLAG_WC) {
> map->virtual = ioremap_wc(bo->mem.bus.base + bo->mem.bus.offset + offset,
>  size);
> -else
> +if (bo->mem.bus.printk)
> +printk ("scratch ioremap_wc");
> +
> +}
> +else {
> map->virtual = ioremap_nocache(bo->mem.bus.base + bo->mem.bus.offset + 
> offset,
>     size);
> +if (bo->mem.bus.printk)
> +printk ("scratch ioremap_nocache");
> +}
> }
> return (!map->virtual) ? -ENOMEM : 0;
>  }
> @@ -618,21 +628,34 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
> struct ttm_mem_type_manager *man =
> &bo->bdev->man[bo->mem.mem_type];
> -if (!map->virtual)
> +if (!map->virtual) {
> +if (bo->mem.bus.printk)
> +printk ("scratch unmap return earlier");
> return;
> +}
> switch (map->bo_kmap_type) {
> case ttm_bo_map_iomap:
> +if (bo->mem.bus.printk)
> +printk ("scratch iounmap");
> iounmap(map->virtual);
> break;
> case ttm_bo_map_vmap:
> +if (bo->mem.bus.printk)
> +printk ("scratch vunmap");
> vunmap(map->virtual);
> break;
> case ttm_bo_map_kmap:
> +if (bo->mem.bus.printk)
> +printk ("scratch kunmap");
> kunmap(map->page);
> break;
> case ttm_bo_map_premapped:
> +if (bo->mem.bus.printk)
> +printk ("scratch unmap ttm_bo_map_premapped");
> break;
> default:
> +if (bo->mem.bus.printk)
> +printk ("scratch unmap bug");
> BUG();
> }
> (void) ttm_mem_io_lock(man, false);
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 2d0f63e..f74a554 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -70,6 +70,7 @@ struct ttm_bus_placement {
> boolis_iomem;
> boolio_reserved_vm;
> uint64_t        io_reserved_count;
> +bool            printk;
>  };
> -- 
> 2.7.4
>
>
>
>
> Thanks,
>
> Alex Bin
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, April 20, 2017 4:43 AM
> *To:* Xie, AlexBin; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
> Hi AlexBin,
>
>> Missing kunmap mapping in vmalloc will make kernel master page table 
>> incorrect.
> That's what I tried to explain yesterday, but unfortunately didn't had 
> time to do so. There is not corruption of the kernel master page table 
> in this case!
>
> The call of ttm_bo_kunmap is completely optional, take a look at 
> amdgpu_ttm_io_mem_reserve() and amdgpu_ttm_io_mem_free().
>
> The aperture is kept mapped into the page tables for the whole time 
> the driver is loaded. So this is a complete no-op and only done for 
> consistency.
>
>> It is good that you agree that there is no real world bad example 
>> caused by my patch. I will not discuss whether it is an improvement 
>> or not now to save time for both of us.
>>
> Great at least we can now agree to completely drop this patch.
>
> Thanks,
> Christian.
>
> Am 19.04.2017 um 21:30 schrieb Xie, AlexBin:
>>
>> Hi Christian,
>>
>>
>> Missing kunmap mapping in vmalloc will make kernel master page table 
>> incorrect. I would not call such issue as completely harmless. Please 
>> note that AMD graphic driver can run in 32 bit system. In 32 bit 
>> system, vmalloc address space is much smaller than size of most GPU VRAM.
>>
>>
>> amdgpu_bo_free_kernel has same issue as amdgpu_vram_scratch_fini. 1. 
>> It calls amdgpu_bo_reserve interruptible too. 2. It misses kunmap 
>> when amdgpu_bo_reserve returns error too. As result, kernel master 
>> page table can become incorrect, or as you call it "completely 
>> harmless vmalloc space leaking".
>>
>>
>> Because amdgpu_bo_free_kernel is used in more places, such as psp 
>> command submission, there will be bigger chance to have other usage 
>> where signal is not blocked. This will become a real bug.
>>
>>
>> I am thinking that we may fix the issue completely when TTM releases 
>> BO. But that is a bigger change.
>>
>>
>> It is good that you agree that there is no real world bad example 
>> caused by my patch. I will not discuss whether it is an improvement 
>> or not now to save time for both of us.
>>
>>
>> Thanks,
>>
>> Alex Bin Xie
>>
>>
>> ------------------------------------------------------------------------
>> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>> *Sent:* Wednesday, April 19, 2017 7:50 AM
>> *To:* Xie, AlexBin; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>> Without correctly kunmap, page table is corrupted. Page entries 
>>> point to wrong memory locations. You might call it completely 
>>> harmless. But I think this is a severe bug. Leaking memory is better 
>>> than a corrupted page table. Think security.
>> We are talking about the page tables for the vmalloc area in the 
>> kernel here, so no security problem. Leaking memory is much more 
>> problematic.
>>
>>> Would you provide any document and reference by saying" It is 
>>> impossible to receive a signal during module load/unload"? For 
>>> example, if the unload stuck in a lock, can CTRL+C stop the unload?
>>>
>> No, CTRL+C doesn't abort module load/unload. There have been patches 
>> to changes this a while ago, but IIRC it broke a whole bunch of 
>> driver relying on this.
>>
>>> What about there is some other return error? What about in future 
>>> somebody improve amdgpu_bo_reserve to return other errors, 
>>> then function amdgpu_vram_scratch_fini becomes buggy?
>>>
>> Yes, that is indeed an issue. For example -EDEADLK is possible as 
>> well. That's why I said we should use amdgpu_bo_free_kernel() instead.
>>
>>> While I am thinking whether there is a better way for the current 
>>> situation, would you give a real world example that my patch really 
>>> not working? Then we can address it.
>>>
>> I don't think there is because the driver can't receive a signal 
>> during load/unload, but the problem is rather that the patch doesn't 
>> improve the situation at all.
>>
>> Regards,
>> Christian.
>>
>> Am 19.04.2017 um 13:37 schrieb Xie, AlexBin:
>>>
>>> Hi Christian,
>>>
>>>
>>> Without correctly kunmap, page table is corrupted. Page entries 
>>> point to wrong memory locations. You might call it completely 
>>> harmless. But I think this is a severe bug. Leaking memory is better 
>>> than a corrupted page table. Think security.
>>>
>>>
>>> Would you provide any document and reference by saying" It is 
>>> impossible to receive a signal during module load/unload"? For 
>>> example, if the unload stuck in a lock, can CTRL+C stop the unload?
>>>
>>>
>>> If "It is impossible to receive a signal during module load/unload", 
>>> interruptible waiting is fine too, because function 
>>> amdgpu_bo_reserve will return successfully.
>>>
>>>
>>> What about there is some other return error? What about in future 
>>> somebody improve amdgpu_bo_reserve to return other errors, 
>>> then function amdgpu_vram_scratch_fini becomes buggy?
>>>
>>>
>>> While I am thinking whether there is a better way for the current 
>>> situation, would you give a real world example that my patch really 
>>> not working? Then we can address it.
>>>
>>>
>>> Thanks,
>>>
>>> Alex Bin
>>>
>>>
>>> ------------------------------------------------------------------------
>>> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>>> *Sent:* Wednesday, April 19, 2017 2:35 AM
>>> *To:* Xie, AlexBin; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>> Hi AlexBin,
>>>
>>> the answer is ttm_bo_kunmap isn't called at all and yes in the case 
>>> of an iomap we leak the address space reserved.
>>>
>>> But that is completely harmless on a 64bit system compared to 
>>> leaking the memory backing the address space.
>>>
>>> Using amdgpu_bo_free_kernel() instead of openly coding it here is 
>>> probably a good idea.
>>>
>>> Additional to that it's probably a good idea to set the no_intr flag 
>>> when reserving kernel BOs. It is impossible to receive a signal 
>>> during module load/unload, but it's probably better to document that 
>>> in the code as well.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 18.04.2017 um 20:54 schrieb Xie, AlexBin:
>>>> Hi Christian,
>>>>
>>>> Have you found how/where/when? When you said "mapping will just be 
>>>> released a bit later on", you must know the answer.
>>>>
>>>> It is difficult to prove something does not exist. Anyway, I will 
>>>> give it a try to prove such "later on" does not exist.
>>>>
>>>> Function ttm_bo_kunmap is the only function to unmap. To prove 
>>>> this, search ttm_bo_map_iomap, only ttm_bo_kunmap use this enum to 
>>>> correctly kunmap.
>>>>
>>>> Function ttm_bo_kunmap is not called by ttm itself. This is a hint 
>>>> that all TTM delay delete mechanism or unref mechanism will NOT 
>>>> kunmap BO later on.
>>>>
>>>> Function ttm_bo_kunmap is called by AMDGPU function 
>>>> amdgpu_bo_kunmap and amdgpu_gem_prime_vunmap.
>>>>
>>>> Search AMDGPU for amdgpu_bo_kunmap. All matches do not kunmap for 
>>>> scratch VRAM BO. amdgpu_bo_free_kernel is a suspect but the answer 
>>>> is still NO.
>>>>
>>>> So all possibilities are searched. Did I miss anything?
>>>>
>>>> Thanks,
>>>> Alex Bin Xie
>>>>
>>>> ------------------------------------------------------------------------
>>>> *From:* Xie, AlexBin
>>>> *Sent:* Tuesday, April 18, 2017 2:04:33 PM
>>>> *To:* Christian König; Zhou, David(ChunMing); 
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>>
>>>> Hi Christian,
>>>>
>>>>
>>>> Would you point out where/when will kunmap happen for this BO when 
>>>> release? It must be somewhere in some function calls.
>>>>
>>>>
>>>> I checked before I asked for review. But I did not see such obvious 
>>>> kunmap function call.
>>>>
>>>>
>>>> If so, there should be a comment in function 
>>>> amdgpu_vram_scratch_fini to avoid future confusion.
>>>>
>>>>
>>>> Thanks,
>>>> Alex Bin Xie
>>>> ------------------------------------------------------------------------
>>>> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>>>> *Sent:* Tuesday, April 18, 2017 1:46 PM
>>>> *To:* Xie, AlexBin; Zhou, David(ChunMing); 
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>> Hi AlexBin,
>>>>
>>>> No, David is right. This is a very common coding pattern in the 
>>>> kernel module.
>>>>
>>>> Freeing up a BO while there still exists a kernel mapping is 
>>>> perfectly ok, the mapping will just be released a bit later on.
>>>>
>>>> So this code is actually perfectly ok and just an optimization, but 
>>>> your patch breaks it and creates a memory leak.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 18.04.2017 um 17:17 schrieb Xie, AlexBin:
>>>>>
>>>>> Hi David,
>>>>>
>>>>>
>>>>> When amdgpu_bo_reserve return errors, we cannot release the BO. 
>>>>> This is not a memory leak. General speaking, memory leak 
>>>>> is unnoticed and unintentional.
>>>>>
>>>>>
>>>>> The caller of function amdgpu_vram_scratch_fini ignores the return 
>>>>> error value...
>>>>>
>>>>>
>>>>> The "memory leak" is not caused by my patch. It is caused because 
>>>>> reserving BO fails.
>>>>>
>>>>>
>>>>> This patch only aim to make function amdgpu_vram_scratch_fini 
>>>>> behave correctly.
>>>>>
>>>>>
>>>>> To follow up, we can add a warning message when amdgpu_bo_reserve 
>>>>> error happens in a different patch.
>>>>>
>>>>>
>>>>> If function call amdgpu_bo_reserve is changed to uninterruptible, 
>>>>> this changes driver behaviour. Without a substantial issue, I 
>>>>> would be cautious for such a change.
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Alex Bin Xie
>>>>>
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>> *From:* Zhou, David(ChunMing)
>>>>> *Sent:* Monday, April 17, 2017 10:38 PM
>>>>> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>>>
>>>>>
>>>>> On 2017年04月17日 22:54, Xie, AlexBin wrote:
>>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>>
>>>>>> Thanks for the comments. However, please have look at 
>>>>>> amdgpu_bo_reserve definition.
>>>>>>
>>>>>> static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool 
>>>>>> no_intr)
>>>>>>
>>>>> Ah, this is a wired wrapper for ttm_bo_reserve.
>>>>>
>>>>>>
>>>>>> When we call this function like the following:
>>>>>>
>>>>>>    r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>>>>>> The false means interruptible.
>>>>>>
>>>>>>
>>>>>> On the other hand,  when amdgpu_bo_reserve function return error, 
>>>>>> why do we unref BO without kunmap and unpin the BO? This is wrong 
>>>>>> implementation when amdgpu_bo_reserve return any error.
>>>>>>
>>>>> Yeah, I see your mean, it's in driver un-loading, How about 
>>>>> changing to no interruptible? Your patch will make a memleak if 
>>>>> bo_reserve fails, but it seems not matter. I have no strong 
>>>>> preference.
>>>>>
>>>>> Regards,
>>>>> David Zhou
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Alex Bin Xie
>>>>>>
>>>>>> ------------------------------------------------------------------------
>>>>>> *From:* Zhou, David(ChunMing)
>>>>>> *Sent:* Friday, April 14, 2017 12:00 AM
>>>>>> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>>>>
>>>>>>
>>>>>> On 2017年04月14日 05:34, Alex Xie wrote:
>>>>>> > According to comment of amdgpu_bo_reserve, amdgpu_bo_reserve
>>>>>> > can return with -ERESTARTSYS. When this function was interrupted
>>>>>> > by a signal, BO should not be unref. Otherwise the BO might be
>>>>>> > released while is kmapped and pinned, or BO MIGHT be deref
>>>>>> > multiple times, etc.
>>>>>>          r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>>>>>> we have specified interruptible to false, so -ERESTARTSYS isn't 
>>>>>> possible
>>>>>> here.
>>>>>>
>>>>>> Thanks,
>>>>>> David Zhou
>>>>>> >
>>>>>> > Change-Id: If76071a768950a0d3ad9d5da7fcae04881807621
>>>>>> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>>>>>> > ---
>>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>>>>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>> >
>>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> > index 53996e3..1dcc2d1 100644
>>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> > @@ -355,8 +355,8 @@ static void amdgpu_vram_scratch_fini(struct 
>>>>>> amdgpu_device *adev)
>>>>>> >                amdgpu_bo_kunmap(adev->vram_scratch.robj);
>>>>>> >                amdgpu_bo_unpin(adev->vram_scratch.robj);
>>>>>> >                amdgpu_bo_unreserve(adev->vram_scratch.robj);
>>>>>> > + amdgpu_bo_unref(&adev->vram_scratch.robj);
>>>>>> >        }
>>>>>> > - amdgpu_bo_unref(&adev->vram_scratch.robj);
>>>>>> >   }
>>>>>> >
>>>>>> >   /**
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------8CEDB8DD76852259471AAC51
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Alex,<br>
      <br>
      <blockquote type="cite">
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 16px;">No. For the current source
            code, I think the premap and no-op is not working.</span></p>
      </blockquote>
      Indeed, we don't set bo-&gt;mem.bus.addr in
      amdgpu_ttm_io_mem_reserve() any more. Felix will probably want to
      fix that for the KFD branch.<br>
      <br>
      Anyway, as I said not unmapping the page tables is harmless
      compared to not releasing the memory backing it.<br>
      <br>
      So please just do as I told you and change the interruptible
      reservation to a non-interruptible.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.04.2017 um 23:56 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB004568A33CBF287710759301F21B0-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Hi Christian, </p>
        <p><br>
        </p>
        <p>I read <span style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 16px;">amdgpu_ttm_io_mem_reserve()
            and amdgpu_ttm_io_mem_free() and relevant codes from <span
              style="font-family: Calibri, Arial, Helvetica, sans-serif;
              font-size: 16px;">amdgpu_vram_scratch_init and <span
                style="font-family: Calibri, Arial, Helvetica,
                sans-serif; font-size: 16px;">amdgpu_vram_scratch_fini</span></span>. </span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 16px;"><br>
          </span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 16px;">No. For the current source
            code, I think the premap and no-op is not working.</span></p>
        <p><br>
        </p>
        <p><span style="background-color: rgb(255, 255, 255);">I add
            printk to prove. You can see </span><span
            style="font-family: Calibri, Arial, Helvetica, sans-serif;
            font-size: 16px; background-color: rgb(255, 255, 255);">bo_kmap_type
            is an invalid value. <span style="font-family: Calibri,
              Arial, Helvetica, sans-serif; font-size: 16px;">ioremap_wc
              is really called to map the IO range into vmalloc space.</span></span></p>
        <p><br>
        </p>
        <p>...</p>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759623] entering amdgpu_vram_scratch_init.</div>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759631] scratch <span style="background-color: rgb(255,
            255, 0);">
            ioremap_wc</span></div>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759631] <span style="background-color: rgb(255, 255,
            0);">
            bo_kmap_type = 129</span></div>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759632] bus address =           (null)</div>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759632] is_iomem = 1</div>
        <div>Apr 20 16:31:18 axie-System-Product-Name kernel: [
           106.759633] leaving amdgpu_vram_scratch_init.</div>
        <div>...</div>
        <div><br>
        </div>
        <div>I don't have log on rmmod AMDGPU yet. There are quite some
          settings to make that happen in my computer.</div>
        <div>I think they are symemtric. Both mapping and
          unmapping are not no-op.</div>
        <div><br>
        </div>
        <div>Here is the printk patch for your reference.</div>
        <div><br>
        </div>
        <div>
          <div>From 25f95239c23225008e4b59f30b9b5363fb321f94 Mon Sep 17
            00:00:00 2001</div>
          <div>From: Alex Xie <a class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></div>
          <div>Date: Thu, 20 Apr 2017 17:48:49 -0400</div>
          <div>Subject: [PATCH] A hack to trace premap and noop.</div>
          <div><br>
          </div>
          <div>Change-Id: I61fbbdbd82f62433e229b2e7e97be7a780ea8afa</div>
          <div>Signed-off-by: Alex Xie <a class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></div>
          <div>---</div>
          <div> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22
            ++++++++++++++++++++++</div>
          <div> drivers/gpu/drm/ttm/ttm_bo.c               |  1 +</div>
          <div> drivers/gpu/drm/ttm/ttm_bo_util.c          | 29
            ++++++++++++++++++++++++++---</div>
          <div> include/drm/ttm/ttm_bo_api.h               |  1 +</div>
          <div> 4 files changed, 50 insertions(+), 3 deletions(-)</div>
          <div><br>
          </div>
          <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>index fbb4afb..a537ea1 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
          <div>@@ -313,6 +313,7 @@ static void
            amdgpu_block_invalid_wreg(struct amdgpu_device *adev,</div>
          <div> static int amdgpu_vram_scratch_init(struct amdgpu_device
            *adev)</div>
          <div> {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>int
            r;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("entering
            amdgpu_vram_scratch_init.");</div>
          <div> </div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;vram_scratch.robj == NULL) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>r
            = amdgpu_bo_create(adev, AMDGPU_GPU_PAGE_SIZE,</div>
          <div>@@ -340,16 +341,36 @@ static int
            amdgpu_vram_scratch_init(struct amdgpu_device *adev)</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_bo_unpin(adev-&gt;vram_scratch.robj);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_bo_unreserve(adev-&gt;vram_scratch.robj);</div>
          <div> </div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
            Would like a printk to see if map / unmap is noop*/</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>adev-&gt;vram_scratch.robj-&gt;tbo.mem.bus.printk
            = true;</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;vram_scratch.robj-&gt;kmap.bo_kmap_type ==
            ttm_bo_map_premapped)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("amdgpu_vram_scratch
            premapped!");</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("bo_kmap_type
            = %d", adev-&gt;vram_scratch.robj-&gt;kmap.bo_kmap_type);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("bus
            address = %p",
            adev-&gt;vram_scratch.robj-&gt;tbo.mem.bus.addr);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("is_iomem
            = %d", adev-&gt;vram_scratch.robj-&gt;tbo.mem.bus.is_iomem);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("leaving
            amdgpu_vram_scratch_init.");</div>
          <div>+</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>return
            r;</div>
          <div> }</div>
          <div> </div>
          <div> static void amdgpu_vram_scratch_fini(struct
            amdgpu_device *adev)</div>
          <div> {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>int
            r;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("entering
            amdgpu_vram_scratch_fini.");</div>
          <div> </div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;vram_scratch.robj == NULL) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (adev-&gt;vram_scratch.robj-&gt;kmap.bo_kmap_type ==
            ttm_bo_map_premapped)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("amdgpu_vram_scratch
            premapped!");</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("bo_kmap_type
            = %d", adev-&gt;vram_scratch.robj-&gt;kmap.bo_kmap_type);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("bus
            address = %p",
            adev-&gt;vram_scratch.robj-&gt;tbo.mem.bus.addr);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("is_iomem
            = %d", adev-&gt;vram_scratch.robj-&gt;tbo.mem.bus.is_iomem);</div>
          <div>+</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>r
            = amdgpu_bo_reserve(adev-&gt;vram_scratch.robj, false);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>if
            (likely(r == 0)) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_bo_kunmap(adev-&gt;vram_scratch.robj);</div>
          <div>@@ -357,6 +378,7 @@ static void
            amdgpu_vram_scratch_fini(struct amdgpu_device *adev)</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_bo_unreserve(adev-&gt;vram_scratch.robj);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk("leaving
            amdgpu_vram_scratch_fini.");</div>
          <div> }</div>
          <div> </div>
          <div> /**</div>
          <div>diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
            b/drivers/gpu/drm/ttm/ttm_bo.c</div>
          <div>index 989b98b..9b05d54 100644</div>
          <div>--- a/drivers/gpu/drm/ttm/ttm_bo.c</div>
          <div>+++ b/drivers/gpu/drm/ttm/ttm_bo.c</div>
          <div>@@ -1178,6 +1178,7 @@ int ttm_bo_init_reserved(struct
            ttm_bo_device *bdev,</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;mem.page_alignment
            = page_alignment;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;mem.bus.io_reserved_vm
            = false;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;mem.bus.io_reserved_count
            = 0;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;mem.bus.printk
            = false;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;moving
            = NULL;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;mem.placement
            = (TTM_PL_FLAG_SYSTEM | TTM_PL_FLAG_CACHED);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bo-&gt;persistent_swap_storage
            = persistent_swap_storage;</div>
          <div>diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
            b/drivers/gpu/drm/ttm/ttm_bo_util.c</div>
          <div>index bf6e216..9d06952 100644</div>
          <div>--- a/drivers/gpu/drm/ttm/ttm_bo_util.c</div>
          <div>+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c</div>
          <div>@@ -526,14 +526,24 @@ static int ttm_bo_ioremap(struct
            ttm_buffer_object *bo,</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.addr) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>map-&gt;bo_kmap_type
            = ttm_bo_map_premapped;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>map-&gt;virtual
            = (void *)(((u8 *)bo-&gt;mem.bus.addr) + offset);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch premapping");</div>
          <div>+</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>}
            else {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>map-&gt;bo_kmap_type
            = ttm_bo_map_iomap;</div>
          <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (mem-&gt;placement &amp; TTM_PL_FLAG_WC)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (mem-&gt;placement &amp; TTM_PL_FLAG_WC) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>map-&gt;virtual
            = ioremap_wc(bo-&gt;mem.bus.base + bo-&gt;mem.bus.offset +
            offset,</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span> size);</div>
          <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>else</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch ioremap_wc");</div>
          <div>+</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>else
            {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>map-&gt;virtual
            = ioremap_nocache(bo-&gt;mem.bus.base +
            bo-&gt;mem.bus.offset + offset,</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span> 
                size);</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch ioremap_nocache");</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>return
            (!map-&gt;virtual) ? -ENOMEM : 0;</div>
          <div> }</div>
          <div>@@ -618,21 +628,34 @@ void ttm_bo_kunmap(struct
            ttm_bo_kmap_obj *map)</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>struct
            ttm_mem_type_manager *man =</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>&amp;bo-&gt;bdev-&gt;man[bo-&gt;mem.mem_type];</div>
          <div> </div>
          <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (!map-&gt;virtual)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (!map-&gt;virtual) {</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch unmap return earlier");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>switch
            (map-&gt;bo_kmap_type) {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>case
            ttm_bo_map_iomap:</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch iounmap");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>iounmap(map-&gt;virtual);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>break;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>case
            ttm_bo_map_vmap:</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch vunmap");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>vunmap(map-&gt;virtual);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>break;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>case
            ttm_bo_map_kmap:</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch kunmap");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>kunmap(map-&gt;page);</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>break;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>case
            ttm_bo_map_premapped:</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch unmap ttm_bo_map_premapped");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>break;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>default:</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
            (bo-&gt;mem.bus.printk)</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>printk
            ("scratch unmap bug");</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>BUG();</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>(void)
            ttm_mem_io_lock(man, false);</div>
          <div>diff --git a/include/drm/ttm/ttm_bo_api.h
            b/include/drm/ttm/ttm_bo_api.h</div>
          <div>index 2d0f63e..f74a554 100644</div>
          <div>--- a/include/drm/ttm/ttm_bo_api.h</div>
          <div>+++ b/include/drm/ttm/ttm_bo_api.h</div>
          <div>@@ -70,6 +70,7 @@ struct ttm_bus_placement {</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bool<span class="Apple-tab-span" style="white-space:pre">
</span>is_iomem;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>bool<span class="Apple-tab-span" style="white-space:pre">
</span>io_reserved_vm;</div>
          <div> <span class="Apple-tab-span" style="white-space:pre"> </span>uint64_t
                   io_reserved_count;</div>
          <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>bool
                       printk;</div>
          <div> };</div>
          <div> </div>
          <div> </div>
          <div>-- </div>
          <div>2.7.4</div>
          <div><br>
          </div>
          <br>
        </div>
        <div><br>
        </div>
        <div><br>
        </div>
        Thanks,
        <p>Alex Bin</p>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Thursday, April 20, 2017 4:43 AM<br>
              <b>To:</b> Xie, AlexBin; Zhou, David(ChunMing);
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly unref
              of BO</font>
            <div> </div>
          </div>
          <div>
            <div class="moz-cite-prefix">Hi AlexBin,<br>
              <br>
              <blockquote type="cite">Missing kunmap mapping in <span
                  style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:16px">vmalloc will </span>make kernel master
                page table incorrect.</blockquote>
              That's what I tried to explain yesterday, but
              unfortunately didn't had time to do so. There is not
              corruption of the kernel master page table in this case!<br>
              <br>
              The call of ttm_bo_kunmap is completely optional, take a
              look at amdgpu_ttm_io_mem_reserve() and
              amdgpu_ttm_io_mem_free().<br>
              <br>
              The aperture is kept mapped into the page tables for the
              whole time the driver is loaded. So this is a complete
              no-op and only done for consistency.<br>
              <br>
              <blockquote type="cite">
                <p>It is good that you agree that there is no real
                  world bad example caused by my patch. I will
                  not discuss whether it is an improvement or not now to
                  save time for both of us.</p>
              </blockquote>
              Great at least we can now agree to completely drop this
              patch.<br>
              <br>
              Thanks,<br>
              Christian.<br>
              <br>
              Am 19.04.2017 um 21:30 schrieb Xie, AlexBin:<br>
            </div>
            <blockquote type="cite">
              <div id="divtagdefaultwrapper" dir="ltr"
                style="font-size:12pt; color:#000000;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                <p>Hi Christian,</p>
                <p><br>
                </p>
                <p>Missing kunmap mapping in <span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px">vmalloc will </span>make
                  kernel master page table incorrect. I would not call
                  such issue as completely harmless. Please note that
                  AMD graphic driver can run in 32 bit system. In 32 bit
                  system, vmalloc address space is much smaller than
                  size of most GPU VRAM.</p>
                <p><br>
                </p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px">amdgpu_bo_free_kernel has same issue
                    as <span>amdgpu_vram_scratch_fini. 1. It calls <span>amdgpu_bo_reserve
                        interruptible too. 2. It misses kunmap when <span>amdgpu_bo_reserve
                          returns error too. As result, </span>kernel
                        master page table can become incorrect, or as
                        you call it "completely harmless vmalloc space
                        leaking". </span></span></span></p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px"><span><span><br>
                      </span></span></span></p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px"><span><span>Because <span
                          style="font-family:Calibri,Arial,Helvetica,sans-serif;
                          font-size:16px">amdgpu_bo_free_kernel is used
                          in more places, such as psp command
                          submission, there will be bigger chance to
                          have other usage where signal is not blocked.
                          This will become a real bug.</span></span></span></span></p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px"><br>
                  </span></p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px">I am thinking that we may fix the
                    issue completely when TTM releases BO. But that is a
                    bigger change.</span></p>
                <p><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px"><br>
                  </span></p>
                <p>It is good that you agree that there is no real
                  world bad example caused by my patch. I will
                  not discuss whether it is an improvement or not now to
                  save time for both of us.</p>
                <p><br>
                </p>
                <p>Thanks, </p>
                <p>Alex Bin Xie</p>
                <p><br>
                </p>
                <div style="color:rgb(0,0,0)">
                  <hr tabindex="-1" style="display:inline-block;
                    width:98%">
                  <div id="divRplyFwdMsg" dir="ltr"><font
                      style="font-size:11pt" color="#000000"
                      face="Calibri, sans-serif"><b>From:</b> Christian
                      König
                      <a moz-do-not-send="true"
                        class="moz-txt-link-rfc2396E"
                        href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                      <b>Sent:</b> Wednesday, April 19, 2017 7:50 AM<br>
                      <b>To:</b> Xie, AlexBin; Zhou, David(ChunMing); <a
                        moz-do-not-send="true"
                        class="moz-txt-link-abbreviated"
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                        amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix
                      wrongly unref of BO</font>
                    <div> </div>
                  </div>
                  <div>
                    <div class="moz-cite-prefix">
                      <blockquote type="cite">Without correctly kunmap,
                        page table is corrupted. Page entries point to
                        wrong memory locations. You might call it
                        completely harmless. But I think this is a
                        severe bug. Leaking memory is better than a
                        corrupted page table. Think security.</blockquote>
                      We are talking about the page tables for the
                      vmalloc area in the kernel here, so no security
                      problem. Leaking memory is much more problematic.<br>
                      <br>
                      <blockquote type="cite">
                        <p>Would you provide any document and reference
                          by saying"<span style=""> It is impossible to
                            receive a signal during module load/unload"?
                            For example, if the unload stuck in a lock,
                            can CTRL+C stop the unload?</span></p>
                      </blockquote>
                      No, CTRL+C doesn't abort module load/unload. There
                      have been patches to changes this a while ago, but
                      IIRC it broke a whole bunch of driver relying on
                      this.<br>
                      <br>
                      <blockquote type="cite">
                        <p><span style="font-size:12pt;
                            font-family:Calibri,Arial,Helvetica,sans-serif">What
                            about there is some other return error? What
                            about in future somebody improve <span
                              style="font-family:Calibri,Arial,Helvetica,sans-serif;
                              font-size:16px">amdgpu_bo_reserve to
                              return other errors, then function <span>amdgpu_vram_scratch_fini</span>
                              becomes buggy?</span></span></p>
                      </blockquote>
                      Yes, that is indeed an issue. For example -EDEADLK
                      is possible as well. That's why I said we should
                      use amdgpu_bo_free_kernel() instead.<br>
                      <br>
                      <blockquote type="cite">
                        <p>While I am thinking whether there is a better
                          way for the current situation, would you give
                          a real world example that my patch really not
                          working? Then we can address it.</p>
                      </blockquote>
                      I don't think there is because the driver can't
                      receive a signal during load/unload, but the
                      problem is rather that the patch doesn't improve
                      the situation at all.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      Am 19.04.2017 um 13:37 schrieb Xie, AlexBin:<br>
                    </div>
                    <blockquote type="cite">
                      <div id="divtagdefaultwrapper" dir="ltr"
                        style="font-size:12pt; color:#000000;
                        font-family:Calibri,Arial,Helvetica,sans-serif">
                        <p>Hi Christian,</p>
                        <p><br>
                        </p>
                        <p>Without correctly kunmap, page table
                          is corrupted. Page entries point to wrong
                          memory locations. You might call it completely
                          harmless. But I think this is a severe bug.
                          Leaking memory is better than a corrupted page
                          table. Think security.</p>
                        <p><br>
                        </p>
                        <p>Would you provide any document and reference
                          by saying"<span style=""> It is impossible to
                            receive a signal during module load/unload"?
                            For example, if the unload stuck in a lock,
                            can CTRL+C stop the unload?</span></p>
                        <p><span style=""><br>
                          </span></p>
                        <p><span style="">If "<span style="">It is
                              impossible to receive a signal during
                              module load/unload", interruptible waiting
                              is fine too, because function </span></span><span
                            style="font-size:12pt;
                            font-family:Calibri,Arial,Helvetica,sans-serif">amdgpu_bo_reserve
                            will return successfully.</span></p>
                        <p><span style="font-size:12pt;
                            font-family:Calibri,Arial,Helvetica,sans-serif"><br>
                          </span></p>
                        <p><span style="font-size:12pt;
                            font-family:Calibri,Arial,Helvetica,sans-serif">What
                            about there is some other return error? What
                            about in future somebody improve <span
                              style="font-family:Calibri,Arial,Helvetica,sans-serif;
                              font-size:16px">amdgpu_bo_reserve to
                              return other errors, then function <span>amdgpu_vram_scratch_fini</span>
                              becomes buggy?</span></span></p>
                        <p><span style=""><br>
                          </span></p>
                        <p>While I am thinking whether there is a better
                          way for the current situation, would you give
                          a real world example that my patch really not
                          working? Then we can address it.</p>
                        <p><br>
                        </p>
                        <p>Thanks,</p>
                        <p>Alex Bin</p>
                        <br>
                        <div style="color:rgb(0,0,0)">
                          <hr tabindex="-1" style="display:inline-block;
                            width:98%">
                          <div id="divRplyFwdMsg" dir="ltr"><font
                              style="font-size:11pt" color="#000000"
                              face="Calibri, sans-serif"><b>From:</b>
                              Christian König
                              <a moz-do-not-send="true"
                                class="moz-txt-link-rfc2396E"
                                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                              <b>Sent:</b> Wednesday, April 19, 2017
                              2:35 AM<br>
                              <b>To:</b> Xie, AlexBin; Zhou,
                              David(ChunMing); <a
                                moz-do-not-send="true"
                                class="moz-txt-link-abbreviated"
                                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                                amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                              <b>Subject:</b> Re: [PATCH] dmr/amdgpu:
                              Fix wrongly unref of BO</font>
                            <div> </div>
                          </div>
                          <div>
                            <div class="moz-cite-prefix">Hi AlexBin,<br>
                              <br>
                              the answer is ttm_bo_kunmap isn't called
                              at all and yes in the case of an iomap we
                              leak the address space reserved.<br>
                              <br>
                              But that is completely harmless on a 64bit
                              system compared to leaking the memory
                              backing the address space.<br>
                              <br>
                              Using <span style=""><span>amdgpu_bo_free_kernel()
                                  instead of openly coding it here is
                                  probably a good idea.<br>
                                  <br>
                                  Additional to that it's probably a
                                  good idea to set the no_intr flag when
                                  reserving kernel BOs. It is impossible
                                  to receive a signal during module
                                  load/unload, but it's probably better
                                  to document that in the code as well.<br>
                                  <br>
                                  Regards,<br>
                                  Christian.<br>
                                </span></span><br>
                              Am 18.04.2017 um 20:54 schrieb Xie,
                              AlexBin:<br>
                            </div>
                            <blockquote type="cite">
                              <div id="divtagdefaultwrapper" dir="ltr"
                                style="font-size:12pt; color:#000000;
                                font-family:Calibri,Arial,Helvetica,sans-serif">
                                Hi Christian,
                                <div><br>
                                </div>
                                <div>Have you found how/where/when? When
                                  you said "<span
                                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                    font-size:16px">mapping will just</span><span
style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:16px"> be
                                    released a bit later on", you must
                                    know the answer. </span></div>
                                <div><br>
                                </div>
                                <div>It is difficult to prove something
                                  does not exist. Anyway, I will give it
                                  a try to prove such "later on" does
                                  not exist.</div>
                                <div><br>
                                </div>
                                <div><span>Function ttm_bo_kunmap is the
                                    only function to unmap. To prove
                                    this, search <span>ttm_bo_map_iomap,
                                      only <span style="">ttm_bo_kunmap
                                        use this enum to correctly
                                        kunmap.</span></span></span><br>
                                </div>
                                <div><span><span><span style=""><br>
                                      </span></span></span></div>
                                <div><span><span><span style=""><span>Function ttm_bo_kunmap
                                          is not called by ttm itself.
                                          This is a hint that all TTM
                                          delay delete mechanism or
                                          unref mechanism will NOT
                                          kunmap BO later on.</span><br>
                                      </span></span></span></div>
                                <div><span><span><span style=""><span><br>
                                        </span></span></span></span></div>
                                <div><span><span><span style=""><span><span
                                            style="">Function </span><span
                                            style="">ttm_bo_kunmap is
                                            called by AMDGPU function <span>amdgpu_bo_kunmap
                                              and <span>amdgpu_gem_prime_vunmap.</span></span></span><br>
                                        </span></span></span></span></div>
                                <div><br>
                                </div>
                                <div>Search AMDGPU for <span style="">amdgpu_bo_kunmap.
                                    All matches do not kunmap for
                                    scratch VRAM BO.  <span>amdgpu_bo_free_kernel
                                      is a suspect but the answer is
                                      still NO.</span></span></div>
                                <div><span style=""><span><br>
                                    </span></span></div>
                                <div><span style=""><span>So all
                                      possibilities are searched. Did I
                                      miss anything?</span></span></div>
                                <div><span style=""><span><br>
                                    </span></span></div>
                                <div>Thanks,</div>
                                <div>Alex Bin Xie</div>
                                <div><br>
                                </div>
                              </div>
                              <hr tabindex="-1"
                                style="display:inline-block; width:98%">
                              <div id="divRplyFwdMsg" dir="ltr"><font
                                  style="font-size:11pt" color="#000000"
                                  face="Calibri, sans-serif"><b>From:</b>
                                  Xie, AlexBin<br>
                                  <b>Sent:</b> Tuesday, April 18, 2017
                                  2:04:33 PM<br>
                                  <b>To:</b> Christian König; Zhou,
                                  David(ChunMing); <a
                                    moz-do-not-send="true"
                                    class="moz-txt-link-abbreviated"
                                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                  <b>Subject:</b> Re: [PATCH]
                                  dmr/amdgpu: Fix wrongly unref of BO</font>
                                <div> </div>
                              </div>
                              <div>
                                <div id="divtagdefaultwrapper" dir="ltr"
                                  style="font-size:12pt; color:#000000;
font-family:Calibri,Arial,Helvetica,sans-serif">
                                  <p>Hi Christian,</p>
                                  <p><br>
                                  </p>
                                  <p>Would you point out where/when will
                                    kunmap happen for this BO when
                                    release? <span
                                      style="font-size:12pt">It must be
                                      somewhere </span><span
                                      style="font-size:12pt"></span><span
                                      style="font-size:12pt">in some
                                      function calls</span><span
                                      style="font-size:12pt">.</span></p>
                                  <p><span style="font-size:12pt"><br>
                                    </span></p>
                                  <p><span style="font-size:12pt">I
                                      checked before I asked for review.
                                      But I did not see such obvious
                                      kunmap function call.</span></p>
                                  <p><span style="font-size:12pt"><br>
                                    </span></p>
                                  <p><span style="font-size:12pt">If so,
                                      there should be a comment in
                                      function <span>amdgpu_vram_scratch_fini </span>to
                                      avoid future confusion.</span></p>
                                  <br>
                                  Thanks,
                                  <div>Alex Bin Xie<br>
                                    <div style="color:rgb(0,0,0)">
                                      <hr tabindex="-1"
                                        style="display:inline-block;
                                        width:98%">
                                      <div id="divRplyFwdMsg" dir="ltr"><font
                                          style="font-size:11pt"
                                          color="#000000" face="Calibri,
                                          sans-serif"><b>From:</b>
                                          Christian König
                                          <a moz-do-not-send="true"
                                            class="moz-txt-link-rfc2396E"
href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                                          <b>Sent:</b> Tuesday, April
                                          18, 2017 1:46 PM<br>
                                          <b>To:</b> Xie, AlexBin; Zhou,
                                          David(ChunMing); <a
                                            moz-do-not-send="true"
                                            class="moz-txt-link-abbreviated"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                          <b>Subject:</b> Re: [PATCH]
                                          dmr/amdgpu: Fix wrongly unref
                                          of BO</font>
                                        <div> </div>
                                      </div>
                                      <div>
                                        <div class="moz-cite-prefix">Hi
                                          AlexBin,<br>
                                          <br>
                                          No, David is right. This is a
                                          very common coding pattern in
                                          the kernel module.<br>
                                          <br>
                                          Freeing up a BO while there
                                          still exists a kernel mapping
                                          is perfectly ok, the mapping
                                          will just be released a bit
                                          later on.<br>
                                          <br>
                                          So this code is actually
                                          perfectly ok and just an
                                          optimization, but your patch
                                          breaks it and creates a memory
                                          leak.<br>
                                          <br>
                                          Regards,<br>
                                          Christian.<br>
                                          <br>
                                          Am 18.04.2017 um 17:17 schrieb
                                          Xie, AlexBin:<br>
                                        </div>
                                        <blockquote type="cite">
                                          <div id="divtagdefaultwrapper"
                                            dir="ltr"
                                            style="font-size:12pt;
                                            color:#000000;
                                            font-family:Calibri,Arial,Helvetica,sans-serif">
                                            <p>Hi David,</p>
                                            <p><br>
                                            </p>
                                            <p>When <span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif">amdgpu_bo_reserve
                                                return errors, we cannot
                                                release the BO. This is
                                                not a memory leak.
                                                General speaking, memory
                                                leak is unnoticed and
                                                unintentional.</span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><br>
                                              </span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif">The
                                                caller of function <span>amdgpu_vram_scratch_fini
                                                  ignores the return
                                                  error value...</span></span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                                </span></span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span>The
                                                  "memory leak" is not
                                                  caused by my patch. It
                                                  is caused because
                                                  reserving BO fails.</span></span></p>
                                            <p><span
                                                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                                font-size:12pt"><br>
                                              </span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span></span></span><span
style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt">This patch
                                                only aim to make
                                                function </span><span
                                                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                                font-size:12pt">amdgpu_vram_scratch_fini
                                                behave correctly.</span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                                </span></span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span>To
                                                  follow up, we can add
                                                  a warning message when
                                                  <span
                                                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                                    font-size:16px">amdgpu_bo_reserve</span>
                                                  error happens in a
                                                  different patch.</span></span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                                </span></span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif">If
                                                function call </span><span
style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt">amdgpu_bo_reserve
                                                is changed to
                                                uninterruptible, this
                                                changes driver behaviour.
                                                Without a substantial
                                                issue, I would be
                                                cautious for such a
                                                change.</span></p>
                                            <p><span
                                                style="font-size:12pt;
                                                font-family:Calibri,Arial,Helvetica,sans-serif"><br>
                                              </span></p>
                                            <p>Thanks,</p>
                                            <p>Alex Bin Xie</p>
                                            <br>
                                            <div
                                              style="color:rgb(0,0,0)">
                                              <hr tabindex="-1"
                                                style="display:inline-block;
                                                width:98%">
                                              <div id="divRplyFwdMsg"
                                                dir="ltr"><font
                                                  style="font-size:11pt"
                                                  color="#000000"
                                                  face="Calibri,
                                                  sans-serif"><b>From:</b>
                                                  Zhou, David(ChunMing)<br>
                                                  <b>Sent:</b> Monday,
                                                  April 17, 2017 10:38
                                                  PM<br>
                                                  <b>To:</b> Xie,
                                                  AlexBin; <a
                                                    moz-do-not-send="true"
class="moz-txt-link-abbreviated"
                                                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                                  <b>Subject:</b> Re:
                                                  [PATCH] dmr/amdgpu:
                                                  Fix wrongly unref of
                                                  BO</font>
                                                <div> </div>
                                              </div>
                                              <div><br>
                                                <br>
                                                <div
                                                  class="moz-cite-prefix">On
                                                  2017年04月17日 22:54,
                                                  Xie, AlexBin wrote:<br>
                                                </div>
                                                <blockquote type="cite">
                                                  <div
                                                    id="divtagdefaultwrapper"
                                                    dir="ltr"
                                                    style="font-size:12pt;
                                                    color:#000000;
                                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                                    <p>Hi David,</p>
                                                    <p><br>
                                                    </p>
                                                    <p>Thanks for the
                                                      comments. However,
                                                      please have look
                                                      at <span style="">amdgpu_bo_reserve</span>
                                                      definition.</p>
                                                    <p><span>static
                                                        inline int
                                                        amdgpu_bo_reserve(struct
                                                        amdgpu_bo *bo,
                                                        bool no_intr)</span><br>
                                                    </p>
                                                  </div>
                                                </blockquote>
                                                Ah, this is a wired
                                                wrapper for
                                                ttm_bo_reserve.<br>
                                                <br>
                                                <blockquote type="cite">
                                                  <div
                                                    id="divtagdefaultwrapper"
                                                    dir="ltr"
                                                    style="font-size:12pt;
                                                    color:#000000;
                                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                                    <p><span><br>
                                                      </span></p>
                                                    <p><span>When we
                                                        call this
                                                        function like
                                                        the following:</span></p>
                                                    <p><span><span
                                                          style="">     
                                                             r =
                                                          amdgpu_bo_reserve(adev-&gt;vram_scratch.robj,
                                                          false);</span><br
                                                          style="">
                                                      </span><span
                                                        style="font-size:12pt">The
                                                        false means <span>interruptible</span>.</span><span><br>
                                                      </span></p>
                                                    <p><span
                                                        style="font-size:12pt"><br>
                                                      </span></p>
                                                    <p><span
                                                        style="font-size:12pt">On
                                                        the other hand,
                                                         when <span
                                                          style="">amdgpu_bo_reserve
                                                          function
                                                          return error,
                                                          why do we
                                                          unref BO
                                                          without kunmap
                                                          and unpin the
                                                          BO? This is
                                                          wrong
                                                          implementation when <span
                                                          style="">amdgpu_bo_reserve
                                                          return any
                                                          error.</span></span></span></p>
                                                  </div>
                                                </blockquote>
                                                Yeah, I see your mean,
                                                it's in driver
                                                un-loading, How about
                                                changing to no
                                                interruptible? Your
                                                patch will make a
                                                memleak if bo_reserve
                                                fails, but it seems not
                                                matter. I have no strong
                                                preference.<br>
                                                <br>
                                                Regards,<br>
                                                David Zhou<br>
                                                <blockquote type="cite">
                                                  <div
                                                    id="divtagdefaultwrapper"
                                                    dir="ltr"
                                                    style="font-size:12pt;
                                                    color:#000000;
                                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                                    <p><br>
                                                    </p>
                                                    Thanks,
                                                    <div>Alex Bin Xie<br>
                                                      <br>
                                                      <div
                                                        style="color:rgb(0,0,0)">
                                                        <div>
                                                          <hr
                                                          tabindex="-1"
style="display:inline-block; width:98%">
                                                          <div
                                                          id="x_divRplyFwdMsg"
                                                          dir="ltr"><font
style="font-size:11pt" color="#000000" face="Calibri, sans-serif"><b>From:</b>
                                                          Zhou,
                                                          David(ChunMing)<br>
                                                          <b>Sent:</b>
                                                          Friday, April
                                                          14, 2017 12:00
                                                          AM<br>
                                                          <b>To:</b>
                                                          Xie, AlexBin;
                                                          <a
                                                          moz-do-not-send="true"
class="moz-txt-link-abbreviated"
                                                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                                          <b>Subject:</b>
                                                          Re: [PATCH]
                                                          dmr/amdgpu:
                                                          Fix wrongly
                                                          unref of BO</font>
                                                          <div> </div>
                                                          </div>
                                                        </div>
                                                        <font size="2"><span
style="font-size:10pt">
                                                          <div
                                                          class="PlainText"><br>
                                                          <br>
                                                          On 2017年04月14日
                                                          05:34, Alex
                                                          Xie wrote:<br>
                                                          &gt; According
                                                          to comment of
amdgpu_bo_reserve, amdgpu_bo_reserve<br>
                                                          &gt; can
                                                          return with
                                                          -ERESTARTSYS.
                                                          When this
                                                          function was
                                                          interrupted<br>
                                                          &gt; by a
                                                          signal, BO
                                                          should not be
                                                          unref.
                                                          Otherwise the
                                                          BO might be<br>
                                                          &gt; released
                                                          while is
                                                          kmapped and
                                                          pinned, or BO
                                                          MIGHT be deref<br>
                                                          &gt; multiple
                                                          times, etc.<br>
                                                                   r =
                                                          amdgpu_bo_reserve(adev-&gt;vram_scratch.robj,
                                                          false);<br>
                                                          we have
                                                          specified
                                                          interruptible
                                                          to false, so
                                                          -ERESTARTSYS
                                                          isn't possible
                                                          <br>
                                                          here.<br>
                                                          <br>
                                                          Thanks,<br>
                                                          David Zhou<br>
                                                          &gt;<br>
                                                          &gt;
                                                          Change-Id:
                                                          If76071a768950a0d3ad9d5da7fcae04881807621<br>
                                                          &gt;
                                                          Signed-off-by:
                                                          Alex Xie <a
                                                          moz-do-not-send="true"
class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">
&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                                          &gt; ---<br>
                                                          &gt;  
                                                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                                          | 2 +-<br>
                                                          &gt;   1 file
                                                          changed, 1
                                                          insertion(+),
                                                          1 deletion(-)<br>
                                                          &gt;<br>
                                                          &gt; diff
                                                          --git
                                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                                          &gt; index
                                                          53996e3..1dcc2d1
                                                          100644<br>
                                                          &gt; ---
                                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                                          &gt; +++
                                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                                          &gt; @@ -355,8
                                                          +355,8 @@
                                                          static void
                                                          amdgpu_vram_scratch_fini(struct
                                                          amdgpu_device
                                                          *adev)<br>
&gt;                amdgpu_bo_kunmap(adev-&gt;vram_scratch.robj);<br>
&gt;                amdgpu_bo_unpin(adev-&gt;vram_scratch.robj);<br>
&gt;                amdgpu_bo_unreserve(adev-&gt;vram_scratch.robj);<br>
                                                          &gt;
                                                          +            
amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);<br>
                                                          &gt;        }<br>
                                                          &gt; -    
                                                          amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);<br>
                                                          &gt;   }<br>
                                                          &gt;   <br>
                                                          &gt;   /**<br>
                                                          <br>
                                                          </div>
                                                          </span></font></div>
                                                    </div>
                                                  </div>
                                                </blockquote>
                                                <br>
                                              </div>
                                            </div>
                                          </div>
                                          <br>
                                          <fieldset
                                            class="mimeAttachmentHeader"></fieldset>
                                          <br>
                                          <pre>_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                                        </blockquote>
                                        <p><br>
                                        </p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <br>
                              <fieldset class="mimeAttachmentHeader"></fieldset>
                              <br>
                              <pre>_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                            </blockquote>
                            <p><br>
                            </p>
                          </div>
                        </div>
                      </div>
                      <br>
                      <fieldset class="mimeAttachmentHeader"></fieldset>
                      <br>
                      <pre>_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                    <p><br>
                    </p>
                  </div>
                </div>
              </div>
            </blockquote>
            <p><br>
            </p>
          </div>
        </div>
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

--------------8CEDB8DD76852259471AAC51--

--===============1734377622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1734377622==--
