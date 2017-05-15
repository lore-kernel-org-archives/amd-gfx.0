From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: cleanup adjust_mc_addr handling
Date: Mon, 15 May 2017 11:06:21 +0800
Message-ID: <59191B2D.7000604@amd.com>
References: <1494596880-3968-1-git-send-email-deathsimple@vodafone.de>
 <1494596880-3968-3-git-send-email-deathsimple@vodafone.de>
 <674b18c3-045e-2c77-1349-b1f24e72067c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0870138346=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <674b18c3-045e-2c77-1349-b1f24e72067c-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

--===============0870138346==
Content-Type: multipart/alternative;
	boundary="------------040003080304010106090302"

--------------040003080304010106090302
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年05月13日 02:57, Felix Kuehling wrote:
> Hi Christian,
>
> One comment inline [FK]. If this is not a problem, then feel free to add
> my R-B for the whole series.
>
> Kent, when we adopt this change, we need to convert the PDE back to an
> address, because KFD needs to fill just the page directory base address
> into the map_process HIQ packet. I think the existing
> amdgpu_amdkfd_gpuvm_get_process_page_dir already takes care of that just
> by right-shifting the address.
>
> Regards,
>    Felix
>
> On 17-05-12 09:48 AM, Christian König wrote:
>> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>
>> Rename adjust_mc_addr to get_vm_pde, check the address bits in one place and
>> move setting the valid bit in there as well.
>>
>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  5 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 ++++++++++++----------------------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  5 +----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  |  6 ++++++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  |  8 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  |  8 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 10 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  5 +----
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  | 10 ++--------
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  5 +----
>>   10 files changed, 46 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index fadeb55..bc089eb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -309,8 +309,8 @@ struct amdgpu_gart_funcs {
>>   	/* set pte flags based per asic */
>>   	uint64_t (*get_vm_pte_flags)(struct amdgpu_device *adev,
>>   				     uint32_t flags);
>> -	/* adjust mc addr in fb for APU case */
>> -	u64 (*adjust_mc_addr)(struct amdgpu_device *adev, u64 addr);
>> +	/* get the pde for a given mc addr */
>> +	u64 (*get_vm_pde)(struct amdgpu_device *adev, u64 addr);
>>   	uint32_t (*get_invalidate_req)(unsigned int vm_id);
>>   };
>>   
>> @@ -1816,6 +1816,7 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
>>   #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
>>   #define amdgpu_gart_flush_gpu_tlb(adev, vmid) (adev)->gart.gart_funcs->flush_gpu_tlb((adev), (vmid))
>>   #define amdgpu_gart_set_pte_pde(adev, pt, idx, addr, flags) (adev)->gart.gart_funcs->set_pte_pde((adev), (pt), (idx), (addr), (flags))
>> +#define amdgpu_gart_get_vm_pde(adev, addr) (adev)->gart.gart_funcs->get_vm_pde((adev), (addr))
>>   #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((adev)->vm_manager.vm_pte_funcs->copy_pte((ib), (pe), (src), (count)))
>>   #define amdgpu_vm_write_pte(adev, ib, pe, value, count, incr) ((adev)->vm_manager.vm_pte_funcs->write_pte((ib), (pe), (value), (count), (incr)))
>>   #define amdgpu_vm_set_pte_pde(adev, ib, pe, addr, count, incr, flags) ((adev)->vm_manager.vm_pte_funcs->set_pte_pde((ib), (pe), (addr), (count), (incr), (flags)))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 88420dc..c10f3ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -682,16 +682,6 @@ static bool amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring *ring)
>>   	return false;
>>   }
>>   
>> -static u64 amdgpu_vm_adjust_mc_addr(struct amdgpu_device *adev, u64 mc_addr)
>> -{
>> -	u64 addr = mc_addr;
>> -
>> -	if (adev->gart.gart_funcs->adjust_mc_addr)
>> -		addr = adev->gart.gart_funcs->adjust_mc_addr(adev, addr);
>> -
>> -	return addr;
>> -}
>> -
>>   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>   				  struct amdgpu_job *job)
>>   {
>> @@ -1034,19 +1024,17 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
>>   		    (count == AMDGPU_VM_MAX_UPDATE_SIZE)) {
>>   
>>   			if (count) {
>> -				uint64_t pt_addr =
>> -					amdgpu_vm_adjust_mc_addr(adev, last_pt);
>> +				uint64_t entry;
>>   
>> +				entry = amdgpu_gart_get_vm_pde(adev, last_pt);
>>   				if (shadow)
>>   					amdgpu_vm_do_set_ptes(&params,
>>   							      last_shadow,
>> -							      pt_addr, count,
>> -							      incr,
>> -							      AMDGPU_PTE_VALID);
>> +							      entry, count,
>> +							      incr, 0);
> [FK] For count >=3 this would result in an SDMA_OP_PTEPDE packet with
> flags=0 and the flags included in the address. Could SDMA mask out the
> flags bits from the address before it applies the flags? The SDMA 4.0
> MAS includes pseudo code that looks like it wouldn't.

         5.


                  Generate PTE/PDE

It would work like this in C pseudo code:

For (i = 0; i < count; i++)

{

Write ( Mask | ( Initial Value + ( i * Increment ) ) ) to Dest Addr // 
result is a 64 bit value

Dest Addr += 8 bytes;

}

Yes, it wouldn't.

Regards,
David Zhou

>   But then the flags
> are kind of redundant in the packet.
>
>>   
>>   				amdgpu_vm_do_set_ptes(&params, last_pde,
>> -						      pt_addr, count, incr,
>> -						      AMDGPU_PTE_VALID);
>> +						      entry, count, incr, 0);
>>   			}
>>   
>>   			count = 1;
>> @@ -1059,14 +1047,16 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
>>   	}
>>   
>>   	if (count) {
>> -		uint64_t pt_addr = amdgpu_vm_adjust_mc_addr(adev, last_pt);
>> +		uint64_t entry;
>> +
>> +		entry = amdgpu_gart_get_vm_pde(adev, last_pt);
>>   
>>   		if (vm->root.bo->shadow)
>> -			amdgpu_vm_do_set_ptes(&params, last_shadow, pt_addr,
>> -					      count, incr, AMDGPU_PTE_VALID);
>> +			amdgpu_vm_do_set_ptes(&params, last_shadow, entry,
>> +					      count, incr, 0);
>>   
>> -		amdgpu_vm_do_set_ptes(&params, last_pde, pt_addr,
>> -				      count, incr, AMDGPU_PTE_VALID);
>> +		amdgpu_vm_do_set_ptes(&params, last_pde, entry,
>> +				      count, incr, 0);
>>   	}
>>   
>>   	if (params.ib->length_dw == 0) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 6dc75d2..9e241d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3759,10 +3759,7 @@ static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>   	uint32_t req = ring->adev->gart.gart_funcs->get_invalidate_req(vm_id);
>>   	unsigned eng = ring->vm_inv_eng;
>>   
>> -	pd_addr = ring->adev->gart.gart_funcs->adjust_mc_addr(ring->adev, pd_addr);
>> -	pd_addr = pd_addr | 0x1; /* valid bit */
>> -	/* now only use physical base address of PDE and valid */
>> -	BUG_ON(pd_addr & 0xFFFF00000000003EULL);
>> +	pd_addr = amdgpu_gart_get_vm_pde(ring->adev, pd_addr);
>>   
>>   	gfx_v9_0_write_data_to_reg(ring, usepfp, true,
>>   				   hub->ctx0_ptb_addr_lo32 + (2 * vm_id),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 1e6263a..445f6f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -395,6 +395,11 @@ static uint64_t gmc_v6_0_get_vm_pte_flags(struct amdgpu_device *adev,
>>   	return pte_flag;
>>   }
>>   
>> +static uint64_t gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
>> +{
>> +	return addr | AMDGPU_PTE_VALID;
>> +}
>> +
>>   static void gmc_v6_0_set_fault_enable_default(struct amdgpu_device *adev,
>>   					      bool value)
>>   {
>> @@ -1127,6 +1132,7 @@ static const struct amdgpu_gart_funcs gmc_v6_0_gart_funcs = {
>>   	.flush_gpu_tlb = gmc_v6_0_gart_flush_gpu_tlb,
>>   	.set_pte_pde = gmc_v6_0_gart_set_pte_pde,
>>   	.set_prt = gmc_v6_0_set_prt,
>> +	.get_vm_pde = gmc_v6_0_get_vm_pde,
>>   	.get_vm_pte_flags = gmc_v6_0_get_vm_pte_flags
>>   };
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 967505b..b9d86e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -472,6 +472,11 @@ static uint64_t gmc_v7_0_get_vm_pte_flags(struct amdgpu_device *adev,
>>   	return pte_flag;
>>   }
>>   
>> +static uint64_t gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
>> +{
>> +	return addr | AMDGPU_PTE_VALID;
>> +}
>> +
>>   /**
>>    * gmc_v8_0_set_fault_enable_default - update VM fault handling
>>    *
>> @@ -1293,7 +1298,8 @@ static const struct amdgpu_gart_funcs gmc_v7_0_gart_funcs = {
>>   	.flush_gpu_tlb = gmc_v7_0_gart_flush_gpu_tlb,
>>   	.set_pte_pde = gmc_v7_0_gart_set_pte_pde,
>>   	.set_prt = gmc_v7_0_set_prt,
>> -	.get_vm_pte_flags = gmc_v7_0_get_vm_pte_flags
>> +	.get_vm_pte_flags = gmc_v7_0_get_vm_pte_flags,
>> +	.get_vm_pde = gmc_v7_0_get_vm_pde
>>   };
>>   
>>   static const struct amdgpu_irq_src_funcs gmc_v7_0_irq_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 3b5ea0f..de8bfb6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -656,6 +656,11 @@ static uint64_t gmc_v8_0_get_vm_pte_flags(struct amdgpu_device *adev,
>>   	return pte_flag;
>>   }
>>   
>> +static uint64_t gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
>> +{
>> +	return addr | AMDGPU_PTE_VALID;
>> +}
>> +
>>   /**
>>    * gmc_v8_0_set_fault_enable_default - update VM fault handling
>>    *
>> @@ -1612,7 +1617,8 @@ static const struct amdgpu_gart_funcs gmc_v8_0_gart_funcs = {
>>   	.flush_gpu_tlb = gmc_v8_0_gart_flush_gpu_tlb,
>>   	.set_pte_pde = gmc_v8_0_gart_set_pte_pde,
>>   	.set_prt = gmc_v8_0_set_prt,
>> -	.get_vm_pte_flags = gmc_v8_0_get_vm_pte_flags
>> +	.get_vm_pte_flags = gmc_v8_0_get_vm_pte_flags,
>> +	.get_vm_pde = gmc_v8_0_get_vm_pde
>>   };
>>   
>>   static const struct amdgpu_irq_src_funcs gmc_v8_0_irq_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 19e1027..523157a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -358,17 +358,19 @@ static uint64_t gmc_v9_0_get_vm_pte_flags(struct amdgpu_device *adev,
>>   	return pte_flag;
>>   }
>>   
>> -static u64 gmc_v9_0_adjust_mc_addr(struct amdgpu_device *adev, u64 mc_addr)
>> +static u64 gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, u64 addr)
>>   {
>> -	return adev->vm_manager.vram_base_offset + mc_addr - adev->mc.vram_start;
>> +	addr = adev->vm_manager.vram_base_offset + addr - adev->mc.vram_start;
>> +	BUG_ON(addr & 0xFFFF00000000003FULL);
>> +	return addr | AMDGPU_PTE_VALID;
>>   }
>>   
>>   static const struct amdgpu_gart_funcs gmc_v9_0_gart_funcs = {
>>   	.flush_gpu_tlb = gmc_v9_0_gart_flush_gpu_tlb,
>>   	.set_pte_pde = gmc_v9_0_gart_set_pte_pde,
>> -	.get_vm_pte_flags = gmc_v9_0_get_vm_pte_flags,
>> -	.adjust_mc_addr = gmc_v9_0_adjust_mc_addr,
>>   	.get_invalidate_req = gmc_v9_0_get_invalidate_req,
>> +	.get_vm_pte_flags = gmc_v9_0_get_vm_pte_flags,
>> +	.get_vm_pde = gmc_v9_0_get_vm_pde
>>   };
>>   
>>   static void gmc_v9_0_set_gart_funcs(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 91cf7e6..af98ed2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -1143,10 +1143,7 @@ static void sdma_v4_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>   	uint32_t req = ring->adev->gart.gart_funcs->get_invalidate_req(vm_id);
>>   	unsigned eng = ring->vm_inv_eng;
>>   
>> -	pd_addr = ring->adev->gart.gart_funcs->adjust_mc_addr(ring->adev, pd_addr);
>> -	pd_addr = pd_addr | 0x1; /* valid bit */
>> -	/* now only use physical base address of PDE and valid */
>> -	BUG_ON(pd_addr & 0xFFFF00000000003EULL);
>> +	pd_addr = amdgpu_gart_get_vm_pde(ring->adev, pd_addr);
>>   
>>   	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_SRBM_WRITE) |
>>   			  SDMA_PKT_SRBM_WRITE_HEADER_BYTE_EN(0xf));
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index 22f42f3..c8f4c34 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -1316,10 +1316,7 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>   	uint32_t data0, data1, mask;
>>   	unsigned eng = ring->vm_inv_eng;
>>   
>> -	pd_addr = ring->adev->gart.gart_funcs->adjust_mc_addr(ring->adev, pd_addr);
>> -	pd_addr = pd_addr | 0x1; /* valid bit */
>> -	/* now only use physical base address of PDE and valid */
>> -	BUG_ON(pd_addr & 0xFFFF00000000003EULL);
>> +	pd_addr = amdgpu_gart_get_vm_pde(ring->adev, pd_addr);
>>   
>>   	data0 = (hub->ctx0_ptb_addr_hi32 + vm_id * 2) << 2;
>>   	data1 = upper_32_bits(pd_addr);
>> @@ -1358,10 +1355,7 @@ static void uvd_v7_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>   	uint32_t req = ring->adev->gart.gart_funcs->get_invalidate_req(vm_id);
>>   	unsigned eng = ring->vm_inv_eng;
>>   
>> -	pd_addr = ring->adev->gart.gart_funcs->adjust_mc_addr(ring->adev, pd_addr);
>> -	pd_addr = pd_addr | 0x1; /* valid bit */
>> -	/* now only use physical base address of PDE and valid */
>> -	BUG_ON(pd_addr & 0xFFFF00000000003EULL);
>> +	pd_addr = amdgpu_gart_get_vm_pde(ring->adev, pd_addr);
>>   
>>   	amdgpu_ring_write(ring, HEVC_ENC_CMD_REG_WRITE);
>>   	amdgpu_ring_write(ring,	(hub->ctx0_ptb_addr_hi32 + vm_id * 2) << 2);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 07b2ac7..b1bda0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -926,10 +926,7 @@ static void vce_v4_0_emit_vm_flush(struct amdgpu_ring *ring,
>>   	uint32_t req = ring->adev->gart.gart_funcs->get_invalidate_req(vm_id);
>>   	unsigned eng = ring->vm_inv_eng;
>>   
>> -	pd_addr = ring->adev->gart.gart_funcs->adjust_mc_addr(ring->adev, pd_addr);
>> -	pd_addr = pd_addr | 0x1; /* valid bit */
>> -	/* now only use physical base address of PDE and valid */
>> -	BUG_ON(pd_addr & 0xFFFF00000000003EULL);
>> +	pd_addr = amdgpu_gart_get_vm_pde(ring->adev, pd_addr);
>>   
>>   	amdgpu_ring_write(ring, VCE_CMD_REG_WRITE);
>>   	amdgpu_ring_write(ring,	(hub->ctx0_ptb_addr_hi32 + vm_id * 2) << 2);
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------040003080304010106090302
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年05月13日 02:57, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote cite="mid:674b18c3-045e-2c77-1349-b1f24e72067c-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">Hi Christian,

One comment inline [FK]. If this is not a problem, then feel free to add
my R-B for the whole series.

Kent, when we adopt this change, we need to convert the PDE back to an
address, because KFD needs to fill just the page directory base address
into the map_process HIQ packet. I think the existing
amdgpu_amdkfd_gpuvm_get_process_page_dir already takes care of that just
by right-shifting the address.

Regards,
  Felix

On 17-05-12 09:48 AM, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>

Rename adjust_mc_addr to get_vm_pde, check the address bits in one place and
move setting the valid bit in there as well.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 ++++++++++++----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  5 +----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  5 +----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  5 +----
 10 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fadeb55..bc089eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -309,8 +309,8 @@ struct amdgpu_gart_funcs {
 	/* set pte flags based per asic */
 	uint64_t (*get_vm_pte_flags)(struct amdgpu_device *adev,
 				     uint32_t flags);
-	/* adjust mc addr in fb for APU case */
-	u64 (*adjust_mc_addr)(struct amdgpu_device *adev, u64 addr);
+	/* get the pde for a given mc addr */
+	u64 (*get_vm_pde)(struct amdgpu_device *adev, u64 addr);
 	uint32_t (*get_invalidate_req)(unsigned int vm_id);
 };
 
@@ -1816,6 +1816,7 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
 #define amdgpu_asic_get_config_memsize(adev) (adev)-&gt;asic_funcs-&gt;get_config_memsize((adev))
 #define amdgpu_gart_flush_gpu_tlb(adev, vmid) (adev)-&gt;gart.gart_funcs-&gt;flush_gpu_tlb((adev), (vmid))
 #define amdgpu_gart_set_pte_pde(adev, pt, idx, addr, flags) (adev)-&gt;gart.gart_funcs-&gt;set_pte_pde((adev), (pt), (idx), (addr), (flags))
+#define amdgpu_gart_get_vm_pde(adev, addr) (adev)-&gt;gart.gart_funcs-&gt;get_vm_pde((adev), (addr))
 #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;copy_pte((ib), (pe), (src), (count)))
 #define amdgpu_vm_write_pte(adev, ib, pe, value, count, incr) ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;write_pte((ib), (pe), (value), (count), (incr)))
 #define amdgpu_vm_set_pte_pde(adev, ib, pe, addr, count, incr, flags) ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;set_pte_pde((ib), (pe), (addr), (count), (incr), (flags)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88420dc..c10f3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -682,16 +682,6 @@ static bool amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring *ring)
 	return false;
 }
 
