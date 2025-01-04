Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0192E77188
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 06:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621D210E0BB;
	Sat,  4 Jan 2025 06:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyOCwvup";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAFC10E0BB
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 06:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJtt1pvNmzVV/qE2qPZWOdtwrFQsGldMOj0Lc6xzztMD2m917Slep/+CIHtXVY5wparLU9VbvPqJxueKo4iRHOPYLOc+SXq2s7pgMzbmNwbSz7nW/xY3r87gUHoL9eaS9Qh7dK2eSC25UvAvMkt3um6dh5x3jZcLBHq2gP0kd6gvqDjtyXV1PiVe0S4hp6Tl7k/ZTUTK5lxNOz4ZEVfbmuscVT7KyH/tucFZTL9p8hrp44fFnIYQXbxlOrivKBw6/YxoctWxEImhRsKT7kb5h3HgMmpZPXtSmOnIKsXNHx6bAsUcS3B9Y4zoOTcTlayx5TZvM3wzO0CDizdYNX5ReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9JTV7xU78BsKQfS9oRmf5svZ/hUKJNHpVJIskQMcFY=;
 b=VE8iXxTt+qMljIdkcBj2uhnFjjKxfjOE9+CtSr4B9jfkfPirNloyG1wR4ZfgzcAbeUw8ALc8dPbfDKbtZpXS89rylmp9hZ8SRVHYRS5DEHvKbeuEeHomo4cigInyHOFbP1UnXlcorlSuJKWplOSIrwYjDxMTED+C2130yq4Jqxm5fvYMkt8Q56YncZZVUpRf77DXJPCpgXmyRI1WCAJBfYDfxwM9Fi+BA9W7xna6jn4x4pFdl6RvXTU+yV2F9yoqcs/7t+ghry2sUBFjDSNuQmBTtUrcdjjDYWvIAyZUNDQoruZyDHrpASBi52MkjPa8WjsId+EqWAf0RgbtfP6e+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9JTV7xU78BsKQfS9oRmf5svZ/hUKJNHpVJIskQMcFY=;
 b=EyOCwvupRKXX6UPxfjns8qyL1BY8zwpwZYDV8DEjV6JzPuAS1BZ1Zo5sjSwsbz/+MC3Tv3joW6dELYZFRAjyVgYua6i2xCETHTaU64ykKurNPbQk5SH+tZZw2/9lGq2qWdLluuOJwDdCpk2Ku/zYKtCIYMLNhi4nyvPyuR73gLU=
