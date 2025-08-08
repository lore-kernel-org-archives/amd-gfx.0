Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4F8C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C3310E971;
	Fri,  8 Aug 2025 19:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMYYQASd";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5053710E971
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:04:15 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-23ff92d05acso4316085ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754679855; x=1755284655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWRVAGBe8pdgKFIn1c23sjWvCS8QGH2IExxZPsGUNOQ=;
 b=MMYYQASdxewweezEtBHln/eGGBTX6Ug/n+oy3uwB8/l9bShnGY1XdEyKuAGlqn5t1H
 NogVjwm1MVdmf4wB7XRnDqDm8KQwCJJ0BxG+ncAHyDr3nqEKl5zXWbZJURyuz1I/oUZV
 gdNElobVOc2bRY0NQlMkL/Hp3Ux6MI76wo6lYvMunMNGDukHu44TH03bgvnNbFQXqzwv
 uMfbZMuHpuU6/wfZfYo21V2JrQFFhW26O16NvpfRT0Q1uyu9My9rKpPT704cN1P5ok3z
 AjEzZhLtU4eiey9Xy8PuTSIivDnjvD8gv+knp/aXjusODX4BRzHRqYUkaAvZUPOJ7xa+
 mNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679855; x=1755284655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWRVAGBe8pdgKFIn1c23sjWvCS8QGH2IExxZPsGUNOQ=;
 b=ku7IgWX//LpEQuiGbFDE77wP7b66oAS+LIkwY/3AWOm3TIxiUnfAixeG+pRjKrctg/
 ugpFpBPhVJKdPBn22B0GXrVQMP45/aEqxL+P76yLgu6DnvpSmqgJ/adD4HoZEYGbV3XY
 GaV1EIDkcz4acFlJQ78AsqP8hYKNBlv+Ga2QnN/8o7HRwWrTx8i4AlJpQ0eI3lMmJAkT
 NRWfXh9q2HFhyj3pb2Ev4otE7Mo8AnYUB1TYXMkWD4N4PPgTkzBNbjyv5XG9zzq4Gg9g
 2B333EhqDQEY5b+jKkHkcsvqqIOAjRH7In+jzjxfT4If6ThMyGx/YQFtRsESRgA2mE9I
 rTaA==
X-Gm-Message-State: AOJu0YwnAoNh+2GoB4WbWGJj1QDbk5LazP+xKa32/E2pE12PeckJyV0c
 KSLqQeaLTck52Oz0n/5fOKvVvbO4YvBbl5oqkU2DqYAtkRfn2IGsalSLnrs2WegUz8IS0ZOUk5r
 +LwP6Z+FNzaqQpigIZfQ1nZWNyq3udWY=
X-Gm-Gg: ASbGncudXXPhUWlxr0vy3vk9r2WYYR6gjTsiY5MG9VyuGKwtzfRX5OJd9tKICHKQMS4
 Ae173Ni4dl2de7FVWqM3/TX878NprWhR40xMHZuqsJh6EWC9H08rV4L2KgD9ZBc6LNHM3CxP+zH
 SSfO0d7lUH1Jce/7OU8LpS75+933SF/ige7qa+SeoY7Mfwr5/hnxPoexs/dYLQhcFketol/gIkL
 bgR8mu7qpcqaAOCiQ==
X-Google-Smtp-Source: AGHT+IGkp+L5ANZthAdg4JCG57yHn2qf3f6h/oO1I/QRRJZ5qzG/Iba4qlt56+LU5uyC3GqlnA5B251wkHn9ErNo+4Q=
X-Received: by 2002:a17:902:f548:b0:240:79df:48b0 with SMTP id
 d9443c01a7336-242d35721f7mr485945ad.0.1754679854636; Fri, 08 Aug 2025
 12:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-5-timur.kristof@gmail.com>
 <CADnq5_P6EsOrX8e8B3bRh_KEaPVisUAEWxZ9uXX62TY=a-dO3g@mail.gmail.com>
 <4c002dfef88f033832d0be5221fed0019c0feaf0.camel@gmail.com>
 <CADnq5_MSd5CeDwFH2n7fqNtmt9iiXaRrruSJJ887dG_CK=4jGQ@mail.gmail.com>
 <11315cd2289dd111db673b0d3832f373d268c833.camel@gmail.com>
In-Reply-To: <11315cd2289dd111db673b0d3832f373d268c833.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 15:04:02 -0400
X-Gm-Features: Ac12FXyTTjV3-B-7sPIGLEuFMhF6JHhtr7bxGqt9rJm20LuCDDZ-nykI9vE_YME
Message-ID: <CADnq5_NmfCoB-Bk+TC9WafXdvMhQr9sUyoodnhOf5__TY5mr5g@mail.gmail.com>
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

