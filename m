Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028DEC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934AA10EC07;
	Fri, 14 Feb 2025 08:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLLU2VAJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7440110EC07
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk1wLyQZji2XTHw7o59JYb8h+cPXEbCZmHIhzSziBPKZ5AzOA6tR6a0gBqBrP4SpHcsR/yklKFxBBRSMfD74yz+KgFr/V96R6WsSgIoPi4iwbXYrBa4DsCYYIn4I6A5ebn0zBlfarI7kbBCT4uY5FG2QgIAfdydRjloIiyWnLqukxwj8m1FN8Gm98jOM9imRu3nkNeBwGA+rfOMKQ8xmnIk1lwosT89okG2F1o5+A4zu+9ZkfJ1BSd4Mc2zBNP89B43s+vdxlXLbsmLAQi3l/vkeULmUg94xsGzvBZHNt418somhsU4uhmgvb2wiyhxfJi9zuss11+qjSEMbznqgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5Vcnx8QPeUc5t/4bOA2g6Sr5wwNuO+R5EZzorIpG3A=;
 b=ewbRsEB66MSM9NwmC1bCqIEjQi5/uCj2lUTpr5H0/nFSQfCuiLMT7p3x+ujT2dcF9ttmc1Rv7QFa4VIAYDdcgZfkZcWPNGN6NIdP4l777/g8nO59ZMW4o6ZC0CBK+qHLaFPX5G6KTKQUFGa215h3NcB/21sxG+mh4M+NuPOUI6Q34bumYDsTd+y+D9U8pXEWPzeUBKzn6jeuzwwisoOTl016LB66PT/eWHtEod+lt3M888G54s0BS6Gs3o4QjSQXcbQUKX/dKVV1dmWa5vzfwO2ay2z02JlInWcFgX+sBdM0hCWT+VEjTwwKlE0b98jLeAkeL8RgpkHxvmnIOzt9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5Vcnx8QPeUc5t/4bOA2g6Sr5wwNuO+R5EZzorIpG3A=;
 b=vLLU2VAJugsKko7Nto6gL/14LONy0NlyXjzZKfnQWNb44V0eZ2mD1MIq1QHQU2AbaYUKVTGBLmUXre8u4ibbgDMN1n9cpM0bBev5YaorlWg4fUBcPQj3+N58tFHAJganBV0L7UxpqXKrl8KSU0l3hPqgRw1QhKgNnU3vgWrrFH8=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 08:58:11 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::67) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 08:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 08:58:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Feb 2025 02:58:08 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, lin cao <lin.cao@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>,
 "Zhigang Luo" <zhigang.luo@amd.com>
Subject: [PATCH] drm/amdgpu: Replace Mutex with Spinlock for RLCG register
 access to avoid Priority Inversion in SRIOV
