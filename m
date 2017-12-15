From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: implement 2+1 PD support for Raven v2
Date: Fri, 15 Dec 2017 15:30:13 +0800
Message-ID: <42c4a24a-49d8-6174-50fe-eb1a8696afa5@amd.com>
References: <20171214120329.1578-1-christian.koenig@amd.com>
 <CADnq5_OXa4JV6Et+f+baM-sEdC9c+QVORxQM_2=o86HxmOuHXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------84550191376D44EDAA8A64A9"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OXa4JV6Et+f+baM-sEdC9c+QVORxQM_2=o86HxmOuHXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------84550191376D44EDAA8A64A9
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年12月15日 02:04, Alex Deucher wrote:
> On Thu, Dec 14, 2017 at 7:03 AM, Christian König
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Instead of falling back to 2 level and very limited address space use
>> 2+1 PD support and 128TB + 512GB of virtual address space.
>>
>> v2: cleanup defines, rebase on top of level enum
>>
>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  6 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 42 ++++++++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 26 ++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 49 ++++++++++++++++++++------------
>>   5 files changed, 89 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 0cb2235f4798..8ac5875472bd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -541,6 +541,7 @@ struct amdgpu_mc {
>>          u64                                     private_aperture_end;
>>          /* protects concurrent invalidation */
>>          spinlock_t              invalidate_lock;
>> +       bool                    translate_further;
>>   };
>>
>>   /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 1056484de0e3..edd2ea52dc00 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -70,6 +70,12 @@ struct amdgpu_bo_list_entry;
>>   /* PDE is handled as PTE for VEGA10 */
>>   #define AMDGPU_PDE_PTE         (1ULL << 54)
>>
>> +/* PTE is handled as PDE for VEGA10 (Translate Further) */
>> +#define AMDGPU_PTE_TF          (1ULL << 56)
>> +
>> +/* PDE Block Fragment Size for VEGA10 */
>> +#define AMDGPU_PDE_BFS(a)      ((uint64_t)a << 59)
> Safer to put parens around the a in case some one passes in an expression.
>
>
>> +
>>   /* VEGA10 only */
>>   #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
>>   #define AMDGPU_PTE_MTYPE_MASK  AMDGPU_PTE_MTYPE(3ULL)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> index 1d392f186e0d..197005e54d78 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> @@ -143,8 +143,15 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>>          WREG32_SOC15(GC, 0, mmVM_L2_CNTL2, tmp);
>>
>>          tmp = mmVM_L2_CNTL3_DEFAULT;
>> -       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
>> -       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
>> +       if (adev->mc.translate_further) {
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
>> +                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
>> +       } else {
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
>> +                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
>> +       }
> Is this correct?  Aren't the cases reversed here? Won't this change 2
> and 4 level?
obviously it's reversed.
In addition, I wonder that we should set L2_CACH3_BIGK_FRAGMENT_SIZE to 
0 for TF usage? For TF case, the page size pionted by PTE still is 4KB.
If TF bit is disabled, it certainly should be 9 same as 
BLOCK_FRAGMENT_SIZE of PDE.

And I tested it failed on Vega10, I think some points we need to address:
0. set root_level if tf is enabled.
1. alloc SUBPTB
2. get entry for SUBPTB
3. shift for tf case.

I made a draft as the attached, have no time to try yet.

Regards,
David Zhou

