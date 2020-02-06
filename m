Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D143C2D0B1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A4120659
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKD4qkTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A4120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8198D6EA7E;
	Thu,  6 Feb 2020 14:00:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D032E6EA7E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 14:00:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q9so62076wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 06:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7dzMOykjvCg2oAYJpvA35l745jJrhcAtEyizTleFoyw=;
 b=lKD4qkTMCTHLQDafJV3HUoNCISgDqubLK4bKNrzhlyQGZmHyCB7s8URNscrNQ66gSD
 dwWCzrriIXIuqyputCCFuKZ4pZcKlOZsRCKWQ/J9s2Gftft+T9FL6jQ62fmxAhcgw6B0
 XoXVm7MEgBkECvEVZZGbQl/DIWpxARttrtxJSiyEHZGSD9goLkWQzNsGbRWXfXouzDLa
 0YQKggr79y05WsIzdhZAkcyxKpmpWiFpb0o9ldKREWp/fqa8PZmXvxzWUCvP7DMSkdJx
 c5fhEv3nV+xpt81RPm4dOZGpT9tcaDcJElnm1clfX/i3xRfQGSM+3FCCSWxgNeG/T9jo
 eyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7dzMOykjvCg2oAYJpvA35l745jJrhcAtEyizTleFoyw=;
 b=LQAEkxU/XqJgf7nPt+K9jtmoq45u07addI2rIHcgF55ZgxqwE0AU6PnY19lMOIKLlf
 QnT2VYeyq2YIN8+rf6puDDFH3C04tq3WTGkLRc+jxZimzbM5bYzK+tpO40Kwl5KKKJzB
 U4ROfmgmVVS7rjtlNpS8dGcb56edpFA8MZ8711I5g+OZd8ZzsETL/kcfLIXVP731+R78
 edNg8BrDwT8QPdeqlsjPbEWm9eL0sJaHWMxQgLfNXS31FCPZklzJVR4N9pwF507jXw+x
 4IzkS1mrBjrTZcz2KYMsWEqEPZJZ0o8kRxSbhn2d65stoOGvc5eRPBcijdcv63BEXi9J
 Ry1g==
X-Gm-Message-State: APjAAAV9147zU3xJ1wDNM+8m09B/0+LbrC51xPM5BpcWmcdQZCrX5V9B
 kmlRSQDSo2VwYzKiO63JH/jLrPCS6JnnwOOGCLq1L+0p
X-Google-Smtp-Source: APXvYqxliMQ7NzHqNTcED1u9UyoJW4dm897uzMvPaBEocLlHFQHYJp4CjNNFC/y8+3rHvYP/tt4ySI4cebSDFmydWo8=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr4748827wmg.39.1580997653416; 
 Thu, 06 Feb 2020 06:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20200206081920.18766-1-evan.quan@amd.com>
In-Reply-To: <20200206081920.18766-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2020 09:00:42 -0500
Message-ID: <CADnq5_Obdf0pL8vuereUPGsVZWPaHX1J3Fkni3_ZFbUOxFMrfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 6, 2020 at 3:19 AM Evan Quan <evan.quan@amd.com> wrote:
>
> SMU FW will handle the features disablement for baco reset
> on Arcturus.
>
> Change-Id: Ifd87a09de2fca0c67c041afbd5e711973769119a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 53 +++++++++++++++++-----
>  1 file changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 9d1075823681..efd10e6fa9ef 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1467,24 +1467,39 @@ void smu_late_fini(void *handle)
>         smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);
>  }
>
> -static int smu_suspend(void *handle)
> +static int smu_disabled_dpms(struct smu_context *smu)
>  {
> -       int ret;
> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       struct smu_context *smu = &adev->smu;
> -       bool baco_feature_is_enabled = false;
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t smu_version;
> +       int ret = 0;
>
> -       if (!smu->pm_enabled)
> -               return 0;
> +       ret = smu_get_smc_version(smu, NULL, &smu_version);
> +       if (ret) {
> +               pr_err("Failed to get smu version.\n");
> +               return ret;
> +       }
>
> -       if(!smu->is_apu)
> -               baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
> +       /*
> +        * For baco reset on Arcturus, this operation
> +        * (disable all smu feature) will be handled by SMU FW.
> +        */
> +       if (adev->in_gpu_reset &&
> +           (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
> +           (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
> +               return 0;

Do we need the in_gpu_reset check here?  Is there ever a case where
would ever want to execute the rest of this?  What if we enable BACO
for power savings on arcturus?

>
> +       /* Disable all enabled SMU features */
>         ret = smu_system_features_control(smu, false);
> -       if (ret)
> +       if (ret) {
> +               pr_err("Failed to disable smu features.\n");
>                 return ret;
> +       }
>
> -       if (baco_feature_is_enabled) {
> +       /* For baco reset, need to leave BACO feature enabled */
> +       if (adev->in_gpu_reset &&
> +           (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
> +           !smu->is_apu &&
> +           smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {

This change will break BACO for power savings on navi1x.  I think we
can drop this hunk.

>                 ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
>                 if (ret) {
>                         pr_warn("set BACO feature enabled failed, return %d\n", ret);
> @@ -1492,6 +1507,22 @@ static int smu_suspend(void *handle)
>                 }
>         }
>
> +       return ret;
> +}
> +
> +static int smu_suspend(void *handle)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +       struct smu_context *smu = &adev->smu;
> +       int ret;
> +
> +       if (!smu->pm_enabled)
> +               return 0;
> +
> +       ret = smu_disabled_dpms(smu);
> +       if (ret)
> +               return ret;
> +
>         smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
>
>         if (adev->asic_type >= CHIP_NAVI10 &&
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
