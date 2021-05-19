Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EBBC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E4C60D07
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E4C60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E366EE00;
	Wed, 19 May 2021 15:44:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015D36EE00
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 15:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caOkzZoTUJQccBbiM3GFYV9LRe9PTDWd8OdF9Ij52Kte+2imolnbZ2VVMCOGKh69Gp9NCehJuECfjLStlVoyt61iH6RW8uBI4kDVzml3uw6FboG+KPcYlmGXLp7REyxBJs8SVZ9F1E1j+sc3XpyxpiKxkcgvKzjPOWAK4CCLJSo0M4A/kj8p5jFTVGVjaTVhczXXrLuY2Wt1jGi6FcPkN6d2i6Vu9hmtw2MZXfkoeIcvg7imskrlpLeeboYOQKmoT+TEfYhUC51s80N0v0aEWsTsYm0zSn+3YzUyP+YoycGeniwrZeo00d007VaVV3AcvFpJOqyNnZR2klEInUY5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a9Jd8FsNlpNDK55onELPTH+TrHk/nBHwh1lzleKgfU=;
 b=NCTdq0A9r1WoYBuZp1Xo2cQaM439gdDPgDbRfGee5zWFPEHSM0dBs/wN2PU96BqT4WP+POV7MwpNTAYlQU5X7hjjMDcyK2/BMmhSA+dVyCrdKxUtftmTdFMlW/Q40ILXWG8lBqXFEFchukUv8FzYlHS1ndzQIlXgMp/Uw1A/oTWvwkQBqUz4MaBDSFquOHt4XDgatbvF5mJayA5PHPK3hpJadrh5hUpdi7yUnhrHsWkqNj7BsFc3AbdVAsANhTpwcxS5T5XWpMmovsgPLOUhg74abJVC9deGAkDNz3q/i+0nDxH3vWU2c9iBMkE/tYjxPLpoxS8SwSA/he/Sivrtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a9Jd8FsNlpNDK55onELPTH+TrHk/nBHwh1lzleKgfU=;
 b=jNpTD/dTrRnXt6Ddf5ZzuytgzWSfiWHwww8OQ210EWJ2IJy03hymG9DcjxgmzWD8QX65dx5nP7a/vjrS0LcWIa96KoTSWY4O1OM1ySIjyuCNahApq5YfzWIQChqEZqaICCkklcvyayjUVUvBU35IUrYMb0A07+7hUASJNaYmouI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 15:44:10 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 15:44:10 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu/pm: add new fields for Navi1x
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519060233.13597-1-david.nieto@amd.com>
 <20210519060233.13597-2-david.nieto@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <16f057fd-3bfa-5761-0acc-fa92e013652f@amd.com>
