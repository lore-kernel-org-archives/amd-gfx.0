Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A952EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E89F10E2AD;
	Mon, 21 Aug 2023 20:48:38 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D831610E2AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:48:35 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a1ebb85f99so2809910b6e.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692650915; x=1693255715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wo4HfdtlE0Jo/9ZwAzlD4CQ3JmMNM+MXBudZkyRG7ms=;
 b=BgoCcdHNEIIHKLblETW4YrwDL2ohKMIqRg9UO+klMODH6dCOALjIvV6zSuGKm62CT4
 VCIL3344CW7N6xsCAOUZ2CzJzfuaICoMKBf5bn5Ok/rK74ivY4YlvoUk5wJ04kYlaR5I
 clbK18njWr98Sj/E2T6zpXzehiijKrIV09I8bbkXqsREGW+8MvtJnBNmPqNSMNhKxeif
 TySfzpitgvTr87ENOkJdqoWLqBriIn8FtdwCcllUmWjsiXwjORP61vuM5I/rYlC6Fq6K
 HVtcizbNzJ0zB2fPHaS+etFJVKh9aUiSFD/7zgcWnVamyf79/vsG4FUiSrq2Va6iWzl9
 Rnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692650915; x=1693255715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wo4HfdtlE0Jo/9ZwAzlD4CQ3JmMNM+MXBudZkyRG7ms=;
 b=YQ6QFWxcSpycEhptSHRrKSRgOC1LBV6A2GW8ah1Mh4AYbUjK0QIcZOtjCXUXIz1MbU
 FHOIJ0JjuNeAQmZ6a6hEprM88gT5biwtJK5hpm4jQeoF8VSDuAqN7c0U7eRowq0cqYsw
 bhK/ENTT/feM1O8vxycrc+arTFMujs4pJh1oigJcblZQnclUjGxywyitlN50uhdUkDzG
 28nyWzaiihUWO020Js5pIGlQihDoTC/AOOIe7ppUBrrZQo1jr3/ABSgehhcjYaRuEAg/
 vQyFMSw9qyGHExIZkIo+P26bJ3bwDk6jmmO7CBzPuoBiwgx6bP6wk/AByLxckMW4o3gD
 sMZQ==
X-Gm-Message-State: AOJu0YyYnd0icB+Bt4U5TLtOcuXYyfb3Et7gWO2df/PlXTy6eymLHI+s
 hoEXgy5XjEJJGmO2wtk+5nncDpfOalJgznOrl0Q=
X-Google-Smtp-Source: AGHT+IFcbEzxqjDa0iVSmZFyrHCE0C7Nl5BXO4nk31SZ2d2LtB5zdGatG10MQoi76KlQePI3E2ZVvibqO9r/8OFDZsk=
X-Received: by 2002:a05:6808:2a6c:b0:3a1:e7fb:76fc with SMTP id
 fu12-20020a0568082a6c00b003a1e7fb76fcmr8587536oib.17.1692650914858; Mon, 21
 Aug 2023 13:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230815084231.3229009-1-evan.quan@amd.com>
In-Reply-To: <20230815084231.3229009-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Aug 2023 16:48:23 -0400
Message-ID: <CADnq5_O5jaHFOjrjBO3XUd=9YiRrrU-er1YziwV08BZJsjE5SQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] A new set of Linux OD interfaces
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

On Tue, Aug 15, 2023 at 4:50=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> The existing OD interface `pp_od_clk_voltage` is unable to meet the growi=
ng
> demands for more OD functionalities. Since the buf used within it comes w=
ith
> size limit as one page. With more OD functionalities added, we will hit t=
hat
> limit soon.
>
> To better meet the growing demainds, a new set of OD interfaces are desig=
ned.
> With this new design, there will be multiple interfaces exposed with each
> representing a single OD functionality. And all those interfaces will be
> arranged in a tree liked hierarchy as below. Meanwhile all functionalitie=
s
> for the same component will be arranged under the same directory.

Patches look good to me, but please add kerneldoc for this to
amdgpu_pm.c and make sure it gets picked up in
Documentation/gpu/amdgpu/thermal.rst.

Alex

>
> gpu_od/
> =E2=94=9C=E2=94=80=E2=94=80 fan_ctrl
>     =E2=94=9C=E2=94=80=E2=94=80 acoustic_limit_rpm_threshold
>     =E2=94=9C=E2=94=80=E2=94=80 acoustic_target_rpm_threshold
>     =E2=94=9C=E2=94=80=E2=94=80 fan_curve
>     =E2=94=9C=E2=94=80=E2=94=80 fan_minimum_pwm
>     =E2=94=9C=E2=94=80=E2=94=80 fan_mode
>     =E2=94=9C=E2=94=80=E2=94=80 fan_target_temperature
> ...
> ...(more to be added)
>
>
> Evan Quan (8):
>   drm/amd/pm: introduce a new set of OD interfaces
>   drm/amdgpu: revise the device initialization sequences
>   drm/amd/pm: add fan mode OD setting support for SMU13
>   drm/amd/pm: add fan temperature/pwm curve OD setting support for SMU13
>   drm/amd/pm: add fan acoustic limit OD setting support for SMU13
>   drm/amd/pm: add fan acoustic target OD setting support for SMU13
>   drm/amd/pm: add fan target temperature OD setting support for SMU13
>   drm/amd/pm: add fan minimum pwm OD setting support for SMU13
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  14 +-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 676 +++++++++++++++++-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  16 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  12 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   6 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 316 +++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 316 +++++++-
>  8 files changed, 1370 insertions(+), 25 deletions(-)
>
> --
> 2.34.1
>
