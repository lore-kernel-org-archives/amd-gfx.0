Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ED3C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 14:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4289B10E20A;
	Mon, 23 Oct 2023 14:56:48 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD11C10E20A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 14:56:43 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e9bb3a0bfeso2723078fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698073003; x=1698677803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oOFnXrIhJ0PgMaZYzi8GJRtKeKsYGjqGroiBj5448M=;
 b=g0xhnrZhRWUhPHzdaGOQyHQTqGoz8AG/EkOP7lWUCOJwrRYgLK3oR6+mT1GKrtZv/1
 esoKjII0oPk5bxm1iHAiekPlDOEERzrARjuBBhTueqv6z993aSDOcEXnmoQx6QVg6U5U
 DnAtm4dLIYef3tjHO6jzHUu2ULZ8SnUKa4pDnKPiAD8uciq+4frhkbnVCsyoQT3LxEzO
 N5NDlEs4xcdfq+kuLsVCbslbAIL1tEpxuCfbSQvJauazmppNuPE6cNsYiDiQ1sdRMzgm
 Lc9lDvWmgGwpm2Ft8XgOEle1FNCIbu61hV7RScbZGtOXuIg2TnJt0FuJb+79b7OF6H99
 WeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073003; x=1698677803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oOFnXrIhJ0PgMaZYzi8GJRtKeKsYGjqGroiBj5448M=;
 b=redJIJeQljfUmpm5/O0EyCH4O38kMS0J3zY4IAvvnAI68l2nVrv1T7mBK8/M+w4Jfm
 EqkdUtEyBpAOwRrm1ZpRMwGpCCJkVfSWipSJn13CvWOtOn3AReF3cNKwApmzcU2IgYIE
 xlqBv+jDsFk39q6XCrF784GZAiu38f8ZxujOzK78j1nK+4ehOw+/lxd8IevKPe8YGNah
 nwPeHV2Y1CSlgS+1ygjyh4oVYXHVR2hx5ilXiMenvM7uELA0ahrXxYxB5QKxVHQ51fUa
 nJOGRCJqJ/hSKakx0I7UkTIPJuQpgBH/wd0d7pf8anme69Y0mufp6D/IzoKT6ROFR22Y
 toJQ==
X-Gm-Message-State: AOJu0YwTSIvERxT5kpdm6Q+n/XMgdPuHrTBhoLbLVtMtl3Gv4lFiRlvr
 zbI8ja8pK6JvPUnVylXjm95CkKRbS+M05fq7qnu+pkoq
X-Google-Smtp-Source: AGHT+IHrmD+r42ev5bLrCqF22X9VAlxUiFhVFbLF/+LYcWbNBgtSMLwAzE6qXOOvMm6MWEpGcyAXwBMNqCnvhzFRG4g=
X-Received: by 2002:a05:6870:120b:b0:1d5:91d6:65f3 with SMTP id
 11-20020a056870120b00b001d591d665f3mr9627420oan.7.1698073002809; Mon, 23 Oct
 2023 07:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231020081558.739636-1-kenneth.feng@amd.com>
 <CADnq5_P6092B8sJQf0-_gdLOSr0Q68STNhSRfAE41xy-YE8n4w@mail.gmail.com>
 <DM4PR12MB5165ACD77658867A878DE6048ED8A@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165ACD77658867A878DE6048ED8A@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Oct 2023 10:56:31 -0400
