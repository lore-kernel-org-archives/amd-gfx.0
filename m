Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F1C5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 16:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D4710F083;
	Wed, 12 Aug 2026 16:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ahq33ZZR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1853410F083
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 16:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXW7n1SxcduudlAVIYDQn5I2Eg2bx0vhA9Q7bA1mIdkzjFYnGJXQRFAHuhdw1sz2SyDTZVdIvaZVklGGCuKbyEwTudy5Yp4SPXeOkZMK32U79nTtziPjLCR43pRxrc3LbGfpoUNuoswKY0Be480FLV/xCTTnNV7Q2K47PLjAoBhb40tEu2YHQZPUPhX1g2Pe1xyuN+qhVxVQGEWUtzxZyUTSbvm+S6ckbIPn5yQ6E+NULtWXbM7U0jvzyPT66gTm/4Lv/DGbbpcdcm2Xht6fHDD+CM/ulEocRonnJUVNbkRiiOrzbZB4rsyWB9q7t14xlVB9Yb3bXg0Vb1GAxcR34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFcOu0+A8/mbW2Cwt0eZcC2ZXweV2XVeJSpEgdw+wJs=;
 b=NNdsOrWJlwtmwSfLYXebmwy8Xa4kv/ufkv/wjQ9c3X04+yo14oi+AXYY8N3HFlGamzWKCPsOlTcJnnWUMc0a/70WeLVo1eh7sxTiSFm6g3KepPJvHUc+6q2CcoKrMrcjBXrE1oM27CS+EKP6k10KDMYHZOS5BD9FCXL0u4dyyfF8hi4FIOpXX/+zg5Xx60FJup5SlxND+yb/G5C0VDOFBZ0Ouuh+/mTDo+z9+1YvRzSrWrPXV2LEfkA7ZlKKHI/mAdPd2ED5qVYyyTIMOKuOOu0BmAMBSyLtwGXGfZioJR9lLTDDR1gjPTlfe0BECM5/3cWHfXZMRTZEUFLxHZN3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFcOu0+A8/mbW2Cwt0eZcC2ZXweV2XVeJSpEgdw+wJs=;
 b=ahq33ZZROkpl/yG4rWDE1vu1OKfhaF0JU/95v0bPUu9C5+a2gBWbFDGl7BWuEQrweeWND6FTKaMA2UkYPhFU6gfOsbBSqQ9PIGCkZ/vjTkGfCUIxVnOvyTchtcbDPYudz4WW0Wemg4xQA5BuUydgmcwLdofQlhmKQ/vsb9Cgbjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by DS7PR12MB5982.namprd12.prod.outlook.com
 (2603:10b6:8:7d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 16:19:51 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::54ad:b7e2:f8c2:dd51]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::54ad:b7e2:f8c2:dd51%3]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:19:51 +0000
