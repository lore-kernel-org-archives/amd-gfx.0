Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95FC3F68F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 14:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A0220663
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPMPMts2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1300689E39;
	Mon, 30 Dec 2019 14:46:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD87189E39
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 14:46:40 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g17so32840834wro.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 06:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hzIVb4DXTwnGfh478eslirMbaI9p6LZG9Z2972Bd+V4=;
 b=SPMPMts2T7Uoxvi/0QQ1HJLi14dLHHFoOwgcfVcPikARCcZQ2BVvKFw2huJvryXybB
 5avkQXYXZTSR8zoW+W80W7umoTeZk95MGQ/pLo8aL+vM1qvNwWD+ZvxsnaQU9zwS/1zW
 FC4Gb8oc0L9vXyOR2cjlJToFBaeiEUxTAkgN+HGOgWIw4x6OvYEq+Ib3zAKMHJ9rBeoP
 c/aynanDvVsED3utPrepv5xm/V7dgvoibmtmB3SoxdXQnmv4T9uNjWLjb5lcpNIIHkVN
 wYGysoVInL/ak1deVOTW7PcQu84ZsIZPy4M4e0cgCTAJYkIYxfBYzG+zJ7Z14OtVYNYt
 IT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hzIVb4DXTwnGfh478eslirMbaI9p6LZG9Z2972Bd+V4=;
 b=Yt48IIaazImjNCaQ0wp6jeZ45SsK6K7VZxh4A5L2+oRF95CXBpdfSdW2h2Ga2bED5m
 p21yiSYOmOuZ0/5QcJAQ5D9sC5eMplm4SZ6xa4J1zxhXiYPcVwAS9irfWOI3MdVliyMR
 cG8LLkOtryq7gVe98CIgHD5N/I3Xi825TwjQVAMTRKOKUu+PxCH2eBLz7xLxY9VrUHqO
 355ioUgxV3e4orG7bL3I8yuXxJtrm9IBwmjieJ1PLSbVZQ3ikH3HUX8k86lHZ6+1pVE6
 XXnqkAMlQjDmVBklaAaae1u2GkTGD2F1j0NV5ebb/Y12GogQPumAgie9a2cVFCqncWfi
 Mp3g==
X-Gm-Message-State: APjAAAWQ3V9bhlcypWYpRelnXTDMMJ13sbACs3ac1MdkhDQnui8UZS22
 VeLLZyn3hH6fukhp9Ry/xf8EQO98DMN6w/ss1b8=
X-Google-Smtp-Source: APXvYqwo9SSQrGq2j0FkhSfwafATOr+6nV9lyb6SjVW/6JlSGzMvj6UEEmtNEWQqWWcTFK+7DHM68HvK29qMDevBnMQ=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr67189022wru.40.1577717199004; 
 Mon, 30 Dec 2019 06:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20191230104129.28165-1-evan.quan@amd.com>
In-Reply-To: <20191230104129.28165-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Dec 2019 09:46:27 -0500
Message-ID: <CADnq5_Pb=N2w7Q4FSFu7vrsNaLAO=o-vhmNh5H1L_BgbOT+HJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: retrieve the enabled feature mask from
 cache
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 30, 2019 at 5:41 AM Evan Quan <evan.quan@amd.com> wrote:
>
> This is why those feature mask members designed for. And this
> can reduce the SMU workload.
>
> Change-Id: I2c6e12e945508f7b2fd79bc172efa68bc6150d05
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 61 +++++++++++++---------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4b686f0af538..290976f5f6c2 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1313,7 +1313,7 @@ static int smu_hw_init(void *handle)
>
>  static int smu_stop_dpms(struct smu_context *smu)
>  {
> -       return smu_send_smc_msg(smu, SMU_MSG_DisableAllSmuFeatures);
> +       return smu_system_features_control(smu, false);
>  }
>
>  static int smu_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 962e97860fe8..e804f9854027 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -855,27 +855,33 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
>                                       uint32_t *feature_mask, uint32_t num)
>  {
>         uint32_t feature_mask_high = 0, feature_mask_low = 0;
> +       struct smu_feature *feature = &smu->smu_feature;
>         int ret = 0;
>
>         if (!feature_mask || num < 2)
>                 return -EINVAL;
>
> -       ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
> -       if (ret)
> -               return ret;
> -       ret = smu_read_smc_arg(smu, &feature_mask_high);
> -       if (ret)
> -               return ret;
> +       if (bitmap_empty(feature->enabled, feature->feature_num)) {
> +               ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
> +               if (ret)
> +                       return ret;
> +               ret = smu_read_smc_arg(smu, &feature_mask_high);
> +               if (ret)
> +                       return ret;
>
> -       ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
> -       if (ret)
> -               return ret;
> -       ret = smu_read_smc_arg(smu, &feature_mask_low);
> -       if (ret)
> -               return ret;
> +               ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
> +               if (ret)
> +                       return ret;
> +               ret = smu_read_smc_arg(smu, &feature_mask_low);
> +               if (ret)
> +                       return ret;
>
> -       feature_mask[0] = feature_mask_low;
> -       feature_mask[1] = feature_mask_high;
> +               feature_mask[0] = feature_mask_low;
> +               feature_mask[1] = feature_mask_high;
> +       } else {
> +               bitmap_copy((unsigned long *)feature_mask, feature->enabled,
> +                            feature->feature_num);
> +       }
>
>         return ret;
>  }
> @@ -887,21 +893,24 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>         uint32_t feature_mask[2];
>         int ret = 0;
>
> -       if (smu->pm_enabled) {
> -               ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
> -                                            SMU_MSG_DisableAllSmuFeatures));
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
> +       ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
> +                                    SMU_MSG_DisableAllSmuFeatures));
>         if (ret)
>                 return ret;
>
> -       bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
> -                   feature->feature_num);
> -       bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -                   feature->feature_num);
> +       if (en) {
> +               ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
> +               if (ret)
> +                       return ret;
> +
> +               bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
> +                           feature->feature_num);
> +               bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> +                           feature->feature_num);
> +       } else {
> +               bitmap_zero(feature->enabled, feature->feature_num);
> +               bitmap_zero(feature->supported, feature->feature_num);
> +       }
>
>         return ret;
>  }
> --
> 2.24.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
