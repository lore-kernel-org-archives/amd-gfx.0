Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ACAC47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2B820675
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTMB11pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2B820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D256E5D5;
	Tue,  5 May 2020 15:19:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD5C6E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 15:19:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id e16so3218478wra.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N1j0JpSTUVOEhYPn7CFOLjacHTVDYQZbcRNmVyj8sHw=;
 b=vTMB11pRka/F4dtkwv2ZCMDuqVYO8JHawU89xvzQ4PwvFdc2lESvi6p1h06PfA2uHA
 7sQ0SJKAFMLZ7s5Ugu5WG7kPvQ7zKfsj7JDgzSdVG7YjB61t8V9kXr1Cdlpl5RwIN3FS
 ei1uLt06TyIOG1yypgjaJh7KnNIV6xmd6LjTqJiMhNkAn9VClCWuep5Xhjqq3N4GeMqA
 MxVT2iMvYywUBnob608T9laeJ8LV2QNpSO2PXujB3dCOLGGWLtZ6JpYdbw+/DpyvG7lY
 KdykYkRI4GKsXam8knSeiE8unBEg5DFqSqOH8kKuiDSxHD8Yv3Egyz44PEvaIOBNZbtf
 oyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N1j0JpSTUVOEhYPn7CFOLjacHTVDYQZbcRNmVyj8sHw=;
 b=X9Yuj51i8q3N3O32GwJM8n5edsZD4khOiO19GouWCm7lhXXuuUkjgC0WfGItMG3lMT
 rJ61+F9VV/cpb59Fnuk/658egNtRdlj80Sjx5PDWa0ovKLOrsnhT1y+0tuzdus631Zdn
 ZdMCz34IO5NhqACE4zpH4SACGHl0AqaSQ/8SyNDp/Mm5LY453kFX/8YtO/O6uCOdZaRa
 rVineJ6CL9ChYl0Jpzn/WTLmBwkJf9uyqyW/0rQ+42uCsOcBucEJZc1Idy1Z2jedtsgf
 X5KnpiDcyXbTS+lYeGFo21T9VrOIjQZciuq88l6inTX7mjp1l0aBA4opLm58GmkcCpIv
 B2GA==
X-Gm-Message-State: AGi0Pub5lGPNM0zXGaclopn1ZPqDLaw5Tcss2Eualn0hceA7XLe9207I
 vrWtmeJc6rXfEcdOTXE9IFgNS/7OS+xKJ9eAcuAo1w==
X-Google-Smtp-Source: APiQypK8fN+b37WyGSGnTyVPDrvVmbZDJSoxH3yKSk3ltDgqa+PAnpS/UuYnwYh7s0o30pOhgANlPWLp0qWLp7jdVs0=
X-Received: by 2002:adf:ee86:: with SMTP id b6mr4551031wro.419.1588691960055; 
 Tue, 05 May 2020 08:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200505132729.39420-1-avg@FreeBSD.org>
In-Reply-To: <20200505132729.39420-1-avg@FreeBSD.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 May 2020 11:19:08 -0400
Message-ID: <CADnq5_PK2WE+P8M6Vc0a6aFCDDM95c-wRpAWpY0Mf24kRxfRqA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu_acpi: add backlight control for the DC case
To: Andriy Gapon <avg@freebsd.org>
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

Applied.  Thanks!

Alex

On Tue, May 5, 2020 at 9:27 AM Andriy Gapon <avg@freebsd.org> wrote:
>
> This uses backlight_device_set_brightness() to set the brightness
> level requested via ATIF.
>
> Signed-off-by: Andriy Gapon <avg@FreeBSD.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 1e41367ef74ee..a8157a5154243 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -444,7 +444,6 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>
>                 DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
>
> -               /* todo: add DC handling */
>                 if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
>                     !amdgpu_device_has_dc_support(adev)) {
>                         struct amdgpu_encoder *enc = atif->encoder_for_bl;
> @@ -463,6 +462,25 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>  #endif
>                         }
>                 }
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +               if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
> +                   amdgpu_device_has_dc_support(adev)) {
> +                       struct amdgpu_display_manager *dm = &adev->dm;
> +                       struct backlight_device *bd = dm->backlight_dev;
> +
> +                       if (bd) {
> +                               DRM_DEBUG_DRIVER("Changing brightness to %d\n",
> +                                                req.backlight_level);
> +
> +                               /*
> +                                * XXX backlight_device_set_brightness() is
> +                                * hardwired to post BACKLIGHT_UPDATE_SYSFS.
> +                                * It probably should accept 'reason' parameter.
> +                                */
> +                               backlight_device_set_brightness(bd, req.backlight_level);
> +                       }
> +               }
> +#endif
>                 if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
>                         if (adev->flags & AMD_IS_PX) {
>                                 pm_runtime_get_sync(adev->ddev->dev);
> --
> 2.22.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
