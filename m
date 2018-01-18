From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 14/21] drm/amdgpu: add new amdgpu_gmc_emit_flush_gpu_tlb
 callback
Date: Thu, 18 Jan 2018 15:08:39 +0800
Message-ID: <db8d7b0d-bb67-e5fe-299e-a334e483bd19@amd.com>
References: <20180116194017.39067-1-christian.koenig@amd.com>
 <20180116194017.39067-14-christian.koenig@amd.com>
 <abf156ad-44a7-fe7f-12b0-3c1a77757fbd@amd.com>
 <2d56c566-9a4d-924e-6542-1e406ce1776a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F7635B3D2C0114CEA16D4240"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2d56c566-9a4d-924e-6542-1e406ce1776a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------F7635B3D2C0114CEA16D4240
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年01月17日 20:19, Christian König wrote:
> Am 17.01.2018 um 07:24 schrieb Chunming Zhou:
>> I'm not sure if this is a good ongoing, as I know, our per IP 
>> topology is intended for every generation asic bringup.
>
> Actually the intention goes beyond that, e.g. we want to reuse IPs for 
> newer ASICs as well when they haven't changed.
>
>>
>> I think there are many similar logics which we can abstract, but we 
>> don't do that.
>>
>> For emit_wreg above patches, they only can be used by vm flush part, 
>> but they are common func fallback.
>>
>> Can we only make emit_wreg as static in their files, and replace 
>> every where they are used?
>
> Not sure what you are suggesting here?
my mean is like the attached, only abstract them in file per ip.

Regards,
David Zhou
>
> Regards,
> Christian.
>
>>
>> Regards,
>> David Zhou
>> On 2018年01月17日 03:40, Christian König wrote:
>>> Add a new GMC function to unify vm flushing.
>>>
>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 93eae393b08d..230826718c98 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1779,6 +1779,7 @@ amdgpu_get_sdma_instance(struct amdgpu_ring 
>>> *ring)
>>>   #define amdgpu_asic_flush_hdp(adev) 
>>> (adev)->asic_funcs->flush_hdp((adev))
>>>   #define amdgpu_asic_invalidate_hdp(adev) 
>>> (adev)->asic_funcs->invalidate_hdp((adev))
>>>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid) 
>>> (adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid))
>>> +#define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, pasid, addr) 
>>> (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (pasid), 
>>> (addr))
>>>   #define amdgpu_gmc_set_pte_pde(adev, pt, idx, addr, flags) 
>>> (adev)->gmc.gmc_funcs->set_pte_pde((adev), (pt), (idx), (addr), 
>>> (flags))
>>>   #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) 
>>> (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
>>>   #define amdgpu_gmc_get_pte_flags(adev, flags) 
>>> (adev)->gmc.gmc_funcs->get_vm_pte_flags((adev),(flags))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index a4a8374f7f3f..114350a4693f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -52,6 +52,9 @@ struct amdgpu_gmc_funcs {
>>>       /* flush the vm tlb via mmio */
>>>       void (*flush_gpu_tlb)(struct amdgpu_device *adev,
>>>                     uint32_t vmid);
>>> +    /* flush the vm tlb via ring */
>>> +    uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, 
>>> unsigned vmid,
>>> +                       unsigned pasid, uint64_t pd_addr);
>>>       /* write pte/pde updates using the cpu */
>>>       int (*set_pte_pde)(struct amdgpu_device *adev,
>>>                  void *cpu_pt_addr, /* cpu addr of page table */
>>
>


--------------F7635B3D2C0114CEA16D4240
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-abstract-write-data-packet-for-gfx8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-abstract-write-data-packet-for-gfx8.patch"

>From ce20fa3aba41605e7a5001e08a0e97a5fa1f4cff Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 18 Jan 2018 15:05:59 +0800
Subject: [PATCH] drm/amdgpu: abstract write data packet for gfx8

Change-Id: I1512225e94b4875b9c59fcaf1bff818922dbdd7c
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 153 +++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 3fd7eb2a9a7b..9ba4aae128d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -675,6 +675,24 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev);
 static void gfx_v8_0_ring_emit_ce_meta(struct amdgpu_ring *ring);
 static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 
+struct gfx8_write_data {
+	uint32_t n;
+	uint32_t control;
+	uint64_t reg;
+	uint32_t val;
+};
+
+static void gfx_v8_0_ring_write_data(struct amdgpu_ring *ring,
+				     struct gfx8_write_data *wd)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, wd->n));
+	amdgpu_ring_write(ring, wd->control);
+	amdgpu_ring_write(ring, lower_32_bits(wd->reg));
+	amdgpu_ring_write(ring, upper_32_bits(wd->reg));
+	amdgpu_ring_write(ring, wd->val);
+}
+
+
 static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
@@ -5340,6 +5358,8 @@ static void gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 					  uint32_t gws_base, uint32_t gws_size,
 					  uint32_t oa_base, uint32_t oa_size)
 {
+	struct gfx8_write_data wd;
+
 	gds_base = gds_base >> AMDGPU_GDS_SHIFT;
 	gds_size = gds_size >> AMDGPU_GDS_SHIFT;
 
@@ -5350,36 +5370,32 @@ static void gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 	oa_size = oa_size >> AMDGPU_OA_SHIFT;
 
 	/* GDS Base */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				WRITE_DATA_DST_SEL(0)));
