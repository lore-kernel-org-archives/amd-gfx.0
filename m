Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A7C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F0310E4D8;
	Mon,  7 Apr 2025 15:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L3dtfkeE";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE30710E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:03:11 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso882816a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744038191; x=1744642991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGGgNNW+Q/O/KTd8RUlkSi8a0KUUbS5hvK2VQQ7L/BU=;
 b=L3dtfkeEupCBiJ60W6CaGydME+4z8kCSiVzzDFaxTGoyR8/AXTckH7875nfIvLsaJM
 F/sy0QSLiNbHmttY/LljS8m4auHvdjIU4xslKL1m8W/46skcZQXxtR9rYvh1irdKnCAg
 PZ1eIUdYirh0EwfoFjFKBxbemOXcgImLzsGm9JwMXavKCviaQvMVVbXHprwlYs5YcndM
 zYR0GhsPfwHiySS8u8tlZfoGKbmJtSL3YP2ggEnFA1nBDWGKEO9Jnuhg8qcBtt2KsTcx
 MeDBf7kealtlet/SFNVbfSBjIIcwW3jULriHLDhzTzdQMpAYDLPH4vTz/zpC5mTSXg3s
 UcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038191; x=1744642991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGGgNNW+Q/O/KTd8RUlkSi8a0KUUbS5hvK2VQQ7L/BU=;
 b=mdf4TrIdVsnLf+eTl98wbniCFLhi72RZ0dXSRK4YVDAkrSNyxX0m8niJ3KqNCklwfP
 hh7/FUtdqk5xA5Q0mtbRXJo+ut5wK47ZtMRZokFoeGEp9S++p9RprbM4C+lZeGDWx/5E
 npOjH/Tjx4KY1H+FZgtEpyR35vgZslfrrQzUmCNGyf9fleJxwvXq/5FpLSXfWBDXZte+
 c/giakbxwnI7/JTJP4JZEMK/az7AcuzxpI95mKjfA6Uf87Ow+6glHh3TeeE8liWUnxbs
 LxgMXGgKMC1PyaCL09QGZPh6XQYHYTW/LTz2qbMhEW+qN3CfY1e85/1UMiyYHWkOw+ny
 p02A==
X-Gm-Message-State: AOJu0YznUBTGU8GxHsqWlCVkZan7fKZIg6JwxZWpsvXcDVtGjeh0xx4w
 T71rbvuc23XqlsB3pHCZEeN6CKWjKPwGcRTq+yRPd+6TDCFJVLgejN3llO9jD3YwMUmtRQrUt40
 mkFWyYWFCDE+1CQnzEAN+1e9c04/0+w==
X-Gm-Gg: ASbGncuyAtF7Evav11nJs8iwC93wOwCv6cGMpswWj4G/GeI/6qGR5p0qhmxEAA1X57c
 kZkoCo/Mx1tG8+qE8QpOey8atVcMZGmgAhFi3IDLEYkUIkiqFST6GBiPWRX4jEUg3NDVApBI3w0
 4/tZ4n/kMjcOxzurfdVjirSXpzpxup5Hx9s4ns
X-Google-Smtp-Source: AGHT+IGA7Dqejs1jvjwuj2P9oh/9beu3daAiaogyjvOnY0h7ylgTGgravA8JCuYp6kN76F5G5kxiUJDxnMlR3IdO8No=
X-Received: by 2002:a17:90b:1c8d:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-306a4975b3cmr6520057a91.3.1744038191309; Mon, 07 Apr 2025
 08:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250407055230.35519-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250407055230.35519-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 11:02:59 -0400
X-Gm-Features: ATxdqUHbETZgMW2FXfJ1CXeaZKZmIiQJctsZ97LIVPqS0SeD1w_c58RsmV0ZQio
Message-ID: <CADnq5_PK7d4T72_uutvw8UtjpeBEpkdRAuyYq_=rLJmwrkKqOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: still cleanup sid.h
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

Applied.  Thanks!

Alex

