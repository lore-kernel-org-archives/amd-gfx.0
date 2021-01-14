Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCBCC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A5023772
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5023772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DAD89C9D;
	Thu, 14 Jan 2021 17:49:04 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E3E89BFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 17:49:02 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id j12so5955768ota.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vR/gIG25pZGHCRP/uSWMhuVMvn1LEBRd3FIn1y2WbG8=;
 b=G2RxWNLHJVkdYYh+1RkKHI3pbQ40gZnK8bOIPz+KvOXpVSNL+azZKKcSVaLOsv0Xro
 pASRjA7ZHlJ40N33NJCZeuMiqaBSmLSw4X7X3n3VNIVRSo/jtLEi9roa4lYxCnvJ8FhU
 6NkOrPlGhEvfnutfd1lXYbcUldrLiMwAaRTRLGT2+G0Enq9FHZ6xyqeofI83+asFDck6
 +d/nqI4Ji2mze3EYI7rbo18I5y7XA2CDEYDz/9Iuel2uRGTbsVkTrYfViZUEIzPefMoF
 FR77T93ARYhlCsfMPBEdGj5yEfrMigW+NLiJ1Bm+Gxb65hj8Il9FdL5KkJGqAcforgGk
 CNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vR/gIG25pZGHCRP/uSWMhuVMvn1LEBRd3FIn1y2WbG8=;
 b=mkTfvck/IPUO/uYlG+XvtvMs5775lFhROoTbwUhAP6jiccnqVdJMrzGYdhTAqw7Lcu
 Gvz+1guQquL6bp+oQJtkMGdTtPJ+FH9Merx6IDdDoFs1hva4QPiFjxo23HZV2LIoUYwb
 6LpzqPAh+28plxS9hsVaNKByLJtFG3w/RS7b/nY4R4aDKYVIRE5/JngIFVTCG0b2NRzg
 QNW/xjVv3qulf0VzvsZGHdy71eNU7+AvSgiUG2qofnh1Hkw/ZlRwC9mVrcBTznFyWwyR
 3o0XfWTJ2SQfDoGJCY2i0eqbLJE8Z3bhRNFS4S84EIiUV+ADSIbcFJD6ksjZhoNLiDyD
 L+6g==
X-Gm-Message-State: AOAM531qANDGyB6CU9aGQJCI3GbHjfE+31UfX49sgVzPmh14CQxEBE+3
 ikx0LfB1QLk2h1pFgZMAzl/auAl9UXTnzter3kvefrog
X-Google-Smtp-Source: ABdhPJya8W8/rYBsx5aprOaMMkQQCyOaAN7HdwlthFX59GtRqbusfaDXeqa1P/ltxBY0L3UN9OQ4K7WMRRBEf5YDApY=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr5569332ote.132.1610646542204; 
 Thu, 14 Jan 2021 09:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20210113032726.2475-1-darren.powell@amd.com>
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:48:51 -0500
Message-ID: <CADnq5_Ox2kn98K1eSpxtcd0hBKpwer3xyzMa5Ki5r79gwRK8Hg@mail.gmail.com>
Subject: Re: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
To: Darren Powell <darren.powell@amd.com>
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

On Tue, Jan 12, 2021 at 10:28 PM Darren Powell <darren.powell@amd.com> wrote:
>
> === Description ===
> Patches to add the Powerplay API to smu and simplify dpm/pm calling code
>
> * Version 2 Updates
>  0001: updated the structure name to swsmu_pm_funcs
>  0002: No Changes
>  0003: changed error return value of smu_get_fan_control_mode to AMD_FAN_CTRL_NONE
>        fixed type in amdgpu_hwmon_get_pwm1_enable() print statement
>        fixed indent flagged by checkpatch.pl
>  0004: remove check for error during swsmu amdgpu_dpm_get_pp_num_states() call to match previous powerplay behaviour
>  0005: add comment to highlight assignment that changes uint32_t value to int
>        fix errors flagged by checkpatch.pl
>  0006: fix errors flagged by checkpatch
>  0007: fix errors and warnings flagged by checkpatch
>  0008: No Changes

