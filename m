Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034C1C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 15:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF3510E901;
	Thu, 27 Mar 2025 15:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RTtVKWkn";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AED10E901
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 15:21:35 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-223fd44daf8so3309845ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743088895; x=1743693695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7Kyy+Y+/IHK4SQ4bqB/mlqzHWTYE1F/ApgknHpeCyw=;
 b=RTtVKWknyEl0bPL6mNt/1rLtb6RB77ptPtG0hIKu9AtwtG9lFXWftLC1ygUFOTd5+b
 KMzCYJujYcap+BRnEZWo/LeykIm0CWpibPmZQZ4zHPIB1qvAP7SwrGgiLC1LP3grsVOB
 E1SavwaBpebnZMoZmpRqZJIVbJc16JBXyCSsDjyNCiC5gND9/50I0HT739vykzr37wuy
 mf4wswmBpz5snRIUOTw1Dcu9o7Yh9iVq/Y5OV1RKwxBLLZi2CUMONnO4WWyb0Dc8ip2S
 ETuSlUKp0fNKDfaPhV4qmuKfpt97iv2hN0ElgheUN9+8U7C/SRMjx/7Tdlobee1Nq7l/
 4/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743088895; x=1743693695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7Kyy+Y+/IHK4SQ4bqB/mlqzHWTYE1F/ApgknHpeCyw=;
 b=YwH6TwKCIGypxPwEWJHlEXQv5+DHdYCKyJwZwOukZ6bXRIE+ukLd/yY2pAHZcXW16j
 LtQUoqV1r/8KCzrrbSDUmduFztiQuxypoQUvHIsAX8+z5LQ+YfD8fojeyQvxOYYJlY1w
 f6F2XQKy5/Oiux/xmjZEVFn1250p6QeQBKgobu1zkqkfu9lX/z7bFk1/L/Xsk1Cn5u+m
 CN4HhJQ4ZwNsyTcFkWvTRbycz+KyK9E2oOZysfn7SaC9Fr/QFXDkdwMsmDxm06Xn6HBS
 KchAtLwp5f9WVdfoMxljLa5UsuGSEG3m85Y/+n/zBBPP27lsloZtNSmtzziThzGnDsrX
 WcAg==
X-Gm-Message-State: AOJu0YzTRH3G1zvutGxguuJh24ysyakUBMgAD+OaeWiKklvmg9kHMkQI
 OuL8SJmiHdrwEBa+Bp3wbcEfiRsMSjobA7w2MUiUWAFVryjLAUFJr0t9+nF5ek633R9Ff+btaGH
 749KN3U40MjzdVjI1+QkGJg9vyE3FkQ==
X-Gm-Gg: ASbGncsSnzKSH5mT7kpofDLlM5cin6sz1pppibba21cfLibYpwggz5ccWnv60ZrMRow
 +Gh7MGFdeE02qa/cxICmhrEs5bNdyr7WvXzFhdVaT5j5spA0LzRTK2wmtfFwwhW2t9peVk0m9AK
 0NAJb2eTSvLlwKQ5ieqGBjYeyP4g==
X-Google-Smtp-Source: AGHT+IHaDXI+Sex3zvExgb5d/LuWoSIihiE/MsHPeOGbSgtZqDYzsvbxmHBeESREdXDxkCuWrJ2sNMgJ4YwoVnEbhbw=
X-Received: by 2002:a17:902:db0f:b0:223:5e86:efa9 with SMTP id
 d9443c01a7336-22806874271mr19361095ad.8.1743088894455; Thu, 27 Mar 2025
 08:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
 <20250322183746.86002-6-alexandre.f.demers@gmail.com>
 <CADnq5_MKMrECPyheRymSxEYXA535kJURMng1AHsusp8WWvuUNw@mail.gmail.com>
 <CAPEhTTHCoPewPo0C1WsEnSFBy32BfD39nk056O7GQkO7aaG4zQ@mail.gmail.com>
In-Reply-To: <CAPEhTTHCoPewPo0C1WsEnSFBy32BfD39nk056O7GQkO7aaG4zQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Mar 2025 11:21:21 -0400
X-Gm-Features: AQ5f1JrwlnicPJ4HxDhB4FHazaWO16lwR6r1eqmpz_N4krlBXm4QqEdfdtsykRA
Message-ID: <CADnq5_MxgEnG1ZozwtXYO_+WSGLB92EPKQdspDN5XWMjJKFZZw@mail.gmail.com>
Subject: Re: [PATCH 6/5] drm/amdgpu: fix style in dce_v8_0.c and in vi.c
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

On Thu, Mar 27, 2025 at 12:16=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 2:21=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Sat, Mar 22, 2025 at 2:48=E2=80=AFPM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > Bring things on a single line and fix spacing.
> > >
> > > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
> > >  drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v8_0.c
> > > index f008615343c3..533851beb27c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > > @@ -3233,8 +3233,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_fu=
ncs =3D {
> > >         .set_powergating_state =3D dce_v8_0_set_powergating_state,
> > >  };
> > >
> > > -static void
> > > -dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> > > +static void dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> > >                           struct drm_display_mode *mode,
> > >                           struct drm_display_mode *adjusted_mode)
> > >  {
> > > @@ -3330,8 +3329,7 @@ static void dce_v8_0_ext_commit(struct drm_enco=
der *encoder)
> > >
> > >  }
> > >
> > > -static void
> > > -dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> > > +static void dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> > >                       struct drm_display_mode *mode,
> > >                       struct drm_display_mode *adjusted_mode)
> > >  {
> > > @@ -3343,8 +3341,7 @@ static void dce_v8_0_ext_disable(struct drm_enc=
oder *encoder)
> > >
> > >  }
> > >
> > > -static void
> > > -dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> > > +static void dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> > >  {
> > >
> > >  }
> > > @@ -3407,7 +3404,6 @@ static void dce_v8_0_encoder_add(struct amdgpu_=
device *adev,
> > >                         amdgpu_encoder->devices |=3D supported_device=
;
> > >                         return;
> > >                 }
> > > -
> > >         }
> > >
> > >         /* add a new one */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/am=
dgpu/vi.c
> > > index a83505815d39..bcabcf27c3d0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > > @@ -61,19 +61,27 @@
> > >
> > >  #include "vid.h"
> > >  #include "vi.h"
> > > +
> > >  #include "gmc_v8_0.h"
> > >  #include "gmc_v7_0.h"
> > > +
> > >  #include "gfx_v8_0.h"
> > > +
> > >  #include "sdma_v2_4.h"
> > >  #include "sdma_v3_0.h"
> > > +
> > >  #include "dce_v10_0.h"
> > >  #include "dce_v11_0.h"
> > > +
> > >  #include "iceland_ih.h"
> > >  #include "tonga_ih.h"
> > >  #include "cz_ih.h"
> > > +
> > >  #include "uvd_v5_0.h"
> > >  #include "uvd_v6_0.h"
> > > +
> > >  #include "vce_v3_0.h"
> > > +
> > >  #if defined(CONFIG_DRM_AMD_ACP)>  #include "amdgpu_acp.h"
> > >  #endif
> >
> > What is the reason for these changes?  Unless this actually fixes some
> > style warning, I'd drop this change.
> >
> > Alex
> >
> Readability. Nothing more, nothing less. I'm leaving this up to you to
> decide if you want it in or not.

Can you drop this hunk when you send your next respin?

Alex

> Alexandre
> >
> > > --
> > > 2.49.0
> > >
