From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 8/8] drm/amdgpu: implement 2+1 PD support for Raven
Date: Mon, 11 Dec 2017 14:49:03 +0800
Message-ID: <7c8d12b8-7d2e-f5be-b8e7-295245c29a92@amd.com>
References: <20171208164107.1567-1-christian.koenig@amd.com>
 <20171208164107.1567-8-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7CF42466B127F44FAB6ADDF3"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171208164107.1567-8-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

It is a coincidence, I also am trying to implement this, still under debug.

For yours, seems not ready yet, right?
We should handle 64KB native page to 16 * 4KB sub-PTB for TF case, which 
is the only verified option by HW.
For TF case, the number entries and shift of PTB is a bit different from 
normal,  we should count native page size to it.

Regards,
David Zhou

On 2017年12月09日 00:41, Christian König wrote:
> Instead of falling back to 2 level and very limited address space use
> 2+1 PD support and 128TB + 512GB of virtual address space.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 42 ++++++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 26 ++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 49 ++++++++++++++++++++------------
>   5 files changed, 86 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e5e0fbd43273..9517c0f76d27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -541,6 +541,7 @@ struct amdgpu_mc {
>   	u64					private_aperture_end;
>   	/* protects concurrent invalidation */
>   	spinlock_t		invalidate_lock;
> +	bool			translate_further;
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 228f63e9ac5e..79134f0c26d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -69,6 +69,9 @@ struct amdgpu_bo_list_entry;
>   /* PDE is handled as PTE for VEGA10 */
>   #define AMDGPU_PDE_PTE		(1ULL << 54)
>   
> +/* PTE is handled as PDE for VEGA10 */
> +#define AMDGPU_PTE_TRANSLATE_FURTHER	(1ULL << 56)
> +
>   /* VEGA10 only */
>   #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
>   #define AMDGPU_PTE_MTYPE_MASK	AMDGPU_PTE_MTYPE(3ULL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index f1effadfbaa6..a56f77259130 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -144,8 +144,15 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, mmVM_L2_CNTL2, tmp);
>   
>   	tmp = mmVM_L2_CNTL3_DEFAULT;
> -	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
> -	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
> +	if (adev->mc.translate_further) {
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> +				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
> +	} else {
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> +				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
> +	}
>   	WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, tmp);
>   
>   	tmp = mmVM_L2_CNTL4_DEFAULT;
> @@ -183,31 +190,40 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
> -	int i;
> +	unsigned num_level, block_size;
>   	uint32_t tmp;
> +	int i;
> +
> +	num_level = adev->vm_manager.num_level;
> +	block_size = adev->vm_manager.block_size;
> +	if (adev->mc.translate_further)
> +		num_level -= 1;
> +	else
> +		block_size -= 9;
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
> -				    adev->vm_manager.num_level);
> +				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
> +				    1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				PAGE_TABLE_BLOCK_SIZE,
> -				adev->vm_manager.block_size - 9);
> +				    PAGE_TABLE_BLOCK_SIZE,
> +				    block_size);
>   		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>   				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0fe2a4e782ff..d6a19514c92b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -481,6 +481,21 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   		*addr = adev->vm_manager.vram_base_offset + *addr -
>   			adev->mc.vram_start;
>   	BUG_ON(*addr & 0xFFFF00000000003FULL);
> +
> +	if (!adev->mc.translate_further)
> +		return;
> +
> +	if (level == 0) {
> +		/* Set the block size */
> +		if (!(*flags & AMDGPU_PDE_PTE))
> +			*flags |= 9ULL << 59;
> +
> +	} else if (level == 1) {
> +		if (*flags & AMDGPU_PDE_PTE)
> +			*flags &= ~AMDGPU_PDE_PTE;
> +		else
> +			*flags |= AMDGPU_PTE_TRANSLATE_FURTHER;
> +	}
>   }
>   
>   static const struct amdgpu_gart_funcs gmc_v9_0_gart_funcs = {
> @@ -771,11 +786,14 @@ static int gmc_v9_0_sw_init(void *handle)
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
>   		adev->mc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
> -		if (adev->rev_id == 0x0 || adev->rev_id == 0x1)
> +		if (adev->rev_id == 0x0 || adev->rev_id == 0x1) {
>   			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> -		else
> -			/* vm_size is 64GB for legacy 2-level page support */
> -			amdgpu_vm_adjust_size(adev, 64, 9, 1, 48);
> +		} else {
> +			/* vm_size is 128TB + 512GB for legacy 3-level page support */
> +			amdgpu_vm_adjust_size(adev, 128 * 1024 + 512, 9, 2, 48);
> +			adev->mc.translate_further =
> +				adev->vm_manager.num_level > 1;
> +		}
>   		break;
>   	case CHIP_VEGA10:
>   		/* XXX Don't know how to get VRAM type yet. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index bd160d8700e0..a88f43b097dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -156,10 +156,15 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
>   	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);
>   
> -	tmp = mmVM_L2_CNTL3_DEFAULT;
> -	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
> -	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
> -	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL3, tmp);
> +	if (adev->mc.translate_further) {
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> +				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
> +	} else {
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> +				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
> +	}
>   
>   	tmp = mmVM_L2_CNTL4_DEFAULT;
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
> @@ -197,32 +202,40 @@ static void mmhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>   
>   static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   {
> -	int i;
> +	unsigned num_level, block_size;
>   	uint32_t tmp;
> +	int i;
> +
> +	num_level = adev->vm_manager.num_level;
> +	block_size = adev->vm_manager.block_size;
> +	if (adev->mc.translate_further)
> +		num_level -= 1;
> +	else
> +		block_size -= 9;
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
> +		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> +		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
> +				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				ENABLE_CONTEXT, 1);
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				PAGE_TABLE_DEPTH, adev->vm_manager.num_level);
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
> +				    1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> +				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -				PAGE_TABLE_BLOCK_SIZE,
> -				adev->vm_manager.block_size - 9);
> +				    PAGE_TABLE_BLOCK_SIZE,
> +				    block_size);
>   		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>   				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch; name="0008-debug-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0008-debug-1.patch"

>From cd993ed074e81e987342a5918fb86d3af8cc46d1 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 8 Dec 2017 18:48:04 +0800
Subject: [PATCH 8/8] debug 1

Change-Id: I99994f6ecc5cce1f0d35029fe45a5cbaa5b80dd4
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ec4070787996..823c01b0a5dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -101,7 +101,7 @@ int amdgpu_deep_color = 0;
 int amdgpu_vm_size = -1;
 int amdgpu_vm_fragment_size = -1;
 int amdgpu_vm_block_size = -1;
-int amdgpu_vm_translate_further = 0;
+int amdgpu_vm_translate_further = 1;
 int amdgpu_vm_fault_stop = 0;
 int amdgpu_vm_debug = 0;
 int amdgpu_vram_page_split = 512;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e5e1252dfc47..08bc76cf986c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -330,12 +330,15 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 {
 	unsigned native_page = amdgpu_vm_get_native_page(adev);
 	unsigned shift = amdgpu_vm_level_shift(adev, level, native_page,
-					       sub_ptb);
+					       false);
 	unsigned pt_idx, from, to;
 	int r;
 	u64 flags;
 	uint64_t init_value = 0;
 
+	printk("%s************np:%u, saddr:0x%llx, eaddr:0x%llx, level:%u, shift:%u sub_ptb:%u, num_entry:%u\n",
+	       __func__,  native_page, saddr, eaddr, level, shift, sub_ptb,
+	       amdgpu_vm_num_entries(adev, level, native_page, false));
 	BUG_ON(level > adev->vm_manager.num_level);
 
 	if (adev->vm_manager.translate_further && level == 1)
@@ -345,7 +348,7 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 	if (!parent->entries) {
 		unsigned num_entries = amdgpu_vm_num_entries(adev, level,
 							     native_page,
-							     sub_ptb);
+							     false);
 
 		parent->entries = kvmalloc_array(num_entries,
 						   sizeof(struct amdgpu_vm_pt),
@@ -358,9 +361,9 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 	from = saddr >> shift;
 	to = eaddr >> shift;
 	if (from >= amdgpu_vm_num_entries(adev, level, native_page,
-					  sub_ptb) ||
+					  false) ||
 	    to >= amdgpu_vm_num_entries(adev, level, native_page,
-					sub_ptb))
+					false))
 		return -EINVAL;
 
 	if (to > parent->last_entry_used)
@@ -393,6 +396,10 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 		struct amdgpu_vm_pt *entry = &parent->entries[pt_idx];
 		struct amdgpu_bo *pt;
 
+		printk("%s********level:%u, sub_ptb:%u, pt_idx:%u, \
+		       entry->base.bo:%p num_entry:%u\n", __func__,
+		       level, sub_ptb, pt_idx, entry->base.bo,  amdgpu_vm_num_entries(adev, level, native_page,
+							     sub_ptb));
 		if (!entry->base.bo) {
 			r = amdgpu_bo_create(adev,
 					     amdgpu_vm_bo_size(adev, level,
@@ -1378,13 +1385,14 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 	*entry = &p->vm->root;
 	while ((*entry)->entries) {
 		unsigned np = amdgpu_vm_get_native_page(p->adev);
-		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level--,
-							     np, (*entry)->tf);
+		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level,
+							     np, false);
 
-		idx %= amdgpu_vm_num_entries(p->adev, level);
+		idx %= amdgpu_vm_num_entries(p->adev, level, np, (*entry)->tf);
+printk("%s*******addr:0x%llx, level:%u, tf:%u, idx:%u", __func__, addr, level, (*entry)->tf, idx);
 		*parent = *entry;
 		*entry = &(*entry)->entries[idx];
-		if (level)
+		if (level > 0)
 			level--;
 	}
 
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0007-drm-amdgpu-addr-TF-setting-in-PTE.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0007-drm-amdgpu-addr-TF-setting-in-PTE.patch"

>From cefda75a99480d5d6ebf248ccd8cd27e90a83e92 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 18:12:05 +0800
Subject: [PATCH 7/8] drm/amdgpu: addr TF setting in PTE

Change-Id: I8aafeb0b1f51fec66e951fba979a8e02e8bc8c25
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a325a3360894..e5e1252dfc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1199,6 +1199,9 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 			parent->entries[pt_idx].addr |=
 				AMDGPU_PDE_FRAGMENT(parent->entries[pt_idx].native_page);
 		}
+		if (parent->entries[pt_idx].tf) {
+			parent->entries[pt_idx].addr |= AMDGPU_PTE_TF;
+		}
 		pde = pd_addr + pt_idx * 8;
 		incr = amdgpu_bo_size(bo);
 		if (((last_pde + 8 * count) != pde) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 93dc36bf6125..bae3504a1d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -70,6 +70,8 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_PDE_PTE		(1ULL << 54)
 
 /* VEGA10 only */
+/* translate further */
+#define AMDGPU_PTE_TF		(1ULL << 56)
 #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
 #define AMDGPU_PTE_MTYPE_MASK	AMDGPU_PTE_MTYPE(3ULL)
 
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0006-drm-amdgpu-add-VMPT-translate-further-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0006-drm-amdgpu-add-VMPT-translate-further-support.patch"

>From 7878f9126c3c507ca5d73e6fdeaf5288dacf778b Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 17:26:44 +0800
Subject: [PATCH 6/8] drm/amdgpu: add VMPT translate further support

Change-Id: If70c93b635c710e57d33f38151e86b2655c9651d
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77 ++++++++++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +++
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e668f2921fda..a325a3360894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -146,14 +146,17 @@ struct amdgpu_prt_cb {
  * Returns the number of bits the pfn needs to be right shifted for a level.
  */
 static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
-				      unsigned level)
+				      unsigned level, unsigned native_page,
+				      bool tf)
 {
-	if (level != 0)
+	if (tf)
+		return 0;
+	else if (level != 0)
 		return 9 * (level - 1) +
 			adev->vm_manager.block_size;
 	else
 		/* For the page tables on the leaves */
-		return 0;
+		return native_page;
 }
 
 /**
@@ -170,12 +173,17 @@ static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
  * level0 --- PTB
  */
 static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
