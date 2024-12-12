Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004AFE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B1510EDF9;
	Thu, 12 Dec 2024 14:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H2H17Wsr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E741410EDFC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMkNfko3naT5ObnNRyT6iKJAZePHKJoLF399IAwKkKEccrBoC12zuSf1mK+ZkUELGf+R56lSUwv9T9TjgAahLs2YVb+8X7sCtGkpuba35sGx6SHxUddrTcwFVpcxNbUq2HHrKocLTkejBKE72tBPRtNepmqVGdSeFqWN5LhGHvsTHzOPvQCRq2n77Uvl/wXpPFJs9byeL/OxFyYh0Rt2n3UZgWoSiLm7itTykOdPGiK2gGbcbOfK3HzgTOB2ryeIE7GFHs4ADQ9irdHOl1HJg6a3XddWE90ddWWNrAaP1dO9jnvNT06sUVACFbZ8w9qj2gsZzfTl1xOR2Vf1Y8xX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EO/qoreSH1QLuShXfMjfF9al7s7/8Fm3KAbymWy9ZY=;
 b=qI6x1e7cnMcK5FE+JrWQE/H5LFoJyS7TWyc3WtMRi+qgM3um4oMDlxjX8MnjQQqw4jKwVTcABtRlrwi9y4K+pZJrZcmUfAds5PcKAvXIu2lvA4HGm8YYfAz6nzcGTdF74lO1af+KNeqNqV31HvS9GwfG6NBrn51+dHrEQ1c/yf6EU0ryCg/Zt7oq+sWdOi97PdNRhumPHDRtF6xqnSDJ1BkC6ZbDDQwU9WrkylpI/QPN6nKaZzCliloHD67xtUO0xY5sxROv2Zs12pgGrZ/Km1CLpIOWbnIE8+ZsUCwug9TUgSNIHTn1aicX+s6DqvBhJuRhtjwJvU1QEhCG7i0n5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EO/qoreSH1QLuShXfMjfF9al7s7/8Fm3KAbymWy9ZY=;
 b=H2H17WsrhMtRaCPTRQLD4lhSWRuAQDWn5y0e3aSg2Uxj1ja8fgQWVEZW4tfZMZP7p2f0h4vxxOkc+8OgIBK6QmO2f5WaBiGLJZyMQ73V9p6czQkCCM32zGV3Iq8w15U5GoSrAqV23XsdnYsWYIgo1ZczvFWL6/k5cBkfIDwAdM8=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:26:01 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::aa) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 14:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:26:01 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:59 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu: Fix wait IOCTL lockup issues.
