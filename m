Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28081C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 13:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF1A10E5B7;
	Fri, 20 Oct 2023 13:58:42 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B72510E5B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 13:58:41 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dc9c2b2b79so532659fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697810320; x=1698415120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri7xTIQdzEfo9Kbb5rIxOB+1V3JXqZQJavnU0h+049g=;
 b=cEkh5euTpE+voNTZfSrbp0ICTaEx8ZUgBvmhr55SXShzImnVTGJKbuw/t0cCn+o4mO
 99iohVIchsJor2+prUlkWqe/6vm6GEDpaye4dwSRW6Mw5uk1ZrgNvBSGNtjoDUlNV5RY
 sBFxvIPBEgD3W72gkycEAr0YwiO3XubUsSfkDWJ5g63dd39gHd32Cyd+61Tovgr93zT4
 6GeeLX2z0Go+a+KBv84R4RTYck+w+WRuaWhGV/3VSD3KAOcuH95cukE3embw40bHAqE+
 23jjZNROGisdfEu31vtQRp0gQ5CNl9UqK3NV9cuaMi0CwonRqxlTikO5kXlmjnbaVB3d
 g7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810320; x=1698415120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri7xTIQdzEfo9Kbb5rIxOB+1V3JXqZQJavnU0h+049g=;
 b=OHLkhI+1Pn+A7U8C1pypDZrPljBsd93sZnaoW/WWbbT7VDNB5CLbCiZOWY8VlkvW2J
 JSC696atYOsm92Sj/wchH3FK+iwNs9Gxgs9kS26YwoJ5og1JntwmZFrB5py8rBW5a+43
 0Zkb1GtIp0fJYRkPoCWVu1LxJpbCnjpvNQEYoTDqxX38MS2b1HVb2K8ivpNXssC8SQQR
 Caq7pIlGj8pZh9ThoYLjEWaAjwOtKPP2JRsh6fb+hoq63t8a1HR0p2hmp1PCB99uK+oe
 MwtWZFuaZUpH7LvhkOcasiEEbUtk1+8paHiDoNV8tKctgQ/ck1EjgBpwrWvA3XlOi+sY
 DbnQ==
X-Gm-Message-State: AOJu0YxS/4sQA3nSd/37/YvpZdMdDcLDcrDelRytATV7YeHAVrZmxjbN
 BUDow/LGUPA/yYmYQB+kdPdrmSAViHw0KYTIL1q7LcNepxM=
X-Google-Smtp-Source: AGHT+IGfXprCj97DQaasSdILzzSwiw06vi37f86Xu3t+LdvN5oO1bMYBtR7cH8n1Xfk2n/e++unb0JyW3qIzjWrAl6g=
X-Received: by 2002:a05:6870:568a:b0:1d0:f5bd:6e9 with SMTP id
 p10-20020a056870568a00b001d0f5bd06e9mr1985763oao.22.1697810320233; Fri, 20
 Oct 2023 06:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231020081558.739636-1-kenneth.feng@amd.com>
In-Reply-To: <20231020081558.739636-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Oct 2023 09:58:29 -0400
Message-ID: <CADnq5_P6092B8sJQf0-_gdLOSr0Q68STNhSRfAE41xy-YE8n4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the high voltage and temperature issue on
 smu 13
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
Cc: kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 20, 2023 at 4:32=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> fix the high voltage and temperature issue after the driver is unloaded o=
n smu 13.0.0,
> smu 13.0.7 and smu 13.0.10
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 ++++++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
>  8 files changed, 86 insertions(+), 13 deletions(-)
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

Maybe better to move this into smu_v13_0_0_baco_exit() so we keep the
asic specific details out of the common files?

> +
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 80ca2c05b0b8..3ad38e42773b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -73,7 +73,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device=
 *adev,
>                  * fini/suspend, so the overall state doesn't
>                  * change over the course of suspend/resume.
>                  */
> -               if (!adev->in_s0ix)
> +               if (!adev->in_s0ix && adev->gfx.is_poweron)
>                         amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB=
(0), false);
>                 break;
>         case AMDGPU_IRQ_STATE_ENABLE:
> @@ -85,7 +85,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device=
 *adev,
>                  * fini/suspend, so the overall state doesn't
>                  * change over the course of suspend/resume.
>                  */
> -               if (!adev->in_s0ix)
> +               if (!adev->in_s0ix && adev->gfx.is_poweron)
>                         amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB=
(0), true);
>                 break;
>         default:


These changes are probably a valid bug fix on their own.

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 7c3356d6da5e..30e5f7161737 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
>         smu->adev =3D adev;
>         smu->pm_enabled =3D !!amdgpu_dpm;
>         smu->is_apu =3D false;
> -       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
> +       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;


I'm not sure I understand this change.  Is this just to set the
default BACO state?  Maybe this would be better as a separate patch.

>         smu->smu_baco.platform_support =3D false;
>         smu->user_dpm_profile.fan_mode =3D -1;
>
> @@ -1740,10 +1740,25 @@ static int smu_smc_hw_cleanup(struct smu_context =
*smu)
>         return 0;
>  }
>
> +static int smu_reset_mp1_state(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 0):
> +       case IP_VERSION(13, 0, 7):
> +       case IP_VERSION(13, 0, 10):
> +               return smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +       default:
> +               return 0;
> +       }
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
> @@ -1761,7 +1776,15 @@ static int smu_hw_fini(void *handle)
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
> index 47d008cbc186..0a167f70f4bc 100644
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
> +               if(!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT=
)

space between if and (

> +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> +
>                 break;
>         default:
>                 /* Ignore others */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index b8a7a1d853df..d7a4a03b1e31 100644
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
> +               if(!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT=
)

Same here.

Alex

> +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> +
>                 break;
>         default:
>                 /* Ignore others */
> --
> 2.34.1
>
