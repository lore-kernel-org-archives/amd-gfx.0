Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939FACCF2D5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 20:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D37610E407;
	Mon,  5 Jan 2026 20:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2RDP4Is";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7057710E26A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwdcnV9ECRiXgh202vhPrQERcBki4NW3i9vWVNvY7Is8GXjOsnBxzDRl8Vfod9czlW6bbGJ4TBTZmbGNuQnIurtAqUrnUYWG9qrsksmEmzbL0mF37eimNqgd31iClwsuf1X7OjkP3VtAOXHdpTqdsu5h+sRJclUb4QP4JaFHFe1NZasC9ek2YstCMRRCbyuNEbqwNBYcp6zFXvIfY8GygBFDnqHGkI8NdXCKKQXCJQBjbLj/1hGoYF17+leanPKKd+rrB7jZgDZ7aEc0K/A9v3nQgEQ9/cAOnsUjEExeP/NYWpGXCcmP6B1fEECmMywC2fvSZ5/A3FRTS9nJG63K2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rbSyIn2eYse1YR6tUbI8MydxRvxMx2jzL2jxLTmBgY=;
 b=HqDzVdkFe4p5KVqzWTIRsVt14Zc/MSfn+S7EL4iU1BKEbcr7IHZx8Dg1XhVHob0J9tBJk2GmJqBerOjbZNpBRXRnN3SLuHxZUvfbxZ6dT6hpnBAeV17AJw+vVhTLD1n8vK2l3qgXv2ChozKXPRLO4wG1/oHu8K4+zG/K3GBSEtimEntSoK90RwKp04sVD7bBwN8rVBUeigzMF/IUecFGY+T2k3Fq+Kau1PUrBv576BXqYOF+niv87nTmt8MfV0lK0ZhsBL6d7rWh+Mb4bByUVA38ybBm+YOlNm2ftbqMTSf5nUe8EzbFRFTD2A1Spr0QXuyFZXIyU1EOIqi0quu2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rbSyIn2eYse1YR6tUbI8MydxRvxMx2jzL2jxLTmBgY=;
 b=O2RDP4IssrmR4yqoGhkfcDX3XvaeBjZZNpjiXAgCdcmj3MXKYyVOoQRYZOQNw0M147/rLIjVXxfPsFHff54i1Vx+iDczS+HSjwmmet/z888EBoL6YqeZ94JAX2DNvENsfZ5D8Rsf9B/oeU7dhKF9MWOP4zSPLrysk0l/ysaIRlw=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 20:13:33 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5c) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 20:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 20:13:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 14:13:31 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 5 Jan 2026 14:13:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add THM 15.0.0 headers
