Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C00C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A1010E563;
	Mon,  4 Aug 2025 17:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/khTWWO";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401A610E563
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:31:23 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-32127d5f63eso185711a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754328683; x=1754933483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMv7lkVKIhoKOAW9uMzdxvSxW+8/N3A+QglXMePtWhU=;
 b=D/khTWWOkiAXY5mgtKz+4P0x0pvEmN9a7uqoBsbceCU2XRgW82p6axEGOnsP8mEg2k
 9gQ+/bKZclND3AOrMjQJeb7ltQpeP+8mBADo9QnZUTBsGIC4ElWYfTDOfXwAEk0fKpgb
 Djehww0GSNSlWAx+zhaf1tn9rDDIiTiorktuUjs6mn04scReXEfjhcnEC05ALfmivcJ0
 Sw7Ilh3zKU0nyMC4uvyaysqWboHavVN5KB3TewWit7ia29NBKh+47HQXB9Bk1+LEOvVn
 he1Wt0/yrFpYFUxBguZ2yGh4JxBBQ8xQMx3FxAfUfmYXeIBIrj9BccAPCtx0kONo9OwO
 osLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754328683; x=1754933483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMv7lkVKIhoKOAW9uMzdxvSxW+8/N3A+QglXMePtWhU=;
 b=e9SREoWl0CNG1xi4ASCAdpYUqg+/eaEUD+qagj58Lrc5wuFd4wDRmrgvURO2LpsaYV
 zq5aW0lnKIAL6ETFyseS6r3b2f07l6/2rQh39V2y5k2JGus9lVrNdxyMON5+jbv5YFS+
 hNzlFqavAWj8FMLmQwM/mDmIpTWM8BGerLgs/f3nH4bYJkh+j4lK7qgwQKkkJP9KTm8I
 mkHRrQiTA7BW8ogbw/ODXALqXRvFzG+yb+fOYFeXYyhqH41FUGv1u7/GQqDcoAygKO5C
 5ot9S6mNEQiyH4dC5WvnGKNNAlmsThqW42gqA3gHSXTYvat11zou+IDIu869CawzThST
 H8Xw==
X-Gm-Message-State: AOJu0YyCAW5ZCLv30Ki1lSbGSyxK25Enqtqx5UEEpCn22hpjevHE8eY/
 hIweD4+qO5QPkKthT1wmHluP+BIXDHnlerZ2FEejBflurU018P1eqXf8lkl5mYioquA5+LpBez7
 MTnBtYj3h6ssOIor5adkGzSwSZJSt/sX/aA==
X-Gm-Gg: ASbGncuGHTaVCIZQ+X5VUi4oHIJgfJWBf9oRSjrKIXw94DFOKX5z/+YLOS5LkTzzxMW
 nJk4YXrfLj8E/n90EcS2jyIise+yAAopWaXIExLOTI5G7EYkcu1S4bG6JnT96Ltz17QrUX59FuP
 rBss9tFeUhNW0fbLePrW6Cx/Fp2RluOdOGiSk7jG+11cjeY8v66Hydl1E6p04v5InE9JmmVYwRc
 sAL2rRq
X-Google-Smtp-Source: AGHT+IEtLWyoGA1GEM21NJ+irHJxr/O0UnuJ5n5wbKevBFG28M/DCoMoL2MxVFiR5lbQpzdL+R6ZbYakBIKhyUQaPrg=
X-Received: by 2002:a17:90b:38cf:b0:31f:23f0:2df8 with SMTP id
 98e67ed59e1d1-321162c7222mr4977487a91.6.1754328682393; Mon, 04 Aug 2025
 10:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-5-timur.kristof@gmail.com>
 <CADnq5_P6EsOrX8e8B3bRh_KEaPVisUAEWxZ9uXX62TY=a-dO3g@mail.gmail.com>
 <4c002dfef88f033832d0be5221fed0019c0feaf0.camel@gmail.com>
