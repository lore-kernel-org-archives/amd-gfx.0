Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFE2C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 09:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC6010EB51;
	Fri, 23 Feb 2024 09:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yus+ARRs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAA510EB51
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 09:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5xRJirEDUoC00qz3oHvSBYZb8fXTV1swesdjYYEzuqRBuKVF3HzFGK4nYU50DO5jfmx7WiQ4FZNxdLU0+HEhIl9sEgKdPhPVyca0i749X+KpP8dOPwhl9lZEEHHdM5gxs2eK3/LWj8MN+GcSntUVwuU1EOwXtwol7NVTJSn+XstQsdIq3k8QoLg082soIqkrfHCzagBfj58Mx1FmhWu4LIFX1SmK6rZyViT9HGAylbyX4YTLLN8S0l0Bx4Zz/MErPdEw2aUfS6ezdLn8oP9eOEyPxxfqmgetGNFS6aBTMjpTTq2MQAkTEYNC/kepVOlxhUVSpgEKWLFpxGQOC0uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCW6Vlp/V7y8qVmBOK2lAqu22+6icJMAeoQsH31zWbU=;
 b=iLzzMZMd44pMvnoq7I5MeM+3/okevbkE7vGczF5Gz03kp4GWGLt3vmig1s3W/h9QkqYo+iBt3hQ+wKM7FPOVSE7PB2oTWOb5fbVm0fSvFDoiphBhnNqtuo5q+jadRKhfBVqyQ0yPHzXoI7kHvfsuzP3g4TKRPx5QxNxRe+xSCc9Xfv25rUYy8iJVImHdN1uXsP8sw5fzDzIzXjSUiPqqHYSq8C7KPttogSFT5MnG9Vb4+DdaA25LjzYgtRHtDFCBLS4ie2HzV3t6iYsrcgy/9XEVRn3S+GycTbHhaQoC3UKTCVlFQwWbzuAFEqmRKNGOEDAva37h08W3oquF00Rg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCW6Vlp/V7y8qVmBOK2lAqu22+6icJMAeoQsH31zWbU=;
 b=Yus+ARRsBh44YcffCFlzg3cJuvPcbIy8qtYAruH9UzSuR886G/hIvvQoEpbjiFNp2VMbV12aDcHxAIshQ7Yfsb4HqN9wB+Ri+Xk8cW2QQ2u1UXWQeGW66G1V39Duc+cgZIFvp5CTKdQ2iKokqmzJvvXzu8t1ntT/56kQi3Gm9ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 09:51:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 09:51:45 +0000