Date: Thu, 12 Dec 2024 19:55:32 +0530
Message-ID: <20241212142533.2164946-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 860508d6-d99e-4ea1-b4cb-08dd1ab8e76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PwhK0OdX/knEbKDnkp3Rr5GWqQ94gO/+MkXCX/6j+U1KqGgbmfN0Kw+0kgj1?=
 =?us-ascii?Q?NCM8FtCBPXxYgxK+xbqK41Q574KUZT/sQgD2m7rrs4es5MBwXhIKcbZ1tEiV?=
 =?us-ascii?Q?+3ktsacvh9EPsHwnMKE6fmSEXd7bKphea4tE4H0oWJ6djC7PtMBSyoVpjvo2?=
 =?us-ascii?Q?FT6EtHFpz8GueJ2cGyfHfgLJUyABeoErVFMwVegyASZh2fIe1gkyXPNIlO+F?=
 =?us-ascii?Q?9D52u01VBL5GDGyirLSXTNLCnWoO91ILGqs6oELFCWWJr71bfX/gflKtmO6y?=
 =?us-ascii?Q?sGjRog4tlKZHMv+7ugbImpnb74gjkHQSacwuQF9pR20ZuvG8v34CXDuhJbT2?=
 =?us-ascii?Q?hwGq5VQkKE9uQ+YkrU/fMOkb6lfLPpaD/sfa138Sq2A0IQq/PiK95oHi+CPC?=
 =?us-ascii?Q?M9vgBwDljaWwuj9Sk45TeiAEG91kVaMsM7l37yvHetMIO3wyfa5QJksRPSgQ?=
 =?us-ascii?Q?Fk7P95pQPa76lNnHXN+4Q6ja5VZMLGn5zdPZrwkP3Bz7IDQLNKc4i6pZ4ff2?=
 =?us-ascii?Q?RjfTenUJV0mEreIGlJVsoN+Ic13Y8jcHLR0YE8llBApDMMhqyMUu8a3gquo9?=
 =?us-ascii?Q?7gQqNs8WRI4DhXLa4PIDDgJEgmp92358/rl0EuXcZaySRsL4RLDonB24Pt0d?=
 =?us-ascii?Q?OR+Ab1kY4H6OaVjBvyAxVcres74T6cknNvsIZSsP/cHSD/lk7KdXVbu5thXT?=
 =?us-ascii?Q?FycQ2RNt0Y9dT9gWKg7YnEI4alaKlQ0eSRgoJmgPVeXPe9so+g1KIYJgJOcB?=
 =?us-ascii?Q?jAWtCd08T8neBiz7VrINaOqD5xjcYF/5sySAYGndH9wYyuKcywEKEZwcxP6T?=
 =?us-ascii?Q?PiOG5GUVwv0e+7tOpo1i8D7FiXIHGIwUB4xb1kAO8Xr6k/ZJnmslG2FQHyf3?=
 =?us-ascii?Q?3hv6QkGaUHjLPRNO+fvwoDCcxdrJFLefzQbT3jyr+6z8YL4wfmYAeAY6+UQT?=
 =?us-ascii?Q?KpOChzrIGQDtzzZbXyS8u7WjwbhIvConKTXtAxCdTcQs+bBwYSugygAEx3iO?=
 =?us-ascii?Q?vVkcri3Xaj54HAStMjFnnIa6Ry0YSciCf6GRzfZsfap51J3Fb0LahN+za0qL?=
 =?us-ascii?Q?cub/i4wBDoFZaEWDBxKMXCRjX50nF6mXnkmbGyF2IzU5nokBK8pBRbR+0AVm?=
 =?us-ascii?Q?zbOcGDmWnLKTj/pvoW5J8Qyhju0R4BE52iOxgecZ4skPwtPD7qP+935KVaXb?=
 =?us-ascii?Q?CbeQQdRDbnG7UCxzDTJSFwMYdP1FfLTkGxO6C9qvJjJQ15JXtMgxLu6v17Dh?=
 =?us-ascii?Q?i2T0KUO5dOzj6R3B+WrXf95+S/dBAIbBOh54S3jP6ojtH7GSIScOds/sh0ZC?=
 =?us-ascii?Q?2PwtFPoMxf/TuMfy/s95lGUQ+01EY3SipyMNs4aq5KsIgY6g+Y/162hmSBvM?=
 =?us-ascii?Q?zMB5zgRjuAAz9rNXYMfdQxBp9yZE7o+8wv3Jp3D/1bWO61Qqe1vIkF3BVo4u?=
 =?us-ascii?Q?2oqDoz++mb5qYiPukbKsuG/Of3lbKEI2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:26:01.4481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860508d6-d99e-4ea1-b4cb-08dd1ab8e76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

Fix the wait IOCTL lockup issue.

