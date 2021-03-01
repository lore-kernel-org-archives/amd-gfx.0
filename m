Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4713C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522026024A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522026024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CBD6E030;
	Mon,  1 Mar 2021 16:03:38 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2EE6E030
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 16:03:37 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id l64so18508082oig.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Mar 2021 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zqRQoxIKZjfKPcCz3SQuow0U4Un4FxfznGO10DQJQB0=;
 b=LTAbU2IpRcd/wnT54Bi2dY2+nCfgZEu1IdCKopVUhGFEOVCsYTvOJjJSA3HwxBBKYr
 YJO/T2E2YvhsLNtEpjGCcdNdNpVyUJwWcUYeWc50J4Tx03776ESnc0ECy2mcorFa5kLF
 bi8EOBSsKLVu/sHJRnR/zuSkbZYS04cke8zzT6gGQEBwnHvARFmHq7EbfgvWWrG6wi0n
 oA9HGbsqB5Fkl0IQ6k0Fjmc4U8rup0cb1G3VaQAgXyIUiBNH7lQ3umBk9DPCndP34idz
 +1ed11c22goi7t1frmc6zkwm+82rou6aKEvTtPKaVLujOUcvi5yujBhgHMdbwla/VAf5
 GFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zqRQoxIKZjfKPcCz3SQuow0U4Un4FxfznGO10DQJQB0=;
 b=LbAA0KKu1jvqKCCZP39uGFgmmfPWBzSIfGYy7LJ8Ahn2IyHtSuiEG+QYEoJk9qLqp6
 MKB58GxomojufK6vkEEAixQJdG1gGy/+HWU3ZEgnVosUdBxO8kfdHVoWxSj/AYRFOqEt
 BjoZaT5Yc7KIZL6RR5+MrJE5SJr3SK8riqBMm/t3zPW0CCYdc/qYxjVRw3L1MUHW3WvU
 Qk4fsr5e1JUku7ClFHqD3g/0bJJ1gt44tYQHac3WE2USr7WpiMgV2rCjNXQdbV6qa+0h
 /Rgw0cx6ZJbrQRMIDTbq50NOptI/L2jfZxKenga3L0ecwQ042Lj66bpFU+EscZl84Hif
 tYlg==
X-Gm-Message-State: AOAM530H57QFd9dovSS6EMKsXKBr2cs+30BYQYhbpVyod64T+0tmF8Bd
 j2rZhmLzp0obHINc22AfgtNI7sGoqhl79Tb+7T8b2Ca7
X-Google-Smtp-Source: ABdhPJysjblSLxwmgqrRKspSRs188Pv2LMhew+zDnOq75SmDT5nQpHWfvs3UWgk3KeiX2umr8ELM+TvMsp2aQU0IHXE=
X-Received: by 2002:aca:f485:: with SMTP id
 s127mr12043280oih.120.1614614617090; 
 Mon, 01 Mar 2021 08:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20210226063122.9902-1-horace.chen@amd.com>
 <CY4PR12MB17036381E3A8C93A36AAC8E2849A9@CY4PR12MB1703.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB17036381E3A8C93A36AAC8E2849A9@CY4PR12MB1703.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Mar 2021 11:03:26 -0500
Message-ID: <CADnq5_Nt81TqAbkOoTjtFVGYQhfQzJ=g4XHEkz1W77h7rZBfrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
To: "Liu, Monk" <Monk.Liu@amd.com>
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 1, 2021 at 6:37 AM Liu, Monk <Monk.Liu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Pls change "    if (smu->od_enabled) {"             to       " if (amdgpu_sriov_vf() && smu->od_enabled) {"

Won't that break bare metal?

Alex

>
> With this addressed the patch is reviewed by me
>
> Thanks
>
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Horace Chen <horace.chen@amd.com>
> Sent: Friday, February 26, 2021 2:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
> Subject: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
>
> sienna cichlid needs one vf mode which allows vf to set and get clock status from guest vm. So now expose the required interface and allow some smu request on VF mode. Also since this asic blocked direct MMIO access, use KIQ to send SMU request under sriov vf.
>
> OD use same command as getting pp table which is not allowed for  sienna cichlid, so remove OD feature under sriov vf.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
>  5 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f0f7ed42ee7f..dfbf2f2db0de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>         adev->pm.pp_feature = amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
>                 adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +       if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
> +               adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
>
>         for (i = 0; i < adev->num_ip_blocks; i++) {
>                 if ((amdgpu_ip_block_mask & (1 << i)) == 0) { diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index b770dd634ab6..1866cbaf70c3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>
>  static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATTR_FLAG_BASIC),
> +       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATTR_FLAG_BASIC),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d143ef1b460b..7033d52eb4d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_set_default_od_settings(smu);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to setup default OD settings!\n");
> -               return ret;
> +       if (smu->od_enabled) {
> +               ret = smu_set_default_od_settings(smu);
> +               if (ret) {
> +                       dev_err(adev->dev, "Failed to setup default OD settings!\n");
> +                       return ret;
> +               }
>         }
>
>         ret = smu_populate_umd_state_clk(smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index af73e1430af5..441effc23625 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>         MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
>         MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,             1),
>         MSG_MAP(SetPptLimit,                    PPSMC_MSG_SetPptLimit,                 0),
> -       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,       0),
> -       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,        0),
> +       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,       1),
> +       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,        1),
>         MSG_MAP(SetToolsDramAddrHigh,           PPSMC_MSG_SetToolsDramAddrHigh,        0),
>         MSG_MAP(SetToolsDramAddrLow,            PPSMC_MSG_SetToolsDramAddrLow,         0),
> -       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,       0),
> +       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,       1),
>         MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,       0),
>         MSG_MAP(UseDefaultPPTable,              PPSMC_MSG_UseDefaultPPTable,           0),
>         MSG_MAP(RunDcBtc,                       PPSMC_MSG_RunDcBtc,                    0),
>         MSG_MAP(EnterBaco,                      PPSMC_MSG_EnterBaco,                   0),
> -       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,            0),
> -       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,            0),
> +       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,            1),
> +       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,            1),
>         MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq,            1),
>         MSG_MAP(SetHardMaxByFreq,               PPSMC_MSG_SetHardMaxByFreq,            0),
>         MSG_MAP(GetMinDpmFreq,                  PPSMC_MSG_GetMinDpmFreq,               1),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index bcedd4d92e35..d955dc4c6998 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,  {
>         struct amdgpu_device *adev = smu->adev;
>
> -       *arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>  }
>
>  static int smu_cmn_wait_for_response(struct smu_context *smu) @@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
>         uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
>
>         for (i = 0; i < timeout; i++) {
> -               cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +               cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>                 if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>                         return cur_value;
>
> @@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
>         if (i == timeout)
>                 return -ETIME;
>
> -       return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>  }
>
>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu, @@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>                 return ret;
>         }
>
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>
>         return 0;
>  }
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
