Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF681061B21
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 03:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D347210E1D4;
	Tue, 31 Mar 2026 03:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/LoQu0x";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B450610E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDzPsyTLHgkfZ+TjS5hRudWTZ1ANtRE8hu+4GggUF2iI9tMpFc7Cx4HBHc7TC/vr2PiWh5mHTAZqI8Hm7xSh4rgc4GAQtRWd6Q6pXFhlQ8Iw6sCZFQ6a9xSOLOjLwuci9b2ixs3KlIwX0ClQJrJgiL8jU9QHrvfpayQUB7LwpAd5G2VpS+HFmqH4B8EmvPTJFl9KY/KVHQLiXV5mgaJxwslfukjtKslH0NjC6oZBT3NxEN45eVgxcOtibWKRhqAd9OOUiSuerAH5Wkbzmbe7XubrePgbgmrr60JhCz+d4tpYEET/HfPNO32vV3HDYuVSHvMRMWhD9TpFYtjKDdU7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2xFJ6/kXsLVj2GglrZTGLNi/5cp/HW0I590YSqMI/c=;
 b=gq76fbpuwS5uyVPxGhZb2pRzKgrZ1+l8WanwVE+JPcIays+MHm08c9nahS479jekPiV6qHZsliQZJhNop6gk7z16mfLLHkpn3ig2JHMQpE8mPTGkS5+PykR4falkHxrCa+NVsyuF5Xr8fXdHK0YY7XAA3BRdiCIQPcrPmbr1Dh/J6Y45XOwh+j1PW82Y7oDlET7xlUvOaTmTJnfzL0BTfrK2u+r8LwJE4Qaqmg5XHRMhYQsAaKskgwXJzUFyFgSwTajs4pvVdFbYy5uXPHJdu5ti1KRVViOGnbgK3Lrw0L7MSv3WWZahTvQ4EbFnJ1kdOuvIF/7YRRsqvMUl1o4/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2xFJ6/kXsLVj2GglrZTGLNi/5cp/HW0I590YSqMI/c=;
 b=j/LoQu0xDCjLQAX1ex83FS5rZTwEsjHxHmzCbDTBC9rY85K4z2wbkwRXcRYUrUPmM6qX/gq3N2kTEs5N1yRZxKgarPBAADv0Rcwlbc2oEo2o6ghDAU7IXyO0/xsjxpIGnVKIQEFzkxKLS0+u6o/w84d/GjR3BXTWc0aCbUuBC04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:27:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:27:18 +0000
