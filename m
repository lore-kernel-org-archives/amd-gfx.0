Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E98CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C34710EAE4;
	Tue, 19 May 2026 07:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuPmT8AZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D64910EAE4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 07:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvs9zq2SK/h7qmIDWrvUZqUxL8NsmarYb6fPEJpKnm1DjMkr1Y339MdqksZPxaz2cda9V3Hmacp7X4atLVpWoKupfAi5R0xdRlqC9D8nBVh/VilVbsHfyCVPlpURZatw2F8l/CH/wCht+Aw7iXX8KGVSRtTD8RsmIsIQktazp5erWwIjNw7J+380Tz8L82WZqBs0C2dd4KgHvLu6qqwP5jNwlqR3qFeSjoSaL2LNGuDl0zcnVB/nGkGDuLZnxqk6/SQxTvEOaATYl8hXbunaEnUMUJceAcn+LJXwckEGjBp46kZEtm7Rcti5Sczfw2m82j7CMxUdy49Rl2wUc1yiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdCU6VwMNXBXT8jtiTueweyNGpizFeDuGE/jC15zOyE=;
 b=RC10ZbaLBXSrVo65nR4f+91z8jopSeCtPLo7v+G7Dbols50TOXPiT9Z3UJoTEUhL+JU3TG8usdr1f9VXaNIn8oKT2c8Cxyw8MuMqRFtxN1SoCOCQD93CO3wQt15sdQeCPnn6EV4/z8I8oiPTG1S+Inzd0ZqSIvBf1+ISyh+DkUutQkETyBgI1rj+pkjwL4EuDX3CkogePMNd/eW4nVng7fBGoI8A1JS/D/XmpOyE68sezpnOASSgzTLafzO6SQMxzmyigQ/HZXYli/kpNK3mICvA1CKWzEM4w2o08N9tf6W3SmO+Cjlh0SeWSTJHtQh5hGt9YK8yO0Eh24mXWbKWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdCU6VwMNXBXT8jtiTueweyNGpizFeDuGE/jC15zOyE=;
 b=yuPmT8AZcvA/NdzqSyi86eOMCKVzAunqkHYMVjAAZ4bvuAC9i2TX4oUI6XhsVb12pRzMU6kz3a6UhmEMjDBV81mVwBzMph/8YEDl4xRczV7gOD0QMOq3bi0i8z3DyJH7/wizxcbMMpSMvtlnyC0hQ86MrjJgqg1iREVWcQdZ52A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 07:40:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 07:40:10 +0000
