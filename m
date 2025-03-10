Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36789C28B2E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 15:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9F510E46B;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MX3Yr7tT";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7783910E476
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 15:08:44 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-224104a9230so7755565ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741619324; x=1742224124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVUdPoK4FOShKTQYeSATsnPPX9kfogYDcChmJXhq+aU=;
 b=MX3Yr7tTYteIbBIZ8cI1CtGwUD0U1ZfIgU1khRFraTn/xNI7NLDyna/LbLfksNvLmM
 7DCXb0+qghbfCBMjp7+JOWMVZTXDjeOMa6sSl9xX3Rv23C0EFwixO05PUTASNLayhkLm
 zRkDr2RvoVFwfDb8dJHh/bcC/wMBwWe8AbwqbsvgfLt1qu6RNqk4/EDqA9ZDqTkRZzPM
 W6AD/cPXDWtn14p55owe395YRzD/5/oCvPhBL94xPpzBCjGMk7ziXjqa72vQXm7ezMLF
 MDEL2PrgK7WsjmdPcuOjNEUvQ8++2ZTSKhLYfHrd3roTgR5BBNZn+Q2B7xUOpdYOoJvP
 1a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619324; x=1742224124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVUdPoK4FOShKTQYeSATsnPPX9kfogYDcChmJXhq+aU=;
 b=kv61l+ELmzn5ngCCXTZ25snOvsiBbUovppsh3zWbsD+84GEKVEHKR/U1x0KyNfPExr
 SYGlrqFKaIpEvSVz/E2R+WfYy5xc5Fg03Ic8zJdDsL9/9ihlHoDSPU0HE77vtBr5KT7B
 8v1jIirnwlbt6SN9A1+AlZG9WKNiu9ZHEhM4JOCVuPkG6qRn9kOCzitM/zL/nsjK1qSc
 TEUjbyItjEDhvEfKU+pl5mrjgF0on0AwHqgvZSCKZLllr3Xn3tCu12Az/KrLdlYOq/NP
 kgunSTSC2bTInbqCTQz2RlVF+Bkw6RgRXPMACpb63246ai4w30ycnwCrIItISaI8RjFg
 C7nA==
X-Gm-Message-State: AOJu0Yzi3SNw8GZELdlc6Juf3Zv7AuN7I37l1GTU66l/zvBoh8MViAZG
 7MJw0JUqNqyDXFuNgcR3NW5Yx2ir3Idy8wgr1wM4f+nuu5uXArJQxvYUaw5HMrWX0Jt63s9sEcy
 t3wYAOv9vXR8ZHisP+Grl4yjMS3pbOw==
X-Gm-Gg: ASbGncsrtXLuQOKozGDhCj26BTL1cpzWQ91oUr7lox108ukohw1Z52ouuNSv5d/wTFB
 mgFxweOyIqj8ceK5TzLh8qEBpvznrBhhQDKGZbYMBBDzX4CMt2EVVExNRJYw/g+PFbw/Fk9tJjc
 Kv45SATFH3IW3wqtM8RUD9yU63wA==
X-Google-Smtp-Source: AGHT+IFhEFRV3xeiJFhhpfe2FAv9rcJMZ6T7OVMI/iG80+azuIfRY35g1dIoYqSkP0OyFi9CGc97ynnCueGVYAcYr4I=
X-Received: by 2002:a17:902:cf04:b0:21f:519:6bc6 with SMTP id
 d9443c01a7336-225932f1b31mr608815ad.9.1741619323900; Mon, 10 Mar 2025
 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
 <20250309164852.3936628-4-alexandre.f.demers@gmail.com>
In-Reply-To: <20250309164852.3936628-4-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 11:08:32 -0400
X-Gm-Features: AQ5f1JrOe_gU_1_rKDUk7W8xticBZQS5A-jVz9zK1RbqJDl8MMm2BDtp51ZOTv8
Message-ID: <CADnq5_MJ2dxJn-NBRwXUx50msbvVDjuHkZembR+Jo6s2Bo6kXA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amdgpu: finish wiring up sid.h in DCE6
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

Applied the series.  Thanks!

Alex

