Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDED6113C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FDED6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DD96E11C;
	Wed,  8 Sep 2021 06:37:36 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9F06E11C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 06:37:35 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id d6so1482854wrc.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=O7QDtkudZE+4d2QO1Cd8I/vhZ2+a7SEWSQ7kucRxW2s=;
 b=WTGvFeuH7qScW2mW/1samhc37GadgPoKA7LO8CRRqXQMqF8l5sVKhG4jyA+tHPshnv
 co/4LtIv7eaeANNYWluY58l4iXVukA5Oz+sNEILCTsXimp6kV9iB2R/AlrPE8AUY2J5l
 E6VHZhcQSz0DCD6wV2Z7PD8/I/lakmmmjF23QfNG6vCl8yc7Ir4qu1kMXSZjKQUM9ocJ
 eBazsOhJyeCfa7m68YrOFWezIYixbDIn+9FTaafRa6XRQetiONAr05l/weTuBbThiQSX
 Y31/jm3U7XSFRVsqAAJm11qdhNOZVZnrtTSJINsRt8DormahNFaYDEWvQT19PHKjyEoP
 5xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=O7QDtkudZE+4d2QO1Cd8I/vhZ2+a7SEWSQ7kucRxW2s=;
 b=yH9hPZjtKCrNN3MasY+io98l833grzu09Y2jeEykH5sbgGqoL/IlQyAuSC33XJtDDX
 2fpTXRH1wgXYz0M98/hf0wAifZlJPf8OIlj1rotW+bxK/Cl+LsTey4BbJo5fgl+TDnLn
 8nNNQj/kbGK8eQoPgZhk/2rMDE8VZcixueQfo/b2P18uv9DUBFy7FSJ7cUSK3z4NGV3B
 qklowpvEp3VPF42LtSbOhKJX1/AwQ5aXObba/tvMLJM9N+k/t1z1bUSFH6rmu0U8dfgK
 jAgeq/34YUpHobonyCiC4blCdMXlVeehtUOSoY7w54t8uiOIm2FBpgKI5r9mscxTFOgu
 6gpA==
X-Gm-Message-State: AOAM531/7PKwQFdDtmFjyMquOIZdjkme5T7gDa5voaF0RopguHkLq0oT
 b6Z94NF8rwcOQeeih8r80hE=
X-Google-Smtp-Source: ABdhPJxkyrXTYjte3UmuGVZK5/zgCHQpvetZYXBjV8wqNA3hI1pul08E7ZSf0tj9RmRHd1BWFST3lA==
X-Received: by 2002:adf:f984:: with SMTP id f4mr2121805wrr.331.1631083054376; 
 Tue, 07 Sep 2021 23:37:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:58f0:1f28:e3d8:5e7b?
 ([2a02:908:1252:fb60:58f0:1f28:e3d8:5e7b])
 by smtp.gmail.com with ESMTPSA id d9sm1346071wrb.36.2021.09.07.23.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 23:37:34 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Tian Tao <tiantao6@hisilicon.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
Date: Wed, 8 Sep 2021 08:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908055615.3781901-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 08.09.21 um 07:56 schrieb Lang Yu:
> sysfs_emit and sysfs_emit_at requrie a page boundary
> aligned buf address. Make them happy!
>
> Warning Log:
> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0
> [  492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765 sysfs_emit_at+0x4a/0xa0
> [  492.654805] Call Trace:
> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu]
> [  492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu]
> [  492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu]
> [  492.659733]  ? preempt_schedule_common+0x18/0x30
> [  492.660713]  smu_print_ppclk_levels+0x65/0x90 [amdgpu]
> [  492.662107]  amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu]
> [  492.663620]  dev_attr_show+0x1d/0x40

Mhm, that at least partially doesn't looks like the right approach to me.

Why do we have string printing and sysfs code in the hardware version 
specific backend in the first place?

