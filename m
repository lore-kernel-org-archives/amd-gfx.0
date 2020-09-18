Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1848C43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 09:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F034206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 09:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgRPaD2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F034206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8046E123;
	Fri, 18 Sep 2020 09:03:02 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE7D6E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 09:03:00 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id j11so7159982ejk.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FaOCfBaJa0gccscUAYVUSpbHiubf/kKKYZBwXeDJ2QQ=;
 b=UgRPaD2iXyRRj9keV+q0jzx36UoYeAN+y5XZRiUn7HAAiXH3pguRPS6TZeSxtZZAp0
 W24wOY/kKjk+SXdxWZ81EIhH3QloywNX5sMR5zdKQvud3Vp1x360OuuLDPuFVGCHpS2c
 GCwjfgFuZIfIlErrPRPCMqEWuq9y5Yev08Pg/WjaEIssVWnUXeTCuvfi6aYtjXpQIego
 cq8rC8B/0cJLRDGMbKtZg9hQMhwT+96+gFj3EPRr2zQv2dvM+lPyeylxGAhCn3O7DZMH
 rkjCgwfHFNrtYkCVDwrnzaE1rflE7aeyxcTIZdwe2zz8rvAFX9xhuYcRFKtkArnhBgDB
 +ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FaOCfBaJa0gccscUAYVUSpbHiubf/kKKYZBwXeDJ2QQ=;
 b=penKCUB1ZYXg0ZPHUAYLPhDsXy1gDTc9i/LXLZknG5PZgDF1nDn4rh8CFCrf2u8bwm
 hSnBqWOHZHkbfoY8uBItooHG6M2h6afyVg7bhyInpHze19hugNhL7Z57RfbeOm/5dJBi
 6CNsDKAt+UtOWj14b1kpSh1k6TUfA2jDjxvSpgc/fedr+56baoh1aG4LDNwVLQDtZJyf
 YXgoRyTOEUKe5UUsX2hMa6me7IMh0fsUM5doT7sy2FcSeXNDC1Gwyl/aN+8nhc4Q0j/P
 aCLbH6HYPfdc4XZk8m/zL/B5Lmr/G/Q2sZ4JtLieSQ+9uMer9jdxsTIPVWsh1e1/UiXE
 AwCQ==
X-Gm-Message-State: AOAM5309kJ8hQ+65DHkI2lhWNyy5pBtVjbC1WMvNIOzbum4Cm9wefmMt
 vwZ8INksFdaMfKQjxAalFTaZ/qz14iD6HeQTRMTwTSd0QJF9cA==
X-Google-Smtp-Source: ABdhPJyIAGWHjYpe6TUJEuYPmn5rcBrOCRxl019bLR1QWblJk4CmuooCZP2HYWsWNNaanx20ihZJMfdZSyRHCiKUDNM=
X-Received: by 2002:a17:906:9443:: with SMTP id
 z3mr36583921ejx.156.1600419779399; 
 Fri, 18 Sep 2020 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1600384563-10872-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1600384563-10872-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Fri, 18 Sep 2020 11:02:48 +0200
Message-ID: <CAD=4a=Udh7m7otpHy6L8my+fZ+9wzj4m-Gety2ntPL6jtikHnw@mail.gmail.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0014138985=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0014138985==
Content-Type: multipart/alternative; boundary="0000000000007155e905af92c423"

--0000000000007155e905af92c423
Content-Type: text/plain; charset="UTF-8"

Can some of them be null and others not? Perhaps write that in the comments
somewhere.
Like v1 doesn't have get_fb_location for example.

Regards
//Ernst

Den fre 18 sep. 2020 kl 01:16 skrev Oak Zeng <Oak.Zeng@amd.com>:

> gfxhub functions are now called from function pointers,
> instead of from asic-specific functions.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
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
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             | 53
> +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 28 +++++++++---
>  15 files changed, 155 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
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
> @@ -753,7 +752,7 @@ static void set_vm_context_page_table_base(struct
> kgd_dev *kgd, uint32_t vmid,
>         }
>
>         /* SDMA is on gfxhub as well for Navi1* series */
> -       gfxhub_v2_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
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
> @@ -657,7 +656,7 @@ static void
> set_vm_context_page_table_base_v10_3(struct kgd_dev *kgd, uint32_t v
>         struct amdgpu_device *adev = get_amdgpu_device(kgd);
>
>         /* SDMA is on gfxhub as well for Navi1* series */
> -       gfxhub_v2_1_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  #if 0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
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
> @@ -703,7 +700,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct
> kgd_dev *kgd,
>
>         adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>
> -       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
>
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> new file mode 100644
> index 0000000..66ebc2e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
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
> +       void (*set_fault_enable_default)(struct amdgpu_device *adev, bool
> value);
> +       void (*init)(struct amdgpu_device *adev);
> +       int (*get_xgmi_info)(struct amdgpu_device *adev);
> +};
> +
> +struct amdgpu_gfxhub {
> +       const struct amdgpu_gfxhub_funcs *funcs;
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> index 92d3a70..0c46672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> @@ -33,4 +33,5 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device
> *adev);
>  void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
>                                 uint64_t page_table_base);
>
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs;
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
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
> @@ -66,3 +67,13 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device
> *adev)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index b882ac5..3386cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -102,7 +102,7 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct
> amdgpu_device *adev,
>                 GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>  }
>
> -u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
>  {
>         u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
>
> @@ -112,12 +112,12 @@ u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device
> *adev)
>         return base;
>  }
>
> -u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
>         return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
>  }
>
> -void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> +static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
> uint32_t vmid,
>                                 uint64_t page_table_base)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -347,7 +347,7 @@ static void gfxhub_v2_0_program_invalidation(struct
> amdgpu_device *adev)
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
> @@ -394,7 +394,7 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device
> *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
> +static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device
> *adev,
>                                           bool value)
>  {
>         u32 tmp;
> @@ -436,7 +436,7 @@ static const struct amdgpu_vmhub_funcs
> gfxhub_v2_0_vmhub_funcs = {
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
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
> -void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> -                               uint64_t page_table_base);
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v2_0_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 237a9ff..98f2c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -102,7 +102,7 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct
> amdgpu_device *adev,
>                 GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>  }
>
> -u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
>  {
>         u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
>
> @@ -112,12 +112,12 @@ u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device
> *adev)
>         return base;
>  }
>
> -u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
> +static u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
>         return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
>  }
>
> -void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> +static void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev,
> uint32_t vmid,
>                                 uint64_t page_table_base)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
> @@ -348,7 +348,7 @@ static void gfxhub_v2_1_program_invalidation(struct
> amdgpu_device *adev)
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
> @@ -405,7 +405,7 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device
> *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
> +static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device
> *adev,
>                                           bool value)
>  {
>         u32 tmp;
> @@ -454,7 +454,7 @@ static const struct amdgpu_vmhub_funcs
> gfxhub_v2_1_vmhub_funcs = {
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
> @@ -531,3 +531,14 @@ int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device
> *adev)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
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
> -void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> -                               uint64_t page_table_base);
> -
> -int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev);
> +extern const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 31359e5..dbc8b76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -634,11 +634,26 @@ static void gmc_v10_0_set_mmhub_funcs(struct
> amdgpu_device *adev)
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
> @@ -676,11 +691,7 @@ static void gmc_v10_0_vram_gtt_location(struct
> amdgpu_device *adev,
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
>         base += adev->gmc.xgmi.physical_node_id *
> adev->gmc.xgmi.node_segment_size;
> @@ -689,11 +700,7 @@ static void gmc_v10_0_vram_gtt_location(struct
> amdgpu_device *adev,
>         amdgpu_gmc_gart_location(adev, mc);
>
>         /* base offset of vram pages */
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -           adev->asic_type == CHIP_NAVY_FLOUNDER)
> -               adev->vm_manager.vram_base_offset =
> gfxhub_v2_1_get_mc_fb_offset(adev);
> -       else
> -               adev->vm_manager.vram_base_offset =
> gfxhub_v2_0_get_mc_fb_offset(adev);
> +       adev->vm_manager.vram_base_offset =
> adev->gfxhub.funcs->get_mc_fb_offset(adev);
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
> @@ -944,11 +947,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device
> *adev)
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
> @@ -969,11 +968,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device
> *adev)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d5679d1..7e481af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1164,6 +1164,19 @@ static void gmc_v9_0_set_mmhub_funcs(struct
> amdgpu_device *adev)
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
> @@ -1234,7 +1248,7 @@ static void gmc_v9_0_vram_gtt_location(struct
> amdgpu_device *adev,
>         amdgpu_gmc_gart_location(adev, mc);
>         amdgpu_gmc_agp_location(adev, mc);
>         /* base offset of vram pages */
> -       adev->vm_manager.vram_base_offset =
> gfxhub_v1_0_get_mc_fb_offset(adev);
> +       adev->vm_manager.vram_base_offset =
> adev->gfxhub.funcs->get_mc_fb_offset(adev);
>
>         /* XXX: add the xgmi offset of the physical node? */
>         adev->vm_manager.vram_base_offset +=
> @@ -1269,7 +1283,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device
> *adev)
>
>  #ifdef CONFIG_X86_64
>         if (adev->flags & AMD_IS_APU) {
> -               adev->gmc.aper_base = gfxhub_v1_0_get_mc_fb_offset(adev);
> +               adev->gmc.aper_base =
> adev->gfxhub.funcs->get_mc_fb_offset(adev);
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
> @@ -1569,7 +1583,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device
> *adev)
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
>

