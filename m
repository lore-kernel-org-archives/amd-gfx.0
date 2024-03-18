Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5553C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 14:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E41510EEA2;
	Mon, 18 Mar 2024 14:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sM6X6zBM";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DC110EEA2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvjE+rTkdkGM6y8Jrv+Znji7vH5+eDN53T1a5iByexhQhwr3N6zglIwp8tAf4JXPo8YkBP5MBXf8oy9SHloizi0QTp/F1ZItpGBJ+OUGegMpPiasj59B4Yljzf2VvUNimcSyfkXpEgDE67lrMsrWnTZWcx6SLZYZc8JOAf+H0fekOmFzCFF44QnDw9BTrXI6c0TSgaK3fM6lWQJ5uijNmsQLCL9gOBQZvF0HSoEOyE7+8Ux3GE9vEAa/hQv18BmVLhgYeE5d5mHrV5iUSzAS+OqGXyN0/D8Nvjm953umiko2VVuEyr8eBudBnKLs/uA+XyxKKiCY+nLtGqbNIqefpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71DkKPAhLTe1G5F6EumU7pRqZSkXbam1QhWpPCzDIqg=;
 b=DVyHKDIUr6A+uW30EqX9ysYAruwDYjkDXQZ7Sf99bLqj4pAibswX5SeXwIkYdGwKq8wSEdDHMcfa50t1kCQPfZTaa/51yOcWIjUWYI3mvtmEmV0Bj6F6Xo7En87D6LkpffYl3fvxj+p+Ti010jT6LiadRFNyDQrIK9g6RgXXWLbEJJG9/a/YivrW5UjWYeCoR4uhbtEydnVKmqe9K6VMi4vay9yjeJVc6ZYRbBoQ+jM/Thjg6ZnJDs9sSY29ftGgQunSLN4wiX379P3IPpOfy3MB4dU+NCXKrStMf+caALetlSM72Kk8Y2g+mPdeVx+7pKzg2T/XeqlujBIqdjZYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71DkKPAhLTe1G5F6EumU7pRqZSkXbam1QhWpPCzDIqg=;
 b=sM6X6zBMUv/Gd70+nJRdqY/ibF/ovZfv960q2qjuu9/Y6HcEaH2FxSgX/XxtFlYMvZjJn/FBgo8CKhE+aULaEOnagsd/9yoZulXCzsYCk55mH72FnZdEZFoHbFldgiv6cvDjtqL0Y3bScj4Z6v6NMAbqbVVEsB29V9Q7CKphxjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Mon, 18 Mar 2024 14:04:25 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:04:25 +0000
Content-Type: multipart/alternative;
 boundary="------------eZNHrdARV0g4xT9PuNselyHR"
Message-ID: <0e729b5c-818e-495f-a479-b48c3177094a@amd.com>
Date: Mon, 18 Mar 2024 10:04:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb flush
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
 <20240318120837.2011-2-shashank.sharma@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20240318120837.2011-2-shashank.sharma@amd.com>
