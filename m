Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 13:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E06910E28F;
	Thu,  3 Nov 2022 13:19:17 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA52310E5DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 13:19:15 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-13bd19c3b68so2071410fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ftrnR6NQwmZj/Rq7CCMvmXL1YTOZ8L2HRQ2SkzasLhw=;
 b=SpgOzom4ReKUXsrszmXYYBmKIUfTVj2UIPJXuOYKE2Ec8uwT6Qtsufif+ISVwTRL14
 GIKDkj7tv0fNyzM6vgkSWTxBPApvzBKHRc80zHvJSmBBJqxH6Qm9OLKwAMZz1Qwmll4x
 t9YVpaPGrbf+ipRhe6YyEOfoS3qiijgAOW91HPPvIW8IHUWBDB/IOGOy47/NZyI17fFe
 Tryc1v+8kyxq/0P4QKyfGR5OZzLYJRW8VHzHCeW9F9Df2stj2aA6rUBGGpvUsVK7O7fl
 +pxrADDmhCprpOE4oIZTRDfVDU2u7Y4nElzbDG1DRTIxiwy4ZK1tNsggl5AIQJddDCR7
 bEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftrnR6NQwmZj/Rq7CCMvmXL1YTOZ8L2HRQ2SkzasLhw=;
 b=x6PKJOyfJ5AOTRfLlcYAp/QQejeku9jd9pHHncFYo0Fg74/AXEOoK0L1mqRDUMRvIb
 DCznMAuqPV4Ds1GazxWh9G2K+FShGWr3E3GlyWbFdoah98C0VifPZKbiShCtDzOwNDpj
 QhcoSryYGhv7BEQnkyVOY+mP1PXi6liAiAg1GWEDrgpuOm6pJcUtvrteQX0GNRMfxlmQ
 bV9QFZTGlL5bGxoR4pnAFanbp3rvyIkUxDVKcSqxc9n8D8bPyduoHmZKjUTrY+nE8KyB
 dhxY0k0T9/IE4RRRI3rsTfXz62eDhWNr8Jtw2uom1QUDMMncMvG22YJxvimqDTeFrHpE
 Ptvw==
X-Gm-Message-State: ACrzQf1gVNf2g/u2axzmzXgvMF8HMt64wUAV9b2dIrrer8wEnnmO19Cz
 xMObmrjvDZjx9MhJigpOtj2V4N5UjKH436VfXa7VBTv7
X-Google-Smtp-Source: AMsMyM71J7EUFtBSlbSBO00EiEW+vs4Fl20fMMdnDcuujSFS6IoepikDkkTPAbYU/O9OCV2nTDIb3KOR0snjF2nLYU4=
X-Received: by 2002:a05:6870:a116:b0:13a:f9de:6fd0 with SMTP id
 m22-20020a056870a11600b0013af9de6fd0mr27975371oae.46.1667481555235; Thu, 03
 Nov 2022 06:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221103085013.527767-1-tim.huang@amd.com>
In-Reply-To: <20221103085013.527767-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Nov 2022 09:19:04 -0400
Message-ID: <CADnq5_Ou=QzwGO4u5tTjWoq8_TB1hncArkNDVrZDVGXQUU77mQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: update SMU IP v13.0.4 msg interface header
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Nov 3, 2022 at 4:50 AM Tim Huang <tim.huang@amd.com> wrote:
>
> Some of the unused messages that were used earlier in development have
> been freed up as spare messages, no intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h  | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
> index d9b0cd752200..f4d6c07b56ea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
> @@ -54,14 +54,14 @@
>  #define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
>  #define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
>  #define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
> -#define PPSMC_MSG_EnableGfxOff                  0x04 ///< Enable GFXOFF
> -#define PPSMC_MSG_DisableGfxOff                 0x05 ///< Disable GFXOFF
> +#define PPSMC_MSG_SPARE0                        0x04 ///< SPARE
> +#define PPSMC_MSG_SPARE1                        0x05 ///< SPARE
>  #define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
>  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
>  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
>  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Needs update
> -#define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
> +#define PPSMC_MSG_SPARE2                        0x0A ///< SPARE
> +#define PPSMC_MSG_SPARE3                        0x0B ///< SPARE
>  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
>  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
>  #define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits of DRAM address for Driver table transfer
> @@ -73,8 +73,7 @@
>  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
>  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
>
> -
> -#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Needs update
> +#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
>
>  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
>  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
> @@ -102,8 +101,8 @@
>  #define PPSMC_MSG_SetHardMinIspxclkByFreq       0x2C ///< Set HardMin by frequency for ISPXCLK
>  #define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN.UMSCH (aka VSCH) scheduler
>  #define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN.UMSCH (aka VSCH) scheduler
> -#define PPSMC_Message_IspStutterOn_MmhubPgDis   0x2F ///< ISP StutterOn mmHub PgDis
> -#define PPSMC_Message_IspStutterOff_MmhubPgEn   0x30 ///< ISP StufferOff mmHub PgEn
> +#define PPSMC_MSG_IspStutterOn_MmhubPgDis       0x2F ///< ISP StutterOn mmHub PgDis
> +#define PPSMC_MSG_IspStutterOff_MmhubPgEn       0x30 ///< ISP StufferOff mmHub PgEn
>
>  #define PPSMC_Message_Count                     0x31 ///< Total number of PPSMC messages
>  /** @}*/
> --
> 2.25.1
>
