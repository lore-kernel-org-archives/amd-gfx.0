Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB890C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF2720643
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSQWYoM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2720643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D6E89E50;
	Mon, 23 Dec 2019 19:35:09 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB7189E50
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 19:35:07 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w15so5125284wru.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 11:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kYnP7qjt8HaNzSnT4VSX9Rw7HKgC2ZzcqHwraXmQHEo=;
 b=NSQWYoM8AQaR1nWX0mO6/2eUhRmZOQGD5HpqtoE6eV3YId1Vpss2TSnNRMcfV4wAFL
 eshyU2otYSZn90ggdLGBzVY/0OuFKfpLx4V7eeUkdD+1uYJ68p1AucYuxKEejS7hsC0Z
 cFDwzoHx2Q1X3SP9rpRAS7afJgFNoHBk5M+ubPXabnZA32zQreJMWKrt4QBWrQ0LrBfd
 nKSKq0VAePLThdki89DomlDAgIAC4K3FrSIIUWd8cQWPiv4P/GD0Z2mWFO8ko7WfIM+s
 rQXzwmPlQb3lPObuW8ApB7Ta9XJQTQWh+YJuJ6o6x5WsAsa0EoWOsUMKYyow93ZlsQrs
 jJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kYnP7qjt8HaNzSnT4VSX9Rw7HKgC2ZzcqHwraXmQHEo=;
 b=UuXGxPySxF/vKWlbriqDLQycSuTFLmlNIglQ9VNdgPe+J/D1jT9BX0o0aYtftS5Fe4
 Zd59yUDbEEKhmPtESb+MNxqrosgGsSTqfMZ6CG/EvldO0ZLMQhicUeV+Gs/EpOP14pYV
 ZYP/M1mANRoLCmSXL+jWni7wMKYwoSoBlgD75IdH6rAN+7EtRHQssYIvc7PaW/Zc0MHF
 w6b9TgaOW//VswJinIBsvD40+N8XIoAVwWSvWrF60BLSL79APJjR2j5m1vmOgImJUe4H
 4Kvdftpd0HqPyC3N9xkSanlbQPS/OR/OqJ0/Zo7772aDZ9A9SLa5Hzq1eV3jFmT5kXYL
 95uA==
X-Gm-Message-State: APjAAAWHNYcf8cRaw7oZDpDt6NaD/gQKp7zMw/Tb5jYbcMDXWmpB/t+a
 ZzKF0Ba2KcTbdSjfCKNh9HoE9HLx/VytQ7yqOHI=
X-Google-Smtp-Source: APXvYqzpqVHIx0T6VwGXy7pnRfXVji/SRbVJroi4BjVRS8KV+OKEYkvTd9Nb/E1eFql1k27Mb9KS3WeEiUMyw2lQn3g=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr19180608wru.154.1577129706329; 
 Mon, 23 Dec 2019 11:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20191223080518.28754-1-evan.quan@amd.com>
In-Reply-To: <20191223080518.28754-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Dec 2019 14:34:54 -0500
Message-ID: <CADnq5_NwvBtvXk0yUBZm=vQfaX65_Ha+bD+LwZXL8F=YKBwmGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: support custom power profile setting
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 23, 2019 at 3:05 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Support custom power profile mode settings on Arcturus.
>
> Change-Id: Id14f9a1cced41433b7487f447c452f8852964891
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 132 +++++++++++++++++-
>  .../powerplay/inc/smu11_driver_if_arcturus.h  |   6 +-
>  2 files changed, 128 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 9610b9b8a54c..043ac2ab0496 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -179,6 +179,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_table_map[SMU_TABLE_COUNT] = {
>         TAB_MAP(DRIVER_SMU_CONFIG),
>         TAB_MAP(OVERDRIVE),
>         TAB_MAP(I2C_COMMANDS),
> +       TAB_MAP(ACTIVITY_MONITOR_COEFF),
>  };
>
>  static struct smu_11_0_cmn2aisc_mapping arcturus_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
> @@ -302,6 +303,10 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
>         SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
>                                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> +       SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +                      sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
> +                      AMDGPU_GEM_DOMAIN_VRAM);
> +

