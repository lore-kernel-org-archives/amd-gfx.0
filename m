Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDCC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F32206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W/YL/R/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F32206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF9D6E87E;
	Thu, 30 Jul 2020 07:24:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A416E87E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 07:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMAtq0Mo7jCfDkbVg0vjiOxUqh4+zlAK2enYmRHWEEatDWI7SnsjISN/QOdG5IFm9hK/lQPbmTEJ0JMmkWzJ4oO+DyqgVjkWE0qGkj6g7jbeuWm+lY3iS9cfuH2VHV/iUUWAeD5wMmhcYI15xzYTIjCtZkEPyiBw6wTVsxRZv/0JwffhAY4DDIRvOVEe+u9ok/LWN27qqxFMKFEz6egDQQ7Ok7ks63Sh+WCUmDOEU01lSd+mjOg2acWDkyKG0UXXTYMYu/Rt0mSgHoV3kS0rL5wUx/iuqHkSpFdf1YWct+SD0aPTCcmNYZOSNxTWKhMpMNPDPIGqDkBHHNHkrjMGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVR2IPI6anNwAjYV0h5kUEfDrWBob1bRGQ1cZ6bcpxY=;
 b=HXj2zYuxXjj/aImUZZ7Zh9jzAteGSsIEGxtN+UpqpyUVc0RnK1hbK180961IhgI8KGFHC0UlIVY5heGjTanO9jimDQdpQWxIPAY0TBe8dPxQUo5oBGalYSOqnuY9Ggo9T2QpuqTK+RmBkGiBrBWPl7tFCStJ+lMP1PeC0KvUdtpD+umt8Mqt9gTwghxlbcKOR4Pq+k0cAkGEX20wbloWsNAgCdUrNi27hDm7Ge1pXoEXIAhsgTCT2awwoNCoEAXuijQHLas3tc2rX24frowmBk5DJPLECKUOMLhWowNYcC5EFC8pFTYlnibTZTktQLiqHTxil5gYiUcFaSapls7VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVR2IPI6anNwAjYV0h5kUEfDrWBob1bRGQ1cZ6bcpxY=;
 b=W/YL/R/7fHe1w7zN/N2bN7uDuFwIy5NnqvIIIMMCpxENdD2lmyGxDWp5Fbh5yTyc3V7JYqScmRf4Iq69GVbSHc1RMx7Ls8skIzpvr5GcZp8i5DjGh1MMjR1JKd/zMvSfIqSO8RXTUvKu2BgvpYdFrDtzgIVyZb+NIR+fT/kSwQ4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 07:23:58 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 07:23:58 +0000
Subject: Re: [PATCH 8/8] drm/amd/powerplay: add Renoir support for gpu metrics
 export
To: amd-gfx@lists.freedesktop.org
References: <20200730032839.2517-1-evan.quan@amd.com>
 <20200730032839.2517-8-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0785697c-2455-e0e1-77fc-83a1bf125211@amd.com>
