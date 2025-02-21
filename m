Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EBC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A460F10EA8D;
	Fri, 21 Feb 2025 15:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTmqUx/2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1096B10EA8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNKkIB+SsZMnKD6E1+iv0l2lC4bwHMAXHZOHiVpmLEKLCQw3zfUC3zRi9YDsLTUjdUrAESW7OBSVWrsnLiDTD3f0SQcq5ISHbvU/4cmVI5If+88NARaFgxOn4sqAy4QEG2VA63INcR/5WFmi6DLPTzf35lZxLDSVy5I9S2uv5EIWShqlDgbSfAF9ksfW+suVmkLFNkMR/aMFcDi1j+TDXMH5vrLl1Dvpucp7k3UppOAaN+FLG9y6Wcv9bSfHAnv9xtJ54W4Pi2iRBMaQeiOyPqrykasXBc+FDm9KEjImnib4MG7ItnY1iKd/GTYbIPFgCvhvc5eaW4Rf2wZtrFZ4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB5ppIIbxQclD9IYmJMZiJVIyDDMZeKtwi0IAiMgOW4=;
 b=k8P5aWJ+8kLwWgEsJ+80ZqMceKfPpQvo7staqUFfsfZaydmPMpqB1IA1W2AecGUQ8FFmWWKxp7B6ZYfVQ6t+4UF+DHUtAkt3WJ2DRY8G1SvPiSr+zek5o6EA/sgQFG7V3JObqbyOOytgxg+qHInSJq3eKcuPj1X70H19MM7Q+0AX3enTa6KIQlEKsei/z8UJe0SkdDUDDa5yYlTJIjJyTYFy8Uf3MBsJngqWmwxMBZQqWyBQ1QcTbdfHnaTWUd2Ddy+Be0cwEF/anHxwOOQ6VViKNbtjaJR0AEYIgJ4XkFqMI+zfbinRx3JhOnk9t3ohndtIasc7fao1jmmJaZOukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB5ppIIbxQclD9IYmJMZiJVIyDDMZeKtwi0IAiMgOW4=;
 b=cTmqUx/2VvTxpieNtRm+4GzN6FFWtmfG9ZqYBfTVbyV5MmxjjiUTbFFF5V6ZQfYvfPliWMvSqEJNL+IvMFJ47Ekbi4V1+IUSl+PZACTSnau4BqIWkdwrzR2R9/lnUWn5MAHoeeG0v+2TcVSErowvAHJfoP0swy7Anw9qWsECj4U=
