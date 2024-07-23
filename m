Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83B0C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 11:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFF110E56A;
	Tue, 23 Jul 2024 11:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TbFO9k4l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E071A10E566
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 11:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzB0mvyVXJucZNIvILS9OQd8Dc2MXuT9vhqnB4gtFXLT+TozUjuzvbqWEokgMVNCrTOo8EG3MLqc1Cj7nVB69DCFuXYzTbOcHHWxYqkwpneVQVLR0upfvT0kmTl0bAyJqtIUQmtI7zIC+U/UeC1rHJQiwpNup2SDqy21YlyHveaOWf9qMyUa5+hcS6QPLM3M2kUvetF9GPRck5xTa8YjvQkYuCiOsrk4VJmyoVnnNKJBjlK2FiLVK/eUIRiNfxinCvg47LK1eX6nykB75JREWM1WixPU1WCpURTFGrfY9qPKEaZEYlQ9hZzWTuYs069QY6vpAQrkz1xvaAPyi42qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJIzmpcjYkyA58rQGe4VedNA+GFcrAHX/OPUkJfWGP4=;
 b=QKoMvogPpxPpZn7y2masxyk5ntgYNjKj7kxLc241kmS7JS7/EJtRPohbKWmyO+ZRwH5ryIpql2bkaph0ssLQaiPf5LWsU/xSVSNLpv/623M8KjN4nPwVP43h7Y+EpCRGpzk2sCRt7vxbPlbjG3oTcxC1WKXkFcl8z+pHufJTa2HGSmXXAlECYgUdI4CtuA5nJD/ffCxxy0em+IM7EsvCruBHfNHR4tT0lPbfrwGqlAyKObg3YiRn8NeTuSEsc9yO1msW0aQRIuDh3iw38FmokvLhTdS7FKhFQTX8WQeYi2HPA0s+mOsBqqJELzdS7Os9zPgxJ73NZYy04olLNv5YCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJIzmpcjYkyA58rQGe4VedNA+GFcrAHX/OPUkJfWGP4=;
 b=TbFO9k4lRIG9XW7Iirs/LZhODCFmMgMiLa/k2WC9t2puZue6yUS6/gEJC2DNioDOzM+i77RkmIuJbRgE5a5HC32gRTzyKmOM/8aFA/TbGcwEBquZ6byKVg4+DsWUxYcgqSUXQkri8nuOIWI+zAlXN25jDsB5xUhqhz9FmP73low=
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 11:08:12 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::2e) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 11:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 11:08:11 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 06:08:09 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <saleemkhan.jamadar@amd.com>, <li.ma@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu: add missed harvest check for VCN IP v4/v5
Date: Tue, 23 Jul 2024 19:07:16 +0800
Message-ID: <20240723110716.313756-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: d765f500-0773-4305-6a9b-08dcab07bde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m96bsPUsPA0wbJEZWG4VuaPY44f7A9C90xgpVB5E32UBxoXneq9o5JxB5tDh?=
 =?us-ascii?Q?ePoGzZ5/N2oeSS6/nxWOJzYi0oItVlei/1prJuLfScJR7aw0e5HCiUdUzQ3p?=
 =?us-ascii?Q?tOPAAw83UapSYIZeZZoU6ZyMTnYL7KmUuSGzwCOI5v++bAKrU9lWzDhOOA7T?=
 =?us-ascii?Q?8WcF92JxuDP7/5SaF5eAiI4aC9kW250HnqO/v5CbZ+CpBS9VzIncgWbgJEwd?=
 =?us-ascii?Q?c43nRBXqE2aa+8xY8EVIvacIqIsboZ2TEkKD+QQogdNev3avKCSkaraOgiTJ?=
 =?us-ascii?Q?V71If0zvFhBsxKZk496L9sDzhPErEb4DzqLgVIBOEHnZaGhWPE9m4h/uYAlc?=
 =?us-ascii?Q?Ih/Yyf5fXJUeJ/21hGiwwRC1MVVunHRzRqJnjpoZoJ6Ss0sh4hSjf0hV1+co?=
 =?us-ascii?Q?LJBl3vpODU8SNHU8w6kkISL/QdvgaroQfgNEK8XQh5QR9rXRUJnp8Ok9J6O8?=
 =?us-ascii?Q?ErCLMtW8Vqt3//We+pIFm2xjCvWmCNVJBcj4tIuty/CiyA07HFF+XVzxqhr4?=
 =?us-ascii?Q?YZpfHryhCBSWL3ZcHqBOl2ivEQ13hRbzp0UO4d5Ky6eL+ZKv3zDrwBkBuflb?=
 =?us-ascii?Q?mfkUvI1PuIm1A/9H55kUHQ7gjeCfl8FTXdcjg0tCkwpmd1O3Z/5PpOppb44Q?=
 =?us-ascii?Q?tlazvxqMkEw0AykeiVwkjiE7rvhTOtJRQYGXiqcNqPOedFwnkgnvprnrZr1v?=
 =?us-ascii?Q?w81V1ZWgvvXmuWL0JJJxLqF8yPwCyF6BcHlC0VU2GUJAUXqPUXEBatPCVYlQ?=
 =?us-ascii?Q?D+P3tvCwnKdmZ07jwkU1VzOR/5hVPnX6oceTuNf1boU/2BY9Op7GOm9eDz7B?=
 =?us-ascii?Q?7KK9WZTp0GdSnifNViHyDyQvW04pNlX4ks7pNDPnrbMg0jpBSxJWR52yO6vp?=
 =?us-ascii?Q?xKu8kKpOg3kCDPghZnMDAcNTjIdxLJVego0nGnMtga9Tq/LlpYW/xbRoPE19?=
 =?us-ascii?Q?x4/6FUzsRfhhDzZLTxK80bzdKwX+6/m1NuL4Ru6ICP1Zvr4tgwXtzOj9HBK5?=
 =?us-ascii?Q?a1ZzgHsbQY9/c9ujPEqO/v6sJikylVH+46ntDFxlvQYWPE020MF1tZpsk+vm?=
 =?us-ascii?Q?UMpAYJnxCpgm53ynmRK4nKi01EZXq5vPM2BKpjnOXqWKsnGaAa9udUYY1Pxe?=
 =?us-ascii?Q?aEzD5IJ5GYkbGVsQhBYsZ7cqbdqs/yHTSioKVJYEZQ0LUQNFryhFRWz3MBdK?=
 =?us-ascii?Q?Ei5R3x+DNuIXW+LNN2e4mdIX8ampylRRCIiwuyqHWv/Bkrip3e3l6Q5bZZRp?=
 =?us-ascii?Q?h7Z0ivqe9eqCqS2grUUQ9F7yDFBVoGjoTjzwf2rrP692yJ4r02/M1IYTXgmV?=
 =?us-ascii?Q?uW09HGU1mrezhHLtzREWBFBkkDyVA344oTl/+q45OTac5uhRE8EA7zpTw65d?=
 =?us-ascii?Q?DOOGK5M959iCCuPGwRcSlsGREOxn3cHQaUcuvJuuO3iqsZ4UtQHjXtOuk6bE?=
 =?us-ascii?Q?pT4MJGNhHoCIiuFPauIJwCUpPkqOIDex?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 11:08:11.8298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d765f500-0773-4305-6a9b-08dcab07bde9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

v2:
Apply the same check to VCN IP v4.0 and v5.0.

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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f6d96a44d75f..776c539bfdda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1045,6 +1045,9 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1498,6 +1501,9 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 070b56610c7d..68c97fcd539b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -721,6 +721,9 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -898,6 +901,9 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-- 
2.43.0

