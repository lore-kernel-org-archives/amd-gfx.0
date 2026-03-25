Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B7F103A99F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 03:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF6D10E6C3;
	Wed, 25 Mar 2026 03:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3N7PMTh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29A810E6C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 03:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvpaBSAijPjH8JRlzQlKu+autpCvpN6R5zqFX1aijwtOkbA68dPYDibsmDv54pG27mdQVrxsbgU2+h/XSm+krQ10rSlgDmLmAAZoPLZhI16J14h7tkP6gNQoqvh7uEZJ81FJ+D3AuZrV0N20/HQrfWKSZc9o1PRZyG0+yHv2xYWkBhL/oLmGnnWliBImB7GKaTt6TTDZoZqW2NLmZu7FjauY9fkTEZSozBHBaMZAFdHmI6Vd1PjzvX8Peq2jqEkyVbuGlI01+yXkx8WOmwgba9JIXRY2GqfOHnaj2pwf/ueUo8b29ascGR8O1tZ7i95j0cAF4DlmHAkeVmhYp6OZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOTweHlkTNPuiYVaxovpdH/lUJWqfhr+pyoY+4rDYdY=;
 b=dQHsAEqi+63A8qMOfJK9ecHDXwpIgoYFOsr/9kGgZLLrikG1l357ODbwHWbl9MYpW5tOLl3D+ULutGx5s0MsIZBRUQvBTcGiVHP4Jhhf2rOo0nyzUCULdws5gFT0b2SK4jipSU0ei9cWWSHM0QqJPKoQzjHWzq8Yg98qiTcrPCZRNfKwYeqrcNcXKwU1boZU/Jo8BNS4SBEVcB6rYPsmPhI4502MvU7XyD2+OhSe2t41elQ4pSqwnJbFRUTDeGontuzr+1E96l1R1+YeARyc5CDRw+M4sZvyWAR6KJ2DTx6BQEgtJucdpt/pIwNqyYMm4/QTSORlkrnC46mVfI6b+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOTweHlkTNPuiYVaxovpdH/lUJWqfhr+pyoY+4rDYdY=;
 b=B3N7PMThH1KNAWQVzs11rlP+3hqUXcL2U14qjHYQVa0w2po3EwLwwBnIe6BagMi7SO7G+5zRgsj51uvh1IbSWh/aEnWJUtSBQdEFwF5nBBlvwJ7F8HKBafdzGmeQ3eBLwaG/g/2sBCbj2pu9C4Z72dpwI+hEZxVo7hB0GtvrDAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 03:00:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 03:00:41 +0000
