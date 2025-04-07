Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307D6C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 05:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C347C10E1E4;
	Mon,  7 Apr 2025 05:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypConwSx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D69E10E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 05:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE1u3tfYoQ0ondu+LWrMqRMNcv6UqcWv5LSOwcNR30U2g0q8hH8sD+0n+FePRJxzxN6Ku65mO81L59/4CannwL1/6m+GjYyfIG6MVt5yKZt77P/ktp9+XblxUsE+wGlXYSnkcSgZR/jo/fse+5JKZ9vP1p+2yLgFSAqdGZMFmRkhhLa/t4u4xrxZrpZRaAbisDY0Qm0WYzZhol+DHa4xxSlfwgrJwo7RZmErW5chz0tKNdiQWsd7qbMW0vT1Pqih8iec9e7QKaD7pqljiHB8DgqUoUiKRDZjuN733ibHa/FrtaM6yNFfyP7XxchpsA29DmjelD2CDVders/genDnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx1RF4qN1rMliv1RXtdntJnCj2jT/bj29etCaQGPE4M=;
 b=XeigTci4nF0E898PszZ9BXyPbPpoxtJkabl9D345b+JFzJHbNH6I5VoqDw97fXQWHzdHaTe9GR48dk3tExPB8R8Rn6zEj3o5CdzcPuEAIrByM2AGBVXLaIJdp0wMRUaEdjEnt2H01pxd0xlwbQylzbEFK2/M7orUIxLmrFdvj9F8FZq05Hl5yYOfxDQg8MP5G1M8UB55gmK3aQ7A8+MpoNHAzAFEArwkju97D6kM4strEUpbzeQFn04jm3Wu8oWs1WzH6XbBJlI38gCJGAJswEFPknHl/VjlkkqtZf8X6k+newvirDr3AHGjFm+VrcpI6CUjYnTqJPlT+kG5ceWknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx1RF4qN1rMliv1RXtdntJnCj2jT/bj29etCaQGPE4M=;
 b=ypConwSxV0J3EI5DhecG6YeU4zMNj3an+MAuAFO+zcOJjI5onqAJhiVmXBYTWt+64gBvHjISZ22TtJvPUCH/45kFjKHQGz2h59SoQQTDUHH+y7Z1g364WtDbfJsb9x0GHAQ93uVM8uvxdqk9wnMtoYhPvUAcv4m2bUK/4WlnezM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 05:58:33 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 05:58:33 +0000
