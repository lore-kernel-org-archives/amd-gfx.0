Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AE6CF9C68
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Sep 2024 03:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2411810E0C9;
	Sat, 21 Sep 2024 03:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z0ei+wML";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035A810E0C9
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Sep 2024 03:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUQGh6Qkpvf+YKkiW6YWb3NSBTHH9uoVMcGF+mxoOEix11MGm51DJcjs+oROaEZfG8QrYpgWBeEX6vdqy31pnkmAvNmVSwhjKD2uDfful2ubK3W9YE1vlu/SWJORXmf7ORhuLsqmbyBTFmvxJS1znME6ExtfJvuq6792HGSzECx3MQSFNQ24Rly+k9Fu7/A8k63ZEoZ+wTdUH2YqTGQYQNcjfKD4v+2MtHUxg1cRh4mUWMLHoGAEzHPBWz/MVUwmR0ixSuxJBxpIePWsf2K/qpyh6Xb7amPj8Tlcsa0nhNuA8dV7hxXh+y9HXdsltsToHSlQpYWaUgxpf3TMRt0omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnsSefjK7PoYBHbDmU6WbhSQeOvd0wM74HgiX9WSbyA=;
 b=cTQZD0CUq/Uj9T8jjLldeR1Q89iIchyOY1/qORGh2mb87hG1aDJcEMWDC1Gq4yurql3tKW1qAALrxBVx9F2MNQMbT4/1AP4TR5JpnW134Lh5V3uPC+1P6W3H4CU4Zj/QS+LbXR4wh4faPa0PePZ3y4Ou2ySkLciTTSz+rr8fKCACPH96AwGxNFGqv3vw2rCfKnlXLVVOaRG6n3QA6jnDK7+GgGrnqaDSXTYjtepBGCZ6efOQUgC54GdSU1OnqJV8XP0s+kQLpgooRskx/jR5U71msIPL6rkMZNQN6ut+2Vp1ScpNrpJTemFXD2uuRLiBXZJuNUO9+e/m5BvzvE0CFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnsSefjK7PoYBHbDmU6WbhSQeOvd0wM74HgiX9WSbyA=;
 b=Z0ei+wML/NKRlrI3R0MvFjljP4YM0sqbAe1Kh+Dj18q6YpkghpG1mn44m+Jjy0pUuc55LC8u3VBx+n2eMejvK0109b3Qf2qAXlbzgtSIvnawKdAhdLThEzCL9hgnJv0Pxa1UAaMpZBWa9JLOZvgvvzFKJhU+xHAuR0WZvnahB0c=
