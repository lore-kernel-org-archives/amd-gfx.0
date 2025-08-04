Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A3C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EDB10E21C;
	Mon,  4 Aug 2025 17:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uj4R7yeh";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9773E10E21C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:45:36 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-76bf762cd52so122433b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754329536; x=1754934336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6cmI9HltlnAC8/pvSDiCU07WEWreQDzAdpIAa+/awM=;
 b=Uj4R7yeh3Q59WSpQFLUlkGe7zvwhzy4mAfSzgczc+uTs//+Cfoo+M8aPuw6PLByZez
 FxTjklrYtnEc9Nb6YMQsH7O1CVU9P6eIoYknzK5NEqICS5wzq0v/JNLaf6yxogvQiGkj
 fn/T/dm6SevIs81WY8aGQLlZiQxhlE0rmZGZJcZyfwbijXXgHCucY+NvwFtPbHrMGZU+
 bN3XMR3LxjjiWuggzkN9iPrTNby9M2gID1tmgMiAqK1Ir/oKqpApxO4CHhiQo30OioFs
 00B2dgdbj3Pp/BLmvtYdTFXANyaEhXky07idO2Ot47FjrEGjXfJTgLYMpueYNx345k8O
 8wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754329536; x=1754934336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6cmI9HltlnAC8/pvSDiCU07WEWreQDzAdpIAa+/awM=;
 b=rWJtLeunTZtjAkmbouj1A22uwqv+/QE8DePfgl213zwOxzTI+i8octd8tPtN1LLnNB
 rraEzit2a8SMlczfL6WP0PjjJPNshbhWuMw1croNwqrhhzALRF0tM59Ei6JDAVtCVWEO
 /9uj9uy6fgQMQKhASL1TwUnWx0/Od2t9oAZUZwryeoa23gpZK60JlABfjtnnhm/J5RCt
 Mf8TKP8wvkAVbjTq5VlSAD3cZD11/lJm3cQslGzi5Jnl9az9T+ZQ/VFan/q6eSDXmUer
 g1sGTmsuSWiUfwS1sjlbyn+pmWe15on9gaElJ8Cz1XpyaA5MOf/js/JxWHf4QLif90AE
 SJ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHQ10b6GyUmtpc/hK4YlwbHL5x4qS5aq731L58HLR5B+O5dmfqIjdUqEfbj1VkIYdK2K7mhrpS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKrAU52yDF0ifuXENGJ426vtduyfVf8lkxb2aTA47vgLsgIOvj
 0OMZoZAx8nslIySZZIfTCtxGS+Ocn4Y6e659j8A4qA0InEiYt4liyxp6Lr/OpQOJfO3ECcsndsK
 2RlhWLTJL8QC7i4qd/sfok8QCM4G8KstDGJb5
X-Gm-Gg: ASbGnctpk0R5ymFm8Tqji7qWTCNfXxFJcEX3Xc59r9HDBu/vNrQYuEspBXAMyVHQemE
 2ptZGr6ZL/zEeS+e1hGp+eJGZy+chWHP9fG1v1uZB6sRgUH2iLVQN7hVBb2YnRgGxEyt+5iN799
 ut8maFfNVPsOqi6y4Ny2MrxyPP11/DPuZKRaOwsv3Ldvd1myHLN8m1ao4bup1hzfNYZth4Io66i
 rZRveeT
X-Google-Smtp-Source: AGHT+IFahbczsDYmGqAHv/0z6s4cIv1mbUbuUgJpupKtNxOuPjYl2bQa7Wf5zLcAQDpr+7cIHTxNe1Cpo2KnJIXAId0=
X-Received: by 2002:a05:6a20:2591:b0:233:f84f:6097 with SMTP id
 adf61e73a8af0-23df94ebae2mr6430741637.9.1754329535933; Mon, 04 Aug 2025
 10:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
