Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6149EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 06:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A9610FF6D;
	Thu, 14 Apr 2022 06:37:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550E410FF6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 06:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPun6yI25N+Kvy6MACvQ76VdGQ0wq/sFFen1IF0LFiVM23nUJK+pYJCRIUr+aKdYiUcw9f11fx0/tvpaAjJdH1sJNQEVNVxdaBGHKMnYdVgYFVQ/glgAH7uCtvUWLDLqvobvW/ABwzI6s8nY80MXFvc0Rp09QeInMGx7HCP9xC+QYq5Qq+NAxEUVRvPULfz6BalgFc07pGpgLpI8L0R+rG2CSmsqIvlO6fJSR67yqwSnvNI+sesZCruatiCEbeD8JN+342tdjAj+eGZv/6B0VHXz3qiaLv6/2ukDM5gX8r/hG4yRL7T+k9SOZWbNTWJLYtPdirYxri3hz7ZThb7iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1c5d/CxbCBnWNuacC/vR20gHaaPo2SP/31MwWI4FS4=;
 b=U2h52sKz3GI9JKMgt4PaJx6NKkyCJzuDx5ngn42VV1wewGGtmTmlvVVC1pbnBPb2F+j9acl8jXPhy5tV8Hgz5sQLnVKk2QF8qYuD6qLjUvUsEIZOgtYvvq5pJtn3hRHK5Ia8VSCvOsp/8fyz0NOSNzkS+Nev5XeBkLnjgN/oK8betlJ/cuY/9nuQ1gobLHqN7b2m+Z1ZAiJZB5VTmG0UR1bh4zUZ8sTotiWPAUAx9iLOsF0v9cvXJ/wpfxOmK0CCv1n3agTgxprRgDs2Sl2+L3QSw2NtON+Y+RvR+WQy1/yaimtCl0w8W+L1xZvLNJlhQ7ISfGBUzFZijCJlzkhMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1c5d/CxbCBnWNuacC/vR20gHaaPo2SP/31MwWI4FS4=;
 b=ECC4ENeIDKCI4sCOYpyhNivNSdAl+7AThB6DCqPPvhbUM+3H8aEV2lgAsgHC9hCXOWfOp0AlWwf+8jUkAY6P4HOopFNRFzt/sePdc2MVJlulit4wlE0rYe5/FlpslWt8CpoGKxZuxOCVbdlAJFm/kPVW8hH4Xkqu2HAcf+MoE3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:36:56 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 06:36:56 +0000
