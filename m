Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED4C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9928620739
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpQWzG41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9928620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B7B89D5F;
	Tue, 29 Sep 2020 14:25:41 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC69F89D5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:25:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e11so6760687wme.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=89m5o+dFo7BXYmmDEtymABnfihs881TuPds2Duprt5k=;
 b=FpQWzG41KYvK71UKeQEGVNThcoqiwPN/N8TM9SQ7Vi6KjPB8nMQP35SeR7aVqRqp0j
 yeLU8IyJttX0vdziPiluBeoP3zD/PMZuh84l9Dtzqb7VjGrhgBgQGzxj+DNjEsTDcKKR
 nD1+Zj8jPgERwioS/fSONRVVPP2i6GyEWgOrYpJGsrGHbF96InsvMm+o4zqm1LczKYAK
 Rm/yAbUMDoGrauvYyGPmuce5J6DoBuZJegG2dhh/ij7Gz1wbixGi0draK/SUjAG3f8Kq
 gVMZIYF/ypj0t19M/lKsbiSk5hBex5uKPXT1d4GOk9LvQKF+cZhV32GSGND/LzAW/BUm
 3tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=89m5o+dFo7BXYmmDEtymABnfihs881TuPds2Duprt5k=;
 b=ECQUVM/lzivrTndDzkw50JcE8EEbyE+bn9/0n7Fo5Nb04l8zvgjyjaEzFqnEhm/J0Z
 tx0o0Fu+uvYkdeJXSMTkelQj5vfJKGojSAjGgyzsFn4Eg8YRAB1H3JGJ8NJDaob1cA6y
 eCp+7vmddJjf+F7+P+5yXoNkPCHWoXrC5cvyeU7hlhIIptwwlzShp3RX+wFfKSHpUMS9
 dpcSPJX7Lxq08jlOgZVQ8JjXf9weP4C8F9ZF+r2XxnZCE0owBRuZq/y0V+IO+4nqgcfe
 FXq97BmnJQC71kteuvK9llhNj2BWINzMBF/xKHqDT6W29SXK/500xudvKBL2BnNe+ylg
 aB+Q==
X-Gm-Message-State: AOAM533RTlQkht9jHeq3LaUADkmFfSoum65zuhk87JEUzFW9vtJu9fmp
 TkPu8dwZ1A8PX+zsI0gE+AIEWi4ssFL0yKrJ5EKyeB4q
X-Google-Smtp-Source: ABdhPJzScqq2fWTRlzjOPnOTpUPHHi/wPLJxbgQd11v9DrndTZ0q06Vw9BPiHBFP3Sxh8kZItBvduhfHK47IUfytEh4=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr4878601wmc.73.1601389537977; 
 Tue, 29 Sep 2020 07:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <1600384563-10872-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1600384563-10872-1-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 10:25:26 -0400
