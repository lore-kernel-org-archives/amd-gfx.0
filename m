Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB24DFD2D79
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8EA10E286;
	Tue, 10 Mar 2026 13:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uvZadXK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E679A10E286
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ/Q2y7aQC8sVzjY6ojLO5EjK2oZSHv7nRDf6TkyXOvJu5SB0L2DBXVgC4BJxBj7UQygt93M0oyhUHRFltwOJ+OAuifWt4RUk5MVsSbbGWvD46VVFtj8EM7J0blffZ4G7geo48gn8o9v0MQ+YGx+7wbxIoLtAlAFXABnVuywTorXWh3aLsCk11ep8l/ZgYRBk3N79bgdT5duZB0aDDPpMhjxPuWma1yv4pwLolc9OQqzayuxJ+Lyl6eYlvz2OorsTTf9S7hTkrkP6fmamkqeJE2LMYL7jD53+Wn9p3nx7Cw3hFaadn+s3GeVegDDg7XxoDQ1/7ma7qJFmIufL/3YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5e++sXwr2DQihatKpnQ9U0R5JeI0Te3f8RBLb444oc=;
 b=liemOrGruPNMSMbzFKPj6dh5fAQPJ5/gK2apryDa0woSjV2+8Nq/sQ5+qosPmcGEy3YXsqi42m8iVvivdd4Mo8gItxQNWKtrU8vjKStrO8uLY1WYdEluroqOI5gw60MXwJDBNV9DtPo+O6rc/r9M+/W28c5HbGyQxrlsHVy7eggHdp0VOuoTdXSfFOMblShagbnOKIJK1826OWEOTzHQUxlauQ8z2C6G1nhkFll0VS+nw+sZcE3ddght5k/rlj0ZYV0UtIKF2EsrKT+25ja5UmQictdApPpuoCSPkX+cM72SBibqmjGm/14bTiVH+sSoJnki7DGwIljHpgTOPEAh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5e++sXwr2DQihatKpnQ9U0R5JeI0Te3f8RBLb444oc=;
 b=1uvZadXKKaA+ZGWa137zKLPmopntYroC5m1K1VYev5asdoylA9nGQKENEnncQ0fy0D3O2JDHPtND72RKzzQbSXxvPIhiAAGkUuiDr125OZyM9xFaOIKztZDBvOp2rbWDG1A7vJdyVGeWg3AkeVCH5lAwpS8XnHdxwe6plQ9YkAU=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:22:24 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b0) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 13:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:22:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 08:22:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 08:22:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:22:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add poison consumption handling for gfx v12_1
Date: Tue, 10 Mar 2026 09:22:10 -0400
Message-ID: <20260310132211.2867415-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132211.2867415-1-alexander.deucher@amd.com>
References: <20260310132211.2867415-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: a00e3b71-e4e1-4b6e-9115-08de7ea8109c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099002; 
X-Microsoft-Antispam-Message-Info: BQ9qfGl9o5e7Z2lRjwk7g5dYCwo8sl57ajnQXIKPD7mJ0pqgBtphvWlEGXFYVdaa6vV7wWn8FQ5i/+FlvzdIdzJEmlVHanCDuX5e7is5VvX6RtWZQ7q2HxfFlnYnjgA2+8r2m93TdLlmV7n9PI+6arrdiZI+2bJkkllVuUYsx2Yn8re++DbFPo4UZbp7Q2NoRZBTWn77WvG2zAe2nDFpRdtaZvEwAMHao4VCNFj6dQhHxmpAG9XS1tVULXdjspn5lpx8m1SEBcEiFBNFBc6fPLHXvTXPcPIt4bg2LyJGWlPI3/aVrrdf6d1/fgdzzUCHYEEiKucLXXXaa4wnTf2RqmedCXH9WxJu+eFbLA7dp5E8qLxlT/XGeAJpLFbTiVaj2ZojUtS2mBIdvF4MXJOSIo5W+JK8o9hmcIM6y34rMipwoN9aA1dZfwgmcWBDMc+CZag8DgsuYAUwDmlrIDu2NgyrahJ+JEcjzJXowu1UTnUS45d+3Po9rPjHRalnKVQxJPbh1JGpcMl36is1luNg25AhbsL09upXUmuFvdDIGtUzkQY/1MU1SkwaQ45AU3NuFbVEZNVKevOXhlDcII1Pfnhf0R0F7YeG3QpgTGhMBfJjrIue1YHYqsxzSffZHAlux6ybcFRh5tQGGOQZzz7Bhdes+xwOdnhSrublgmu8c50qmL9nGcBWamAGe0GtSFZYxXh3P6EiLkgPaXa+vFlyQL/mh3UECjNkMbiXnLs3/HjDCVQXwau8usPlUKQxOADADjF2lohpFMfLhCMnUVMwew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHi0R2LannW520irvFNdc2xhfl3PljFjNqul3xgjPmZe/Xv2Vj6LDncamPJrpLCY/A6wS2T69AEaV5+oDD3QuvWKV9ADeo+AM4BtL8ktu5PLntzFi4wrCHpB2umNMy+aq2cCJqIq6l8K6vdyQ2J/msomNjL2i5uBrXFAyf/lOikTRRkWElJ5C0q7mAkkN63LCS23V9rgmbTKu9GmfhvmVWidEyAqzYTGHKmQFnchnLdNJ8GzpZgBebulebWq9YYc399hissgahGPKaEjbumB+xkZb58fCBNnILXBtw9FuWYbySg4t4J2G4SUdnwJHjttFOmrcLvI6rtr5wGvegOWzM9wa/8/Z7vlYzoErVEofy/RJnlhr26xI03Qlrw8/2vz+Ped/H4K41YrnQf316q2tA5mP7WvBVAUF1IvvzzCepX5xC9DOTW1PWZD2TCN/71/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:22:23.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00e3b71-e4e1-4b6e-9115-08de7ea8109c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add poison consumption handling for gfx v12_1.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 44 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_int_process_v12_1.c    | 12 ++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c6..2785eda6fea52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -463,6 +463,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		cp_ecc_error_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
+	struct amdgpu_irq_src		rlc_poison_irq;
 	struct sq_work			sq_work;
 
 	/* gfx status */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1a7ccfed8f0ac..db49582a211f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -45,6 +45,7 @@
 #include "v12_structs.h"
 #include "gfx_v12_1.h"
 #include "mes_v12_1.h"