[Dec 6 17:53] watchdog: BUG: soft lockup - CPU#4 stuck for 26s! [Xwayland:cs0:2634]
[  +0.000002] RIP: 0010:amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
[  +0.000003] RSP: 0018:ffffada901f4fc38 EFLAGS: 00000202
[  +0.000003] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
[  +0.000001] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: ffffada901f4fce8
[  +0.000002] RBP: ffffada901f4fd58 R08: ffff9fc28b974148 R09: 0000000000000000
[  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
[  +0.000002] R13: 0000000000000000 R14: 0000000000000010 R15: ffffada901f4fe00
[  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
[  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
[  +0.000001] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  +0.000002] Call Trace:
[  +0.000002]  <IRQ>
[  +0.000004]  ? show_regs+0x69/0x80
[  +0.000005]  ? watchdog_timer_fn+0x271/0x300
[  +0.000005]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
[  +0.000006]  ? hrtimer_interrupt+0x110/0x240
[  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
[  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
[  +0.000004]  </IRQ>
[  +0.000002]  <TASK>
[  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000006]  ? amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
[  +0.000162]  ? amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
[  +0.000156]  ? finish_task_switch.isra.0+0x94/0x290
[  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000161]  drm_ioctl_kernel+0xaa/0x100 [drm]
[  +0.000025]  drm_ioctl+0x29d/0x500 [drm]
[  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000160]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000003]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000004]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
[  +0.000141]  __x64_sys_ioctl+0x95/0xd0
[  +0.000005]  x64_sys_call+0x1205/0x20d0
[  +0.000003]  do_syscall_64+0x4d/0x120
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000002] RIP: 0033:0x7f3a0bb1a94f
[  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
[  +0.000001] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
[  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
[  +0.000002] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
[  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
[  +0.000005]  </TASK>
[ +27.998164] watchdog: BUG: soft lockup - CPU#4 stuck for 52s! [Xwayland:cs0:2634]
[  +0.000002] RIP: 0010:drm_exec_unlock_all+0x76/0xc0 [drm_exec]
[  +0.000002] RSP: 0018:ffffada901f4fbf8 EFLAGS: 00000246
[  +0.000003] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  +0.000002] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: 0000000000000000
[  +0.000001] RBP: ffffada901f4fc10 R08: ffff9fc28b974148 R09: 0000000000000000
[  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
[  +0.000002] R13: 00000000ffffffff R14: ffffada901f4fce8 R15: ffffada901f4fe00
[  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
[  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
[  +0.000002] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  +0.000002] Call Trace:
[  +0.000002]  <IRQ>
[  +0.000003]  ? show_regs+0x69/0x80
[  +0.000006]  ? watchdog_timer_fn+0x271/0x300
[  +0.000004]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
[  +0.000006]  ? hrtimer_interrupt+0x110/0x240
[  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
[  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
[  +0.000004]  </IRQ>
[  +0.000002]  <TASK>
[  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000006]  ? drm_exec_unlock_all+0x76/0xc0 [drm_exec]
[  +0.000004]  drm_exec_cleanup+0x77/0x90 [drm_exec]
[  +0.000004]  amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
[  +0.000206]  ? finish_task_switch.isra.0+0x94/0x290
[  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000159]  drm_ioctl_kernel+0xaa/0x100 [drm]
[  +0.000026]  drm_ioctl+0x29d/0x500 [drm]
[  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000163]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000002]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000005]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
[  +0.000143]  __x64_sys_ioctl+0x95/0xd0
[  +0.000005]  x64_sys_call+0x1205/0x20d0
[  +0.000004]  do_syscall_64+0x4d/0x120
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000002] RIP: 0033:0x7f3a0bb1a94f
[  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
[  +0.000002] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
[  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
[  +0.000001] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
[  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
[  +0.000006]  </TASK>

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 122 +++++++++++-------
 1 file changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 49dc78c2f0d7..5c39681c9720 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -383,6 +383,34 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int amdgpu_userq_exec_lock(struct drm_exec *exec, u32 flags,
+				  struct drm_gem_object **gobj,
+				  u32 num_handles, unsigned int num_fences)
+{
+	int r;
+
+	if (!exec | !gobj)
+		return -EINVAL;
+
+	drm_exec_init(exec, flags, num_handles);
+
+	/* Lock all BOs with retry handling */
+	drm_exec_until_all_locked(exec) {
+		r = drm_exec_prepare_array(exec, gobj, num_handles, num_fences);
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
@@ -476,45 +504,31 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (!queue) {
 		r = -ENOENT;
 		mutex_unlock(&userq_mgr->userq_mutex);
-	}
-
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			mutex_unlock(&userq_mgr->userq_mutex);
-			goto exec_fini;
-		}
-
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			mutex_unlock(&userq_mgr->userq_mutex);
-			goto exec_fini;
-		}
+		goto put_gobj_write;
 	}
 
 	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
 	if (r) {
 		mutex_unlock(&userq_mgr->userq_mutex);
-		goto exec_fini;
+		goto put_gobj_write;
 	}
 
 	/* Create a new fence */
 	r = amdgpu_userq_fence_create(queue, wptr, &fence);
 	if (r) {
 		mutex_unlock(&userq_mgr->userq_mutex);
-		goto exec_fini;
+		goto put_gobj_write;
 	}
 
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
+	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+				   gobj_read, num_read_bo_handles, 1);
+	if (r)
+		goto put_gobj_write;
+
 	for (i = 0; i < num_read_bo_handles; i++) {
 		if (!gobj_read || !gobj_read[i]->resv)
 			continue;
@@ -522,6 +536,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		dma_resv_add_fence(gobj_read[i]->resv, fence,
 				   DMA_RESV_USAGE_READ);
 	}
+	amdgpu_userq_exec_unlock(&exec);
+
+	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+				   gobj_write, num_write_bo_handles, 1);
+	if (r)
+		goto put_gobj_write;
 
 	for (i = 0; i < num_write_bo_handles; i++) {
 		if (!gobj_write || !gobj_write[i]->resv)
@@ -530,6 +550,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		dma_resv_add_fence(gobj_write[i]->resv, fence,
 				   DMA_RESV_USAGE_WRITE);
 	}
+	amdgpu_userq_exec_unlock(&exec);
 
 	/* Add the created fence to syncobj/BO's */
 	for (i = 0; i < num_syncobj_handles; i++)
@@ -538,8 +559,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
 
-exec_fini:
-	drm_exec_fini(&exec);
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
@@ -650,26 +669,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
@@ -682,7 +681,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
 							   &fence);
 				if (r)
-					goto exec_fini;
+					goto put_gobj_write;
 
 				dma_fence_unwrap_for_each(f, &iter, fence)
 					num_fences++;
@@ -700,12 +699,17 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
 						   &fence);
 			if (r)
-				goto exec_fini;
+				goto put_gobj_write;
 
 			num_fences++;
 			dma_fence_put(fence);
 		}
 
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_read, num_read_bo_handles, 1);
+		if (r)
+			goto put_gobj_write;
+
 		/* Count GEM objects fence */
 		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
