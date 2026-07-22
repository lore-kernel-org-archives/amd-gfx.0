Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ECEC4453A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 09:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D895A10E447;
	Wed, 22 Jul 2026 09:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xrJZaW4Q";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA3510E441
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 09:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH3syYoW1/+B++xaOczPUWfGtYRlmeo+MaZUgxbbnBILcGnI8LZC2gMQZaYiBG6q3RZc1nO59EYbmpFC+jezDw6ejeKlq8QXysgNhhn/V5B+tIE1yEW9O4YRNFwO2/nLBK0xd9ER737tVUOlTqHOly7dQtnqToga69xa4NXufsV89jKPzKftZqyCmcgaLCi+leLewqTV/Npt74XDvKjtawmdmWZWHnc8PdAANFGSlwKKJiZArgZBhHNJW1vBw1erECjyswztYAokjV5Exs5Le4mNBcc55kZtkI4bIIc1+3GIUYdWRqc6LCE9WNRqF26Ob9AWusjJFarGFpifU0x3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1LZDttIGazaU9fuLnh6HIGhCHwsLI78TLbAfBTxcas=;
 b=AkgXkWOuZz6Gi/Bax/eFoJUdsQZl3dEdB2A6XxuRIzqtcEDpdUlW7gTvpL+lkVJk5CsrWSlKT+KoTI0VeSHDvaaklugQJR4hXNgu97pFQYhya7mSgxXewwesY1Js5g6dsP/L/YwoF7dl9y7zy5q7VpFXFFnkC/Np8Q2107/Aqk/jXdoDJ6PbLEB06XahN1beU8wIYtuDRJAcLf2+XCGQPnQXqHOMlaW5a+d/gzSjZzXn+0YJu3DjhSGKeHxTkNaKXJZdGgjI+o2vQU2IP9WwyTO1GGIjnOd0vn5RcExjEBgxbs/14d7OFH90VEgKYpomKmpHvaWhvHQyJDyS8OpuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1LZDttIGazaU9fuLnh6HIGhCHwsLI78TLbAfBTxcas=;
 b=xrJZaW4QsM172t09+ruLfN44hFe8EVhXAO4dDstw7hqbo1hEiFqR9KtmVrkGdz4RDtuYMTNk+Qtm3wo7GBonf5dVHAueqpX9MrQliYBOLnr3Ae071Pn9drStrKY9hUlTLXB/Ycs4eZ/hOX5nLJUrs5QU8hAbiLSOLUMWZYi4CUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:25:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 09:25:14 +0000
Message-ID: <53e9330e-ed7b-4f99-a1ae-cf67d2db1bcf@amd.com>
Date: Wed, 22 Jul 2026 14:55:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain SDMA before process eviction during GPU
 reset
