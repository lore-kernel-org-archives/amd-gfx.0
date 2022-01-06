Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A40C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 06:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038E61124A8;
	Thu,  6 Jan 2022 06:17:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512B21124AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 06:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJALAIF3s+h1YMcnBgcZQGkKsFHmEkGoXlRklCapd/5ApotoDSmaoOEmLBqPiDsPOrRZCPWlKeb4i7luk0QXXW1c20NEpzeH0f2qIdlU4FunkasDsLhnLNM/P8MbaahKf/t3rArX1VeoFJxdrqBwtvl4n0c1Q4/692jP5uQ5ynBEb4yTM4hbjuqlrDhhAUJ1+N6J7k0w5NnAwruhEV0+JbND6EEKO2Qm8bcrhfm5uLVENOgZhu/EAlFAdYBVq8eRC00fplTgUKNVadaU24Y1ElQn1Dr8coJF8o73W1mpparHBUVuqiUQyBZN24y5pyezd5JtjEUVfb8tF2bMXC3RpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3a0ayHHhJqdSO2d1uL6GyIdM6mFOiuKPazS0RTQNjU=;
 b=fQuOePejaAb8HE3aZvoCkgxPvQWcA27oruTQ6Nx0BJ9J30yVMbye7nnJK/AKM7oDYvxaBoFwX1mEVVYq8fyUVYUJSBwrAuCmom+iLN5c0WC2V6ka3MT+26qCPGnryuUKPBwoFgXvs23yBoHACkMfVv5eTqHxBTeIYg7gUjRvpQYKpmhtq0xZNz8fXdjY92qaTKXXXMRVyNab4NewUlQaHj6SyW460IlbpgoFsxJiPKyRJf+zPZcatRA5SXhEVgaj6K0JyAvvqlMixJT+VwXYN/2eR+sb++Lxi2LhwKaiSaqohIOuFadiPuvqhAuD9bYj6K+amC8rZSjDzklcvQx9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3a0ayHHhJqdSO2d1uL6GyIdM6mFOiuKPazS0RTQNjU=;
 b=bavCrfN8fSuOuYAIn7GffhS9oYkjH3PEkpkriHAxGEQcCHtvmvqbUDeCceycBiGlLSJCnEJ7hlWtrJmhGqDx3rr9KUAE96O1zaJ7kVjoWfjZGxD8y0MpxHAXwqHyv1lkHFADSXZMiDpgw+R/8CzTRTrU/7CKjvDL6y37dPtgODY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 06:17:17 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::183:1343:d261:7870]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::183:1343:d261:7870%4]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 06:17:16 +0000