Message-ID: <f684cffc-398f-4c67-9cc7-b9315c3563c0@amd.com>
Date: Tue, 19 May 2026 13:10:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix smu13 power limit default/cap calculation
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260519041822.552663-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260519041822.552663-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 1965a473-f14d-4e84-6507-08deb579dad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: A4b030f7htA8nNyzK8/K94raJzhif29SkuTjdd1ydHXKApDavMO8yntmkdWicTrkVeqYa3H8CxhFYmHX7Syx1z7+gGrLHa2n72x4R0c2rY/YBlOgwV7Nk9snMImuEN/9hnsbUWdV2jA/WI9lUZAelyKQBUA5aT2OiJOuzX4GPBy8vJsG5pM+aFGaldeVGivoQvBsUFEoghTaghQ1QgAcw4T3IArajyuEQJQflCOu0SCCF7Vk83SsTKG3SQ8WbydI5JUCoui6mNdm3McKBKtTRY94pEPLl+x1cR1OoeLqwu6u95t4B1gVicq6XjnJNly7C91lWB8zZvczfdWA1COgpv2+g7s1uRr0tDLj/cyxPupKWkF9RjqIyZJcYqVvRcFlaIihw1JNl0Bw6ob4+eXra/IMVDnDis6cIE+EWSjRH3gsPTKBZ/9WOO4xgsZ0A5Qe+Oy6HxZH+fV6lYfXpVOojhUkGctAJRev5c59nTjYgAHkhAZmmlDy37cEbmnGZIlTq6sUwszzHPqnL1vxh3JfwPqU/UkXHmHqJN0Wj7IXSmI2/odooIiphFPtckFsEiEf83bX7cy/rynD5iWKERwmZcYZdJq4FdbNncpwG9UKrLHyjZGIwIE7NByrMKUx+QxHpU9uf5hyDz2zYQsjDhTt/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1NuWFl1Uis2YlVUYlp0dEdQZjEyVUtIald0RDNNcWs3eENjT1lLNU51ZWsz?=
 =?utf-8?B?Ty96Rzg3L2psRDdzNmsrV1RtMVhkaUUrd0xEUzdZcUNVSSt5VmdWcjJ3cnpX?=
 =?utf-8?B?RUw0Q01HTEM0QkJGODZRcjVITkRKcFhQY0RQTVNMcW0zYjhmbzd6aWlPVmEw?=
 =?utf-8?B?YmFOcUtERkhFNExGV0c1cHdPRVFWOFZkajl0bDRCcWVJLys3blA2UFMzRXh5?=
 =?utf-8?B?dGdRTWFZKzU5d01XQmFmWUhDN0wxZ0cySWhURkhMbWhQVGN1YTA2SDY4aTdP?=
 =?utf-8?B?cit6SWY4RWtmQzJaajFlOW9Zdjd4L0xKNUtPaXNOclJtUWFzVXFPcmtDNkpW?=
 =?utf-8?B?dmRZSHNEVzk2ZHdaVEdBVXZDQ3NiNnFXN1c4bi9BV3V1dTdFdGx6RUhWWW9P?=
 =?utf-8?B?RkU3NjV6VTkzV3Nkd1A5T2EvbzZkUWRmVDdneGk2eTlvMzU4R0RtTTRVODk1?=
 =?utf-8?B?VkZ4aStaTU9OZmJzM01WeVY5UVlhUGY3VG91ZzkzZHlJeFBCKzNiOFR1V3V1?=
 =?utf-8?B?U1RZNktCbWJ2bVYyNUJKeXdHY3FnTGR3QkVyZGJVNnNUdnYyMk9pSGhKNk80?=
 =?utf-8?B?V3RpaG10Y3BzSHl5NlQ0NUxyMGR2VlpWNVpZTWJ1V05sS2Y1RzVxM2xKaWFU?=
 =?utf-8?B?d05VdUZyamNPWCsydU1na29MbHhIM2Qrb1hqZkhaMWI3cDdEa3FTRVgrSWNX?=
 =?utf-8?B?UGh1MHdrL3BhdU9ETGx6dlBIRWJRY1JiZXAzbk92ZzV5LzRzUE9GRU9iamF1?=
 =?utf-8?B?KzRYbmk1VnV1SGd1OExJNU9zNDVub2pXdTlmVnFza295U2xBZkozY2N3emh2?=
 =?utf-8?B?bTB5cDBZZzdMTGZGakdZL3gvZFNjN2JJaFVXVGVMcktublJzRElHWlJ6R0xB?=
 =?utf-8?B?S2Q0bUFJRElNRFVUOUg1dWliblJ0T2hpMDBERytqVE1FdVE1TVZRSG13YVIy?=
 =?utf-8?B?ZkhlbWdlOC9xeEtMYXVzTk8wY1VXMTRvZGhOWmdqTUR4N1ZHSU5OcUc5Z0c1?=
 =?utf-8?B?VkpnYnc4eVhrbHo1eXZyZ2xKOHp4OEdsUEtTMGNuUzZNK1ZIUHFlZGd0Unhn?=
 =?utf-8?B?S05Kb2dpZDZvR3Q4Mmg5UGxYdElPRzV6UUFsZFozelRGdlRZTnF1eFRkdkRY?=
 =?utf-8?B?NG1IWHBsOXVIc21MQkg4RnUrK2NBOEozSzVGOG1wZEpQcFNsMVg2OEU2TzhL?=
 =?utf-8?B?M0lydUtFWmRPNVlhN3NmUHpYV0NQczNoenNBT1FvdW5uWkdJTk8xNzhUU2cr?=
 =?utf-8?B?V3ZZYXNIdW5ma2NFN1ZKZm1Ra09ybHIwZFV2NmgvTG1vZU5ZaUY0ejFDSTJm?=
 =?utf-8?B?K29tYkMxRy9ldFVlTlgxMEdINXZXbUxISjgzYXBQbkFESEdYVE9nUktDcXNU?=
 =?utf-8?B?V0I3VEVCd0prMjdSMVZheDVVdENSOFF2T0pzb1RxWVlzM056MEZweE91c0xw?=
 =?utf-8?B?Tk11WlY0dXhIVzcwUzYybUVJcSs1UXMwTlBuTEtZUjROeVBEQ2h3TG5mOWVi?=
 =?utf-8?B?cFM1MlpENVg4dTJ0NUJ1OEtqSmZNdnprU3owT1RGUTFxbXgyKzNLMEdmT1JS?=
 =?utf-8?B?RlF6Zy9GWFg1K2s5UDVkYVhkdC91c2NIL0hhQ2wvdlRxYlFEeHViYnJnZkRR?=
 =?utf-8?B?TGJZSXhOVVU5dUVwb0hxUXlqY1pKaE9xL1BkallrbTVuOEUrSllndjc5bmMw?=
 =?utf-8?B?YVlwMUhGY0tPTzRyNWtaUFBBZ0VFQXpmTnZGVlIwRmYxaENmVkdZNzdkeERp?=
 =?utf-8?B?bnNIczBKMXF6TXBKOGdReXd2S0t3YVozWVJxcW5jMVQydVZQdnNacmd3Vm9C?=
 =?utf-8?B?Wk9sV3FWSzFvOHptNE4zQWo0MXIzL0N5bk8ydHRYQlBhVmhEV0Q5VHpaclRB?=
 =?utf-8?B?YVZSVHJrNkFSSnpyRWExZ05BdWorOG9hSHJ0OXcyNmh1SUtiQ2FBdXJFSnZp?=
 =?utf-8?B?bG9URDBQcFV2K0o3d1JmekpOeWFMNDRBZ1lucXZnSlRYNVBDNFlBME8yVFNs?=
 =?utf-8?B?UktGa3NkaVJPeEJDLzZiZC9MNkhIdFdtc2ltV29qWWZ3SWhiQ2hyUkNpVVM1?=
 =?utf-8?B?SE03MWNMVWlvOXZWR28zSk5GSXNGTW5iTml0TDZSd3lFenRsYzFQTGtLWEs3?=
 =?utf-8?B?d09IZ05mRHVKTlFLdEd5SC9QNVRtenpqZFkySG9YVUVoVzF6aFFkTTJGRi9t?=
 =?utf-8?B?cjVzWi9ldUFWbHJkMmR5NnZYV3pqUE5kUjlHcnlHUnlmLzRkK1poMklVUE03?=
 =?utf-8?B?WGJDUzNuYVM4ampyQWRJU2xkOWUzdGNQS01ybkgxc1NKYzlHTFNDL0ppL24v?=
 =?utf-8?B?RnlpWVFBMjFpTjBJVGhOV1BzN1BrN01HK3M2cmVDOUYyZ3dmSWhOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1965a473-f14d-4e84-6507-08deb579dad5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:40:10.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3CR9j7xgSmAntKDJAYY+oFtU0AOJRx9EBYJONgQGNyuzLloA9BCYQE73Xrv/924
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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



