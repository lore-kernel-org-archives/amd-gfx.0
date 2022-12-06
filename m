Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B735C352A1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Dec 2022 08:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5290A10E2FD;
	Tue,  6 Dec 2022 08:20:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D454F10E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Dec 2022 08:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQxjfNkGxSnyzuno47BZpYsTmkh/gwIiULcte5x5icBwvVr69JuFM2zJiwFuwg1YDUg6xXY6z9Nj+0il61RVSFGddvLsLWKY6DfkqOUTQxInTeIYmxh0+rzdT4/UDstmVq2e/2weTYbUezyEwbcJFQaqLkeGrKEHqvM4N0VYKupZ2D8D4qWjM5znSaJBlMLpAB37VXk1a2GJWXr+HNRhll1PmL3SeDokbe1UDMt7RCOVeOQwIfJqYxaIVlYKn3HyWjEXwqchF3zngOxA1ooCivrn2qUq2K2g0ipR5Pe4a72MVrohWLZ/oiAi+7KiUTtoI8gh7oVetd4dP2YDNEdlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNoduvxviGddvjaZGdmjvO6GNopZT++m9UfY08PS35k=;
 b=g0OF0WILdeJTIiTu+lU6WuqtkOUtZCdyA+HAOZvFQgdKJ1BHUnKWcCv7kpUL1d/obU7Y1osFq72VgVxXoWAfsj4S7d7pOcgyL4REuCcN7phQuwkoqyXXmcmPs2jb7T7BxfT6xkPIgM/+4KJz/OLHISP6Wr/GmCYjeJQTBuuiujLZb4Q10zY/Cxsdszm4visU9I8h8D6jup1NQ9v116n5owUtRPB4y+7pkZRYJ++pebSDaECBsPLm6MPww32/icrxspLOHHY6hUMBDGJQ+K9UAwWyH5IdxmmX0/8GGLknXvq612nkWxblNHQBMMlSyu/kRg3kcHNqUd5Q/tyTHAZN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNoduvxviGddvjaZGdmjvO6GNopZT++m9UfY08PS35k=;
 b=tiktNGB0iGc7C42N/ezkjo5NPebZfbA10+YT+sqBGzJZ8m5avmvRuqN3l0sCYwJjprw8+1WVEaIWzS9MYpt9Ip9kDbZpk5BTC6ilB/dcuiMj00wqvw8OgjdpLHAM5r3na4BaISAutjRKQ7EcOK3EVQbano/+TgSGzT9wMUdbJ7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 08:20:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:20:07 +0000
