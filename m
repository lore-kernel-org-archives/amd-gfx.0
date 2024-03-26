Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359EDC54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 16:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C7010EF53;
	Tue, 26 Mar 2024 16:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VUZc1KSt";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D57E10EF48
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 16:50:27 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-29f69710cbbso3835300a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711471826; x=1712076626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSt+vGeOge/2tqP3rBqb92pKjhNfSiBah7lywrR2jbo=;
 b=VUZc1KSteJnIfcfaE2YitdYib9/QDXijSnKLUSoBfnbJUp99dztEiZYeubNPfrTV0M
 w4u02Nj8Cic1/pJeAwo1HqqiIOnxR3SDw/APUizynAIrkBgmfIEI84yKlShj1zkmH+6R
 mEV0zridQ1A6GLK9ZWMwjIaKkYIXB9HATM9rFR1FxtRCtTaMlRzrD30IPkZMxnh0honA
 nEX8heyt0EF6AvDeM6aYtvb4ak8yTK4nq9KAw2XxrCVvnZ/od/OV19WW29dtv7HPwxlZ
 ZgcQk5aErgxOpuzD6bq1TlnIpbk0mKhZBdFOF/3NmwPweY6z7UznNGSdDWUwpqaM1hJ8
 50rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711471826; x=1712076626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSt+vGeOge/2tqP3rBqb92pKjhNfSiBah7lywrR2jbo=;
 b=HL24OVrb4F5sNMMn4PIZCyaxO2I3fTgo6a2uI2G7VqIBI2ZTmuTr9alenhkCN3Lszg
 iwwash721qcUYlQD+zC8JB5ggfVPsujLcYRkD8riN7Bxx8EH/9FqWg9aex+sO4bzQD4G
 Pnu7kplaSpOEcZGc+g2INi4W/6ArnTRxn/IZ3TGohuDdwoqxMRA8UDh976sgYn4QOBW2
 c6nJrzf4pCRjuPCnTsOMuplEqBKE35E+EWYkN2DY5PaQ3VtklbAThauCOhdh0V0qlrw2
 QNVqj13x+hjNU6b44myiuio9HsQ/yWzVP4yd6Kp89IHZaZTGKZi6cvNPp68QuKua1+h4
 pfzQ==
X-Gm-Message-State: AOJu0Yy5oisapK08tNuhtAXyaA2y9ppHS8WR0i5pachxRnWuX/Bm7i2C
 32pV/2jVHC7XwdPRHTFrwwcAdTSgmUD0fyyT/mXrN5C/eqERv8a5MNvZj0ccGaSBGhLj96++iL/
 Y0MHT1zekhYouxobj/UkW4fqNSh6MBAr2
X-Google-Smtp-Source: AGHT+IGihOMWcOmNda9fd3FfDMCat3f9reZobov0roc9MHtZg0JPE02/xmveQ3kj60UN7ou6U2efXoHsARWs9uG5q+A=
X-Received: by 2002:a17:90b:4b8f:b0:2a0:7e08:ea49 with SMTP id
 lr15-20020a17090b4b8f00b002a07e08ea49mr3021172pjb.5.1711471826276; Tue, 26
 Mar 2024 09:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240322180021.391680-1-shaoyun.liu@amd.com>
 <CH0PR12MB53727B34030F966B79075C51F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CH0PR12MB53728065D73B07D089A9AB6AF4352@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53728065D73B07D089A9AB6AF4352@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 12:50:13 -0400
Message-ID: <CADnq5_NxMGhFYxs9_aztY2KAy+UqLF3gCVhWQmnhm7rirHDpVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Mar 26, 2024 at 11:51=E2=80=AFAM Liu, Shaoyun <Shaoyun.Liu@amd.com>=
 wrote:
>
> [AMD Official Use Only - General]
>
>
> ping

Maybe we'd want to make this something we could dynamically enable via
debugfs?  Not sure how much of a pain it would be to change this at
runtime.  Something we can think about for the future.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, S=
haoyun
> Sent: Monday, March 25, 2024 8:51 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log f=
eature
>
>
>
> [AMD Official Use Only - General]
>
>
>
> [AMD Official Use Only - General]
>
>
>
> Ping
>
>
>
> Get Outlook for iOS
>
> ________________________________
>
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Friday, March 22, 2024 2:00:21 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log featu=
re
>
>
>
> The MES log might slow down the performance for extra step of log the dat=
a,
> disable it by default and introduce a parameter can enable it when necess=
ary
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  7 +++++--
>  4 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 9c62552bec34..b3b84647207e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -210,6 +210,7 @@ extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
>  extern int amdgpu_discovery;
>  extern int amdgpu_mes;
> +extern int amdgpu_mes_log_enable;
>  extern int amdgpu_mes_kiq;
>  extern int amdgpu_noretry;
>  extern int amdgpu_force_asic_type;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 80b9642f2bc4..e4277298cf1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -195,6 +195,7 @@ int amdgpu_async_gfx_ring =3D 1;
>  int amdgpu_mcbp =3D -1;
>  int amdgpu_discovery =3D -1;
>  int amdgpu_mes;
> +int amdgpu_mes_log_enable =3D 0;
>  int amdgpu_mes_kiq;
>  int amdgpu_noretry =3D -1;
>  int amdgpu_force_asic_type =3D -1;
> @@ -667,6 +668,15 @@ MODULE_PARM_DESC(mes,
>          "Enable Micro Engine Scheduler (0 =3D disabled (default), 1 =3D =
enabled)");
>  module_param_named(mes, amdgpu_mes, int, 0444);
>
> +/**
> + * DOC: mes_log_enable (int)
> + * Enable Micro Engine Scheduler log. This is used to enable/disable MES=
 internal log.
> + * (0 =3D disabled (default), 1 =3D enabled)
> + */
> +MODULE_PARM_DESC(mes_log_enable,
> +       "Enable Micro Engine Scheduler log (0 =3D disabled (default), 1 =
=3D enabled)");
> +module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
> +
>  /**
>   * DOC: mes_kiq (int)
>   * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 78dfd027dc99..9ace848e174c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -100,6 +100,9 @@ static int amdgpu_mes_event_log_init(struct amdgpu_de=
vice *adev)
>  {
>          int r;
>
> +       if (!amdgpu_mes_log_enable)
> +               return 0;
> +
>          r =3D amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>                                      AMDGPU_GEM_DOMAIN_GTT,
>                                      &adev->mes.event_log_gpu_obj,
> @@ -1561,7 +1564,7 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgp=
u_device *adev)
>  #if defined(CONFIG_DEBUG_FS)
>          struct drm_minor *minor =3D adev_to_drm(adev)->primary;
>          struct dentry *root =3D minor->debugfs_root;
> -       if (adev->enable_mes)
> +       if (adev->enable_mes && amdgpu_mes_log_enable)
>                  debugfs_create_file("amdgpu_mes_event_log", 0444, root,
>                                      adev, &amdgpu_debugfs_mes_event_log_=
fops);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 072c478665ad..63f281a9984d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -411,8 +411,11 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>          mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>          mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
>          mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> -       mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> -       mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes->event_l=
og_gpu_addr;
> +       if (amdgpu_mes_log_enable) {
> +               mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> +               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
> +                                       mes->event_log_gpu_addr;
> +       }
>
>          return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                          &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> --
> 2.34.1
