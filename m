Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91387F9B607
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3E710E9A5;
	Wed, 22 Apr 2026 10:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hfQ4C6g6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AFA10E9A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+ElfOmw7JsDvOrdhzZB0AgXsjHJzqziW9sQ2kd49c9azbchCvn4n5sBNBEPN1Kl+92G731mNOcdeJwHDO9d+HXRie5YtvuCqpjnoSmGlHJuVEijfDLnblF55K7Gt2pDIzhTJZL3p6TGUfbfVm1wocEy4kygUnDJnlkurTH1vdnxZEKmW+vzEYGNG0LkVDGT6o/BpW5FLTfNtuEcASav61gPbcPCbxj0pI8sscPeSMg2SzDyYdWR6AsvtCoYhkg8zWJLAUDxTA6WHdkIF8Yyg7QdVF73Zxb33W8BP914yAAVjCdnkhG2RHMX29HIZrSoDk+aZMB7oYmLMcVFBcbHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtQE0jBk2KTVxoXajzhaDRdJ4DOk4YUCqDINzj0X9Lg=;
 b=Dffc3SzzdULXoOg59S4AUAq/6TKr474ZjkJooKExROeY9K1L2vt5KY/3Z63wf3u0aYWHCZBy6l5Zf74DrzZh7jTVx2yBBkzkbND4cpUvmhwkc6tF8QUyX+Ex0bjkBejFr+NPbhoFV/yAy/KV/i/Gvqlenk6D9esrY4p3ZWij6eGPTGJQ6TTzNAYuGdeuO4Z5bj+efZHSxeAEbOXfObYP3I7NVnS/U5LdqYTqt+xLi/D+sT6oBOuCeoGARWTZaQH69zakcR15Etje743p6pRWUeosj+BryYX6jpxi2F+wNzqzrC6EaHqHwfeYYYCjtxkQGXdsWb7wjF5sAzYMWz4vOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtQE0jBk2KTVxoXajzhaDRdJ4DOk4YUCqDINzj0X9Lg=;
 b=hfQ4C6g6GqL6cOGHgITt62uZnEK+GLo1TTAQdTYdWzKnCrZRG+spEcI57EeqKjFeews2EDpGF8jq740g7IWZ0q2ViSTBEu18h8VHZCZiU2N6XAix4FnF8k7g/9+Jg4su0G29xnSMReeetjfiwGl4noRCNBswgwapCwQU4l56TIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DSWPR12MB999153.namprd12.prod.outlook.com (2603:10b6:8:36e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 10:16:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 10:16:15 +0000
Message-ID: <3e600910-dac6-4b01-a190-d2fc9a6637f0@amd.com>
Date: Wed, 22 Apr 2026 15:46:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/amdgpu: rework userq fence signal processing
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-5-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067EF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2b) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DSWPR12MB999153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de3d463-1906-450d-4d29-08dea0582ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tGCVUOVe1Q2hPRbvLeBVP8ahUNkWbtBfcfOkBGutuN2K5oJC8aIYAJYdLlltbRSr5AxNtO6MyVab38Jhz7K2cVl2LUTZwDn2kz26W1kL7WxxA1QBL3oAZPZTtS/l3dOqryk9yg+iuGL7xoDWQxeHDkct5YDAc0/LXETKYPLw9DL2YvwLLZrtbSgz+dWFMZdCrI/6Oib6NQ7YKjHBHtwguzvjdbpimzs/oRDrEB/gmwjTxu3G1f0IoeVmmA57LjQYAmKX2wS/tFdzAKNgATxpT6Z2/3WuzN167GMDVYCJq7i1vylt1RD4MGflV0BP20JjBXsjYBStqGhXzy1NXFA/6CmOa72BdnMvnK1JKG4qAYmhVlt7SpBfQgE2RxmFMTAkWYHEX7z8Qi8n3COfTgMT33agL3FkkffD5AVWZYAa2tZQd+yvKfu4nXSHUXFvwljShrrW/WJlNgzazt8hGUsktOp4oePuNzmxO2HTyPFyDmyFV8pYYTaH5FcwkUwEmUR0rHYV3+NNSEm+KHiXVsgWl+LgFDWT13Ieq60Sas5X5jw4xFdZlx2sbn5NKgghLasZlT/iGHXFIYiFlz+rdZNnIaRrQ88wr8GURUtf/wDgNgLtPq9WBZ1HiTEnC7cAhb0Bcu21sXLxnmu+UM3UkFPrO7Ihg5NlzL0Y04EXVImpCYLusP7Gsam7P2p47vTa8loT/nWcinFPzgSFXTA0RpsKL2gCcvN0DmXSG3Le3auJ/JQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHg3ZmpJbFp1azF2RWRGWWFFd2VUSVpzamhTcVFKcU9YM3A2aGc3eGVUMnZO?=
 =?utf-8?B?VE9pTWQxakRSN3lQOTlDMEttcVZaTkpOUzhXcVdueCtHRkhiWVJ3TCthazZN?=
 =?utf-8?B?UHgrWmZxZWxkV3J3QWc1cEJkQXZaK1NKRzZTZGp4aFZCbUFFZGU4NExMZmFW?=
 =?utf-8?B?ZVQzTmlZcjg5b0R0RXE2S2wwZ0pTNlNDdFZXbEZFTkZQcWJQbEVLRWtIQmZO?=
 =?utf-8?B?UGpvem42SkdrWCtoK0p4TjlRcGhuSFZZcXlDbVFqVUxYQXNsNUhCWFZVNXVV?=
 =?utf-8?B?S1JCci9FMkt2M3Z6TVF0ekFMK1NGd3N3aHIwQXM5OGRnYzJNNzRENEc1Qm92?=
 =?utf-8?B?TlJ3SjR4NWZqL0J2WG9vZGpTUWZPUzZ0dWx2TlRyVW5pa2JSaE5nSzNueG1a?=
 =?utf-8?B?dlNWdUZ6RDZsWi9samtHK0VHYzJUSWdpN1RnSVhPYXZRNWRZUzFtbVdqNG9O?=
 =?utf-8?B?Y0o1NzRKc1I0cGk3U0NVYlVPMVNHTXJRU29mVktlN2tHZDhmeVVrU3E2RVJz?=
 =?utf-8?B?VndLMXZOWnpEbVJkTVc0UFYydmgyWm9YL2E4dXFvNENCQzM0eStXVGZNdFpB?=
 =?utf-8?B?aGE4M3dzQ0p5RUJnS0paL25sU2VBWHk4NjJjVTBLcElsZXA4cFZRMHM5OVZ1?=
 =?utf-8?B?dHlYci90YlVZZG1pRmMzQW8xSm11eTJPYjR2WmZFTTE3SHhkcXlVazBVcnl6?=
 =?utf-8?B?TUdkT3lsam1BeTZWaW1kYllkS3FrOXVZam5uYzRqaVZ0UnBCK2RhRTAyUHlY?=
 =?utf-8?B?Uk5nNERORk1LdGZpR0ljcytvM0VabW82NDFYVGI0RDBDOHhJTm1IVGdOVkxk?=
 =?utf-8?B?MDFWcVdaYzFXUzRidVBEMlh6K205UmVsM21JelREVFl2NzRlYUtLVkhBK28r?=
 =?utf-8?B?MDN4Y3BFeGZXc3JtTFBPU3dUbmhkYjVnNHdTZ2ZMelJzdm44WEpHODI2R0I1?=
 =?utf-8?B?Tk9BZ09UK1hCZ2NGUUQzR1dhc2ZteVpTU0xBTCtmR2I0SmMwd09pajBqWW1X?=
 =?utf-8?B?cXdTMFRUVGE0OHhmYTkxR3BWYUZiNmppSnVqbktxU3JvTHU0Ky9xbDJ6RjYy?=
 =?utf-8?B?MGcyWjQzQjJkYU1vSTlRZmRwQ0dqdVlFS3RMTG16em8xWHZQRlJYc3MyMHRY?=
 =?utf-8?B?L1lpaWVGVC9lUmp3VTBPNm5MY21Mdy90UDhVVjkxOUtSZEFxQ05vTzA0bUho?=
 =?utf-8?B?NlB2TGpLdktEdi8wTFZUVnFTbnc4OWgzd1crMzBrWDB3MDcxSEZkbUtnRGxH?=
 =?utf-8?B?NFdoZ0RDdWFkWTUzWUlHbmEvalYrdm0zZ0hJTnc0c2dWd292eGRlNlpLYm1q?=
 =?utf-8?B?d3c4UW9xTFV2NkZZZktlUVN5azdDYS9mWWh2dEk1Y1NXYjBtVVVuMWFkN09H?=
 =?utf-8?B?Z1NVWDBCUzF4UTFYdDJQUmZYL3JLeVZHbFF5RG9GRjYyQ2ozM2t4cE1YeGcz?=
 =?utf-8?B?SGRMU2RPUy9VZTJCNlp6UHFNUSszSTVSVWM4Nm5JMzV1ZmxHdkovUmZSWVBn?=
 =?utf-8?B?MGErSCt6eUppejlUclZ3dmZkQmxrSmdiRDZtR2t1RVZaZk5EM2FobEdaa0JL?=
 =?utf-8?B?YmZ4aUF4UUVJalo4d0xONVpNRWxiT0RQd29GSmNmVVRONVVqTGJHbU1OOGZS?=
 =?utf-8?B?bmlOemgva1ZVNy9VZTVvZGpNU2RQTXMyZThQN01KUjhWK0dldWlwampRWllH?=
 =?utf-8?B?TXkvQ2NaV0xMU1VaS2Q5N3lGTDNuUnBNaUpzZXRzaWRFbkdIaFZ5VVhVZzRI?=
 =?utf-8?B?NWt0eVQyS0FBOHpGcFloVWxTTksrSUZkWWVSNHM5aStQdzN1aXNqcllkc000?=
 =?utf-8?B?UlNlVm5iN0FIZDRyejU3SzcvaXIwQVptellDNkdIc3NoczhNYVNkcjFIRjhB?=
 =?utf-8?B?ck1LWXBlbWVWY1BESTVJRVB1azJvL0RNQVE1RzV2WkFxVytpQlZqcG0zdGQ3?=
 =?utf-8?B?WlY4SE53VURja0dkcjczVXI4VVNVUjZHSU9Fc3VYcytjQ3VCU01sL2R1MGxM?=
 =?utf-8?B?emhyT1BqZkZXWGRidE9HVVdxM2haajEzRThnbUJ2Si9TVXZQaG1BYnBldmFu?=
 =?utf-8?B?Ym5hbVJiY1hiaEczN0VuZ3RuVk5lUUlxZktVQWFJU0dVYis0ZFA4aG84VS9a?=
 =?utf-8?B?aEg2MzI1SWNyWDRndEdlTVJJVWZXTm54dHFHRXNuSFRLeW9DRHBrV1llOHJl?=
 =?utf-8?B?TmIxVTloRUJaaThjcTFGMGhDbGlXN1ZyVWt4aGZyak9ub1R6aCt1YU5FZlk1?=
 =?utf-8?B?S2lnU0FqWmp1MlNtZGtFSHl1cjcrbGNqNjBjUm9Cdk5BcWRBSXZjV2ZxRjBC?=
 =?utf-8?B?NGxaWU9RUzByMU81SS93eFJpUGhQQ2M5RWZZRDM2UWcwRmxpSmR0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de3d463-1906-450d-4d29-08dea0582ff6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:16:15.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqCuLHDGXAxqnte5qAX0oBIyokM27XROS3nHxuMK2p4Js5oAxA+fQTXVC1TQ3QikpOfESbF4DiUjd4ZBjM2A6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999153
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 21-04-2026 06:25 pm, Christian König wrote:
> Move more code into a common userq function.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    | 11 +----------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    | 11 +----------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    | 11 +----------
>   7 files changed, 19 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 174190a77005..8ce001481d42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -205,6 +205,19 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>   		     msecs_to_jiffies(timeout_ms));
>   }
>   
> +void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
> +{
> +	struct xarray *xa = &adev->userq_doorbell_xa;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long flags;
> +
> +	xa_lock_irqsave(xa, flags);
> +	queue = xa_load(xa, doorbell);
> +	if (queue)
> +		amdgpu_userq_fence_driver_process(queue->fence_drv);
> +	xa_unlock_irqrestore(xa, flags);
> +}
> +
>   static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
>   {
>   	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index cb92789c1ed1..843ea8ecc5d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -168,6 +168,7 @@ void amdgpu_userq_reset_work(struct work_struct *work);
>   void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
>   int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
>   void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
> +void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
>   
>   int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>   				   struct amdgpu_usermode_queue *queue,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 837d98947958..1ffbb5450f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6528,15 +6528,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>   	DRM_DEBUG("IH: CP EOP\n");
>   
>   	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_usermode_queue *queue;
> -		struct xarray *xa = &adev->userq_doorbell_xa;
> -		unsigned long flags;
> -
> -		xa_lock_irqsave(xa, flags);
> -		queue = xa_load(xa, doorbell_offset);
> -		if (queue)
> -			amdgpu_userq_fence_driver_process(queue->fence_drv);
> -		xa_unlock_irqrestore(xa, flags);
> +		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 60f0c7d6a7a3..6baac533a2e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4859,15 +4859,7 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
>   	DRM_DEBUG("IH: CP EOP\n");
>   
>   	if (adev->enable_mes && doorbell_offset) {
> -		struct xarray *xa = &adev->userq_doorbell_xa;
> -		struct amdgpu_usermode_queue *queue;
> -		unsigned long flags;
> -
> -		xa_lock_irqsave(xa, flags);
> -		queue = xa_load(xa, doorbell_offset);
> -		if (queue)
> -			amdgpu_userq_fence_driver_process(queue->fence_drv);
> -		xa_unlock_irqrestore(xa, flags);
> +		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 948758b51b5c..ae65412109c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3654,16 +3654,7 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
>   	DRM_DEBUG("IH: CP EOP\n");
>   
>   	if (adev->enable_mes && doorbell_offset) {
> -		struct xarray *xa = &adev->userq_doorbell_xa;
> -		struct amdgpu_usermode_queue *queue;
> -		unsigned long flags;
> -
> -		xa_lock_irqsave(xa, flags);
> -		queue = xa_load(xa, doorbell_offset);
> -		if (queue)
> -			amdgpu_userq_fence_driver_process(queue->fence_drv);
> -
> -		xa_unlock_irqrestore(xa, flags);
> +		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index de329b76a00c..bf09ac841a68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1662,17 +1662,8 @@ static int sdma_v6_0_process_fence_irq(struct amdgpu_device *adev,
>   	u32 doorbell_offset = entry->src_data[0];
>   
>   	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_usermode_queue *queue;
> -		struct xarray *xa = &adev->userq_doorbell_xa;
> -		unsigned long flags;
> -
>   		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
> -
> -		xa_lock_irqsave(xa, flags);
> -		queue = xa_load(xa, doorbell_offset);
> -		if (queue)
> -			amdgpu_userq_fence_driver_process(queue->fence_drv);
> -		xa_unlock_irqrestore(xa, flags);
> +		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 85d98a0e1bff..f154b68dda70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1594,17 +1594,8 @@ static int sdma_v7_0_process_fence_irq(struct amdgpu_device *adev,
>   	u32 doorbell_offset = entry->src_data[0];
>   
>   	if (adev->enable_mes && doorbell_offset) {
> -		struct xarray *xa = &adev->userq_doorbell_xa;
> -		struct amdgpu_usermode_queue *queue;
> -		unsigned long flags;
> -
>   		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
> -
> -		xa_lock_irqsave(xa, flags);
> -		queue = xa_load(xa, doorbell_offset);
> -		if (queue)
> -			amdgpu_userq_fence_driver_process(queue->fence_drv);
> -		xa_unlock_irqrestore(xa, flags);
> +		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
>   	}
>   
>   	return 0;
