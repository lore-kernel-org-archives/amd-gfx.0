Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C6C3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 16:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A00B10E366;
	Mon,  2 Jan 2023 16:01:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE59910E366
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 16:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXIU9rKH+BfJVQQ6wfsPCWU3wRh6K2V67aILNXk1pVhtNKONVCmPe29Lcg/DpCx1f4O3kezm4JWCXsmJqyudl6dQs5KPJvLYhpHrPc5NDbMNuHs8qShBBemWP2dNx2mCEO5gWAefbSyGwfaIJTSe94JHZ0hmgeYXSZBUQL1ocGvh9WOV0auSrBa0wLOFQMYkcj8GYpSqMzimw91/zR6h5qAaDkG6khaEUcCkYWCWjaqZmxFk2zd0Xj8wKfHLQOSCh/+ZvNfJG3Jod5B4M7oJp3/lCpZ4hktqlBvPyqc2TBiIWpYwbotriB8PNlZw1nZ7IAcQ4epqyLUX4CROgllefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyWzjLg4r3irBSPqu9mViY3X6AEYlrPHXUKf+DiS5IQ=;
 b=h99B2BbMi/64jJtQKckKin5bE26Kw5aZh0LWdLkxDbCtnsVZcvkw1rXIR/B+ID0L+JyZ8L/oayWIZyWaeA8HEA+tf4Hyp7DVcYHrpRKnUGDXZEKBT+LpxQ5jK9dWGp4Hs1UBySEeKY60PHj2DypemzvEDx/qQv2MU9S8FZzQduSxx+v8l916yBAtb0KvPomciyc4Xj/XslDxvQAgozbIlvKVwrYaNZv08Nr4FoCKsgICAbGhxGGghnxG5QSgubi+txh3yxceJ3HYx5gCZ6gmm8lH8Xv1NUW2jmohCFQ1/sMbpNJT8MpRuZuhe9SUdO0Kpf5dnekMUfWTMhol198k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyWzjLg4r3irBSPqu9mViY3X6AEYlrPHXUKf+DiS5IQ=;
 b=rUdxD2szt1bxo79clcW0AxM09oybhNwIJAheTrk9PHkVLdkyUAMvIupdPdNMCO41wQ43I1sRl9yeUtkPOEpeGZoBIXFGJjrduBQrijUhdlfrhcXrh90dsqm8ps2G61PppGUrfrBbRYCrG085o548TvF0Z0r+ROMFFM69ijjUOaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 16:01:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 16:01:42 +0000
