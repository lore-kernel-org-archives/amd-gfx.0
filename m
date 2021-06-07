Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07975C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E876109F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E876109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F766E8E9;
	Mon,  7 Jun 2021 14:35:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A08F6E8E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtF8f528CZ9QS+/FC6nGlH3is4U6rQ9Hh7Z9jRTDGAFdm/uMuB85SF/RZfyGu25+SRXxDOvVacdpI8AkHFw8uXlJR+MoCFZb1yAds0DZ5PJWurbGwGTiXSiHnzb0+SACoGiSZv7SljRUT1cZbgi5gl/9F+WasyoR+EAnF2ctZEKhYny+xVy+uA0G8cRU2TOBe3iPl+6OCAfsWTiYcdlydC733VMvSYz45/TymKk+aQ+YJjHxC3IPayV0LYR17KnNK3lhAiOQuDwOBpGIW+oG1RsCocCBSqZSs3TAjAiF2hliSWZEs6IQek75SbJF6GKld6iLg5kqBys++3sT2yyYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+krYgdWLztVF4nrfNn4cEZkRSZS94aAfwSvio3q/VMY=;
 b=UE4BEEai1afGXOGnimJrO8Ma+mIV3JLbKqp2vnScA/2qr7s0JePfeQssTFGfQ4HQnYJCethrJNganVYDqvBIiE/NCGE3PuaneAfq5AjpAVNl9VK3NCiiO7OCxum5gutRAWiSmszVqQXFMQp+BKcsV1JulpRDJUwBrBhV7lqYg3uOUg55T1Kj30gih7by/GJozFwtJ0g+yPMpParAguuIOPoEJS7RgoMza7MXfeNJ3WgMmv28oV7WpXsWz/GTcOtccGCblp10uC7GDNFZgLYafir/pGbMa/xMGTtzXp+YZZtDT8nVuSVKHZtUt/eETsvdt35HZqIBrcDEyuTSrGe0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+krYgdWLztVF4nrfNn4cEZkRSZS94aAfwSvio3q/VMY=;
 b=DBb3jl/f2jWDnuSEfgHfcjDrwsOs449Tr8t7x6Y+v8OAFS1GL/ziCxLYbikmtVtVNG42zorjQKWWfodxPXwXt1BczqemOoflzPbdvTJICjCtf48lLrw1bVhf+Vq+Qn23HyiTiO49Xn+hjS5EBFk+QVqtdQ3M6RkNEnzEGE2K6c8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 14:35:25 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:35:25 +0000
Subject: Re: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210607134439.28542-1-Graham.Sider@amd.com>
 <20210607134439.28542-7-Graham.Sider@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <26b9761c-eb4d-6c30-7817-18054efb6006@amd.com>
