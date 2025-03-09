Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB2FC282EC
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 00:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFC710E24B;
	Sun,  9 Mar 2025 00:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQXGNsgh";
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0765410E24B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 00:33:04 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-86d30787263so1367807241.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Mar 2025 16:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741480383; x=1742085183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCVtEtL1w/kxZ+yOQUbKXRxSOPvLTJ4ZucamvMeLLgo=;
 b=HQXGNsghIPKPP6NHYpnuHiX3Mv/WgmAIHuIQJu7THcDvpDgiTcpOzVYdHxoU4GB/fy
 ulNvwYt/caOax6Av4/Kq8C5yv/Dv5nD8XCkP3+RqhXtgh4xKyXyOX/ihUzw7lle1UHVz
 Y6kF2dV00jo79rxH2Hz3Syexp4z+t4izFyUJKc8kVqSMlR3Q5Q1oXEX6PtXm0zZlWg3/
 aVr+d0S6H7fK2/Zk5ME07y3ig4xfsCt+t4gBpHLdXnB9hFlubgKMtYFgKcCA9LhvZlQA
 EA9VfEW91YtL4FRVj+iruOlrfePP/VwH/d4pWGFYqhjaPqUKXkiTm++ZHwwtAJfIRsGM
 5uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741480383; x=1742085183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCVtEtL1w/kxZ+yOQUbKXRxSOPvLTJ4ZucamvMeLLgo=;
 b=E/9l6r7YwUgUrvPIX2rUoSFpQvPZiz3inbzzZlUkCfXp/nbqma8AjJEjC/WFHBgQV/
 4FuQhZlvUlFUY1M8CdQtJFIOXoV22cCyXXij7BztlsWeoQH+Y+N3DZJv53EHXwOHPmWB
 /I9WQSsCaYlLxBS8hs1+RFAJm3ZxkE/hRLv/gBGde5GESL/d79+gDj0Hcn7dbg97BI3X
 zMgmNwL4UMHzQu8Lwqr252nKJGIkn66Z+SbWU/toN5aHM09mtiJgB7+ebjRfYH+KZD9p
 VSD2qKkr4AnAIcscfBwL8WOcp37okvjReNhT0pmXVuWiLjT6MDxYxpwHnbgROlIh7Sjt
 xl5Q==
X-Gm-Message-State: AOJu0YytnvFPSe06gUOzi116MaWTu0BYminK/0aH1l6jXAh3uYWTzgd7
 3BS0Vm8t+ESmee/9Z73PIEaXZBlHslOg9ihwICIBsRKqg/b8pcv8lhFwulaEyz7kTK/WUGCD8ub
 W/aeIh45YMEZZal8YwRIh7DGvbE4=
X-Gm-Gg: ASbGnctteMRjEp/+Mz/eAjk2xT8bufO1q7fzEjY2TeVr5hBR36eaWmbpah6yh3mRJ0u
 mCvJw9XGROMWld1xP7svIPd7la1HnY2JKUTYLU+yiEhUVDzjeaBiBBUUmVbVedw2+uHXDs9Fu1E
 AlfujCc4Q802EKQ7vUke82LuTY
X-Google-Smtp-Source: AGHT+IGhunYDRb813LQDY7jqKKDpGw3qY10G+nSA+klLPEdfhN9hbVp90AHOVMpWLp/XSyHrnzTjDQasIg4Dr5N+21c=
X-Received: by 2002:a05:6102:2d0a:b0:4c1:8c9d:3f39 with SMTP id
 ada2fe7eead31-4c30a5387a3mr6110362137.4.1741480382652; Sat, 08 Mar 2025
 16:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
 <20250306014958.785021-2-alexandre.f.demers@gmail.com>
 <CADnq5_O65aDEgaVkzZ1xZyqEgqHr4nR1WDWPJ94jKRtu629o9w@mail.gmail.com>
In-Reply-To: <CADnq5_O65aDEgaVkzZ1xZyqEgqHr4nR1WDWPJ94jKRtu629o9w@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 8 Mar 2025 19:32:51 -0500
X-Gm-Features: AQ5f1Jr9rOc-nHo8vfYzKiJ_Ecm0pWyGA-pmJJdA0lonT42wphxcs5EYK8qtQ0Q
Message-ID: <CAPEhTTGxA_owpgD6=4XUCcyVXRjBxRJveYdbaVqjbug9Digusg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: add or move defines for DCE6 in sid.h
To: Alex Deucher <alexdeucher@gmail.com>
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

