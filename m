Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87FDC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 14:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9168210EB06;
	Thu, 27 Feb 2025 14:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RK4b8cwJ";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6096C10EB06
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 14:23:43 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2234f57b892so2087375ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666223; x=1741271023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2WcCYEIoa98PZPva6pM8kgqQWYyaz3pTFEMIcEhMPc=;
 b=RK4b8cwJ8bt5j7IYVaZjvMWvmLOsfV2EEX194tTkrAa1O2kNwmCH+WaeC625I54EkA
 4zuPSXcqFccQgTVt3grziw3TWP7hiEIF/4ZkXu6ONVUdTPFqE/EwbrjJBK5mp2g0/EPO
 +j4CIuCbVGOYolaZnrjjiP7q/yV/yAAH2kK4Uy7vNJOue2/FESEZsvvv+YIRDCsmmVCH
 MEZj9Yt6mw0kbINHYOmLPX9t4iOOGhfgHlF0N67TtklrrnmcMgDJYotPgPSjeh8hfJe4
 fsetMG7zYY4DH+5NHwjybEe3DjBhOYgqLkuuWd12CJBN6X97FG3NnTVVF6tYoE3xUPd3
 R+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666223; x=1741271023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2WcCYEIoa98PZPva6pM8kgqQWYyaz3pTFEMIcEhMPc=;
 b=PgR7dpZMzVyisnuFDnAT0eZZztjzBpYs37zPppWNIxkJ2yV4qqL/oRVVcsso2b7urc
 u1235O2+Zldf9nPlRv80fSi3Umifaz65xKqN4yemWTm79cD1UQKB/EwztmtdhArbKk9G
 N/NGMoPONPK9F6ri57qw8nZk0Ggs9Es2zTpdL5t3v/sMLXQu0E29ytKUDItiJ+1cfVNe
 rzGg8fxHRJpljcsMtB43s6behhwG1aLAgVNL1v4GdHNDFKVCZvrhwJqtt6CNFUQcUgwo
 vPc7R8ZYPuu5ElcA2QK8nxdTKLyGjQjC4fO/5T6aHjLmRIJAVjPd774G41BkNQJbGPYP
 TT1g==
X-Gm-Message-State: AOJu0Yx0mq4zOTxOiCrOOiYcYToIkj2f298xfmzor+oxZdaXoiVvOrXt
 YIEY0w8vIxrO+pRYn+sQFmSAMjKs2KOoNGG+EO7vhjHfPxscvmaFYTRwclS6aLhgAxgRfduGSXz
 jewoHxapM8PtjnWJ6I2Ox5tKOzAo=
X-Gm-Gg: ASbGncuPB4AZJkEwz/AdLpCZy2AOuSu0RHmwQUxTk2qiOwI9H8/pnZixB9hdoh0HoXD
 E/MB9KxylPEBoc086k9h2Xe08MrwD4IiifRUhKUKk0pMbjumPsMC3cuo6KR9ntdNyx65ifuGSA+
 jrAf8vaHw=
X-Google-Smtp-Source: AGHT+IGRU8XkrLEJVA8/wjJmU3JC484SXDShwXyEi7e8BDb0XiQqHxRHsTKPQgCThcYV2UL2Qzu8uKkSYlJ34nBzeR4=
X-Received: by 2002:a17:902:ecd2:b0:223:5e57:44f0 with SMTP id
 d9443c01a7336-2235e57456fmr7337485ad.14.1740666222797; Thu, 27 Feb 2025
 06:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
In-Reply-To: <20250227052241.171102-3-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 09:23:31 -0500
X-Gm-Features: AQ5f1JoBALURxvES5QUn8lua4BnNKmqAO_VNblGKG3OYx6Uspd8xnbTKbUI2ZXg
Message-ID: <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> DCE6 was missing soft reset, but it was easily identifiable under radeon.
> This should be it, pretty much as it is done under DCE8 and DCE10.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 ++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index bd763fde1c50..254cb73324c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_=
device *adev)
>         return mmDC_GPIO_HPD_A;
>  }
>
> +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> +{
> +       u32 crtc_hung =3D 0;
> +       u32 crtc_status[6];
> +       u32 i, j, tmp;
> +
> +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTR=
OL__CRTC_MASTER_EN_MASK) {
> +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_COUNT =
+ crtc_offsets[i]);
> +                       crtc_hung |=3D (1 << i);
> +               }
> +       }
> +
> +       for (j =3D 0; j < 10; j++) {
> +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +                       if (crtc_hung & (1 << i)) {
> +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT + c=
rtc_offsets[i]);
> +                               if (tmp !=3D crtc_status[i])
> +                                       crtc_hung &=3D ~(1 << i);
> +                       }
> +               }
> +               if (crtc_hung =3D=3D 0)
> +                       return false;
> +               udelay(100);
> +       }
> +
> +       return true;
> +}
> +
>  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
>                                           bool render)
>  {
>         if (!render)
>                 WREG32(mmVGA_RENDER_CONTROL,
>                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
> -
>  }
>
>  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
>  {
> +       int num_crtc =3D 0;
> +
>         switch (adev->asic_type) {
>         case CHIP_TAHITI:
>         case CHIP_PITCAIRN:
>         case CHIP_VERDE:
> -               return 6;
> +               num_crtc =3D 6;
>         case CHIP_OLAND:
> -               return 2;
> +               num_crtc =3D 2;
>         default:
> -               return 0;
> +               num_crtc =3D 0;
>         }
> +       return num_crtc;

Any particular reason for this change?  It just adds an extra variable.

Alex

>  }
>
>  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
>
>  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
> -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> +       u32 srbm_soft_reset =3D 0, tmp;
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (dce_v6_0_is_display_hung(adev))
> +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> +
> +       if (srbm_soft_reset) {
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +               tmp |=3D srbm_soft_reset;
> +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               udelay(50);
> +
> +               tmp &=3D ~srbm_soft_reset;
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               /* Wait a little for things to settle down */
> +               udelay(50);
> +       }
>         return 0;
>  }
>
> --
> 2.48.1
>