Message-ID: <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
Date: Tue, 6 Dec 2022 09:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: c11135df-fd05-4b30-b67d-08dad762af67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AULigIL3nmf2fAU7VF2h0FwG6p+nVE0gwstr6dvXVbf1YwbGh42zT6IRuaa2JtrXRVGWqKJQzdnOFt0QsJ/bz44MXYK3kMY6RKvvBlovITgnQEOhY3BqIN2EJ2FufroNAGoijKyFpxJrvOqBfmhd7vdCoIe51l5C4UMcP19MCY5TSGHbUSWnCctY5OoCiFCSG8QoHnYAuWWqCL/OSpZXC4u+5lH6oEZhuEG/VDCnHUzdl6TH3EwKlEl1xLXKjJKe3PTuhg3Oga2i2CuRyZhQXm9TE1n0gjUESrL1eu20e+pKuG951HkZdT7RUpjlsOlRD8umMKc6QAsyxeW+tkmmJqY6iN5H99l9sYXbuXhp23Yp0VTxTXyGcCbhrZoVowIRkSqhy1cy8b3aD19Ub6Fqtsi53WwEv+Qw9M37UgCtLwwgJ6elClSB5Hhugjd/+3CNOnx6zOIINYfn3tfRRRUe36YQ8BNZXHt4YKwS0VBIi6PZtd7MOV7ylbRtjcg7VY1DpM8JUNbhEdkSbAFj4B5+47Cxcyso+VNsCJ36ydZjFYv0VevByzZyh6vhjgcM8HIcAX8rW16VMANOoUWCMhY/ZlLeEuXCnYXQaHUOf3N/HmIi8Fv1bzx5iz+yKCCM7tPz3FaE7T1PK5P0/j4wRrCDFrzzfuDByjVBmporRBglWAZJpBSjsqALC2NsOtsJSOuwKknMWoNQmGP7HgRDRB1xr3dcU8DB4U6JSVgfAK2QHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(83380400001)(2616005)(41300700001)(86362001)(31696002)(2906002)(5660300002)(186003)(110136005)(478600001)(6486002)(38100700002)(6512007)(66476007)(66556008)(8676002)(66946007)(316002)(6506007)(6666004)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RlZ0ZkZkxtaGRObVpBaTZhdndzZ1F5eWFMbHZJcVdXU0ttcVFHRVNjM2Fj?=
 =?utf-8?B?OHpCNlBoUW44SHN0Yk9jV1VFQ1ZSbzAvalRPY3YwakQzYm94MmVaMkxlVTcx?=
 =?utf-8?B?TEdnK09DNnNYcWpRTnNCTEJVTmFrWXpmbGtVdjZQWXdZUDFsOWFOc2h2RTFM?=
 =?utf-8?B?OWZ4L3dmMUdUUkxFRWJNMDBsY2pyQUhwVTd0OC9YdXV4QVVJTXl0b29Nd3A0?=
 =?utf-8?B?N2h1N0xOdTF5U0VHd3BsRkZZTzRleGxHYzFEcXkzUmR5c1Bqd1lxd3FsWTJo?=
 =?utf-8?B?clI2cmRBSDlCb0VhUW1tL0FKTWMzVi9PSS80NEFGLzgwSVFTUXlMUEtPZVRz?=
 =?utf-8?B?VHJ3OFRzUUVZWDZ3VkZyWUZKRHp3VDRpUDI4WkEzbEMrTlVGOUpFUUZVNlJv?=
 =?utf-8?B?MTJGMCs3bDk1bFBJM3ExVWhIWlI2ZmpTeVFTVTJwSXN4ZzdxOTN5WXZvSmtR?=
 =?utf-8?B?NE1VaG11RGVUbHF2Z3hjUUJDekJ0U1RnWG10V1VMbVBsbGFDOFhkbnk3STNt?=
 =?utf-8?B?QklBL2Zxb3JON0xiL2NINnc0Nytua2N4QVpTR3I1YVZlSS9lSkRwbUZIeHlJ?=
 =?utf-8?B?NVFnaWw2YUVhSSswQzdYRG5pU2dpakVxWk9EUkxJZTJJdy96NnNHaEVpRTN3?=
 =?utf-8?B?M0djZmFDMkpiS24vODB4bkI2enZnV2wxRWhZRWNXV0tsaTZXZXpyVy9ISnZX?=
 =?utf-8?B?OUVVelVLTllsa2ZJV1FsaUE5SEt4UjBUZTBCWCtQZUcwTHp2czRXZzQxVFdj?=
 =?utf-8?B?ZHc3RStUQU5RNm53d3MvZjJGdmdqQzJZd2tCY2ErWWR4NEFtT09GNWhERXFI?=
 =?utf-8?B?NGdHSFJYSUVrcERwTkJmKzdoaGxWU3pueFhyS1czYURyd1lLUkRGUWswbTlm?=
 =?utf-8?B?NGNGaDdldURkWTlkZVNESXJvS3psdDgxY29mWDZta0N2dDhmYnIvNS9aZHZn?=
 =?utf-8?B?cE94OXZCdW9rTG02MWNzKzJoWkY4RlFTcWlEVm5lRmQ2bVV5NGRVeDZDZlIr?=
 =?utf-8?B?NUowdTcwbHdKODd3WHYranZyalRrR29GdDlqQk5WbnFDU2FuaUo1SHFtWnhD?=
 =?utf-8?B?TDNlSkxmVzk4aGlGaUFQTDVsZjJIOFdIYml3bWNjUnNxV05OYjFXMm9tK25a?=
 =?utf-8?B?TTZQYUdMRHIzU1A1NGUxZ1Zsb2lYbFhUbko0TGZXeXdYdVQ5QXhWQ3ZFUU5R?=
 =?utf-8?B?UERYOTh5LzdFTXh6NzR3MXI5RTNTb0RiV1lVTjB6UElXTk56a2twVXIrZGFO?=
 =?utf-8?B?dzk4OFRKZWRyeW1QemFKOURRNGxLV0R6YmVPQndUNVZKR25NZWJsOENhT0t0?=
 =?utf-8?B?L3k2dzc5NEpqN1Y0LzlHcXVwWmFwNVJrcmxBWGo2NFhTYzAxaUczWFJMcUxq?=
 =?utf-8?B?T3hZWXBUVzg5ZENCN25mMFZtOW1RSVAvZ0Y5MmhlMHFNZTI5dDFlRVNtRnBi?=
 =?utf-8?B?THZQT3FsNTYwdDlnQmxQWWllakMweDhyYkVXUVNLcnA5aFBXMDFQL2U1YWEv?=
 =?utf-8?B?bmlBSjBwRHY3dlZ5WW1leWt5RWRMZGZCcjRwK0RhdE9nK2J6VUtLSFNxbVR6?=
 =?utf-8?B?K1RpSytyNVJtVDk0dUVSUDJJS1VwbXc3VTYwMklabzB0cmsvdFFnaFoweit0?=
 =?utf-8?B?RlhENU1OSXJuT1J6eVFYbVhMOXFDRE5vRndGTzBCTkNBNHJOWWRYMC9rOGhW?=
 =?utf-8?B?N3ZOUzJBeWZ2RE05dDVxT2NEam00ZTZjeGt5RzV6WUduTmR2bnlJQVkvMGJs?=
 =?utf-8?B?VlIwM3NjZkNHZzNHRE1ObHM1UGZ5QmxZS0NhT0F6WHF3aEFQSVRCTTh5aUdS?=
 =?utf-8?B?d0RWMXdoTmIxV29zMERkYjRKRkhja21KOWFiTHBmZFdpMjVlNVkxVGVibXYv?=
 =?utf-8?B?YWRQbG5ua1lDNGlRTmtpOUtDUG1jV0NuM205VzBEVmN4RS8zK2twb0VsV2g3?=
 =?utf-8?B?Q1lyNWUyb0wrb1QvQjV2LzE1Vmp3M1NveFlaZUNiYUZLSG9RdXRoblhYNHlO?=
 =?utf-8?B?ekdkaTVmL0tSeFhySnJ5YUVIZnVZQ3R0WHZ6aEwvdEhUU3dIa1RWVERSeVMv?=
 =?utf-8?B?UnlBWW8xNDd3MFlNcDVsckx4Y3JmbzFlVG9QRjNUQ1haWnRGeXVPVzhXWGc0?=
 =?utf-8?B?TStReENnVW9xcFlHVUlCcDJwZzF6ZWw4UUdXendqSzJ6NkgrNDVvcDhOVE9n?=
 =?utf-8?Q?bVCMROnLPOtnxsn7vZifw4Ckr0ATDbVElzMqoU6A8d9L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11135df-fd05-4b30-b67d-08dad762af67
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 08:20:07.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD4DdeC85bfCg8fnGiMPzSYA3qfXlHISdUoYbg8srYPL4SF1l7DV5uuRSlId/4V4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

