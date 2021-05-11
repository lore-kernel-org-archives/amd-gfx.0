Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA6C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F30F61930
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F30F61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E19C6E9EF;
	Tue, 11 May 2021 07:49:33 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A476E9A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 03:33:06 +0000 (UTC)
Received: from mail-lj1-f199.google.com ([209.85.208.199])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lgJ8p-0006CO-Lz
 for amd-gfx@lists.freedesktop.org; Tue, 11 May 2021 03:33:05 +0000
Received: by mail-lj1-f199.google.com with SMTP id
 h1-20020a2e9ec10000b02900edf305c2e1so603860ljk.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 20:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpZ1o8BZbVj97ScJ5uIe5Iz8N7aLUvfNU9S9Nz3IzwM=;
 b=XjRpWU+WSR/1ZAVT1tr5QWvAx4dyhm8Mbz5JTTrQdkIuHM+im+NdrHHFtJNE+S+mtb
 xmbPCAneyKbuz4geCXq5RKkMEgQPgmjYrl9xS94UeSNWr6kfrA2DgztFas9pSH5ZrFnl
 te2Xyci3SHBx3ZxEnx2h7yi9QKEOPqV0SgOzhF43IxObThySAxYQCPXSc2V0Zl/r4AMK
 K0C6NTkzEheVyhSKVVfsQlcJoiOdGqDB4/Z+ElIL8DqhvH1pKI37c8ZFnOJPP6Ro5Lth
 XHq/E+B3saqlVK3wE7uDkokJSzkHnXgDy52BovH+5TJYKhzf+JMZJV0wxxDrCxlXLBHD
 IOVw==
X-Gm-Message-State: AOAM533CF8YeN6BSwBV+ht5e4dOOmzJf6JkG+8DEQbJqGe2rD9jn9+he
 Z/4OgQTtLgv/BJAZep3Z/1X+WIgZIt/FwRkpexSRHLTtpILOI8FFOZx0Kw6C3AUavEAhHW2DjvH
 t2f0AVM8s7Ljy4/q73MT3haiwRfZdmIslnWmHY5abGLcWnr5zrXzrbWyds2U=
X-Received: by 2002:a05:6512:3b93:: with SMTP id
 g19mr19441660lfv.548.1620703983110; 
 Mon, 10 May 2021 20:33:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ3I3h7WqnNP7SEfWG7sKaQkaYZUkTMSdI76PL8q58FqDBzKUFS9tR8ZJAqHuO5+E46Kf0NlHlj83wxal64HY=
X-Received: by 2002:a05:6512:3b93:: with SMTP id
 g19mr19441646lfv.548.1620703982869; 
 Mon, 10 May 2021 20:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210430045656.577395-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210430045656.577395-1-kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 11 May 2021 11:32:50 +0800
Message-ID: <CAAd53p4fLYXB0z7OQOmAS_BkACARTrrfRf+QwWd3MYQhk5oFTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/dpm: Disable sclk switching on Oland when
 two 4K 60Hz monitors are connected
To: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
X-Mailman-Approved-At: Tue, 11 May 2021 07:49:32 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 30, 2021 at 12:57 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen flickers rapidly when two 4K 60Hz monitors are in use. This issue
> doesn't happen when one monitor is 4K 60Hz (pixelclock 594MHz) and
> another one is 4K 30Hz (pixelclock 297MHz).
>
> The issue is gone after setting "power_dpm_force_performance_level" to
> "high". Following the indication, we found that the issue occurs when
> sclk is too low.
>
> So resolve the issue by disabling sclk switching when there are two
> monitors requires high pixelclock (> 297MHz).
>
> v2:
>  - Only apply the fix to Oland.
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/gpu/drm/radeon/radeon.h    | 1 +
>  drivers/gpu/drm/radeon/radeon_pm.c | 8 ++++++++
>  drivers/gpu/drm/radeon/si_dpm.c    | 3 +++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index 42281fce552e6..56ed5634cebef 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -1549,6 +1549,7 @@ struct radeon_dpm {
>         void                    *priv;
>         u32                     new_active_crtcs;
>         int                     new_active_crtc_count;
> +       int                     high_pixelclock_count;
>         u32                     current_active_crtcs;
>         int                     current_active_crtc_count;
>         bool single_display;
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index 0c1950f4e146f..3861c0b98fcf3 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -1767,6 +1767,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>         struct drm_device *ddev = rdev->ddev;
>         struct drm_crtc *crtc;
>         struct radeon_crtc *radeon_crtc;
> +       struct radeon_connector *radeon_connector;
>
>         if (!rdev->pm.dpm_enabled)
>                 return;
> @@ -1776,6 +1777,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>         /* update active crtc counts */
>         rdev->pm.dpm.new_active_crtcs = 0;
>         rdev->pm.dpm.new_active_crtc_count = 0;
> +       rdev->pm.dpm.high_pixelclock_count = 0;
>         if (rdev->num_crtc && rdev->mode_info.mode_config_initialized) {
>                 list_for_each_entry(crtc,
>                                     &ddev->mode_config.crtc_list, head) {
> @@ -1783,6 +1785,12 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>                         if (crtc->enabled) {
>                                 rdev->pm.dpm.new_active_crtcs |= (1 << radeon_crtc->crtc_id);
>                                 rdev->pm.dpm.new_active_crtc_count++;
> +                               if (!radeon_crtc->connector)
> +                                       continue;
> +
> +                               radeon_connector = to_radeon_connector(radeon_crtc->connector);
> +                               if (radeon_connector->pixelclock_for_modeset > 297000)
> +                                       rdev->pm.dpm.high_pixelclock_count++;
>                         }
>                 }
>         }
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 9186095518047..3cc2b96a7f368 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -2979,6 +2979,9 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
>                     (rdev->pdev->device == 0x6605)) {
>                         max_sclk = 75000;
>                 }
> +
> +               if (rdev->pm.dpm.high_pixelclock_count > 1)
> +                       disable_sclk_switching = true;
>         }
>
>         if (rps->vce_active) {
> --
> 2.30.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
