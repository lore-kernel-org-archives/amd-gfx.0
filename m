Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B3EC83F38
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 17:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BB910E6B1;
	Thu, 31 Aug 2023 17:26:28 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C6610E196
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 17:26:26 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a9ee3c7dbbso647521b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693502786; x=1694107586; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sto47lb/dm6eC/8vL0FJ7x9IfZSjTr6idSvahjTV66U=;
 b=Bh8edhS60JsKl8bhD4cRng9SgHy9db8QcoXB/ZtfdEYMtM2vlWUe119i5nuD9s3CrA
 0cjRW6s9jlRsu6qEodVM6GK/WobOXrcuB44HLgMvjr0Yux93ssRx2PcFexux4UgeScyP
 Yo5nyMD6Fw7l2wX/fEgPF8fNzXj8ppbgjPW/4SrmHAiTYLTn3xTHRF5s0gJ7WOlvOhw6
 0d04HN5YLDwb1JBdKJ6FQGLgmogkbBywY+3vnRuFTYXqgdT/5FnPJLIXaF//6nHc4EHO
 URI9dtk1zPXZsuQpTjRsy20g22NLTEa1jBx6gCXSx95BLvvvnzw7lmoRXMHhdsn1zaSG
 rpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693502786; x=1694107586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sto47lb/dm6eC/8vL0FJ7x9IfZSjTr6idSvahjTV66U=;
 b=aXdz2GNXkdKniRz05izaQI6B2f60xbQK64WtmVMVb10n0MEUfqBAcAR53wJdJ/uN+I
 pG+b/8d3rkICfRcIKZu8O5jX6603Z52apz7nt1nDN7eWK019//dmoQlyFf+X/oacLbns
 bHJ9P4Q2XAgW39s4J+Wo8LUf9f17NsWZpfa0v8+HaQgqVIGb5mgHQfUl0LBcfd3ohSIN
 IyaOY7+mSjqAGKWe/kajZ52cE3ZL2dqHKEUU3sKPwlT9T9InzOWUnV+ipIjcgQ+F2J8h
 lNUwOZUMCUjQ4z8v+A3y4W9Io5B4s0mrAwuQDLNARDAhJDS291cTQmRe5qKiORdmUo0K
 alRQ==
X-Gm-Message-State: AOJu0Yxf9b1HXapgxrS6lWp2JVrLhPZa4OuCWyHsiah3KWGNSLXqXqqg
 VGdOoFsIa2KahV8JOJPLDpFnmIVH5bBOlz2NKcwCynEz
X-Google-Smtp-Source: AGHT+IGCpRvw/sZyc5zfL0B4MYhN77nu/VLSC5OwN9nOHzRT9UNCvh8+hPWlxgB9gjuDTG/8LEjyUrCAFXgl9Jg5NGs=
X-Received: by 2002:a54:4485:0:b0:3a7:9837:7148 with SMTP id
 v5-20020a544485000000b003a798377148mr138711oiv.58.1693502785759; Thu, 31 Aug
 2023 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830055648.477908-1-evan.quan@amd.com>
 <CADnq5_MT5bNB2oYDKArk1K5FOW8e4=+6gxPzaWjoGi5=aep6xQ@mail.gmail.com>
In-Reply-To: <CADnq5_MT5bNB2oYDKArk1K5FOW8e4=+6gxPzaWjoGi5=aep6xQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Aug 2023 13:26:14 -0400
Message-ID: <CADnq5_O7bv1E7UE0ShoTcTmw2Nir7s+NszPCFo0NhL1_X7Y-2g@mail.gmail.com>
Subject: Re: [V3 0/7] A new set of Linux OD interfaces
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For consistency with the other OD interface, we'd probably want an "r"
option to reset each attribute to the default state again.

Alex

On Wed, Aug 30, 2023 at 9:33=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Wed, Aug 30, 2023 at 2:35=E2=80=AFAM Evan Quan <evan.quan@amd.com> wro=
te:
> >
> > The existing OD interface `pp_od_clk_voltage` is unable to meet the gro=
wing
> > demands for more OD functionalities. Since the buf used within it comes=
 with
> > size limit as one page. With more OD functionalities added, we will hit=
 that
> > limit soon.
> >
> > To better meet the growing demainds, a new set of OD interfaces are des=
igned.
> > With this new design, there will be multiple interfaces exposed with ea=
ch
> > representing a single OD functionality. And all those interfaces will b=
e
> > arranged in a tree liked hierarchy as below. Meanwhile all functionalit=
ies
> > for the same component will be arranged under the same directory.
> >
> > gpu_od/
> > =E2=94=9C=E2=94=80=E2=94=80 fan_ctrl
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_limit_rpm_threshold
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_target_rpm_threshold
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_curve
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_minimum_pwm
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_target_temperature
> >
> > Evan Quan (7):
> >   drm/amd/pm: introduce a new set of OD interfaces
> >   drm/amdgpu: revise the device initialization sequences
> >   drm/amd/pm: add fan temperature/pwm curve OD setting support for SMU1=
3
> >   drm/amd/pm: add fan acoustic limit OD setting support for SMU13
> >   drm/amd/pm: add fan acoustic target OD setting support for SMU13
> >   drm/amd/pm: add fan target temperature OD setting support for SMU13
> >   drm/amd/pm: add fan minimum pwm OD setting support for SMU13
> >
> >  Documentation/gpu/amdgpu/thermal.rst          |  30 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    |  12 +-
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 730 +++++++++++++++++-
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  14 +
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +
> >  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 298 ++++++-
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 298 ++++++-
> >  9 files changed, 1411 insertions(+), 25 deletions(-)
> >
> > --
> > 2.34.1
> >
