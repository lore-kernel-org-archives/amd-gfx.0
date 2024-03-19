Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF2EC54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 10:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B427310F98D;
	Tue, 19 Mar 2024 10:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/A8yiuo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157A310F98D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 10:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ohACPtVDcANSWuwD4Kw1iuKw+gq1Om29NHVcmy7TZxxNpuDvURdpEIAFmGn2r1YxBHNqW/sUNjFSXmbSfHNmfD6Ve8oXf9XTZEKqU/L3y/uTw8QLqxhqmWLegvejEaUNZ+4KMgMWSWAhMQPh+N6vS4wWT2ViIWEw4YTynFD0i70w1XRcJCiJpYSakoCQwYwQQm5JxEZL6eQntbe6nF3Rxul+5xPmBnjBOQQDvdWMJnGrNHK92NzFzJHl2nXmOo5t5iTpnoIdfglDkzS+MXQhwcLkmIOmF07ITsaCJyc4NfRJsKFpWg6Rukq2VGS2/owqjS7aMMPbIUEZww6I1fROBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OA6BBLdnqYoPx6vba9QNHSd0Rv59naJUq651ObXEKk=;
 b=DaCUIjtrRNBQ/TZuUe3GqsPRnF6jeJeS2MA7Xyj0PkL0g+eHMoh35s2c2vZR/3lo1LaljTAla+KdzchuTTnKtF2Aj0TWNkeU3cpKSueB43NeSEbyZbbbb4y+w99MqJYxkUfeP/mFnYgQ8LfPueOjw/byLe0nfBTH63qdB/D9olxI8R0OKVaULEb5APmqSJOjujaZVvXfDo6C/shsEy7pxa7uFuaciIUz/WYePXh+wqI3ZDUEYghGxUIUxjs6E/hAy2ZTxCSBFnevsGVMN9/2myELiQ0RCtIOKOmfjPPdi3yBcFot78SdzfmqitdX+hiStCttIQ6QnIjg3gCeVhGALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OA6BBLdnqYoPx6vba9QNHSd0Rv59naJUq651ObXEKk=;
 b=v/A8yiuoh0bJINyI5mLT85xd1Ymx2yJKn+5vXVHgkQzcC6rspQ3K9F1wLtGxzcHIb2W/58EjFVkyRCViacJiBo88QJFx6xuEF8TWCSpQKq89HYSzjOeoOwhFO4LV/0F7g66fX8LQ5O2Hfh3zpGZiYW+gCIlj5+LbnLpXUpRCLT8=
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 10:36:24 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2%6]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 10:36:24 +0000
Message-ID: <bb61fc11-0a2a-4b3d-80c5-ee6f5a6ed098@amd.com>
Date: Tue, 19 Mar 2024 11:36:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240318161140.2101-1-shashank.sharma@amd.com>
 <20240318161140.2101-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240318161140.2101-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB8972:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43FsNqUGS0fK0UWvx6mmfM327QKMSK3GgiwusA+47ccLKIxt456gZpVRYUp6gTaM3+HBL7HvKDPghU21n315n0hQSqsXTJRB0gOOs0h7r7O9yQ5WgLwPD62mkhNWOpmSFwFUoGmnLiha3IyWtDXvPtgIwNQUikExvnLIAu7vdwBgEfefe/7HrbHZNr0w1wirBmK+sAXEaLkqt5zjIX38KfNGoQ31xlulk+BM4u9NuzXsFL1IMBSUClkKksOeL7AuoRufEomDcZCxvKK+TO0Z25+BPby19BkMUoXKJwiilB5Exk4UgkUt+91V464J2XRKZ+t9EqWMCL2VBI1Gv4HHNviN4y1CN42wHYsm0IeUxctqwITpfgGYLlsrhJXc5SrslBP5NFavdKxET9r1HiQJs4Nln3A+PHrXX5R+lZT2SgMmd/D8J08yES0L9GZiIAarqCO81nmEtu5sDDAKjXyM5nTyQ+axxyOlgQtW83UBhW74NHo9QQfv0Xhs5qMH7CYmB/MteK+K/P3nIo8z/ErW9rcocfLTNYoDGj3hb6myN/BrFs0jHLbNmTrUa1xsF4O89YnAI3rd3nZu0QspltrfwzNv+QI+A/66pow+eFl0veslQIDimhCYPn1KmEln+RZS++55mr3vuvfe5pmqqiJRlHaOM7QzOwO7y46uHly1cXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BBclhWU3dZNHdsTUhmWUhlWGFyUEVrRXZTQnlFNkczTU5yeFRYbWZSWFRS?=
 =?utf-8?B?VDE1SXlpWi82T3ordU40R1QrWS9RTkZmU3NkSE83N08vMlVQTE9CdEJsekVC?=
 =?utf-8?B?YUp6T3dRMHFOVjN5RjA2dCsza3N4Smp1SG16TUdZc05mZkdzV2swTXFMWUl4?=
 =?utf-8?B?VStvZmhnbU9qd3hzamttV0xIb2V3bEhxMDgzdjBXVk02VnRmZVhaRHc1bFMy?=
 =?utf-8?B?SEE3RmZyZ3c4UHFFSHJaY3ptZERHQlNJTWN5ZUNOZGtMQ2daUjgzSXdDYkxK?=
 =?utf-8?B?eW9wdGt0dzBMenFpZFF6eTNHU01Ec3Q5QzBPT21Pc1VneDdPNmxEUGNKcExu?=
 =?utf-8?B?QzcvcjA0VVJHOFk4RXY0bFFLa0x4OUxJNVBKTk5ZMFJ6WUJwMnlzSG1qS05R?=
 =?utf-8?B?eS9BVVZJQkFjc1Rxb1BUZ0FLWGxtSU14bG1kVzErMTJCaFdDYVNyNHpwVTln?=
 =?utf-8?B?aGU1ZzZKSmRhb0NWK1lHTmlJVXl6aGlEalY3cUMvQ0lWamZiUEVzRzZiT3ph?=
 =?utf-8?B?UDdRamZ5QmVYaGxFRlFiQnJzc1ZUY1dzWGJvYTNZZWlpaHl4cnZrQ0paL0Vv?=
 =?utf-8?B?czI0bFhGZk1VTEF3NTBWOTRuZHVYbHlqaEpLVzMvOGtqa0V3WmhBN2RCdysw?=
 =?utf-8?B?VE1QcWRqMlhDUXd6SSs1UGVYU0hiRTZ3YlpyZzBLaWZmaEplN2hKZGFqbjBz?=
 =?utf-8?B?WlMxQUNlK0ZrRVdLdkFYd1AwN3dxdm13N2U0NGhRcEpNR0NYbU02T1o1Vzht?=
 =?utf-8?B?Vm9rUWVsRjdHTllrY0YvWlRzSmhhU3dCRXBVcnlNY2p2Z1RuTnNBLzVSb1M5?=
 =?utf-8?B?cCtzTlQ0OTU2VWtlNlF0YTZ4QmRFVFZmMWdMaml5c3k1eUR4YW43SlMrTlEz?=
 =?utf-8?B?SFlldDh1VEljMWNqNnFmRmNsL3E3NUU5RGRBc1hkQXBUdkVxbUw3OXprSTFx?=
 =?utf-8?B?UXJkOS9JaWsxM0lOVlk1RmI4VzlaL3A3QWh6WDVDeG1UMk10aUFiOXU5dTlK?=
 =?utf-8?B?aThpSmxEQzFWME9FR21IRi9lbXdpOGpOSFk0YWk3UjF0ajYyTko3VHpFVDE5?=
 =?utf-8?B?UFpyTEh5ZU1pbm1wL1dkWlphbWFRbDZYUHBrNzRlTVg1QWEwT2hyVDRUd0dv?=
 =?utf-8?B?Rks3K0QzRGVhWXN1MlJtYTVyRnFiSVJOeEpYbmd0RmRBanFPb0ozS0tVUG9o?=
 =?utf-8?B?c3V1UXA5MndRUGhTVFlQUGVFTVZoK2FSRy84Sy9MK1loTUZFdWZQclR2NG5J?=
 =?utf-8?B?UFdPWkkyREpBUHRUcm9ZejViMS9kMmwxWnRxdE5WQkpEZHpwOTFVajNWa0d5?=
 =?utf-8?B?cFBaWUpMYU1SeU9lSkNTMVRTY0hBSXQxcXBFZVVyREUwa3R1Q21IclczZTFO?=
 =?utf-8?B?dWt6eU4xS2dUWkxxYmhsNlZCL0orR2hqVEdZNnkyaFo4OVpiRFMxcnpvWnpa?=
 =?utf-8?B?V25sNmtkWEk1Y1dtMko0Q0xudW5CUHVETlZVemxFZ01FeEtueDJMc2NDdmZV?=
 =?utf-8?B?STErZmVqYUxBM3FEVUxuR0Y2dnlBZ2E2SkdRVnJJMEJpMmwxMzJOa01ucGd3?=
 =?utf-8?B?REVGQmxxM0dlYWdCcnhVTVVvSHZId0FCOWNiRTZsbDJHMUVVMU5IR1c0cHZO?=
 =?utf-8?B?cmk1d0s4dFkxU1Jpa0NGcXl4SFF4SW9JMmltQlVqTG00SmJhZ0xrZW95UE56?=
 =?utf-8?B?NlA1cjVRSE1OZzZhN2NxMm4vRXBmZkQrckMzc29odnA1SXlpcVVIYVFtWGpv?=
 =?utf-8?B?VGt0ZHFOWXR5Zk1JcG55cGFRUHZIR0NxdzNZSm1VQWFEa0U2MEFxRWppRExs?=
 =?utf-8?B?SDNGQmxWM3F3WTlTTmNVLzBhVVdkL1dyMjloTDArS0M2VGVRSWozYlVBRTFI?=
 =?utf-8?B?UmhDUHl4OG5BVlBrZDNJWUo5MU1XdjI3RGdqUmtWL1hrL1FobG5ZcFFoMHJO?=
 =?utf-8?B?M0lLLzBHZmNndTU5c0FKUW9OaDZmZi9vcVBURU5Mb1VzRjh6TVZKQnQvU3FL?=
 =?utf-8?B?NUdTUy9QZ2V5RTVTcTRyMURlbXBUWnB5UFFtWUFMQlE5MlZ6ZkZxeXVaclhL?=
 =?utf-8?B?UVovaGM2dDVWczFYMkVKNnp5aDRiQW1xL09VRWh1a3dPZHd2dlRVdWhudWoy?=
 =?utf-8?Q?HC3dt3Xu8xJXFRCDMwI5PjgHA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f2d5c-f14c-4c00-dd99-08dc48006c7e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 10:36:23.8754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8PCCeXAYAHd5vUhOq7urV+8aShLV5dPhPt8VZBKgfc3OfvTXR6qNZaoRvzTczPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