On 19-May-26 9:48 AM, Yang Wang wrote:
> smu_v13_0_0_get_power_limit() and smu_v13_0_7_get_power_limit() mix
> runtime power_limit with PP table limits when reporting default/min/max.
> 
> When current power limit query succeeds, default_power_limit was set to the
> runtime value instead of the PP table default, and min/max could be derived
> from inconsistent bases (MsgLimits/runtime), leading to incorrect cap info.
> 
> Use SocketPowerLimitAc/Dc as the PP default base (pp_limit), keep
> current_power_limit as runtime value, and derive min/max from pp_limit with
> OD percentages.
> 
> closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5227
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 32 +++++++++++--------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++++++--------
>   2 files changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 30d9cfac0d89..9e74a5c4be43 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2391,28 +2391,32 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct smu_context *smu)
>   }
>   
>   static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
> -						uint32_t *current_power_limit,
> -						uint32_t *default_power_limit,
> -						uint32_t *max_power_limit,
> -						uint32_t *min_power_limit)
> +				       uint32_t *current_power_limit,
> +				       uint32_t *default_power_limit,
> +				       uint32_t *max_power_limit,
> +				       uint32_t *min_power_limit)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
>   	struct smu_13_0_0_powerplay_table *powerplay_table =
>   		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
>   	PPTable_t *pptable = table_context->driver_pptable;
>   	SkuTable_t *skutable = &pptable->SkuTable;
> -	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
> -	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
> -
> -	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
> -		power_limit = smu->adev->pm.ac_power ?
> +	uint32_t pp_limit = smu->adev->pm.ac_power ?
>   			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
>   			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
> +	uint32_t power_limit = 0, od_percent_upper = 0, od_percent_lower = 0;
> +	int ret;
> +
> +	if (current_power_limit) {
> +		ret = smu_v13_0_get_current_power_limit(smu, &power_limit);
> +		if (ret)
> +			power_limit = pp_limit;

<nit> power_limit  may no longer be required. Could use 
current_power_limit directly.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
>   
> -	if (current_power_limit)
>   		*current_power_limit = power_limit;
> +	}
> +
>   	if (default_power_limit)
> -		*default_power_limit = power_limit;
> +		*default_power_limit = pp_limit;
>   
>   	if (powerplay_table) {
>   		if (smu->od_enabled &&
> @@ -2426,15 +2430,15 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>   	}
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
> -					od_percent_upper, od_percent_lower, power_limit);
> +		od_percent_upper, od_percent_lower, pp_limit);
>   
>   	if (max_power_limit) {
> -		*max_power_limit = msg_limit * (100 + od_percent_upper);
> +		*max_power_limit = pp_limit * (100 + od_percent_upper);
>   		*max_power_limit /= 100;
>   	}
>   
>   	if (min_power_limit) {
> -		*min_power_limit = power_limit * (100 - od_percent_lower);
> +		*min_power_limit = pp_limit * (100 - od_percent_lower);
>   		*min_power_limit /= 100;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index d253ce367476..481908913dde 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2373,28 +2373,32 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
>   }
>   
>   static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
> -						uint32_t *current_power_limit,
> -						uint32_t *default_power_limit,
> -						uint32_t *max_power_limit,
> -						uint32_t *min_power_limit)
> +				       uint32_t *current_power_limit,
> +				       uint32_t *default_power_limit,
> +				       uint32_t *max_power_limit,
> +				       uint32_t *min_power_limit)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
>   	struct smu_13_0_7_powerplay_table *powerplay_table =
>   		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
>   	PPTable_t *pptable = table_context->driver_pptable;
>   	SkuTable_t *skutable = &pptable->SkuTable;
> -	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
> -	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
> -
> -	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
> -		power_limit = smu->adev->pm.ac_power ?
> +	uint32_t pp_limit = smu->adev->pm.ac_power ?
>   			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
>   			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
> +	uint32_t power_limit = 0, od_percent_upper = 0, od_percent_lower = 0;
> +	int ret;
> +
> +	if (current_power_limit) {
> +		ret = smu_v13_0_get_current_power_limit(smu, &power_limit);
> +		if (ret)
> +			power_limit = pp_limit;
>   
> -	if (current_power_limit)
>   		*current_power_limit = power_limit;
> +	}
> +
>   	if (default_power_limit)
> -		*default_power_limit = power_limit;
> +		*default_power_limit = pp_limit;
>   
>   	if (powerplay_table) {
>   		if (smu->od_enabled &&
> @@ -2408,15 +2412,15 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>   	}
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
> -					od_percent_upper, od_percent_lower, power_limit);
> +		od_percent_upper, od_percent_lower, pp_limit);
>   
>   	if (max_power_limit) {
> -		*max_power_limit = msg_limit * (100 + od_percent_upper);
> +		*max_power_limit = pp_limit * (100 + od_percent_upper);
>   		*max_power_limit /= 100;
>   	}
>   
>   	if (min_power_limit) {
> -		*min_power_limit = power_limit * (100 - od_percent_lower);
> +		*min_power_limit = pp_limit * (100 - od_percent_lower);
>   		*min_power_limit /= 100;
>   	}
>   

