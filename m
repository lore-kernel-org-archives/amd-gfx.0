Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 21:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6966A64DA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 21:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6966A64DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DB66E0BF;
	Fri, 26 Feb 2021 21:34:25 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325A36E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 21:34:25 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id a13so11260959oid.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5oLEF2A9LVP94iT+nCTXeKgtxdBErimUzKzVxlNPSEM=;
 b=EKtaQelVbbBBTj848t084gDaNVsaJUKRYtB01w26fYCM+4qAT3o8tzNQeegbsE1xQ3
 PDkOfKwyx3lPBx51jgG2SSwbgMKYVG4gXo6+rpkUrnmi8GI7zzMEsLftEu4LgyA7uXZz
 2Ok/FsCVxCyrA3/lexCDD5iUx1VjJ55n62ALmNLFy87axP6NWQ1WutA0fghiS/Tq6uzI
 79d5kdZLLRI0PDwhTs2jkg6C7Gf0C/TjDn9tl3lBoxVLLLwlia/Q05cIypS4tJ+62gr2
 1BvCJQ8YoNgXrloFJ5HnSSwEbfG3yNrfxtovRl0ojsyY3c6JIgUp1bhS3XnSZBsNcekg
 daUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5oLEF2A9LVP94iT+nCTXeKgtxdBErimUzKzVxlNPSEM=;
 b=HC8fZxAWi5ddvmsoivVIrTcLX9bYZkWY0or69h7PdEpP2QXepHXFagWVi2lRQ3G+7h
 YlhyDaptWGdVcb+V0r2tSatanAkHO6hEG2WL7Ro+hA0wQkXFRBAATgp62//tkXv5SU7D
 bYirnniXNQFREyHs+/cUzj5RP67Rbmsx8HjylbQ0+ojUAQOp3h5iMGwzRVZ2FkJcrfJ4
 1hG9JZbkHYxaEz76cTaMQSwbYVCPJGfWXUKha6PXw1O9vNzxTjJbrD0F7CLqZxyj470o
 sGmV/e5tY/6MqvbCxVgHelDXsKKnz2rbM1+q0BKj61QTOPYfWbclM3P9kt/nqD6E6BPV
 K0zg==
X-Gm-Message-State: AOAM532ny2jOcm00/qVTHLBKkgtHEL4YcnE1/mBpH06d9/AsBpHNxEJ7
 nUjdr7L7ee2P3vbRfkuV6Tr3sM+rYtUQc3mNvgU=
X-Google-Smtp-Source: ABdhPJyWq48oAPj7Z6AWFC7MbDY1VvOpN1H1YVhZOvbF+hYn7GUt88SmmcCd4ROihoqEgtlvSxsfdLL9JUbA+/RXByc=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr3372880oii.5.1614375264367; 
 Fri, 26 Feb 2021 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20210226060855.54789-1-evan.quan@amd.com>