Received: from CPXP152CA0012.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103::24) by
 DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.23; Sat, 21 Sep 2024 03:35:23 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10d6:103:0:cafe::61) by CPXP152CA0012.outlook.office365.com
 (2603:10d6:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Sat, 21 Sep 2024 03:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 21 Sep 2024 03:35:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 22:35:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix out-of-bounds access in
 'dcn21_link_encoder_create'
Date: Sat, 21 Sep 2024 09:03:33 +0530
Message-ID: <20240921033333.1349101-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8a0a34-d78b-4796-2fe0-08dcd9ee6bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4C26Ubt27iSEv+sHI/GIF/To6PqUOMHEZ5NfDHnEheaBF1TD+koV1si9Xw3?=
 =?us-ascii?Q?FGz72MjBNC53MVpiEeoscaYsNcdcncNkgMKxmLYZbtW9823ASY/8+7Ujsy5X?=
 =?us-ascii?Q?+Jh4BazsVWDS3DBVks50EjAoL1I11ng8106Zs/YTbd6jQ1tMUC8Ic9vpKRXC?=
 =?us-ascii?Q?Km7umHkgcG7WCNZRSV5BbmMIpi+ceivXS+5bzLAP6rE0zFN5mXMXqEYZFORc?=
 =?us-ascii?Q?GXohm5oAWP9Os3S8dkcQvfhjB9qm6/XueF3w1U2L0zxY0k+mdf4v8e6qjmej?=
 =?us-ascii?Q?ti+KrKGZmw/7IXXsFjuseqt0Hdo7LtI6cUYhv4xNELAOlnaL6yG3oDgBo81j?=
 =?us-ascii?Q?O8o4GMKa4CZrcb9+s9J2xhxuL+4my00YIhE25zDHXdDB60UT3liSiyH81nBt?=
 =?us-ascii?Q?HFTA2Zm6lBlaAYsfF8IMrwkurhsZPfVIl0c2Q2vBB7+RBRvvS8k4Cclu24sj?=
 =?us-ascii?Q?zDXZy5jl8zSTsHbSHBCAF3zQ4p42rAg8puHUTtpgZlw1CXFcTNoXb0WdQPL2?=
 =?us-ascii?Q?aAcEZ74hjCQeg9kPWgbVqjISWzZG/6dpGE5rktysmZOisO9Lb7tew+IstFOm?=
 =?us-ascii?Q?1IqxZG2k4CuMkyU5IcSqs4Y0xhw64N17SRGRKy8cXSoVZwoEuyreozC7pLiK?=
 =?us-ascii?Q?Jpe8kMUEkCKpVlwcLR0i0p2c5mWVwYKV0xIMHRJEw6D044sJzjdNyRNtkgq5?=
 =?us-ascii?Q?1hnaYDMQly2bgoOyQXYYIKltX/UjPWKiwECuiwm22/eezaTCqbLqVdoWSWCR?=
 =?us-ascii?Q?z0fURrRbZ1HDWpN3N53NmQRfpzSj/F1agKxZdhxw3ghgKTmWyUY8pHpIU4/h?=
 =?us-ascii?Q?1+T6XemV2G0Q06WD6+cFnPAmAQKzr12EWWz1x5IqHbx3HIxld6Bv9gtzi0T4?=
 =?us-ascii?Q?4S4nuMLUx80M5k6X+bE5NU/tOmXPmIBarzvvEXiH1SCL35+aGpLhdbcqCWkc?=
 =?us-ascii?Q?ymXozBi1LRBYVc4i80/MqUnf65c4LvAjJD27PZRykiXO9tsIBb7zCw6QSPJS?=
 =?us-ascii?Q?gQHfOUMeGdYZFVBBi5aMY8oKzQkndlMRN5xmEscJsbNLR2gR8pttyaeQSLQV?=
 =?us-ascii?Q?XFuejEpbaLj5srrraXaAWrmBtab4WGR95BfWCieAU64caeu8vItCh9ISpDe0?=
 =?us-ascii?Q?vm3juNWkeZAosqj/s1V3qZH7oDRIIk7E5cvepRot21/B4/b85tr97wUYKsnH?=
 =?us-ascii?Q?7WPCMWurKO8aKwdtoLN0QoDbhJ+1+fYjfwq26n1wgXwqk6lFYhnIvg0SUnyX?=
 =?us-ascii?Q?/RCeOItlKSd+HD/aZK52pzTJPF9LiPLZgIFaRCFY6zUHKRoCAsNfVRvWVu8A?=
 =?us-ascii?Q?fWzsnRXBYY6NVIdY6DLWvspTtb46KujZHLp3BE0FpVGbUipnmjUYzaaOyZgQ?=
 =?us-ascii?Q?yjV3/mcWCBO4MvgFbdeXYr0GVlLg/qMQVlXnlDTnYNQOKC5RERSXonNRh/0+?=
 =?us-ascii?Q?ZZfHJI1rQmnkV0c9lrZ3g0MLFDZvYhDL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:35:21.2555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8a0a34-d78b-4796-2fe0-08dcd9ee6bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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

An issue was identified in the dcn21_link_encoder_create function where
an out-of-bounds access could occur when the hpd_source index was used
to reference the link_enc_hpd_regs array. This array has a fixed size
and the index was not being checked against the array's bounds before
accessing it.

This fix adds a conditional check to ensure that the hpd_source index is
within the valid range of the link_enc_hpd_regs array. If the index is
out of bounds, the function now returns NULL to prevent undefined
behavior.

The conditional check ensures that the hpd_source index is greater than
or equal to HPD_SOURCEID1 and less than HPD_SOURCEID_COUNT, which
corresponds to the valid range of indices for the array.

References:
[   65.920507] ------------[ cut here ]------------
[   65.920510] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:1312:29
[   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_registers [5]'
[   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE      6.8.0-cleanershaderfeatureresetasdntipmi200nv2132 #13
[   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS WMJ0429N_Weekly_20_04_2 04/29/2020
[   65.920527] Call Trace:
[   65.920529]  <TASK>
[   65.920532]  dump_stack_lvl+0x48/0x70
[   65.920541]  dump_stack+0x10/0x20
[   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
[   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
[   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
[   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
[   65.921679]  dc_create+0x360/0x720 [amdgpu]
[   65.921999]  ? dmi_matches+0xa0/0x220
[   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
[   65.922342]  ? console_unlock+0x77/0x120
[   65.922348]  ? dev_printk_emit+0x86/0xb0
[   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
[   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
[   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
[   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
[   65.923087]  local_pci_probe+0x4b/0xb0
[   65.923087]  pci_device_probe+0xc8/0x280
[   65.923087]  really_probe+0x187/0x300
[   65.923087]  __driver_probe_device+0x85/0x130
[   65.923087]  driver_probe_device+0x24/0x110
[   65.923087]  __driver_attach+0xac/0x1d0
[   65.923087]  ? __pfx___driver_attach+0x10/0x10
[   65.923087]  bus_for_each_dev+0x7d/0xd0
[   65.923087]  driver_attach+0x1e/0x30
[   65.923087]  bus_add_driver+0xf2/0x200
[   65.923087]  driver_register+0x64/0x130
[   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   65.923087]  __pci_register_driver+0x61/0x70
[   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
[   65.923087]  do_one_initcall+0x49/0x310
[   65.923087]  ? kmalloc_trace+0x136/0x360
[   65.923087]  do_init_module+0x6a/0x270
[   65.923087]  load_module+0x1fce/0x23a0
[   65.923087]  init_module_from_file+0x9c/0xe0
[   65.923087]  ? init_module_from_file+0x9c/0xe0
[   65.923087]  idempotent_init_module+0x179/0x230
[   65.923087]  __x64_sys_finit_module+0x5d/0xa0
[   65.923087]  do_syscall_64+0x76/0x120
[   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   65.923087] RIP: 0033:0x7f2d80f1e88d
[   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d80f1e88d
[   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI: 000000000000000f
[   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   65.923087] R10: 000000000000000f R11: 0000000000000246 R12: 0000564c9c1e5480
[   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15: 0000564c9c1e54b0
[   65.923087]  </TASK>
[   65.923927] ---[ end trace ]---

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 347e6aaea582..e0f99b95f9bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1298,7 +1298,8 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || (enc_init_data->hpd_source < HPD_SOURCEID1 ||
+		       enc_init_data->hpd_source >= HPD_SOURCEID_COUNT))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1