Received: from BL1PR13CA0066.namprd13.prod.outlook.com (2603:10b6:208:2b8::11)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Sat, 4 Jan
 2025 06:02:25 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a0) by BL1PR13CA0066.outlook.office365.com
 (2603:10b6:208:2b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.6 via Frontend Transport; Sat, 4
 Jan 2025 06:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Sat, 4 Jan 2025 06:02:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 4 Jan 2025 00:02:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Circular Locking Dependency in AMDGPU GFX
 Isolation
Date: Sat, 4 Jan 2025 11:32:09 +0530
Message-ID: <20250104060209.3628441-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b53020-69e0-47b3-f765-08dd2c855ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVkxMmxlWGk1bU1BdU84VGRjc05ZWHJSWm5ScEJTL3lKOFJ0VG13YU11eHl0?=
 =?utf-8?B?MFM5UEZxeXBQbm1Tb1o5aTgyQUFxQlhqRWgyMUNIZ1RTaU1DMXh2bThOU0Rx?=
 =?utf-8?B?a05QN1pMNzVCN3ZJaEVPQ1J4d1FrRHVsaEVnb094cENqbE5lbUZvU2pxL2Zl?=
 =?utf-8?B?U0FOcFNXa0xlb3JjbXRodGhSOUtldkZzUEZsU1FQQ1h0U0kyRlZtN0VTcjlI?=
 =?utf-8?B?OEQ1UElxUzhKMGxFNU1IRnFoOHVIVlI3UnRtRms3VFEyNnJ0UkJvdjFia1lo?=
 =?utf-8?B?ejU0U2NqYk43TWFwMlJwc1lldlNralMyQVN2bzRpMDg5TUhoYVZCOXF5cHlR?=
 =?utf-8?B?MEZscStmSmR0MEZCVy9LNXk1STBxVk5jbFVhbUx4MllyakpVUEU4ODZRcFo2?=
 =?utf-8?B?WDcwUFRtZVFRUVR5eWMyRGxBd0FzK0ZYYWRxSyszVmxIU2JPOFQzK2pYRnpp?=
 =?utf-8?B?RTA1QkVpZG1Yd1BhS1BkRi9qL2lYVzQ2b3VEYUxzbU9UMnQzeHBWUVRmU3dT?=
 =?utf-8?B?RzBaSWZaUk9zclRDbzVDNjUrOUZkdDNFV0ZuTVNZaEd3TDV4Qk80MEd1blVj?=
 =?utf-8?B?OUhqYmUzTmZVaGcyT1FoLzM3eTIvZG4xZWVyeTdScG14UUFaeHpjVXpIZGdJ?=
 =?utf-8?B?cWFDZGF4cExzQ29LbGUvUUxEcFd3WjhHRSs5L2Y0Y2EyckJhbGl5RjUvTHFJ?=
 =?utf-8?B?UHpRSnpJTUxXWFZYb052Ykp3bXlDYlhHbE90ZmQ2N0JrSkNta1Y3QjFNV1JO?=
 =?utf-8?B?bmZCOGw3RGRGRng3NTJ2eDYvQVlFeE12T3gyVFZtUkhBWE9DcWx1MVZVR3pK?=
 =?utf-8?B?OENBbWNWQnFZVlcxTXR1NXh5ZWh0cDlWUmJEdSt0ZmJyYjFhZUJxamdSdlJx?=
 =?utf-8?B?bXdjOExRRUtyYXEzcFZEL2llT2NQcW94ekRkdThSYzZjR1d4VnY1OFVyaHBV?=
 =?utf-8?B?Z0NPZkpQSzhZTWxuNlM4MDBjcG1mWE0rV2ZBMkE1RDJMK1pHUkcwYmc2U1Qr?=
 =?utf-8?B?RVZvYnoyNCtsc3RUWWlSVHcrMGdEWWxsdURJZVkxOW5jNzZvbkVSNC8xdSt6?=
 =?utf-8?B?NVo5bytEUmVGajIxRVJ2VmpsYXlEaUpodVNiMGFVSEZZTjJMY0JYVFNpTll5?=
 =?utf-8?B?UkVmOFprWlN4TGhKTkR3SU0rVnRJVnZHWlc0VU9zZmxLbHVqVi80b1NQQ2JO?=
 =?utf-8?B?eUJaTVU3MG9nMmVTMG1EOTJZRSt5TXg2MlBxMzNFK1pESG1TMjY2S3hIREFY?=
 =?utf-8?B?K0JiTFNrK1g5OE9IMWpyMEVqZGl0V1RFbDluYXNxY3VQckgxK01EdHRqcDFp?=
 =?utf-8?B?VG9GUkNpSFZnejkzRUNiektoNVFHWkl1QWFEaGRWdUxrMHo5cUw5SHc0Uy9J?=
 =?utf-8?B?L2RWRndaUnJzSzFXdUNDSzZPKzFEWlRoTjQxZ3B6Sk1HcHdJWnQwSDV1a0VW?=
 =?utf-8?B?Y0V3UHVnOUtORDVDam4wdTRudjM2K2YvVVJLRnpOdlE1WG9ZWGlhNC9vZmxP?=
 =?utf-8?B?MXI4dGJMNDJacHQxdlBTY2svQk9MZU12cnpxaTh0cFBxWEVodGZGOHAzLzdK?=
 =?utf-8?B?SjAvNWQvcUVESyt5LzhmSkpQbzdmY01vQ1NsUXdSR2htaEk5d05GOHoycDR4?=
 =?utf-8?B?WEhROWJtVm5GMkdTL0FlVWRCczdINkUzNFJEUzQ3ZFN0M1JLQW40VHc2dXls?=
 =?utf-8?B?RSs5dzVwUndTR2wxcmRDQWRGU3pOK3o1KzRzbk81bVdnUG1kdkJFMmZ3SkdR?=
 =?utf-8?B?TUpkd1JRdEFhMm1SOE04Vi9Od3MwQUJmQXRtK1VzVlVVZDlyRitDeTB5aXFG?=
 =?utf-8?B?MFlhdVFkcisybDluSE9Uc2FuWU1Bemt6c2grZFE2S082cWFSMjdBTGsrQ3Js?=
 =?utf-8?B?emQyMUZhV0pIbk8yWE1xajV3dG1mK0lVQm9GRXEveWNKenE3bFRhSis3eU5I?=
 =?utf-8?B?SEhjcnoxaVRCY21JNC9Oc2padS9qNlU5cG1lbHd4SmdrbFM1Y05vcmJUdkU4?=
 =?utf-8?Q?JzI5RgDBi6C9hyKb1w7szdfzZfa0Lo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 06:02:25.5062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b53020-69e0-47b3-f765-08dd2c855ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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

Solution:
- Removed the acquisition of `enforce_isolation_mutex` in
  `amdgpu_gfx_enforce_isolation_ring_begin_use` and
  `amdgpu_gfx_enforce_isolation_ring_end_use`.
- This change ensures that locks are acquired in a consistent order,
  preventing the circular dependency and potential deadlock.

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
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e..89f7c89d1392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2069,12 +2069,10 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	/* Don't submit more work until KFD has had some time */
 	amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
 
-	mutex_lock(&adev->enforce_isolation_mutex);
 	if (adev->enforce_isolation[idx]) {
 		if (adev->kfd.init_complete)
 			amdgpu_gfx_kfd_sch_ctrl(adev, idx, false);
 	}
-	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
 /**
@@ -2102,12 +2100,10 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 	if (idx >= MAX_XCP)
 		return;
 
-	mutex_lock(&adev->enforce_isolation_mutex);
 	if (adev->enforce_isolation[idx]) {
 		if (adev->kfd.init_complete)
 			amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
 	}
-	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
 /*
-- 
2.34.1

