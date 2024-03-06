Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62027C54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 11:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA525113080;
	Wed,  6 Mar 2024 11:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2i43cAX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F34F113080
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 11:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnprgwYxbhMq+OH8DzG0oTFHD5Ubi95LaPipQkn/3fMzVqbMj953Htb2GnUxmbamV8V+sEkeoTWcXJmzSnPv4JOZ/MnVOFn+PKDuKH9NwNDN+68GGP200wfd8KjdpJj8M9NKg23JEVa8A7uyev8nKR0ucHJpCI6TMd4aiLJR3eTSfIU9NAPgbm/FFClSi9MJH4uQFHsEiDcImMqbK5B9QjoJHHC3q5BDnk6Ozl6yCdLdHeZyZqnHsuvHzibFCbl8Y+Yc41rC+jtA7rx5C40FzpxPhA5d++sV6AR3YbEdI6EccWc/lXeYPs78Zsf6svvi2MbPZR/LUK1NEZcIyIm47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zUeKFXM1wJvnTVEpOjWOsuI9TDExu5XJVAew9rc+Rc=;
 b=SuN+4SwS2wrv7f1ddQh2NEUXstYhSrTsvdB1if2CxlIYbtayNEFr3jnFnywrJ5f+urS7zzWp5+ZpLWF/DE2qX9jpalLVVjsNIf6YoC8Thq6fY2F+OaRsexHXEyZUR2UDDkV5YWoiuBQScfN12Ap+dCHGFp7XZpqEsUnm1164Z+O2qNfgQhMQrocJlXNEYwjkdQXY2VQuo/jZ2dbtXxEOxtLYeycR7kU3yIS6a3cnY9ZuVQT7Z5V1CCQYsmG08zBrheZgVFBKioY0x0g/9xrnN/ue1JjYM9Nn2b2rhKjlcIwlT2/56hWFNRT+czgaGEEKmvb0AsRFtpdn2AnHD9TrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zUeKFXM1wJvnTVEpOjWOsuI9TDExu5XJVAew9rc+Rc=;
 b=B2i43cAXCxier3yLWaP1xA8VZQy5rqdKCU/P0RatqAarEDgt31Cslpq96bw2mSjvIFK6FNsAdyJOicqWLE/w9awz/jsTM0VWaxzKcGktOL0SDdoeBji8OxuAK7oU8NrTOaASO6GvfMu4FSs1aFS4fSWytYewMhPsZZgV4oj5huU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Wed, 6 Mar 2024 11:16:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 11:16:48 +0000
