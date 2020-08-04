Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C4C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD51206DA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeFTGWkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD51206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A846E4B6;
	Tue,  4 Aug 2020 20:40:19 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275926E4B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 20:40:18 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id l2so28091415wrc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9rs9G4My8vYRqn9JPnM3vPnElgzz2NwwkYv/9Z/7wRI=;
 b=NeFTGWkJE8TEIDXk4t9QPcsWXNPYtg5QvosVW96/KQEe6KUGysH34BNSMXlCzQidsH
 IYF2Y7zdAXFOjGkgUBMBTwUDzVwTmnrI4AKNrRnteFppbV5NaOl3qdz34MrnnnWdvXYs
 OoTK+Pl6evo35yeW/hD/SV6/hlNm9qKQh+Mw3OPN0G0CkkdYnQw+RqA5p9Ptm+J7orVU
 p1kr+qC0HWQNoGvI0UBxlxHVcYu44GaN9gYC9AhYpx+kfLqfzo/CQxnAMGcU2+cgM28I
 EgQ0c/rSiCojEetzFzMFnLBlcSlhmwEWJ8e4IqPWvDDfY14skc7RNVvSq0kU437I9+el
 ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9rs9G4My8vYRqn9JPnM3vPnElgzz2NwwkYv/9Z/7wRI=;
 b=B7Q7tHqkKUpiF8Lz0PkFRGBBCp+7jmfGfdus4gvY+ik+/LjVKYWhdKccEpZ9zH1mpX
 7PDM12nf5XEjUxkNz+Yr5z6r9qeRFv7hl3C9lSJE1XZV0e0hP/9/JSVtNr59s33ftbGX
 OcA4ZF5IxpDD4AYQyZwoccOtdTZ9VN73i30NQPpRqqoxHH/9LQSf+Qd5ongueSYBE8dZ
 FSX3KcioGP6pPmzau2UfieX8ZQLDUL9CPY9qrQuk3DLqqx5jEoi3uEC8L+2F5NlcOFhI
 zD2y79XwmPX1ztR6I0XlfiOvaPvaq6y92gN9NhRfglQrHYgFiZ9N4LWu2f6NQV0bvJna
 rwSA==
X-Gm-Message-State: AOAM533v7ggBwLwraVT8sj6mv2HkmjzM7De5I2rmDfr7LjG4EBWuXJZ/
 OFo7bEjUn7Q+NamU6wrwGXbF4+HLrbDhEPIntvw=
X-Google-Smtp-Source: ABdhPJzzmGweMvkvB4CwUGi8nxLsIcQpo+8WFWFYZOaxrXCy4sKVr2ukVnsGPHrpSJLZMuXCNQxSLm8wLxjQHUKIm78=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr20675401wrw.362.1596573616782; 
 Tue, 04 Aug 2020 13:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024316.28324-1-evan.quan@amd.com>
 <20200731024316.28324-11-evan.quan@amd.com>