Date: Mon, 7 Jun 2021 20:05:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210607134439.28542-7-Graham.Sider@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MA1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::28) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MA1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 14:35:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c65c968-1b6c-4b48-e2ea-08d929c17c9a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53883F0F7D810FF9657D406F97389@CH0PR12MB5388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7vuuPgbE2zUU0NV/15WHikvEmAZMJ7ESGgHHtbvVFUY0LX7DhUf92dIKBR8DknQRkReIzoutJP4j6nE56gCapyJzmgl7Bt6Lf98jcaA10oENmi2zH0Zz1e49mIiSbjw9ZtZR9OhD0pYbLK3AHolCevTf1VLqDOWo6drKFCZfbQTd9kWFwOGq2DLnIuUm2R5thSfg1O67mYjwcZfyQ34+RfA5ihZBjwc/ffTDKDSbOxYdxmPjBPxZw+I/njh7iHY48hhrOz4pQTfjEsCzgbHxXWZzGLUqfDOqc3wbqRP43uHky+kPjT5BCZkLQ20s+w8vxuCv8x8to0CZLwgC3WFzrQAeZjJwZWQS7QLn223tj1zLEsrEq3eZ5sElf8mKX5LLK9L0lt/HgS9iy4XRhFLz2llNoy8vqG+OVfMnB0fdf89C+gMJLikS4Q39FcyFj3KqZzJQDYeOWGqfhiEzlm/UBgO/4n5Xe2u3lxVzlPrNg4zJPAMoFPv6FOVxhIAXjc2416u3IU2rJmkUYuY2Mez9hJYME5bxmuO5AmF+79aVgHMLTqUwQYeAlmu5bL1RjbhgxmIYpiAmsxJ2G9DBQcXQTR8zjrLfb9ON9THegDqspS5SKRiqu0Hb+9lsd3yUpgk0BrlIcId4BRjCnhhuSUFXtYdHo4hjuTY6xUqbuqew8VLkJYOKrKqXnVXgvfZms40
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(31696002)(26005)(186003)(36756003)(86362001)(83380400001)(16526019)(16576012)(53546011)(316002)(956004)(6666004)(31686004)(5660300002)(2906002)(38100700002)(478600001)(4326008)(2616005)(8936002)(8676002)(6486002)(66946007)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjU3SGF2SlZPc3ZlajhaOWFKY3Zsc2ZMUVZsT0hoaXBWU2ZZckQ5TmFPQlcv?=
 =?utf-8?B?R1VDTU92b3ozeDhLQXdhazJ1RUdKc0dYeHlPZEVLREhaK3U4OE8yeU5VQnhO?=
 =?utf-8?B?c1BGQTliN1JEdkVKRXpOVWJHelpZbis5dkcrQmdNcmRCc3FDaXJKWi9IMmhY?=
 =?utf-8?B?UW1heUs2QmpwVk5aaXRQZGJhM0pGdEp1dFZZb01kUWVUa0x4aVV5T083eVE1?=
 =?utf-8?B?b2t3S3lxS25KUWlqWXFRWHJTbVFVU0RCd2krMVRFenhRb1pjSDhQUkJkajZv?=
 =?utf-8?B?byt4RHhrWnhyZytWcVlOTHBQYU1GeU9iczhSTzBxWDRMa2lSUUFjVzIzZy9Z?=
 =?utf-8?B?azNhekRHM1FYVzZGaEM1UFQ1amJJVldnVUU5V1pDTnp6TGY0c1Z1S3NFaDlj?=
 =?utf-8?B?THcxOERCaGVIL3E0c0VuRG5OMU8raGgyQmNFby9LcnBQRHI1R0hJWUZqSlNW?=
 =?utf-8?B?NjQ4Y3AvSUdzWERtQXN2QWR1VTlZMjIyZFRCbExLeUg4aDRRSTYrL1k2UXBx?=
 =?utf-8?B?c21vaXVZeTdLQ3RseEZCT0E2aVF0b21UZGdCNmJBdk90dUVSaDU5WXhaZ28v?=
 =?utf-8?B?NFd4R1F5L2NHSnVxU096MGVEUUp5YThlU245Njh6cmhpTEZSc0huK2YrRTNs?=
 =?utf-8?B?K0lhZmRLbVphOTVMK0trOUJ6eHc5NWRFbXU2ck5vaUlVVWZ2N3phUm5nYzFs?=
 =?utf-8?B?VDNwTGcreXFxaU41OEs0UCt3UHFoV1RwKzZDeWZ0WkQ2NUVhck1aRVZ6OHVL?=
 =?utf-8?B?cXBnazVOajhnRTJVSjFYY0YxK3dJVk9qNlBQYmR3STRnNUEvcEZGLzFlVnNC?=
 =?utf-8?B?TjZwRXB2c2tJYXpOY2VHYXZOMnpjeUtCZ3RMSUpIMXJhclFZTzhkeVhiV3FS?=
 =?utf-8?B?TTFoYWswUXpPb0NwcTJVakpPRjZnK0M3SHFKS2lmU3lQb0FESXYzMDd3b2J1?=
 =?utf-8?B?QVNhZE50dlJKYndveDFqdk5ZbHYxODZiZjN6L2wzRDJuMXd6M1VSbUNKbHVl?=
 =?utf-8?B?UW8zUjVyeHBuSWt6MDNKelVwMzJITVpxa0tETE1YQ2dGa2wzOTY5bHE3QUYz?=
 =?utf-8?B?TmlRVnNDNkJvZmIxTGdDTWNEc3B5Y1BaUHpnNVovaHc1Y2lHN1hwZStpYmVZ?=
 =?utf-8?B?YVBDS0tLbWhoWFQzbnR1UlVNVXJkSmkzMkhqMmE1UVdFYjJsVjJDR0ViWU9i?=
 =?utf-8?B?NXREaE9qMUlNcUxQWGVXSUN4NDRSWmM2RVQvc3JCMnkvbVJnSzNuZEUwbUdD?=
 =?utf-8?B?dmk2YWJTZmxpV2c1MXZRVHFqbG9oTDlhWERGaGhWdGpJNXluU2JnYVdmRVNP?=
 =?utf-8?B?NUpBQXJ2c3lyY254eGRCZjdRTEV5SFJhVTcvcnpiT1htMkdJYUJqZkh5cnZo?=
 =?utf-8?B?b3ZCU3lBbEFxck4raitBQ0RrMVhWRWRNb3RCUExUajZiVVQydWsyR2lqNGdQ?=
 =?utf-8?B?VFVUeVIwVSszMC9MQ0didVV0ZFJJbVhqbXRZaVQvZUx3Z1VPN010a05mYnJn?=
 =?utf-8?B?OUZPL3haZmtNK0RCRjg1WG5FWWJSckoxSnBTZThWOWk0b0hhSzJ6ZzRpdUJs?=
 =?utf-8?B?TGd3dGFOYmZsRWFrQ1N3K3pLT3NWdUNKUStwL2JVejdleTFyWm9Vd3ZlOVJR?=
 =?utf-8?B?REVTNjRReDlEYXZHb0R4SlBxS296TDgxVDdLaEdBeU5LdjEwNTdRWVdjdFZy?=
 =?utf-8?B?TEp0MVBkRGtjZGRkQlU3NDk0WC9GNzkrdkNZL3ZTY2FzMnZQQUpaU08xaG1M?=
 =?utf-8?Q?QuQYhYZZh6x0ET3XUYh2IQ3K+/c/LrgU2sHAulr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c65c968-1b6c-4b48-e2ea-08d929c17c9a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:35:25.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkr1REH1IRu0hTOp6RcIV9aekr+gshsHJMXB0+RD6Q/Sx9a/potZlsIsrOww/9TD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
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
Cc: Harish.Kasiviswanathan@amd.com, Elena.Sakhnovitch@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/7/2021 7:14 PM, Graham Sider wrote:
> Perform dependent to independent throttle status translation
> for vangogh.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 ++++++++++++++-----
>   1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 77f532a49e37..589304367929 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -190,6 +190,20 @@ static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT]
>   	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
>   };
>   
> +static const uint8_t vangogh_throttler_map[] = {
> +	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
> +	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT]	= (SMU_THROTTLER_SPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT_APU]	= (SMU_THROTTLER_SPPT_APU_BIT),
> +	[THROTTLER_STATUS_BIT_THM_CORE]	= (SMU_THROTTLER_TEMP_CORE_BIT),
> +	[THROTTLER_STATUS_BIT_THM_GFX]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_THM_SOC]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),

Above two mappings don't look correct. They essentially mean throttling 
due to GFX/SOC domain temperatures in APU exceeding their limits, not 
the VR temperatures. Except those mappings, rest of the patch series 
looks good to me.

Thanks,
Lijo

> +	[THROTTLER_STATUS_BIT_TDC_VDD]	= (SMU_THROTTLER_TDC_VDD_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_SOC]	= (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_GFX]	= (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
> +};
> +
>   static int vangogh_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -226,7 +240,7 @@ static int vangogh_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;
> @@ -1632,8 +1646,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
>   
> @@ -1641,7 +1655,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.SocTemperature;
> @@ -1674,20 +1688,23 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> @@ -1695,7 +1712,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
> @@ -1735,12 +1752,15 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.Current.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *smu,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