@@ -715,6 +719,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_READ, fence)
 				num_fences++;
 		}
+		amdgpu_userq_exec_unlock(&exec);
+
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_write, num_write_bo_handles, 1);
+		if (r)
+			goto put_gobj_write;
 
 		for (i = 0; i < num_write_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
@@ -724,6 +734,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_WRITE, fence)
 				num_fences++;
 		}
+		amdgpu_userq_exec_unlock(&exec);
 
 		/*
 		 * Passing num_fences = 0 means that userspace doesn't want to
@@ -737,7 +748,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
 		if (!fence_info) {
 			r = -ENOMEM;
-			goto exec_fini;
+			goto put_gobj_write;
 		}
 
 		/* Array of fences */
@@ -747,6 +758,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			goto free_fence_info;
 		}
 
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_read, num_read_bo_handles, 1);
+		if (r)
+			goto free_fences;
+
 		/* Retrieve GEM read objects fence */
 		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
@@ -756,6 +772,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_READ, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
+					amdgpu_userq_exec_unlock(&exec);
 					goto free_fences;
 				}
 
@@ -763,6 +780,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_get(fence);
 			}
 		}
+		amdgpu_userq_exec_unlock(&exec);
+
+		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+					   gobj_write, num_write_bo_handles, 1);
+		if (r)
+			goto free_fences;
 
 		/* Retrieve GEM write objects fence */
 		for (i = 0; i < num_write_bo_handles; i++) {
@@ -773,6 +796,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						DMA_RESV_USAGE_WRITE, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
+					amdgpu_userq_exec_unlock(&exec);
 					goto free_fences;
 				}
 
@@ -780,6 +804,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_get(fence);
 			}
 		}
+		amdgpu_userq_exec_unlock(&exec);
 
 		if (num_points) {
 			struct dma_fence_unwrap iter;
@@ -885,7 +910,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		kfree(fence_info);
 	}
 
-	drm_exec_fini(&exec);
 	for (i = 0; i < num_read_bo_handles; i++)
 		drm_gem_object_put(gobj_read[i]);
 	kfree(gobj_read);
@@ -908,8 +932,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(fences);
 free_fence_info:
 	kfree(fence_info);
-exec_fini:
-	drm_exec_fini(&exec);
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
-- 
2.25.1