In-Reply-To: <20200731024316.28324-11-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 16:40:05 -0400
Message-ID: <CADnq5_Ox3MrPVzHxT-SHqRCNEeZtWz2fpp8ThtUXyf0=Q6ztRA@mail.gmail.com>
Subject: Re: [PATCH 11/17] drm/amd/powerplay: add Vega12 support for gpu
 metrics export
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Nirmoy <nirmodas@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 9-11 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 30, 2020 at 10:44 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Add Vega12 gpu metrics export interface.
>
> Change-Id: I2c910f523049f0f90eecb8d74cb73ebb39a22bd9
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 111 ++++++++++++++++++
>  .../drm/amd/powerplay/hwmgr/vega12_hwmgr.h    |   1 +
>  2 files changed, 112 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index a678a67f1c0d..40bb0c2e4e8c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -47,6 +47,13 @@
>  #include "pp_thermal.h"
>  #include "vega12_baco.h"
>
> +#define smnPCIE_LC_SPEED_CNTL                  0x11140290
> +#define smnPCIE_LC_LINK_WIDTH_CNTL             0x11140288
> +
> +#define LINK_WIDTH_MAX                         6
> +#define LINK_SPEED_MAX                         3
> +static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> +static int link_speed[] = {25, 50, 80, 160};
>
>  static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, uint32_t mask);
> @@ -2095,6 +2102,46 @@ static int vega12_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
>         return 0;
>  }
>
> +static int vega12_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
> +               PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
> +               >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> +}
> +
> +static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
> +{
> +       uint32_t width_level;
> +
> +       width_level = vega12_get_current_pcie_link_width_level(hwmgr);
> +       if (width_level > LINK_WIDTH_MAX)
> +               width_level = 0;
> +
> +       return link_width[width_level];
> +}
> +
> +static int vega12_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
> +               PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> +               >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> +}
> +
> +static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
> +{
> +       uint32_t speed_level;
> +
> +       speed_level = vega12_get_current_pcie_link_speed_level(hwmgr);
> +       if (speed_level > LINK_SPEED_MAX)
> +               speed_level = 0;
> +
> +       return link_speed[speed_level];
> +}
> +
>  static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, char *buf)
>  {
> @@ -2682,6 +2729,69 @@ static int vega12_set_mp1_state(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> +static void vega12_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
> +{
> +       memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
> +
> +       gpu_metrics->common_header.structure_size =
> +                               sizeof(struct gpu_metrics_v1_0);
> +       gpu_metrics->common_header.format_revision = 1;
> +       gpu_metrics->common_header.content_revision = 0;
> +
> +       gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> +}
> +
> +static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
> +                                     void **table)
> +{
> +       struct vega12_hwmgr *data =
> +                       (struct vega12_hwmgr *)(hwmgr->backend);
> +       struct gpu_metrics_v1_0 *gpu_metrics =
> +                       &data->gpu_metrics_table;
> +       SmuMetrics_t metrics;
> +       uint32_t fan_speed_rpm;
> +       int ret;
> +
> +       ret = vega12_get_metrics_table(hwmgr, &metrics);
> +       if (ret)
> +               return ret;
> +
> +       vega12_init_gpu_metrics_v1_0(gpu_metrics);
> +
> +       gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> +       gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> +       gpu_metrics->temperature_mem = metrics.TemperatureHBM;
> +       gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
> +       gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem;
> +
> +       gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +       gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
> +
> +       gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
> +       gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
> +       gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
> +
> +       gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
> +       gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
> +       gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
> +       gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> +       gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> +
> +       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +
> +       vega12_fan_ctrl_get_fan_speed_rpm(hwmgr, &fan_speed_rpm);
> +       gpu_metrics->current_fan_speed = (uint16_t)fan_speed_rpm;
> +
> +       gpu_metrics->pcie_link_width =
> +                       vega12_get_current_pcie_link_width(hwmgr);
> +       gpu_metrics->pcie_link_speed =
> +                       vega12_get_current_pcie_link_speed(hwmgr);
> +
> +       *table = (void *)gpu_metrics;
> +
> +       return sizeof(struct gpu_metrics_v1_0);
> +}
> +
>  static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
>         .backend_init = vega12_hwmgr_backend_init,
>         .backend_fini = vega12_hwmgr_backend_fini,
> @@ -2739,6 +2849,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
>         .get_ppfeature_status = vega12_get_ppfeature_status,
>         .set_ppfeature_status = vega12_set_ppfeature_status,
>         .set_mp1_state = vega12_set_mp1_state,
> +       .get_gpu_metrics = vega12_get_gpu_metrics,
>  };
>
>  int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> index 73875399666a..aa63ae41942d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> @@ -399,6 +399,7 @@ struct vega12_hwmgr {
>
>         unsigned long                  metrics_time;
>         SmuMetrics_t                   metrics_table;
> +       struct gpu_metrics_v1_0        gpu_metrics_table;
>  };
>
>  #define VEGA12_DPM2_NEAR_TDP_DEC                      10
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