Message-ID: <4c820046-fc95-e7ef-c857-eebea6542990@amd.com>
Date: Thu, 6 Jan 2022 11:47:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-4-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220106055732.3073780-4-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbdf7ff1-789a-4587-a56a-08d9d0dc2fd2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB235011E9DFB1E50A3B4DA69E974C9@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/xUupncKF7F5ljA0wwLsngAnRI5GReH7PRSF+tqB73BamOGKb7CBYqLsuQ5aYMnY1AslM2OuoBGmglDd43hMehTlCsJJh5cUXMhF5kJMY2QPTZJ+Q8GKNFxg3fhcP/AOTgsi1keX1qL0jy4STVnHip7RC98SmgykSBfVtYRurxjhNIu1PegEJeY+pFXKaGL3SnVtNVGy+wy6pB2Jfz+ZAxVOHxWZY3b0q/aK8155ph/xpKyNnxP7eWjPnyraMPkGUVXNERXwPPgjo8A0XGVA5aOMdE5LBmq/NxWQTgqr37w2SjUoeqsqawhSH/gy7+7+tz1G5ZLHe0ddIbDLCogvmQL985jR5Ogj1Bo+dXSxlwU5I3rSWHGwtXhOWcwSdWZwzjqhqwCS7CBxW1kYq6eotjAfxQocZq9rC6rGh3JxXHfRh/QhHsIrIVFxE2KcX65rx/FltyeBXu8O3kPgRd2Qqb1ybjjhSSWi5ZssTrbFVV7qfAlSyYrsWF2kyFxsslbC6X4+xqO+v9nZBc0gE57xlLdKmbbxArFT1JV4Sh4YR5tJB7xD+P++vSYddDzJGgy15ZCXpwJLlYfq2Ggg+p29MLq3JZEGSPsBayJgw0VFUgc7g2NIvNVVX+Sf25BcGNPZ0Bwxe76Mx44g4gdxZ8OpwyEvUWVcoymmElf3SLJWJSCzgqTGULXpAkObRswDD5J0M48V5E0n7MdspKZ/xmuSDfel2gCh02HbBPIgpiNNk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(30864003)(2616005)(36756003)(31696002)(8936002)(19627235002)(6666004)(38100700002)(4326008)(2906002)(66946007)(31686004)(66556008)(186003)(66476007)(26005)(6486002)(6506007)(53546011)(6512007)(83380400001)(5660300002)(508600001)(86362001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09KanMxd0JaVHhWQWZaOXQzWENrS1c5blp1Y3pRQUhrSDdRNVZ2R0tNMmow?=
 =?utf-8?B?UGFyVUxIaGorTVJQdDBjYm11WkNmSHNiODcrajN0c2w2WG42WU10cmd3ZXFp?=
 =?utf-8?B?OE54eFpvS3Y3SG9LcGhwRElaQmR2TWV2RFIyQytmWnJDQkZqem9tQVRzU3VS?=
 =?utf-8?B?UHI3cWxUbjM2emltUUJFdng4QWlJdFpJakU5YVpaNTNaRG5uNVlycUtuellS?=
 =?utf-8?B?dmkyM3JjOEhRWXhnRENTTTNVV2VhQTZjWGp2TnllcjJtTHRQVXo3ODJkNjNj?=
 =?utf-8?B?anQ5Umd0enZTaWpTcFJFbTJzeG9GcWZOTU1ueWNQdVA1K1hmcHhyZ3pPdFRu?=
 =?utf-8?B?NzBlNzJDT3UrUWo2VS8zZDdrTGZaZTNLWlJzZHFzNTcvMGkwSXhpWTA5cnpr?=
 =?utf-8?B?MVhEbE1wZnlWR1o2SlBwYUNhOVhhVWlESWVzUkJWa0h6bE5XeC82WkNWQk8x?=
 =?utf-8?B?ZndySFNtV0lVeDVhcUs4Wng0WGJTaHIrWVJKVkhvUHFrbStEMGhrUDUzL0FV?=
 =?utf-8?B?RVB2V1VqK3BwNGxSdGZWeHJZbGNOWUI4N1Raamo0WjNzUCs2ZFRTMGdWK1dT?=
 =?utf-8?B?WXBkRjlNaFlyVGg5MUI3eU5oQmlsZjVIK3orUFFRRU52MG1kQmozTE5MS216?=
 =?utf-8?B?QlNkSDN1SUNoNXFOenU2emxaRkt2THdhQU5MTnY0dlRlNk9rVlBCUHV3Y1dT?=
 =?utf-8?B?T2VWR3cyYUhDTXVub2M4bGNybjZyTzVoMlZqSUNpUXVacmtlYW9TWm9sWXBo?=
 =?utf-8?B?SnhQYklPbFZ4NDZDTjk0blBZSFFiejRCdFk5VG5mREloSFd0NTZBRlRYNGFr?=
 =?utf-8?B?MVo3Q1M5WVBITTY0a215dmt0QzZ4V2ZIUmFnQVRpQmxjT1AzR0pGc2dXVkhu?=
 =?utf-8?B?Wk1MZEY3S0UyeE05Ym5PSmNOa0ZFNFVJV09iNW1YQTJ2Slo4V2Zyck5oS1lF?=
 =?utf-8?B?WGdQWEIxVUJxc0pVWEJFRi9oZHFYSlplRlZ1Yk9TdzNQNk5ZQ3R0ZmJwOC9v?=
 =?utf-8?B?emdyek9FM3dCdDJaNjVwMVREVW9ZUlJUZy9GZ0lEazN6OW9Vd0p2R3BJNzE1?=
 =?utf-8?B?TWNuL0Ruc0RuMGNWUHk1ZHdYa0xlNXVBTzVXRW5FWHlGYW9McG9FVzRjb1pk?=
 =?utf-8?B?dXlxMnl2OENYSXBJaUY2Z2phUHYyVnpVeEFZcnhuaHZPOXA3QVloakVTRHRn?=
 =?utf-8?B?Z1RUTHhHQU9pQldxK1lGZHZWaWdwNmJVRzFXSlREcEV5aDNSZENhK1N5MFhy?=
 =?utf-8?B?aUkyNWUxSHQ1ZHVGaFJPVjc3MFlqWlZXWVgrc1FXMERqNlFoTmcwV21jTzhP?=
 =?utf-8?B?cnY5a0JLY1p5WUVwa2FBVjk2N3M0dlBkZ3FWRG80Wm5SY1ZWbkJtL0NiemxE?=
 =?utf-8?B?NUpyMGhpeVhKWVJMU1d0RW1KN0pNT2dLdk8vdkhKMjlPYnZrV3cxdUZUTVBQ?=
 =?utf-8?B?UFd0djV1NWtuMml5N2xiMzMrZ2hwSVJ0T2FhRCticUVOQ0dnRUtBa0RHb1dU?=
 =?utf-8?B?TDJtSjBsZjFub1dVSWJaWlU3eml6RHdaWU5EMytaMFlpZk5BRHlhMXFXTnd5?=
 =?utf-8?B?Y1JGaVJORFBrQ0hlUnJMd1B5TmhkYkg2eWdWREtWb0NFVEtDcTZrcFJLcHg0?=
 =?utf-8?B?NE56T1hzWFhxYWtiOGJ6NDh6MWozMFNJMFRCMDdJNk55dzk4aDI0YklWZFAv?=
 =?utf-8?B?OWEvY0l5aVp3cVlEYlJnSHpnOEhuc1ozdDdVZnk0eWU4VnZ3cW5ZajNKb1hS?=
 =?utf-8?B?WitacXFPdWtFL005eTNCeXFDbnZTZGVxQXNsaUpjekRxS1R6Q29TZSt3NWJ5?=
 =?utf-8?B?SlhUekpocSt2VHRrTk1SLzhXcVNLOExZQUgyc1hHOW51Z3VRU052eWZxeWY3?=
 =?utf-8?B?YTlIWTRqeENxYzQ2KzdRSVlyN044VTh1QXhKZjRudTJyVG1UeE1QRm15czgr?=
 =?utf-8?B?MHhPc2NmbTBTZWsyaG1qb0daMjVuRFZ2cHBkY29HMVhjTnpINnRWY2lpYmVG?=
 =?utf-8?B?Sm9HZjc5c2VtNUdkcEI2d3JMR0NoUVN0cWwwaU9WMXliZEV1QWp0UW5ybWha?=
 =?utf-8?B?cUxXK0JhVnFkV3crM1lGVldTZnowNm5xS280NkFNOXQyVGx1NnF5WjduSFNT?=
 =?utf-8?Q?L1bU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdf7ff1-789a-4587-a56a-08d9d0dc2fd2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 06:17:16.7883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEcHkbOR2oe6rbSQUzxZsk9+7DBT0x9W3hdIGn+l6f+Uz5fDcwcn3wfg2dvrbZBS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/6/2022 11:27 AM, Evan Quan wrote:
> As all those related APIs are already well protected by
> adev->pm.mutex and smu->message_lock.
> 

This one may be widely used. Instead of relying on pm.mutex it's better 
to keep metrics lock so that multiple clients can read data without 
waiting on other APIs that use pm.mutex.

Thanks,
Lijo

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ic75326ba7b4b67be8762d5407d02f6c514e1ad35
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  14 +--
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  10 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 112 +++++-------------
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++---
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  28 ++---
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 +--
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  23 ++--
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  10 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  21 +---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
>   12 files changed, 70 insertions(+), 195 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ecbc768dfe2f..f0136bf36533 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
>   	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>   
>   	mutex_init(&smu->sensor_lock);
> -	mutex_init(&smu->metrics_lock);
>   	mutex_init(&smu->message_lock);
>   
>   	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index c3efe4fea5e0..63ed807c96f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -487,7 +487,6 @@ struct smu_context
>   	const struct cmn2asic_mapping	*pwr_src_map;
>   	const struct cmn2asic_mapping	*workload_map;
>   	struct mutex			sensor_lock;
> -	struct mutex			metrics_lock;
>   	struct mutex			message_lock;
>   	uint64_t pool_size;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index addb0472d040..3f7c1f23475b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -602,15 +602,11 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -693,8 +689,6 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2238ee19c222..7ae6b1bd648a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -150,13 +150,9 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -200,8 +196,6 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index fe17b3c1ece7..fdb059e7c6ba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -546,15 +546,11 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>   		(SmuMetrics_legacy_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -624,8 +620,6 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -638,15 +632,11 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
>   		(SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -719,8 +709,6 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -733,15 +721,11 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>   		(SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -811,8 +795,6 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -825,15 +807,11 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
>   		(SmuMetrics_NV12_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -906,8 +884,6 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -2708,20 +2684,14 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       true);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					true);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_legacy_t));
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> @@ -2899,20 +2869,14 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       true);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					true);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> @@ -2977,20 +2941,14 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_NV12_legacy_t metrics;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       true);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					true);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_legacy_t));
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> @@ -3058,20 +3016,14 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_NV12_t metrics;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       true);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					true);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 93caaf45a2db..2241250c2d2a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -525,15 +525,11 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   	uint16_t average_gfx_activity;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -633,8 +629,6 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   
>   }
> @@ -3564,14 +3558,11 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>   	uint16_t average_gfx_activity;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       &metrics_external,
> -					       true);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					&metrics_external,
> +					true);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
> @@ -3661,8 +3652,6 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>   				smu_v11_0_get_current_pcie_link_speed(smu);
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 5cb07ed227fb..c736adca6fbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -273,15 +273,11 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -335,8 +331,6 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -348,15 +342,11 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -410,8 +400,6 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 25c4b135f830..d75508085578 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1128,15 +1128,11 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_AVERAGE_GFXCLK:
> @@ -1201,8 +1197,6 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f065d95b117a..014fb88daa04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -571,15 +571,11 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       NULL,
> -					       false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu,
> +					NULL,
> +					false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> @@ -653,8 +649,6 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> @@ -1592,17 +1586,14 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
>   	uint32_t upper32 = 0, lower32 = 0;
>   	int ret;
>   
> -	mutex_lock(&smu->metrics_lock);
> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>   	if (ret)
> -		goto out_unlock;
> +		goto out;
>   
>   	upper32 = metrics->PublicSerialNumUpper32;
>   	lower32 = metrics->PublicSerialNumLower32;
>   
> -out_unlock:
> -	mutex_unlock(&smu->metrics_lock);
> -
> +out:
>   	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>   	if (adev->serial[0] == '\0')
>   		sprintf(adev->serial, "%016llx", adev->unique_id);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index caf1775d48ef..451d30dcc639 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -310,13 +310,9 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->metrics_lock);
> -
> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
> -	if (ret) {
> -		mutex_unlock(&smu->metrics_lock);
> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	switch (member) {
>   	case METRICS_AVERAGE_GFXCLK:
> @@ -387,8 +383,6 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	}
>   
> -	mutex_unlock(&smu->metrics_lock);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 735e1a1e365d..d78e4f689a2a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -964,9 +964,9 @@ int smu_cmn_write_pptable(struct smu_context *smu)
>   				    true);
>   }
>   
> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
> -				     void *metrics_table,
> -				     bool bypass_cache)
> +int smu_cmn_get_metrics_table(struct smu_context *smu,
> +			      void *metrics_table,
> +			      bool bypass_cache)
>   {
>   	struct smu_table_context *smu_table= &smu->smu_table;
>   	uint32_t table_size =
> @@ -994,21 +994,6 @@ int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>   	return 0;
>   }
>   
> -int smu_cmn_get_metrics_table(struct smu_context *smu,
> -			      void *metrics_table,
> -			      bool bypass_cache)
> -{
> -	int ret = 0;
> -
> -	mutex_lock(&smu->metrics_lock);
> -	ret = smu_cmn_get_metrics_table_locked(smu,
> -					       metrics_table,
> -					       bypass_cache);
> -	mutex_unlock(&smu->metrics_lock);
> -
> -	return ret;
> -}
> -
>   void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
>   {
>   	struct metrics_table_header *header = (struct metrics_table_header *)table;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 67a25da79256..f0b4fb2a0960 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -101,10 +101,6 @@ int smu_cmn_write_watermarks_table(struct smu_context *smu);
>   
>   int smu_cmn_write_pptable(struct smu_context *smu);
>   
> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
> -				     void *metrics_table,
> -				     bool bypass_cache);
> -
>   int smu_cmn_get_metrics_table(struct smu_context *smu,
>   			      void *metrics_table,
>   			      bool bypass_cache);
> 
