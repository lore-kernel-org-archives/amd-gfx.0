Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D99C021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD29D10E2C5;
	Mon, 24 Feb 2025 13:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fo+Btaid";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C96A10E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 13:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJnj/sD8HuSQdKLP8z8o7DUgjV+vPaRw3jtHklzpZVneeD/TP4ROKE5z4nBQyRB3fCUYZlFswQeMGS5r+3HTX4oLx6IEDej+Sf4V0x6P/BepqbeOC396S3Mv2O1P8YFXGae2FHTUh2Bi0gmNx0mknjqyrkS1bvqexODUmwr4PglpEbBFAGVj/gd77F4VDYN+WV5ksZyXoq7VND3sAPsEgitmJEiSdc6MJRE/VrkWH2VVTNa+HyL6LEyeRV2kPrAOFT9QfS0dUIUcS9zOURDYf2FfagQefwKYR209QbAKPUR5yAZbZPv3QCsQJUJ9muC06CfDYfNks0m/4POY5mQI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orlJbNddZCLa3WGavDi8Wp47Y7MZPwKs/hGicr/jOlQ=;
 b=RUkCcsKb6Jed9eu/bRQG8HuAmmUkwmVW9t5D8bD2PO+EOzcm36TIjJwaZJ/oDbRsN5Ep80BFBbJo1PmmHcwUJy9SdFwXqhL7as++SzbIjfTgn2nE/TA4nV3epuRk+E1h+YaxGHgjpMKkkEyFDFVmseXD2y9e7LPGyGMxYMZoJVa+7XwIgA/OoB9Tjd7BwVdzqacZrS78w0IbaVdjxBHAO72e+yPJgKULWifWHYPvnnkJVeyPwXJC00GPPbnJqsTJaRGxDhw4I2Ktpp/3n8Uurb/Kv5Q+KU7Cu/uku1mai3nVdY6mGyzMKcAOWb9HyTAGKnp8HZco8LagoXAxD4xzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orlJbNddZCLa3WGavDi8Wp47Y7MZPwKs/hGicr/jOlQ=;
 b=fo+Btaid0GN+Q//Y0frALM1RUE5T/So/I0Qb99wAqU69PcVzwq9r8KWMdc755efGoY1kCRi0Xm+bFyiAlpaKoNtKAmrhLJ6mVYpbzCDxizYfav3w62O7DxMLl/7Mj97Vj4USGwgGfD2SasxXQMZn9MsoguRy23H+kfhhSSrNwc4=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:49:05 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::6) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Mon,
 24 Feb 2025 13:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 13:49:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 07:49:01 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, "Yunxiang
 Li" <Yunxiang.Li@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