-static u64 amdgpu_vm_adjust_mc_addr(struct amdgpu_device *adev, u64 mc_addr)
-{
-	u64 addr = mc_addr;
-
-	if (adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr)
-		addr = adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(adev, addr);
-
-	return addr;
-}
-
 bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job)
 {
@@ -1034,19 +1024,17 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 		    (count == AMDGPU_VM_MAX_UPDATE_SIZE)) {
 
 			if (count) {
-				uint64_t pt_addr =
-					amdgpu_vm_adjust_mc_addr(adev, last_pt);
+				uint64_t entry;
 
+				entry = amdgpu_gart_get_vm_pde(adev, last_pt);
 				if (shadow)
 					amdgpu_vm_do_set_ptes(&amp;params,
 							      last_shadow,
-							      pt_addr, count,
-							      incr,
-							      AMDGPU_PTE_VALID);
+							      entry, count,
+							      incr, 0);
</pre>
      </blockquote>
      <pre wrap="">
[FK] For count &gt;=3 this would result in an SDMA_OP_PTEPDE packet with
flags=0 and the flags included in the address. Could SDMA mask out the
flags bits from the address before it applies the flags? The SDMA 4.0
MAS includes pseudo code that looks like it wouldn't.</pre>
    </blockquote>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <ol>
      <ol>
        <ol start="5">
          <li>
            <h3 class="western"><a name="_Toc415065276"></a>Generate
              PTE/PDE</h3>
          </li>
        </ol>
      </ol>
    </ol>
    <p class="western" style="line-height: 100%"><font color="#000000">It
would
        work like this in C pseudo code:</font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">For
(i
        = 0; i &lt; count; i++)</font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">{</font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">               
Write
        ( Mask | ( Initial Value + ( i * Increment ) ) ) to Dest Addr 
        // result is a 64 bit value</font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">               
Dest
        Addr += 8 bytes;</font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">}<br>
      </font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">Yes,
        it wouldn't.<br>
      </font></p>
    <p class="western" style="line-height: 100%"><font color="#000000">Regards,<br>
        David Zhou<br>
      </font></p>
    <title></title>
    <meta name="generator" content="LibreOffice 4.2.7.2 (Linux)">
    <style type="text/css">
	<!--
		@page { margin: 0.79in }
		h3 { margin-top: 0in; margin-bottom: 0in; direction: ltr; color: #000000; text-align: left; widows: 2; orphans: 2; page-break-after: auto }
		h3.western { font-family: "Times New Roman", serif; font-size: 12pt }
		h3.cjk { font-family: "Droid Sans Fallback"; font-size: 12pt; so-language: en-US }
		h3.ctl { font-family: "Times New Roman"; font-size: 10pt; font-weight: normal }
		p { margin-bottom: 0in; direction: ltr; color: #000000; line-height: 120%; text-align: left; widows: 2; orphans: 2 }
		p.western { font-family: "Times New Roman", serif }
		p.cjk { so-language: en-US }
		a:link { color: #0000ff; so-language: zxx }
	-->
	</style>
    <blockquote cite="mid:674b18c3-045e-2c77-1349-b1f24e72067c-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap=""> But then the flags
are kind of redundant in the packet.

</pre>
      <blockquote type="cite">
        <pre wrap=""> 
 				amdgpu_vm_do_set_ptes(&amp;params, last_pde,
-						      pt_addr, count, incr,
-						      AMDGPU_PTE_VALID);
+						      entry, count, incr, 0);
 			}
 
 			count = 1;
@@ -1059,14 +1047,16 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 	}
 
 	if (count) {
-		uint64_t pt_addr = amdgpu_vm_adjust_mc_addr(adev, last_pt);
+		uint64_t entry;
+
+		entry = amdgpu_gart_get_vm_pde(adev, last_pt);
 
 		if (vm-&gt;root.bo-&gt;shadow)
-			amdgpu_vm_do_set_ptes(&amp;params, last_shadow, pt_addr,
-					      count, incr, AMDGPU_PTE_VALID);
+			amdgpu_vm_do_set_ptes(&amp;params, last_shadow, entry,
+					      count, incr, 0);
 
-		amdgpu_vm_do_set_ptes(&amp;params, last_pde, pt_addr,
-				      count, incr, AMDGPU_PTE_VALID);
+		amdgpu_vm_do_set_ptes(&amp;params, last_pde, entry,
+				      count, incr, 0);
 	}
 
 	if (params.ib-&gt;length_dw == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6dc75d2..9e241d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3759,10 +3759,7 @@ static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t req = ring-&gt;adev-&gt;gart.gart_funcs-&gt;get_invalidate_req(vm_id);
 	unsigned eng = ring-&gt;vm_inv_eng;
 
-	pd_addr = ring-&gt;adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(ring-&gt;adev, pd_addr);
-	pd_addr = pd_addr | 0x1; /* valid bit */
-	/* now only use physical base address of PDE and valid */
-	BUG_ON(pd_addr &amp; 0xFFFF00000000003EULL);
+	pd_addr = amdgpu_gart_get_vm_pde(ring-&gt;adev, pd_addr);
 
 	gfx_v9_0_write_data_to_reg(ring, usepfp, true,
 				   hub-&gt;ctx0_ptb_addr_lo32 + (2 * vm_id),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 1e6263a..445f6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -395,6 +395,11 @@ static uint64_t gmc_v6_0_get_vm_pte_flags(struct amdgpu_device *adev,
 	return pte_flag;
 }
 
+static uint64_t gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
+{
+	return addr | AMDGPU_PTE_VALID;
+}
+
 static void gmc_v6_0_set_fault_enable_default(struct amdgpu_device *adev,
 					      bool value)
 {
@@ -1127,6 +1132,7 @@ static const struct amdgpu_gart_funcs gmc_v6_0_gart_funcs = {
 	.flush_gpu_tlb = gmc_v6_0_gart_flush_gpu_tlb,
 	.set_pte_pde = gmc_v6_0_gart_set_pte_pde,
 	.set_prt = gmc_v6_0_set_prt,
+	.get_vm_pde = gmc_v6_0_get_vm_pde,
 	.get_vm_pte_flags = gmc_v6_0_get_vm_pte_flags
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 967505b..b9d86e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -472,6 +472,11 @@ static uint64_t gmc_v7_0_get_vm_pte_flags(struct amdgpu_device *adev,
 	return pte_flag;
 }
 
+static uint64_t gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
+{
+	return addr | AMDGPU_PTE_VALID;
+}
+
 /**
  * gmc_v8_0_set_fault_enable_default - update VM fault handling
  *
@@ -1293,7 +1298,8 @@ static const struct amdgpu_gart_funcs gmc_v7_0_gart_funcs = {
 	.flush_gpu_tlb = gmc_v7_0_gart_flush_gpu_tlb,
 	.set_pte_pde = gmc_v7_0_gart_set_pte_pde,
 	.set_prt = gmc_v7_0_set_prt,
-	.get_vm_pte_flags = gmc_v7_0_get_vm_pte_flags
+	.get_vm_pte_flags = gmc_v7_0_get_vm_pte_flags,
+	.get_vm_pde = gmc_v7_0_get_vm_pde
 };
 
 static const struct amdgpu_irq_src_funcs gmc_v7_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 3b5ea0f..de8bfb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -656,6 +656,11 @@ static uint64_t gmc_v8_0_get_vm_pte_flags(struct amdgpu_device *adev,
 	return pte_flag;
 }
 
+static uint64_t gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, uint64_t addr)
+{
+	return addr | AMDGPU_PTE_VALID;
+}
+
 /**
  * gmc_v8_0_set_fault_enable_default - update VM fault handling
  *
@@ -1612,7 +1617,8 @@ static const struct amdgpu_gart_funcs gmc_v8_0_gart_funcs = {
 	.flush_gpu_tlb = gmc_v8_0_gart_flush_gpu_tlb,
 	.set_pte_pde = gmc_v8_0_gart_set_pte_pde,
 	.set_prt = gmc_v8_0_set_prt,
-	.get_vm_pte_flags = gmc_v8_0_get_vm_pte_flags
+	.get_vm_pte_flags = gmc_v8_0_get_vm_pte_flags,
+	.get_vm_pde = gmc_v8_0_get_vm_pde
 };
 
 static const struct amdgpu_irq_src_funcs gmc_v8_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 19e1027..523157a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -358,17 +358,19 @@ static uint64_t gmc_v9_0_get_vm_pte_flags(struct amdgpu_device *adev,
 	return pte_flag;
 }
 
-static u64 gmc_v9_0_adjust_mc_addr(struct amdgpu_device *adev, u64 mc_addr)
+static u64 gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, u64 addr)
 {
-	return adev-&gt;vm_manager.vram_base_offset + mc_addr - adev-&gt;mc.vram_start;
+	addr = adev-&gt;vm_manager.vram_base_offset + addr - adev-&gt;mc.vram_start;
+	BUG_ON(addr &amp; 0xFFFF00000000003FULL);
+	return addr | AMDGPU_PTE_VALID;
 }
 
 static const struct amdgpu_gart_funcs gmc_v9_0_gart_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_gart_flush_gpu_tlb,
 	.set_pte_pde = gmc_v9_0_gart_set_pte_pde,
-	.get_vm_pte_flags = gmc_v9_0_get_vm_pte_flags,
-	.adjust_mc_addr = gmc_v9_0_adjust_mc_addr,
 	.get_invalidate_req = gmc_v9_0_get_invalidate_req,
+	.get_vm_pte_flags = gmc_v9_0_get_vm_pte_flags,
+	.get_vm_pde = gmc_v9_0_get_vm_pde
 };
 
 static void gmc_v9_0_set_gart_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 91cf7e6..af98ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1143,10 +1143,7 @@ static void sdma_v4_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t req = ring-&gt;adev-&gt;gart.gart_funcs-&gt;get_invalidate_req(vm_id);
 	unsigned eng = ring-&gt;vm_inv_eng;
 
-	pd_addr = ring-&gt;adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(ring-&gt;adev, pd_addr);
-	pd_addr = pd_addr | 0x1; /* valid bit */
-	/* now only use physical base address of PDE and valid */
-	BUG_ON(pd_addr &amp; 0xFFFF00000000003EULL);
+	pd_addr = amdgpu_gart_get_vm_pde(ring-&gt;adev, pd_addr);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_SRBM_WRITE) |
 			  SDMA_PKT_SRBM_WRITE_HEADER_BYTE_EN(0xf));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 22f42f3..c8f4c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1316,10 +1316,7 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t data0, data1, mask;
 	unsigned eng = ring-&gt;vm_inv_eng;
 
-	pd_addr = ring-&gt;adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(ring-&gt;adev, pd_addr);
-	pd_addr = pd_addr | 0x1; /* valid bit */
-	/* now only use physical base address of PDE and valid */
-	BUG_ON(pd_addr &amp; 0xFFFF00000000003EULL);
+	pd_addr = amdgpu_gart_get_vm_pde(ring-&gt;adev, pd_addr);
 
 	data0 = (hub-&gt;ctx0_ptb_addr_hi32 + vm_id * 2) &lt;&lt; 2;
 	data1 = upper_32_bits(pd_addr);
@@ -1358,10 +1355,7 @@ static void uvd_v7_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t req = ring-&gt;adev-&gt;gart.gart_funcs-&gt;get_invalidate_req(vm_id);
 	unsigned eng = ring-&gt;vm_inv_eng;
 
-	pd_addr = ring-&gt;adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(ring-&gt;adev, pd_addr);
-	pd_addr = pd_addr | 0x1; /* valid bit */
-	/* now only use physical base address of PDE and valid */
-	BUG_ON(pd_addr &amp; 0xFFFF00000000003EULL);
+	pd_addr = amdgpu_gart_get_vm_pde(ring-&gt;adev, pd_addr);
 
 	amdgpu_ring_write(ring, HEVC_ENC_CMD_REG_WRITE);
 	amdgpu_ring_write(ring,	(hub-&gt;ctx0_ptb_addr_hi32 + vm_id * 2) &lt;&lt; 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 07b2ac7..b1bda0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -926,10 +926,7 @@ static void vce_v4_0_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t req = ring-&gt;adev-&gt;gart.gart_funcs-&gt;get_invalidate_req(vm_id);
 	unsigned eng = ring-&gt;vm_inv_eng;
 
-	pd_addr = ring-&gt;adev-&gt;gart.gart_funcs-&gt;adjust_mc_addr(ring-&gt;adev, pd_addr);
-	pd_addr = pd_addr | 0x1; /* valid bit */
-	/* now only use physical base address of PDE and valid */
-	BUG_ON(pd_addr &amp; 0xFFFF00000000003EULL);
+	pd_addr = amdgpu_gart_get_vm_pde(ring-&gt;adev, pd_addr);
 
 	amdgpu_ring_write(ring, VCE_CMD_REG_WRITE);
 	amdgpu_ring_write(ring,	(hub-&gt;ctx0_ptb_addr_hi32 + vm_id * 2) &lt;&lt; 2);
</pre>
      </blockquote>
      <pre wrap="">
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040003080304010106090302--

--===============0870138346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0870138346==--
