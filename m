Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D62C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 12:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388B52070B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 12:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFHpMlgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388B52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE9E6E97D;
	Thu,  7 May 2020 12:55:22 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B0B6E97D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 12:55:22 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e16so6264621wra.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m2C6e/ybGxHsVZlCeU9V8hJ6yYItPtEe1cKHHNbYSpk=;
 b=nFHpMlgboBa7tmvz4u/9TVYzP8H+sGmLl5Rf9WhHZSoTY3qqE70Dik5NqpJuhRlkjT
 z6Q4g3F5lJQ/D4LlTCJDnwDmQeo86PU+YzPcykQTOvphktj1r/rhZ5fzc2eYCzAb82WB
 j9bbW6zZZTbQZrfiVGBOhClwIuE7idxicnFyewAwfXkfgMCRxlRfCzrQZDuXKqgPRGTX
 4HI3dqMWtixAjZD0Vk6rGN246itMIXmXfTAlPq3pSm4PZjJwznWW6hVE2B7ckVyvrOyb
 0xdY/IJ0hLh7CnvG4/xJlYNEMWZiKdye63nsHVSv2i6nF5zifPIMDu9uLI+GeKgNUmGy
 dggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m2C6e/ybGxHsVZlCeU9V8hJ6yYItPtEe1cKHHNbYSpk=;
 b=tGQ/uQhQHMoPIRaAeq5JrtlRenaAcHlcZKinQ3L9KCKenyYuXPr6IdU9EQSB6bkjO5
 zs4Q1p44/ktoJeAPOtIrr8uBajBx/slFAfWEjmhgmEDHI2xquSs4LZ596jM0ZFlkp03B
 jcrR17BuRcqDozF3uG25sPYrnv8d34D0/v7RSbPmKjihO05lp1K9Nt4w8AI3LTn5axtr
 hMA8ekCySQw6AncUxpZjZgQ+CkebItwH659N+4/YsT2YSEsNhSjwI8FEnO2OM//gCPj2
 Gb+pngu1pqADl+0GRjFeo+leBhdyPLj7yAOKyG16NtyQTz8Ar+zVK0qcwORGEU+JatVr
 z3vA==
X-Gm-Message-State: AGi0Pubi3ngUewJONg4INgQMEu8Isw+TzSWS0Y0By5DEKw/ShlD9wyOa
 1/U+3ah+Quuru/gyK6d2JjeT5TF9f6boI02Se5c=
X-Google-Smtp-Source: APiQypK4/vuPApOW8E6YkLDVgUGLjG/+UOI4KD0x/OUBlP8hh8+Gfq/JEVdT7XafLP79rDPggdgt+TqKhN7LgZQF5bA=
X-Received: by 2002:a5d:4151:: with SMTP id c17mr15121421wrq.111.1588856121352; 
 Thu, 07 May 2020 05:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200507102544.6915-1-evan.quan@amd.com>
In-Reply-To: <20200507102544.6915-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 08:55:10 -0400
Message-ID: <CADnq5_OGCnjXmD3ZVGw2+od+kiWaAo_zqwVNASdyv9X2R4tAzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable hibernate support on Navi1X
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 7, 2020 at 6:26 AM Evan Quan <evan.quan@amd.com> wrote:
>
> BACO is needed to support hibernate on Navi1X.
>
> Change-Id: Ia283612919e9a5b4e1e198ab2cc0bc15f7f94760
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5bd213f88ae5..e649a3d3fd7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1010,6 +1010,7 @@ struct amdgpu_device {
>
>         /* s3/s4 mask */
>         bool                            in_suspend;
> +       bool                            in_hibernate;
>
>         bool                            in_gpu_reset;
>         enum pp_mp1_state               mp1_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index eb351844e46c..5eaa5ea83d0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1260,7 +1260,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
>         struct amdgpu_device *adev = drm_dev->dev_private;
>         int r;
>
> +       adev->in_hibernate = true;
>         r = amdgpu_device_suspend(drm_dev, true);
> +       adev->in_hibernate = false;
>         if (r)
>                 return r;
>         return amdgpu_asic_reset(adev);
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8a0c37dc5182..f1621147db61 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1500,7 +1500,7 @@ static int smu_disable_dpm(struct smu_context *smu)
>         bool use_baco = !smu->is_apu &&
>                 ((adev->in_gpu_reset &&
>                   (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
> +                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
>
>         ret = smu_get_smc_version(smu, NULL, &smu_version);
>         if (ret) {
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
