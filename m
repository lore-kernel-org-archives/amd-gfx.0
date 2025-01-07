Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1893E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7569110E6FC;
	Tue,  7 Jan 2025 15:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNn32Omh";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A743810E6FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:05:01 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-467b07d3ea4so18522271cf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736262241; x=1736867041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVVjNAO+2YssZv5Op2EjPUMV9GJ+24RWMzvwpya8GRk=;
 b=kNn32OmhpZQts5yng1lanFqiDTatPrUXz76zP1fChnV4v/B03QAJW+1BTH/3ptzduP
 pEu+hVb5wTCZXZaTvGTasUHXnraybKjfwsRH+Q8hUaZmvqeekgUXjQ67vsPRaVHTWEV3
 y9r8p21hzUisbrN3o7lvtXYCN0fUwFSeTUak1i0MG4gYFl2nf67eSdByvOP5dsdcJ8Ny
 k83OsOcMuG1m8A2XQ5kAkHnctSp2hDxdJBom0BEes1I6r2vuM9KFZqkUbI4A5tXgDNhO
 rNJ7dx3HJ45sserHJ3Y67aVO/n3KiCC3C+M0RpiURcV4AmwiPNvM/AUF6rDavc8VD/aF
 IePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736262241; x=1736867041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVVjNAO+2YssZv5Op2EjPUMV9GJ+24RWMzvwpya8GRk=;
 b=Z8Wyefhqp6gGM6UXQrzW2xcYBBl7tqUQULcz7lUuwl+I1s9nMsNz3L5IdBwvEtqsg+
 z6lxbOFUz1jIiUUfadZ/SeLhFPfHeWf534RbECFoet1EHyTmiVZQ5WUjF6fgNGP7QcJx
 a8H8rxdESGz/JOTkoeplkR5+Afb0R33rzcpwYciBZK1t1L591uGvTPU62eLXpRrQTr6U
 9uhNssZhgx4FcBT7YftpCwf7Bb5cokepZnkBP7U9JM3iY6iseHKuPNzLAuda5WjJf51Z
 8DuHMsZ1kSbviZlRyBlKWyCWkJai+c9ntHRJJAeSeuHIqAiFkj8Q+YeJGzuu6Cehm+We
 dDBQ==
X-Gm-Message-State: AOJu0YxNLv+rC1TEhqvxEpI5RIDz7729ahSevXpsjlNTQY2lPwRGSpp4
 iYbpxvvUOVHT23oS/LTstjOr3rIsiPvbJUjYn79Anw2ysJKxKJeTWVBCSfjV+ZYSvQw/EAuleV/
 pZNct/7HVAjLbf6Hz+Io0dRWELaRguQdh
X-Gm-Gg: ASbGncsi38ZdFTNM9hvnFkJoSMyYMXHoy0XRLbF6AiO9eFUbJBagam54zwfunZSyXED
 cx5ZPBgzfpOjFEXF43OYiFiZhbH8yPOjThJiETA==
X-Google-Smtp-Source: AGHT+IFw58NYhxTenP1Utp4IVkQsHSIgqrgFZY8i2mP4lSmrlZgXHF1I0GdnDai+XTgjw/Rc84S/X72fBMKYQK1O45U=
X-Received: by 2002:a17:90b:1345:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f452ea6538mr36077994a91.4.1736261758078; Tue, 07 Jan 2025
 06:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20241225080814.1692482-1-kenneth.feng@amd.com>
 <CADnq5_NT7mC--R=pSo62riPD05cVwzmXwKzakWWKnaU=sgduBw@mail.gmail.com>
 <DM4PR12MB5165696C5A07E1ED7845E53E8E112@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165696C5A07E1ED7845E53E8E112@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jan 2025 09:55:45 -0500
Message-ID: <CADnq5_Nig1rO-ihVKDxXqc1FQyLFfGPwnGh9mQCf0S8qWf-E5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
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

