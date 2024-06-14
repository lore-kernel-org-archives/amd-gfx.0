Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE086C27C77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 18:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56ACC10EE16;
	Fri, 14 Jun 2024 18:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2em2Gr/";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDBF10EE16
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 18:02:49 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso1830465a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718388168; x=1718992968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z2rnZbJ35wtL5blv5/zWtBIbpHGn75BnmAtKiK9Qp0=;
 b=j2em2Gr/DMdx/b8BGP0oG0qye3uhtTr5rYoEgYFFl7FmLJOpcye1kT7YuidBJV1tq5
 mjZufs7N26kLKhei+gPRLPPWviBRCAISAOM9+m3Gk6kiUNJZkX5KfDrsHEFMo6XxxybY
 8tSsYoEUOkcesr3tFUrswyEbP/H/Goy0CdItYAMeXyCHTURUBrfp1UqjGjqiH3iHhadX
 8l0kkp458PY+iDhChaK33odUXw4oyUfciNqzYPVjaTdN+KC38fi6DCbsDAJgJ7VKeZrd
 V54S+0gA0tYDsM2WYNJ7x1gmduvGOKSmz5Ch0FowX7xz2TIHUBGmX/X5fuzmFvYHIulY
 qwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718388168; x=1718992968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2z2rnZbJ35wtL5blv5/zWtBIbpHGn75BnmAtKiK9Qp0=;
 b=DMy74b9YoS2YboMuFxIrIz273IoFaEqHU+EFJ39OMGMQMjrjMUd7goy6WM6nSJ/4k6
 gKHgdRK6UJDs802mY8V7ZerdZaKeWu/afZxgePV4j1VTFJH5p/u7EkW8Fv5U9U3+/uxy
 6AailyDRhBFCrFPhhQW7sP+W4mtxFcuzP8c2rT9c3dmgaznWfiAkF0C1/arWohzl940J
 f5QvvDO1j3ri8Uo9+TtU8R6e4tTe/Xu3cxi7w9eHkGZ/Pk8LREFflJ3u+aGbdWdaaY4/
 MkGfm9pSftdwNRWr9j/9o27Db+/Ww1DgCFQ9/rlTlpnx3pfuONCjiaLXndqhaFGwSRLn
 xWCA==
X-Gm-Message-State: AOJu0YzIFYH78gN4pxXOyFFMnjVOQ/osds4rVLaBV9Au5mg7o7nzKkrV
 XIJxEGJnAI4VFEReecvju+7RWLP+4fdjPu38Lfm39MpfgM3MM/8J7jxJDp+6dKOYWDF7mSWKXUx
 6VR/ox5JVPFChLuh1akEI4X8x61OzQQ==
X-Google-Smtp-Source: AGHT+IEIvK9yAdvVFsbfpbmIIqa0OcmUAIV5C/HWaP0WhuYPTeTaD38CPs+uQj8WXqb0isL7QJigcLQu//QOkJUWCWs=
X-Received: by 2002:a17:90a:ae06:b0:2c2:f6a3:3043 with SMTP id
 98e67ed59e1d1-2c4db133ea3mr3854899a91.9.1718388168430; Fri, 14 Jun 2024
 11:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240611042440.1988379-1-li.ma@amd.com>
In-Reply-To: <20240611042440.1988379-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jun 2024 14:02:37 -0400
Message-ID: <CADnq5_P-x_pnWZK9qekX9zoC=WmknnJpLx-p3cdUbkoBV0BAvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/swsmu: add MALL init support workaround for
 smu_v14_0_1
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, yifan1.zhang@amd.com, Tim Huang <Tim.Huang@amd.com>
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

On Tue, Jun 11, 2024 at 12:42=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> [Why]
> SMU firmware has not supported MALL PG.
>
> [How]
> Disable MALL PG and make it always on until SMU firmware is ready.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++
>  .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 73 +++++++++++++++++++
>  5 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 6f742d88867d..8e694b576d1c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -325,6 +325,18 @@ static int smu_dpm_set_umsch_mm_enable(struct smu_co=
ntext *smu,
>         return ret;
>  }
>
> +static int smu_set_mall_enable(struct smu_context *smu)
> +{
> +       int ret =3D 0;
> +
> +       if (!smu->ppt_funcs->set_mall_enable)
> +               return 0;
> +
> +       ret =3D smu->ppt_funcs->set_mall_enable(smu);
> +
> +       return ret;
> +}
> +
>  /**
>   * smu_dpm_set_power_gate - power gate/ungate the specific IP block
>   *
> @@ -1804,6 +1816,7 @@ static int smu_hw_init(void *handle)
>                 smu_dpm_set_jpeg_enable(smu, true);
>                 smu_dpm_set_vpe_enable(smu, true);
>                 smu_dpm_set_umsch_mm_enable(smu, true);
> +               smu_set_mall_enable(smu);
>                 smu_set_gfx_cgpg(smu, true);
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3f94c33df7b7..a34c802f52be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1408,6 +1408,11 @@ struct pptable_funcs {
>          */
>         int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enab=
le);
>
> +       /**
> +        * @set_mall_enable: Init MALL power gating control.
> +        */
> +       int (*set_mall_enable)(struct smu_context *smu);
> +
>         /**
>          * @notify_rlc_state: Notify RLC power state to SMU.
>          */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h=
 b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
> index c4dc5881d8df..e7f5ef49049f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
> @@ -106,8 +106,8 @@
>  #define PPSMC_MSG_DisableLSdma                  0x35 ///< Disable LSDMA
>  #define PPSMC_MSG_SetSoftMaxVpe                 0x36 ///<
>  #define PPSMC_MSG_SetSoftMinVpe                 0x37 ///<
> -#define PPSMC_MSG_AllocMALLCache                0x38 ///< Allocating MAL=
L Cache
> -#define PPSMC_MSG_ReleaseMALLCache              0x39 ///< Releasing MALL=
 Cache
