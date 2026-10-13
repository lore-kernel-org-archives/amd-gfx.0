Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD77CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 15:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED2010E8E0;
	Tue, 13 Oct 2026 15:02:15 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2226D10E8E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj/VGkkfMZlawXViHXsyu+U+zaRAsK+A9ecGHDQF5lHs7E9gxa8ymFjA3dlm0Vnt/WOUoAavlLke5unlavmP2rDj7JPolyACdwIxjcwBRrQe8mQI1YXZNhRnfkdXONR7IW/+7yraxL23i3o5hD3Yvv755sy6Nkqbg7y1c9ZdfJmEdpjELWfhg02xbuNPNhyC2w/ea237AegLb9Alz4kqpKN+t+54FxggQKwEDFNkRMATRpPSMNkNllWJJFASkgU0XVVd5dMyaFy+jeMOQ21gMPu0W6JTT6U+XMDsyRllNyvPJceBas8RW1+tQUhfPhrRqbWUaXdYqmYY+xKrNHUmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUXsjWUAXQ6uSy+fo3QkxgZKdZbtcokt1rXkq88PQ3U=;
 b=g8IldMjbVLv1+cHidkmWDWChOuNcHnu3oeT2pCb8aLqesMKeJFdo5cFfSivIKQTkA3iQI4GawJ5nDmoym1XHnimm69ufZksPM1cBvbQD9BSujlwSTbnvR4Mk+fztwbaqaNnO+eRgHCnnmp1gsdASTpeIyxBwuv/3JihycyLfLMUYLkyIYVtqr4RpuL6gJpPb4JBkxJaundG74/bbIcnzwmEnaMVbkixdeu8O6SLH5+MmdFj7M2Rw2/o/zLl4km+uMHZJZPmiJCysu4x7KGQe2SquArcBOGerbBUbs4MKbR37D4R50unie6qCJrLJjoWXxSOUcFc4SUcf5jS9LQ9WWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUXsjWUAXQ6uSy+fo3QkxgZKdZbtcokt1rXkq88PQ3U=;
 b=XEeH6c728fCNqr3wl3k52JdEdKtGF4Ku3/Qgu9w1fI9TnovL1XbbfvWLp/7JZ9X+MFTCoA5ooOTwNVFOM0adVqKfcM2Vta+RG9TAMd+wYGQkQYR7xQbYXr4+xGQkvuZovEuSF+UgXlMfCre4utzUPzIiglrCKooUz1Vkw+8+NEg=
