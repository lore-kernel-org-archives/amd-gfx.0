Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2123ACA0FF3
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387610E0D6;
	Tue,  5 Sep 2023 14:01:37 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CAF610E0D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:01:35 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1cca7cf6e01so1415353fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693922495; x=1694527295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWd4tGZLXnz3gdszoBFqA1zaJufxE7FltFDY17vas6E=;
 b=GkkoSsdl86l/7vzArPAMdZ0WSHiy00uj1CwgKL1UbKIyGHDynFy3MzEM9WFgUKNcjb
 Tw8/fjG6NvqeuKY2gKeA0yJZV8rmLa1GKWYIj0gYofvAumxzUjpbbAYeTVApokuDjCfi
 t0hM0cc8StNJrGWJSMA4VMePlclc/t4nMCsIAYLjBLvQdD2vZG2/YpkB34HUrjQ+NlNG
 zX7uBKMtTwz2a0362GDBUcNkQ6wH4prRPn42Z4N0phOqwwB2H62vXWOrAALKGQNIvzEG
 UMvjKhyl2w+iUI7rPHcjpHBJJHhpNIu5BQiy3ku9wpUYRkJQeQwQbbIaQ92gjbcLpg4x
 e6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693922495; x=1694527295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWd4tGZLXnz3gdszoBFqA1zaJufxE7FltFDY17vas6E=;
 b=bV6NQhkVHzUTYeR9L0qO1DV6RnhVvFmgO10TecE+byt0yK6j6ncZRXBsglEkJPlnKR
 ZdPb7Q03R0ZC/sFrEn6DZpdS0GJEZhZfITA19mwLQsv8j4Bl2emVWYdMn0PqvhZBOr3k
 V9hkN+4jQAUjqNNoek1H/8wc/BDBxWI5xANxO7jz8opnT/hk2e/K79hYyBdFqZgyVviV
 jJAg4tV9XCEE2xCXiii52a0+1VgyxWIV5pvaKb87QWxbtDk+9uMe8DBwBJzA9v36VP5f
 T97mm84VV67MtyJWki6Frk9C8bLv3deVCVlmKvK5t2BSNjLAVC0Xg56tzYMmomqLAuQq
 fHJg==
X-Gm-Message-State: AOJu0YwAeEZyQpRJmWdOHOXcWNr6HacjU424bNZXCOiy9+2ipT0vtReh
 Ukhq/Trhkm2cON+GhAdLSfMtgzFX/JXJnAWUBYGrYPvy
X-Google-Smtp-Source: AGHT+IGOVhzrNc7Dl0VD24pE8Oi82Ubf5T0H72jpq0EfzQpTsHU0EQI3VHFwXy+r4HVZR+0XnLkir7qfkZjobLeEL2c=
X-Received: by 2002:a05:6870:b28a:b0:1d0:f5bd:6e9 with SMTP id
 c10-20020a056870b28a00b001d0f5bd06e9mr14046602oao.22.1693922494447; Tue, 05
 Sep 2023 07:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230830055648.477908-1-evan.quan@amd.com>
 <CADnq5_MT5bNB2oYDKArk1K5FOW8e4=+6gxPzaWjoGi5=aep6xQ@mail.gmail.com>
 <CADnq5_O7bv1E7UE0ShoTcTmw2Nir7s+NszPCFo0NhL1_X7Y-2g@mail.gmail.com>
 <DM6PR12MB2619A62E560384E195C286A8E4E9A@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619A62E560384E195C286A8E4E9A@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 10:01:23 -0400
Message-ID: <CADnq5_P_8Lhncsuaet6N9FRZ++rdeM+mmMduyv=xrqSo7LeDcQ@mail.gmail.com>
Subject: Re: [V3 0/7] A new set of Linux OD interfaces
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Sep 3, 2023 at 9:23=E2=80=AFPM Quan, Evan <Evan.Quan@amd.com> wrote=
:
>
> [AMD Official Use Only - General]
>
> Actually, with my original design, there indeed came with an 'r' option s=
upport.
> But I found that brings some confusion. Since per current 'r' option desi=
gn, it will
> reset all attributes back to original states. Thus I dropped it.
>
> If to support 'r' option per attribute, some redesigns to current logics =
will be needed
> to support both legacy and the new OD interfaces. That will need some ext=
ra efforts.
> Maybe we can put that on our TODO list?

Wouldn't it just reset the values of the attributes to the initial
value?  E.g., for the curve, it would be useful to have a way to set
the curve back to the initial settings after messing with it.

Alex

>
> Evan
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, September 1, 2023 1:26 AM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [V3 0/7] A new set of Linux OD interfaces
> >
> > For consistency with the other OD interface, we'd probably want an "r"
> > option to reset each attribute to the default state again.
> >
> > Alex
> >
> > On Wed, Aug 30, 2023 at 9:33=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com>
> > wrote:
> > >
> > > Series is:
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > On Wed, Aug 30, 2023 at 2:35=E2=80=AFAM Evan Quan <evan.quan@amd.com>
> > wrote:
> > > >
> > > > The existing OD interface `pp_od_clk_voltage` is unable to meet the
> > > > growing demands for more OD functionalities. Since the buf used
> > > > within it comes with size limit as one page. With more OD
> > > > functionalities added, we will hit that limit soon.
> > > >
> > > > To better meet the growing demainds, a new set of OD interfaces are
> > designed.
> > > > With this new design, there will be multiple interfaces exposed wit=
h
> > > > each representing a single OD functionality. And all those
> > > > interfaces will be arranged in a tree liked hierarchy as below.
> > > > Meanwhile all functionalities for the same component will be arrang=
ed
> > under the same directory.
> > > >
> > > > gpu_od/
> > > > =E2=94=9C=E2=94=80=E2=94=80 fan_ctrl
> > > > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_limit_rpm_threshol=
d
> > > > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_target_rpm_thresho=
ld
> > > > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_curve
> > > > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_minimum_pwm
> > > > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_target_temperature
> > > >
> > > > Evan Quan (7):
> > > >   drm/amd/pm: introduce a new set of OD interfaces
> > > >   drm/amdgpu: revise the device initialization sequences
> > > >   drm/amd/pm: add fan temperature/pwm curve OD setting support for
> > SMU13
> > > >   drm/amd/pm: add fan acoustic limit OD setting support for SMU13
> > > >   drm/amd/pm: add fan acoustic target OD setting support for SMU13
> > > >   drm/amd/pm: add fan target temperature OD setting support for SMU=
13
> > > >   drm/amd/pm: add fan minimum pwm OD setting support for SMU13
> > > >
> > > >  Documentation/gpu/amdgpu/thermal.rst          |  30 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
> > > >  .../gpu/drm/amd/include/kgd_pp_interface.h    |  12 +-
> > > >  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 730
> > +++++++++++++++++-
> > > >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  14 +
> > > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +
> > > >  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +
> > > >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 298 ++++++-
> > > > .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 298 ++++++-
> > > >  9 files changed, 1411 insertions(+), 25 deletions(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
