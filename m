Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D298E784AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B7A10E279;
	Mon,  2 Oct 2023 10:29:32 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFB510E279
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:29:30 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3231df68584so12141318f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242569; x=1696847369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aaC4zrGtfEtVPz2HK9cRtNfez7c7l4wwJ7tNtJpLhGA=;
 b=hdkFy+n+ZltddduvmnXKHHClENayxoVKRV1/JL4spntvMrIpr/jxdlVVS5C69DfDHF
 zJDDF5LlY+ofm3VLjrPzUMo5zlPV/SAwSukon7t6Ay0pmYgrCSA2VWJMu6xInxcagXJc
 xIDbKjzBL+SJQ16trny+3I818090vHd9q7cU8mFBLjcUmdH1IszQu6HcmFBP+edj14RZ
 08h0EIYoMjfSqJXArNFsmRBJVXkCZgE7FxkH3aR1TFYlWNi3lRGC7tKuHt8pwIq2hvTG
 zoeYymujL2FIMMglwYrpAd78yePlzGYQtL0dYvtQmt4Z4sRPONwXRivDfsPlzxbm8brp
 Q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242569; x=1696847369;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aaC4zrGtfEtVPz2HK9cRtNfez7c7l4wwJ7tNtJpLhGA=;
 b=glwh5rizhZrIWUCyhp+YBuzX8XaDZGBtoil1aSpcTaQ4SvaO096cU6GDJlvF8cfeSd
 1J2ecxx8sKKXHr/puyx0etDZW7wWe/auXS9bhmmRiPbMr79vQ/fhFSVE1UQZ3a66/YEr
 /KzXn1qhHfwdBoB7aPb9vQKEmBAYcYFVDgKVJY7WGlsoxQ00lzP1rQ6G0raC67gmAYqu
 vql2OxapniHUtuexk2woHt0tD58CzU95wfnBywPweVqijKLw4xqsAGnhwUWOyEz7Wu/U
 WEi5uwsvTY/kdsH9Kr65Z3su3PLm0An3dLfhpllS4FxCXyS3/bgHZ4XEs9ohlX3nWXh+
 TP5A==
X-Gm-Message-State: AOJu0YwhhBKqI9GzQ/+ZMaYpMUUjxxqGfuDm+cnzUYcXrKr0XUzJKGnV
 FCevRzqg5OtI7+K05J2i8nMCx9UDn4a/Tg==
X-Google-Smtp-Source: AGHT+IE38POsY3zz+2nJTlacKomu65BJkBFIeOqr9Yt0YstzN+tm95f5Q/NRrdlHRJcz3DQTOU2p0A==
X-Received: by 2002:a5d:4385:0:b0:319:867e:97d7 with SMTP id
 i5-20020a5d4385000000b00319867e97d7mr10122219wrq.52.1696242568942; 
 Mon, 02 Oct 2023 03:29:28 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ba6-20020a0560001c0600b003248a490e3asm9345002wrb.39.2023.10.02.03.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:29:28 -0700 (PDT)
Message-ID: <aec7fa93-4370-1ebb-d588-b4e3a86c63a3@gmail.com>
Date: Mon, 2 Oct 2023 12:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] drm/amd: Update `update_pcie_parameters` functions to
 use uint8_t arguments
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230930032254.580-1-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230930032254.580-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 30.09.23 um 05:22 schrieb Mario Limonciello:
> The matching values for `pcie_gen_cap` and `pcie_width_cap` when
> fetched from powerplay tables are 1 byte, so narrow the arguments
> to match to ensure min() and max() comparisons without casts.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 ++++----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 4 ++--
>   6 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 33eaf0d77163..99750c182279 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1270,7 +1270,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   {
>   	struct smu_feature *feature = &smu->smu_feature;
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t pcie_gen = 0, pcie_width = 0;
> +	uint8_t pcie_gen = 0, pcie_width = 0;
>   	uint64_t features_supported;
>   	int ret = 0;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 4f6df3558b9b..f3cab5e633a7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -846,7 +846,7 @@ struct pptable_funcs {
>   	 * &pcie_gen_cap: Maximum allowed PCIe generation.
>   	 * &pcie_width_cap: Maximum allowed PCIe width.
>   	 */
> -	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
> +	int (*update_pcie_parameters)(struct smu_context *smu, uint8_t pcie_gen_cap, uint8_t pcie_width_cap);
>   
>   	/**
>   	 * @i2c_init: Initialize i2c.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 355c156d871a..cc02f979e9e9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -296,8 +296,8 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
>   					uint32_t pptable_id);
>   
>   int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
> -				     uint32_t pcie_gen_cap,
> -				     uint32_t pcie_width_cap);
> +				     uint8_t pcie_gen_cap,
> +				     uint8_t pcie_width_cap);
>   
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 650482cedd1f..5f3cbfff156a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2380,8 +2380,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
>   }
>   
>   static int navi10_update_pcie_parameters(struct smu_context *smu,
> -				     uint32_t pcie_gen_cap,
> -				     uint32_t pcie_width_cap)
> +					 uint8_t pcie_gen_cap,
> +					 uint8_t pcie_width_cap)
>   {
>   	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>   	PPTable_t *pptable = smu->smu_table.driver_pptable;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 1f05bfb7d473..dd07662262e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2092,14 +2092,14 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>   #define MAX(a, b)	((a) > (b) ? (a) : (b))
>   
>   static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
> -					 uint32_t pcie_gen_cap,
> -					 uint32_t pcie_width_cap)
> +						 uint8_t pcie_gen_cap,
> +						 uint8_t pcie_width_cap)
>   {
>   	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>   	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
>   	uint8_t *table_member1, *table_member2;
> -	uint32_t min_gen_speed, max_gen_speed;
> -	uint32_t min_lane_width, max_lane_width;
> +	uint8_t min_gen_speed, max_gen_speed;
> +	uint8_t min_lane_width, max_lane_width;
>   	uint32_t smu_pcie_arg;
>   	int ret, i;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index d86499ac8931..208db8b580eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2419,8 +2419,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
>   }
>   
>   int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
> -				     uint32_t pcie_gen_cap,
> -				     uint32_t pcie_width_cap)
> +				     uint8_t pcie_gen_cap,
> +				     uint8_t pcie_width_cap)
>   {
>   	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>   	struct smu_13_0_pcie_table *pcie_table =

