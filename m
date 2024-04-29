Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D155C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2213910EACF;
	Mon, 29 Apr 2024 13:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7WZaxXx";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB8B10EACF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:28:34 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1e2b137d666so33980805ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714397314; x=1715002114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf7z0VWUe5AOMp/Ze+G3C77+jXWSQaHbPBzNMBL6pt0=;
 b=j7WZaxXxaQIDlwWmPXWlfgjylQhm1TlSiJG5P5Xb7VMYVAQtxvwTcK5rT3D4YOVyUg
 ZlGwk84RsDkDungxeUDvaU9//Gvh5zk7VJeUoSlCwhMr6jsZOtkQYESlj1I+TcH02Ws2
 H7/EAgGBF9hvfqj2WHD4eeDS+sSRWKn1O6omkFTMaS+u80mzcfsm1ByLtj3ub1VjsZNJ
 FRkEgiwcBzovoSqR9s5LwD5B8oiUQH0+2Kb0ZB6Wp9VZxtqvnmALtTbNWVjHvrrgSiPQ
 4x3W/DPu8/bFvVBkS+gxYOdOLY4a+WK9ZQNK09JAfDkNMSqkmmmurXOCC8NBvOPA0nmK
 gp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714397314; x=1715002114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf7z0VWUe5AOMp/Ze+G3C77+jXWSQaHbPBzNMBL6pt0=;
 b=MMVoklGHiMsYsXw5wcq+q1N+AcRGIxEQcAAuYiMHH7+RTfNdfDuyD/+jBzNBADqg+/
 XdfGpQIozOQqKzi2uvG6DfUSytf99PNNjmTLmoagE4T9TKucRdzNAJCswznCT8mpXVCg
 A1Sl+jODrHTw7uigZ8PjiGOqeisfcgQ8WZ5f9D22B3oIHuVLLsf9GRxErUW72DtGUCnG
 jEm+LSzGNWTfkXi8tjuNyFqDBWdePFr8eOA0TmUZSHLQUjj5ykeKcAdbv4KbfZtO8JTp
 j5+SKKZJGT3lljmCWzeXw+cPcKxmNkMVOWEpWcgJCmPUKahUCDt/gH9fDiVJU1Ar1t2p
 CR8w==
X-Gm-Message-State: AOJu0Yw3XXcfhIrlx6Az9L0ae//33gSuOtrRLwGNB6rSiwGfY7D+OpBb
 3eppMKVx9foty0TjxsScWVyfum9tEsLaY81S/TmyPDxr1OQbVCOQYTiyKKw+Tgmaldq96LxxKTv
 IOS5WSfdmsA0A+V0mD0LNbBlRmA5RRQ==
X-Google-Smtp-Source: AGHT+IFja5pltHXbDkARv1mKsZRtiwoY7sG4qrUeuH1sgCMvnh1GTOCEumFXFxoqQNCAaD6gAMZE7gmAENNTyZNeNUg=
X-Received: by 2002:a17:903:11ce:b0:1e3:f4f1:a2c4 with SMTP id
 q14-20020a17090311ce00b001e3f4f1a2c4mr12094836plh.64.1714397314206; Mon, 29
 Apr 2024 06:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240429065245.166647-1-peytolee@amd.com>
In-Reply-To: <20240429065245.166647-1-peytolee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 09:28:22 -0400
Message-ID: <CADnq5_N3AwaE9NDFmS0roGDaVG-hN3gdhYFyZtAr-H+3QNHhUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: fix vpe dpm clk ratio setup failed
To: Peyton Lee <peytolee@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Lang Yu <lang.yu@amd.com>, Alan Liu <haoping.liu@amd.com>
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

On Mon, Apr 29, 2024 at 3:07=E2=80=AFAM Peyton Lee <peytolee@amd.com> wrote=
:
>
> Some version of BIOS does not enable all clock levels,
> resulting in high level clock frequency of 0.
> The number of valid CLKs must be confirmed in advance.
>
> Signed-off-by: Peyton Lee <peytolee@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index c23d97d34b7e..49881073ff58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -128,6 +128,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
>                 struct dpm_clock *VPEClks;
>                 struct dpm_clock *SOCClks;
>                 uint32_t idx;
> +               uint32_t vpeclk_enalbled_num =3D 0;
>                 uint32_t pratio_vmax_vnorm =3D 0, pratio_vnorm_vmid =3D 0=
, pratio_vmid_vmin =3D 0;
>                 uint16_t pratio_vmin_freq =3D 0, pratio_vmid_freq =3D 0, =
pratio_vnorm_freq =3D 0, pratio_vmax_freq =3D 0;
>
> @@ -144,6 +145,14 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
>                 SOCClks =3D clock_table.SocClocks;
>                 VPEClks =3D clock_table.VPEClocks;
>
> +               /* Comfirm enabled vpe clk num
> +                * Enabled VPE clocks are ordered from low to high in VPE=
Clks
> +                * The highest valid clock index+1 is the number of VPECl=
ks
> +                */
> +               for (idx =3D PP_SMU_NUM_VPECLK_DPM_LEVELS; idx && !vpeclk=
_enalbled_num; idx--)
> +                       if (VPEClks[idx-1].Freq)
> +                               vpeclk_enalbled_num =3D idx;
> +
>                 /* vpe dpm only cares 4 levels. */
>                 for (idx =3D 0; idx < VPE_MAX_DPM_LEVEL; idx++) {
>                         uint32_t soc_dpm_level;
> @@ -155,8 +164,8 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
>                                 soc_dpm_level =3D (idx * 2) + 1;
>
>                         /* clamp the max level */
> -                       if (soc_dpm_level > PP_SMU_NUM_VPECLK_DPM_LEVELS =
- 1)
> -                               soc_dpm_level =3D PP_SMU_NUM_VPECLK_DPM_L=
EVELS - 1;
> +                       if (soc_dpm_level > vpeclk_enalbled_num - 1)
> +                               soc_dpm_level =3D vpeclk_enalbled_num - 1=
;
>
>                         min_freq =3D (SOCClks[soc_dpm_level].Freq < VPECl=
ks[soc_dpm_level].Freq) ?
>                                    SOCClks[soc_dpm_level].Freq : VPEClks[=
soc_dpm_level].Freq;
> --
> 2.34.1
>
