Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6BEC369A5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 05:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA0410E2F5;
	Wed,  9 Apr 2025 05:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnIMRqkM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AFA10E2F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 05:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJuO5F3DBiaDA6GrZ8Rh5/Yp90/iFnRYb/GJF188c/dkhhJ1FNXNyq7lT39Vb18Sg9HRsNLc0gtbiYCFEJsv94dM0nSFMcHZ06y5u6JeroGgdq+wGvei43kU7mnTZkc3uYyJgEmt+gPp2WUFDzhHYbpK6dYF43RmD+KqlxR1pyfywdeLL9jiJsXmUYBqOevP1PFiKVzcXYbNClFfdP8P5RwYavBIJrseL3kkumzdJ1CvLYLxmFpA2zx9aVU68bapgH+pLBoPQ8wR9lpt3XvheVA4fj4oid1QiEdOho0tI/6JC3Yj1vcrOc0ZPyLaK8+r98hkBlCUprMIPTlkEnQtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3Bc2RFgKcqmmP742CdHmRU36YyUEGduXj4TcK/2R0I=;
 b=G3o5SnsqdIflWXp3tlKn052xByF6poJBfH1N/+YU0l+z0P83OSacK8yYU9h4jD9j8qZMQzbpOv3QBv++yrqSozu9EPlcsX1zdfa9nFR3rhlDJ9cIQ/ZxsSI7vRQChvzGGCne17RVFnzBfP5Y4i7K3SrY8lEb1lsTmhgEjcEUngixmv3fNuMw+Blk5wtBVhRTQmvZhoenYox4oqJqUyf36HZt7rK9QNwTvMerbvmpL3RpCvdGA0+r4d99uL+3A88/P2JUDfs6IH1cr7W6VKwBXpRyNx5ySC38nzx+ar6bWvXjfUD+OeO3LkJn3VSnkysQGIPp9mg5uKPctIqow4XobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3Bc2RFgKcqmmP742CdHmRU36YyUEGduXj4TcK/2R0I=;
 b=wnIMRqkMoei6WRKD9hBsZdgYYIgMiD6wNx3yioGc1wQUzTuxLz0T7PeWQF8z7C9uRTt+UOQFQHauPCvoPs4pOyzx801IdyNDRaaGow2yjcDNal1V/fLesMxj4fBcYOcvzOFmRunF4oxuL2Sd9M8b9J31EDdkzpXkntsi1DSRguw=