-				      unsigned level, unsigned native_page)
+				      unsigned level, unsigned native_page,
+				      bool sub_ptb)
 {
 	unsigned shift = amdgpu_vm_level_shift(adev,
-					       adev->vm_manager.num_level);
+					       adev->vm_manager.num_level,
+					       native_page, sub_ptb);
 
-	if (level == adev->vm_manager.num_level)
+	if (sub_ptb)
+		/*for sub ptb */
+		return 1 << native_page;
+	else if (level == adev->vm_manager.num_level)
 		/* For the root directory */
 		return round_up(adev->vm_manager.max_pfn, 1 << shift) >> shift;
 	else if (level != 0)
@@ -194,10 +202,11 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
  * Calculate the size of the BO for a page directory or page table in bytes.
  */
 static unsigned amdgpu_vm_bo_size(struct amdgpu_device *adev, unsigned level,
-				  unsigned native_page)
+				  unsigned native_page, bool sub_ptb)
 {
 	return AMDGPU_GPU_PAGE_ALIGN(amdgpu_vm_num_entries(adev, level,
-							   native_page) * 8);
+							   native_page, sub_ptb)
+				     * 8);
 }
 
 /**
@@ -299,6 +308,10 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	return ready;
 }
 
+static unsigned amdgpu_vm_get_native_page(struct amdgpu_device *adev)
+{
+	return adev->vm_manager.translate_further ? AMDGPU_VM_BIGK : 0;
+}
 /**
  * amdgpu_vm_alloc_levels - allocate the PD/PT levels
  *
@@ -313,9 +326,11 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_vm_pt *parent,
 				  uint64_t saddr, uint64_t eaddr,
-				  unsigned level)
+				  unsigned level, bool sub_ptb)
 {
-	unsigned shift = amdgpu_vm_level_shift(adev, level);
+	unsigned native_page = amdgpu_vm_get_native_page(adev);
+	unsigned shift = amdgpu_vm_level_shift(adev, level, native_page,
+					       sub_ptb);
 	unsigned pt_idx, from, to;
 	int r;
 	u64 flags;
@@ -323,9 +338,14 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 
 	BUG_ON(level > adev->vm_manager.num_level);
 
+	if (adev->vm_manager.translate_further && level == 1)
+		/* hw only verified 64KB---16 4KB for TF */
+		parent->native_page = AMDGPU_VM_BIGK;
+
 	if (!parent->entries) {
 		unsigned num_entries = amdgpu_vm_num_entries(adev, level,
-							     parent->native_page);
+							     native_page,
+							     sub_ptb);
 
 		parent->entries = kvmalloc_array(num_entries,
 						   sizeof(struct amdgpu_vm_pt),
@@ -337,14 +357,17 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 
 	from = saddr >> shift;
 	to = eaddr >> shift;
-	if (from >= amdgpu_vm_num_entries(adev, level, parent->native_page) ||
-	    to >= amdgpu_vm_num_entries(adev, level, parent->native_page))
+	if (from >= amdgpu_vm_num_entries(adev, level, native_page,
+					  sub_ptb) ||
+	    to >= amdgpu_vm_num_entries(adev, level, native_page,
+					sub_ptb))
 		return -EINVAL;
 
 	if (to > parent->last_entry_used)
 		parent->last_entry_used = to;
 
-	level--;
+	if (level > 0)
+		level--;
 	saddr = saddr & ((1 << shift) - 1);
 	eaddr = eaddr & ((1 << shift) - 1);
 
@@ -373,7 +396,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 		if (!entry->base.bo) {
 			r = amdgpu_bo_create(adev,
 					     amdgpu_vm_bo_size(adev, level,
-							       parent->native_page),
+							       native_page,
+							       sub_ptb),
 					     AMDGPU_GPU_PAGE_SIZE, true,
 					     AMDGPU_GEM_DOMAIN_VRAM,
 					     flags,
@@ -403,12 +427,18 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 			entry->addr = 0;
 		}
 
-		if (level > 0) {
+		if (level == 0 && adev->vm_manager.translate_further &&
+		    !sub_ptb)
+			entry->tf = true;
+		else
+			entry->tf = false;
+
+		if (level > 0 || entry->tf) {
 			uint64_t sub_saddr = (pt_idx == from) ? saddr : 0;
 			uint64_t sub_eaddr = (pt_idx == to) ? eaddr :
 				((1 << shift) - 1);
 			r = amdgpu_vm_alloc_levels(adev, vm, entry, sub_saddr,
-						   sub_eaddr, level);
+						   sub_eaddr, level, entry->tf);
 			if (r)
 				return r;
 		}
@@ -450,7 +480,7 @@ int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	return amdgpu_vm_alloc_levels(adev, vm, &vm->root, saddr, eaddr,
-				      adev->vm_manager.num_level);
+				      adev->vm_manager.num_level, false);
 }
 
 /**
@@ -1141,7 +1171,6 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 		params.func = amdgpu_vm_do_set_ptes;
 	}
 
-
 	/* walk over the address space and update the directory */
 	for (pt_idx = 0; pt_idx <= parent->last_entry_used; ++pt_idx) {
 		struct amdgpu_vm_pt *entry = &parent->entries[pt_idx];
@@ -1345,7 +1374,9 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 	*parent = NULL;
 	*entry = &p->vm->root;
 	while ((*entry)->entries) {
-		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level);
+		unsigned np = amdgpu_vm_get_native_page(p->adev);
+		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level--,
+							     np, (*entry)->tf);
 
 		idx %= amdgpu_vm_num_entries(p->adev, level);
 		*parent = *entry;
