Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372E6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1778E10F8C5;
	Fri, 29 Apr 2022 18:03:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACF710F8A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvPnawe5J28b0LvCOEcwoClOo4kLdAWmwTNN8JMU0RfLpkaZQTllR0yYRTzE0y0wCB6I+6VW7s8VGskpqodlViWfG/k6L8Yt9JLd0H7UoEx4a4r2ifNYHsO2zFEs7zasHXftUreQ+BEZ6XxlvBRQEsYwGSM8VsDsPbWibUVS7WCPoFmAQc8/5W3k1nlMKuuxpu8IuvWfUuzqFnvXGInwyiwOMHg8l3Hm1LOW1FSbw9T6bUoOVFakERRiOjw7D8EnzOexJ/DpQYei/zMU+Szoi3O+7sVSDC+rVOIy/gnDprXBydTC9eoByDw00s0dyCMqgV0YFkfM/l+FzNr2xY/Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5B6abxpq/nK3VPfttzgL20jODW+HG6px0F5SxBmCsM=;
 b=YhFSv9O4JkQx5qd+XyhT8f2w+otbm8om7W1YKq12RNecTClHAMvYWy/2Ezxb+ofHYb5H3hrU6sGwAMqKeAh/VkRmuGsMUDMptTxo9c4lwq4b4kMpgxqEa81C+xe2gUAJYqGet4QwvLGYeEpVkwTtIUy1wMFR12izlqazVKF3KomJVLWbK3ED89+72CfTn9VX0o0Qfw65GWbmnbV9Pb6BsQsdCrSY1RItGrQC5kdCOzul928HQUHgjiurYxvGtufh23Rt9sQGqU0vUp+vxtFGXrl4ck+6PViM7g2PDtGjPN8220EVenGdUzSK964XCXyBhJ0zL51ISYqZ0taolVCNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5B6abxpq/nK3VPfttzgL20jODW+HG6px0F5SxBmCsM=;
 b=WJ0bTEh+P0Cx13wTxV6lxQgpjnq+pTOHuxeZtyPImDf/b1NuAdsLOPDrkpX0qhGg3Y4gnwAYvsI6BmowfFmafZXalCYNLmidoCRRDb1dd38tTKBQ3YK0M92DpFeWc1k+JtOgHx3rZ7CgObHEk0RKf7N9tDwlOuMwA+TAkNeIDVY=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by DM5PR12MB1899.namprd12.prod.outlook.com (2603:10b6:3:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 18:02:57 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::59) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/29] drm/amdgpu/gfx11: enable kiq to map mes ring
Date: Fri, 29 Apr 2022 14:02:24 -0400
Message-ID: <20220429180226.536084-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4142b0b1-9005-41a3-2e01-08da2a0a7dba
X-MS-TrafficTypeDiagnostic: DM5PR12MB1899:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB189990A8C8BAC49E91785F08F7FC9@DM5PR12MB1899.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWuXX4DC2HMERgeOn1ldcJ0211LgIc9zb5MaMU/n+Qw2B5ywGSQxPpR6EybE4Qeb7b1RAaKkF1fj/j0dhpsT/HR3RQ+Ye6JZkf3Sb3t+jiFUPfQc0U1VqQxQo4GqQp1T2VZ1tdM8UnYp5Kr5l9RNDrWPW3eK+HButd8OD8UjbG6Ge6Lykioe6egbzHxN/4ye/TIvn6uNK5+Rk586eePHOeHcZf2k3SmVQNjh5X41t7h74U9PGIKtan4HPREC6u3euNiJJta1y8vJ1CuWtiJ3ptLgte9TJ/O4evnBgbeb3t8Q4SqLqdxYb7XHQT5uonzOAIMTsqxR4G0uluvVFnf1jBTg+tQPGncawHk3B9/DHY6rLc59cu+twebf/qskKJ0H34Akz1UrmOaCS73Rkns1lkICllA1UzV5Cy6N+3DfIpY2Kfi0FEEoLrU4A0pv2LKUIOhYql2/WoDXm9HQlY2FNiP9vOKjc3qhudqzK8OSLwJiUvKOaEEq4aDV6tZUvAm+Y3Vln53f0HCskmTDvQiXJ1AZAuUIO7NLLmliIrDkhFQgwao4xPSxnx8hswhLamYKUs86D2Ni0bDmzbRDSFVEfUokB/+wddFTaTAl8wWqPMdK5JB6kFWYKV5XqgXASsGPiURcCTL9vz5sJeU/LwveRxU9e5yWTLFogLqAhF7ASdO4SEfp21yBRKddd79YY2j4kksogBf7v62u5HUg4aGx8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(6666004)(7696005)(70206006)(70586007)(4326008)(86362001)(81166007)(8936002)(82310400005)(8676002)(2906002)(36860700001)(83380400001)(47076005)(2616005)(1076003)(426003)(16526019)(336012)(186003)(40460700003)(6916009)(54906003)(316002)(5660300002)(508600001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:57.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4142b0b1-9005-41a3-2e01-08da2a0a7dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Enable KIQ to map MES ring:
1). add MES queue mapping support in MAP_QUEUES packet.
2). use correct MQD settings for MES queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |  16 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 107 ++++++++++---------------
 2 files changed, 57 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2f8fbe2651ff..184bf554acca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -121,7 +121,21 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = 0;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_COMPUTE:
+		eng_sel = 0;
+		break;
+	case AMDGPU_RING_TYPE_GFX:
+		eng_sel = 4;
+		break;
+	case AMDGPU_RING_TYPE_MES:
+		eng_sel = 5;
+		break;
+	default:
+		WARN_ON(1);
+	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index af944a43fb03..12e048c83b0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -28,6 +28,7 @@
 #include "soc21.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
+#include "gc/gc_11_0_0_default.h"
 #include "v10_structs.h"
 #include "mes_v11_api_def.h"
 
@@ -632,7 +633,6 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
 
 static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
@@ -646,38 +646,18 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->compute_misc_reserved = 0x00000007;
 
 	eop_base_addr = ring->eop_gpu_addr >> 8;
-	mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
-	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(MES_EOP_SIZE / 4) - 1));
 
+	mqd->cp_hqd_eop_base_addr_lo = lower_32_bits(eop_base_addr);
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 	mqd->cp_hqd_eop_control = tmp;
 
-	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
-
-	if (ring->use_doorbell) {
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_SOURCE, 0);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_HIT, 0);
-	}
-	else
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_EN, 0);
-
-	mqd->cp_hqd_pq_doorbell_control = tmp;
-
 	/* disable the queue if it's active */
 	ring->wptr = 0;
-	mqd->cp_hqd_dequeue_request = 0;
 	mqd->cp_hqd_pq_rptr = 0;
 	mqd->cp_hqd_pq_wptr_lo = 0;
 	mqd->cp_hqd_pq_wptr_hi = 0;
@@ -687,17 +667,28 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
 	hqd_gpu_addr = ring->gpu_addr >> 8;
-	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_lo = lower_32_bits(hqd_gpu_addr);
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
+	/* set the wb address whether it's enabled or not */
+	wb_gpu_addr = ring->rptr_gpu_addr;
+	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_rptr_report_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	wb_gpu_addr = ring->wptr_gpu_addr;
+	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
+	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -705,30 +696,18 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, NO_UPDATE_RPTR, 1);
 	mqd->cp_hqd_pq_control = tmp;
 
-	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = ring->rptr_gpu_addr;;
-	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
-	mqd->cp_hqd_pq_rptr_report_addr_hi =
-		upper_32_bits(wb_gpu_addr) & 0xffff;
-
-	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = ring->wptr_gpu_addr;
-	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
-	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
-
+	/* enable doorbell */
 	tmp = 0;
-	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_OFFSET, ring->doorbell_index);
-
+				    DOORBELL_OFFSET, ring->doorbell_index);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -736,27 +715,24 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
 	}
-
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 0);
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
-
-	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
-
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x55);
-	mqd->cp_hqd_persistent_state = tmp;
-
-	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
-	mqd->cp_hqd_ib_control = tmp;
-
 	/* activate the queue */
 	mqd->cp_hqd_active = 1;
+	mqd->cp_hqd_persistent_state = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+	mqd->cp_hqd_ib_control = regCP_HQD_IB_CONTROL_DEFAULT;
+	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
+	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
+
+	tmp = regCP_HQD_GFX_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN, 1);
+	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
+	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
+
 	return 0;
 }
 
@@ -822,7 +798,6 @@ static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-#if 0
 static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -847,7 +822,6 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 	}
 	return r;
 }
-#endif
 
 static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 				enum admgpu_mes_pipe pipe)
@@ -862,11 +836,17 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	else
 		BUG();
 
+	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
+	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
+		*(ring->wptr_cpu_addr) = 0;
+		*(ring->rptr_cpu_addr) = 0;
+		amdgpu_ring_clear_ring(ring);
+	}
+
 	r = mes_v11_0_mqd_init(ring);
 	if (r)
 		return r;
 
-#if 0
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
 		r = mes_v11_0_kiq_enable_queue(adev);
 		if (r)
@@ -874,9 +854,6 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	} else {
 		mes_v11_0_queue_init_register(ring);
 	}
-#else
-	mes_v11_0_queue_init_register(ring);
-#endif
 
 	return 0;
 }
-- 
2.35.1

