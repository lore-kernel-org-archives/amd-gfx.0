Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961FBCD68EC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 04:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44E710E14C;
	Tue, 10 Oct 2023 04:51:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D2D10E14C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 04:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC/NAK6LCCv6gJB7imh+1KIhqi/bIhC5SW+SXYHTezm3Et5y+TFmbkJUn6v4bd68Xu84r7zIwapYAmQA6G4tykblAaxz28U6vZ+ljX3KqE656OP6s25j1YCsUJ2Cvyj/i+SpwCaCBPjias9fkJLjzJPFsLC5IWBiG4dxPx3Umf0+BuFZPK17y350UOH78THPxoHzQqpyph6vRJwrHoAO2qu1pkAqG8icOsexl2JsoJwpssshdUNhxC7QOSa9HhP0mY8749VNRCNpo2byoqTMvd1a8sjLtNc7YqiL6xWaSXhWByvqjoc59qyf2hvdRE4skCGAVbDykRmMOJ2+P1MO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u30o/BbLZD1xV0nXNL/XwuQxHuvMO2B1YwzFV2WFC+0=;
 b=N2Bkhypqp+YcxpC0R+3zZ+6X92dVjOe3kSNtMOfY+ohL+MJVEXIUQAsD17SY29XJybo9eYBwSTHnU8i5xjyWPsY26UdUCUsfPjOd9u02TacCZalfgV6GRU7JUQj+1v9fHtbBPyQRty22szh0iKmfWtFuIV5kWo6Q3N2Fph4DdSNJFcvSb5F4JhnzowpK5aPZYuDuD904Udd8SevPs+mOMrKaeELD5kYBI93zdDKUqvxuWGujna8T1zqa5V9TAYA4ZsO2rNxLQzISxXvIQAlnDfRYYLixKZnvgrm0u2nX2Qxx4EtzokdkRNbVkzAz7+GUVTFkrL0X0zShu/DE4hdL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u30o/BbLZD1xV0nXNL/XwuQxHuvMO2B1YwzFV2WFC+0=;
 b=w1VQ2iAweNOJFEvXWHGqFokTYhi95m2fZDMjfc+nERCc9qC0bqhfHDZW5/vqAcSq/00jUWEPr41PiLwnRs2VIY5IX9tNv22nvtcgDARrDn6XfdN4zmztZpB7/3c5mDDnVrySxZqp5Ftl+wvg5dXEIiLpqMWavdwdXX256atflcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 04:51:52 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:51:52 +0000
