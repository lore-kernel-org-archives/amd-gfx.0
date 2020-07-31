Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A49D2177B
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EXARSdhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A49D2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB176EACC;
	Fri, 31 Jul 2020 14:38:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86D76EACA
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 14:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWWBc5+acPzuPTMBH3TlfS8CXF+ukW/06TNrdvLqklqy590eRptulg0jqR4l3TcOu1JIJwi4LXMgDg485vmKtv6bHanBU44+8vvziBLVZNvCp9SWUUr7S/ABAa5n6dFInYPHgmCFiXLF/wOeBTgkItvFJzW0VsSEcYvqjXwXwhhp6WZ/AyFLI8pflua6ZqIr65t8JraqlBKW4r52ZDuswTUGvC/i6smE6oSH7qEFe5YaChQ1i2VWWRojSS8jn2KyWAdjnCpyrJGJi8OVVj5rh13x1Q/L7fxqtSD3UHO+JPw/dDxnaa8/w3G7fblntdWbBQ+7t3XHtoYIeiaXJoja7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCX2azxvYPqOzM4wjG6VLJ+KjaFege5byy3Wsjsg+t8=;
 b=MTvCHesshqlUpn8H8lqJOGssoghPJtYslW8nk1Mw+29d+DqnIP4+Mt/3dWFdZ5fyRHV1tF6q7/2tcKa1AeYBqYBB9jA0cA84rMwHV3ZhUZNC7AMOnkJFDAwZte8iXUDyZsQrGzMFUQwmvZWblaF9uSpc4sfU4XDP9wOBvdUNDVNhBS5IZOLXhxx4hR+MJN7bG2D6ODL98hw0Eq5cpCWwP4CXpqyhVjfnG8gdzPCy6gMOu/qb5JwSJ7l+/TOx9vv0EW6SlyEnkoDF+meOidTTt1hf6Wbn4C0YXoKbeDIpiAG4e3t3NujK67AkVGmZGV/rFILStzNlR9R3u3qhvd/JAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCX2azxvYPqOzM4wjG6VLJ+KjaFege5byy3Wsjsg+t8=;
 b=EXARSdhkJ74sVxnOEYRhGRzdLHTSYbP/ZRj9IE6bLC6417AeqaiPMJCg6bilkYhWGom7T2l61uzGQc0qi8CfIgg6Rvhd/E3eF+cek+d5qW7m7hhHFxhO+oq20Ozuv18imRvbF/iHwWZDumISLo0WbDWmBXrpbKmxe3TEdr1uWRg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 14:38:08 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::718b:874b:e858:382c]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::718b:874b:e858:382c%2]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 14:38:08 +0000
Subject: Re: [PATCH 08/17] drm/amd/powerplay: add Renoir support for gpu
 metrics export(V2)
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200731024316.28324-1-evan.quan@amd.com>
 <20200731024316.28324-8-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1ef57017-dd65-dfd8-6051-d3fd5ecfccec@amd.com>
