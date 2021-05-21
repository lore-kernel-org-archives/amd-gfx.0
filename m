Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC98FC4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B56135A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B56135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD896F88C;
	Fri, 21 May 2021 14:27:28 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0626EC6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:27:27 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 v13-20020a4aa40d0000b02902052145a469so4621048ool.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qOo5CK2lZ5CXwIg6I4P9lVmOeRCutBH+8w12HGFlDuo=;
 b=vFWqf4a5zQexbMm4LzbEVn0F/D98Zto4BqVVMfE7V5/s1A1Fg0FRiins+2oxFR7pn/
 UUOI6AWAk38WpN9WTVMeLE+nrCVMvEw7EnWZkxHS+Et808dcb8dgJm5Ig1oP15UzTSYz
 H6UgjqnZu6/P0nxQJG61f4LxJQnh7D2bOpXdMkVYL0sSzgCgkOAKXw28IN1apxX+gOFy
 LDUTFP5wd0R3SupMrZZYgMCMawYCGjGCPASMF/q746XPUZgc7E3W6/V1u0/mKvPFuunx
 QtWdsqAwYJ8aN3mIh2foSdHTAN2tpcnWDisQrzHDs3tsy+Wxn1RGPQdoB97/KXoqmiuR
 2N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qOo5CK2lZ5CXwIg6I4P9lVmOeRCutBH+8w12HGFlDuo=;
 b=KER4pgXEveolxIMel4pQgXgIz4kX9W4PuDVs/uD/xUhsVgAdM+kkWmD67m/eRLEGpv
 WQUA6V/h30vDUvQair2zJcH1xIZj3GMKYHgWpiDNZPn6lF4MCJFqa/qHdbLs/J/ZKUe9
 iS+0g9sHmrlF4+4thsjgWF/kCA19GxdaPx3+h/J+cJPx8RWOXR+mWU1rW93jVmb9P+aY
 MPza/llnwDb0I31JqCWdeNEWnLLLLb0ten7bQBZwO0lhiPZtdw0YCaEExt1MMvtk+Mec
 wrMIRx2hlMCfpFZaFHLFKMhQ+83AjRqANmOU+E2r18s2LWEhtgkELjY+tCC3BxM2Jffz
 ZIGQ==
X-Gm-Message-State: AOAM533H1Q08rDw/BtQhx9FEX9wJT98sJAaS8o/K3Vo9vrVDqWlUqwX7
 nL8fYcvmFRToFzKYRNA8aKr0C7INy24NPgYqVIMb/pWd
X-Google-Smtp-Source: ABdhPJwNmSO7048ROZkVOL0RRQxjvxYsDAZ3L8iX1n1OBeL01zzzwKZ3LxMUoE2GgNyWVandcs1DQAplG2Phy6UZagw=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr8429630oos.72.1621607246578;
 Fri, 21 May 2021 07:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
In-Reply-To: <20210520142930.8369-2-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 10:27:15 -0400
Message-ID: <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
To: Graham Sider <Graham.Sider@amd.com>
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

General comment on the patch series, do you want to bump the metrics
table version since the meaning of the throttler status has changed?

Alex

On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
>
> Perform dependent to independent throttle status translation for
> arcturus.
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62 ++++++++++++++++---
>  1 file changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1735a96dd307..7c01c0bf2073 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
>         return (abs(frequency1 - frequency2) <= EPSILON);
>  }
>
> +static uint32_t arcturus_get_indep_throttler_status(
> +                                       unsigned long dep_throttler_status)
> +{
> +       unsigned long indep_throttler_status = 0;
> +
> +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_VRHOT1_BIT, &dep_throttler_status));
> +
> +       return (uint32_t)indep_throttler_status;
> +}
> +
>  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>                                          MetricsMember_t member,
>                                          uint32_t *value)
> @@ -629,7 +672,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>                 break;
>         case METRICS_THROTTLER_STATUS:
> -               *value = metrics->ThrottlerStatus;
> +               *value = arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
>                 break;
>         case METRICS_CURR_FANSPEED:
>                 *value = metrics->CurrFanSpeed;
> @@ -2213,13 +2256,13 @@ static const struct throttling_logging_label {
>         uint32_t feature_mask;
>         const char *label;
>  } logging_label[] = {
> -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
>  };
>  static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
>  {
> @@ -2314,7 +2357,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
>         gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
>
> -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +       gpu_metrics->throttle_status =
> +                       arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
>
>         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
