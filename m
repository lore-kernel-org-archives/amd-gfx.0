Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C6C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 05:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607B110E7DA;
	Wed,  9 Apr 2025 05:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RC7xqfuQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93D910E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 05:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySpoR6pdwbR/9mutu5eU4Vdp53gWOGTGlMkEqgqiMIGOPvzhmIRR9t6nQQVQtMVqCRGV+VhNIhE4l3INPAthI+VHRYqzD+Y0vfvJ+hobnQWbKQQRstECc4B2uYOUc6F3WlWrQkXDh4dWzyOjZqIlnFU6oeYqU0/YD9M1c+nxqYpcrLD+uL8BMxJfiZJdksFsvjSTGUPy70IKxKmxQF91aFJdr8KZ8Im2T16uTFIAgNWj8Dc38zFcNMEKovbFUWnQS4dSm2neRI4+hdyIWpFzg+jfgZsaSZGFVIqajHUcbCqBU68X0+J7gemG6ej483N2gWhkliQRH9I+4wYiRqCgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9oIkLaqerOTGyrbyv/cqEaMRaGXVqFIMuMC88mMuTE=;
 b=Vd8Qt7urHL9EhGZIbP03zPnpNJXf3FZa4mszLLmY2I2xAP6CUbwt82Qedovgm3mupBSXDxDAcdZyvLA6AFpDgZP72YkfGNFuzYrhWFHWvQAIKsabv1Xokl8SXdvqPCUL6LL2CrZl1j5Le+q7oARS+9+IwqAG7y80K572A9RXbScnqcpZCSIVqfSVaKR4mlmKV4CIfTxC7jEYS48NlTtW7p5PulmnHeWJ6Fere7quuJF+Cd5hN/kfi9qoH9X+49RnztdPwjdfcclP674GW0WKCSh+hbq6nSQoZDs/Xme3PXNIWN67oQ2Xv2AWRX/1fE81jR5Qs//aZSJhTv3ztOpQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9oIkLaqerOTGyrbyv/cqEaMRaGXVqFIMuMC88mMuTE=;
 b=RC7xqfuQP2dBFfxmTSE1qTv9APm1RWG9gGFyaKJu/JVh5nW585h77QTDkqoqJHJN0jtF1T1J9GCxlEwaTFY0vjX8KU1EAdmygZ9oIVcFfmn8ZRPAQOfAtPK3CjLjC4wiEmts7IQgUqEMRB8/0Gbqos+i3MFbncxuaxxZ3Bhxi2U=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 05:49:21 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::ea) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 05:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 05:49:21 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Apr 2025 00:49:19 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Acquire BO locks only during BO processing
