Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E31DC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 01:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FAC10E040;
	Thu, 16 May 2024 01:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WjLZ2c+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2917010E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 01:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVkZOBWnJ/4rGEpyW7ngfp6dRpovaBkbqk3oMX9n/P+My92aWJ/NBfQMUjH4DuQh1gSAejcXFQ1BxEez02MuRSO9PLSPqs2lcv2+bEsr6ERtzUvxjoSs8jI/hmOgDyHTxoME2T9XNMumjuSg+vqULEli+zr95deHCg6LCIPnohXlpat3JR1VrdSyVXLqwfSaUHZSytd2OT5Ln/haP0mMCXPnft1gESN4D/BhSe/D/HkoDeCPgADO570wdDO5ywpgS9k6/Ppzoo20upP+piSwklg9/5nEpXcgmgxHotaTUiP+W/ykal0jYIF/cgrvbqV5PJIKBVcnvNPO3mW9TVYm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma3bnL5ACYhvZrB6ih9tuHcqsPpgP/tFDsGD4vkV3xY=;
 b=DErzSKG0PNrwU3/QzeZHHuITwWF4nb2Bpec0iWglwkX/e2a5zXuLAkb1JG2gQNAQy4iAvUiT8cWyLewJr7vaqTmFLEV/mDOciS7Tsz9XyDuGr8+pdI+4+a0K0T8rdmNSsm/7zZW4zT6QHjPklRtmVkwDe+39OxBmGuTLBT4KVtNwgAZAN5onYsjh+IQ53CdRRa1+p6K24FxhOVd8xNuAta2ZAmLc5TP/tdXvIloi/yPa43kekXEyfxGGGidayoOaoheMVIR1v+20w26IGCCq5vsvZrGF0OVNGaZ9gonfihcGZ85dhe+SYwc9XiaXO0Q4Se54YHchfYeZlO9TofHnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma3bnL5ACYhvZrB6ih9tuHcqsPpgP/tFDsGD4vkV3xY=;
 b=4WjLZ2c+8wFRW9JqMjl4cygtZsnd0wWkAQt0vjLy8IRjEgxNWDxOKvEp4lVePe+tuBWDM3XOTCWntpLyRY4//aux9UDGFN5MTeFKtzMooR63qhfdz4RpUGyOfUp90nwQgEVkOJKB7outggkBDiiyOwMJun2StlYqvxzAzr6CucM=