Message-ID: <639b1e4a-69c5-43fb-bd8e-30d0d2677529@amd.com>
Date: Tue, 31 Mar 2026 08:57:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/pm: optimize logic and remove unnecessary
 checks in smu v15.0.8
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, Asad.Kamal@amd.com
References: <20260331024705.1361626-1-kevinyang.wang@amd.com>
 <20260331024705.1361626-3-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260331024705.1361626-3-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0499744b-7386-4f4d-99a9-08de8ed56963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: MUy9N8VISS8mgFniXQEbRS3CE43psKC7EQw/xiFYfN6W3oMS9nPF4hyQ6l8pjapry0TnR4pI5cqk1ZxGNg0SQ7AB12GRQzjbHQKFX/On16e3M43Eowt3lmg7OcGRN8WEIoOUmhmQG3q8lKN15q3SQn3p3rQn52eshLCT8qVv0OwqE+b9utN04L/JEn3vmwluazrd5JSCluRzzhMNKfwdcSYAb1LwHXPZ9+AcGAx4fGXUVuQz+PZ8L3/dqNzbnEH8V12FTU5QGb0GXTwUBrQsH9zLTyXIdELGQ/J/LUhyN+MXDyGCcZVbQsC53Y8JR0hCYN14EqfSKp1zrM9Jok2ki1N7zS8lMIAHfHc4lGfW3W8KBiNseDn9hI8wx/RvxAFAuL06NyYEQ2BXdjRhUNMirIPdwQkB+yn+OBsvexEGjFFpgPMpu1xMkstn9TmsO+wccMxrAXczR8SQsfFLxwzhNIckkiy+r4oRiMBbbzO6+pYffUq0D9VMW2GQ11IeUDA7u5f7JZo2YjP0NQtNg+2a6iKcTuHMa1ilXqH5k0WrJkPbe+ZYXs0ByWsVRV6mTph2f2rupDTUiKb8SkpvXHmjsx2V18xuDqxmo1nFGw3oB0LyyOA83CKTKX4nC2dXxqwYKSmY544IVYwjcTN4cjDTUXyDyZUuFMra+AocQwYQG/rvQO71rZKKV8Xq+7CaoD+YkMvRGwqkBslqV8vWp4Ke0RxWEiNXtHTbG7ItxlhCbs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FMSnF4K3QycEFZSk5MNjhvMnNkejEvVHNpMUhEdVJaUUUwM3JkM0ZRZlMr?=
 =?utf-8?B?aTB1RWZOOExoNTlwWnhxNUJDYmJHUG5NNUhwdHNUdDIrNm1LY01IaFNhbGZL?=
 =?utf-8?B?bkNzWWdWdnk1S1lacEM3QmdZczNoc0s3TURkbjBiZnFqWVJvc2F6anZtOTdD?=
 =?utf-8?B?Q2Z6MU1nU2U5WmVPcmgxb3FXeTlkZjVOdEJtLzErMC9pTWdUTDhXaEs4d05x?=
 =?utf-8?B?UkQ5bVdudWY5UDF0dm9oR2FWcHBCVURaZ2h3QlJWQjJncnZ6YnRPMXExRFhN?=
 =?utf-8?B?RmFqb0Y1am9RQmx5a0lxaTlzbXBDYjNQYU9PY0xTTHc2a2JpazdYTGNVQkpZ?=
 =?utf-8?B?dkg4QTRadC8xdWRaSFcvZmF0Y0NJV0hMdlFWNHNIK0pRZjR5bUpqSzVaaDAy?=
 =?utf-8?B?LzFPclFGV1p1RDJSRWFPKzVwdzI2YndhRTkvQUhsdnlIYlhkOTdoUGNyaFhv?=
 =?utf-8?B?WVNZUnZEUUNMSkp2bWdrdGVnUTVLVWpPTmhwaDNQMXhXZndMbW9menh4dzdj?=
 =?utf-8?B?WFRGQjZBVkQ1YlB3MC90MXI0L3ZaaHdRUDY5OE9qam92SEhxVmE2d0VJU1VJ?=
 =?utf-8?B?ZDNvcnFmaE1WZE1tcFdhR2NPQnFCRDNpUmlZM24wVDNzZkhiUERRaTJER3Ax?=
 =?utf-8?B?R1F0amNqd21Mb3hkdGZOSWYwR2V2U2tJWXNiejRhaGJqZ1o4OGdra3c4V3ZY?=
 =?utf-8?B?czFQU1JUazU2MjRsZVo1cnphQlExL092WEVwaEx4RUgwMkVObkJCcGppR3JY?=
 =?utf-8?B?T1VYUUZUVStMVnR3RGxwQ3pZMmoxN0lqMXhJRkJPL2hER1M0UkF0Vm5qQUJ0?=
 =?utf-8?B?MkhtMm1XT2pkMVJnRWUxWGcvQUtZOVEwamZqTWp6U0ZnaDJaNmUwOTA2NjBj?=
 =?utf-8?B?VEJuVTlzckY3ZUIyOVZUUlNLa3RlanNneUNwTTFWajZZaXA1SlRhRTJ6TFdK?=
 =?utf-8?B?ckNTNGtQVHoxQ29BRzVaUUZBMDNsdjNXenZJVDI5ZngxcVl4RkhrWmFNQlB6?=
 =?utf-8?B?aCtBOVdhalV3Uk9BMWN2dHIya216d1JuTGdMclV4RVhaZHdBT1NuT1N1VmdK?=
 =?utf-8?B?S0VvS1h5WDBaOEtBbzN4OG1hNTYrSHJYcEtqeVNuMDlmTTRyeU5wN1NTNS9K?=
 =?utf-8?B?K0lWck05UkhKdXBGRGxjR0lTYm8zSW5ObVBTWk1McDF3SHgzTmFMWDlkWWw4?=
 =?utf-8?B?ZTQxcS8wRzNLR1VSOVA1M3VjT1piVG0zcnBuWkxoRWU3aUZkMFFHMytUVFdW?=
 =?utf-8?B?bVFNQ2NOLzRINU1QRDV4MDBocGZaTnB0Y0ZXRVdMd1RQVU05R28wVU00RkxH?=
 =?utf-8?B?WlFwVFVmYzFnQm9rYVJXc05xOWVJUm9pQ1BnS082aDBSWFdKNHFucWlxeVpD?=
 =?utf-8?B?TzV2enhtYVNCT0FUUzZZUjBGUDFWcTRYYWFkUEc3SmZGbzRFVDJ2eVR5Vzgr?=
 =?utf-8?B?SmV4M24raU1MYm5zWTdQc1MxRzBpUklnUUUwSnRiMVFqMkNSWVpNckFTdkxq?=
 =?utf-8?B?a0hXc2JWUS9vdGhLKzNCNDRjNWVNTXYwMVFoMGpzemtjUysvZGVzRFQzdGp2?=
 =?utf-8?B?MHlUY05tOEJhOURBbGtHd2RvZDdyVUI2TWdTMGFMRkNhdit6VzJKZXdINnFz?=
 =?utf-8?B?bGhISVg0TmJvb1IzcUxlM21BV0Q2YVJ5eGJZZ2lXMWZVdTU0UzRaeTBXd0p2?=
 =?utf-8?B?Ynh5RnZvQ1FYZnJJa0JsbUtueUlIS0dDYVJrUWpqVXBWWGNHYnhxMkFuU3NW?=
 =?utf-8?B?em9JdG9HeGFkS1BOUXpzUnZzdUJtam15bkVhV2RuVUhkNUZDbmFSREdnUGZG?=
 =?utf-8?B?djcrQUJTR2QvbmRjYnovWW9qNFg2V24yMHh1KzZZZFdrL0Zqa3hDTGhYN1Zh?=
 =?utf-8?B?NnFkajhFbVdMRFpEMkZHdlpxc2FKRlNZN3VoRVNxYml6eGhGZnoyZ290VXNa?=
 =?utf-8?B?MDZvK1NvcmlNKzQvTjhKaHN6c0xpU1MrOWxSRjNXQzNhK0JJRDlWbjdoUDlV?=
 =?utf-8?B?MndDWGtiSWR1RTRNRk4wYjQ5ZDZGUHAzTlFlTkJiV2tWMGF1bzVYOGMrQjh2?=
 =?utf-8?B?bndueGNTVlp6RzJhRk9uY0ZVRFRQRlpPL0t4RWZoSlpUQXVucFpUb1pJcjlZ?=
 =?utf-8?B?Uzg4eHJKQjBpKzlKK2VjSGtmbjFkMC9wN2lWTGNKS1oyeklXcnRiZDZrT2hz?=
 =?utf-8?B?VTlpL1FVQ01Ja0dGbXJoVis4am1KWm5RNWVQdHFXS0VjdEhMNXBhSkU2d1dY?=
 =?utf-8?B?RmpIWDRReW5uRUt0UmFwOFlhNTlDd1lRRlpqRTdXTVUzZVF0bjM3QmVYeWZn?=
 =?utf-8?B?TGZ0N3Q4Yi8zc0doN0lURnNudDZkRG1hVHVQQ3k3NWdhczRyVGM1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0499744b-7386-4f4d-99a9-08de8ed56963
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:27:18.4892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4/OHt/WPIlZp+K1y4BoNqbSNfpwyrjSOc1hlPvIGbiW8Wxz+AR/Jk9vtF8XnWQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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