Date: Fri, 14 Feb 2025 14:27:55 +0530
Message-ID: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 207a0fa8-ff1d-4f6b-f845-08dd4cd5b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGFmL2VoQWZMTWQ1TU9aR1ZNcUNMY2JGTFBheG5URTkrdVpJaVh3YlBHbVVL?=
 =?utf-8?B?dk5nWkdGZnRiU3dLWXZ3Y2RzODN2bm9NdVdiUFNXTXpCWVBvekpZMW9hNm81?=
 =?utf-8?B?VkphbTVyNkZXWldjWkxGV1NLdmdiakl3enNTa1JtbkN5K3ZXOTVSUENMazZu?=
 =?utf-8?B?WTNHVXhYQXhvbWJJN3J1SDRjOVY2OUlUcGk0L3BlbDFUSWE3QmxkL3gya3Yz?=
 =?utf-8?B?MXhKNk05RzI3Z3NXTmdMKytSeW1HR0pGUkp0aXBwWHhuY0pwRWxWUXZGSVZE?=
 =?utf-8?B?bDZRRkRnV3BITEhHZGZtYjZ5c3g2MlJxQWxvUXcrWm9iak92Mmxvd2d3YVdr?=
 =?utf-8?B?ek9qdU5SQVB5cVRnd0x0Z1M1S0U0cHpDd25lcWRoUUJ5Tk1wVllieVJuOVFt?=
 =?utf-8?B?a09kcGVsakp6N0RPbXdIOFhFNGVQdWxqR1E1Y3lFdU9TcnVlekdOTDVSWEs5?=
 =?utf-8?B?ekZnbERrMjN0V0RzT0dBOGMvbXR3SWhRVFQ1em03cXVicC9uMjVVTU1uRUdM?=
 =?utf-8?B?aFFFdisxUDJGZTdNdWN1aHlaQmNSbzhSYUJPSUhvcjBqWkd2Y3BmTzJudE1O?=
 =?utf-8?B?SHFCR1FGSDR4Y01VdEZjV0dnMndSZjZPdFZqSFVrSzlKTjJBaUNKY1FFbTAw?=
 =?utf-8?B?RUkzenZHR1F6djl3c3hWZWxYQm91OGdxMGlJRnl6VWo4Q0Q5a0tsQ0xSK2hP?=
 =?utf-8?B?SlcwVVcxRmxOeEl1WHM4a0V4dzdpck4xaXhsdC9PNHpEMXFsUkhMMisvNkNG?=
 =?utf-8?B?SHFYZVJtT0FwR3JxZ3IrTUNNZXMwRzhJUlBuR0xXTjZGYm4ydlMyclBRbU1V?=
 =?utf-8?B?VkNrcVFGWm5KODdxTE5TSnJWQlNZTEpmd0ZQVlVNcmVCSCthTmRlUTJrN0lo?=
 =?utf-8?B?ZUJIelZRRXRhVjNlbEtzdzRnR0lRMGg0Z0d4RTFtVmZncnlGMDJ0Y2sydXFC?=
 =?utf-8?B?czJhQnFPTk45V1JGVS9lZWU4M0gwZ2owWnJEb3ZPRDJZWUhQQm1BSUJQYTZ6?=
 =?utf-8?B?SVVVM2dYNVJsV1lCV1hwU25ZWVdYb3ppZldhZVVwSUVoRUh4dXhWOE4zbVM4?=
 =?utf-8?B?dXdFd08rYkNhZElxa0ZqU3ZPaXBmVllIRjlhU1FvK2JCUHhoRnFLVHFKZGF6?=
 =?utf-8?B?RDdwaThZeHNoT3YrNUZLNEVuRmRoam1zVkJMMUdkVmo1OG9WM0V0SEY0Rks2?=
 =?utf-8?B?OHFMZFFsRGxEalY3cWlvNUlMdmVKT1B2WXFtVExhUXV1a3N4bEQyY0pRbW83?=
 =?utf-8?B?cUhDTncvbVNUeHgvcWxLQUpndVl6R1FmdisrWDN4cVUvV2J2THYxQXArSFUy?=
 =?utf-8?B?WjFOTjlaNnhYV1YzVnoveDdsb3UzTmFyNjV6eFpZSVp6YTRKSGIzN2YrTkhI?=
 =?utf-8?B?cEtydnhpOWpYVVYrSGpsUHorakc5UHVTVkNHNTBaaFFURzVqdElHNVd4MElI?=
 =?utf-8?B?bzlzeUM0K3Z5SnRHNjVqcmJ3V2VtYnJFNi9rVGozSURVZ0ZvQWRXWXV3QTJp?=
 =?utf-8?B?NE8xM2lFSXNWOTdkSnZvMlMxTkV2cmhXWFNMd0o2eHRhalJia3ZldGFnb2Zn?=
 =?utf-8?B?RDhBWHJyZzEyT1A5My95RGh0SGx4UExGTEZVWmlJQVVYOTlJQkVLaURkL0V2?=
 =?utf-8?B?TVYrQ1ZmUFAveDgrUUpZcnIxOWxhVHozL1JXbE5jc1pEZEVkcGFIZ25PUWp5?=
 =?utf-8?B?bTF0ckVCVzhaQ0lEZTJlenhTaVMrc2hrTTErMXYyeTFPQlVvcWNnc01NU0lu?=
 =?utf-8?B?UHhoTktyOURMaEhsd0FQT3RPMUxZUkovZFVZQzFHYkRwTTZKTXFlYjgvNmJH?=
 =?utf-8?B?T1VIV0ZIN2xocVhiTHZBTXlYdjBWVkZGbklYK1R0NWNBRCs2UG0zTEZPZ1NB?=
 =?utf-8?B?QjNzR1BWci9FakhxYWpXSWYybDNxR1QvMkt2d2E0MzdkVnNCcHJPckh4M1M3?=
 =?utf-8?B?a2dlSzcrb2lEdUxHQTR4dWpvd1BGc3JGc3JXNE9yQlNXMzB3MGhzR1AwTFc2?=
 =?utf-8?Q?rmSaWSEnI6R9Fhps3mTtlgZ9xa/Bnw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:58:11.4607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207a0fa8-ff1d-4f6b-f845-08dd4cd5b5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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