Date: Mon, 24 Feb 2025 19:18:12 +0530
Message-ID: <20250224134812.2319376-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224113020.2273984-1-srinivasan.shanmugam@amd.com>
References: <20250224113020.2273984-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc8cf22-9181-4016-3015-08dd54da00b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXg5MC9uWFIrTEdadHZXWmNUdnpYV2dHZEMxZnN3RDByVnpCL3k0VGNLcDh1?=
 =?utf-8?B?Ui80ZFZuVDZ3Y3dGby9NbzdsaU0vTjBWNTE0bndpbFVVcDRHNnlFQXNZYWtQ?=
 =?utf-8?B?Mk1oSC9jREpYODd5MURUME1LUXM0SDkxZDdWMWMrV0dEUzlGYVhuWGRuK0JL?=
 =?utf-8?B?UWlPRTZhemUrWHRqNEU0WEtWK2ozejIwalc0QzhrLzBjWk15R250RkJUNWpT?=
 =?utf-8?B?OGwxSkxheEpmNkJZcnp6RjRaVUlraHVDYzZtSi9DdUFWSmZHNTdVcWYvanlh?=
 =?utf-8?B?Wm5YaHhsVUhjbFJCVEl5NVpCcktUM0FpNjFMcEh4RHRoby94OWozbnhuTFNR?=
 =?utf-8?B?VkZ2OFp4TzczdHJoeWNIbHpZNi9maUd0bTFGUTVoWWVsSlROMnZLWFN3VUVv?=
 =?utf-8?B?NDdVOGNFMTRXdjNwTkpKaTZlWXNvVFBUazBlSnl6VERObXZUa0c1akZ4Wi9x?=
 =?utf-8?B?aStFNzAwajFHbVA0V1QyZ1M4dlhEQk5nL3dGRDBGOWFhTTVsSW9ZeXhUSjdw?=
 =?utf-8?B?YVlib3ZhdTdwcW5CRkliZFZTWnp1YXR1a2k1a0ZRM0xLcHhiVUNrVTRrYWRN?=
 =?utf-8?B?d2o4TXdWN0ptMjNVMHErNGRGSmZrd0x3d1JDNmo4TW90d0NmekN0REpzcmVo?=
 =?utf-8?B?OHB3dUVmWUU5Ymp3c0NTUGZoR3RVSjRMYVgwS2M3VHhpQW5CY2tCbmJVbUhY?=
 =?utf-8?B?RS9YcVpXWGZ1bXZuYThHRjcrV1FOaXZWd0UzNUJXTDZyZ210MWZDNVNKcWxI?=
 =?utf-8?B?cm50dk94ZlhCaWRCZTdpSldzb1VHNW44eXNKUlZ6dTJLb2Vmem5Ialk5V2lO?=
 =?utf-8?B?azM5MkFYSmdNbTU2dWNhekRycTh3SVZsbXduUXVYVzdpWHNIQVgrY01LL1VN?=
 =?utf-8?B?TkExRno1U3dySjljTjVFeFc2MXMreHMrS00yN1NpdG5PZGhPMkQ0ZkhieVBm?=
 =?utf-8?B?VjA3V0JsakxxdkdTY2wyb0ZFbWZxZWViWkUxTUJCbXp3YTNSUzZrNzY1WURD?=
 =?utf-8?B?QWVhVm9uNS9OYXRWOFhCaW1SbzhoQ216ay9vbXA0QUtjSThDektMVWt3VytC?=
 =?utf-8?B?R05xV3hBaFFMaEdhQXN3bmJwM3YwMFlMYVpGYVQwVUxkOVdZZTF5blN1bllI?=
 =?utf-8?B?bWxtMHVNTUtIYVViei9ZRUphdUc5UnBOdlpsVlVNYzRSQnhLY244K3VweVEy?=
 =?utf-8?B?V3NLemgxQlJXMUVIQmdRZmhEY1N1TzZtTHVLTGk3dVZRNzIzczMvcHVkaXdB?=
 =?utf-8?B?VHdWbFh0QTlYOUp3YXdsOG1XekU1cm54akFZZytWZ1NsQk1KeHd4VHFLNzdQ?=
 =?utf-8?B?Uk9ZMkg1aGI1eGs3eU5XNFNKR2ExdFREUWxjSU4xWWhPYjJNdzZPV1dib085?=
 =?utf-8?B?cXdDcFk2MzlwbTV3VFdoR1F0NlEzSHZCNytqM2drMGZ5dkx4WWdvSmZGYUdJ?=
 =?utf-8?B?YS80aCtQSU1wVzdycnlJeXZuOGNwb200ZlpYcWl1T2ZKbXRXcXRlOTRPNm5U?=
 =?utf-8?B?M1AyYnY2dm8rYkFJeFA2RE95MVZUUE0zVUZYNThIenkwbTd4aFBneElxeHY0?=
 =?utf-8?B?UTV5QUJJZnhuZHp1c0JKWG9rcjVQYTNZS09nMHp0NkRoQkk3RW4zNTRqZnE2?=
 =?utf-8?B?MTYvTXRHL3pWN2ZaOXowazBUOEpYaXpTSXgyYVJTZGwrRzVmOHFBMW1Jd2xO?=
 =?utf-8?B?WEZCQW1odzNrejJlNFhRMDltYmt2S1lMSmZPS2NyV0xwWnJrRkNqcmtWOTk5?=
 =?utf-8?B?MXVHNnZXZXJXUm9yNCtscFNPa1luR1QrZDRac2Y4YU9PK0k3VzZFclRvV045?=
 =?utf-8?B?VVBhMXZaNXdCU1UvNUZlaktxUFg1OGM0WUpMbHlPSDlONlIvKzAxVTNTT0Z4?=
 =?utf-8?B?VDFyUHVxTWl4VmpuelQ4Q3l4Vktwa3V1Y1l0aWw5cUR1R2x4WUlnY2hDTTBm?=
 =?utf-8?B?c2x3aW11RXpyelN2R1U5VUlZMmhMUkRJVHIyNTRuZEZ5YXVObk5WdFJlWUFm?=
 =?utf-8?Q?EteMMc7y/ZQ1pvJPy2HLWZWfMOMawc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:49:04.7356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc8cf22-9181-4016-3015-08dd54da00b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

This commit addresses a circular locking dependency in the
svm_range_cpu_invalidate_pagetables function. The function previously
held a lock while determining whether to perform an unmap or eviction
operation, which could lead to deadlocks.

