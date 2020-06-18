Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FDFC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32E52100A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjsjDFH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32E52100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9998D6E222;
	Thu, 18 Jun 2020 04:29:40 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C766E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:29:39 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t194so4138204wmt.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UV0z1cG+QK1n/Xbw/LRrIhrmduiA98kwUNa4V4CbkQk=;
 b=TjsjDFH1FxzdmaEBbvM6wTnfjWQumcfTTrtJr1K2QPFKh3gv9OnHpbePpfy+DNX2o+
 IR4kJYa/iHGiv2dL7QhbR+6oXKxj0+q/+uoUDDsg3oQR031vvVz1J0M7Hj1YPTU/Epem
 xZcqOUxKcyK1yVAjcvZcYNCK1qCgdYRHZtzQe08mlxUypf5ZmvvFF6y2w9GiyzLJ6V2A
 xoPnGo5pCG2sMbdpIQo6EEheInZx99wxr9HoUvqeCgnbNUiofoWDi2Mdb8fvE2iiHSkP
 LSDqVGfHhNL0K8qJTsOngoFxj2SsVFn11u+UpTNIes909drHKvPPp8EZIp31OWaKd50n
 CqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UV0z1cG+QK1n/Xbw/LRrIhrmduiA98kwUNa4V4CbkQk=;
 b=LJSbnsjEIpv9qD0jHZ0z8ewwulQToaeePapoqBc0WkiFVltMvKX3Qxe1FfRp210nFt
 6EGFyiSjTe3hVhVFwfyMd+qlM7Ww6KmUl8U7zBWl4PFzTlfJRN0XklP1ahnN7w9bJw7Z
 gS3z28dAquf6JcGVN0AUnBWqzwIEPhirt07GS6NQ9gw7gs2GOyiAwMhhZGY47cCa9LDf
 J9at51uAnq5DDSx8yALDqAtSdl7E4l8YkPEAflWOveNP4r1KBe0/P7aSW6g2o4MH5jn7
 2qWz/E3zQzmvY53B03v6nsf9nt7G0pTgBzro0TGkHYVTxEOoxs6uWwGHItp22q1mrZkA
 cl0w==
X-Gm-Message-State: AOAM532PPiyguMxzivlOpdHKKS3Ry0DxaPtO4tXuU0urlsMXnEteEf7o
 6mD6qFKgQTQEZArID/vYqHmWsohMULUq7gi2LXQ=
X-Google-Smtp-Source: ABdhPJx90P2rAisisHajvgX5q+X1hmoxcLD8JNV00wUIzsOpmsFR/l4w/Lew2HgG/nZgz3lnr7NEdcTHR4ymxKTP0qc=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr1928275wmb.39.1592454578323;
 Wed, 17 Jun 2020 21:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617215943.4783-1-sonny.jiang@amd.com>
In-Reply-To: <20200617215943.4783-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jun 2020 00:29:27 -0400
Message-ID: <CADnq5_P1bC8t8XHBxRGQnhwo1N4eompe+1-+cqdGN3_W=0ES0A@mail.gmail.com>
Subject: Re: [PATCH] drm amdgpu: SI UVD add Oland, Pitcairn, Verde,
 Tahiti firmware
To: Sonny Jiang <sonny.jiang@amd.com>
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

On Wed, Jun 17, 2020 at 6:00 PM Sonny Jiang <sonny.jiang@amd.com> wrote:
>

Please add a patch description and add your signed-off-by.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 5100ebe8858d..f8bebf18ee36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -54,6 +54,12 @@
>  #define FW_1_66_16     ((1 << 24) | (66 << 16) | (16 << 8))
>
>  /* Firmware Names */
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +#define FIRMWARE_TAHITI                "amdgpu/tahiti_uvd.bin"
> +#define FIRMWARE_VERDE         "amdgpu/verde_uvd.bin"
> +#define FIRMWARE_PITCAIRN      "amdgpu/pitcairn_uvd.bin"
> +#define FIRMWARE_OLAND         "amdgpu/oland_uvd.bin"
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  #define FIRMWARE_BONAIRE       "amdgpu/bonaire_uvd.bin"
>  #define FIRMWARE_KABINI        "amdgpu/kabini_uvd.bin"
> @@ -100,6 +106,12 @@ struct amdgpu_uvd_cs_ctx {
>         unsigned *buf_sizes;
>  };
>
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +MODULE_FIRMWARE(FIRMWARE_TAHITI);
> +MODULE_FIRMWARE(FIRMWARE_VERDE);
> +MODULE_FIRMWARE(FIRMWARE_PITCAIRN);
> +MODULE_FIRMWARE(FIRMWARE_OLAND);
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  MODULE_FIRMWARE(FIRMWARE_BONAIRE);
>  MODULE_FIRMWARE(FIRMWARE_KABINI);
> @@ -133,6 +145,20 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>         INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>
>         switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +       case CHIP_TAHITI:
> +               fw_name = FIRMWARE_TAHITI;
> +               break;
> +       case CHIP_VERDE:
> +               fw_name = FIRMWARE_VERDE;
> +               break;
> +       case CHIP_PITCAIRN:
> +               fw_name = FIRMWARE_PITCAIRN;
> +               break;
> +       case CHIP_OLAND:
> +               fw_name = FIRMWARE_OLAND;
> +               break;
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>         case CHIP_BONAIRE:
>                 fw_name = FIRMWARE_BONAIRE;
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
