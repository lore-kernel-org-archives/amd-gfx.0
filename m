Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173FF60F70
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 173FF60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9136E0AC;
	Fri, 12 Nov 2021 15:34:01 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF5E6E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 15:34:00 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 d1-20020a4a3c01000000b002c2612c8e1eso3058025ooa.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rt2tN+9SIikNlZT+VDO4HRjGKckpMqPN3wsDli+VsJk=;
 b=FX6UJTn48TQfDYQrft6I0TU47BgrSEu73U0cfIOA38Te8hIfUyjSQf+QZuBJGFUCOS
 LGyl7G7nVxgSW+J/I3H8Y5AcRDzTYJd78Qu9FPeqcNyOusL0o2/7tAJwAgC+46yJWgc9
 +aEN4i3d29DLmDIv53NUUiw8ipAh9L0PIHeMRWEMkCyVEbU3emmsw0sDATyIXuo0lYEf
 XvayDXIVPOxxN3d/jVurnPuYbJeOz9oziXUB6rEj0BMGuhVSzFgV/RhPQfp++6weGyvU
 CrL96y7KB2wA+MzdNi4VIWZdZ2iXrpfDvCV0oO1ztxs+j3xvg5vKis5ZBIY13Jl50jsU
 DABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rt2tN+9SIikNlZT+VDO4HRjGKckpMqPN3wsDli+VsJk=;
 b=Cs6ZRo6wU3hrTSIsSN/2z8zhTJLNwDLfmVsv29txl7bewME+aq095mREH81baVPk+1
 V9oPujkB6/Jkj4/af3RcKEs/aeGQJKu/5S+A6jXQl03mFEvEQW4PpD9TKJWHGadZ88L0
 WqI0RGWJxhXwyTzLWt+jXBBI6lGcngDMqKcd4+ZZdtInmo6UhrvbRVDLc+wqDBJTm+n4
 YWgPi0imXIiG03idBJdnfxhqe1iClMAYb86fSS1Oic4fOZAlbie4t+elUauVLnRGgQa+
 EK/rPHbxJQW3jk0A6MZIOSGTjJzs64UZJgWw1Tui9+VCr5/zHUHwcu/YM95DnwI4ugz0
 oumw==
X-Gm-Message-State: AOAM530lKRfRGI5oj+VM6eN5JnvIhuIj3vbBcS8HXIdgPWcu2czCzFoC
 mj8KXXfK1pswlcjsRK8fHEpM1k7RG2CB8hTZ3tY=
X-Google-Smtp-Source: ABdhPJzZwlVZ+t2U2ZfGhrboARacd/payDjrqhql1iekUaC1CKWZEK0LzNZ3AaFusxLqw1qWZ9No6KB5lm0TrDxGUYQ=
X-Received: by 2002:a4a:8701:: with SMTP id z1mr5148569ooh.68.1636731239382;
 Fri, 12 Nov 2021 07:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20211111093451.69243-1-Perry.Yuan@amd.com>
In-Reply-To: <20211111093451.69243-1-Perry.Yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Nov 2021 10:33:48 -0500
Message-ID: <CADnq5_Pp-YC0fRo5apYMFQFa5iE-+G++DWkTA8_Qe5CWxbVSmQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/pm: add GFXCLK/SCLK clocks level print support
 for APUs
To: Perry Yuan <Perry.Yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Xinmei.Huang@amd.com,
 Huang Rui <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 11, 2021 at 4:35 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> add support that allow the userspace tool like RGP to get the GFX clock
