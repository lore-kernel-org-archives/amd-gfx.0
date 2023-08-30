Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9F8C83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 13:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD4710E143;
	Wed, 30 Aug 2023 13:33:47 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A276A10E14F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 13:33:44 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5738cb00eebso1869795eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693402424; x=1694007224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cih7WnEox5a2genur+QDRpNJ+v1XhybMiYkfqnblb/Y=;
 b=P2iRyJUqjfvg59+KjjTZ29FNKiQMLMvbtFF2dFS2062UqpyiE7ROBqCTWpsBYYVu+1
 BXs2Ll5ZWVo+pxYCx+XA2askuPb5c9igR3J8pvRcrQceoPv3jXeGDjMFR9qkzRqMXIjK
 F/8oXM8xyb4q0eUcCoAcbCd9FN7H2IVxo/uQGDFyyAwQHfUAFhipe1HIUUtr+r8u1NjJ
 p+MGEsUgIksdCX43diAopErx8FAL5oF4G6knfcpoNnHw0yPcQXe7mqijdzam3uNQH72Y
 Pdutygw8keX1U/Ae+iiX3AJCqWQ1AYeWgsyeHJXiZND5DzC78e7a9buqv1gDTTOlLHKs
 5Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402424; x=1694007224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cih7WnEox5a2genur+QDRpNJ+v1XhybMiYkfqnblb/Y=;
 b=WfelHHG9glLc0KeQmsLtCFHIrNOaAd64jgG3FbMwgWHkT13c7jDPCipYp0n1f7Onrq
 lqlxXwEPu+8OXsqBKHakE/RFtl8Wg1yYQytHPr6cb5m1mEWDM0W6Md7BwsZnHpswJMlI
 VRc3ocjWSyJJHf3AoaYKwqXNCZgkuYQ20Vw/9bD90f1E5fApWCJuL2wJhTtWXAaqrJJL
 jxm5JBqjZWpXEp5+zJviPgApEatvdHf+Ji5GwgdmmNLlMzW/BdLhhAbiafG4rDsBMDyu
 0SV1QBPdSFW02HDDsvkjRiYSmmBbdgicc89M4zbgLEhWeIRbxAibraBptRgwSbL1PwcQ
 eQDA==
X-Gm-Message-State: AOJu0YyCUtGL4TwkauFNN8d8N4HDrX429vorXXCS/EoWEz/kwEgQKrIr
 F4/gp5WrgTrStLO7Zrea+jgKvsiJxaOJ1WyBiNI=
X-Google-Smtp-Source: AGHT+IEMy9U3eW391QtbPlJ5kWohhvRFUyoeSn53mFPSHa234dzjk3MsFs5JVgSV8KKdJDQWVW5LT3ZIBLUUmcvcryI=
X-Received: by 2002:a4a:3416:0:b0:571:aceb:26ce with SMTP id
 b22-20020a4a3416000000b00571aceb26cemr2308092ooa.1.1693402423694; Wed, 30 Aug
 2023 06:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830055648.477908-1-evan.quan@amd.com>
In-Reply-To: <20230830055648.477908-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Aug 2023 09:33:31 -0400
Message-ID: <CADnq5_MT5bNB2oYDKArk1K5FOW8e4=+6gxPzaWjoGi5=aep6xQ@mail.gmail.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Aug 30, 2023 at 2:35=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
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
>
> gpu_od/
> =E2=94=9C=E2=94=80=E2=94=80 fan_ctrl
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_limit_rpm_threshold
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 acoustic_target_rpm_threshold
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_curve
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_minimum_pwm
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 fan_target_temperature
>
> Evan Quan (7):
>   drm/amd/pm: introduce a new set of OD interfaces
>   drm/amdgpu: revise the device initialization sequences
>   drm/amd/pm: add fan temperature/pwm curve OD setting support for SMU13
>   drm/amd/pm: add fan acoustic limit OD setting support for SMU13
>   drm/amd/pm: add fan acoustic target OD setting support for SMU13
>   drm/amd/pm: add fan target temperature OD setting support for SMU13
>   drm/amd/pm: add fan minimum pwm OD setting support for SMU13
>
>  Documentation/gpu/amdgpu/thermal.rst          |  30 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  12 +-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 730 +++++++++++++++++-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  14 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 298 ++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 298 ++++++-
>  9 files changed, 1411 insertions(+), 25 deletions(-)
>
> --
> 2.34.1
>
