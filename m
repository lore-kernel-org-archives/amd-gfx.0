Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD1ACA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 16:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3EF10E5D2;
	Wed, 30 Sep 2026 16:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSZYtznG";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47210E26B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 16:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOgLlDQ0JLeKhcZG+gFwhsN/+lrPnkMh4dhu6MscVsVRg0c8byro6wFAiIoV5Q++3TK+wbrhXuwenPvmRc/j7l0APNiuMCem9/6ghp2fqtCxvCleWgJKhHrvwqgc0u6hqPBbbWbVQFMtoSSTJZGVqxTHzjxxwaONcmQembMFniThx0gT/KcVKZefSdGXHEpVfjUnaD6wNXDL3wK1xAg57joGjqxNsncldeWGnu0JAG1gNar5MVPcgdzgKjVZh7Hc0v8tmVuQ/KJC8BLt4sK2e4lVBHTXUYhZwb3qBHLxEAgJzwv4uwZv+/vJg/Dq0wue453wIem7+Sg4gmaBYfaJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+oHuG2PlSccd/kD43Ezl3CJxzzbl+gaeuiDQWHVK4M=;
 b=fL2O+4C1TDUCFjrYlP4Q1TZ+3FxrGoDQFxMSU76ko2KFyiieofovXm7tvhJVAWBfc+ktdqXHZpUURp7xQk4wTXcchfzE2HF/wNoXOO8TrURtxrg9wvncNqIaQoQQ/04Q/5IR2+LofzEPl1mBuSCx1NIBN5PbjvnZon/GiBVyIjbbFkIL/r6nzow39PDAfs2F3JQ9LTyDy8LBFo0zCQ8z0Op7PkWb6iSzLNK/b1uOciJT67jDbrQiKC1do6l2o6ERYXjFjO3KEZhk1qgv1S1/zDQx9J04N627pJ0jk2McM2eIhojbGdINRWFnUHIRRLl4vPPUCYoEhUDwxZuJ9xGLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+oHuG2PlSccd/kD43Ezl3CJxzzbl+gaeuiDQWHVK4M=;
 b=pSZYtznGEdqEZVFj3HlbeiUYELE+hmxvXOD9OHM318CF3EjaHGnZDN1BxxCuz3SNZvoSgte8h2S+4CBMpQ+D0+1nHcASxO5vQ6BpOa0uHM+HNXODQaoaimvjieYJniMiaZxN6ZwPPdo8ngjusZ/5n8T4wz37AWDK7X3HWZSGhDg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 16:44:27 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:44:26 +0000
