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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB8C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F274520736
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqpcmNC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F274520736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF0F6E133;
	Thu,  7 May 2020 16:09:37 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1FD6E149
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:09:36 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id u16so7447021wmc.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qeY6IgMqm2VQCl3scx6849xH97ZLQUVmhZ8bFB91y/o=;
 b=pqpcmNC9MA+gvn8bWwjqKTGImOAiUGNpUGSOKiFKq3lafxes5V5MumonglEs+1E0Px
 4yRu/6C0C4HRBOljm9JJn7091aXln1qjXU78p+fK/h+2Ru693OWGn6lNKIzZ4+AsgyVW
 gWTH5HL+2bwdu4+Dmw1gjOSH5i+XKJVd85c2UOs4ENcCJKRLL9yMt60l5pXMiww7WjGj
 OkdkAK7135HHqToEnW8kUoHzyl3DFPcbfNsZFuOnm6sMIAxs17yAdcEgJKlKYy2A+gvY
 TyHRLwTRjzPnKwucrk2rr+1u/KRnZcXKWxle6gaZCN4fA5HnhBqd2oC2bEOByeigCW6x
 bZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qeY6IgMqm2VQCl3scx6849xH97ZLQUVmhZ8bFB91y/o=;
 b=itzsp9wHLVwAO3fgFbwXxgXKzLLX/pa4SIMmD3XpV4zU4JPDyFnGbTlre8f3GjE36d
 sA9oUaHfBkXJt1rXzJCFarohcXZJMr6k0J6uT+4iktB/sIKEL+/yHHC5BfLVP0r3Ktbd
 8hJ+2+VksjxBlRtl9KMWnsdJE4amlY4YFTrbLwgsu1WHQ73WDjy0ajefea1Jx1CMs2AJ
 f5OP6msDxwx40Xgaf+FDViwo6J6gT52k54MgchWsav2LjjsG4CJH5H/v1KEINrjhlzbH
 RY7Pi8jlzKaA9gixyzKqNNuWQef2DvWNj5oJRN0XKd1Z8eU3GxKLMPJ7SexCu4x6GWuR
 PVFw==
X-Gm-Message-State: AGi0PuahDcMm2ouqf8OxiKoxVb1C3U2lN0yFjW3DmThWHhKI78quQ3jk
 mN1pJIgT9GiOaCQBUYZpb5jgBkaum1lJJ91sQJLNAA==
X-Google-Smtp-Source: APiQypIwGlE0rGPMbJiJYOalLta9J4ayYbzids9tV9kPkd65w5qSDrhSY7Hd6lus7HVyZvNCj7OF4Rz1jB7mhldg4Ew=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr11142977wmh.39.1588867774780; 
 Thu, 07 May 2020 09:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505194812.185370-1-alexander.deucher@amd.com>
In-Reply-To: <20200505194812.185370-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 12:09:23 -0400
Message-ID: <CADnq5_Oizm+QJjJ2FxQERWXdvWy_g=8=QMh2POGH5-tR44M7bA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify ATIF backlight handling
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, May 5, 2020 at 3:48 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Just register the a pointer to the backlight device and use
> that. Unifies the DC and non-DC handling.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 73 ++++++++++--------------
>  1 file changed, 30 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 956cbbda4793..913c8f0513bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -64,7 +64,9 @@ struct amdgpu_atif {
>         struct amdgpu_atif_notifications notifications;
>         struct amdgpu_atif_functions functions;
>         struct amdgpu_atif_notification_cfg notification_cfg;
> -       struct amdgpu_encoder *encoder_for_bl;
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +       struct backlight_device *bd;
> +#endif
>         struct amdgpu_dm_backlight_caps backlight_caps;
>  };
>
> @@ -444,45 +446,21 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>
>                 DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
>
> -               if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
> -                   !amdgpu_device_has_dc_support(adev)) {
> -                       struct amdgpu_encoder *enc = atif->encoder_for_bl;
> -
> -                       if (enc) {
> -                               struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> -
> -                               DRM_DEBUG_DRIVER("Changing brightness to %d\n",
> -                                                req.backlight_level);
> -
> -                               amdgpu_display_backlight_set_level(adev, enc, req.backlight_level);
> -
> -#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> -                               backlight_force_update(dig->bl_dev,
> -                                                      BACKLIGHT_UPDATE_HOTKEY);
> -#endif
> -                       }
> -               }
> -#if defined(CONFIG_DRM_AMD_DC)
> +               if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
>  #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> -               if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
> -                   amdgpu_device_has_dc_support(adev)) {
> -                       struct amdgpu_display_manager *dm = &adev->dm;
> -                       struct backlight_device *bd = dm->backlight_dev;
> -
> -                       if (bd) {
> +                       if (atif->bd) {
>                                 DRM_DEBUG_DRIVER("Changing brightness to %d\n",
>                                                  req.backlight_level);
> -
>                                 /*
>                                  * XXX backlight_device_set_brightness() is
>                                  * hardwired to post BACKLIGHT_UPDATE_SYSFS.
>                                  * It probably should accept 'reason' parameter.
>                                  */
> -                               backlight_device_set_brightness(bd, req.backlight_level);
> +                               backlight_device_set_brightness(atif->bd, req.backlight_level);
>                         }
> -               }
> -#endif
>  #endif
> +               }
> +
>                 if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
>                         if (adev->flags & AMD_IS_PX) {
>                                 pm_runtime_get_sync(adev->ddev->dev);
> @@ -829,23 +807,32 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>         adev->atif = atif;
>
>         if (atif->notifications.brightness_change) {
> -               struct drm_encoder *tmp;
> -
> -               /* Find the encoder controlling the brightness */
> -               list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
> -                               head) {
> -                       struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
> -
> -                       if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
> -                           enc->enc_priv) {
> -                               struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> -                               if (dig->bl_dev) {
> -                                       atif->encoder_for_bl = enc;
> -                                       break;
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +               if (amdgpu_device_has_dc_support(adev)) {
> +#if defined(CONFIG_DRM_AMD_DC)
> +                       struct amdgpu_display_manager *dm = &adev->dm;
> +                       atif->bd = dm->backlight_dev;
> +#endif
> +               } else {
> +                       struct drm_encoder *tmp;
> +
> +                       /* Find the encoder controlling the brightness */
> +                       list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
> +                                           head) {
> +                               struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
> +
> +                               if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
> +                                   enc->enc_priv) {
> +                                       struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> +                                       if (dig->bl_dev) {
> +                                               atif->bd = dig->bl_dev;
> +                                               break;
> +                                       }
>                                 }
>                         }
>                 }
>         }
> +#endif
>
>         if (atif->functions.sbios_requests && !atif->functions.system_params) {
>                 /* XXX check this workraround, if sbios request function is
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