Date: Wed, 19 May 2021 21:13:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519060233.13597-2-david.nieto@amd.com>
Content-Language: en-US
X-Originating-IP: [117.222.149.218]
X-ClientProxiedBy: PN2PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::6) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (117.222.149.218) by
 PN2PR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 15:44:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b86a258c-3298-4d7b-856b-08d91adcf19e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5268019BDDF32B45D1448CB5972B9@CH0PR12MB5268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iahp7wMzb0XKZBx1CenpQWEU4I6R5500OTMBHio7w4j+vZ2EwvUpZM0OBINFmSRPDjXT0ZNL1ISk8UhTO5qYL6G2vP+FhbH2MgftENaJwF2Bz/znVWcPn+1ziqvT/cAeuhL+BOWSAKzvLizfTu3KwxWE+IEbIZqirYfC5K6Vf/ZaMAYa2oCfvhDbof485qWEtVKkxD100MUKRTcEPfD9qGcbm9h7aLJ0gxBc9JpaZWvyXw4HCFjoTtlwRq40rUkaYCMnYl4uaUNBvWvmr20fhdgHryj4m9Ry9J50YwQERVSltc+gicOXI4g/VF4M7DyFth8rU666RIRL/U+NtoQEqiU8Eg37mP0dIUJnsRn9EvBiGZ3cnQpqU70Nad73KNhNWRHUnIBp9yhFYewCcAWaV9VEh3nXHMgLMh0Yb7ATz1re6C7vX1tLPI4bt4WKCEtlwQwJrrGW8j76EAy9G47j5Jz6nAggzXyQM7iID9sOBUyTavQNogL9XL8iPvCzOkWIq9S9dGgoPjRi5ui/2B63GMFciHvqE6RSlnDRFGU7zADZRxezvULZ8VRPgB/tBaz/fSRMYdv5Z3TKldsWDgvwlvI4EpKYvYW6HtLEa3SUwFiHNx5+ZKlfj8/JVxNEDTTQUKd6O7xnwOh77k07M39xQ9gLt91kS1+hgMqt473EapmLLIAQeV+spTMEhzOZ/qabZwoF5SL/qYmZzuGLZ1PZk5q256NeE8m2AHGCh6d63H2C/qtwlf/FUBPVmbsfycUX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(44832011)(956004)(478600001)(8676002)(16526019)(38100700002)(186003)(38350700002)(2616005)(36756003)(5660300002)(16576012)(2906002)(316002)(66946007)(66556008)(66476007)(6666004)(52116002)(83380400001)(8936002)(19627235002)(26005)(86362001)(31686004)(31696002)(53546011)(6486002)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZDJLTVVsYzVKdGhDaWdPbEIrYjMyK2pCbTBnK2swRzJhTFgyemZyaHh4NnBt?=
 =?utf-8?B?cXZsVHlFajhjSkUzcnhRendOSzdsblBabjRmVXpqc3ZLYlpsM0hmT3NtM3lZ?=
 =?utf-8?B?NExjaXFSVTlITUxINEE4dklBdDNmSVVrL2JxMDhGdjNhYjl6TDZ2UVJndXNL?=
 =?utf-8?B?Wmh6N0NDZG1xa2hJeVZsWkVFUTBpVXhGa1h4cEFmdnlBb1VLSmZjWE94dmNz?=
 =?utf-8?B?T3NTUktQc2ZSOFpEVmdmR3U0S01KdEpYY0o4YnE0dDc4cW1oaXFTOEVJcnVJ?=
 =?utf-8?B?KzQ1UCtQZTJhcmpqNjVNb0RjcmF5djIxL1pwYXQyanA1VDY5aEpqR09hY2FV?=
 =?utf-8?B?SmRsSldBMjl0Z3VkT2F3MXFVbGZPdlZUNCtTbS9ITE9uS2c1aEM3MEF4czBY?=
 =?utf-8?B?YlhRR0R5dlZybTVkQi9TMjhqUTBDc1pRSWozK2tEdlBSbWJ2aVRDZEllUVAv?=
 =?utf-8?B?S2FOaGJHbktxYzVLdlgxRFZlY3dUS1A1b01lZGZib0JlU3NzMzNSTHZXMWJp?=
 =?utf-8?B?bGlyS25FTngwTzBJa0c1VnBPTE5PSFB6R2tnNzdBTXo1ZUFNc1VCS2cwZnFm?=
 =?utf-8?B?bzlhY3dVVDU3ZUdYSUV4aU16MkNyR0RSM1ZDZTU1OWhiM3NrZmowS1VvMmwv?=
 =?utf-8?B?cDljK2ZGcXc4ak83SGdiTkJqYTFzTUNyTG9oUWpuUU5pSlp4QnQwLzBrYzJw?=
 =?utf-8?B?RDdjN0pSeHE5eVhXOWlFSmd2N2J6a2w0YWNZM1ljRGNmajZ5amFGQWVHanl0?=
 =?utf-8?B?Y0V5Y0tudzRPcTBtTXI3a3kzWTh3bjlhYW9FMmhqamVuSHBMQTJsMTcvUHFY?=
 =?utf-8?B?QWptdTBGVjRvdnZ1ci85TUlkd25xdVMydVVNVkh2SDNLcG1ESkxDQllQQk5N?=
 =?utf-8?B?SDA5bXRqd3J5ZXBnb3hkQ0xJTTh5OGN4SW1VV1M0TGdEUWtOOWlXQW9jbnI1?=
 =?utf-8?B?Tk91WlVCeTBYZVNMTE9Yekc3ZzcyclRBcjhjYnJRajhLclBkTHlvUkh6WmNt?=
 =?utf-8?B?U2VGQmdKV0E5TjF0RVl2aDZQcjF1a0N0M3pKbTJxVElqQ1M5Q1g4UTBxaFp0?=
 =?utf-8?B?VUdSNm94NzQrdmJuR3BETGNEVzNURXZwUm5HVTR3dVR5Nmx1QzE4cnpUZkpN?=
 =?utf-8?B?TXJWcGNnRlRTeVdaZ2NlWEo3V3hqdkUvWHpjY3VCVjYyVHBUSHNHN2xMdVdO?=
 =?utf-8?B?ajJEaUI4ajgrcUlGR082RzltbGwweFNaSnpMckdvalpEU2craWVRRHQ5OTRl?=
 =?utf-8?B?T0RGMEFJdm92dFFZeUVSVmhQY1prcXpJWUxVcXB5RTRxUkw0cDNCa0JUQkFO?=
 =?utf-8?B?cXZCK3dyTWhRdmxKanZ6cTlNOXVvMlN2ZytlWUMwY2RMNkJTcXhmU0M2NHZr?=
 =?utf-8?B?a2ZKQ2xUVXNMTWhDeTAxcjh5UU9RdlFhTFdWWDR0U2k0ckRFNVlMYkRBZnJG?=
 =?utf-8?B?SWFIdm05NmZOQ1FzKzE3R0ZrOHhnVnl1aFg1elF4ZEV3RmsvTHFHQmZmVzBz?=
 =?utf-8?B?cHVldEpDM2JCY0piUlJDRllLY3RZL1h0U3JyR2hGWFRZYXNncHVYaGxPcE1w?=
 =?utf-8?B?MnNzWm55amNkbm41QkxZVFA3eUVYVkpmMXRlQWFSRDRKNHJlVE5PSTR3S3JL?=
 =?utf-8?B?aVpGbnNyZEE2K2xGeUV1OU5wb1dQSG9TRmxaUlA5aXM4dlhKaGdJUWVPZVF2?=
 =?utf-8?B?a2pBalF5aVFmbHQzdnhpSGdxL2hnOEd1bEpxczFod0FYYUpMUHVqeW9kbGhM?=
 =?utf-8?Q?4N4ttWEkfaFILD5YyAoIVbcr+Gdswl5dKm/WNy8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86a258c-3298-4d7b-856b-08d91adcf19e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 15:44:10.1517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmF8PODJPJPbbOFqw40kRUFddAZ8knqDtzw9Pw+XV5/BC/XqPnBXAhCb6eybmF1C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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

Add a check of non-zero offsets so that it doesn't show a static voltage 
of 1.55v all the time. With that addressed the patch is

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/19/2021 11:32 AM, David M Nieto wrote:
> Fill voltage fields in metrics table
> 
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 58 +++++++++++++------
>   1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ac13042672ea..b8971303a873 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;
> @@ -2627,8 +2627,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   					     void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
>   
> @@ -2646,7 +2646,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2681,17 +2681,23 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> @@ -2709,7 +2715,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2746,17 +2752,23 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   					     void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_NV12_legacy_t metrics;
>   	int ret = 0;
>   
> @@ -2774,7 +2786,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2814,17 +2826,23 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_NV12_t metrics;
>   	int ret = 0;
>   
> @@ -2842,7 +2860,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2884,9 +2902,15 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
