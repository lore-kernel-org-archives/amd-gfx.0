Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39289C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD91010F1FC;
	Tue, 31 May 2022 15:37:48 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED50A10F1FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:37:47 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id s188so17902954oie.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXNfvWNGev3BSxVs84o6LDfyNxKaxVjwisWpi5pTQnw=;
 b=aP6VCr8rKJXMS34feh34V5ch4jeYbJVqYH5DBgaoKQ2YJK57A86JPsDVoTL1U7OwAv
 Sviey3ctRz/bgTLjXrwEkAdQrQdoYmGsNBDoxLvG1wUChrdS/6WpeIppIwwMd+BsC48c
 uc/KN8MsD27RBQ5MoaQ5hI323TEnXLatLZP0Y2ukBCabS6xJpRADKEuj1gwf6tTL9uBl
 Io4BORqWAsn6Eu1Upiqrq4z4ShHBbwgaSdYcDc7yMgmxbbT8V9DsLOqcY05/Rg8wPLOZ
 40dyimborPMA8iV90AIb9CG8ofdYz0JnJ6GHotffZmpXl9MUHJfHBf0VOWOtFBsFlMGv
 LJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXNfvWNGev3BSxVs84o6LDfyNxKaxVjwisWpi5pTQnw=;
 b=6HItaCZGOv2PDP//DT4FHI//ZBgFGiTSQldxDqVgrR4FhSwZPC2LAP3TF9gwjWwKPm
 BPr/oxUJ9ZVfWgME1boiuU0wi/eoUeAghoRmBLo1UOpC5DqtDt4VHoxLfdlfRfFHwO5k
 JiVZExPIrPsTlRA+rdBqcrN2J0HzrfugouIU9L1u4hERdiYCQESpuvbGDJg6u8mmddFA
 p/LSsfd3DAPxoP9Vib/Vw6dtovQrvpCv3CLEgMgSy4iRqdL6JsxMTnfp4NK7yFmHcbW0
 zrPLUb8wV0qAan19PYYX0FQYirzSJ9KHkUhLk94ifOOzei+gAMUE3rRgMZiwLqp7u34z
 6krw==
X-Gm-Message-State: AOAM532XLl3sXtkTjwyJQcNWhTK5WsC7lGa/AXdAE0JOya7N99b8xN8y
 gop3MHjhoSUNUe60Ltk3mKqsQU1KGFOYVmGiNYGpzBj+
X-Google-Smtp-Source: ABdhPJxtUcth/SS6+ZZwu2ma/4NO077kc45GVUMUx95yk6Ie/TZE9lRPx8zWigfWB4UWxSiA6mOH6Eib+toMYydFyNU=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr13201633oiw.253.1654011467163; Tue, 31
 May 2022 08:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220530060911.345435-1-evan.quan@amd.com>
