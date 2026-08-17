Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D0C5CFC1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA70010E6A2;
	Mon, 17 Aug 2026 07:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uy7q5V2s";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A141B10E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 07:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AY+pwBg5YJJ2uJWnV5tXpfHDOBKctGp4OR2mNbAJzaTjvAHdzUVeTnAJmCqh6KQb74fvj9+S7ihkfpqoCq7RpLLfvOR77q47SO1V1URXGgU1k6+hOO4TwdD9hZdPuD/HnIhINsVH31kEpI3Khddakw3TvBYKteOND2uST8+tpddkv55KdoOwvZ9QW7JVjMpgj2qWnc1lfXX1kljorWqeLJugFKlYLt9E0cjFsMzjw91lHecmvqkRMS4nbeQqiNGcGYdw3qwUwbvAct2ib0p/9Vmu3Da+WdzVFdzS8P0e4JT3TTfU7uvH7+dmYIx4n4E9KMMs/muOyp8BB8gHQYj9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/wZ6vg8dUuva3eYHqciaevqlOtGoLTE7mhj6TdBCXk=;
 b=hiSao4bu3/WolRyoZ/iqu+lrr6SPD4+t7iLXkmdTCvY8xWFBltlCeYIEiegxc+TiJA0qVPKs4BWY8OwwmumHMN7I50PPvRSZ4adJ2GHsIGVkR2utkiWf46J5MipHWgMLH+7+Xvck0kc2peLCUsxIhbAJl4CPc30L/lr/DyyRHnGp6JBGUOa9uwrJO9+NipXQ1xFglQMSg9tb8+j2CTQuLFin68yEyEeOnLZ/dc6egK36HUwlsp3+IZoif6DBAjUbwYhpehacge32nM8rAIvWgtdSSq5JmAeuhL79qOqVVEVY5E5u949mzclh1Qurvfd0qjAry/XY+IjDxLOhM6C9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/wZ6vg8dUuva3eYHqciaevqlOtGoLTE7mhj6TdBCXk=;
 b=Uy7q5V2sk+Nu426GZKmnBGEj9b1ckqpf3GU9IjgAQNwAjK4eUGg6hydK/7IKoPEpPU0pvz8Df6QKq3e41a4mDQmU7vi2UJ++c7KaqPNwx2ssWalwU4VTpdRfO1ScjYCeVejhdOyX1q8Qje+N/KDUZVcJPbFnLBLn8fWvALukUqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:23:50 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:23:50 +0000