To: Sunday Clement <Sunday.Clement@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent.Russell@amd.com, Harish.Kasiviswanathan@amd.com
References: <20260721183150.303360-1-Sunday.Clement@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260721183150.303360-1-Sunday.Clement@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: fc34c03d-77eb-4cc1-066d-08dee7d322af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u2RPTmI5Cv2yDC8kknWQxBw2cUBiU6LUO4WE3ODTymnvZDIbT9gKtVBUDtLy2XPE4I84uff6AIUKr8LumYfQJrUFmHuYbMU4f/6D6k2zTTiQ6QtY5bP6vBnA9uS9x6Fcjmw5nvKfDZCtX6pBNkGNaD43Iq7XvbEv4WmTPwmeD3Hq8kV/NIpNJjMU8UVYRjb5uWMv/nrHA5zzjOgo1bagm496v99ch6N9a2uGkrWC6NcUBe+nf7sEojrk7kDf9235T2qtm8Yk7IW7LKhMF47c7SLi+2S717Q04bcfpFTgivYwYzEftabUgZTeEd22iHZoSoqw4BLyeE2yTpJVd1n0kHQrhdty8PNz0tfsi41DFl6YeOy+FfzaaXAYaAbG8nEHVyFk890G98cbmW/rSCMMA1Vaw7dgsqzkzhpHbUlG4xA17PwysBK/Wx7UedOVJJBcMpc6SWzLh+M9LUMxdPWtjLCK3KrmtBgAgRmrVrvC+yRCMscIrFEvaUphqdue9J/WqRTAGfE5u0WS6IcPir3fSIX1zZeW+IsWj/mJ97JqVCyUkuig+0GvwmQg8LxCAMXSR2LcILzAdfs5N1M+EcbYtJ797aZdY07yP6JHi1J5k6IBVLcJEtHfqab4eCm4s+rAIQziUrnIeUSRA0ZTzhmnEF/1tUO5E9Ex3DWL90bq4uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtIcmJtODl6K0lzdFNLaC84VWgxeGlUeVNXb1pRU2owU3ZKaXE4ZGVyV25a?=
 =?utf-8?B?a3RjenVBaEFYejZMU0s0NSsxamZ4U3E4N0R4d0RMVkJKZkJqODZRZVdxY3Nm?=
 =?utf-8?B?YVFIZjlzYWtWWjRqYUV3aytIdnZoWDlpUzczUUMrRWxBZGpuQ28vUEhWZWR3?=
 =?utf-8?B?a2NpRWNhYmFVaDA4RFZQYmZXZ0w1dVhYTldNMEdEcUtXWW1hZXo3ZkFocFVo?=
 =?utf-8?B?c2owOHpVOStLbk0ySzR2c0paSWlQYTZyczVjeE8wQmtUMGp3NityWFMxQ25M?=
 =?utf-8?B?Qm15ekRBMEVNN2E3SGpBUGJWN3F0MFF5NnVEekRNRzhaK2VMMWVreUQyWm1C?=
 =?utf-8?B?UFlxM0RBTnp2dk1iRmdGNUM1Z1VXT212aDd5djV0WHlVK2RtSDIxMFl3UDJZ?=
 =?utf-8?B?TUtLRWxEalU2YjR1VmpXNVRHenI0SVF0QVNlUUxXaUk0cXZpbkYwZFBPZWhQ?=
 =?utf-8?B?SGlmVGhkSDdTaHliTm52VmVhZHl0aG5nYlNyZHVuOEYvenBvRzA2WUtsbkZh?=
 =?utf-8?B?RXdYRXo3V1ZBbnJxZ2xyalFkc0NuQlNYYzQ0TTFHSnhzNVRTT3dsSUFYbHJX?=
 =?utf-8?B?NUJWenlZV2tyajZXQ09sYlJoQWREa3IwRWw4UFV3UG4vMHUyQnhTcTF3YlZT?=
 =?utf-8?B?VDVvR3BoSVFta1VWN1YzSDFuTUl5SmRCT2w1TGllcWVWSlVjN1dYdkJBRGhz?=
 =?utf-8?B?U0N4QjFoZU01bXYzcGJoVVU5ZElTWTg3VkllUlN0VnpSRlJSVkFvVzdDOGho?=
 =?utf-8?B?bExlNklyTzFPTk5LTGJVbUl3NFBFdjBnRFpQRmxUUzBhNG90UDhUMk9Qdjcx?=
 =?utf-8?B?cTlud3U0czl1cFpsQnhoYXkrNTRzMzZZNzNLUFVVeEdwa2I0dEIrbUQ3ZjBt?=
 =?utf-8?B?Sm1pMG1vT1hIVjJOcUlIS2RWNzBhZXk0R3ZqcHd1WkVUYzFzQUtZSHNoMHNG?=
 =?utf-8?B?TmpNYk4xc00rWXJUc2RDMk5MYU9oWmo2MGRmbG1YeE9Xc2dwTk1LRE5TL1Iw?=
 =?utf-8?B?dk1MQm8zbkhFWU1CeGlybFgzUGVTUmFRb1h3ZExubk84VTBMS1dJUFF6V282?=
 =?utf-8?B?Z3pYWlFoSVp6VVN4Z2VoKzJUR0ptSEE0SzFEbXNESHcyd09uRmRmTllPeGpK?=
 =?utf-8?B?Kzl5cWZNd2ZQa2MrTUdIWmlQRS9ML1E2Z0toS3REZEZPZDZiUHE4R25xcm01?=
 =?utf-8?B?M0JtdlFDRTNpRktJQ2dPSFp4UzNVcjJUTVBESC9saTBNNFhPcUh2NFk2N3pW?=
 =?utf-8?B?aHAvVVJjM3A2QjFqd1h4TVVDNEFsK3dOcWZHWmpvalY2SC9ZR0tvQ1FOUzk2?=
 =?utf-8?B?Z2RqYkRzektpYU1SN3BaTnl6Y0VkUysrMDZvVm5WeHk5czFNSFZmbHJFSFlU?=
 =?utf-8?B?MUNESFFBNm0yZ2R3MFJQL3lWdDNDS0wwemJTWlhZclUxMVZKb1ZndHZpVkJO?=
 =?utf-8?B?QSs5eWkzRVRId3ZjalNidEZZVXhzWTh2M28yMDVBMnptY2RlZVoxM0VKWGg5?=
 =?utf-8?B?WVZKTzJTRTFrTmtvcDNtYnMxSmFMM2hNSkxjMXZnZ1hRcnhYZXoxZWJ5MHV3?=
 =?utf-8?B?TGwrOFBVdUl6SUx4bmYxV3k1Y2h2RkkvTDkrVU4xeFIxdXFQVTdNdUtaUldJ?=
 =?utf-8?B?WHJwM1RoUkZkNjNkSGNJenJqU21iYmNUY25LSHhTRHJEYnFPZG9Fc3kybXl6?=
 =?utf-8?B?cHBUd2pTV2R4cldLZTA5akNvbFd2cTRVUTMyQ0YrME5LT1k5U1ZlMEJaN1Av?=
 =?utf-8?B?T1hpaEt0dUJPbm9wejN3cmZUMzZuelZZTTd4N0pwNS84ZWtYaUlESno2dHBS?=
 =?utf-8?B?UkVSZlRRUmNLbFh4RjI5VlgwL1ArNUdTQjc5TGROcFJhekkrd3N1K1ZvVlNm?=
 =?utf-8?B?Y2pCbk5qRE9ocEpQa0diR3Q5QXc4UThCb21kcW5TUFBGUmtzTTIrK1c2dVQz?=
 =?utf-8?B?SWcrbDY4NWhBbG50RHY3eGE2RXdGNW5XNUhoK25tK1ZGU0UvQlJ3c2pqL3E5?=
 =?utf-8?B?eUg5a29QWFVpOWxQOWxvOTQ5L3BpYXA1ek1SYkVCU1l1ZHBXNCtiemtsUThi?=
 =?utf-8?B?WnpJVzFhVlByZEZDQlhuNEp1aFVPbEJDelk4cElUYVJ5QzlsZ2xpUXp0Wndx?=
 =?utf-8?B?MlQxbktxUGNnRXU2ell0MEV0Yzd0akIxc0FsZGhoTkZMd0xlVG50Uk1BWG01?=
 =?utf-8?B?OWt5L01wQUZtYlVRMXh1K04vb0kxRW00Rnl5T1orMjNIZ1huR3pySXF3OVF1?=
 =?utf-8?B?dHhVcllvajREWGNJeHJPQkZGQnFBYnFCUnNLQnROSTcvT3BxVzBVRTg3WktB?=
 =?utf-8?B?T0RSYjlrdzF0bytvT1dYaEM2RHRCb1lHQjBSdEZJVlREMk5sL1VNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc34c03d-77eb-4cc1-066d-08dee7d322af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:25:14.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8CFf3vyTswxbCUMfym0UDk/KBAbQWpI+BankBH1F2bZ/IXMNbZTcIG5um6PSCyU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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