On Sun, Mar 9, 2025 at 12:49=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> For coherence with DCE8 et DCE10, add or move some values under sid.h
> and remove duplicated from si_enums.h.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/si_enums.h |  6 ---
>  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
>  3 files changed, 55 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 47b0e4848a56..e1b0779e835f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -41,6 +41,7 @@
>  #include "amdgpu_display.h"
>
>  #include "dce_v6_0.h"
> +#include "sid.h"
>
>  #include "bif/bif_3_0_d.h"
>  #include "bif/bif_3_0_sh_mask.h"
> @@ -65,31 +66,31 @@ static void dce_v6_0_set_irq_funcs(struct amdgpu_devi=
ce *adev);
>
>  static const u32 crtc_offsets[6] =3D
>  {
> -       SI_CRTC0_REGISTER_OFFSET,
> -       SI_CRTC1_REGISTER_OFFSET,
> -       SI_CRTC2_REGISTER_OFFSET,
> -       SI_CRTC3_REGISTER_OFFSET,
> -       SI_CRTC4_REGISTER_OFFSET,
> -       SI_CRTC5_REGISTER_OFFSET
> +       CRTC0_REGISTER_OFFSET,
> +       CRTC1_REGISTER_OFFSET,
> +       CRTC2_REGISTER_OFFSET,
> +       CRTC3_REGISTER_OFFSET,
> +       CRTC4_REGISTER_OFFSET,
> +       CRTC5_REGISTER_OFFSET
>  };
>
>  static const u32 hpd_offsets[] =3D
>  {
> -       mmDC_HPD1_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD2_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD3_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD4_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD5_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD6_INT_STATUS - mmDC_HPD1_INT_STATUS,
> +       HPD0_REGISTER_OFFSET,
> +       HPD1_REGISTER_OFFSET,
> +       HPD2_REGISTER_OFFSET,
> +       HPD3_REGISTER_OFFSET,
> +       HPD4_REGISTER_OFFSET,
> +       HPD5_REGISTER_OFFSET
>  };
>
>  static const uint32_t dig_offsets[] =3D {
> -       SI_CRTC0_REGISTER_OFFSET,
> -       SI_CRTC1_REGISTER_OFFSET,
> -       SI_CRTC2_REGISTER_OFFSET,
> -       SI_CRTC3_REGISTER_OFFSET,
> -       SI_CRTC4_REGISTER_OFFSET,
> -       SI_CRTC5_REGISTER_OFFSET,
> +       CRTC0_REGISTER_OFFSET,
> +       CRTC1_REGISTER_OFFSET,
> +       CRTC2_REGISTER_OFFSET,
> +       CRTC3_REGISTER_OFFSET,
> +       CRTC4_REGISTER_OFFSET,
> +       CRTC5_REGISTER_OFFSET,
>         (0x13830 - 0x7030) >> 2,
>  };
>
> @@ -1365,13 +1366,13 @@ static void dce_v6_0_audio_enable(struct amdgpu_d=
evice *adev,
>
>  static const u32 pin_offsets[7] =3D
>  {
> -       (0x1780 - 0x1780),
> -       (0x1786 - 0x1780),
> -       (0x178c - 0x1780),
> -       (0x1792 - 0x1780),
> -       (0x1798 - 0x1780),
> -       (0x179d - 0x1780),
> -       (0x17a4 - 0x1780),
> +       AUD0_REGISTER_OFFSET,
> +       AUD1_REGISTER_OFFSET,
> +       AUD2_REGISTER_OFFSET,
> +       AUD3_REGISTER_OFFSET,
> +       AUD4_REGISTER_OFFSET,
> +       AUD5_REGISTER_OFFSET,
> +       AUD6_REGISTER_OFFSET,
>  };
>
>  static int dce_v6_0_audio_init(struct amdgpu_device *adev)
> @@ -2882,22 +2883,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_st=
ate(struct amdgpu_device *adev,
>
>         switch (crtc) {
>         case 0:
> -               reg_block =3D SI_CRTC0_REGISTER_OFFSET;
> +               reg_block =3D CRTC0_REGISTER_OFFSET;
>                 break;
>         case 1:
> -               reg_block =3D SI_CRTC1_REGISTER_OFFSET;
> +               reg_block =3D CRTC1_REGISTER_OFFSET;
>                 break;
>         case 2:
> -               reg_block =3D SI_CRTC2_REGISTER_OFFSET;
> +               reg_block =3D CRTC2_REGISTER_OFFSET;
>                 break;
>         case 3:
> -               reg_block =3D SI_CRTC3_REGISTER_OFFSET;
> +               reg_block =3D CRTC3_REGISTER_OFFSET;
>                 break;
>         case 4:
> -               reg_block =3D SI_CRTC4_REGISTER_OFFSET;
> +               reg_block =3D CRTC4_REGISTER_OFFSET;
>                 break;
>         case 5:
> -               reg_block =3D SI_CRTC5_REGISTER_OFFSET;
> +               reg_block =3D CRTC5_REGISTER_OFFSET;
>                 break;
>         default:
>                 DRM_DEBUG("invalid crtc %d\n", crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/=
amdgpu/si_enums.h
> index cd9b0a654991..d656ef1fa6e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
> +++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
> @@ -121,12 +121,6 @@
>  #define CURSOR_UPDATE_LOCK             (1 << 16)
>  #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
>
> -#define SI_CRTC0_REGISTER_OFFSET                0
> -#define SI_CRTC1_REGISTER_OFFSET                0x300
> -#define SI_CRTC2_REGISTER_OFFSET                0x2600
> -#define SI_CRTC3_REGISTER_OFFSET                0x2900
> -#define SI_CRTC4_REGISTER_OFFSET                0x2c00
> -#define SI_CRTC5_REGISTER_OFFSET                0x2f00
>
>  #define ES_AND_GS_AUTO       3
>  #define RADEON_PACKET_TYPE3  3
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index bf228a1dedff..cbf232f5235b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -1700,12 +1700,29 @@
>
>  //#dce stupp
>  /* display controller offsets used for crtc/cur/lut/grph/viewport/etc. *=
/
> -#define SI_CRTC0_REGISTER_OFFSET                0 //(0x6df0 - 0x6df0)/4
> -#define SI_CRTC1_REGISTER_OFFSET                0x300 //(0x79f0 - 0x6df0=
)/4
> -#define SI_CRTC2_REGISTER_OFFSET                0x2600 //(0x105f0 - 0x6d=
f0)/4
> -#define SI_CRTC3_REGISTER_OFFSET                0x2900 //(0x111f0 - 0x6d=
f0)/4
> -#define SI_CRTC4_REGISTER_OFFSET                0x2c00 //(0x11df0 - 0x6d=
f0)/4
> -#define SI_CRTC5_REGISTER_OFFSET                0x2f00 //(0x129f0 - 0x6d=
f0)/4
> +#define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6df=
0 - 0x6df0)/4
> +#define CRTC1_REGISTER_OFFSET                 (0x1e7c - 0x1b7c) //(0x79f=
0 - 0x6df0)/4
> +#define CRTC2_REGISTER_OFFSET                 (0x417c - 0x1b7c) //(0x105=
f0 - 0x6df0)/4
> +#define CRTC3_REGISTER_OFFSET                 (0x447c - 0x1b7c) //(0x111=
f0 - 0x6df0)/4
> +#define CRTC4_REGISTER_OFFSET                 (0x477c - 0x1b7c) //(0x11d=
f0 - 0x6df0)/4
> +#define CRTC5_REGISTER_OFFSET                 (0x4a7c - 0x1b7c) //(0x129=
f0 - 0x6df0)/4
> +
> +/* hpd instance offsets */
> +#define HPD0_REGISTER_OFFSET                 (0x1807 - 0x1807)
> +#define HPD1_REGISTER_OFFSET                 (0x180a - 0x1807)
> +#define HPD2_REGISTER_OFFSET                 (0x180d - 0x1807)
> +#define HPD3_REGISTER_OFFSET                 (0x1810 - 0x1807)
> +#define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
> +#define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
> +
> +/* audio endpt instance offsets */
> +#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
> +#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
> +#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
> +#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
> +#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
> +#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
> +#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
>
>  #define CURSOR_WIDTH 64
>  #define CURSOR_HEIGHT 64
> --
> 2.48.1
>