Date: Wed, 9 Apr 2025 11:18:30 +0530
Message-ID: <20250409054831.2411-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9b15ba-8ed1-4dc7-16f8-08dd772a46a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iL/cCp+dzbdCzDyz0pCF+7k1r6Xt6sZucUcThAvjj574Rclv+71xUI3k5XZ+?=
 =?us-ascii?Q?GJzlTkA1wI+Zrpx9xT0Hut02XznJw+xWsY/g+2WfZ8ovAj3iWtSzUEdarfOu?=
 =?us-ascii?Q?M+OC+3XSO0MgECN2LkHNxU26vzMUlJLudrxSYofz1lGLwDbBIQkabDCmoRZK?=
 =?us-ascii?Q?7p3SB/VZWWR6UfeuRFEiIxJZi0jbSfGnQBHeAxNNP/5WEad8rWTEXFZ2lDm+?=
 =?us-ascii?Q?9tB+D12Rj0nHfqRMUKYRuXYn9vBHWyrWjtV4KPGR1hE49sfGIVzzk56jPBix?=
 =?us-ascii?Q?Gnl3PTuaqKUbjDwknFMu9Zk+V3aWQzvAK7VUTIfkvjQUlG4K/zDTMEiXdDaZ?=
 =?us-ascii?Q?8vhc7trmbQ3g/Q+6ZmEF49LGXEpBnAN2guN/Wzl61XrYlj64oOmzCy8zpm5z?=
 =?us-ascii?Q?Lm7HU4D3+WRC94Py/tutTkY2/b79sUg9kz6bXECaqZqCQpXAkUBCywKTFtrd?=
 =?us-ascii?Q?ADdNJKvFusKwIXhZ1JrnFH1RiIoeVQl6GABDI52Cdi5XcqtzNv7C1ImiIG66?=
 =?us-ascii?Q?AfBW6zV2iAp6Vb212Jeo6wcWa7j7BxQ1TZBW50MTusQ3K+wf/8M49SnJ7Qse?=
 =?us-ascii?Q?nfFIBe33p826L3Z26AicuhzoutbKTfoLCUN7Phf5a+iSSpmtbLGjF7wszhj4?=
 =?us-ascii?Q?jVnXtKTnZtlx2SfFOIYZ0FSyjWyvu2Yf7UNL+DT+wU9ENbBl9yIfbfYP9Wr2?=
 =?us-ascii?Q?BVy9NRk305cooa2JqF3Nmutng3h6FsQJvWUIP4u1sj4Du6jUX/jOub71AzXK?=
 =?us-ascii?Q?E40d0qO5QqJt94DGFIqcRTfYf3qeTSnIUXidvkZ0IJM+LrIlZsZtb30Z9VRc?=
 =?us-ascii?Q?mw5xBVnKwZSkIq+5W6jWNPZKoxIgWy2ExVnAhpHwb+EGZZWMUfP+9Oxzd9ko?=
 =?us-ascii?Q?njMgnGuE8Gijygl/ynGy6qATV1eszmxtsHnYEUpJIT4kzzNkEx3pEB6i0nle?=
 =?us-ascii?Q?8j+WUynJ2Q9EBYG7JJ8k774OiRAQMqHrgVsftLGMary/eX4gkBYedZMq/oXl?=
 =?us-ascii?Q?dhqApEdaRZAOoRMBglrlSE+hZpi6z0AUwRyZ3Nqwirh8LpH7xaIq8eQ8GiGT?=
 =?us-ascii?Q?RSwR5/LXUPOT3arLBejiGHgOpwltOiVlMXKyuMh+cvaV78pkmd6U2HNH3OvS?=
 =?us-ascii?Q?VPantGYGOHW9JRzjgpwedZ+Yulqo9CeVKBEyHBHfWSd446zLe5EU2qinGt+0?=
 =?us-ascii?Q?1nQJbx11xueI2DlgFn9XlyZUNGB1O2vacgG5rkAmY75OnVRzIF87xaihOxIO?=
 =?us-ascii?Q?EsLDmQE0mjez7BJx6X1RSRtmBFyI/hopfs5GW4M6x/T6gQd9lrz9fjRgdjIs?=
 =?us-ascii?Q?orVyTp2p/nJ6ERZ8qt3TMUlnT+E/R/ZJypPi1ib9QpYmzlIVIowhRCwsUy3p?=
 =?us-ascii?Q?sZJPu8Y641ATXbsxRks1T6QrMNSUe1QsscfUq3y/79Ad0Q3e2iKD2+eKrsk/?=
 =?us-ascii?Q?nopSlYwG1j8rkMLnl3Be8iO9+7+DJCuF58m1ZukqfecNPHZWSj4RcRinPHIt?=
 =?us-ascii?Q?au6Mlt9zW1Cb8AQJ+z3JBxK4Gos0zd7KrcTN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:49:21.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9b15ba-8ed1-4dc7-16f8-08dd772a46a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495
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

Fix lockdep warnings.

