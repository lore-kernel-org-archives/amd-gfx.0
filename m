Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A2AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091FE10E285;
	Tue, 31 May 2022 21:15:24 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D1410E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:15:23 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id r65so64390oia.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t6CJohsBWqb4qcg33ifutJLxWm4wXkiZKUpVRTLnSFQ=;
 b=gC69E0A2RgigiT17AAN7vpwk7w086IOpyW7JIqXM1dXMcXNJl2+KJawsTzgfSY+lnt
 QpomyvpM1Mae5/55ElDfcOG1T6eb7fiZUxNAPu+BdUJO9fdk03v8zhuQ15thjU+PXpi5
 86Ha7te0RyY//JzVFqacbkiTMA5dlcNxPgKiISZCIeFp/ZhDyZoZkpw9T3xj6ivJ1Pq9
 sn4ulCdJXlfhPy2vf2VN6T+L0krfx7S471p8Dmp/kRGmvnxd5pIFTrqCNfJdyFBMCXE9
 p0MeAUPtz1/lum9MwgoFr+WwdkhJydoWVHzZBEYvjrWncZfKfOdMWeIEn2+yc/Mz1d2H
 Gvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t6CJohsBWqb4qcg33ifutJLxWm4wXkiZKUpVRTLnSFQ=;
 b=5sDlO1HkcCIO+lL/ep3IbX8t4kasU13jAsQDoe5giBcvWaJiGC8Qgp9dO4TKhWuDdI
 atCHaEavgAWP/KIt0FR2MD62Z/+n0Xnov5kLO83+6M3LG0ctUSUNYOuz5YsiZ8X880le
 PcEclmOR/ai0P15fQPLb7xisrBC8uAbDeI0OEhpD0q3GzjdApv4lA4fWwS1P7XSJ2luL
 ronqEt9iYoQXvcd2XkO9zOEmGFtmI+Vy70rBVukx05jIGB/l7zOpB14ufh3hUlUaH5aw
 92sOCTURwBSoXsri2TYe0MUZyVzJDe4kV8uylewjENM++dEDicHqAyf9oXcWGEUOo3z/
 WM0Q==
X-Gm-Message-State: AOAM532qSJ+mYJCQX55nN4n2hbMvOlhPQs24X5yJ8UJFxvMXnSx7WS0c
 xkhsRSKFyjwZO+p5T/EnFPnZmp4kqbLArzvODZBIo9bVp7c=
X-Google-Smtp-Source: ABdhPJzEcwautuKf8z2rJTMMbF+asp319mIcGcUlZn+ClUKO+TDL8+ykDiE+Awd3kPRGOaEXz9g8fV1gCaxuOb/oEGI=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr14084227oiw.253.1654031722145; Tue, 31
 May 2022 14:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
 <20220526180027.3044740-2-alexander.deucher@amd.com>