Received: from PH8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:2d0::29)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:23:51 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::c6) by PH8PR02CA0003.outlook.office365.com
 (2603:10b6:510:2d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Fri,
 21 Feb 2025 15:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:23:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:23:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sonny.jiang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add offset normalization in VCN v5.0.1
Date: Fri, 21 Feb 2025 20:53:30 +0530
Message-ID: <20250221152330.67373-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221152330.67373-1-lijo.lazar@amd.com>
References: <20250221152330.67373-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d3a1ab-74e2-4909-8247-08dd528bbe91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNOxoZjcHS6kH0m/qj4rHyf2QVX6Y5aPaIoNRB2sRbvSUzI3YJpvH8IkZ1Q/?=
 =?us-ascii?Q?OgW7eNXIWZeZOkvPQgBfcdyTA9+OePssrMtxupfz8OcnbKuVn1BLcpxf1s/p?=
 =?us-ascii?Q?RKumxPRVLNyYT0+9IzEjXl8NyAG/GNyN/ghSjxH0c3252dSnuTvf0FmK8k1t?=
 =?us-ascii?Q?fRTMX9ucAYt8s56QT5WGHTfyUXyeGKijM+evq/hoppOMaf1mxZ8EDPTOxvA/?=
 =?us-ascii?Q?zhGElQNfObdttb3Ye1+m/zadIGmIz6sjN2+eum6EuSxMgUOmmL277cle6Nom?=
 =?us-ascii?Q?h8/Ozr/colR8Txh2CU5kT0n9bLV50rFvsr3OFNsytTW1vuwNISpdEWKNN/vc?=
 =?us-ascii?Q?DeVAohZCYkFUAhoOFVSCax2xz4cSey0GzE3wqA3s2FLA6DPCk7TxFmARkknI?=
 =?us-ascii?Q?p7OvF8fEUpdJ2uaOxSNDS2LLnlE/syZ5iO1io33kNyLYX+56CgMexeMDqIBe?=
 =?us-ascii?Q?Mws9nRVGT1p8jynRLa4gMHMbm1QDZE7G7uEzWITStGmu90wGM2O9I6Ixj5FD?=
 =?us-ascii?Q?b50MDoUrzr51d/kybmlUc3rhpJnPjfn6GsyNKwTk4/EvIUdGtxoyf41nOQW6?=
 =?us-ascii?Q?Q0eCR00qWlzG15PjIN8B5osP+atfMvprzzG/dJV0mMZ8IygsW2E6LGLzxN3O?=
 =?us-ascii?Q?BCunwSRaKqYWGTZIlsF52Sblwqz7cu5u32LnnaCWB+WKJewsd/Aysuw4fZ2D?=
 =?us-ascii?Q?6ITEbP7CKPv3PBkqjnar5voI/mai4eabD9DLQNLjwjJpntFmBlKmEHVnqS0S?=
 =?us-ascii?Q?M04vfrBdQQJN3wWZoJrjzPghIFfZxiYUo2no34761+t4tbVsjqoqFGcEMBXP?=
 =?us-ascii?Q?Xv/OkAK+J3EqhcWdsGtU8S7A2B4lKcmWvxtBMhRn5jSbrTgV0LLKvAZ+4YPg?=
 =?us-ascii?Q?cKtYF2nbUeSRiJVPIovCW2V1WvcogJxPtXW5Amnk2SNmQiOSZZYnqdNYRf7f?=
 =?us-ascii?Q?XhkpA9kr1HNMrSbMYR7JAv+KyMmkRzoz2oTXHaqiDsggqDH+S7/xbRa6gaAw?=
 =?us-ascii?Q?FkdtYLq++KgSglvepWKH21zF+M+qnFKQpVfLx5+DWdyJ0AHO0XPXIRU3wbTi?=
 =?us-ascii?Q?qPvAUvv07qFTVbneH3QNV3mDUva2dcIc6Wse74+MlkSdw0Lx8PwW77+RuGh8?=
 =?us-ascii?Q?0O6pXK4f257Ka4Avl7d80dM9/8iXq5hQaxz95qwBoR6wWovDrnsAIvzTyCMF?=
 =?us-ascii?Q?CmmW61xQBFDrCSapokeEo8RqZqxrk3a05c5xWlCu+gk3haa7JjJLtOUQtQk3?=
 =?us-ascii?Q?GoIC2HrV4cIlDchvVK2foR/cXFo3Cus/8mW81IJQdQX+c0yiOAx2eE2ZAaOB?=
 =?us-ascii?Q?LKYYv4Tatq195m1y9W24jCPsPyroULrqIQMSkkRQ/vbXiqwbRT9fm45ho5DU?=
 =?us-ascii?Q?OhVcByZF1P+nTcCNMfq+QhNEyoLdec3anmY26Hagag+pHEge9TksCkSsbfQy?=
 =?us-ascii?Q?tOqrlmROdz61SrbJT9hFytcQULl+Ett0SngyOBzvOn5VGrUCJefJB6WXESgW?=
 =?us-ascii?Q?PPjVf5+bSCFUaQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:23:50.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d3a1ab-74e2-4909-8247-08dd528bbe91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
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

VCN v5.0.1 also will need register offset normalization. Reuse the logic
from VCN v4.0.3. Also, avoid HDP flush similar to VCN v5.0.1

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 20 +++++++++++---------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index dda5ee187948..4aa622a2cbc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -31,6 +31,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
 #include "mmsch_v4_0_3.h"
 
 #include "vcn/vcn_4_0_3_offset.h"
@@ -1455,8 +1456,8 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-				uint32_t val, uint32_t mask)
+void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				       uint32_t val, uint32_t mask)
 {
 	/* Use normalized offsets when required */
 	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
@@ -1468,7 +1469,8 @@ static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t
 	amdgpu_ring_write(ring, val);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+				   uint32_t val)
 {
 	/* Use normalized offsets when required */
 	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
@@ -1479,8 +1481,8 @@ static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg
 	amdgpu_ring_write(ring, val);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
-				unsigned int vmid, uint64_t pd_addr)
+void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				       unsigned int vmid, uint64_t pd_addr)
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
@@ -1492,7 +1494,7 @@ static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					lower_32_bits(pd_addr), 0xffffffff);
 }
 
-static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
 	 * This is a workaround to avoid any HDP flush through VCN ring.
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
index 0b046114373a..03572a1d0c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
@@ -26,4 +26,13 @@
 
 extern const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block;
 
+void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				       uint32_t val, uint32_t mask);
+
+void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+				   uint32_t val);
+void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				       unsigned int vmid, uint64_t pd_addr);
+void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring);
+
 #endif /* __VCN_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 5472b4ff6578..c2f366a3c8cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -29,6 +29,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
@@ -885,16 +886,17 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
-	.emit_frame_size =
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
-		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_frame_size = SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+			   SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+			   4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+			   5 +
+			   5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+			   1, /* vcn_v2_0_enc_ring_insert_end */
 	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
@@ -902,8 +904,8 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
-	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.25.1