Message-ID: <da24f543-fdb7-880b-addb-c5a21787cc54@amd.com>
Date: Thu, 14 Apr 2022 08:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix one use-after-free of VM
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220414050348.8888-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220414050348.8888-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1071ba4-44c7-448e-f266-08da1de12bb6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4646DB2120CE775B66C3600383EF9@CH2PR12MB4646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we92movVxDgBWMHzDEct/QMHX/FI/Min14njiG/mNNdjNkYOwt75ct7OL4E+veQorPPBlWf1lwwr1y4njoLbwmc2g0Q1l7780/kF7db+IoXo4lfNxpFzjkHXKcqwfE+kJDThXbddAg26PD0ydHarBLsK94H17PzqiU4KGBKu0idtP7Hz6Jt0D8zRotUfXB+LGdRGjGTRrqyT1rwuGEEbO/LBt8aShgGRrvsFqQMInP05q1AR9xE2c8V3KST8XZQWSXmVcavv5ZHzsikJ1kkH7wS4Id8RDB5EhFOWQ0BZmpWNbT/QMx7RNlJapJvpYlqbcSdV3PnUy9Ws+Ss3RL03s/rkJLdBz+ovXvf0gO2JlyXbR7WFdhA2xBg9bFEULm7Kc4F3BZK1y92ZbZOScNth/8GLOtc6BUvcAvUPloHNkixAtDAwSdY04Qr6YboLlzfdtRxJ0/SWwB9ZlMPz1MzRSlVnoV+RQi4pkA/TLrHzwWNOGkDdtv08Pl945X3o5DexGewAQlHy2F1hmCPQ7Xn2OrfKcVF6/9JsTlnyyXdPoWIclpdGrPm3Cr/sQcf/s+IPwWKc4OZk51YbKkkkDQbI43v8+rEqhrt8BbCXwbiXiFLAgYiIUNdTwwspASMwkFlCyME1OYG6JvcLWZ/q2+y5EfBsVr/MSAtx53wZOHBoRMiAU4J+sPcoMU4qXisVNI50S7bEywf73IbPRTSUV3Itii/z6xEGJG1SXmGl+RJK0/R3Nerw9k9cXjH0kFLqMlGy0Sc2ttKZ6SgePoaWGsH+zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(38100700002)(5660300002)(31686004)(6486002)(66556008)(66476007)(31696002)(6666004)(8936002)(6506007)(2906002)(508600001)(186003)(66574015)(316002)(8676002)(4326008)(6512007)(66946007)(2616005)(36756003)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkN6VzhmVnV4dllPUVh2Q085a1Jhbk43NzNoWXYrd2FwQU00VzJxdER0YmtR?=
 =?utf-8?B?WmpSMGtFNDNNcUlEb3Z4NmExTGZnSXNQajJMcWhtQ0RicitoQy9iMlpCUXdK?=
 =?utf-8?B?WGZYQ29ua0QwVjNJR2dPN1AwSXZvYWJlMk9GdHI2OU1ycnlJSDc0STdLSlJL?=
 =?utf-8?B?TW9tUXRqY2tmdUk2NU5PMVROR0IzZGt6aVVJcm5BZTJXbkJmZklXQmpna0Q2?=
 =?utf-8?B?MmE4RDBULy9PcUo4V3RrdTZIeVNLeWNwWk9nMTNaRHZhWndTV2wyTzBvd2RW?=
 =?utf-8?B?ZGNTcEUvanVQZUtKQ2k2eEE4T2VCVzRsb1pUZ0FEdlVWcXd3WWYwUDRDUTlI?=
 =?utf-8?B?bXFVcXFhbnhSSk5mYVRBbmpkY0t4UXhSUW9Ea2Q2d0NoL0xvY1FEV1lmZCt6?=
 =?utf-8?B?WmlmNEh4NldjRzFaQlpQN3hxbHFVWXhQOFBWYTc2L3lRNzFpRHRYNVorb3N4?=
 =?utf-8?B?ZVRJY0l3WWhEdmtJSGlBNlZGd0FnTHNmbzRKM0VNRkVhU281RFd6M2hkUzVt?=
 =?utf-8?B?eUoxQ3RBZ3QraFlIREpGTkk5QnRHdnFkdnN0U3AvSTJHOEJXdzNwdmR2OGFO?=
 =?utf-8?B?MWpLOTEyZ2I4MXJyU1hvRnlyaVNpNlNSdlJobC9nOHhwaFp4NHoxQS9TejZl?=
 =?utf-8?B?Wkg2U3lJMjB6aDJ6YmJGei9XZVZXdFlFQzNScFo3dGhxekdUQWJLZEovVm9X?=
 =?utf-8?B?UjB1dDNlUDFscnJHSEQvakJzZnRmbW1BMCtpYXBWUzN2VDdwNFZpMm9ualBu?=
 =?utf-8?B?V005NnRjN2dJamorTHFLQ2IyN21pVE9lUTZWcURiUm9ZQ3hyaUFCN3hCVTRx?=
 =?utf-8?B?T2p2WlY2Q2FWNURWNFUzdlU3SFRIQzZtYXo2dVpFRDN6eERYd3B0ZXNzcTNW?=
 =?utf-8?B?VFNqTVFlWnE3UFVuaTVGdWVIcGZLV21XcXduZ0tmd3RUN0tmUjJ4NWkrSm44?=
 =?utf-8?B?WkpKZlVRdCtoNmk3Z01uVHduNXJMaWtVMkFMbTVFcVNIWDk5bmVySDBwL2I1?=
 =?utf-8?B?bWFMUVZETG93L0kraTNReCtyenBMMUJLK1laZnkwZmRZOThqTk4rc1pzTUlM?=
 =?utf-8?B?VkQwUHZKUVVqbFdoMllqZEFqNjhISld3YlRKa3lPNEhtVmVqemI5NVVSaHE1?=
 =?utf-8?B?aWdKWlFUdlBCcCt6cisreFlBN0l2cThuWVdrNHZFbTFLWnpyeW1PTWl6UXNQ?=
 =?utf-8?B?Ym9pL1VVNVNPM1FPZUVGbFlnWGREaHJxbFg5QTZuRm5FbGoyanZqVVkxWFBJ?=
 =?utf-8?B?bUdkMWxxam5zU2d3WmM2RWhZQ2ZCelVIYlhNamI4YytYMVFFN1ZXWlhRVjI1?=
 =?utf-8?B?Vmc5L0paUXowdjBFWk93T2lodkNzOGd4WERRWStSUnZ5ZHBYay9nbG5YUmdT?=
 =?utf-8?B?b3JFMWU5andycW1VblpjSlhrMGcvQml1RUNRMTlCT2thZVYyR3FaSHU0eFNS?=
 =?utf-8?B?TEl1UndIODRsalA3K05zMVcrSS9TeVpqTDlvWlJYbmRXWXdCRFRZV1RWdFVI?=
 =?utf-8?B?S0RRYzdMaFkrOVUrRldQdGsxazZRekNPK3NUY2FsbHk4SStNWTJnbDlEbUZX?=
 =?utf-8?B?MGJ1QXhUbmZ4dnJjdXdieEpPK3hyM3owRnNveUdyTUJmdXBUR0VPdUhrRnBG?=
 =?utf-8?B?S3VjNTkyMkNkTHVsK2xKT25UbTJlaWJvOWVMZXBKME9scS9GSWYvMzJNcnQ3?=
 =?utf-8?B?QWRDK2dwTGhnOEZUY01uYno4bnV4cUVMblM1ZER3bStQOWhiMWo4Mm5VdEVR?=
 =?utf-8?B?cnJ2NU4zdThTOWhoc2JIY01jVC9qRjV4RU81VzRKK1pNUzh1K01TSkZ0djZK?=
 =?utf-8?B?K1duQW4weDJESWNES1hrU25oOE55bS9xcWZEQitGTWxKVGZzcG5UclA0Z09s?=
 =?utf-8?B?MWdvZmJ2cjlrRGV5VHNaTCtBaGFMMXovZUxLeGZ5bmEvTUs0NFEyZ0Q0ZUdz?=
 =?utf-8?B?Z2k1TVIyWVVBdHBWUG5HR2RPRVV0K1l5WEF4Um04a2J0OVFoaXBxZUF0aTYx?=
 =?utf-8?B?cE0yMFhFOWtraWlrbFpTM3FoV28wTFdyUG9GcEVlRWVzdEE5RWRtRitUc1pO?=
 =?utf-8?B?Y3BtVWx4UlpmNDFnMlZNSTRITGdhNmVqUEhLdWFhQWpKVFJBWHpjeXB6UTlG?=
 =?utf-8?B?dW9MWXNMUTQ0bzRZYXdNRXVmdUZ6Z0V5ZGVoWFBEWGNFam9adUpwNjBWNWxI?=
 =?utf-8?B?Unorc29KZjhXSDFkbjRIbVJJYWpNUGdwVFgzL24wL0FDRHphdkZMNnFyTzNr?=
 =?utf-8?B?ZzdQWDFqOHEzVllhZUZuRk0zOFhWejdCSlRQbmZra0ZJUG11Q25iNnRiOW0w?=
 =?utf-8?B?T3hya3MxVitPdDd3K24vaWNZRGtQS2syZElzQ3Vqb0FNclM1K05zL3lLMjFN?=
 =?utf-8?Q?4/MISyVC1YjtoYrp2HKBYlFOB9taniqFqaK/2JtuHFoQy?=