+#include "amdgpu_ras_mgr.h"
 
 #define GFX12_MEC_HPD_SIZE	2048
 #define NUM_SIMD_PER_CU_GFX12_1	4
@@ -1184,6 +1185,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* RLC POISON Error */
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_RLC,
+				GFX_12_1_0__SRCID__RLC_POISON_INTERRUPT,
+				&adev->gfx.rlc_poison_irq);
+	if (r)
+		return r;
+
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
 	r = gfx_v12_1_rlc_init(adev);
@@ -3778,6 +3786,35 @@ static int gfx_v12_1_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_1_rlc_poison_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	uint32_t rlc_fed_status = 0;
+	uint32_t ras_blk = RAS_BLOCK_ID__GFX;
+	struct ras_ih_info ih_info = {0};
+	int i, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++)
+		rlc_fed_status |= RREG32(SOC15_REG_OFFSET(GC,
+					GET_INST(GC, i), regRLC_RLCS_FED_STATUS));
+
+	if (!rlc_fed_status)
+		return 0;
+
+	if (REG_GET_FIELD(rlc_fed_status, RLC_RLCS_FED_STATUS, SDMA0_FED_ERR) ||
+	    REG_GET_FIELD(rlc_fed_status, RLC_RLCS_FED_STATUS, SDMA1_FED_ERR))
+		ras_blk = RAS_BLOCK_ID__SDMA;
+
+	dev_warn(adev->dev, "RLC %d FED IRQ\n", ras_blk);
+
+	ih_info.block = ras_blk;
+	ih_info.reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+	amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
+	return 0;
+}
+
 static void gfx_v12_1_emit_mem_sync(struct amdgpu_ring *ring)
 {
 	const unsigned int gcr_cntl =
@@ -3902,6 +3939,10 @@ static const struct amdgpu_irq_src_funcs gfx_v12_1_priv_inst_irq_funcs = {
 	.process = gfx_v12_1_priv_inst_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v12_1_rlc_poison_irq_funcs = {
+	.process = gfx_v12_1_rlc_poison_irq,
+};
+
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -3912,6 +3953,9 @@ static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v12_1_priv_inst_irq_funcs;
+
+	adev->gfx.rlc_poison_irq.num_types = 1;
+	adev->gfx.rlc_poison_irq.funcs = &gfx_v12_1_rlc_poison_irq_funcs;
 }
 
 static void gfx_v12_1_set_imu_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
index 5d8b5aa194da8..47947b94926ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -28,6 +28,7 @@
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "amdgpu_ras_mgr.h"
 
 /*
  * GFX12.1 SQ Interrupts
@@ -185,6 +186,7 @@ static void event_interrupt_poison_consumption_v12_1(struct kfd_node *node,
 	enum amdgpu_ras_block block = 0;
 	int ret = -EINVAL;
 	uint32_t reset = 0;
+	u64 event_id = RAS_EVENT_INVALID_ID;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 
 	if (!p)
@@ -220,7 +222,15 @@ static void event_interrupt_poison_consumption_v12_1(struct kfd_node *node,
 	 * resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	amdgpu_amdkfd_ras_poison_consumption_handler(node->adev, block, reset);
+	if (amdgpu_uniras_enabled(node->adev))
+		event_id = amdgpu_ras_mgr_gen_ras_event_seqno(node->adev,
+					RAS_SEQNO_TYPE_POISON_CONSUMPTION);
+
+	RAS_EVENT_LOG(node->adev, event_id,
+		      "poison is consumed by source %d, kick off gpu reset flow\n", source_id);
+
+	amdgpu_amdkfd_ras_pasid_poison_consumption_handler(node->adev,
+				block, pasid, NULL, NULL, reset);
 }
 
 static bool event_interrupt_isr_v12_1(struct kfd_node *node,
-- 
2.53.0

