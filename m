Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68722C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE2410E832;
	Mon, 17 Aug 2026 15:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alfYxwYF";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED95210E825
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:10:10 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5bfa1e7e123so122924e0c.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 08:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979410; cv=none;
 d=google.com; s=arc-20260327;
 b=iqq53gfYb1TDu07rTAcvx95PjhzK0/4pzgdmHedx9KGAw1Q511Am/zfX2k+KHjBw46
 czqcjJcWM49X1e/UmO69xP4fIsZpB9RpvdWV2a731rrT78yjNq6B7/2Kd0dAi2cpPQHr
 5jeMA+N8X6th/vbzv2b90NPpx6Dsl8A+SIOcJEpL85YdusgK/OJK2KAUjRUxTzvy2GIW
 7lV3GigRVqkrsFB8DGfp6WMhBEKXM/zDS1UZE/7ssFalND1YiaJ/+icjXZdceYwgOsgp
 7+NtE1kkTFgPyYK7Pg3+1kGGyOkgNnmRBIYtjRg422e+ZuAPUXLibYYozGDb5v8ywNoA
 ZGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 fh=kSrGXeBTgm/IcognzYTjxo8Ik+vKnvS8BqbxFVi5a+Y=;
 b=LBhtD6nOFtsMa01mtH7iBSLHmeuD/rPY6xPKL1f1R1bWfFggRiOTARZ2c8JpDrmB3C
 r7gTvWWrlqdLGihW4zXJMKdcfKb4mT5d/VHfkENVDnrRetQHZ4eOjZx2Jb3t++S+Wifc
 k/z2L8hmg2+mK+Hmx7TyPHZPQE6yNWhyNGFvt/R95UCZB8dklIEnXnhr9pez2dfZNM/V
 gBUre/X2KhGG4Uc32Tn/Gx4jHbeVdatxAq19QEYjT7YBD35R+YUasfxBK/rTVdM/Jkeh
 7/rsvfYITjUPM3iEM+54vV9VESiId3rX7GfbGsrjmlVCnzDjnhzXzYG1p1rnajmWyevd
 n80g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786979410; x=1787584210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 b=alfYxwYF08F3Ogx4epenZyquUGzrSDaoBUYJTJk1rrk/Mg7J+DE83YDFWRYJxvASWf
 vlwlmn+TNbT10j2SIpF1U5AjoMoKTyDWzuA4ZmQj5p7B71gux4Oei0Mox0gzccDk9lbO
 VDDnKsiVQkw/bmQYz800QNYAeT174OS0w++2kQHfi7Ml1ySkzMjjzkQ4JKiDTj8Qy/62
 5wDRGOjjfe/PdnHC4bJbJzd9QadA7Y2XZLuxPGdRwvTHcrLloIUMX40mW0Cjz2N5D1jZ
 ZOhzOyVydrOzIn3qNZc6+KWtkrhh/XLL6DgI/EP0SUayz8+Ypo6zru4NjxPq1nboQO9Y
 9+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979410; x=1787584210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Vs4z9VETMAlhC8TDC7AO7aGvoR74ABE5Di5IsBaUZI=;
 b=PXLTzBSJK4nvuLSXb/4lsKSqkYy56FmKQWxhY9X9WKG3Nz+Dd0aH9MCquvcR7d9BJZ
 AD1WNPtRpphyMd5NkhenTlBuDgzV9BRV5EpOgI1lJoVq98O9MlkE3msHb3Pv5zs2ihQV
 jdd//KpWJYNxLlDETb0ctoGnmzGg+8G3xNpZP2QWnKWnT4j6KhiNsYirct8qw3KYJK0s
 TqUFN8V/j7zyuRk9iJdKudMEYIvfDsDVqolYJoubuJjvxuVuDIxMMspcZNTzN+O1wFlO
 grjZhnMLn76+Qtx5GURqnr5LPn0HSkU2y9cO30R8jLjrocnqc9WwMbKBLxeBXvGBOKHs
 kGmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLwFuBdi/yv9w5BSVBoBheptWF9K4EJd88fivKv7kuiKjEsJiBEqCfPdEFTPkVQnB41E5CgQVb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWIDbrqo2K2yZ7BxVRbQaNeCdmnBWify5GmosnSiyhto5Utf7q
 8Qg/YuECxvo9nQOqkbuBE+LRhuWJYczYXzvyxCTboLNG3pcSHPJFEAlvUX537uHT5GnYqnurepZ
 ApQHgricB3PQh6LmWe7U9FSPHORGqQLP39Q==
