Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B82FC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 10:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F73710F7DC;
	Fri, 10 Jul 2026 10:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8A7m0g4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCF910F7DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 10:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0usf9g8GNanGnXP9/t31n+ZNXlJb3bPVL1VxuOMAVY738+mcOqaolnoczblFKXa8uXIF0ezBlfqMm2bsdKcaVczUIHHkNyyg7hQ7n4O6FSVY7+WFGakndNnXBN2/BfGaCOFklLiRkf+zmkUeXlnIfC6Kl/iAoeNfxzsfFlrxq2Cs/pTHVv9akkwJHqKO2zTxcqjNG1EUhpG1GWO5hFkOv57IPCTLINp5vuiVM0lbS6W5ibNTFrQKzIwioLIQlMiNbRbAugtrPIw7/1GDUQa4DGC+UN0MYi7DZDDTPmjSHxlNdaqI7FdLHvdUvk6dgufI8/fgqZSkg7rhVZiGgusJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT4o1ThotPS4rNXELxHxc70mNVPRJxW6D0jOkKX3uYs=;
 b=D+sg3JTAKx+OuxIADWkEjszwHyQaUAQpJp29NUd5GueCML0Cgmx0rkx3URZYMYF5w6YZbF5vmmfgCnyJRHSNTnt5TNunGmeygWXhVtMzV6Ruxamhr1ysDvJA09d0S0Hr5hVbk2ts+mr0/Xl22CkVzYYxjqgY8g8Tek+kpjyQyoU8L/fuApbenDF930VdIIsQ058vlKc1NnYK3FYs4rOlwwgGd+kez4DOj9dRMoM1YrDtqqATQPD4AGA/1QJrxbtY/1nS458ICHDTc9DnEBJIflwhJK68aIPpiPnwl0ywN7l1306DHvmiKqijdc0P7vMcPmcILgelXIQbqbWMdj4T7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT4o1ThotPS4rNXELxHxc70mNVPRJxW6D0jOkKX3uYs=;
 b=i8A7m0g4IwEode3NGujfzII4hUK91I1lxCYYGuJGMz0K/xasFq0K4XS9viEh6jzfYEd6O6ssZeIzcRe9onrUOebU321wwRhcYMr9madUreRAgCzLob+sr5H9H3q8QHZu8g9wj7YaO80SxTvNLhm/vPe6G3FqML24gexYPsS/xCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 10:06:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:06:25 +0000