Hi Felix,

to be honest I think the whole approach you take here and unmapping the 
range with the lock held is highly problematic.

Essentially unmapping is something which can run concurrently with other 
operations and should never be blocked by such a lock. In other words it 
is perfectly valid for an unmap to run while another processor tries to 
map the same range.

That's why the same page fault can occur multiple times until the page 
tables are up to date.

When you get an MMU notification that range A->B is invalidated you 
trigger invalidation of range A->B inside the GPUVM address space as 
well and that's completely independent what's mapped there.

Invalidating the mappings and eventually scheduling that they are 
re-created is a separate step which should come independent of this if 
I'm not completely mistaken.

Regards,
Christian.

Am 06.12.22 um 01:04 schrieb Felix Kuehling:
> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
> eviction lock when allocating PT BO", but there was another one hiding 
> underneath that (see the log below). The problem is, that we're still 
> allocating page tables while holding the prange->lock in the kfd_svm 
> code, which is also held in MMU notifiers. This creates a lock 
> dependency between the vram_mgr->lock and fs-reclaim.
>
> There are three ways around this:
>
>  * Do the page table mapping outside prange->lock (creates a race,
>    contradicts advice in Documentation/vm/hmm.rst)
>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>    allocate page tables ahead of time somehow)
>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may cause
>    memory allocations to fail in drm_buddy under memory pressure)
>
> I only mention the first one for completeness. It's not a valid 
> solution. Neither of the remaining two options are particularly 
> appealing either.
>
> Regards,
>   Felix
>
>
> [   83.979486] ======================================================
> [   83.986583] WARNING: possible circular locking dependency detected
> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
> [   83.999044] ------------------------------------------------------
> [   84.006088] kfdtest/3453 is trying to acquire lock:
> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.023911]
>                but task is already holding lock:
> [   84.031608] ffffffffbcd929c0 
> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
> unmap_vmas+0x5/0x170
> [   84.041992]
>                which lock already depends on the new lock.
>
> [   84.052785]
>                the existing dependency chain (in reverse order) is:
> [   84.061993]
>                -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
> [   84.088411]        workqueue_init+0x88/0x318
> [   84.093533]        kernel_init_freeable+0x134/0x28f
> [   84.099258]        kernel_init+0x16/0x130
> [   84.104107]        ret_from_fork+0x1f/0x30
> [   84.109038]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
> [   84.121697]        kmem_cache_alloc+0x2c/0x760
> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
> [   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
> [   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
> [   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
> [   84.231313]        local_pci_probe+0x40/0x80
> [   84.236437]        work_for_cpu_fn+0x10/0x20
> [   84.241500]        process_one_work+0x270/0x5a0
> [   84.246805]        worker_thread+0x203/0x3c0
> [   84.251828]        kthread+0xea/0x110
> [   84.256229]        ret_from_fork+0x1f/0x30
> [   84.261061]
>                -> #1 (&mgr->lock){+.+.}-{3:3}:
> [   84.268156]        __mutex_lock+0x9a/0xf30
> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
> [   84.335537]        svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
> [   84.359738]        do_syscall_64+0x35/0x80
> [   84.364481]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   84.370687]
>                -> #0 (&prange->lock){+.+.}-{3:3}:
> [   84.377864]        __lock_acquire+0x12ed/0x27e0
> [   84.383027]        lock_acquire+0xca/0x2e0
> [   84.387759]        __mutex_lock+0x9a/0xf30
> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
> [   84.407410]        unmap_vmas+0x162/0x170
> [   84.412126]        unmap_region+0xa8/0x110
> [   84.416905]        __do_munmap+0x209/0x4f0
> [   84.421680]        __vm_munmap+0x78/0x120
> [   84.426365]        __x64_sys_munmap+0x17/0x20
> [   84.431392]        do_syscall_64+0x35/0x80
> [   84.436164]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   84.442405]
>                other info that might help us debug this:
>
> [   84.452431] Chain exists of:
>                  &prange->lock --> fs_reclaim --> 
> mmu_notifier_invalidate_range_start
>
> [   84.466395]  Possible unsafe locking scenario:
>
> [   84.473720]        CPU0                    CPU1
> [   84.479020]        ----                    ----
> [   84.484296]   lock(mmu_notifier_invalidate_range_start);
> [   84.490333]                                lock(fs_reclaim);
> [   84.496705] lock(mmu_notifier_invalidate_range_start);
> [   84.505246]   lock(&prange->lock);
> [   84.509361]
>                 *** DEADLOCK ***
>
> [   84.517360] 2 locks held by kfdtest/3453:
> [   84.522060]  #0: ffff9a99821ec4a8 (&mm->mmap_lock#2){++++}-{3:3}, 
> at: __do_munmap+0x417/0x4f0
> [   84.531287]  #1: ffffffffbcd929c0 
> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
> unmap_vmas+0x5/0x170
> [   84.541896]
>                stack backtrace:
> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
> 5.19.0-kfd-fkuehlin #75
> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled By 
> O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
> [   84.565788] Call Trace:
> [   84.568925]  <TASK>
> [   84.571702]  dump_stack_lvl+0x45/0x59
> [   84.576034]  check_noncircular+0xfe/0x110
> [   84.580715]  ? kernel_text_address+0x6d/0xe0
> [   84.585652]  __lock_acquire+0x12ed/0x27e0
> [   84.590340]  lock_acquire+0xca/0x2e0
> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.602338]  __mutex_lock+0x9a/0xf30
> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.629353]  svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
> [   84.636742]  ? lock_release+0x139/0x2b0
> [   84.641374]  __mmu_notifier_invalidate_range_start+0x1d3/0x230
> [   84.647976]  unmap_vmas+0x162/0x170
> [   84.652203]  unmap_region+0xa8/0x110
> [   84.656503]  __do_munmap+0x209/0x4f0
> [   84.660792]  __vm_munmap+0x78/0x120
> [   84.664977]  __x64_sys_munmap+0x17/0x20
> [   84.669499]  do_syscall_64+0x35/0x80
> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   84.679485] RIP: 0033:0x7f32872eb97b
> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff 
> ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 d8 64 89 
> 01 48
> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 ORIG_RAX: 
> 000000000000000b
> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
> 00007f32872eb97b
> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
> 00007f32831ae000
> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
> 000055e7570ad230
> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
> 000055e75453cefa
> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
> 0000000000000000
> [   84.751584]  </TASK>
>
>