Received: from YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::28)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 15:02:04 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:b01:84:cafe::4) by YT3PR01CA0063.outlook.office365.com
 (2603:10b6:b01:84::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 15:02:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:02:03 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:01:57 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Add log when register access is blocked in PTL
Date: Tue, 13 Oct 2026 11:01:47 -0400
Message-ID: <20261013150147.2896846-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fee72c9-7584-4555-5b07-08df293af0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Jhh9IiITj2jx+k+eHRNyrozCjiK5RwglhlK++VIMZ1qDUBcNI4IfGYvpOnz0oPGXqaLrwzeatVeQKZkNT+raBuXUxTwdaQb95ZdRivm+CRo1lXdcjBSvLDN/vl5JatQ105iQ5dOPd93BeDyxbbEs6WILTa4ATKmq02aq5S4h9fM2GVf5k3/dFckeLFwJe3eHdd8h6+o0r48d9BXiH7R5vQEAaoAQ70tvPVOBcZ6Ht55SUNvI2CCqloa2ew3DdixwEDjcUSO/yRAjfwbuBGMm86Q8SOb8/c965O9ulNRU5usnDhTbkZlSqHeQdsfp8Rmevvio6NKoNcJV0BbY0kSjxVPajo59PqO/muf8wgjXvxSSx0SbQp3M1geEELQ9c9WpB+GoJfSR4NsWrjJGPeiT0wjUbYVZH3AkpvCxlSC1vAvtscwvIrvorFMFiU5foIMJLym7Gvb6DtRYzcYqA3wo7L0QJte+FdFc9dxgUkPIgp3hMlIwhNLuw28MaEL0lQkB9ARF2/15qvOsqvU6P6iwpbaTYwTDJZBijab59MRVejrGvwkleozr7vnesGisyB2XgEiF5+u09ppAH0IX5nscOjEfGwErvZAxU0PnmntQyybc66RH9S4zvNJL65HvYYFmfzYLpjPKSuTQuWNmRpBHbYASQaWYoy2It/f0SQYQqXre7BzyFn2ZoFhnwZ++6gZD1N4eW8qzGgvWwrR3a1QcVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qwwvhz4bL6NgZQn78G2bJw80Otg6LRoDab2IvlR3vKnsRD+q3EHr5hohrFJ6nh6NMuDIKxHmx7M8RhyswBCGgeUMiiwCuwvbGLCTw1KW1R6Kkw6Y0/cWgSH1A37eJXpzRrerfjI1QlpGQYGguFlTgjdLHGKhxNv6Diggc+B+FZhh6igCBL9JxEavIBuGl4Wt3ZOGaV1piIRGSjsasHjb9DJ8fFLzXqiqHJhDu2uQ9rWxWJb2OVLpQz5ojLlrU01ZroYVObTpAQFdBNQyAwxvGGn7/yPFJrSsI98NLFpTeUOVgeGJD2bWQ8q8Jaj6KGcFereW8TIoha6Iwz3FuNp8rJxOD/05kR3qWUh6yQc0PG7XqnfrVKCDZ4Kb0mJH/l0A+F40ylkySwFvtzCR8IViyzBIi9j2u0GK7PcrriQnzD/54DOxlV7PPme1ag7TpMiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:02:03.6852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee72c9-7584-4555-5b07-08df293af0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

PTL will limit access to specific registers. Instead of silently
dropping these attempts, log them in dmesg for reference. Also add a
dev_debug option to show what pasid/addr/packet type failed.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 34 +++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 76 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3572eb9b5758..1ce8313e3c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -171,6 +171,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device *adev);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -2661,6 +2662,7 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
@@ -2668,6 +2670,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_4_3_ptl_hw_init(adev);
 
+	/* Enable PTL register skip notifications if PTL is supported */
+	if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED)
+		gfx_v9_4_3_enable_ptl_skip_interrupt(adev);
+
 	return 0;
 }
 
@@ -3327,6 +3333,34 @@ static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * Enable GENERIC1 interrupt (bit 30) for PTL register skip notifications.
+ * When FW skips a privileged register access due to PTL, it signals via
+ * GENERIC1 and KFD receives interrupt source 177 with skip details.
+ */
+static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device *adev)
+{
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+				mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+				if (mec_int_cntl_reg) {
+					mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+					mec_int_cntl = REG_SET_FIELD(mec_int_cntl,
+							CP_ME1_PIPE0_INT_CNTL,
+							GENERIC1_INT_ENABLE, 1);
+					WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+				}
+			}
+		}
+	}
+}
+
 static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      unsigned type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e241ad7d55df..8dee8c43824d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -123,6 +123,28 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
