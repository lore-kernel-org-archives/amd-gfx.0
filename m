Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB406D3E2A0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B985D10E523;
	Mon, 28 Oct 2024 19:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgXnq+Pn";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CD510E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:08:47 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-71e4eb91228so323162b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142527; x=1730747327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGu3vxSN00ogbMElpXdK1B0OxaSX3TUb9NS04Jnarmw=;
 b=OgXnq+PnSGQewFwDj5bQhDk1fDLeopaF35clqwjxOwoCrSl2SSDKT6GIfKoy4o/+/8
 fEdwgrmZa7WQ/UuwIYE0ImijMT3YauA7pK3N89SY/4jaJUOs7A6oxSmkOMnXMDxfr+VB
 /7YfpC0xEfK1D0WhT9tYk/49bAVZw80XQsZhPCQMlG7dZqEk5mCcr7fC3h142R6goTgr
 GI2E7AUWr/Jrr0tuoZNMFmNyWw2cm68ykCJsC3cvpNgxiFHrjaQZrKTpPZkCJRjGaUeR
 0TScSZJCJTaPBIrw86r06NeszSJeleL23XEbzIXNj2u+5q/CsEuj5l3r2yAaPrEjPmnO
 8b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142527; x=1730747327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGu3vxSN00ogbMElpXdK1B0OxaSX3TUb9NS04Jnarmw=;
 b=LH342scXBViKRp4PaDs6kjKSOEnREtBnYnr0I8hCUxzQ0NP4eFF2DzZdne347rsFlx
 dnKY0vtzJoNUBlatlcd9cUbzXG7BSdS92/5dcl1wd0ObhVGEE90GKrLV37eE3eYdbdP4
 5K/wA02RJT0tGz1tVNNKhg4PmjqIaceL813SwIdpJntzmAPIP5wOLjtUQPHJ3/a3W6Kw
 K/lzVM7eglPmbp7j1tONdGhPtS7fs/yyHSGTAxiLIorvXaMfVjPD43OS839UqhKN3wKD
 XAYi7U4Vkyo7UQAJW2IcHmuoW2Az0oSqKC3eNeec6qHTjCo/cqQFTR4gIuvMgs4+7JyZ
 lNZA==
X-Gm-Message-State: AOJu0YylBRXixpZhk5WLHDAdQOkg6twJGv6kGs3I8cU7mAnJKMUH2iZ4
 skKXrYD4wi8WfLjtm8Top6eJUHPfGBtsPHT8dNpn3KjLCKZxkpilbv4OdIU0FL/tO+A4j5CY1fQ
 50dNJZS4artkP5f87sfWxrjzX18n+dUih
X-Google-Smtp-Source: AGHT+IG6YeWown6XSmMCAdPtu0kR2XCl2Ne83SE+LyfvYpvtNypJDm0tciJVrMhNMNeY70KJh7PM2tmgOcA4JOjdj3Q=
X-Received: by 2002:a05:6a20:9143:b0:1d8:f2a2:23ee with SMTP id
 adf61e73a8af0-1d9a83d5a86mr6694336637.4.1730142527163; Mon, 28 Oct 2024
 12:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-5-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-5-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:08:35 -0400
Message-ID: <CADnq5_Nv+kMMRsV+5BfF2bM3USXeVxCfarxmo_k_1o5nk+cH3Q@mail.gmail.com>
Subject: Re: [PATCH 04/29] drm/amd/pm: add inst to set_powergating_by_smu
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

On Thu, Oct 24, 2024 at 11:18=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add an instance parameter to set_powergating_by_smu() function, and
> re-write all amd_pm functions accordingly. Then use the instance to
> call smu_dpm_set_vcn_enable().
>
> v2: remove duplicated functions.
>
> remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
> to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
> logic as before, until further separation in next patch.
>
> v3: add instance number in error message.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
>  5 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 2fa71f68205e..f24bc61df9a7 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -405,7 +405,9 @@ struct amd_pm_funcs {
>         int (*load_firmware)(void *handle);
>         int (*wait_for_fw_loading_complete)(void *handle);
>         int (*set_powergating_by_smu)(void *handle,
> -                               uint32_t block_type, bool gate);
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst);
>         int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
>         int (*set_power_limit)(void *handle, uint32_t n);
>         int (*get_power_limit)(void *handle, uint32_t *limit,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 9dc82f4d7c93..bcedbeec082f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCE:
>         case AMD_IP_BLOCK_TYPE_GFX:
> -       case AMD_IP_BLOCK_TYPE_VCN:
>         case AMD_IP_BLOCK_TYPE_SDMA:
>         case AMD_IP_BLOCK_TYPE_JPEG:
>         case AMD_IP_BLOCK_TYPE_GMC:
> @@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_de=
vice *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_VPE:
>                 if (pp_funcs && pp_funcs->set_powergating_by_smu)
>                         ret =3D (pp_funcs->set_powergating_by_smu(
> -                               (adev)->powerplay.pp_handle, block_type, =
gate));
> +                               (adev)->powerplay.pp_handle, block_type, =
gate, 0));
> +               break;
> +       case AMD_IP_BLOCK_TYPE_VCN:
> +               if (pp_funcs && pp_funcs->set_powergating_by_smu) {
> +                       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++=
)
> +                               ret =3D (pp_funcs->set_powergating_by_smu=
(
> +                                       (adev)->powerplay.pp_handle, bloc=
k_type, gate, i));
> +               }
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 8908646ad620..f0f81ecd9ad6 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3276,7 +3276,9 @@ static int kv_dpm_read_sensor(void *handle, int idx=
,
>  }
>
>  static int kv_set_powergating_by_smu(void *handle,
> -                               uint32_t block_type, bool gate)
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst)
>  {
>         switch (block_type) {
>         case AMD_IP_BLOCK_TYPE_UVD:
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index 26624a716fc6..90500b419d60 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1227,7 +1227,9 @@ static void pp_dpm_powergate_sdma(void *handle, boo=
l gate)
>  }
>
>  static int pp_set_powergating_by_smu(void *handle,
> -                               uint32_t block_type, bool gate)
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index bb7980f48674..c5ef8806dbb3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -354,10 +354,10 @@ static int smu_set_mall_enable(struct smu_context *=
smu)
>   */
>  static int smu_dpm_set_power_gate(void *handle,
>                                   uint32_t block_type,
> -                                 bool gate)
> +                                 bool gate,
> +                                 int inst)
>  {
>         struct smu_context *smu =3D handle;
> -       struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> @@ -374,12 +374,10 @@ static int smu_dpm_set_power_gate(void *handle,
>          */
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       ret =3D smu_dpm_set_vcn_enable(smu, !gate, i);
> -                       if (ret)
> -                               dev_err(smu->adev->dev, "Failed to power =
%s VCN instance %d!\n",
> -                                       gate ? "gate" : "ungate", i);
> -               }
> +               ret =3D smu_dpm_set_vcn_enable(smu, !gate, inst);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to power %s VCN i=
nstance %d!\n",
> +                               gate ? "gate" : "ungate", inst);
>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
>                 ret =3D smu_gfx_off_control(smu, gate);
> --
> 2.34.1
>