>
>
>>          WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, tmp);
>>
>>          tmp = mmVM_L2_CNTL4_DEFAULT;
>> @@ -182,31 +189,40 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>>
>>   static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>>   {
>> -       int i;
>> +       unsigned num_level, block_size;
>>          uint32_t tmp;
>> +       int i;
>> +
>> +       num_level = adev->vm_manager.num_level;
>> +       block_size = adev->vm_manager.block_size;
>> +       if (adev->mc.translate_further)
>> +               num_level -= 1;
>> +       else
>> +               block_size -= 9;
>>
>>          for (i = 0; i <= 14; i++) {
>>                  tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>> -                                   adev->vm_manager.num_level);
>> +                                   num_level);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
>> +                                   1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               PAGE_TABLE_BLOCK_SIZE,
>> -                               adev->vm_manager.block_size - 9);
>> +                                   PAGE_TABLE_BLOCK_SIZE,
>> +                                   block_size);
>>                  /* Send no-retry XNACK on fault to suppress VM fault storm. */
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>>                                      RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 1b5dfccfd5d5..ab0a74b0d30f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -476,6 +476,21 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>>                  *addr = adev->vm_manager.vram_base_offset + *addr -
>>                          adev->mc.vram_start;
>>          BUG_ON(*addr & 0xFFFF00000000003FULL);
>> +
>> +       if (!adev->mc.translate_further)
>> +               return;
>> +
>> +       if (level == AMDGPU_VM_PDB1) {
>> +               /* Set the block fragment size */
>> +               if (!(*flags & AMDGPU_PDE_PTE))
>> +                       *flags |= AMDGPU_PDE_BFS(0x9);
>> +
>> +       } else if (level == AMDGPU_VM_PDB0) {
>> +               if (*flags & AMDGPU_PDE_PTE)
>> +                       *flags &= ~AMDGPU_PDE_PTE;
>> +               else
>> +                       *flags |= AMDGPU_PTE_TF;
>> +       }
>>   }
>>
>>   static const struct amdgpu_gart_funcs gmc_v9_0_gart_funcs = {
>> @@ -765,11 +780,14 @@ static int gmc_v9_0_sw_init(void *handle)
>>          switch (adev->asic_type) {
>>          case CHIP_RAVEN:
>>                  adev->mc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
>> -               if (adev->rev_id == 0x0 || adev->rev_id == 0x1)
>> +               if (adev->rev_id == 0x0 || adev->rev_id == 0x1) {
>>                          amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
>> -               else
>> -                       /* vm_size is 64GB for legacy 2-level page support */
>> -                       amdgpu_vm_adjust_size(adev, 64, 9, 1, 48);
>> +               } else {
>> +                       /* vm_size is 128TB + 512GB for legacy 3-level page support */
>> +                       amdgpu_vm_adjust_size(adev, 128 * 1024 + 512, 9, 2, 48);
>> +                       adev->mc.translate_further =
>> +                               adev->vm_manager.num_level > 1;
>> +               }
>>                  break;
>>          case CHIP_VEGA10:
>>                  /* XXX Don't know how to get VRAM type yet. */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> index 0c5a76f88d35..ba1dfc7fb79e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>> @@ -155,10 +155,15 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>>          tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
>>          WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);
>>
>> -       tmp = mmVM_L2_CNTL3_DEFAULT;
>> -       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
>> -       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
>> -       WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL3, tmp);
>> +       if (adev->mc.translate_further) {
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
>> +                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
>> +       } else {
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
>> +               tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
>> +                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
>> +       }
> Same here.
>
>>          tmp = mmVM_L2_CNTL4_DEFAULT;
>>          tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
>> @@ -196,32 +201,40 @@ static void mmhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>>
>>   static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>>   {
>> -       int i;
>> +       unsigned num_level, block_size;
>>          uint32_t tmp;
>> +       int i;
>> +
>> +       num_level = adev->vm_manager.num_level;
>> +       block_size = adev->vm_manager.block_size;
>> +       if (adev->mc.translate_further)
>> +               num_level -= 1;
>> +       else
>> +               block_size -= 9;
>>
>>          for (i = 0; i <= 14; i++) {
>>                  tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
>> +               tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>> +               tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>> +                                   num_level);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               ENABLE_CONTEXT, 1);
>> -               tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               PAGE_TABLE_DEPTH, adev->vm_manager.num_level);
>> -               tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
>> +                                   1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>> +                                   EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>> -                               PAGE_TABLE_BLOCK_SIZE,
>> -                               adev->vm_manager.block_size - 9);
>> +                                   PAGE_TABLE_BLOCK_SIZE,
>> +                                   block_size);
>>                  /* Send no-retry XNACK on fault to suppress VM fault storm. */
>>                  tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>>                                      RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
>> --
>> 2.11.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------84550191376D44EDAA8A64A9
Content-Type: text/x-patch; name="subptb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="subptb.patch"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 564e1b1962f1..67b6485713c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -158,8 +158,13 @@ static unsigned amdgpu_vm_level_shift(struct amdgpu_device *adev,
 			adev->vm_manager.block_size;
 		break;
 	case AMDGPU_VM_PTB:
-		shift = 0;
+		if (adev->mc.translate_further)
+			shift = adev->vm_manager.block_size;
+		else
+			shift = 0;
 		break;
+	case AMDGPU_VM_SUBPTB:
+		shift = 0;
 	default:
 		dev_err(adev->dev, "the level%d isn't supported.\n", level);
 	}
@@ -397,7 +402,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 			spin_unlock(&vm->status_lock);
 		}
 