Message-ID: <7b8ad7e8-27c7-4af1-9df7-fdb8474be2ee@amd.com>
Date: Fri, 10 Jul 2026 12:06:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix indefinite fence wait during GPU
 reset
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
References: <20260710100151.2849385-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260710100151.2849385-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2702472b-1f27-4744-32d4-08dede6ae67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: BKVdlyvGwtCujFyrcd1j8aMQCXVJTg1p+BSeg2j3mg1XMSI4g72fN6BDWF12G/gc/z7aWEQPBtd8hMcPRFBL4GB/bmWqIgi0Ikx5rMeTzfcNBwrWJa8/mn6szHZchbCwv4p6l3HNGhtbeKiduHGKDx0xp4CyuZ8K049LvQuBcFElB5fA3xOtnMnCvRP3eXqvLtrr8m5RDvRMm7LA6MTWxJszYsKMaYW8gFOB5eluCbA+ynGnYRFXaIsdQO6Fx981y0jhJZUN7mSgVLHRksP9rt8Sn0VNVxMwmMjo0SmqzeZ5F/EoafoQUKBxeRjmtWDGprAqDgIJq8Wvf9WFMGSw/kGTd94JDbe5bKhP9XgVUAh/ZbvmPZy1Tg5QFOs6sEvixQcNzKmTPsQFjz4j+I8GvFUF7KgZLOQEw06LKB21nYJHZGeGr0oOH58zoter3+6uD0fNd/FXRKpY3e2kx/+YZKDY3tDNqOqQEyaOwKnHeklHsZLEdIEFjSeg9Azr8Jl5sA3Qekf1PTs/eDPxMjdBSDQty36i1uIlPPpVClK6AswsecsNn/dUj0P+i8V2LocP7tS2JeHiRvVxNV9cfyilGaOuc0NK7buKkMv4V3P73E6OpvdX2Ta034Cb1F2IitgniJOmUJk1am++xdFgfRx9MgAobjS/Bh2gTqBd3FgRAjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtOK3p3a3I0b3F4QWpMa203RkgycTF0bDg2WFVEcEsvZFJJSlR4K09kU1VN?=
 =?utf-8?B?NTI2VWJUS01GU2pBY3pWaVJYR0IrMnVCQmxGbkRldk5ZNmx3SEcrclg4SVc5?=
 =?utf-8?B?N3IzVmtPWDYrMDFyUWt2MnJMTmZOcnNhRXhnY0NzaW1QSlkvQ3BXSE1ZdU5Q?=
 =?utf-8?B?RkxIam9yOE1VclJ6WkNrcEhWZ1kralZsRTdWOXBOMlpWcUdGdjI3ZExKelhZ?=
 =?utf-8?B?R05ydHVZdklVOEliNWpHK0txVWdkekhSTXVmODJFZ0tYVStMaVd3bW9lOVE2?=
 =?utf-8?B?VXFndXgrY1JJaFhjVjVNOUFTMnlibCtkSitlZk1aQ3ozd1UwSHFheC9raUdF?=
 =?utf-8?B?YmpoK1ErQUV6RE5wcVJ1cWpmQjVCUnBwQUpuRmQwdm9LY2NXL3JuMjFmYnZO?=
 =?utf-8?B?QjlvOGVVeWEzbThoSWpLdFpTS1d5MmZYQ00xYldoR2hsQkxpdmEyb3dzK0dB?=
 =?utf-8?B?Uy9jeHZYeUxwWENYNERoSUpnVVIwQlJXZ1c1UkpsaTFJWkp2eCt2Z2Z3TmtU?=
 =?utf-8?B?VGxZV1hVT0tSOG5BYlJPMTNRWU9ZdGF3NjczNlNmdzBMbjBHZmpyUWNycnFi?=
 =?utf-8?B?SUpBREcyYmJDbW8zSWlhWExZSkZIWHZCQU9jQUhxQ0s0aGgzM2Y3VHFlcldu?=
 =?utf-8?B?ZTFwVGlkTi9MRmZqRDZXMjFvOWNFeUdWN3RhZFhadU9mc2tIV21acmFrMGRx?=
 =?utf-8?B?QldRK3BVSWhaOWg4cytxOHk0SEcrZXc3MVRvQlRXOW1uNG02aExkc1FnV2RP?=
 =?utf-8?B?Z24xTWRuVzBnVjlUVElXazBmcjh5Smc2UFN0YnpuQldxWlFKUnVSczRSaHkr?=
 =?utf-8?B?RXBwK25NZ0xQUE9XMjZRQ0VzM0N1QVJuR0srWndpSG45TmFaQ3RmMk9CanpP?=
 =?utf-8?B?TmFEYXh3Y1YrdEpSMXRHQlk3ZVBZQTQ4R0Z6VW5SaWhxdGxiY0wxbkNKeVhn?=
 =?utf-8?B?VDAwRkxnMXArWjJNaFlkdTlubks1SXRzaWdQR3d6bEg2M1orN1Vqdy82cnJo?=
 =?utf-8?B?ZDdXZEJWOGxLU1M5NWxjR0FmMjNZSlJpRjgxdmZjdzN0VFdBb01Tamw1cmVM?=
 =?utf-8?B?YVhaS0NPTHZKYm1lc3o1aTBJaWRObzR1blpJSjR0ckhuOEtBSG5oUXhoYTFI?=
 =?utf-8?B?Q0Ywdm9oNjl3R3BQYzFZSzl5NFRnTTF1Skc3STVoVjJkaFkxaUVsQTN1SmNt?=
 =?utf-8?B?OXQzdWZJNUNUSEsyN28xY0hZY1JKU1pMVlZmNzRFdW1zT1oxcGJjRVhPMStj?=
 =?utf-8?B?NWdJclJjc1ZlWVR6M3RRVzd1WE5DN0VrQk4xV0dTeTU1SzlzeW9GejN4eWo2?=
 =?utf-8?B?dkZpMTFLcHhDcmRjMURMOTZtY2ZVZXNaaEZFalF5OUtrTERmbFJGbWFpNTho?=
 =?utf-8?B?dktpWHRQRDBpbWllRjIyc0dMVXh5bm4rclo4M1g3K2cvMDZGa3pFWFFDc2RP?=
 =?utf-8?B?RCtKb0VHQXF5Snp3UjF2T1Q4VkhIcXQ1SjdRREVBMWZxQ0xVUkkwREhsbEpn?=
 =?utf-8?B?SWVvSHAwcnI2K1dOV2pxMDB6NlFqc0x3Y0R6R3hnMC9EeXdnZjRDVlZwNi9h?=
 =?utf-8?B?S01qa0xWVXY0L3c5NG5CK3R0dTA5TUh2ZnpHeDhGbHE1c3QwVFNnQVJ4V2cz?=
 =?utf-8?B?YWplVkNBTGRsaEVYZXpIVlRCSFFha2czK2hvOWk4eENBYTUxdkdDWWZYbzk0?=
 =?utf-8?B?TFpRVGVkcG5DTWRJaXFWRjYrSzhlbkpNZ0V1d21kcEszcTMvTDVUVE41Ti85?=
 =?utf-8?B?UHN0S0cvQzBwbEtPN2srNzFKRnZhaTlMUSt6M2UrOWM5RStFcnYwS2t1YlMz?=
 =?utf-8?B?Y1c4VFFkSTBXTVV5MUJhNUFObEtFbytQdjRKM3NGT00vWENhQTF3U0EyUitj?=
 =?utf-8?B?Smxwbnd2L3hOYXpKVmdoaUdVdnA5UDhrV2NHaURsQUJ1aFJMY1BTRDNkaVBi?=
 =?utf-8?B?dUxUVTR4dFB0R3RWZkpZNGt6dWtUb3IxUmZ5Tkd6c1lPeGRLWWRyem9CQU5N?=
 =?utf-8?B?QlJpcGJ6NExBNUhqRm1Ra29Hci9xWkE1WSswSVN6RWUxMGcra0RYMkJWaXht?=
 =?utf-8?B?eVZ3TW1vdUNGWXBuNWtBUmZNU1V0elVhRkM0ZUt4d2VsN080aUV5SmVqcWRE?=
 =?utf-8?B?Y3JRRlJsaEtBdmt3bmw0SnRpSXRtazErL3YrZzJqd1g2QnNFRWZGWEU4Qnl5?=
 =?utf-8?B?TkoyWUd3TTdaQno2N2N0RWVkV1BSVHBXdzFEZ0hUU1d0OS94TG5qeWtLUFlq?=
 =?utf-8?B?UzJTVDVlRnB0MzJueW92RHlOMHM2cTdvdmNxZ1QydzhtNHA0S1Rxc21QRkhV?=
 =?utf-8?Q?ZM3sbUUuFnIPoY+TUc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2702472b-1f27-4744-32d4-08dede6ae67e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:06:24.9609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bwg9u/8ijB5O0WjYbFx/yVzSCsbRjlTDGb+XGLItn4VpyNTAijvmPphteEXwcuqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