--0000000000007155e905af92c423
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Can some of them be null and others not? Perhaps write =
that in the comments somewhere.</div><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">Like v1 doesn&#39;t have get_fb_loc=
ation for example.</div><div class=3D"gmail_default" style=3D"font-family:a=
rial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">Regards</div><div class=3D"gmail_de=
fault" style=3D"font-family:arial,helvetica,sans-serif">//Ernst<br></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">De=
n fre 18 sep. 2020 kl 01:16 skrev Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@a=
md.com">Oak.Zeng@amd.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">gfxhub functions are now called from function pointers,<b=
r>
instead of from asic-specific functions.<br>
<br>
Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@amd.com" target=3D"_=
blank">Oak.Zeng@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |=C2=A0 3 +-<br>
=C2=A0.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c=C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c=C2=A0 |=C2=A0 5 +-<=
br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 43 ++++++++++++++++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 10 ++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 13 +++++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 24 +++++++---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 10 +---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 27 +++++++----<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 12 +----<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 53 +++++++++-------------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 28 +++++++++---<br>
=C2=A015 files changed, 155 insertions(+), 83 deletions(-)<br>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 13f92de..0d8ace9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -104,6 +104,7 @@<br>
=C2=A0#include &quot;amdgpu_mes.h&quot;<br>
=C2=A0#include &quot;amdgpu_umc.h&quot;<br>
=C2=A0#include &quot;amdgpu_mmhub.h&quot;<br>
+#include &quot;amdgpu_gfxhub.h&quot;<br>
=C2=A0#include &quot;amdgpu_df.h&quot;<br>
<br>
=C2=A0#define MAX_GPU_INSTANCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016<br>
@@ -884,6 +885,9 @@ struct amdgpu_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mmhub */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_mmhub=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mmhub;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* gfxhub */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_gfxhub=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 gfxhub;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gfx */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_gfx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx;<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
index df0aab0..1529815 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
@@ -32,7 +32,6 @@<br>
=C2=A0#include &quot;v10_structs.h&quot;<br>
=C2=A0#include &quot;nv.h&quot;<br>
=C2=A0#include &quot;nvd.h&quot;<br>
-#include &quot;gfxhub_v2_0.h&quot;<br>
<br>
=C2=A0enum hqd_dequeue_request_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NO_ACTION =3D 0,<br>
@@ -753,7 +752,7 @@ static void set_vm_context_page_table_base(struct kgd_d=
ev *kgd, uint32_t vmid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SDMA is on gfxhub as well for Navi1* series =
*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_0_setup_vm_pt_regs(adev, vmid, page_t=
able_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;setup_vm_pt_regs(adev=
, vmid, page_table_base);<br>
=C2=A0}<br>
<br>
=C2=A0const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
index e12623a..b7ea20e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
@@ -31,7 +31,6 @@<br>
=C2=A0#include &quot;v10_structs.h&quot;<br>
=C2=A0#include &quot;nv.h&quot;<br>
=C2=A0#include &quot;nvd.h&quot;<br>
-#include &quot;gfxhub_v2_1.h&quot;<br>
<br>
=C2=A0enum hqd_dequeue_request_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NO_ACTION =3D 0,<br>
@@ -657,7 +656,7 @@ static void set_vm_context_page_table_base_v10_3(struct=
 kgd_dev *kgd, uint32_t v<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D get_amdgpu_devic=
e(kgd);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SDMA is on gfxhub as well for Navi1* series =
*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_1_setup_vm_pt_regs(adev, vmid, page_t=
able_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;setup_vm_pt_regs(adev=
, vmid, page_table_base);<br>
=C2=A0}<br>
<br>
=C2=A0#if 0<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index e6aede7..b824582 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -36,9 +36,6 @@<br>
=C2=A0#include &quot;v9_structs.h&quot;<br>
=C2=A0#include &quot;soc15.h&quot;<br>
=C2=A0#include &quot;soc15d.h&quot;<br>
-#include &quot;mmhub_v1_0.h&quot;<br>
-#include &quot;gfxhub_v1_0.h&quot;<br>
-<br>
<br>
=C2=A0enum hqd_dequeue_request_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NO_ACTION =3D 0,<br>
@@ -703,7 +700,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct k=
gd_dev *kgd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;setup_vm_pt_regs(adev,=
 vmid, page_table_base);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_t=
able_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;setup_vm_pt_regs(adev=
, vmid, page_table_base);<br>
=C2=A0}<br>
<br>
=C2=A0const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gfxhub.h<br>
new file mode 100644<br>
index 0000000..66ebc2e<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h<br>
@@ -0,0 +1,43 @@<br>
+/*<br>
+ * Copyright 2020 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ */<br>
+#ifndef __AMDGPU_GFXHUB_H__<br>
+#define __AMDGPU_GFXHUB_H__<br>
+<br>
+struct amdgpu_gfxhub_funcs {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 (*get_fb_location)(struct amdgpu_device *ad=
ev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 (*get_mc_fb_offset)(struct amdgpu_device *a=
dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*setup_vm_pt_regs)(struct amdgpu_device *=
adev, uint32_t vmid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint64_t page_table_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*gart_enable)(struct amdgpu_device *adev);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*gart_disable)(struct amdgpu_device *adev=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*set_fault_enable_default)(struct amdgpu_=
device *adev, bool value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*init)(struct amdgpu_device *adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*get_xgmi_info)(struct amdgpu_device *adev=
);<br>
+};<br>
+<br>
+struct amdgpu_gfxhub {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct amdgpu_gfxhub_funcs *funcs;<br>
+};<br>
+<br>
+#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c<br>
index 529e463..f4187c3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
@@ -403,3 +403,13 @@ void gfxhub_v1_0_init(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hub-&gt;eng_addr_distance =3D mmVM_INVALIDATE_E=
NG1_ADDR_RANGE_LO32 -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmVM_INVALIDATE_ENG=
0_ADDR_RANGE_LO32;<br>
=C2=A0}<br>
+<br>
+<br>
+const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_mc_fb_offset =3D gfxhub_v1_0_get_mc_fb_off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup_vm_pt_regs =3D gfxhub_v1_0_setup_vm_pt_r=
egs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_enable =3D gfxhub_v1_0_gart_enable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_disable =3D gfxhub_v1_0_gart_disable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_fault_enable_default =3D gfxhub_v1_0_set_f=
ault_enable_default,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.init =3D gfxhub_v1_0_init,<br>
+};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.h<br>
index 92d3a70..0c46672 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h<br>
@@ -33,4 +33,5 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *ad=
ev);<br>
=C2=A0void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_=
t vmid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t page_table_base);<br>
<br>
+extern const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs;<br>
=C2=A0#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_1.c<br>
index c0ab71d..1e24b6d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c<br>
@@ -21,6 +21,7 @@<br>
=C2=A0 *<br>
=C2=A0 */<br>
=C2=A0#include &quot;amdgpu.h&quot;<br>
+#include &quot;gfxhub_v1_0.h&quot;<br>
=C2=A0#include &quot;gfxhub_v1_1.h&quot;<br>
<br>
=C2=A0#include &quot;gc/gc_9_2_1_offset.h&quot;<br>
@@ -28,7 +29,7 @@<br>
<br>
=C2=A0#include &quot;soc15_common.h&quot;<br>
<br>
-int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)<br>
+static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 xgmi_lfb_cntl =3D RREG32_SOC15(GC, 0, mmMC_=
VM_XGMI_LFB_CNTL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 max_region =3D<br>
@@ -66,3 +67,13 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
+<br>
+const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_mc_fb_offset =3D gfxhub_v1_0_get_mc_fb_off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup_vm_pt_regs =3D gfxhub_v1_0_setup_vm_pt_r=
egs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_enable =3D gfxhub_v1_0_gart_enable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_disable =3D gfxhub_v1_0_gart_disable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_fault_enable_default =3D gfxhub_v1_0_set_f=
ault_enable_default,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.init =3D gfxhub_v1_0_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_xgmi_info =3D gfxhub_v1_1_get_xgmi_info,<b=
r>
+};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_1.h<br>
index d753cf2..ae5759f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h<br>
@@ -24,6 +24,6 @@<br>
=C2=A0#ifndef __GFXHUB_V1_1_H__<br>
=C2=A0#define __GFXHUB_V1_1_H__<br>
<br>
-int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev);<br>
+extern const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs;<br>
<br>
=C2=A0#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index b882ac5..3386cfa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -102,7 +102,7 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amd=
gpu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GCVM_L2_PROTECTION_=
FAULT_STATUS, RW));<br>
=C2=A0}<br>
<br>
-u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)<br>
+static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 base =3D RREG32_SOC15(GC, 0, mmGCMC_VM_FB_L=
OCATION_BASE);<br>
<br>
@@ -112,12 +112,12 @@ u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device =
*adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return base;<br>
=C2=A0}<br>
<br>
-u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)<br>
+static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OF=
FSET) &lt;&lt; 24;<br>
=C2=A0}<br>
<br>
-void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,<br>
+static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint3=
2_t vmid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t page_table_base)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
@@ -347,7 +347,7 @@ static void gfxhub_v2_0_program_invalidation(struct amd=
gpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)<br>
+static int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* GART Enable. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gfxhub_v2_0_init_gart_aperture_regs(adev);<br>
@@ -363,7 +363,7 @@ int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)<br>
+static void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tmp;<br>
@@ -394,7 +394,7 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device *ade=
v)<br>
=C2=A0 * @adev: amdgpu_device pointer<br>
=C2=A0 * @value: true redirects VM faults to the default page<br>
=C2=A0 */<br>
-void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,<br>
+static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *ade=
v,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool value)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tmp;<br>
@@ -436,7 +436,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhu=
b_funcs =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_invalidate_req =3D gfxhub_v2_0_get_invalid=
ate_req,<br>
=C2=A0};<br>
<br>
-void gfxhub_v2_0_init(struct amdgpu_device *adev)<br>
+static void gfxhub_v2_0_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
<br>
@@ -477,3 +477,13 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hub-&gt;vmhub_funcs =3D &amp;gfxhub_v2_0_vmhub_=
funcs;<br>
=C2=A0}<br>
+<br>
+const struct amdgpu_gfxhub_funcs gfxhub_v2_0_funcs =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_fb_location =3D gfxhub_v2_0_get_fb_locatio=
n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_mc_fb_offset =3D gfxhub_v2_0_get_mc_fb_off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup_vm_pt_regs =3D gfxhub_v2_0_setup_vm_pt_r=
egs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_enable =3D gfxhub_v2_0_gart_enable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_disable =3D gfxhub_v2_0_gart_disable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_fault_enable_default =3D gfxhub_v2_0_set_f=
ault_enable_default,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.init =3D gfxhub_v2_0_init,<br>
+};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.h<br>
index 392b8cd..9ddc35cd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h<br>
@@ -24,14 +24,6 @@<br>
=C2=A0#ifndef __GFXHUB_V2_0_H__<br>
=C2=A0#define __GFXHUB_V2_0_H__<br>
<br>
-u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev);<br>
-int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev);<br>
-void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev);<br>
-void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol value);<br>
-void gfxhub_v2_0_init(struct amdgpu_device *adev);<br>
-u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev);<br>
-void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t page_table_base);<br>
+extern const struct amdgpu_gfxhub_funcs gfxhub_v2_0_funcs;<br>
<br>
=C2=A0#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c<br>
index 237a9ff..98f2c53 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
@@ -102,7 +102,7 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct amd=
gpu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GCVM_L2_PROTECTION_=
FAULT_STATUS, RW));<br>
=C2=A0}<br>
<br>
-u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)<br>
+static u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 base =3D RREG32_SOC15(GC, 0, mmGCMC_VM_FB_L=
OCATION_BASE);<br>
<br>
@@ -112,12 +112,12 @@ u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device =
*adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return base;<br>
=C2=A0}<br>
<br>
-u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)<br>
+static u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OF=
FSET) &lt;&lt; 24;<br>
=C2=A0}<br>
<br>
-void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,<br>
+static void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint3=
2_t vmid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t page_table_base)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
@@ -348,7 +348,7 @@ static void gfxhub_v2_1_program_invalidation(struct amd=
gpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)<br>
+static int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_sriov_vf(adev)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
@@ -376,7 +376,7 @@ int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)<br>
+static void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tmp;<br>
@@ -405,7 +405,7 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *ade=
v)<br>
=C2=A0 * @adev: amdgpu_device pointer<br>
=C2=A0 * @value: true redirects VM faults to the default page<br>
=C2=A0 */<br>
-void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,<br>
+static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *ade=
v,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool value)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tmp;<br>
@@ -454,7 +454,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhu=
b_funcs =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_invalidate_req =3D gfxhub_v2_1_get_invalid=
ate_req,<br>
=C2=A0};<br>
<br>
-void gfxhub_v2_1_init(struct amdgpu_device *adev)<br>
+static void gfxhub_v2_1_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhu=
b[AMDGPU_GFXHUB_0];<br>
<br>
@@ -496,7 +496,7 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hub-&gt;vmhub_funcs =3D &amp;gfxhub_v2_1_vmhub_=
funcs;<br>
=C2=A0}<br>
<br>
-int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)<br>
+static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 xgmi_lfb_cntl =3D RREG32_SOC15(GC, 0, mmGCM=
C_VM_XGMI_LFB_CNTL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 max_region =3D<br>
@@ -531,3 +531,14 @@ int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *ad=
ev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
+<br>
+const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_fb_location =3D gfxhub_v2_1_get_fb_locatio=
n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_mc_fb_offset =3D gfxhub_v2_1_get_mc_fb_off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup_vm_pt_regs =3D gfxhub_v2_1_setup_vm_pt_r=
egs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_enable =3D gfxhub_v2_1_gart_enable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.gart_disable =3D gfxhub_v2_1_gart_disable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_fault_enable_default =3D gfxhub_v2_1_set_f=
ault_enable_default,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.init =3D gfxhub_v2_1_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_xgmi_info =3D gfxhub_v2_1_get_xgmi_info,<b=
r>
+};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.h<br>
index 3452a4e..f75c2ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h<br>
@@ -24,16 +24,6 @@<br>
=C2=A0#ifndef __GFXHUB_V2_1_H__<br>
=C2=A0#define __GFXHUB_V2_1_H__<br>
<br>
-u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev);<br>
-int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev);<br>
-void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev);<br>
-void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol value);<br>
-void gfxhub_v2_1_init(struct amdgpu_device *adev);<br>
-u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev);<br>
-void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t page_table_base);<br>
-<br>
-int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev);<br>
+extern const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs;<br>
<br>
=C2=A0#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index 31359e5..dbc8b76 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -634,11 +634,26 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_d=
evice *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs =3D &amp;mmhub_v2_0_funcs;=
<br>
=C2=A0}<br>
<br>
+static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (adev-&gt;asic_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_SIENNA_CICHLID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_NAVY_FLOUNDER:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.fun=
cs =3D &amp;gfxhub_v2_1_funcs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.fun=
cs =3D &amp;gfxhub_v2_0_funcs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+<br>
=C2=A0static int gmc_v10_0_early_init(void *handle)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_set_mmhub_funcs(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0gmc_v10_0_set_gfxhub_funcs(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_set_gmc_funcs(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_set_irq_funcs(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_set_umc_funcs(adev);<br>
@@ -676,11 +691,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_=
device *adev,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 base =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D gfxhub_v2_=
1_get_fb_location(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D gfxhub_v2_=
0_get_fb_location(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D adev-&gt;gfxhub.funcs-&gt;get_fb_locat=
ion(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add the xgmi offset of the physical node */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 base +=3D adev-&gt;gmc.xgmi.physical_node_id * =
adev-&gt;gmc.xgmi.node_segment_size;<br>
@@ -689,11 +700,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_=
device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gmc_gart_location(adev, mc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* base offset of vram pages */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;vm_manager=
.vram_base_offset =3D gfxhub_v2_1_get_mc_fb_offset(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;vm_manager=
.vram_base_offset =3D gfxhub_v2_0_get_mc_fb_offset(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;vm_manager.vram_base_offset =3D adev-&=
gt;gfxhub.funcs-&gt;get_mc_fb_offset(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add the xgmi offset of the physical node */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;vm_manager.vram_base_offset +=3D<br>
@@ -777,11 +784,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r, vram_width =3D 0, vram_type =3D 0, vram_=
vendor =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_1_init(ad=
ev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_0_init(ad=
ev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;init(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;init(adev);<br>
<br>
@@ -852,7 +855,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;gmc.xgmi.supported) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D gfxhub_v2_1_g=
et_xgmi_info(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D adev-&gt;gfxh=
ub.funcs-&gt;get_xgmi_info(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -944,11 +947,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device =
*adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D gfxhub_v2_1_g=
art_enable(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D gfxhub_v2_0_g=
art_enable(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D adev-&gt;gfxhub.funcs-&gt;gart_enable(ade=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
<br>
@@ -969,11 +968,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device =
*adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_V=
M_FAULT_STOP_ALWAYS) ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false : true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_1_set_fau=
lt_enable_default(adev, value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_0_set_fau=
lt_enable_default(adev, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;set_fault_enable_defa=
ult(adev, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;set_fault_enable_defau=
lt(adev, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0=
, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_=
0, 0);<br>
@@ -1014,11 +1009,7 @@ static int gmc_v10_0_hw_init(void *handle)<br>
=C2=A0 */<br>
=C2=A0static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHL=
ID ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;asic_type =3D=3D CHIP_NA=
VY_FLOUNDER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_1_gart_di=
sable(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v2_0_gart_di=
sable(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;gart_disable(adev);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;gart_disable(adev);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gart_table_vram_unpin(adev);<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index d5679d1..7e481af 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1164,6 +1164,19 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_d=
evice *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (adev-&gt;asic_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_ARCTURUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_VEGA20:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.fun=
cs =3D &amp;gfxhub_v1_1_funcs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.fun=
cs =3D &amp;gfxhub_v1_0_funcs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0static int gmc_v9_0_early_init(void *handle)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
@@ -1172,6 +1185,7 @@ static int gmc_v9_0_early_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v9_0_set_irq_funcs(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v9_0_set_umc_funcs(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmc_v9_0_set_mmhub_funcs(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0gmc_v9_0_set_gfxhub_funcs(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.shared_aperture_start =3D 0x200000=
0000000000ULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.shared_aperture_end =3D<br>
@@ -1234,7 +1248,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_=
device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gmc_gart_location(adev, mc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gmc_agp_location(adev, mc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* base offset of vram pages */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;vm_manager.vram_base_offset =3D gfxhub=
_v1_0_get_mc_fb_offset(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;vm_manager.vram_base_offset =3D adev-&=
gt;gfxhub.funcs-&gt;get_mc_fb_offset(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* XXX: add the xgmi offset of the physical nod=
e? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;vm_manager.vram_base_offset +=3D<br>
@@ -1269,7 +1283,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *ade=
v)<br>
<br>
=C2=A0#ifdef CONFIG_X86_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;flags &amp; AMD_IS_APU) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.aper_b=
ase =3D gfxhub_v1_0_get_mc_fb_offset(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.aper_b=
ase =3D adev-&gt;gfxhub.funcs-&gt;get_mc_fb_offset(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.aper_s=
ize =3D adev-&gt;gmc.real_vram_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
@@ -1339,7 +1353,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r, vram_width =3D 0, vram_type =3D 0, vram_=
vendor =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v1_0_init(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;init(adev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;init(adev);<br>
<br>
@@ -1453,7 +1467,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;need_swiotlb =3D drm_need_swiotlb(44);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;gmc.xgmi.supported) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D gfxhub_v1_1_g=
et_xgmi_info(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D adev-&gt;gfxh=
ub.funcs-&gt;get_xgmi_info(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -1569,7 +1583,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device =
*adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D gfxhub_v1_0_gart_enable(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D adev-&gt;gfxhub.funcs-&gt;gart_enable(ade=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
<br>
@@ -1636,7 +1650,7 @@ static int gmc_v9_0_hw_init(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!amdgpu_sriov_vf(adev)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v1_0_set_fau=
lt_enable_default(adev, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.fun=
cs-&gt;set_fault_enable_default(adev, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.func=
s-&gt;set_fault_enable_default(adev, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;num_vmhubs; ++i)<=
br>
@@ -1659,7 +1673,7 @@ static int gmc_v9_0_hw_init(void *handle)<br>
=C2=A0 */<br>
=C2=A0static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0gfxhub_v1_0_gart_disable(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfxhub.funcs-&gt;gart_disable(adev);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mmhub.funcs-&gt;gart_disable(adev);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gart_table_vram_unpin(adev);<br>
=C2=A0}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000007155e905af92c423--

--===============0014138985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0014138985==--
