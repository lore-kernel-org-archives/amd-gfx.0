Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E917E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 16:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA2D10EED7;
	Thu,  9 Jan 2025 16:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kFBHhvt9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2CE10EED8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 16:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/l+JQEvVW8kHN02scgC56I3mujMEFLGKVUl8ZFwyM2424n3SLKXR6kme/N4ZBUcibSfwm+DLUeBjRnxe+9iMWTbX5bOgraEFG646nkV6ue/NGmOVG/F/032k+8McVUzonG2m04+OCnuGXhN6oJCnXRaTK6P/qtLdVMmX1wMYi4V4xJHxXXBf8pEHq5xxJwMtqkNuT2WidLR8FxjrtaT0kfKwY9Pf+lnSjdZ9QPWY29T1KB9Hekr3mkSoeAZYCBnetDhikGlg2jPvDoptO0ewovcs5a0GLuH+ltkYNo+UG5m60fscNZUrGFrOcufEjGl8bZ6osU9TJOyy7TT1hiVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QIdO7FvVK950kSTFjJZmOnCInsFZ6jBuNyJAD1At4c=;
 b=gTFokWwMAQmF9r7tbN3gX/8nINgdkf82YJ5c48dOQg9Qz6AgYS1kUwt2XHybJP7eIXoKdqRg3buZbfcoygUqm0uzvEI4yug2dQ1d1oPWVH1m6JPmUNNtTuisGG15oL9BMMPqHDl7Tg78UBuIr1XDyxnuvkz410TkXnZoBudzdmdtnF3aU+novmJy8wAg43OPTs+vNv0Bg6woKfw41mYOGm0MM9vNdbxUYFPq/dNjSjhOjSJziJn7YozOP74D31l9oI/2P87iOnR//+mk+Bq/1HGNiHYujHsvoR4fLstrbIjZn/6YLw2uN2uzU3RS5DnIPcceVF2gRkZ0Vhfj4flFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QIdO7FvVK950kSTFjJZmOnCInsFZ6jBuNyJAD1At4c=;
 b=kFBHhvt9qz8ev4c8ZcIgTgRo7F2Y6yryW+4jlm8mSmSz1MLzCLeYNwsn60s2g46XcdMqGBeS22ylQzHWcdcaT0N+OIrOwjTAEF0mPLuFwvArB+Ue4Rwmauc+IS8WvPKdOSVJS1cdjN6qEKN5oC1Abc5OHWNToisfZF8lDeEiesM=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:09:57 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::62) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:09:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:09:55 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix Circular Locking Dependency in AMDGPU GFX
 Isolation