On Mon, Apr 7, 2025 at 1:52=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> The defines, shifts and masks are already available in dce_6_0_d.h,
> dce_6_0_sh_mask.h.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c  | 26 +++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/sid.h | 16 ----------------
>  2 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu=
/si.c
> index 3b8c65a966b9..c21f97d89cbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1278,24 +1278,24 @@ static bool si_read_disabled_bios(struct amdgpu_d=
evice *adev)
>         u32 rom_cntl;
>         bool r;
>
> -       bus_cntl =3D RREG32(R600_BUS_CNTL);
> +       bus_cntl =3D RREG32(mmBUS_CNTL);
>         if (adev->mode_info.num_crtc) {
> -               d1vga_control =3D RREG32(AVIVO_D1VGA_CONTROL);
> -               d2vga_control =3D RREG32(AVIVO_D2VGA_CONTROL);
> +               d1vga_control =3D RREG32(mmD1VGA_CONTROL);
> +               d2vga_control =3D RREG32(mmD2VGA_CONTROL);
>                 vga_render_control =3D RREG32(mmVGA_RENDER_CONTROL);
>         }
>         rom_cntl =3D RREG32(R600_ROM_CNTL);
>
>         /* enable the rom */
> -       WREG32(R600_BUS_CNTL, (bus_cntl & ~R600_BIOS_ROM_DIS));
> +       WREG32(mmBUS_CNTL, (bus_cntl & ~BUS_CNTL__BIOS_ROM_DIS_MASK));
>         if (adev->mode_info.num_crtc) {
>                 /* Disable VGA mode */
> -               WREG32(AVIVO_D1VGA_CONTROL,
> -                      (d1vga_control & ~(AVIVO_DVGA_CONTROL_MODE_ENABLE =
|
> -                                         AVIVO_DVGA_CONTROL_TIMING_SELEC=
T)));
> -               WREG32(AVIVO_D2VGA_CONTROL,
> -                      (d2vga_control & ~(AVIVO_DVGA_CONTROL_MODE_ENABLE =
|
> -                                         AVIVO_DVGA_CONTROL_TIMING_SELEC=
T)));
> +               WREG32(mmD1VGA_CONTROL,
> +                      (d1vga_control & ~(D1VGA_CONTROL__D1VGA_MODE_ENABL=
E_MASK |
> +                                         D1VGA_CONTROL__D1VGA_TIMING_SEL=
ECT_MASK)));
> +               WREG32(mmD2VGA_CONTROL,
> +                      (d2vga_control & ~(D1VGA_CONTROL__D1VGA_MODE_ENABL=
E_MASK |
> +                                         D1VGA_CONTROL__D1VGA_TIMING_SEL=
ECT_MASK)));
>                 WREG32(mmVGA_RENDER_CONTROL,
>                        (vga_render_control & ~VGA_RENDER_CONTROL__VGA_VST=
ATUS_CNTL_MASK));
>         }
> @@ -1304,10 +1304,10 @@ static bool si_read_disabled_bios(struct amdgpu_d=
evice *adev)
>         r =3D amdgpu_read_bios(adev);
>
>         /* restore regs */
> -       WREG32(R600_BUS_CNTL, bus_cntl);
> +       WREG32(mmBUS_CNTL, bus_cntl);
>         if (adev->mode_info.num_crtc) {
> -               WREG32(AVIVO_D1VGA_CONTROL, d1vga_control);
> -               WREG32(AVIVO_D2VGA_CONTROL, d2vga_control);
> +               WREG32(mmD1VGA_CONTROL, d1vga_control);
> +               WREG32(mmD2VGA_CONTROL, d2vga_control);
>                 WREG32(mmVGA_RENDER_CONTROL, vga_render_control);
>         }
>         WREG32(R600_ROM_CNTL, rom_cntl);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index 19889276d677..99f6dfae9b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -81,11 +81,6 @@
>  #define                MC_CG_ENABLE                            (1 << 18)
>  #define                MC_LS_ENABLE                            (1 << 19)
>
> -#define MC_SHARED_CHMAP                                                0=
x801
> -#define                NOOFCHAN_SHIFT                                  1=
2
> -#define                NOOFCHAN_MASK                                   0=
x0000f000
> -#define MC_SHARED_CHREMAP                                      0x802
> -
>  #define        MC_VM_FB_LOCATION                               0x809
>  #define        MC_VM_AGP_TOP                                   0x80A
>  #define        MC_VM_AGP_BOT                                   0x80B
> @@ -664,17 +659,6 @@
>  #define CURSOR_WIDTH 64
>  #define CURSOR_HEIGHT 64
>
> -#define AVIVO_D1VGA_CONTROL                                    0x00cc
> -#       define AVIVO_DVGA_CONTROL_MODE_ENABLE            (1 << 0)
> -#       define AVIVO_DVGA_CONTROL_TIMING_SELECT          (1 << 8)
> -#       define AVIVO_DVGA_CONTROL_SYNC_POLARITY_SELECT   (1 << 9)
> -#       define AVIVO_DVGA_CONTROL_OVERSCAN_TIMING_SELECT (1 << 10)
> -#       define AVIVO_DVGA_CONTROL_OVERSCAN_COLOR_EN      (1 << 16)
> -#       define AVIVO_DVGA_CONTROL_ROTATE                 (1 << 24)
> -#define AVIVO_D2VGA_CONTROL                                    0x00ce
> -
> -#define R600_BUS_CNTL                                           0x1508
> -#       define R600_BIOS_ROM_DIS                                (1 << 1)
>
>  #define R600_ROM_CNTL                              0x580
>  #       define R600_SCK_OVERWRITE                  (1 << 1)
> --
> 2.49.0
>
