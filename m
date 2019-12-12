Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456CC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6995214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGuyN2t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6995214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B086E228;
	Thu, 12 Dec 2019 22:41:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2986E226
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 22:41:38 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b6so4576230wrq.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 14:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=enQ1U1OFNpAQJ+DylmD+z8XAYKJ7IPsLPppe7/zbyYg=;
 b=iGuyN2t9QycXMIyDp9HTgzlRKHuL9tHOe08asktYVdG5z+54FpKsaGdb6aCe95KTis
 crZqB8P0NTwAMcHRNE+jUUH5kp36QyAdoK0noQ7hi+nrzBEvsMd9WVl/VJWqO6nKlDAp
 /MNS4uWmD7yoJ5aACcHZUGhMg4ORvO+vXDR+LYJTQEljN6OrRp6I6c92En219CQCmVwA
 V4A8eVchOrWh69YzwKsfUiZJoc0u25ZBa1CZAXV/ce0yEXODhLIq7+ithQQodXGbl06D
 UdAIDMzbZsheRH3O97VUyCWQykLOXjGyZUlpnF+9ZUe1VOOuUyh2EZkYsU0xnjNGJI0S
 Hakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=enQ1U1OFNpAQJ+DylmD+z8XAYKJ7IPsLPppe7/zbyYg=;
 b=oDWGz1PyvUqf+N91pg+yYkvYHDO2jMTtlXfqVu8gCOdYs7oo7pd48ZONENSUHIBpvR
 4+UqqHZe8yG32jP37y0enVHGeZc/IW4MCtt0Ic5WRJV4eewnxGPbFGpHeqfhexqVESGD
 mO3gFvQb7BfhAyLA6iVErQVaiYqhk1pA+/Sp+xMG5C++CPdQXj51MKsUPRX04U4mD5xr
 99q5reK8igP9hE+qKX+aj3WnUGJP+TZmYnhWEzoGrz7iTrGdkqMqQYRSibtFz7tZiT92
 kUeFXVK3NfdXoiVvX8Kle9a2rid6q8hJ+dzcnFjz59Sm6N605hcV0r8Ho0jPUY/WUKi1
 iUiw==
X-Gm-Message-State: APjAAAXc6iXdX+jlManSUetnAF3DyLyLB5qGOHkqsNqnqiHQbCnd5NlJ
 WBMoEZvyl04onWq9gzwicWWHK67soUb9o45Cs0okkw==
X-Google-Smtp-Source: APXvYqw/oWpmj4wbNFXPAxIYTGuqreVwSVoYx7GM3kQNHFvQZavHXKhTDIbGeSvydj8/IAfGwWOCiX3v/59+OVrcCnE=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr8911093wru.40.1576190496958; 
 Thu, 12 Dec 2019 14:41:36 -0800 (PST)
MIME-Version: 1.0
References: <1468620701.4246768.1575758833243.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1468620701.4246768.1575758833243.JavaMail.zimbra@raptorengineeringinc.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2019 17:41:25 -0500
Message-ID: <CADnq5_O39wA4W45du29gDnfTAvWyx8zfTy=+mSHL+1_-QDaQqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] amdgpu: Prepare DCN floating point macros for generic
To: Timothy Pearson <tpearson@raptorengineering.com>
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
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Dec 7, 2019 at 5:47 PM Timothy Pearson
<tpearson@raptorengineering.com> wrote:
>
>  arch support
>
> Introduce DC_FP_START()/DC_FP_END() macros to help enable floating
> point kernel mode support across various architectures.
>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>