Message-ID: <367307a7-c1cc-4296-93f2-de6aad690217@amd.com>
Date: Wed, 12 Aug 2026 12:19:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Shaoyun.Liu@amd.com, Lijo.Lazar@amd.com, Alexander.Deucher@amd.com,
 Mario.Limonciello@amd.com, Christian.Koenig@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260812061122.435929-1-Priya.Hosur@amd.com>
 <20260812061122.435929-2-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260812061122.435929-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 625fc480-4b8c-4ee9-7738-08def88d8950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|56012099006|11063799006|22082099003|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: NXwSmsNCSrDegMeCdiitg4q2nR5D5AzgiMGXCt6iK0EJXAe/ou8HXDJpZ5+YRMbpAuCUxW5V0H7C3sLIFQ3AWlQ3elPnIU3k4+WS84ChMxAPnUp4ZohqUHF/6K6xHgJTfPRtcEVLpQc2mgCMSHA6U3Z5KSrls2h1bPKWBb3YJk/XOesBiyDgndNrw/ThjeyBqoM+AdQRWAa74Sx7COcIYHaKC31+WbzFWAm2rrX8wmUnHzezR92ySVDTktvbtnaq0QplILQoHfpEelxKdVjzgDbE06cnXFvwxwYAhy2nMsDKsufL9GNlxhuUOAKaeGT6eMxIgqXWAjVzMC+vNBg75SPmGeD2bXIrZI6rl2c12VblNCJsdycJhLN01yfXmCoXGGeilJI7L3ZYeFQGoghmXJr5cUl7VCuSEv8nAIHZABIztYWWpbOGAekcpZHjdVaCmPHii57g6n/z5qhSRBnXpUH6tv+JDtZvM7uBa3q45BQf3XB+l+uIggKLvhs1AX2H3xNrYp4LG4PdkafxsrqFAG9nRBUPLFu7rIB1Ao6D4NKf/WH+8dkgkeam8C1/hs6pA78vGn6D3idMejLlT5szHQXissU/GvnNk4kTgZN8+kUjoJZgYusGHuYS7TNSANzsDtrAu6oiEqBuBv4miRrqV1hiIz6dFOsw67y11cSMqvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(22082099003)(6133799003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW9Db1pGay82L2M3a1NBQW9VSzVZWHpsUzBJRUNESmh0R2hqdjdBd1liRnhJ?=
 =?utf-8?B?REtUMGVHcmlLbFZOemtiQmMxSlFQb1VtQmo0Si8xaFJ3OVBWNnQvbHhITUh2?=
 =?utf-8?B?dElMaDA4SHQvNjBnYkwyNjVRdE1obW4zaEdpTGNpZmpPeG95T1ZCQW8ybXNx?=
 =?utf-8?B?NmJ5OWZrc2lkMTRNWFNDR29FcXhVQ3FTcjJQTnBXSTRJV05rdVJ3NVNkWlk3?=
 =?utf-8?B?R0xsK255Ly9HZlFmR0FET2lpWDl0N3p6SkFOVkV2dmNFU0h0RGJVemY2N210?=
 =?utf-8?B?N2c2c3RaOFVZYWlwMllST1I0OXhSOTMrUklGNlI4MFR6UCtFc2Y3WDBBTHZJ?=
 =?utf-8?B?QzBMa25hY3JCSzMvSGxJR1hWNktGdlBLbnZzcnltbE1kQnVXZW5HVEU3ODhU?=
 =?utf-8?B?dGVCamladXNpL1hkR0ttVU9zSUg3di9iUDdvTFljZEJscXdoSmI1enBVQS9k?=
 =?utf-8?B?QVVtNUtDSkJNcUh4cWN2TktZTjF1TzdQblhFOGZuUVRsenRHNVdBWnoyOTh2?=
 =?utf-8?B?WGI2d0diNFFLRTZ6QWNEb1ZyeVJnWkE0MTMvVzRuaE9HSUwxNzB1dkNOdDZj?=
 =?utf-8?B?VnZMVklaT3duT2w1SXZLK1NVRm1tSzRtczBZdGo1MjJlWnQxTlZkcWVMMkFw?=
 =?utf-8?B?VVVwdmQ3OU4rcWxrdUJHT3pVTHV5Y2J0Wm1BRDBpN1JOUCtLMUo5OGJDRXJF?=
 =?utf-8?B?NFExWjVwRlFxQWdFMlMySmdyeXdDVVlNUmVUNzNxZ0QrWTMwZVJyYTUvbEdh?=
 =?utf-8?B?TXMxZEg5Q1ZUMnRSUFNzalFiK1BGZjlCdElVMDJhdllueEpFaGZhdUpmYU1i?=
 =?utf-8?B?MnJnSmhUNEtHejgzR0JscmRBNnBZbkR3elE2UTc1YVJzUEdjM09udVo4ZXQv?=
 =?utf-8?B?R2hsYjRmYXNDN20vWXVRb2V3dXF4d0MwZ3J3c3hUL29yMzRrRW5GSHdVaFZG?=
 =?utf-8?B?Y21OOExIMk55TVRVcEFGZ3pVT055YVhKOWw2cWx3WWpXZnRVc05GMVNXZWhv?=
 =?utf-8?B?alB1OEU2ZHpaWVVaR1hvbDc5Z0htTmdadHllZVdyMzJwenRvVXFPMVEwZTV2?=
 =?utf-8?B?R0ozSFNMZ2VCbCs2Yk9lMGFmWUFMdnIzVk05L0NBaEh5Mm9sT2RObEJ0NHRo?=
 =?utf-8?B?bHEydm9LM01BMmNHN3hld3FUcVl2aU9YbnJRd0ZaT2t0RmxON0NzNjA4NnF4?=
 =?utf-8?B?cyt1TkZFQUVmV2kwWjJxN3BwS0ZPZ1lxYy9qMUs4KzJnNUxyak0xTHpoMkhq?=
 =?utf-8?B?eUQyNFVjeFZJUExCZDNZVStGQUZmQXl4ZTN4N3ROUWpCWGFxa3kxWlZDUmE2?=
 =?utf-8?B?b1IwL3kxSXd3dmZCcFB3MVdEdEQ4Q3ZxSUgvTGhOK2pLZVJBZlBQZjdxVVQ5?=
 =?utf-8?B?TkZYOEtjVnVvVmorQmJEREwzYUFLdlFKK0NzUkV2ZzVaOVo0T29oZzdRNDRn?=
 =?utf-8?B?YXlHa0xuL1Jrd1l4bFhqYzBuSzZSRlU3UFZsbTBxQVFIZklidG9tbnVzbnFt?=
 =?utf-8?B?MUZqaFVBbnRBUlJBejVGd3ozNFpkQTIzK3pPRVBEeitOL2U1WldteCtrRmx2?=
 =?utf-8?B?RmRNZk0vRHNLc0F4MnkvdmhaeFltWVZKcERrZ0dXb3lHY2RlU3pVSDNkVUda?=
 =?utf-8?B?VDhFb3k2bGRTMDlmN3BkSjRSaTFseENjeW9CeWNHVlpnUG93Q3A0elJEcGEy?=
 =?utf-8?B?b2Z6aUx4TVdlVEdkOFZXaVMzVUxaNFBhOHV3S0Y2MnZuSGxDQVVXbUwzejdt?=
 =?utf-8?B?UVZFRlU0VUZTbkV6YjlZUll6bnpNNGR0MXJickszcFJGK0xHWHo0dTcxOW04?=
 =?utf-8?B?T3ZDL1NDTUdOZytzMExmZmdab1cyNCsxbCt2WWl6Zm40NG1EZURpd2RmemFC?=
 =?utf-8?B?bFh6VG8yanlrdUJHM3V1RGJ3OU8zVzc5bUl4K0NTdklDcGJqUmM3M3RYRWtU?=
 =?utf-8?B?NzNwcFBIVmJGajRDYVZheDhvbVJvNHcreDBHRXB6V1Z2NnAxYWNiVzJwR3Rq?=
 =?utf-8?B?YmpXZldCVU9WbWMya3VzK2VMSVFOcU5taGtBaDVDUmJKZUV6bjFWMmc0ekVH?=
 =?utf-8?B?YWZtQXBYV0N4VElydWVWU0pIN0g0cit5Sm00TWNHZ3h4ZklkNUlGeXhQUVUx?=
 =?utf-8?B?V2djOHZjNTRKTTRnT0FxdGRvM0t5dGpTS0VaRVZ0VTZzU3UxSnBhWUl0ODR3?=
 =?utf-8?B?U0lsZ2YrWm5maUt0L0Nwd0ZNZllPeWFGTy9qa3pVMXRXc3p6WStzb29WYjR6?=
 =?utf-8?B?NWFQQ1FhTmFCa0FyTWUrRWhla0pxQ2hjTmphTlYwZnRMN25KMXR0TmUxZEZV?=
 =?utf-8?B?TFp4c3o3YnQrNURuWWNWZ1N2NzEwY2xXN1RRd1dGdlpsZlpxaEJzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625fc480-4b8c-4ee9-7738-08def88d8950
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:19:51.3065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3NPuCxsz6NJfMg8qY6fQ0yb2jmRHwdnFWKG9pqwbOUfOppNMYRVjs997otgI3+VTh1L/9C+rVZT7i/szSnCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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

On 2026-08-12 02:11, Priya Hosur wrote:
> MES (Micro Engine Scheduler) does not perform heavy-weight TLB invalidation
> after unmapping queues, unlike HWS which does this automatically. This causes
> a race condition where in-flight SDMA DMA descriptors can access memory that
> has been unmapped, leading to page faults and GPU queue hangs during SVM
> page migration.
>
> The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest/1 failures
> on gfx1151 (Ryzen AI MAX) with XNACK mode 1 enabled - the GPU compute queue
> hangs with packets submitted but never consumed.
>
> Add kfd_flush_tlb() with TLB_FLUSH_HEAVYWEIGHT in two MES code paths:
> 1. evict_process_queues_cpsch() - after MES removes queues
> 2. suspend_queues() - after MES suspends queues and mem_fence completes
>
> This ensures all in-flight memory accesses from unmapped queues are flushed
> before memory is freed or migrated.
>
> Testing on gfx1151 shows this reduces failure rate from 100% to approximately
> 7-10%. The residual failures require further investigation.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..5eb85290126e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
> +	/*
> +	 * Heavy-weight TLB flush after MES removes queues to ensure
> +	 * in-flight SDMA accesses complete before memory is freed/migrated.
> +	 * HWS does this automatically, MES does not.

I'm not sure why you call out SDMA specifically here. This affects 
in-flight memory accesses from compute jobs as well. Just remove "SDMA" 
from the comment. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +	 */
> +	if (dqm->dev->kfd->shared_resources.enable_mes)
> +		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
>   		pdd->last_evict_timestamp = get_jiffies_64();
>   		retval = execute_queues_cpsch(dqm,
> @@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
>   		if (!per_device_suspended) {
>   			dqm_unlock(dqm);
>   			mutex_unlock(&p->event_mutex);
> -			if (total_suspended)
> +			if (total_suspended) {
>   				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
> +				/* Heavy-weight TLB flush after MES suspends queues */
> +				kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +			}
>   			continue;
>   		}
>   