Message-ID: <f58aab4b-2e1e-dffa-f617-11fa209423b3@amd.com>
Date: Tue, 10 Oct 2023 10:21:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 3/3] drm/amd/pm: Use gpu_metrics_v1_4 for SMUv13.0.6
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231009145315.597629-1-asad.kamal@amd.com>
 <20231009145315.597629-3-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231009145315.597629-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0697885f-cc74-4eec-17b7-08dbc94c9e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6zhRALaCPV4ybgLX1dNiQ/asawOGjcGhG15tiDkbDSQmV13vaGTg8NwWTemPgs1KIxEe90+YQeeCjEgthCIxDPsE9huARSwT0+QzujxKVihdWVtOyAAkaMyfL800snXOYw6tyA/w3PXXGFEPhPR7T+cT2IbNut9JpPbbjwxXcsE7hlKOrIZcFJptIL79j1SdvzILjKl0Kw4xnhDDll8O6bm3ZvXFYfxue9S/Z848Luj31f5VNRyz9K1l6RS8Uq1kRC6RkYjAQz4oYZ9ZfEvY4JE6MnAvk9vURLXJ+RLJqwULZXOUiQFnge2RfQQHrVgs5AC2EkjAbhbVczdNOxXgQR0O63eWM1G8YBXY2+qfxM5AkwIxC5wXXbycb1F0wnfwVCCLaiIiF86OfWk/oOAuR/CvAgboMMez9ouLVKdrdRXyBnY6QIIBD3Em4Hcq15wX3iSeUsS+FbrPvCL8lIyTsOB8QtiHdRKqZDKWtVGx0bbzuRszfuJguDpyk4kBQuka/nIsDuBp1db+fbRJhM2TaYyepvIHwXwVSth4bH3I+oB5iOOwGxKfyWw4Xc6lreHX1tpO7D68jF1VZi76/NrgGLarv9PpH0pVqU++U+BGzWgcR0saAXCfNE3liXpQlVsYKNF7kNdwJ6G92t2hW47wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31696002)(86362001)(38100700002)(36756003)(31686004)(6512007)(478600001)(6486002)(2906002)(41300700001)(5660300002)(8676002)(6666004)(4326008)(8936002)(6506007)(2616005)(53546011)(83380400001)(316002)(66946007)(66556008)(66476007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG4zMGs0ZERmRFU1cnNhZHV6Sko3TnNaV01rY0UzcFJKeXA2d2R3bWF0SlNw?=
 =?utf-8?B?ek1uYUVRWmwzSUZQamFuNWM1ZkVyVzZWMlR3cWxzRHRTdlUvNDJEOGQwRzBm?=
 =?utf-8?B?Slk1Rk81blpwZ3lsb2NrMnhkQ3A1cGZqV0tGNlNlRW1ROW9vM3hVOHQ4eU1D?=
 =?utf-8?B?ZDRPbTdWUGhCblAyWG1jaHFpbHp2STNnT2duT09qVTYxaGhFUG41TDgzb0lz?=
 =?utf-8?B?S3lvdVFEMDlMZWRNQlJqQ08ybTRheitjRm0zUUlPb3JTdnNhTEFybktJdlpv?=
 =?utf-8?B?c3k5VnFEdXBVckNiak9tcllKUVBTT0JBWk9NQkk0V0Q4bUZHSmhmRCtJM2xC?=
 =?utf-8?B?OU5ZSEY3Nng5MEgzRVdFMVVFbVBjcU1NUlNzVUdQSkpPWGl5L3NibEFLWTN2?=
 =?utf-8?B?SnlaVjdEY3g3aFdicElITGZrTmZxVU1tVmdSVVFxYUM5ZTRBb3hPWGRmc3pY?=
 =?utf-8?B?L2VYeXNhNmpmZ3lHQkRJak1yaHRQVUtxQis0Y2J2bU03UjEybFVRTWFVamkv?=
 =?utf-8?B?dFlTWmtFeHczdDIzV2FTZFVvZFZjb01RczFvTVZudUJUUzJVTVhyT045czh1?=
 =?utf-8?B?ZElDVmVTYWxvZkRBQjBiWm4xSTVKUkkvZjk5YVp0bEJxTFAvcHdNc0lmWGF1?=
 =?utf-8?B?enJGS3p3UVNZVWJxMkVVVjhzd0NUbFJ4UThVRk53REZiM3Y5OVlhMEt5ZUtN?=
 =?utf-8?B?ZHpTNVQ0bDhLWmlVWGovanp3UDBIUzc4dFd5d01XZENhcXczbENDRTZyczRD?=
 =?utf-8?B?VFYzZTFZR0tBUVJ2ZHBnVnlXM2swU0V6TEFDRXcvckE3OHZwbFZoRGpydFFW?=
 =?utf-8?B?V2xHZUhIQXpUYnZBbXFsQW03bnhoQ0tLcDU4VXo5QTFjRS9MYTF5RkVEV1Ra?=
 =?utf-8?B?TmhrMlptM2owMERtRUdOeWg4eGMwYmYzbDhIclhvVG4zdXhNczFudVhCdzM0?=
 =?utf-8?B?NUV6K2VVUlorbzVFemFUdnhjc3paSEZNcTZpVGNYOExXcW4wRW1RK1NjdGpZ?=
 =?utf-8?B?czg5SUt4clhkT0lCQVdQdkV4cEpuVU5xaHV2WDIyRFhRcy9NeDQxbGh4SXlX?=
 =?utf-8?B?L015YlNVN3h6ME0xMml2ZnAwMU5oZXRQUTV6a1FtSmxtZnZoTFlwbzRqRkpK?=
 =?utf-8?B?KzNBZmVTUURuNVYrTngxVmdRYVJZbmFRL0lvaGI5V0pPRStqMXVCVmZiYUkz?=
 =?utf-8?B?a250bmJ2NEEydXNDNnZScmZabk9Zd1NLaysyUUpnYjUxWlBGNE8rR1FiZWxi?=
 =?utf-8?B?U2xBSnl1b0JSbmY1SFFnNjc5KzBoSGlyVGZtSDlYNlJBeGNOemNKWjFoTlVH?=
 =?utf-8?B?eU1SMlJRek84K3VnUWVqaVN4OUR6YzYxU05tU1hYZ1IrN3pjYkpEbjJSaWtp?=
 =?utf-8?B?MXJ4bDJoVHJibEdXV3lXbk9GemFTNmc0YjEvcG5iUFdZM3hjYmdWOG9WQ2V6?=
 =?utf-8?B?N2kzV3VXam56T2VDNTVnRUEwTC9NRDBzdGVYalIxb2JkT2hDcEhoYkJDaGx2?=
 =?utf-8?B?bE9PQzVGRHRpL2lNZUlxYjRZWHdiaFM3WCtlYVNDb21hU2ozcnZPR1ZWSlRj?=
 =?utf-8?B?dU00cGRhdlNZK2ZZeHRWNVdSc1poQ0tLc05QMUpKM0l0ZUZCUnFoMHFrUXZZ?=
 =?utf-8?B?TlVJNG5SS01jMXdaY1FBNEN1aU9xY3pjUEdtTFpHa1VITDBPN3pkNlF0NVhU?=
 =?utf-8?B?MHlQRHhocVdObCtrZGVhNHlVbk52Z0xpZVJQL2xoNnFtMGI4R0dtSTFENzV6?=
 =?utf-8?B?MDRKTXJzMkRpUVhmQjNMMXgvSUtRVmdER0UybGF5TUVidU5lcUJUeHpwOUl3?=
 =?utf-8?B?RDlZeXljWnJZaUY2QWdZdWZjNDVmQzdLb3g5cm05N0NuckNKNE1OajZaM01u?=
 =?utf-8?B?bGxxUDR0b01lYTdLdktzT1JLbWdqTG1vZkJldDIwcVlNcVcrWmVJVUJmREFG?=
 =?utf-8?B?aVFuaHdxU3NFNDVwSFE1T1VMUCs3K1A3YndYb3hPR3JQclFxbjZFSkVKWTY3?=
 =?utf-8?B?eTFQRDZDQm1TSFRJRStUNUJWUFRCNVN5eVgwejdsR3ZNajBWWVlEbUowVWVl?=
 =?utf-8?B?Y0xsTzY4T3hPV1JkV3FnTU9EM1owelZQYms3bjZ2VG1TM0g2c0tpSElKU3o2?=
 =?utf-8?Q?Mo0psTFUY/37U2oFmgu6q85Kx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0697885f-cc74-4eec-17b7-08dbc94c9e52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:51:51.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3w4o1pu2GrpBipwROycyxLechmizyV9LmPdUQQP3Nl1X+jV54jcHNR8uhcG6E/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/9/2023 8:23 PM, Asad Kamal wrote:
> Use gpu_metrics_v1_4 for SMUv13.0.6 to fill
> gpu metric info
> 
> v3: Removed filling gpu metric instantaneous
> pcie bw
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

A special note inline.

Series is-
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 65 ++++++++++++-------
>   1 file changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ce971a93d28b..7ab73112e4f3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -279,7 +279,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
>   		return -ENOMEM;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_4);
>   	smu_table->gpu_metrics_table =
>   		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table) {
> @@ -1969,22 +1969,19 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_3 *gpu_metrics =
> -		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_4 *gpu_metrics =
> +		(struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
>   	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, inst0, xcc0;
> +	int ret = 0, xcc_id, inst, i;
>   	MetricsTable_t *metrics;
>   	u16 link_width_level;
>   
> -	inst0 = adev->sdma.instance[0].aid_id;
> -	xcc0 = GET_INST(GC, 0);
> -
>   	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);

Please take care to include "(drm/amd/pm: Fix a memory leak on an error 
path)" while pushing these changes.

