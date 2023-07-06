Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F314EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3764C10E408;
	Thu,  6 Jul 2023 14:05:35 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F610E408
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:05:34 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a1d9b64837so770584b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688652333; x=1691244333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSNUlAfDQUYKP3k2dpSzGiIZ0Mz3C+qiMTVkZqlt6qQ=;
 b=GXFMi6E+MFLWdsI+aDbg/UxI2Mg1Moq/XXW93h0rZrGY4rGjCw33YY4yXvPcfDOx9O
 /BRS59zMKCjSSJI/jJML+tZbVZSr0rOqquFOXbUOZKpuPrXDGPorFMtOm8KLIqa06S0c
 kbSTifsxYdZL1xK5c8009nbuOtCIPXByk0pJ45J+LwOd3u5YNZaiWcTUqtjk6IK+3Xol
 uGJIO2WxAb+dQ7wQ1ETTvkBSusEHGgc5qqb3o26xFdaLApLlOrzFcYPrUsTUkBhcYOZa
 qx96qMh3+VORCGAAZVxruJnY4ZmHaOfA/wMdqEyV/SajGgNCXacvekk/B+hKdVLmmyZy
 LKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652333; x=1691244333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSNUlAfDQUYKP3k2dpSzGiIZ0Mz3C+qiMTVkZqlt6qQ=;
 b=ZtzmXj7ioDkUdmIwIwf8bYUqQOarYSJuzmSiK2xzmiaqu3VHsqslBvv460GNCUVN5V
 NnRTTuvNXeJ/NSfMDIIOkZv2vYt4xTfR1cGpAi28E85TqwgORG+sRiC+jzJ/IuHzaGgU
 c/jCm/yiGy8UCe4KuQVqOxYNi4cfp/b8jr9UGIj3nn/+EK+mN5BLpaOqNK3USd/G30//
 Cnub4SNYHXZ2HI1ii2tu1XxBySz5CyDA1S+BAcwwuwnClmygJK3BnKphbI0ATZ4IV7lC
 FPXNTwV0XPhcdCgANSn3x7ztUw2dR7d9Nyv+WsJmf5SQTVcGHPWxyUp1/hwsCvLNETmT
 JC/A==
X-Gm-Message-State: ABy/qLaffyPDtEumJjKPK1E2PJuDc9JZLVEOAol18GBOpMZ2WM70UjIW
 z/gcBxprYLTKn7QYz+PYLh2rP3nn9ZMBQ1/BX2c=
X-Google-Smtp-Source: APBJJlG2tA6vt+3ZKfVnXTfgUnnvQ4HJ25iAo3Gz479hmoq35K+T4XbP1lkdHSvrrOxH+w/0VKF7puY29nFTCIqgDRM=
X-Received: by 2002:a05:6808:308:b0:3a3:9073:856f with SMTP id
 i8-20020a056808030800b003a39073856fmr2365610oie.3.1688652332822; Thu, 06 Jul
 2023 07:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230706120102.2174734-1-danijel.slivka@amd.com>
In-Reply-To: <20230706120102.2174734-1-danijel.slivka@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 10:05:21 -0400
Message-ID: <CADnq5_OSxDQ=7Kpa6k5qwTbnTcfwtQ0e+EB0Wj9xfSEO-chCsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check whether smu is idle in sriov case
To: Danijel Slivka <danijel.slivka@amd.com>
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, Nikola Prica <nikola.prica@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 8:01=E2=80=AFAM Danijel Slivka <danijel.slivka@amd.c=
om> wrote:
>
> Why:
> If the reg mmMP1_SMN_C2PMSG_90 is being programed to 0x0 before
> guest initialization, then modprobe amdgpu will fail at smu hw_init.
> (the default mmMP1_SMN_C2PMSG_90 at a clean guest environment is 0x1).
>
> How to fix:
> this patch is to check whether smu is idle by sending a test
> message to smu. If smu is idle, it will respond.
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 +
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 40 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
>  7 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ce41a8309582..63ea4cd32ece 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1443,6 +1443,14 @@ static int smu_start_smc_engine(struct smu_context=
 *smu)