Date: Thu, 9 Jan 2025 21:39:38 +0530
Message-ID: <20250109160938.2855092-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1d6a44-2361-4e40-24af-08dd30c80fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDFLRVM2Z3NOc0NOMXVPeUw4OUpLMnArS1FKRURpYldiQWVzRjYvZ0ducGpi?=
 =?utf-8?B?SHVPQmtRNSt1YVhRRnZib1Q4aW45a2tWaXMwSEh4dEFNR1JGZzNiVGN5d3ND?=
 =?utf-8?B?cXFsd0ZIZ2g4WXMwZHcySGt1dFdmL3owVzJ6L3FFdkJrU05DSmU4MVhHajF4?=
 =?utf-8?B?T0xZT081OUVTeG1KKzh4bVYyMndXZE1EcmNZZ2ZnN3FhOFF5ZC9mMEN3T2l5?=
 =?utf-8?B?TGErZGh3emhaS3g4dDA4YkczdzJyVXVCK1JUY0ZSMkZxNm9aK24waDZOUHhs?=
 =?utf-8?B?a1NGS0VueUNaUWgyWTRNZWpUa3pTVzRxMlY1cHpqTGV1VEZOUitJU1BpMTRS?=
 =?utf-8?B?dVdNYXU4UmZ3QXc5eTJOTG01RXNISE13MCtocTRjcERsM2EyT2xhZXRHNzNa?=
 =?utf-8?B?MEpkMHNyRVpNSGNiZjFWWURMNkYvWkM2MGdEK3ZkUXZGYkRWdjE4dUNhdnkr?=
 =?utf-8?B?L2xPMGt3MHBVYmI2NDRITHlrdkRxVXZTZnVodHVGT09aMGRldHpjOSt1NlA4?=
 =?utf-8?B?S2RjTmg2YUpMa0JGUXVaMlJxcDZ1ai9aL0JRUmdYbndjd0F3dDhVRUM5a0xH?=
 =?utf-8?B?ZkF4TXhtbU1wOWt0dXdDUTlnVm5rNUhIMW9qOXUySGw1Sy81U09nWjY3OEY3?=
 =?utf-8?B?RGF6RlRza1lVN1V2ZzdHMllLMENFMmdiQndHdkNKdEk0N2J4VGNJRnBSTjJ4?=
 =?utf-8?B?YU9IVTF5VmFaM1Z6VlRybnZzUmVYK3orZVNUczhhTjczMTZYK3lZV2NCbWVZ?=
 =?utf-8?B?VjdtaWgxcWU5a2x4NmFRUVNOWSs3cGEzU1RBTVVwSXdIUXcyRWNGaFE1Vlgr?=
 =?utf-8?B?Zm1EZld3Z09qaERIcTRXc3AwSm4xY3BXQVVMZFM5MmpoV2RVTXhBN2xrMUhJ?=
 =?utf-8?B?eUNnTFdQbC9WdG5YcllkaVZWTTJWV0xMT3N5M2J4UHhNeG9SZTFhZU1xK3BH?=
 =?utf-8?B?SEhtMFk5ZkpDeW9vRk5oOXI2NDQ0S3pBZ0w0THRSbHJpQVhqNDh0QS9lK1c3?=
 =?utf-8?B?QVZ1YVV1UGpNbjdsbkNFYkZCWjhLTnJmd3VOKzlUK2NQWkVsM2RPRmxYVWNW?=
 =?utf-8?B?d1dvT053RWV4Ynd2NG45N2RrSm9UZmtSWnJJQkg0aEQ1aXlldXhOZXZjNldJ?=
 =?utf-8?B?YUpNTWVJN2I3TXZGak50dU9nMnV6Q25lWWpRdTMwVzQ3Nk5FdlpRend6aGFm?=
 =?utf-8?B?VXMzZE1lK0tWS2RwNlRCakM4NDZ6QkkycW1TckZLSzA1cWJISlFZSGNRZTJ2?=
 =?utf-8?B?SWlONnFxaXFoa1UwUHFvanJQd1ZydU9ISWRXUlhScHVKMER6SHd3cGl5Y1dQ?=
 =?utf-8?B?c0J4VXFlQVRoRGo0R3hqU1UzaGZBYUJRV0hmaTBIMHlrSC9WUm1sOWpERGYy?=
 =?utf-8?B?MjUxeHRaQUxZR05WZC9ybEsvREJJZ0J6QnpRdGNnUHRqc0NQL0cwaVdhdnJU?=
 =?utf-8?B?bGs1c2VZN0dWaXBoVHNnelhkK2UzMlA4S2xweFlxMlNaUzlONGJ1LzR5L3ZO?=
 =?utf-8?B?TTN5VGlDN1NoeWVXcHUzYWsyQ054QlY4SVpxaU5SMVFnYlR6bEtuaEF2dHNV?=
 =?utf-8?B?Yks1emFHdE43S2pJL29yV1VXSHkxdUEvdFQ3eThTMFRoeDVKaWpCVFI5K21N?=
 =?utf-8?B?dGQ0N0JaRTR6WnZheWVKSFhPL2dlMTFsaEw5c2JXcG04ZXFlWExaRmp1ck1G?=
 =?utf-8?B?ejBBWjkrNnRicWlzZ0Z5SWxWTi9tSU5wdnJpU1ZTaHhmR3ZLM3dLejRJNXgw?=
 =?utf-8?B?VWp4aFZKR2tEWiszOW5yNnd6MFJ0cU53Tlh3ck5waW5iakpna1Nxd0t4b3BI?=
 =?utf-8?B?R0NrNGFwTnBjRFU5dnNXRW1meG9VK1BEaWRtME16SlN1S0VjOXNYaFBaOWIr?=
 =?utf-8?B?ZGR6V29EZkVPR1RJWUlNMWFiT1pNdnhtK09TRi9WdE5YUUNFR1F0VnEyd3VY?=
 =?utf-8?B?Q3F1bFBZSVR6QzBmRElIUzA1dllOR29yL2ZDVU9EbFR5TkxZZUZLbWlBeFRY?=
 =?utf-8?Q?K/zX6ycnwyvskfk+6RlHGaCPqT4yjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:09:57.3637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d6a44-2361-4e40-24af-08dd30c80fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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

