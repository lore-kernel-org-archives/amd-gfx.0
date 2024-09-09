Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA5ECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 09:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DE110E346;
	Mon,  9 Sep 2024 09:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49EiCzyb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8227E10E34A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7CAf7wg3hZxOQLofV0nXy0Tv3uQX8miWB1rQI9GG+qLijpUE2sanm7PZaKdf7JxWcY0HM4JPbRXPehuqEcloFQ30gglLP2DYPIz3c/YwfPMXofiDkRrt3rJrOmBMPgkm8IA+O7rRAw02wislXvyv0XJDwL4itBcYHg1kFv78z55wsRB4uH1CFwqq/uoUoP29eP24pQlMmSFm6NEaf3BNq7kUURMPNqz0pMwdhAn74ft4U3xKPYkws+R2FtE8AMGfzwoaGFvCYvFjK0AAAYtAvo/t9OdzdbSzo/q6/6OZeIlt6JQwxusNDVZSImE295vraDUfV3G85C1dRa3BP07dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDZkNAMPNuNqg+IEn8ImQ9J1pzQJ7Yw9Qkv65PuyqoM=;
 b=CihHIGSniRXydwhzENNbRnhtSSZMFCiA/l804jAfV5LjwI1bAQXlyGAvxeCsW1sRVmJ450sZwgHSgyWQyXhh8PRNW4yIpBoNU8b8blyg5W3A1e4YkdPWNGVhtQQfkT9pEF0n7e8EQE9ZhXyoGyBq5e+K81W1bPgVJIXOhu8DNKkzEd2AVZFCd5888Tt5UehbYI30IX4UWvKstNUJzmOTbJ8tycanbvFRSnLpbl5Ix7x1eshL+JixB1TW9Fu9PUz81UCfjz+IVcnNoZu6tJvhEPC35zyiRXzVqdEHqCn+l8v7eHRID1cRqeDWI+S5wn4p7n8+lEOsw37Aq3pGiRxJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDZkNAMPNuNqg+IEn8ImQ9J1pzQJ7Yw9Qkv65PuyqoM=;
 b=49EiCzybYTzpUMvNmhJsUvlOR0H1tS9QLvhZKHlSjzfpTZQaCLrcvUlQ/i8YtLsgsMSqwTeukeZ9CRq6rkELByl423X+JkB+jexQpYD0Mc2cVh3VTtQ2WKEX5RRSARtyjB2v0cZRHUf3f9xlhYFSNrN8hE04jdyrpFkA+l/j2ts=
