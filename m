Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62556D3E2A0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B08F10E51E;
	Mon, 28 Oct 2024 19:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y7g6OXoD";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEF510E51E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:05:19 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7202e1a0209so340057b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142318; x=1730747118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qirH9Orn2Lq0TQMu6zl4EAjW9mAAHsh93KVQGLkdMm8=;
 b=Y7g6OXoDoSibtCN8iE019ICfrl6+Ja4J9QSBUHPSTZmV0OME1Nr5X4JtJoPOmk23T6
 j+GKeCIRRogd1pYKQbJExoRPI0EnEd+uhpqN1s8YESsQx+NBqvL/r1vwfmU6JuRhCNMe
 k2E22v/hjamVJ104pjSTdZnlQBtPgmnuDnb1T7dHKgJiM12+ttCV5abMUnV7QC8hRvli
 O9VUMIInayx+PMxdeqFUAY9txi3e1ZPJaLoz6Lzh6FbaXoozODE7lzbEstdWsWjemiMb
 R+gN+5waBwjnxpbewZSkel8cR7jIiXfojwdUnalxc8Qzy07+06hd9u+RseaJlFl5RhXc
 oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142318; x=1730747118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qirH9Orn2Lq0TQMu6zl4EAjW9mAAHsh93KVQGLkdMm8=;
 b=FwofS12er1t8YHwz+jQuOVZ1F48QOdIo6lqh5Vkaac+mXBIhZG165iBVvfaqdVDS9R
 BC/o+vB0Y0XZy1SehsnlIZ7M394iVHFsogUvOZ9Jqx6WW2LjlMeW7l7PdyfwBToY5ND0
 PfP3YwYf0I/xlWZeifDIJBkoytAkL2RmRw3K6iSf0OCVBHehQmdHFzUzY6PslBAs1BFt
 GUV/h6aYsWOONp5RQS2OFhKWvYXSu9Xu/mdAMrlV4HRqT9dSC9cKbQpHso84IkuuXqnW
 4Pgv0P+otOMD7HD7PuOufjjJXcx9r6ZXRuOKjn8pjhYxjICZm9uUwGmTu72G+GU5hsPn
 m79w==
X-Gm-Message-State: AOJu0YzqRlwU0NwHJlnls5cnAlAwTHiAxN/8tdGNl0hSr1jZcHCch/gh
 MDvFyTBFSvZ6LEYR35E5jqwVpd+63TnOOCPtX4CU9v+kru++0fikt1MquLuX6Vyb+EabdNhUnnf
 mWAnFyIV1aNnvqM2m64SGBYYQTewM3w==
X-Google-Smtp-Source: AGHT+IF5nApHylDprJvMxXwkl3cVkAQjwwlMYDzoQVxOlcLIyNVghPQjnLUHQ80O6jo0DYJqnNUCCv4A1BkXV5Ed1Ps=
X-Received: by 2002:a05:6a00:22c7:b0:71e:4bda:71ec with SMTP id
 d2e1a72fcca58-72063028ed7mr5450303b3a.4.1730142318333; Mon, 28 Oct 2024
 12:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-2-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-2-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:05:06 -0400