On 22-Jul-26 12:01 AM, Sunday Clement wrote:
> Host kernel panics (Oops in free_swap_cache) when GPU reset is
> triggered under multi-process load. The crash is caused by SDMA engines
> writing to memory while munmap clears page table entries during process
> eviction.
> 
> The race condition:
> amdgpu_device_halt_activities() loops over all devices in the reset
> list and calls amdgpu_amdkfd_pre_reset() on each device. The first call
> to amdgpu_amdkfd_pre_reset() triggers global process eviction across
> all GPUs via kgd2kfd_suspend_process(), which starts munmap clearing
> PTEs. However, SDMA engines on other devices in the reset list still
> have in-flight DMA transactions that have not been drained.
> 
> Fix by draining ALL SDMA rings on ALL devices in the reset list BEFORE
> calling amdgpu_amdkfd_pre_reset() on any device. Also flush the HDP
> write cache to ensure SDMA writes reach system memory before PTEs are
> cleared. This guarantees no in-flight DMAs exist when process eviction
> begins.
> 

The processes are signaled during pre_reset. Without 
suspending/notifying any process, how do you expect rings to drain?

Thanks,
Lijo

> Signed-off-by: Sunday Clement <sunday.clement@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 +++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 472e96ae884e..0cd3dc4cffb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5340,7 +5340,36 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   					  bool need_emergency_restart)
>   {
>   	struct amdgpu_device *tmp_adev = NULL;
> -	int i;
> +	int i, r;
> +	struct amdgpu_ring *ring;
> +
> +    /*
> +     * Drain all SDMA on all devices before any KFD pre_reset.
> +     *
> +     * amdgpu_amdkfd_pre_reset() triggers global process eviction across
> +     * all GPUs, which starts munmap clearing PTEs. We must ensure no
> +     * in-flight SDMA DMAs on any device when eviction begins, otherwise
> +     * SDMA writes race with munmap, corrupting PTEs.
> +     */
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		for (i = 0; i < tmp_adev->sdma.num_instances; i++) {
> +			ring = &tmp_adev->sdma.instance[i].ring;
> +			if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
> +				continue;
> +
> +			r = amdgpu_fence_wait_empty(ring);
> +			if (r)
> +				dev_warn(tmp_adev->dev,
> +					"SDMA%d ring drain timeout before reset, proceeding\n", i);
> +		}
> +
> +		/*
> +		 * Flush HDP write cache to ensure SDMA writes reach system
> +		 * memory before munmap. Prevents cached writes from arriving
> +		 * after pages are freed.
> +		 */
> +		amdgpu_device_flush_hdp(tmp_adev, NULL);
> +	}
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list, reset_list) {

