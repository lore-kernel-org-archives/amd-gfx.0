Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E58C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C527E2072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXym63v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C527E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE1F6EA26;
	Fri, 10 Jan 2020 14:39:52 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D946EA26
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:39:51 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m24so2253747wmc.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MD8txtWWjEtVfdJS65CGa1gPCh5NHiMNAEqBthlARVA=;
 b=BXym63v7nLukDcjuej0vW8c6fhSDTzmOBFba95sacj7pAeu5wJGsMlA4zNmnvoB857
 fGgftawyQ73hHkPggg0FZlksCR7VgUUj1EMU8dNIN1AJ09BTxHn7JnSuT7dxp6FEH90l
 3Q62c7YCKrxRIwh6P3wTjIOqWgT/DAGwB7EsYWuUBqsYY9QXfNJRTw44QjsqHTW+NP77
 cSZT3Xoba870gTzccQAQQDZMVuymT9bXCOQtwbLMHCA/ymUr3A34VT/c7V/JFYteSRXQ
 jtDiHZK7j49Dw+DExmQdgwY86ZSx7yPR+Op9Pg83h7qZtMKqaKQdsM2nwVpS+4fodw7c
 rH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MD8txtWWjEtVfdJS65CGa1gPCh5NHiMNAEqBthlARVA=;
 b=iHiqf5C95BeIdByVYs/8C/a+StfeVZJTvfpjWJB8P8IQUQEDvaZ1Wqgs0TPwzzzlap
 QEm7uxphCz+ZlyUp09f9ybq5qUvgAODdfQvg0staZJYDBxDlavTaf17Th6qDc0NH+/Ez
 sCgCCCqFIwOoIQmOwclYSZp547xzgYEBgKOGT4ToXxM6ERjXVv7KMxtLHR1sPgVLPmd5
 U9dgqLIWfRL+ifx+Mbt2w/58kYm+HmS4nSiQfQXFTTXzvcvfdquez2FzI3NH+i7Q0d2H
 wnLjwqfk0mxspgVFowaqsV9Q+vGSKS923SunppnNva2Xt8cCgFKDE07UWk+HQylKq6qc
 CXdQ==
X-Gm-Message-State: APjAAAVOoNJs20dbiklcFbLf4h2xtex6r+xR6tLiMk2wkl3VLRH4Aaiu
 fsYxkQLNK59XhT+8CnwnBpxLfBWd5BSreIZg6CHTLw==
X-Google-Smtp-Source: APXvYqxCLisRqrcB21GjHOpqVvMgCLspVeZ/GBdR2yf0Y6CMhihJipNKosdaBsXfvHnAjAl8l69X/u0/B8Re5U3DYYM=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr4777207wmq.65.1578667189555; 
 Fri, 10 Jan 2020 06:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
 <20200110020206.676605-2-Joseph.Greathouse@amd.com>