Date: Mon, 5 Jan 2026 15:13:15 -0500
Message-ID: <20260105201318.64865-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105201318.64865-1-alexander.deucher@amd.com>
References: <20260105201318.64865-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: f91e567d-8f1d-4731-5844-08de4c96e6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q6AFZS3rgcdroiRnwpP9TWbVTD5ECiKf7WddUWQzbqIiKIgna/74QJ4vh2XZ?=
 =?us-ascii?Q?oiosTrtm/X/O/nDBaYKjp6guapnhWG31nKSARaeN2hLdRYGkQQxh4TKzwBnR?=
 =?us-ascii?Q?ktaS4FOkaddbj6FVYz9vpO8jpaAxa4ji2gKD+7o2hNxGqY+uHgCZsMco4VQz?=
 =?us-ascii?Q?UCRsTKu6JvkTlewRyB0B9BLX4pfrmpPcswMZU3cqkVRilb90hvlSj5wOb9zP?=
 =?us-ascii?Q?mhtj1gCJIb/JAsbsQdFatdjNhWBNrk/B/DhqZN7sjjurVJEzWAlrUsR++BGA?=
 =?us-ascii?Q?cEC6nVqaEFSox42PRsUON40sCiCCRAii15pkU4Oj1peW0lMBS4ZuXfyx5bH/?=
 =?us-ascii?Q?hbf09Fe+kgo0LlpEolkjaXzJFCgjh6z5Gs/6X27fiLFU+1LkDdSOmwNmT06k?=
 =?us-ascii?Q?r9fXnhLoi0+c0VfX7kWwDF8+9UhQXr/oLsex1sMTWVgrGuYQGAw6zngH3460?=
 =?us-ascii?Q?7c4k6zqZ08QrkSWUbXWfcSkTtnY1rL+LCMtGsp+Pz7+pbvtk/CE9vx/EPh6d?=
 =?us-ascii?Q?vtA5gPGQhTQm15P9/3nw6WLqCOxyGVpS5q4sZyZCS0m1Axp6ABi4Bam5feHe?=
 =?us-ascii?Q?wpf57rlqmt40ZmPWbIwYOa+K4ACUgj0gEXUX7qX6aS70c+VSY/U2wd/Fhp4J?=
 =?us-ascii?Q?UaaJUqokr+ojdSpSgeITWk44JQuHs5rOsmw9uDM0oWbZrLyj3cP1pGcUyxQ8?=
 =?us-ascii?Q?2js3JaqQAZoA1/eZ60NOue2p5NcstEeHPV5NS3G1DOwykh8td2GcyXVK5ijd?=
 =?us-ascii?Q?pRrJY5XYcG2ApojoIutNskicaAY7t1TUMsK9OdjBLgWXhd76klKXds/mPLrZ?=
 =?us-ascii?Q?i9quH1mWMiuwQsbzJlEQbAJim7KXdz4L56w88wlxoZ4U7BKlXH9dCdFgOYwY?=
 =?us-ascii?Q?ll4SlTNm8nxF3PoooXg7VVsDTQaG/wNtGuV5IXq55I0Xp+DEpGgxbnnesrnj?=
 =?us-ascii?Q?e2no7ZykkJViDinSkhnDTTmL9xcZ6iBomwCrpU+ySraNwAUg36NP4702ZnDm?=
 =?us-ascii?Q?QdhCKSXG0XgTaQakwcIqCYg2P2DVQIVkTjUv2i7nCCXnaSTLMKO+ujA921mj?=
 =?us-ascii?Q?1qUPg7Dhf+sHsBl/x0vGxzSm+X9VzEAK2aYv0uWGNJDJc+aryiTViVlMRQKy?=
 =?us-ascii?Q?n/L8CDzDRoDiCLy1l+6LHJYw5+RC/i0THUi/Ad5PoScaRblx+LCJzk0WndFD?=
 =?us-ascii?Q?9yRDiJlMfUJDmlm4odVMe9dSbrL5h+kv8tnyaVJ1qDPIIeDKrSeLALSTdv5U?=
 =?us-ascii?Q?zVCpBmItU9w/WwYycMUDWg1EUQaYsXAii/oKnUJbpAUs+6Z09QbgW1etQ5er?=
 =?us-ascii?Q?gE0tRwHu88AS3BGoPx+36qqc/3O4nwgutga5uJpmdNlTsWBuTFL+R1C7IKvj?=
 =?us-ascii?Q?JzMsNQ+MpqEFsrq92Z3C1lBkpBZt98As27gyqQVp0bJHZk28LeRJn6AnCtiB?=
 =?us-ascii?Q?U3XDUSoM0FFhLk7UEakHKtk3hBOpVlobtn5wmgn215KNB5liMBVph6B8rmLk?=
 =?us-ascii?Q?rTxJCNN3mX9x2n92KtE0o+8m2qFnH+iIPol0O+nUETxR+tt+waHIOJ4miKhb?=
 =?us-ascii?Q?Vj9A5jHglMguk0i8tBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:13:33.5807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91e567d-8f1d-4731-5844-08de4c96e6fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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

Add headers for THM 15.0.0.

