Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC2C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A773810F8F7;
	Mon, 18 Mar 2024 15:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9rhNDMT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA9F10F8F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 15:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM0FCoU9GmpnabY81E4/k3YGga11nHOoux7ETUMWHDQt+a7eE/KdWWLp+9A9fM4GIEmQqdxN7Dhapnb3iaGcZzJolxyAaGZa6B0n86u/WY0oTfZCrel4jPh7EwXNpDcB5J+4LZM7pN7CBxKtRYwdcviM3ZWaHKDwM+HXyYMJV9ec2K43TAbnTGUZBdqkxzfMVIuEAXCuRcZnYHyGGJ78/gl43aG4rGTbhM3DKZhl/owikYTxsKB15veCr7tXyBOe5Sbf6+QYDVF+GocKnra/sRuSjmwjQbBjEmhtM+b4/fF3+Q5qux0hmXo88bD6vZal596grm9CjEp1QYeKIJDJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHF9xeAZzeFxQi7AEbP2HAfNmbjEa45X4Zg/MRw1aCI=;
 b=K+Yt1HbQFI3rI9F6LoQuDtaVZi4jXyBgzr8/xdlpdRzsHf3BYif0wvrpb0ti+NSjmg97SPltXTz4L7iLLtMNrse4HNks8JWzJYopRFM1Y3NPlAwTuAezHzbl70S/OoZ8bauFzPNOxtaLWmrDkf/rZYOuIxJvBy25SL8idcwZLwzqTua/mWIm/gpQBA6/311OL8x6gF4tbDKZ059KbLM56YW0fLUlT4OTDFbBCI6YBHVJgv+1SuK0LmKcIKbBIDoSDTTQJsWSMbn6xDe4gdLH3FM/FhZFUYhEw35s8BLX/HM237JaqxkOAsFkFZU7Ht2bQJX7wYwEZqL91ZpiOIaIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHF9xeAZzeFxQi7AEbP2HAfNmbjEa45X4Zg/MRw1aCI=;
 b=s9rhNDMTUeV0CbaaDJyYFzLTHjVZ7Qmui9cA5tSU0cym4KFPIS6uxsMN6wW6L4XjGDSUzq90ErpC1GGUE6zA/Ad1uHlJd6Mz7CQqQRyZDlKu4OY/x/3JCrSq2imEF50RnbMCL8QWosDJH1yjJUUQH/+D5D7MlgNqqdeP9niNUCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 15:01:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 15:01:43 +0000
