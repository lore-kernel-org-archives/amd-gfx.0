Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E948C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 10:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C0610E043;
	Tue, 23 Jul 2024 10:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NpGSKVp6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CFB89E59
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 10:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMryD4qBDABD06OxXvxYJ97RL63EwdbwHfiT0cEda5TiDspQLqApmXbZdKfwM1261D4FABGZCYw4h/1zywsOfJdaBv9W1yDTFWpptBd24AiL2JER3+uAHJ0kUIulDD0N37PWyXnmWwgLPwJSwi/yEY7Zft8sAznsGbXLo1SImaNznP5RhlG5TF0xFPHauiR3IyHznNYI0QibF1Daxn8Pi2MQ4X97Y2ZtUJsgoFufXpo9MAzJrtJk/HX0rr5m8Hk455VqNjkslz+H+KQtWrwiOw7gB6Knmb/pbFJG/rI6BRZ0PpK2Ak41zUmiamQ3zcS4nPju9xMqmGhHd7z32/etiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0VEVroeWM3Fz//hp0nB7RUyVbx8vlgDfmJGwHEzX4c=;
 b=XjRW+LwXAryIb+a+nb6BSuF0SmH3AflR7Gzcc8kkKYtlnxvI0DKz5z7g9XSouqnDCjzc6XipRblRlrvbOj+gwyEOChbkiK1yj2HXoxIpElXfgrOVhXH6tcTFuI27FYe7UHDv2KrwmP51qX6W9RpnltYKknkYJbPH8KpCh8/FjGux3AnJMlKQMvU5Tp2rKL45wLrrBtQVSIVEUZ4BYiCoWBbioQMhzYyYwvaYnMibxUn/NGzwwbTAq60XhjgGWEhmwOnWrn08kYihlIgBv4Vxe8pj7RXBSuI3DLKsuavpEQdOZHPEfqx/aO0c1lv1pE7l+8sYVBjF9+0nzn9etIs+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0VEVroeWM3Fz//hp0nB7RUyVbx8vlgDfmJGwHEzX4c=;
 b=NpGSKVp62MV3p9m9uOLzfQNmHWQzRI1OnnqCMDrjBXjROca4BAeL04ovUmm6Yck8MacU9hyuerkqqTt6kVOOjZtu4FPgI6ZcPKEKqJOSYDFqzQ2xthQwpZELcnhcwMh5njHs3axxFxx+pprzrefAz8lZMIBqNrIwDTgzqLPnE9A=