+/*
+ * PTL (Peak TOPS Limiter) register skip notification.
+ * When FW skips a privileged register access, it sends interrupt 177
+ * with GENERIC1 and provides packet type info in CPC_INT_CNTX_ID[31:28].
+ */
+#define CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG	1
+#define CPC_PTL_PACKET_TYPE_SET_SH_REG		2
+#define CPC_PTL_PACKET_TYPE_COPY_DATA_READ	3
+#define CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE	4
+#define CPC_PTL_PACKET_TYPE_WRITE_DATA		5
+#define CPC_PTL_PACKET_TYPE_COND_WRITE		6
+#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM	7
+#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64	8
+
+/* CPC_INT_CNTX_ID[31:28]: packet type that was skipped */
+#define CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT	28
+#define CPC_INT_CNTX_ID__PACKET_TYPE_MASK	0xF0000000
+
+/* CPC_INT_INFO[30:28]: queue ID */
+#define CPC_INT_INFO__QUEUE_ID__SHIFT		28
+#define CPC_INT_INFO__QUEUE_ID_MASK		0x70000000
+
 /*
  * The debugger will send user data(m0) with PRIV=1 to indicate it requires
  * notification from the KFD with the following queue id (DOORBELL_ID) and
@@ -142,6 +164,30 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 				KFD_DEBUG_CP_BAD_OP_ECODE_MASK)		\
 				>> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
 
+static const char *cpc_packet_type_name(uint32_t packet_type)
+{
+	switch (packet_type) {
+	case CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG:
+		return "SET_UCONFIG_REG";
+	case CPC_PTL_PACKET_TYPE_SET_SH_REG:
+		return "SET_SH_REG";
+	case CPC_PTL_PACKET_TYPE_COPY_DATA_READ:
+		return "COPY_DATA_READ";
+	case CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE:
+		return "COPY_DATA_WRITE";
+	case CPC_PTL_PACKET_TYPE_WRITE_DATA:
+		return "WRITE_DATA";
+	case CPC_PTL_PACKET_TYPE_COND_WRITE:
+		return "COND_WRITE";
+	case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM:
+		return "WAIT_REG_MEM";
+	case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64:
+		return "WAIT_REG_MEM64";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
@@ -352,6 +398,8 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 		source_id == SOC15_INTSRC_SDMA_ECC ||
 		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
 		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
+		(client_id == SOC15_IH_CLIENTID_GRBM_CP &&
+		 source_id == SOC15_INTSRC_CP_PTL_REG_SKIP) ||
 		KFD_IRQ_IS_FENCE(client_id, source_id) ||
 		((client_id == SOC15_IH_CLIENTID_VMC ||
 		client_id == SOC15_IH_CLIENTID_VMC1 ||
@@ -538,6 +586,34 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
 				NULL, 0);
+		} else if (source_id == SOC15_INTSRC_CP_PTL_REG_SKIP) {
+			uint32_t packet_type, queue_id;
+			uint32_t skipped_addr;
+
+			/*
+			 * PTL (Peak TOPS Limiter) register skip notification.
+			 * FW skipped a privileged register access and is notifying KFD.
+			 * Data from IH entry (not registers):
+			 * - context_id0 contains CPC_INT_CNTX_ID with packet type in [31:28]
+			 * - context_id1 contains CPC_INT_INFO with queue ID in [30:28]
+			 * - context_id2 contains CPC_INT_ADDR (skipped register address)
+			 * - PASID comes from CPC_INT_PASID (already extracted from IH entry)
+			 */
+			skipped_addr = SOC15_CONTEXT_ID2_FROM_IH_ENTRY(ih_ring_entry);
+
+			/* Extract packet type from CPC_INT_CNTX_ID[31:28] */
+			packet_type = (context_id0 & CPC_INT_CNTX_ID__PACKET_TYPE_MASK) >>
+					CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT;
+
+			/* Extract queue ID from CPC_INT_INFO[30:28] */
+			queue_id = (context_id1 & CPC_INT_INFO__QUEUE_ID_MASK) >>
+					CPC_INT_INFO__QUEUE_ID__SHIFT;
+
+			dev_info_ratelimited(dev->adev->dev,
+				"PTL: AQL request was rejected due to incompatible user input; please verify your PTL configuration.");
+			dev_dbg_ratelimited(dev->adev->dev,
+				"PTL: register access skipped - pasid 0x%x, queue %u, packet %s, addr 0x%x\n",
+				pasid, queue_id, cpc_packet_type_name(packet_type), skipped_addr);
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index e5c0205f2618..736b02ccdefb 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -25,6 +25,7 @@
 
 #include "soc15_ih_clientid.h"
 
+#define SOC15_INTSRC_CP_PTL_REG_SKIP	177
 #define SOC15_INTSRC_CP_END_OF_PIPE	181
 #define SOC15_INTSRC_CP_BAD_OPCODE	183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
-- 
2.43.0