[  +0.000024] WARNING: CPU: 10 PID: 1909 at drivers/gpu/drm/drm_syncobj.c:456 drm_syncobj_find_fence+0x58c/0x6e0
[  +0.000519] CPU: 10 UID: 1000 PID: 1909 Comm: gnome-shel:cs0 Tainted: G        W  OE      6.12.0+ #18
[  +0.000008] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
[  +0.000004] RIP: 0010:drm_syncobj_find_fence+0x58c/0x6e0
[  +0.000006] RSP: 0018:ffff88846d9ef680 EFLAGS: 00010202
[  +0.000008] RAX: 0000000000000000 RBX: 0000000000001388 RCX: 0000000000000001
[  +0.000004] RDX: 1ffff1108f5ad1da RSI: 0000000000000001 RDI: ffff88847ad68ed0
[  +0.000005] RBP: ffff88846d9ef770 R08: 0000000000000000 R09: 0000000000000000
[  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88847ad68000
[  +0.000004] R13: 0000000000000002 R14: ffff888149353d00 R15: 000000000000000f
[  +0.000005] FS:  00007269977fe6c0(0000) GS:ffff888409500000(0000) knlGS:0000000000000000
[  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000004] CR2: 0000643a866b50d0 CR3: 0000000469eb2000 CR4: 0000000000f50ef0
[  +0.000005] PKRU: 55555554
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000005]  ? show_regs+0x6c/0x80
[  +0.000010]  ? __warn+0xd2/0x2d0
[  +0.000008]  ? drm_syncobj_find_fence+0x58c/0x6e0
[  +0.000009]  ? report_bug+0x282/0x2f0
[  +0.000014]  ? handle_bug+0x6e/0xc0
[  +0.000008]  ? exc_invalid_op+0x18/0x50
[  +0.000007]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000020]  ? drm_syncobj_find_fence+0x58c/0x6e0
[  +0.000012]  ? __pfx_drm_syncobj_find_fence+0x10/0x10
[  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? lock_is_held_type+0xa3/0x130
[  +0.000016]  amdgpu_userq_wait_ioctl+0x92d/0x2200 [amdgpu]
[  +0.000257]  ? amdgpu_userq_wait_ioctl+0x92d/0x2200 [amdgpu]
[  +0.000180]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? __lock_acquire+0x1b19/0x69c0
[  +0.000022]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000179]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? __kasan_check_read+0x11/0x20
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? mark_lock+0xfd/0x17c0
[  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? lock_acquire.part.0+0x116/0x360
[  +0.000006]  ? drm_dev_enter+0x51/0x190
[  +0.000008]  ? __pfx___lock_acquire+0x10/0x10
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? find_held_lock+0x36/0x140
[  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? lock_acquire+0x7c/0xc0
[  +0.000005]  ? drm_dev_enter+0x51/0x190
[  +0.000027]  drm_ioctl_kernel+0x18b/0x330
[  +0.000008]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000181]  ? __pfx_drm_ioctl_kernel+0x10/0x10
[  +0.000005]  ? lock_acquire+0x7c/0xc0
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? __kasan_check_write+0x14/0x30
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000010]  drm_ioctl+0x589/0xd00
[  +0.000006]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000187]  ? __pfx_drm_ioctl+0x10/0x10
[  +0.000007]  ? __pm_runtime_resume+0x80/0x110
[  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? trace_hardirqs_on+0x53/0x60
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
[  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
[  +0.000182]  __x64_sys_ioctl+0x13a/0x1c0
[  +0.000012]  x64_sys_call+0x11ad/0x25f0
[  +0.000007]  do_syscall_64+0x91/0x180
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000009]  ? __pfx___do_sys_prctl+0x10/0x10
[  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? irqentry_exit_to_user_mode+0x8b/0x260
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? irqentry_exit+0x77/0xb0
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? exc_page_fault+0x93/0x150
[  +0.000009]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000005] RIP: 0033:0x7269b0324ded
[  +0.000006] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[  +0.000005] RSP: 002b:00007269977fc9b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000008] RAX: ffffffffffffffda RBX: 00007269977fcb00 RCX: 00007269b0324ded
[  +0.000004] RDX: 00007269977fcb00 RSI: 00000000c0406458 RDI: 000000000000000d
[  +0.000004] RBP: 00007269977fca00 R08: 00007269977fcc1c R09: 0000000000000000
[  +0.000005] R10: 000000000000000f R11: 0000000000000246 R12: 000000000000000d
[  +0.000004] R13: 00005bce7c309a50 R14: 00007269977fca30 R15: 0000000000000000
[  +0.000021]  </TASK>
[  +0.000005] irq event stamp: 1359
[  +0.000004] hardirqs last  enabled at (1365): [<ffffffffaa8693a9>] __up_console_sem+0x79/0xa0
[  +0.000007] hardirqs last disabled at (1370): [<ffffffffaa86938e>] __up_console_sem+0x5e/0xa0
[  +0.000005] softirqs last  enabled at (756): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000006] softirqs last disabled at (749): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000005] ---[ end trace 0000000000000000 ]---

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 116 +++++++++++-------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index d5b35b5df527..c5de39a8ff98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -395,6 +395,43 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static int amdgpu_userq_exec_lock(struct drm_exec *exec, u32 flags,
+				  struct drm_gem_object **rgobj,
+				  struct drm_gem_object **wgobj,
+				  u32 num_read_handles,
+				  u32 num_write_handles,
+				  unsigned int num_fences)
+{
+	int r;
+
+	if (!exec | !rgobj | !wgobj)
+		return -EINVAL;
+
+	drm_exec_init(exec, flags,
+		      (num_read_handles + num_write_handles));
+
+	/* Lock all BOs with retry handling */
+	drm_exec_until_all_locked(exec) {
+		r = drm_exec_prepare_array(exec, rgobj, num_read_handles, num_fences);
+		drm_exec_retry_on_contention(exec);
+		if (r)
+			drm_exec_fini(exec);
+
+		r = drm_exec_prepare_array(exec, wgobj, num_write_handles, num_fences);
+		drm_exec_retry_on_contention(exec);
+		if (r)
+			drm_exec_fini(exec);
+	}
+
+	return r;
+}
+
+static void amdgpu_userq_exec_unlock(struct drm_exec *exec)
+{
+	if (exec)
+		drm_exec_fini(exec);
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
@@ -511,24 +548,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	queue->last_fence = dma_fence_get(fence);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			amdgpu_userq_fence_cleanup(fence);
-			goto exec_fini;
-		}
-
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			amdgpu_userq_fence_cleanup(fence);
-			goto exec_fini;
-		}
+	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+				   gobj_read, gobj_write,
+				   num_read_bo_handles,
+				   num_write_bo_handles,
+				   1);
+	if (r) {
+		amdgpu_userq_fence_cleanup(fence);
+		goto put_gobj_write;
 	}
 
 	for (i = 0; i < num_read_bo_handles; i++) {
@@ -546,6 +573,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		dma_resv_add_fence(gobj_write[i]->resv, fence,
 				   DMA_RESV_USAGE_WRITE);
 	}