Date: Thu, 30 Jul 2020 09:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200730032839.2517-8-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR2001CA0033.namprd20.prod.outlook.com
 (2603:10b6:405:16::19) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.141] (165.204.84.11) by
 BN6PR2001CA0033.namprd20.prod.outlook.com (2603:10b6:405:16::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 07:23:57 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c413f11b-5e0b-4412-c161-08d83459861a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:
X-Microsoft-Antispam-PRVS: <DM5PR12MB159662C2D2230D4758E2FD8D8B710@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UhZTGoeuxGGnEsjR5v+w8KNYkHYCOXcnbqYOzA1RPL03IXiyfYtXQu6zAfFcGlxxC9IgPTVDI7iLFEwxJLq6zP8gkjyVMkplizXh/UQIlvB0VCOBM+rstFp6iGckykg0ITAKLcaVuHAbg9CgCVUlcUAuBiyMXSHALsSGgCaJU9Rw+y5oNoI5S3BCo5voqffvOGUkC94RJyriNtV3QpD925CmJX1kf7aFeoyCD2ruc2LsTefXjNDAxBgB/7ANsJtBZjtw3pekWmg25ulBsYEnh0SAVH5OUVT8n52LgVGlu3zGBJOS2//s5SbQtInfrq9AgUVvUq4zvTWxN+U+KTJnQPpfhVpLUV1E/kwk7t3MLopnO6n5Lr5ZDK1/KIkxizr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(31686004)(83380400001)(5660300002)(2616005)(2906002)(6666004)(66476007)(36756003)(956004)(66556008)(66946007)(6916009)(53546011)(8676002)(26005)(16576012)(52116002)(316002)(8936002)(186003)(16526019)(6486002)(478600001)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XyNRkMZvTCUXI1OgBMG0AyOoyyBGaFmqhibC39EjUDDiCKfTsm1KGR43KbuW4ephEeD2ksTh2fI83/7agI3GtQ0Wr6pS9M14/4gPVsUDarNkkwSYixOtzJNOuvYK0oPoglbbBBz0Bl9vxwPx7GQX4UABK4aVqvf77tabJIuvVL2Fdvnyx0F+igmstJUGtWZX8DH/QTIpI5ibADWp2J7JE1P2Sbb0iUWokjSxBVTwZM5TCpTuGmnKJNu4AtxSaVKFBk2p4CdqnFURIgS0bomLij6kQ3xFK82p5zDfpgzcMXrqrE+26rzqRhFCHiFj0iK1X0lKxrS05uUQlXG10clJ3FV69/rf1KPrZCXobJrB0aw4BtpRWNHPO8fvhagxlDRaK6VoOC8YivIqkGvCZQKLZ0ibjOSdKttufbehwzvFiiYCb8EHnNqw2Zj9YYnqhgxS3r/JlKepazPxLuN8KZh5soNm94Z6WYzE4BmygZe0kjY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c413f11b-5e0b-4412-c161-08d83459861a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 07:23:58.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5cyhNnQ+HFSg9rBgQUGW4+z4PEzIZEBMkSV66H12+os8RO+O3WNESV3fjsdOlup0h7JhCVkLNAj+OfdTEJ44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/30/20 5:28 AM, Evan Quan wrote:
> Add Renoir gpu metrics export interface.
>
> Change-Id: Ic83265536eeaa9e458dc395b2be18ea49da4c68a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
>   drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 95 ++++++++++++++++++-
>   drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 10 ++
>   3 files changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> index 02de3b6199e5..fa2e8cb07967 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> @@ -60,5 +60,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>   
>   int smu_v12_0_set_driver_table_location(struct smu_context *smu);
>   
> +void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 575ae4be98a2..8d73781775bc 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -166,18 +166,32 @@ static int renoir_init_smc_tables(struct smu_context *smu)
>   
>   	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
>   	if (!smu_table->clocks_table)
> -		return -ENOMEM;
> +		goto err0_out;
>   
>   	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
>   	if (!smu_table->metrics_table)
> -		return -ENOMEM;
> +		goto err1_out;
>   	smu_table->metrics_time = 0;
>   
>   	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
>   	if (!smu_table->watermarks_table)
> -		return -ENOMEM;
> +		goto err2_out;
> +
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
> +	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
> +	if (!smu_table->gpu_metrics_table)
> +		goto err3_out;
>   
>   	return 0;
> +
> +err3_out:
> +	kfree(smu_table->watermarks_table);
> +err2_out:
> +	kfree(smu_table->metrics_table);
> +err1_out:
> +	kfree(smu_table->clocks_table);
> +err0_out:
> +	return -ENOMEM;
>   }
>   
>   /**
> @@ -995,6 +1009,80 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
>   
>   }
>   
> +static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
> +				      void **table)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct gpu_metrics_v2_0 *gpu_metrics =
> +		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
> +	SmuMetrics_t metrics;
> +	int ret = 0;
> +
> +	ret = renoir_get_metrics_table(smu, &metrics);
> +	if (ret)
> +		return ret;
> +
> +	smu_v12_0_init_gpu_metrics_v2_0(gpu_metrics);
> +
> +	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
> +	gpu_metrics->temperature_soc = metrics.SocTemperature;
> +	gpu_metrics->temperature_core[0] = metrics.CoreTemperature[0];
> +	gpu_metrics->temperature_core[1] = metrics.CoreTemperature[1];
> +	gpu_metrics->temperature_core[2] = metrics.CoreTemperature[2];
> +	gpu_metrics->temperature_core[3] = metrics.CoreTemperature[3];
> +	gpu_metrics->temperature_core[4] = metrics.CoreTemperature[4];
> +	gpu_metrics->temperature_core[5] = metrics.CoreTemperature[5];
> +	gpu_metrics->temperature_core[6] = metrics.CoreTemperature[6];
> +	gpu_metrics->temperature_core[7] = metrics.CoreTemperature[7];


memcpy() would this much more compact.


> +	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
> +	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
> +
> +	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +	gpu_metrics->average_mm_activity = metrics.AverageUvdActivity;
> +
> +	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
> +	gpu_metrics->average_cpu_power = metrics.Power[0];
> +	gpu_metrics->average_soc_power = metrics.Power[1];
> +	gpu_metrics->average_core_power[0] = metrics.CorePower[0];
> +	gpu_metrics->average_core_power[1] = metrics.CorePower[1];
> +	gpu_metrics->average_core_power[2] = metrics.CorePower[2];
> +	gpu_metrics->average_core_power[3] = metrics.CorePower[3];
> +	gpu_metrics->average_core_power[4] = metrics.CorePower[4];
> +	gpu_metrics->average_core_power[5] = metrics.CorePower[5];
> +	gpu_metrics->average_core_power[6] = metrics.CorePower[6];
> +	gpu_metrics->average_core_power[7] = metrics.CorePower[7];


Same as above.


> +
> +	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
> +	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
> +	gpu_metrics->average_fclk_frequency = metrics.AverageFclkFrequency;
> +	gpu_metrics->average_vclk_frequency = metrics.AverageVclkFrequency;
> +
> +	gpu_metrics->current_gfxclk = metrics.ClockFrequency[CLOCK_GFXCLK];
> +	gpu_metrics->current_socclk = metrics.ClockFrequency[CLOCK_SOCCLK];
> +	gpu_metrics->current_uclk = metrics.ClockFrequency[CLOCK_UMCCLK];
> +	gpu_metrics->current_fclk = metrics.ClockFrequency[CLOCK_FCLK];
> +	gpu_metrics->current_vclk = metrics.ClockFrequency[CLOCK_VCLK];
> +	gpu_metrics->current_dclk = metrics.ClockFrequency[CLOCK_DCLK];
> +	gpu_metrics->current_coreclk[0] = metrics.CoreFrequency[0];
> +	gpu_metrics->current_coreclk[1] = metrics.CoreFrequency[1];
> +	gpu_metrics->current_coreclk[2] = metrics.CoreFrequency[2];
> +	gpu_metrics->current_coreclk[3] = metrics.CoreFrequency[3];
> +	gpu_metrics->current_coreclk[4] = metrics.CoreFrequency[4];
> +	gpu_metrics->current_coreclk[5] = metrics.CoreFrequency[5];
> +	gpu_metrics->current_coreclk[6] = metrics.CoreFrequency[6];
> +	gpu_metrics->current_coreclk[7] = metrics.CoreFrequency[7];


Same as above.


> +	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
> +	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
> +
> +	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +
> +	gpu_metrics->fan_pwm = metrics.FanPwm;
> +
> +	*table = (void *)gpu_metrics;
> +
> +	return sizeof(struct gpu_metrics_v2_0);
> +}
> +
>   static const struct pptable_funcs renoir_ppt_funcs = {
>   	.set_power_state = NULL,
>   	.print_clk_levels = renoir_print_clk_levels,
> @@ -1029,6 +1117,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>   	.is_dpm_running = renoir_is_dpm_running,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
> +	.get_gpu_metrics = renoir_get_gpu_metrics,
>   };
>   
>   void renoir_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 31456437bb18..533b0f04c85c 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -274,3 +274,13 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
>   
>   	return ret;
>   }
> +
> +void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
> +{
> +	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
> +
> +	gpu_metrics->common_header.structure_size =
> +				sizeof(struct gpu_metrics_v2_0);
> +	gpu_metrics->common_header.format_revision = 2;
> +	gpu_metrics->common_header.content_revision = 0;
> +}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
