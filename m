Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB749C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A64910E3AC;
	Thu, 20 Mar 2025 16:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjfooZ6+";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE44E10E3AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPZX0H0R3BSKdTUBuecL/WCgz9f3omwfYKazyzm0umtnBnWE3q8zhcyRbSdHYdQ5fIMvNeNnv+k7X2iva7pkmI0yUaGqz+YBPt6G6P5/K4/vltLWeOQ5XO10cjdUAXRQoDRzwdnSI9pOcjJf5lGh96SDQ3gbBWoFSALO+/bDZ0xD4c7iAUianhbGo04DKlvUkrAG9eq4+H7oHQNOUNTE+Kxqy8SVq2Go9Ll2GLp28HSQkQlYIQFRBzbkt6167f9/pI0pAn0H99SrpM3nF+Vw/0LZ1t1lZsJdxHdzemC6Wwl/ZoWVQT57dWOVsayBTQ+rwI/HjNXEKMzyVtjgpTu/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k22nhLOKp9mZ6GgWUqoUJUAbQ9kKRsKVq08l+H7Y/bA=;
 b=v6d3HTv5rR+tMVlWh1gHCwCtAl2aVXZItxOnDIF3X/nq/Z1hZk8SkunfBj2ESrxIE6UDJ4Ye4AeyjT2hztVdgALJNsqC29Pj9OAh1x8ptlJUY7X2NEmdEafK13L0Fq5prFVznUyByOINGvgcNlHQpT9LZ+ihlw6g+SDschiGUcgLzyiSMT3SLL+p/xZikuBVZ8bx/6s3JVz3igKsrnGinIyweeDIQJwmQD/a9EXW60eCCVwzCxaHPDk7mryQEdlVeGJrai1et+f3z0whK7RBnNV/8L31d/bUbOu4YLTiHDw/SgPW99p3tKyXzmUiD6e86b6CxwzNCZvyX/Jo2NLdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k22nhLOKp9mZ6GgWUqoUJUAbQ9kKRsKVq08l+H7Y/bA=;
 b=sjfooZ6+whbuQLvGzUFO/54UbShVhMvq6t1W9XGg3gSBZX1LBXE9NNL53sm2JANaNdCD8FqRBwRRmXKmaakAwdNpJd9CQWEskYJYauIsMXg0SA8Dlp0BiAWznXc5eMMuhtoOCa0+aaiMId7FHMLOu05np4B2ajPjDeAsQ4YN0sQ=
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 16:56:48 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::a6) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:56:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:56:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
Date: Thu, 20 Mar 2025 12:56:30 -0400
Message-ID: <20250320165634.1245798-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d251caa-90ed-4e83-8aa8-08dd67d033fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGp5Ibq1h7Pp+ywjkXslf3i+TTib6X3Br7CYE6/+Tx/bACWMB/7qfXFJSJco?=
 =?us-ascii?Q?vmGmkyT4FxvJZv6Q3KBq/WQFlfYEGBZUQ3/K+TNDCGW2gfEudX2/WCYVpxp5?=
 =?us-ascii?Q?4/adt1b8S0IkenU3+gpEBOEOZwPFMrMWDeuKYyix7GnnM5itQw5zEtGdOp7K?=
 =?us-ascii?Q?LvxPuA+67iOpv5TkJveMu+8yInBV8Tf8yOALx/Fz6ZIgt7G0I4JTycX/2i0f?=
 =?us-ascii?Q?pvrhJnDBbB+VYzLF3T/QEy0bS0MrUz2RSyX5dOJE64w1Ms4+F59IbiGxzv0n?=
 =?us-ascii?Q?GKBy4nzkV2u6hewYT7dVNV3rC7g2YVLsOP2HMfEX0w9AqkDnWP+VD2nFmgfs?=
 =?us-ascii?Q?OV/oYZAK3YLO13RWqRcWjTPv0sQaIMGrgoxqqTMwjPEik+D39cQdnRtmeUlm?=
 =?us-ascii?Q?jjOBENFLgpy3D6GOzbWMGi1t+EbRs9VdIoFrXEMieQJacM0bzf89fzByKWqf?=
 =?us-ascii?Q?6xR3rt/9noI9A2VWP4LmOmktlWbc47YCCuZqxuEzi+bROq8/p7pvpJdZQ/zV?=
 =?us-ascii?Q?m0nxB+wM8CIQXS7+3Hz6/lNaqlwcoHCK0JkMLTWydOKv4CLJJdF5peUNQZ/t?=
 =?us-ascii?Q?3+zoyNv53bpr7ENKX1yuvmqYvCEL22I01m6pbWK5Bg4Sb+YVJLYuT4Se/OWx?=
 =?us-ascii?Q?MKjAVSWVusNP36gxj4iDGlO0iRaa9Qhh9HYr3/q7/yv2e3nGDvWQpauvm9zS?=
 =?us-ascii?Q?WWRSmWmQ+89G9d2mxSnXyJWyGbRmLKqrwwtE1f9m2X030TyxtvDpVqy8BXge?=
 =?us-ascii?Q?Eh+jKRtDk6A+EWhZx7Y9ylUfOPk+MqQZJxNWeIHT7TVpxMaBvsA3lV0vZMAQ?=
 =?us-ascii?Q?+xMLCnoZg6mClJBxHMMlqhrp3+RdFCpx4mHuw2GhfJQ6jZ4x/AbXSmhWiW8d?=
 =?us-ascii?Q?yBYQXdel7LiVrYVE0vf7MjizHdA6oH8LWU5sqRUvLC/XVXncykLtZoUnjk1l?=
 =?us-ascii?Q?ungvTRZ7llGg++U5bNpF6Tn25oO21r8cl7hGTRiBEI55UWnLiTPhafcT6Ap0?=
 =?us-ascii?Q?LsmhmawDZ9G74pYVPn8iK3ul6+7Kfa6GJ7Nw16qr1kupSV22v9EiT1vPNdfi?=
 =?us-ascii?Q?hQ2X7Xy6P9Ve1dTvfoef9roqMnCl8Hls21oPvPdAl8P2cNnLgANHr0g4OmAG?=
 =?us-ascii?Q?SbzpeN6/vGX6OXAyvflfImAi5I+JJiHweGQ5esI6/oIrbh7y1x7LLdGCmWHa?=
 =?us-ascii?Q?aAuR8XKhsZ3pU5qJLBnRmArppMGmkPe7TTqmYVetDOY76xPuPapZ6NcpdUSu?=
 =?us-ascii?Q?/Cvwyd9nDH9MYbpuXWH2Ce4MoBV0suf1yszSW6SLO0BW/yi5pwJbriNn2yEA?=
 =?us-ascii?Q?cGvn3XeHwhD2piPbBGU+Mmqh6YxjHWak1QlNazk7fgTWAvy18XTfCgWLR7Fw?=
 =?us-ascii?Q?kQtoJWqQsAuT6VNGwL+jSXu2BCoVObxdop6by11PbFkbX3u8OviEXnzSo1/j?=
 =?us-ascii?Q?h2rsMS6AL++teryKbdPTDe0QJm1+yt7EX7+JWEl+NMAfcOQwYWVg0gT3/r+9?=
 =?us-ascii?Q?lNuBVBPmpczIOME=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:47.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d251caa-90ed-4e83-8aa8-08dd67d033fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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

In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f4dfa1418b740..64342160ff7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
 	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
 	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
-	/* cp header registers */
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
 	/* SE status registers */
 	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
 	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
 	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
-	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
+	/* packet headers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
 };
 
 static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
@@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
 };
 
 enum ta_ras_gfx_subblock {
@@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
 			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
 				drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
 				for (reg = 0; reg < reg_count; reg++) {
-					drm_printf(p, "%-50s \t 0x%08x\n",
-						   gc_cp_reg_list_9[reg].reg_name,
-						   adev->gfx.ip_dump_compute_queues[index + reg]);
+					if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   "mmCP_MEC_ME2_HEADER_DUMP",
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
+					else
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   gc_cp_reg_list_9[reg].reg_name,
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
 				}
 				index += reg_count;
 			}
@@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
 				soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
 
 				for (reg = 0; reg < reg_count; reg++) {
-					adev->gfx.ip_dump_compute_queues[index + reg] =
-						RREG32(SOC15_REG_ENTRY_OFFSET(
-							gc_cp_reg_list_9[reg]));
+					if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
+					else
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_ENTRY_OFFSET(
+								       gc_cp_reg_list_9[reg]));
 				}
 				index += reg_count;
 			}
-- 
2.49.0