X-ClientProxiedBy: YQBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::41)
 To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7474e1-9c23-40e0-9263-08dc4754518e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zcQ2dmHIsSZSheV4Ohnaj8By84q2YPz5uK8Py53jP2xI0Xy4ds2TWWgVKFbA9reSOEllBhEK4ROa/4AcZADMOLI/JMLqXMKoXC7kk0RvD4zjnz6jBMUhYbxfLm1NgeRL62x5UIPg9xjW53MjR5sIkYsSZFQU7L52MW3baQOo5vxQ0K+v8bTbpSQTVx7t+Krq5Ad64K9NXXHzfMvw41g0w/Al2OYD3u0iRtMuN6E2PbWEQJhiuYuowEpIIXy1MsmaWDUHL7pYbfzkqiktlJaypQosRvKGy0X7K7b773uZMOBjJEIcPRxlV6Sh+DM3Iw7J9J/FtXXUgRF7ykpySGDTmmMeZCvq/OzkWkbL0Qp14zP20Pcy6dHUW3J96jygtR79N6dVVr4O6HOG4SjhOa7UYm/urPDLk/A3BRBpJ7UW5qZDvSIimFiL3bPOozUcM0OjAUSqvDlliBuefbX/xew11FdCbIxF4d8q1XFR+orBCmYYpTcZ9D2EbibVrAldhO0jV6QHr8frNTqa1fHiT8irW9GcHM55XfWuSVmiGGwWb9LoUvHBe0mR0cWSipOjMofYbmdOb4A/N8wbRaWI+Ur8QTJKeGnZke8LgaIWNd7RQ/6lJhnSRogUbciNBy4CZ96psYPwmKh0pOSOYTbkCdCZ9cgAjqxF5rPn9tC9/oL7Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5ONVVoSkpqZHlGUkR3S2czdnlnUlVuYVROZ2VBR0NkTlR6NFhtdU9vY0Z5?=
 =?utf-8?B?RVJxeTVJVTJ1MTVVV1N1U1pndk1peks1K1VRb2N4eFR5M3BVdE51K1ZMUnJO?=
 =?utf-8?B?M2doU0gzUTFJdXlycEdDdEpVS25BTWVNL0FVU0Fkb0ZLWHRBRFQxL0F2MXph?=
 =?utf-8?B?RDJTdEJxZWlBbU44eHZNZmZRK0hETEpwR1p3WVh4WThndXhoWEhNV1YxTXRZ?=
 =?utf-8?B?NWVONzJMZVhUWXpxbUJJK3paalMwdFY3cGlid1dTY1E2WW41S2dhbHRSS2Y3?=
 =?utf-8?B?c1RlTmg4V2VYQ3hDL0VlMU1MQlVZeGFTMXE5dWxaNFR6aThqRXlJUlFRM2Mz?=
 =?utf-8?B?Y3dDRWFoWUVCRmY0K21FRkFyZTMzVFZmSG1scWZpUDkwc2thL3c4cXBIQnJz?=
 =?utf-8?B?aWVSRE5XSzVhZGorNW9NelJXQVBQbUlxb29nU2FtcVVOKzRadXpQSWJVUnh1?=
 =?utf-8?B?NkdTSldlUzJWVXN4TkVwZ3NHaWhYREJ5L1kyODF2MkV1TVF6WFpJRWJjcFB6?=
 =?utf-8?B?UldtYXJBSkNkS1dlTGc4aWlIUzV6SkZQSWNodVlUWXpObzNZYzRnSWpJZVFm?=
 =?utf-8?B?ckNFU2NWbU5iYVBBK3BubkJBMTI1OVVMcUJlc0pQMVlnK0IyZWNqNzNua0xU?=
 =?utf-8?B?dHIwSi9wY2ZtVit2WjJKY1lhRUIyaEcrN1FadEgvak1xa2RUVXIyL25rN3lG?=
 =?utf-8?B?aHF6TGFMYzFIdndtYTNLL05PdEZ6VFNsQzFWbHFpOU9wWEh6OVAyTmp4MDQ2?=
 =?utf-8?B?ZzZacDBFckNoaVNGMm1NRlA0ckhBZERrYnRlMVRDSUdXTUhreVZ1QlYwandW?=
 =?utf-8?B?VHVVdmxDYzE0MG81WmpHbUxlYWRUK2s4eTFvRWNybXhMSXRBMHRJK0FnRmt6?=
 =?utf-8?B?WDNSVzlPSmhQVjV1andMM096U0piV2hxM1dxc25aRUVuaDFTeUxENkVqbU50?=
 =?utf-8?B?ZWt3TUNPNlAzNk1uVGxVbnRDRkRBYVJyeElrU1UvVUF6aHJOSWViZEMweUh6?=
 =?utf-8?B?dGVDRUl5M1NsaWg4eXpFNXYyVzRiWFRNSkJvb09KaSt1TU9vakZVQ3VWV253?=
 =?utf-8?B?NXdNZlQzNWdvcWVwVmF2M1BNUVNTdVlIdkhoR1k5MTJKL2E0alhjRWxLMGtP?=
 =?utf-8?B?TTdaazhvVG5waFR3Mi9wdUtlUndrZStlTlFDcW02MStzTGZUcW9QdUNXdjhi?=
 =?utf-8?B?bW1zN01rS3FpRmExb29MRWJHUVhLdHE5WFlmWFZ2RXBMc0ovOHdyZHVHZHVG?=
 =?utf-8?B?TVdPWDBLWXNxcFBRaU9LZW5qSzJBSEF6NnJiaDJ3VTRjbkZWZ3prUTlNTHgz?=
 =?utf-8?B?KytYcEkyNkhUVUJRL1pkNitaeUFGbU9RaWhoTEdTdFZnUVJDQnhmMGxmeS9n?=
 =?utf-8?B?QzBMTlF1VHJuZ2ZJOXk1UmFicTNpZndNeFppaTY2STFaS2NEbGZrVHdlUXVa?=
 =?utf-8?B?b1MwU2VkbzJtbGIwQ3hWTENyUjd0OWhTS1FNTGNYVURMS0FMRkdINC8zcDNM?=
 =?utf-8?B?dStRNjFrczU4WWZ2Q2toSUxhTzcvVFZtVURDM3dFRGhvSHk5RUNjZ08vellM?=
 =?utf-8?B?OVFnMHFHb0hGS1NiRmdyRHEyYTdoeWwrcWFjVCtwQ1V3VnFJYSt3S04zYUN0?=
 =?utf-8?B?V0ZEUEd4ekZzRWVEUUwranFKeDgxdjlYcVhucVk5K2RkcFQyWERaSE9EZXBv?=
 =?utf-8?B?d21vd29LdWxHN0wxUUJyUnV3VG01VTRIK1ZDSUtqaE15SkxyZGZjcGMvMURy?=
 =?utf-8?B?K2pDOWx5NEFGTlNPYVFoS01NQndzQXI2Z1ZwRHN5eVJwR2FGR2tDR0w1ZmlZ?=
 =?utf-8?B?b2VqcnlHanlNWFlYc20rZUdpMFVFcEh2M3RFd0dpYVNqQUlkbkszY3NzZDFP?=
 =?utf-8?B?VFltYVdqQ3kvempMUGliclcyYzZLWEMxWWRvZ3FjcktndjdINUFqMWN5N0JH?=
 =?utf-8?B?NWJRb0dISXllV1F1ekVuOG03MzI5cEVwV3lQWDB2TlM3MWtMWUpMcnVyYitv?=
 =?utf-8?B?SXl1YTNwOUMwMVZ3aFRKM2hHaC9nK0UrN0ZHUStSYit0K3ErZ0MyV3VwL0Yx?=
 =?utf-8?B?eWF4akVTQS9DTEdramFBWjV0S1Evc0IwUVRWaUlzeWMzZ1FBRlFSc1JYOUNI?=
 =?utf-8?Q?mP8vV/PHeHW32zWIiuPDLCVkb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7474e1-9c23-40e0-9263-08dc4754518e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:04:25.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X2JkUKbEsFlFZnIoBtBO9Z11v6AZr2mTTVhrMYKJ9+7A9PiiEyS5UJuQ9xjHWJxcN79EkUC61qh60vpio5tUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