This commit addresses a circular locking dependency issue within the GFX
isolation mechanism. The problem was identified by a warning indicating
a potential deadlock due to inconsistent lock acquisition order.

- The `amdgpu_gfx_enforce_isolation_ring_begin_use` and
  `amdgpu_gfx_enforce_isolation_ring_end_use` functions previously
  acquired `enforce_isolation_mutex` and called `amdgpu_gfx_kfd_sch_ctrl`,
  leading to potential deadlocks. ie., If `amdgpu_gfx_kfd_sch_ctrl` is
  called while `enforce_isolation_mutex` is held, and
  `amdgpu_gfx_enforce_isolation_handler` is called while `kfd_sch_mutex` is
  held, it can create a circular dependency.

By ensuring consistent lock usage, this fix resolves the issue:

[  606.297333] ======================================================
[  606.297343] WARNING: possible circular locking dependency detected
[  606.297353] 6.10.0-amd-mlkd-610-311224-lof #19 Tainted: G           OE
[  606.297365] ------------------------------------------------------
[  606.297375] kworker/u96:3/3825 is trying to acquire lock:
[  606.297385] ffff9aa64e431cb8 ((work_completion)(&(&adev->gfx.enforce_isolation[i].work)->work)){+.+.}-{0:0}, at: __flush_work+0x232/0x610
[  606.297413]
               but task is already holding lock:
[  606.297423] ffff9aa64e432338 (&adev->gfx.kfd_sch_mutex){+.+.}-{3:3}, at: amdgpu_gfx_kfd_sch_ctrl+0x51/0x4d0 [amdgpu]
[  606.297725]
               which lock already depends on the new lock.

[  606.297738]
               the existing dependency chain (in reverse order) is:
[  606.297749]
               -> #2 (&adev->gfx.kfd_sch_mutex){+.+.}-{3:3}:
[  606.297765]        __mutex_lock+0x85/0x930
[  606.297776]        mutex_lock_nested+0x1b/0x30
[  606.297786]        amdgpu_gfx_kfd_sch_ctrl+0x51/0x4d0 [amdgpu]
[  606.298007]        amdgpu_gfx_enforce_isolation_ring_begin_use+0x2a4/0x5d0 [amdgpu]
[  606.298225]        amdgpu_ring_alloc+0x48/0x70 [amdgpu]
[  606.298412]        amdgpu_ib_schedule+0x176/0x8a0 [amdgpu]
[  606.298603]        amdgpu_job_run+0xac/0x1e0 [amdgpu]
[  606.298866]        drm_sched_run_job_work+0x24f/0x430 [gpu_sched]
[  606.298880]        process_one_work+0x21e/0x680
[  606.298890]        worker_thread+0x190/0x350
[  606.298899]        kthread+0xe7/0x120
[  606.298908]        ret_from_fork+0x3c/0x60
[  606.298919]        ret_from_fork_asm+0x1a/0x30
[  606.298929]
               -> #1 (&adev->enforce_isolation_mutex){+.+.}-{3:3}:
