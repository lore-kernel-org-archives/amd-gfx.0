Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CC2C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE9910E10C;
	Thu, 16 May 2024 14:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FcyQP1RE";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95C810E10C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 14:18:36 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2b432be5cc9so205451a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715869116; x=1716473916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFqFvB9X9x/SOQWaJl/MFlMCgaLN3M7Ecw56sYSywTw=;
 b=FcyQP1REtFnhn7Fzl/BHNgirNSvSQRG+Qw5vV5Wig4XVdo5cPTQcPISgvZ3+M9+a9a
 wpN/pSvP0QwFzTAhNo5xjcnmmx7ylleQZCHeY7hsefuEADS/BXS3/luRLpsOUToQz28X
 jYazh9tawMS37C4Fcn7w0L1VGogWma8Pd+v44TluykxceNLt7BLs5V0bh7f0WG1HWR4H
 ICghUnjWzrr61pfqDiR8xy6ZiVia8SdAOyYCgxCbbcSPCA4yedtqQIgSDe1ICPZ1SPAW
 cog4He9MDJzjpa1rC2Bmp7cEHznzdXoSsyYUVQE0nnnCA2GlCJ5W8sfuRvJmYyZZ11jC
 VJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715869116; x=1716473916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFqFvB9X9x/SOQWaJl/MFlMCgaLN3M7Ecw56sYSywTw=;
 b=NiyHuZonqwVC2J8oDdX50gSOPKNmVyQMw+J4GqscRL26K3+Iv2EikkaRmggX5WGQS4
 OyViZ+DH860mzZdaR6WuXtELfjLMblE/T8q6r3mx8uWE+L8AqmiQDH2ytYhqIxkTVhvp
 kuGeuqC9uNx4YcxeHlROSUbQkcrGL7ATdotzmKEk1rpaW7uqC0JgSTfRxoh694qSM33P
 Ao99dSyGvD91TaYZINo03pkND4P+uyzWPU0Ucz7+LeyoZnmujoEMTwcvJ4mR0mt8lWjd
 fRaxD+f+uw/Y9W4eGXm1zDNCXq/2WC/NKg23aDUV8JtdRZ1Grg6SOG7M8AHMPvW3Pxb2
 MQeQ==
X-Gm-Message-State: AOJu0YwCfQuXuDZePooKlLT1zCG9WAh0+zUNnud1UPTrPbu3528bxBgF
 y6+GHtsvdGiYvBvUZY0PPCo1uJFG4T2/uTOm31b025MCFrSKspvJXdtHycXZc3EpDso+lvdXPK3
 Juz93LfygIy6OjbInI8IH6/ZyAPQp/g==
X-Google-Smtp-Source: AGHT+IF7rqtlefoJskjfOVgRm5ttPIIXk/Hr85QpfbCuEVZDyoCo4P3ZYjyXFT1cO5o/oo/mwamP+cL6UUb1NwbjAVs=
X-Received: by 2002:a17:90b:b0f:b0:2b2:7c42:bcd7 with SMTP id
 98e67ed59e1d1-2b6cc97c729mr17131456a91.21.1715869116108; Thu, 16 May 2024
 07:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240515192009.14362-1-kendallsm2@icloud.com>
In-Reply-To: <20240515192009.14362-1-kendallsm2@icloud.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 10:18:24 -0400
Message-ID: <CADnq5_Mb1fDJ=Z8Knnyj5B1YRN+ni1_mmje+==-C9ytmX0Z1uQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: initialize atom DIG backlight for iMac12, 1
 and iMac12, 2 with Radeon 6750M
To: Kendall Smith <kendallsm2@icloud.com>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Wed, May 15, 2024 at 5:47=E2=80=AFPM Kendall Smith <kendallsm2@icloud.co=
m> wrote:
>
> If a Radeon 6750M GPU from an iMac12,1 is installed into an iMac 12,2, th=
ere is no backlight device initialized during boot. Everything else is func=
tional, but the display brightness cannot be controlled. There are no direc=
tories present in /sys/class/backlight after booting. A simple one line mod=
ification to an if statement fixes this issue by initializing the radeon ba=
cklight device for an iMac12,2 as well if it has a 6750M. After the patch, =
brightness can be controlled and radeon_bl0 is present in /sys/class/backli=
ght. This was tested by compiling the latest kernel with and without the pa=
tch.
>
> Signed-off-by: Kendall Smith <kendallsm2@icloud.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 2bff0d9e20f5..7b11674f5d45 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -201,7 +201,7 @@ void radeon_atom_backlight_init(struct radeon_encoder=
 *radeon_encoder,
>          */
>         if ((rdev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE) &&
>             (rdev->pdev->device =3D=3D 0x6741) &&
> -           !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
> +           !(dmi_match(DMI_PRODUCT_NAME, "iMac12,1") || dmi_match(DMI_PR=
ODUCT_NAME, "iMac12,2")))
>                 return;
>
>         if (!radeon_encoder->enc_priv)
> --
> 2.34.1
>