RLCG Register Access is a way for virtual functions to safely access GPU
registers in a virtualized environment., including TLB flushes and
register reads. When multiple threads or VFs try to access the same
registers simultaneously, it can lead to race conditions. By using the
RLCG interface, the driver can serialize access to the registers. This
means that only one thread can access the registers at a time,
preventing conflicts and ensuring that operations are performed
correctly. Additionally, when a low-priority task holds a mutex that a
high-priority task needs, ie., If a thread holding a spinlock tries to
acquire a mutex, it can lead to priority inversion. register access in
amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.

The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
called, which attempts to acquire the mutex. This function is invoked
from amdgpu_sriov_wreg, which in turn is called from
gmc_v11_0_flush_gpu_tlb.

The warning [ BUG: Invalid wait context ] indicates that a thread is
trying to acquire a mutex while it is in a context that does not allow
it to sleep (like holding a spinlock).

Fixes the below:

[  253.013423] =============================
[  253.013434] [ BUG: Invalid wait context ]
[  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  253.013464] -----------------------------
[  253.013475] kworker/0:1/10 is trying to lock:
[  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.013815] other info that might help us debug this:
[  253.013827] context-{4:4}
[  253.013835] 3 locks held by kworker/0:1/10:
[  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
[  253.014154] stack backtrace:
[  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
[  253.014224] Workqueue: events work_for_cpu_fn
[  253.014241] Call Trace:
[  253.014250]  <TASK>
[  253.014260]  dump_stack_lvl+0x9b/0xf0
[  253.014275]  dump_stack+0x10/0x20
[  253.014287]  __lock_acquire+0xa47/0x2810
[  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014321]  lock_acquire+0xd1/0x300
[  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014562]  ? __lock_acquire+0xa6b/0x2810
[  253.014578]  __mutex_lock+0x85/0xe20
[  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014782]  ? sched_clock_noinstr+0x9/0x10
[  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014808]  ? local_clock_noinstr+0xe/0xc0
[  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.015029]  mutex_lock_nested+0x1b/0x30
[  253.015044]  ? mutex_lock_nested+0x1b/0x30
[  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
[  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
[  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
[  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
[  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
[  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
[  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
[  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
[  253.017493]  local_pci_probe+0x4b/0xb0
[  253.017746]  work_for_cpu_fn+0x1a/0x30
[  253.017995]  process_one_work+0x21e/0x680
[  253.018248]  worker_thread+0x190/0x330
[  253.018500]  ? __pfx_worker_thread+0x10/0x10
[  253.018746]  kthread+0xe7/0x120
[  253.018988]  ? __pfx_kthread+0x10/0x10
[  253.019231]  ret_from_fork+0x3c/0x60
[  253.019468]  ? __pfx_kthread+0x10/0x10
[  253.019701]  ret_from_fork_asm+0x1a/0x30
[  253.019939]  </TASK>

Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: Zhigang Luo <zhigang.luo@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eab530778fbd..14125cc3a937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
-	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
+	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
 
 	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2056efaf157d..073fc34e43eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1038,7 +1038,11 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
 
-	mutex_lock(&adev->virt.rlcg_reg_lock);
+	/* Try to acquire the lock without blocking */
+	if (!spin_trylock(&adev->virt.rlcg_reg_lock)) {
+		dev_err(adev->dev, "Failed to acquire rlcg_reg_lock, aborting register access!\n");
+		return 0;
+	}
 
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
@@ -1097,7 +1101,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 	ret = readl(scratch_reg0);
 
-	mutex_unlock(&adev->virt.rlcg_reg_lock);
+	/* Unlock the spinlock after the critical section is complete */
+	spin_unlock(&adev->virt.rlcg_reg_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 270a032e2d70..0f3ccae5c1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -279,7 +279,8 @@ struct amdgpu_virt {
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
 
-	struct mutex rlcg_reg_lock;
+	/* Spinlock to protect access to the RLCG register interface */
+	spinlock_t rlcg_reg_lock;
 
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
-- 
2.34.1