Message-ID: <CADnq5_OCk_aSg4C2jVDQdJ44u7wpLgeny3EA_j7miGaD+WHOFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use function pointer for gfxhub functions
To: Oak Zeng <Oak.Zeng@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 17, 2020 at 7:16 PM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> gfxhub functions are now called from function pointers,
> instead of from asic-specific functions.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h         | 43 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           | 13 +++++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           | 24 +++++++---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h           | 10 +---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           | 27 +++++++----
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h           | 12 +----
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             | 53 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 28 +++++++++---
>  15 files changed, 155 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 13f92de..0d8ace9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -104,6 +104,7 @@
>  #include "amdgpu_mes.h"
>  #include "amdgpu_umc.h"
>  #include "amdgpu_mmhub.h"
> +#include "amdgpu_gfxhub.h"
>  #include "amdgpu_df.h"
>
>  #define MAX_GPU_INSTANCE               16
> @@ -884,6 +885,9 @@ struct amdgpu_device {
>         /* mmhub */
>         struct amdgpu_mmhub             mmhub;
>
> +       /* gfxhub */
> +       struct amdgpu_gfxhub            gfxhub;
> +
>         /* gfx */
>         struct amdgpu_gfx               gfx;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index df0aab0..1529815 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -32,7 +32,6 @@
>  #include "v10_structs.h"
>  #include "nv.h"
>  #include "nvd.h"
> -#include "gfxhub_v2_0.h"
>
>  enum hqd_dequeue_request_type {
>         NO_ACTION = 0,
> @@ -753,7 +752,7 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
>         }
>
>         /* SDMA is on gfxhub as well for Navi1* series */
> -       gfxhub_v2_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index e12623a..b7ea20e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -31,7 +31,6 @@
>  #include "v10_structs.h"
>  #include "nv.h"
>  #include "nvd.h"
> -#include "gfxhub_v2_1.h"
>
>  enum hqd_dequeue_request_type {
>         NO_ACTION = 0,
> @@ -657,7 +656,7 @@ static void set_vm_context_page_table_base_v10_3(struct kgd_dev *kgd, uint32_t v
>         struct amdgpu_device *adev = get_amdgpu_device(kgd);
>
>         /* SDMA is on gfxhub as well for Navi1* series */
> -       gfxhub_v2_1_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  #if 0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index e6aede7..b824582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -36,9 +36,6 @@
>  #include "v9_structs.h"
>  #include "soc15.h"
>  #include "soc15d.h"
> -#include "mmhub_v1_0.h"
> -#include "gfxhub_v1_0.h"
> -
>
>  enum hqd_dequeue_request_type {
>         NO_ACTION = 0,
> @@ -703,7 +700,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
>
>         adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>
> -       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> new file mode 100644
> index 0000000..66ebc2e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __AMDGPU_GFXHUB_H__
> +#define __AMDGPU_GFXHUB_H__
> +
> +struct amdgpu_gfxhub_funcs {
> +       u64 (*get_fb_location)(struct amdgpu_device *adev);
> +       u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
> +       void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
> +                       uint64_t page_table_base);
> +       int (*gart_enable)(struct amdgpu_device *adev);
> +
> +       void (*gart_disable)(struct amdgpu_device *adev);
> +       void (*set_fault_enable_default)(struct amdgpu_device *adev, bool value);
> +       void (*init)(struct amdgpu_device *adev);
> +       int (*get_xgmi_info)(struct amdgpu_device *adev);
> +};
> +
> +struct amdgpu_gfxhub {
> +       const struct amdgpu_gfxhub_funcs *funcs;
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index 529e463..f4187c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -403,3 +403,13 @@ void gfxhub_v1_0_init(struct amdgpu_device *adev)
>         hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
>                 mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
>  }
> +
> +
> +const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
> +       .get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
> +       .setup_vm_pt_regs = gfxhub_v1_0_setup_vm_pt_regs,
> +       .gart_enable = gfxhub_v1_0_gart_enable,
> +       .gart_disable = gfxhub_v1_0_gart_disable,
> +       .set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
> +       .init = gfxhub_v1_0_init,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> index 92d3a70..0c46672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> @@ -33,4 +33,5 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev);
>  void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
>                                 uint64_t page_table_base);
>
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs;
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> index c0ab71d..1e24b6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "gfxhub_v1_0.h"
>  #include "gfxhub_v1_1.h"
>
>  #include "gc/gc_9_2_1_offset.h"
> @@ -28,7 +29,7 @@
>
>  #include "soc15_common.h"
>
> -int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
> +static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
>  {
>         u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
>         u32 max_region =
> @@ -66,3 +67,13 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
>
>         return 0;
>  }
> +
> +const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs = {
> +       .get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
> +       .setup_vm_pt_regs = gfxhub_v1_0_setup_vm_pt_regs,
> +       .gart_enable = gfxhub_v1_0_gart_enable,
> +       .gart_disable = gfxhub_v1_0_gart_disable,
> +       .set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
> +       .init = gfxhub_v1_0_init,
> +       .get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
> index d753cf2..ae5759f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
> @@ -24,6 +24,6 @@
>  #ifndef __GFXHUB_V1_1_H__
>  #define __GFXHUB_V1_1_H__
>
> -int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev);
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index b882ac5..3386cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -102,7 +102,7 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>                 GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>  }
>
> -u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
>  {
>         u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
>
> @@ -112,12 +112,12 @@ u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
>         return base;
>  }
>
> -u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
>         return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
>  }
>
> -void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> +static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
>                                 uint64_t page_table_base)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -347,7 +347,7 @@ static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
>         }
>  }
>
> -int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
> +static int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
>  {
>         /* GART Enable. */
>         gfxhub_v2_0_init_gart_aperture_regs(adev);
> @@ -363,7 +363,7 @@ int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
> +static void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>         u32 tmp;
> @@ -394,7 +394,7 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
> +static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
>                                           bool value)
>  {
>         u32 tmp;
> @@ -436,7 +436,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
>         .get_invalidate_req = gfxhub_v2_0_get_invalidate_req,
>  };
>
> -void gfxhub_v2_0_init(struct amdgpu_device *adev)
> +static void gfxhub_v2_0_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>
> @@ -477,3 +477,13 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
>
>         hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
>  }
> +
> +const struct amdgpu_gfxhub_funcs gfxhub_v2_0_funcs = {
> +       .get_fb_location = gfxhub_v2_0_get_fb_location,
> +       .get_mc_fb_offset = gfxhub_v2_0_get_mc_fb_offset,
> +       .setup_vm_pt_regs = gfxhub_v2_0_setup_vm_pt_regs,
> +       .gart_enable = gfxhub_v2_0_gart_enable,
> +       .gart_disable = gfxhub_v2_0_gart_disable,
> +       .set_fault_enable_default = gfxhub_v2_0_set_fault_enable_default,
> +       .init = gfxhub_v2_0_init,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> index 392b8cd..9ddc35cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> @@ -24,14 +24,6 @@
>  #ifndef __GFXHUB_V2_0_H__
>  #define __GFXHUB_V2_0_H__
>
> -u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev);
> -int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev);
> -void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev);
> -void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
> -                                         bool value);
> -void gfxhub_v2_0_init(struct amdgpu_device *adev);
> -u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev);
> -void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v2_0_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 237a9ff..98f2c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -102,7 +102,7 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
>                 GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>  }
>
> -u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
>  {
>         u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
>
> @@ -112,12 +112,12 @@ u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
>         return base;
>  }
>
> -u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
>         return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
>  }
>
> -void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> +static void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
>                                 uint64_t page_table_base)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -348,7 +348,7 @@ static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
>         }
>  }
>
> -int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
> +static int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
>  {
>         if (amdgpu_sriov_vf(adev)) {
>                 /*
> @@ -376,7 +376,7 @@ int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
> +static void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>         u32 tmp;
> @@ -405,7 +405,7 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
> +static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
>                                           bool value)
>  {
>         u32 tmp;
> @@ -454,7 +454,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
>         .get_invalidate_req = gfxhub_v2_1_get_invalidate_req,
>  };
>
> -void gfxhub_v2_1_init(struct amdgpu_device *adev)
> +static void gfxhub_v2_1_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>
> @@ -496,7 +496,7 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
>         hub->vmhub_funcs = &gfxhub_v2_1_vmhub_funcs;
>  }
>
> -int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
> +static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
>  {
>         u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmGCMC_VM_XGMI_LFB_CNTL);
>         u32 max_region =
> @@ -531,3 +531,14 @@ int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
>
>         return 0;
>  }
> +
> +const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
> +       .get_fb_location = gfxhub_v2_1_get_fb_location,
> +       .get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
> +       .setup_vm_pt_regs = gfxhub_v2_1_setup_vm_pt_regs,
> +       .gart_enable = gfxhub_v2_1_gart_enable,
> +       .gart_disable = gfxhub_v2_1_gart_disable,
> +       .set_fault_enable_default = gfxhub_v2_1_set_fault_enable_default,
> +       .init = gfxhub_v2_1_init,
> +       .get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
> index 3452a4e..f75c2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
> @@ -24,16 +24,6 @@
>  #ifndef __GFXHUB_V2_1_H__
>  #define __GFXHUB_V2_1_H__
>
> -u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev);
> -int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev);
> -void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev);
> -void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
> -                                         bool value);
> -void gfxhub_v2_1_init(struct amdgpu_device *adev);
> -u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev);
> -void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> -
> -int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev);
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 31359e5..dbc8b76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -634,11 +634,26 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
>         adev->mmhub.funcs = &mmhub_v2_0_funcs;
>  }
>
> +static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
> +{
> +       switch (adev->asic_type) {
> +       case CHIP_SIENNA_CICHLID:
> +       case CHIP_NAVY_FLOUNDER:
> +               adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
> +               break;
> +       default:
> +               adev->gfxhub.funcs = &gfxhub_v2_0_funcs;
> +               break;
> +       }
> +}
> +
> +
>  static int gmc_v10_0_early_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         gmc_v10_0_set_mmhub_funcs(adev);
> +       gmc_v10_0_set_gfxhub_funcs(adev);
>         gmc_v10_0_set_gmc_funcs(adev);
>         gmc_v10_0_set_irq_funcs(adev);
>         gmc_v10_0_set_umc_funcs(adev);
> @@ -676,11 +691,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>  {
>         u64 base = 0;
>
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               base = gfxhub_v2_1_get_fb_location(adev);
> -       else
> -               base = gfxhub_v2_0_get_fb_location(adev);
> +       base = adev->gfxhub.funcs->get_fb_location(adev);
>
>         /* add the xgmi offset of the physical node */
>         base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> @@ -689,11 +700,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>         amdgpu_gmc_gart_location(adev, mc);
>
>         /* base offset of vram pages */
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               adev->vm_manager.vram_base_offset = gfxhub_v2_1_get_mc_fb_offset(adev);
> -       else
> -               adev->vm_manager.vram_base_offset = gfxhub_v2_0_get_mc_fb_offset(adev);
> +       adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>
>         /* add the xgmi offset of the physical node */
>         adev->vm_manager.vram_base_offset +=
> @@ -777,11 +784,7 @@ static int gmc_v10_0_sw_init(void *handle)
>         int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               gfxhub_v2_1_init(adev);
> -       else
> -               gfxhub_v2_0_init(adev);
> +       adev->gfxhub.funcs->init(adev);
>
>         adev->mmhub.funcs->init(adev);
>
> @@ -852,7 +855,7 @@ static int gmc_v10_0_sw_init(void *handle)
>         }
>
>         if (adev->gmc.xgmi.supported) {
> -               r = gfxhub_v2_1_get_xgmi_info(adev);
> +               r = adev->gfxhub.funcs->get_xgmi_info(adev);
>                 if (r)
>                         return r;
>         }
> @@ -944,11 +947,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               r = gfxhub_v2_1_gart_enable(adev);
> -       else
> -               r = gfxhub_v2_0_gart_enable(adev);
> +       r = adev->gfxhub.funcs->gart_enable(adev);
>         if (r)
>                 return r;
>
> @@ -969,11 +968,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>         value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
>                 false : true;
>
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               gfxhub_v2_1_set_fault_enable_default(adev, value);
> -       else
> -               gfxhub_v2_0_set_fault_enable_default(adev, value);
> +       adev->gfxhub.funcs->set_fault_enable_default(adev, value);
>         adev->mmhub.funcs->set_fault_enable_default(adev, value);
>         gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
>         gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
> @@ -1014,11 +1009,7 @@ static int gmc_v10_0_hw_init(void *handle)
>   */
>  static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>  {
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               gfxhub_v2_1_gart_disable(adev);
> -       else
> -               gfxhub_v2_0_gart_disable(adev);
> +       adev->gfxhub.funcs->gart_disable(adev);
>         adev->mmhub.funcs->gart_disable(adev);
>         amdgpu_gart_table_vram_unpin(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d5679d1..7e481af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1164,6 +1164,19 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
>         }
>  }
>
> +static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
> +{
> +       switch (adev->asic_type) {
> +       case CHIP_ARCTURUS:
> +       case CHIP_VEGA20:
> +               adev->gfxhub.funcs = &gfxhub_v1_1_funcs;
> +               break;
> +       default:
> +               adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
> +               break;
> +       }
> +}
> +
>  static int gmc_v9_0_early_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1172,6 +1185,7 @@ static int gmc_v9_0_early_init(void *handle)
>         gmc_v9_0_set_irq_funcs(adev);
>         gmc_v9_0_set_umc_funcs(adev);
>         gmc_v9_0_set_mmhub_funcs(adev);
> +       gmc_v9_0_set_gfxhub_funcs(adev);
>
>         adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
>         adev->gmc.shared_aperture_end =
> @@ -1234,7 +1248,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>         amdgpu_gmc_gart_location(adev, mc);
>         amdgpu_gmc_agp_location(adev, mc);
>         /* base offset of vram pages */
> -       adev->vm_manager.vram_base_offset = gfxhub_v1_0_get_mc_fb_offset(adev);
> +       adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>
>         /* XXX: add the xgmi offset of the physical node? */
>         adev->vm_manager.vram_base_offset +=
> @@ -1269,7 +1283,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>
>  #ifdef CONFIG_X86_64
>         if (adev->flags & AMD_IS_APU) {
> -               adev->gmc.aper_base = gfxhub_v1_0_get_mc_fb_offset(adev);
> +               adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>                 adev->gmc.aper_size = adev->gmc.real_vram_size;
>         }
>  #endif
> @@ -1339,7 +1353,7 @@ static int gmc_v9_0_sw_init(void *handle)
>         int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       gfxhub_v1_0_init(adev);
> +       adev->gfxhub.funcs->init(adev);
>
>         adev->mmhub.funcs->init(adev);
>
> @@ -1453,7 +1467,7 @@ static int gmc_v9_0_sw_init(void *handle)
>         adev->need_swiotlb = drm_need_swiotlb(44);
>
>         if (adev->gmc.xgmi.supported) {
> -               r = gfxhub_v1_1_get_xgmi_info(adev);
> +               r = adev->gfxhub.funcs->get_xgmi_info(adev);
>                 if (r)
>                         return r;
>         }
> @@ -1569,7 +1583,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       r = gfxhub_v1_0_gart_enable(adev);
> +       r = adev->gfxhub.funcs->gart_enable(adev);
>         if (r)
>                 return r;
>
> @@ -1636,7 +1650,7 @@ static int gmc_v9_0_hw_init(void *handle)
>                 value = true;
>
>         if (!amdgpu_sriov_vf(adev)) {
> -               gfxhub_v1_0_set_fault_enable_default(adev, value);
> +               adev->gfxhub.funcs->set_fault_enable_default(adev, value);
>                 adev->mmhub.funcs->set_fault_enable_default(adev, value);
>         }
>         for (i = 0; i < adev->num_vmhubs; ++i)
> @@ -1659,7 +1673,7 @@ static int gmc_v9_0_hw_init(void *handle)
>   */
>  static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>  {
> -       gfxhub_v1_0_gart_disable(adev);
> +       adev->gfxhub.funcs->gart_disable(adev);
>         adev->mmhub.funcs->gart_disable(adev);
>         amdgpu_gart_table_vram_unpin(adev);
>  }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