In-Reply-To: <20220530060911.345435-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 11:37:36 -0400
Message-ID: <CADnq5_PDxLMeoOQWW=f-hWjQhYjVTXq1AGk+4cwc4Feqy2Bbfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: suppress compile warnings about possible
 unaligned accesses
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, May 30, 2022 at 2:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Suppress the following compile warnings:
> >> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h:163:17:
> warning: field smc_pptable within 'struct smu_11_0_powerplay_table' is
> less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_powerplay_table'
> being packed, which can lead to unaligned accesses [-Wunaligned-access]
>          PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
>                    ^
>    1 warning generated.
> --
> >> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_7_pptable.h:193:17:
> warning: field smc_pptable within 'struct smu_11_0_7_powerplay_table' is
> less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_7_powerplay_table'
> being packed, which can lead to unaligned accesses [-Wunaligned-access]
>          PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
>                    ^
>    1 warning generated.
> --
> >> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0_pptable.h:161:12:
> warning: field smc_pptable within 'struct smu_13_0_powerplay_table' is less aligned than
> 'PPTable_t' and is usually due to 'struct smu_13_0_powerplay_table' being packed, which
> can lead to unaligned accesses [-Wunaligned-access]
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I855062e987effd563ccc09336caad75f02751bb6
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h |  9 ++++++---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h   |  9 ++++++---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h |  5 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h   | 10 +++++++---
>  4 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> index 247c6e9632ba..1cb399dbc7cc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> @@ -22,6 +22,7 @@
>  #ifndef SMU_11_0_7_PPTABLE_H
>  #define SMU_11_0_7_PPTABLE_H
>
> +#pragma pack(push, 1)
>
>  #define SMU_11_0_7_TABLE_FORMAT_REVISION                  15
>
> @@ -139,7 +140,7 @@ struct smu_11_0_7_overdrive_table
>      uint32_t max[SMU_11_0_7_MAX_ODSETTING];                   //default maximum settings
>      uint32_t min[SMU_11_0_7_MAX_ODSETTING];                   //default minimum settings
>      int16_t  pm_setting[SMU_11_0_7_MAX_PMSETTING];            //Optimized power mode feature settings
> -} __attribute__((packed));
> +};
>
>  enum SMU_11_0_7_PPCLOCK_ID {
>      SMU_11_0_7_PPCLOCK_GFXCLK = 0,
> @@ -166,7 +167,7 @@ struct smu_11_0_7_power_saving_clock_table
>      uint32_t count;                                           //power_saving_clock_count = SMU_11_0_7_PPCLOCK_COUNT
>      uint32_t max[SMU_11_0_7_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
>      uint32_t min[SMU_11_0_7_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
> -} __attribute__((packed));
> +};
>
>  struct smu_11_0_7_powerplay_table
>  {
> @@ -191,6 +192,8 @@ struct smu_11_0_7_powerplay_table
>        struct smu_11_0_7_overdrive_table               overdrive_table;
>
>        PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
> -} __attribute__((packed));
> +};
> +
> +#pragma pack(pop)
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> index 7a63cf8e85ed..0116e3d04fad 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> @@ -22,6 +22,7 @@
>  #ifndef SMU_11_0_PPTABLE_H
>  #define SMU_11_0_PPTABLE_H
>
> +#pragma pack(push, 1)
>
>  #define SMU_11_0_TABLE_FORMAT_REVISION                  12
>
> @@ -109,7 +110,7 @@ struct smu_11_0_overdrive_table
>      uint8_t  cap[SMU_11_0_MAX_ODFEATURE];                     //OD feature support flags
>      uint32_t max[SMU_11_0_MAX_ODSETTING];                     //default maximum settings
>      uint32_t min[SMU_11_0_MAX_ODSETTING];                     //default minimum settings
> -} __attribute__((packed));
> +};
>
>  enum SMU_11_0_PPCLOCK_ID {
>      SMU_11_0_PPCLOCK_GFXCLK = 0,
> @@ -133,7 +134,7 @@ struct smu_11_0_power_saving_clock_table
>      uint32_t count;                                           //power_saving_clock_count = SMU_11_0_PPCLOCK_COUNT
>      uint32_t max[SMU_11_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
>      uint32_t min[SMU_11_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
> -} __attribute__((packed));
> +};
>
>  struct smu_11_0_powerplay_table
>  {
> @@ -162,6 +163,8 @@ struct smu_11_0_powerplay_table
>  #ifndef SMU_11_0_PARTIAL_PPTABLE
>        PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
>  #endif
> -} __attribute__((packed));
> +};
> +
> +#pragma pack(pop)
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> index 3f29f4327378..478862ded0bd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> @@ -22,6 +22,8 @@
>  #ifndef SMU_13_0_7_PPTABLE_H
>  #define SMU_13_0_7_PPTABLE_H
>
> +#pragma pack(push, 1)
> +
>  #define SMU_13_0_7_TABLE_FORMAT_REVISION 15
>
>  //// POWERPLAYTABLE::ulPlatformCaps
> @@ -194,7 +196,8 @@ struct smu_13_0_7_powerplay_table
>      struct smu_13_0_7_overdrive_table overdrive_table;
>      uint8_t padding1;
>      PPTable_t smc_pptable; //PPTable_t in driver_if.h
> -} __attribute__((packed));
> +};
>
> +#pragma pack(pop)
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> index 1f311396b706..043307485528 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> @@ -22,6 +22,8 @@
>  #ifndef SMU_13_0_PPTABLE_H
>  #define SMU_13_0_PPTABLE_H
>
> +#pragma pack(push, 1)
> +
>  #define SMU_13_0_TABLE_FORMAT_REVISION                  1
>
>  //// POWERPLAYTABLE::ulPlatformCaps
> @@ -109,7 +111,7 @@ struct smu_13_0_overdrive_table {
>         uint8_t  cap[SMU_13_0_MAX_ODFEATURE];                     //OD feature support flags
>         uint32_t max[SMU_13_0_MAX_ODSETTING];                     //default maximum settings
>         uint32_t min[SMU_13_0_MAX_ODSETTING];                     //default minimum settings
> -} __attribute__((packed));
> +};
>
>  enum SMU_13_0_PPCLOCK_ID {
>         SMU_13_0_PPCLOCK_GFXCLK = 0,
> @@ -132,7 +134,7 @@ struct smu_13_0_power_saving_clock_table {
>         uint32_t count;                                           //power_saving_clock_count = SMU_11_0_PPCLOCK_COUNT
>         uint32_t max[SMU_13_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
>         uint32_t min[SMU_13_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
> -} __attribute__((packed));
> +};
>
>  struct smu_13_0_powerplay_table {
>         struct atom_common_table_header header;
> @@ -160,6 +162,8 @@ struct smu_13_0_powerplay_table {
>  #ifndef SMU_13_0_PARTIAL_PPTABLE
>         PPTable_t smc_pptable;                        //PPTable_t in driver_if.h
>  #endif
> -} __attribute__((packed));
> +};
> +
> +#pragma pack(pop)
>
>  #endif
> --
> 2.29.0
>
