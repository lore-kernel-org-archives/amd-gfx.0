Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4826C3DA7A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 16:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E82910FE89;
	Wed, 14 Oct 2026 16:41:37 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8021E10FE89
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpotRjrjo3EfnmRNYXSuNyw/tqdr1FAanrBi8tANpxIexdZwajKZhnzx58U8WBzwpwTCOcaWZFzbkFsA5uvLc0963/LsAeZxXFBrcpi1rH2qV24UQFUUA6GIlX2TT9p84tPhIVnpGP5PgSQEx8hR3ERzsGDL3WYHlXL1emXtPQF3SfkLAlGyE27+ELkzKjFgkmSmJ8MHZD0ZlYVEbxLRhVtvfCwrfOE5P+kMBBmJ5ZL6+6ClHCMUu3SWYBL9kbE33cvfeZtJM9pts7Ht5GNydnGL0b9p58i1b/CP3OneDJQmO5bIXTQcTo5+n7I4+DYNWM4jvBZQ2nIzY4k5WLbCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFlZ3S9XGneliZom1BvwDw91pReMwf9Nraee/NRD2GU=;
 b=NQJ8k+H+ToUtOR2rm920FihcYNQDt5cfxnWIVWsxt3CJZsavdXJSN210jargP22IIi1ZQrxco9Eyx/35kQuGUDUmBkSE83HL36OJ48fL4+BOOAKIlvds4NupE27u0N2kjRWXqPBAwM0GfQVv8NiDHfNv8KQTMpPW38CyyJuGM+zAJSVLqLbLVWH7AcQfZ7BzkKuBkutZnfV8LIjfyVE4lotgToJw8MPA3MFOMSTcH2JJaXrmpQdHhDOZJjANPf9+tJ4JPv2gOKfKuUo1YNm0E+7vqutr11Y1dNcTnIK92GQP+iNmC2gLb37UkP7jG7ojInE1sS9wZ1x/psjmEt05Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFlZ3S9XGneliZom1BvwDw91pReMwf9Nraee/NRD2GU=;
 b=U7De32Dm36BbuCSWPKmd5G6pI1N1wGXAWLpY5G/i5IN2jKlc4ADnN6Ct+WNFSYM11GPQ2JfQBcUA8CVctFZcIuiVTzW4XJoqDExesudTswxseemZVvvQBXDvpqiSoqHw6+fZI4ZN1gl2O0gUP8KAMHtDAYdLLqAog4S0wiirg2M=
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 16:41:26 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::32) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 16:41:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 16:41:26 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 11:41:19 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <perry.yuan@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Add log when register access is blocked in PTL
Date: Wed, 14 Oct 2026 12:41:16 -0400
Message-ID: <20261014164116.2985138-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: c888e1e7-4a49-4b5f-8f5d-08df2a11fd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mHW+c5wqTabTKKwHIuQgnDKaLmvOHpO5jHKcJuswKbs9+smnuRXzPPlWX6HE3H5QRgkW/LLT72NwwPPyoeHyqaSl8Go6bicwHto81SznklEbz0+NXnRg8fGKwReLj1ytTb9svdr7PMr4P6sxXfLWeBf+kNirQqpxqRPS/JbthU9WchrHLTYnK/IAvF0cN/TDnWjzfBdeuI8P3wIhCP2NYYpuyNVdpvQ7sWyxyNaOHhi7FJI0Qr4VxnKfTMThgRIMsOCfEvajxpb0C0U6ULqsmUEuOGqBbxodY0j6wYwZbwCVs4nOeO6Gw27uuOi7wnzOu1NNM2M15ilNIZ2O2qp6F1wb4+SMq/jDzYgn17r0cT3n7ria5nBGb0J79jRoOszcglpjmte6UWN186QKInnce23ByMDk+E9sc91YlJA71GNd7diQGEZWehiwtCvbjMtl3YmG6hvf8TU0sL01fSPj0b4SJe5KTSNMxdgTqvm8f0z89zxyGqCyVL1mFGgZa4sT+UcoBUbEV79RwqhV+syD+MQf4QgjJTxIhoAHFXJLkyn8y3WDQvxjJPOaYoJ2wl6BzRsEN3BwKKMt344sdg2cNKWlOa2Z1GcCKtdI1DGcw/XCPZArHwti51ZDV80pCGAX4W82912tFlvWRk7pDcrUb4erXgSTL0lNFKyNIX1HsR5iC2M8XM+64mVkLBcPQ0UpxjWSSxTMthsIpbm9u2Dfhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r8xqMFNHWZMwXSIIMfsoc0FcWz9ljzflyntA62+wlANGsj6sXf1CpBWwm5wrdfrLqNNwXGiIQ5reUbx8gnVi4Zcsx9vXMdRYmiP+e4xbYYRvjkFn3LHjPrhc+/hYYoIgcdlfsvVKedPu+37ff7aGFy40e0LAwqXn0uP6tXHQW0AS95LvC0+KhT+6qQtdGTtFhZHB2XqtudVUJBsceckWkw1zS72mXANzoK6ugjBkxDfuF2jNCsij46l6P6DIDUl146j6vgtgvsqKls/moNvM9Rn2ThGxIdWK3rw7uC/o/gy/P0IBORV4X7IcX+wDz6NShrhnGjxo9hDGBDRiQJK6ImnmShCAoKZsCwZvainQcYZ9lcj1b051E+aVdP6dViry9gCo3brTA2EhUqcA08gmhVHu0UdUYclJSRKv8V4iwSctj1A3jgUifqWvx4YCCQWb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:41:26.0548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c888e1e7-4a49-4b5f-8f5d-08df2a11fd44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

v2: Make sure to guard it by MEC v195, and move enable call into
ptl_hw_init function

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 35 +++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 76 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
 3 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0ffdef21df0a..718aab5c7b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -171,6 +171,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device *adev);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -2465,6 +2466,11 @@ static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_device *adev)
 
 	gfx_v9_4_3_perf_monitor_ptl_init(adev, enable ? 1 : 0);
 
+	/* Enable PTL register skip notifications if PTL is supported */
+	if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED)
+		if (adev->gfx.mec_fw_version >= 194)
+			gfx_v9_4_3_enable_ptl_skip_interrupt(adev);
+
 	return 0;
 }
 
@@ -2661,6 +2667,7 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
@@ -3327,6 +3334,34 @@ static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,
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