Received: from BN8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:ac::24)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 10:00:28 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::55) by BN8PR07CA0011.outlook.office365.com
 (2603:10b6:408:ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 10:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 10:00:28 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 05:00:26 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <saleemkhan.jamadar@amd.com>, <li.ma@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix potential probe issue for VCN IP v4.0.6
Date: Tue, 23 Jul 2024 17:58:50 +0800
Message-ID: <20240723095850.296140-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c80b84-dfab-418c-bafb-08dcaafe47c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XbRw4hg+Y7f/4DhRyweExnz2VnMhWvk8XY3cfBkLGihqxja2sOpkckds8Pef?=
 =?us-ascii?Q?nJJEjUthKSdYz2HmJIBMc74zIDYLcdhGL1omHioTAjNUm5k5c1m91rhY2zGn?=
 =?us-ascii?Q?JIu2agCv2SlduoFsohjBi2hQUD706f//ekmOJmDuoum1Uu2L0TMwIEwPyB20?=
 =?us-ascii?Q?6YpS3AWpNbLaRxpZc0gai4T5aVHBl/s4LA7vd0EcNb2sbs3IzDbEHlGa05IC?=
 =?us-ascii?Q?VoAobs4ZUAuRT4Ldf3Im9/FJY/MOw3DxtkbmcPhON5gbUIYF4xp029FTYqq+?=
 =?us-ascii?Q?uI8dZzds4xMXeTrqfPnN1S3C0aAE1JT1wAbV0iGYlEtCN9OERaoepQQTB/dG?=
 =?us-ascii?Q?SEVP0MbNU3hRrZecvfBrBcR71wLF76Ds8s2rXfKWxuSvV/abCklj8El9waFA?=
 =?us-ascii?Q?GvslX4p6Gu92lKAv1MdDarNtdE+dB7H7VixrHHHf69XRiklLH/IehRVqZdk0?=
 =?us-ascii?Q?zdolIkVSiMUxkr4i2Ig41Yn+ceCIYNRM43Y2Fbm6IXnb37vD5CZ2kA/z/+Hn?=
 =?us-ascii?Q?aCwJpasjwEGpBniE2mxVjXYzipdfkllGe+byL8jNVUUMGn4FSsTzu9fdJnGX?=
 =?us-ascii?Q?J7aDvxt10lE0VET8fGGZwyDL9wVkwu3SufmFfu1jKdz9WItepYvatV+BlAqp?=
 =?us-ascii?Q?PrpM8wkPc4m7NngmkTpo2Ni1/GsRHmrSqTNoqvO7gp8LUv6Nj/g9maem7jhe?=
 =?us-ascii?Q?b+RkSVzWPxbCebJrWw/0wKAyM5roEubjy+YWijlqw3pEnYO6qAicFbCliAbc?=
 =?us-ascii?Q?wmA7WGIP61wNYBKVfJ/kpyH15xIa4nMVYHyBVOKoFZ3ptPahcOV7ApC4MTmc?=
 =?us-ascii?Q?w2OBzaAdO+V0et3OARPPPb3Rioc3IpcryyWYUb/T6ZcnY44Jpi0gKN9Hw+Bw?=
 =?us-ascii?Q?mPfs6y+BNiDQ+uL/ps3YmA4twCSEOQR7B93TZvQlbXFRC49rYu7M20JXl9Zc?=
 =?us-ascii?Q?c9yaS+iIzv1aNc8f5KS3SfU4Li6YIDA8N8oAS3IbR54Rm8asUwCA150V4O6G?=
 =?us-ascii?Q?CdPEckisXx2pFqRMF5EvTHrb5HgeLGjpLIf+d5MmmWquEOKTnX0zkHE/uKQJ?=
 =?us-ascii?Q?47BkzOuVcN8Hm4S5Rf0V1WPLBJyG1iRtuKijhyrVYxVifMakbpl7WFKAu8yu?=
 =?us-ascii?Q?/R8HScjLvzqy6ANv/WcdTFo5S/da5SI5MVFSlCRJHPiURBgpZKbsBjYR8m1f?=
 =?us-ascii?Q?L7DxAjPlN1B62Q96JigYscNzpyCeLngmpZ36zA1EOTPW3ADt7v6kl3OUjHmU?=
 =?us-ascii?Q?2IIS1j1JJGppWGFAkAbrFdFVAf943qcOvKMaIF3eIG3v+nlcSYkYrajOuyGu?=
 =?us-ascii?Q?0wgXFZ+FkzVstG8OpUcG9NUyxSRg6jpF1ZjzIPanBZRc2MCdB0V/BCnT5iPA?=
 =?us-ascii?Q?JBbn9hlEWFfMmwavMecA3dbz87dAyGhyURz4E2mJK20dRGBtdOGnzDpTlYwt?=
 =?us-ascii?Q?GwKpTJeJ4y48WV7TbZmXyhn89YOeQE29?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 10:00:28.1764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c80b84-dfab-418c-bafb-08dcaafe47c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

To prevent below probe failure, add a check for models with VCN
IP v4.0.6 where VCN1 may be harvested.

[   54.070117] RIP: 0010:vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
[   54.071055] Code: 80 fb ff 8d 82 00 80 fe ff 81 fe 00 06 00 00 0f 43
c2 49 69 d5 38 0d 00 00 48 8d 71 04 c1 e8 02 4c 01 f2 48 89 b2 50 f6 02
00 <89> 01 48 8b 82 50 f6 02 00 48 8d 48 04 48 89 8a 50 f6 02 00 c7 00
[   54.072408] RSP: 0018:ffffb17985f736f8 EFLAGS: 00010286
[   54.072793] RAX: 00000000000000d6 RBX: ffff99a82f680000 RCX:
0000000000000000
[   54.073315] RDX: ffff99a82f680000 RSI: 0000000000000004 RDI:
ffff99a82f680000
[   54.073835] RBP: ffffb17985f73730 R08: 0000000000000001 R09:
0000000000000000
[   54.074353] R10: 0000000000000008 R11: ffffb17983c05000 R12:
0000000000000000
[   54.074879] R13: 0000000000000000 R14: ffff99a82f680000 R15:
0000000000000001
[   54.075400] FS:  00007f8d9c79a000(0000) GS:ffff99ab2f140000(0000)
knlGS:0000000000000000
[   54.075988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.076408] CR2: 0000000000000000 CR3: 0000000140c3a000 CR4:
0000000000750ef0
[   54.076927] PKRU: 55555554
[   54.077132] Call Trace:
[   54.077319]  <TASK>
[   54.077484]  ? show_regs+0x69/0x80
[   54.077747]  ? __die+0x28/0x70
[   54.077979]  ? page_fault_oops+0x180/0x4b0
[   54.078286]  ? do_user_addr_fault+0x2d2/0x680
[   54.078610]  ? exc_page_fault+0x84/0x190
[   54.078910]  ? asm_exc_page_fault+0x2b/0x30
[   54.079224]  ? vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
[   54.079941]  ? vcn_v4_0_5_start_dpg_mode+0xe6/0x36b0 [amdgpu]
[   54.080617]  vcn_v4_0_5_set_powergating_state+0x82/0x19b0 [amdgpu]
[   54.081316]  amdgpu_device_ip_set_powergating_state+0x64/0xc0
[amdgpu]
[   54.082057]  amdgpu_vcn_ring_begin_use+0x6f/0x1d0 [amdgpu]
[   54.082727]  amdgpu_ring_alloc+0x44/0x70 [amdgpu]
[   54.083351]  amdgpu_vcn_dec_sw_ring_test_ring+0x40/0x110 [amdgpu]
[   54.084054]  amdgpu_ring_test_helper+0x22/0x90 [amdgpu]
[   54.084698]  vcn_v4_0_5_hw_init+0x87/0xc0 [amdgpu]
[   54.085307]  amdgpu_device_init+0x1f96/0x2780 [amdgpu]
[   54.085951]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
[   54.086591]  amdgpu_pci_probe+0x19f/0x550 [amdgpu]
[   54.087215]  local_pci_probe+0x48/0xa0
[   54.087509]  pci_device_probe+0xc9/0x250
[   54.087812]  really_probe+0x1a4/0x3f0
[   54.088101]  __driver_probe_device+0x7d/0x170
[   54.088443]  driver_probe_device+0x24/0xa0
[   54.088765]  __driver_attach+0xdd/0x1d0
[   54.089068]  ? __pfx___driver_attach+0x10/0x10
[   54.089417]  bus_for_each_dev+0x8e/0xe0
[   54.089718]  driver_attach+0x22/0x30
[   54.090000]  bus_add_driver+0x120/0x220
[   54.090303]  driver_register+0x62/0x120
[   54.090606]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   54.091255]  __pci_register_driver+0x62/0x70
[   54.091593]  amdgpu_init+0x67/0xff0 [amdgpu]
[   54.092190]  do_one_initcall+0x5f/0x330
[   54.092495]  do_init_module+0x68/0x240
[   54.092794]  load_module+0x201c/0x2110
[   54.093093]  init_module_from_file+0x97/0xd0
[   54.093428]  ? init_module_from_file+0x97/0xd0
[   54.093777]  idempotent_init_module+0x11c/0x2a0
[   54.094134]  __x64_sys_finit_module+0x64/0xc0
[   54.094476]  do_syscall_64+0x58/0x120
[   54.094767]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f45495de6875..8d75061f9f38 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -958,6 +958,9 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1162,6 +1165,9 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-- 
2.43.0

