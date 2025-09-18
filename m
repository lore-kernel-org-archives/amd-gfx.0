Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA1CCA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 19:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06D310E8E7;
	Thu, 18 Sep 2025 19:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APnXjXlK";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED5210E8E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 19:05:39 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-26808b24a00so2063645ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758222339; x=1758827139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZdDmR3l4rPO5UXJNs7PJ2wVGdMA4rEekFAXbtXgmrA=;
 b=APnXjXlKsZC3MvItZWidv6gPneFFk6TuzjO89I9wo2K31UUYXroxakbaj5OhIdo3xi
 nNmJVuIPqfjAKS/P8yT3vp5b3J0rTizY5g+X2BlzZSHmmaSHuH26k6sbIDy5GmdGwTDO
 /vssW70xwuPAuPoT3VXr3S3FIAwjYdCeDgFe1EqAZY12uix8W0KWoGbrtYYaXwi+DS7G
 FcaPVq5XgHodr2oiAG9WPuD/8rhXRk89vUWaDe45OaJ8x/V9yqEDPG8an4Roeu27R5f9
 M0D3Zm1OIgfZOmyofoZ3+gv0gJuraiIhJ/wYoncPdr1o6RJGSB9cxXE38z0tkZQWUA86
 Zahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758222339; x=1758827139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZdDmR3l4rPO5UXJNs7PJ2wVGdMA4rEekFAXbtXgmrA=;
 b=dkKEtlUAy8P17NGlhmulXEuwIQaDo3iFkmbRuwnx9r3eN6fFI+lxyD0F6utBZitfm4
 X3DWuo2xhtYsEB/QiTWfD9V5NH/6Lyp4fxCWymR8S+geHZiKXORpxADoV7zTACZUEMY4
 ZLyGY7Cadt4lEuuaFBxraJgfaozo5HxvpPd28QUS58uCGGXSh4jdDaFC7H2Xcojv4860
 HH7UgTunFahbVcoJJScY0Kvs+jFvKG3L0PEyq712M+ZKChPW71K2i+9zODBm1Ofa5ZQt
 Hbr+MUDqC3Xn7JOe8H7H4dFiEjQe0o0Rrd3JZNfLTHqbFLeqATAK7cazOCSEDO0v6NbL
 WKGg==
X-Gm-Message-State: AOJu0Yw8rU41WTeKCCeNza/mKURS8th5qsjUgocWV5ggVcviwmfYOcUU
 MOdmaaxE/1O9+EntaUiRtn1Vqx30CloXaVY1pawjkthXGpyyMiKGHFMGOiQbDMfMKDf/rYi9Kxa
 U8sB1YBnKGfScoOyRieIjamdgzP3wJ1c=
X-Gm-Gg: ASbGnctRDduRC5yu2NLoBVyM4meon/R0p0fkYzrjm9rdWNbMdLE5KAjjqmrdpoPWgfQ
 fCNy3YwWDRN9tViLwcuR/BkAfWhyXJVZdoosxC+JJHq+PrwevgP5xgR+J/xBRJ0+8rDTL2T6W3i
 j1l47XSqVwWBbb750HkmqyMp9mNV1GWz5a2vulKIEUWqtW4W41JgUQ8diPtTLWkxUQfn2CDzPrf
 lHC1K2twGJmgtYY5zWO5+GRaQ==
X-Google-Smtp-Source: AGHT+IHQXpcT+Lmnmnnhi3i+6psLjzwZapCiJPvQzHL1fZkaBdE4J/jYI8iksDi8DxOmx5E5bBD5Ivsn6kRZpQtL80U=
X-Received: by 2002:a17:902:da8f:b0:24e:af92:70de with SMTP id
 d9443c01a7336-269ba5049dbmr4988535ad.7.1758222338557; Thu, 18 Sep 2025
 12:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250918184150.394532-1-mario.limonciello@amd.com>
In-Reply-To: <20250918184150.394532-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 15:05:26 -0400
X-Gm-Features: AS18NWCxEMsC86DPZsrDIlZNSlQB97ScFwNTjrJJcmy4e6MRfxpCW5WuvTuCbxU
Message-ID: <CADnq5_M13ADiuoKKdgEyi=1MVbLJ9qCJKTHUPd+F+aLXUzwtDQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
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

On Thu, Sep 18, 2025 at 2:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The MES set resources packet has an optional bit 'lr_compute_wa'
> which can be used for preventing MES hangs on long compute jobs.
>
> Set this bit by default.
>
> Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Presumably this bit will be ignored on old firmwares?  If not, we'll
need a firmware version check.  Assuming this works correctly on old
firmwares,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> ---
> v2:
>  * drop module parameter
>  * add more description to commit text
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
>  4 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 3b91ea601add..540b514312b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -713,6 +713,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_m=
es *mes)
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
>         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> +       mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> +
>         if (amdgpu_mes_log_enable) {
>                 mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
>                 mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 998893dff08e..01266eef65cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -769,6 +769,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_m=
es *mes, int pipe)
>         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> +       mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
>
>         /*
>          * Keep oversubscribe timer for sdma . When we have unmapped door=
bell
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index 15680c3f4970..ab1cfc92dbeb 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t enable_mes_sch_stb_log : 1;
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t is_strix_tmz_wa_enabled  :1;
> -                               uint32_t reserved : 13;
> +                               uint32_t enable_lr_compute_wa : 1;
> +                               uint32_t reserved : 12;
>                         };
>                         uint32_t        uint32_t_all;
>                 };
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index c04bd351b250..69611c7e30e3 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t unmapped_doorbell_handling: 2;
>                                 uint32_t enable_mes_fence_int: 1;
> -                               uint32_t reserved : 10;
> +                               uint32_t enable_lr_compute_wa : 1;
> +                               uint32_t reserved : 9;
>                         };
>                         uint32_t uint32_all;
>                 };
> --
> 2.49.0
>
