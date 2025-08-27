Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D1CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D07910E166;
	Wed, 27 Aug 2025 16:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WIJ8o6xM";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F06410E166
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 16:37:43 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-771f4374fc0so6898b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756312663; x=1756917463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0swVn0LHq3lHSNX5BlNgU0WACOboAWE824P2dLB+s8=;
 b=WIJ8o6xMSf5M8pEHIbfHR5ah8BqO9awvbnSDwyOABKxINxdxU2MGQKK1+Hhd2yXl7I
 sKYFPLxgUj/u81zGjl/SjuQyZjPxsbaqEI9jSDpzxPIiPhGvvVzQ2syMmFK4O4kz29EO
 HFP8kyvTiLvCNpXaHI/pkOqstSPp7arGNz1ZluI33D3XSqewmWPPpAKUvuzPtV+Yeeg5
 g6cx/lbOSB9+tZflxNs8gcemXa1xKRM7ngBS08Vubc9hJQ2uJDio31W6uInxWlsMVqM7
 q58VnsxIg3WPkt5eiBVChhX8Z8zTrPCYcmoKKULUHxjpZGQSTOL6ChNcHdaWxYaDjYAN
 XImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312663; x=1756917463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0swVn0LHq3lHSNX5BlNgU0WACOboAWE824P2dLB+s8=;
 b=Gjc6c+FslbmaNCzpzqkOO8UKNsGdGpZKd4yfQHRUHmkMWpGHvZKDYurJcsECfw5xZs
 rDE+jcysidUoPdh/hOjnVJY9qo1Jm2s3Jvn7uOAF4sqoS0+76XRplcUFSg2BqcdpX5kx
 WduMcuDyd8D40F7sYl628jfApgY0rpKZXY7dZUWD4ZwtgilZAObjfSRIkoj7JhPqGK9v
 5Sq2Yw7YbnHB+dZNPTN4SGflXh0t73R9YDBJ6mq41B8rcCourbXokUQquoGACFnImNiV
 9IEvYfJUZizBe2riCcEUL/crMvrFOc0DAKoGaobBjJfB6CFH4pYsI/JmF0GLaGsFhYsN
 kxkQ==
X-Gm-Message-State: AOJu0Yyx7YPdXiZhZffurM2JFmdoLnDlRujzyfAjB7moqJchLg7Qsunz
 ntCkXCk5SGLL/E4eKCWhMdrgWcTgHwaqyAzVM1DfeIe9FS/sFrymgavR/61G9b1A6o8DFHRap5R
 6ucxRfOrM7bprAL+QtNjQRN/60j6O1QQ=
X-Gm-Gg: ASbGncvg3KQQB0PcUuhzasjfYgW69pIGJZ7x9zgTjbZxeGc4kappljqb6wbWm9eAeK5
 Q+qHope6Skm86gFjCfsIw/uxl2VljK2mG4unDCrp6ILgLW5cEVG4d9w/SqCxGR8c4VYbLN/TBth
 vqXM8lA+o10IdoaGTBU1jvwS6NlGFSNEdZKKcBEXUno+IjeOIOymQSMiyGMI1LQ6JX6wgUjBNlw
 DjMUds=
X-Google-Smtp-Source: AGHT+IE77WFV2071LTavBYfg3ObFdNNv893LQZ35jqbjjxNjVlwlsaNq9w0QBoDqfB7BmsQGrH3JJls5N04SJtKnRWI=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr96969645ad.4.1756312663039; Wed, 27 Aug 2025
 09:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250825214635.621539-1-timur.kristof@gmail.com>
 <20250825214635.621539-6-timur.kristof@gmail.com>
 <CADnq5_NtWdn_v4JLHuzDGDE2NQn3jJZ+GNP1_dg2QMW2dUuBYA@mail.gmail.com>
 <135f672a9dd0d9257f1c3476d5f0254acf493296.camel@gmail.com>
In-Reply-To: <135f672a9dd0d9257f1c3476d5f0254acf493296.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 12:37:29 -0400
X-Gm-Features: Ac12FXwuXGvQBVX9O1HdJaXT9F_-wUC96Eqw12BSjrqFY8MEL_aaxd0-QjCnxYw
Message-ID: <CADnq5_MFfkOuLU6LuY_Hm296_Ctypf9ZmdcdebYreckJSvKpiA@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amd/pm: Treat zero vblank time as too short in
 si_dpm (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, alex.hung@amd.com
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

On Wed, Aug 27, 2025 at 10:27=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Tue, 2025-08-26 at 16:05 -0400, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 5:46=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > Some parts of the code base expect that MCLK switching is turned
> > > off when the vblank time is set to zero.
> > >
> > > According to pp_pm_compute_clocks the non-DC code has issues
> > > with MCLK switching with refresh rates over 120 Hz.
> > >
> > > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > index db46fc0817a7..1e2aeea0b552 100644
> > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > @@ -3082,8 +3082,8 @@ static bool si_dpm_vblank_too_short(void
> > > *handle)
> > >  {
> > >         struct amdgpu_device *adev =3D (struct amdgpu_device
> > > *)handle;
> > >         u32 vblank_time =3D amdgpu_dpm_get_vblank_time(adev);
> > > -       /* we never hit the non-gddr5 limit so disable it */
> > > -       u32 switch_limit =3D adev->gmc.vram_type =3D=3D
> > > AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
> > > +       /* we never hit the non-gddr5 limit so disable it (but
> > > treat 0 as too short) */
> > > +       u32 switch_limit =3D adev->gmc.vram_type =3D=3D
> > > AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 1;
> >
> > Took me a while to wrap my head around this.  It might be clearer to
> > just return early if the vblank_time is 0.
>
> Sure, I can do that if you think that makes it easier to read.
>
> > That said, if there are no
> > displays attached there is no reason to not enable mclk switching.
> >
>
> The function is only called when there are displays attached.
> Should I mention that in a comment?
>

Sure that sounds good.  Thanks!

Alex

> >
> > >
> > >         if (vblank_time < switch_limit)
> > >                 return true;
> > > --
> > > 2.50.1
> > >
