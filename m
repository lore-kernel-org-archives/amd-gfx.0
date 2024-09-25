Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAADCF9C77
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 14:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6F610EA24;
	Wed, 25 Sep 2024 14:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBY3XeyP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873AD10EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 14:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY44z+Rd3FsELHb3vYmWn9UQc6N/4a5bgLOo9tLQH7Ied+vGdr1jXPWOc9gzcOhnMBab1PVWMrdas12EEhAtMIhHeqst3NL0XsUW85NgJ9kMFv4sMJXf3l248kw+QodMdZ1k42uqho97LyQ2ylp8oTAVOYW/9SWRwpSeSz8OaZF6eE3FboCLBQvxGKdp7xZkxI5rXLhjxJs3Z9egrti2IxvYCJ5SwBuLEAfFZQDdR2Nyj/vZkQXLqYNC8YHn03VtjIR924P4y50sg+kHmTX3BJ2LtCr5PN0bNqgNChjuxRm3VRZxdynRPEBGS5EXntbbssapkYnXaLB/Vvy9/7w+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G7WPKJf1kiceYpww8fsrdwhG2msCOw4Dlq78FYrQvE=;
 b=S+gyN5agnjMWqYdbTFsm7dtb6tUQH7R1LLlDWcdH6iiEO8e3byEZLOymzLVHr45yOh2TIPp1EXO0T5z4+Yo25XHoXcwg49/LHCvaDTPymbPpFj4MbKktOH0dPJXqIEhh4u5252Ikz667Uau+mQUJaFawLGHaMoFMwiWPdwuOQ3+om3cCNcHOKa6ZPP6TQExDepojsFIUOmzmhdU/o3mhbazsGS3dv2MZXQInglMDj5E/8wA1MZFVrJIWXYCYrwZC21xPJx9fypJomNV2dmNBhbBs592NG6NpLcX6R5SXmufQ+jTlpbyhEfb0da9lcoOn9oYJ6RweqOLLa8xixF4qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G7WPKJf1kiceYpww8fsrdwhG2msCOw4Dlq78FYrQvE=;
 b=pBY3XeyP916jPCB4hNj46S334wNYIMFSsfuz0s54kEoh+cSwu6xIMtPwhPJqxi8g0AXD4XqbwZdbMDeMs714SqaOBfW2JpczWTXEqqMeGeqaChVYXxmc4rIByrEhvOF82mc870lEg2RWNiqJYHXpL4P67L1eHE/mwgt4PWz6w+0=
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 14:38:58 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::28) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 14:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 14:38:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 09:38:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix out-of-bounds access in
 'dcn21_link_encoder_create'
Date: Wed, 25 Sep 2024 20:08:40 +0530
Message-ID: <20240925143840.3322263-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 094cc3f3-5a35-479b-0eee-08dcdd6fc9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sgssmz9pjq5vWZCq2qSYzjtHasUfO8pwiYwKXv2rIyThJu4U9B/1HNoTm9g4?=
 =?us-ascii?Q?eGleCuEa8VYKaneURsTiYwktG5KwV/HndNKTAqiu8ihk0z4K3CNk6sPjpYBK?=
 =?us-ascii?Q?MgEegHwOVlLvRH0QadhezIGrTmYXPdLUp4F/eW2VdCByPwKbHsvouw+M9/RG?=
 =?us-ascii?Q?2dEMDPTefFLo7rYURy38vXXr3yIxpn+87drxTfjV3BlQeTPIgRCBlQxrcI+W?=
 =?us-ascii?Q?x3YlAMZ/uYvq9tisVe8IiKhuROF2wYoKgaJF2E6TIQR9LY7FW9q1riLwBzd+?=
 =?us-ascii?Q?fX43u4zkzEZuRUAKg/MMkYoduY7/Rad++D55Mw4jV3wVkZaUYYwvWJjGJMK/?=
 =?us-ascii?Q?FxbYTmidSvRL4C36EAcAfAsmnFCXVZ+mRRrTEQ65cvnpkMBoNsdr+SN21mT1?=
 =?us-ascii?Q?rKZ9IZv0gyb5n7Qo7Eg6cbnMqmxWgijNeixKraXfFZ4AJRxXngBgqoLZ0Zru?=
 =?us-ascii?Q?oxj7xdHuZMjbgOJ0idbUtib9wn5RdEXhpnX/puitNg7UHlDXruHFpEKFq1l3?=
 =?us-ascii?Q?TEByQlOcN2yuhsRQpM2MZ4UF8b6Kw4Ut+S/Ud3JXoDh75VOoUQ/VFI33MmsJ?=
 =?us-ascii?Q?OFlCUHY4rtEmlVcZknqTfwdM3yFj5eVYXUd/nGwmRb/WKoHv/zYjfVnFJDC3?=
 =?us-ascii?Q?JhS9LwyGsBfIaONFMD0ALZHnpOPxq7VjuYDU4pwmSV1AU+lAP9W3iiurnNLB?=
 =?us-ascii?Q?CszyDc6oKSpYH7QfGA1tnM2M0QiPYvCKY6m3ZGvP7Qk8SYHVvo/Am1SqHIdN?=
 =?us-ascii?Q?rMVUTEWX5icVRouEyVMv3DeQTi8RvYA1Ka1LTwBugun0PQrN9HDNKP1IM1xO?=
 =?us-ascii?Q?u5ULPBGgpW9WF8TWpfNtF9Ge2+T4EhhsC/yKWd9PI5cNeGtz2IJRZl3iZnBg?=
 =?us-ascii?Q?m9CcRGDs3+TTamphRfUx6yTtlVYQUx6BUFxhtDm7JPY+a3XFQw3JIYdvKlQa?=
 =?us-ascii?Q?1Rk5ch2FU5Z8fGw/Qj0C+5hG/wbyNE4fvS7/VvTAi0Ek1kZdK8GTNkYl0dlj?=
 =?us-ascii?Q?YgN3TXbuOTkR/p9PZpK0dZzkf6hJnSoyQIB7I+jT1lionU6brgQ1+yd318En?=
 =?us-ascii?Q?RrT58Gb8A3RKmNZArX25vRnN0HWt5vCgsfAW9ddLGtRLJOpjU7aGrZWDJIFQ?=
 =?us-ascii?Q?M0BSo16tLxPaiinfoZ0iPkK3lkCCeWZGilpmhl1pABVJMPPQGOay/9omuaMy?=
 =?us-ascii?Q?W6ofRk1xuXCLjE0gE/nyuFUlXvNTwA3C97N4Ds0TQMpVboxhbhAKMPNFXUBQ?=
 =?us-ascii?Q?Cbja2I549CQT5pER2d8IG++dworHATCVGXVANahHJyp68b+R1SQFMHxB3H2i?=
 =?us-ascii?Q?LJTL4SRHMuBSn8/BFwsXUuWPMfnd6QfgONNrV0DMIP4i2HGIFHE+j0DhVUwv?=
 =?us-ascii?Q?w8R433G1i2b0T0diXzy0iDw5+k17DfwhVZIL6/F6/uGT3HGWmRwVyIn5UXer?=
 =?us-ascii?Q?OgvF34EAXapk6NGXJYxfd+kD4id6p3Po?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 14:38:57.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094cc3f3-5a35-479b-0eee-08dcdd6fc9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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
v2:
 - Changed to ARRAY_SIZE() to be generic (Roman)

 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 347e6aaea582..14b28841657d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1298,7 +1298,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1

