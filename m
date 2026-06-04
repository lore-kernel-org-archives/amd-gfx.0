Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D5FCD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 17:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1740911A21A;
	Thu,  4 Jun 2026 17:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLH+U53z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B411C11A21A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 17:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUmkHFcrV4+xowO8swM2QPdtA+9Lu1VDGrFZWeEf74PSLiO5MrnKxlPpc7AB8LH+KOIvXsUWGmc7cJ4aUAokYn+KoD/r5/p/GUkNOsCIZ2QKnZ7XJz6G8i/ZFNSaFp65t9id3DmfyEkVXypm++2RxKg7xZn8AWsWBf/Z86d1QOS0j9CHqkG/UyI7vGArxqb7KJqHEP4unNCY+VlBTBV5fELUgwnEBsj1jJFgV2k01WcYy1GyHGkbIRlq8TXzUETjXy8RHlxwInFPNqx0B+yvTOoEZWtzAMKSnxyq2Cjbrr1wI17wfvL2Hww9V39vM047JNtronSOAff07iXzbxVl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG/ORHwdPCZxSF58Lz8fooz+adzOhn/B6Bmo8HjFJv0=;
 b=S4soX28dr5HGQva6tdHltCaSrIFavzx6MxVup/CBd3kyscOIDIq1eUeMZPIUgx8gfjkAQK1aZrn3WNv+BUFJjTE+Y2TBr8kY6ttxjqRYAMZO6beQPUbaQ34aza8ihgt+ZNgmqfOdK6nyMYoaESwh/Y6SXpIf4S/txBpF0u3H5EqIn/8wqD3XCXN1bjA754GyuIzuq8ACWstKt+4J5lM2wQEIqvu3nNjTjo4AGal4CfdC+/0uqgdBcEHfNonUWhSJx2F6BMLm/nUbdzZGeQZQCrj157TmRRlhlKSvqrcZH2tF2ZGzS9jvHUWsLaTqVV8JdUuJKZLGF7BmWZRdaIuR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG/ORHwdPCZxSF58Lz8fooz+adzOhn/B6Bmo8HjFJv0=;
 b=MLH+U53z/n0sWNFTNU3kR6WZJUAJcRbgyn6ZJ3dCSURqm3GWppNHMCpPH86vhk1SyGo+bjShi8DGevX/j1Zjgs360NLKmy88thwbU9lgbB2cIZ54TmTqBBloejSZcCfEwfA+975mBUoiQVb+GdTTczl03PMd8Ct3nS9rB6kl7ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Thu, 4 Jun 2026 17:44:16 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 17:44:16 +0000
Message-ID: <13b891ab-e83f-4ebd-bb63-a5558910c25b@amd.com>
Date: Thu, 4 Jun 2026 13:44:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on
 free