Date: Fri, 31 Jul 2020 16:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200731024316.28324-8-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:404:f7::18) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.1.21] (165.204.84.11) by
 BN6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:404:f7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 14:38:06 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23d01e37-0938-432e-35f2-08d8355f5796
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4183FE3BC82C408E959711BC8B4E0@CH2PR12MB4183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbnkFrVhp8/Z1DwTpcDUIGhI4lLfcr/WTtYuG9igTmzRZhN0+73qqzHJBGkOqEsUpB1i65nAu4Bp4z4hthLmgZBieQDdNQLmTBNjyAV9WcxBGa0iXUcUzFgQFcYMrPmfSFOOAxxnjJB9u8VcUmWyT+SuQNTNZJJYDWImqbs4KU3jrgTMPhZwMkncDVnevu+SMYvgKCOJAveauIxuvtNGEh+KQ2SzEckMPskS99awa9XznLceEY7jGod4xzcQHrBYKwtvJELzLQy6+QndE/8A40NGKLMLZwp6w6IjnPnpzqDwMuIhK5gAkroT8zQ3tps9j1D7YKn7RlW0GPbf5rsaPaw9muSeUoLyh8H6pFVlBBTzGWtHM+Zyz1vO4nOjW3Vb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(6486002)(83380400001)(16576012)(31696002)(5660300002)(31686004)(316002)(956004)(2616005)(36756003)(66556008)(66946007)(186003)(16526019)(2906002)(8676002)(53546011)(66476007)(52116002)(478600001)(26005)(4326008)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4mvzU6IavFXmGSuI2CncqtSlODs26/V/osadBeqTGNWJJuZ5Z6BNIFXUvcCQNhZ11LhsRCdwvkczPp+7QE0xCx6sIDLT5Y8sEgrTgyWu/DiHbe/SuJTBONsI+Ektkj93iP/6Z4c4YHFnYGpgbIQVYZhCdAyQ7Q4MK07JTzBs+ROl20D2PRbJrTHI1xQSx25YFkAWajySNcp/HEeS9QDn7g1ZIXvhMWORrh9/6/WYzJWLwbPNOUhlyI2i0IHWUYQ48T37t3GZQfZmF0ySqOddj1kvzX4mf8cAJtLwjctCAbFLp4Wzc6RWoYgxcbHaWg0VFPA030TBo5UyqyOf8Vhuka34u52VwObb+lEgZy7JpBms/lClpFI/Ft+qPSM2LxVUJ7q4MVKMsgaDUXnMkku0xuiaFMkarh+GVc/Wr0YMFxSXUyaqjbSg6twioJ6ZvC/JLqvhrEuo/g4wGZHyvJDaJ5P6ltpj8RLDYgBAT5p0Is32fFR0D3HRHvVG6baHK1vOyRhAKTqupi1hj3A7UUnfCqsjel/6fyMZroiXPELpbhBq5cLMYgGAkQEmzOlIrVaXGEbQ6AS5VmUFSKO7BsLGkeffevWIloQWhoCBSbGQQDjfyPOr6MZNy9xR1/3ggKp81JlcDfN4n8jvUjXPAhcvWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d01e37-0938-432e-35f2-08d8355f5796
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3911.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 14:38:08.3410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nwKPqSrWOwjPLFjSDjVBOPXohEDl6efPH+pyn2xh1DR52+riO4K8TejwiGKQ+Cs+4NYltN4jypEJhBdpRX0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Harish.Kasiviswanathan@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 7/31/20 4:43 AM, Evan Quan wrote:
> Add Renoir gpu metrics export interface.
>
> V2: use memcpy to make code more compact
>
> Change-Id: Ic83265536eeaa9e458dc395b2be18ea49da4c68a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
>   drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 80 ++++++++++++++++++-
>   drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 12 +++
>   3 files changed, 91 insertions(+), 3 deletions(-)
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
> index 575ae4be98a2..61e8700a7bdb 100644
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
> @@ -995,6 +1009,65 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
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
> +	memcpy(&gpu_metrics->temperature_core[0],
> +		&metrics.CoreTemperature[0],
> +		sizeof(uint16_t) * 8);
> +	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
> +	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
> +
> +	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
> +	gpu_metrics->average_mm_activity = metrics.AverageUvdActivity;
> +
> +	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
> +	gpu_metrics->average_cpu_power = metrics.Power[0];
> +	gpu_metrics->average_soc_power = metrics.Power[1];
> +	memcpy(&gpu_metrics->average_core_power[0],
> +		&metrics.CorePower[0],
> +		sizeof(uint16_t) * 8);
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
> +	memcpy(&gpu_metrics->current_coreclk[0],
> +		&metrics.CoreFrequency[0],
> +		sizeof(uint16_t) * 8);
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
> @@ -1029,6 +1102,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>   	.is_dpm_running = renoir_is_dpm_running,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
> +	.get_gpu_metrics = renoir_get_gpu_metrics,
>   };
>   
>   void renoir_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 31456437bb18..660f403d5770 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -274,3 +274,15 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
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
> +
> +	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> +}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