X-Gm-Gg: AR+sD10OpHtERxxlffdEH5gXcnmMWMzJCHHPfzZYI2KorutikKdpFnkklS9Rq4z1lUg
 qehnUTl0HyeyBraT3QnAlM3iXPQBNBE12GKZsMvdTWWDVSTr2h8XotjrCs1Cfll6Hi/UZCv7tpL
 el98lXh5prEBMQtsg6rT/b5yyaSDUQSt2Ajc4bYYg+9dddhHnJ+ukLwezxurttltljE5zvFatcW
 srWwYkb1ACBs0GHSbqly/eVdT5fs/Z9sFojpf/hFYX5GR4M1MyYmyj0BsEnUNga3lVDoI1Y3c4p
 NxLowjk8IGPBAegS0IjLeVoKAs1V4DtwoKoh1KoWRp5HJIUWoPky1RrjsGpNYPoeTlKG//DacVV
 blp8n5vccT3aJsF+27tpKT4RG7SNbF/IA/k72
X-Received: by 2002:a05:6102:2ad0:b0:756:32ba:1a83 with SMTP id
 ada2fe7eead31-76f2c9430damr1845779137.2.1786979409622; Mon, 17 Aug 2026
 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
 <20260817004326.3192-1-gilles.risch@gmail.com>
In-Reply-To: <20260817004326.3192-1-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:09:56 -0400
X-Gm-Features: AcwNN1XLOqNILg4yZI4rdPExnRh06Vw-U8A0OXdUm9EOG9yczYIphNcdXXJDLto
Message-ID: <CADnq5_N9-3fF4UFur3oA7+AkNLTiBg_CHdP4SJd0w4UmWZLR8A@mail.gmail.com>
Subject: Re: [PATCH v6] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, lukas@wunner.de
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

On Sun, Aug 16, 2026 at 8:43=E2=80=AFPM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
>
> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> Apple routes the internal display through Link B of the DIG encoder
> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> the Apple-specific encoder assignment into its own block, independent
> of the DCE version check.
>
> Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> to avoid affecting other boards.
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
>
> Good morning,
>
> this is v6 of the patch, rebased on top of amd-staging-drm-next
> (agd5f/linux).
>
> There are no functional or code changes since v5.
>
> Regarding Lukas Wunner's previous Reviewed-by (which was provided on v2),
> I have kept him in CC so he can confirm if his review still stands given
> the changes between v2 and v5.
>
> Could you have a look at this when you have a spare moment?
>
> Regards,
> Gilles
>
> Changes in v6:
> - Rebased on amd-staging-drm-next (no functional/code changes since v5)
> ---
>  drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
>  drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
> index 2fc0334e0d6c..075eba2d47f3 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -24,6 +24,8 @@
>   *          Alex Deucher
>   */
>
> +#include <linux/dmi.h>
> +
>  #include <drm/drm_fixed.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> @@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>                 if (((rdev->family =3D=3D CHIP_RS780) || (rdev->family =
=3D=3D CHIP_RS880))
>                     && !radeon_crtc->ss_enabled)
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
> -               if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> +               if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME, "=
iMac11,1"))
> +                   && mode->clock > 165000)
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
>         } else {
>                 radeon_crtc->pll_flags |=3D RADEON_PLL_LEGACY;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 5cfd8fcfa5e8..8b3f8303a967 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)=
) && connector) {
>                         /* DP_SET_POWER_D0 is set in radeon_dp_link_train=
 */
>                         radeon_dp_link_train(encoder, connector);
> -                       if (ASIC_IS_DCE4(rdev))
> +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_N=
AME, "iMac11,1"))
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> @@ -2123,17 +2123,20 @@ int radeon_atom_pick_dig_encoder(struct drm_encod=
er *encoder, int fe_idx)
>         }
>
>         /*
> -        * On DCE32 any encoder can drive any block so usually just use c=
rtc id,
> -        * but Apple thinks different at least on iMac10,1 and iMac11,2, =
so there use linkb,
> -        * otherwise the internal eDP panel will stay dark.
> +        * Apple routes the internal eDP panel through Link B of the DIG =
encoder
> +        * instead of Link A on the iMac10,1, iMac11,1 and iMac11,2.
> +        * Use linkb to avoid a dark display.
>          */
> -       if (ASIC_IS_DCE32(rdev)) {
> -               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> -                   dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> -                       enc_idx =3D (dig->linkb) ? 1 : 0;
> -               else
> -                       enc_idx =3D radeon_crtc->crtc_id;
> +       if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +           dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> +           dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
> +               enc_idx =3D (dig->linkb) ? 1 : 0;
> +               goto assigned;
> +       }
>
> +       /* on DCE32 and encoder can driver any block so just crtc id */
> +       if (ASIC_IS_DCE32(rdev)) {
> +               enc_idx =3D radeon_crtc->crtc_id;
>                 goto assigned;
>         }
>
>
> base-commit: 21c50d41af7c46e138b542dba2dcf6d2a978ae99
> --
> 2.47.3
>