Message-ID: <c4362e69-e540-4cd8-b680-539dba82f806@amd.com>
Date: Wed, 6 Mar 2024 16:46:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix NULL pointer dereference when set/get
 power limit
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 Yin Zhenguo <zhenguo.yin@amd.com>
References: <20240306102615.2117462-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240306102615.2117462-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bebf44c-5d44-4506-fe18-08dc3dceea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/0cs0XLVHePeJJpqww6ob0JjTjpFCkMFNEguV4WTlEhSqE14oRQiiGrLmCtrK1De5zSsDyvO4YcpyHPepc1q2hoVQ2KpvMEMir4qGQ7q2926jcmDerHVBxZaX51dU1CER3uwErmT1dwz1yjQtKjW+5X9UwMw/p9x/D8rqKNRKHamXXJWjjOdjt2NFU3BccjBcMNXIJiSAt63r77MUNnM7I9m7YoVJITKe7PKfMMmUKU/xVUKoJc8bJByY/h6c2hKIOoG5Bh9xlhwBKZSsvF10b0vE1U4Q1dyD8Z75jqNgA2qChtHpMvfkwnuJCQVq0bCtN0NurL30fEC7gT6uvVXpwIUFE/mZP0Rv8aF/43evVNUWJxbNYvQjD7l7cYpxvQZNxjnurAsVqc8jnAhYupsRJbm/KXnxNBixAUV802Q0mqynPWI4fJ5wUkMxYvITqjFbvFr6By6eOhdrLmJrSCYRW+q/yRTPlpgJJeXs7I6k/6MQrjt3xZZvpmFmZ5krtUIKchAsft3liw37npOjqiuD19IL9FErzwbD9FZXrniOd0VNwIvR5EAaQh8IcXMpXU4lbiHfD1wT9KW7YMmLB1lv4DMvaW0JwX2x/pUnqED60QubxQVY65+iD3f2cU67hogL+jCqGyZpjrvpsCWNCGwWrlL7LYWZeKOU+88q08I3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzhVQm1hTGo4bWFUM0E2Z0xsQStMNXg3MTc3c2llNXF0Q2JFVjg4V2N3YUhx?=
 =?utf-8?B?SDJmV3M4UFhmL1hJYkdDLzJyTVBhZnVyc2k5dWU1emNpWGRrMTBIL1U4dFdZ?=
 =?utf-8?B?S0F0ckpxNnV4QjYvazlzODZDQTZpWGF6TjV6QVlLL1AxQWgvQklxVXhCWVlW?=
 =?utf-8?B?UGt4OTEyWkZ1QS9qMEJaTXFEMFFZQ3NBZGtoOWZSSCt1QnEyaVJpYm9zeUhw?=
 =?utf-8?B?QVJPczVad3laZ29uTTBLaDBubzhXcmZiUjNMOE95VDlZWTl6dldKcGtqTi9k?=
 =?utf-8?B?QTZHazIreEdnWHh6cEk0VTRXNmxwNDR4Y0FWcE1mVTRlKzJVcVlhaEpwdkxo?=
 =?utf-8?B?QmRVbHowMHM0Um5EeCt3bEFId0MrdmdRK24yK0lhUkF1QkhkQW0vS1gzc3lv?=
 =?utf-8?B?NU9sOWhQTUlBUmZIcW5uWWFrT0VMZWsyNnVGb0xWT3JiZnZRcVJlc242VkVh?=
 =?utf-8?B?dzA0SXFSUFNsWTVoU212S1VOeDUvVllNaHlSdGt5NWdzRWwwbEIyaFphRE5x?=
 =?utf-8?B?QVFtTkdRZ3I2NXlHSDc2TVI0VFZwVzd5c0QwVlNpR0swdGg3WUJMRTVFbzZ4?=
 =?utf-8?B?UGY5T0tra3ZZR0VSVVlDM3FLM2prclhrWndOOFZzdTdEY2VKQVpMZThjTUpN?=
 =?utf-8?B?NkVMcHFsdGJNTnJnU0phVlM3NGdBNm41L2RXY3JNQ2RSTE9wSTdHVm5idVJs?=
 =?utf-8?B?a0JBQVFKRGM5aStNaHpKRzdLU0JFb0dUbkthZ3Y2cVRpN2paQjZPZFNONlRC?=
 =?utf-8?B?WmVNWWxFWUg3VGcxRGJzM3FTTkJycWlHVFp2RjFHTGg2YXorYm93a1gzSEp5?=
 =?utf-8?B?TW54ZjFHd0puSXVTMUhHazVOc1Y2aGttN0NYb2dZTStRYlFzN0xDWWJaYjlp?=
 =?utf-8?B?QjRBUDRzc1ZlOWx4S0JWS1JXMWl1d096RG40TnBDdWxBenQ4M3d2UkMyYmZB?=
 =?utf-8?B?NkdLNWZaS1FZZnVhSzJQM0lpaFJRRlRDSWdoWk82bWtDQUxCaHdDeE5tdmxp?=
 =?utf-8?B?UTRmNWIxeEoxUldVUW5GUURxTW9venlwV0svVk1vWGw5RHRscVE1VVdGWXJi?=
 =?utf-8?B?Ny9VSVkyU0NjVmxGMmV6RThDMndNWTdJQmV2V0dudWNkbW5veUhiZXAyV0NX?=
 =?utf-8?B?LysxbkRyNmJOdkVhY2g2ZlBpNC9qQWt3aCtKcEU3dTJWRHpxeW5KR0hSbmw4?=
 =?utf-8?B?bkgwYU96bmM2azQzd1A1eXNjRU44RmdodTZVUjdPZzRLakczd1E5a0ppY21l?=
 =?utf-8?B?MDhSdENYT1BlcXgxRm05Z3NTKzFXcjczdFJvK3J0RHZzakwydDhDYzRnQU9M?=
 =?utf-8?B?blpSNnl0b3g0cDhOY2FGWmFyMU05Rk1aZnk1OGk0L2JXYWVGMXdwbWNYMHhw?=
 =?utf-8?B?Tk4yVW0xOWIwSzZVNlB6TU9sUWJhQkJBYnFhQVQ3M0RKZGMzYVJHK0ZXUFg5?=
 =?utf-8?B?VHZFbTFZaHdhcEtSdThOOGNSZVNJTVhPQUVmbkpLNS92NDFnY2QwZmFsT1Jw?=
 =?utf-8?B?Q3pxTTZqODRSSlIzYjVUcEd4OE1jS2JVTzE2S3ZWSVBjZWtBR0IxNWZ2THpy?=
 =?utf-8?B?YU02YytRa1ZpbHhxUG42WnhIRUNxSFZDeEsrSDZCLzVRYkIwMDYweVJ1Qmd4?=
 =?utf-8?B?bk5uK0JZNWN6K0E1VUNudWs1YkJZK29CbktVaFZGczlOR2ZiZk1KcnBBeUpB?=
 =?utf-8?B?RUpIOFdmSjUrSUdUTDlCVHBCc3VUdGY3SW8wVzZXamxFS3BvYjBHYWtpZzB3?=
 =?utf-8?B?Y1JnbG9rZTUwenFBN0pIZlhueE5qaUg0eERSN0EvUFNLY2pVR2pmMnhMZTkv?=
 =?utf-8?B?OWxWNS8xRTNzcWdMSFZVeUZwN21qK3JUVGRYOVU4Nnpza01ENFZkRE1VSWFl?=
 =?utf-8?B?Y0hVN01pd1JhNThaWldCRUdXL3A0T1YwTG9qNmR4OEFjT0tBb292ZmVFUFh0?=
 =?utf-8?B?WmlYejVBU1ZGSCt4QzEvcWlEUHlHekUvNGFhYWR6d2QreGJuT0pqaGdJU1dz?=
 =?utf-8?B?SFRyWjFSTTY2N2xubEVmdDBVTytXZGF3ZEhhYy9rZnFOVytsTThJckxEclAy?=
 =?utf-8?B?WURVUmpxRVlxUUpaUk5mRmdwMGx4UXdvaDl4Vm5FWXcySVhOMm5RN01TRzhL?=
 =?utf-8?Q?NvyIb98nVK/COafVH0xdRP1CA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bebf44c-5d44-4506-fe18-08dc3dceea5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:16:48.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s5bFrSb5g/wVBSYdoAnJB4C4s2mGVXEffaSYUUqbtZMMy0YH43V3yolh6ux3DMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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