On Fri, Aug 8, 2025 at 4:22=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> On Mon, 2025-08-04 at 13:31 -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 12:16=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > On Mon, 2025-08-04 at 11:32 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 4, 2025 at 9:42=E2=80=AFAM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >
> > > > > The si_upload_smc_data function uses si_write_smc_soft_register
> > > > > to set some register values in the SMC, and expects the result
> > > > > to be PPSMC_Result_OK which is 1.
> > > > >
> > > > > The PPSMC_Result_OK / PPSMC_Result_Failed values are used for
> > > > > checking the result of a command sent to the SMC.
> > > > >
> > > > > However, the si_write_smc_soft_register actually doesn't send
> > > > > any commands to the SMC and returns zero on success,
> > > > > so this check was incorrect.
> > > > >
> > > > > Fix that by correctly interpreting zero as success.
> > > > > This seems to fix an SMC hang that happens in si_set_sw_state.
> > > > >
> > > > > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 +++++++++++++-
> > > > > ----
> > > > > ----
> > > > >  1 file changed, 19 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > index 33b9d4beec84..e9f034ade214 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > @@ -5820,6 +5820,7 @@ static int si_upload_smc_data(struct
> > > > > amdgpu_device *adev)
> > > > >  {
> > > > >         struct amdgpu_crtc *amdgpu_crtc =3D NULL;
> > > > >         int i;
> > > > > +       int ret;
> > > > >
> > > > >         if (adev->pm.dpm.new_active_crtc_count =3D=3D 0)
> > > > >                 return 0;
> > > > > @@ -5837,20 +5838,26 @@ static int si_upload_smc_data(struct
> > > > > amdgpu_device *adev)
> > > > >         if (amdgpu_crtc->line_time <=3D 0)
> > > > >                 return 0;
> > > > >
> > > > > -       if (si_write_smc_soft_register(adev,
> > > > > -
> > > > > SI_SMC_SOFT_REGISTER_crtc_index,
> > > > > -                                      amdgpu_crtc->crtc_id) !=3D
> > > > > PPSMC_Result_OK)
> > > > > -               return 0;
> > > > > +       ret =3D si_write_smc_soft_register(
> > > > > +               adev,
> > > > > +               SI_SMC_SOFT_REGISTER_crtc_index,
> > > > > +               amdgpu_crtc->crtc_id);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > >
> > > > > -       if (si_write_smc_soft_register(adev,
> > > > > -
> > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > > -                                      amdgpu_crtc->wm_high /
> > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > -               return 0;
> > > > > +       ret =3D si_write_smc_soft_register(
> > > > > +               adev,
> > > > > +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > > +               amdgpu_crtc->wm_high / amdgpu_crtc->line_time);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > >
> > > > > -       if (si_write_smc_soft_register(adev,
> > > > > -
> > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > > -                                      amdgpu_crtc->wm_low /
> > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > -               return 0;
> > > > > +       ret =3D si_write_smc_soft_register(
> > > > > +               adev,
> > > > > +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > > +               amdgpu_crtc->wm_low / amdgpu_crtc->line_time);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > > This patch changes the behavior of this function (i.e., it always
> > > > returns 0 before this patch).  Not sure if that matters or not.
> > > > I
> > > > think this could be simplified to something like the following to
> > > > retain the current behavior.
> > >
> > > Actually now that I think of it more, I think it may be entirely
> > > unnecessary to check the return value.
> > >
> > > si_upload_smc_data calls:
> > > si_write_smc_soft_register
> > > amdgpu_si_write_smc_sram_dword
> > > si_set_smc_sram_address
> > >
> > > This last one, si_set_smc_sram_address returns -EINVAL when its
> > > smc_address parameter is not dword-aligned or out of bounds.
> > > Otherwise
> > > all of the above functions return 0 (success). Considering that all
> > > of
> > > the addresses passed by si_upload_smc_data are compile time
> > > constants,
> > > we know they are correct so there is no reason why any of those
> > > functions would return an error.
> > >
> > > Looking at other callers of si_write_smc_soft_register, I see that
> > > they
> > > don't check the return value at all.
> > >
> > > So, I'd actually simplify this even more and just not check the
> > > return
> > > values. What do you think about that?
> >
> > Sure.  Works for me.
> >
> > Alex
>
> Alex, before I send a new version of this series, can you please
> clarify what these registers are and verify that the actual programming
> of these SMC registers is correct?

This code was based on what the windows code did.

>
> The reason I ask is because due the the bug being fixed by these patch,
> these registers were never actually written, which makes me wonder if
> the value we program them to is actually correct.
>
> I mean the values that we program these registers to:
>
> SI_SMC_SOFT_REGISTER_crtc_index - we just program the index of the
> first active CRTC, seems straightforward enough, but it's unclear what
> the SMC uses this for. Why does the SMC care which crtc we use?
>
> SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min - programmed to the high
> display watermark divided by the line time. But I can't find any
> information about what this information represents or what the SMC uses
> it for. Judging by the name it has to do with mclk switching?
>
> SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max - same concern as _min.

For mclk switching, the mclk has to be changed during the display
blanking period to avoid display artifacts.  This is presumably part
of that, but I don't remember exactly what all of these do anymore.

Alex

>
> Thanks,
> Timur
>
>
> >
> > >
> > >
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > index 52e732be59e36..3dd0115aa15f8 100644
> > > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > @@ -5836,17 +5836,17 @@ static int si_upload_smc_data(struct
> > > > amdgpu_device *adev)
> > > >
> > > >         if (si_write_smc_soft_register(adev,
> > > >
> > > > SI_SMC_SOFT_REGISTER_crtc_index,
> > > > -                                      amdgpu_crtc->crtc_id) !=3D
> > > > PPSMC_Result_OK)
> > > > +                                      amdgpu_crtc->crtc_id))
> > > >                 return 0;
> > > >
> > > >         if (si_write_smc_soft_register(adev,
> > > >
> > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > -                                      amdgpu_crtc->wm_high /
> > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > +                                      amdgpu_crtc->wm_high /
> > > > amdgpu_crtc->line_time))
> > > >                 return 0;
> > > >
> > > >         if (si_write_smc_soft_register(adev,
> > > >
> > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > -                                      amdgpu_crtc->wm_low /
> > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > +                                      amdgpu_crtc->wm_low /
> > > > amdgpu_crtc->line_time))
> > > >                 return 0;
> > > >
> > > >         return 0;
> > > >
> > > >
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > --
> > > > > 2.50.1
> > > > >
