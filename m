Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5D0C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B204D10E5E1;
	Mon, 10 Aug 2026 03:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LqCv6/7L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA79C10E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHrAZSZmqP5kbVp6Zry4eBoFJXMEm3tPGbXAqxVp4lfaMVsPzA00mSc7LyKsLURsWcn5cZActrpSIzVv01/5Sued4UQ0QRSGjmwZ+n64whlTLb9mUjOR1S40/pTNBpfyFeDjDwFnvPX3AbXK3IoGBr8CpoyHu7ApTXeHr39gbIx2vz/K4NbT/4bOhaG8yyheXXeCJNg+O6xGb8n49y/RGzruIRaCPebaa2STB7MH/9UhrdYM88oy8KXp8SF3q1/O5f2cgCu/GHvYkIvwFZjgJ1GRhj5kYg7sSKnAyN+dSn0twhgiJM5GVcW5rbOXi5CDWi7n+u4QIdDD5u2o7fed3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mps0sIwjykKRZSuIqS6Fbx7tQfCbxldypO8QhIODUL8=;
 b=KxqrakkZxaXDv6wmOKmXNpvpuApFQ19Uoro0U1nh0Eq5kzWWeIBkrkHZk+G98t/Qoxk6GKo+LnqYsf4JyE4vHY/8ITxsV7PpLWU3Rz+s/JbN7Gx1uchwy8B/m2w408sBYL5SQqIuWVksnZXXSGU/Q8R8fsTiz2qXM1O+UnoiD3NpvMr7jeDnykuvgD5eKrbPDojkojxIQpmHblH+2tFzlzERYrWNFx+CtBKPAvivbvN6FZ4CMupAyGWUowhr7qJwl5rOBR1e3xYGnW+1ILfno1scfBsj/5u9D+8n7vXeVADaD1WRZY5w4pITlODYPghrUz3zLzkso0ylYp6fzqoGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mps0sIwjykKRZSuIqS6Fbx7tQfCbxldypO8QhIODUL8=;
 b=LqCv6/7LzOxYGnFyZS69u9ci/7NnsTodNhmFoMtE0z0hZ02Ce4xP1AmWvvuYW4NFRFCmYNw07389rvurOTkc5WarkUnvLZN4rTznz2izvHUVLb3WEPBEsei5B7vdztMj3iwK1QmJ2z/UcZ/Vmkxo9l7yCtygXIQXD5obttn3TN4=
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:07 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::31) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:07 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 05/13] drm/amdgpu: VCN 5_0_2 add support for multi-instance
Date: Sun, 9 Aug 2026 23:36:36 -0400
Message-ID: <20260810033644.118194-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ac6454-5915-4c31-7395-08def691362d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: cJuZN+lMxFPZpMX3Vm0j2o6dPPS1qEs3o5a4IeIVAqHtcM9dOiqoU393Mvp/7gRXraIToCrl8Bdgbty4KXnX5BlNf6E/W0BpByuRpztZPNsnbuKE8oen2jJeqivu4dRddX8TpIS+0Z2zBqm5UuckB/dUR6WDVuEuyi+l9mIJ7VqBuGIaTBAy7i2jE9ae2Jhq9C0rIEorWwIiRjRlqG19Ao70xkRLhukZ6NY+ApDIN8oBi2Xkq5UTZwPOHNMFOORP7lI3mSuJj7NPMUk4/fzy1s+MOHABfJga0ne1kOCiX4bqf2LNF33nVy4wUCQfiCr2fxy/dSmpzPNYWLLFUOtjvix6GkdLYcF3owaSYgnoe264pnfzBG902MNWa4zCrSYA4TSZ0UUzZwkNmYnrpTARCGkKcBuT24U29wla0e1/99bWLu0Aa9mw05EnOGtSIIIavMV25KBDT9R9BRHfM4PoU/p2jTXayF+IHiCObPrHvCbVaV0xwQPJ/kN3hXWJKguLV4Ovu1makJ/UzBKex0XKpIlqFgxe70smFY24f7R35wNN5RVpVNKhYD0tERLFMmHYHVu68Ndv7V8yyNcaxcsrUxIm1oXkX2jknhQSEE6JiTgmE0avUNNaYbJJlV2FfvbT1aDs2zC+HfLenRjHVXHaTvtko6LTM91aW8tPbtNgWzV0X0Badc/WSs3F1OOG5HPM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pQB0qXS4/k5BIkw638K23vAY03eTkXtNzuV+D++G0Fts41qdkuoMkwyRBjBEMK87lY2rLezPU1MZtg3P8fPNJZcK/KiDFFRH9vcxxuioy/AunU3xngOZmFSXmMlHLSnyRvIccdbe6SYYBuNYrnzTQPwnLaeatTE3BLBbr8IV8jcgFkz4/l7aVeMXls8fg7DZfJ3hFwo4NowvAOTeU1jSZEv4y7k/UmZmRxDH0aKa3wRR6gEaPzbPzKpU7Fs3e/BG75yVhCEYl16cVe74IrGHPy2w+lvCk6uwmg6SA5fJCliC3vLVzIGDLyCvXtj+rM/EtwExGUYv13FX+Q5qOnlokDkxbr+cmHZboLqJ57MNiT1kzB7lJAWJdfyIGv/s53UeRGcVGz4LQQLAV2T3DkaGUjmdqB6FiWNf4GBmTBACTjuXaQOc1wserm5tl1cZNFk+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:07.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac6454-5915-4c31-7395-08def691362d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

