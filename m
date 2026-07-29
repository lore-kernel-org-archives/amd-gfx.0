Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268CFC54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 12:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35B810EBBD;
	Wed, 29 Jul 2026 12:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw0r4gso";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB80810EBBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 12:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE+JqLfnycw35xOjr1dk2aIRWTgmtOiqAlS4uFxMpydHaYo1tnNR5QIraPuwKpqOsgXBWSgBS1F/waeTo9X50Ohb7oeaK/VIFVKjTlReYbgVDszBO5tYsiRTZ5rPetTa7VBWsNBKIhtbOaOWGg79wYu8JUJaxVW6oxEy3DXBZ8jnz4mZenfJsk02elBxWQoONgfrD2rjyXp9da1+k8ICtIveoe0J8ppehKMcOyAI1Vzg+e/SKf3QPFNKcI4m7JMye3jbhd0wwTiRE03dmKwHK9KmpPa2eaXHsvgp7NPmZKs3QFBSlGIjG/D9VGlgs4JF7wzumwsArF4InpDWBNSOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJShawaYkSQH0qOl9uSmeIEmz8p5QEYUHj2b/E41doA=;
 b=yDm33Y3+ND4pEI+Tii5Ti+/g2I6hMClDWiYDWRMmaP2qhgK5FqTq8B1MlYF12g4LYgqnup7v4P5SnqibMHHa11Cuh/yeliJjBoHYUAgeNgwx8rMUiW/JIyKBDRCT5tYz62L1da7ruOH27vfHk4CdIgARB9eKhVUtUfot3P7RHM3a8XDX9ahPS3q/J7MN1q8mYLrARNNNqXLV1NKnk6Jn3mzAFwc2u3GO7JA5+khMt+D5mThmsh0HJt0cr+O6zNFYCfQmlMnV087ATa7tBJaaN4TV95d20kEokdH1u/0CGU5l1ZcrSyg4+kvngZWZkIXX2Gttc2NpdIjj9czllgPbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJShawaYkSQH0qOl9uSmeIEmz8p5QEYUHj2b/E41doA=;
 b=Qw0r4gsovTg/DprK5zH5GMfN0/MNtrWLvcvC9IpoBmctOqoGEsVcGKLzCNJL9l6fNQGjKCkWdhDq3VrvQxokcyBl5+vvRVJjEbrj66b3z5Mtrz3P+pHKkjhe0ePDexq7HG4LYqh7sV3nj/t5zZLYImztLEqw9uIShyV16taGWw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SAWPR12MB999117.namprd12.prod.outlook.com (2603:10b6:806:4e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:03:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:03:02 +0000
Message-ID: <91060727-86e9-4794-b031-9325bdf1163a@amd.com>
Date: Wed, 29 Jul 2026 17:32:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use virtual alloc during coredump
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20260729075018.1547054-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260729075018.1547054-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SAWPR12MB999117:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a4c093-4ab7-4e64-5417-08deed69574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C9PUD/Mn+XEFdu3u7qfadxTDxywjEgmEXXPhOyE8CfVK+CpH8CSJPJcVloNr6Q9KS98OtYdPA1ynzXPsaawZtPZCOuNeQNkmxlSHZIsI/FmjAIr9CHtJtJUz9rIXPbqnTo5iOHq2wkoA2vnIlO7Orw5DQFs277iWBvCwSxDX8l7s5pnKpBNgRxneMJgU4Cbk6jBwROTnYrwOffocuUsVTgZ0mcKhE/46PmdGtN50ApxkLSxCSjob+ffwndPv+xEH7bZlmIa7K31pbbvOuxnyZvgRsatADxQq0fESjjdeqm9fUn7Nz9WLOOox0riLNUH1EmQ5WRmxcJst92f4SpNPmG6lH34TCo0dYTkSR0t+dw7MNDgky3c1UHKSV2mHwyR5Z23OePeDDu5sGYWY5YGeN/dzocwSSnVylRBjFrBtNyUVHNfx2FirOqVwJAGW/NDfDJ24Q+BaSNyvzitePewJ0bEJZn/3WQiXNB11nqwlF7HudtyBu0QBoZ8cwtYs2r3g+msgTl5sen2DYS6QeqGhy/GZHfwFGTjmOIQ/wJ93i7dyuXtuPB8Ycpsfkjc46rRYHj56YRnAuNeFnHDoEeOAWrp39Hk7LO5jzJg06nKUaCUHmhoK7SrDF8dZ1dFFxjXDojtQrvNuIa82d5fd5gcddpA+RSeOBGWTdCruO+VhwjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNNWEk5eHl3a1k2VThzOWZvQ25TTjExRXZyZFhrR3EvdXI3d2hvd1RqMC9k?=
 =?utf-8?B?VmFHWW41ZmExYlRhbUZic0lyRW5OT3I1SERnTlh0d2lIc24weHBwOUJ0VWJG?=
 =?utf-8?B?U1NjeTVodms4YmVnUzN2azdRTDI2RWFqeFE5dlgzQmM5dWgyb0RkeFU0SXlU?=
 =?utf-8?B?cUI2K2wrVTI4TFg3TDBXS0s0YWNySGcxbjJzbnJuVWU2TjNqZTVzbFptb292?=
 =?utf-8?B?RUtqc2pxNlZ3VWF0UGx5VnEvais2TzBqbDViemFHNTdHZTVaZW42WFJtT1Zx?=
 =?utf-8?B?d2grakw1MllmVmJCLzIycVRLTHYvLzNmRWtDNGp3eDZhT0R2NVZleXc5endp?=
 =?utf-8?B?aTdJdTRRR08yV3U3Ri9qZEVwQ3RIL0FWOUZRRmhKRWh4U1M2b1ZWYWpvbkc2?=
 =?utf-8?B?NnNVblM5cVZtV0p6SjhRR0kwd1FJOXBhMUtnekRaUzY4KzJTYjBNTTZYK1lt?=
 =?utf-8?B?dzVabWg3S0FVZjlmVGh5bUEvTTZkZUpyMkRuM0pSNE5KdXdNYWNNSjkvdXdL?=
 =?utf-8?B?MzIvWDlDM1hDdDFBYzFjUExrcG5jL2FZNDRHMzUwUjI3dldZM0tGVEZwQW9y?=
 =?utf-8?B?VFYxZ21aRTgwS3dKWldvdTdaY3JvQWpoRUNnK0dXTlBTd2RZQTZJOVh0cWxw?=
 =?utf-8?B?bXNjZVdlU25ZenZWdFVIL01Oc21DN3hKekUzNnJ3V01HT1V2VXNJbE4vUE1s?=
 =?utf-8?B?b2V3WlNJMTlRRGNGSTFwN0t1blBWbnM1V0t2OGdoMXl1ODZhaEFjbTRaOUVN?=
 =?utf-8?B?S2pkc0xYSWh0YVlTeFNJV0JRS09aQU9FT3BOWWlqWGluNUtoY0paOFB5REFL?=
 =?utf-8?B?cUF1U1RzYmVHa0xUU1QrMFNiOTdNTkhQb0x4dERVSzJUV1IxWTRrZUVhOTJr?=
 =?utf-8?B?R3UwR3hsdEdCL3dXRlkyWlhuLzN5NFpOK1h5dlBTS1RYaXlWRnFwQm1DNmVH?=
 =?utf-8?B?Skd3cXUrc29NS3lGZzd3aWl3NERnNHNIcmlJQWd2ZGUxVllZN0RpSUVRTDZF?=
 =?utf-8?B?cWhOMWJiWllSQXdkUXp3czhKYkpyaGtCbVRyUHVRQ053SFFMRm5uY3JHZVI3?=
 =?utf-8?B?cFRnOXExR285MDVleHh0MTVseXdKcTlINXE5RjFHL2hQU0ZNMVZraVFCVTln?=
 =?utf-8?B?bHFGdEYzNjdRNEJHMmU3UXlsa2hwSlQ2c2RuMEFaOHVzZ2lqRmxEN3dTUU44?=
 =?utf-8?B?U0lBU3NZbXJqREJvR1liN1pzUnJwNXlpeldEV1RyclJoTTBKWkhXTXNGS1lO?=
 =?utf-8?B?R1FUd1BKSG5ZbXVReU9JeDJnSUxFdlJvMytFZ044ZDJhQlNkNW9ZelVOdDNO?=
 =?utf-8?B?dTNDOTUrT1BmbWtFbVpuQ2pLeEMvRmhkeDYrRElWL25wVWFTSCt4dzBGbGZq?=
 =?utf-8?B?OCtRZDRaY1ZaVzVhbGhpQ2FXelgyUnp6cDBsMlc4YTl5d2NlMUd1emVCZXQ1?=
 =?utf-8?B?UlBubkxUVDA0elF5WXpJdWxIUG9tYjlsSXRFNklsdnlaaURGZk11WHEwbDJB?=
 =?utf-8?B?VW01YVpFUzhTRXhEYUcxWDZlcmV0VVVnREpKMEhJMWxKanY5ODZpMDFVdjRD?=
 =?utf-8?B?WlM5VTRQTE9KZWNoYURzN200ZXRqMklxSFBUM3g3cjVNbnV6RWFqK0M1dlNL?=
 =?utf-8?B?NUQ0Sk9pdDFvM0tQcEVtdG9oYlFmdFhad3YxdnZQbERDcm51OGVSbzZTNFhZ?=
 =?utf-8?B?dHp1QjIyaGdBb1RyTng0SytDKzRML3RTVURUTUxYdTU0M1lJclFPNzBWeStn?=
 =?utf-8?B?Q09wMmdDaU9wZE5NOUFDeW9aYURNdWZuRHRTMHpKZVUyY1Z2Nm13VlNtWTBo?=
 =?utf-8?B?Q3E1dmR0V1owMnRxTENTZVFsK3dOcFhLOFBGQzlId1pWakxiaUp4ak5iZ2JG?=
 =?utf-8?B?dWNHMEZWZi9ZYWo2NEZXeFhNME5YL0tQY0V2d2xpaGZxNTc0dHRKOHVXcnAw?=
 =?utf-8?B?c2pLU2NWN01zT2pxeTNFUzRLczZMTEpabk0xdko1S01iTC91MWd2WkhrOEt4?=
 =?utf-8?B?ckJmVi9sWDJDRjhmUHRhNGJ1ZzBoSytnOFVRZ0NPcGlQckhhUEtjSmpKWmNV?=
 =?utf-8?B?UWVWWjJnQVdKRzdyWW1DVTlFSlhrb1BGcDZnUmNyYTkxMXV5cDdoSkh2ZmY4?=
 =?utf-8?B?UGZIQTNnU3o2WmRlZVFDZFUwNE0rdWRRekxUYUljdTdsNkhOZGR5NUpPTFpl?=
 =?utf-8?B?djdMU0l4SWJnVnd4RDlXdGhGWUFTWUYxYTRSVVBVd2oxR25VTXdRMlU0elFN?=
 =?utf-8?B?ckJ3OHBnYnBuc2l6c1B0Yy9KanFCcmdZNmNKdTc1cEppZEY4M25xR3NZZTA0?=
 =?utf-8?B?a2hFWVFXcldNSTBoKzY0blFaR3lYMUVhOVNWOFU0SHg0aE81WjZTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a4c093-4ab7-4e64-5417-08deed69574d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:03:02.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDxuF5n1xmYYyARE5gluSIUcQaFkGTZUzUFwpp/lDkkCG/zJZsUAUNIaMZAkop3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999117
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


Please ignore this. This is a followup patch to
"drm/amdgpu: Use virtual alloc during coredump".

Have sent both together for better context.

Thanks,
Lijo

On 29-Jul-26 1:20 PM, Lijo Lazar wrote:
> The number of rings with outstanding fences can be large, requiring a
> bigger allocation. Such allocations don't need to be physically
> contiguous, so use kvzalloc/kvcalloc which fall back to vmalloc when
> contiguous memory isn't available. This also matches the existing
> kvfree used to free these allocations.
> 
> Also guard the allocation with ring_count to avoid passing 0 size to
> allocation routines.
> 
> Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the device")
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 39b2a4c0e011..4dfea36997d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -554,7 +554,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>   	if (job && job->pasid)
>   		size += sizeof(struct amdgpu_coredump_ib_info) * job->num_ibs;
>   
> -	coredump = kzalloc(size, GFP_NOWAIT);
> +	coredump = kvzalloc(size, GFP_NOWAIT);
>   	if (!coredump)
>   		return;
>   
> @@ -597,8 +597,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>   		total_ring_size += ring->ring_size;
>   		ring_count++;
>   	}
> -	coredump->rings_dw = kzalloc(total_ring_size, GFP_NOWAIT);
> -	coredump->rings = kcalloc(ring_count, sizeof(struct amdgpu_coredump_ring), GFP_NOWAIT);
> +	if (ring_count) {
> +		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
> +		coredump->rings = kvcalloc(ring_count,
> +					   sizeof(struct amdgpu_coredump_ring),
> +					   GFP_NOWAIT);
> +	}
>   	if (coredump->rings && coredump->rings_dw) {
>   		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
>   			ring = adev->rings[i];