Message-ID: <021213ee-1cae-4e9f-9cf5-0550a0410a12@amd.com>
Date: Mon, 17 Aug 2026 12:53:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260817062728.2535467-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260817062728.2535467-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e93ba7-c6a7-4a58-303d-08defc307b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NGnPAIcJMUlpWvqWszsrC7URx5gDlt+jOXUrzK/NlNko4oc9vRWeVYuOh/H2ZqNT3rTHoneyYebRA83IlVj8cO3/LY5s5dYlQ0qkWBmBNltr8LdzVsC+iRsY3LYPnaKuQ1llZZelCV0H3CbETSQCyFXXJb+wSoNAbHEJiucSpvCbtE6HyLqPCx1fm0lGRy8jJCB33UIcisn4G4VC/YEtoUm4nrmAnB5zW8Wmy57ozc+TWoC9wVfEgg3paRnRYKO00l0Qg/gNoZmwU3dvQXCxpFKSThCnd91w9HP0sDw8RHtfWuL8sUtVCRvuNOkidFgGtCvESUdCkKectLpI24YmniGLPeqis9muF16UX+s8AgNcnsCnchuqG4ygSBJ05xso6Y26OFgVMhuLseGBjQE951nTq00j8tP4Ew8e+RmljBZAcVNQQqullFdMh8xyGj/bszSqehVatHyr1owqMNOpdTAjenhRq3rOkE9RR3wpn9DFOjJbWCF3+q+mx/5dCffOCKzTcYr7NmDdfdgmDiR8mLkpxPsne6scD75c5L7r1lCa44QJ/sOmmhKt0jwVeUdyMixG/mBHkJq9ABBJvUUnvBSzUfQEGmWYONXV4cdXHMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJTYlUzeFduREhObTl6aDJ5elpqREpRSGg5V3NsVHltTE9aMXhEbVkwS3Rq?=
 =?utf-8?B?ZTNPQk5uZ3BuVWNIbEdLZzZEVHdNbzZlYnRSY01hSTdDUnNBSS96cHhaSEQr?=
 =?utf-8?B?TEJ2SExNQnlVdkFnQlJWMTVtdEk4bm5uaFU3RkM3emtkNlFabTZhdTFQaktG?=
 =?utf-8?B?S2dGZ0Z6SFNwbTR0V0tka0NicU04YXRHQk9pMVBMS041Z01mU1ZGZjd2dWRr?=
 =?utf-8?B?SEFEZG5WM3Z5MGlmenlGYXdBUUkwNlB0WkgzK1dMODUxbksxZjQxeit0Z2I5?=
 =?utf-8?B?Uk9oSlRsWFpsMmRPWFpleVoyOWZQcFdZdEIycmJUU0c5M1NQNW8wRUFsdDdo?=
 =?utf-8?B?RjVqMGpaQld6eWl5cjg5bjdGNFJaOHhtM0h5YmN2dzhkL2xPNG9RcUlsdEF3?=
 =?utf-8?B?NTg0Ri9USnBkRm5YZU5VVTdReTg1cFo1Mk5xWDk2dEFqN2FXWTNlbmhjMENz?=
 =?utf-8?B?TlpCZzV4Z2lXMTdpcmhBejB3ajkrOVZNSDRNS2hhTWpvdUdrV21NR0FJa3N6?=
 =?utf-8?B?TDlzODhXSWVFUkNVZ2cvZlYzeGtocStCaFpPUUVucVNwZzZRcFhweXptVFN0?=
 =?utf-8?B?L3psOHRudzNLbUNqb3c0YTlKbWVIYnlWaVhzYmZlYWg5a1ZsaXVpSnR5ZzV3?=
 =?utf-8?B?QnNaa1hSYmZsTG5kZG84cVR0QXJxaUp2YVVRK0xZUCsxVjJzVGhMSVVlemJy?=
 =?utf-8?B?NzBBbFRSN3B6VUovNmpaVFZtWWlGQkI3RGQzSzkyamNnaFduMVZTWExEWm5T?=
 =?utf-8?B?aG5YZjBQaE5zYUNVa1NZRjZKbUxLUTh0WDJ5OVNERi9qTnlRWmxjZzhWUjF2?=
 =?utf-8?B?UHZwYmNkQXA1VHRmcW54Q0xvSFVKZnQveEo3YzFNRWU4dFpzbzk3VGY5RnhQ?=
 =?utf-8?B?STNTdDVEVnpoZHU4U3RtSUpRZ3ZaV09HbHpTUGEyYU5VeUZ6Zm93M0VKSitX?=
 =?utf-8?B?eFN2LzVMV2taOGlrVGdZTlUvajFhbTNQVU9GVUs1MUhGQTlOUkxBUlJFNkta?=
 =?utf-8?B?WjBIdlVyWllSN0xLYTczMWw2QUZDOGxCNUtsM3NVdlNuZThlSExZR1JrSkJE?=
 =?utf-8?B?TEt3Z3NkZ2hmWnhXVmNoUlN5cFJNeHJGT3NER2RSNG05NFdQK1czamFhYWZx?=
 =?utf-8?B?WGliekg2VjVjc3I0QXFHVVBnZCsyQVFxSHA5Q05CbU56SVJianVmZUpoa2cy?=
 =?utf-8?B?VnltREZqYWZnSHBpSHcrdTM1emNMSlBWRHdaaklnYVBVZkltRW9iY29xTE5E?=
 =?utf-8?B?T3JtRnVNRklHRk85eWd5Z2dLQURiWmJYNGlhSndiWDVwRGRDVlpGYXM3K2kv?=
 =?utf-8?B?UEt3MytlN29LWDRRQVR5SDZSWEZuQmgzOW90Vnh6UTYxOUM4UkJJRzRzYlY4?=
 =?utf-8?B?UjBZZ01rbXZVOXhzalVxRWJiNHlqY0JPRXF3V1lnRzVyWmd1WlAxWkhRa0la?=
 =?utf-8?B?TFNjdldRMHE1dkMyZ0Vtc3FscEN3VVo4SFZFUXNaREFONlgwSWJCTmVWdDdy?=
 =?utf-8?B?enRia1JGRFZBWjJtR0pKQklaVkI1ZUNmcGJWMVREQVgvbyt2NXBETzllbWhp?=
 =?utf-8?B?VytLVUppMjBzOHlHcTNnRU9xTkVjNlYrR3FkWVJCa3luS0NyaThESmg2NU5X?=
 =?utf-8?B?ZFVMZkdKNDNwZ3Y5dUdSeVBrWWYyb0dXZ3hjWTZ3Qjd6bmhXWU1jUFFqdlVY?=
 =?utf-8?B?a3ZIQzVrY0dLMmovR2hqTkhXZ1htOUh4cis1WVZqTVFPajdPcGMwUk83QzMv?=
 =?utf-8?B?cTBwZVZuaEFtUHY5MXQvRTVGZjFMM1N4WFFZTURwcC9DRDlHM3o4NktQNkx4?=
 =?utf-8?B?N1pKYXU0VWVBeHdIT2pLeFhjYjdKMXFtdExoTmhINEFvZFM3MWw5RmlaZ0dp?=
 =?utf-8?B?YndYcmpibnYvTlByeDNtYTZNSmhkV3dqckVNcXhPYWZJdHY1SmZqTmUxekpj?=
 =?utf-8?B?NzJnQ01QZitycSttM0RaK2w5Y3NUWXdXZlorY3lmdnZBNW9yTzlpWklCalh0?=
 =?utf-8?B?NUJMdnZpeVN5N1hZci9XS3NQQWxxTDhIbjArMXNJWlZVT2VWMXFjdytYTTd6?=
 =?utf-8?B?WXVoSm81aTk5ZzhBUHNhdWp2anA0RldQRU1LRTd6WVBPMGozU2RnTlE0K0Nj?=
 =?utf-8?B?U0xIUndMaTgzcmQvZW1RRk1GNTlwc0JnQVdSditYaTc0Qk5nYXJwWWdOZGZ6?=
 =?utf-8?B?bjlBb0QxS3RGTWZ2RXZhMWxzZjRuSWljZGM5R1Zsd1dMbFQ4MWNtMEY4cS9l?=
 =?utf-8?B?a2JxbUtybk5OUmNKOE90WCtKYkU2ZHBVZEdBVFYwTSt0NmlUREpzWDVPeExH?=
 =?utf-8?B?NFdqK0ttdSs0elVpbzhUY2FIc0FJd0c3cGJxU3dNbWJseFpSLzhNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e93ba7-c6a7-4a58-303d-08defc307b9a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:23:49.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItF29BjKAwZgAaoNkG9wdJMXF4jpwx6KRUCWZMt9gktD9lobuZmSI+qyDRuZ8HN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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