Am 18.03.24 um 17:11 schrieb Shashank Sharma:
> The idea behind this patch is to delay the freeing of PT entry objects
> until the TLB flush is done.
>
> This patch:
> - Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will keep the
>    objects that need to be freed after tlb_flush.
> - Adds PT entries in this list in amdgpu_vm_ptes_update after finding
>    the PT entry.
> - Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)
>    to simply freeing of the BOs, also renames it to
>    amdgpu_vm_pt_free_list to reflect this same.
> - Exports function amdgpu_vm_pt_free_list to be called directly.
> - Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.
>
> V2: rebase
> V4: Addressed review comments from Christian
>      - add only locked PTEs entries in TLB flush waitlist.
>      - do not create a separate function for list flush.
>      - do not create a new lock for TLB flush.
>      - there is no need to wait on tlb_flush_fence exclusively.
>
> V5: Addressed review comments from Christian
>      - change the amdgpu_vm_pt_free_dfs's functionality to simple freeing
>        of the objects and rename it.
>      - add all the PTE objects in params->tlb_flush_waitlist
>      - let amdgpu_vm_pt_free_root handle the freeing of BOs independently
>      - call amdgpu_vm_pt_free_list directly
>
> V6: Rebase
> V7: Rebase
> V8: Added a NULL check to fix this backtrace issue:
> [  415.351447] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  415.359245] #PF: supervisor write access in kernel mode
> [  415.365081] #PF: error_code(0x0002) - not-present page
> [  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
> [  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: G           OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
> [  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS RMO1001AS 02/21/2024
> [  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
> [  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 4c 89 ff <48
>> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
> [  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
> [  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 0000000000000000
> [  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: ffff888161f80000
> [  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: ffffc9000401fa00
> [  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: ffffc9000401fb20
> [  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: ffff888161f80000
> [  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) knlGS:0000000000000000
> [  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 0000000000770ef0
> [  415.499738] PKRU: 55555554
> [  415.502750] Call Trace:
> [  415.505482]  <TASK>
> [  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
> [  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
> [  415.519814]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdgpu]
> [  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
> [  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
>
> V9: Addressed review comments from Christian
>      - No NULL check reqd for root PT freeing
>      - Free PT list regardless of needs_flush
>      - Move adding BOs in list in a separate function
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 66 +++++++++++++++--------
>   3 files changed, 53 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 104bf600c85f..8fada1152664 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -986,6 +986,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.allow_override = allow_override;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
>   	/* Implicitly sync to command submissions in the same VM before
>   	 * unmapping. Sync to moving fences before mapping.
> @@ -1076,6 +1077,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		tlb_cb = NULL;
>   	}
>   
> +	amdgpu_vm_pt_free_list(adev, &params);
> +
>   error_free:
>   	kfree(tlb_cb);
>   	amdgpu_vm_eviction_unlock(vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b0a4fe683352..54d7da396de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
>   	 * to be overridden for NUMA local memory.
>   	 */
>   	bool allow_override;
> +
> +	/**
> +	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
> +	 */
> +	struct list_head tlb_flush_waitlist;
>   };
>   
>   struct amdgpu_vm_update_funcs {
> @@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
>   void amdgpu_vm_pt_free_work(struct work_struct *work);
> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> +			    struct amdgpu_vm_update_params *params);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 601df0ce8290..d904fc96ba0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -622,40 +622,58 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
>   }
>   
>   /**
> - * amdgpu_vm_pt_free_dfs - free PD/PT levels
> + * amdgpu_vm_pt_free_list - free PD/PT levels
>    *
>    * @adev: amdgpu device structure
> - * @vm: amdgpu vm structure
> - * @start: optional cursor where to start freeing PDs/PTs
> - * @unlocked: vm resv unlock status
> + * @params: see amdgpu_vm_update_params definition
>    *
> - * Free the page directory or page table level and all sub levels.
> + * Free the page directory objects saved in the flush list
>    */
> -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
> -				  struct amdgpu_vm *vm,
> -				  struct amdgpu_vm_pt_cursor *start,
> -				  bool unlocked)
> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> +			    struct amdgpu_vm_update_params *params)
>   {
> -	struct amdgpu_vm_pt_cursor cursor;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *next;
> +	struct amdgpu_vm *vm = params->vm;
> +	bool unlocked = params->unlocked;
> +
> +	if (list_empty(&params->tlb_flush_waitlist))
> +		return;
>   
>   	if (unlocked) {
>   		spin_lock(&vm->status_lock);
> -		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -			list_move(&entry->vm_status, &vm->pt_freed);
> -
> -		if (start)
> -			list_move(&start->entry->vm_status, &vm->pt_freed);
> +		list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
>   		spin_unlock(&vm->status_lock);
>   		schedule_work(&vm->pt_free_work);
>   		return;
>   	}
>   
> -	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> +	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> +}
>   
> -	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +/**
> + * amdgpu_vm_pt_add_list - add PD/PT level to the flush list
> + *
> + * @params: parameters for the update
> + * @cursor: first PT entry to start DF search from, non NULL
> + *
> + * This list will be freed after TLB flush.
> + */
> +static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
> +				  struct amdgpu_vm_pt_cursor *cursor)
> +{
> +	struct amdgpu_vm_pt_cursor seek;
> +	struct amdgpu_vm_bo_base *entry;
> +
> +	spin_lock(&params->vm->status_lock);
> +	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
> +		if (entry && entry->bo)
> +			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
> +	}
> +
> +	/* enter start node now */
> +	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> +	spin_unlock(&params->vm->status_lock);
>   }
>   
>   /**
> @@ -667,7 +685,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
> +	struct amdgpu_vm_pt_cursor cursor;
> +	struct amdgpu_vm_bo_base *entry;
> +
> +	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
> +		amdgpu_vm_pt_free(entry);
>   }
>   
>   /**
> @@ -973,9 +995,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				/* Make sure previous mapping is freed */
>   				if (cursor.entry->bo) {
>   					params->needs_flush = true;
> -					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor,
> -							      params->unlocked);
> +					amdgpu_vm_pt_add_list(params, &cursor);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