On 31-Mar-26 8:17 AM, Yang Wang wrote:
> the following two sets of logic are clearly mutually exclusive in
> smu_v15_0_8_set_soft_freq_limited_range.
> remove unnecessary code logic to keep the code logic clear.
> 
> e.g:
> 
> if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
> 	return -EINVAL;
> 
> if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> 	...
> }
> 
> Fixes: afb58cd13e81 ("drm/amd/pm: Add od_edit_dpm_table support")

I don't think there is any bug in this case. Only that the extra check 
is redundant.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 52 ++++++++-----------
>   1 file changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index ae43edfa93a5..a916cad40dbc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1899,42 +1899,36 @@ static int smu_v15_0_8_set_soft_freq_limited_range(struct smu_context *smu,
>   	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
>   		return -EINVAL;
>   
> -	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -		if (min >= max) {
> -			dev_err(smu->adev->dev,
> -				"Minimum clk should be less than the maximum allowed clock\n");
> -			return -EINVAL;
> -		}
> +	if (min >= max) {
> +		dev_err(smu->adev->dev,
> +			"Minimum clk should be less than the maximum allowed clock\n");
> +		return -EINVAL;
> +	}
>   
> -		if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK) {
> -			if ((min == pstate_table->gfxclk_pstate.curr.min) &&
> -			    (max == pstate_table->gfxclk_pstate.curr.max))
> -				return 0;
> +	if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK) {
> +		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
> +		    (max == pstate_table->gfxclk_pstate.curr.max))
> +			return 0;
>   
> -			ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(smu,
> -									  min, max);
> -			if (!ret) {
> -				pstate_table->gfxclk_pstate.curr.min = min;
> -				pstate_table->gfxclk_pstate.curr.max = max;
> -			}
> +		ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(smu, min,
> +								  max);
> +		if (!ret) {
> +			pstate_table->gfxclk_pstate.curr.min = min;
> +			pstate_table->gfxclk_pstate.curr.max = max;
>   		}
> +	}
>   
> -		if (clk_type == SMU_UCLK) {
> -			if (max == pstate_table->uclk_pstate.curr.max)
> -				return 0;
> -
> -			ret = smu_v15_0_set_soft_freq_limited_range(smu,
> -								    SMU_UCLK,
> -								    0, max,
> -								    false);
> -			if (!ret)
> -				pstate_table->uclk_pstate.curr.max = max;
> -		}
> +	if (clk_type == SMU_UCLK) {
> +		if (max == pstate_table->uclk_pstate.curr.max)
> +			return 0;
>   
> -		return ret;
> +		ret = smu_v15_0_set_soft_freq_limited_range(smu, SMU_UCLK, 0,
> +							    max, false);
> +		if (!ret)
> +			pstate_table->uclk_pstate.curr.max = max;
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,

