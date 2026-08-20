Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B74C5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98810E1A4;
	Thu, 20 Aug 2026 10:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="DEy4bvad";
	dkim-atps=neutral
X-Greylist: delayed 520 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 10:46:44 UTC
Received: from smtpout2.mo536.mail-out.ovh.net
 (smtpout2.mo536.mail-out.ovh.net [51.210.91.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F4D10E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:46:44 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hQfzG4b2Kz88XM;
 Thu, 20 Aug 2026 10:38:02 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Thu, 20 Aug 2026 10:38:02 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.58.241])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQfzG3QXmz1y8M; Thu, 20 Aug 2026 10:38:02 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1CC5DB81B07; 
 Thu, 20 Aug 2026 10:38:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007d502190d-2b4c-4766-bdef-65cdad69dad7,
 272873839BD06AC788C5654E217593B0E5FF663A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <973ba6d1-17c8-4b4d-8507-a27045eb7e95@pixelcluster.dev>
Date: Thu, 20 Aug 2026 12:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: Add VM ioctl handlers for
 second-level trap handler
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Lancelot Six <lancelot.six@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20260820070143.3916329-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15639312656930791924
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGTJBaTxsqYgBbn/hCT9zz2dxrF2cBgIDudQ2zXhZKnBaB+ee4+DPSxdIs47wAoKA5Tq+QZoSJYwudy93IvePaAhplJx42ZGJLieAr748E6hdmRc0VmdOe1+QIm1YGqaud3IbO0seNUwFwt2pjGVrjZ8/yQte5SJcp4dg7IbFU1Ff3j89Ttm40cqUFAydNgAqDfByDQ8gl/HzO+sdWyG29jAKccP/WkP7lEBb09PsSVm6TlntkXLKEpOt5c3/k1RuQStKz9amZcrfW6Gfvkia2d5uZ4Vws6i/fE7ou1F60yud38SyQAc3cnsTCwWVR6R2RqXyQ0pPChX+SRflkSdfE+Uotnt5dpg2QL1L6VUJttIX3zqyrpv5awPXDC2ENobnhogDbFgXQ9GUkeLZX4G1JpIis8WYqi11X9tbDUwyntxDFgfEzxGJ6zcav/2+HL5hIa8FXV9fUOBf8xoiB5NuWeqp/Wuo+RLQW8mTbhWPH2eneyCGPwV7yAQLrwKUAUN/WpxiIGhpsKju5J95IwAXq9tm53HuYkGfEs29q0BCEd3GRHkOTrYlOk6jKqs2Ml5CchXNFqMFVRrh8AqaKZzx/dPlgaPw50on+1UsO9fBm23EE8uuHSvzCHFhY53W0L1Ctv77swHf+9vC9h1/msz96ReyW/A3iG4qGN4FdEEliJ1w
DKIM-Signature: a=rsa-sha256; bh=Fc5Dagbn9mcx65WEaRxWllann/um3oxarqZUj2gDS3Y=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1787222282; v=1;
 b=DEy4bvadbdCk4uppmvaBrPISLZL52b47/FgdqFg+GbK9uHIwHYNMJ/PJZsGi/MyayOpoqaZM
 SVNtI4zd16I5KHkiZFoRFBmtHkIPza6dj+q0NSC2e5rR7KvRu4VULUfSfPY0gS9FjgkKNwhLoWT
 zdkPf0DdUkIsSLrGJOK0TzA1oNdeMawHD2VP+oUVrYOrSgIZMRCwlkzmzOsNj7NRbJdyECvsojP
 S0naTpbezvft4lCzZhmDs9Lc0kQSvHQI8FWwu07VC3vvvtFbZQP6YcYtvJRYH8Bz8p9IDGW/rql
 Rt2UFQSYXpZseG4ypdZo9orL+ExIHq4uv5XrwWQCOVPDA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/20/26 09:01, Srinivasan Shanmugam wrote:
> Render-node user queues had no mechanism to install a userspace
> second-level trap handler equivalent to what KFD provides for compute.
> Add it via the VM ioctl and fix several correctness issues in the CWSR
> TMA access path.
> 
> On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
> (PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
> lack full load/store support for MMIO. Replace void *tma_cpu_addr with
> struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.
> 
> Writing TBA and TMA as two separate stores creates a race where a
> trapping wave can observe a mismatched pair. Evict all user queues and
> flush the GPU TLB before writing, then restore queues after. Use
> amdgpu_vm_wait_idle() on the CLEAR_L2_TRAP path to also drain kernel
> queue VM operations before zeroing TBA/TMA.

Once you properly track the TBA/TMA buffers as used like I suggested in
my previous email, this dance becomes unnecessary. You should then be 
able to reuse how VM unmap operations sync to everything that may use 
the BO.

This also takes care of the concern Timur brought up about handling 
kernel queues properly.

Thanks,
Natalie

> 
> Evict user queues in amdgpu_cwsr_free() at file close. Waves may still
> be active at that point; without eviction a freed TMA BO can be accessed
> via a stale TBA, causing a GPU page fault.
> 
> Export amdgpu_userq_restore_all() for immediate queue restore after
> SET/CLEAR without waiting for the eviction fence.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I6d95799037924e44fb320de756f7cfcdcf39532e
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c  | 341 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h  |  54 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  15 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  26 ++
>   include/uapi/drm/amdgpu_drm.h             |  13 -
>   7 files changed, 379 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> index 7e5a08b0a1c8..36a69d0ab81a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -19,12 +19,26 @@
>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
> +#include <linux/iosys-map.h>
> +#include <drm/ttm/ttm_bo.h>
> +
>   #include <drm/drm_exec.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_gmc.h"
> +#include "amdgpu_userq.h"
> +#include "amdgpu_vm.h"
>   #include "cwsr_trap_handler.h"
>   #include "amdgpu_cwsr.h"
>   
> +/*
> + * First-level TMA layout shared with the next-level trap handler ABI.
> + * A zero second-level TBA disables next-level dispatch.
> + */
> +#define AMDGPU_CWSR_L2_TBA_INDEX	0
> +#define AMDGPU_CWSR_L2_TMA_INDEX	1
> +#define AMDGPU_CWSR_DEBUG_FLAG_INDEX	2
> +
>   extern int cwsr_enable;
>   
>   #define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> @@ -380,6 +394,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	struct amdgpu_cwsr_trap_obj *cwsr;
>   	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
> +	void *cpu_addr;
>   	int r;
>   
>   	if (!amdgpu_cwsr_is_enabled(adev))
> @@ -407,10 +422,21 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAGE_SIZE,
>   				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
> -				    &cwsr->tma_cpu_addr);
> +				    &cpu_addr);
>   	if (r)
>   		goto err;
>   
> +	/*
> +	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
> +	 * may be placed in VRAM (MMIO via PCI BAR). Check TTM_BO_MAP_IOMEM_MASK
> +	 * to select the correct write accessor. Mirrors kfd_process.c.
> +	 */
> +	if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +		iosys_map_set_vaddr_iomem(&cwsr->tma_map,
> +					  (void __iomem *)cpu_addr);
> +	else
> +		iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
> +
>   	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
>   	if (r)
>   		goto err;
> @@ -433,6 +459,30 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +void amdgpu_cwsr_clear_l2_trap_handler(struct amdgpu_vm *vm,
> +				       struct amdgpu_cwsr_trap_obj *cwsr_obj)
> +{
> +	if (!cwsr_obj || iosys_map_is_null(&cwsr_obj->tma_map))
> +		return;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	/*
> +	 * A zero TBA disables next-level dispatch. Clear TBA first so the
> +	 * GPU cannot observe an enabled descriptor while it is removed.
> +	 */
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_L2_TBA_INDEX * sizeof(u64), u64, 0);
> +	dma_wmb();
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_L2_TMA_INDEX * sizeof(u64), u64, 0);
> +
> +	cwsr_obj->l2_tba_addr = 0;
> +	cwsr_obj->l2_tba_size = 0;
> +	cwsr_obj->l2_tma_addr = 0;
> +	cwsr_obj->l2_tma_size = 0;
> +}
> +
>   int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>   				struct amdgpu_cwsr_params *cwsr_params,
>   				int num_xcc)
> @@ -464,6 +514,7 @@ int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>   }
>   
>   void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_userq_mgr *uq_mgr,
>   		      struct amdgpu_cwsr_trap_obj **trap_obj)
>   {
>   	struct amdgpu_bo *tba_bo;
> @@ -473,32 +524,47 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>   		return;
> +
>   	tba_bo = adev->cwsr_info->isa_bo;
>   	tma_bo = (*trap_obj)->tma_bo;
>   
>   	if (!tba_bo || !tma_bo)
>   		return;
>   
> -	drm_exec_init(&exec, 0, 0);
> -	drm_exec_until_all_locked(&exec)
> -	{
> +	/*
> +	 * Evict all user queues before freeing CWSR state. At file-close
> +	 * time waves may still be active; without eviction a wave can trap
> +	 * into the handler after the TMA BO is freed, causing a GPU page fault.
> +	 * Called after amdgpu_bo_unreserve() in postclose so no lock held.
> +	 */
> +	if (uq_mgr)
> +		amdgpu_userq_evict(uq_mgr);
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
>   		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> -		if (likely(!r))
> -			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> -		drm_exec_retry_on_contention(&exec);
>   		if (likely(!r))
>   			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
> +		if (likely(!r))
> +			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
>   		drm_exec_retry_on_contention(&exec);
>   		if (unlikely(r)) {
>   			dev_err(adev->dev,
>   				"failed to reserve CWSR BOs: err=%d\n", r);
> -			goto err;
> +			goto out;
>   		}
>   	}
>   
> +	/*
> +	 * amdgpu_driver_postclose_kms() doesn't hold the VM reservation.
> +	 * drm_exec above holds VM root + CWSR BO reservations, serialising
> +	 * teardown with VM mapping removal and TMA destruction.
> +	 */
> +	amdgpu_cwsr_clear_l2_trap_handler(vm, *trap_obj);
> +
>   	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
>   	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> -err:
> +out:
>   	drm_exec_fini(&exec);
>   	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
>   	kfree(*trap_obj);
> @@ -512,62 +578,174 @@ static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
>   	struct amdgpu_bo_va_mapping *va_map;
>   	uint64_t addr;
>   	uint32_t size;
> -	int r;
> +
> +	/*
> +	 * Caller (amdgpu_cwsr_vm_set_l2_trap) already holds the VM root
> +	 * BO reservation via amdgpu_bo_reserve(). Assert it is held rather
> +	 * than taking it again.
> +	 */
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   
>   	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>   	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
>   
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r)
> -		return r;
> -
>   	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
> -	if (!va_map) {
> -		r = -EINVAL;
> -		goto err;
> -	}
> +	if (!va_map)
> +		return -EINVAL;
> +
>   	/* validate whether resident in the VM mapping range */
> -	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
> -		amdgpu_bo_unreserve(vm->root.bo);
> +	if (addr >= va_map->start && va_map->last - addr + 1 >= size)
>   		return 0;
> -	}
>   
> -	r = -EINVAL;
> -err:
> -	amdgpu_bo_unreserve(vm->root.bo);
> -
> -	return r;
> +	return -EINVAL;
>   }
>   
> -static int amdgpu_cwsr_set_l2_trap_handler(
> -	struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
> -	struct amdgpu_cwsr_usr_addr *tba)
> +/**
> + * amdgpu_cwsr_vm_set_l2_trap - install the second-level trap handler.
> + * @adev: amdgpu device
> + * @vm: VM for this DRM file
> + * @uq_mgr: user queue manager for this DRM file
> + * @cwsr_obj: per-file CWSR trap object
> + * @tba_va: GPU VA of the handler code buffer
> + * @tba_sz: size of the TBA buffer in bytes
> + * @tma_va: GPU VA of the handler scratch buffer
> + * @tma_sz: size of the TMA buffer in bytes
> + *
> + * Called from amdgpu_vm_ioctl() for AMDGPU_VM_OP_SET_L2_TRAP.
> + * Evicts all user queues, flushes GPU TLB, validates TBA/TMA, writes
> + * new TBA/TMA into the first-level TMA, then restores queues.
> + */
> +int amdgpu_cwsr_vm_set_l2_trap(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
> +			       struct amdgpu_userq_mgr *uq_mgr,
> +			       struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +			       u64 tba_va, uint32_t tba_sz,
> +			       u64 tma_va, uint32_t tma_sz)
>   {
> -	uint64_t *l1tma;
> +	struct amdgpu_cwsr_usr_addr tba = { .addr = tba_va, .size = tba_sz };
> +	struct amdgpu_cwsr_usr_addr tma = { .addr = tma_va, .size = tma_sz };
>   	int r;
>   
>   	if (!amdgpu_cwsr_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   
> -	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
> +	if (!cwsr_obj || iosys_map_is_null(&cwsr_obj->tma_map))
>   		return -EINVAL;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +
> +	/*
> +	 * Evict all user queues before updating TBA/TMA. Writing TBA and TMA
> +	 * as two separate stores creates a race: a wave that traps between
> +	 * them reads a mismatched TBA/TMA pair. Evicting first ensures no
> +	 * wave is active on hardware during the update.
> +	 * amdgpu_userq_wait_for_signal() polls a seq64 CPU address; no BO
> +	 * reservation dependency, so calling before amdgpu_bo_reserve is safe.
> +	 */
> +	amdgpu_userq_evict(uq_mgr);
> +
> +	/*
> +	 * Flush the GPU TLB for this process PASID to remove stale cached
> +	 * TBA/TMA values. flush_type=2 flushes both TC (L2) and TLB.
> +	 * Called before amdgpu_bo_reserve so no reservation is held.
> +	 */
> +	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>   	if (r)
>   		return r;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +
> +	r = amdgpu_cwsr_validate_user_addr(adev, vm, &tba);
> +	if (r)
> +		goto out_unreserve;
> +
> +	r = amdgpu_cwsr_validate_user_addr(adev, vm, &tma);
> +	if (r)
> +		goto out_unreserve;
> +
> +	/*
> +	 * No wave is active (eviction above). Write TBA=0 first to disable
> +	 * any residual dispatch, write TMA, then publish new TBA.
> +	 */
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_L2_TBA_INDEX * sizeof(u64), u64, 0);
> +	dma_wmb();
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_L2_TMA_INDEX * sizeof(u64), u64, tma_va);
> +	dma_wmb();
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_L2_TBA_INDEX * sizeof(u64), u64, tba_va);
> +
> +	cwsr_obj->l2_tba_addr = tba_va;
> +	cwsr_obj->l2_tba_size = tba_sz;
> +	cwsr_obj->l2_tma_addr = tma_va;
> +	cwsr_obj->l2_tma_size = tma_sz;
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	if (!r) {
> +		/* New handler installed; clear the forced-removal flag. */
> +		cwsr_obj->l2_trap_removed = false;
> +		amdgpu_userq_restore_all(uq_mgr);
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_cwsr_vm_clear_l2_trap - disable the second-level trap handler.
> + * @adev: amdgpu device
> + * @vm: VM for this DRM file
> + * @uq_mgr: user queue manager for this DRM file
> + * @cwsr_obj: per-file CWSR trap object
> + *
> + * Called from amdgpu_vm_ioctl() for AMDGPU_VM_OP_CLEAR_L2_TRAP.
> + * Waits for VM idle, evicts all user queues, flushes TLB, then zeros
> + * TBA/TMA slots. Restores queues after clear.
> + */
> +int amdgpu_cwsr_vm_clear_l2_trap(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_userq_mgr *uq_mgr,
> +				 struct amdgpu_cwsr_trap_obj *cwsr_obj)
> +{
> +	int r;
> +
> +	/*
> +	 * Wait for all VM scheduler entities to drain before clearing.
> +	 * This covers kernel queue VM operations and user queue VM update
> +	 * fences before we touch the handler state.
> +	 */
> +	amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
> +
> +	/*
> +	 * Evict all user queues. A wave may still be executing inside the
> +	 * second-level handler; evicting first ensures no wave is active
> +	 * when TBA is zeroed.
> +	 */
> +	amdgpu_userq_evict(uq_mgr);
> +
> +	/* Flush stale TBA/TMA values from GPU TLB caches. */
> +	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>   	if (r)
>   		return r;
>   
> -	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
> -	l1tma[0] = tma->addr;
> -	l1tma[1] = tba->addr;
> +	amdgpu_cwsr_clear_l2_trap_handler(vm, cwsr_obj);
> +	/* Explicit clean clear; clear the forced-removal flag. */
> +	cwsr_obj->l2_trap_removed = false;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	/* Restore queues now the handler is cleanly disabled. */
> +	amdgpu_userq_restore_all(uq_mgr);
>   
>   	return 0;
>   }
>   
>   /*
> - * Userspace cwsr related ioctl
> + * Userspace cwsr related ioctl.
> + * SET_L2_TRAP and CLEAR_L2_TRAP are now handled by amdgpu_vm_ioctl()
> + * via AMDGPU_VM_OP_SET_L2_TRAP and AMDGPU_VM_OP_CLEAR_L2_TRAP.
>    */
>   /**
>    * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> @@ -576,15 +754,13 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>    * @data: request object
>    * @filp: drm filp
>    *
> - * This function is used to perform cwsr and trap handler related operations
> + * This function is used to perform cwsr and trap handler related operations.
>    * Returns 0 on success, error code on failure.
>    */
>   int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>   	union drm_amdgpu_cwsr *cwsr = data;
>   	struct amdgpu_fpriv *fpriv;
> -	int r;
>   
>   	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>   
> @@ -592,38 +768,85 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		return -EOPNOTSUPP;
>   
>   	switch (cwsr->in.op) {
> -	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> -		struct amdgpu_cwsr_usr_addr tba;
> -		struct amdgpu_cwsr_usr_addr tma;
> -
> -		tba.addr = cwsr->in.l2trap.tba_va;
> -		tba.size = cwsr->in.l2trap.tba_sz;
> -		tma.addr = cwsr->in.l2trap.tma_va;
> -		tma.size = cwsr->in.l2trap.tma_sz;
> -		r = amdgpu_cwsr_set_l2_trap_handler(
> -			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> -	} break;
>   	default:
>   		return -EINVAL;
>   	}
> -
> -	return r;
>   }
>   
>   int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
>   				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
>   				    bool enabled)
>   {
> -	uint64_t *l1tma;
> -
>   	if (!amdgpu_cwsr_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   
>   	if (!cwsr_obj)
>   		return -EINVAL;
>   
> -	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
> -	l1tma[2] = enabled;
> +	iosys_map_wr(&cwsr_obj->tma_map,
> +		     AMDGPU_CWSR_DEBUG_FLAG_INDEX * sizeof(u64), u64,
> +		     (u64)enabled);
>   
>   	return 0;
> -}
> \ No newline at end of file
> +}
> +
> +/**
> + * amdgpu_cwsr_handle_l2_trap_unmap - disable L2 handler if VA overlaps TBA/TMA.
> + * @adev: amdgpu device
> + * @vm: VM for this DRM file
> + * @uq_mgr: user queue manager for this DRM file
> + * @cwsr_obj: per-file CWSR trap object
> + * @addr: start of the VA range being unmapped
> + * @size: size of the VA range being unmapped
> + *
> + * Called from amdgpu_gem_va_ioctl() for VA_OP_UNMAP and VA_OP_CLEAR.
> + * UNMAP must always succeed; performs handler teardown before the
> + * mapping is removed rather than returning an error.
> + */
> +void amdgpu_cwsr_handle_l2_trap_unmap(struct amdgpu_device *adev,
> +				      struct amdgpu_vm *vm,
> +				      struct amdgpu_userq_mgr *uq_mgr,
> +				      struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +				      u64 addr, u64 size)
> +{
> +	bool tba_overlap, tma_overlap;
> +
> +	if (!cwsr_obj || !size || !uq_mgr)
> +		return;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	tba_overlap = cwsr_obj->l2_tba_size &&
> +		      addr < cwsr_obj->l2_tba_addr + cwsr_obj->l2_tba_size &&
> +		      cwsr_obj->l2_tba_addr < addr + size;
> +	tma_overlap = cwsr_obj->l2_tma_size &&
> +		      addr < cwsr_obj->l2_tma_addr + cwsr_obj->l2_tma_size &&
> +		      cwsr_obj->l2_tma_addr < addr + size;
> +
> +	if (!tba_overlap && !tma_overlap)
> +		return;
> +
> +	/*
> +	 * Wait for all VM scheduler entities to drain. This covers kernel
> +	 * queue VM operations before touching the handler state.
> +	 */
> +	amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
> +
> +	/*
> +	 * Evict all user queues so no wave can access the about-to-be-freed
> +	 * memory. Mirrors the WPTR/RPTR/ring buffer unmap eviction path.
> +	 */
> +	amdgpu_userq_evict(uq_mgr);
> +
> +	/* Flush stale TBA/TMA values from GPU TLB caches. */
> +	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +
> +	amdgpu_cwsr_clear_l2_trap_handler(vm, cwsr_obj);
> +
> +	/*
> +	 * Mark that TBA/TMA was forcibly removed by unmap without CLEAR_L2_TRAP.
> +	 * Queues will not restart until userspace installs a new handler via
> +	 * SET_L2_TRAP.
> +	 */
> +	cwsr_obj->l2_trap_removed = true;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> index 06036954627e..c417b49ab623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -24,11 +24,13 @@
>   #define AMDGPU_CWSR_H
>   
>   #include <linux/types.h>
> +#include <linux/iosys-map.h>
>   
>   struct amdgpu_bo;
>   struct amdgpu_bo_va;
>   struct amdgpu_device;
>   struct amdgpu_vm;
> +struct amdgpu_userq_mgr;
>   
>   /**
>    * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
> @@ -42,7 +44,24 @@ struct amdgpu_cwsr_trap_obj {
>   	struct amdgpu_bo *tma_bo;
>   	struct amdgpu_bo_va *tba_va;
>   	struct amdgpu_bo_va *tma_va;
> -	void *tma_cpu_addr;
> +	struct iosys_map tma_map;  /* GTT or VRAM — set by TTM_BO_MAP_IOMEM_MASK check */
> +
> +	/*
> +	 * Active userspace second-level trap-handler VA ranges.
> +	 * Protected by the VM root BO reservation object.
> +	 */
> +	u64 l2_tba_addr;
> +	u64 l2_tba_size;
> +	u64 l2_tma_addr;
> +	u64 l2_tma_size;
> +
> +	/*
> +	 * Set when TBA or TMA was forcibly removed via GEM_VA UNMAP without
> +	 * calling CLEAR_L2_TRAP first. Prevents queues from restarting with
> +	 * an invalid trap handler state. Cleared when SET_L2_TRAP installs a
> +	 * new handler or when CLEAR_L2_TRAP explicitly disables the handler.
> +	 */
> +	bool l2_trap_removed;
>   };
>   
>   struct amdgpu_cwsr_info {
> @@ -73,7 +92,37 @@ void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>   int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
>   void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_userq_mgr *uq_mgr,
>   		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> +
> +/**
> + * amdgpu_cwsr_l2_trap_was_removed - check if TBA/TMA was forcibly removed.
> + *
> + * Called from amdgpu_userq_restore_all() before restarting a queue.
> + * Returns true if the L2 trap handler TBA or TMA was removed via
> + * GEM_VA UNMAP without calling CLEAR_L2_TRAP first. Queues must not
> + * restart with a missing trap handle.
> + */
> +static inline bool amdgpu_cwsr_l2_trap_was_removed(struct amdgpu_cwsr_trap_obj *cwsr_obj)
> +{
> +	return cwsr_obj && cwsr_obj->l2_trap_removed;
> +}
> +
> +int amdgpu_cwsr_vm_set_l2_trap(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
> +			       struct amdgpu_userq_mgr *uq_mgr,
> +			       struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +			       u64 tba_va, uint32_t tba_sz,
> +			       u64 tma_va, uint32_t tma_sz);
> +int amdgpu_cwsr_vm_clear_l2_trap(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_userq_mgr *uq_mgr,
> +				 struct amdgpu_cwsr_trap_obj *cwsr_obj);
> +void amdgpu_cwsr_handle_l2_trap_unmap(struct amdgpu_device *adev,
> +				      struct amdgpu_vm *vm,
> +				      struct amdgpu_userq_mgr *uq_mgr,
> +				      struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +				      u64 addr, u64 size);
>   static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
>   {
>   	return adev->cwsr_info != NULL;
> @@ -95,5 +144,6 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
>   				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
>   				    bool enabled);
> -
> +void amdgpu_cwsr_clear_l2_trap_handler(struct amdgpu_vm *vm,
> +				       struct amdgpu_cwsr_trap_obj *cwsr_obj);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f8a30e52e2a0..db08238ee912 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1716,7 +1716,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	}
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +
> +	/* VM root BO reservation released before this call. */
> +	amdgpu_cwsr_free(adev, &fpriv->vm,
> +			 &fpriv->userq_mgr, &fpriv->cwsr_trap);
>   
>   	if (pasid)
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index feffebb210ea..34b45e1ce6cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -998,9 +998,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> -static int
> +int
>   amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>   {
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>   	struct amdgpu_usermode_queue *queue;
>   	unsigned long queue_id;
>   	int ret = 0, r;
> @@ -1017,6 +1018,18 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>   			continue;
>   		}
>   
> +		/*
> +		 * If the second-level trap handler TBA or TMA was forcibly
> +		 * removed by GEM_VA UNMAP without CLEAR_L2_TRAP, do not
> +		 * restart the queue. A queue must not run without a valid
> +		 * resident trap handler if one was previously configured.
> +		 */
> +		if (amdgpu_cwsr_l2_trap_was_removed(fpriv->cwsr_trap)) {
> +			trace_amdgpu_userq_state_changed(queue,
> +							 AMDGPU_USERQ_STATE_INVALID_VA);
> +			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> +			continue;
> +		}
>   		r = amdgpu_userq_map_helper(queue);
>   		if (r)
>   			ret = r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 26f7fef3048c..3c8731ca846c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -164,6 +164,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>   
>   void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
> +int amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr);
>   
>   void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>   				  struct amdgpu_eviction_fence_mgr *evf_mgr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 930b744c5f5f..9dd9b3eebcbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -36,6 +36,7 @@
>   #include <drm/ttm/ttm_tt.h>
>   #include <drm/drm_exec.h>
>   #include "amdgpu.h"
> +#include "amdgpu_cwsr.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> @@ -2893,6 +2894,31 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
>   		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>   		break;
> +	case AMDGPU_VM_OP_SET_L2_TRAP:
> +		/*
> +		 * Install or replace the per-VM second-level trap handler.
> +		 * Applies to all shader waves under this VMID regardless of
> +		 * queue type (GFX, compute, or any other).
> +		 */
> +		if (!fpriv->cwsr_trap)
> +			return -EOPNOTSUPP;
> +		return amdgpu_cwsr_vm_set_l2_trap(adev, vm,
> +						  &fpriv->userq_mgr,
> +						  fpriv->cwsr_trap,
> +						  args->in.l2trap.tba_va,
> +						  args->in.l2trap.tba_sz,
> +						  args->in.l2trap.tma_va,
> +						  args->in.l2trap.tma_sz);
> +	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
> +		/*
> +		 * Disable the per-VM second-level trap handler.
> +		 * Waits for VM idle, evicts queues, flushes TLB, clears handler.
> +		 */
> +		if (!fpriv->cwsr_trap)
> +			return -EOPNOTSUPP;
> +		return amdgpu_cwsr_vm_clear_l2_trap(adev, vm,
> +						    &fpriv->userq_mgr,
> +						    fpriv->cwsr_trap);
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 872ff9d1d1ff..ec94f26f8b9d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1814,22 +1814,9 @@ struct drm_amdgpu_info_cwsr {
>   	__u32 min_save_area_size;
>   };
>   
> -/* cwsr ioctl */
> -#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> -
>   struct drm_amdgpu_cwsr_in {
>   	/* AMDGPU_CWSR_OP_* */
>   	__u32 op;
> -	struct {
> -		/* Level 2 trap handler base address */
> -		__u64 tba_va;
> -		/* Level 2 trap handler buffer size (in bytes) */
> -		__u32 tba_sz;
> -		/* Level 2 trap memory buffer address */
> -		__u64 tma_va;
> -		/* Level 2 trap memory buffer size (in bytes) */
> -		__u32 tma_sz;
> -	} l2trap;
>   };
>   
>   union drm_amdgpu_cwsr {