Received: from PH8PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:2cf::18)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 01:11:47 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::85) by PH8PR07CA0038.outlook.office365.com
 (2603:10b6:510:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 01:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 01:11:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 20:11:26 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 15 May 2024 20:11:25 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <likun.gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: add thm 14.0.2 header file
Date: Thu, 16 May 2024 09:11:22 +0800
Message-ID: <20240516011123.2112909-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: c72213b8-5f29-4020-b60b-08dc75452832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4y0c7V+a61py/XimuU+Wjt89ioEcVmxUa8iS0yJ+IzN6DzVxOnZP+eFB7FN3?=
 =?us-ascii?Q?SB+pKAvfs2MzjC/sFBSwm1BsOtzQtyhgzrMsxq1u2m/Bfcw1UvZd+AC3vO0H?=
 =?us-ascii?Q?TiTzsfnnX3kTkT3HjAYK96GVrWyi/WAx9cPey410IURnXglf+HZ9KZiNWdw+?=
 =?us-ascii?Q?dHSK2GJuSKNjkzTv5GwzGYLnf5eR8x4j6MsrZXlNJMnEpGARC9llLYes76uo?=
 =?us-ascii?Q?2LzYoyTm6VkFXUVPU5S++tdFvMgokYpsgv+Wb5L3gTnaVQe5fzWVNvmapaq2?=
 =?us-ascii?Q?Eyz0O08rsVcH2Xb1pcTfC06tNZtAxmN68+D5DKtY6VCE4cm+XHguDc9s6k0R?=
 =?us-ascii?Q?E0z6UdkCTAySF9DEW0vxLjREAnOxVtmM1+ZVqpwviurmKe3hH1k5n4Cli8eh?=
 =?us-ascii?Q?HrXzN3myEvVRxS6qeer2Q95m3d/k2bY7mM7m84uHWh3UKRiu3a/tbe6T2y/h?=
 =?us-ascii?Q?DcXxtT7hdIvKd5WiBvUvqwRQlfrHvGUQZ1P/bQoeEqXW82z5dXO5n0+V+3Kr?=
 =?us-ascii?Q?nHSW7i7VPSR+r4VW3Kzy5uafFX1n9kcfWaO82QrA9uW8S86qF+ouDz0O/SgF?=
 =?us-ascii?Q?nEnQ9KEPKcM/SW3YB4RLWr+lWK3AC9vofR832IBPJLVtfpwkmbsshi2B/EYu?=
 =?us-ascii?Q?n1BgIxW7V+x1LW1gAExZwclguunJYWYHcmF+fCljIF/AmrB8p4qfCEdnQw98?=
 =?us-ascii?Q?/zSs5u1GodORUN73FHvh+oc0RIBXF/tBG61iO6/hYebo0d908oYu1ueMjPAU?=
 =?us-ascii?Q?YTfpf6TTR2SRQ/YbEa5IQwJDDJ+WWuZGctfesw9EHm/Mj+gy7RxCSQ9SNjj6?=
 =?us-ascii?Q?8mM5Inc7Ehe9gXu52wGM1/ZjyzsG2GWti7PiaZukCQCeEn025e9IQlR8mxw3?=
 =?us-ascii?Q?pktJoy2/NanTVPLfZEC44/EAVrTaem8OlLcqXWVza160uJVmfdINQEGvc+1p?=
 =?us-ascii?Q?kOWFX6NIi/hP1KN168xzqWEfynfVT32masyuxviVgMM0Ln6i0zv429ayg0a5?=
 =?us-ascii?Q?6PL1dj/IQWcRsGi+bHfotpwMwaLMI4+IWtGb9EhoyPHcV+N/3XUro99YgEwl?=
 =?us-ascii?Q?qN+qkB3TXF39CMfvKfwZuR5ZvI0BPOBMx1uuBo2SB0knVJqfGTJhzvlRVcoQ?=
 =?us-ascii?Q?spPlrzPBh44w6Cpt0rr+Kx+sge6GrZ0RrsTV1FLDAnpAmpPdxLXV0u8gQYuC?=
 =?us-ascii?Q?9Ba6llFmT+q7+yk0cBxc7Ppv2e08lqMYGcHarg3AGBK81/CAQpSWQittQv6e?=
 =?us-ascii?Q?3yg0FPJmJb7u+2WN0UKAaSlk/neya6GlOma8uzm6Wb8tmlfoWGImNvA2BsCZ?=
 =?us-ascii?Q?4UNaztd/2w9msL/62FDfqur5j4gGJW4Zz7BrQfBZL0KwQgze7rMBuniXSpmy?=
 =?us-ascii?Q?L0MfNeA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 01:11:46.6280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72213b8-5f29-4020-b60b-08dc75452832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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

add thm 14.0.2 header file

v2: add license, update to latest changes (Alex)

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/thm/thm_14_0_2_offset.h  | 228 +++++
 .../include/asic_reg/thm/thm_14_0_2_sh_mask.h | 940 ++++++++++++++++++
 2 files changed, 1168 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_offset.h
new file mode 100644
index 000000000000..78a71b124d22
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_offset.h
@@ -0,0 +1,228 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#ifndef _thm_14_0_2_OFFSET_HEADER
+#define _thm_14_0_2_OFFSET_HEADER
+
+
+
+// addressBlock: thm_thm_SmuThmDec
+// base address: 0x59800
+#define regTHM_TCON_CUR_TMP                                                                             0x0000
+#define regTHM_TCON_CUR_TMP_BASE_IDX                                                                    0
+#define regTHM_TCON_HTC                                                                                 0x0001
+#define regTHM_TCON_HTC_BASE_IDX                                                                        0
+#define regTHM_TCON_THERM_TRIP                                                                          0x0002
+#define regTHM_TCON_THERM_TRIP_BASE_IDX                                                                 0
+#define regTHM_CTF_DELAY                                                                                0x0003
+#define regTHM_CTF_DELAY_BASE_IDX                                                                       0
+#define regTHM_GPIO_PROCHOT_CTRL                                                                        0x0004
+#define regTHM_GPIO_PROCHOT_CTRL_BASE_IDX                                                               0
+#define regTHM_GPIO_THERMTRIP_CTRL                                                                      0x0005
+#define regTHM_GPIO_THERMTRIP_CTRL_BASE_IDX                                                             0
+#define regTHM_GPIO_PWM_CTRL                                                                            0x0006
+#define regTHM_GPIO_PWM_CTRL_BASE_IDX                                                                   0
+#define regTHM_GPIO_TACHIN_CTRL                                                                         0x0007
+#define regTHM_GPIO_TACHIN_CTRL_BASE_IDX                                                                0
+#define regTHM_GPIO_PUMPOUT_CTRL                                                                        0x0008
+#define regTHM_GPIO_PUMPOUT_CTRL_BASE_IDX                                                               0
+#define regTHM_GPIO_PUMPIN_CTRL                                                                         0x0009
+#define regTHM_GPIO_PUMPIN_CTRL_BASE_IDX                                                                0
+#define regTHM_THERMAL_INT_ENA                                                                          0x000a
+#define regTHM_THERMAL_INT_ENA_BASE_IDX                                                                 0
+#define regTHM_THERMAL_INT_CTRL                                                                         0x000b
+#define regTHM_THERMAL_INT_CTRL_BASE_IDX                                                                0
+#define regTHM_THERMAL_INT_STATUS                                                                       0x000c
+#define regTHM_THERMAL_INT_STATUS_BASE_IDX                                                              0
+#define regTHM_SW_TEMP                                                                                  0x000d
+#define regTHM_SW_TEMP_BASE_IDX                                                                         0
+#define regCG_MULT_THERMAL_CTRL                                                                         0x000e
+#define regCG_MULT_THERMAL_CTRL_BASE_IDX                                                                0
+#define regCG_MULT_THERMAL_STATUS                                                                       0x000f
+#define regCG_MULT_THERMAL_STATUS_BASE_IDX                                                              0
+#define regCG_THERMAL_RANGE                                                                             0x0010
+#define regCG_THERMAL_RANGE_BASE_IDX                                                                    0
+#define regCG_FDO_CTRL0                                                                                 0x0011
+#define regCG_FDO_CTRL0_BASE_IDX                                                                        0
+#define regCG_FDO_CTRL1                                                                                 0x0012
+#define regCG_FDO_CTRL1_BASE_IDX                                                                        0
+#define regCG_FDO_CTRL2                                                                                 0x0013
+#define regCG_FDO_CTRL2_BASE_IDX                                                                        0
+#define regCG_TACH_CTRL                                                                                 0x0014
+#define regCG_TACH_CTRL_BASE_IDX                                                                        0
+#define regCG_TACH_STATUS                                                                               0x0015
+#define regCG_TACH_STATUS_BASE_IDX                                                                      0
+#define regCG_THERMAL_STATUS                                                                            0x0016
+#define regCG_THERMAL_STATUS_BASE_IDX                                                                   0
+#define regCG_PUMP_CTRL0                                                                                0x0017
+#define regCG_PUMP_CTRL0_BASE_IDX                                                                       0
+#define regCG_PUMP_CTRL1                                                                                0x0018
+#define regCG_PUMP_CTRL1_BASE_IDX                                                                       0
+#define regCG_PUMP_CTRL2                                                                                0x0019
+#define regCG_PUMP_CTRL2_BASE_IDX                                                                       0
+#define regCG_PUMP_TACH_CTRL                                                                            0x001a
+#define regCG_PUMP_TACH_CTRL_BASE_IDX                                                                   0
+#define regCG_PUMP_TACH_STATUS                                                                          0x001b
+#define regCG_PUMP_TACH_STATUS_BASE_IDX                                                                 0
+#define regCG_PUMP_STATUS                                                                               0x001c
+#define regCG_PUMP_STATUS_BASE_IDX                                                                      0
+#define regTHM_TCON_LOCAL2                                                                              0x001d
+#define regTHM_TCON_LOCAL2_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL3                                                                              0x001e
+#define regTHM_TCON_LOCAL3_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL4                                                                              0x001f
+#define regTHM_TCON_LOCAL4_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL5                                                                              0x0020
+#define regTHM_TCON_LOCAL5_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL6                                                                              0x0021
+#define regTHM_TCON_LOCAL6_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL7                                                                              0x0022
+#define regTHM_TCON_LOCAL7_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL8                                                                              0x0023
+#define regTHM_TCON_LOCAL8_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL9                                                                              0x0024
+#define regTHM_TCON_LOCAL9_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL10                                                                             0x0025
+#define regTHM_TCON_LOCAL10_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL11                                                                             0x0026
+#define regTHM_TCON_LOCAL11_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL12                                                                             0x0027
+#define regTHM_TCON_LOCAL12_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL13                                                                             0x0028
+#define regTHM_TCON_LOCAL13_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL14                                                                             0x0029
+#define regTHM_TCON_LOCAL14_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL15                                                                             0x002a
+#define regTHM_TCON_LOCAL15_BASE_IDX                                                                    0
+#define regTHM_BACO_CNTL                                                                                0x002d
+#define regTHM_BACO_CNTL_BASE_IDX                                                                       0
+#define regTHM_BACO_TIMING0                                                                             0x002e
+#define regTHM_BACO_TIMING0_BASE_IDX                                                                    0
+#define regTHM_BACO_TIMING1                                                                             0x002f
+#define regTHM_BACO_TIMING1_BASE_IDX                                                                    0
+#define regTHM_BACO_TIMING2                                                                             0x0030
+#define regTHM_BACO_TIMING2_BASE_IDX                                                                    0
+#define regTHM_BACO_TIMING                                                                              0x0031
+#define regTHM_BACO_TIMING_BASE_IDX                                                                     0
+#define regXTAL_CNTL                                                                                    0x0032
+#define regXTAL_CNTL_BASE_IDX                                                                           0
+#define regTHM_PWRMGT                                                                                   0x0033
+#define regTHM_PWRMGT_BASE_IDX                                                                          0
+#define regSMUSBI_SBIREGADDR                                                                            0x0158
+#define regSMUSBI_SBIREGADDR_BASE_IDX                                                                   0
+#define regSMUSBI_SBIREGDATA                                                                            0x0159
+#define regSMUSBI_SBIREGDATA_BASE_IDX                                                                   0
+#define regSMUSBI_ERRATA_STAT_REG                                                                       0x015d
+#define regSMUSBI_ERRATA_STAT_REG_BASE_IDX                                                              0
+#define regSMUSBI_SBICTRL                                                                               0x015e
+#define regSMUSBI_SBICTRL_BASE_IDX                                                                      0
+#define regSMUSBI_CKNBIRESET                                                                            0x015f
+#define regSMUSBI_CKNBIRESET_BASE_IDX                                                                   0
+#define regSMUSBI_TIMING                                                                                0x0160
+#define regSMUSBI_TIMING_BASE_IDX                                                                       0
+#define regSMUSBI_HS_TIMING                                                                             0x0161
+#define regSMUSBI_HS_TIMING_BASE_IDX                                                                    0
+#define regSBTSI_REMOTE_TEMP                                                                            0x0162
+#define regSBTSI_REMOTE_TEMP_BASE_IDX                                                                   0
+#define regSBRMI_CONTROL                                                                                0x0163
+#define regSBRMI_CONTROL_BASE_IDX                                                                       0
+#define regSBRMI_COMMAND                                                                                0x0164
+#define regSBRMI_COMMAND_BASE_IDX                                                                       0
+#define regSBRMI_WRITE_DATA0                                                                            0x0166
+#define regSBRMI_WRITE_DATA0_BASE_IDX                                                                   0
+#define regSBRMI_WRITE_DATA1                                                                            0x0167
+#define regSBRMI_WRITE_DATA1_BASE_IDX                                                                   0
+#define regSBRMI_WRITE_DATA2                                                                            0x0168
+#define regSBRMI_WRITE_DATA2_BASE_IDX                                                                   0
+#define regSBRMI_READ_DATA0                                                                             0x016a
+#define regSBRMI_READ_DATA0_BASE_IDX                                                                    0
+#define regSBRMI_READ_DATA1                                                                             0x016b
+#define regSBRMI_READ_DATA1_BASE_IDX                                                                    0
+#define regSBRMI_CORE_EN_NUMBER                                                                         0x016c
+#define regSBRMI_CORE_EN_NUMBER_BASE_IDX                                                                0
+#define regSBRMI_CORE_EN_STATUS0                                                                        0x016d
+#define regSBRMI_CORE_EN_STATUS0_BASE_IDX                                                               0
+#define regSBRMI_CORE_EN_STATUS1                                                                        0x016e
+#define regSBRMI_CORE_EN_STATUS1_BASE_IDX                                                               0
+#define regSBRMI_APIC_STATUS0                                                                           0x016f
+#define regSBRMI_APIC_STATUS0_BASE_IDX                                                                  0
+#define regSBRMI_APIC_STATUS1                                                                           0x0170
+#define regSBRMI_APIC_STATUS1_BASE_IDX                                                                  0
+#define regSBRMI_MCE_STATUS0                                                                            0x0171
+#define regSBRMI_MCE_STATUS0_BASE_IDX                                                                   0
+#define regSBRMI_MCE_STATUS1                                                                            0x0172
+#define regSBRMI_MCE_STATUS1_BASE_IDX                                                                   0
+#define regSMBUS_CNTL0                                                                                  0x0173
+#define regSMBUS_CNTL0_BASE_IDX                                                                         0
+#define regSMBUS_CNTL1                                                                                  0x0174
+#define regSMBUS_CNTL1_BASE_IDX                                                                         0
+#define regSMBUS_BLKWR_CMD_CTRL0                                                                        0x0175
+#define regSMBUS_BLKWR_CMD_CTRL0_BASE_IDX                                                               0
+#define regSMBUS_BLKWR_CMD_CTRL1                                                                        0x0176
+#define regSMBUS_BLKWR_CMD_CTRL1_BASE_IDX                                                               0
+#define regSMBUS_BLKRD_CMD_CTRL0                                                                        0x0177
+#define regSMBUS_BLKRD_CMD_CTRL0_BASE_IDX                                                               0
+#define regSMBUS_BLKRD_CMD_CTRL1                                                                        0x0178
+#define regSMBUS_BLKRD_CMD_CTRL1_BASE_IDX                                                               0
+#define regSMBUS_TIMING_CNTL0                                                                           0x0179
+#define regSMBUS_TIMING_CNTL0_BASE_IDX                                                                  0
+#define regSMBUS_TIMING_CNTL1                                                                           0x017a
+#define regSMBUS_TIMING_CNTL1_BASE_IDX                                                                  0
+#define regSMBUS_TIMING_CNTL2                                                                           0x017b
+#define regSMBUS_TIMING_CNTL2_BASE_IDX                                                                  0
+#define regSMBUS_TRIGGER_CNTL                                                                           0x017c
+#define regSMBUS_TRIGGER_CNTL_BASE_IDX                                                                  0
+#define regSMBUS_UDID_CNTL0                                                                             0x017d
+#define regSMBUS_UDID_CNTL0_BASE_IDX                                                                    0
+#define regSMBUS_UDID_CNTL1                                                                             0x017e
+#define regSMBUS_UDID_CNTL1_BASE_IDX                                                                    0
+#define regSMBUS_UDID_CNTL2                                                                             0x017f
+#define regSMBUS_UDID_CNTL2_BASE_IDX                                                                    0
+#define regSMUSBI_SMBUS                                                                                 0x0180
+#define regSMUSBI_SMBUS_BASE_IDX                                                                        0
+#define regSMUSBI_ALERT                                                                                 0x0181
+#define regSMUSBI_ALERT_BASE_IDX                                                                        0
+#define regSMBUS_BACO_DUMMY                                                                             0x0182
+#define regSMBUS_BACO_DUMMY_BASE_IDX                                                                    0
+#define regSMBUS_BACO_ADDR_RANGE0_LOW                                                                   0x0183
+#define regSMBUS_BACO_ADDR_RANGE0_LOW_BASE_IDX                                                          0
+#define regSMBUS_BACO_ADDR_RANGE0_HIGH                                                                  0x0184
+#define regSMBUS_BACO_ADDR_RANGE0_HIGH_BASE_IDX                                                         0
+#define regSMBUS_BACO_ADDR_RANGE1_LOW                                                                   0x0185
+#define regSMBUS_BACO_ADDR_RANGE1_LOW_BASE_IDX                                                          0
+#define regSMBUS_BACO_ADDR_RANGE1_HIGH                                                                  0x0186
+#define regSMBUS_BACO_ADDR_RANGE1_HIGH_BASE_IDX                                                         0
+#define regSMBUS_BACO_ADDR_RANGE2_LOW                                                                   0x0187
+#define regSMBUS_BACO_ADDR_RANGE2_LOW_BASE_IDX                                                          0
+#define regSMBUS_BACO_ADDR_RANGE2_HIGH                                                                  0x0188
+#define regSMBUS_BACO_ADDR_RANGE2_HIGH_BASE_IDX                                                         0
+#define regSMBUS_BACO_ADDR_RANGE3_LOW                                                                   0x0189
+#define regSMBUS_BACO_ADDR_RANGE3_LOW_BASE_IDX                                                          0
+#define regSMBUS_BACO_ADDR_RANGE3_HIGH                                                                  0x018a
+#define regSMBUS_BACO_ADDR_RANGE3_HIGH_BASE_IDX                                                         0
+#define regSMBUS_BACO_ADDR_RANGE4_LOW                                                                   0x018b
+#define regSMBUS_BACO_ADDR_RANGE4_LOW_BASE_IDX                                                          0
+#define regSMBUS_BACO_ADDR_RANGE4_HIGH                                                                  0x018c
+#define regSMBUS_BACO_ADDR_RANGE4_HIGH_BASE_IDX                                                         0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_sh_mask.h
new file mode 100644
index 000000000000..a888afda94d4
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_14_0_2_sh_mask.h
@@ -0,0 +1,940 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#ifndef _thm_14_0_2_SH_MASK_HEADER
+#define _thm_14_0_2_SH_MASK_HEADER
+
+
+// addressBlock: thm_thm_SmuThmDec
+//THM_TCON_CUR_TMP
+#define THM_TCON_CUR_TMP__PER_STEP_TIME_UP__SHIFT                                                             0x0
+#define THM_TCON_CUR_TMP__TMP_MAX_DIFF_UP__SHIFT                                                              0x5
+#define THM_TCON_CUR_TMP__TMP_SLEW_DN_EN__SHIFT                                                               0x7
+#define THM_TCON_CUR_TMP__PER_STEP_TIME_DN__SHIFT                                                             0x8
+#define THM_TCON_CUR_TMP__REMOTE_TJ_SEL__SHIFT                                                                0xd
+#define THM_TCON_CUR_TMP__CUR_TEMP_TJ_SEL__SHIFT                                                              0x10
+#define THM_TCON_CUR_TMP__CUR_TEMP_TJ_SLEW_SEL__SHIFT                                                         0x12
+#define THM_TCON_CUR_TMP__CUR_TEMP_RANGE_SEL__SHIFT                                                           0x13
+#define THM_TCON_CUR_TMP__MCM_EN__SHIFT                                                                       0x14
+#define THM_TCON_CUR_TMP__CUR_TEMP__SHIFT                                                                     0x15
+#define THM_TCON_CUR_TMP__PER_STEP_TIME_UP_MASK                                                               0x0000001FL
+#define THM_TCON_CUR_TMP__TMP_MAX_DIFF_UP_MASK                                                                0x00000060L
+#define THM_TCON_CUR_TMP__TMP_SLEW_DN_EN_MASK                                                                 0x00000080L
+#define THM_TCON_CUR_TMP__PER_STEP_TIME_DN_MASK                                                               0x00001F00L
+#define THM_TCON_CUR_TMP__REMOTE_TJ_SEL_MASK                                                                  0x00006000L
+#define THM_TCON_CUR_TMP__CUR_TEMP_TJ_SEL_MASK                                                                0x00030000L
+#define THM_TCON_CUR_TMP__CUR_TEMP_TJ_SLEW_SEL_MASK                                                           0x00040000L
+#define THM_TCON_CUR_TMP__CUR_TEMP_RANGE_SEL_MASK                                                             0x00080000L
+#define THM_TCON_CUR_TMP__MCM_EN_MASK                                                                         0x00100000L
+#define THM_TCON_CUR_TMP__CUR_TEMP_MASK                                                                       0xFFE00000L
+//THM_TCON_HTC
+#define THM_TCON_HTC__HTC_EN__SHIFT                                                                           0x0
+#define THM_TCON_HTC__EXTERNAL_PROCHOT__SHIFT                                                                 0x2
+#define THM_TCON_HTC__INTERNAL_PROCHOT__SHIFT                                                                 0x3
+#define THM_TCON_HTC__HTC_ACTIVE__SHIFT                                                                       0x4
+#define THM_TCON_HTC__HTC_ACTIVE_LOG__SHIFT                                                                   0x5
+#define THM_TCON_HTC__HTC_DIAG__SHIFT                                                                         0x8
+#define THM_TCON_HTC__DIS_PROCHOT_PIN_OUT__SHIFT                                                              0x9
+#define THM_TCON_HTC__HTC_TO_IH_EN__SHIFT                                                                     0xa
+#define THM_TCON_HTC__PROCHOT_TO_IH_EN__SHIFT                                                                 0xb
+#define THM_TCON_HTC__PROCHOT_EVENT_SRC__SHIFT                                                                0xc
+#define THM_TCON_HTC__DIS_PROCHOT_PIN_IN__SHIFT                                                               0xf
+#define THM_TCON_HTC__HTC_TMP_LMT__SHIFT                                                                      0x10
+#define THM_TCON_HTC__HTC_HYST_LMT__SHIFT                                                                     0x17
+#define THM_TCON_HTC__HTC_SLEW_SEL__SHIFT                                                                     0x1b
+#define THM_TCON_HTC__HTC_EN_MASK                                                                             0x00000001L
+#define THM_TCON_HTC__EXTERNAL_PROCHOT_MASK                                                                   0x00000004L
+#define THM_TCON_HTC__INTERNAL_PROCHOT_MASK                                                                   0x00000008L
+#define THM_TCON_HTC__HTC_ACTIVE_MASK                                                                         0x00000010L
+#define THM_TCON_HTC__HTC_ACTIVE_LOG_MASK                                                                     0x00000020L
+#define THM_TCON_HTC__HTC_DIAG_MASK                                                                           0x00000100L
+#define THM_TCON_HTC__DIS_PROCHOT_PIN_OUT_MASK                                                                0x00000200L
+#define THM_TCON_HTC__HTC_TO_IH_EN_MASK                                                                       0x00000400L
+#define THM_TCON_HTC__PROCHOT_TO_IH_EN_MASK                                                                   0x00000800L
+#define THM_TCON_HTC__PROCHOT_EVENT_SRC_MASK                                                                  0x00007000L
+#define THM_TCON_HTC__DIS_PROCHOT_PIN_IN_MASK                                                                 0x00008000L
+#define THM_TCON_HTC__HTC_TMP_LMT_MASK                                                                        0x007F0000L
+#define THM_TCON_HTC__HTC_HYST_LMT_MASK                                                                       0x07800000L
+#define THM_TCON_HTC__HTC_SLEW_SEL_MASK                                                                       0x18000000L
+//THM_TCON_THERM_TRIP
+#define THM_TCON_THERM_TRIP__CTF_PAD_POLARITY__SHIFT                                                          0x0
+#define THM_TCON_THERM_TRIP__THERM_TP__SHIFT                                                                  0x1
+#define THM_TCON_THERM_TRIP__CTF_THRESHOLD_EXCEEDED__SHIFT                                                    0x2
+#define THM_TCON_THERM_TRIP__THERM_TP_SENSE__SHIFT                                                            0x3
+#define THM_TCON_THERM_TRIP__RSVD2__SHIFT                                                                     0x4
+#define THM_TCON_THERM_TRIP__THERM_TP_EN__SHIFT                                                               0x5
+#define THM_TCON_THERM_TRIP__THERM_TP_LMT__SHIFT                                                              0x6
+#define THM_TCON_THERM_TRIP__SW_THERM_TP__SHIFT                                                               0x1f
+#define THM_TCON_THERM_TRIP__CTF_PAD_POLARITY_MASK                                                            0x00000001L
+#define THM_TCON_THERM_TRIP__THERM_TP_MASK                                                                    0x00000002L
+#define THM_TCON_THERM_TRIP__CTF_THRESHOLD_EXCEEDED_MASK                                                      0x00000004L
+#define THM_TCON_THERM_TRIP__THERM_TP_SENSE_MASK                                                              0x00000008L
+#define THM_TCON_THERM_TRIP__RSVD2_MASK                                                                       0x00000010L
+#define THM_TCON_THERM_TRIP__THERM_TP_EN_MASK                                                                 0x00000020L
+#define THM_TCON_THERM_TRIP__THERM_TP_LMT_MASK                                                                0x00003FC0L
+#define THM_TCON_THERM_TRIP__SW_THERM_TP_MASK                                                                 0x80000000L
+//THM_CTF_DELAY
+#define THM_CTF_DELAY__CTF_DELAY_CNT__SHIFT                                                                   0x0
+#define THM_CTF_DELAY__CTF_DELAY_CNT_MASK                                                                     0x000FFFFFL
+//THM_GPIO_PROCHOT_CTRL
+#define THM_GPIO_PROCHOT_CTRL__TXIMPSEL__SHIFT                                                                0x0
+#define THM_GPIO_PROCHOT_CTRL__PD__SHIFT                                                                      0x1
+#define THM_GPIO_PROCHOT_CTRL__PU__SHIFT                                                                      0x2
+#define THM_GPIO_PROCHOT_CTRL__SCHMEN__SHIFT                                                                  0x3
+#define THM_GPIO_PROCHOT_CTRL__S0__SHIFT                                                                      0x4
+#define THM_GPIO_PROCHOT_CTRL__S1__SHIFT                                                                      0x5
+#define THM_GPIO_PROCHOT_CTRL__RXEN__SHIFT                                                                    0x6
+#define THM_GPIO_PROCHOT_CTRL__RXSEL0__SHIFT                                                                  0x7
+#define THM_GPIO_PROCHOT_CTRL__RXSEL1__SHIFT                                                                  0x8
+#define THM_GPIO_PROCHOT_CTRL__OE_OVERRIDE__SHIFT                                                             0x10
+#define THM_GPIO_PROCHOT_CTRL__OE__SHIFT                                                                      0x11
+#define THM_GPIO_PROCHOT_CTRL__A_OVERRIDE__SHIFT                                                              0x12
+#define THM_GPIO_PROCHOT_CTRL__A__SHIFT                                                                       0x13
+#define THM_GPIO_PROCHOT_CTRL__Y__SHIFT                                                                       0x1f
+#define THM_GPIO_PROCHOT_CTRL__TXIMPSEL_MASK                                                                  0x00000001L
+#define THM_GPIO_PROCHOT_CTRL__PD_MASK                                                                        0x00000002L
+#define THM_GPIO_PROCHOT_CTRL__PU_MASK                                                                        0x00000004L
+#define THM_GPIO_PROCHOT_CTRL__SCHMEN_MASK                                                                    0x00000008L
+#define THM_GPIO_PROCHOT_CTRL__S0_MASK                                                                        0x00000010L
+#define THM_GPIO_PROCHOT_CTRL__S1_MASK                                                                        0x00000020L
+#define THM_GPIO_PROCHOT_CTRL__RXEN_MASK                                                                      0x00000040L
+#define THM_GPIO_PROCHOT_CTRL__RXSEL0_MASK                                                                    0x00000080L
+#define THM_GPIO_PROCHOT_CTRL__RXSEL1_MASK                                                                    0x00000100L
+#define THM_GPIO_PROCHOT_CTRL__OE_OVERRIDE_MASK                                                               0x00010000L
+#define THM_GPIO_PROCHOT_CTRL__OE_MASK                                                                        0x00020000L
+#define THM_GPIO_PROCHOT_CTRL__A_OVERRIDE_MASK                                                                0x00040000L
+#define THM_GPIO_PROCHOT_CTRL__A_MASK                                                                         0x00080000L
+#define THM_GPIO_PROCHOT_CTRL__Y_MASK                                                                         0x80000000L
+//THM_GPIO_THERMTRIP_CTRL
+#define THM_GPIO_THERMTRIP_CTRL__TXIMPSEL__SHIFT                                                              0x0
+#define THM_GPIO_THERMTRIP_CTRL__PD__SHIFT                                                                    0x1
+#define THM_GPIO_THERMTRIP_CTRL__PU__SHIFT                                                                    0x2
+#define THM_GPIO_THERMTRIP_CTRL__SCHMEN__SHIFT                                                                0x3
+#define THM_GPIO_THERMTRIP_CTRL__S0__SHIFT                                                                    0x4
+#define THM_GPIO_THERMTRIP_CTRL__S1__SHIFT                                                                    0x5
+#define THM_GPIO_THERMTRIP_CTRL__RXEN__SHIFT                                                                  0x6
+#define THM_GPIO_THERMTRIP_CTRL__RXSEL0__SHIFT                                                                0x7
+#define THM_GPIO_THERMTRIP_CTRL__RXSEL1__SHIFT                                                                0x8
+#define THM_GPIO_THERMTRIP_CTRL__OE_OVERRIDE__SHIFT                                                           0x10
+#define THM_GPIO_THERMTRIP_CTRL__OE__SHIFT                                                                    0x11
+#define THM_GPIO_THERMTRIP_CTRL__A_OVERRIDE__SHIFT                                                            0x12
+#define THM_GPIO_THERMTRIP_CTRL__A__SHIFT                                                                     0x13
+#define THM_GPIO_THERMTRIP_CTRL__CTFEN__SHIFT                                                                 0x14
+#define THM_GPIO_THERMTRIP_CTRL__Y__SHIFT                                                                     0x1f
+#define THM_GPIO_THERMTRIP_CTRL__TXIMPSEL_MASK                                                                0x00000001L
+#define THM_GPIO_THERMTRIP_CTRL__PD_MASK                                                                      0x00000002L
+#define THM_GPIO_THERMTRIP_CTRL__PU_MASK                                                                      0x00000004L
+#define THM_GPIO_THERMTRIP_CTRL__SCHMEN_MASK                                                                  0x00000008L
+#define THM_GPIO_THERMTRIP_CTRL__S0_MASK                                                                      0x00000010L
+#define THM_GPIO_THERMTRIP_CTRL__S1_MASK                                                                      0x00000020L
+#define THM_GPIO_THERMTRIP_CTRL__RXEN_MASK                                                                    0x00000040L
+#define THM_GPIO_THERMTRIP_CTRL__RXSEL0_MASK                                                                  0x00000080L
+#define THM_GPIO_THERMTRIP_CTRL__RXSEL1_MASK                                                                  0x00000100L
+#define THM_GPIO_THERMTRIP_CTRL__OE_OVERRIDE_MASK                                                             0x00010000L
+#define THM_GPIO_THERMTRIP_CTRL__OE_MASK                                                                      0x00020000L
+#define THM_GPIO_THERMTRIP_CTRL__A_OVERRIDE_MASK                                                              0x00040000L
+#define THM_GPIO_THERMTRIP_CTRL__A_MASK                                                                       0x00080000L
+#define THM_GPIO_THERMTRIP_CTRL__CTFEN_MASK                                                                   0x00100000L
+#define THM_GPIO_THERMTRIP_CTRL__Y_MASK                                                                       0x80000000L
+//THM_GPIO_PWM_CTRL
+#define THM_GPIO_PWM_CTRL__TXIMPSEL__SHIFT                                                                    0x0
+#define THM_GPIO_PWM_CTRL__PD__SHIFT                                                                          0x1
+#define THM_GPIO_PWM_CTRL__PU__SHIFT                                                                          0x2
+#define THM_GPIO_PWM_CTRL__SCHMEN__SHIFT                                                                      0x3
+#define THM_GPIO_PWM_CTRL__S0__SHIFT                                                                          0x4
+#define THM_GPIO_PWM_CTRL__S1__SHIFT                                                                          0x5
+#define THM_GPIO_PWM_CTRL__RXEN__SHIFT                                                                        0x6
+#define THM_GPIO_PWM_CTRL__RXSEL0__SHIFT                                                                      0x7
+#define THM_GPIO_PWM_CTRL__RXSEL1__SHIFT                                                                      0x8
+#define THM_GPIO_PWM_CTRL__OE_OVERRIDE__SHIFT                                                                 0x10
+#define THM_GPIO_PWM_CTRL__OE__SHIFT                                                                          0x11
+#define THM_GPIO_PWM_CTRL__A_OVERRIDE__SHIFT                                                                  0x12
+#define THM_GPIO_PWM_CTRL__A__SHIFT                                                                           0x13
+#define THM_GPIO_PWM_CTRL__Y__SHIFT                                                                           0x1f
+#define THM_GPIO_PWM_CTRL__TXIMPSEL_MASK                                                                      0x00000001L
+#define THM_GPIO_PWM_CTRL__PD_MASK                                                                            0x00000002L
+#define THM_GPIO_PWM_CTRL__PU_MASK                                                                            0x00000004L
+#define THM_GPIO_PWM_CTRL__SCHMEN_MASK                                                                        0x00000008L
+#define THM_GPIO_PWM_CTRL__S0_MASK                                                                            0x00000010L
+#define THM_GPIO_PWM_CTRL__S1_MASK                                                                            0x00000020L
+#define THM_GPIO_PWM_CTRL__RXEN_MASK                                                                          0x00000040L
+#define THM_GPIO_PWM_CTRL__RXSEL0_MASK                                                                        0x00000080L
+#define THM_GPIO_PWM_CTRL__RXSEL1_MASK                                                                        0x00000100L
+#define THM_GPIO_PWM_CTRL__OE_OVERRIDE_MASK                                                                   0x00010000L
+#define THM_GPIO_PWM_CTRL__OE_MASK                                                                            0x00020000L
+#define THM_GPIO_PWM_CTRL__A_OVERRIDE_MASK                                                                    0x00040000L
+#define THM_GPIO_PWM_CTRL__A_MASK                                                                             0x00080000L
+#define THM_GPIO_PWM_CTRL__Y_MASK                                                                             0x80000000L
+//THM_GPIO_TACHIN_CTRL
+#define THM_GPIO_TACHIN_CTRL__TXIMPSEL__SHIFT                                                                 0x0
+#define THM_GPIO_TACHIN_CTRL__PD__SHIFT                                                                       0x1
+#define THM_GPIO_TACHIN_CTRL__PU__SHIFT                                                                       0x2
+#define THM_GPIO_TACHIN_CTRL__SCHMEN__SHIFT                                                                   0x3
+#define THM_GPIO_TACHIN_CTRL__S0__SHIFT                                                                       0x4
+#define THM_GPIO_TACHIN_CTRL__S1__SHIFT                                                                       0x5
+#define THM_GPIO_TACHIN_CTRL__RXEN__SHIFT                                                                     0x6
+#define THM_GPIO_TACHIN_CTRL__RXSEL0__SHIFT                                                                   0x7
+#define THM_GPIO_TACHIN_CTRL__RXSEL1__SHIFT                                                                   0x8
+#define THM_GPIO_TACHIN_CTRL__OE_OVERRIDE__SHIFT                                                              0x10
+#define THM_GPIO_TACHIN_CTRL__OE__SHIFT                                                                       0x11
+#define THM_GPIO_TACHIN_CTRL__A_OVERRIDE__SHIFT                                                               0x12
+#define THM_GPIO_TACHIN_CTRL__A__SHIFT                                                                        0x13
+#define THM_GPIO_TACHIN_CTRL__Y__SHIFT                                                                        0x1f
+#define THM_GPIO_TACHIN_CTRL__TXIMPSEL_MASK                                                                   0x00000001L
+#define THM_GPIO_TACHIN_CTRL__PD_MASK                                                                         0x00000002L
+#define THM_GPIO_TACHIN_CTRL__PU_MASK                                                                         0x00000004L
+#define THM_GPIO_TACHIN_CTRL__SCHMEN_MASK                                                                     0x00000008L
+#define THM_GPIO_TACHIN_CTRL__S0_MASK                                                                         0x00000010L
+#define THM_GPIO_TACHIN_CTRL__S1_MASK                                                                         0x00000020L
+#define THM_GPIO_TACHIN_CTRL__RXEN_MASK                                                                       0x00000040L
+#define THM_GPIO_TACHIN_CTRL__RXSEL0_MASK                                                                     0x00000080L
+#define THM_GPIO_TACHIN_CTRL__RXSEL1_MASK                                                                     0x00000100L
+#define THM_GPIO_TACHIN_CTRL__OE_OVERRIDE_MASK                                                                0x00010000L
+#define THM_GPIO_TACHIN_CTRL__OE_MASK                                                                         0x00020000L
+#define THM_GPIO_TACHIN_CTRL__A_OVERRIDE_MASK                                                                 0x00040000L
+#define THM_GPIO_TACHIN_CTRL__A_MASK                                                                          0x00080000L
+#define THM_GPIO_TACHIN_CTRL__Y_MASK                                                                          0x80000000L
+//THM_GPIO_PUMPOUT_CTRL
+#define THM_GPIO_PUMPOUT_CTRL__TXIMPSEL__SHIFT                                                                0x0
+#define THM_GPIO_PUMPOUT_CTRL__PD__SHIFT                                                                      0x1
+#define THM_GPIO_PUMPOUT_CTRL__PU__SHIFT                                                                      0x2
+#define THM_GPIO_PUMPOUT_CTRL__SCHMEN__SHIFT                                                                  0x3
+#define THM_GPIO_PUMPOUT_CTRL__S0__SHIFT                                                                      0x4
+#define THM_GPIO_PUMPOUT_CTRL__S1__SHIFT                                                                      0x5
+#define THM_GPIO_PUMPOUT_CTRL__RXEN__SHIFT                                                                    0x6
+#define THM_GPIO_PUMPOUT_CTRL__RXSEL0__SHIFT                                                                  0x7
+#define THM_GPIO_PUMPOUT_CTRL__RXSEL1__SHIFT                                                                  0x8
+#define THM_GPIO_PUMPOUT_CTRL__OE_OVERRIDE__SHIFT                                                             0x10
+#define THM_GPIO_PUMPOUT_CTRL__OE__SHIFT                                                                      0x11
+#define THM_GPIO_PUMPOUT_CTRL__A_OVERRIDE__SHIFT                                                              0x12
+#define THM_GPIO_PUMPOUT_CTRL__A__SHIFT                                                                       0x13
+#define THM_GPIO_PUMPOUT_CTRL__Y__SHIFT                                                                       0x1f
+#define THM_GPIO_PUMPOUT_CTRL__TXIMPSEL_MASK                                                                  0x00000001L
+#define THM_GPIO_PUMPOUT_CTRL__PD_MASK                                                                        0x00000002L
+#define THM_GPIO_PUMPOUT_CTRL__PU_MASK                                                                        0x00000004L
+#define THM_GPIO_PUMPOUT_CTRL__SCHMEN_MASK                                                                    0x00000008L
+#define THM_GPIO_PUMPOUT_CTRL__S0_MASK                                                                        0x00000010L
+#define THM_GPIO_PUMPOUT_CTRL__S1_MASK                                                                        0x00000020L
+#define THM_GPIO_PUMPOUT_CTRL__RXEN_MASK                                                                      0x00000040L
+#define THM_GPIO_PUMPOUT_CTRL__RXSEL0_MASK                                                                    0x00000080L
+#define THM_GPIO_PUMPOUT_CTRL__RXSEL1_MASK                                                                    0x00000100L
+#define THM_GPIO_PUMPOUT_CTRL__OE_OVERRIDE_MASK                                                               0x00010000L
+#define THM_GPIO_PUMPOUT_CTRL__OE_MASK                                                                        0x00020000L
+#define THM_GPIO_PUMPOUT_CTRL__A_OVERRIDE_MASK                                                                0x00040000L
+#define THM_GPIO_PUMPOUT_CTRL__A_MASK                                                                         0x00080000L
+#define THM_GPIO_PUMPOUT_CTRL__Y_MASK                                                                         0x80000000L
+//THM_GPIO_PUMPIN_CTRL
+#define THM_GPIO_PUMPIN_CTRL__TXIMPSEL__SHIFT                                                                 0x0
+#define THM_GPIO_PUMPIN_CTRL__PD__SHIFT                                                                       0x1
+#define THM_GPIO_PUMPIN_CTRL__PU__SHIFT                                                                       0x2
+#define THM_GPIO_PUMPIN_CTRL__SCHMEN__SHIFT                                                                   0x3
+#define THM_GPIO_PUMPIN_CTRL__S0__SHIFT                                                                       0x4
+#define THM_GPIO_PUMPIN_CTRL__S1__SHIFT                                                                       0x5
+#define THM_GPIO_PUMPIN_CTRL__RXEN__SHIFT                                                                     0x6
+#define THM_GPIO_PUMPIN_CTRL__RXSEL0__SHIFT                                                                   0x7
+#define THM_GPIO_PUMPIN_CTRL__RXSEL1__SHIFT                                                                   0x8
+#define THM_GPIO_PUMPIN_CTRL__OE_OVERRIDE__SHIFT                                                              0x10
+#define THM_GPIO_PUMPIN_CTRL__OE__SHIFT                                                                       0x11
+#define THM_GPIO_PUMPIN_CTRL__A_OVERRIDE__SHIFT                                                               0x12
+#define THM_GPIO_PUMPIN_CTRL__A__SHIFT                                                                        0x13
+#define THM_GPIO_PUMPIN_CTRL__Y__SHIFT                                                                        0x1f
+#define THM_GPIO_PUMPIN_CTRL__TXIMPSEL_MASK                                                                   0x00000001L
+#define THM_GPIO_PUMPIN_CTRL__PD_MASK                                                                         0x00000002L
+#define THM_GPIO_PUMPIN_CTRL__PU_MASK                                                                         0x00000004L
+#define THM_GPIO_PUMPIN_CTRL__SCHMEN_MASK                                                                     0x00000008L
+#define THM_GPIO_PUMPIN_CTRL__S0_MASK                                                                         0x00000010L
+#define THM_GPIO_PUMPIN_CTRL__S1_MASK                                                                         0x00000020L
+#define THM_GPIO_PUMPIN_CTRL__RXEN_MASK                                                                       0x00000040L
+#define THM_GPIO_PUMPIN_CTRL__RXSEL0_MASK                                                                     0x00000080L
+#define THM_GPIO_PUMPIN_CTRL__RXSEL1_MASK                                                                     0x00000100L
+#define THM_GPIO_PUMPIN_CTRL__OE_OVERRIDE_MASK                                                                0x00010000L
+#define THM_GPIO_PUMPIN_CTRL__OE_MASK                                                                         0x00020000L
+#define THM_GPIO_PUMPIN_CTRL__A_OVERRIDE_MASK                                                                 0x00040000L
+#define THM_GPIO_PUMPIN_CTRL__A_MASK                                                                          0x00080000L
+#define THM_GPIO_PUMPIN_CTRL__Y_MASK                                                                          0x80000000L
+//THM_THERMAL_INT_ENA
+#define THM_THERMAL_INT_ENA__THERM_INTH_SET__SHIFT                                                            0x0
+#define THM_THERMAL_INT_ENA__THERM_INTL_SET__SHIFT                                                            0x1
+#define THM_THERMAL_INT_ENA__THERM_TRIGGER_SET__SHIFT                                                         0x2
+#define THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT                                                            0x3
+#define THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT                                                            0x4
+#define THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT                                                         0x5
+#define THM_THERMAL_INT_ENA__THERM_INTH_SET_MASK                                                              0x00000001L
+#define THM_THERMAL_INT_ENA__THERM_INTL_SET_MASK                                                              0x00000002L
+#define THM_THERMAL_INT_ENA__THERM_TRIGGER_SET_MASK                                                           0x00000004L
+#define THM_THERMAL_INT_ENA__THERM_INTH_CLR_MASK                                                              0x00000008L
+#define THM_THERMAL_INT_ENA__THERM_INTL_CLR_MASK                                                              0x00000010L
+#define THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR_MASK                                                           0x00000020L
+//THM_THERMAL_INT_CTRL
+#define THM_THERMAL_INT_CTRL__DIG_THERM_INTH__SHIFT                                                           0x0
+#define THM_THERMAL_INT_CTRL__DIG_THERM_INTL__SHIFT                                                           0x8
+#define THM_THERMAL_INT_CTRL__TEMP_THRESHOLD__SHIFT                                                           0x10
+#define THM_THERMAL_INT_CTRL__THERM_INTH_MASK__SHIFT                                                          0x18
+#define THM_THERMAL_INT_CTRL__THERM_INTL_MASK__SHIFT                                                          0x19
+#define THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK__SHIFT                                                       0x1a
+#define THM_THERMAL_INT_CTRL__THERM_PROCHOT_MASK__SHIFT                                                       0x1b
+#define THM_THERMAL_INT_CTRL__THERM_IH_HW_ENA__SHIFT                                                          0x1c
+#define THM_THERMAL_INT_CTRL__MAX_IH_CREDIT__SHIFT                                                            0x1d
+#define THM_THERMAL_INT_CTRL__DIG_THERM_INTH_MASK                                                             0x000000FFL
+#define THM_THERMAL_INT_CTRL__DIG_THERM_INTL_MASK                                                             0x0000FF00L
+#define THM_THERMAL_INT_CTRL__TEMP_THRESHOLD_MASK                                                             0x00FF0000L
+#define THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK                                                            0x01000000L
+#define THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK                                                            0x02000000L
+#define THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK                                                         0x04000000L
+#define THM_THERMAL_INT_CTRL__THERM_PROCHOT_MASK_MASK                                                         0x08000000L
+#define THM_THERMAL_INT_CTRL__THERM_IH_HW_ENA_MASK                                                            0x10000000L
+#define THM_THERMAL_INT_CTRL__MAX_IH_CREDIT_MASK                                                              0xE0000000L
+//THM_THERMAL_INT_STATUS
+#define THM_THERMAL_INT_STATUS__THERM_INTH_DETECT__SHIFT                                                      0x0
+#define THM_THERMAL_INT_STATUS__THERM_INTL_DETECT__SHIFT                                                      0x1
+#define THM_THERMAL_INT_STATUS__THERM_TRIGGER_DETECT__SHIFT                                                   0x2
+#define THM_THERMAL_INT_STATUS__THERM_PROCHOT_DETECT__SHIFT                                                   0x3
+#define THM_THERMAL_INT_STATUS__THERM_INTH_DETECT_MASK                                                        0x00000001L
+#define THM_THERMAL_INT_STATUS__THERM_INTL_DETECT_MASK                                                        0x00000002L
+#define THM_THERMAL_INT_STATUS__THERM_TRIGGER_DETECT_MASK                                                     0x00000004L
+#define THM_THERMAL_INT_STATUS__THERM_PROCHOT_DETECT_MASK                                                     0x00000008L
+//THM_SW_TEMP
+#define THM_SW_TEMP__SW_TEMP__SHIFT                                                                           0x0
+#define THM_SW_TEMP__SW_TEMP_MASK                                                                             0x000001FFL
+//CG_MULT_THERMAL_CTRL
+#define CG_MULT_THERMAL_CTRL__TS_FILTER__SHIFT                                                                0x0
+#define CG_MULT_THERMAL_CTRL__UNUSED__SHIFT                                                                   0x4
+#define CG_MULT_THERMAL_CTRL__THERMAL_RANGE_RST__SHIFT                                                        0x9
+#define CG_MULT_THERMAL_CTRL__TEMP_SEL__SHIFT                                                                 0x14
+#define CG_MULT_THERMAL_CTRL__TS_FILTER_MASK                                                                  0x0000000FL
+#define CG_MULT_THERMAL_CTRL__UNUSED_MASK                                                                     0x000001F0L
+#define CG_MULT_THERMAL_CTRL__THERMAL_RANGE_RST_MASK                                                          0x00000200L
+#define CG_MULT_THERMAL_CTRL__TEMP_SEL_MASK                                                                   0x0FF00000L
+//CG_MULT_THERMAL_STATUS
+#define CG_MULT_THERMAL_STATUS__ASIC_MAX_TEMP__SHIFT                                                          0x0
+#define CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT                                                               0x9
+#define CG_MULT_THERMAL_STATUS__ASIC_MAX_TEMP_MASK                                                            0x000001FFL
+#define CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK                                                                 0x0003FE00L
+//CG_THERMAL_RANGE
+#define CG_THERMAL_RANGE__ASIC_T_MAX__SHIFT                                                                   0x0
+#define CG_THERMAL_RANGE__ASIC_T_MIN__SHIFT                                                                   0x10
+#define CG_THERMAL_RANGE__ASIC_T_MAX_MASK                                                                     0x000001FFL
+#define CG_THERMAL_RANGE__ASIC_T_MIN_MASK                                                                     0x01FF0000L
+//CG_FDO_CTRL0
+#define CG_FDO_CTRL0__FDO_STATIC_DUTY__SHIFT                                                                  0x0
+#define CG_FDO_CTRL0__FAN_SPINUP_DUTY__SHIFT                                                                  0x8
+#define CG_FDO_CTRL0__FDO_PWM_MANUAL__SHIFT                                                                   0x10
+#define CG_FDO_CTRL0__FDO_PWM_HYSTER__SHIFT                                                                   0x11
+#define CG_FDO_CTRL0__FDO_PWM_RAMP_EN__SHIFT                                                                  0x17
+#define CG_FDO_CTRL0__FDO_PWM_RAMP__SHIFT                                                                     0x18
+#define CG_FDO_CTRL0__FDO_STATIC_DUTY_MASK                                                                    0x000000FFL
+#define CG_FDO_CTRL0__FAN_SPINUP_DUTY_MASK                                                                    0x0000FF00L
+#define CG_FDO_CTRL0__FDO_PWM_MANUAL_MASK                                                                     0x00010000L
+#define CG_FDO_CTRL0__FDO_PWM_HYSTER_MASK                                                                     0x007E0000L
+#define CG_FDO_CTRL0__FDO_PWM_RAMP_EN_MASK                                                                    0x00800000L
+#define CG_FDO_CTRL0__FDO_PWM_RAMP_MASK                                                                       0xFF000000L
+//CG_FDO_CTRL1
+#define CG_FDO_CTRL1__FMAX_DUTY100__SHIFT                                                                     0x0
+#define CG_FDO_CTRL1__FMIN_DUTY__SHIFT                                                                        0x8
+#define CG_FDO_CTRL1__M__SHIFT                                                                                0x10
+#define CG_FDO_CTRL1__TACH_IN_MAX__SHIFT                                                                      0x18
+#define CG_FDO_CTRL1__FMAX_DUTY100_MASK                                                                       0x000000FFL
+#define CG_FDO_CTRL1__FMIN_DUTY_MASK                                                                          0x0000FF00L
+#define CG_FDO_CTRL1__M_MASK                                                                                  0x00FF0000L
+#define CG_FDO_CTRL1__TACH_IN_MAX_MASK                                                                        0xFF000000L
+//CG_FDO_CTRL2
+#define CG_FDO_CTRL2__TMIN__SHIFT                                                                             0x0
+#define CG_FDO_CTRL2__FAN_SPINUP_TIME__SHIFT                                                                  0x8
+#define CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT                                                                     0xb
+#define CG_FDO_CTRL2__TMIN_HYSTER__SHIFT                                                                      0xe
+#define CG_FDO_CTRL2__TMAX__SHIFT                                                                             0x11
+#define CG_FDO_CTRL2__TACH_PWM_RESP_RATE__SHIFT                                                               0x19
+#define CG_FDO_CTRL2__TMIN_MASK                                                                               0x000000FFL
+#define CG_FDO_CTRL2__FAN_SPINUP_TIME_MASK                                                                    0x00000700L
+#define CG_FDO_CTRL2__FDO_PWM_MODE_MASK                                                                       0x00003800L
+#define CG_FDO_CTRL2__TMIN_HYSTER_MASK                                                                        0x0001C000L
+#define CG_FDO_CTRL2__TMAX_MASK                                                                               0x01FE0000L
+#define CG_FDO_CTRL2__TACH_PWM_RESP_RATE_MASK                                                                 0xFE000000L
+//CG_TACH_CTRL
+#define CG_TACH_CTRL__EDGE_PER_REV__SHIFT                                                                     0x0
+#define CG_TACH_CTRL__TARGET_PERIOD__SHIFT                                                                    0x3
+#define CG_TACH_CTRL__EDGE_PER_REV_MASK                                                                       0x00000007L
+#define CG_TACH_CTRL__TARGET_PERIOD_MASK                                                                      0xFFFFFFF8L
+//CG_TACH_STATUS
+#define CG_TACH_STATUS__TACH_PERIOD__SHIFT                                                                    0x0
+#define CG_TACH_STATUS__TACH_PERIOD_MASK                                                                      0xFFFFFFFFL
+//CG_THERMAL_STATUS
+#define CG_THERMAL_STATUS__FDO_PWM_DUTY__SHIFT                                                                0x9
+#define CG_THERMAL_STATUS__TACH_IN_H_DEGLITCH_CNT__SHIFT                                                      0x11
+#define CG_THERMAL_STATUS__FDO_PWM_DUTY_MASK                                                                  0x0001FE00L
+#define CG_THERMAL_STATUS__TACH_IN_H_DEGLITCH_CNT_MASK                                                        0xFFFE0000L
+//CG_PUMP_CTRL0
+#define CG_PUMP_CTRL0__PUMP_STATIC_DUTY__SHIFT                                                                0x0
+#define CG_PUMP_CTRL0__PUMP_SPINUP_DUTY__SHIFT                                                                0x8
+#define CG_PUMP_CTRL0__PUMP_PWM_MANUAL__SHIFT                                                                 0x10
+#define CG_PUMP_CTRL0__PUMP_PWM_HYSTER__SHIFT                                                                 0x11
+#define CG_PUMP_CTRL0__PUMP_PWM_RAMP_EN__SHIFT                                                                0x17
+#define CG_PUMP_CTRL0__PUMP_PWM_RAMP__SHIFT                                                                   0x18
+#define CG_PUMP_CTRL0__PUMP_STATIC_DUTY_MASK                                                                  0x000000FFL
+#define CG_PUMP_CTRL0__PUMP_SPINUP_DUTY_MASK                                                                  0x0000FF00L
+#define CG_PUMP_CTRL0__PUMP_PWM_MANUAL_MASK                                                                   0x00010000L
+#define CG_PUMP_CTRL0__PUMP_PWM_HYSTER_MASK                                                                   0x007E0000L
+#define CG_PUMP_CTRL0__PUMP_PWM_RAMP_EN_MASK                                                                  0x00800000L
+#define CG_PUMP_CTRL0__PUMP_PWM_RAMP_MASK                                                                     0xFF000000L
+//CG_PUMP_CTRL1
+#define CG_PUMP_CTRL1__PMAX_DUTY100__SHIFT                                                                    0x0
+#define CG_PUMP_CTRL1__PMIN_DUTY__SHIFT                                                                       0x8
+#define CG_PUMP_CTRL1__M__SHIFT                                                                               0x10
+#define CG_PUMP_CTRL1__TACH_IN_MAX__SHIFT                                                                     0x18
+#define CG_PUMP_CTRL1__PMAX_DUTY100_MASK                                                                      0x000000FFL
+#define CG_PUMP_CTRL1__PMIN_DUTY_MASK                                                                         0x0000FF00L
+#define CG_PUMP_CTRL1__M_MASK                                                                                 0x00FF0000L
+#define CG_PUMP_CTRL1__TACH_IN_MAX_MASK                                                                       0xFF000000L
+//CG_PUMP_CTRL2
+#define CG_PUMP_CTRL2__TMIN__SHIFT                                                                            0x0
+#define CG_PUMP_CTRL2__PUMP_SPINUP_TIME__SHIFT                                                                0x8
+#define CG_PUMP_CTRL2__PUMP_PWM_MODE__SHIFT                                                                   0xb
+#define CG_PUMP_CTRL2__TMIN_HYSTER__SHIFT                                                                     0xe
+#define CG_PUMP_CTRL2__TMAX__SHIFT                                                                            0x11
+#define CG_PUMP_CTRL2__TACH_PWM_RESP_RATE__SHIFT                                                              0x19
+#define CG_PUMP_CTRL2__TMIN_MASK                                                                              0x000000FFL
+#define CG_PUMP_CTRL2__PUMP_SPINUP_TIME_MASK                                                                  0x00000700L
+#define CG_PUMP_CTRL2__PUMP_PWM_MODE_MASK                                                                     0x00003800L
+#define CG_PUMP_CTRL2__TMIN_HYSTER_MASK                                                                       0x0001C000L
+#define CG_PUMP_CTRL2__TMAX_MASK                                                                              0x01FE0000L
+#define CG_PUMP_CTRL2__TACH_PWM_RESP_RATE_MASK                                                                0xFE000000L
+//CG_PUMP_TACH_CTRL
+#define CG_PUMP_TACH_CTRL__EDGE_PER_REV__SHIFT                                                                0x0
+#define CG_PUMP_TACH_CTRL__TARGET_PERIOD__SHIFT                                                               0x3
+#define CG_PUMP_TACH_CTRL__EDGE_PER_REV_MASK                                                                  0x00000007L
+#define CG_PUMP_TACH_CTRL__TARGET_PERIOD_MASK                                                                 0xFFFFFFF8L
+//CG_PUMP_TACH_STATUS
+#define CG_PUMP_TACH_STATUS__TACH_PERIOD__SHIFT                                                               0x0
+#define CG_PUMP_TACH_STATUS__TACH_PERIOD_MASK                                                                 0xFFFFFFFFL
+//CG_PUMP_STATUS
+#define CG_PUMP_STATUS__PUMP_PWM_DUTY__SHIFT                                                                  0x9
+#define CG_PUMP_STATUS__PUMP_IN_H_DEGLITCH_CNT__SHIFT                                                         0x11
+#define CG_PUMP_STATUS__PUMP_PWM_DUTY_MASK                                                                    0x0001FE00L
+#define CG_PUMP_STATUS__PUMP_IN_H_DEGLITCH_CNT_MASK                                                           0xFFFE0000L
+//THM_TCON_LOCAL2
+#define THM_TCON_LOCAL2__TMON_init_delay__SHIFT                                                               0x0
+#define THM_TCON_LOCAL2__TMON_pwrup_stagger_time__SHIFT                                                       0x2
+#define THM_TCON_LOCAL2__short_stagger_count__SHIFT                                                           0x5
+#define THM_TCON_LOCAL2__sbtsi_use_corrected__SHIFT                                                           0x6
+#define THM_TCON_LOCAL2__temp_read_skip_scale__SHIFT                                                          0xa
+#define THM_TCON_LOCAL2__skip_scale_correction__SHIFT                                                         0xb
+#define THM_TCON_LOCAL2__use_tsen_for_temp_sel__SHIFT                                                         0xc
+#define THM_TCON_LOCAL2__use_tro_for_temp_sel__SHIFT                                                          0xd
+#define THM_TCON_LOCAL2__TMON_init_delay_MASK                                                                 0x00000003L
+#define THM_TCON_LOCAL2__TMON_pwrup_stagger_time_MASK                                                         0x0000000CL
+#define THM_TCON_LOCAL2__short_stagger_count_MASK                                                             0x00000020L
+#define THM_TCON_LOCAL2__sbtsi_use_corrected_MASK                                                             0x00000040L
+#define THM_TCON_LOCAL2__temp_read_skip_scale_MASK                                                            0x00000400L
+#define THM_TCON_LOCAL2__skip_scale_correction_MASK                                                           0x00000800L
+#define THM_TCON_LOCAL2__use_tsen_for_temp_sel_MASK                                                           0x00001000L
+#define THM_TCON_LOCAL2__use_tro_for_temp_sel_MASK                                                            0x00002000L
+//THM_TCON_LOCAL3
+#define THM_TCON_LOCAL3__Global_TMAX__SHIFT                                                                   0x0
+#define THM_TCON_LOCAL3__Global_TMAX_MASK                                                                     0x000007FFL
+//THM_TCON_LOCAL4
+#define THM_TCON_LOCAL4__Global_TMAX_ID__SHIFT                                                                0x0
+#define THM_TCON_LOCAL4__Global_TMAX_ID_MASK                                                                  0x000000FFL
+//THM_TCON_LOCAL5
+#define THM_TCON_LOCAL5__Global_TMIN__SHIFT                                                                   0x0
+#define THM_TCON_LOCAL5__Global_TMIN_MASK                                                                     0x000007FFL
+//THM_TCON_LOCAL6
+#define THM_TCON_LOCAL6__Global_TMIN_ID__SHIFT                                                                0x0
+#define THM_TCON_LOCAL6__Global_TMIN_ID_MASK                                                                  0x000000FFL
+//THM_TCON_LOCAL7
+#define THM_TCON_LOCAL7__THERMID__SHIFT                                                                       0x0
+#define THM_TCON_LOCAL7__THERMID_MASK                                                                         0x000000FFL
+//THM_TCON_LOCAL8
+#define THM_TCON_LOCAL8__THERMMAX__SHIFT                                                                      0x0
+#define THM_TCON_LOCAL8__THERMMAX_MASK                                                                        0x000007FFL
+//THM_TCON_LOCAL9
+#define THM_TCON_LOCAL9__Tj_Max_TSEN0__SHIFT                                                                  0x0
+#define THM_TCON_LOCAL9__Tj_Max_TSEN0_MASK                                                                    0x000007FFL
+//THM_TCON_LOCAL10
+#define THM_TCON_LOCAL10__TSEN0_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL10__TSEN0_Tj_Max_RS_ID_MASK                                                             0x000000FFL
+//THM_TCON_LOCAL11
+#define THM_TCON_LOCAL11__Tj_Max_TSEN1__SHIFT                                                                 0x0
+#define THM_TCON_LOCAL11__Tj_Max_TSEN1_MASK                                                                   0x000007FFL
+//THM_TCON_LOCAL12
+#define THM_TCON_LOCAL12__TSEN1_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL12__TSEN1_Tj_Max_RS_ID_MASK                                                             0x000000FFL
+//THM_TCON_LOCAL13
+#define THM_TCON_LOCAL13__boot_done__SHIFT                                                                    0x0
+#define THM_TCON_LOCAL13__boot_done_MASK                                                                      0x00000001L
+//THM_TCON_LOCAL14
+#define THM_TCON_LOCAL14__Tj_Max_TSEN2__SHIFT                                                                 0x0
+#define THM_TCON_LOCAL14__Tj_Max_TSEN2_MASK                                                                   0x000007FFL
+//THM_TCON_LOCAL15
+#define THM_TCON_LOCAL15__TSEN2_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL15__TSEN2_Tj_Max_RS_ID_MASK                                                             0x000000FFL
+//THM_BACO_CNTL
+#define THM_BACO_CNTL__BACO_MODE__SHIFT                                                                       0x0
+#define THM_BACO_CNTL__BACO_ISO_EN__SHIFT                                                                     0x1
+#define THM_BACO_CNTL__BACO_PWROKRAW_CNTL__SHIFT                                                              0x2
+#define THM_BACO_CNTL__BACO_RESET_EN__SHIFT                                                                   0x3
+#define THM_BACO_CNTL__BACO_SOC_VDCI_RESET__SHIFT                                                             0x4
+#define THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT                                                                 0x5
+#define THM_BACO_CNTL__BACO_SOC_REFCLK_OFF__SHIFT                                                             0x6
+#define THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT                                                                 0x7
+#define THM_BACO_CNTL__BACO_EXIT__SHIFT                                                                       0x8
+#define THM_BACO_CNTL__BACO_ANA_ISO_EN__SHIFT                                                                 0x9
+#define THM_BACO_CNTL__BACO_HW_EXIT_DISABLE__SHIFT                                                            0xa
+#define THM_BACO_CNTL__BACO_ROGATING__SHIFT                                                                   0xb
+#define THM_BACO_CNTL__BACO_ISO_EN_DFX__SHIFT                                                                 0xc
+#define THM_BACO_CNTL__BACO_CLK_ISO_EN__SHIFT                                                                 0xd
+#define THM_BACO_CNTL__BACO_CLK_ISO_EN_DFX__SHIFT                                                             0xe
+#define THM_BACO_CNTL__BACO_CLEAR_TEMP_DATA_EN__SHIFT                                                         0xf
+#define THM_BACO_CNTL__BACO_SCRATCH_SWITCH__SHIFT                                                             0x1d
+#define THM_BACO_CNTL__BACO_SB_AXI_FENCE__SHIFT                                                               0x1e
+#define THM_BACO_CNTL__SOC_DOMAIN_IDLE__SHIFT                                                                 0x1f
+#define THM_BACO_CNTL__BACO_MODE_MASK                                                                         0x00000001L
+#define THM_BACO_CNTL__BACO_ISO_EN_MASK                                                                       0x00000002L
+#define THM_BACO_CNTL__BACO_PWROKRAW_CNTL_MASK                                                                0x00000004L
+#define THM_BACO_CNTL__BACO_RESET_EN_MASK                                                                     0x00000008L
+#define THM_BACO_CNTL__BACO_SOC_VDCI_RESET_MASK                                                               0x00000010L
+#define THM_BACO_CNTL__BACO_SMNCLK_MUX_MASK                                                                   0x00000020L
+#define THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK                                                               0x00000040L
+#define THM_BACO_CNTL__BACO_AEB_ISO_EN_MASK                                                                   0x00000080L
+#define THM_BACO_CNTL__BACO_EXIT_MASK                                                                         0x00000100L
+#define THM_BACO_CNTL__BACO_ANA_ISO_EN_MASK                                                                   0x00000200L
+#define THM_BACO_CNTL__BACO_HW_EXIT_DISABLE_MASK                                                              0x00000400L
+#define THM_BACO_CNTL__BACO_ROGATING_MASK                                                                     0x00000800L
+#define THM_BACO_CNTL__BACO_ISO_EN_DFX_MASK                                                                   0x00001000L
+#define THM_BACO_CNTL__BACO_CLK_ISO_EN_MASK                                                                   0x00002000L
+#define THM_BACO_CNTL__BACO_CLK_ISO_EN_DFX_MASK                                                               0x00004000L
+#define THM_BACO_CNTL__BACO_CLEAR_TEMP_DATA_EN_MASK                                                           0x00008000L
+#define THM_BACO_CNTL__BACO_SCRATCH_SWITCH_MASK                                                               0x20000000L
+#define THM_BACO_CNTL__BACO_SB_AXI_FENCE_MASK                                                                 0x40000000L
+#define THM_BACO_CNTL__SOC_DOMAIN_IDLE_MASK                                                                   0x80000000L
+//THM_BACO_TIMING0
+#define THM_BACO_TIMING0__BACO_ISO_EXIT_CNT__SHIFT                                                            0x0
+#define THM_BACO_TIMING0__BACO_PWROKRAW_EXIT_CNT__SHIFT                                                       0x8
+#define THM_BACO_TIMING0__BACO_RESET_EXIT_CNT__SHIFT                                                          0x10
+#define THM_BACO_TIMING0__BACO_VDCI_RESET_EXIT_CNT__SHIFT                                                     0x18
+#define THM_BACO_TIMING0__BACO_ISO_EXIT_CNT_MASK                                                              0x000000FFL
+#define THM_BACO_TIMING0__BACO_PWROKRAW_EXIT_CNT_MASK                                                         0x0000FF00L
+#define THM_BACO_TIMING0__BACO_RESET_EXIT_CNT_MASK                                                            0x00FF0000L
+#define THM_BACO_TIMING0__BACO_VDCI_RESET_EXIT_CNT_MASK                                                       0xFF000000L
+//THM_BACO_TIMING1
+#define THM_BACO_TIMING1__BACO_SMNCLK_EXIT_CNT__SHIFT                                                         0x0
+#define THM_BACO_TIMING1__BACO_FENCE_EXIT_CNT__SHIFT                                                          0x8
+#define THM_BACO_TIMING1__BACO_REFCLK_EXIT_CNT__SHIFT                                                         0x10
+#define THM_BACO_TIMING1__BACO_MODE_EXIT_CNT__SHIFT                                                           0x18
+#define THM_BACO_TIMING1__BACO_SMNCLK_EXIT_CNT_MASK                                                           0x000000FFL
+#define THM_BACO_TIMING1__BACO_FENCE_EXIT_CNT_MASK                                                            0x0000FF00L
+#define THM_BACO_TIMING1__BACO_REFCLK_EXIT_CNT_MASK                                                           0x00FF0000L
+#define THM_BACO_TIMING1__BACO_MODE_EXIT_CNT_MASK                                                             0xFF000000L
+//THM_BACO_TIMING2
+#define THM_BACO_TIMING2__BACO_AEB_ISO_EXIT_CNT__SHIFT                                                        0x0
+#define THM_BACO_TIMING2__BACO_ANA_ISO_EXIT_CNT__SHIFT                                                        0x8
+#define THM_BACO_TIMING2__BACO_EXIT_CNT__SHIFT                                                                0x10
+#define THM_BACO_TIMING2__BACO_SOC_PWROK_OVERRIDE__SHIFT                                                      0x18
+#define THM_BACO_TIMING2__BACO_VDDP_PWROK_OVERRIDE__SHIFT                                                     0x19
+#define THM_BACO_TIMING2__BACO_AEB_ISO_EXIT_CNT_MASK                                                          0x000000FFL
+#define THM_BACO_TIMING2__BACO_ANA_ISO_EXIT_CNT_MASK                                                          0x0000FF00L
+#define THM_BACO_TIMING2__BACO_EXIT_CNT_MASK                                                                  0x00FF0000L
+#define THM_BACO_TIMING2__BACO_SOC_PWROK_OVERRIDE_MASK                                                        0x01000000L
+#define THM_BACO_TIMING2__BACO_VDDP_PWROK_OVERRIDE_MASK                                                       0x02000000L
+//THM_BACO_TIMING
+#define THM_BACO_TIMING__BACO_RESET_DELAY__SHIFT                                                              0x0
+#define THM_BACO_TIMING__BACO_RESET_DELAY_MASK                                                                0x0000FFFFL
+//XTAL_CNTL
+#define XTAL_CNTL__PCIE_REFCLK_SWITCH__SHIFT                                                                  0x0
+#define XTAL_CNTL__CORE_XTAL_CLKGEN_CLKEN__SHIFT                                                              0x4
+#define XTAL_CNTL__CORE_XTAL_PWDN__SHIFT                                                                      0x8
+#define XTAL_CNTL__OSC_GAIN_EN__SHIFT                                                                         0xc
+#define XTAL_CNTL__PCIE_REFCLK_SWITCH_MASK                                                                    0x00000001L
+#define XTAL_CNTL__CORE_XTAL_CLKGEN_CLKEN_MASK                                                                0x00000010L
+#define XTAL_CNTL__CORE_XTAL_PWDN_MASK                                                                        0x00000100L
+#define XTAL_CNTL__OSC_GAIN_EN_MASK                                                                           0x00007000L
+//THM_PWRMGT
+#define THM_PWRMGT__CLK_GATE_EN__SHIFT                                                                        0x0
+#define THM_PWRMGT__CLK_GATE_ST__SHIFT                                                                        0x1
+#define THM_PWRMGT__DBG_CLK_GATE_EN__SHIFT                                                                    0x2
+#define THM_PWRMGT__PUMP_CTL_GATE_EN__SHIFT                                                                   0x6
+#define THM_PWRMGT__FAN_CTL_GATE_EN__SHIFT                                                                    0x7
+#define THM_PWRMGT__CLK_GATE_MAX_CNT__SHIFT                                                                   0x8
+#define THM_PWRMGT__CLK_GATE_EN_MASK                                                                          0x00000001L
+#define THM_PWRMGT__CLK_GATE_ST_MASK                                                                          0x00000002L
+#define THM_PWRMGT__DBG_CLK_GATE_EN_MASK                                                                      0x00000004L
+#define THM_PWRMGT__PUMP_CTL_GATE_EN_MASK                                                                     0x00000040L
+#define THM_PWRMGT__FAN_CTL_GATE_EN_MASK                                                                      0x00000080L
+#define THM_PWRMGT__CLK_GATE_MAX_CNT_MASK                                                                     0x00FFFF00L
+#define HM_MAX_HOLD_TEMP_SHADOW_REG_ADDR__MAX_HOLD_TEMP_SHADOW_RD_IDX__SHIFT                                 0x0
+#define HM_MAX_HOLD_TEMP_SHADOW_REG_ADDR__MAX_HOLD_TEMP_SHADOW_RD_IDX_MASK                                   0x0000007FL
+//SMUSBI_SBIREGADDR
+#define SMUSBI_SBIREGADDR__Address__SHIFT                                                                     0x0
+#define SMUSBI_SBIREGADDR__TSI_RMI_SEL__SHIFT                                                                 0x8
+#define SMUSBI_SBIREGADDR__SIZE__SHIFT                                                                        0x9
+#define SMUSBI_SBIREGADDR__Address_MASK                                                                       0x000000FFL
+#define SMUSBI_SBIREGADDR__TSI_RMI_SEL_MASK                                                                   0x00000100L
+#define SMUSBI_SBIREGADDR__SIZE_MASK                                                                          0x00000600L
+//SMUSBI_SBIREGDATA
+#define SMUSBI_SBIREGDATA__SBI_REGDATA__SHIFT                                                                 0x0
+#define SMUSBI_SBIREGDATA__SBI_REGDATA_MASK                                                                   0xFFFFFFFFL
+//SMUSBI_ERRATA_STAT_REG
+#define SMUSBI_ERRATA_STAT_REG__ERRATA_STAT_REG__SHIFT                                                        0x0
+#define SMUSBI_ERRATA_STAT_REG__ERRATA_STAT_REG_MASK                                                          0xFFFFFFFFL
+//SMUSBI_SBICTRL
+#define SMUSBI_SBICTRL__CK_SPRSBIWRDONE__SHIFT                                                                0x0
+#define SMUSBI_SBICTRL__NB_SBISELECT__SHIFT                                                                   0x1
+#define SMUSBI_SBICTRL__NB_SBIADDR__SHIFT                                                                     0x2
+#define SMUSBI_SBICTRL__NB_SBIADDR_OVERRIDE__SHIFT                                                            0x5
+#define SMUSBI_SBICTRL__CK_SPRSBIWRDONE_MASK                                                                  0x00000001L
+#define SMUSBI_SBICTRL__NB_SBISELECT_MASK                                                                     0x00000002L
+#define SMUSBI_SBICTRL__NB_SBIADDR_MASK                                                                       0x0000001CL
+#define SMUSBI_SBICTRL__NB_SBIADDR_OVERRIDE_MASK                                                              0x00000020L
+//SMUSBI_CKNBIRESET
+#define SMUSBI_CKNBIRESET__CKNBIRESET__SHIFT                                                                  0x0
+#define SMUSBI_CKNBIRESET__CKNBIRESET_MASK                                                                    0x00000001L
+//SMUSBI_TIMING
+#define SMUSBI_TIMING__SETUP_TIME__SHIFT                                                                      0x0
+#define SMUSBI_TIMING__SETUP_TIME_OVERRIDE__SHIFT                                                             0x8
+#define SMUSBI_TIMING__HOLD_TIME__SHIFT                                                                       0x10
+#define SMUSBI_TIMING__HOLD_TIME_OVERRIDE__SHIFT                                                              0x18
+#define SMUSBI_TIMING__DGLT_LMT_OVERRIDE__SHIFT                                                               0x1b
+#define SMUSBI_TIMING__DGLT_LMT__SHIFT                                                                        0x1c
+#define SMUSBI_TIMING__SETUP_TIME_MASK                                                                        0x0000003FL
+#define SMUSBI_TIMING__SETUP_TIME_OVERRIDE_MASK                                                               0x00000100L
+#define SMUSBI_TIMING__HOLD_TIME_MASK                                                                         0x00FF0000L
+#define SMUSBI_TIMING__HOLD_TIME_OVERRIDE_MASK                                                                0x01000000L
+#define SMUSBI_TIMING__DGLT_LMT_OVERRIDE_MASK                                                                 0x08000000L
+#define SMUSBI_TIMING__DGLT_LMT_MASK                                                                          0xF0000000L
+//SMUSBI_HS_TIMING
+#define SMUSBI_HS_TIMING__HS_SETUP_TIME__SHIFT                                                                0x0
+#define SMUSBI_HS_TIMING__HS_SETUP_TIME_OVERRIDE__SHIFT                                                       0x8
+#define SMUSBI_HS_TIMING__HS_HOLD_TIME__SHIFT                                                                 0x10
+#define SMUSBI_HS_TIMING__HS_HOLD_TIME_OVERRIDE__SHIFT                                                        0x18
+#define SMUSBI_HS_TIMING__HS_SETUP_TIME_MASK                                                                  0x0000003FL
+#define SMUSBI_HS_TIMING__HS_SETUP_TIME_OVERRIDE_MASK                                                         0x00000100L
+#define SMUSBI_HS_TIMING__HS_HOLD_TIME_MASK                                                                   0x00FF0000L
+#define SMUSBI_HS_TIMING__HS_HOLD_TIME_OVERRIDE_MASK                                                          0x01000000L
+//SBTSI_REMOTE_TEMP
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensor__SHIFT                                                            0x0
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorId__SHIFT                                                          0xb
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorValid__SHIFT                                                       0x13
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensor_MASK                                                              0x000007FFL
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorId_MASK                                                            0x0007F800L
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorValid_MASK                                                         0x00080000L
+//SBRMI_CONTROL
+#define SBRMI_CONTROL__READ_CMD_INT_DIS__SHIFT                                                                0x0
+#define SBRMI_CONTROL__DPD__SHIFT                                                                             0x1
+#define SBRMI_CONTROL__DbrdySts__SHIFT                                                                        0x2
+#define SBRMI_CONTROL__READ_CMD_INT_DIS_MASK                                                                  0x00000001L
+#define SBRMI_CONTROL__DPD_MASK                                                                               0x00000002L
+#define SBRMI_CONTROL__DbrdySts_MASK                                                                          0x00000004L
+//SBRMI_COMMAND
+#define SBRMI_COMMAND__Command__SHIFT                                                                         0x0
+#define SBRMI_COMMAND__WrDataLen__SHIFT                                                                       0x8
+#define SBRMI_COMMAND__RdDataLen__SHIFT                                                                       0x10
+#define SBRMI_COMMAND__CommandSent__SHIFT                                                                     0x18
+#define SBRMI_COMMAND__CommandNotSupported__SHIFT                                                             0x19
+#define SBRMI_COMMAND__CommandAborted__SHIFT                                                                  0x1a
+#define SBRMI_COMMAND__Status__SHIFT                                                                          0x1c
+#define SBRMI_COMMAND__Command_MASK                                                                           0x000000FFL
+#define SBRMI_COMMAND__WrDataLen_MASK                                                                         0x0000FF00L
+#define SBRMI_COMMAND__RdDataLen_MASK                                                                         0x00FF0000L
+#define SBRMI_COMMAND__CommandSent_MASK                                                                       0x01000000L
+#define SBRMI_COMMAND__CommandNotSupported_MASK                                                               0x02000000L
+#define SBRMI_COMMAND__CommandAborted_MASK                                                                    0x04000000L
+#define SBRMI_COMMAND__Status_MASK                                                                            0xF0000000L
+//SBRMI_WRITE_DATA0
+#define SBRMI_WRITE_DATA0__WrByte0__SHIFT                                                                     0x0
+#define SBRMI_WRITE_DATA0__WrByte1__SHIFT                                                                     0x8
+#define SBRMI_WRITE_DATA0__WrByte2__SHIFT                                                                     0x10
+#define SBRMI_WRITE_DATA0__WrByte3__SHIFT                                                                     0x18
+#define SBRMI_WRITE_DATA0__WrByte0_MASK                                                                       0x000000FFL
+#define SBRMI_WRITE_DATA0__WrByte1_MASK                                                                       0x0000FF00L
+#define SBRMI_WRITE_DATA0__WrByte2_MASK                                                                       0x00FF0000L
+#define SBRMI_WRITE_DATA0__WrByte3_MASK                                                                       0xFF000000L
+//SBRMI_WRITE_DATA1
+#define SBRMI_WRITE_DATA1__WrByte4__SHIFT                                                                     0x0
+#define SBRMI_WRITE_DATA1__WrByte5__SHIFT                                                                     0x8
+#define SBRMI_WRITE_DATA1__WrByte6__SHIFT                                                                     0x10
+#define SBRMI_WRITE_DATA1__WrByte7__SHIFT                                                                     0x18
+#define SBRMI_WRITE_DATA1__WrByte4_MASK                                                                       0x000000FFL
+#define SBRMI_WRITE_DATA1__WrByte5_MASK                                                                       0x0000FF00L
+#define SBRMI_WRITE_DATA1__WrByte6_MASK                                                                       0x00FF0000L
+#define SBRMI_WRITE_DATA1__WrByte7_MASK                                                                       0xFF000000L
+//SBRMI_WRITE_DATA2
+#define SBRMI_WRITE_DATA2__WrByte8__SHIFT                                                                     0x0
+#define SBRMI_WRITE_DATA2__WrByte9__SHIFT                                                                     0x8
+#define SBRMI_WRITE_DATA2__WrByte10__SHIFT                                                                    0x10
+#define SBRMI_WRITE_DATA2__WrByte11__SHIFT                                                                    0x18
+#define SBRMI_WRITE_DATA2__WrByte8_MASK                                                                       0x000000FFL
+#define SBRMI_WRITE_DATA2__WrByte9_MASK                                                                       0x0000FF00L
+#define SBRMI_WRITE_DATA2__WrByte10_MASK                                                                      0x00FF0000L
+#define SBRMI_WRITE_DATA2__WrByte11_MASK                                                                      0xFF000000L
+//SBRMI_READ_DATA0
+#define SBRMI_READ_DATA0__RdByte0__SHIFT                                                                      0x0
+#define SBRMI_READ_DATA0__RdByte1__SHIFT                                                                      0x8
+#define SBRMI_READ_DATA0__RdByte2__SHIFT                                                                      0x10
+#define SBRMI_READ_DATA0__RdByte3__SHIFT                                                                      0x18
+#define SBRMI_READ_DATA0__RdByte0_MASK                                                                        0x000000FFL
+#define SBRMI_READ_DATA0__RdByte1_MASK                                                                        0x0000FF00L
+#define SBRMI_READ_DATA0__RdByte2_MASK                                                                        0x00FF0000L
+#define SBRMI_READ_DATA0__RdByte3_MASK                                                                        0xFF000000L
+//SBRMI_READ_DATA1
+#define SBRMI_READ_DATA1__RdByte4__SHIFT                                                                      0x0
+#define SBRMI_READ_DATA1__RdByte5__SHIFT                                                                      0x8
+#define SBRMI_READ_DATA1__RdByte6__SHIFT                                                                      0x10
+#define SBRMI_READ_DATA1__RdByte7__SHIFT                                                                      0x18
+#define SBRMI_READ_DATA1__RdByte4_MASK                                                                        0x000000FFL
+#define SBRMI_READ_DATA1__RdByte5_MASK                                                                        0x0000FF00L
+#define SBRMI_READ_DATA1__RdByte6_MASK                                                                        0x00FF0000L
+#define SBRMI_READ_DATA1__RdByte7_MASK                                                                        0xFF000000L
+//SBRMI_CORE_EN_NUMBER
+#define SBRMI_CORE_EN_NUMBER__EnabledCoreNum__SHIFT                                                           0x0
+#define SBRMI_CORE_EN_NUMBER__EnabledCoreNum_MASK                                                             0x0000007FL
+//SBRMI_CORE_EN_STATUS0
+#define SBRMI_CORE_EN_STATUS0__CoreEnStat0__SHIFT                                                             0x0
+#define SBRMI_CORE_EN_STATUS0__CoreEnStat0_MASK                                                               0xFFFFFFFFL
+//SBRMI_CORE_EN_STATUS1
+#define SBRMI_CORE_EN_STATUS1__CoreEnStat1__SHIFT                                                             0x0
+#define SBRMI_CORE_EN_STATUS1__CoreEnStat1_MASK                                                               0xFFFFFFFFL
+//SBRMI_APIC_STATUS0
+#define SBRMI_APIC_STATUS0__APICStat0__SHIFT                                                                  0x0
+#define SBRMI_APIC_STATUS0__APICStat0_MASK                                                                    0xFFFFFFFFL
+//SBRMI_APIC_STATUS1
+#define SBRMI_APIC_STATUS1__APICStat1__SHIFT                                                                  0x0
+#define SBRMI_APIC_STATUS1__APICStat1_MASK                                                                    0xFFFFFFFFL
+//SBRMI_MCE_STATUS0
+#define SBRMI_MCE_STATUS0__MceStat0__SHIFT                                                                    0x0
+#define SBRMI_MCE_STATUS0__MceStat0_MASK                                                                      0xFFFFFFFFL
+//SBRMI_MCE_STATUS1
+#define SBRMI_MCE_STATUS1__MceStat1__SHIFT                                                                    0x0
+#define SBRMI_MCE_STATUS1__MceStat1_MASK                                                                      0xFFFFFFFFL
+//SMBUS_CNTL0
+#define SMBUS_CNTL0__SMB_DEFAULT_SLV_ADDR_OVERRIDE__SHIFT                                                     0x0
+#define SMBUS_CNTL0__SMB_DEFAULT_SLV_ADDR__SHIFT                                                              0x1
+#define SMBUS_CNTL0__SMB_CPL_DUMMY_BYTE__SHIFT                                                                0x8
+#define SMBUS_CNTL0__SMB_NOTIFY_ARP_MAX_TIMES__SHIFT                                                          0x10
+#define SMBUS_CNTL0__THM_READY__SHIFT                                                                         0x14
+#define SMBUS_CNTL0__SMB_DEFAULT_SLV_ADDR_OVERRIDE_MASK                                                       0x00000001L
+#define SMBUS_CNTL0__SMB_DEFAULT_SLV_ADDR_MASK                                                                0x000000FEL
+#define SMBUS_CNTL0__SMB_CPL_DUMMY_BYTE_MASK                                                                  0x0000FF00L
+#define SMBUS_CNTL0__SMB_NOTIFY_ARP_MAX_TIMES_MASK                                                            0x00070000L
+#define SMBUS_CNTL0__THM_READY_MASK                                                                           0x00100000L
+//SMBUS_CNTL1
+#define SMBUS_CNTL1__SMB_TIMEOUT_EN__SHIFT                                                                    0x0
+#define SMBUS_CNTL1__SMB_BLK_WR_CMD_EN__SHIFT                                                                 0x1
+#define SMBUS_CNTL1__SMB_BLK_RD_CMD_EN__SHIFT                                                                 0x9
+#define SMBUS_CNTL1__SMB_TIMEOUT_EN_MASK                                                                      0x00000001L
+#define SMBUS_CNTL1__SMB_BLK_WR_CMD_EN_MASK                                                                   0x000001FEL
+#define SMBUS_CNTL1__SMB_BLK_RD_CMD_EN_MASK                                                                   0x0001FE00L
+//SMBUS_BLKWR_CMD_CTRL0
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD0__SHIFT                                                         0x0
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD1__SHIFT                                                         0x8
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD2__SHIFT                                                         0x10
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD3__SHIFT                                                         0x18
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD0_MASK                                                           0x000000FFL
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD1_MASK                                                           0x0000FF00L
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD2_MASK                                                           0x00FF0000L
+#define SMBUS_BLKWR_CMD_CTRL0__SMB_BLK_WR_CMD3_MASK                                                           0xFF000000L
+//SMBUS_BLKWR_CMD_CTRL1
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD4__SHIFT                                                         0x0
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD5__SHIFT                                                         0x8
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD6__SHIFT                                                         0x10
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD7__SHIFT                                                         0x18
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD4_MASK                                                           0x000000FFL
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD5_MASK                                                           0x0000FF00L
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD6_MASK                                                           0x00FF0000L
+#define SMBUS_BLKWR_CMD_CTRL1__SMB_BLK_WR_CMD7_MASK                                                           0xFF000000L
+//SMBUS_BLKRD_CMD_CTRL0
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD0__SHIFT                                                         0x0
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD1__SHIFT                                                         0x8
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD2__SHIFT                                                         0x10
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD3__SHIFT                                                         0x18
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD0_MASK                                                           0x000000FFL
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD1_MASK                                                           0x0000FF00L
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD2_MASK                                                           0x00FF0000L
+#define SMBUS_BLKRD_CMD_CTRL0__SMB_BLK_RD_CMD3_MASK                                                           0xFF000000L
+//SMBUS_BLKRD_CMD_CTRL1
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD4__SHIFT                                                         0x0
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD5__SHIFT                                                         0x8
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD6__SHIFT                                                         0x10
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD7__SHIFT                                                         0x18
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD4_MASK                                                           0x000000FFL
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD5_MASK                                                           0x0000FF00L
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD6_MASK                                                           0x00FF0000L
+#define SMBUS_BLKRD_CMD_CTRL1__SMB_BLK_RD_CMD7_MASK                                                           0xFF000000L
+//SMBUS_TIMING_CNTL0
+#define SMBUS_TIMING_CNTL0__SMB_TIMEOUT_MARGIN__SHIFT                                                         0x0
+#define SMBUS_TIMING_CNTL0__SMB_FILTER_LEVEL_CONVERT_MARGIN__SHIFT                                            0x16
+#define SMBUS_TIMING_CNTL0__SMB_TIMEOUT_MARGIN_MASK                                                           0x003FFFFFL
+#define SMBUS_TIMING_CNTL0__SMB_FILTER_LEVEL_CONVERT_MARGIN_MASK                                              0x3FC00000L
+//SMBUS_TIMING_CNTL1
+#define SMBUS_TIMING_CNTL1__SMB_DAT_SETUP_TIME_MARGIN__SHIFT                                                  0x0
+#define SMBUS_TIMING_CNTL1__SMB_DAT_HOLD_TIME_MARGIN__SHIFT                                                   0x5
+#define SMBUS_TIMING_CNTL1__SMB_START_AND_STOP_TIMING_MARGIN__SHIFT                                           0xb
+#define SMBUS_TIMING_CNTL1__SMB_BUS_FREE_MARGIN__SHIFT                                                        0x14
+#define SMBUS_TIMING_CNTL1__SMB_DAT_SETUP_TIME_MARGIN_MASK                                                    0x0000001FL
+#define SMBUS_TIMING_CNTL1__SMB_DAT_HOLD_TIME_MARGIN_MASK                                                     0x000007E0L
+#define SMBUS_TIMING_CNTL1__SMB_START_AND_STOP_TIMING_MARGIN_MASK                                             0x000FF800L
+#define SMBUS_TIMING_CNTL1__SMB_BUS_FREE_MARGIN_MASK                                                          0x3FF00000L
+//SMBUS_TIMING_CNTL2
+#define SMBUS_TIMING_CNTL2__SMB_SMBCLK_HIGHMAX_MARGIN__SHIFT                                                  0x0
+#define SMBUS_TIMING_CNTL2__SMBCLK_LEVEL_CTRL_MARGIN__SHIFT                                                   0xd
+#define SMBUS_TIMING_CNTL2__SMB_SMBCLK_HIGHMAX_MARGIN_MASK                                                    0x00001FFFL
+#define SMBUS_TIMING_CNTL2__SMBCLK_LEVEL_CTRL_MARGIN_MASK                                                     0x07FFE000L
+//SMBUS_TRIGGER_CNTL
+#define SMBUS_TRIGGER_CNTL__SMB_SOFT_RESET_TRIGGER__SHIFT                                                     0x0
+#define SMBUS_TRIGGER_CNTL__SMB_NOTIFY_ARP_TRIGGER__SHIFT                                                     0x8
+#define SMBUS_TRIGGER_CNTL__SMB_SOFT_RESET_TRIGGER_MASK                                                       0x00000001L
+#define SMBUS_TRIGGER_CNTL__SMB_NOTIFY_ARP_TRIGGER_MASK                                                       0x00000100L
+//SMBUS_UDID_CNTL0
+#define SMBUS_UDID_CNTL0__SMB_PRBS_INI_SEED__SHIFT                                                            0x0
+#define SMBUS_UDID_CNTL0__SMB_SRST_REGEN_UDID_EN__SHIFT                                                       0x1f
+#define SMBUS_UDID_CNTL0__SMB_PRBS_INI_SEED_MASK                                                              0x7FFFFFFFL
+#define SMBUS_UDID_CNTL0__SMB_SRST_REGEN_UDID_EN_MASK                                                         0x80000000L
+//SMBUS_UDID_CNTL1
+#define SMBUS_UDID_CNTL1__SMB_UDID_31_0__SHIFT                                                                0x0
+#define SMBUS_UDID_CNTL1__SMB_UDID_31_0_MASK                                                                  0xFFFFFFFFL
+//SMBUS_UDID_CNTL2
+#define SMBUS_UDID_CNTL2__PEC_SUPPORTED__SHIFT                                                                0x0
+#define SMBUS_UDID_CNTL2__UDID_VERSION__SHIFT                                                                 0x1
+#define SMBUS_UDID_CNTL2__SMBUS_VERSION__SHIFT                                                                0x4
+#define SMBUS_UDID_CNTL2__OEM__SHIFT                                                                          0x8
+#define SMBUS_UDID_CNTL2__ASF__SHIFT                                                                          0x9
+#define SMBUS_UDID_CNTL2__IPMI__SHIFT                                                                         0xa
+#define SMBUS_UDID_CNTL2__PEC_SUPPORTED_MASK                                                                  0x00000001L
+#define SMBUS_UDID_CNTL2__UDID_VERSION_MASK                                                                   0x0000000EL
+#define SMBUS_UDID_CNTL2__SMBUS_VERSION_MASK                                                                  0x000000F0L
+#define SMBUS_UDID_CNTL2__OEM_MASK                                                                            0x00000100L
+#define SMBUS_UDID_CNTL2__ASF_MASK                                                                            0x00000200L
+#define SMBUS_UDID_CNTL2__IPMI_MASK                                                                           0x00000400L
+//SMUSBI_SMBUS
+#define SMUSBI_SMBUS__Spare0__SHIFT                                                                           0x0
+#define SMUSBI_SMBUS__Spare1__SHIFT                                                                           0x1
+#define SMUSBI_SMBUS__ResBiasEn__SHIFT                                                                        0x2
+#define SMUSBI_SMBUS__CompSel__SHIFT                                                                          0x3
+#define SMUSBI_SMBUS__NG__SHIFT                                                                               0x4
+#define SMUSBI_SMBUS__I2cRxSel0__SHIFT                                                                        0x8
+#define SMUSBI_SMBUS__I2cRxSel1__SHIFT                                                                        0x9
+#define SMUSBI_SMBUS__PdEn0__SHIFT                                                                            0xa
+#define SMUSBI_SMBUS__PdEn1__SHIFT                                                                            0xb
+#define SMUSBI_SMBUS__FallSlewSel0__SHIFT                                                                     0xc
+#define SMUSBI_SMBUS__FallSlewSel1__SHIFT                                                                     0xd
+#define SMUSBI_SMBUS__Slewn__SHIFT                                                                            0xe
+#define SMUSBI_SMBUS__SpikeRcEn__SHIFT                                                                        0xf
+#define SMUSBI_SMBUS__SpikeRcSel__SHIFT                                                                       0x10
+#define SMUSBI_SMBUS__CSel0p9__SHIFT                                                                          0x11
+#define SMUSBI_SMBUS__CSel1p1__SHIFT                                                                          0x12
+#define SMUSBI_SMBUS__RSel0p9__SHIFT                                                                          0x13
+#define SMUSBI_SMBUS__RSel1p1__SHIFT                                                                          0x14
+#define SMUSBI_SMBUS__BiasCrtEn__SHIFT                                                                        0x15
+#define SMUSBI_SMBUS__DI2C0__SHIFT                                                                            0x16
+#define SMUSBI_SMBUS__DI2C1__SHIFT                                                                            0x17
+#define SMUSBI_SMBUS__DI2C0_OVERRIDE__SHIFT                                                                   0x18
+#define SMUSBI_SMBUS__DI2C1_OVERRIDE__SHIFT                                                                   0x19
+#define SMUSBI_SMBUS__Y0__SHIFT                                                                               0x1e
+#define SMUSBI_SMBUS__Y1__SHIFT                                                                               0x1f
+#define SMUSBI_SMBUS__Spare0_MASK                                                                             0x00000001L
+#define SMUSBI_SMBUS__Spare1_MASK                                                                             0x00000002L
+#define SMUSBI_SMBUS__ResBiasEn_MASK                                                                          0x00000004L
+#define SMUSBI_SMBUS__CompSel_MASK                                                                            0x00000008L
+#define SMUSBI_SMBUS__NG_MASK                                                                                 0x000000F0L
+#define SMUSBI_SMBUS__I2cRxSel0_MASK                                                                          0x00000100L
+#define SMUSBI_SMBUS__I2cRxSel1_MASK                                                                          0x00000200L
+#define SMUSBI_SMBUS__PdEn0_MASK                                                                              0x00000400L
+#define SMUSBI_SMBUS__PdEn1_MASK                                                                              0x00000800L
+#define SMUSBI_SMBUS__FallSlewSel0_MASK                                                                       0x00001000L
+#define SMUSBI_SMBUS__FallSlewSel1_MASK                                                                       0x00002000L
+#define SMUSBI_SMBUS__Slewn_MASK                                                                              0x00004000L
+#define SMUSBI_SMBUS__SpikeRcEn_MASK                                                                          0x00008000L
+#define SMUSBI_SMBUS__SpikeRcSel_MASK                                                                         0x00010000L
+#define SMUSBI_SMBUS__CSel0p9_MASK                                                                            0x00020000L
+#define SMUSBI_SMBUS__CSel1p1_MASK                                                                            0x00040000L
+#define SMUSBI_SMBUS__RSel0p9_MASK                                                                            0x00080000L
+#define SMUSBI_SMBUS__RSel1p1_MASK                                                                            0x00100000L
+#define SMUSBI_SMBUS__BiasCrtEn_MASK                                                                          0x00200000L
+#define SMUSBI_SMBUS__DI2C0_MASK                                                                              0x00400000L
+#define SMUSBI_SMBUS__DI2C1_MASK                                                                              0x00800000L
+#define SMUSBI_SMBUS__DI2C0_OVERRIDE_MASK                                                                     0x01000000L
+#define SMUSBI_SMBUS__DI2C1_OVERRIDE_MASK                                                                     0x02000000L
+#define SMUSBI_SMBUS__Y0_MASK                                                                                 0x40000000L
+#define SMUSBI_SMBUS__Y1_MASK                                                                                 0x80000000L
+//SMUSBI_ALERT
+#define SMUSBI_ALERT__TXIMPSEL__SHIFT                                                                         0x0
+#define SMUSBI_ALERT__PD__SHIFT                                                                               0x1
+#define SMUSBI_ALERT__PU__SHIFT                                                                               0x2
+#define SMUSBI_ALERT__SCHMEN__SHIFT                                                                           0x3
+#define SMUSBI_ALERT__S0__SHIFT                                                                               0x4
+#define SMUSBI_ALERT__S1__SHIFT                                                                               0x5
+#define SMUSBI_ALERT__RXEN__SHIFT                                                                             0x6
+#define SMUSBI_ALERT__RXSEL0__SHIFT                                                                           0x7
+#define SMUSBI_ALERT__RXSEL1__SHIFT                                                                           0x8
+#define SMUSBI_ALERT__OE_OVERRIDE__SHIFT                                                                      0x10
+#define SMUSBI_ALERT__OE__SHIFT                                                                               0x11
+#define SMUSBI_ALERT__A_OVERRIDE__SHIFT                                                                       0x12
+#define SMUSBI_ALERT__A__SHIFT                                                                                0x13
+#define SMUSBI_ALERT__Y__SHIFT                                                                                0x1f
+#define SMUSBI_ALERT__TXIMPSEL_MASK                                                                           0x00000001L
+#define SMUSBI_ALERT__PD_MASK                                                                                 0x00000002L
+#define SMUSBI_ALERT__PU_MASK                                                                                 0x00000004L
+#define SMUSBI_ALERT__SCHMEN_MASK                                                                             0x00000008L
+#define SMUSBI_ALERT__S0_MASK                                                                                 0x00000010L
+#define SMUSBI_ALERT__S1_MASK                                                                                 0x00000020L
+#define SMUSBI_ALERT__RXEN_MASK                                                                               0x00000040L
+#define SMUSBI_ALERT__RXSEL0_MASK                                                                             0x00000080L
+#define SMUSBI_ALERT__RXSEL1_MASK                                                                             0x00000100L
+#define SMUSBI_ALERT__OE_OVERRIDE_MASK                                                                        0x00010000L
+#define SMUSBI_ALERT__OE_MASK                                                                                 0x00020000L
+#define SMUSBI_ALERT__A_OVERRIDE_MASK                                                                         0x00040000L
+#define SMUSBI_ALERT__A_MASK                                                                                  0x00080000L
+#define SMUSBI_ALERT__Y_MASK                                                                                  0x80000000L
+//SMBUS_BACO_DUMMY
+#define SMBUS_BACO_DUMMY__BACO_DUMMY_DATA__SHIFT                                                              0x0
+#define SMBUS_BACO_DUMMY__BACO_DUMMY_DATA_MASK                                                                0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE0_LOW
+#define SMBUS_BACO_ADDR_RANGE0_LOW__BACO_ADDR_RANGE0_LOW__SHIFT                                               0x0
+#define SMBUS_BACO_ADDR_RANGE0_LOW__BACO_ADDR_RANGE0_LOW_MASK                                                 0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE0_HIGH
+#define SMBUS_BACO_ADDR_RANGE0_HIGH__BACO_ADDR_RANGE0_HIGH__SHIFT                                             0x0
+#define SMBUS_BACO_ADDR_RANGE0_HIGH__BACO_ADDR_RANGE0_HIGH_MASK                                               0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE1_LOW
+#define SMBUS_BACO_ADDR_RANGE1_LOW__BACO_ADDR_RANGE1_LOW__SHIFT                                               0x0
+#define SMBUS_BACO_ADDR_RANGE1_LOW__BACO_ADDR_RANGE1_LOW_MASK                                                 0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE1_HIGH
+#define SMBUS_BACO_ADDR_RANGE1_HIGH__BACO_ADDR_RANGE1_HIGH__SHIFT                                             0x0
+#define SMBUS_BACO_ADDR_RANGE1_HIGH__BACO_ADDR_RANGE1_HIGH_MASK                                               0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE2_LOW
+#define SMBUS_BACO_ADDR_RANGE2_LOW__BACO_ADDR_RANGE2_LOW__SHIFT                                               0x0
+#define SMBUS_BACO_ADDR_RANGE2_LOW__BACO_ADDR_RANGE2_LOW_MASK                                                 0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE2_HIGH
+#define SMBUS_BACO_ADDR_RANGE2_HIGH__BACO_ADDR_RANGE2_HIGH__SHIFT                                             0x0
+#define SMBUS_BACO_ADDR_RANGE2_HIGH__BACO_ADDR_RANGE2_HIGH_MASK                                               0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE3_LOW
+#define SMBUS_BACO_ADDR_RANGE3_LOW__BACO_ADDR_RANGE3_LOW__SHIFT                                               0x0
+#define SMBUS_BACO_ADDR_RANGE3_LOW__BACO_ADDR_RANGE3_LOW_MASK                                                 0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE3_HIGH
+#define SMBUS_BACO_ADDR_RANGE3_HIGH__BACO_ADDR_RANGE3_HIGH__SHIFT                                             0x0
+#define SMBUS_BACO_ADDR_RANGE3_HIGH__BACO_ADDR_RANGE3_HIGH_MASK                                               0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE4_LOW
+#define SMBUS_BACO_ADDR_RANGE4_LOW__BACO_ADDR_RANGE4_LOW__SHIFT                                               0x0
+#define SMBUS_BACO_ADDR_RANGE4_LOW__BACO_ADDR_RANGE4_LOW_MASK                                                 0xFFFFFFFFL
+//SMBUS_BACO_ADDR_RANGE4_HIGH
+#define SMBUS_BACO_ADDR_RANGE4_HIGH__BACO_ADDR_RANGE4_HIGH__SHIFT                                             0x0
+#define SMBUS_BACO_ADDR_RANGE4_HIGH__BACO_ADDR_RANGE4_HIGH_MASK                                               0xFFFFFFFFL
+
+#endif
-- 
2.34.1