Message-ID: <6d7390fb-e609-47f2-a40a-371c15ce54f2@amd.com>
Date: Tue, 24 Mar 2026 23:00:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 6/6] drm/amdkfd: Fix queue
 preemption/eviction failures by aligning control stack size to GPU page size
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <9b5d3040f6ce7d99be2c656f68055c8c7529b34a.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <9b5d3040f6ce7d99be2c656f68055c8c7529b34a.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b067514-4263-4761-b0f1-08de8a1ab31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: MYaa/4W0zJEF4rn9CVL+cvwhduZyNHiuIFW2+u2lS60P84QOZ+5CMMZv0FgUYOV9dUZvgy+R4ob7Hlog1KAKn355CVsVyywh058oeoN/k7PGe1+g9RuPCMrCq7oXrH80wLjeTR/irfHco2dfSr2VKW5uhD11smTZM+J5sV2NqJKsyyelMZvFCqzS/hpzQlDRYLV880wnZKcVKuy6rr1yLDwiuVVUSK8bce/l6wYF/vStDoCYvxTZy2l2tEc40tSP+tgN1M58xaTW7vSpNGGdsy5kO52SJyezyqED16oPV+U7WBmWfgcihu5mg/BscV/NtNUU5YDkvZ/mZbpyM3+rbiMQRaranugXKLv01geA4Ar8CrUfJ/8TbCG/kuA5cU4RF1fW+i762GHCp/x2rkJjuTSnIPcmBdTXgbdz8TMOyePZqyQSAtGkzR3W3lnIV6Om1GqfQy7JcEUPYF3lJbEsoasQw744k4mKNW+gcJJ5PvkRdR8eCsC+reBSDjFz/EIQoPJdoU2urqyYViDyLRMOGNMYaFLUpyDGx14TcgYTFZ6i23Wu0WtLMAGKKHI+PZVIk6IcDM9CPtViiw6qeB2VzeUZnbWyjaB8KVWhB6OqeEXqKK4PUMij/PzEF92tTNyhxQo3lWt4uMq4zp7kwEez89ZQQkOyWorz7IuVLM/0r4771DVhOHcXLsIv1t8qnLQoKN8vxybrh5NaoyYIUEv2PVxFqSAcG7xGYZ/Ncw9k5Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFUdlJHL1pGZVc1TnVZNDU4L1JpN2ZiQm81MmJhNUpOSC9sL001cDZnMlpF?=
 =?utf-8?B?bU1jaytBSEU3SXFFb3F6aEMwOXhVTlRuYWVnK2dTakFkelFsdUdmMVdCKzdX?=
 =?utf-8?B?dnkrdWZIc0F3K3VLSjl4YUhiYmtxVzRWZXNNSDBSTHNtYnVwdVlFZnR6ODY2?=
 =?utf-8?B?Q2pKZlFlakd4TmZZSE1HUEl0aC91RFY5dU52OXpIRzhnZmhsRFQrSms2TkRK?=
 =?utf-8?B?MmhQWVY0UEVBSDljOEViWXJNekdlNDJOMFVwbWJMUXpBQ3pKbU9xcTR0a0J2?=
 =?utf-8?B?Ym5VclY4OHN1c2gvR2c0QWVHcGFKenUzWm00WmdBREowY0RGWFhZSFE3VmhS?=
 =?utf-8?B?SmNvTisrMXJrZXJGUkFvR2VTUHVqZkJBWXlkNDN5MGl6dm5Td2RNSUhTUVhP?=
 =?utf-8?B?dExqa1NCQkw0U3kzY2hNOW5NOXJwN0Y5RkFYSkRoOVd2UHZ2Zmo3QUhjVml5?=
 =?utf-8?B?ejQ1ZFdpc0lkT2hVTWFpVlVhV1JqOENoYktNczNZdFRtdTJQbHNCQ29aZmt0?=
 =?utf-8?B?REJ6Tkc2VU0ySDRQc01lMEdhTTRLUWFlUGFFeTBmNEQ3dzFJRklDdjlCazF6?=
 =?utf-8?B?NTM1RzIzZkUzeDJGOUtidmJYRnM5N1o1dGx5OUh1QUJBZ1ZweHdhVTBMaUZD?=
 =?utf-8?B?SVF3Z3JPZ0VDSitNdGphRU5KMEhYZG9mU3hoOHZwaFg5R2FkODZzT0ZqT01N?=
 =?utf-8?B?aFp3eXJqMGYxMFliTWFhK1Y2OEl1dCsybmFSWk5BWC9RanFVam1kOVc3clJP?=
 =?utf-8?B?eHlSU0pyZ0lqUXZXaEVXWEMwUXlOUXc3SllWM01jWElGdXQza0krRnZNUWQ3?=
 =?utf-8?B?cDhoazFCenE5MnIyMGdQQ0wveUxYNHEvOXBtN0lUUDVrQThMRkhvQmhqM2pD?=
 =?utf-8?B?dHlXRjBQeTdpWjEvK2J1amZ4OFB4RTNTT2hZOFVjYzk5UGIyVHZvQk9xSE1M?=
 =?utf-8?B?cURQSnFnQjVVbTBqRkpIWnZGLzg2Wm02NUhjTDA5THBqdzdVWG1zemFUOHVC?=
 =?utf-8?B?S0ZoaXJ6a200Y0RBN2ZSUFNPd2c0ZXNUdVVVSklGRVhZdWtpd1RhSTBjd2VQ?=
 =?utf-8?B?QThJNWE3TWxyazVSb2ZNd29PbUpiSEhFcGowYWRLMkxFTXZhWWM1a1FuZ2Rk?=
 =?utf-8?B?MC9iRFRSaTVhTDNDY0JxbDFQbTM4Q21LQlNyMWlZbmtBeTBiUnJ4aVR3T1Ry?=
 =?utf-8?B?SkFrSmpveWJDcCtBRzVOKysvenBaL3pSYlZmd09jK05YZWpsYmRmMkNvUFEz?=
 =?utf-8?B?Yk03dDdvUVRiaG91QU54THM4Uy90aXI4MTRSVkw2SWpWbjNuRlF4VlR1c0ZK?=
 =?utf-8?B?SjVobk1WdzRMSjAvWU5sTWhUaHBSZG9LSlAvZlhCd3poVWZyR1Q0WFRxNUZU?=
 =?utf-8?B?d0E4clRwcENINUI2bW9LbHYweFlqcTRtRjZuQTQ5aWdnSXZsMnFCaWlrdDkw?=
 =?utf-8?B?bm1ab3U5UW0yR3RIYlVCekc5Vi83TDBidjdxQnFYeVVXZVdyeDJnQ2xIM1l3?=
 =?utf-8?B?UUl3TnIrdFRKcXdZSU9jWHpJVyt6Nno2OUlGbXV3Z0ZleHJyTW5ZSC9sTGlU?=
 =?utf-8?B?ZXpCU20rc1pxWklPUnhYWHR0ZFlKRUtTZVkvRFFMT1dNTFNHVTFjUHBxUzRT?=
 =?utf-8?B?YWRTSlhFbjlXR2FNS3FJNCtseUNqaUV0VS9iZDlUdjFNaTlTNU05RnNhbWQ5?=
 =?utf-8?B?NGM0V2JpdFAxRzlUSUdYMUtKWmxreXNxdHZFMmxtWjlkM1lQQUdUS21CNFhJ?=
 =?utf-8?B?S2I4U0lra2h2M280SGFzYldCZEFDQ0phbzBIMzdKTzl5TmR0TU1nK0lZN0Vo?=
 =?utf-8?B?NGxoY1l2NGZ3aXZBVlphNGNYeXBtKzZFcFoxdnZQemJ3YWlkTkNOTUhkZWNp?=
 =?utf-8?B?UXBjR2QxbWhXeW9wWVdkcjU1WFMyVWtlVkxPRnkyK2ZydE1POEpwNUo5dU43?=
 =?utf-8?B?SWlDRXhmTUFwbElLQmJmd0lCNTNvKzMyWDNLVnl2MDRpL0VmU0luazV4aUlG?=
 =?utf-8?B?aTZlTUE3VVZMRW5sc3RxdzFoTXRtdENiVEZuZEU0cktkTlJ0V2F6OG1vTFJ2?=
 =?utf-8?B?VzRqOTRSZ0l0THNTR0dmM0RUQVUvNnNwZ0daQWt1b3BkaTRlRVlyMTlOU01l?=
 =?utf-8?B?LzFTV3o3RFRrY1N5Q3dCTkJ5VXR5c3VuOTNUbHhEaThJc0VOT01VSGtkWVpZ?=
 =?utf-8?B?UHo0WnlwZHFIaUZKTXg3Rk14UkJLZlZ5aWcrRlNKTGJkZjhqVU13NGhmQmlQ?=
 =?utf-8?B?NUNVM2gwUWZsN2loaHNGZGhiNGRObFRTeDU2aFcvcncrMGN2VDdKQ2p1SDlm?=
 =?utf-8?B?YmVaNVhFclN3TWYvRTV6VFVKck5jY29RMmRMVWY0L282N3FERFA1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b067514-4263-4761-b0f1-08de8a1ab31c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 03:00:41.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q/nWL+bf+aW1G6o+k2gefjyIK92XnJa1PpLNXpiompy1HNQaB0j9sTyvumLp31B765yNGu/RG/oASUrAI2yjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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