In-Reply-To: <20200110020206.676605-2-Joseph.Greathouse@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2020 09:39:37 -0500
Message-ID: <CADnq5_O6M5SWJuuJYFTVcWv0dosYifhu8tZv2pzYM7Ztx=sMeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Create generic DF struct in adev
To: Joseph Greathouse <Joseph.Greathouse@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 9, 2020 at 9:34 PM Joseph Greathouse
<Joseph.Greathouse@amd.com> wrote:
>
> The only data fabric information the adev struct currently
> contains is a function pointer table. In the near future,
> we will be adding some cached DF information into adev. As
> such, this patch creates a new amdgpu_df struct for adev
> to old. Right now, it only containst the old function pointer
> table, but new stuff will be added soon.
>
> Change-Id: I0359344297a740782efd35e902f9638bc9e67da8
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 29 ++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_df.h   | 62 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c  | 12 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  6 +--
>  drivers/gpu/drm/amd/amdgpu/df_v1_7.c     |  6 +--
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c     |  6 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  6 +--
>  drivers/gpu/drm/amd/amdgpu/soc15.c       | 12 ++---
>  8 files changed, 90 insertions(+), 49 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 863bf45ba198..63eab0c135db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -91,6 +91,7 @@
>  #include "amdgpu_umc.h"
>  #include "amdgpu_mmhub.h"
>  #include "amdgpu_tmz.h"
> +#include "amdgpu_df.h"
>
>  #define MAX_GPU_INSTANCE               16
>
> @@ -670,29 +671,6 @@ struct amdgpu_mmio_remap {
>         resource_size_t bus_addr;
>  };
>
> -struct amdgpu_df_funcs {
> -       void (*sw_init)(struct amdgpu_device *adev);
> -       void (*sw_fini)(struct amdgpu_device *adev);
> -       void (*enable_broadcast_mode)(struct amdgpu_device *adev,
> -                                     bool enable);
> -       u32 (*get_fb_channel_number)(struct amdgpu_device *adev);
> -       u32 (*get_hbm_channel_number)(struct amdgpu_device *adev);
> -       void (*update_medium_grain_clock_gating)(struct amdgpu_device *adev,
> -                                                bool enable);
> -       void (*get_clockgating_state)(struct amdgpu_device *adev,
> -                                     u32 *flags);
> -       void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
> -                                           bool enable);
> -       int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
> -                                        int is_enable);
> -       int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
> -                                        int is_disable);
> -       void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
> -                                        uint64_t *count);
> -       uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
> -       void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
> -                        uint32_t ficadl_val, uint32_t ficadh_val);
> -};
>  /* Define the HW IP blocks will be used in driver , add more if necessary */
>  enum amd_hw_ip_block_type {
>         GC_HWIP = 1,
> @@ -939,6 +917,9 @@ struct amdgpu_device {
>         /* tmz */
>         struct amdgpu_tmz               tmz;
>
> +       /* df */
> +       struct amdgpu_df                df;
> +
>         struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>         int                             num_ip_blocks;
>         struct mutex    mn_lock;
> @@ -952,8 +933,6 @@ struct amdgpu_device {
>         /* soc15 register offset based on ip, instance and  segment */
>         uint32_t                *reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
>
> -       const struct amdgpu_df_funcs    *df_funcs;
> -
>         /* delayed work_func for deferring clockgating during resume */
>         struct delayed_work     delayed_init_work;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> new file mode 100644
> index 000000000000..61a26c15c8dd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> @@ -0,0 +1,62 @@
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
> +
> +#ifndef __AMDGPU_DF_H__
> +#define __AMDGPU_DF_H__
> +
> +struct amdgpu_df_hash_status {
> +       bool hash_64k;
> +       bool hash_2m;
> +       bool hash_1g;
> +};
> +
> +struct amdgpu_df_funcs {
> +       void (*sw_init)(struct amdgpu_device *adev);
> +       void (*sw_fini)(struct amdgpu_device *adev);
> +       void (*enable_broadcast_mode)(struct amdgpu_device *adev,
> +                                     bool enable);
> +       u32 (*get_fb_channel_number)(struct amdgpu_device *adev);
> +       u32 (*get_hbm_channel_number)(struct amdgpu_device *adev);
> +       void (*update_medium_grain_clock_gating)(struct amdgpu_device *adev,
> +                                                bool enable);
> +       void (*get_clockgating_state)(struct amdgpu_device *adev,
> +                                     u32 *flags);
> +       void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
> +                                           bool enable);
> +       int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
> +                                        int is_enable);
> +       int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
> +                                        int is_disable);
> +       void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
> +                                        uint64_t *count);
> +       uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
> +       void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
> +                        uint32_t ficadl_val, uint32_t ficadh_val);
> +};
> +
> +struct amdgpu_df {
> +       struct amdgpu_df_hash_status    hash_status;
> +       const struct amdgpu_df_funcs    *funcs;
> +};
> +
> +#endif /* __AMDGPU_DF_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index cf21ad0cad9a..07914e34bc25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -74,9 +74,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
>         switch (pe->pmu_perf_type) {
>         case PERF_TYPE_AMDGPU_DF:
>                 if (!(flags & PERF_EF_RELOAD))
> -                       pe->adev->df_funcs->pmc_start(pe->adev, hwc->conf, 1);
> +                       pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
>
> -               pe->adev->df_funcs->pmc_start(pe->adev, hwc->conf, 0);
> +               pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 0);
>                 break;
>         default:
>                 break;
> @@ -101,7 +101,7 @@ static void amdgpu_perf_read(struct perf_event *event)
>
>                 switch (pe->pmu_perf_type) {
>                 case PERF_TYPE_AMDGPU_DF:
> -                       pe->adev->df_funcs->pmc_get_count(pe->adev, hwc->conf,
> +                       pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->conf,
>                                                           &count);
>                         break;
>                 default:
> @@ -126,7 +126,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
>
>         switch (pe->pmu_perf_type) {
>         case PERF_TYPE_AMDGPU_DF:
> -               pe->adev->df_funcs->pmc_stop(pe->adev, hwc->conf, 0);
> +               pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 0);
>                 break;
>         default:
>                 break;
> @@ -156,7 +156,7 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
>
>         switch (pe->pmu_perf_type) {
>         case PERF_TYPE_AMDGPU_DF:
> -               retval = pe->adev->df_funcs->pmc_start(pe->adev, hwc->conf, 1);
> +               retval = pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
>                 break;
>         default:
>                 return 0;
> @@ -184,7 +184,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
>
>         switch (pe->pmu_perf_type) {
>         case PERF_TYPE_AMDGPU_DF:
> -               pe->adev->df_funcs->pmc_stop(pe->adev, hwc->conf, 1);
> +               pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 1);
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index c626f3e59ff9..a97af422575a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -146,16 +146,16 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>         ficaa_pie_ctl_in = AMDGPU_XGMI_SET_FICAA(0x200);
>         ficaa_pie_status_in = AMDGPU_XGMI_SET_FICAA(0x208);
>
> -       fica_out = adev->df_funcs->get_fica(adev, ficaa_pie_ctl_in);
> +       fica_out = adev->df.funcs->get_fica(adev, ficaa_pie_ctl_in);
>         if (fica_out != 0x1f)
>                 pr_err("xGMI error counters not enabled!\n");
>
> -       fica_out = adev->df_funcs->get_fica(adev, ficaa_pie_status_in);
> +       fica_out = adev->df.funcs->get_fica(adev, ficaa_pie_status_in);
>
>         if ((fica_out & 0xffff) == 2)
>                 error_count = ((fica_out >> 62) & 0x1) + (fica_out >> 63);
>
> -       adev->df_funcs->set_fica(adev, ficaa_pie_status_in, 0, 0);
> +       adev->df.funcs->set_fica(adev, ficaa_pie_status_in, 0, 0);
>
>         return snprintf(buf, PAGE_SIZE, "%d\n", error_count);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> index d6221298b477..03fdeef568d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -66,7 +66,7 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
>  {
>         int fb_channel_number;
>
> -       fb_channel_number = adev->df_funcs->get_fb_channel_number(adev);
> +       fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
>
>         return df_v1_7_channel_number[fb_channel_number];
>  }
> @@ -77,7 +77,7 @@ static void df_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>         u32 tmp;
>
>         /* Put DF on broadcast mode */
> -       adev->df_funcs->enable_broadcast_mode(adev, true);
> +       adev->df.funcs->enable_broadcast_mode(adev, true);
>
>         if (enable && (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG)) {
>                 tmp = RREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater);
> @@ -92,7 +92,7 @@ static void df_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>         }
>
>         /* Exit boradcast mode */
> -       adev->df_funcs->enable_broadcast_mode(adev, false);
> +       adev->df.funcs->enable_broadcast_mode(adev, false);
>  }
>
>  static void df_v1_7_get_clockgating_state(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 2f884d941e8d..7bd29d97adfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -311,7 +311,7 @@ static u32 df_v3_6_get_hbm_channel_number(struct amdgpu_device *adev)
>  {
>         int fb_channel_number;
>
> -       fb_channel_number = adev->df_funcs->get_fb_channel_number(adev);
> +       fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
>         if (fb_channel_number >= ARRAY_SIZE(df_v3_6_channel_number))
>                 fb_channel_number = 0;
>
> @@ -325,7 +325,7 @@ static void df_v3_6_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>
>         if (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG) {
>                 /* Put DF on broadcast mode */
> -               adev->df_funcs->enable_broadcast_mode(adev, true);
> +               adev->df.funcs->enable_broadcast_mode(adev, true);
>
>                 if (enable) {
>                         tmp = RREG32_SOC15(DF, 0,
> @@ -344,7 +344,7 @@ static void df_v3_6_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>                 }
>
>                 /* Exit broadcast mode */
> -               adev->df_funcs->enable_broadcast_mode(adev, false);
> +               adev->df.funcs->enable_broadcast_mode(adev, false);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 26194ac9af98..b83c8d745f42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -817,8 +817,8 @@ static int gmc_v9_0_late_init(void *handle)
>                         r = amdgpu_atomfirmware_mem_ecc_supported(adev);
>                         if (!r) {
>                                 DRM_INFO("ECC is not present.\n");
> -                               if (adev->df_funcs->enable_ecc_force_par_wr_rmw)
> -                                       adev->df_funcs->enable_ecc_force_par_wr_rmw(adev, false);
> +                               if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
> +                                       adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
>                         } else {
>                                 DRM_INFO("ECC is active.\n");
>                         }
> @@ -1023,7 +1023,7 @@ static int gmc_v9_0_sw_init(void *handle)
>                 else
>                         chansize = 128;
>
> -               numchan = adev->df_funcs->get_hbm_channel_number(adev);
> +               numchan = adev->df.funcs->get_hbm_channel_number(adev);
>                 adev->gmc.vram_width = numchan * chansize;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 6c75021dda0f..317803f6a561 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -677,9 +677,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>         }
>
>         if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
> -               adev->df_funcs = &df_v3_6_funcs;
> +               adev->df.funcs = &df_v3_6_funcs;
>         else
> -               adev->df_funcs = &df_v1_7_funcs;
> +               adev->df.funcs = &df_v1_7_funcs;
>
>         adev->rev_id = soc15_get_rev_id(adev);
>         adev->nbio.funcs->detect_hw_virt(adev);
> @@ -1247,7 +1247,7 @@ static int soc15_common_sw_init(void *handle)
>         if (amdgpu_sriov_vf(adev))
>                 xgpu_ai_mailbox_add_irq_id(adev);
>
> -       adev->df_funcs->sw_init(adev);
> +       adev->df.funcs->sw_init(adev);
>
>         return 0;
>  }
> @@ -1257,7 +1257,7 @@ static int soc15_common_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_nbio_ras_fini(adev);
> -       adev->df_funcs->sw_fini(adev);
> +       adev->df.funcs->sw_fini(adev);
>         return 0;
>  }
>
> @@ -1478,7 +1478,7 @@ static int soc15_common_set_clockgating_state(void *handle,
>                                 state == AMD_CG_STATE_GATE ? true : false);
>                 soc15_update_rom_medium_grain_clock_gating(adev,
>                                 state == AMD_CG_STATE_GATE ? true : false);
> -               adev->df_funcs->update_medium_grain_clock_gating(adev,
> +               adev->df.funcs->update_medium_grain_clock_gating(adev,
>                                 state == AMD_CG_STATE_GATE ? true : false);
>                 break;
>         case CHIP_RAVEN:
> @@ -1536,7 +1536,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
>         if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
>                 *flags |= AMD_CG_SUPPORT_ROM_MGCG;
>
> -       adev->df_funcs->get_clockgating_state(adev, flags);
> +       adev->df.funcs->get_clockgating_state(adev, flags);
>  }
>
>  static int soc15_common_set_powergating_state(void *handle,
> --
> 2.19.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
