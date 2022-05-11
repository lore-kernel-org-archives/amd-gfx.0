Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8745EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEDD10E1B0;
	Wed, 11 May 2022 12:01:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7365510E258
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXu+exYF6WBdprf4zrHdyJjWzmbZQlGwFpCDXRxOlu1XVcPDI8H6P+dJ4apAx9Z9Bt+9g6qEXdK6ocbiQpnKfDtJ8zZiqWAJwbMXfQelkRifvyX7RAwkR2eyKyJ1BaYYvV8/ymiEJ/Z3rVcJeyaSuqgRxTZQTWdz6Gc20Na+3AApWM98BEg90hpMJzqY9gJ3K5i2S3U+TNpZZH/NrCq4kDfaOKOFLuP6UWod/kFJEDC9Ymx12z4oiZNWLBxKF7heR+8uWv3SyWtmkBXPfIcEp2pJhpXr+LVpx+eoWcvcnC8eccZ8THzqwCmPc6eB9qCvklNbOWejCOFyBnf0MIMG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X732fqnRKJJqpvBprJlP8bubq4/TkUrZSqgVrMWMLOw=;
 b=PlNKhQGnEdxm4XdiUBQkxQAE2zwOZU5CnELYskNTXyG6EK6e1QCT8/rh84skC4seLvZuylHMkXJdX7UPb1fhKfvh1CnUj6x1TrXoKjIMoQRGmEb3IeWFvR+nDepQTp9yVhoEG5/sSSH0wkjdHyG3s9jOXVxnYPv89EH5sRBLEstjn6YSagKppCqfXwzHx/rrlOTFNAJWdyYH/oEOya0A1tz/nFzfST+Zh8QAKC0LMrNfKTqrUe9A/wuuYb1tyg+2jcSBVEeITnTZB6jDS6BQNTE3b8QOjwyb7iidytQCmtSy05giCGvcXr5LNq1wMt52uQirHuUXpCGWxGfmaNvPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X732fqnRKJJqpvBprJlP8bubq4/TkUrZSqgVrMWMLOw=;
 b=ac31uC9GwqHR1nQEndr5Q/tsIBS7mQ3hHgE8gRtXFui5u2H9fUehquKeXnuJC/VtCWXxvqUpBUoMHVxBTTmVisb5CS/XPSyFLoIUkudnhYmMeya28ppcifZtP46QpkSp1Y0ugQYO57G91CmGZ8qRBRjhkVtyMIfuvR/RKXHQXGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:01:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:01:04 +0000