X-MS-Exchange-AntiSpam-MessageData-1: lv7XCowR9jZRnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1071ba4-44c7-448e-f266-08da1de12bb6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 06:36:56.6947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OXGngcx9RcFjM1A9jbIB5sbwfCZblWCE+6HFHo7Qy/8H28mxhhgKv/Wat8HJe53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.04.22 um 07:03 schrieb xinhui pan:
> VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
> We see the calltrace below.
>
> Fix it by keeping the last flush fence around and wait for it to signal
>
> BUG kmalloc-4k (Not tainted): Poison overwritten
>
> 0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
> instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
> age=44 cpu=0 pid=2343
>   __slab_alloc.isra.0+0x4f/0x90
>   kmem_cache_alloc_trace+0x6b8/0x7a0
>   amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>   drm_file_alloc+0x222/0x3e0 [drm]
>   drm_open+0x11d/0x410 [drm]
> Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
> pid=2485
>   kfree+0x4a2/0x580
>   amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
>   drm_file_free+0x24e/0x3c0 [drm]
>   drm_close_helper.isra.0+0x90/0xb0 [drm]
>   drm_release+0x97/0x1a0 [drm]
>   __fput+0xb6/0x280
>   ____fput+0xe/0x10
>   task_work_run+0x64/0xb0
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 645ce28277c2..cd5aa7edd451 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (flush_tlb || params.table_freed) {
>   		tlb_cb->vm = vm;
> -		if (!fence || !*fence ||
> -		    dma_fence_add_callback(*fence, &tlb_cb->cb,
> -					   amdgpu_vm_tlb_seq_cb))
> +		if (fence && *fence &&
> +		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
> +					   amdgpu_vm_tlb_seq_cb)) {
> +			dma_fence_put(vm->last_tlb_flush);
> +			vm->last_tlb_flush = dma_fence_get(*fence);
> +		} else
>   			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);

One style nit pick here: When one side of an if/else has {}, the other 
side should have {} as well.

Apart from that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>   		tlb_cb = NULL;
>   	}
> @@ -2094,6 +2097,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   	vm->last_update = NULL;
>   	vm->last_unlocked = dma_fence_get_stub();
> +	vm->last_tlb_flush = dma_fence_get_stub();
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> @@ -2132,6 +2136,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	vm->root.bo = NULL;
>   
>   error_free_delayed:
> +	dma_fence_put(vm->last_tlb_flush);
>   	dma_fence_put(vm->last_unlocked);
>   	drm_sched_entity_destroy(&vm->delayed);
>   
> @@ -2248,6 +2253,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>   	struct amdgpu_bo *root;
> +	unsigned long flags;
>   	int i;
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -2257,6 +2263,11 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> +	dma_fence_wait(vm->last_tlb_flush, false);
> +	/* Make sure that all fence callbacks have completed */
> +	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
> +	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
> +	dma_fence_put(vm->last_tlb_flush);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 1a814fbffff8..6b06a214f05f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>   
>   	/* Last finished delayed update */
>   	atomic64_t		tlb_seq;
> +	struct dma_fence	*last_tlb_flush;
>   
>   	/* Last unlocked submission to the scheduler entities */
>   	struct dma_fence	*last_unlocked;