Message-ID: <1d216f6d-a4cf-43f6-8be1-1b21c9eda783@amd.com>
Date: Fri, 23 Feb 2024 10:51:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power1_min_cap value
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240223091911.1850226-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240223091911.1850226-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 41122417-ed6d-4fc1-b56f-08dc34550b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0XlnI70R/s4z1FVbPsJz5iWQz4WzJ4N+m6SJGB+DsywJAryZtLOWaNaQR+cYqQMUBzMpPTY82oQegvTf+7DGT5qWmpK+d7LAOM2Sf73M0E/2noQLP5TQSKhmabnTdO4cQpBqn6GBUApVrF8CZ3b5LibF6RwZvlXXqBQYsSNETh+Z7WoXG5FvyxweoItIwlHvvSWkMnP34g0OgaO7k9aa66TerKJsARmHlr+cVnkq9XF8od2/KlNP5k6H64VyGtzYQCscnx7SF8VlTw+p7JbXfCi9otWDrv3ONnwiMuG13MH1a2rNhpBMGC/YBLcprwFQgyt5J+dtQtEB77SZMeWpobUXU9x67RBK9g3WvWlo/+rs5EbPlodWXRw3YLJIwlSd5EI5rvWPNvYYcVustmC0T2+rmGcfb7PnGcDAgGwB6yyJ2utHWVqrebNRDTqiIsekMgCDLClrMN2rSeGlOaEzTfLVLLE6uF42FaVlFXoruSh33524oXztfNJpp5OQXktos99AwQYYSTCxzjqccEofJYSicidgP6IgERbqNIRRRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRkQkE4YURxS1BMUEJsa1RpZE9GWEhacm9KNmUzM1VpQW44cHhKNXRSSi95?=
 =?utf-8?B?SXVLek85dEJRQW9aM1p1KytzU0h2MzR0U3B2MmZWZyt3WlAwamppWHRZazZS?=
 =?utf-8?B?TFpDRkh6SDhoS1h4QU1zWjgwWFYyVEpHajBlWEJTd0tTR25KWGo5UHdWOEM4?=
 =?utf-8?B?R3BoUFNCY2VUc1Z3U2RpNVFwdVVMcU5mYkp1MGtlQTdyY3NhWU1maE5WYldJ?=
 =?utf-8?B?MnlTYmxRWlVqYUdOdWx1SVFjMER1SWVPdWtQK25aemFybjk4V3JUN3JEbU1q?=
 =?utf-8?B?dnViMEphVkJrRzJBRU5lTUFGWU9uVm9OQjRiYmdhZmNPQXZHU05vemx2S21K?=
 =?utf-8?B?OEsrUXZMZFpybjltSGtTTWtUUU9BYml1d2VIM3o4d0hVUHIyY3FUNkZZMjE0?=
 =?utf-8?B?eFpZNTh4U1NqVU1xVVBZQUtjL1pCY2lUU0g4cHVzK0YyMnV2Y3AzdTRKNWNw?=
 =?utf-8?B?Z05tTUJhVlNaWkx4U2pVcUdodFZNZWRLRjJkNUpsNUpLZGQ4TGkrYlA3dDEw?=
 =?utf-8?B?ZnBVODdISm53cXRYYmZyUDlHRjNXVUp3MDZXcnJpSi82SUJQY2loeHZHTUg2?=
 =?utf-8?B?ZnhOeXN3TDBtd09yN0lFYnE0enVnRUJZcFVCaGhsMFRDVXp4VkZtUU93WjZm?=
 =?utf-8?B?RWFOejFoczJFVkVTQmExT2NHbFp0cnNwK1lLN3F4d2s5K2tyU2tZUWFpQ2dZ?=
 =?utf-8?B?K0VBK1QwYS9TK2Z6MEdCR3hjM2dsQ29lZjM2elYvaUdvdGlhZ0YxQjZGMEZR?=
 =?utf-8?B?dGRid2ZQeURoUUdKd2FZbnJUKzJGTTd6RjI5MmRNTStJUUZ6WWZpTW1mQmhz?=
 =?utf-8?B?Z29UNWN4dUVLQzN1TjE1MlZFTjI1UjY4WlBGRmhEb0ZYWWdJTjFCWldIaUpC?=
 =?utf-8?B?MGVBVnA5MW5ua3pJc0s4SXoySktUbUxDenpDUFRtUkdlTUFwN3RrSWZVNlZZ?=
 =?utf-8?B?WUp4RDVlbmJNVkRHNkVmWk9TN2VCZ3grZVNLVTVDY1A1VW5WUzFOYVo1UkRN?=
 =?utf-8?B?OHpMWUNPWjRMUFFsanpId2h3TEFSWFNVTzdHM2hTazdVQnM2ZXluQzJmYjJZ?=
 =?utf-8?B?TXdBbndyNEhsOWlCTDkrQklodExZZTZZS0hPZ3ZSNE52WW43TE8vTDRIQjAz?=
 =?utf-8?B?TlBDZzUrTkJ4SS9QNHhUVWwyOEFFbEFYS2hSbnZmVWJ0MThFdld2c3ByUHlo?=
 =?utf-8?B?dXhDNTZvYTJtVFBaT1lmU2l2NEwvMVc1V2hrUiswVEc5aGNRSXFYVzY3c1h5?=
 =?utf-8?B?V0FFUXkzb1lrQTVTcjBud2FTZEsrLzF1ZUR4SldGS3ZDL3I1SVptOFFoaVpV?=
 =?utf-8?B?Qnl3eEhsbERERlRpMjFMQ2hScXdGUGUvY2ZKNVdNSExvVmV1eHhTajk5UmZl?=
 =?utf-8?B?Y0FvY0pwdHpkN1FZeXJTciswTk5ubFQ1Zm90U2J1ZmZZYnFIVGllOWVRSjlh?=
 =?utf-8?B?SWNUdDJqL09nRWNGRWxma2FYTjMyWWoyb1lEWkMyYlJNMzhNUUQyNllLVzJm?=
 =?utf-8?B?ZitmSWgyemsySVNlbWtqL2F0cGVycks4NUlPTThYUUs0a2hLRGQyOVRmbW93?=
 =?utf-8?B?QVNZUHdwdjVmS09ySmZkakUyc0ZwUVZqQWR1UlA1OFQ2SkFoZVA4QXduNGp2?=
 =?utf-8?B?MVR1Z0xZejQ4TzdydnVoRlVuSGEwcXlienIyanBucXlBSWF0UXpwaHlnV1hh?=
 =?utf-8?B?SURqeTZLZjdSTXZzRm5UZ3ZRS09DZGVhL2h0NjFxeEppNi9FbXZxaTBFVmIy?=
 =?utf-8?B?aVNmS0xGZXVVZlhuK3pGYStGSmIzRTVNMXRXZ01JTFE5a3dBaGpCeDhHa0J0?=
 =?utf-8?B?NVZTVkRGNlV1RmhLWURmNVZGOVd5dlZtdjJCcTliZ3hCMlpOampBTWxGNGph?=
 =?utf-8?B?NFN0enJndHR5dnQzTHVmRWxidm5xa3RFNWtCY3p4a3hpejZjQi9RRkZEcG80?=
 =?utf-8?B?VzhlS1ZIUHp1WGZQa2Z0cXdYUTVOQ3RJbmJ3SmNrQTB0aWpsZTRxbHlPN3Nh?=
 =?utf-8?B?V0JMWFJqMFExQmpUdUNMQklOYy9qTFl0RTJZT0lhdTQ1dmd4SStremFZbGlu?=
 =?utf-8?B?NitHVzNtU0tmeTh3M0xQMEcyQVpOc0lCYlpVWXByY3FtbTFRaHViRm1PZnRh?=
 =?utf-8?Q?fKR7Be/jHU0QJMLXpQVF7DlbJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41122417-ed6d-4fc1-b56f-08dc34550b8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:51:45.2758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEVliPJ3P/eDhAJMFakU+iNZ7LRy52mLvwZAaaoqP51G3NPtLz4oXWEsp5ZQz4/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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