On 2026-03-23 00:28, Donet Tom wrote:
> The control stack size is calculated based on the number of CUs and
> waves, and is then aligned to PAGE_SIZE. When the resulting control
> stack size is aligned to 64 KB, GPU hangs and queue preemption
> failures are observed while running RCCL unit tests on systems with
> more than two GPUs.
>
> amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
> doorbell_id: 80030008
> amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
> amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
> amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
> doorbell_id: 80030008
> amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
> amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues
>
> This issue is observed on both 4 KB and 64 KB system page-size
> configurations.
>
> This patch fixes the issue by aligning the control stack size to
> AMDGPU_GPU_PAGE_SIZE instead of PAGE_SIZE, so the control stack size
> will not be 64 KB on systems with a 64 KB page size and queue
> preemption works correctly.
>
> Additionally, In the current code, wg_data_size is aligned to PAGE_SIZE,
> which can waste memory if the system page size is large. In this patch,
> wg_data_size is aligned to AMDGPU_GPU_PAGE_SIZE. The cwsr_size, calculated
> from wg_data_size and the control stack size, is aligned to PAGE_SIZE.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 572b21e39e83..9d4838461168 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -492,10 +492,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>   	cu_num = props->simd_count / props->simd_per_cu / NUM_XCC(dev->gpu->xcc_mask);
>   	wave_num = get_num_waves(props, gfxv, cu_num);
>   
> -	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
> +	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
> +				AMDGPU_GPU_PAGE_SIZE);
>   	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
>   	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
> -			       PAGE_SIZE);
> +			       AMDGPU_GPU_PAGE_SIZE);
>   
>   	if ((gfxv / 10000 * 10000) == 100000) {
>   		/* HW design limits control stack size to 0x7000.
> @@ -507,7 +508,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>   
>   	props->ctl_stack_size = ctl_stack_size;
>   	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
> -	props->cwsr_size = ctl_stack_size + wg_data_size;
> +	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
>   
>   	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
>   		props->eop_buffer_size = 0x8000;