Applied with a bit of tweaking.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 24 +++++++++----------
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c |  4 ++--
>  .../drm/amd/display/dc/dcn21/dcn21_resource.c |  4 ++--
>  drivers/gpu/drm/amd/display/dc/os_types.h     |  3 +++
>  4 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> index 9b2cb57bf2ba..cd5471263248 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> @@ -626,7 +626,7 @@ static bool dcn_bw_apply_registry_override(struct dc *dc)
>  {
>         bool updated = false;
>
> -       kernel_fpu_begin();
> +       DC_FP_START();
>         if ((int)(dc->dcn_soc->sr_exit_time * 1000) != dc->debug.sr_exit_time_ns
>                         && dc->debug.sr_exit_time_ns) {
>                 updated = true;
> @@ -662,7 +662,7 @@ static bool dcn_bw_apply_registry_override(struct dc *dc)
>                 dc->dcn_soc->dram_clock_change_latency =
>                                 dc->debug.dram_clock_change_latency_ns / 1000.0;
>         }
> -       kernel_fpu_end();
> +       DC_FP_END();
>
>         return updated;
>  }
> @@ -742,7 +742,7 @@ bool dcn_validate_bandwidth(
>                 dcn_bw_sync_calcs_and_dml(dc);
>
>         memset(v, 0, sizeof(*v));
> -       kernel_fpu_begin();
> +       DC_FP_START();
>
>         v->sr_exit_time = dc->dcn_soc->sr_exit_time;
>         v->sr_enter_plus_exit_time = dc->dcn_soc->sr_enter_plus_exit_time;
> @@ -1275,7 +1275,7 @@ bool dcn_validate_bandwidth(
>         bw_limit = dc->dcn_soc->percent_disp_bw_limit * v->fabric_and_dram_bandwidth_vmax0p9;
>         bw_limit_pass = (v->total_data_read_bandwidth / 1000.0) < bw_limit;
>
> -       kernel_fpu_end();
> +       DC_FP_END();
>
>         PERFORMANCE_TRACE_END();
>         BW_VAL_TRACE_FINISH();
> @@ -1443,7 +1443,7 @@ void dcn_bw_update_from_pplib(struct dc *dc)
>         res = dm_pp_get_clock_levels_by_type_with_voltage(
>                         ctx, DM_PP_CLOCK_TYPE_FCLK, &fclks);
>
> -       kernel_fpu_begin();
> +       DC_FP_START();
>
>         if (res)
>                 res = verify_clock_values(&fclks);
> @@ -1463,12 +1463,12 @@ void dcn_bw_update_from_pplib(struct dc *dc)
>         } else
>                 BREAK_TO_DEBUGGER();
>
> -       kernel_fpu_end();
> +       DC_FP_END();
>
>         res = dm_pp_get_clock_levels_by_type_with_voltage(
>                         ctx, DM_PP_CLOCK_TYPE_DCFCLK, &dcfclks);
>
> -       kernel_fpu_begin();
> +       DC_FP_START();
>
>         if (res)
>                 res = verify_clock_values(&dcfclks);
> @@ -1481,7 +1481,7 @@ void dcn_bw_update_from_pplib(struct dc *dc)
>         } else
>                 BREAK_TO_DEBUGGER();
>
> -       kernel_fpu_end();
> +       DC_FP_END();
>  }
>
>  void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
> @@ -1496,11 +1496,11 @@ void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
>         if (!pp || !pp->set_wm_ranges)
>                 return;
>
> -       kernel_fpu_begin();
> +       DC_FP_START();
>         min_fclk_khz = dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 * 1000000 / 32;
>         min_dcfclk_khz = dc->dcn_soc->dcfclkv_min0p65 * 1000;
>         socclk_khz = dc->dcn_soc->socclk * 1000;
> -       kernel_fpu_end();
> +       DC_FP_END();
>
>         /* Now notify PPLib/SMU about which Watermarks sets they should select
>          * depending on DPM state they are in. And update BW MGR GFX Engine and
> @@ -1551,7 +1551,7 @@ void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
>
>  void dcn_bw_sync_calcs_and_dml(struct dc *dc)
>  {
> -       kernel_fpu_begin();
> +       DC_FP_START();
>         DC_LOG_BANDWIDTH_CALCS("sr_exit_time: %f ns\n"
>                         "sr_enter_plus_exit_time: %f ns\n"
>                         "urgent_latency: %f ns\n"
> @@ -1740,5 +1740,5 @@ void dcn_bw_sync_calcs_and_dml(struct dc *dc)
>         dc->dml.ip.bug_forcing_LC_req_same_size_fixed =
>                 dc->dcn_ip->bug_forcing_luma_and_chroma_request_to_same_size_fixed == dcn_bw_yes;
>         dc->dml.ip.dcfclk_cstate_latency = dc->dcn_ip->dcfclk_cstate_latency;
> -       kernel_fpu_end();
> +       DC_FP_END();
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 09793336d84f..74ad6f09c1d4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3243,7 +3243,7 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
>
>  void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb)
>  {
> -       kernel_fpu_begin();
> +       DC_FP_START();
>         if ((int)(bb->sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
>                         && dc->bb_overrides.sr_exit_time_ns) {
>                 bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
> @@ -3267,7 +3267,7 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
>                 bb->dram_clock_change_latency_us =
>                                 dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
>         }
> -       kernel_fpu_end();
> +       DC_FP_END();
>  }
>
>  static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 459bd9a5caed..ce4d38e91054 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -1017,7 +1017,7 @@ static void calculate_wm_set_for_vlevel(
>
>  static void patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb)
>  {
> -       kernel_fpu_begin();
> +       DC_FP_START();
>         if (dc->bb_overrides.sr_exit_time_ns) {
>                 bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
>         }
> @@ -1035,7 +1035,7 @@ static void patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
>                 bb->dram_clock_change_latency_us =
>                                 dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
>         }
> -       kernel_fpu_end();
> +       DC_FP_END();
>  }
>
>  void dcn21_calculate_wm(
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 30ec80ac6fc8..938735bf624d 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright 2012-16 Advanced Micro Devices, Inc.
> + * Copyright 2019 Raptor Engineering, LLC
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a
>   * copy of this software and associated documentation files (the "Software"),
> @@ -50,6 +51,8 @@
>
>  #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
>  #include <asm/fpu/api.h>
> +#define DC_FP_START() kernel_fpu_begin()
> +#define DC_FP_END() kernel_fpu_end()
>  #endif
>
>  /*
> --
> 2.20.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