Feel free to pick up the RBs or ABs from the previous review that are
applicable.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> === Test System ===
> * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>  + ISO(Ubuntu 20.04.1 LTS)
>  + Kernel(5.9.0-rc5-custom-pmcallback-00865-gd3b9ec1a13c9)
>
> === Patch Summary ===
>    linux: (git://people.freedesktop.org/~agd5f/linux) origin/amd-staging-drm-next @ d3b9ec1a13c9
>     + b401b8ff07ca amdgpu/pm: Powerplay API for smu , added get_performance_level
>     + 924fb45c2fc9 amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to use API
>     + 22459821a119 amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to use API
>     + 9a1dff6ed4a4 amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use API
>     + eeaf9dad054a amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor functions to use API
>     + c10bf38a4250 amdgpu/pm: Powerplay API for smu , changes to clock and profile mode functions
>     + 73c150926ef3 amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
>     + f840fb27c965 amdgpu/pm: Powerplay API for smu , updates to some pm functions
>
> === Tests ===
> ** 0001
>  amdgpu_get_power_dpm_force_performance_level()    <- /sys/class/drm/card0/device/power_dpm_force_performance_level
> ** 0002
>  amdgpu_dpm_set_mp1_state              <- systemctl suspend
>  amdgpu_dpm_mode2_reset                <- untested: needs Arctic Islands Hardware (VEGAx, RAVEN)
>  amdgpu_dpm_switch_power_profile       <- untested
>  amdgpu_dpm_set_xgmi_pstate            <- untested: amdgpu_xgmi_set_pstate():411 pstate switching disabled
>  amdgpu_dpm_set_df_cstate              <- untested: needs ras enabled hardware
>  amdgpu_dpm_enable_mgpu_fan_boost      <- untested: needs multi-gpu hardware
> ** 0003
>  amdgpu_hwmon_get_pwm1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1_enable
>  amdgpu_hwmon_set_pwm1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1_enable
>  amdgpu_hwmon_set_pwm1                           <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1
>  amdgpu_hwmon_get_pwm1                           <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1
>  amdgpu_hwmon_get_fan1_input                     <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_input
>  amdgpu_hwmon_get_fan1_target                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_target
>  amdgpu_hwmon_set_fan1_target                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_target
>  amdgpu_hwmon_get_fan1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_enable
>  amdgpu_hwmon_set_fan1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_enable
> ** 0004
>  amdgpu_get_power_dpm_state                      <- /sys/class/drm/card0/device/power_dpm_state
>  amdgpu_set_power_dpm_force_performance_level    <- /sys/class/drm/card0/device/power_dpm_force_performance_level
>  amdgpu_get_pp_num_states                        <- /sys/class/drm/card0/device/pp_num_states
>  amdgpu_get_pp_cur_state                         <- /sys/class/drm/card0/device/pp_cur_state
>  amdgpu_get_pp_table                             <- /sys/class/drm/card0/device/pp_table
>  amdgpu_get_pp_features                          <- /sys/class/drm/card0/device/pp_features
>  amdgpu_hwmon_show_power_cap_max                 <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap_max
>  amdgpu_hwmon_show_power_cap                     <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap
>  amdgpu_hwmon_set_power_cap                      <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap
> ** 0005
>  amdgpu_dpm_baco_enter                  <- untested: called from runtime.pm
>  amdgpu_dpm_baco_exit                   <- untested: called from runtime.pm
>  amdgpu_dpm_is_baco_supported           <- untested: needs other Hardware(cik, vi, soc15)
>  amdgpu_dpm_baco_reset                  <- untested: needs other Hardware(cik, vi, soc15)
> ** 0006
>  amdgpu_get_pp_dpm_sclk              <- /sys/class/drm/card0/device/pp_dpm_sclk
>  amdgpu_set_pp_dpm_sclk              <- /sys/class/drm/card0/device/pp_dpm_sclk
>  amdgpu_get_pp_dpm_mclk              <- /sys/class/drm/card0/device/pp_dpm_mclk
>  amdgpu_set_pp_dpm_mclk              <- /sys/class/drm/card0/device/pp_dpm_mclk
>  amdgpu_get_pp_dpm_socclk            <- /sys/class/drm/card0/device/pp_dpm_socclk
>  amdgpu_set_pp_dpm_socclk            <- /sys/class/drm/card0/device/pp_dpm_socclk
>  amdgpu_get_pp_dpm_fclk              <- /sys/class/drm/card0/device/pp_dpm_fclk
>  amdgpu_set_pp_dpm_fclk              <- /sys/class/drm/card0/device/pp_dpm_fclk
>  amdgpu_get_pp_dpm_dcefclk           <- /sys/class/drm/card0/device/pp_dpm_dcefclk
>  amdgpu_set_pp_dpm_dcefclk           <- /sys/class/drm/card0/device/pp_dpm_dcefclk
>  amdgpu_get_pp_dpm_pcie              <- /sys/class/drm/card0/device/pp_dpm_pcie
>  amdgpu_set_pp_dpm_pcie              <- /sys/class/drm/card0/device/pp_dpm_pcie
>  amdgpu_get_pp_power_profile_mode    <- /sys/class/drm/card0/device/pp_power_profile_mode
>  amdgpu_set_pp_power_profile_mode    <- /sys/class/drm/card0/device/pp_power_profile_mode
>  amdgpu_get_gpu_metrics              <- /sys/class/drm/card0/device/gpu_metrics
> ** 0007
>  amdgpu_pm_compute_clocks            <- untested
>  amdgpu_dpm_set_powergating_by_smu   <- untested
>  amdgpu_dpm_get_mclk                 <- untested
>  amdgpu_dpm_get_sclk                 <- untested
> ** 0008
>  amdgpu_get_pp_od_clk_voltage                 <- /sys/class/drm/card0/device/pp_od_clk_voltage
>  amdgpu_set_pp_od_clk_voltage                 <- /sys/class/drm/card0/device/pp_od_clk_voltage
>  amdgpu_set_pp_table                          <- /sys/class/drm/card0/device/pp_table
>  amdgpu_set_power_dpm_force_performance_level <- /sys/class/drm/card0/device/power_dpm_force_performance_level
>
> === Summary of Untested Functions ===
> ** 0002
>  amdgpu_dpm_mode2_reset                <- untested: needs Arctic Islands Hardware (VEGAx, RAVEN)
>  amdgpu_dpm_switch_power_profile       <- untested: called during initialization
>  amdgpu_dpm_set_xgmi_pstate            <- untested: amdgpu_xgmi_set_pstate():411 pstate switching disabled
>  amdgpu_dpm_set_df_cstate              <- untested: needs ras enabled hardware
>  amdgpu_dpm_enable_mgpu_fan_boost      <- untested: needs multi-gpu hardware
> ** 0005
>  amdgpu_dpm_baco_enter                  <- untested: called from runtime.pm
>  amdgpu_dpm_baco_exit                   <- untested: called from runtime.pm
>  amdgpu_dpm_is_baco_supported           <- untested: needs other Hardware(cik, vi, soc15)
>  amdgpu_dpm_baco_reset                  <- untested: needs other Hardware(cik, vi, soc15)
> ** 0007
>  amdgpu_pm_compute_clocks            <- untested
>  amdgpu_dpm_set_powergating_by_smu   <- untested
>  amdgpu_dpm_get_mclk                 <- untested
>  amdgpu_dpm_get_sclk                 <- untested
> ** 0008
>  amdgpu_get_pp_od_clk_voltage                 <- file not found
>  amdgpu_set_pp_od_clk_voltage                 <- file not found
>  amdgpu_set_pp_table                          <- no binary data to test with
>
>
> === Cover Letter ===
> Darren Powell (8):
>   amdgpu/pm: Powerplay API for smu , added get_performance_level
>   amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to
>     use API
>   amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to
>     use API
>   amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use
>     API
>   amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor
>     functions to use API
>   amdgpu/pm: Powerplay API for smu , changes to clock and profile mode
>     functions
>   amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
>   amdgpu/pm: Powerplay API for smu , updates to some pm functions
>
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 228 +++------
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 597 +++++-----------------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  79 ++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 358 ++++++++++---
>  4 files changed, 534 insertions(+), 728 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