> value at runtime, the fix follow the old way to show the min/current/max
> clocks level for compatible consideration.
>
> === Test ===
> $ cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 200Mhz *
> 1: 1100Mhz
> 2: 1600Mhz
>
> then run stress test on one APU system.
> $ cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 200Mhz
> 1: 1040Mhz *
> 2: 1600Mhz
>
> The current GFXCLK value is updated at runtime.
>
> BugLink: https://gitlab.freedesktop.org/mesa/mesa/-/issues/5260
> Reviewed-by: Huang Ray <Ray.Huang@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Might be cleaner to split this into 3 patches, one for each asic.  Either way:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> ---
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 22 +++++++++++++--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 26 ++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 27 +++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  1 +
>  4 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 3d4c65bc29dc..6e8343907c32 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -308,6 +308,7 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
>  {
>         int ret = 0, size = 0;
>         uint32_t cur_value = 0;
> +       int i;
>
>         smu_cmn_get_sysfs_buf(&buf, &size);
>
> @@ -333,8 +334,6 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
>                 size += sysfs_emit_at(buf, size, "VDDC: %7umV  %10umV\n",
>                                                 CYAN_SKILLFISH_VDDC_MIN, CYAN_SKILLFISH_VDDC_MAX);
>                 break;
> -       case SMU_GFXCLK:
> -       case SMU_SCLK:
>         case SMU_FCLK:
>         case SMU_MCLK:
>         case SMU_SOCCLK:
> @@ -345,6 +344,25 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
>                         return ret;
>                 size += sysfs_emit_at(buf, size, "0: %uMhz *\n", cur_value);
>                 break;
> +       case SMU_SCLK:
> +       case SMU_GFXCLK:
> +               ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, &cur_value);
> +               if (ret)
> +                       return ret;
> +               if (cur_value  == CYAN_SKILLFISH_SCLK_MAX)
> +                       i = 2;
> +               else if (cur_value == CYAN_SKILLFISH_SCLK_MIN)
> +                       i = 0;
> +               else
> +                       i = 1;
> +               size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", CYAN_SKILLFISH_SCLK_MIN,
> +                               i == 0 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +                               i == 1 ? cur_value : CYAN_SKILLFISH_SCLK_DEFAULT,
> +                               i == 1 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", CYAN_SKILLFISH_SCLK_MAX,
> +                               i == 2 ? "*" : "");
> +               break;
>         default:
>                 dev_warn(smu->adev->dev, "Unsupported clock type\n");
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f6ef0ce6e9e2..6852e4b45589 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -683,6 +683,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>         int i, size = 0, ret = 0;
>         uint32_t cur_value = 0, value = 0, count = 0;
>         bool cur_value_match_level = false;
> +       uint32_t min, max;
>
>         memset(&metrics, 0, sizeof(metrics));
>
> @@ -743,6 +744,13 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>                 if (ret)
>                         return ret;
>                 break;
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetGfxclkFrequency, 0, &cur_value);
> +               if (ret) {
> +                       return ret;
> +               }
> +               break;
>         default:
>                 break;
>         }
> @@ -768,6 +776,24 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>                 if (!cur_value_match_level)
>                         size += sysfs_emit_at(buf, size, "   %uMhz *\n", cur_value);
>                 break;
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
> +               max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
> +               if (cur_value  == max)
> +                       i = 2;
> +               else if (cur_value == min)
> +                       i = 0;
> +               else
> +                       i = 1;
> +               size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
> +                               i == 0 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +                               i == 1 ? cur_value : VANGOGH_UMD_PSTATE_STANDARD_GFXCLK,
> +                               i == 1 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
> +                               i == 2 ? "*" : "");
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a403657151ba..cb5326d98f3e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -781,6 +781,11 @@ static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
>         case SMU_FCLK:
>                 return smu_cmn_send_smc_msg_with_param(smu,
>                                 SMU_MSG_GetFclkFrequency, 0, value);
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               return smu_cmn_send_smc_msg_with_param(smu,
> +                               SMU_MSG_GetGfxclkFrequency, 0, value);
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1051,6 +1056,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
>  {
>         int i, size = 0, ret = 0;
>         uint32_t cur_value = 0, value = 0, count = 0;
> +       uint32_t min, max;
>
>         smu_cmn_get_sysfs_buf(&buf, &size);
>
> @@ -1089,6 +1095,27 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
>                                         cur_value == value ? "*" : "");
>                 }
>                 break;
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
> +               if (ret)
> +                       goto print_clk_out;
> +               min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
> +               max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
> +               if (cur_value  == max)
> +                       i = 2;
> +               else if (cur_value == min)
> +                       i = 0;
> +               else
> +                       i = 1;
> +               size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
> +                               i == 0 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +                               i == 1 ? cur_value : YELLOW_CARP_UMD_PSTATE_GFXCLK,
> +                               i == 1 ? "*" : "");
> +               size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
> +                               i == 2 ? "*" : "");
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> index b3ad8352c68a..a9205a8ea3ad 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> @@ -24,5 +24,6 @@
>  #define __YELLOW_CARP_PPT_H__
>
>  extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
> +#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
>
>  #endif
> --
> 2.25.1
>
