Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AE1CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 14:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BA810E0AE;
	Wed, 27 Aug 2025 14:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OEeblBT7";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCAC10E0AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 14:27:30 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso36722855e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756304849; x=1756909649; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7p3kghDIaij79/GJuphsUQYxLfTwYbknOwCSrsy9w6g=;
 b=OEeblBT7HLaWO4nx7qJ1YyN40tzlR+6pvMmJDpbpHEkO/jNRggkhtw7tVMFPQzX11l
 yTGM/xSkRovElLbA5n00ik3pHWNQgaF3sDfBMyPi6uucaavwlTdpma7bXt6LS0ehlUgW
 IXhc8C+TsepDw5BZfEP+uBUmG7ggaazhhmv0s6aaduKMeFkr8jawnAwmskHyYpMR1Euq
 cvbYJoz95b99Pv7xxiZESByQWcOvBMyCH+HVvIXnLulA+TECcz4Qxg7RthNJ0TfonKZq
 HUDGPYOGd+qDGNuImewJNgPer6WVkK+wtliHMqcAqyc9NAUfldxX4E0qrZLgueXimg7t
 stAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756304849; x=1756909649;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7p3kghDIaij79/GJuphsUQYxLfTwYbknOwCSrsy9w6g=;
 b=uzV60FtRtV/LrJpN2FQ4Bule6XWzgvzSiIGloQLbPThFKyAlzGmEehGLWkZ9maX7Qj
 5vFeNJcSvK4GzhyrljoN7UdEcOhQXDxRDkJYrJZzevZ3bn9FH0z/trTacqWptyeOWhsy
 IqToxBYP4UUq+05ojAfKUSn3vL9qZcsd/agTTTy6BVzytcT6ncS6Ujtg4p3rhVmNcJ8a
 vpihRLfXgzRcLX4RPfqxeUBbyBpdhQxywAJYwqc744kgb4/rWaB9e7W9sZPWcAiXKNh1
 9taYU5CXRKgtDnJFswTemDdbJ6fB/fk2+fXr+XGT2HMpGK0ouri79CfS6RjAy2fNxBYg
 uy6w==
X-Gm-Message-State: AOJu0Yzpd1jWr1YEKEDoBj/yPxTXpiWBWMvtanZlcE/QWJqvAj1lT2RQ
 OEdlrdNP9XXOhgphJVJLrZux6NpyRPdN2ZvIV2/jHjk8/aN4MqOSwYTV
X-Gm-Gg: ASbGnctn0znmi3JBdkPHJCq4izDTt8/QdYFiSPkCRr7M7oz3J6lfGt86lLfjbyKQKuE
 M+pstxqb8/qRaH+aK7PLM5uD0TmERsH1raLtciAZBZJsnPJJIn6vt8j+Pe4scuQEEhcBoP3aREQ
 ly/+n9LTl94z1UdzZbVO6zwNdMev9w/poIF6eEqbP1DE+Ds6nRSXsfkyT3hOfo5IeM1hgicPPDh
 UFtDOPcdTZ8X5CNkfep9dMDNuC6vHNRg+teTlrwRyX3HMZkJHjRwJ6sEcnkMAgm0T37aoOiAy2R
 taEE0T1S8oKboUyDVEHsoX7dLA+jBRnS8Cj9Zwq8iBuCC249keT+hxo/BmR4Ks+SW4t4bzfXgUm
 1nkPvIR4DaQNjxT1TT9ugAZfdmqbdfZEP1bZyIXF6moBkDYmzMsiqNZHeFVgwdGy+AsUPGAE517
 cJJZICQhQgq8aWOEIQiTvTvBXTQasQNiFWHYxrFhULY5nTUBIG+IagFAI8iEL0nA==
X-Google-Smtp-Source: AGHT+IGSRLloB2yiSUP8fUnr+w87yhthtMVTU/94C+AQVJwXTIdwmYwVHwYuWmY2m2wGCjtPTtPZkw==
X-Received: by 2002:a05:600c:4451:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45b517cba3bmr168902615e9.35.1756304848987; 
 Wed, 27 Aug 2025 07:27:28 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:f46e:206e:80c6:1890?
 (20014C4E24E36900F46E206E80C61890.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:f46e:206e:80c6:1890])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cc7b699d5dsm3679586f8f.48.2025.08.27.07.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:27:28 -0700 (PDT)
Message-ID: <135f672a9dd0d9257f1c3476d5f0254acf493296.camel@gmail.com>
Subject: Re: [PATCH 5/8] drm/amd/pm: Treat zero vblank time as too short in
 si_dpm (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, alex.hung@amd.com
Date: Wed, 27 Aug 2025 16:27:27 +0200
In-Reply-To: <CADnq5_NtWdn_v4JLHuzDGDE2NQn3jJZ+GNP1_dg2QMW2dUuBYA@mail.gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
 <20250825214635.621539-6-timur.kristof@gmail.com>
 <CADnq5_NtWdn_v4JLHuzDGDE2NQn3jJZ+GNP1_dg2QMW2dUuBYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-08-26 at 16:05 -0400, Alex Deucher wrote:
> On Mon, Aug 25, 2025 at 5:46=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Some parts of the code base expect that MCLK switching is turned
> > off when the vblank time is set to zero.
> >=20
> > According to pp_pm_compute_clocks the non-DC code has issues
> > with MCLK switching with refresh rates over 120 Hz.
> >=20
> > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index db46fc0817a7..1e2aeea0b552 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -3082,8 +3082,8 @@ static bool si_dpm_vblank_too_short(void
> > *handle)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =
=3D (struct amdgpu_device
> > *)handle;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 vblank_time =3D amdgpu_d=
pm_get_vblank_time(adev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we never hit the non-gddr5 lim=
it so disable it */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 switch_limit =3D adev->gmc.vr=
am_type =3D=3D
> > AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we never hit the non-gddr5 lim=
it so disable it (but
> > treat 0 as too short) */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 switch_limit =3D adev->gmc.vr=
am_type =3D=3D
> > AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 1;
>=20
> Took me a while to wrap my head around this.=C2=A0 It might be clearer to
> just return early if the vblank_time is 0.=C2=A0

Sure, I can do that if you think that makes it easier to read.

> That said, if there are no
> displays attached there is no reason to not enable mclk switching.
>=20

The function is only called when there are displays attached.
Should I mention that in a comment?

>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vblank_time < switch_lim=
it)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return true;
> > --
> > 2.50.1
> >=20