Is freeing this handled properly?  Assuming that is ok, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>         smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
>         if (!smu_table->metrics_table)
>                 return -ENOMEM;
> @@ -1314,6 +1319,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>  static int arcturus_get_power_profile_mode(struct smu_context *smu,
>                                            char *buf)
>  {
> +       DpmActivityMonitorCoeffInt_t activity_monitor;
>         static const char *profile_name[] = {
>                                         "BOOTUP_DEFAULT",
>                                         "3D_FULL_SCREEN",
> @@ -1323,14 +1329,35 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>                                         "COMPUTE",
>                                         "CUSTOM"};
>         static const char *title[] = {
> -                       "PROFILE_INDEX(NAME)"};
> +                       "PROFILE_INDEX(NAME)",
> +                       "CLOCK_TYPE(NAME)",
> +                       "FPS",
> +                       "UseRlcBusy",
> +                       "MinActiveFreqType",
> +                       "MinActiveFreq",
> +                       "BoosterFreqType",
> +                       "BoosterFreq",
> +                       "PD_Data_limit_c",
> +                       "PD_Data_error_coeff",
> +                       "PD_Data_error_rate_coeff"};
>         uint32_t i, size = 0;
>         int16_t workload_type = 0;
> +       int result = 0;
> +       uint32_t smu_version;
>
> -       if (!smu->pm_enabled || !buf)
> +       if (!buf)
>                 return -EINVAL;
>
> -       size += sprintf(buf + size, "%16s\n",
> +       result = smu_get_smc_version(smu, NULL, &smu_version);
> +       if (result)
> +               return result;
> +
> +       if (smu_version >= 0x360d00)
> +               size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
> +                       title[0], title[1], title[2], title[3], title[4], title[5],
> +                       title[6], title[7], title[8], title[9], title[10]);
> +       else
> +               size += sprintf(buf + size, "%16s\n",
>                         title[0]);
>
>         for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> @@ -1342,8 +1369,50 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>                 if (workload_type < 0)
>                         continue;
>
> +               if (smu_version >= 0x360d00) {
> +                       result = smu_update_table(smu,
> +                                                 SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +                                                 workload_type,
> +                                                 (void *)(&activity_monitor),
> +                                                 false);
> +                       if (result) {
> +                               pr_err("[%s] Failed to get activity monitor!", __func__);
> +                               return result;
> +                       }
> +               }
> +
>                 size += sprintf(buf + size, "%2d %14s%s\n",
>                         i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> +
> +               if (smu_version >= 0x360d00) {
> +                       size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
> +                               " ",
> +                               0,
> +                               "GFXCLK",
> +                               activity_monitor.Gfx_FPS,
> +                               activity_monitor.Gfx_UseRlcBusy,
> +                               activity_monitor.Gfx_MinActiveFreqType,
> +                               activity_monitor.Gfx_MinActiveFreq,
> +                               activity_monitor.Gfx_BoosterFreqType,
> +                               activity_monitor.Gfx_BoosterFreq,
> +                               activity_monitor.Gfx_PD_Data_limit_c,
> +                               activity_monitor.Gfx_PD_Data_error_coeff,
> +                               activity_monitor.Gfx_PD_Data_error_rate_coeff);
> +
> +                       size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
> +                               " ",
> +                               1,
> +                               "UCLK",
> +                               activity_monitor.Mem_FPS,
> +                               activity_monitor.Mem_UseRlcBusy,
> +                               activity_monitor.Mem_MinActiveFreqType,
> +                               activity_monitor.Mem_MinActiveFreq,
> +                               activity_monitor.Mem_BoosterFreqType,
> +                               activity_monitor.Mem_BoosterFreq,
> +                               activity_monitor.Mem_PD_Data_limit_c,
> +                               activity_monitor.Mem_PD_Data_error_coeff,
> +                               activity_monitor.Mem_PD_Data_error_rate_coeff);
> +               }
>         }
>
>         return size;
> @@ -1353,18 +1422,69 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>                                            long *input,
>                                            uint32_t size)
>  {
> +       DpmActivityMonitorCoeffInt_t activity_monitor;
>         int workload_type = 0;
>         uint32_t profile_mode = input[size];
>         int ret = 0;
> -
> -       if (!smu->pm_enabled)
> -               return -EINVAL;
> +       uint32_t smu_version;
>
>         if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>                 pr_err("Invalid power profile mode %d\n", profile_mode);
>                 return -EINVAL;
>         }
>
> +       ret = smu_get_smc_version(smu, NULL, &smu_version);
> +       if (ret)
> +               return ret;
> +
> +       if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> +            (smu_version >=0x360d00)) {
> +               ret = smu_update_table(smu,
> +                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +                                      WORKLOAD_PPLIB_CUSTOM_BIT,
> +                                      (void *)(&activity_monitor),
> +                                      false);
> +               if (ret) {
> +                       pr_err("[%s] Failed to get activity monitor!", __func__);
> +                       return ret;
> +               }
> +
> +               switch (input[0]) {
> +               case 0: /* Gfxclk */
> +                       activity_monitor.Gfx_FPS = input[1];
> +                       activity_monitor.Gfx_UseRlcBusy = input[2];
> +                       activity_monitor.Gfx_MinActiveFreqType = input[3];
> +                       activity_monitor.Gfx_MinActiveFreq = input[4];
> +                       activity_monitor.Gfx_BoosterFreqType = input[5];
> +                       activity_monitor.Gfx_BoosterFreq = input[6];
> +                       activity_monitor.Gfx_PD_Data_limit_c = input[7];
> +                       activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> +                       activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> +                       break;
> +               case 1: /* Uclk */
> +                       activity_monitor.Mem_FPS = input[1];
> +                       activity_monitor.Mem_UseRlcBusy = input[2];
> +                       activity_monitor.Mem_MinActiveFreqType = input[3];
> +                       activity_monitor.Mem_MinActiveFreq = input[4];
> +                       activity_monitor.Mem_BoosterFreqType = input[5];
> +                       activity_monitor.Mem_BoosterFreq = input[6];
> +                       activity_monitor.Mem_PD_Data_limit_c = input[7];
> +                       activity_monitor.Mem_PD_Data_error_coeff = input[8];
> +                       activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> +                       break;
> +               }
> +
> +               ret = smu_update_table(smu,
> +                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +                                      WORKLOAD_PPLIB_CUSTOM_BIT,
> +                                      (void *)(&activity_monitor),
> +                                      true);
> +               if (ret) {
> +                       pr_err("[%s] Failed to set activity monitor!", __func__);
> +                       return ret;
> +               }
> +       }
> +
>         /*
>          * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
>          * Not all profile modes are supported on arcturus.
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> index a886f0644d24..910226ec512e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> @@ -823,7 +823,6 @@ typedef struct {
>    uint32_t MmHubPadding[8]; // SMU internal use
>  } AvfsFuseOverride_t;
>
> -/* NOT CURRENTLY USED
>  typedef struct {
>    uint8_t   Gfx_ActiveHystLimit;
>    uint8_t   Gfx_IdleHystLimit;
> @@ -866,7 +865,6 @@ typedef struct {
>
>    uint32_t  MmHubPadding[8]; // SMU internal use
>  } DpmActivityMonitorCoeffInt_t;
> -*/
>
>  // These defines are used with the following messages:
>  // SMC_MSG_TransferTableDram2Smu
> @@ -878,11 +876,11 @@ typedef struct {
>  #define TABLE_PMSTATUSLOG             4
>  #define TABLE_SMU_METRICS             5
>  #define TABLE_DRIVER_SMU_CONFIG       6
> -//#define TABLE_ACTIVITY_MONITOR_COEFF  7
>  #define TABLE_OVERDRIVE               7
>  #define TABLE_WAFL_XGMI_TOPOLOGY      8
>  #define TABLE_I2C_COMMANDS            9
> -#define TABLE_COUNT                   10
> +#define TABLE_ACTIVITY_MONITOR_COEFF  10
> +#define TABLE_COUNT                   11
>
>  // These defines are used with the SMC_MSG_SetUclkFastSwitch message.
>  typedef enum {
> --
> 2.24.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