On Thu, Mar 6, 2025 at 10:19=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Mar 5, 2025 at 9:08=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > For coherence with DCE8 et DCE10, add or move some values under sid.h.
> >
> > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
>
> This change doesn't build.  Please adjust the order of the patches as
> needed to make sure they all build.
>
> Alex

Yeah, adding sid.h should probably be at the end, once all changes are
made. I'll look at it.

Thanks for noticing.
Alexandre
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
> >  drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
> >  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
> >  3 files changed, 55 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> > index a72fd7220081..185401d66961 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > @@ -32,6 +32,7 @@
> >  #include "amdgpu.h"
> >  #include "amdgpu_pm.h"
> >  #include "amdgpu_i2c.h"
> > +#include "sid.h"
> >  #include "atom.h"
> >  #include "amdgpu_atombios.h"
> >  #include "atombios_crtc.h"
> > @@ -59,31 +60,31 @@ static void dce_v6_0_set_irq_funcs(struct amdgpu_de=
vice *adev);
> >
> >  static const u32 crtc_offsets[6] =3D
> >  {
> > -       SI_CRTC0_REGISTER_OFFSET,
> > -       SI_CRTC1_REGISTER_OFFSET,
> > -       SI_CRTC2_REGISTER_OFFSET,
> > -       SI_CRTC3_REGISTER_OFFSET,
> > -       SI_CRTC4_REGISTER_OFFSET,
> > -       SI_CRTC5_REGISTER_OFFSET
> > +       CRTC0_REGISTER_OFFSET,
> > +       CRTC1_REGISTER_OFFSET,
> > +       CRTC2_REGISTER_OFFSET,
> > +       CRTC3_REGISTER_OFFSET,
> > +       CRTC4_REGISTER_OFFSET,
> > +       CRTC5_REGISTER_OFFSET
> >  };
> >
> >  static const u32 hpd_offsets[] =3D
> >  {
> > -       mmDC_HPD1_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > -       mmDC_HPD2_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > -       mmDC_HPD3_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > -       mmDC_HPD4_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > -       mmDC_HPD5_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > -       mmDC_HPD6_INT_STATUS - mmDC_HPD1_INT_STATUS,
> > +       HPD0_REGISTER_OFFSET,
> > +       HPD1_REGISTER_OFFSET,
> > +       HPD2_REGISTER_OFFSET,
> > +       HPD3_REGISTER_OFFSET,
> > +       HPD4_REGISTER_OFFSET,
> > +       HPD5_REGISTER_OFFSET
> >  };
> >
> >  static const uint32_t dig_offsets[] =3D {
> > -       SI_CRTC0_REGISTER_OFFSET,
> > -       SI_CRTC1_REGISTER_OFFSET,
> > -       SI_CRTC2_REGISTER_OFFSET,
> > -       SI_CRTC3_REGISTER_OFFSET,
> > -       SI_CRTC4_REGISTER_OFFSET,
> > -       SI_CRTC5_REGISTER_OFFSET,
> > +       CRTC0_REGISTER_OFFSET,
> > +       CRTC1_REGISTER_OFFSET,
> > +       CRTC2_REGISTER_OFFSET,
> > +       CRTC3_REGISTER_OFFSET,
> > +       CRTC4_REGISTER_OFFSET,
> > +       CRTC5_REGISTER_OFFSET,
> >         (0x13830 - 0x7030) >> 2,
> >  };
> >
> > @@ -1359,13 +1360,13 @@ static void dce_v6_0_audio_enable(struct amdgpu=
_device *adev,
> >
> >  static const u32 pin_offsets[7] =3D
> >  {
> > -       (0x1780 - 0x1780),
> > -       (0x1786 - 0x1780),
> > -       (0x178c - 0x1780),
> > -       (0x1792 - 0x1780),
> > -       (0x1798 - 0x1780),
> > -       (0x179d - 0x1780),
> > -       (0x17a4 - 0x1780),
> > +       AUD0_REGISTER_OFFSET,
> > +       AUD1_REGISTER_OFFSET,
> > +       AUD2_REGISTER_OFFSET,
> > +       AUD3_REGISTER_OFFSET,
> > +       AUD4_REGISTER_OFFSET,
> > +       AUD5_REGISTER_OFFSET,
> > +       AUD6_REGISTER_OFFSET,
> >  };
> >
> >  static int dce_v6_0_audio_init(struct amdgpu_device *adev)
> > @@ -2876,22 +2877,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_=
state(struct amdgpu_device *adev,
> >
> >         switch (crtc) {
> >         case 0:
> > -               reg_block =3D SI_CRTC0_REGISTER_OFFSET;
> > +               reg_block =3D CRTC0_REGISTER_OFFSET;
> >                 break;
> >         case 1:
> > -               reg_block =3D SI_CRTC1_REGISTER_OFFSET;
> > +               reg_block =3D CRTC1_REGISTER_OFFSET;
> >                 break;
> >         case 2:
> > -               reg_block =3D SI_CRTC2_REGISTER_OFFSET;
> > +               reg_block =3D CRTC2_REGISTER_OFFSET;
> >                 break;
> >         case 3:
> > -               reg_block =3D SI_CRTC3_REGISTER_OFFSET;
> > +               reg_block =3D CRTC3_REGISTER_OFFSET;
> >                 break;
> >         case 4:
> > -               reg_block =3D SI_CRTC4_REGISTER_OFFSET;
> > +               reg_block =3D CRTC4_REGISTER_OFFSET;
> >                 break;
> >         case 5:
> > -               reg_block =3D SI_CRTC5_REGISTER_OFFSET;
> > +               reg_block =3D CRTC5_REGISTER_OFFSET;
> >                 break;
> >         default:
> >                 DRM_DEBUG("invalid crtc %d\n", crtc);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/am=
d/amdgpu/si_enums.h
> > index 4e935baa7b91..cdf8eebaa392 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
> > @@ -121,13 +121,6 @@
> >  #define CURSOR_UPDATE_LOCK             (1 << 16)
> >  #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
> >
> > -#define SI_CRTC0_REGISTER_OFFSET                0
> > -#define SI_CRTC1_REGISTER_OFFSET                0x300
> > -#define SI_CRTC2_REGISTER_OFFSET                0x2600
> > -#define SI_CRTC3_REGISTER_OFFSET                0x2900
> > -#define SI_CRTC4_REGISTER_OFFSET                0x2c00
> > -#define SI_CRTC5_REGISTER_OFFSET                0x2f00
> > -
> >  #define DMA0_REGISTER_OFFSET 0x000
> >  #define DMA1_REGISTER_OFFSET 0x200
> >  #define ES_AND_GS_AUTO       3
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amd=
gpu/sid.h
> > index 9a39cbfe6db9..32a4e7d450c6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> > @@ -1991,12 +1991,29 @@
> >
> >  //#dce stupp
> >  /* display controller offsets used for crtc/cur/lut/grph/viewport/etc.=
 */
> > -#define SI_CRTC0_REGISTER_OFFSET                0 //(0x6df0 - 0x6df0)/=
4
> > -#define SI_CRTC1_REGISTER_OFFSET                0x300 //(0x79f0 - 0x6d=
f0)/4
> > -#define SI_CRTC2_REGISTER_OFFSET                0x2600 //(0x105f0 - 0x=
6df0)/4
> > -#define SI_CRTC3_REGISTER_OFFSET                0x2900 //(0x111f0 - 0x=
6df0)/4
> > -#define SI_CRTC4_REGISTER_OFFSET                0x2c00 //(0x11df0 - 0x=
6df0)/4
> > -#define SI_CRTC5_REGISTER_OFFSET                0x2f00 //(0x129f0 - 0x=
6df0)/4
> > +#define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6=
df0 - 0x6df0)/4
> > +#define CRTC1_REGISTER_OFFSET                 (0x1e7c - 0x1b7c) //(0x7=
9f0 - 0x6df0)/4
> > +#define CRTC2_REGISTER_OFFSET                 (0x417c - 0x1b7c) //(0x1=
05f0 - 0x6df0)/4
> > +#define CRTC3_REGISTER_OFFSET                 (0x447c - 0x1b7c) //(0x1=
11f0 - 0x6df0)/4
> > +#define CRTC4_REGISTER_OFFSET                 (0x477c - 0x1b7c) //(0x1=
1df0 - 0x6df0)/4
> > +#define CRTC5_REGISTER_OFFSET                 (0x4a7c - 0x1b7c) //(0x1=
29f0 - 0x6df0)/4
> > +
> > +/* hpd instance offsets */
> > +#define HPD0_REGISTER_OFFSET                 (0x1807 - 0x1807)
> > +#define HPD1_REGISTER_OFFSET                 (0x180a - 0x1807)
> > +#define HPD2_REGISTER_OFFSET                 (0x180d - 0x1807)
> > +#define HPD3_REGISTER_OFFSET                 (0x1810 - 0x1807)
> > +#define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
> > +#define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
> > +
> > +/* audio endpt instance offsets */
> > +#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
> > +#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
> > +#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
> > +#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
> > +#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
> > +#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
> > +#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
> >
> >  #define CURSOR_WIDTH 64
> >  #define CURSOR_HEIGHT 64
> > --
> > 2.48.1
> >