Received: from MW4PR04CA0291.namprd04.prod.outlook.com (2603:10b6:303:89::26)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 05:49:19 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::f1) by MW4PR04CA0291.outlook.office365.com
 (2603:10b6:303:89::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 05:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 05:49:17 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Apr 2025 00:49:15 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Fix userq ttm_bo_pin and ttm_bo_unpin lockdep
 warnings
Date: Wed, 9 Apr 2025 11:18:28 +0530
Message-ID: <20250409054831.2411-3-Arunpravin.PaneerSelvam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5400a8-8581-45d2-a76d-08dd772a44a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2t53EvoFFKQ9nnr2Thn15gCKfL0PsCYsGANFtq3zAtZT3qXtJK0SRkJFYcF?=
 =?us-ascii?Q?9mDCT7ycaipet5GilkBRvW23YSMjoISUnjlrJaOOwDIRCZ4e33ikV7lyxTV/?=
 =?us-ascii?Q?3rVndPG/qjgtfG4XvBGnJ+SMo/2rMbgwMtudS0/UHxEowARIWc+eQunlKbsQ?=
 =?us-ascii?Q?p757QGfSOPhTzBet5p7/sKlBjOdLNEc9M3x0nyp0ABjs7jDO1jlbamyxsu2M?=
 =?us-ascii?Q?i+NpGhL+Ax8N6+GRDWDJbHycgALl6Dnne7OYdEj53OljJb2HrFKhis9kSlXv?=
 =?us-ascii?Q?9kTvDnIikWS5emFlGZ6GplQdVqFYgUdM8S1c/KVEJ1FTlILLWJmATDLXydgU?=
 =?us-ascii?Q?KcbUedwF2WSVvVdktQAPnIV13jYxN1YWUk07F2WokPslX9sHi14R3S4xQl5/?=
 =?us-ascii?Q?fsK8lJ4f5QvGCs1GY1Ji3EpRLG4LdhxW1R4qYNvCL1NAw6hgJplBFOQkYmSA?=
 =?us-ascii?Q?nMrdqNzEY2hYvl9+VTmJBbphb7FZt2Tx52zFdOC/s8fY/sy5fbJS9G76GKkE?=
 =?us-ascii?Q?jLNtl1Yj4efDwOayVPqDNghpZwPG69FziZjH8z923RcRDgN9GWiwC+75LykM?=
 =?us-ascii?Q?geTyA3kQVPUd83yrL1IGSDDoiLMHtHs7qN5yYyUrQXyveOO53RuK/7gJN0Pn?=
 =?us-ascii?Q?YjCgqL19c1oWL4zrDfC1H2d7UdQNxSCfuoMduGLjtFZzDFaIGFliiUOaLyKO?=
 =?us-ascii?Q?lFEmzAw+V3gtDeC9D24WpSdJ2WyCJ0Exr9CrchcFwftwbfTUGQMtWoxsc6v4?=
 =?us-ascii?Q?qyohcoPYgCW7JxsO36nMxIVdwZv5qMY0zwYVpfkg7GyAolH2s1j0V/dK0Seg?=
 =?us-ascii?Q?1X6M8z5B0pRsAnVSS3YNVvcEwwpt90EhG2hwj2vHyEPL59fM95QYjKwhvg+6?=
 =?us-ascii?Q?J4jDD1BMGv3L+bu3LPyYbgs4uX4UOeUuYibbWr2HhwUvm03ImQr62q+Q7SWu?=
 =?us-ascii?Q?kKTqY1TeGgs4p5DDBIzfCapDQ3PsVhMTzptBsZ7Ie8q0NPuNIIfLz+0wOV75?=
 =?us-ascii?Q?WRkxjHy4VlpeJaT80ABf1X4YkxGbYIfLnxv8EsyxkBgANY9LXikKFazAouuA?=
 =?us-ascii?Q?ly03xRMuym5GErF8LsZU3AKJ+7M06A6qDegFV//oCOVV1kufjbM15PdxTMYT?=
 =?us-ascii?Q?SAvFLLEurG4cFqJIciaBsK2aqDISS/fal5UUTxJg7kTcV8W+HTR9NDwpPGq3?=
 =?us-ascii?Q?uRbx+Md81jVcZp660QonlDPVo2x47F2ux9GXFbPxm0lZAadx6P8O6YsRVPka?=
 =?us-ascii?Q?K7nV1loKqe+Zst34G48EFFd3xNLzllZdPd6wqQMX29r9k7I6VOnCGwxQNXxQ?=
 =?us-ascii?Q?QE9JaEAvJ7/3sYM54rUKsAu+aVrDXOwaHeMq96zrnKAj97YMUkNCLX0GuG9f?=
 =?us-ascii?Q?+k+MZ1vsNvi9f8DakMBhzH4zd/oypbuRClIByusGAqo3ljyO6s2AfkdKPcge?=
 =?us-ascii?Q?l72bm/m/2K330RfSi3HSArkTDSgwQ3ZtLOYj4twuN8TRo/1kJHwRK6ufEYuZ?=
 =?us-ascii?Q?UCoM6tf3gu1+lJM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:49:17.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5400a8-8581-45d2-a76d-08dd772a44a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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

The ttm_bo_pin and ttm_bo_unpin warnings are resolved by moving the
doorbell bo reserve up before pin/unpin.

WARNING: CPU: 11 PID: 1818 at drivers/gpu/drm/ttm/ttm_bo.c:592 ttm_bo_pin+0x1f6/0x270 [ttm]
[  +0.000277] CPU: 11 UID: 1000 PID: 1818 Comm: Xwayland Tainted: G        W          6.12.0+ #15
[  +0.000006] Tainted: [W]=WARN
[  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
[  +0.000004] RIP: 0010:ttm_bo_pin+0x1f6/0x270 [ttm]
[  +0.000005] RSP: 0018:ffff88846ca879d0 EFLAGS: 00010246
[  +0.000007] RAX: 0000000000000000 RBX: ffff88810b7ca848 RCX: 0000000000000000
[  +0.000004] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  +0.000005] RBP: ffff88846ca879e8 R08: 0000000000000000 R09: 0000000000000000
[  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810b7ca848
[  +0.000004] R13: ffff88846c666250 R14: 1ffff1108d950f44 R15: ffff88846ca87aa0
[  +0.000005] FS:  00007c45ff436d00(0000) GS:ffff888409580000(0000) knlGS:0000000000000000
[  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000005] CR2: 00005b0c142a60e0 CR3: 000000012ce5a000 CR4: 0000000000f50ef0
[  +0.000004] PKRU: 55555554
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000005]  ? show_regs+0x6c/0x80
[  +0.000007]  ? __warn+0xd2/0x2d0
[  +0.000007]  ? ttm_bo_pin+0x1f6/0x270 [ttm]
[  +0.000031]  ? report_bug+0x282/0x2f0
[  +0.000012]  ? handle_bug+0x6e/0xc0
[  +0.000007]  ? exc_invalid_op+0x18/0x50
[  +0.000007]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000017]  ? ttm_bo_pin+0x1f6/0x270 [ttm]
[  +0.000014]  amdgpu_bo_pin+0x365/0x9d0 [amdgpu]
[  +0.000191]  ? __pfx_amdgpu_bo_pin+0x10/0x10 [amdgpu]
[  +0.000185]  ? drm_gem_object_lookup+0x81/0xc0
[  +0.000008]  ? kasan_save_alloc_info+0x37/0x60
[  +0.000007]  ? __kasan_kmalloc+0xc3/0xd0
[  +0.000013]  amdgpu_userqueue_get_doorbell_index+0xee/0x5f0 [amdgpu]
[  +0.000209]  amdgpu_userq_ioctl+0x6b4/0xd40 [amdgpu]
[  +0.000193]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000211]  ? lock_acquire+0x7c/0xc0
[  +0.000006]  ? drm_dev_enter+0x51/0x190
[  +0.000015]  drm_ioctl_kernel+0x18b/0x330
[  +0.000007]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000190]  ? __pfx_drm_ioctl_kernel+0x10/0x10
[  +0.000005]  ? lock_acquire+0x7c/0xc0
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? __kasan_check_write+0x14/0x30
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000011]  drm_ioctl+0x589/0xd00
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000194]  ? __pfx_drm_ioctl+0x10/0x10
[  +0.000006]  ? __pm_runtime_resume+0x80/0x110
[  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? trace_hardirqs_on+0x53/0x60
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
[  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
[  +0.000185]  __x64_sys_ioctl+0x13a/0x1c0
[  +0.000010]  x64_sys_call+0x11ad/0x25f0
[  +0.000007]  do_syscall_64+0x91/0x180
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? irqentry_exit+0x77/0xb0
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? exc_page_fault+0x93/0x150
[  +0.000009]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000005] RIP: 0033:0x7c45ff924ded
[  +0.000005] RSP: 002b:00007ffff7167810 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000008] RAX: ffffffffffffffda RBX: 00000000c0486456 RCX: 00007c45ff924ded
[  +0.000004] RDX: 00007ffff7167870 RSI: 00000000c0486456 RDI: 000000000000000b
[  +0.000004] RBP: 00007ffff7167860 R08: ffff800100000000 R09: 0000000000010000
[  +0.000005] R10: 00007ffff7167950 R11: 0000000000000246 R12: 00005b0c2a51bc48
[  +0.000004] R13: 000000000000000b R14: 0000000000000000 R15: 00007ffff7167950
[  +0.000022]  </TASK>
[  +0.000004] irq event stamp: 80693
[  +0.000004] hardirqs last  enabled at (80699): [<ffffffff86a693a9>] __up_console_sem+0x79/0xa0
[  +0.000005] hardirqs last disabled at (80704): [<ffffffff86a6938e>] __up_console_sem+0x5e/0xa0
[  +0.000005] softirqs last  enabled at (80390): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000005] softirqs last disabled at (80385): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000006] ---[ end trace 0000000000000000 ]---
------------------------------------------------------------------------------------------------------