In-Reply-To: <4c002dfef88f033832d0be5221fed0019c0feaf0.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:31:11 -0400
X-Gm-Features: Ac12FXylBvRw27TLwzHabFfn4Qwl_-2zd0Cckr1QbTiwVX_yUtmDd28txSswHJ0
Message-ID: <CADnq5_MSd5CeDwFH2n7fqNtmt9iiXaRrruSJJ887dG_CK=4jGQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/pm: Fix si_upload_smc_data
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Mon, Aug 4, 2025 at 12:16=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-04 at 11:32 -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 9:42=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > The si_upload_smc_data function uses si_write_smc_soft_register
> > > to set some register values in the SMC, and expects the result
> > > to be PPSMC_Result_OK which is 1.
> > >
> > > The PPSMC_Result_OK / PPSMC_Result_Failed values are used for
> > > checking the result of a command sent to the SMC.
> > >
> > > However, the si_write_smc_soft_register actually doesn't send
> > > any commands to the SMC and returns zero on success,
> > > so this check was incorrect.
> > >
> > > Fix that by correctly interpreting zero as success.
> > > This seems to fix an SMC hang that happens in si_set_sw_state.
> > >
> > > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 +++++++++++++-----
> > > ----
> > >  1 file changed, 19 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > index 33b9d4beec84..e9f034ade214 100644
> > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > @@ -5820,6 +5820,7 @@ static int si_upload_smc_data(struct
> > > amdgpu_device *adev)
> > >  {
> > >         struct amdgpu_crtc *amdgpu_crtc =3D NULL;
> > >         int i;
> > > +       int ret;
> > >
> > >         if (adev->pm.dpm.new_active_crtc_count =3D=3D 0)
> > >                 return 0;
> > > @@ -5837,20 +5838,26 @@ static int si_upload_smc_data(struct
> > > amdgpu_device *adev)
> > >         if (amdgpu_crtc->line_time <=3D 0)
> > >                 return 0;
> > >
> > > -       if (si_write_smc_soft_register(adev,
> > > -
> > > SI_SMC_SOFT_REGISTER_crtc_index,
> > > -                                      amdgpu_crtc->crtc_id) !=3D
> > > PPSMC_Result_OK)
> > > -               return 0;
> > > +       ret =3D si_write_smc_soft_register(
> > > +               adev,
> > > +               SI_SMC_SOFT_REGISTER_crtc_index,
> > > +               amdgpu_crtc->crtc_id);
> > > +       if (ret)
> > > +               return ret;
> > >
> > > -       if (si_write_smc_soft_register(adev,
> > > -
> > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > -                                      amdgpu_crtc->wm_high /
> > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > -               return 0;
> > > +       ret =3D si_write_smc_soft_register(
> > > +               adev,
> > > +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > +               amdgpu_crtc->wm_high / amdgpu_crtc->line_time);
> > > +       if (ret)
> > > +               return ret;
> > >
> > > -       if (si_write_smc_soft_register(adev,
> > > -
> > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > -                                      amdgpu_crtc->wm_low /
> > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > -               return 0;
> > > +       ret =3D si_write_smc_soft_register(
> > > +               adev,
> > > +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > +               amdgpu_crtc->wm_low / amdgpu_crtc->line_time);
> > > +       if (ret)
> > > +               return ret;
> >
> > This patch changes the behavior of this function (i.e., it always
> > returns 0 before this patch).  Not sure if that matters or not.  I
> > think this could be simplified to something like the following to
> > retain the current behavior.
>
> Actually now that I think of it more, I think it may be entirely
> unnecessary to check the return value.
>
> si_upload_smc_data calls:
> si_write_smc_soft_register
> amdgpu_si_write_smc_sram_dword
> si_set_smc_sram_address
>
> This last one, si_set_smc_sram_address returns -EINVAL when its
> smc_address parameter is not dword-aligned or out of bounds. Otherwise
> all of the above functions return 0 (success). Considering that all of
> the addresses passed by si_upload_smc_data are compile time constants,
> we know they are correct so there is no reason why any of those
> functions would return an error.
>
> Looking at other callers of si_write_smc_soft_register, I see that they
> don't check the return value at all.
>
> So, I'd actually simplify this even more and just not check the return
> values. What do you think about that?

Sure.  Works for me.

Alex

>
>
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index 52e732be59e36..3dd0115aa15f8 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -5836,17 +5836,17 @@ static int si_upload_smc_data(struct
> > amdgpu_device *adev)
> >
> >         if (si_write_smc_soft_register(adev,
> >
> > SI_SMC_SOFT_REGISTER_crtc_index,
> > -                                      amdgpu_crtc->crtc_id) !=3D
> > PPSMC_Result_OK)
> > +                                      amdgpu_crtc->crtc_id))
> >                 return 0;
> >
> >         if (si_write_smc_soft_register(adev,
> >
> > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > -                                      amdgpu_crtc->wm_high /
> > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > +                                      amdgpu_crtc->wm_high /
> > amdgpu_crtc->line_time))
> >                 return 0;
> >
> >         if (si_write_smc_soft_register(adev,
> >
> > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > -                                      amdgpu_crtc->wm_low /
> > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > +                                      amdgpu_crtc->wm_low /
> > amdgpu_crtc->line_time))
> >                 return 0;
> >
> >         return 0;
> >
> >
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.50.1
> > >