Message-ID: <CADnq5_PPvzcWhpy+C-bFEzUSL1vYweyqZZRwoDgoiq=uk-Hq9g@mail.gmail.com>
Subject: Re: [PATCH 01/29] drm/amd/pm: add inst to dpm_set_vcn_enable
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
> Add an instance parameter to the existing function dpm_set_vcn_enable()
> for future implementation. Re-write all pptable functions accordingly.
>
> v2: Remove duplicated dpm_set_vcn_enable() functions in v1. Instead,
> adding instance parameter to existing functions.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h            | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c          | 3 ++-
>  13 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8d4aee4e2287..fe2a740766a2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -252,7 +252,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context =
*smu,
>         if (atomic_read(&power_gate->vcn_gated) ^ enable)
>                 return 0;
>
> -       ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
> +       ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
>         if (!ret)
>                 atomic_set(&power_gate->vcn_gated, !enable);
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..4ebcc1e53ea2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -739,7 +739,7 @@ struct pptable_funcs {
>          * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
>          *                      management.
>          */
> -       int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
> +       int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable, i=
nt inst);
>
>         /**
>          * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index 044d6893b43e..ae3563d71fa0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -255,7 +255,8 @@ int smu_v13_0_wait_for_event(struct smu_context *smu,=
 enum smu_event_type event,
>                              uint64_t event_arg);
>
>  int smu_v13_0_set_vcn_enable(struct smu_context *smu,
> -                            bool enable);
> +                             bool enable,
> +                             int inst);
>
>  int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
>                               bool enable);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v14_0.h
> index 07c220102c1d..0546b02e198d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> @@ -210,7 +210,8 @@ int smu_v14_0_wait_for_event(struct smu_context *smu,=
 enum smu_event_type event,
>                              uint64_t event_arg);
>
>  int smu_v14_0_set_vcn_enable(struct smu_context *smu,
> -                            bool enable);
> +                             bool enable,
> +                             int inst);
>
>  int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
>                               bool enable);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 5ad09323a29d..6c8e80f6b592 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1571,7 +1571,9 @@ static bool arcturus_is_dpm_running(struct smu_cont=
ext *smu)
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> -static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool ena=
ble)
> +static int arcturus_dpm_set_vcn_enable(struct smu_context *smu,
> +                                       bool enable,
> +                                       int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 9fa305ba6422..faa8e7d9c3c6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1135,7 +1135,9 @@ static int navi10_set_default_dpm_table(struct smu_=
context *smu)
>         return 0;
>  }
>
> -static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enabl=
e)
> +static int navi10_dpm_set_vcn_enable(struct smu_context *smu,
> +                                     bool enable,
> +                                     int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 77e58eb46328..a9cb28ce2133 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1152,7 +1152,9 @@ static int sienna_cichlid_set_default_dpm_table(str=
uct smu_context *smu)
>         return 0;
>  }
>
> -static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bo=
ol enable)
> +static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
> +                                             bool enable,
> +                                             int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
>         int i, ret =3D 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index a333ab827f48..a1ef63878cc3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -459,7 +459,9 @@ static int vangogh_init_smc_tables(struct smu_context=
 *smu)
>         return smu_v11_0_init_smc_tables(smu);
>  }
>
> -static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enab=
le)
> +static int vangogh_dpm_set_vcn_enable(struct smu_context *smu,
> +                                      bool enable,
> +                                      int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 0b210b1f2628..a34797f3576b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -645,7 +645,9 @@ static enum amd_pm_state_type renoir_get_current_powe=
r_state(struct smu_context
>         return pm_type;
>  }
>
> -static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enabl=
e)
> +static int renoir_dpm_set_vcn_enable(struct smu_context *smu,
> +                                     bool enable,
> +                                     int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 6cfd66363915..2bfea740dace 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2104,7 +2104,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct sm=
u_context *smu)
>  }
>
>  int smu_v13_0_set_vcn_enable(struct smu_context *smu,
> -                            bool enable)
> +                             bool enable,
> +                             int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
>         int i, ret =3D 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index a71b7c0803f1..f5db181ef489 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -193,7 +193,9 @@ static int smu_v13_0_5_system_features_control(struct=
 smu_context *smu, bool en)
>         return ret;
>  }
>
> -static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu, bool =
enable)
> +static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu,
> +                                          bool enable,
> +                                          int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 71d58c8c8cc0..73b4506ef5a8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -220,7 +220,9 @@ static int yellow_carp_system_features_control(struct=
 smu_context *smu, bool en)
>         return ret;
>  }
>
> -static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool =
enable)
> +static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu,
> +                                          bool enable,
> +                                          int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index f7745eaf118e..ecb0164d533e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1507,7 +1507,8 @@ int smu_v14_0_set_single_dpm_table(struct smu_conte=
xt *smu,
>  }
>
>  int smu_v14_0_set_vcn_enable(struct smu_context *smu,
> -                            bool enable)
> +                             bool enable,
> +                             int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
>         int i, ret =3D 0;
> --
> 2.34.1
>
