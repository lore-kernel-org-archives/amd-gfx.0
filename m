Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF1C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27AE208B3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhKRNb0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27AE208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14CB6EA98;
	Wed, 14 Oct 2020 13:18:39 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566F56EA9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:18:38 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id e23so2273405wme.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yvVNsKWBRJ+f2GSHiBo+rHzJFbzh+nm0bUNSdSuWhvg=;
 b=EhKRNb0l3HYisdiAiYWwHuoO4grzUyguDny78bDDeaBX0OyYZJ/d/zgRJWIZdoz5TU
 58+LnGGeJO5HsnUewMEWq4fe5W4bJp67dFw97Tm/3ZozN0DpYQsOLH/pRhliqopmtbyK
 KD5ARTWeZ4ahSnuRMk6vFOFVC71JF524Zt3nnRSoPFl/1aZcjEM8wo15mqwF0CRLfou4
 IRWyQl93FtN5U8Wv8ALsv0HZlmvZUZL3aXSAGi28D3kyfQVMizSkOCvGN3V+cfWTEo8I
 TwOIGJG4ie11Vl0xNKxGLKiw+g3Lydy93srVCPnPR17kCPNnZcVAfJTK/zJdnJXJ84c5
 y2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yvVNsKWBRJ+f2GSHiBo+rHzJFbzh+nm0bUNSdSuWhvg=;
 b=YgKXw2sRVAZEXgvMxxlSsUZKLE8+CvTbWHfFzhw5mlB+I0JY5GNd16NOIlppx5cshD
 LdMYooSFPm/jOIzwsGuP6WwQLyTtBgu1/PvaomZpfTnywTQsxnhvg4Ng3vpNk21sS4vL
 8oCPu8Ia0jso/VK7LBtJ7itd6JPmAYyyDEF60aldGN0z7qTvzI7eHssya9WzZlVLb+Fl
 N94kA7JT2rKpY5EBPUOMtsEioVVabx9s2OLwXHx0gKmMlufRXcwnAtpLF00edn7JEmZq
 nMwg5PHQ2XOtUhAZOaCHEShm0ez8mEuJvQDEM9sf5zTaqT/S1Es5YdZIopiCkr0amyJg
 sKdQ==
X-Gm-Message-State: AOAM5324cYiHQDjkGYDSorKb3yG7kcjuZwBpguE6FCkjzzGjUnXsbQXI
 NpiriHt0/xmX45/chgbOwiwHNQGIaBiuH+UYzM+rcIp8
X-Google-Smtp-Source: ABdhPJyHXOCyHKWMyc9tjJ7fb2dGLb8X4ylW+zMm+9Lu072xWkWDavbvQn8mNhPJ2KDYYcnpK3a+V9qp8YwInuN1jXA=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr3410507wma.70.1602681516983; 
 Wed, 14 Oct 2020 06:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201014052023.7085-1-evan.quan@amd.com>
 <20201014052023.7085-2-evan.quan@amd.com>
In-Reply-To: <20201014052023.7085-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2020 09:18:25 -0400
Message-ID: <CADnq5_MxB_N5kAW6AGUYvWRTkZGu9GGrHM4rocMz4gJeyO6i-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2020 at 1:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Populate current link speed, width and clock domain frequency.
>
> Change-Id: Ic342fbd8f5e2495d212eaa4b85b4e146838e0525
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c             |  3 ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 46eea3f8f958..f87411cfa4da 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2124,9 +2124,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (asic_type < CHIP_VEGA20)
>                         *states = ATTR_STATE_UNSUPPORTED;
> -       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> -               if (asic_type == CHIP_ARCTURUS)
> -                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>                 *states = ATTR_STATE_UNSUPPORTED;
>                 if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index f982b9090d7b..46d950757230 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -720,6 +720,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>         struct smu_11_0_dpm_table *single_dpm_table;
>         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>         struct smu_11_0_dpm_context *dpm_context = NULL;
> +       uint32_t gen_speed, lane_width;
>
>         if (amdgpu_ras_intr_triggered())
>                 return snprintf(buf, PAGE_SIZE, "unavailable\n");
> @@ -823,6 +824,23 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                                 now) ? "*" : ""));
>                 break;
>
> +       case SMU_PCIE:
> +               gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
> +               lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
> +               size += sprintf(buf + size, "0: %s %s %dMhz *\n",
> +                               (gen_speed == 0) ? "2.5GT/s," :
> +                               (gen_speed == 1) ? "5.0GT/s," :
> +                               (gen_speed == 2) ? "8.0GT/s," :
> +                               (gen_speed == 3) ? "16.0GT/s," : "",
> +                               (lane_width == 1) ? "x1" :
> +                               (lane_width == 2) ? "x2" :
> +                               (lane_width == 3) ? "x4" :
> +                               (lane_width == 4) ? "x8" :
> +                               (lane_width == 5) ? "x12" :
> +                               (lane_width == 6) ? "x16" : "",
> +                               smu->smu_table.boot_values.lclk / 100);

We should put a * by the link speed for consistency with other asics.

Alex


> +               break;
> +
>         default:
>                 break;
>         }
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