In-Reply-To: <20210226060855.54789-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Feb 2021 16:34:13 -0500
Message-ID: <CADnq5_PLYWQeRGVDc1NmN-DwH-H8ZqgUQF_217a1mwL6MW8Tgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: bump Navi1x driver if version and related
 data structures V2
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 26, 2021 at 1:09 AM Evan Quan <evan.quan@amd.com> wrote:
>
> New changes were involved for the SmuMetrics structure.
>
> Change-Id: Ib45443db03977ccd18618bcfdfd3574ac13d50d1
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/inc/smu11_driver_if_navi10.h   |  98 ++-
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   6 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 609 +++++++++++++++++-
>  3 files changed, 673 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> index 246d3951a78a..04752ade1016 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> @@ -843,11 +843,15 @@ typedef struct {
>    uint16_t      FanMaximumRpm;
>    uint16_t      FanMinimumPwm;
>    uint16_t      FanTargetTemperature; // Degree Celcius
> +  uint16_t      FanMode;
> +  uint16_t      FanMaxPwm;
> +  uint16_t      FanMinPwm;
> +  uint16_t      FanMaxTemp; // Degree Celcius
> +  uint16_t      FanMinTemp; // Degree Celcius
>    uint16_t      MaxOpTemp;            // Degree Celcius
>    uint16_t      FanZeroRpmEnable;
> -  uint16_t      Padding;
>
> -  uint32_t     MmHubPadding[8]; // SMU internal use
> +  uint32_t     MmHubPadding[6]; // SMU internal use
>
>  } OverDriveTable_t;
>
> @@ -880,6 +884,45 @@ typedef struct {
>    uint8_t  Padding8_2;
>    uint16_t CurrFanSpeed;
>
> +  // Padding - ignore
> +  uint32_t     MmHubPadding[8]; // SMU internal use
> +} SmuMetrics_legacy_t;
> +
> +typedef struct {
> +  uint16_t CurrClock[PPCLK_COUNT];
> +  uint16_t AverageGfxclkFrequencyPostDs;
> +  uint16_t AverageSocclkFrequency;
> +  uint16_t AverageUclkFrequencyPostDs;
> +  uint16_t AverageGfxActivity    ;
> +  uint16_t AverageUclkActivity   ;
> +  uint8_t  CurrSocVoltageOffset  ;
> +  uint8_t  CurrGfxVoltageOffset  ;
> +  uint8_t  CurrMemVidOffset      ;
> +  uint8_t  Padding8              ;
> +  uint16_t AverageSocketPower    ;
> +  uint16_t TemperatureEdge       ;
> +  uint16_t TemperatureHotspot    ;
> +  uint16_t TemperatureMem        ;
> +  uint16_t TemperatureVrGfx      ;
> +  uint16_t TemperatureVrMem0     ;
> +  uint16_t TemperatureVrMem1     ;
> +  uint16_t TemperatureVrSoc      ;
> +  uint16_t TemperatureLiquid0    ;
> +  uint16_t TemperatureLiquid1    ;
> +  uint16_t TemperaturePlx        ;
> +  uint16_t Padding16             ;
> +  uint32_t ThrottlerStatus       ;
> +
> +  uint8_t  LinkDpmLevel;
> +  uint8_t  Padding8_2;
> +  uint16_t CurrFanSpeed;
> +
> +  uint16_t AverageGfxclkFrequencyPreDs;
> +  uint16_t AverageUclkFrequencyPreDs;
> +  uint8_t  PcieRate;
> +  uint8_t  PcieWidth;
> +  uint8_t  Padding8_3[2];
> +
>    // Padding - ignore
>    uint32_t     MmHubPadding[8]; // SMU internal use
>  } SmuMetrics_t;
> @@ -919,10 +962,61 @@ typedef struct {
>    uint16_t VcnActivityPercentage ;
>    uint16_t padding16_2;
>
> +  // Padding - ignore
> +  uint32_t     MmHubPadding[8]; // SMU internal use
> +} SmuMetrics_NV12_legacy_t;
> +
> +typedef struct {
> +  uint16_t CurrClock[PPCLK_COUNT];
> +  uint16_t AverageGfxclkFrequencyPostDs;
> +  uint16_t AverageSocclkFrequency;
> +  uint16_t AverageUclkFrequencyPostDs;
> +  uint16_t AverageGfxActivity    ;
> +  uint16_t AverageUclkActivity   ;
> +  uint8_t  CurrSocVoltageOffset  ;
> +  uint8_t  CurrGfxVoltageOffset  ;
> +  uint8_t  CurrMemVidOffset      ;
> +  uint8_t  Padding8              ;
> +  uint16_t AverageSocketPower    ;
> +  uint16_t TemperatureEdge       ;
> +  uint16_t TemperatureHotspot    ;
> +  uint16_t TemperatureMem        ;
> +  uint16_t TemperatureVrGfx      ;
> +  uint16_t TemperatureVrMem0     ;
> +  uint16_t TemperatureVrMem1     ;
> +  uint16_t TemperatureVrSoc      ;
> +  uint16_t TemperatureLiquid0    ;
> +  uint16_t TemperatureLiquid1    ;
> +  uint16_t TemperaturePlx        ;
> +  uint16_t Padding16             ;
> +  uint32_t ThrottlerStatus       ;
> +
> +  uint8_t  LinkDpmLevel;
> +  uint8_t  Padding8_2;
> +  uint16_t CurrFanSpeed;
> +
> +  uint16_t AverageVclkFrequency  ;
> +  uint16_t AverageDclkFrequency  ;
> +  uint16_t VcnActivityPercentage ;
> +  uint16_t AverageGfxclkFrequencyPreDs;
> +  uint16_t AverageUclkFrequencyPreDs;
> +  uint8_t  PcieRate;
> +  uint8_t  PcieWidth;
> +
> +  uint32_t Padding32_1;
> +  uint64_t EnergyAccumulator;
> +
>    // Padding - ignore
>    uint32_t     MmHubPadding[8]; // SMU internal use
>  } SmuMetrics_NV12_t;
>
> +typedef union SmuMetrics {
> +       SmuMetrics_legacy_t             nv10_legacy_metrics;
> +       SmuMetrics_t                    nv10_metrics;
> +       SmuMetrics_NV12_legacy_t        nv12_legacy_metrics;
> +       SmuMetrics_NV12_t               nv12_metrics;
> +} SmuMetrics_NV1X_t;
> +
>  typedef struct {
>    uint16_t MinClock; // This is either DCEFCLK or SOCCLK (in MHz)
>    uint16_t MaxClock; // This is either DCEFCLK or SOCCLK (in MHz)
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 281835f23f6d..50dd1529b994 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -27,9 +27,9 @@
>
>  #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>  #define SMU11_DRIVER_IF_VERSION_ARCT 0x17
> -#define SMU11_DRIVER_IF_VERSION_NV10 0x36
> -#define SMU11_DRIVER_IF_VERSION_NV12 0x36
> -#define SMU11_DRIVER_IF_VERSION_NV14 0x36
> +#define SMU11_DRIVER_IF_VERSION_NV10 0x37
> +#define SMU11_DRIVER_IF_VERSION_NV12 0x38
> +#define SMU11_DRIVER_IF_VERSION_NV14 0x38
>  #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
>  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
>  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ada97d12cb43..ffd37b8a3882 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -70,6 +70,8 @@
>         FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
>         FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
>
> +#define SMU_11_0_GFX_BUSY_THRESHOLD 15
> +
>  static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
> @@ -456,18 +458,13 @@ static int navi10_tables_init(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct smu_table *tables = smu_table->tables;
> -       struct amdgpu_device *adev = smu->adev;
>
>         SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -       if (adev->asic_type == CHIP_NAVI12)
> -               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_NV12_t),
> -                              PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -       else
> -               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
> -                              PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_NV1X_t),
> +                      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
> @@ -478,9 +475,8 @@ static int navi10_tables_init(struct smu_context *smu)
>                        sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM);
>
> -       smu_table->metrics_table = kzalloc(adev->asic_type == CHIP_NAVI12 ?
> -                                          sizeof(SmuMetrics_NV12_t) :
> -                                          sizeof(SmuMetrics_t), GFP_KERNEL);
> +       smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_NV1X_t),
> +                                          GFP_KERNEL);
>         if (!smu_table->metrics_table)
>                 goto err0_out;
>         smu_table->metrics_time = 0;
> @@ -504,17 +500,200 @@ static int navi10_tables_init(struct smu_context *smu)
>         return -ENOMEM;
>  }
>
> +static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
> +                                             MetricsMember_t member,
> +                                             uint32_t *value)
> +{
> +       struct smu_table_context *smu_table= &smu->smu_table;
> +       SmuMetrics_legacy_t *metrics =
> +               (SmuMetrics_legacy_t *)smu_table->metrics_table;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              false);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
> +       }
> +
> +       switch (member) {
> +       case METRICS_CURR_GFXCLK:
> +               *value = metrics->CurrClock[PPCLK_GFXCLK];
> +               break;
> +       case METRICS_CURR_SOCCLK:
> +               *value = metrics->CurrClock[PPCLK_SOCCLK];
> +               break;
> +       case METRICS_CURR_UCLK:
> +               *value = metrics->CurrClock[PPCLK_UCLK];
> +               break;
> +       case METRICS_CURR_VCLK:
> +               *value = metrics->CurrClock[PPCLK_VCLK];
> +               break;
> +       case METRICS_CURR_DCLK:
> +               *value = metrics->CurrClock[PPCLK_DCLK];
> +               break;
> +       case METRICS_CURR_DCEFCLK:
> +               *value = metrics->CurrClock[PPCLK_DCEFCLK];
> +               break;
> +       case METRICS_AVERAGE_GFXCLK:
> +               *value = metrics->AverageGfxclkFrequency;
> +               break;
> +       case METRICS_AVERAGE_SOCCLK:
> +               *value = metrics->AverageSocclkFrequency;
> +               break;
> +       case METRICS_AVERAGE_UCLK:
> +               *value = metrics->AverageUclkFrequency;
> +               break;
> +       case METRICS_AVERAGE_GFXACTIVITY:
> +               *value = metrics->AverageGfxActivity;
> +               break;
> +       case METRICS_AVERAGE_MEMACTIVITY:
> +               *value = metrics->AverageUclkActivity;
> +               break;
> +       case METRICS_AVERAGE_SOCKETPOWER:
> +               *value = metrics->AverageSocketPower << 8;
> +               break;
> +       case METRICS_TEMPERATURE_EDGE:
> +               *value = metrics->TemperatureEdge *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_HOTSPOT:
> +               *value = metrics->TemperatureHotspot *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_MEM:
> +               *value = metrics->TemperatureMem *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRGFX:
> +               *value = metrics->TemperatureVrGfx *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRSOC:
> +               *value = metrics->TemperatureVrSoc *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_THROTTLER_STATUS:
> +               *value = metrics->ThrottlerStatus;
> +               break;
> +       case METRICS_CURR_FANSPEED:
> +               *value = metrics->CurrFanSpeed;
> +               break;
> +       default:
> +               *value = UINT_MAX;
> +               break;
> +       }
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       return ret;
> +}
> +
>  static int navi10_get_smu_metrics_data(struct smu_context *smu,
>                                        MetricsMember_t member,
>                                        uint32_t *value)
>  {
>         struct smu_table_context *smu_table= &smu->smu_table;
> -       /*
> -        * This works for NV12 also. As although NV12 uses a different
> -        * SmuMetrics structure from other NV1X ASICs, they share the
> -        * same offsets for the heading parts(those members used here).
> -        */
> -       SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
> +       SmuMetrics_t *metrics =
> +               (SmuMetrics_t *)smu_table->metrics_table;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              false);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
> +       }
> +
> +       switch (member) {
> +       case METRICS_CURR_GFXCLK:
> +               *value = metrics->CurrClock[PPCLK_GFXCLK];
> +               break;
> +       case METRICS_CURR_SOCCLK:
> +               *value = metrics->CurrClock[PPCLK_SOCCLK];
> +               break;
> +       case METRICS_CURR_UCLK:
> +               *value = metrics->CurrClock[PPCLK_UCLK];
> +               break;
> +       case METRICS_CURR_VCLK:
> +               *value = metrics->CurrClock[PPCLK_VCLK];
> +               break;
> +       case METRICS_CURR_DCLK:
> +               *value = metrics->CurrClock[PPCLK_DCLK];
> +               break;
> +       case METRICS_CURR_DCEFCLK:
> +               *value = metrics->CurrClock[PPCLK_DCEFCLK];
> +               break;
> +       case METRICS_AVERAGE_GFXCLK:
> +               if (metrics->AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD)
> +                       *value = metrics->AverageGfxclkFrequencyPreDs;
> +               else
> +                       *value = metrics->AverageGfxclkFrequencyPostDs;
> +               break;
> +       case METRICS_AVERAGE_SOCCLK:
> +               *value = metrics->AverageSocclkFrequency;
> +               break;
> +       case METRICS_AVERAGE_UCLK:
> +               *value = metrics->AverageUclkFrequencyPostDs;
> +               break;
> +       case METRICS_AVERAGE_GFXACTIVITY:
> +               *value = metrics->AverageGfxActivity;
> +               break;
> +       case METRICS_AVERAGE_MEMACTIVITY:
> +               *value = metrics->AverageUclkActivity;
> +               break;
> +       case METRICS_AVERAGE_SOCKETPOWER:
> +               *value = metrics->AverageSocketPower << 8;
> +               break;
> +       case METRICS_TEMPERATURE_EDGE:
> +               *value = metrics->TemperatureEdge *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_HOTSPOT:
> +               *value = metrics->TemperatureHotspot *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_MEM:
> +               *value = metrics->TemperatureMem *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRGFX:
> +               *value = metrics->TemperatureVrGfx *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRSOC:
> +               *value = metrics->TemperatureVrSoc *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_THROTTLER_STATUS:
> +               *value = metrics->ThrottlerStatus;
> +               break;
> +       case METRICS_CURR_FANSPEED:
> +               *value = metrics->CurrFanSpeed;
> +               break;
> +       default:
> +               *value = UINT_MAX;
> +               break;
> +       }
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       return ret;
> +}
> +
> +static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
> +                                             MetricsMember_t member,
> +                                             uint32_t *value)
> +{
> +       struct smu_table_context *smu_table= &smu->smu_table;
> +       SmuMetrics_NV12_legacy_t *metrics =
> +               (SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
>         int ret = 0;
>
>         mutex_lock(&smu->metrics_lock);
> @@ -600,6 +779,136 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
>         return ret;
>  }
>
> +static int navi12_get_smu_metrics_data(struct smu_context *smu,
> +                                      MetricsMember_t member,
> +                                      uint32_t *value)
> +{
> +       struct smu_table_context *smu_table= &smu->smu_table;
> +       SmuMetrics_NV12_t *metrics =
> +               (SmuMetrics_NV12_t *)smu_table->metrics_table;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              false);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
> +       }
> +
> +       switch (member) {
> +       case METRICS_CURR_GFXCLK:
> +               *value = metrics->CurrClock[PPCLK_GFXCLK];
> +               break;
> +       case METRICS_CURR_SOCCLK:
> +               *value = metrics->CurrClock[PPCLK_SOCCLK];
> +               break;
> +       case METRICS_CURR_UCLK:
> +               *value = metrics->CurrClock[PPCLK_UCLK];
> +               break;
> +       case METRICS_CURR_VCLK:
> +               *value = metrics->CurrClock[PPCLK_VCLK];
> +               break;
> +       case METRICS_CURR_DCLK:
> +               *value = metrics->CurrClock[PPCLK_DCLK];
> +               break;
> +       case METRICS_CURR_DCEFCLK:
> +               *value = metrics->CurrClock[PPCLK_DCEFCLK];
> +               break;
> +       case METRICS_AVERAGE_GFXCLK:
> +               if (metrics->AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD)
> +                       *value = metrics->AverageGfxclkFrequencyPreDs;
> +               else
> +                       *value = metrics->AverageGfxclkFrequencyPostDs;
> +               break;
> +       case METRICS_AVERAGE_SOCCLK:
> +               *value = metrics->AverageSocclkFrequency;
> +               break;
> +       case METRICS_AVERAGE_UCLK:
> +               *value = metrics->AverageUclkFrequencyPostDs;
> +               break;
> +       case METRICS_AVERAGE_GFXACTIVITY:
> +               *value = metrics->AverageGfxActivity;
> +               break;
> +       case METRICS_AVERAGE_MEMACTIVITY:
> +               *value = metrics->AverageUclkActivity;
> +               break;
> +       case METRICS_AVERAGE_SOCKETPOWER:
> +               *value = metrics->AverageSocketPower << 8;
> +               break;
> +       case METRICS_TEMPERATURE_EDGE:
> +               *value = metrics->TemperatureEdge *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_HOTSPOT:
> +               *value = metrics->TemperatureHotspot *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_MEM:
> +               *value = metrics->TemperatureMem *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRGFX:
> +               *value = metrics->TemperatureVrGfx *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_TEMPERATURE_VRSOC:
> +               *value = metrics->TemperatureVrSoc *
> +                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               break;
> +       case METRICS_THROTTLER_STATUS:
> +               *value = metrics->ThrottlerStatus;
> +               break;
> +       case METRICS_CURR_FANSPEED:
> +               *value = metrics->CurrFanSpeed;
> +               break;
> +       default:
> +               *value = UINT_MAX;
> +               break;
> +       }
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       return ret;
> +}
> +
> +static int navi1x_get_smu_metrics_data(struct smu_context *smu,
> +                                      MetricsMember_t member,
> +                                      uint32_t *value)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t smu_version;
> +       int ret = 0;
> +
> +       ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to get smu version!\n");
> +               return ret;
> +       }
> +
> +       switch (adev->asic_type) {
> +       case CHIP_NAVI12:
> +               if (smu_version > 0x00341C00)
> +                       ret = navi12_get_smu_metrics_data(smu, member, value);
> +               else
> +                       ret = navi12_get_legacy_smu_metrics_data(smu, member, value);
> +               break;
> +       case CHIP_NAVI10:
> +       case CHIP_NAVI14:
> +       default:
> +               if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
> +                     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
> +                       ret = navi10_get_smu_metrics_data(smu, member, value);
> +               else
> +                       ret = navi10_get_legacy_smu_metrics_data(smu, member, value);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  static int navi10_allocate_dpm_context(struct smu_context *smu)
>  {
>         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> @@ -880,7 +1189,7 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
>                 return -EINVAL;
>         }
>
> -       return navi10_get_smu_metrics_data(smu,
> +       return navi1x_get_smu_metrics_data(smu,
>                                            member_type,
>                                            value);
>  }
> @@ -1327,7 +1636,7 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
>
>         switch (smu_v11_0_get_fan_control_mode(smu)) {
>         case AMD_FAN_CTRL_AUTO:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_CURR_FANSPEED,
>                                                   speed);
>                 break;
> @@ -1644,37 +1953,37 @@ static int navi10_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_MEM_LOAD:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_AVERAGE_MEMACTIVITY,
>                                                   (uint32_t *)data);
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_GPU_LOAD:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_AVERAGE_GFXACTIVITY,
>                                                   (uint32_t *)data);
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_GPU_POWER:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_AVERAGE_SOCKETPOWER,
>                                                   (uint32_t *)data);
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_TEMPERATURE_HOTSPOT,
>                                                   (uint32_t *)data);
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_EDGE_TEMP:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_TEMPERATURE_EDGE,
>                                                   (uint32_t *)data);
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_MEM_TEMP:
> -               ret = navi10_get_smu_metrics_data(smu,
> +               ret = navi1x_get_smu_metrics_data(smu,
>                                                   METRICS_TEMPERATURE_MEM,
>                                                   (uint32_t *)data);
>                 *size = 4;
> @@ -1685,7 +1994,7 @@ static int navi10_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_GFX_SCLK:
> -               ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
> +               ret = navi1x_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
>                 *(uint32_t *)data *= 100;
>                 *size = 4;
>                 break;
> @@ -2289,14 +2598,75 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
>         return 0;
>  }
>
> +static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
> +                                            void **table)
> +{
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct gpu_metrics_v1_0 *gpu_metrics =
> +               (struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
> +       SmuMetrics_legacy_t metrics;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              true);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
> +       }
> +
> +       memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_legacy_t));
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
> +
> +       gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> +       gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> +       gpu_metrics->temperature_mem = metrics.TemperatureMem;
> +       gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
> +       gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
> +       gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
> +
> +       gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +       gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
> +
> +       gpu_metrics->average_socket_power = metrics.AverageSocketPower;
> +
> +       gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
> +       gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
> +       gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
> +
> +       gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
> +       gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
> +       gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
> +       gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> +       gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> +
> +       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +
> +       gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> +
> +       gpu_metrics->pcie_link_width =
> +                       smu_v11_0_get_current_pcie_link_width(smu);
> +       gpu_metrics->pcie_link_speed =
> +                       smu_v11_0_get_current_pcie_link_speed(smu);
> +
> +       gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> +
> +       *table = (void *)gpu_metrics;
> +
> +       return sizeof(struct gpu_metrics_v1_0);
> +}
> +
>  static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>                                       void **table)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>         struct gpu_metrics_v1_0 *gpu_metrics =
>                 (struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
> -       struct amdgpu_device *adev = smu->adev;
> -       SmuMetrics_NV12_t nv12_metrics = { 0 };
>         SmuMetrics_t metrics;
>         int ret = 0;
>
> @@ -2311,8 +2681,73 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>         }
>
>         memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
> -       if (adev->asic_type == CHIP_NAVI12)
> -               memcpy(&nv12_metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
> +
> +       gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> +       gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> +       gpu_metrics->temperature_mem = metrics.TemperatureMem;
> +       gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
> +       gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
> +       gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
> +
> +       gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +       gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
> +
> +       gpu_metrics->average_socket_power = metrics.AverageSocketPower;
> +
> +       if (metrics.AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD)
> +               gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
> +       else
> +               gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
> +
> +       gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
> +       gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
> +
> +       gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
> +       gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
> +       gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
> +       gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> +       gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> +
> +       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +
> +       gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> +
> +       gpu_metrics->pcie_link_width =
> +                       smu_v11_0_get_current_pcie_link_width(smu);
> +       gpu_metrics->pcie_link_speed =
> +                       smu_v11_0_get_current_pcie_link_speed(smu);
> +
> +       gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> +
> +       *table = (void *)gpu_metrics;
> +
> +       return sizeof(struct gpu_metrics_v1_0);
> +}
> +
> +static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
> +                                            void **table)
> +{
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct gpu_metrics_v1_0 *gpu_metrics =
> +               (struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
> +       SmuMetrics_NV12_legacy_t metrics;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              true);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
> +       }
> +
> +       memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_legacy_t));
>
>         mutex_unlock(&smu->metrics_lock);
>
> @@ -2334,13 +2769,83 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
>         gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
>
> -       if (adev->asic_type == CHIP_NAVI12) {
> -               gpu_metrics->energy_accumulator = nv12_metrics.EnergyAccumulator;
> -               gpu_metrics->average_vclk0_frequency = nv12_metrics.AverageVclkFrequency;
> -               gpu_metrics->average_dclk0_frequency = nv12_metrics.AverageDclkFrequency;
> -               gpu_metrics->average_mm_activity = nv12_metrics.VcnActivityPercentage;
> +       gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
> +       gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
> +       gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
> +       gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
> +
> +       gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
> +       gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
> +       gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
> +       gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> +       gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> +
> +       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +
> +       gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> +
> +       gpu_metrics->pcie_link_width =
> +                       smu_v11_0_get_current_pcie_link_width(smu);
> +       gpu_metrics->pcie_link_speed =
> +                       smu_v11_0_get_current_pcie_link_speed(smu);
> +
> +       gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> +
> +       *table = (void *)gpu_metrics;
> +
> +       return sizeof(struct gpu_metrics_v1_0);
> +}
> +
> +static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
> +                                     void **table)
> +{
> +       struct smu_table_context *smu_table = &smu->smu_table;
> +       struct gpu_metrics_v1_0 *gpu_metrics =
> +               (struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
> +       SmuMetrics_NV12_t metrics;
> +       int ret = 0;
> +
> +       mutex_lock(&smu->metrics_lock);
> +
> +       ret = smu_cmn_get_metrics_table_locked(smu,
> +                                              NULL,
> +                                              true);
> +       if (ret) {
> +               mutex_unlock(&smu->metrics_lock);
> +               return ret;
>         }
>
> +       memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
> +
> +       mutex_unlock(&smu->metrics_lock);
> +
> +       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
> +
> +       gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> +       gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> +       gpu_metrics->temperature_mem = metrics.TemperatureMem;
> +       gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
> +       gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
> +       gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
> +
> +       gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +       gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
> +
> +       gpu_metrics->average_socket_power = metrics.AverageSocketPower;
> +
> +       if (metrics.AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD)
> +               gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
> +       else
> +               gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
> +
> +       gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
> +       gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
> +
> +       gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
> +       gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
> +       gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
> +       gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
> +
>         gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
>         gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
>         gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
> @@ -2363,6 +2868,40 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>         return sizeof(struct gpu_metrics_v1_0);
>  }
>
> +static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
> +                                     void **table)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t smu_version;
> +       int ret = 0;
> +
> +       ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to get smu version!\n");
> +               return ret;
> +       }
> +
> +       switch (adev->asic_type) {
> +       case CHIP_NAVI12:
> +               if (smu_version > 0x00341C00)
> +                       ret = navi12_get_gpu_metrics(smu, table);
> +               else
> +                       ret = navi12_get_legacy_gpu_metrics(smu, table);
> +               break;
> +       case CHIP_NAVI10:
> +       case CHIP_NAVI14:
> +       default:
> +               if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
> +                     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
> +                       ret = navi10_get_gpu_metrics(smu, table);
> +               else
> +                       ret =navi10_get_legacy_gpu_metrics(smu, table);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> @@ -2493,7 +3032,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .set_power_source = smu_v11_0_set_power_source,
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
> -       .get_gpu_metrics = navi10_get_gpu_metrics,
> +       .get_gpu_metrics = navi1x_get_gpu_metrics,
>         .enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
>         .gfx_ulv_control = smu_v11_0_gfx_ulv_control,
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