v2: squash in updates (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/thm/thm_15_0_0_offset.h  | 157 +++++
 .../include/asic_reg/thm/thm_15_0_0_sh_mask.h | 567 ++++++++++++++++++
 2 files changed, 724 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_offset.h
new file mode 100644
index 0000000000000..187390b8003cb
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_offset.h
@@ -0,0 +1,157 @@
+/*
+ * Copyright (C) 2025  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _thm_15_0_0_OFFSET_HEADER
+#define _thm_15_0_0_OFFSET_HEADER
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
+#define regTHM_CTF_DELAY                                                                                0x0004
+#define regTHM_CTF_DELAY_BASE_IDX                                                                       0
+#define regTHM_GPIO_PROCHOT_CTRL                                                                        0x0005
+#define regTHM_GPIO_PROCHOT_CTRL_BASE_IDX                                                               0
+#define regTHM_SW_TEMP                                                                                  0x0006
+#define regTHM_SW_TEMP_BASE_IDX                                                                         0
+#define regCG_MULT_THERMAL_CTRL                                                                         0x0007
+#define regCG_MULT_THERMAL_CTRL_BASE_IDX                                                                0
+#define regCG_MULT_THERMAL_STATUS                                                                       0x0008
+#define regCG_MULT_THERMAL_STATUS_BASE_IDX                                                              0
+#define regCG_THERMAL_RANGE                                                                             0x0009
+#define regCG_THERMAL_RANGE_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL2                                                                              0x000a
+#define regTHM_TCON_LOCAL2_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL3                                                                              0x000b
+#define regTHM_TCON_LOCAL3_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL4                                                                              0x000c
+#define regTHM_TCON_LOCAL4_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL5                                                                              0x000d
+#define regTHM_TCON_LOCAL5_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL6                                                                              0x000e
+#define regTHM_TCON_LOCAL6_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL7                                                                              0x000f
+#define regTHM_TCON_LOCAL7_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL8                                                                              0x0010
+#define regTHM_TCON_LOCAL8_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL9                                                                              0x0011
+#define regTHM_TCON_LOCAL9_BASE_IDX                                                                     0
+#define regTHM_TCON_LOCAL10                                                                             0x0012
+#define regTHM_TCON_LOCAL10_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL11                                                                             0x0013
+#define regTHM_TCON_LOCAL11_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL12                                                                             0x0014
+#define regTHM_TCON_LOCAL12_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL13                                                                             0x0015
+#define regTHM_TCON_LOCAL13_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL14                                                                             0x0016
+#define regTHM_TCON_LOCAL14_BASE_IDX                                                                    0
+#define regTHM_TCON_LOCAL15                                                                             0x0017
+#define regTHM_TCON_LOCAL15_BASE_IDX                                                                    0
+#define regTHM_PWRMGT                                                                                   0x001b
+#define regTHM_PWRMGT_BASE_IDX                                                                          0
+#define regTHM_DIE1_TEMP                                                                                0x001c
+#define regTHM_DIE1_TEMP_BASE_IDX                                                                       0
+#define regTHM_DIE2_TEMP                                                                                0x001d
+#define regTHM_DIE2_TEMP_BASE_IDX                                                                       0
+#define regTHM_DIE3_TEMP                                                                                0x001e
+#define regTHM_DIE3_TEMP_BASE_IDX                                                                       0
+#define regSMUSBI_SBIREGADDR                                                                            0x0124
+#define regSMUSBI_SBIREGADDR_BASE_IDX                                                                   0
+#define regSMUSBI_SBIREGDATA                                                                            0x0125
+#define regSMUSBI_SBIREGDATA_BASE_IDX                                                                   0
+#define regSMUSBI_ERRATA_STAT_REG                                                                       0x0129
+#define regSMUSBI_ERRATA_STAT_REG_BASE_IDX                                                              0
+#define regSMUSBI_SBICTRL                                                                               0x012a
+#define regSMUSBI_SBICTRL_BASE_IDX                                                                      0
+#define regSMUSBI_CKNBIRESET                                                                            0x012b
+#define regSMUSBI_CKNBIRESET_BASE_IDX                                                                   0
+#define regSMUSBI_TIMING                                                                                0x012c
+#define regSMUSBI_TIMING_BASE_IDX                                                                       0
+#define regSMUSBI_HS_TIMING                                                                             0x012d
+#define regSMUSBI_HS_TIMING_BASE_IDX                                                                    0
+#define regSBTSI_REMOTE_TEMP                                                                            0x012e
+#define regSBTSI_REMOTE_TEMP_BASE_IDX                                                                   0
+#define regSBRMI_CONTROL                                                                                0x012f
+#define regSBRMI_CONTROL_BASE_IDX                                                                       0
+#define regSBRMI_COMMAND                                                                                0x0130
+#define regSBRMI_COMMAND_BASE_IDX                                                                       0
+#define regSBRMI_WRITE_DATA0                                                                            0x0132
+#define regSBRMI_WRITE_DATA0_BASE_IDX                                                                   0
+#define regSBRMI_WRITE_DATA1                                                                            0x0133
+#define regSBRMI_WRITE_DATA1_BASE_IDX                                                                   0
+#define regSBRMI_WRITE_DATA2                                                                            0x0134
+#define regSBRMI_WRITE_DATA2_BASE_IDX                                                                   0
+#define regSBRMI_READ_DATA0                                                                             0x0136
+#define regSBRMI_READ_DATA0_BASE_IDX                                                                    0
+#define regSBRMI_READ_DATA1                                                                             0x0137
+#define regSBRMI_READ_DATA1_BASE_IDX                                                                    0
+#define regSBRMI_CORE_EN_NUMBER                                                                         0x0138
+#define regSBRMI_CORE_EN_NUMBER_BASE_IDX                                                                0
+#define regSBRMI_CORE_EN_STATUS0                                                                        0x0139
+#define regSBRMI_CORE_EN_STATUS0_BASE_IDX                                                               0
+#define regSBRMI_CORE_EN_STATUS1                                                                        0x013a
+#define regSBRMI_CORE_EN_STATUS1_BASE_IDX                                                               0
+#define regSBRMI_APIC_STATUS0                                                                           0x013b
+#define regSBRMI_APIC_STATUS0_BASE_IDX                                                                  0
+#define regSBRMI_APIC_STATUS1                                                                           0x013c
+#define regSBRMI_APIC_STATUS1_BASE_IDX                                                                  0
+#define regSBRMI_MCE_STATUS0                                                                            0x013d
+#define regSBRMI_MCE_STATUS0_BASE_IDX                                                                   0
+#define regSBRMI_MCE_STATUS1                                                                            0x013e
+#define regSBRMI_MCE_STATUS1_BASE_IDX                                                                   0
+#define regSMBUS_CNTL0                                                                                  0x013f
+#define regSMBUS_CNTL0_BASE_IDX                                                                         0
+#define regSMBUS_CNTL1                                                                                  0x0140
+#define regSMBUS_CNTL1_BASE_IDX                                                                         0
+#define regSMBUS_BLKWR_CMD_CTRL0                                                                        0x0141
+#define regSMBUS_BLKWR_CMD_CTRL0_BASE_IDX                                                               0
+#define regSMBUS_BLKWR_CMD_CTRL1                                                                        0x0142
+#define regSMBUS_BLKWR_CMD_CTRL1_BASE_IDX                                                               0
+#define regSMBUS_BLKRD_CMD_CTRL0                                                                        0x0143
+#define regSMBUS_BLKRD_CMD_CTRL0_BASE_IDX                                                               0
+#define regSMBUS_BLKRD_CMD_CTRL1                                                                        0x0144
+#define regSMBUS_BLKRD_CMD_CTRL1_BASE_IDX                                                               0
+#define regSMBUS_TIMING_CNTL0                                                                           0x0145
+#define regSMBUS_TIMING_CNTL0_BASE_IDX                                                                  0
+#define regSMBUS_TIMING_CNTL1                                                                           0x0146
+#define regSMBUS_TIMING_CNTL1_BASE_IDX                                                                  0
+#define regSMBUS_TIMING_CNTL2                                                                           0x0147
+#define regSMBUS_TIMING_CNTL2_BASE_IDX                                                                  0
+#define regSMBUS_TRIGGER_CNTL                                                                           0x0148
+#define regSMBUS_TRIGGER_CNTL_BASE_IDX                                                                  0
+#define regSMBUS_UDID_CNTL0                                                                             0x0149
+#define regSMBUS_UDID_CNTL0_BASE_IDX                                                                    0
+#define regSMBUS_UDID_CNTL1                                                                             0x014a
+#define regSMBUS_UDID_CNTL1_BASE_IDX                                                                    0
+#define regSMBUS_UDID_CNTL2                                                                             0x014b
+#define regSMBUS_UDID_CNTL2_BASE_IDX                                                                    0
+#define regSMUSBI_SMBUS                                                                                 0x014c
+#define regSMUSBI_SMBUS_BASE_IDX                                                                        0
+#define regSMUSBI_ALERT                                                                                 0x014d
+#define regSMUSBI_ALERT_BASE_IDX                                                                        0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_sh_mask.h
new file mode 100644
index 0000000000000..365eab646df72
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_15_0_0_sh_mask.h
@@ -0,0 +1,567 @@
+/*
+ * Copyright (C) 2025  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _thm_15_0_0_SH_MASK_HEADER
+#define _thm_15_0_0_SH_MASK_HEADER
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
+#define THM_TCON_THERM_TRIP__THERM_TP_EN__SHIFT                                                               0x5
+#define THM_TCON_THERM_TRIP__THERM_TP_LMT__SHIFT                                                              0x6
+#define THM_TCON_THERM_TRIP__FCH_THERMTRIP_EN__SHIFT                                                          0xe
+#define THM_TCON_THERM_TRIP__FCH_THERMTRIP_STATUS__SHIFT                                                      0xf
+#define THM_TCON_THERM_TRIP__TSV_THERMTRIP_IN__SHIFT                                                          0x10
+#define THM_TCON_THERM_TRIP__THERM_TP_LOCAL_SENSE__SHIFT                                                      0x1d
+#define THM_TCON_THERM_TRIP__THERM_TP_LOCAL__SHIFT                                                            0x1e
+#define THM_TCON_THERM_TRIP__SW_THERM_TP__SHIFT                                                               0x1f
+#define THM_TCON_THERM_TRIP__CTF_PAD_POLARITY_MASK                                                            0x00000001L
+#define THM_TCON_THERM_TRIP__THERM_TP_MASK                                                                    0x00000002L
+#define THM_TCON_THERM_TRIP__CTF_THRESHOLD_EXCEEDED_MASK                                                      0x00000004L
+#define THM_TCON_THERM_TRIP__THERM_TP_SENSE_MASK                                                              0x00000008L
+#define THM_TCON_THERM_TRIP__THERM_TP_EN_MASK                                                                 0x00000020L
+#define THM_TCON_THERM_TRIP__THERM_TP_LMT_MASK                                                                0x00003FC0L
+#define THM_TCON_THERM_TRIP__FCH_THERMTRIP_EN_MASK                                                            0x00004000L
+#define THM_TCON_THERM_TRIP__FCH_THERMTRIP_STATUS_MASK                                                        0x00008000L
+#define THM_TCON_THERM_TRIP__TSV_THERMTRIP_IN_MASK                                                            0x0FFF0000L
+#define THM_TCON_THERM_TRIP__THERM_TP_LOCAL_SENSE_MASK                                                        0x20000000L
+#define THM_TCON_THERM_TRIP__THERM_TP_LOCAL_MASK                                                              0x40000000L
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
+#define THM_GPIO_PROCHOT_CTRL__S2__SHIFT                                                                      0x9
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
+#define THM_GPIO_PROCHOT_CTRL__S2_MASK                                                                        0x00000200L
+#define THM_GPIO_PROCHOT_CTRL__OE_OVERRIDE_MASK                                                               0x00010000L
+#define THM_GPIO_PROCHOT_CTRL__OE_MASK                                                                        0x00020000L
+#define THM_GPIO_PROCHOT_CTRL__A_OVERRIDE_MASK                                                                0x00040000L
+#define THM_GPIO_PROCHOT_CTRL__A_MASK                                                                         0x00080000L
+#define THM_GPIO_PROCHOT_CTRL__Y_MASK                                                                         0x80000000L
+//THM_SW_TEMP
+#define THM_SW_TEMP__SW_TEMP__SHIFT                                                                           0x0
+#define THM_SW_TEMP__SW_TEMP_MASK                                                                             0x000001FFL
+//CG_MULT_THERMAL_CTRL
+#define CG_MULT_THERMAL_CTRL__UNUSED__SHIFT                                                                   0x4
+#define CG_MULT_THERMAL_CTRL__THERMAL_RANGE_RST__SHIFT                                                        0x9
+#define CG_MULT_THERMAL_CTRL__TEMP_SEL__SHIFT                                                                 0x14
+#define CG_MULT_THERMAL_CTRL__UNUSED_MASK                                                                     0x000001F0L
+#define CG_MULT_THERMAL_CTRL__THERMAL_RANGE_RST_MASK                                                          0x00000200L
+#define CG_MULT_THERMAL_CTRL__TEMP_SEL_MASK                                                                   0x3FF00000L
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
+#define THM_TCON_LOCAL4__Global_TMAX_ID_MASK                                                                  0x000001FFL
+//THM_TCON_LOCAL5
+#define THM_TCON_LOCAL5__Global_TMIN__SHIFT                                                                   0x0
+#define THM_TCON_LOCAL5__Global_TMIN_MASK                                                                     0x000007FFL
+//THM_TCON_LOCAL6
+#define THM_TCON_LOCAL6__Global_TMIN_ID__SHIFT                                                                0x0
+#define THM_TCON_LOCAL6__Global_TMIN_ID_MASK                                                                  0x000001FFL
+//THM_TCON_LOCAL7
+#define THM_TCON_LOCAL7__THERMID__SHIFT                                                                       0x0
+#define THM_TCON_LOCAL7__THERMID_MASK                                                                         0x000001FFL
+//THM_TCON_LOCAL8
+#define THM_TCON_LOCAL8__THERMMAX__SHIFT                                                                      0x0
+#define THM_TCON_LOCAL8__THERMMAX_MASK                                                                        0x000007FFL
+//THM_TCON_LOCAL9
+#define THM_TCON_LOCAL9__Tj_Max_TSEN0__SHIFT                                                                  0x0
+#define THM_TCON_LOCAL9__Tj_Max_TSEN0_MASK                                                                    0x000007FFL
+//THM_TCON_LOCAL10
+#define THM_TCON_LOCAL10__TSEN0_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL10__TSEN0_Tj_Max_RS_ID_MASK                                                             0x000001FFL
+//THM_TCON_LOCAL11
+#define THM_TCON_LOCAL11__Tj_Max_TSEN1__SHIFT                                                                 0x0
+#define THM_TCON_LOCAL11__Tj_Max_TSEN1_MASK                                                                   0x000007FFL
+//THM_TCON_LOCAL12
+#define THM_TCON_LOCAL12__TSEN1_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL12__TSEN1_Tj_Max_RS_ID_MASK                                                             0x000001FFL
+//THM_TCON_LOCAL13
+#define THM_TCON_LOCAL13__boot_done__SHIFT                                                                    0x0
+#define THM_TCON_LOCAL13__boot_done_MASK                                                                      0x00000001L
+//THM_TCON_LOCAL14
+#define THM_TCON_LOCAL14__Tj_Max_TSEN2__SHIFT                                                                 0x0
+#define THM_TCON_LOCAL14__Tj_Max_TSEN2_MASK                                                                   0x000007FFL
+//THM_TCON_LOCAL15
+#define THM_TCON_LOCAL15__TSEN2_Tj_Max_RS_ID__SHIFT                                                           0x0
+#define THM_TCON_LOCAL15__TSEN2_Tj_Max_RS_ID_MASK                                                             0x000001FFL
+//THM_PWRMGT
+#define THM_PWRMGT__CLK_GATE_EN__SHIFT                                                                        0x0
+#define THM_PWRMGT__CLK_GATE_ST__SHIFT                                                                        0x1
+#define THM_PWRMGT__DBG_CLK_GATE_EN__SHIFT                                                                    0x2
+#define THM_PWRMGT__CLK_GATE_MAX_CNT__SHIFT                                                                   0x8
+#define THM_PWRMGT__CLK_GATE_EN_MASK                                                                          0x00000001L
+#define THM_PWRMGT__CLK_GATE_ST_MASK                                                                          0x00000002L
+#define THM_PWRMGT__DBG_CLK_GATE_EN_MASK                                                                      0x00000004L
+#define THM_PWRMGT__CLK_GATE_MAX_CNT_MASK                                                                     0x00FFFF00L
+//THM_DIE1_TEMP
+#define THM_DIE1_TEMP__TEMP__SHIFT                                                                            0x0
+#define THM_DIE1_TEMP__VALID__SHIFT                                                                           0xb
+#define THM_DIE1_TEMP__TEMP_MASK                                                                              0x000007FFL
+#define THM_DIE1_TEMP__VALID_MASK                                                                             0x00000800L
+//THM_DIE2_TEMP
+#define THM_DIE2_TEMP__TEMP__SHIFT                                                                            0x0
+#define THM_DIE2_TEMP__VALID__SHIFT                                                                           0xb
+#define THM_DIE2_TEMP__TEMP_MASK                                                                              0x000007FFL
+#define THM_DIE2_TEMP__VALID_MASK                                                                             0x00000800L
+//THM_DIE3_TEMP
+#define THM_DIE3_TEMP__TEMP__SHIFT                                                                            0x0
+#define THM_DIE3_TEMP__VALID__SHIFT                                                                           0xb
+#define THM_DIE3_TEMP__TEMP_MASK                                                                              0x000007FFL
+#define THM_DIE3_TEMP__VALID_MASK                                                                             0x00000800L
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
+#define SMUSBI_SBICTRL__REMOTE_SBI_EN__SHIFT                                                                  0x6
+#define SMUSBI_SBICTRL__NB_SBIADDR_EXTEND__SHIFT                                                              0x7
+#define SMUSBI_SBICTRL__CK_SPRSBIWRDONE_MASK                                                                  0x00000001L
+#define SMUSBI_SBICTRL__NB_SBISELECT_MASK                                                                     0x00000002L
+#define SMUSBI_SBICTRL__NB_SBIADDR_MASK                                                                       0x0000001CL
+#define SMUSBI_SBICTRL__NB_SBIADDR_OVERRIDE_MASK                                                              0x00000020L
+#define SMUSBI_SBICTRL__REMOTE_SBI_EN_MASK                                                                    0x00000040L
+#define SMUSBI_SBICTRL__NB_SBIADDR_EXTEND_MASK                                                                0x00000080L
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
+#define SBTSI_REMOTE_TEMP__UNUSED__SHIFT                                                                      0x12
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorValid__SHIFT                                                       0x13
+#define SBTSI_REMOTE_TEMP__RemoteTcenQuadId__SHIFT                                                            0x14
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensor_MASK                                                              0x000007FFL
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorId_MASK                                                            0x0003F800L
+#define SBTSI_REMOTE_TEMP__UNUSED_MASK                                                                        0x00040000L
+#define SBTSI_REMOTE_TEMP__RemoteTcenSensorValid_MASK                                                         0x00080000L
+#define SBTSI_REMOTE_TEMP__RemoteTcenQuadId_MASK                                                              0x00300000L
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
+#define SMUSBI_ALERT__S2__SHIFT                                                                               0x9
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
+#define SMUSBI_ALERT__S2_MASK                                                                                 0x00000200L
+#define SMUSBI_ALERT__OE_OVERRIDE_MASK                                                                        0x00010000L
+#define SMUSBI_ALERT__OE_MASK                                                                                 0x00020000L
+#define SMUSBI_ALERT__A_OVERRIDE_MASK                                                                         0x00040000L
+#define SMUSBI_ALERT__A_MASK                                                                                  0x00080000L
+#define SMUSBI_ALERT__Y_MASK                                                                                  0x80000000L
+
+#endif
-- 
2.52.0