[  +0.000006] WARNING: CPU: 10 PID: 1818 at drivers/gpu/drm/ttm/ttm_bo.c:611 ttm_bo_unpin+0x21f/0x2c0 [ttm]
[  +0.000280] CPU: 10 UID: 1000 PID: 1818 Comm: Xwayland Tainted: G        W          6.12.0+ #15
[  +0.000006] Tainted: [W]=WARN
[  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
[  +0.000004] RIP: 0010:ttm_bo_unpin+0x21f/0x2c0 [ttm]
[  +0.000005] RSP: 0018:ffff88846ca87888 EFLAGS: 00010246
[  +0.000007] RAX: 0000000000000000 RBX: ffff88810b7ca848 RCX: 0000000000000000
[  +0.000005] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  +0.000004] RBP: ffff88846ca878a0 R08: 0000000000000000 R09: 0000000000000000
[  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888164e90050
[  +0.000005] R13: ffff88846c666200 R14: 0000000000000001 R15: ffff888168402d28
[  +0.000004] FS:  00007c45ff436d00(0000) GS:ffff888409500000(0000) knlGS:0000000000000000
[  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000004] CR2: 00007c45f7373b20 CR3: 000000012ce5a000 CR4: 0000000000f50ef0
[  +0.000005] PKRU: 55555554
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000005]  ? show_regs+0x6c/0x80
[  +0.000008]  ? __warn+0xd2/0x2d0
[  +0.000007]  ? ttm_bo_unpin+0x21f/0x2c0 [ttm]
[  +0.000012]  ? report_bug+0x282/0x2f0
[  +0.000013]  ? handle_bug+0x6e/0xc0
[  +0.000006]  ? exc_invalid_op+0x18/0x50
[  +0.000008]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000017]  ? ttm_bo_unpin+0x21f/0x2c0 [ttm]
[  +0.000011]  ? ttm_bo_unpin+0x217/0x2c0 [ttm]
[  +0.000011]  amdgpu_bo_unpin+0x45/0x250 [amdgpu]
[  +0.000216]  amdgpu_userq_ioctl+0x2c3/0xd40 [amdgpu]
[  +0.000226]  ? drm_dev_exit+0x2d/0x60
[  +0.000010]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000201]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? lock_acquire+0x7c/0xc0
[  +0.000006]  ? drm_dev_enter+0x51/0x190
[  +0.000015]  drm_ioctl_kernel+0x18b/0x330
[  +0.000007]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000188]  ? __pfx_drm_ioctl_kernel+0x10/0x10
[  +0.000006]  ? lock_acquire+0x7c/0xc0
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? __kasan_check_write+0x14/0x30
[  +0.000006]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000010]  drm_ioctl+0x589/0xd00
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
[  +0.000211]  ? __pfx_drm_ioctl+0x10/0x10
[  +0.000006]  ? __pm_runtime_resume+0x80/0x110
[  +0.000020]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? trace_hardirqs_on+0x53/0x60
[  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
[  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
[  +0.000186]  __x64_sys_ioctl+0x13a/0x1c0
[  +0.000010]  x64_sys_call+0x11ad/0x25f0
[  +0.000007]  do_syscall_64+0x91/0x180
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000010]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
[  +0.000005]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
[  +0.000013]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? do_syscall_64+0x9d/0x180
[  +0.000011]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000010]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? irqentry_exit_to_user_mode+0x8b/0x260
[  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000006]  ? irqentry_exit+0x77/0xb0
[  +0.000004]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000005]  ? exc_page_fault+0x93/0x150
[  +0.000010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000005] RIP: 0033:0x7c45ff924ded
[  +0.000005] RSP: 002b:00007ffff7168790 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000008] RAX: ffffffffffffffda RBX: 00000000c0486456 RCX: 00007c45ff924ded
[  +0.000005] RDX: 00007ffff71687f0 RSI: 00000000c0486456 RDI: 000000000000000b
[  +0.000004] RBP: 00007ffff71687e0 R08: 00005b0c2a49b010 R09: 0000000000000007
[  +0.000004] R10: 00005b0c2a4d7140 R11: 0000000000000246 R12: 000000000000000b
[  +0.000004] R13: 00007c45ff19e5cc R14: 00005b0c2a51c538 R15: 00005b0c2a51bbd8
[  +0.000022]  </TASK>
[  +0.000005] irq event stamp: 87419
[  +0.000004] hardirqs last  enabled at (87425): [<ffffffff86a693a9>] __up_console_sem+0x79/0xa0
[  +0.000005] hardirqs last disabled at (87430): [<ffffffff86a6938e>] __up_console_sem+0x5e/0xa0
[  +0.000005] softirqs last  enabled at (87058): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000006] softirqs last disabled at (87053): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
[  +0.000005] ---[ end trace 0000000000000000 ]---

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index beae931152a3..7427e080b389 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -208,14 +208,14 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	drm_gem_object_put(gobj);
 
-	/* Pin the BO before generating the index, unpin in queue destroy */
-	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
+	r = amdgpu_bo_reserve(db_obj->obj, true);
 	if (r) {
 		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
 		goto unref_bo;
 	}
 
-	r = amdgpu_bo_reserve(db_obj->obj, true);
+	/* Pin the BO before generating the index, unpin in queue destroy */
+	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
 	if (r) {
 		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
 		goto unpin_bo;
@@ -264,6 +264,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct amdgpu_usermode_queue *queue;
+	int r;
 
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -275,7 +276,11 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 
-	amdgpu_bo_unpin(queue->db_obj.obj);
+	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
+	if (!r) {
+		amdgpu_bo_unpin(queue->db_obj.obj);
+		amdgpu_bo_unreserve(queue->db_obj.obj);
+	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
-- 
2.43.0