On Mon, Jan 6, 2025 at 10:56=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, January 6, 2025 11:59 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Pillai, Aurabindo <Aurabindo.Pillai@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: add the interface to set and save th=
e bootup workload type
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Wed, Dec 25, 2024 at 3:08=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.co=
m> wrote:
> >
> > add the interface to set and save the bootup workload type
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 27 +++++++++++++++++++
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
> >  4 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index 6a9e26905edf..92fa19cac32a 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -349,6 +349,33 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_=
device *adev,
> >         return ret;
> >  }
> >
> > +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device =
*adev,
> > +                                               bool en) {
> > +       struct smu_context *smu =3D (struct
> > +smu_context*)(adev->powerplay.pp_handle);
>
> You need to check if is_support_sw_smu() before accessing the smu context=
.
>
> > +       int current_profile_mode =3D smu->power_profile_mode;
> > +       int saved_profile_mode =3D smu->saved_power_profile_mode;
> > +       int ret =3D 0;
> > +
> > +       if (en && current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOT=
UP_DEFAULT)
> > +               return 0;
> > +
> > +       if (!en && current_profile_mode !=3D PP_SMC_POWER_PROFILE_BOOTU=
P_DEFAULT)
> > +               return 0;
> > +
> > +       if (en) {
> > +               ret =3D amdgpu_dpm_switch_power_profile(adev, current_p=
rofile_mode, !en);
> > +               smu->saved_power_profile_mode =3D current_profile_mode;
> > +               smu->power_profile_mode =3D
> > + PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>
> Should take the pm.mutex when you mess with the smu context.
> [Kenneth] - the pm.mutex is taken in the called function amdgpu_dpm_switc=
h_power_profile. Do we need it before calling amdgpu_dpm_switch_power_profi=
le?

no, wrap the smu->saved_power_profile_mode and smu->power_profile_mode
with the mutex.  E.g.,

+       if (en) {
+               ret =3D amdgpu_dpm_switch_power_profile(adev,
current_profile_mode, !en);

mutex_lock()

+               smu->saved_power_profile_mode =3D current_profile_mode;
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;

mutex_unlock()

+       } else {
+               ret =3D amdgpu_dpm_switch_power_profile(adev,
saved_profile_mode, !en);

mutex_lock()

+               smu->power_profile_mode =3D saved_profile_mode;
+               smu->saved_power_profile_mode =3D
PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;

mutex_unlock()

+       }

Alex

> Thanks.
>
> > +       } else {
> > +               ret =3D amdgpu_dpm_switch_power_profile(adev, saved_pro=
file_mode, !en);
> > +               smu->power_profile_mode =3D saved_profile_mode;
> > +               smu->saved_power_profile_mode =3D
> > + PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>
> Same here.
>
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
> >                                uint32_t pstate)  { diff --git
> > a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > index 1f5ac7e0230d..5fe404bbb033 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > @@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_d=
evice *adev,
> >                                     enum PP_SMC_POWER_PROFILE type,
> >                                     bool en);
> >
> > +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device =
*adev,
> > +                                   bool en);
> > +
> >  int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
> >
> >  int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev); diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 8ca793c222ff..a6f748361198 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_con=
text *smu)
> >                                 PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >         }
> >         smu_power_profile_mode_get(smu, smu->power_profile_mode);
> > +       smu->saved_power_profile_mode =3D smu->power_profile_mode;
> >  }
> >
> >  static int smu_sw_init(struct amdgpu_ip_block *ip_block) diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index 3630593bce61..c58fc31fb1d7 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -560,6 +560,7 @@ struct smu_context {
> >         uint32_t workload_mask;
> >         /* default/user workload preference */
> >         uint32_t power_profile_mode;
> > +       uint32_t saved_power_profile_mode;
> >         uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> >         /* backend specific custom workload settings */
> >         long *custom_profile_params;
> > --
> > 2.34.1
> >