To: Yunxiang Li <Yunxiang.Li@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: Ramesh.Errabolu@amd.com, amd-gfx@lists.freedesktop.org
References: <20260604172011.1840130-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260604172011.1840130-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dca161-cc9d-45d2-0901-08dec260e5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: exHL62Fgwnw6u5jcVIwGSnG0F999s1ohEjLeCOJYV9/bIIH5L/x25S96goA1mzumIDygAOHywLNtMl2NfefPvHYdtnXwZbEWw5U5dITcUApRUi/RWPkt6kY/55Uga9MtwNFmvM4CSBg40Jkn1ueWE9NQdSfIGy08dbICWnwHBlwk2sx2hQsLCPmjJ3uLRKRItkK46vBopSZAuI2MdlOb+s/0FAVzJmgE2eCXvz9SQIqn8VY9VSqeii8g+bLJdQXUV3ObJ231EShGTLziPVSb6wiX86xeAvP139Drt3E2J8amC7UGfJM78QtdQowTUbjmvjpdRhkJwomjhe3rW4cH/Em2U2hwBCwGas7gsX8JHGYEHhAsGYSJshrHy7/X3Z1k8RzfFYjA2Ck+3DihhICjrjOJj4wkf85YxZGTWVOgATkVjA++1pTWEWnduH33qVIbCG7NJ8k7A3B4DDm3Q9AAmcEEQISsc9F3ifjQQCyqfADi3dd3NAjwsKZ4a54Nrsy7HBc6A/sQJLfQUh+DTytsloHTaslXZ3c8zFFHOSoGh5SgOToVfrAnxtJ0E5OGkxpKhxjow+UH0k7LOxl6JMIuks/TynF+Dk2loBGvVUwznAGguTSU8o0gu2V+DLe1jEsy4bxg6T4zsQ4K2tZdBLjYmZ/u8666O0czixSqr0Q9Qliv28bE9dSaQMw6v1K0+TYn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tuUVAyWHJaODhqclloeEdUeWE2ei9BeGRBK01yN3Jxbldxa0RVSTZaZnRT?=
 =?utf-8?B?a2NycDc2M0pXZlJCNEN5UzVKNlp1Vm9sTnRLY2hqenpUM3JRZXBiZXVKY0V6?=
 =?utf-8?B?bDd5OHlpc2VXdkIvQlNjK3VwUGQrWnhPUkVXRUNqVEdPSXJCQXVNcno0dzNx?=
 =?utf-8?B?OVZKRE5qQjhXQjVBaTJGdkhPdnpTOHRiWS9kL0RtbnhVNkVrMlMwK1NCTW50?=
 =?utf-8?B?bU8xYkJ3T1hnSXdPQ3l1cUhLN3VJaWpWZ2wwWm5OeGhKVi9aeldnMVowdGtQ?=
 =?utf-8?B?WS9JbmZLT3dWbzBQUDhqWFlGaWJuSGxFZlY3RVlYZ21nV2crWUJWN1RkRTk5?=
 =?utf-8?B?dEVodzJhaWhMSjdmMWtuRGxWM0NQUEI2WnhQek5UbFdnT3FDTFZGaFFYZGsy?=
 =?utf-8?B?QXlJVkc0SGxFWDh1V2tmcktrY0U5ZHgweW0wdTUrcUw4WDREM2FVNjJsNE1K?=
 =?utf-8?B?dXpMUGtIdWViVFlkbGRQWlB1QVY3SjFrbjJqVTQ0V1dHdHZaNkxTcHZuY0lp?=
 =?utf-8?B?bXdwT05nVVRKL1J4NDdvU1BpRlB1NEg3ZkhaQnMzVkJMaExPQ1ZNR3lldlZq?=
 =?utf-8?B?MmsxclJsTC80UjEzNHNIWWhCb2Jia00ydDlmaW9EeU92aWlFeU9hOERMUVVq?=
 =?utf-8?B?dVVaZTZHWWd0aGQ1MlVzdWxVbjVWditPY3p6OS9pbFBSbTUySHpCaDlwS2dO?=
 =?utf-8?B?NjdvQldHZUd0enBob3FUQTl6d293OVVoSDVnL2lSR3hTZ1BuaWR1SWw5ajdY?=
 =?utf-8?B?TnpkQVp4VWdGVjliYkk3allIZFA2dlhVM0U4aGU1T3I0bjZubEpSUk9kRW5F?=
 =?utf-8?B?WFdLbmZrbVhzb2FqWm5TRGhpMG96Ny9ZdXE4TFcwOXlLdUJwdDdya2twdkQw?=
 =?utf-8?B?WDZiUC85cHE5QUxNVllLeHdNTzVsTS9tTzFvZG5BRElIWWRFMjhwbzFHWWFG?=
 =?utf-8?B?US9aeDIxZ1QxelV0SmNVbHpFc2ZwNXEvYlRjV1lpVFo5TUovbUJZMEtqSWky?=
 =?utf-8?B?bjljSVdnc1JXL05QeTN4NkRUdTJBMlA4cjFXTmF0SStYYWxnWG44U3hVTTRC?=
 =?utf-8?B?c3VyaFp3Mmp0VlFvTmhJSWtMYzA4UHJIeXNRMjJIeHg0VTkxNGl6WjBTT2JQ?=
 =?utf-8?B?cjFmS3lBdWVYNWRrQ1huRHVWWGY5N0Jic3I3Mm9YUjc0cGZmeTE5Ym01YWF5?=
 =?utf-8?B?cGV2bjI4SnRjeGtDeitncjQ4Kytaa1JOdEpBVlhBWXZ2WEU0Nk50d2NoMUdr?=
 =?utf-8?B?VUhJS0dVVjRWNUpzVTZlQVRZWXF1RlVyK3U4QlZKclZvVnB6VDdPUGpHYlB0?=
 =?utf-8?B?eGh6UnpQNTFyZkZwdXRUV3N6SWhKNUJHcEp1eEZKRUVjelFFUnh6aGZiQnE3?=
 =?utf-8?B?Q2JGZWd2SmpHbDQ0cUxySFRYbGN3UjVmMnJCankrbGNTTHN3ZzN5eU5KWGVV?=
 =?utf-8?B?NVFlOXZ0Szl2VExMZ1VWLysxYkFsMmhLSFM5a0lPRk5yTjRxWjFOSm5xem5s?=
 =?utf-8?B?OU1tNEZZRjM0SFhINVlEUDMvRVdVNDBHVXJzVkw4bUtmTzVNRjc2VUtjZVdS?=
 =?utf-8?B?TXVTMGdVUE9wNnRiNFJtaXdQRzBEWnU1V2dNdHFuaUIvMUpSRmdmRGV5UEh2?=
 =?utf-8?B?YlRaR2s4Rm9oU2V3MjlRMnFWV204THkvemxxL3BockQrbWh3ZmNINHl3Tktr?=
 =?utf-8?B?MWN4MTBlbGQ3WEhieEl4WTdLZUpwcVZ1N3h1Nk5sUC9WTUNVY2ZlOHVMMDRP?=
 =?utf-8?B?SGpDcy9NK3FRaytwc0pHUWJzNGJ3OGdtOTJJLzBvVmJvM0tBbG5CYmNDcjRs?=
 =?utf-8?B?TERxa3U5U3FhREFTYmN3N25tb3ExeXdleW5BMEdzbk5RUnV3U2svQm5pamFY?=
 =?utf-8?B?WnRCWjZlcm5LZjhnKzNGREoya3N5QjdTaXlSTklsMjg5dE1DSzlvUzVLYk11?=
 =?utf-8?B?RWlpd0RyaStYODNRc0QybWhQRVdPaEoxSnF4MDNOcjAxdTl1Y3UrazFPdVRT?=
 =?utf-8?B?N05qclVnUjB6bnd0MUtUUFVwMDVTbFBnOFhGektrQjIvbzN2d2J1SjMzbHNI?=
 =?utf-8?B?WURrUG9VMlB2U1dDZXUxRXlHV0N0NEZFZ1EwdlNUbXNLNzRLK1UrVTVkWldE?=
 =?utf-8?B?TGxzYWF4c3ZNaFBReDJMU1ZUelQ3cTZ0cXdVTWltdklIN0p3U1RScGZPbWRi?=
 =?utf-8?B?bXlDd2RvaG5RbEgvSWFuOVpoTWdBdHZtT0N4Q293MDlBSmxTY08zUUNZSC9X?=
 =?utf-8?B?U3FDc2VnWHZERFVXdFgzNlJmQ1hIbG1qUE5hTlNsYk1jYnRWdlRKbXgxSWlV?=
 =?utf-8?B?bHdoNVpvU2xydCtNUC9rTy9CYlhvSEV0L0JXYzdsbVNXa1R2dFdaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dca161-cc9d-45d2-0901-08dec260e5b2
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:44:16.1857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVkapOpuJ8vvDpr1WMsMGmLBwpRG5Ma4TG3DZY7KxafUp3K7fPWOvLZf9TcrTE2BVQdXjGqImyFvPlklH5mGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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