From: Sonny Jiang <sonny.jiang@amd.com>

VCN 5.0.2 has two VCN instances per MID. Update the SOC configuration
and VCN 5.0.2 initialization to handle multiple instances

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 54 ++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 04c49e23d79b..db48bf2bc213 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -850,7 +850,7 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	adev->sdma.num_instances = NUM_XCC(adev->sdma.sdma_mask);
 
 	adev->vcn.harvest_config = 0;
-	adev->vcn.num_inst_per_aid = 1;
+	adev->vcn.num_inst_per_aid = 2;
 	adev->vcn.inst_mask = 1;
 	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 5291ebbc5c3e..6ffb34974a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -112,6 +112,11 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_VCN1,
+		VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
+	if (r)
+		return r;
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		vcn_inst = GET_INST(VCN, i);
 
@@ -132,7 +137,7 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
-		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
+		sprintf(ring->name, "vcn_unified_%d", i);
 
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 					AMDGPU_RING_PRIO_DEFAULT, &adev->vcn.inst[i].sched_score);
@@ -218,7 +223,7 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				 11 * vcn_inst),
-				adev->vcn.inst[i].aid_id);
+				vcn_inst);
 
 		/* Re-init fw_shared, if required */
 		vcn_v5_0_2_fw_shared_init(adev, i);
@@ -587,7 +592,7 @@ static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 		/* Use dummy register 0xDEADBEEF passing AID selection to PSP FW */
 		WREG32_SOC24_DPG_MODE(inst_idx, 0xDEADBEEF,
-				adev->vcn.inst[inst_idx].aid_id, 0, true);
+				vcn_inst, 0, true);
 	}
 
 	/* enable VCPU clock */
@@ -1141,17 +1146,46 @@ static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v5_0_2_process_interrupt(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
 	struct amdgpu_iv_entry *entry)
 {
-	uint32_t i, inst;
-
-	i = node_id_to_phys_map[entry->node_id];
+	uint32_t mid, cid;
+	int i, inst;
 
 	DRM_DEV_DEBUG(adev->dev, "IH: VCN TRAP\n");
 
-	for (inst = 0; inst < adev->vcn.num_vcn_inst; ++inst)
-		if (adev->vcn.inst[inst].aid_id == i)
+	switch (entry->client_id) {
+	case SOC_V1_0_IH_CLIENTID_VCN:
+		cid = 0;
+		break;
+	case SOC_V1_0_IH_CLIENTID_VCN1:
+		cid = 1;
+		break;
+	default:
+		dev_WARN_ONCE(adev->dev, 1,
+				"Interrupt received for unknown VCN client_id %d",
+				entry->client_id);
+		return 0;
+	}
+
+	switch (entry->node_id) {
+	case 0:
+		mid = 0;
+		break;
+	case 8:
+		mid = 1;
+		break;
+	default:
+		dev_WARN_ONCE(adev->dev, 1,
+				"Interrupt received for unknown VCN instance %d",
+				entry->node_id);
+		return 0;
+	}
+
+	inst = mid * adev->vcn.num_inst_per_aid + cid;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		if (GET_INST(VCN, i) == inst)
 			break;
 
-	if (inst >= adev->vcn.num_vcn_inst) {
+	if (i >= adev->vcn.num_vcn_inst) {
 		dev_WARN_ONCE(adev->dev, 1,
 				"Interrupt received for unknown VCN instance %d",
 				entry->node_id);
@@ -1160,7 +1194,7 @@ static int vcn_v5_0_2_process_interrupt(struct amdgpu_device *adev, struct amdgp
 
 	switch (entry->src_id) {
 	case VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
-		amdgpu_fence_process(&adev->vcn.inst[inst].ring_enc[0]);
+		amdgpu_fence_process(&adev->vcn.inst[i].ring_enc[0]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-- 
2.43.0