--------------eZNHrdARV0g4xT9PuNselyHR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

HI Shashank

We'll probably need a v8 with the null pointer crash fixed i.e. before 
freeing the PT entries check for a valid entry before calling 
amdgpu_vm_pt_free. The crash is seen with device memory allocators but 
the system memory allocators are looking fine.

[  127.255863] [drm] Using MTYPE_RW for local memory
[  333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock ulimits 
for SHM_HUGETLB is obsolete
[  415.351447] BUG: kernel NULL pointer dereference, address: 
0000000000000008
[  415.359245] #PF: supervisor write access in kernel mode
[  415.365081] #PF: error_code(0x0002) - not-present page
[  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
[  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: 
G           OE 5.18.2-mi300-build-140423-ubuntu-22.04+ #24
[  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS 
RMO1001AS 02/21/2024
[  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
[  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 42 
48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 4c 89 
ff <48
 > 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
[  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
[  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 
0000000000000000
[  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: 
ffff888161f80000
[  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: 
ffffc9000401fa00
[  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: 
ffffc9000401fb20
[  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: 
ffff888161f80000
[  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) 
knlGS:0000000000000000
[  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 
0000000000770ef0
[  415.499738] PKRU: 55555554
[  415.502750] Call Trace:
[  415.505482]  <TASK>
[  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
[  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
[  415.519814] amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 
[amdgpu]
[  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
[  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
[  415.539324]  ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0 [amdgpu]
[  415.545844]  ? __fget_light+0xc5/0x100
[  415.550037]  __x64_sys_ioctl+0x91/0xc0
[  415.554227]  do_syscall_64+0x5c/0x80
[  415.558223]  ? debug_smp_processor_id+0x17/0x20
[  415.563285]  ? fpregs_assert_state_consistent+0x23/0x60
[  415.569124]  ? exit_to_user_mode_prepare+0x45/0x190
[  415.574572]  ? ksys_write+0xce/0xe0



On 3/18/2024 8:08 AM, Shashank Sharma wrote:

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
>
> Cc: Christian König<Christian.Koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Cc: Felix Kuehling<felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
> Acked-by: Felix Kuehling<felix.kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
>   3 files changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 26f1c3359642..eaa402f99fe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.allow_override = allow_override;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
>   	/* Implicitly sync to command submissions in the same VM before
>   	 * unmapping. Sync to moving fences before mapping.
> @@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_unlock;
>   
> -	if (params.needs_flush)
> +	if (params.needs_flush) {
>   		r = amdgpu_vm_tlb_flush(&params, fence);
> +		amdgpu_vm_pt_free_list(adev, &params);
> +	}
>   
>   error_unlock:
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
> index 601df0ce8290..440dc8c581fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
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
> -
> -	if (start)
> -		amdgpu_vm_pt_free(start->entry);
>   }
>   
>   /**
> @@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
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
> @@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			while (cursor.pfn < frag_start) {
>   				/* Make sure previous mapping is freed */
>   				if (cursor.entry->bo) {
> +					struct amdgpu_vm_pt_cursor seek;
> +					struct amdgpu_vm_bo_base *entry;
> +
>   					params->needs_flush = true;
> -					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor,
> -							      params->unlocked);
> +					spin_lock(&params->vm->status_lock);
> +					for_each_amdgpu_vm_pt_dfs_safe(adev, params->vm, &cursor,
> +								       seek, entry) {
> +						list_move(&entry->vm_status,
> +							  &params->tlb_flush_waitlist);
> +					}
> +
> +					/* enter start node now */
> +					list_move(&cursor.entry->vm_status,
> +						  &params->tlb_flush_waitlist);
> +					spin_unlock(&params->vm->status_lock);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}
--------------eZNHrdARV0g4xT9PuNselyHR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>HI Shashank</p>
    <p>We'll probably need a v8 with the null pointer crash fixed i.e.
      before freeing the PT entries check for a valid entry before
      calling amdgpu_vm_pt_free. The crash is seen with device memory
      allocators but the system memory allocators are looking fine.</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p><span><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">[&nbsp; 127.255863] [drm] Using MTYPE_RW for local memory<br>
          [&nbsp; 333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock
          ulimits for SHM_HUGETLB is obsolete<br>
          [&nbsp; 415.351447] BUG: kernel NULL pointer dereference, address:
          0000000000000008<br>
          [&nbsp; 415.359245] #PF: supervisor write access in kernel mode<br>
          [&nbsp; 415.365081] #PF: error_code(0x0002) - not-present page<br>
          [&nbsp; 415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0<br>
          [&nbsp; 415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI<br>
          [&nbsp; 415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e
          Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp;
          5.18.2-mi300-build-140423-ubuntu-22.04+ #24<br>
          [&nbsp; 415.394437] Hardware name: AMD Corporation Sh51p/Sh51p,
          BIOS RMO1001AS 02/21/2024<br>
          [&nbsp; 415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10
          [amdgpu]<br>
          [&nbsp; 415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85
          db 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18
          48 8d 75 b0 4c 89 ff &lt;48<br>
          &gt; 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c
          89 63<br>
          [&nbsp; 415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287<br>
          [&nbsp; 415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8
          RCX: 0000000000000000<br>
          [&nbsp; 415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30
          RDI: ffff888161f80000<br>
          [&nbsp; 415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000
          R09: ffffc9000401fa00<br>
          [&nbsp; 415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000
          R12: ffffc9000401fb20<br>
          [&nbsp; 415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0
          R15: ffff888161f80000<br>
          [&nbsp; 415.476312] FS:&nbsp; 00007f132ff89840(0000)
          GS:ffff889f87c00000(0000) knlGS:0000000000000000<br>
          [&nbsp; 415.485350] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:
          0000000080050033<br>
          [&nbsp; 415.491767] CR2: 0000000000000008 CR3: 0000000161d46003
          CR4: 0000000000770ef0<br>
          [&nbsp; 415.499738] PKRU: 55555554<br>
          [&nbsp; 415.502750] Call Trace:<br>
          [&nbsp; 415.505482]&nbsp; &lt;TASK&gt;<br>
          [&nbsp; 415.507825]&nbsp; amdgpu_vm_update_range+0x32a/0x880 [amdgpu]<br>
          [&nbsp; 415.513869]&nbsp; amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]<br>
          [&nbsp; 415.519814]&nbsp;
          amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdgpu]<br>
          [&nbsp; 415.527729]&nbsp; kfd_ioctl_unmap_memory_from_gpu+0xed/0x340
          [amdgpu]<br>
          [&nbsp; 415.534551]&nbsp; kfd_ioctl+0x3b6/0x510 [amdgpu]<br>
          [&nbsp; 415.539324]&nbsp; ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0
          [amdgpu]<br>
          [&nbsp; 415.545844]&nbsp; ? __fget_light+0xc5/0x100<br>
          [&nbsp; 415.550037]&nbsp; __x64_sys_ioctl+0x91/0xc0<br>
          [&nbsp; 415.554227]&nbsp; do_syscall_64+0x5c/0x80<br>
          [&nbsp; 415.558223]&nbsp; ? debug_smp_processor_id+0x17/0x20<br>
          [&nbsp; 415.563285]&nbsp; ? fpregs_assert_state_consistent+0x23/0x60<br>
          [&nbsp; 415.569124]&nbsp; ? exit_to_user_mode_prepare+0x45/0x190<br>
          [&nbsp; 415.574572]&nbsp; ? ksys_write+0xce/0xe0</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    </p>
    <p><br>
    </p>
    <p>On 3/18/2024 8:08 AM, Shashank Sharma wrote:</p>
    <blockquote type="cite" cite="mid:20240318120837.2011-2-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">The idea behind this patch is to delay the freeing of PT entry objects
until the TLB flush is done.

This patch:
- Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will keep the
  objects that need to be freed after tlb_flush.
- Adds PT entries in this list in amdgpu_vm_ptes_update after finding
  the PT entry.
- Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)
  to simply freeing of the BOs, also renames it to
  amdgpu_vm_pt_free_list to reflect this same.
- Exports function amdgpu_vm_pt_free_list to be called directly.
- Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.

V2: rebase
V4: Addressed review comments from Christian
    - add only locked PTEs entries in TLB flush waitlist.
    - do not create a separate function for list flush.
    - do not create a new lock for TLB flush.
    - there is no need to wait on tlb_flush_fence exclusively.

V5: Addressed review comments from Christian
    - change the amdgpu_vm_pt_free_dfs's functionality to simple freeing
      of the objects and rename it.
    - add all the PTE objects in params-&gt;tlb_flush_waitlist
    - let amdgpu_vm_pt_free_root handle the freeing of BOs independently
    - call amdgpu_vm_pt_free_list directly

V6: Rebase
V7: Rebase

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Acked-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Acked-by: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Tested-by: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 26f1c3359642..eaa402f99fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
+	INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_unlock;
 
-	if (params.needs_flush)
+	if (params.needs_flush) {
 		r = amdgpu_vm_tlb_flush(&amp;params, fence);
+		amdgpu_vm_pt_free_list(adev, &amp;params);
+	}
 
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b0a4fe683352..54d7da396de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
 	 * to be overridden for NUMA local memory.
 	 */
 	bool allow_override;
+
+	/**
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+	 */
+	struct list_head tlb_flush_waitlist;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 601df0ce8290..440dc8c581fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 }
 
 /**
- * amdgpu_vm_pt_free_dfs - free PD/PT levels
+ * amdgpu_vm_pt_free_list - free PD/PT levels
  *
  * @adev: amdgpu device structure
- * @vm: amdgpu vm structure
- * @start: optional cursor where to start freeing PDs/PTs
- * @unlocked: vm resv unlock status
+ * @params: see amdgpu_vm_update_params definition
  *
- * Free the page directory or page table level and all sub levels.
+ * Free the page directory objects saved in the flush list
  */
-static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
-				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params)
 {
-	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm *vm = params-&gt;vm;
+	bool unlocked = params-&gt;unlocked;
 
 	if (unlocked) {
 		spin_lock(&amp;vm-&gt;status_lock);
-		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-			list_move(&amp;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);
-
-		if (start)
-			list_move(&amp;start-&gt;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);
+		list_splice_init(&amp;vm-&gt;pt_freed, &amp;params-&gt;tlb_flush_waitlist);
 		spin_unlock(&amp;vm-&gt;status_lock);
 		schedule_work(&amp;vm-&gt;pt_free_work);
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+	list_for_each_entry_safe(entry, next, &amp;params-&gt;tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
-
-	if (start)
-		amdgpu_vm_pt_free(start-&gt;entry);
 }
 
 /**
@@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	struct amdgpu_vm_pt_cursor cursor;
+	struct amdgpu_vm_bo_base *entry;
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
+		amdgpu_vm_pt_free(entry);
 }
 
 /**
@@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn &lt; frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry-&gt;bo) {
+					struct amdgpu_vm_pt_cursor seek;
+					struct amdgpu_vm_bo_base *entry;
+
 					params-&gt;needs_flush = true;
-					amdgpu_vm_pt_free_dfs(adev, params-&gt;vm,
-							      &amp;cursor,
-							      params-&gt;unlocked);
+					spin_lock(&amp;params-&gt;vm-&gt;status_lock);
+					for_each_amdgpu_vm_pt_dfs_safe(adev, params-&gt;vm, &amp;cursor,
+								       seek, entry) {
+						list_move(&amp;entry-&gt;vm_status,
+							  &amp;params-&gt;tlb_flush_waitlist);
+					}
+
+					/* enter start node now */
+					list_move(&amp;cursor.entry-&gt;vm_status,
+						  &amp;params-&gt;tlb_flush_waitlist);
+					spin_unlock(&amp;params-&gt;vm-&gt;status_lock);
 				}
 				amdgpu_vm_pt_next(adev, &amp;cursor);
 			}
</pre>
    </blockquote>
  </body>
</html>

--------------eZNHrdARV0g4xT9PuNselyHR--
