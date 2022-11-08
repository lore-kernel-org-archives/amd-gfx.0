Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A596DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 14:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D144810E246;
	Tue,  8 Nov 2022 14:31:43 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F5A10E246
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 14:31:39 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 g10-20020a4ab4ca000000b00481082808cbso2051997ooo.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Nov 2022 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hYA3dqOUdkHfzJbTp/TgJNUwRtPz/6wjiNLcl9HpIJc=;
 b=Ha+vC5/fovfd0yhFS8Baz5tzU3nmgqPqUhbSw+HGDErzlwCeU7312BzQu4aA3U6TQ7
 V3/KilmvWTB9x1by5uUdeR7fnQFLfCYmVsuac1vaTGK9oC1q2rpf9Nnkxz6TUx3/4nKh
 LdWqcN8TflT6GH2sTNd1TQkJs/JmIaZct2anMGAi5TEsbh9iOi/ywIBKiZZfq7DtodYc
 bQ3XsMUxIOD2smogLZ4vnU3TAdGQNTiGtBePwNH+X54oRG5cpAqQWcNDzU0i00veaSqb
 BmZuMgt1zGpG9pFkccbeoD6sYS5eXv+kZQnh7C79bxqaKA3naB/UN1ultdLBenIRUejD
 wtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYA3dqOUdkHfzJbTp/TgJNUwRtPz/6wjiNLcl9HpIJc=;
 b=qo4K6SpnJYOGrd2qn+L37iTzjIVeY6nAduHeKZ+0TO4dLRacsCne5tkteeUfD2XAbD
 a8ZsaqZsnXOXaThU5oCpG8Ph43NASeemMaB4qsun5dfvk0FnueA65ujgIogXsGhXk/tc
 PA9CrIPPeabefLri/oAZ52xNsQPE74PQZBNIxNAkU8a2t/BQA+r2Mk6sr7Gi+bfKAzV7
 JK5fa5kh+GH3cWRJgMX+tVvPKUeKlvBVlfhm6u0hw6Jv2kiAIu7eLyoj7qafGw0E8nEx
 4zEPEjR/f1BCrC4LzG/Jz1V+61kcB+Xdut1EA/nhwzGc5U3E3ifqJNQqu8IhrR7MB2LJ
 M4KA==
X-Gm-Message-State: ACrzQf0FCvgFN3gvA2eOUxOLsOtmaq/DVWQlGIiesZffWgxhh4aMWmLx
 kOdZ/4yedsZMPtmYnjI/IJS5p6/nYs7bK0OGDeHNXYcqPSE=
X-Google-Smtp-Source: AMsMyM5U4spTyjJriLAA4qfE69owHsZI34mOC8ZyQFjvKTd94fyArd0rLNi02BNJhi/yuVUcOMAhuw6nSDfAl0dsbig=
X-Received: by 2002:a4a:b913:0:b0:480:b3bf:7812 with SMTP id
 x19-20020a4ab913000000b00480b3bf7812mr24031257ooo.97.1667917899104; Tue, 08
 Nov 2022 06:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107172253.155475-1-luben.tuikov@amd.com>
In-Reply-To: <20221107172253.155475-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Nov 2022 09:31:27 -0500
Message-ID: <CADnq5_OwEcfa6+Ggcv203X2iDTTVpquuT6R-zSpbeob6OX-9qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove redundant I2C EEPROM address
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 7, 2022 at 12:23 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Remove redundant EEPROM_I2C_MADDR_54H address, since we already have it
> represented (ARCTURUS), and since we don't include the I2C device type
> identifier in EEPROM memory addresses, i.e. that high up in the device
> abstraction--we only use EEPROM memory addresses, as memory is continuously
> represented by EEPROM device(s) on the I2C bus.
>
> Add a comment describing what these memory addresses are, how they come
> about and how they're usually extracted from the device address byte.
>
> Cc: Candice Li <candice.li@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Fixes: 367a1ebddde5d0 ("drm/amdgpu: Add EEPROM I2C address support for ip discovery")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  2 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 ++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 4d9eb0137f8c43..d6c4293829aab1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -79,6 +79,8 @@
>   * That is, for an I2C EEPROM driver everything is controlled by
>   * the "eeprom_addr".
>   *
> + * See also top of amdgpu_ras_eeprom.c.
> + *
>   * P.S. If you need to write, lock and read the Identification Page,
>   * (M24M02-DR device only, which we do not use), change the "7" to
>   * "0xF" in the macro below, and let the client set bit 20 to 1 in
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 7268ae65c140c1..1bb92a64f24afc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -33,12 +33,30 @@
>
>  #include "amdgpu_reset.h"
>
> +/* These are memory addresses as would be seen by one or more EEPROM
> + * chips strung on the I2C bus, usually by manipulating pins 1-3 of a
> + * set of EEPROM devices. They form a continuous memory space.
> + *
> + * The I2C device address includes the device type identifier, 1010b,
> + * which is a reserved value and indicates that this is an I2C EEPROM
> + * device. It also includes the top 3 bits of the 19 bit EEPROM memory
> + * address, namely bits 18, 17, and 16. This makes up the 7 bit
> + * address sent on the I2C bus with bit 0 being the direction bit,
> + * which is not represented here, and sent by the hardware directly.
> + *
> + * For instance,
> + *   50h = 1010000b => device type identifier 1010b, bits 18:16 = 000b, address 0.
> + *   54h = 1010100b => --"--, bits 18:16 = 100b, address 40000h.
> + *   56h = 1010110b => --"--, bits 18:16 = 110b, address 60000h.
> + * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
> + * address memory in a device or a device on the I2C bus, depending on
> + * the status of pins 1-3. See top of amdgpu_eeprom.c.
> + */
>  #define EEPROM_I2C_MADDR_VEGA20         0x0
>  #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
>  #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
>  #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
>  #define EEPROM_I2C_MADDR_ALDEBARAN      0x0

As a follow on patch maybe we can clean up the rest of these
duplicates?  And rather than using the asic type, maybe just switch to
the define to a more descriptive name?  E.g.,
#define EEPROM_I2C_MADDR_0H       0x00000
#define EEPROM_I2C_MADDR_4H       0x40000
#define EEPROM_I2C_MADDR_6H       0x60000

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> -#define EEPROM_I2C_MADDR_54H            (0x54UL << 16)
>
>  /*
>   * The 2 macros bellow represent the actual size in bytes that
> @@ -130,7 +148,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 0):
>         case IP_VERSION(13, 0, 10):
> -               control->i2c_address = EEPROM_I2C_MADDR_54H;
> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
>                 return true;
>         default:
>                 return false;
> @@ -185,7 +203,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 0):
> -               control->i2c_address = EEPROM_I2C_MADDR_54H;
> +               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
>                 break;
>
>         default:
>
> base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
> --
> 2.38.1
>
