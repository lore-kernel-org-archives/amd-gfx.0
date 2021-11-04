Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ECFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7B66109F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD7B66109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0BB6EB63;
	Thu,  4 Nov 2021 07:57:12 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A341A6EB63
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 07:57:10 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so6572714wme.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=s1vAhMKLyWIvdu4ol0HVD6NkFPpTfJuGgOfO4cR9dAI=;
 b=YBOtOYb3S9UYiMjdlKNY30td7WFfVqyqC6uZJ5gr+FlHMsjz4gmpcwT8dtB2kC85e/
 5FRdew5QbzExSKUL2+M2JZZGPHHSci9ObnE5nwt6/n9g/D3LL8txysOO9bMNVnmy1tAx
 7i9fiKfuvmy4U3bstU/xUpA21QjhfjWafQSTCkMeOX22jeRzzjAAYYk40XYXAh0hbH17
 BQVAefoS7Abbiu3joLwtNG6MfjBiyps9YUBQjiGohGl9GIzNy/BiGXtq9rVS4tP3vUe2
 q4cmIfgW7yDq6/b1Uzm0Nf49slJJKgJpMGmdALK58HTV6HcfbAKJNfEgSgv3aATE2XNU
 gFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=s1vAhMKLyWIvdu4ol0HVD6NkFPpTfJuGgOfO4cR9dAI=;
 b=KmxYUcp3bLscdmV06QMCq4ku6sWG7jjtJBbQIh0lSYNDas+8DztZnOFJDVe93tJl5+
 4JSEVwERiof8pvQAxLYZIRGxdKk9wIF80VY4shqxlAJbinird1pAsHbcKPymQGhzxZum
 K2T8veyxN7XvxxhqUdQAnt09vWqefNiEkWQbuFOv1y0a3S47kupB2vsZOFONon8Q03WW
 CiuABIqJafj6Q3t8QJtKsIRCD/JKss4/AXXKJWB9ZljSWToXchxThfndgRU2LHakBNmZ
 b70QUBYRtkpbjThrv57ihx/uD3nn5odsjhCo+UlXyVwGjBLG3/D+2e19r4oZZSBcU7QQ
 xu8Q==
X-Gm-Message-State: AOAM530YhsG3gGfOz+k+Gkod+JINOQav+xJaRcuB2UKjzWamuHfApg6f
 QbklDxpccetkHCkRj/kXH3s=
X-Google-Smtp-Source: ABdhPJzJKeBkbIdNc/1tfbkJvkdrHwtIEOmij0TulYWfKJa3T1hML9sFBhJKHYg8KsMHDJQ/BtlO6A==
X-Received: by 2002:a05:600c:35c8:: with SMTP id
 r8mr8703926wmq.8.1636012629102; 
 Thu, 04 Nov 2021 00:57:09 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id x21sm7617469wmc.14.2021.11.04.00.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 00:57:08 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix sysfs_emit/sysfs_emit_at
 handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104005852.2454705-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c0ce50c3-01ae-b727-873c-16fbb8de7c41@gmail.com>
Date: Thu, 4 Nov 2021 08:57:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104005852.2454705-1-alexander.deucher@amd.com>
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
Cc: Lang Yu <lang.yu@amd.com>, Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As discussed previous I don't think this is the right approach.

The distinction between sysfs_emit() and sysfs_emit_at() is exactly to 
avoid that kind of stuff.

Instead we should probably add the size parameter to the functions in 
question and so fix the calling convention.

Or even better move the sysfs print out of the powerplay backend.

Regards,
Christian.

