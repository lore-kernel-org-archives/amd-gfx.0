Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47F8C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 11:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F68D10E02C;
	Mon, 21 Sep 2026 11:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kc9i7tiJ";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D3210E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 11:36:40 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a99cd5115bso4328690a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990599; x=1790595399; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3M36SP7UGurBuFhhfC+fdU4rd+zFLqIVkhltXKtvO8A=;
 b=kc9i7tiJTxK6DmVl30qksuF5mP21J8w/Dxc5Gw8CuYh6QDgr+o31iWsDmGtuLPTXuM
 +hZp8XbwAwpI8Gm8OrSdcBK0VfGbdaIPsk72XgMpFes48/Ig0OENPUxFAf1PriVBAzFW
 gbf2wA5KWVQ1Gce6mK3V4se/V105Qoj31ifAbh4KrgXvUw0woXNfi1wFiPEx1U8W2iZ7
 Fws7O7Hm9dk9XX51HI3bdMphc+8bM5uOpMfyIkkJoivm1P6hfePBTHGrCfPZp/CpGxpt
 PmdUU6Oa4hiCMubw+dfwq34cJ8NIq5IoWoF0mx1VSLCdh9dSnzaQVvPlGLtVa7yGeVfX
 oIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990599; x=1790595399;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3M36SP7UGurBuFhhfC+fdU4rd+zFLqIVkhltXKtvO8A=;
 b=XkDthpwA6ILP+auuC2PilNOOp8evwkGKZ9mZzfyEq67Q9zHanMPnyKN7gChJ6ZX2ru
 CK7bBWnOel3FbH4XYZArb4BRept4K/rfUvrpVEH9SxAWg7IuX/Qdxs7uaIyQBHuOsbFW
 e3lSxBMdjZt1IQyTjusdsVLwpuCQTxSc5c632piEaibxUjCJtC4KPe04dROrkukz6mTC
 g9hsEWaIR48qlxpghT3xlQVqppsb9Z+4Vq+heVJbv/r4gqnJbBN64gEXphkAYbKJ2cZV
 spzcGU8bnqpmVUThN+aN5a+DGbghIEHZS9a75G5U64SpC3P72+fith2YN7yE5wMnWPhB
 JgKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2IwFclVNeKzeqtwvH2B7tkK3q9Kc2N/r1Jsyggf0F5ljaHYbs/jlNu7tO76mx1xNByByzxr2i@lists.freedesktop.org
X-Gm-Message-State: AFuF++nugoPMP2vDivbFWodjJ2KTuGBvL9YcDijHOLdL4HxKPLHHHIiv
 5TICd3hYUaNpefCI5pJI78awR+kRutZCVJW3fEseZ+VNaWqCs9DZuHW8
X-Gm-Gg: AYBFou2Y9336tdyV1X6YQ3x5THg/VPGUKYF2GrTHNpXPeY3yIufhuPyj4KtJruXpLXC
 5OrJdRG4+mnyaEm3ZND0g+JXOPN336ti/Bd6UPdcmXaNhzWTp/uIlhY/88E9WmgSeV0HubV7hHX
 N7EnIJ3XrBaCZlk/YkGcLVC2i6oxjj/6+nQYNepldaUbaOkf0tm2q5EipgIouvtSDMd/oGV5pEp
 HDvk8nuo8qLk4cYTrVfIDAcbAwPk+4r1N1tJ4W2lgNOTlHX1BiYLyrgTOuzrcpehhnVnhYRrrfP
 dF7cfR3DY6frlRA5uZvHredYtT6oGh7TzPEt7/X/RChmW651ZBIBjzU4h0dDJvILOThFNrCWdwQ
 aOoI+UIqIstBA5X5KA7fdqpB6WrtirujvmQF2rWHVPII9sFxWb1F4Ky5577QoxAbpxhQ6BhB8a0
 v6K/FD0yrt8ph5upEV5T03cuPJQResHz9LgAcwQN8f4o841JiCIIHaQ2EKn3FhUEDQUsU6rjtOc
 PVanix0mIrNpCHClEOwURnaj7LKYQrdoRs94pzvEdhUWA==
X-Received: by 2002:a05:6402:1e91:b0:6aa:13c1:2c88 with SMTP id
 4fb4d7f45d1cf-6aa579a813dmr7432674a12.44.1789990598271; 
 Mon, 21 Sep 2026 04:36:38 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67dd2c89sm3856772a12.19.2026.09.21.04.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:36:37 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Huang Yu <yhuang13@amd.com>
Cc: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>,
 Ray Huang <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>,
 Lingshan Zhu <lingszhu@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: start to move VM internals into
 amdgpu_vm_internal.h
Date: Mon, 21 Sep 2026 13:36:35 +0200
Message-ID: <atWb2QxcRxSsvRKqOWM7Mw@gmail.com>
In-Reply-To: <20260917110158.296198-2-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
 <20260917110158.296198-2-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, September 17, 2026 1:01:46=E2=80=AFPM Central European Summer =