Message-ID: <cc76d0a2-90e3-420e-9521-f64a75863c25@amd.com>
Date: Mon, 18 Mar 2024 16:01:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
 <20240318144412.2051-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240318144412.2051-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e00723f-a65f-4dc5-3de7-08dc475c52de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/U2Hg1l+Jqkaw67btXTpkuR4ZpJ83VUk6huShsz1LWzK+pFPFV1eL967o2koHM1+DUAEfoYK4WZZphtjXdSAbWp4skPGfyWX0ZyLXL9hlZQQ8dJxyXuP0DhpawkhZEihBQ+b/wCZhpFRfOS9doyxQ5k0E3heacFXTOXs4GPQ2LKSH0DCq5b/xw8PDWadXwbsuqGIevwjuaSJBjWJ5xHY6mkuVOSXVSCNlziHDIXQpDTxsbOD+RcKr5LmiBOhok2wY6o65hu4Fws+s7RHDYRRolv4Hw2BnoI56L0YaL3/4FdMdjIri8XA6VmWC7xdWTMEE8m0tKKby9VZPL5/zmE1Ou+MCc4p0fRdMJjRyWvNP566LYgcFmRAHNGWcrTDBxu+r9bVAIbVPV4ebf3/fyPMxP8CjwOHKYZz1C04ts7shAgATtw0LGTkUB1ca6u0lETBckloLXNNl3sgllraMnSfacCnyLjAvYNyWJBHkJJlSLJDvpGiVs7fDu1hH4jbbveI/lOQrZ5q/KqW13+YHefqZ5cHCtUDuF5yP8f7/0zz+r1+DmCEJgHUgr34lBcPXfyZMzjxIUmeJjmAMoCo5y/mDviK3CafnX+eWwP7x7oxT6Rxs8zne5DqnQGeXAxG84QvGWAw725ZsDdrs5QedYynjK85u6JcIKO/ueqPWC6K50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZSWEN3Q29MQ0Y1bjd4N1RyTTNDekVGQVVYbEVOR3RvdmMxR0d3VFJDWW94?=
 =?utf-8?B?RHlISnBCcnlFdzZvL1FSYW9mQ1c4Q2RDbHhKUUNFK3kwWFdBQUErc25mUFVW?=
 =?utf-8?B?OVJpMHZzZzUyZDRJc2lpRDhZL2kxNVVKMmU1eHgvQVBDVzR4NGdMQkkrM3Nn?=
 =?utf-8?B?YmI4WWIyRUtrM0JkaTN6M3dmWjlrT2RhQWtkSThTK0s0enl3cUFRVjJucEhW?=
 =?utf-8?B?emNCcVV3cFp5OTV2a0w4czQwMGNqYnh4MENwWVc4ZXJCU1JSRjRKVTE4TEJw?=
 =?utf-8?B?U2lUa1FoTHNNbXY4R1YrQmtCVzhQUkpaZERXVllsR013STRaVStCdG5SWkhL?=
 =?utf-8?B?LzdiSEVvdFVkNURBNExyYnFodWQxbWtUVXdxcVVCQ3VuKzhQT1crMW9SVisv?=
 =?utf-8?B?QmVkVTIwb3lidkFHUjBwZTI2Rmd6ZXdwNUtnWUwxMG52OHBlTU9SdmVhV28r?=
 =?utf-8?B?MDBSeC9LTFRwd2JUb0ViOHRINzMyd1g3M0o1YlQvVytLa2Vtdkk2YXRIdU55?=
 =?utf-8?B?Mys3bTZIdlltaGJHbnAwZC8zdUh3dzAwY0s4aVJ4TU1hdEtjeHkzcHphMHhz?=
 =?utf-8?B?MWlyZTE0YTFtQ3hVckFxcGZIeVREeUlwb2trRjhMU2plWGh6RHVBcEJSMmxJ?=
 =?utf-8?B?aGZ0b1Bpb3dENmdwZkV0akNlNEVBT2tYa3VKbklQYkVEUVFlci9uNTF5WTdq?=
 =?utf-8?B?QmVPRXNyTFlVU2VCSlhPWjNhOHl3bXJyMXhScFBWQzd1aGh4TUFFK09CL21I?=
 =?utf-8?B?MW93QnNGaU9jdFpDUDI1ZVlMbUFNTGZWL1piQ1ZRdmtOelhwWnhES1k2RGp6?=
 =?utf-8?B?RTRJdTY3TDZYTUk2NXUwTytxWVNEMG9CM2FrdHFCTlpoNWZNMFRnRldudk5r?=
 =?utf-8?B?S3l1TWJmWFRLdTRaTEdVTGRLWkZRQjdVV3ZxTjY0QWdaVnhpejVyK1ZJK3Jh?=
 =?utf-8?B?b2tNRmxuL0krYWljbzA5THF1MHBPRnJWZlBWcGdZTGY4SDZmMk44L3lvc21R?=
 =?utf-8?B?WmJPa1E4T05BOGpLUlJMN1k2NktMQWR5a0s3NXQ3NGV0cVBMRm13OXVlSUY5?=
 =?utf-8?B?T0Y3NGJWa2YzNXBsMS9QaXRQdlFob3hLUCtFWmdpRUJxb3l2U2R5RE5MYkY2?=
 =?utf-8?B?dTZoT1dsTWpTdW9zcmZXTWdZcGozRURkQlkyYjkwYmFONjA1YWFKblBPZ2Qv?=
 =?utf-8?B?YmNoNW1ic0VSaWMrUDJVZTFmZVdVUDlGbUpGMEVVOVhtTFA4bngwVUp0a3VK?=
 =?utf-8?B?VVV4a0ZPYXFaMEY1bEdsVEJEbXB0VHFpbXI5RENHaFVGdFlSUVY5aE1NZjJw?=
 =?utf-8?B?SXY0QkVKRGY2eFFmUk9CTllveEU2S1RYSUQwQVA5VmJrVTlPQmIrR1hTdFZN?=
 =?utf-8?B?akZCRHU1RTJCdkFYQzZBQnV4RnlzS3IrNm1pSjBROEJCZ0NnNWhML3JKcnIz?=
 =?utf-8?B?TVpUTGRadFhsdGFzc0w5all1TjBUSTFjY1NTWTU5cjMzWmRnZktEMGNCU2w1?=
 =?utf-8?B?WkVXZmM2K3VBbXEyT1lld3Z4b3RJZ0VOV3NYOGRrbVVoUXZ6SnFXRlQ0RlFG?=
 =?utf-8?B?WFVkMW82VU83TnZaeHpRRHVacUQ0ZzRUMnRzSzZOY0t0b1gxSy96NnNKbkJX?=
 =?utf-8?B?Q1F1bXNSZTZ1WUcxTHhYVENyODZLQnlubFRKckszMUN0Yll5eXI5TmdMVFdZ?=
 =?utf-8?B?djVVcmhvK0lOUkhES05WZ284N0lYM214ZkxzUmxvOXF1VVR2dmdtTnhMbmJC?=
 =?utf-8?B?RGgzdS9leDVyR1M4amRRSi80NXd2TW50a2t5WE5KNm5WTmdBaHpwaVAxeXZZ?=
 =?utf-8?B?Z1NodElqNldWMWRUVFYxK0hvTEMrNENERUlnbmtzNE80UXRBTXBaNEZ5OGtW?=
 =?utf-8?B?MXF2TThlZlpoNTVqZWZxcmF3dUc0emVCRW8zOVE4aWkraFNsZC9nNGZ2VTdW?=
 =?utf-8?B?L1lOcDRXOGJoUmJtUGFGbkR4d1p4T3E1a2R1Ni9BSDdyV3p1cGFWY0VlcGhH?=
 =?utf-8?B?S3Y2Znd5alF4Zm5PQXRja2NVMjMrK0hwTW5EalZxa0piSE13QTdFWWJIN3Fr?=
 =?utf-8?B?a0RnOVJLeGFZT1VxQ3djRUhVdVJoNERVQjE2RkY4UzhObFpSQ0RuVVR4cnJL?=
 =?utf-8?Q?4iyJle7C5NYSqSV/6PGc43g1s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e00723f-a65f-4dc5-3de7-08dc475c52de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:01:43.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVOUC6LM0En+hivjgpGcrZEmNTnp4O24TMH/dXZ+vO/j3QQiJQvgqfFWAkbFeyFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
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

Am 18.03.24 um 15:44 schrieb Shashank Sharma:
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
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58 +++++++++++++----------
>   3 files changed, 45 insertions(+), 25 deletions(-)
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

This is completed independent of the VM flush and should always be called.

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
> index 601df0ce8290..9231edfb427e 100644
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
> @@ -667,7 +657,13 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
> +	struct amdgpu_vm_pt_cursor cursor;
> +	struct amdgpu_vm_bo_base *entry;
> +
> +	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
> +		if (entry)

Entry can't be NULL here I think.

> +			amdgpu_vm_pt_free(entry);
> +	}
>   }
>   
>   /**
> @@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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
> +						if (!entry || !entry->bo)
> +							continue;
> +
> +						list_move(&entry->vm_status,
> +							  &params->tlb_flush_waitlist);
> +					}
> +
> +					/* enter start node now */
> +					list_move(&cursor.entry->vm_status,
> +						  &params->tlb_flush_waitlist);
> +					spin_unlock(&params->vm->status_lock);

I would put this into a separate function maybe.

Apart from those nit-picks looks good to me.

Regards,
Christian.

>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