+	amdgpu_userq_exec_unlock(&exec);
 
 	/* Add the created fence to syncobj/BO's */
 	for (i = 0; i < num_syncobj_handles; i++)
@@ -554,8 +582,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
 
-exec_fini:
-	drm_exec_fini(&exec);
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
@@ -666,26 +692,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
-
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
-	}
-
 	if (!wait_info->num_fences) {
 		if (num_points) {
 			struct dma_fence_unwrap iter;
@@ -698,7 +704,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
 							   &fence);
 				if (r)
-					goto exec_fini;
+					goto put_gobj_write;
 
 				dma_fence_unwrap_for_each(f, &iter, fence)
 					num_fences++;
@@ -716,12 +722,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
 						   &fence);
 			if (r)
-				goto exec_fini;
+				goto put_gobj_write;
 
 			num_fences++;
 			dma_fence_put(fence);
 		}
 
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_read, gobj_write,
+					   num_read_bo_handles,
+					   num_write_bo_handles,
+					   1);
+		if (r)
+			goto put_gobj_write;
+
 		/* Count GEM objects fence */
 		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
@@ -740,7 +754,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_WRITE, fence)
 				num_fences++;
 		}
-
+		amdgpu_userq_exec_unlock(&exec);
 		/*
 		 * Passing num_fences = 0 means that userspace doesn't want to
 		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
@@ -753,7 +767,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
 		if (!fence_info) {
 			r = -ENOMEM;
-			goto exec_fini;
+			goto put_gobj_write;
 		}
 
 		/* Array of fences */
@@ -763,6 +777,14 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			goto free_fence_info;
 		}
 
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_read, gobj_write,
+					   num_read_bo_handles,
+					   num_write_bo_handles,
+					   1);
+		if (r)
+			goto free_fences;
+
 		/* Retrieve GEM read objects fence */
 		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
@@ -772,6 +794,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_READ, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
+					amdgpu_userq_exec_unlock(&exec);
 					goto free_fences;
 				}
 
@@ -789,6 +812,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_WRITE, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
+					amdgpu_userq_exec_unlock(&exec);
 					goto free_fences;
 				}
 
@@ -796,6 +820,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_get(fence);
 			}
 		}
+		amdgpu_userq_exec_unlock(&exec);
 
 		if (num_points) {
 			struct dma_fence_unwrap iter;
@@ -901,7 +926,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		kfree(fence_info);
 	}
 
-	drm_exec_fini(&exec);
 	for (i = 0; i < num_read_bo_handles; i++)
 		drm_gem_object_put(gobj_read[i]);
 	kfree(gobj_read);
@@ -924,8 +948,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(fences);
 free_fence_info:
 	kfree(fence_info);
-exec_fini:
-	drm_exec_fini(&exec);
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
-- 
2.43.0

