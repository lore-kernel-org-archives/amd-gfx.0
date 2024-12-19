Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83131E7718B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 10:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA1910E4A0;
	Thu, 19 Dec 2024 10:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TWRQTAYt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A21710E4A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 10:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpSZ/MMQ1bBHmLsCX1U+nNAj8DeyTe3nnS3+ujspxIVOipg6FCSMViqC4kS9iHDQvAr+UCBDfGtdvOxYu9A9xLK15Yw6lKvtZUCKqso61EjWdmP+slOdaa7DLMO8pW5viJJk4Cy7vcOtTa703K6ODjy/FuNMmwTfaiJ3R/y4m3jtKcQPBhdEftPpTmEGh6sTkL+prDJrPnvIunNG3lrQaJeR2KwMql89AQd17Of4MP12Y29XrtqDDUEsQEiIYItKbpqDFst5yeukBjZ7d0Baj45INju6wa9b3r+EATGZp1/rIlcOFIdkC0g1LnPV6adTNPZaiupRw3W6tRBkqO8SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wc2wxizh+HiQPewkN67PH32p2NIXwEb76EqXZLf3Co=;
 b=Yo+YLnXPzpz+Dbn2ZqI5QVgecO9WP2DU9iuw8RM+F9nsyuv9awDfhhWdEevSESudlfEkmoYCZalXhAGmWirMLZ97sZVPiHDOJk7Iwjw3HBfR9QEXqfSqAC+T4C9KA9//IJe/lkr/iNaMCo87lpO2rl4Fh6RQWa7u2Z2WO3jy83/Td16o/R60XSxOlh7Qo9IcjusA9H+JaebAI+79GF2wkFYRnSWABrhYP2grGIGwfFNscR7zOiSQ/w3RW90yHf9u9OFaDPo7Oy7dL7zgYOt7MMfA+uIzSKaMUah0g8x0YS6LIrJ1y3O9GEaOs30p2qGwex0FBMpfEcyt5GZAQf7psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wc2wxizh+HiQPewkN67PH32p2NIXwEb76EqXZLf3Co=;
 b=TWRQTAYtpb3CspEZxkS93mhnciJqLkxidJThCMyeOicdpRFhBL1bxbU0D31k2isgLqCUoefg9f6lmsUYFGoSG3xihrtwRo4b6DRsCcSeCo8JIPiE3ikTJaeACErYpP8dZ0bPfiC/81P6alNp81hrdNamqcHRFW4lsSsz4JtRnGU=