On 3/6/2024 3:56 PM, Ma Jun wrote:
> Because powerplay_table initialization is skipped under
> sriov case, We set default lower and upper OD value to
> avoid NULL pointer issue.

pp_od_clk_voltage is not enabled in SRIOV (except for GC 9.4.3 one VF
mode). Since the interface is not available for SRIOV, a better fix may
be to set smu->od_enabled itself to false for SRIOV.

Thanks,
Lijo

> 
> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 15 ++++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 ++++++++++------
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 15 ++++++++++-----
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 15 ++++++++++-----
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 15 ++++++++++-----
>  5 files changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1d96eb274d72..42c5e6b103e8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1303,12 +1303,17 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> +	if (powerplay_table) {
> +		if (smu->od_enabled)
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		else
> +			od_percent_upper = 0;
>  
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +	} else {
> +		od_percent_upper = 0;
> +		od_percent_lower = 10;
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  							od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ed189a3878eb..6cc2e2d27a0d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2356,13 +2356,17 @@ static int navi10_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled &&
> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> +	if (powerplay_table) {
> +		if (smu->od_enabled && navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		else
> +			od_percent_upper = 0;
>  
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +	} else {
> +		od_percent_upper = 0;
> +		od_percent_lower = 10;
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e2ad2b972ab0..5daeac2e6239 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -640,12 +640,17 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> +	if (powerplay_table) {
> +		if (smu->od_enabled)
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +		else
> +			od_percent_upper = 0;
>  
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +	} else {
> +		od_percent_upper = 0;
> +		od_percent_lower = 10;
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 215f7c91ca73..271151c518e1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2369,12 +2369,17 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> +	if (powerplay_table) {
> +		if (smu->od_enabled)
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +		else
> +			od_percent_upper = 0;
>  
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +	} else {
> +		od_percent_upper = 0;
> +		od_percent_lower = 10;
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 3dc7b60cb075..533a3c1ba41e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2333,12 +2333,17 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> +	if (powerplay_table) {
> +		if (smu->od_enabled)
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +		else
> +			od_percent_upper = 0;
>  
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +	} else {
> +		od_percent_upper = 0;
> +		od_percent_lower = 10;
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