Am 23.02.24 um 10:19 schrieb Ma Jun:
> It's unreasonable to use 0 as the power1_min_cap when
> OD is disabled. So, use the same lower limit as the value
> used when OD is enabled.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 9 ++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 9 ++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 ++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 9 ++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 9 ++++-----
>   5 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4cd43bbec910..bcad42534da4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1303,13 +1303,12 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>   	if (default_power_limit)
>   		*default_power_limit = power_limit;
>   
> -	if (smu->od_enabled) {
> +	if (smu->od_enabled)
>   		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	} else {
> +	else
>   		od_percent_upper = 0;
> -		od_percent_lower = 100;
> -	}
> +
> +	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>   							od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 8d1d29ffb0f1..ed189a3878eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2357,13 +2357,12 @@ static int navi10_get_power_limit(struct smu_context *smu,
>   		*default_power_limit = power_limit;
>   
>   	if (smu->od_enabled &&
> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
> +		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>   		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	} else {
> +	else
>   		od_percent_upper = 0;
> -		od_percent_lower = 100;
> -	}
> +
> +	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>   					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f2f401f00ed1..a405424dd699 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -640,13 +640,12 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>   	if (default_power_limit)
>   		*default_power_limit = power_limit;
>   
> -	if (smu->od_enabled) {
> +	if (smu->od_enabled)
>   		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -	} else {
> +	else
>   		od_percent_upper = 0;
> -		od_percent_lower = 100;
> -	}
> +
> +	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>   					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 67f44f851f59..9649484f11c0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2372,13 +2372,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>   	if (default_power_limit)
>   		*default_power_limit = power_limit;
>   
> -	if (smu->od_enabled) {
> +	if (smu->od_enabled)
>   		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -	} else {
> +	else
>   		od_percent_upper = 0;
> -		od_percent_lower = 100;
> -	}
> +
> +	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>   					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 49e77f8896c1..ac27734674db 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2336,13 +2336,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>   	if (default_power_limit)
>   		*default_power_limit = power_limit;
>   
> -	if (smu->od_enabled) {
> +	if (smu->od_enabled)
>   		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -	} else {
> +	else
>   		od_percent_upper = 0;
> -		od_percent_lower = 100;
> -	}
> +
> +	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>   					od_percent_upper, od_percent_lower, power_limit);