[  606.298947]        __mutex_lock+0x85/0x930
[  606.298956]        mutex_lock_nested+0x1b/0x30
[  606.298966]        amdgpu_gfx_enforce_isolation_handler+0x87/0x370 [amdgpu]
[  606.299190]        process_one_work+0x21e/0x680
[  606.299199]        worker_thread+0x190/0x350
[  606.299208]        kthread+0xe7/0x120
[  606.299217]        ret_from_fork+0x3c/0x60
[  606.299227]        ret_from_fork_asm+0x1a/0x30
[  606.299236]
               -> #0 ((work_completion)(&(&adev->gfx.enforce_isolation[i].work)->work)){+.+.}-{0:0}:
[  606.299257]        __lock_acquire+0x16f9/0x2810
[  606.299267]        lock_acquire+0xd1/0x300
[  606.299276]        __flush_work+0x250/0x610
[  606.299286]        cancel_delayed_work_sync+0x71/0x80
[  606.299296]        amdgpu_gfx_kfd_sch_ctrl+0x287/0x4d0 [amdgpu]
[  606.299509]        amdgpu_gfx_enforce_isolation_ring_begin_use+0x2a4/0x5d0 [amdgpu]
[  606.299723]        amdgpu_ring_alloc+0x48/0x70 [amdgpu]
[  606.299909]        amdgpu_ib_schedule+0x176/0x8a0 [amdgpu]
[  606.300101]        amdgpu_job_run+0xac/0x1e0 [amdgpu]
[  606.300355]        drm_sched_run_job_work+0x24f/0x430 [gpu_sched]
[  606.300369]        process_one_work+0x21e/0x680
[  606.300378]        worker_thread+0x190/0x350
[  606.300387]        kthread+0xe7/0x120
[  606.300396]        ret_from_fork+0x3c/0x60
[  606.300406]        ret_from_fork_asm+0x1a/0x30
[  606.300416]
               other info that might help us debug this:

[  606.300428] Chain exists of:
                 (work_completion)(&(&adev->gfx.enforce_isolation[i].work)->work) --> &adev->enforce_isolation_mutex --> &adev->gfx.kfd_sch_mutex

[  606.300458]  Possible unsafe locking scenario:

[  606.300468]        CPU0                    CPU1
[  606.300476]        ----                    ----
[  606.300484]   lock(&adev->gfx.kfd_sch_mutex);
[  606.300494]                                lock(&adev->enforce_isolation_mutex);
[  606.300508]                                lock(&adev->gfx.kfd_sch_mutex);
[  606.300521]   lock((work_completion)(&(&adev->gfx.enforce_isolation[i].work)->work));
[  606.300536]
                *** DEADLOCK ***

[  606.300546] 5 locks held by kworker/u96:3/3825:
[  606.300555]  #0: ffff9aa5aa1f5d58 ((wq_completion)comp_1.1.0){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[  606.300577]  #1: ffffaa53c3c97e40 ((work_completion)(&sched->work_run_job)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[  606.300600]  #2: ffff9aa64e463c98 (&adev->enforce_isolation_mutex){+.+.}-{3:3}, at: amdgpu_gfx_enforce_isolation_ring_begin_use+0x1c3/0x5d0 [amdgpu]
[  606.300837]  #3: ffff9aa64e432338 (&adev->gfx.kfd_sch_mutex){+.+.}-{3:3}, at: amdgpu_gfx_kfd_sch_ctrl+0x51/0x4d0 [amdgpu]
[  606.301062]  #4: ffffffff8c1a5660 (rcu_read_lock){....}-{1:2}, at: __flush_work+0x70/0x610
[  606.301083]
               stack backtrace:
[  606.301092] CPU: 14 PID: 3825 Comm: kworker/u96:3 Tainted: G           OE      6.10.0-amd-mlkd-610-311224-lof #19
[  606.301109] Hardware name: Gigabyte Technology Co., Ltd. X570S GAMING X/X570S GAMING X, BIOS F7 03/22/2024
[  606.301124] Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
[  606.301140] Call Trace:
[  606.301146]  <TASK>
[  606.301154]  dump_stack_lvl+0x9b/0xf0
[  606.301166]  dump_stack+0x10/0x20
[  606.301175]  print_circular_bug+0x26c/0x340
[  606.301187]  check_noncircular+0x157/0x170
[  606.301197]  ? register_lock_class+0x48/0x490
[  606.301213]  __lock_acquire+0x16f9/0x2810
[  606.301230]  lock_acquire+0xd1/0x300
[  606.301239]  ? __flush_work+0x232/0x610
[  606.301250]  ? srso_alias_return_thunk+0x5/0xfbef5
[  606.301261]  ? mark_held_locks+0x54/0x90
[  606.301274]  ? __flush_work+0x232/0x610
[  606.301284]  __flush_work+0x250/0x610
[  606.301293]  ? __flush_work+0x232/0x610
[  606.301305]  ? __pfx_wq_barrier_func+0x10/0x10
[  606.301318]  ? mark_held_locks+0x54/0x90
[  606.301331]  ? srso_alias_return_thunk+0x5/0xfbef5
[  606.301345]  cancel_delayed_work_sync+0x71/0x80
[  606.301356]  amdgpu_gfx_kfd_sch_ctrl+0x287/0x4d0 [amdgpu]
[  606.301661]  amdgpu_gfx_enforce_isolation_ring_begin_use+0x2a4/0x5d0 [amdgpu]
[  606.302050]  ? srso_alias_return_thunk+0x5/0xfbef5
[  606.302069]  amdgpu_ring_alloc+0x48/0x70 [amdgpu]
[  606.302452]  amdgpu_ib_schedule+0x176/0x8a0 [amdgpu]
[  606.302862]  ? drm_sched_entity_error+0x82/0x190 [gpu_sched]
[  606.302890]  amdgpu_job_run+0xac/0x1e0 [amdgpu]
[  606.303366]  drm_sched_run_job_work+0x24f/0x430 [gpu_sched]
[  606.303388]  process_one_work+0x21e/0x680
[  606.303409]  worker_thread+0x190/0x350
[  606.303424]  ? __pfx_worker_thread+0x10/0x10
[  606.303437]  kthread+0xe7/0x120
[  606.303449]  ? __pfx_kthread+0x10/0x10
[  606.303463]  ret_from_fork+0x3c/0x60
[  606.303476]  ? __pfx_kthread+0x10/0x10
[  606.303489]  ret_from_fork_asm+0x1a/0x30
[  606.303512]  </TASK>

Fixes: afefd6f24502 ("drm/amdgpu: Implement Enforce Isolation Handler for KGD/KFD serialization")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: Refactor lock handling to resolve circular dependency  (Alex)
  
- Introduced a `sched_work` flag to defer the call to `amdgpu_gfx_kfd_sch_ctrl` until after releasing `enforce_isolation_mutex`.  
- This change ensures that `amdgpu_gfx_kfd_sch_ctrl` is called outside the critical section, preventing the circular dependency and deadlock.  
- The `sched_work` flag is set within the mutex-protected section if conditions are met, and the actual function call is made afterward.  
- This approach ensures consistent lock acquisition order.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e..784b03abb3a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2054,6 +2054,7 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 idx;
+	bool sched_work = false;
 
 	if (!adev->gfx.enable_cleaner_shader)
 		return;
@@ -2072,9 +2073,12 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	mutex_lock(&adev->enforce_isolation_mutex);
 	if (adev->enforce_isolation[idx]) {
 		if (adev->kfd.init_complete)
-			amdgpu_gfx_kfd_sch_ctrl(adev, idx, false);
+			sched_work = true;
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
+
+	if (sched_work)
+		amdgpu_gfx_kfd_sch_ctrl(adev, idx, false);
 }
 
 /**
@@ -2090,6 +2094,7 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 idx;
+	bool sched_work = false;
 
 	if (!adev->gfx.enable_cleaner_shader)
 		return;
@@ -2105,9 +2110,12 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 	mutex_lock(&adev->enforce_isolation_mutex);
 	if (adev->enforce_isolation[idx]) {
 		if (adev->kfd.init_complete)
-			amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
+			sched_work = true;
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
+
+	if (sched_work)
+		amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
 }
 
 /*
-- 
2.34.1