On 17-Aug-26 11:57 AM, Yang Wang wrote:
> SMU 11.0.x can retain an unfinished command across system
> suspend, causing SMU messages such as RunDcBtc to fail during resume.
> 
> Prepare MP1 for unload during system suspend and record successful completion,
> reload SMC firmware after PSP restart before resume sends further SMU messages,
> then clear the reload state.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  9 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 38 ++++++++++++++++++++---
>   3 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 04f6ebf31cca..5c00683c1edd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3512,11 +3512,16 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
>   	struct amdgpu_firmware_info *ucode;
>   	struct amdgpu_device *adev = psp->adev;
>   
> -	if (psp->autoload_supported &&
> -	    !psp->pmfw_centralized_cstate_management) {
> +	if (psp->smu_fw_needs_reload ||
> +	    (psp->autoload_supported &&
> +	     !psp->pmfw_centralized_cstate_management)) {

Is this really needed? For PMFW managed cstate ones, load_smu_fw is 
called before TMR setup already. SMU versions 11.0.x listed in this 
patch have pmfw_centralized_cstate_management set to true.

Thanks,
Lijo

> +		if (psp->smu_fw_needs_reload)
> +			dev_dbg(adev->dev,
> +				"Reloading SMU firmware after MP1 unload\n");
>   		ret = psp_load_smu_fw(psp);
>   		if (ret)
>   			return ret;
> +		psp->smu_fw_needs_reload = false;
>   	}
>   
>   	/* Load P2S table first if it's available */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index d80c85793e3b..20338caa4921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -443,6 +443,8 @@ struct psp_context {
>   	bool				boot_time_tmr;
>   	/* flag to mark whether df cstate management centralized to PMFW */
>   	bool				pmfw_centralized_cstate_management;
> +	/* SMC firmware reload required during resume */
> +	bool				smu_fw_needs_reload;
>   
>   	/* xgmi ta firmware and buffer */
>   	const struct firmware		*ta_fw;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 559afdc5815d..8d499d9a86df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2182,12 +2182,36 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>   static int smu_reset_mp1_state(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0;
> +	u32 mp1_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
> +	bool needs_mp1_unload;
> +	int ret;
>   
> -	if ((!adev->in_runpm) && (!adev->in_suspend) &&
> -		(!amdgpu_in_reset(adev)) && !smu->is_apu &&
> -			amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(13, 0, 0))
> -		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +	if (adev->in_runpm || amdgpu_in_reset(adev) || smu->is_apu)
> +		return 0;
> +
> +	switch (mp1_version) {
> +	case IP_VERSION(11, 0, 7):
> +	case IP_VERSION(11, 0, 11):
> +	case IP_VERSION(11, 0, 12):
> +	case IP_VERSION(11, 0, 13):
> +		/*
> +		 * These SMU versions require MP1 unload before system suspend.
> +		 * The shutdown path already requests it through mp1_state.
> +		 */
> +		needs_mp1_unload = adev->mp1_state != PP_MP1_STATE_UNLOAD;
> +		break;
> +	default:
> +		needs_mp1_unload = !adev->in_suspend &&
> +			mp1_version >= IP_VERSION(13, 0, 0);
> +		break;
> +	}
> +
> +	if (!needs_mp1_unload)
> +		return 0;
> +
> +	ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +	if (!ret && adev->in_suspend)
> +		adev->psp.smu_fw_needs_reload = true;
>   
>   	return ret;
>   }
> @@ -2279,6 +2303,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>   	if (ret)
>   		return ret;
>   
> +	ret = smu_reset_mp1_state(smu);
> +	if (ret)
> +		return ret;
> +
>   	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
>   
>   	smu_set_gfx_cgpg(smu, false);