In-Reply-To: <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:45:24 -0400
X-Gm-Features: Ac12FXytrrEmRFly6mYGsrXlyEfi85dluuUljMyDWUmYr_mXywH-inVDdqamWpE
Message-ID: <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Aug 4, 2025 at 12:00=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-04 at 11:20 -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > Unlike later versions, UVD 3 has firmware validation.
> > > For this to work, the UVD should be powered up correctly.
> > >
> > > When DPM is enabled and the display clock is off,
> > > the SMU may choose a power state which doesn't power
> > > the UVD, which can result in failure to initialize UVD.
> >
> > + Christian, Leo
> >
> > That doesn't seem right to me.  IIRC, the driver always set the UVD
> > PLL directly on SI and I don't think SI supported any kind of UVD
> > power gating. I guess it's probably some sort of subtle sequencing
> > difference between radeon and amdgpu.  Unless Christian or Leo have
> > any ideas, I think the patch is probably fine.
> >
> > Alex
>
> Hi,
>
> These are my observations about how the UVD clock works on SI:
>
> 1. It seems that the SMC needs to know whether UVD is enabled or not,
> and the UVD clocks are included as part of the power states. See:
> si_convert_power_state_to_smc
> si_convert_power_level_to_smc
>
> On SI the default power state doesn't set the UVD clocks,
> and SI has a specific power state to be used with UVD. Actually
> amdgpu_dpm_enable_uvd has a special case code path for SI, where it
> sets this power state. If I print the power states from
> si_parse_power_table, it indeed confirms that there is only one power
> state that has non-zero UVD clocks, and the rest of them just have the
> UVD clocks at zero.
>
> It's unclear to me what happens if we try to enable UVD clocks when we
> selected a power state that doesn't include them (ie. when we don't
> tell the SMC that UVD is active).
>
> 2. When setting a power state that enables UVD, the UVD clock is
> enabled either before or after the engine clock by si_dpm. This is done
> so in both radeon and amdgpu, see:
> si_dpm_set_power_state
> ni_set_uvd_clock_before_set_eng_clock
> ni_set_uvd_clock_after_set_eng_clock
>
> The specific sequence in which the UVD clock is enabled by
> si_dpm_set_power_state leads me to the conclusion that
> amdgpu_asic_set_uvd_clocks should not be directly called on SI outside
> of the DPM code.
>
> Please correct me if I misunderstood the code.

Yeah, I don't remember the clock dependencies.  I thought that you
should be able to program the UVD PLLs any time you wanted and the
ordering only mattered when you were also changing the sclk.
Programming the PLLs directly works as is in radeon, but I guess maybe
we init DPM in a different order in radeon vs amdgpu.

It would also probably be a good idea to disable the UVD clocks again
after IP init to save power. E.g., something like:

       if (adev->pm.dpm_enabled)
               amdgpu_dpm_enable_uvd(adev, false);
       else
               amdgpu_asic_set_uvd_clocks(adev, 0, 0);

Alex


>
> Thanks,
> Timur
>
>
> >
> > >
> > > Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > index 5dbaebb592b3..9ad06c1e150d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct
> > > amdgpu_ip_block *ip_block)
> > >         int r;
> > >
> > >         uvd_v3_1_mc_resume(adev);
> > > +       uvd_v3_1_enable_mgcg(adev, true);
> > > +
> > > +       if (adev->pm.dpm_enabled)
> > > +               amdgpu_dpm_enable_uvd(adev, true);
> > > +       else
> > > +               amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> > >
> > >         r =3D uvd_v3_1_fw_validate(adev);
> > >         if (r) {
> > > @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct
> > > amdgpu_ip_block *ip_block)
> > >                 return r;
> > >         }
> > >
> > > -       uvd_v3_1_enable_mgcg(adev, true);
> > > -       amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> > > -
> > >         uvd_v3_1_start(adev);
> > >
> > >         r =3D amdgpu_ring_test_helper(ring);
> > > --
> > > 2.50.1
> > >
