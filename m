Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8C7C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 13:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B2110E77E;
	Fri, 16 Aug 2024 13:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfYSIeX9";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C065E10E797
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 13:56:00 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so1667845b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723816560; x=1724421360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuDXoU0N+0isKKgZzmbgRX5rCw6gxMwTXKsd6Subtbg=;
 b=JfYSIeX9l+RLpdK8VBea5gw2oBlYGC6/YDjNynnH+JbcbfzgrW7NnfQIEXdPEKAOEr
 O6CamdQ4TASOsy4Nviqelkz1kcqJfx4qqWvPT5UAY0QSbZRNr4NE0EUUa0DwatNmWJpO
 GKQ8tDsg0woPhVNwXjJfIo8Z6jkCJ9AANAWBUko+6/RUC1nqzLohvhI1S2N4EyT4Poy9
 cvZxwNCYPf9FF9Oo2s716PBOj6vkqQ63bK5qFfSXwHQnYNzKGdMpj5lx647DLhrcoJPh
 43F7qfgNAOJx0xm/to9qOgcbOnh3z/h9KL+tx2kugqhQKkdb2N4WlWVw3Ojus5ho1mNL
 VIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723816560; x=1724421360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuDXoU0N+0isKKgZzmbgRX5rCw6gxMwTXKsd6Subtbg=;
 b=Gdw9cN0Q0sUH6OgHmamdE5SWBWMBJJzKRVMPrvH4Xa8iM6QuFvGlw2wbhBZdROUwxI
 tLx91j/cWKf1aZg8Dg9znFpbrfFt3ikgjJrCT6h/7AAfH25VoknUF8Nay5klRs0kh/Pz
 Ap2dGMJrdHmc47ORH0tRnt6w/RaUxcT5T/jL1QI6+lgbvl2VNVixOUCVVpP8RWO3Nsdt
 b2/u2XDh2Y/KBrQ9MDwi4A4ni6JMypvxgIuBGvNHcxPO0w0uD3zv08gOcPBpDpmHvozB
 F9TXIOdb19M6+BuX5aJabyOyw1HkUbmSQOihVo4UyelEgBndQBwj1XT2obsSnXRy/TgO
 iBTg==
X-Gm-Message-State: AOJu0YyQOKRnEzGlMLmIpBHluxOdD/x7cldXqGBbmGkp1E0dkcs6AlQH
 SIEs5bwVPNjSDI8RObhc3M/SMbRSskGqt4NjJWISRPPXzlNTQqnaTCVPIldL6qUUhW7E7QqNRuW
 isc/fx0HMyhJdlqGk5xaI8mAFTH2CsA==
X-Google-Smtp-Source: AGHT+IH7Ns5b5JB64qU8ntBpfGAdpPl5hJAMZJXNMkrrXkND5CkueZdCyeKEAfS8MWDMJnQWaMDsle31jMnkkqk3V+I=
X-Received: by 2002:a05:6a20:2d29:b0:1c6:ac08:8dd2 with SMTP id
 adf61e73a8af0-1c904f913aemr3827708637.15.1723816559851; Fri, 16 Aug 2024
 06:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
 <20240816075447.442983-2-Trigger.Huang@amd.com>
In-Reply-To: <20240816075447.442983-2-Trigger.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Aug 2024 09:55:48 -0400
Message-ID: <CADnq5_OROFh=s4KcYe4AMvSR0fE1VsU-Y8KsP_DZF+ZaSR4CxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Add gpu_coredump parameter
To: Trigger.Huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, sunil.khatri@amd.com, 
 alexander.deucher@amd.com
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

On Fri, Aug 16, 2024 at 3:55=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Add new separate parameter to control GPU coredump procedure. This can
> be used to decouple the coredump procedure from gpu recovery procedure
>
> V2: enable gpu_coredump by default (Alex)
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>

I still don't think we'd want to turn this off.  Does it ever hurt
anything?  It seems like someone would accidentally turn this off and
then run into a hang and regret it because the didn't get a dump.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 937de21a7142..4dd465ad14af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern uint amdgpu_force_long_training;
>  extern int amdgpu_lbpw;
>  extern int amdgpu_compute_multipipe;
>  extern int amdgpu_gpu_recovery;
> +extern int amdgpu_gpu_coredump;
>  extern int amdgpu_emu_mode;
>  extern uint amdgpu_smu_memory_pool_size;
>  extern int amdgpu_smu_pptable_id;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b9529948f2b2..06bd20d83db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -178,6 +178,7 @@ uint amdgpu_force_long_training;
>  int amdgpu_lbpw =3D -1;
>  int amdgpu_compute_multipipe =3D -1;
>  int amdgpu_gpu_recovery =3D -1; /* auto */
> +int amdgpu_gpu_coredump =3D 1;
>  int amdgpu_emu_mode;
>  uint amdgpu_smu_memory_pool_size;
>  int amdgpu_smu_pptable_id =3D -1;
> @@ -556,6 +557,13 @@ module_param_named(compute_multipipe, amdgpu_compute=
_multipipe, int, 0444);
>  MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D en=
able, 0 =3D disable, -1 =3D auto)");
>  module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>
> +/**
> + * DOC: gpu_coredump (int)
> + * Set to enable GPU coredump mechanism (1 =3D enable, 0 =3D disable). T=
he default is 1
> + */
> +MODULE_PARM_DESC(gpu_coredump, "Enable GPU coredump mechanism, (1 =3D en=
able(default), 0 =3D disable)");
> +module_param_named(gpu_coredump, amdgpu_gpu_coredump, int, 0444);
> +
>  /**
>   * DOC: emu_mode (int)
>   * Set value 1 to enable emulation mode. This is only needed when runnin=
g on an emulator. The default is 0 (disabled).
> --
> 2.34.1
>
