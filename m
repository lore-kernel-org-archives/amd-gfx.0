Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CDC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D22207DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 13:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMH2DQME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D22207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56116E0FC;
	Wed, 12 Aug 2020 13:42:15 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B62D6E0FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 13:42:14 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id k20so1988056wmi.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RicoGsYB3zswZKls8+c1m79DljgW1KXR7xhgnvDwlbQ=;
 b=EMH2DQMEryq6qtCseZ2PnwgIYD8UT7DHBB4pWayyv6FGYtTY/fmzDrFTxy/DDhKCXO
 iLCaHtaZ0hVCdpJam4uXBTxnWIPzwnc+aAy0p1f+uC88Aes2V6EK8GB9Gw92LmXs31y8
 Et1WImGu2FzxBWEc37ZEg6apfG1ACkRex/fN7s3AWCw+sLFPn1cbJ4dTpUaxKdvRSt67
 wYFo5ZBZgSyVaTII6me11bmZFykp9hG/OWS0LvWCMhIbpFa2coBdQ+v26LPIE3XjgSGG
 vF+Gud9Dyg2WOW/zBAEZrOYvbDSCNxkTWZky+Ps91OfaEG2WACVaNC0lONSoejxfIsU9
 3qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RicoGsYB3zswZKls8+c1m79DljgW1KXR7xhgnvDwlbQ=;
 b=sslcGS8KVIT71ammMLizoQYTqhvkTsPETvrpN/qk8aHDfuGzE5PynwSvbKF/ujWsGR
 n80zG+kQRKuaTvdmgjeXzzkmO/m8y/Nw8scRUHpuFNqb5yyrRCfUCu0CzMIgrEYX8xpx
 IlkRT/8hcidwZuce3CI8BZhHv4hBG8ERR7OEoMR109xokFQ/Z/Shh0H0HXHbFU4VT5Zo
 DLIR3On50kejdsjJwjqME3DOLpwJsf8wqFPfHqbzC78rSwveqysgLKLpEbAHSVcrIVcA
 3P21F7gUiOQMCykFmpDxE7ct/sBW6l9GvI+Njj2qULbKsV2DUSfNu5O+yc8ApjW6xLiY
 QaFw==
X-Gm-Message-State: AOAM531CUhKD1UrgrKFwo/kv/JyWjry8fwZwFX9fveGSQl08goQSHXga
 pcC0d3MexsH7cz4eQ4QO/oATBHB2p+wZS3K1JLrukQ==
X-Google-Smtp-Source: ABdhPJzyqyQGwaYWE/DwZ4ClPMmuIAJQHQ702D4le2ZEfmKg8+6uSuAxZtkWyFxSOO4+IcOvmlv+sNH9JP+J2oVP6eo=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8573028wmh.39.1597239733005; 
 Wed, 12 Aug 2020 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200812045647.20541-1-evan.quan@amd.com>
 <20200812045647.20541-3-evan.quan@amd.com>
In-Reply-To: <20200812045647.20541-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2020 09:42:02 -0400
Message-ID: <CADnq5_Pp2xSCQG5wdPOtaH2fX-5x2+wjFfqB1h5-yvz3Npdaug@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amd/powerplay: enable Navi1X mgpu fan boost
 feature
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 12, 2020 at 12:57 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Support Navi1X mgpu fan boost enablement.
>
> Change-Id: Iafbf07c56462120d2db578b6af45dd7f985a4cc1
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/powerplay/inc/smu_v11_0_ppsmc.h   |  4 +++-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 21 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> index 406bfd187ce8..fa0174dc7e0e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> @@ -123,7 +123,9 @@
>  #define PPSMC_MSG_DALDisableDummyPstateChange    0x49
>  #define PPSMC_MSG_DALEnableDummyPstateChange     0x4A
>
> -#define PPSMC_Message_Count                      0x4B
> +#define PPSMC_MSG_SetMGpuFanBoostLimitRpm        0x4C
> +
> +#define PPSMC_Message_Count                      0x4D
>
>  typedef uint32_t PPSMC_Result;
>  typedef uint32_t PPSMC_Msg;
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 61e2971be9f3..a86cd819b44b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -138,6 +138,7 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE, PPSMC_MSG_DALEnableDummyPstateChange,   0),
>         MSG_MAP(GetVoltageByDpm,                PPSMC_MSG_GetVoltageByDpm,              0),
>         MSG_MAP(GetVoltageByDpmOverdrive,       PPSMC_MSG_GetVoltageByDpmOverdrive,     0),
> +       MSG_MAP(SetMGpuFanBoostLimitRpm,        PPSMC_MSG_SetMGpuFanBoostLimitRpm,      0),
>  };
>
>  static struct cmn2asic_mapping navi10_clk_map[SMU_CLK_COUNT] = {
> @@ -2555,6 +2556,25 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>         return sizeof(struct gpu_metrics_v1_0);
>  }
>
> +static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t param = 0;
> +
> +       /* Navi12 does not support this */
> +       if (adev->asic_type == CHIP_NAVI12)
> +               return 0;
> +
> +       if (adev->pdev->device == 0x7312 &&
> +           adev->external_rev_id == 0)

You want adev->pdev->revision here.  With that fixed, series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               param = 0xD188;
> +
> +       return smu_cmn_send_smc_msg_with_param(smu,
> +                                              SMU_MSG_SetMGpuFanBoostLimitRpm,
> +                                              param,
> +                                              NULL);
> +}
> +
>  static const struct pptable_funcs navi10_ppt_funcs = {
>         .get_allowed_feature_mask = navi10_get_allowed_feature_mask,
>         .set_default_dpm_table = navi10_set_default_dpm_table,
> @@ -2636,6 +2656,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>         .get_gpu_metrics = navi10_get_gpu_metrics,
> +       .enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
>  };
>
>  void navi10_set_ppt_funcs(struct smu_context *smu)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
