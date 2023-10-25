Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8D2C0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 14:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C022F10E662;
	Wed, 25 Oct 2023 14:15:23 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F2A10E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 14:15:22 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-581de3e691dso3271128eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698243322; x=1698848122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=433cjQuAq+DlBySXGYGylk6DZIpSN43/8Q3A1fYAusA=;
 b=XJqzaS+XfB2gzW1CRTD/z2GFDp11NBMvk9FP7s6phAu1AbKjXKdjT6MSU2IJyCyxtm
 d6LXe//TyVeS/ut2KZashEqmYqK5sBvg/YqY/NFKSlrAbNDdjwZGF3o75+167mZ9bg7c
 xl7p6VS5up75iv732RUoEv3w5tMffwwPFUQmfgq8T1cR7jufq6r9Ad9QmbFb/GOASuSm
 XVTpUcig9+OGdjB6oZauZDyoyrY9SSmmw0X3K01lW7wk2H9VfOrGaMBYy2KvYmAMrGWT
 WY2CCuLsQNO9pfPGKIyVdh23cNncY1djMSHfgYXl1F/hfnVIiaSPmiuAfwyOxfvq+PYh
 6iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698243322; x=1698848122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=433cjQuAq+DlBySXGYGylk6DZIpSN43/8Q3A1fYAusA=;
 b=Waf1NeVzDNI+GdbdKatRBBZL9ZoCy45ycUZRXkB5ociVcv9/CIk54ON4u2fEYlp6Jj
 sbb2FSiJrtz3mnO+dvDgNzOqGp27ovsTOR8IsLEcB+mukY+/g1upK41ABJWXn9nSMyfD
 AiDATU97ksfzwybbLpFT9ovzze2K0twNK7SwEZA3Xkzekgmt8iWpGq8fsG03fY0u1d6U
 XrQeY1psYIihQEuC+BoQz8CYyS/r952JE/IB6pZYdh18yn8RSUgcyYqDro8S5GDTqw0x
 yb13oe7mNONr56bTbKmf+4Vj+/Ac7RfhSIMcVlk3TkC/4kUEf32tDy5iMubU3gkpcRIw
 NGRA==
X-Gm-Message-State: AOJu0YzaPGIaK3I7sdVqp+rn2e5eBbV/rTSBRJ2/nrQIIssj/ML5gkVc
 PaGA5527uF3EAa05QFm+5Xd34K0iZK6XA/KF96w=
X-Google-Smtp-Source: AGHT+IFNDuNKetKEGZxKlSp8+kAqE5X+HvEf6STO5b2aXN0VtRpunuLwi8HND5xiwKzEX07OOU16ewP7lXymHcPzEO8=
X-Received: by 2002:a05:6870:3d96:b0:1e9:bd5c:ae8b with SMTP id
 lm22-20020a0568703d9600b001e9bd5cae8bmr18782532oab.5.1698243321623; Wed, 25
 Oct 2023 07:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231025035035.766947-1-kenneth.feng@amd.com>
In-Reply-To: <20231025035035.766947-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Oct 2023 10:15:10 -0400
Message-ID: <CADnq5_M0=x=u72fXvmka9m2QLXUYi==jt5Fo=hm7D873mWqW6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
To: Kenneth Feng <kenneth.feng@amd.com>
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