Message-ID: <1f33db74-8c82-42e3-9b1f-a14de7949802@amd.com>
Date: Mon, 7 Apr 2025 11:28:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: make mes_userq_unmap as int from void
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250402121125.1689394-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250402121125.1689394-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d48df4d-5a20-4dea-8fd4-08dd75993a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S29qSjk0REQ4NjMwNnlMdWlUTFZ1MnBSb3p1cXkwd2dGQWo2SFZDQ044S1dy?=
 =?utf-8?B?UEVMb0Z0b0ZqcVllWVdOUVEyV0UyazhJQnVVN0x4aStPcmE4NXVNYjVlenhm?=
 =?utf-8?B?RHFnWjhOVGJSeTRRK3VGOFZBU1lYVzFEdWhjZEhWSkJjVk9LT2xrOStSeExF?=
 =?utf-8?B?YnNrVWZTdDFjdlp2STdtQjdmSjg4ekN5ZnNSdVlxRjN1VmNaNDFIeG9lZVhu?=
 =?utf-8?B?SHVmelNRa052bkpjU1hsVVRLclpPZGoxNmJzeEg5emhmcENnTE53V3E2K0Yr?=
 =?utf-8?B?OEFnZU9jTDB3UjdUVWhXY3FjWFpxY1pSMkEzT2l5YzFhaU1tQXlHMDNNYkxn?=
 =?utf-8?B?T05tS0RnUWszRzMzL3V5UmdhTFdCN0J2NisrWlh2R0JoT0lORE90YUozempv?=
 =?utf-8?B?Y0tGRHFKUDBLTFhjQVE0SDU3T0NHclJDam9wNWtnKzZjVy9sVmVhb2Y3RVZR?=
 =?utf-8?B?UzBaSllHU1JUSjFlRzFROU5EWmpkOGZZeTc1eDQ2ZGlnVU94UnJRUVNrZy9W?=
 =?utf-8?B?VW1peGErbkZhdnRSL3VzS3N1azN3OUcrZmtXMDMyOVpKRjhKMlhRZEZ3MTZX?=
 =?utf-8?B?NEt5ZkZwMjZsQmZrS2pwbHZvOFIwVGRFNGtQaFJCRGpITXJHTjVOeCt3WE5w?=
 =?utf-8?B?cDhFYVdLcjZpdm4vUlBHcnpQWmEya1VGdVBsdkZYVW1zc1FXbmpFanN6cC82?=
 =?utf-8?B?OVA1U1dtNnd1Z093NG82M0VFdVBZUHorUHZnVnZDRHlPMkVIbnJOMHlHZGhO?=
 =?utf-8?B?OXpPN0xHQTBmYnpsVzY0SDVqcnJET1NieDZOdmZXSThPVlVzTHdZTTFXUG1h?=
 =?utf-8?B?OWRNK3lSRm15TEdiakFrOEV5SWk5ak9jdC9tNm9IME5UNE5tZ2NQdm41bHNt?=
 =?utf-8?B?NE1CU29NbURQY0lVRzlvVWl6Smcva3l6ZkdlSkJjRXh1ZVdOQUwrQlBKY2Q2?=
 =?utf-8?B?eE0yU1hRaHQ1b29YRnJEc2R6SmVHMHpsZkxYcHg3eDhDUkpqRG9EUnFIeFJ4?=
 =?utf-8?B?ZWpOVU8zYSs5V1c2Z0tzWE5lTXIrYVBKWGFZdFBBU0hQdFk1SUpVd2g0RzEx?=
 =?utf-8?B?MGQrUWVrRHVEZXd4RGJZeGFzQytvcHZvT3NXSmVBd2Z1NzlhUG9BZmI1cklk?=
 =?utf-8?B?Mk5VLzVwYmVkN2l5MUVPdWhWRUlxRnAwTnBFVnB4cmhZd2JtL3dPYmpiQ3BO?=
 =?utf-8?B?a1QrTG9NUzlRR2ZIQzY2MXdubitRcS9VOTZGMUFhVkorNUQrY2JaSGhKV3Ax?=
 =?utf-8?B?Z1JQV3BsSUhHSllrTG1raGdWeTFCOFAvUklVWVFFUVUzbWN2dVFVMS9oQ0to?=
 =?utf-8?B?a25HYU1BTGZpZTZ0cE1Hcm9vb053N2I3WXNCVVdoN1lpd1ozZ2VqZUVqYkhw?=
 =?utf-8?B?eDIzTEdtN0h0Y24vVUsvWkRycVdHWU5ZbGI2SDhVT2Y1OFM2by9LS2NKUHp3?=
 =?utf-8?B?YzFieXZsbUM0TWcweTJXbWt1Qk1MVmp4U3JKWUJ3OGRYOUNueDgvVlQ5VHhs?=
 =?utf-8?B?QTllREJpdDZTTVViRlpHanJ2ZDl3SVFGcGI1bmhCR1MrcGlyK0hWSlRleFpq?=
 =?utf-8?B?K1l2aERISXNPdDgzZkJmclB2MkpmVmw1NWExUDVOYWNVdktiTXh4b3EwTzlN?=
 =?utf-8?B?Tll5cTY5QkJwclFvOFQ0N0tFSUtBOEV1djZockdldWgxQWF2Z2cxZUlFeXdU?=
 =?utf-8?B?NXFJdjZOajlwRnVLUm5JSDhabDV5NjFwRjZtUDBNSjZ3U2NUZEdiWTc1b2Nn?=
 =?utf-8?B?eml4WlhvS01DQXFRYW44bVVXa3o0NWtFVTBheXVyTkk5dTltZEZXeTJyN3pk?=
 =?utf-8?B?emJ5TWkzaFJCaVZ1a2JGeXFsRmRXR3RJSnJxaTRQZDdLZmkzTEpNZ1JqdHZF?=
 =?utf-8?Q?khsWTOCl6RIlK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJ3b0J1aXdaL09WRHBiSzM1ZDF1a2NvRGVTZyt4SnNtaVJOc3VCV3M0MCtR?=
 =?utf-8?B?SjRjK2EvKzJzK2xGU09pOG1aa0x5TFVZeTB5dmRzYlQ2aUp5dnlaVmNXOVYy?=
 =?utf-8?B?bjVleTcxU0ZDczYzVmE1NjkxVGpyQisvVFhkYlVkNEpEbXZySTV4MkRPendp?=
 =?utf-8?B?RmgyNG8xYTRNWGwveEFSaVZNVERMaFAvYUdQZmkveFM5ZXpyZGs4akRGeVF6?=
 =?utf-8?B?RStVZnZ5T0wyMitRRnM5aHdZTE5mMlJrR2NNTnNndEFJSzI4Tk5IWW93dTg4?=
 =?utf-8?B?WHYxTGwzeW5vRWtZZ2wwYXluL0ZFeXRudUV0RTBKQ3ZqQ3h2YXpIdndCWjNy?=
 =?utf-8?B?a0Fwc0pEZmVhNWN3SWVGbjR3R2h6UjI2c3gvQXdjaGd6a1hTeEpTc2pubzZO?=
 =?utf-8?B?YkpILy84V3NoWGpKQWlDcUFMR2lCZ1FBMU9SVy9VSEZGT1dnZTBWMGJ5NWw5?=
 =?utf-8?B?eXRhSXdEMVdUbUVySHdlOVlNT0ZtNHVTaVFjUDB5cnR3Nzhta3ZuQ1VnMlBC?=
 =?utf-8?B?WmdWTFpReHVtMVJJVFF2V0g0aTlmc2pYQUs5ZDZnN29IT0toUGxWdVZDUm8r?=
 =?utf-8?B?enpGK0VsajRjZWpTM1FCTWtEVFNvTkR2VUNsaWdNelEyc04yZTd3aEIzZXhX?=
 =?utf-8?B?dm9OZ2JlZHFiUUh5MmpaREIwQTJtOVl2SjA0RWZGWHlqWXJPbVlvV2JmdzdI?=
 =?utf-8?B?VFlSbFJWWURjaldEQUFQL0YwL3RzbldvVWpTd0NWajJDcG03ZVBCQzh1T1hV?=
 =?utf-8?B?ZUYrQ1VHTGFJcDlZb1dUS253VUtZKzJ5UUF5TklZNGFsVU5jQk4yM3FHVzJQ?=
 =?utf-8?B?U2ZzZDJnUVNNK3gwQWNFQXZidWVhVmZacXlLRTNrekJPZHlJVTJzRjQyeWJr?=
 =?utf-8?B?TndGL1RBbjJBWnMvYm9FTWxIUnkxR1ppaDE2YVRPcmQzYUFPS3pCeWo5WE9J?=
 =?utf-8?B?S3lMQlpxOWptaEtTOHIyS0dHcmJrSDhXN0F0N2JiOGF5d3dlL1pHWld1RHpN?=
 =?utf-8?B?aXdTb01XMEZySHZvS0Zwb3RScTBrSnhzd0Y2aGR1a1FsVXY4VndrcStXbUky?=
 =?utf-8?B?U2lrVE9sdFQrOWd5VkQwRHluNHNpQ29WWjBTc2J5YjFSMWhnbERlYURNNloy?=
 =?utf-8?B?azhzRE1lbWdUUUYvaFhSaDJuVytWK0poemVmVlRic1ppMXBlMkNaUVI5S2s2?=
 =?utf-8?B?c3ZVekJwbXRlb3RkUFVhVmRxVkpndytDSDdEWE1uOW41SW11ZXB3VTJURGlC?=
 =?utf-8?B?ejBhRFZTS1kzclZaZ2NjZ0JRTm1PNG02WkRuRlpiL0JWK1ZmQVJDVW9RU1Ns?=
 =?utf-8?B?TmcyVmtCZUdSTm1oenB2OHhSNVRYSjhGMmgxZW5ldEVSUDhpNWw4L2U4UStl?=
 =?utf-8?B?b01tK2R5YWhPTEx1VDVMejJNeTdIQWdueXE3THZ0b3lXSnY2OGZLTzdkTXBY?=
 =?utf-8?B?U2g4bHkxL0dWR21acnNOV3ZtcDNJa21lWkljQ2xZMjVibEE3WnRNM0JKYVYv?=
 =?utf-8?B?Y1hiZVZNd29qQzZhalMxUmw2NkxpaFlCUUVHQXJxK295T2U1SHl5QklZZFZy?=
 =?utf-8?B?YUphRzYwa0dwbzhkR2Y4VW1jR3p3NGdNY1l6ZGdnN01tZzFpTnIweFUzT25G?=
 =?utf-8?B?RjFaeTNaWVJ5SC9lRHRxMXNUdE1uQnBNMTl1SmszUkdzQXR0cTZiRS9FMkRK?=
 =?utf-8?B?aE1PZ0d6RUVaS1JlUTBHLy9yMXZVaGI1dG0wejkrb1pHdnVRRm1PV29Db0pN?=
 =?utf-8?B?dFJzZlMrUktjMUR1eXhsZGM5Qi9PeXBXOFhlOTBCVEt2WVFIVUtseGprSFpT?=
 =?utf-8?B?ZE5ncldJZGdQWm9LZ0tPeE9zMG1DZTNwTlFVTDJyS3B4Z2tLNjl3b3Q2Qzdy?=
 =?utf-8?B?M2w1bmxES2tJditueUFpb0ZqUXRZT0xiZVl0Y01OaXFjZXRKQm5aeUxBcGJN?=
 =?utf-8?B?NDhIbkd1V1VJUnIzMmJRY0FBVTh3c2RoRVVpVUF6TXUrYTlmZU1hQzNySUtH?=
 =?utf-8?B?SzVIbmlTRW5DdUN4U0M3K09jdHFXL09mZ1VGejhYZ3E1VjJ6ZnAzYm5MdHFS?=
 =?utf-8?B?WjBFR2J2ZEFna0dURUx4aDFFRExPaUVVdTNFZ1Z5QzA0cEFyWkF6QTZvaGUw?=
 =?utf-8?Q?TbQsYshe9rDuptzQ5jW9DnMoH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48df4d-5a20-4dea-8fd4-08dd75993a79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 05:58:33.1568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voZP9gEumhsFzDjLYhblB9Xv+VxMfgb63KMwJdWeKszTHUt09jQAIglI5oPyg5EqXa6zhyGU1pUnreSk7hHx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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

