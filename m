Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352FECD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06A010E4E8;
	Mon, 15 Jun 2026 15:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bA0+khJv";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F368110E4EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:13:10 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-59ebdb94079so127527e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536390; cv=none;
 d=google.com; s=arc-20240605;
 b=kMFOpkK5I3yuvY7saJLtfoVcFmWEMR7dWTbT+SWeCGnIjaLGGVdabN9znOAXT3SVXz
 MU2cVwoZgpzD76zxD8XiRSqH4VcoeBboXd76nvzc4W9RdIj7zGsvIVsw4IZN0KzmYAVc
 D4wIAjgqLXuEnl+gUIrc+68AfMTACQPWq1ZChtUMnYVtsR3clB/42CsBohKB5fY9d+es
 hkDHZUr+ZdM/aQ7tjUbjXGppafGfzMdsFMgnPpLFWyVBKM/DaptmNWU4zSjJBFnSw+GF
 UlPZHpEqx6UNEmB6RYpI1rirDIWGouhQ1cVw03fPZ3AhjKgXc13nMhLu/zawk29lQwZC
 CBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 fh=pRxhAjaiuMGmgDurq3AWLR5cAfgPIl/X+zh8R4ERIzk=;
 b=UED/aoK5LJaRNdqIc51ZL3nVuBmLthcWTdU8XqidiJXa/6q8NCbDv7J4NyxBBRamsD
 ZnwAWeFyfL7gsJtQa+RGPoz6myqT5sNO4/62ZxjTXMYf5vGHv1Kn2vlhvbRKce7M0Poi
 YEDQ8fzswtHR564A16PhGQx54h9AvE5wRJJkXqHl/qKUXaLUOx9zNle/GWLt+op+iHHY
 cW/rtvWIEoAZsohFkc+E0a86OibCxXmkO2bPwe8z7p/LIkjpZzn0nRS0ntEyemMevZOm
 RIoceK9TY4PpRSLHRI7SjXQGo5BhdPJdXmcmtJp4Av6hncQiEd3jc0hnKBpPxLFlracz
 rkTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781536390; x=1782141190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 b=bA0+khJvfxKLGbH12zcMeBwviM9RNP+GF1eGVs5TPwJhhgxJm0+DQv6Bq5W0Nn22oN
 IZ5if9FzH8tJiwYX3Aqw0xwplKnmNcR03d7yPQLEmiagjG9CqKimR2cYG73Do6teHukK
 umiPiJw/p0OKJFSJahMMkY/t5Y2PDtiZ9SQIvjNDcb1kvsL7ISCV1p9Nr8IyWcdQfTNG
 +EFnW8JPk3dnv7gxApiG9e8hpVLRTnnPqPUO8ugGb687jClgzIPq2yw2taTUEuE7jbKL
 Jxg481WP4dWaUHh90Eczg97knt1N9ViNHmKrM1WtrNm/lmvU0lcQVSnPqtHWqftRbklc
 AEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536390; x=1782141190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 b=dMpyt1OU4O2rzmIaIbc7UN/8b9djtbyYFvCp6/nrp5q4kkaTzWYu9mvVxoj4RCb2HB
 u1m5VfXhueReipR0fc9dwemYMCnDwj73Oyx/7Rly20PXoLh9KHJ/3e3eaGCAVrDrN0cC
 oDnAMjqlvHdNgP46cd02S+m7va4FiuZjLqKqo4/iB/MrqyZVXDEFm2dR0WRygyX1crO3
 dzhLVlcVmIITpSfWdz7TwW7PpUMzvMBp/u53rapo7mjKhIPki1h4CpgoI//vs5hAlE5I
 lvg2+ZpOmF42shJ+9ryEAE+Zl0RZ4T0tKPJHwHRuW10vHkQxchTsbcwWH1Uog+MXW7M0
 g+3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ97U6l83ZbBHHNW7BldR//+qTATGCDOO7By0HVsaHYBrUr/oGR+9kP77J740xgaRUgA8thgHUgP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzIa7txecU/qosmyPicwW/bL9sHi46s1dVGfPk2Hp7VLRPcTDh
 Za5y8go3aPa5JgM3PgSQ7SoBcjLKax5cfJBY4/kd/RVYIKZDtL2L5q8ZkvWgBqMkbVt2MZksbB1
 DZWY0fgq5fl8j2t/JzIuANJuLLFre83I=