-	amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].mem_base);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, gds_base);
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(0) |	WRITE_DATA_DST_SEL(0);
+	wd.reg = amdgpu_gds_reg_offset[vmid].mem_base;
+	wd.val = gds_base;
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	/* GDS Size */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				WRITE_DATA_DST_SEL(0)));
-	amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].mem_size);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, gds_size);
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(0) |	WRITE_DATA_DST_SEL(0);
+	wd.reg = amdgpu_gds_reg_offset[vmid].mem_size;
+	wd.val = gds_size;
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	/* GWS */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				WRITE_DATA_DST_SEL(0)));
-	amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].gws);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, gws_size << GDS_GWS_VMID0__SIZE__SHIFT | gws_base);
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(0) |	WRITE_DATA_DST_SEL(0);
+	wd.reg = amdgpu_gds_reg_offset[vmid].gws;
+	wd.val = gws_size << GDS_GWS_VMID0__SIZE__SHIFT | gws_base;
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	/* OA */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				WRITE_DATA_DST_SEL(0)));
-	amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].oa);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 << oa_base));
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(0) |	WRITE_DATA_DST_SEL(0);
+	wd.reg = amdgpu_gds_reg_offset[vmid].oa;
+	wd.val = (1 << (oa_size + oa_base)) - (1 << oa_base);
+	gfx_v8_0_ring_write_data(ring, &wd);
 }
 
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
@@ -6233,14 +6249,14 @@ static void gfx_v8_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
 
 static void gfx_v8_0_ring_emit_hdp_invalidate(struct amdgpu_ring *ring)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				 WRITE_DATA_DST_SEL(0) |
-				 WR_CONFIRM));
-	amdgpu_ring_write(ring, mmHDP_DEBUG0);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, 1);
-
+	struct gfx8_write_data wd = {
+		.n = 3,
+		.control = WRITE_DATA_ENGINE_SEL(0) | WRITE_DATA_DST_SEL(0) |
+			WR_CONFIRM,
+		.reg = mmHDP_DEBUG0,
+		.val = 1
+	};
+	gfx_v8_0_ring_write_data(ring, &wd);
 }
 
 static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
@@ -6332,29 +6348,24 @@ static void gfx_v8_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					uint64_t pd_addr)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	struct gfx8_write_data wd;
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(usepfp) |
-				 WRITE_DATA_DST_SEL(0)) |
-				 WR_CONFIRM);
-	if (vmid < 8) {
-		amdgpu_ring_write(ring,
-				  (mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR + vmid));
-	} else {
-		amdgpu_ring_write(ring,
-				  (mmVM_CONTEXT8_PAGE_TABLE_BASE_ADDR + vmid - 8));
-	}
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, pd_addr >> 12);
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(usepfp) | WRITE_DATA_DST_SEL(0) |
+		WR_CONFIRM;
+	wd.reg = vmid < 8 ? mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR + vmid :
+		mmVM_CONTEXT8_PAGE_TABLE_BASE_ADDR + vmid;
+	wd.val = pd_addr >> 12;
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	/* bits 0-15 are the VM contexts0-15 */
 	/* invalidate the cache */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				 WRITE_DATA_DST_SEL(0)));
-	amdgpu_ring_write(ring, mmVM_INVALIDATE_REQUEST);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, 1 << vmid);
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(usepfp) | WRITE_DATA_DST_SEL(0) |
+		WR_CONFIRM;
+	wd.reg = mmVM_INVALIDATE_REQUEST;
+	wd.val = 1 << vmid;
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	/* wait for the invalidate to complete */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
@@ -6501,7 +6512,8 @@ static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 				 EOP_TC_WB_ACTION_EN |
 				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
 				 EVENT_INDEX(5)));
-	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
+	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) |
+			  INT_SEL(int_sel ? 2 : 0));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -6511,25 +6523,26 @@ static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 					 u64 seq, unsigned int flags)
 {
+	struct gfx8_write_data wd;
 	/* we only allocate 32bit for each seq wb address */
 	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	/* write fence seq to the "addr" */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
+	wd.n = 3;
+	wd.control = WRITE_DATA_ENGINE_SEL(0) | WRITE_DATA_DST_SEL(5) |
+		WR_CONFIRM;
+	wd.reg = addr;
+	wd.val = lower_32_bits(seq);
+	gfx_v8_0_ring_write_data(ring, &wd);
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* set register to trigger INT */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-		amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-					 WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
-		amdgpu_ring_write(ring, mmCPC_INT_STATUS);
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
+		wd.n = 3;
+		wd.control = WRITE_DATA_ENGINE_SEL(0) | WRITE_DATA_DST_SEL(0) |
+			WR_CONFIRM;
+		wd.reg = mmCPC_INT_STATUS;
+		wd.val = 0X20000000;
+		gfx_v8_0_ring_write_data(ring, &wd);
 	}
 }
 
@@ -6618,11 +6631,13 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 				  uint32_t val)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (1 << 16)); /* no inc addr */
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, val);
+	struct gfx8_write_data wd = {
+	.n = 3,
+	.control = 1 << 16,
+	.reg = reg,
+	.val = val
+	};
+	gfx_v8_0_ring_write_data(ring, &wd);
 }
 
 static void gfx_v8_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
-- 
2.14.1


--------------F7635B3D2C0114CEA16D4240
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------F7635B3D2C0114CEA16D4240--