Message-ID: <e524b40e-fc05-4e9d-a87c-e38d88359511@amd.com>
Date: Wed, 30 Sep 2026 12:44:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/amdgpu: fix the HMM range handling for KFD SVM v2
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-8-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260928151041.1857-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9ec922-804c-4246-ddb7-08df1f1216a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|3023799007|10067099003|4143699003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: R9WVGe5ZzuMRSlO4YTeDkvht4QbaTNmaNZsVI6eggm29GiYiifDaE7PHsyFp2QVWOSRHwuSvhBlNlRqiB3tySOKmxsBt6RfiJ1EF7IJAt4HGXyydrDY2AuPf0saA+NgU6zHsSNb45GdrX7bXPTLLLGqcID5y3HB+D5dUt6lK55WFm3EF2yGTDBQC/S0OnW+2fnxqdphJ6mvu9o+ZKdQ85eo0He0xv4wIgYiQobrU/iMe1wP6+xvur8pcA47bMA7XUHQiieIFmz6lmS9d2qWghlYRCBCLTL7LueSyGCem79EzvFmaxjHjGLbAG2Xunqn27c0uOvrQpeccFtk7wwtoLVzDErts5b80jznSIThzWBgwuojyBktpp8Co2INK/+5eOG2LykrGlMZK/7qw4br6IHlW/UIeD0s1wQ3MbUHbXcYSY1RSW5k4/WYr7vokhy952Ez/KnH3vv++IOb4thf3OVXqv4bjhbXQsBbM2RCBE1neaIOgr0SGTrSg0wkcwR9uzZQa0HRrDW454tsvDR6fsVRH5ZJgeRjAP9kZdN8/2u2vd76q9cG+2Klvsf5/0MrDzy6iJ43lcDE9WZpVqX2/4WUwIULBjHWkp2Y4Nig6otIl1leNZSPiginwl99IHmKBaQgFuz99j+DEikF0ZkwHMPvFGohouzNvKNINA7JhkHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(4143699003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZjZTVMb0Z1ZjJLbWE0KzBBNllDQnE2b2tuM0tLTHZFdDZXcTJXUit4QlRB?=
 =?utf-8?B?MzNYY2JreGpyUGJZbUJMemV0NHA1a0QzZmVYWmdMeEdtR3c0Z2NSQUh1NjZQ?=
 =?utf-8?B?SEdYSkNZNkExNWsyZFJPR285VnErdHQxcnYwV3dZWW80ZTh2b2NOYzZ1Mndl?=
 =?utf-8?B?Y2JOajM0SHJPcDZSL0hlR2xrSWROem5yRHdmaXVYM3ZWaXBTcjFRMW40aTRL?=
 =?utf-8?B?bTUxVHFPMjd4YTdsOXQyMzlPdXArUW4yRXBOckNoZkVad0U5Tm9SYmg1Y2Jh?=
 =?utf-8?B?MmMvL2ZLSVFVbUdxVTJWWmZ3WC91bVFPb096d2Q3UEJ4TVdnMFJSVWppUUpk?=
 =?utf-8?B?UnZ5MUw0RUlLaEpWODVCT1BpQzdQRDV2QXNHSGsvMVBlU0t5RU8wRktRclZ6?=
 =?utf-8?B?RGdza0tBbVNaZUlZRnhMM3g4Qjg4SHlDRkVyamg1Q2sxV1dOTE1BanBaVWRQ?=
 =?utf-8?B?Zk4rcGtBR1RiekUyQ1c2b2xWSnRqOTdrVjU2LzdrS01ZNTA5Mnk3OC9hSmlV?=
 =?utf-8?B?a3hocFJWY0lkVnYwQ2NLQjk0dHFvTWdWdkFXY2hDQ3cwcjF4ZXVET0V5emFr?=
 =?utf-8?B?SHdtNDA3RGQycTJMT2hWYnpuT0FMTWRBbXpvZ2ZJVmdrYlZEODRsMXhYdXUv?=
 =?utf-8?B?VDVtNDlZWUdNSmFzazFXUkNEcDMzTHVXblNMTzBVRUIwT0FvbGdWSUpSbklX?=
 =?utf-8?B?bXAzUHRoem9taUlTekYwVlNYZXIvcDJIRFN6NENGUFZiTTdTUEtlRVdWdncr?=
 =?utf-8?B?RUxXUW96QTFIQWxaM3E4VkhEeUlnTndSdVc5eER6c0IyTVh5Um5mS2Q2Tk9t?=
 =?utf-8?B?cER5eGtzYkJUc3dNVlVzR1NoK2FWK2tCZHFZc2NWZ3E5NkNyeXhNV29lY1Bw?=
 =?utf-8?B?Tm9YSU90aGpPalVrbzZ1NHNzSExYU2sra2V0L3B1ejNvMVFjZlFQYmxNeElD?=
 =?utf-8?B?QkYwcytGZGY2MTNudUhWc2MxeVltTkticE9yZGdnT1lsZlpiWVBQQmVvczN5?=
 =?utf-8?B?MzJEaFB1R3JubG1kemIwZ1p5Y2NlR1d4cDh6RkpYa2luSVVoMk5WK2lLUnFa?=
 =?utf-8?B?SXpXK3ljQzBQTzRSTnVrcEdUdHZ6M0tQMXZWZmNNOWJHUDRySWJpZ1Z6VWdG?=
 =?utf-8?B?Myt5VFlMMGtnLzNkZ0pITTdITGJuUWhocFMvamU5VTllZHh5OXBXaXJVcXVx?=
 =?utf-8?B?b3RlNEI2anowd2pWOTdVZ3ZLRXRUVHJMcmNiT0FlL1ZMWGh4dWZKa0xKc2R2?=
 =?utf-8?B?alYzSG53bVZ1bkg1c2ZMTnNacm9JZEV2ZW40LzJwNVJkUkpnblpiMTRxWHlh?=
 =?utf-8?B?RE8vUElMZlBhUXJIOWNEUEhjN3k4Skk3bWU3OXBZbVB5YW1wVmhiQzFaR2o4?=
 =?utf-8?B?eUNaTTc3bk1IL3NSWXVscEU0ZGxhYXErNUpocEZrUUlCcXVEaFpUUmk2MXR4?=
 =?utf-8?B?MTdMcFI1MHFMamt1OFlzNUlQQk5BYWo3dW5ybVpkeTEvY3hqbWlKQ2lTdy9q?=
 =?utf-8?B?czMzckExOFR0N1UwQ25VN2RZVGZMM1FRODhaZ21saExUMTFMNnJCeWpobWJM?=
 =?utf-8?B?TlNwSURsbm1NMVgxa3ZVVElvY0RoN0NnWVcwVWJGZzhSQ09iRm9YM3JURjlj?=
 =?utf-8?B?Q0FMMnRzOG8ydDZHcEIrVjYvdmQ3M1plZDI4SnJwNVRRYWxqS2FBUW90U2FG?=
 =?utf-8?B?SWVENCtIWktIWW15SURyTTFhbXlZRnNmdjUySFJZYzRRZEM1SUpRYXo5OFZs?=
 =?utf-8?B?aUhreXVZL1VjTWsza1pyTnNSZ0hWNDdOQnNsTTUrenRwb0pUR0FuSEFHbnBy?=
 =?utf-8?B?Yk5iUkl3Q2xUYWgrQmJGdHBGQlpiRE50SUswRkRvU2x5SThUaFlvNzh2YjJL?=
 =?utf-8?B?UmN4aVZCTnhRa3BmQVRvT0JRQjByd1BRaHBpUnN6a1dsZTVzRFk1cFhHSURF?=
 =?utf-8?B?OXNyaG1kaStOSVRZN0UwbGtPVzBjQlRISzB0S2k4bTkvajd5Rkh0d05vNWd4?=
 =?utf-8?B?MXl4c1hwUmxvdndIcFpYc0VaeW4yZml5a3d0ekk1ZkcvUHEza3dOZGdRQXpK?=
 =?utf-8?B?NWQwbHFsMSt1VkZKWUpac1U5TVFFMXlvQlM4d3pWZGY3enRRU2RsZWpHRnQ3?=
 =?utf-8?B?NFJHMVlEYUM2QUlTanpGSzJhN1BVZkxCMWlOZFlNblIyZmQyd0FoSVR6ODFq?=
 =?utf-8?B?MHRpWmNxanpWbTZnaXF3WVBpUkowYlF5bGFvcnBYSTgyV0RucVRINURYb0xC?=
 =?utf-8?B?VFR6dUttdDVLb1c1VTlhckgyRHQxc3lBUHVFSXp3QjU3b1dkYmFrOUtXRy9p?=
 =?utf-8?Q?tPEhictf/jUkBYnEKL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9ec922-804c-4246-ddb7-08df1f1216a8
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:44:26.1190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60Zo8AzuRK1CTCM4aW6hJmDlcLNu6W/wYkVhq8KglGNe7H7g20ETsAPoKrRu+DQxLmr2rlC4AElvb7GANS7i/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

On 2026-09-28 11:10, Christian König wrote:
> It's mandatory that we have this check inside the VM handling or
> otherwise page table allocation and filling PTEs doesn't work correctly.
>
> This allows to remove the buggy SVM range lock, but that's not part of
> this patch set.
>
> Only compile tested!

@Philip, do you have time to test this? Do we need to ask someone else?

Thanks,
   Felix


>
> v2: fix broken compile after ualink merge
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 13 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 10 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 32 ++++++++-----------
>   5 files changed, 41 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index b7975c77b1fe2..c1bb74cb45eda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2058,7 +2058,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
>   
>   	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
>   				npa_addr + size - 1, pte_value, 0, 0, NULL,
> -				NULL, &vm->last_update);
> +				NULL, NULL, &vm->last_update);
>   	if (r) {
>   		dev_err(adev->dev,
>   			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
> @@ -2111,7 +2111,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
>   	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
>   				npa_addr + size - 1, pte_flags, offset,
>   				adev->vm_manager.vram_base_offset,
> -				bo->tbo.resource, NULL, &vm->last_update);
> +				bo->tbo.resource, NULL, NULL, &vm->last_update);
>   	if (r) {
>   		dev_warn(adev->dev,
>   			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
> @@ -2649,7 +2649,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
>   					npa_addr, npa_addr + size - 1,
>   					pte_flags, 0,
>   					adev->vm_manager.vram_base_offset,
> -					bo->tbo.resource, NULL,
> +					bo->tbo.resource, NULL, NULL,
>   					&vm->last_update);
>   
>   		if (r)
> @@ -2785,7 +2785,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
>   
>   		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
>   					npa_addr, npa_addr + size - 1,
> -					pte_value, 0, 0, NULL, NULL,
> +					pte_value, 0, 0, NULL, NULL, NULL,
>   					&vm->last_update);
>   
>   		if (r)
> @@ -4572,7 +4572,8 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
>   	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
>   				npa_in_pages, npa_in_pages + size_in_pages - 1,
>   				pte_flags, offset, adev->vm_manager.vram_base_offset,
> -				bo->tbo.resource, NULL, &npa_vm->last_update);
> +				bo->tbo.resource, NULL, NULL,
> +				&npa_vm->last_update);
>   	if (r)
>   		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
>   			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> @@ -4606,7 +4607,7 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
>   	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
>   				npa_in_pages, npa_in_pages + size_in_pages - 1,
>   				pte_flags, offset, 0, bo->tbo.resource, NULL,
> -				&npa_vm->last_update);
> +				NULL, &npa_vm->last_update);
>   	if (r)
>   		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
>   			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 77ddb7fa96fb0..55bfe4eebc190 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1115,6 +1115,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @vram_base: base for vram mappings
>    * @res: ttm_resource to map
>    * @pages_addr: DMA addresses to use for mapping
> + * @hmm_range: to check validity of DMA addresses
>    * @fence: optional resulting fence
>    *
>    * Fill in the page table entries between @start and @last. Allocate and free
> @@ -1128,7 +1129,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			struct amdgpu_sync *sync, uint64_t start,
>   			uint64_t last, uint64_t flags, uint64_t offset,
>   			uint64_t vram_base, struct ttm_resource *res,
> -			dma_addr_t *pages_addr, struct dma_fence **fence)
> +			dma_addr_t *pages_addr,
> +			struct amdgpu_hmm_range *hmm_range,
> +			struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
> @@ -1161,6 +1164,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> +	params.hmm_range = hmm_range;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1463,7 +1467,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
>   					mapping->start, mapping->last,
>   					update_flags, mapping->offset,
> -					vram_base, mem, pages_addr,
> +					vram_base, mem, pages_addr, NULL,
>   					last_update);
>   		if (r)
>   			goto error_free;
> @@ -1673,7 +1677,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   
>   		r = amdgpu_vm_map_range(adev, vm, true, false,
>   					&sync, mapping->start, mapping->last,
> -					0, 0, 0, NULL, NULL, &f);
> +					0, 0, 0, NULL, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index a6f6541758609..9b07df5a2b816 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -469,7 +469,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			struct amdgpu_sync *sync, uint64_t start,
>   			uint64_t last, uint64_t flags, uint64_t offset,
>   			uint64_t vram_base, struct ttm_resource *res,
> -			dma_addr_t *pages_addr, struct dma_fence **fence);
> +			dma_addr_t *pages_addr,
> +			struct amdgpu_hmm_range *hmm_range,
> +			struct dma_fence **fence);
>   int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			  bool unlocked, struct amdgpu_sync *sync,
>   			  uint64_t start, uint64_t last,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index db748e8b3bf38..8a0e5fcbd55ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -26,6 +26,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/list.h>
> +#include "amdgpu_hmm.h"
>   #include "amdgpu_vm.h"
>   
>   struct amdgpu_device;
> @@ -72,6 +73,13 @@ struct amdgpu_vm_update_params {
>   	 */
>   	dma_addr_t *pages_addr;
>   
> +	/**
> +	 * @hmm_range:
> +	 *
> +	 * Used to check the validity of pages_addr.
> +	 */
> +	struct amdgpu_hmm_range *hmm_range;
> +
>   	/**
>   	 * @job: job to used for hw submission
>   	 */
> @@ -156,6 +164,8 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>   	p->saved_flags = memalloc_noreclaim_save();
>   	if (p->vm->evicting)
>   		return -EBUSY;
> +	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
> +		return -EAGAIN;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 263e68d29360d..8aebcfd58579b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1465,7 +1465,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   static int
>   svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		     unsigned long offset, unsigned long npages, bool readonly,
> -		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
> +		     dma_addr_t *dma_addr, struct amdgpu_hmm_range *hmm_range,
> +		     struct amdgpu_device *bo_adev,
>   		     struct dma_fence **fence, bool flush_tlb)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
> @@ -1525,7 +1526,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					gpu_start, gpu_end, pte_flags,
>   					(last_start - prange->start) << PAGE_SHIFT,
>   					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					NULL, dma_addr, &vm->last_update);
> +					NULL, dma_addr, hmm_range, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;
> @@ -1552,7 +1553,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   }
>   
>   static int
> -svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
> +svm_range_map_to_gpus(struct svm_range *prange,
> +		      struct amdgpu_hmm_range *hmm_range,
> +		      unsigned long offset,
>   		      unsigned long npages, bool readonly,
>   		      unsigned long *bitmap, bool wait, bool flush_tlb)
>   {
> @@ -1588,7 +1591,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		set_bit(gpuidx, prange->bitmap_mapped);
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
> -					 prange->dma_addr[gpuidx],
> +					 prange->dma_addr[gpuidx], hmm_range,
>   					 bo_adev, wait ? &fence : NULL,
>   					 flush_tlb);
>   		if (r)
> @@ -1862,18 +1865,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   		svm_range_lock(prange);
>   
> -		/* Free backing memory of hmm_range if it was initialized
> -		 * Override return value to TRY AGAIN only if prior returns
> -		 * were successful
> -		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> -			pr_debug("hmm update the range, need validate again\n");
> -			r = -EAGAIN;
> -		}
> -
> -		/* Free the hmm range */
> -		amdgpu_hmm_range_free(range);
> -
>   		if (!r && !list_empty(&prange->child_list)) {
>   			pr_debug("range split by unmap in parallel, validate again\n");
>   			r = -EAGAIN;
> @@ -1885,11 +1876,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			if (map_start_vma <= map_last_vma) {
>   				offset = map_start_vma - prange->start;
>   				npages = map_last_vma - map_start_vma + 1;
> -				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -							  ctx->bitmap, wait, flush_tlb);
> +				r = svm_range_map_to_gpus(prange, range, offset,
> +							  npages, readonly,
> +							  ctx->bitmap, wait,
> +							  flush_tlb);
>   			}
>   		}
>   
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(range);
> +
>   		if (!r && next == end)
>   			prange->mapping_done = true;
>   		else