Message-ID: <CADnq5_MVNEhQ6suWvvhu_F+MVQ-OX=-uR0n1qdzqtJihRm7kSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the high voltage and temperature issue on
 smu 13
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Oct 22, 2023 at 9:05=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - General]
>
> Thanks Alex, I will make another patch.
> And please refer to the comments inline below.
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 20, 2023 9:58 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
> Subject: Re: [PATCH] drm/amd/pm: fix the high voltage and temperature iss=
ue on smu 13
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Fri, Oct 20, 2023 at 4:32=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.co=
m> wrote:
> >
> > fix the high voltage and temperature issue after the driver is
> > unloaded on smu 13.0.0, smu 13.0.7 and smu 13.0.10
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 ++++++++++++--
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
> > drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
> >  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-
> > .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
> >  8 files changed, 86 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 31f8c3ead161..c5c892a8b3f9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3986,13 +3986,23 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >                                 }
> >                         }
> >                 } else {
> > -                       tmp =3D amdgpu_reset_method;
> > -                       /* It should do a default reset when loading or=
 reloading the driver,
> > -                        * regardless of the module parameter reset_met=
hod.
> > -                        */
> > -                       amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
> > -                       r =3D amdgpu_asic_reset(adev);
> > -                       amdgpu_reset_method =3D tmp;
> > +                       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> > +                       case IP_VERSION(13, 0, 0):
> > +                       case IP_VERSION(13, 0, 7):
> > +                       case IP_VERSION(13, 0, 10):
> > +                               r =3D psp_gpu_reset(adev);
> > +                               break;
> > +                       default:
> > +                               tmp =3D amdgpu_reset_method;
> > +                               /* It should do a default reset when lo=
ading or reloading the driver,
> > +                                * regardless of the module parameter r=
eset_method.
> > +                                */
> > +                               amdgpu_reset_method =3D AMD_RESET_METHO=
D_NONE;
> > +                               r =3D amdgpu_asic_reset(adev);
> > +                               amdgpu_reset_method =3D tmp;
> > +                               break;
> > +                       }
> > +
> >                         if (r) {
> >                                 dev_err(adev->dev, "asic reset on init =
failed\n");
> >                                 goto failed; @@ -5945,6 +5955,18 @@
> > int amdgpu_device_baco_exit(struct drm_device *dev)
> >                 return -ENOTSUPP;
> >
> >         ret =3D amdgpu_dpm_baco_exit(adev);
> > +
> > +       if (!ret)
> > +               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> > +               case IP_VERSION(13, 0, 0):
> > +               case IP_VERSION(13, 0, 7):
> > +               case IP_VERSION(13, 0, 10):
> > +                       adev->gfx.is_poweron =3D false;
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
>
> Maybe better to move this into smu_v13_0_0_baco_exit() so we keep the asi=
c specific details out of the common files?
>
> > +
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > index 80ca2c05b0b8..3ad38e42773b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -73,7 +73,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_devi=
ce *adev,
> >                  * fini/suspend, so the overall state doesn't
> >                  * change over the course of suspend/resume.
> >                  */
> > -               if (!adev->in_s0ix)
> > +               if (!adev->in_s0ix && adev->gfx.is_poweron)
> >                         amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXH=
UB(0), false);
> >                 break;
> >         case AMDGPU_IRQ_STATE_ENABLE:
> > @@ -85,7 +85,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_devi=
ce *adev,
> >                  * fini/suspend, so the overall state doesn't
> >                  * change over the course of suspend/resume.
> >                  */
> > -               if (!adev->in_s0ix)
> > +               if (!adev->in_s0ix && adev->gfx.is_poweron)
> >                         amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXH=
UB(0), true);
> >                 break;
> >         default:
>
>
> These changes are probably a valid bug fix on their own.
> [Kenneth] -  When driver is unloaded, gfx core is powered off first. Then=
 in gmc_hw_fini, the gfxhub interruption operation needs to be skipped. Do =
we need a separate patch for this?

Would this trigger in any other cases?  E.g., suspend/resume?  If so,
I think it makes sense as a standalone bug fix.  If not, it's fine to
include it in this patch.

>
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 7c3356d6da5e..30e5f7161737 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
> >         smu->adev =3D adev;
> >         smu->pm_enabled =3D !!amdgpu_dpm;
> >         smu->is_apu =3D false;
> > -       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
> > +       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
>
>
> I'm not sure I understand this change.  Is this just to set the default B=
ACO state?  Maybe this would be better as a separate patch.
> [Kenneth] - smu->smu_baco.state is needed when driver is unloaded, if it'=
s baco exited, then need to reset MP1_FIRMWARE_FLAG =3D 0, otherwise MP1_FI=
RMWARE_FLAG doesn't need to be reset.
> Currently by default  smu->smu_baco.state is baco exited status, we can't=
 recognize if it's really a hardware baco exited status. Do you think we st=
ill need a separate patch for it?

