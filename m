Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA525D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BFC10E549;
	Mon, 28 Oct 2024 19:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hICOGxdQ";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9772010E54D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:45:00 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so173433b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144700; x=1730749500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7QaxWC1GlRVsS83w9rhBzwV3nxEdLHDDfrSe5YIHAw=;
 b=hICOGxdQTS4l6DBQBkJAOT/ID25ZozUCWjOBhpoH8/G2h16PWbYAZTAHDV7LIBUb+J
 1WJ5nfWTgd27+ZAJoXVtqqj6RVWAnkrpjcsVy7z2RZ59LTANUPR15KvasGaqCE+668pA
 wNZXsq728ITU+fQz2YGZ+NiG9HAODPCYKQU79ksdB4BXFm3YJmmvfRdCy114q5qfC/Pj
 8z246FP9WxF9NaVtVPZYVsDCXQ6vBBT4HCT4z1VQAkne751L8gtooH3aAEzs+jzVKM41
 DqbmE/q9lMs+iLQxStxmUF5oe8Jly3TgB+GR8e1zZHo8bTyApWOwsII/IRKg3Jx5k+CB
 fxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144700; x=1730749500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7QaxWC1GlRVsS83w9rhBzwV3nxEdLHDDfrSe5YIHAw=;
 b=cBToUiVilS5ja1oj9MOf5rQu60nkzrQJxBIEjsfHqiqAciLqBzxaxyEihMpSBw+Owh
 VILInzaM5H2bKFu14HbHkkc0Br93CKAf26np6QIRVMBlwaGAnG8ZGVA6InhsGcJGhG7y
 d0aXpZu0nsIMkICCOntPAGRCvkrC+MHt4ylBsXTT8z90AUYQrF88GmnOkGK+dVviPnI0
 4aB3i+mqU+8UvZC8dH5M8KtcoraWgcW6JTM1eqLFjypfaFIQTymM94iRrbX9NEM86aQB
 LzkPf2A/iCAieZcbOEoF+fgU8tooIF8wjQ8YZCR54Un5hks5gccJpZsbK6msb4KMzNa1
 IaeA==
X-Gm-Message-State: AOJu0Yz6SfAu+Hj2VIdcqvW/KOorCwP7MShav/q4Hir4VIjP/o3GOF42
 BKLPIEvVEaRsZ29aFUebVzw/QHc3wVadE5XK+Is+zPqm4miNZ9Rd3V5H6hF/mDmWnDjQwTJI7f2
 Pa7r6yYQRWaleYtG0qJ/R+LxLx/bdoy3p
X-Google-Smtp-Source: AGHT+IEsSJIh9Tur+hU8RnJAzC2eOlbt19iiptXTXyMV/pra0vSJtVrdWFU+7/LNHIzMKiLB+Bj9aFjBkNgB7GQ/1jM=
X-Received: by 2002:a05:6a00:2e26:b0:71e:66bb:d33b with SMTP id
 d2e1a72fcca58-72062f1e0a5mr5770116b3a.1.1730144700013; Mon, 28 Oct 2024
 12:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-29-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-29-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:44:48 -0400
Message-ID: <CADnq5_M3KgNF_XfSO8FXtDf5ZrWM0=eGEhh-5qjM1_-F-3VVQQ@mail.gmail.com>
Subject: Re: [PATCH 28/29] drm/amdgpu: wait_for_idle for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:36=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Perform wait_for_idle only for the instance of the current vcn IP block,
> instead of perform it for all vcn instances.
>
> v2: remove unneeded local variable initialization.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 16 +++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 15 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 15 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 ++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 15 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 15 ++++++---------
>  6 files changed, 35 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 2e5888b905fb..34d94b09f04c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1777,16 +1777,14 @@ static bool vcn_v2_5_is_idle(void *handle)
>  static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STAT=
US__IDLE,
> -                       UVD_STATUS__IDLE);
> -               if (ret)
> -                       return ret;
> -       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
> +
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__I=
DLE,
> +               UVD_STATUS__IDLE);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 0d1c1534db40..451858f86272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2105,17 +2105,14 @@ static bool vcn_v3_0_is_idle(void *handle)
>  static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STAT=
US__IDLE,
> -                       UVD_STATUS__IDLE);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__I=
DLE,
> +               UVD_STATUS__IDLE);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index e9a8e027d5f9..fa7cf10e8900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1968,17 +1968,14 @@ static bool vcn_v4_0_is_idle(void *handle)
>  static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STA=
TUS__IDLE,
> -                       UVD_STATUS__IDLE);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__=
IDLE,
> +               UVD_STATUS__IDLE);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 716bc85141cb..d05dcadb3e81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1566,14 +1566,11 @@ static bool vcn_v4_0_3_is_idle(void *handle)
>  static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_=
STATUS,
> -                                        UVD_STATUS__IDLE, UVD_STATUS__ID=
LE);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, inst), regUVD_STATU=
S,
> +                                UVD_STATUS__IDLE, UVD_STATUS__IDLE);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index b74b2c0942c9..307c8e204456 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1465,17 +1465,14 @@ static bool vcn_v4_0_5_is_idle(void *handle)
>  static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STA=
TUS__IDLE,
> -                       UVD_STATUS__IDLE);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__=
IDLE,
> +               UVD_STATUS__IDLE);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 3fbc2aafcd29..50022bbb276e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1192,17 +1192,14 @@ static bool vcn_v5_0_0_is_idle(void *handle)
>  static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, ret =3D 0;
> +       int inst =3D ip_block->instance;
> +       int ret;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ret =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STA=
TUS__IDLE,
> -                       UVD_STATUS__IDLE);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__=
IDLE,
> +               UVD_STATUS__IDLE);
>
>         return ret;
>  }
> --
> 2.34.1
>