Thanks,
Lijo

>   	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
>   
>   	gpu_metrics->temperature_hotspot =
>   		SMUQ10_ROUND(metrics->MaxSocketTemperature);
> @@ -2000,30 +1997,38 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   	gpu_metrics->average_umc_activity =
>   		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
>   
> -	gpu_metrics->average_socket_power =
> +	gpu_metrics->curr_socket_power =
>   		SMUQ10_ROUND(metrics->SocketPower);
>   	/* Energy counter reported in 15.259uJ (2^-16) units */
>   	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
>   
> -	gpu_metrics->current_gfxclk =
> -		SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
> -	gpu_metrics->current_socclk =
> -		SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
> -	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
> -	gpu_metrics->current_vclk0 =
> -		SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
> -	gpu_metrics->current_dclk0 =
> -		SMUQ10_ROUND(metrics->DclkFrequency[inst0]);
> +	for (i = 0; i < MAX_GFX_CLKS; i++) {
> +		xcc_id = GET_INST(GC, i);
> +		if (xcc_id >= 0)
> +			gpu_metrics->current_gfxclk[i] =
> +				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
> +
> +		if (i < MAX_CLKS) {
> +			gpu_metrics->current_socclk[i] =
> +				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
> +			inst = GET_INST(VCN, i);
> +			if (inst >= 0) {
> +				gpu_metrics->current_vclk0[i] =
> +					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
> +				gpu_metrics->current_dclk0[i] =
> +					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
> +			}
> +		}
> +	}
>   
> -	gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
> -	gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
> -	gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
> -	gpu_metrics->average_vclk0_frequency = gpu_metrics->current_vclk0;
> -	gpu_metrics->average_dclk0_frequency = gpu_metrics->current_dclk0;
> +	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
>   
>   	/* Throttle status is not reported through metrics now */
>   	gpu_metrics->throttle_status = 0;
>   
> +	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
> +	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
> +
>   	if (!(adev->flags & AMD_IS_APU)) {
>   		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
>   		if (link_width_level > MAX_LINK_WIDTH)
> @@ -2033,6 +2038,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   			DECODE_LANE_WIDTH(link_width_level);
>   		gpu_metrics->pcie_link_speed =
>   			smu_v13_0_6_get_current_pcie_link_speed(smu);
> +		gpu_metrics->pcie_bandwidth_acc =
> +				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
>   	}
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> @@ -2042,12 +2049,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>   	gpu_metrics->mem_activity_acc =
>   		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
>   
> +	for (i = 0; i < NUM_XGMI_LINKS; i++) {
> +		gpu_metrics->xgmi_read_data_acc[i] =
> +			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
> +		gpu_metrics->xgmi_write_data_acc[i] =
> +			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
> +	}
> +
> +	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
> +	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
> +
>   	gpu_metrics->firmware_timestamp = metrics->Timestamp;
>   
>   	*table = (void *)gpu_metrics;
>   	kfree(metrics);
>   
> -	return sizeof(struct gpu_metrics_v1_3);
> +	return sizeof(*gpu_metrics);
>   }
>   
>   static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