-		if (level < AMDGPU_VM_PTB) {
+		if ((level < AMDGPU_VM_PTB) || (adev->mc.translate_further &&
+						(level < AMDGPU_VM_SUBPTB))) {
 			uint64_t sub_saddr = (pt_idx == from) ? saddr : 0;
 			uint64_t sub_eaddr = (pt_idx == to) ? eaddr :
 				((1 << shift) - 1);
@@ -1103,11 +1109,11 @@ static void amdgpu_vm_update_pde(struct amdgpu_pte_update_params *params,
 
 	for (level = 0, pbo = parent->base.bo->parent; pbo; ++level)
 		pbo = pbo->parent;
-
 	level += params->adev->vm_manager.root_level;
 	pt = amdgpu_bo_gpu_offset(bo);
 	flags = AMDGPU_PTE_VALID;
 	amdgpu_gart_get_vm_pde(params->adev, level, &pt, &flags);
+	printk("%s********%d, flags:0x%llx\n", __func__, level, flags);
 	if (shadow) {
 		pde = shadow_addr + (entry - parent->entries) * 8;
 		params->func(params, pde, pt, 1, 0, flags);
@@ -1293,7 +1299,9 @@ void amdgpu_vm_get_entry(struct amdgpu_pte_update_params *p, uint64_t addr,
 		addr &= (1ULL << shift) - 1;
 	}
 
-	if (level != AMDGPU_VM_PTB)
+	if (!p->adev->mc.translate_further && level != AMDGPU_VM_PTB)
+		*entry = NULL;
+	if (p->adev->mc.translate_further && level != AMDGPU_VM_SUBPTB)
 		*entry = NULL;
 }
 
@@ -1335,7 +1343,7 @@ static void amdgpu_vm_handle_huge_pages(struct amdgpu_pte_update_params *p,
 		return;
 	entry->huge = !!(flags & AMDGPU_PDE_PTE);
 
-	amdgpu_gart_get_vm_pde(p->adev, AMDGPU_VM_PDB0,
+	amdgpu_gart_get_vm_pde(p->adev, AMDGPU_VM_PTB,
 			       &dst, &flags);
 
 	if (use_cpu_update) {
@@ -2548,6 +2556,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
 			   unsigned max_bits)
 {
 	uint64_t tmp;
+	unsigned num_level;
 
 	/* adjust vm size first */
 	if (amdgpu_vm_size != -1) {
@@ -2568,7 +2577,10 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
 		tmp >>= amdgpu_vm_block_size - 9;
 	tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
 	adev->vm_manager.num_level = min(max_level, (unsigned)tmp);
-	switch (adev->vm_manager.num_level) {
+	num_level = adev->vm_manager.num_level;
+	if (adev->mc.translate_further)
+		num_level -= 1;
+	switch (num_level) {
 	case 3:
 		adev->vm_manager.root_level = AMDGPU_VM_PDB2;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index edd2ea52dc00..97a2dc41b91d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -133,7 +133,8 @@ enum amdgpu_vm_level {
 	AMDGPU_VM_PDB2,
 	AMDGPU_VM_PDB1,
 	AMDGPU_VM_PDB0,
-	AMDGPU_VM_PTB
+	AMDGPU_VM_PTB,
+	AMDGPU_VM_SUBPTB
 };
 
 /* base structure for tracking BO usage in a VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 197005e54d78..8d6080840192 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -143,7 +143,7 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmVM_L2_CNTL2, tmp);
 
 	tmp = mmVM_L2_CNTL3_DEFAULT;
-	if (adev->mc.translate_further) {
+	if (!adev->mc.translate_further) {
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ab0a74b0d30f..5b6df4f7c9c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -480,12 +480,12 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 	if (!adev->mc.translate_further)
 		return;
 
-	if (level == AMDGPU_VM_PDB1) {
+	if (level == AMDGPU_VM_PDB0) {
 		/* Set the block fragment size */
 		if (!(*flags & AMDGPU_PDE_PTE))
 			*flags |= AMDGPU_PDE_BFS(0x9);
 
-	} else if (level == AMDGPU_VM_PDB0) {
+	} else if (level == AMDGPU_VM_PTB) {
 		if (*flags & AMDGPU_PDE_PTE)
 			*flags &= ~AMDGPU_PDE_PTE;
 		else
@@ -797,7 +797,10 @@ static int gmc_v9_0_sw_init(void *handle)
 		 * vm size is 256TB (48bit), maximum size of Vega10,
 		 * block size 512 (9bit)
 		 */
-		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+	//	amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+			/* vm_size is 128TB + 512GB for legacy 3-level page support */
+			adev->mc.translate_further = 1;
+			amdgpu_vm_adjust_size(adev, 128 * 1024 + 512, 9, 2, 48);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index ba1dfc7fb79e..2443cd44a838 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -155,7 +155,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);
 
-	if (adev->mc.translate_further) {
+	if (!adev->mc.translate_further) {
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);

--------------84550191376D44EDAA8A64A9
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------84550191376D44EDAA8A64A9--