>                 }
>         }
>
> +       if (amdgpu_sriov_vf(adev) && smu->ppt_funcs->wait_smu_idle) {
> +               ret =3D smu->ppt_funcs->wait_smu_idle(smu);
> +               if (ret) {
> +                       dev_err(adev->dev, "SMU is not idle\n");
> +                       return ret;
> +               }
> +       }
> +
>         /*
>          * Send msg GetDriverIfVersion to check if the return value is eq=
ual
>          * with DRIVER_IF_VERSION of smc header.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..1bf87ad30d93 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -926,6 +926,13 @@ struct pptable_funcs {
>          */
>         int (*check_fw_status)(struct smu_context *smu);
>
> +       /**
> +        * @wait_smu_idle: wait for SMU idle status.
> +        *
> +        * Return: Zero if check passes, negative errno on failure.
> +        */
> +       int (*wait_smu_idle)(struct smu_context *smu);
> +
>         /**
>          * @set_mp1_state: put SMU into a correct state for comming
>          *                 resume from runpm or gpu reset.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v11_0.h
> index d466db6f0ad4..f3293ddd1a1b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -165,6 +165,8 @@ int smu_v11_0_fini_power(struct smu_context *smu);
>
>  int smu_v11_0_check_fw_status(struct smu_context *smu);
>
> +int smu_v11_0_wait_smu_idle(struct smu_context *smu);
> +
>  int smu_v11_0_setup_pptable(struct smu_context *smu);
>
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index c94d825a871b..f4e7596dcdcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3503,6 +3503,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
>         .init_power =3D smu_v11_0_init_power,
>         .fini_power =3D smu_v11_0_fini_power,
>         .check_fw_status =3D smu_v11_0_check_fw_status,
> +       .wait_smu_idle =3D smu_v11_0_wait_smu_idle,

Drop the smu_v11_0 wrapper and just use the cmn function directly.

>         .setup_pptable =3D navi10_setup_pptable,
>         .get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
>         .check_fw_version =3D smu_v11_0_check_fw_version,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index aa4a5498a12f..059dc2243c06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -195,6 +195,11 @@ int smu_v11_0_check_fw_status(struct smu_context *sm=
u)
>         return -EIO;
>  }
>
> +int smu_v11_0_wait_smu_idle(struct smu_context *smu)
> +{
> +       return smu_wait_smu_idle(smu);
> +}

Drop this.

> +
>  int smu_v11_0_check_fw_version(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index 3ecb900e6ecd..5dc81d7b04da 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -313,6 +313,46 @@ int smu_cmn_wait_for_response(struct smu_context *sm=
u)
>         return res;
>  }
>
> +/**
> + * smu_wait_smu_idle -- wait for smu to become idle
> + * @smu: pointer to an SMU context
> + *
> + * Send SMU_MSG_TestMessage to check whether SMU is idle.
> + * If SMU is idle, it will respond.
> + * The returned parameter will be the param you pass + 1.
> + *
> + * Return 0 on success, -errno on error, indicating the execution
> + * status and result of the message being waited for. See
> + * __smu_cmn_reg2errno() for details of the -errno.
> + */
> +int smu_wait_smu_idle(struct smu_context *smu)

Rename this smu_cmn_wait_smu_idle() for consistency.

Alex

> +{
> +       u32 reg;
> +       u32 param =3D 0xff00011;
> +       uint32_t read_arg;
> +       int res, index;
> +
> +       index =3D smu_cmn_to_asic_specific_index(smu,
> +                                              CMN2ASIC_MAPPING_MSG,
> +                                              SMU_MSG_TestMessage);
> +
> +       __smu_cmn_send_msg(smu, index, param);
> +       reg =3D __smu_cmn_poll_stat(smu);
> +       res =3D __smu_cmn_reg2errno(smu, reg);
> +
> +       if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERR=
OR) &&
> +           res && (res !=3D -ETIME)) {
> +               amdgpu_device_halt(smu->adev);
> +               WARN_ON(1);
> +       }
> +
> +       smu_cmn_read_arg(smu, &read_arg);
> +       if (read_arg =3D=3D param + 1)
> +               return 0;
> +       return res;
> +}
> +
> +
>  /**
>   * smu_cmn_send_smc_msg_with_param -- send a message with parameter
>   * @smu: pointer to an SMU context
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.h
> index d7cd358a53bd..abe875513d77 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_co=
ntext *smu,
>
>  int smu_cmn_wait_for_response(struct smu_context *smu);
>
> +int smu_wait_smu_idle(struct smu_context *smu);
> +
>  int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                                    enum smu_cmn2asic_mapping_type type,
>                                    uint32_t index);
> --
> 2.25.1
>