v2: To resolve this issue, the allocation of the process context buffer
(`proc_ctx_bo`) has been moved from the `add_queue_mes` function to
the `pqm_create_queue` function. This change ensures that the buffer
is allocated only when the first queue for a process is created and
only if the Micro Execution Scheduler (MES) is enabled. (Felix)

Fixes the below:

[  223.418794] ======================================================
[  223.418820] WARNING: possible circular locking dependency detected
[  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  223.418869] ------------------------------------------------------
[  223.418889] kfdtest/3939 is trying to acquire lock:
[  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.419302]
               but task is already holding lock:
[  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
[  223.419447] Console: switching to colour dummy device 80x25
[  223.419477] [IGT] amd_basic: executing
[  223.419599]
               which lock already depends on the new lock.

[  223.419611]
               the existing dependency chain (in reverse order) is:
[  223.419621]
               -> #2 (&prange->lock){+.+.}-{3:3}:
[  223.419636]        __mutex_lock+0x85/0xe20
[  223.419647]        mutex_lock_nested+0x1b/0x30
[  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
[  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
[  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
[  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
[  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
[  223.421024]        __x64_sys_ioctl+0x95/0xd0
[  223.421036]        x64_sys_call+0x1205/0x20d0
[  223.421047]        do_syscall_64+0x87/0x140
[  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.421068]
               -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
[  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
[  223.421095]        ww_mutex_lock+0x2b/0x90
[  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
[  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
[  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
[  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
[  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
[  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
[  223.422662]        process_one_work+0x21e/0x680
[  223.422673]        worker_thread+0x190/0x330
[  223.422682]        kthread+0xe7/0x120
[  223.422690]        ret_from_fork+0x3c/0x60
[  223.422699]        ret_from_fork_asm+0x1a/0x30
[  223.422708]
               -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
[  223.422723]        __lock_acquire+0x16f4/0x2810
[  223.422734]        lock_acquire+0xd1/0x300
[  223.422742]        __mutex_lock+0x85/0xe20
[  223.422751]        mutex_lock_nested+0x1b/0x30
[  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
[  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
[  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
[  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
[  223.423819]        copy_page_range+0x1e94/0x1ea0
[  223.423829]        copy_process+0x172f/0x2ad0
[  223.423839]        kernel_clone+0x9c/0x3f0
[  223.423847]        __do_sys_clone+0x66/0x90
[  223.423856]        __x64_sys_clone+0x25/0x30
[  223.423864]        x64_sys_call+0x1d7c/0x20d0
[  223.423872]        do_syscall_64+0x87/0x140
[  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.423891]
               other info that might help us debug this:

[  223.423903] Chain exists of:
                 &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock

[  223.423926]  Possible unsafe locking scenario:

[  223.423935]        CPU0                    CPU1
[  223.423942]        ----                    ----
[  223.423949]   lock(&prange->lock);
[  223.423958]                                lock(reservation_ww_class_mutex);
[  223.423970]                                lock(&prange->lock);
[  223.423981]   lock(&dqm->lock_hidden);
[  223.423990]
                *** DEADLOCK ***

[  223.423999] 5 locks held by kfdtest/3939:
[  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
[  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
[  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
[  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
[  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
[  223.424365]
               stack backtrace:
[  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
[  223.424416] Call Trace:
[  223.424423]  <TASK>
[  223.424430]  dump_stack_lvl+0x9b/0xf0
[  223.424441]  dump_stack+0x10/0x20
[  223.424449]  print_circular_bug+0x275/0x350
[  223.424460]  check_noncircular+0x157/0x170
[  223.424469]  ? __bfs+0xfd/0x2c0
[  223.424481]  __lock_acquire+0x16f4/0x2810
[  223.424490]  ? srso_return_thunk+0x5/0x5f
[  223.424505]  lock_acquire+0xd1/0x300
[  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.424783]  __mutex_lock+0x85/0xe20
[  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425058]  ? srso_return_thunk+0x5/0x5f
[  223.425067]  ? mark_held_locks+0x54/0x90
[  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425339]  ? srso_return_thunk+0x5/0x5f
[  223.425350]  mutex_lock_nested+0x1b/0x30
[  223.425358]  ? mutex_lock_nested+0x1b/0x30
[  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
[  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
[  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
[  223.426423]  ? srso_return_thunk+0x5/0x5f
[  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
[  223.426450]  copy_page_range+0x1e94/0x1ea0
[  223.426461]  ? srso_return_thunk+0x5/0x5f
[  223.426474]  ? srso_return_thunk+0x5/0x5f
[  223.426484]  ? lock_acquire+0xd1/0x300
[  223.426494]  ? copy_process+0x1718/0x2ad0
[  223.426502]  ? srso_return_thunk+0x5/0x5f
[  223.426510]  ? sched_clock_noinstr+0x9/0x10
[  223.426519]  ? local_clock_noinstr+0xe/0xc0
[  223.426528]  ? copy_process+0x1718/0x2ad0
[  223.426537]  ? srso_return_thunk+0x5/0x5f
[  223.426550]  copy_process+0x172f/0x2ad0
[  223.426569]  kernel_clone+0x9c/0x3f0
[  223.426577]  ? __schedule+0x4c9/0x1b00
[  223.426586]  ? srso_return_thunk+0x5/0x5f
[  223.426594]  ? sched_clock_noinstr+0x9/0x10
[  223.426602]  ? srso_return_thunk+0x5/0x5f
[  223.426610]  ? local_clock_noinstr+0xe/0xc0
[  223.426619]  ? schedule+0x107/0x1a0
[  223.426629]  __do_sys_clone+0x66/0x90
[  223.426643]  __x64_sys_clone+0x25/0x30
[  223.426652]  x64_sys_call+0x1d7c/0x20d0
[  223.426661]  do_syscall_64+0x87/0x140
[  223.426671]  ? srso_return_thunk+0x5/0x5f
[  223.426679]  ? common_nsleep+0x44/0x50
[  223.426690]  ? srso_return_thunk+0x5/0x5f
[  223.426698]  ? trace_hardirqs_off+0x52/0xd0
[  223.426709]  ? srso_return_thunk+0x5/0x5f
[  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426727]  ? srso_return_thunk+0x5/0x5f
[  223.426736]  ? do_syscall_64+0x93/0x140
[  223.426748]  ? srso_return_thunk+0x5/0x5f
[  223.426756]  ? up_write+0x1c/0x1e0
[  223.426765]  ? srso_return_thunk+0x5/0x5f
[  223.426775]  ? srso_return_thunk+0x5/0x5f
[  223.426783]  ? trace_hardirqs_off+0x52/0xd0
[  223.426792]  ? srso_return_thunk+0x5/0x5f
[  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426810]  ? srso_return_thunk+0x5/0x5f
[  223.426818]  ? do_syscall_64+0x93/0x140
[  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426836]  ? srso_return_thunk+0x5/0x5f
[  223.426844]  ? do_syscall_64+0x93/0x140
[  223.426853]  ? srso_return_thunk+0x5/0x5f
[  223.426861]  ? irqentry_exit+0x6b/0x90
[  223.426869]  ? srso_return_thunk+0x5/0x5f
[  223.426877]  ? exc_page_fault+0xa7/0x2c0
[  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.426898] RIP: 0033:0x7f46758eab57
[  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
[  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
[  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
[  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
[  223.427004]  </TASK>

Fixes: 3e5199134e47 ("drm/amdkfd: pause autosuspend when creating pdd")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Alex Sierra <alex.sierra@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3: Fix typo s/Memory Execution Scheduler (MES)/Micro Engine Scheduler (Lijo).

 .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 15 ---------------
 .../drm/amd/amdkfd/kfd_process_queue_manager.c   | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 195085079eb2..94b1ac8a4735 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -207,21 +207,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
-				AMDGPU_MES_PROC_CTX_SIZE,
-				&pdd->proc_ctx_bo,
-				&pdd->proc_ctx_gpu_addr,
-				&pdd->proc_ctx_cpu_ptr,
-				false);
-		if (r) {
-			dev_err(adev->dev,
-				"failed to allocate process context bo\n");
-			return r;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-	}
-
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = pdd->pasid;
 	queue_input.page_table_base_addr =  qpd->page_table_base;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d7947311cbbd..a4e3d389ffad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -363,10 +363,26 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	if (retval != 0)
 		return retval;
 
+	/* Register process if this is the first queue */
 	if (list_empty(&pdd->qpd.queues_list) &&
 	    list_empty(&pdd->qpd.priv_queue_list))
 		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
 
+    /* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
+    if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
+	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+					     AMDGPU_MES_PROC_CTX_SIZE,
+					      &pdd->proc_ctx_bo,
+					      &pdd->proc_ctx_gpu_addr,
+					      &pdd->proc_ctx_cpu_ptr,
+					      false);
+	if (retval) {
+	    dev_err(dev->adev->dev, "failed to allocate process context bo\n");
+	return retval;
+	}
+	memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+    }
+
 	pqn = kzalloc(sizeof(*pqn), GFP_KERNEL);
 	if (!pqn) {
 		retval = -ENOMEM;
-- 
2.34.1