That stuff needs to be implemented for each hardware generation and is 
now cluttered with sysfs buffer offset calculations.

Regards,
Christian.

>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  9 +++++++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 ++++-
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 ++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 15 +++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  3 +++
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13 +++++++++----
>   .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  7 +++++--
>   7 files changed, 41 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index e343cc218990..53185fe96d83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -771,8 +771,13 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>   	struct smu_11_0_dpm_context *dpm_context = NULL;
>   	uint32_t gen_speed, lane_width;
>   
> -	if (amdgpu_ras_intr_triggered())
> -		return sysfs_emit(buf, "unavailable\n");
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
> +	if (amdgpu_ras_intr_triggered()) {
> +		size += sysfs_emit_at(buf, size, "unavailable\n");
> +		return size;
> +	}
>   
>   	dpm_context = smu_dpm->dpm_context;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 4c81989b8162..5490e8e66e14 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1279,6 +1279,9 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>   	uint32_t min_value, max_value;
>   
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
>   	switch (clk_type) {
>   	case SMU_GFXCLK:
>   	case SMU_SCLK:
> @@ -1392,7 +1395,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   	case SMU_OD_RANGE:
>   		if (!smu->od_enabled || !od_table || !od_settings)
>   			break;
> -		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   
>   		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
>   			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 5e292c3f5050..817ad6de3854 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1058,6 +1058,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	uint32_t min_value, max_value;
>   	uint32_t smu_version;
>   
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
>   	switch (clk_type) {
>   	case SMU_GFXCLK:
>   	case SMU_SCLK:
> @@ -1180,7 +1183,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   		if (!smu->od_enabled || !od_table || !od_settings)
>   			break;
>   
> -		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   
>   		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
>   			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 3a3421452e57..c7842c69b570 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -592,7 +592,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -601,7 +601,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   		break;
>   	case SMU_OD_CCLK:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
> +			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -610,7 +610,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   		break;
>   	case SMU_OD_RANGE:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>   				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
>   			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
> @@ -682,6 +682,9 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	bool cur_value_match_level = false;
>   
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
>   	memset(&metrics, 0, sizeof(metrics));
>   
>   	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
> @@ -691,7 +694,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -700,7 +703,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   		break;
>   	case SMU_OD_CCLK:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
> +			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -709,7 +712,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   		break;
>   	case SMU_OD_RANGE:
>   		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>   				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
>   			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 5aa175e12a78..86e7978b6d63 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -491,6 +491,9 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>   	bool cur_value_match_level = false;
>   
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
>   	memset(&metrics, 0, sizeof(metrics));
>   
>   	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ab652028e003..6349f27e9efc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -733,15 +733,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   	uint32_t freq_values[3] = {0};
>   	uint32_t min_clk, max_clk;
>   
> -	if (amdgpu_ras_intr_triggered())
> -		return sysfs_emit(buf, "unavailable\n");
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
> +	if (amdgpu_ras_intr_triggered()) {
> +		size += sysfs_emit_at(buf, size, "unavailable\n");
> +		return size;
> +	}
>   
>   	dpm_context = smu_dpm->dpm_context;
>   
>   	switch (type) {
>   
>   	case SMU_OD_SCLK:
> -		size = sysfs_emit(buf, "%s:\n", "GFXCLK");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
>   		fallthrough;
>   	case SMU_SCLK:
>   		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
> @@ -795,7 +800,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		break;
>   
>   	case SMU_OD_MCLK:
> -		size = sysfs_emit(buf, "%s:\n", "MCLK");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
>   		fallthrough;
>   	case SMU_MCLK:
>   		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 627ba2eec7fd..3b21d9143b96 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -1052,16 +1052,19 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
>   	int i, size = 0, ret = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   
> +	size = offset_in_page(buf);
> +	buf = buf - size;
> +
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> -		size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>   		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>   		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
>   		break;
>   	case SMU_OD_RANGE:
> -		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>   						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
>   		break;