Am 04.11.21 um 01:58 schrieb Alex Deucher:
> sysfs_emit and sysfs_emit_at requrie a page boundary
> aligned buf address. Make them happy!
>
> v2: fix sysfs_emit -> sysfs_emit_at missed conversions
>
> Cc: Lang Yu <lang.yu@amd.com>
> Cc: Darren Powell <darren.powell@amd.com>
> Fixes: 6db0c87a0a8e ("amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1774
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  8 ++++++--
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 10 +++++++---
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  2 ++
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h    | 13 +++++++++++++
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++++++++---
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  4 ++++
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 14 ++++++++++----
>   7 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 1de3ae77e03e..258c573acc97 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1024,6 +1024,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	uint32_t min_freq, max_freq = 0;
>   	uint32_t ret = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
> @@ -1065,7 +1067,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			if (ret)
>   				return ret;
>   
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -1081,7 +1083,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			if (ret)
>   				return ret;
>   
> -			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
>   				min_freq, max_freq);
>   		}
> @@ -1456,6 +1458,8 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
>   	if (!buf)
>   		return -EINVAL;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
>   			title[1], title[2], title[3], title[4], title[5]);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index e7803ce8f67a..aceebf584225 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4914,6 +4914,8 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int size = 0;
>   	uint32_t i, now, clock, pcie_speed;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
> @@ -4963,7 +4965,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_SCLK:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
>   					i, odn_sclk_table->entries[i].clock/100,
> @@ -4972,7 +4974,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_MCLK:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
>   			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
>   					i, odn_mclk_table->entries[i].clock/100,
> @@ -4981,7 +4983,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_RANGE:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
> @@ -5518,6 +5520,8 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
>   	if (!buf)
>   		return -EINVAL;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	size += sysfs_emit_at(buf, size, "%s %16s %16s %16s %16s %16s %16s %16s\n",
>   			title[0], title[1], title[2], title[3],
>   			title[4], title[5], title[6], title[7]);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b94a77e4e714..8e28a8eecefc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1550,6 +1550,8 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	uint32_t i, now;
>   	int size = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		now = PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> index ad33983a8064..2a75da1e9f03 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> @@ -109,6 +109,19 @@ int phm_irq_process(struct amdgpu_device *adev,
>   			   struct amdgpu_irq_src *source,
>   			   struct amdgpu_iv_entry *entry);
>   
> +/*
> + * Helper function to make sysfs_emit_at() happy. Align buf to
> + * the current page boundary and record the offset.
> + */
> +static inline void phm_get_sysfs_buf(char **buf, int *offset)
> +{
> +	if (!*buf || !offset)
> +		return;
> +
> +	*offset = offset_in_page(*buf);
> +	*buf -= *offset;
> +}
> +
>   int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr);
>   
>   void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index c152a61ddd2c..c981fc2882f0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4548,6 +4548,8 @@ static int vega10_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
>   	int ret = 0;
>   	int size = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	ret = vega10_get_enabled_smc_features(hwmgr, &features_enabled);
>   	PP_ASSERT_WITH_CODE(!ret,
>   			"[EnableAllSmuFeatures] Failed to get enabled smc features!",
> @@ -4637,6 +4639,8 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   
>   	int i, now, size = 0, count = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		if (data->registry_data.sclk_dpm_key_disabled)
> @@ -4717,7 +4721,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   
>   	case OD_SCLK:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
>   			for (i = 0; i < podn_vdd_dep->count; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
> @@ -4727,7 +4731,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_MCLK:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
>   			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
>   			for (i = 0; i < podn_vdd_dep->count; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
> @@ -4737,7 +4741,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_RANGE:
>   		if (hwmgr->od_enabled) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
> @@ -5112,6 +5116,8 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
>   	if (!buf)
>   		return -EINVAL;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
>   			title[1], title[2], title[3], title[4], title[5]);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index 8558718e15a8..f7e783e1c888 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -2141,6 +2141,8 @@ static int vega12_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
>   	int ret = 0;
>   	int size = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	ret = vega12_get_enabled_smc_features(hwmgr, &features_enabled);
>   	PP_ASSERT_WITH_CODE(!ret,
>   		"[EnableAllSmuFeatures] Failed to get enabled smc features!",
> @@ -2244,6 +2246,8 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int i, now, size = 0;
>   	struct pp_clock_levels_with_latency clocks;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		PP_ASSERT_WITH_CODE(
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 0cf39c1244b1..03e63be4ee27 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3238,6 +3238,8 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
>   	int ret = 0;
>   	int size = 0;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
>   	PP_ASSERT_WITH_CODE(!ret,
>   			"[EnableAllSmuFeatures] Failed to get enabled smc features!",
> @@ -3364,6 +3366,8 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int ret = 0;
>   	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	switch (type) {
>   	case PP_SCLK:
>   		ret = vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &now);
> @@ -3479,7 +3483,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	case OD_SCLK:
>   		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>   				od_table->GfxclkFmin);
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> @@ -3489,7 +3493,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   
>   	case OD_MCLK:
>   		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
>   			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>   				od_table->UclkFmax);
>   		}
> @@ -3503,7 +3507,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
> -			size = sysfs_emit(buf, "%s:\n", "OD_VDDC_CURVE");
> +			size += sysfs_emit_at(buf, size, "%s:\n", "OD_VDDC_CURVE");
>   			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
>   				od_table->GfxclkFreq1,
>   				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
> @@ -3518,7 +3522,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   
>   	case OD_RANGE:
> -		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>   
>   		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> @@ -4003,6 +4007,8 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
>   	if (!buf)
>   		return -EINVAL;
>   
> +	phm_get_sysfs_buf(&buf, &size);
> +
>   	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
>   			title[0], title[1], title[2], title[3], title[4], title[5],
>   			title[6], title[7], title[8], title[9], title[10]);