Message-ID: <e6f60462-0028-b224-45b0-71757b454a02@amd.com>
Date: Wed, 11 May 2022 17:30:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: update smartshift powerboost calc for smu12
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511105755.2335000-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220511105755.2335000-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01a823f-7a47-462a-a6d9-08da3345ec56
X-MS-TrafficTypeDiagnostic: CY5PR12MB6106:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB610657F2B4DAED96BF37E3CB97C89@CY5PR12MB6106.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYIsKAydDuCrvmtvFOdb7jC/WdEQYj+0RHk7xU7h7HNyiwzXKalV1A/lEQeVn6l6o1OxoApZrT81ufcLM2CTUP8vPNV94xP4lkhmokozGwe8XmCCJRX+U+h4+0V/9cGS7mPKTUqrVXXsfVHDqKCNXqeZs6WHmiq8cFskO3ZnAhOcPj5/CfMh7eWJmR8z5Adw0ygpPcLCaxNQZ28ZwU+1GbyHyLT2Cz/Ds5h45YSvisct5R7Qnto1BD+sTkAxULLXSYZiIp7XRyqKw68shDMmir3a5HUyI5Tx9V8EgUxcwkohXDtF9OsfDISmMl1z0uTB3tLIUIhaTopLRe4S0N07ykcXeiwlj6FbKQWvL6Ujf/K/2f8rcLLR6PizQhNuRnZPnPUWo9Zu9LHJTmMwEDFcmPxxaDQZDpsV09FKkbDwXWwmuQWhM9TKmawoTP2v4/SIsa5yfki+gohH7723sb772RVW8TgqqlSa+BHyitacUPXHtTnCB+WQn7IoMol7EIMyNoTHUZgyVv+KmUmztFmet1s0Vl7ajSCmM2abio8vf8dutsg0X0dXU2UrXCPJwhgnYKsDrvOCjdKUnx2e+pcPE0Sk+i/92SKGbwrusosbi5zCRI+1s21l60swuTEeYIYEJ40IXwyGk9eHkdgZbyMKlUhcCBH3N16kVxytcUv9OjQ7DoYF/VIRozgi27VchAmUX3CG5wg5BLw5U/VI+0SfkVw+fTHjwmcCVKZGg7esw6LSj0r4Sab+4CJPboem5tfF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(6666004)(6512007)(26005)(8936002)(53546011)(5660300002)(6506007)(8676002)(2616005)(31686004)(36756003)(316002)(186003)(2906002)(83380400001)(66476007)(66556008)(31696002)(38100700002)(6486002)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckI2K1YwU3VJZC9OWnFLQ2tmdHg0bG53di9UbGkzMGlBMEJNWVBHZ0R5cGgv?=
 =?utf-8?B?cVdZTm1mejlYTko1OVBYeHZ5R1phRm1ROTYwRkhTaHdpaFZuUFdGNWJ5U2c4?=
 =?utf-8?B?R2Z0SmlNSjllYk5wcU1GSUhpTWk3ZWR0aklIeVBCU2FUckhxVTBLK1ZjV0xC?=
 =?utf-8?B?U2xtR1BSQkhuYnhqZmVnUFVpRlFTbzd6RUlFZkJuSzlEdGt0clFyczRndTZD?=
 =?utf-8?B?QmwxS0VhZ0syQkZCNzY2MXJsRURKUCtscENxTnp4UkRnSjVQOUxFUDJvMC9k?=
 =?utf-8?B?dWYvRXFkR2tXODlvUGRxYmUwVTEycXNNdERBckg2ekl4bVFBT3BlUkxTT2dj?=
 =?utf-8?B?SkpQR1ZNaXkxVy9VODgydlZJTzRwQTMwY0tyMnpweE14emQ0a1lCa2FIUVRi?=
 =?utf-8?B?UVJmZkdIQ1p4eWNILzZUUG5FSVo5dURyOEVCc0RWVTJ2MlQ5Q2hLU3JTUkxN?=
 =?utf-8?B?blFDdjZWSFQ2Y3JvTFJ4aEhkYWZBVEFPL20zMTk4Vjlqb1NLVW5ybXlUY0M1?=
 =?utf-8?B?L3BnQ0tXZEN4UHJZSnh2dzYySmdSY1BXLzI4cDRTd0VPS3k1aTRwYVpOK015?=
 =?utf-8?B?QlliampMd3FjaW5id2p4cDRLREZTTHhNdmFiQkZPNSthNmVuK3VpdVc2Z3No?=
 =?utf-8?B?b1FISTFuL2VPczFFajBTQWJQSUp2QiszWXdSR2pRakJOTFBSRjViNUtNR1Vh?=
 =?utf-8?B?bjhoQW1TUTh3UmdIUlczSDJVZ0c1WDJYVFBqbytBRlJpWG95aGhjWEgzMmZU?=
 =?utf-8?B?b3FWa0ljVCt0ak9qdFVIckVYWjNCalR6a3JMVWpFZlJIZTdtS3NrWURIVzBh?=
 =?utf-8?B?bjQ2Y1FlS0V3dlgrZE9tZHRBQkJDZTZNUUhTVWs1Tk1ScHFmMmJvbHEvck9i?=
 =?utf-8?B?STZiaVZ5UCtjYzZDeUlzTk9OSUVxT0U5OWkxU1VHSEprZDFtRUJqbk9ZTUd6?=
 =?utf-8?B?U1gvdnJUbVNKUmQyQzBlTkJiZzlxbmF0Q1ppZGpkZmFLem1mMGxJdmw4THRs?=
 =?utf-8?B?WmNkS1M1R053SXBxWmZRNnI4WXNnZHFYQ2RGR2s5eFg2c1RBbk1JeEFvcHBR?=
 =?utf-8?B?Rm5yQjN3cXhhMzJxb0QrOFBFekN5dmQ3d0NGc3lTcHYxT01XaW9FamV5bERl?=
 =?utf-8?B?QnBqVzB4R204Wjl2SS9LQTkvcVFOYU0rMll6aGhRVzV5Q3AvSUxySXVtMDhB?=
 =?utf-8?B?cnBGZVViVXRFWEtWeUJzcjFrR3A3M0tQRHlCU0dDUStwNXFGcnJKZ3J0bE8y?=
 =?utf-8?B?dy8yZ0h4MzZTdlo0TzlhZE9CZFBDREZxV1ZvamhxZ3l5eExzL0t0VmdCb2FK?=
 =?utf-8?B?OWRDenFlNVNxME1PWGlaaHc3bzY2MEQvcVFzSVFrM1lPcjdFbUN1NTFxR3JG?=
 =?utf-8?B?OHIzZ2VmaHBjaFllU1pOVG5FS3Z0RTJPNlUvRmpYd0hDOTJDNEV1MUw3UWJP?=
 =?utf-8?B?ZEUxMjlxc2ZUVXg3UjhYemRrTFk4TEhGRXozenF0Wnh5MkI4UXk3enZCKzZn?=
 =?utf-8?B?dEFtQnYxMGRvNXhtSFhMTXFZcUlyc3lxM0dDTnRwdzBSbUNFREViTU5IYUlo?=
 =?utf-8?B?alQ0V3c5TDEraWoxMWE4T0JjVWxZdG9kU1ZCY0FMd0NaZUd6VUU2b1M2Yjdy?=
 =?utf-8?B?T1JDb2NnemdLc3cyenp3TzAwcTdKcjNMYVZ1czBLQy9KYU11amN4Mm4zUldG?=
 =?utf-8?B?OWpHTHBaSHZDSVFJb1BrTkJ5VG4vU1U5TXJXYnBHU0E2dEZ2ZER0VU1lY0x5?=
 =?utf-8?B?aHJLekxrUUQvWkhLc0hCczMvMjhyVlRHMElzYjdRMGoxUmUvV2lxTDFldWFh?=
 =?utf-8?B?UmNUdk9OZDVQUmR3SDdrS2ZubGRmdlZBUTkvV05RODI4SzY3RHRhQlNzUHNS?=
 =?utf-8?B?RWhwVExSZ21MZjM4RktyRGdvM01WZDNOTU9IRDdnUW1JdS8rWThMTEtuMUFJ?=
 =?utf-8?B?T1BtOWJsWVV2TkRESFBzRFdBZDcvZXdNbi9aWlBNckxMekxHNjlxdndNUFc4?=
 =?utf-8?B?alNWYnFiSEZ5NHh2MHRRbGM2V21lU0IwelJoUFRYZGxUd0wvbXpmaGpEejV5?=
 =?utf-8?B?V1FNcTE2NHhVSVFuRzFLZEhjZVQ1WVZRWnJCVFVuRDk0K0VvWjkyVlhoYk5Y?=
 =?utf-8?B?TXBWWS9vUDhXOVhYaEQ1eDh0bVh1SGFWY0FDREVLWDBZTEZNVXNlejBxVDBV?=
 =?utf-8?B?Wk9VUTVDcldoaWIwd2U1c3U5akFTRnNXSk40blBUUGR1eEo5Y2kzOElJcFZG?=
 =?utf-8?B?YzFWVk9XL3N4MVBmOWp6YmtSRG1Yc21YNEM2YlJMeFZBeTIxaE9XaUViaGc5?=
 =?utf-8?B?a2RNUlJ1eTlEai9kKzRiYk9UR2ZyZjk0dGROWVJYdkpBRkpVRVZ6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01a823f-7a47-462a-a6d9-08da3345ec56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:01:04.0176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZHogZ3nHRcdVRX8rmeIjmCggQYKQdEk2+x3QxJtjNMbfGSikELAa4IH2Kk8qLKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 4:27 PM, Sathishkumar S wrote:
> smartshift apu and dgpu power boost are reported as percentage with
> respect to their power limits. This value[0-100] reflects the boost
> for the respective device.
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 60 ++++++++++++++-----
>   1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index fd6c44ece168..012e3bd99cc2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1119,6 +1119,39 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
>   	return size;
>   }
>   
> +static void renoir_get_ss_power_percent(SmuMetrics_t *metrics,
> +					uint32_t *apu_percent, uint32_t *dgpu_percent)
> +{
> +	uint32_t apu_boost = 0;
> +	uint32_t dgpu_boost = 0;
> +	uint16_t apu_limit = 0;
> +	uint16_t dgpu_limit = 0;
> +	uint16_t apu_power = 0;
> +	uint16_t dgpu_power = 0;
> +
> +	apu_power = metrics->ApuPower;
> +	apu_limit = metrics->StapmOriginalLimit;
> +	if (apu_power > apu_limit && apu_limit != 0)
> +		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
> +	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
> +
> +	dgpu_power = metrics->dGpuPower;
> +	if (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit)
> +		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOriginalLimit;
> +	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
> +		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
> +	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
> +
> +	if (dgpu_boost >= apu_boost)
> +		apu_boost = 0;
> +	else
> +		dgpu_boost = 0;
> +
> +	*apu_percent = apu_boost;
> +	*dgpu_percent = dgpu_boost;
> +}
> +
> +
>   static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   				       MetricsMember_t member,
>   				       uint32_t *value)
> @@ -1127,6 +1160,9 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
> +	uint32_t apu_percent = 0;
> +	uint32_t dgpu_percent = 0;
> +
>   
>   	ret = smu_cmn_get_metrics_table(smu,
>   					NULL,
> @@ -1171,26 +1207,18 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->Voltage[1];
>   		break;
>   	case METRICS_SS_APU_SHARE:
> -		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> +		/* return the percentage of APU power boost
> +		 * with respect to APU's power limit.
>   		 */
> -		if (metrics->StapmOriginalLimit > 0)
> -			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
> -		else
> -			*value = 0;
> +		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = apu_percent;
>   		break;
>   	case METRICS_SS_DGPU_SHARE:
> -		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> +		/* return the percentage of dGPU power boost
> +		 * with respect to dGPU's power limit.
>   		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
> -		else
> -			*value = 0;
> +		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = dgpu_percent;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> 