Received: from BN9PR03CA0926.namprd03.prod.outlook.com (2603:10b6:408:107::31)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 09:04:33 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::8e) by BN9PR03CA0926.outlook.office365.com
 (2603:10b6:408:107::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 09:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 09:04:33 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 04:04:31 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yuansmao@amd.com>, YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu: Flush tlb by VM_INVALIDATION packet in sdma_v5_2
Date: Mon, 9 Sep 2024 17:04:18 +0800
Message-ID: <20240909090418.844819-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: ed50364f-cf0f-489e-31a1-08dcd0ae6c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cqqrQwdLi/N1ZPlSZeszOvDbVnI43cMsMkswLfbmao7AL3i7QFnI2/pW57ii?=
 =?us-ascii?Q?Qv+xTJoWgLrebLvIIyb3kxHai25/jTUNyxLsN8ljfE+6rYhy2jLDfW0lYf2v?=
 =?us-ascii?Q?FoHhY2S04+VJGv+mNFdpatTMdlqyr/yraeICBqMF5cW+9sCHBszXRI+nMKZ3?=
 =?us-ascii?Q?CAw5v2oj1pvopwI3cXw1sBx1u2n0SSuEpgRQdJi0wfnxtL1Y1edwkvW9PfKF?=
 =?us-ascii?Q?Wnsp5s9dz3IqMsvjNsHrV3fh1iiXjfEECkZa3a6aJecO5+7K9wAho+xvkOTT?=
 =?us-ascii?Q?xwrt9JGUxuP+GohYhwL4zzIFlKrK+pPZZnAZ2L2SM5mGKrAlnbRZJnLhdv6q?=
 =?us-ascii?Q?jhALI6UNA6kKqxotwrMV1Lw5sfnguczu2ul7BC7t1PMzZ4kOu4/0pPzxRUtS?=
 =?us-ascii?Q?0DTL/UJ670vKXzvAGKZO3TU+WO8m61LQr0uQ5IJJBLru+hao3Wuigqx47uIr?=
 =?us-ascii?Q?pdjXY0dqvyZt1Am0mj3RGxJvx016pQWHGJ6C3BD8mSTzg1dbbIir8gPwIFDL?=
 =?us-ascii?Q?KzgsANtVav1t3Mg/0e0IAfdUcOzLpUkYFAYhLkyfHzaxgOxogTQFPeqwD5q2?=
 =?us-ascii?Q?mwX+N4UDrvNwkELGEGTXmEVxx0f/dZWNqiirAOmdopA1DrYukhXNOlg+UlTz?=
 =?us-ascii?Q?73qwP1XxGb+sZ2o0iiYM99y4af1YF4egceb2K4/6jEi06sLPBeEM2+vXkGTV?=
 =?us-ascii?Q?15PpMAQFcxzhiJodW+tQdWyiLPpMQwwHxlwS1T/TSaDT93/yn2OXdDCxry3B?=
 =?us-ascii?Q?dWp56KXPYX4/jOA+54Md00S5tcGVKJmJBS48NAn4YYdCmtBRSYpMnzP6gpss?=
 =?us-ascii?Q?6sVn0DHcJkNAYelldkyngzXLdU+MtwRcuod+KXWn5wok9M3++3ChTrOvVc0g?=
 =?us-ascii?Q?8O5GN3/JHAl5o4Aauq0zdrmAQ8F5gdxS1ElLCtL2qmdbiZxZrZ5F3Ut9Jn1R?=
 =?us-ascii?Q?aB+jrjQU1VGS3kP2n/Yrac5hnbTlku2XOP/89gtoRhOn4hCYNjb4t0N4qqI1?=
 =?us-ascii?Q?de4/Q91/DPKMl2VrxngjXy9UmSDgGY+06548pFCcTlUVNi1VAZ3vxe5p6V2o?=
 =?us-ascii?Q?OajZEk6Gk9L/NCqDCEqvHLpoJAOCQW9rly573qv6Cx8hZawGNmfUVmpBZhE5?=
 =?us-ascii?Q?sOIY0LOBZitxSzeFeC2OehUAQDEkfaP6ENrf9goHxAJKt8ub0VHO1+r11tI9?=
 =?us-ascii?Q?tGF+Y981Czwqi5GMdfGM7a/HQYNcJZZ3k0Y9UVXOwpFB2r2Kn3oy56f9Si7a?=
 =?us-ascii?Q?Dj5+qhwEpD/T+3y9UWr07+dA+wnv6KSBy5B67qcNx1G7D/UwT2g6ZC/SMmnU?=
 =?us-ascii?Q?7A3OJ9XQ2/OfrmmqoiSkQzZ0x+BiAOx4Y7v0rDIgGPFYLagCoZVAeNEgecrM?=
 =?us-ascii?Q?d5lqlSw+yRNPSE8jxPbeb7o5136gvA6Nlpx6cWyPuKMbT3UpPf6x4R0OBG+m?=
 =?us-ascii?Q?ips5EDbUGhG4lV/LgArWm0aXKCmfOsjc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:04:33.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed50364f-cf0f-489e-31a1-08dcd0ae6c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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

To flush tlb by one single packet, Use VM_INVALIDATION packet
in function sdma_v5_2_ring_emit_vm_flush.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 .../gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 24 ++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
index a5b60c9a2418..c88284ff92d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
@@ -68,6 +68,7 @@
 #define SDMA_SUBOP_POLL_REG_WRITE_MEM  1
 #define SDMA_SUBOP_POLL_DBIT_WRITE_MEM  2
 #define SDMA_SUBOP_POLL_MEM_VERIFY  3
+#define SDMA_SUBOP_VM_INVALIDATION  4
 #define HEADER_AGENT_DISPATCH  4
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
@@ -4040,6 +4041,69 @@
 #define SDMA_PKT_POLL_MEM_VERIFY_RESERVED_RESERVED(x) (((x) & SDMA_PKT_POLL_MEM_VERIFY_RESERVED_reserved_mask) << SDMA_PKT_POLL_MEM_VERIFY_RESERVED_reserved_shift)
 
 
+/*
+** Definitions for SDMA_PKT_VM_INVALIDATION packet
+*/
+
+/*define for HEADER word*/
+/*define for op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
+
+/*define for sub_op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8
+#define SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
+
+/*define for gfx_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift  16
+#define SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift)
+
+/*define for mm_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift  24
+#define SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift)
+
+/*define for INVALIDATEREQ word*/
+/*define for invalidatereq field*/
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) (((x) & SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) << SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
+
+/*define for ADDRESSRANGELO word*/
+/*define for addressrangelo field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
+
+/*define for ADDRESSRANGEHI word*/
+/*define for invalidateack field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x0000FFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
+
+/*define for addressrangehi field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift  16
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
+
+/*define for reserved field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
+
+
 /*
 ** Definitions for SDMA_PKT_ATOMIC packet
 */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cc9e961f0078..a112ea3749c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1121,7 +1121,29 @@ static void sdma_v5_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+	//amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 }
 
 static void sdma_v5_2_ring_emit_wreg(struct amdgpu_ring *ring,
-- 
2.25.1