Message-ID: <f6cc283b-e4d0-4be8-2ac6-d6b35a5f67e2@amd.com>
Date: Mon, 2 Jan 2023 17:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: Add vm->notifier_lock
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: b963296f-aa3c-472f-bd77-08daecdaa3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlsRk16rt80eGrufkIduMiN2z6UU9vuR2Pm3iESr19wEaJWKO1BOvTksSaHjEvfQdBshzcuUYyx+4wCSc0s7NdUKosZQuMOvhyFqt2++zOi44Gc363BnIYSx4c4LuNLf1FiLJx1z444/R0Q1O/WjH72LQb2JN+hiX48mq0jkPQgLbE8T70Sd0NcSVFyxeSex8VsO5Bc/0yZ9QbEK2x17HDvNZsMxFzicnAO+1AypM3ENDEfIXLU3i0JNO2q5lg6YnU3RvZzdNP9mhure1l968o8908FYdcjb1x0lXNs7XD4/HF+aMDHMOAq6Y1EwmEvccMVcGUjCkvwU/ZPlFUBPJOj5bcd1ThB3OtyW6WOhjBxP927ME2hVnVKJNvwBDaRGdFjkSFu1yvZXsrNuShG+hYZVIKTL05OESNVlNlOpfcfqqsGO2I9T0zh1/DNj+ubZ8rMYie8rOnWWzsfewL7o6iYZa8tV2zwE+Aw6/W0ijf3hhFjvaoNSt377wkkYr/4blzaZo8xZU4mFwvVKtISA+zoB0PtIA5yJUGyHnyHZfWHY0gtUtcOudZo/69VZyF3nvV/s0lI2tNTwjRFlgJwa78tvTJ+UrvJqqQTWnsj+hVmDY6UFh93WTPsn8QLnRlIpjF27ycnH8hpFeYWgbJMX+XXu7rp6bWW7mmuzNJ252RJNTNZ2fGumzBrnBgDTrExxJ4dso6CEJv7KnFHXzUG0iYpPo32n252DaQx+89ctJz09hGIsTQtEJnc8clgcL/8qa8frB1pjqR0qMdCC/ftE2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(5660300002)(2906002)(8936002)(31686004)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(6486002)(478600001)(2616005)(6512007)(186003)(6666004)(6506007)(83380400001)(38100700002)(86362001)(31696002)(36756003)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNQTHFKZ3dWM1RaWHNlU0lHRjhnLzdDUlNoYnVLWDFMTEE3b3FOQTZaanB5?=
 =?utf-8?B?YndDa1lZV1huc0hPZDFLUUxwS2gwd2NIMkdabDdkZEVxSzFFYmNocUw3am9H?=
 =?utf-8?B?SmtnWTE2dWhnVk1mbVUraFNKYmFwYURnK0t6bDRBMmVKMGZyYS9tNkRTNUg5?=
 =?utf-8?B?Z0ZUOStDSW12MStMUC9jWkxXTjNERUd3dElsclJrazZEc1phcHJ4Um5WaGlk?=
 =?utf-8?B?KzRGOXkyRG96WmJTTGdnRGVFUnJzQndkZWluN044MExnazYyQkxBTVVwbzBp?=
 =?utf-8?B?a0tyMjlVTTNTRWZuYXpWRm1FUTU5c2NBTDFsdjhvZ1M5eDFuRXZReXBQYW5n?=
 =?utf-8?B?cEJ3RWlNSkw2QVFsWG9sUm5rVndRdWFMbzA4aEVsU2hHMVZyUk5lNjdIYks3?=
 =?utf-8?B?YUQrNks0TzczSVJxREFRdXp1Zng5V3RXamR6bDFKTkJNMGxWNytNL1VDcmox?=
 =?utf-8?B?VDNKSGFnL3ovandUMkR3MkplSjJyazBlcTdqWm82bTdYZ1A0MSt0Y1o2Tzhl?=
 =?utf-8?B?OHVGWHBlWXRDNklkUE45RXhFcVZYUGhlWG1zU1FqRG9aU0hURUhaK2ljYm8w?=
 =?utf-8?B?VHlXOElFUWFqbm9LdWM4cGRSVHFFeHR6d3ZSN2JOR2pEUGIxU3JTZnFOMUhh?=
 =?utf-8?B?UGdPcHVMMFB4SjRVOHEvVTgvYmJITkVvcktGTGRNWjErR1dQTlk1SDlzSlla?=
 =?utf-8?B?cXZsV2RZV2Nldklxd2JmajZIazZWSnFlVktXQ25aRWcyb0IxRDVtb2dnenBk?=
 =?utf-8?B?Yi95dVlmOE5XZjR4dWtnQnZzSlk4NTJ5VEJCYUxQdUdIL1QxZk9yYThhN01H?=
 =?utf-8?B?NDBVVk5mOTRGalpRb0FYa3EvMzdoQTh4MUVGNS9KdmJWdkVrelFiS1lMSkh5?=
 =?utf-8?B?dDdVdEZzTUxNOWxWQmxxM0pkODAwWEZiQXJLZkZWb09hTk8rLzJGZVpIVUZa?=
 =?utf-8?B?QXVPU0Y3bGxmVDcyaDNxRkZKOVczUTNyTG5ZQUxmd0pOVlNOaW9mNVNGbTBC?=
 =?utf-8?B?RU5wVXdCV0dPMFlEWTQvdWFCTXEwMkVyaEVyTGFBUEl3UUM4dmp4N2h3cTE4?=
 =?utf-8?B?N2hrRXQwRmozSDRwdU94dDhUeG9uWWRVVXh3YTQ2MmsrY0oxN1lBSWROR0Rx?=
 =?utf-8?B?b1l2Vk1sbDltVldFSHZKYmdzQ1drSTY5U0Jhdk5PRVlBVE1sVVNhRHVDdStF?=
 =?utf-8?B?VkwzOXRZbDZBNnhsR0V4ZDROZC84UFdWR3NZNjRaMmFmMmNZaSswUXYwY3VP?=
 =?utf-8?B?Q0ViR2IzVGNycDdITHRkQSt5eERKdHlaSlZnYXNtRm1GQjlzaG1BWUtPYWl4?=
 =?utf-8?B?SEE0OEtyU2NCVVlEMG53Wkg4TGJjUjV0bG5qT3U5OFcyOTROZUxzUE0yaUNE?=
 =?utf-8?B?TEhxbVUrNThybVVSQm5FR1dGYU9DNFhXRVRhTThSTko1WTd5M2FIaUlZdXdI?=
 =?utf-8?B?L2kxWUR0dnR5eXRuc2R1Mm9sK05CZkJiOTBnbG5KUmwyejVrTHNVa1p2NVdT?=
 =?utf-8?B?ajJXYTcwVXZpSXdZeHNabGpHMkF6T2pYV2VTUE5xcTRMejdydmdHNEFRclZh?=
 =?utf-8?B?dUJPNm5pK3RFRktORWhZTkVlR205TjVxV2ttYlJvVndyclRwOFcycGlZYnI0?=
 =?utf-8?B?YVA0cXVNU1E1dElHZUpoRmRZUWg2Q2hseHJWdlI1c0x2dnBtaDJLbkRQL2RP?=
 =?utf-8?B?OXFjTHVrakZCeFZxb3ZxMDZzOGZWUGJwckY4SWo0MEhheGlOTDRhMGpCdVB6?=
 =?utf-8?B?SXlLNG9OTE9HM29GS3Qzd0FheHhlOVBhZ1MxdGhCQjFFZE1kcFUwUTRDQlVs?=
 =?utf-8?B?NDkxUUlpYUp0OEhtb2JId2Q0Y2pNZXhTVi9uYkxKMWpDWndWZGF2bGgxanI2?=
 =?utf-8?B?VTFUOXZzRm1oMHVSVFRvcnk0ckwwL1BnQ1ZVWVE5b1lDVjJCdTA2b0V6SDI1?=
 =?utf-8?B?OE1KdUhyRVBoUnZmbmNNY0Qra2VwNmJCMDZWSkRWQTlxTzJVRHlyY0g5WmM3?=
 =?utf-8?B?OEJJaDlFK01zdkRUQUU3dzgvOFBLbXBJSmpSZ1pxWUtZQXJtLzNuTzBOUTF0?=
 =?utf-8?B?VTZ6SkRvdGdjcWszL3V5UHNSR2JnSnpKdGJjTzBkRFo5YlJ0dTVzQ25Zb3Bx?=
 =?utf-8?B?dEJQMjFmc0QzWm5SWjF1ZXFIajZOSy85eEVXUG52dk9LcGRtOEVuNHdoelNi?=
 =?utf-8?Q?iRPRp8k5rZTCQEQmaWa0ryfVcivJe88Zzo2WfR3E+tQE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b963296f-aa3c-472f-bd77-08daecdaa3ed
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 16:01:42.5357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 577GyYNVB9+uB+b4OeUd2TIY6cddC9tBht4tLElujTQvRe14Yz5EKYXpsNMpJQB1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.12.22 um 00:27 schrieb Felix Kuehling:
> This points to a mutex to serialize with MMU notifiers during page table
> updates. For graphics contexts, the notifier lock is per adev. For compute
> contexts the lock is per process.
I don't think mixing the VM code into this is a good idea. Instead we 
should expose the lock function to code outside of the VM subsystem.

Regards,
Christian.

>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 3 +++
>   3 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b15091d8310d..7aaa844a8284 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1325,9 +1325,12 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   
>   		*process_info = info;
>   		*ef = dma_fence_get(&info->eviction_fence->base);
> +	} else {
> +		info = *process_info;
>   	}
>   
>   	vm->process_info = *process_info;
> +	vm->notifier_lock = &info->notifier_lock;
>   
>   	/* Validate page directory and attach eviction fence */
>   	ret = amdgpu_bo_reserve(vm->root.bo, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dc379dc22c77..a04f7aef4ca9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2075,6 +2075,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> +	vm->notifier_lock = &adev->notifier_lock;
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>   				false, &root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 094bb4807303..07af80df812b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -251,6 +251,9 @@ struct amdgpu_vm {
>   	bool			evicting;
>   	unsigned int		saved_flags;
>   
> +	/* Pointer to notifier lock used when updating PTEs */
> +	struct mutex		*notifier_lock;
> +
>   	/* Lock to protect vm_bo add/del/move on all lists of vm */
>   	spinlock_t		status_lock;
>   