> +#define PPSMC_MSG_MALLPowerController           0x38 ///< Set MALL contr=
ol
> +#define PPSMC_MSG_MALLPowerState                0x39 ///< Enter/Exit MAL=
L PG
>  #define PPSMC_Message_Count                     0x3A ///< Total number o=
f PPSMC messages
>  /** @}*/
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index dff36bd7a17c..12a7b0634ed5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -273,7 +273,9 @@
>         __SMU_DUMMY_MAP(GetMetricsVersion), \
>         __SMU_DUMMY_MAP(EnableUCLKShadow), \
>         __SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
> -       __SMU_DUMMY_MAP(SelectPstatePolicy),
> +       __SMU_DUMMY_MAP(SelectPstatePolicy), \
> +       __SMU_DUMMY_MAP(MALLPowerController), \
> +       __SMU_DUMMY_MAP(MALLPowerState),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index e4419e1561ef..18abfbd6d059 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -52,6 +52,19 @@
>  #define mmMP1_SMN_C2PMSG_90                    0x029a
>  #define mmMP1_SMN_C2PMSG_90_BASE_IDX               0
>
> +/* MALLPowerController message arguments (Defines for the Cache mode con=
trol) */
> +#define SMU_MALL_PMFW_CONTROL 0
> +#define SMU_MALL_DRIVER_CONTROL 1
> +
> +/*
> + * MALLPowerState message arguments
> + * (Defines for the Allocate/Release Cache mode if in driver mode)
> + */
> +#define SMU_MALL_EXIT_PG 0
> +#define SMU_MALL_ENTER_PG 1
> +
> +#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALW=
AYS_ON
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)
>  #define SMC_DPM_FEATURE ( \
>         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
> @@ -66,6 +79,12 @@
>         FEATURE_MASK(FEATURE_GFX_DPM_BIT)       | \
>         FEATURE_MASK(FEATURE_VPE_DPM_BIT))
>
> +enum smu_mall_pg_config {
> +       SMU_MALL_PG_CONFIG_PMFW_CONTROL =3D 0,
> +       SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON =3D 1,
> +       SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF =3D 2,
> +};
> +
>  static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
                       1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,=
                       1),
> @@ -113,6 +132,8 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_messag=
e_map[SMU_MSG_MAX_COUNT] =3D
>         MSG_MAP(PowerDownUmsch,                 PPSMC_MSG_PowerDownUmsch,=
                       1),
>         MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe, =
                       1),
>         MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe, =
                       1),
> +       MSG_MAP(MALLPowerController,            PPSMC_MSG_MALLPowerContro=
ller,          1),
> +       MSG_MAP(MALLPowerState,                 PPSMC_MSG_MALLPowerState,=
                       1),
>  };
>
>  static struct cmn2asic_mapping smu_v14_0_0_feature_mask_map[SMU_FEATURE_=
COUNT] =3D {
> @@ -1423,6 +1444,57 @@ static int smu_v14_0_common_get_dpm_table(struct s=
mu_context *smu, struct dpm_cl
>         return 0;
>  }
>
> +static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, e=
num smu_mall_pg_config pg_config)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +       int ret =3D 0;
> +
> +       if (pg_config =3D=3D SMU_MALL_PG_CONFIG_PMFW_CONTROL) {
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALL=
PowerController,
> +                                                               SMU_MALL_=
PMFW_CONTROL, NULL);
> +               if (ret) {
> +                       dev_err(adev->dev, "Init MALL PMFW CONTROL Failur=
e\n");
> +                       return ret;
> +               }
> +       } else {
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALL=
PowerController,
> +                                                               SMU_MALL_=
DRIVER_CONTROL, NULL);
> +               if (ret) {
> +                       dev_err(adev->dev, "Init MALL Driver CONTROL Fail=
ure\n");
> +                       return ret;
> +               }
> +
> +               if (pg_config =3D=3D SMU_MALL_PG_CONFIG_DRIVER_CONTROL_AL=
WAYS_ON) {
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_=
MSG_MALLPowerState,
> +                                                                       S=
MU_MALL_EXIT_PG, NULL);
> +                       if (ret) {
> +                               dev_err(adev->dev, "EXIT MALL PG Failure\=
n");
> +                               return ret;
> +                       }
> +               } else if (pg_config =3D=3D SMU_MALL_PG_CONFIG_DRIVER_CON=
TROL_ALWAYS_OFF) {
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_=
MSG_MALLPowerState,
> +                                                                       S=
MU_MALL_ENTER_PG, NULL);
> +                       if (ret) {
> +                               dev_err(adev->dev, "Enter MALL PG Failure=
\n");
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
> +{
> +       enum smu_mall_pg_config pg_config =3D SMU_MALL_PG_CONFIG_DEFAULT;
> +       int ret =3D 0;
> +
> +       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0, 1))
> +               ret =3D smu_v14_0_1_init_mall_power_gating(smu, pg_config=
);
> +
> +       return ret;
> +}
> +
>  static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
>         .check_fw_status =3D smu_v14_0_check_fw_status,
>         .check_fw_version =3D smu_v14_0_check_fw_version,
> @@ -1454,6 +1526,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_f=
uncs =3D {
>         .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
>         .dpm_set_umsch_mm_enable =3D smu_v14_0_0_set_umsch_mm_enable,
>         .get_dpm_clock_table =3D smu_v14_0_common_get_dpm_table,
> +       .set_mall_enable =3D smu_v14_0_common_set_mall_enable,
>  };
>
>  static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *sm=
u)
> --
> 2.25.1
>