Time Huang=20
Yu wrote:
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>=20
> Avoid exposing some defines outside of the VM code.
>=20
> Co-developed by Claude Sonnet 4.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Hi,

I believe I've already commented on this patch two times already, but it se=
ems=20
both comments were lost, so I'm going to repeat:

Please use the "Assisted-by" tag instead, see this page for details and an=
=20
example: https://docs.kernel.org/process/coding-assistants.html

with that fixed, the patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_trace_points.c  |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 116 -------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 155 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   1 +
>  8 files changed, 162 insertions(+), 116 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h index
> 5324030a13f5..784adf975b04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -37,6 +37,8 @@
>  #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
>  =09
> job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->fi=
ni
> shed)
>=20
> +struct amdgpu_vm_update_params;
> +
>  TRACE_EVENT(amdgpu_device_rreg,
>  	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
>  	    TP_ARGS(did, reg, value),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c index
> b96d885f6e33..fe61ed5b487e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> @@ -25,6 +25,7 @@
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu_cs.h"
>  #include "amdgpu.h"
> +#include "amdgpu_vm_internal.h"
>=20
>  #define CREATE_TRACE_POINTS
>  #include "amdgpu_trace.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 88249aa89ee3..517490946a9c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -37,6 +37,7 @@
>  #include <drm/drm_exec.h>
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_vm_internal.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gmc.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index d32183cd9e0f..ac3b8e8525c1
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -262,80 +262,6 @@ struct amdgpu_task_info {
>  	struct kref	refcount;
>  };
>=20
> -/**
> - * struct amdgpu_vm_update_params
> - *
> - * Encapsulate some VM table update parameters to reduce
> - * the number of function parameters
> - *
> - */
> -struct amdgpu_vm_update_params {
> -
> -	/**
> -	 * @adev: amdgpu device we do this update for
> -	 */
> -	struct amdgpu_device *adev;
> -
> -	/**
> -	 * @vm: optional amdgpu_vm we do this update for
> -	 */
> -	struct amdgpu_vm *vm;
> -
> -	/**
> -	 * @immediate: if changes should be made immediately
> -	 */
> -	bool immediate;
> -
> -	/**
> -	 * @unlocked: true if the root BO is not locked
> -	 */
> -	bool unlocked;
> -
> -	/**
> -	 * @pages_addr:
> -	 *
> -	 * DMA addresses to use for mapping
> -	 */
> -	dma_addr_t *pages_addr;
> -
> -	/**
> -	 * @job: job to used for hw submission
> -	 */
> -	struct amdgpu_job *job;
> -
> -	/**
> -	 * @num_dw_left: number of dw left for the IB
> -	 */
> -	unsigned int num_dw_left;
> -
> -	/**
> -	 * @needs_flush: true whenever we need to invalidate the TLB
> -	 */
> -	bool needs_flush;
> -
> -	/**
> -	 * @override_pte: true for memory that is not uncached and gmc=20
override
> function is -	 * implemented to allow MTYPE to be overridden for=20
NUMA local
> memory. -	 */
> -	bool override_pte;
> -
> -	/**
> -	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
> -	 */
> -	struct list_head tlb_flush_waitlist;
> -};
> -
> -struct amdgpu_vm_update_funcs {
> -	int (*map_table)(struct amdgpu_bo_vm *bo);
> -	int (*prepare)(struct amdgpu_vm_update_params *p,
> -		       struct amdgpu_sync *sync, u64 k_job_id);
> -	int (*update)(struct amdgpu_vm_update_params *p,
> -		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t=20
addr,
> -		      unsigned count, uint32_t incr, uint64_t flags);
> -	int (*commit)(struct amdgpu_vm_update_params *p,
> -		      struct dma_fence **fence);
> -};
> -
>  struct amdgpu_vm_fault_info {
>  	/* fault address */
>  	uint64_t	addr;
> @@ -600,22 +526,6 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device
> *adev, void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>  			  struct amdgpu_mem_stats=20
stats[__AMDGPU_PL_NUM]);
>=20
> -int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		       struct amdgpu_bo_vm *vmbo, bool immediate);
> -int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			int level, bool immediate, struct=20
amdgpu_bo_vm **vmbo,
> -			int32_t xcp_id);
> -void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); -
> -int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
> -			 struct amdgpu_vm_bo_base *entry);
> -int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
> -			  uint64_t start, uint64_t end,
> -			  uint64_t dst, uint64_t flags);
> -void amdgpu_vm_pt_free_work(struct work_struct *work);
> -void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> -			    struct amdgpu_vm_update_params *params);
> -
>  #if defined(CONFIG_DEBUG_FS)
>  void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>  #endif
> @@ -651,32 +561,6 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct
> amdgpu_vm *vm) return atomic64_read(&vm->tlb_seq);
>  }
>=20
> -/*
> - * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-=
=46S
> - * happens while holding this lock anywhere to prevent deadlocks when
> - * an MMU notifier runs in reclaim-FS context.
> - */
> -static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> -{
> -	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags =3D memalloc_noreclaim_save();
> -}
> -
> -static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> -{
> -	if (mutex_trylock(&vm->eviction_lock)) {
> -		vm->saved_flags =3D memalloc_noreclaim_save();
> -		return true;
> -	}
> -	return false;
> -}
> -
> -static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> -{
> -	memalloc_noreclaim_restore(vm->saved_flags);
> -	mutex_unlock(&vm->eviction_lock);
> -}
> -
>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  				  unsigned int pasid,
>  				  uint64_t addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c index
> b31ff6f56f0d..d03b9bbe20c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -21,6 +21,7 @@
>   */
>=20
>  #include "amdgpu_vm.h"
> +#include "amdgpu_vm_internal.h"
>  #include "amdgpu.h"
>  #include "amdgpu_reset.h"
>  #include "amdgpu_object.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h new file mode 100644
> index 000000000000..447195cc4593
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"), + * to deal in the Software without restriction, including
> without limitation + * the rights to use, copy, modify, merge, publish,
> distribute, sublicense, + * and/or sell copies of the Software, and to
> permit persons to whom the + * Software is furnished to do so, subject to
> the following conditions: + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> OR + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E=20
> IN NO EVENT SHALL + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
> ANY CLAIM, DAMAGES OR + * OTHER LIABILITY, WHETHER IN AN ACTION OF
> CONTRACT, TORT OR OTHERWISE, + * ARISING FROM, OUT OF OR IN CONNECTION WI=
TH
> THE SOFTWARE OR THE USE OR + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: Christian K=C3=B6nig
> + */
> +#ifndef __AMDGPU_VM_INTERNAL_H__
> +#define __AMDGPU_VM_INTERNAL_H__
> +
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include "amdgpu_vm.h"
> +
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +struct amdgpu_job;
> +struct amdgpu_sync;
> +struct amdgpu_bo_vm;
> +struct amdgpu_vm_bo_base;
> +struct dma_fence;
> +
> +/**
> + * struct amdgpu_vm_update_params
> + *
> + * Encapsulate some VM table update parameters to reduce
> + * the number of function parameters
> + *
> + */
> +struct amdgpu_vm_update_params {
> +
> +	/**
> +	 * @adev: amdgpu device we do this update for
> +	 */
> +	struct amdgpu_device *adev;
> +
> +	/**
> +	 * @vm: optional amdgpu_vm we do this update for
> +	 */
> +	struct amdgpu_vm *vm;
> +
> +	/**
> +	 * @immediate: if changes should be made immediately
> +	 */
> +	bool immediate;
> +
> +	/**
> +	 * @unlocked: true if the root BO is not locked
> +	 */
> +	bool unlocked;
> +
> +	/**
> +	 * @pages_addr:
> +	 *
> +	 * DMA addresses to use for mapping
> +	 */
> +	dma_addr_t *pages_addr;
> +
> +	/**
> +	 * @job: job to used for hw submission
> +	 */
> +	struct amdgpu_job *job;
> +
> +	/**
> +	 * @num_dw_left: number of dw left for the IB
> +	 */
> +	unsigned int num_dw_left;
> +
> +	/**
> +	 * @needs_flush: true whenever we need to invalidate the TLB
> +	 */
> +	bool needs_flush;
> +
> +	/**
> +	 * @override_pte: true for memory that is not uncached and gmc=20
override
> function is +	 * implemented to allow MTYPE to be overridden for=20
NUMA local
> memory. +	 */
> +	bool override_pte;
> +
> +	/**
> +	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
> +	 */
> +	struct list_head tlb_flush_waitlist;
> +};
> +
> +struct amdgpu_vm_update_funcs {
> +	int (*map_table)(struct amdgpu_bo_vm *bo);
> +	int (*prepare)(struct amdgpu_vm_update_params *p,
> +		       struct amdgpu_sync *sync, u64 k_job_id);
> +	int (*update)(struct amdgpu_vm_update_params *p,
> +		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t=20
addr,
> +		      unsigned count, uint32_t incr, uint64_t flags);
> +	int (*commit)(struct amdgpu_vm_update_params *p,
> +		      struct dma_fence **fence);
> +};
> +
> +int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		       struct amdgpu_bo_vm *vmbo, bool immediate);
> +int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			int level, bool immediate, struct=20
amdgpu_bo_vm **vmbo,
> +			int32_t xcp_id);
> +void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); +int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
> +			 struct amdgpu_vm_bo_base *entry);
> +int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
> +			  uint64_t start, uint64_t end,
> +			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> +			    struct amdgpu_vm_update_params *params);
> +int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); +
> +/*
> + * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-=
=46S
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags =3D memalloc_noreclaim_save();
> +}
> +
> +static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags =3D memalloc_noreclaim_save();
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_noreclaim_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> e43a60d09808..0d7fe32d0c7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_vm_internal.h"
>  #include "amdgpu_job.h"
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
> 430274237689..a6ae2f62f80d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -21,6 +21,7 @@
>   */
>=20
>  #include "amdgpu_vm.h"
> +#include "amdgpu_vm_internal.h"
>  #include "amdgpu_job.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_trace.h"




