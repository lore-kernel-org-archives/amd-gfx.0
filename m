Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F5C36013
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 04:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883B010E25B;
	Thu, 27 Mar 2025 04:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHYt2dvU";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7EC10E25B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 04:16:41 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2bd2218ba4fso185498fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743048997; x=1743653797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74fpbvrCD3ECrw9zxirl3ogxo1/+zICSJD4tz2PCsIc=;
 b=ZHYt2dvU4eH7SYNrFORW4gF346jrc/6PmXleS1TtscJyuOJ2a3YVAvN4qHZu4n4gvK
 Zi12dfzRWNXiYkJBN3uT1e2lcHqijce4rRF6P5scOUMr9ITjGDKgYwq5s8dgeBZ4FLI8
 5TpSXoJX1i1CmMyGyBt4yQJhYhRBPXW0G4si4O0DXicTQlmLMH7Rd4pRCqBv01uscFNF
 pHFLvyaR85GBM5Fmad4MkWHSJ0C91M5TciKh2sWwiUp0LemUAQCLwwmeGdzLFfDLT293
 wLsbO60vj/+33bHVt5jGYvk9zgIwGXIw5AWviC77FR92GwBaLDN465WlKMAwtGTITdrG
 bqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743048997; x=1743653797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74fpbvrCD3ECrw9zxirl3ogxo1/+zICSJD4tz2PCsIc=;
 b=IEvgKG1+99YqtooNexkqa8pmjyvo31rfEYrmB/rY7YnvrPDlhTsAwmexx8dskdzziO
 0OZDSi7MglaZx/hYNzySCoD2D5DBgH/W2xyQUb+Rbq550EamzApCfhVeMBrhOOoU9RuC
 zrxR/5vBI2N2JDywNwoCDBp3jYYPtPiWYnAqDbD0YZ/M1p3bDjLcjTZ/f/ULTtyPRWKm
 TOHpLfLbqhItRQ7Azy2Bw7oBLjLYZjuP3Ch+MA9nvnL9r0ryA6BL3MDRUEmOXIJ/AzZV
 vyFLMZ/iOLZD4GqZRLsPTNbhqwC7btMVgx6cFzxoGhgEIPI24MRvYG4AZBsFeyg6EmZ9
 5+rw==
X-Gm-Message-State: AOJu0YyrNlMd+DEjBD3pqW7+d/zIEA1673GtlgRR02vKFBFPOvi346Lj
 PD49WuBiEKCcjPGJjFc95VTEiLS5uoK76j+RVIHyKqsIaI3D4Jybm/TBtxq0U23gqBI1oDJu8BV
 nOgSn6reEID/L9/LX5+4Q4zADD1s=
X-Gm-Gg: ASbGncvaQ2yPilVRRLDJw2KsiqvwrXeWz5J00Ds8Cfm38hEkWunfa0QnI34avU/5LJX
 LF0dybquEo0C7HXxjQH55qPWj4bniizmfw5HLyF27wsGFWcVvawphMghqjjS0XbeDvA/xep+0PB
 EldLQgDswh897k2Duu+X4h5PsWMkmGxTrOJUo=
X-Google-Smtp-Source: AGHT+IFXzvEuy83NwMoxGyQgXjOKRHXKcDT1UhtoiCZ8TmkGbnEPP4/Q+sBJPO+VB/c3+OxNuMjrkZ1sBLWG1ARnivk=
X-Received: by 2002:a05:6871:5cc:b0:2c2:3c88:6ef7 with SMTP id
 586e51a60fabf-2c8481b374emr1205846fac.26.1743048997482; Wed, 26 Mar 2025
 21:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
 <20250322183746.86002-6-alexandre.f.demers@gmail.com>
 <CADnq5_MKMrECPyheRymSxEYXA535kJURMng1AHsusp8WWvuUNw@mail.gmail.com>
In-Reply-To: <CADnq5_MKMrECPyheRymSxEYXA535kJURMng1AHsusp8WWvuUNw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Thu, 27 Mar 2025 00:16:26 -0400
X-Gm-Features: AQ5f1JokTwkmgE08tm0CQW7cNB1X-6vOzV3FRGbpAHCwV4tfvZOFRkrHdGIaHRM
Message-ID: <CAPEhTTHCoPewPo0C1WsEnSFBy32BfD39nk056O7GQkO7aaG4zQ@mail.gmail.com>
Subject: Re: [PATCH 6/5] drm/amdgpu: fix style in dce_v8_0.c and in vi.c
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

On Mon, Mar 24, 2025 at 2:21=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Sat, Mar 22, 2025 at 2:48=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Bring things on a single line and fix spacing.
> >
> > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
> >  drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v8_0.c
> > index f008615343c3..533851beb27c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > @@ -3233,8 +3233,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_func=
s =3D {
> >         .set_powergating_state =3D dce_v8_0_set_powergating_state,
> >  };
> >
> > -static void
> > -dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> > +static void dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> >                           struct drm_display_mode *mode,
> >                           struct drm_display_mode *adjusted_mode)
> >  {
> > @@ -3330,8 +3329,7 @@ static void dce_v8_0_ext_commit(struct drm_encode=
r *encoder)
> >
> >  }
> >
> > -static void
> > -dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> > +static void dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> >                       struct drm_display_mode *mode,
> >                       struct drm_display_mode *adjusted_mode)
> >  {
> > @@ -3343,8 +3341,7 @@ static void dce_v8_0_ext_disable(struct drm_encod=
er *encoder)
> >
> >  }
> >
> > -static void
> > -dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> > +static void dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> >  {
> >
> >  }
> > @@ -3407,7 +3404,6 @@ static void dce_v8_0_encoder_add(struct amdgpu_de=
vice *adev,
> >                         amdgpu_encoder->devices |=3D supported_device;
> >                         return;
> >                 }
> > -
> >         }
> >
> >         /* add a new one */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> > index a83505815d39..bcabcf27c3d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -61,19 +61,27 @@
> >
> >  #include "vid.h"
> >  #include "vi.h"
> > +
> >  #include "gmc_v8_0.h"
> >  #include "gmc_v7_0.h"
> > +
> >  #include "gfx_v8_0.h"
> > +
> >  #include "sdma_v2_4.h"
> >  #include "sdma_v3_0.h"
> > +
> >  #include "dce_v10_0.h"
> >  #include "dce_v11_0.h"
> > +
> >  #include "iceland_ih.h"
> >  #include "tonga_ih.h"
> >  #include "cz_ih.h"
> > +
> >  #include "uvd_v5_0.h"
> >  #include "uvd_v6_0.h"
> > +
> >  #include "vce_v3_0.h"
> > +
> >  #if defined(CONFIG_DRM_AMD_ACP)>  #include "amdgpu_acp.h"
> >  #endif
>
> What is the reason for these changes?  Unless this actually fixes some
> style warning, I'd drop this change.
>
> Alex
>
Readability. Nothing more, nothing less. I'm leaving this up to you to
decide if you want it in or not.
Alexandre
>
> > --
> > 2.49.0
> >