Ping ?

On 4/2/2025 5:41 PM, Sunil Khatri wrote:
> mes_userq_unmap could fail due to MES fw unable to
> unmap the queue and the return value needs is not
> to be ignored and handled on first step itself.
>
> Also queue->queue_active set to false in this function
> but only when the queue is removed successfully. If the
> queue is not removed successfully then dont change the active
> state of the queue.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b469b800119f..8f6c12a78f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -144,7 +144,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	return 0;
>   }
>   
> -static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>   			    struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_device *adev = uq_mgr->adev;
> @@ -159,9 +159,12 @@ static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>   	amdgpu_mes_unlock(&adev->mes);
> -	if (r)
> +	if (r) {
>   		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +		return r;
> +	}
>   	queue->queue_active = false;
> +	return 0;
>   }
>   
>   static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> @@ -345,7 +348,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   
>   	if (queue->queue_active)
> -		mes_userq_unmap(uq_mgr, queue);
> +		if (mes_userq_unmap(uq_mgr, queue))
> +			return;
>   
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
> @@ -358,10 +362,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
>   				   struct amdgpu_usermode_queue *queue)
>   {
> -	if (queue->queue_active) {
> -		mes_userq_unmap(uq_mgr, queue);
> -		queue->queue_active = false;
> -	}
> +	if (queue->queue_active)
> +		return mes_userq_unmap(uq_mgr, queue);
>   
>   	return 0;
>   }