@@ -1356,6 +1387,8 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 
 	if (level != 0)
 		*entry = NULL;
+	if (p->adev->vm_manager.translate_further && !(*parent)->tf)
+		*entry = NULL;
 }
 
 /**
@@ -2728,8 +2761,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		flags |= (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
 				AMDGPU_GEM_CREATE_SHADOW);
 
-	r = amdgpu_bo_create(adev, amdgpu_vm_bo_size(adev, 0, 0), align, true,
-			     AMDGPU_GEM_DOMAIN_VRAM,
+	r = amdgpu_bo_create(adev, amdgpu_vm_bo_size(adev, 0, 0, false), align,
+			     true, AMDGPU_GEM_DOMAIN_VRAM,
 			     flags,
 			     NULL, NULL, init_pde_value, &vm->root.base.bo);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 34f929bb6b8c..93dc36bf6125 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -122,6 +122,9 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
+/* 64KB native page */
+#define AMDGPU_VM_BIGK 4
+
 /* base structure for tracking BO usage in a VM */
 struct amdgpu_vm_bo_base {
 	/* constant after initialization */
@@ -144,6 +147,8 @@ struct amdgpu_vm_pt {
 
 	/* log2(number of pages) set by PDB0, indicates one PTE presents how many pages */
 	uint64_t			native_page;
+	/* translate further */
+	bool				tf;
 
 	/* array of page tables, one for each directory entry */
 	struct amdgpu_vm_pt		*entries;
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0005-drm-amdgpu-add-kernel-parameter-for-VM-translate-fur.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0005-drm-amdgpu-add-kernel-parameter-for-VM-translate-fur.pa";
	filename*1="tch"

>From cee04e66cf7ac349c999884886bf2c703423c539 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 15:58:20 +0800
Subject: [PATCH 5/8] drm/amdgpu: add kernel parameter for VM translate further

Change-Id: Ie7036f808d9c9e1ea8d994d255945555620194fd
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c56a986a4be2..27b9ebf7f1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -99,6 +99,7 @@ extern int amdgpu_bapm;
 extern int amdgpu_deep_color;
 extern int amdgpu_vm_size;
 extern int amdgpu_vm_block_size;
+extern int amdgpu_vm_translate_further;
 extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
 extern int amdgpu_vm_debug;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 31383e004947..ec4070787996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -101,6 +101,7 @@ int amdgpu_deep_color = 0;
 int amdgpu_vm_size = -1;
 int amdgpu_vm_fragment_size = -1;
 int amdgpu_vm_block_size = -1;
+int amdgpu_vm_translate_further = 0;
 int amdgpu_vm_fault_stop = 0;
 int amdgpu_vm_debug = 0;
 int amdgpu_vram_page_split = 512;
@@ -198,6 +199,9 @@ module_param_named(vm_fragment_size, amdgpu_vm_fragment_size, int, 0444);
 MODULE_PARM_DESC(vm_block_size, "VM page table size in bits (default depending on vm_size)");
 module_param_named(vm_block_size, amdgpu_vm_block_size, int, 0444);
 
+MODULE_PARM_DESC(vm_translate_further, "VM page table translate furhter (0 = disable (default), 1 = enable");
+module_param_named(vm_translate_further, amdgpu_vm_translate_further, int, 0444);
+
 MODULE_PARM_DESC(vm_fault_stop, "Stop on VM fault (0 = never (default), 1 = print first, 2 = always)");
 module_param_named(vm_fault_stop, amdgpu_vm_fault_stop, int, 0444);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 004a797abb30..e668f2921fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2644,8 +2644,15 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
 	else
 		adev->vm_manager.fragment_size = amdgpu_vm_fragment_size;
 
-	DRM_INFO("vm size is %u GB, %u levels, block size is %u-bit, fragment size is %u-bit\n",
+	if (amdgpu_vm_translate_further) {
+		if (adev->asic_type < CHIP_VEGA10)
+			DRM_ERROR("Don't surpport VMPT translate further feature!");
+		else
+			adev->vm_manager.translate_further = true;
+	}
+	DRM_INFO("vm size is %u GB, %u levels, TF:%d, block size is %u-bit, fragment size is %u-bit\n",
 		 vm_size, adev->vm_manager.num_level + 1,
+		 adev->vm_manager.translate_further,
 		 adev->vm_manager.block_size,
 		 adev->vm_manager.fragment_size);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f130c1f3680e..34f929bb6b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -242,6 +242,7 @@ struct amdgpu_vm_manager {
 	uint32_t				num_level;
 	uint32_t				block_size;
 	uint32_t				fragment_size;
+	bool					translate_further;
 	/* vram base address for page table entry  */
 	u64					vram_base_offset;
 	/* vm pte handling */
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0004-drm-amdgpu-set-native-page-in-PDE0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0004-drm-amdgpu-set-native-page-in-PDE0.patch"

>From 08425d15be0802697d7dd1e2bafa832ebda312db Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 15:22:26 +0800
Subject: [PATCH 4/8] drm/amdgpu: set native page in PDE0

Change-Id: If1e12bb721e89cf9c2aacd8d51c93ed8b3dde4b4
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ed825f64259..004a797abb30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1163,7 +1163,13 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 			continue;
 
 		parent->entries[pt_idx].addr = pt | AMDGPU_PTE_VALID;
-
+		if (parent->entries[pt_idx].native_page &&
+		    parent->entries[pt_idx].native_page <= 32) {
+			parent->entries[pt_idx].addr &=
+				~AMDGPU_PDE_FRAGMENT_MASK;
+			parent->entries[pt_idx].addr |=
+				AMDGPU_PDE_FRAGMENT(parent->entries[pt_idx].native_page);
+		}
 		pde = pd_addr + pt_idx * 8;
 		incr = amdgpu_bo_size(bo);
 		if (((last_pde + 8 * count) != pde) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 0fd96d6b5d67..f130c1f3680e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -73,6 +73,9 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
 #define AMDGPU_PTE_MTYPE_MASK	AMDGPU_PTE_MTYPE(3ULL)
 
+#define AMDGPU_PDE_FRAGMENT(a)	((uint64_t)a << 59)
+#define AMDGPU_PDE_FRAGMENT_MASK AMDGPU_PDE_FRAGMENT(32ULL)
+
 /* For Raven */
 #define AMDGPU_MTYPE_CC 2
 
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0003-drm-amdgpu-take-native-page-into-count-PTE-entries.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-drm-amdgpu-take-native-page-into-count-PTE-entries.patc";
	filename*1="h"

>From 6114cb0c23538c7ef32da029b6ac56463692c107 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 14:23:00 +0800
Subject: [PATCH 3/8] drm/amdgpu: take native page into count PTE entries

BLOCK Fragment bits[63:59] of PDE0 presents native page size pointed by its PTEs.

Change-Id: I7af9e111e0df122ed3b38a36e1c50d312f3a6d2f
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  3 +++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index affe64e42cef..9ed825f64259 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -170,7 +170,7 @@ static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
  * level0 --- PTB
  */
 static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
-				      unsigned level)
+				      unsigned level, unsigned native_page)
 {
 	unsigned shift = amdgpu_vm_level_shift(adev,
 					       adev->vm_manager.num_level);
@@ -183,7 +183,7 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
 		return 512;
 	else
 		/* For the page tables on the leaves(PTB) */
-		return AMDGPU_VM_PTE_COUNT(adev);
+		return AMDGPU_VM_PTE_COUNT(adev) >> native_page;
 }
 
 /**
@@ -193,9 +193,11 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
  *
  * Calculate the size of the BO for a page directory or page table in bytes.
  */
-static unsigned amdgpu_vm_bo_size(struct amdgpu_device *adev, unsigned level)
+static unsigned amdgpu_vm_bo_size(struct amdgpu_device *adev, unsigned level,
+				  unsigned native_page)
 {
-	return AMDGPU_GPU_PAGE_ALIGN(amdgpu_vm_num_entries(adev, level) * 8);
+	return AMDGPU_GPU_PAGE_ALIGN(amdgpu_vm_num_entries(adev, level,
+							   native_page) * 8);
 }
 
 /**
@@ -322,7 +324,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 	BUG_ON(level > adev->vm_manager.num_level);
 
 	if (!parent->entries) {
-		unsigned num_entries = amdgpu_vm_num_entries(adev, level);
+		unsigned num_entries = amdgpu_vm_num_entries(adev, level,
+							     parent->native_page);
 
 		parent->entries = kvmalloc_array(num_entries,
 						   sizeof(struct amdgpu_vm_pt),
@@ -334,8 +337,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 
 	from = saddr >> shift;
 	to = eaddr >> shift;
-	if (from >= amdgpu_vm_num_entries(adev, level) ||
-	    to >= amdgpu_vm_num_entries(adev, level))
+	if (from >= amdgpu_vm_num_entries(adev, level, parent->native_page) ||
+	    to >= amdgpu_vm_num_entries(adev, level, parent->native_page))
 		return -EINVAL;
 
 	if (to > parent->last_entry_used)
@@ -369,7 +372,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 
 		if (!entry->base.bo) {
 			r = amdgpu_bo_create(adev,
-					     amdgpu_vm_bo_size(adev, level),
+					     amdgpu_vm_bo_size(adev, level,
+							       parent->native_page),
 					     AMDGPU_GPU_PAGE_SIZE, true,
 					     AMDGPU_GEM_DOMAIN_VRAM,
 					     flags,
@@ -2711,7 +2715,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		flags |= (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
 				AMDGPU_GEM_CREATE_SHADOW);
 
-	r = amdgpu_bo_create(adev, amdgpu_vm_bo_size(adev, 0), align, true,
+	r = amdgpu_bo_create(adev, amdgpu_vm_bo_size(adev, 0, 0), align, true,
 			     AMDGPU_GEM_DOMAIN_VRAM,
 			     flags,
 			     NULL, NULL, init_pde_value, &vm->root.base.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 43ea131dd411..0fd96d6b5d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -139,6 +139,9 @@ struct amdgpu_vm_pt {
 	struct amdgpu_vm_bo_base	base;
 	uint64_t			addr;
 
+	/* log2(number of pages) set by PDB0, indicates one PTE presents how many pages */
+	uint64_t			native_page;
+
 	/* array of page tables, one for each directory entry */
 	struct amdgpu_vm_pt		*entries;
 	unsigned			last_entry_used;
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch;
	name="0002-drm-amdgpu-fix-pte-index-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-fix-pte-index-calculation.patch"

>From 99c061b224128804fd6c2c1850e54716afa75c73 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 8 Dec 2017 18:51:34 +0800
Subject: [PATCH 2/8] drm/amdgpu: fix pte index calculation

Change-Id: I40ecf31ad4b51022a2c0c076ae45188b6e9d63de
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8904ccf78fc9..affe64e42cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1335,11 +1335,13 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 	*parent = NULL;
 	*entry = &p->vm->root;
 	while ((*entry)->entries) {
-		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level--);
+		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level);
 
-		idx %= amdgpu_bo_size((*entry)->base.bo) / 8;
+		idx %= amdgpu_vm_num_entries(p->adev, level);
 		*parent = *entry;
 		*entry = &(*entry)->entries[idx];
+		if (level)
+			level--;
 	}
 
 	if (level != 0)
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/x-patch; name="0001-drm-amdgpu-reverse-PDBs-order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-reverse-PDBs-order.patch"

>From bb3170b6f1324389f38222e36428e923fed431b0 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 7 Dec 2017 13:02:23 +0800
Subject: [PATCH 1/8] drm/amdgpu: reverse PDBs order

The hiberachy of page table is as below, which aligns hw names.
PDB2->PDB1->PDB0->PTB, accordingly:
level3 --- PDB2
level2 --- PDB1
level1 --- PDB0
level0 --- PTB

Change-Id: I2d748e5e96cffe18294c104c4b192d910b2f8e6b
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 37 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3ecdbdfb04dd..8904ccf78fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -148,8 +148,8 @@ struct amdgpu_prt_cb {
 static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
 				      unsigned level)
 {
-	if (level != adev->vm_manager.num_level)
-		return 9 * (adev->vm_manager.num_level - level - 1) +
+	if (level != 0)
+		return 9 * (level - 1) +
 			adev->vm_manager.block_size;
 	else
 		/* For the page tables on the leaves */
@@ -162,20 +162,27 @@ static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  *
  * Calculate the number of entries in a page directory or page table.
+ * The hiberachy of page table is as below, which aligns hw names.
+ * PDB2->PDB1->PDB0->PTB, accordingly:
+ * level3 --- PDB2
+ * level2 --- PDB1
+ * level1 --- PDB0
+ * level0 --- PTB
  */
 static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
 				      unsigned level)
 {
-	unsigned shift = amdgpu_vm_level_shift(adev, 0);
+	unsigned shift = amdgpu_vm_level_shift(adev,
+					       adev->vm_manager.num_level);
 
-	if (level == 0)
+	if (level == adev->vm_manager.num_level)
 		/* For the root directory */
 		return round_up(adev->vm_manager.max_pfn, 1 << shift) >> shift;
-	else if (level != adev->vm_manager.num_level)
+	else if (level != 0)
 		/* Everything in between */
 		return 512;
 	else
-		/* For the page tables on the leaves */
+		/* For the page tables on the leaves(PTB) */
 		return AMDGPU_VM_PTE_COUNT(adev);
 }
 
@@ -312,6 +319,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 	u64 flags;
 	uint64_t init_value = 0;
 
+	BUG_ON(level > adev->vm_manager.num_level);
+
 	if (!parent->entries) {
 		unsigned num_entries = amdgpu_vm_num_entries(adev, level);
 
@@ -332,7 +341,7 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 	if (to > parent->last_entry_used)
 		parent->last_entry_used = to;
 
-	++level;
+	level--;
 	saddr = saddr & ((1 << shift) - 1);
 	eaddr = eaddr & ((1 << shift) - 1);
 
@@ -346,7 +355,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 
 	if (vm->pte_support_ats) {
 		init_value = AMDGPU_PTE_DEFAULT_ATC;
-		if (level != adev->vm_manager.num_level - 1)
+		/* != PDB0 */
+		if (level != 1)
 			init_value |= AMDGPU_PDE_PTE;
 
 	}
@@ -389,7 +399,7 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 			entry->addr = 0;
 		}
 
-		if (level < adev->vm_manager.num_level) {
+		if (level > 0) {
 			uint64_t sub_saddr = (pt_idx == from) ? saddr : 0;
 			uint64_t sub_eaddr = (pt_idx == to) ? eaddr :
 				((1 << shift) - 1);
@@ -435,7 +445,8 @@ int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
-	return amdgpu_vm_alloc_levels(adev, vm, &vm->root, saddr, eaddr, 0);
+	return amdgpu_vm_alloc_levels(adev, vm, &vm->root, saddr, eaddr,
+				      adev->vm_manager.num_level);
 }
 
 /**
@@ -1319,19 +1330,19 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 			 struct amdgpu_vm_pt **entry,
 			 struct amdgpu_vm_pt **parent)
 {
-	unsigned level = 0;
+	unsigned level = p->adev->vm_manager.num_level;
 
 	*parent = NULL;
 	*entry = &p->vm->root;
 	while ((*entry)->entries) {
-		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level++);
+		unsigned idx = addr >> amdgpu_vm_level_shift(p->adev, level--);
 
 		idx %= amdgpu_bo_size((*entry)->base.bo) / 8;
 		*parent = *entry;
 		*entry = &(*entry)->entries[idx];
 	}
 
-	if (level != p->adev->vm_manager.num_level)
+	if (level != 0)
 		*entry = NULL;
 }
 
-- 
2.14.1


--------------7CF42466B127F44FAB6ADDF3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------7CF42466B127F44FAB6ADDF3--