No, this makes sense.  I just want to verify the reason for the
change.  It would be nice to include this detail in the commit
message.

>
> >         smu->smu_baco.platform_support =3D false;
> >         smu->user_dpm_profile.fan_mode =3D -1;
> >
> > @@ -1740,10 +1740,25 @@ static int smu_smc_hw_cleanup(struct smu_contex=
t *smu)
> >         return 0;
> >  }
> >
> > +static int smu_reset_mp1_state(struct smu_context *smu) {
> > +       struct amdgpu_device *adev =3D smu->adev;
> > +
> > +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> > +       case IP_VERSION(13, 0, 0):
> > +       case IP_VERSION(13, 0, 7):
> > +       case IP_VERSION(13, 0, 10):
> > +               return smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> > +       default:
> > +               return 0;
> > +       }
> > +}
> > +
> >  static int smu_hw_fini(void *handle)
> >  {
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >         struct smu_context *smu =3D adev->powerplay.pp_handle;
> > +       int ret;
> >
> >         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> >                 return 0;
> > @@ -1761,7 +1776,15 @@ static int smu_hw_fini(void *handle)
> >
> >         adev->pm.dpm_enabled =3D false;
> >
> > -       return smu_smc_hw_cleanup(smu);
> > +       ret =3D smu_smc_hw_cleanup(smu);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D smu_reset_mp1_state(smu);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> >  }
> >
> >  static void smu_late_fini(void *handle) diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index 1454eed76604..9f2dbc90b606 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -419,6 +419,7 @@ enum smu_reset_mode {  enum smu_baco_state {
> >         SMU_BACO_STATE_ENTER =3D 0,
> >         SMU_BACO_STATE_EXIT,
> > +       SMU_BACO_STATE_NONE,
> >  };
> >
> >  struct smu_baco_context {
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > index cc02f979e9e9..43c7ba68eb50 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > @@ -299,5 +299,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_con=
text *smu,
> >                                      uint8_t pcie_gen_cap,
> >                                      uint8_t pcie_width_cap);
> >
> > +int smu_v13_0_disable_pmfw_state(struct smu_context* smu);
> > +
> >  #endif
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > index bcb7ab9d2221..0724441e53ef 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > @@ -2473,3 +2473,16 @@ int smu_v13_0_update_pcie_parameters(struct
> > smu_context *smu,
> >
> >         return 0;
> >  }
> > +
> > +int smu_v13_0_disable_pmfw_state(struct smu_context* smu) {
> > +       int ret;
> > +       struct amdgpu_device *adev =3D smu->adev;
> > +
> > +       WREG32_PCIE(MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff),
> > + 0);
> > +
> > +       ret =3D RREG32_PCIE(MP1_Public |
> > +                                          (smnMP1_FIRMWARE_FLAGS &
> > + 0xffffffff));
> > +
> > +       return ret =3D=3D 0 ? 0 : -EINVAL; }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 47d008cbc186..0a167f70f4bc 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2758,7 +2758,13 @@ static int smu_v13_0_0_set_mp1_state(struct
> > smu_context *smu,
> >
> >         switch (mp1_state) {
> >         case PP_MP1_STATE_UNLOAD:
> > -               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
> > +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > +                                                               SMU_MSG=
_PrepareMp1ForUnload,
> > +                                                               0x55,
> > + NULL);
> > +
> > +               if(!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EX=
IT)
>
> space between if and (
>
> > +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> > +
> >                 break;
> >         default:
> >                 /* Ignore others */
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index b8a7a1d853df..d7a4a03b1e31 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2429,7 +2429,13 @@ static int smu_v13_0_7_set_mp1_state(struct
> > smu_context *smu,
> >
> >         switch (mp1_state) {
> >         case PP_MP1_STATE_UNLOAD:
> > -               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
> > +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > +                                                               SMU_MSG=
_PrepareMp1ForUnload,
> > +                                                               0x55,
> > + NULL);
> > +
> > +               if(!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EX=
IT)
>
> Same here.
>
> Alex
>
> > +                       ret =3D smu_v13_0_disable_pmfw_state(smu);
> > +
> >                 break;
> >         default:
> >                 /* Ignore others */
> > --
> > 2.34.1
> >