On 2026-06-04 13:20, Yunxiang Li wrote:
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu() unpinned DOORBELL and MMIO
> remap BOs (which are pinned at allocation time) before checking whether
> the BO is still mapped to the GPU. When the BO is still mapped, the
> function returns -EBUSY and leaves the BO alive, but it has already
> been unpinned. The BO is then unpinned again when it is finally freed
> during process teardown, triggering a ttm_bo_unpin() underflow warning:
>
>    WARNING: CPU: 18 PID: 15066 at ttm/ttm_bo.c:650 amdttm_bo_unpin+0x6d/0x80 [amdttm]
>    Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
>    RIP: 0010:amdttm_bo_unpin+0x6d/0x80 [amdttm]
>    Call Trace:
>     amdgpu_bo_unpin+0x1a/0x90 [amdgpu]
>     amdgpu_amdkfd_gpuvm_unpin_bo+0x31/0xb0 [amdgpu]
>     amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x3bf/0x460 [amdgpu]
>     kfd_process_free_outstanding_kfd_bos+0xd4/0x170 [amdgpu]
>     kfd_process_wq_release+0x109/0x1b0 [amdgpu]
>     process_one_work+0x1e2/0x3b0
>     worker_thread+0x50/0x3a0
>     kthread+0xdd/0x100
>     ret_from_fork+0x29/0x50
>
> Move the unpin after the mapped_to_gpu_memory check so it only happens
> once we are committed to freeing the BO.
>
> Fixes: d25e35bc26c3 ("drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain")
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c01492e69ddd..5bb3e28441a5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1914,13 +1914,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	mutex_lock(&mem->lock);
>   
> -	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
> -	if (mem->alloc_flags &
> -	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> -	}
> -
>   	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>   	is_imported = mem->is_imported;
>   	mutex_unlock(&mem->lock);
> @@ -1934,6 +1927,15 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		return -EBUSY;
>   	}
>   
> +	/* At this point the BO is guaranteed to be freed, so unpin the
> +	 * MMIO/DOORBELL BOs that were pinned during allocation.
> +	 */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>   	/* Make sure restore workers don't access the BO any more */
>   	mutex_lock(&process_info->lock);
>   	if (!list_empty(&mem->validate_list))