On 7/10/26 12:01, Jesse Zhang wrote:
> pre_reset only force-completes fences of MAPPED queues. A queue in any
> other state (e.g. mid-eviction) keeps its last_fence pending; after a
> GPU reset that fence never signals, so the eviction/suspend worker and
> process teardown (amdgpu_evf_mgr_flush_suspend) wait on it forever and
> wedge the machine:
> 
>   INFO: task kworker/6:28 blocked for more than 120 seconds.
>   Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
>   Call Trace:
>    dma_fence_wait_timeout+0x7e/0x130
>    amdgpu_userq_evict+0x67/0x140 [amdgpu]
>    amdgpu_eviction_fence_suspend_worker+0xd8/0x160 [amdgpu]
>    process_scheduled_works+0xa6/0x420
> 
> Force-complete every queue's fence regardless of state. The unmap and
> mark-hung step stays gated on MAPPED, since unmapping a queue that is
> not mapped is invalid.
> 
> Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 25 +++++++++++++----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index aa5cc5642e87..6aa75da27f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1424,18 +1424,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>  
>  	/* TODO: We probably need a new lock for the queue state */
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> -		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
> -			continue;
> -
> -		trace_amdgpu_userq_state_start(queue);
> -		userq_funcs = adev->userq_funcs[queue->queue_type];
> -		userq_funcs->unmap(queue);
> -		/* just mark all queues as hung at this point.
> -		 * if unmap succeeds, we could map again
> -		 * in amdgpu_userq_post_reset() if vram is not lost
> +		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +			trace_amdgpu_userq_state_start(queue);
> +			userq_funcs = adev->userq_funcs[queue->queue_type];
> +			userq_funcs->unmap(queue);
> +			/* just mark all queues as hung at this point.
> +			 * if unmap succeeds, we could map again
> +			 * in amdgpu_userq_post_reset() if vram is not lost
> +			 */
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
> +			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +		}
> +		/* Force-complete any pending fence regardless of queue state so
> +		 * that eviction/suspend and queue teardown waiters don't block
> +		 * forever on a fence that will never signal after the reset.
>  		 */
> -		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
> -		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  		amdgpu_userq_fence_driver_force_completion(queue);
>  	}
>  }