Received: from CH3P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::15)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 10:38:48 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::7d) by CH3P221CA0010.outlook.office365.com
 (2603:10b6:610:1e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 10:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 10:38:47 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Dec 2024 04:38:45 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: Fix wait IOCTL lockup issues.
Date: Thu, 19 Dec 2024 16:08:24 +0530
Message-ID: <20241219103824.630689-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f591e40-f231-4d37-a53d-08dd20195213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HDxTkowvnCqetKuvaqVO3SDYC7iH5Zym1KXunOphrqs8UOS4VKh8J4slLn8E?=
 =?us-ascii?Q?2hDpn4hObcF6DL1QdFyfHpY7GnTQCnrrEVuddEKSBKNDJ9dlrTxWkeekDf0J?=
 =?us-ascii?Q?7pebDw2J/c1X7muQ/OBP4LiSn1g8ljxkrwsrdDMmMLJKiXcqVNQl+73NZ9YX?=
 =?us-ascii?Q?VmPMEFBghfdm4WFty2yL5PvgZ8T4lhBwFqGw605ZzsuFuWHGr5kHp/ewQJN9?=
 =?us-ascii?Q?whCKDAV9n50I3J4/7/uJbCSgUYyhB43pQPxDdHqMHMMzrhGM4GNv8EajXUL+?=
 =?us-ascii?Q?yLvsLjBkrxP5PM1U+NWpkfrWUqusnGo+RWZMFH93AxdZXD/MxUC9c+OQdqWj?=
 =?us-ascii?Q?eCYua2aTPEsm0m5MUslEUWST7nAcjT4Ta0PATy9WBUcwbBHPZcDKr3aLK/Cz?=
 =?us-ascii?Q?uvmOqZKxnzxSVBA8mEm8o6XE8UqFc+fHmqAcU3gCvhYUtmSd+E2oxcn2cPkS?=
 =?us-ascii?Q?pOvCqFyr4qsDHaPSNQL5h84x65dhhAxDNGRoIXaDs+5KyJWXAT9ilDgjJroq?=
 =?us-ascii?Q?yrNxg2TIogWDDAtilaATqJbdOaMje9XufASreazkcK2EsjpGwTEw0XMWa14W?=
 =?us-ascii?Q?g5r2rswHZ12QkrfFpsHhC3EtFAGn8CO3sSZPhTxRz0FrqSl7+AL4iWGtHalt?=
 =?us-ascii?Q?8NSdMorIJAgFBU1Wm2KSlYPutNAANV1mjstCjRqg3Rj6qWI3ztqUMTXYqwF4?=
 =?us-ascii?Q?Nn7ZxZ/DAtm6t8a5PTOiIAr1fWE9bQFmNIUujXKpYt7MI9UEJZQuHN2tn8IV?=
 =?us-ascii?Q?6A73NA3fWQmQsaEUMPPck7MA3dHTVWy2JOZkuCIBktzMBKEjCY24TVpP+pIX?=
 =?us-ascii?Q?Ibt0mJtrGqJp7ju+diUBmzwbvMsuiig8kEk74b929vcknzffV/v26uhmISkl?=
 =?us-ascii?Q?k6kiFuAfvWKjMk278WoBNGq0XzV69pLwMMLKZLP8JE94siiFepS7hM/LrLvl?=
 =?us-ascii?Q?ByQi6akmSmEMhq63Fdvj6tStnHwcKgZamURY4G6Xtda+j8e8iywN68lpP1mA?=
 =?us-ascii?Q?MpNZnsG+K+XrWNbPlrNKp7b3sBM5coQSC7/W2/SN7TgxqtieJdzY4+TzcNNM?=
 =?us-ascii?Q?PpZDDbswb+OKIhC6DG5isu6NnmYM3evR9kSSdXel+ypXw/zZW94/zadNVF0v?=
 =?us-ascii?Q?8kSYcqIXMJumkL9lygHVKBz+ejxCp1C465Rv3Xb9DCVjuT0dM6woAcRFN+nN?=
 =?us-ascii?Q?unptJBvmABvmRcvGPUoyg+cOtIT2V5Z0MOM7xUffsG8jnxTsfiMnGqYfP6Ue?=
 =?us-ascii?Q?B69SdiS+Vrze4sdcNn5FiBsh93oiu83X14ahTPsnVNsmVq+AcTjH/t907DtA?=
 =?us-ascii?Q?417k12yHFqfFWYMpuzE2ySms2tUkjUgU3Uk7xUCUor5JHzgItoVlpLDzZawX?=
 =?us-ascii?Q?yQgOlffX0bP4xSx/K2gnGSrGzRVKWUddzjrJiQ/+/AtZ2CuV7l/L/EE3GciI?=
 =?us-ascii?Q?Jei5MvIwIx+/r32GdhTtAY/VLFFfsp4hEap/VH3lmyRg44DBCrEK82Xi64a0?=
 =?us-ascii?Q?yAVz5uVXaYtsDWo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:38:47.8987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f591e40-f231-4d37-a53d-08dd20195213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
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

v2:(Christian)
  - The problem is that you need to lock all BOs under a single
    drm_exec_until_all_locked() loop. Otherwise not all BOs
    would be locked again on contention.

v3: Locking vm pd when accessing the GEM BO's solves the lockup
    issues.

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
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 45 ++++++++++++-------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6876f24e5eda..35d306fc069d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -463,22 +463,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto put_gobj_write;
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r)
-			goto exec_fini;
-
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r)
-			goto exec_fini;
-	}
-
 	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
 	if (r)
 		goto exec_fini;
@@ -495,6 +479,27 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	queue->last_fence = dma_fence_get(fence);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      (num_read_bo_handles + num_write_bo_handles));
+
+	/* Lock all BOs with retry handling */
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(queue->vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+
+		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+
+		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+	}
+
 	for (i = 0; i < num_read_bo_handles; i++) {
 		if (!gobj_read || !gobj_read[i]->resv)
 			continue;
@@ -558,6 +563,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
@@ -635,6 +641,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r) {
+			drm_exec_fini(&exec);
+			goto put_gobj_write;
+		}
+
 		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (r) {
-- 
2.25.1