X-Gm-Gg: Acq92OGXXSI5nG87GDXCY7lvW5In6X8VPVKYGQYku05kLR7ijda7PFbcny8jGJNpR6T
 mzqhsuhSA7uC/YokMA7whOE/Wnh/KU/izcrcvEU2VTm6qhvenyrLqjgOl96fcGP4LCLWqpCpk53
 vuE/zxnz6nO+KMGwalpL49PE8KrLg4xA5TY6k0CrpyJORMoat+juMWHn8neCQw/eYQ76UgL+f8l
 c0mgSyH2k7aJDLyRZwKy6y/o0+dqnd+2QXNRqQHTC+USJ5VHLHT/q0LGjOfHYgRqma8lW4DxCjS
 w8q5+WAhsCspxXGaDRx8LZoohFxhPd569ndi3jlAHzAS8Jwiv8WwVOTKPJ3wdqh6sjltbg==
X-Received: by 2002:a05:6102:c8c:b0:6c1:6ef9:db9d with SMTP id
 ada2fe7eead31-71e88c6e864mr2986309137.3.1781536389962; Mon, 15 Jun 2026
 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260608063638.24-1-ruoyuw560@gmail.com>
In-Reply-To: <20260608063638.24-1-ruoyuw560@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:12:56 -0400
X-Gm-Features: AVVi8Cer4GIFMDQbtQ86Y9cQ14WBjF3jDOlUIN6sx-Gkqu9NK1Mrx2Ch-KpOnV0
Message-ID: <CADnq5_MdEabu0FbbZSvvEMwMwVpogQf_4sXW2R6GQRhq7Xo52A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: avoid double free in r600 DPM cleanup
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 8, 2026 at 5:14=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> wro=
te:
>
> r600_parse_extended_power_table() uses manual kfree() calls for some
> early allocation failures, but the freed pointers are left in the
> dynamic power-management state. If device teardown later calls
> r600_free_extended_power_table(), those stale pointers can be freed
> again.
>
> Use the common extended power table cleanup helper for those early
> failure paths as well, and clear each pointer after freeing it so
> repeated cleanup stays safe.
>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Applied.  Thanks!

> ---
>  drivers/gpu/drm/radeon/r600_dpm.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r=
600_dpm.c
> index 83f1ae31cbdbc..9755e717ca8bb 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c
> @@ -932,7 +932,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.vddci_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -943,8 +943,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.vddc_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddci_depend=
ency_on_mclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -955,9 +954,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.mvdd_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddci_depend=
ency_on_mclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_mclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -1296,17 +1293,29 @@ void r600_free_extended_power_table(struct radeon=
_device *rdev)
>         struct radeon_dpm_dynamic_state *dyn_state =3D &rdev->pm.dpm.dyn_=
state;
>
>         kfree(dyn_state->vddc_dependency_on_sclk.entries);
> +       dyn_state->vddc_dependency_on_sclk.entries =3D NULL;
>         kfree(dyn_state->vddci_dependency_on_mclk.entries);
> +       dyn_state->vddci_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->vddc_dependency_on_mclk.entries);
> +       dyn_state->vddc_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->mvdd_dependency_on_mclk.entries);
> +       dyn_state->mvdd_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->cac_leakage_table.entries);
> +       dyn_state->cac_leakage_table.entries =3D NULL;
>         kfree(dyn_state->phase_shedding_limits_table.entries);
> +       dyn_state->phase_shedding_limits_table.entries =3D NULL;
>         kfree(dyn_state->ppm_table);
> +       dyn_state->ppm_table =3D NULL;
>         kfree(dyn_state->cac_tdp_table);
> +       dyn_state->cac_tdp_table =3D NULL;
>         kfree(dyn_state->vce_clock_voltage_dependency_table.entries);
> +       dyn_state->vce_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->uvd_clock_voltage_dependency_table.entries);
> +       dyn_state->uvd_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->samu_clock_voltage_dependency_table.entries);
> +       dyn_state->samu_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->acp_clock_voltage_dependency_table.entries);
> +       dyn_state->acp_clock_voltage_dependency_table.entries =3D NULL;
>  }
>
>  enum radeon_pcie_gen r600_get_pcie_gen_support(struct radeon_device *rde=
v,
> --
> 2.51.0
>