In-Reply-To: <20220526180027.3044740-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:15:10 -0400
Message-ID: <CADnq5_MBHh=yzy8=BvM3CVO41ZuQTfTBWW_9WTOng498Kfp0zg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in SMU
 context
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, May 26, 2022 at 2:00 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> So we can eventaully use them in the common smu code for
> accessing the SMU mailboxes without needing a lot of
> per asic logic in the common code.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h   |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   |  2 ++
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  1 +
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  1 +
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  9 +++++++++
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 14 ++++++++++++++
>  .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 18 ++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 14 ++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   | 14 ++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  1 +
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |  1 +
>  17 files changed, 86 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a6a7b6c33683..36af1f417dcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -563,6 +563,10 @@ struct smu_context
>         struct stb_context stb_context;
>
>         struct firmware pptable_firmware;
> +
> +       u32 param_reg;
> +       u32 msg_reg;
> +       u32 resp_reg;
>  };
>
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index acb3be292096..a9215494dcdd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -316,5 +316,7 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
>
>  int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
>
> +void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 036fd2810ecc..f60dcc4f7e75 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -298,5 +298,7 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
>                                 uint32_t size);
>
>  int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
> +
> +void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 201563072189..bfabcd3c45aa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2509,4 +2509,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = arcturus_table_map;
>         smu->pwr_src_map = arcturus_pwr_src_map;
>         smu->workload_map = arcturus_workload_map;
> +       smu_v11_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index f1a4a720d426..ca4d97b7f576 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -591,4 +591,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
>         smu->message_map = cyan_skillfish_message_map;
>         smu->table_map = cyan_skillfish_table_map;
>         smu->is_apu = true;
> +       smu_v11_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 5f22fc3430f4..0bcd4fe0ef17 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3580,4 +3580,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = navi10_table_map;
>         smu->pwr_src_map = navi10_pwr_src_map;
>         smu->workload_map = navi10_workload_map;
> +       smu_v11_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 6b452e3f5ee3..f6f21b516fd6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -4357,4 +4357,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = sienna_cichlid_table_map;
>         smu->pwr_src_map = sienna_cichlid_pwr_src_map;
>         smu->workload_map = sienna_cichlid_workload_map;
> +       smu_v11_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b87f550af26b..974b8fe1dbb6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -2197,3 +2197,12 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
>
>         return ret;
>  }
> +
> +void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +
> +       smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +       smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 5551e1426ef5..e2d8ac90cf36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2213,4 +2213,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = vangogh_table_map;
>         smu->workload_map = vangogh_workload_map;
>         smu->is_apu = true;
> +       smu_v11_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 012e3bd99cc2..85e22210963f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -41,6 +41,15 @@
>  #undef pr_info
>  #undef pr_debug
>
> +#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
> +#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
> +#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
> +#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
> +
>  static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
> @@ -1447,6 +1456,8 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>
>  void renoir_set_ppt_funcs(struct smu_context *smu)
>  {
> +       struct amdgpu_device *adev = smu->adev;
> +
>         smu->ppt_funcs = &renoir_ppt_funcs;
>         smu->message_map = renoir_message_map;
>         smu->clock_map = renoir_clk_map;
> @@ -1454,4 +1465,7 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
>         smu->workload_map = renoir_workload_map;
>         smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
>         smu->is_apu = true;
> +       smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +       smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index fb130409309c..2e6a93869be8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -2117,4 +2117,5 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)
>         smu->clock_map = aldebaran_clk_map;
>         smu->feature_map = aldebaran_feature_mask_map;
>         smu->table_map = aldebaran_table_map;
> +       smu_v13_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 7be4f6875a7b..6fd3216b91d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -60,6 +60,15 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
>  MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
>  MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
>
> +#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
> +#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
> +#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
> +#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
> +
>  #define SMU13_VOLTAGE_SCALE 4
>
>  #define LINK_WIDTH_MAX                         6
> @@ -2386,3 +2395,12 @@ int smu_v13_0_set_default_dpm_tables(struct smu_context *smu)
>         return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
>                                     smu_table->clocks_table, false);
>  }
> +
> +void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +
> +       smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +       smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 5c74a72577c6..418480e0c077 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1651,4 +1651,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = smu_v13_0_0_table_map;
>         smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
>         smu->workload_map = smu_v13_0_0_workload_map;
> +       smu_v13_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 5a17b51aa0f9..8ccda593fc50 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -43,6 +43,15 @@
>  #undef pr_info
>  #undef pr_debug
>
> +#define mmMP1_SMN_C2PMSG_66                    0x0282
> +#define mmMP1_SMN_C2PMSG_66_BASE_IDX            1
> +
> +#define mmMP1_SMN_C2PMSG_82                    0x0292
> +#define mmMP1_SMN_C2PMSG_82_BASE_IDX            1
> +
> +#define mmMP1_SMN_C2PMSG_90                    0x029a
> +#define mmMP1_SMN_C2PMSG_90_BASE_IDX           1
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)
>
>  #define SMC_DPM_FEATURE ( \
> @@ -1034,9 +1043,14 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
>
>  void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
>  {
> +       struct amdgpu_device *adev = smu->adev;
> +
>         smu->ppt_funcs = &smu_v13_0_4_ppt_funcs;
>         smu->message_map = smu_v13_0_4_message_map;
>         smu->feature_map = smu_v13_0_4_feature_mask_map;
>         smu->table_map = smu_v13_0_4_table_map;
>         smu->is_apu = true;
> +       smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +       smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index b81711c4ff33..47360ef5c175 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -42,6 +42,15 @@
>  #undef pr_info
>  #undef pr_debug
>
> +#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
> +#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
> +
> +#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
> +#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
> +
> +#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
> +#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)
>  #define SMC_DPM_FEATURE ( \
>         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
> @@ -1049,9 +1058,14 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
>
>  void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
>  {
> +       struct amdgpu_device *adev = smu->adev;
> +
>         smu->ppt_funcs = &smu_v13_0_5_ppt_funcs;
>         smu->message_map = smu_v13_0_5_message_map;
>         smu->feature_map = smu_v13_0_5_feature_mask_map;
>         smu->table_map = smu_v13_0_5_table_map;
>         smu->is_apu = true;
> +       smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
> +       smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
> +       smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 4e1861fb2c6a..bdea7bca3805 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1594,4 +1594,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
>         smu->table_map = smu_v13_0_7_table_map;
>         smu->pwr_src_map = smu_v13_0_7_pwr_src_map;
>         smu->workload_map = smu_v13_0_7_workload_map;
> +       smu_v13_0_set_smu_mailbox_registers(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index feff4f8c927c..70cbc46341a3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -1203,4 +1203,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
>         smu->feature_map = yellow_carp_feature_mask_map;
>         smu->table_map = yellow_carp_table_map;
>         smu->is_apu = true;
> +       smu_v13_0_set_smu_mailbox_registers(smu);
>  }
> --
> 2.35.3
>