On Tue, Oct 24, 2023 at 11:57=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com=
> wrote:
>
> fix the high voltage and temperature issue after the driver is unloaded o=
n smu 13.0.0,
> smu 13.0.7 and smu 13.0.10
> v2 - fix the code format and make sure it is used on the unload case only=
.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
>  7 files changed, 90 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 31f8c3ead161..c5c892a8b3f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3986,13 +3986,23 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>                                 }
>                         }
>                 } else {
> -                       tmp =3D amdgpu_reset_method;
> -                       /* It should do a default reset when loading or r=
eloading the driver,
> -                        * regardless of the module parameter reset_metho=
d.
> -                        */
> -                       amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
> -                       r =3D amdgpu_asic_reset(adev);
> -                       amdgpu_reset_method =3D tmp;
> +                       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +                       case IP_VERSION(13, 0, 0):
> +                       case IP_VERSION(13, 0, 7):
> +                       case IP_VERSION(13, 0, 10):
> +                               r =3D psp_gpu_reset(adev);
> +                               break;
> +                       default:
> +                               tmp =3D amdgpu_reset_method;
> +                               /* It should do a default reset when load=
ing or reloading the driver,
> +                                * regardless of the module parameter res=
et_method.
> +                                */
> +                               amdgpu_reset_method =3D AMD_RESET_METHOD_=
NONE;
> +                               r =3D amdgpu_asic_reset(adev);
> +                               amdgpu_reset_method =3D tmp;
> +                               break;
> +                       }
> +
>                         if (r) {
>                                 dev_err(adev->dev, "asic reset on init fa=
iled\n");
>                                 goto failed;
> @@ -5945,6 +5955,18 @@ int amdgpu_device_baco_exit(struct drm_device *dev=
)
>                 return -ENOTSUPP;
>
>         ret =3D amdgpu_dpm_baco_exit(adev);
> +
> +       if (!ret)
> +               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +               case IP_VERSION(13, 0, 0):
> +               case IP_VERSION(13, 0, 7):
> +               case IP_VERSION(13, 0, 10):
> +                       adev->gfx.is_poweron =3D false;
> +                       break;
> +               default:
> +                       break;
> +               }

Was it not possible to put this in the smu13 baco exit code?

> +
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 7c3356d6da5e..2e82172ba250 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
>         smu->adev =3D adev;
>         smu->pm_enabled =3D !!amdgpu_dpm;
>         smu->is_apu =3D false;
> -       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
> +       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
>         smu->smu_baco.platform_support =3D false;
>         smu->user_dpm_profile.fan_mode =3D -1;
>
> @@ -1740,10 +1740,31 @@ static int smu_smc_hw_cleanup(struct smu_context =
*smu)
>         return 0;
>  }
>
> +static int smu_reset_mp1_state(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +       int ret =3D 0;
> +
> +       if ((!adev->in_runpm) && (!adev->in_suspend) &&
> +               (!amdgpu_in_reset(adev)))
> +               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +                 case IP_VERSION(13, 0, 0):
> +                 case IP_VERSION(13, 0, 7):
> +                 case IP_VERSION(13, 0, 10):
> +                       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOA=
D);
> +                       break;

Is there any reason not to enable this on all dGPUs?

Alex

> +                 default:
> +                       break;
> +               }
> +
> +       return ret;
> +}
> +
>  static int smu_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
> +       int ret;
>
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
> @@ -1761,7 +1782,15 @@ static int smu_hw_fini(void *handle)
>
>         adev->pm.dpm_enabled =3D false;
>
> -       return smu_smc_hw_cleanup(smu);
> +       ret =3D smu_smc_hw_cleanup(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D smu_reset_mp1_state(smu);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
>  }
>
>  static void smu_late_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 1454eed76604..9f2dbc90b606 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -419,6 +419,7 @@ enum smu_reset_mode {
>  enum smu_baco_state {
>         SMU_BACO_STATE_ENTER =3D 0,
>         SMU_BACO_STATE_EXIT,
> +       SMU_BACO_STATE_NONE,
>  };
>
>  struct smu_baco_context {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index cc02f979e9e9..43c7ba68eb50 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -299,5 +299,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_conte=
xt *smu,
>                                      uint8_t pcie_gen_cap,
>                                      uint8_t pcie_width_cap);
>
> +int smu_v13_0_disable_pmfw_state(struct smu_context* smu);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index bcb7ab9d2221..0724441e53ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2473,3 +2473,16 @@ int smu_v13_0_update_pcie_parameters(struct smu_co=
ntext *smu,
>
>         return 0;
>  }
> +
> +int smu_v13_0_disable_pmfw_state(struct smu_context* smu)
> +{
> +       int ret;
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       WREG32_PCIE(MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff), 0)=
;
> +
> +       ret =3D RREG32_PCIE(MP1_Public |
> +                                          (smnMP1_FIRMWARE_FLAGS & 0xfff=
fffff));
> +
> +       return ret =3D=3D 0 ? 0 : -EINVAL;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 47d008cbc186..e2a09fe29e2f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2758,7 +2758,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_co=
ntext *smu,
>
>         switch (mp1_state) {
>         case PP_MP1_STATE_UNLOAD:
> -               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                                               SMU_MSG_P=
repareMp1ForUnload,
> +                                                               0x55, NUL=
L);
> +
> +               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXI=
T)
> +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> +
>                 break;
>         default:
>                 /* Ignore others */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index b8a7a1d853df..2a0d1da18a9b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2429,7 +2429,13 @@ static int smu_v13_0_7_set_mp1_state(struct smu_co=
ntext *smu,
>
>         switch (mp1_state) {
>         case PP_MP1_STATE_UNLOAD:
> -               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                                               SMU_MSG_P=
repareMp1ForUnload,
> +                                                               0x55, NUL=
L);
> +
> +               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXI=
T)
> +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> +
>                 break;
>         default:
>                 /* Ignore others */
> --
> 2.34.1
>
