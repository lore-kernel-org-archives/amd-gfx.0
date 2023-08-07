Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF95C0015E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 03:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DBC10E00D;
	Mon,  7 Aug 2023 03:06:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE2B10E00D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 03:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it9K9ggxUMcDkVe+2Bszw4GqxTcs9FaYP9hkpj6k7bz4gXdzGLUzfrY1bSRp9T7OOvL4UBN6YbP+8epdDG/A0eMGlXosdB3bJCALyA9MupZRboB8r5wEJOCNpu8m9hnSTMwOQFZbRnzCZOvxjCsXEj/AGIHY0aKAxVq8B3Hg4IDjS/ZpgVmC/XkiWgrKqdgVc28lUCKRRhta9aERJaXinWxrA4FubR/S5+kK8Mo0W3D5eclgfhe8iXs8IYxJBhJ4hkIKB9DMj2YDozTVxuszR6J96UV0chZH77VAPmgZR8W0HWb0d+BMq/4MbEZg5IrODlG+bpfKRcrX0yYNYJfX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQukJ+4/lUa1V2UfE477C0BtQRxNXlDhPnwujwnR4bU=;
 b=PNOg1MgfQx8Rs1pvZl088MUqWVXiTJQgpgLohIy+VVsUxzavQCAfiZv+ZjSdmpNIwKzYSl9pqAn9G2HtzwyzvydFwfs0AO3L/uD+3g/CDtVs4VOrlZZQ6wqqSztBXFxU3p5cq7/Swny+oTtW8nx4XwMYoYgSxyKFaXv2BsTc4+Kp+72/p8dxPVKVVUx+zxwYmeT/E8rZQP5obpzqHeR4DutWvQpYf31nm8NLaN/RsJsgILeJ7vswoIhlzjYdPOlNiaVsb1QYPxy9i37OXvUdeCn5akL+w+dLVE8K8I0JEu9rgHVxVdDqlnw8vJpsT/fTcNJ6WhzM4BgHa7DG9v96cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQukJ+4/lUa1V2UfE477C0BtQRxNXlDhPnwujwnR4bU=;
 b=2em6Djjfd99HTen3H0vEyg9lrjOk4iREDQu/VGs7vp4cKbreUgWU16iy5nwavmxCqPBB2vksz80h5A3hCnFK9VW6FMhiLbqV/pYKfGTaBUe7F9g1V9T93teXAXT1ct+3VEOIhrc3NS3O+KRBXrgT7Ftgk0z8glWZvUc9uH+0Twc=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 03:06:35 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::98) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 03:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 03:06:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 22:06:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: add RAS fatal error handler for NBIO v7.9
Date: Mon, 7 Aug 2023 11:06:23 +0800
Message-ID: <20230807030623.21757-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: bb766984-e272-448f-4495-08db96f3502c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSBm2r3rl24NOms+XFDZG9K9PtOXVrW5z/f4FVwl/kRo4wkHjkurP0DlDv0xvHgESgWudwzgMx77weD0UbheZY3Snvk/yGPPQ0OlCsQzAzt1WXuEpJvjeDWX9Vof9iOg3LRSXFdtKCtXERHRyG1A50oiJFEwY2vvQGI+U+CEDZzYgnh54HofIbxKxRS0HbMOXE0BHYPbGCzBrMp2WMPZsHD7VQp76UfKcKTrqTHGHOJjD+eEJem5sd26WAmFIaDVnxTvwo/HjcxF3a/YCvHtSVPgEKOBfc60UpbShAFWKEKHwTja+mamFLx9AeHi/KSmdMrrSlUWDXANMox78YOg91UmChMW4aMzGVQ6ij4HJuVtuxtzv/cwz6SCOZG3gjtHJ+UIIQMW2mFaOfZq2sbnlqiF7aH4NRXqYNC6RPk8gQGDCigWfAgtzWrbtg/y+NSMvLBAAsTdVSfnJhBGK7Ok5sUuRzCRiErPbw+fXlI5ql0g8thehFkn4qAKFsBZyYRHtTqJ1ryLXoqr8jA/YjvCiOP1tN8JI8x3KQozA/ESP6E4Z+kgQlTapaPBBScEzG81+QmBKjQdRlNj6lektJbrulzyXBQs2gT8/kxiRm8E6vfK2cNddRqHx7SjJd43zvDGMCpwqJEvmG608B4FDfKqqmoIcC6r0Pwq9FIFzUKXcCLDg6b5vcEbVK7f436QBgTfmZX4Ct4nayrTXWnNyx4ROr0WtXeiR59uD1UFMyVH1BXajJu8FiO7OZ5rbWiOM+vBCGjEIfgveDRXVe/1k+H3Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(186006)(1800799003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(110136005)(2906002)(6636002)(4326008)(5660300002)(8936002)(316002)(8676002)(336012)(70586007)(70206006)(16526019)(86362001)(478600001)(81166007)(82740400003)(6666004)(7696005)(356005)(41300700001)(1076003)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 03:06:36.8729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb766984-e272-448f-4495-08db96f3502c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register RAS fatal error interrupt and add handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  | 219 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h  |   1 +
 3 files changed, 224 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 832fa646b38f..bef0f9264b4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,6 +35,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "nbio_v4_3.h"
+#include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
 
@@ -2663,6 +2664,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			 * check DF RAS */
 			adev->nbio.ras = &nbio_v4_3_ras;
 		break;
+	case IP_VERSION(7, 9, 0):
+		adev->nbio.ras = &nbio_v7_9_ras;
+		break;
 	default:
 		/* nbio ras is not available */
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cd1a02d30420..cc2268b871e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -451,3 +451,222 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
 };
+
+static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	return;
+}
+
+static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
+{
+	uint32_t bif_doorbell_intr_cntl;
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+		BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_CNTLR_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
+						BIF_BX0_BIF_DOORBELL_INT_CNTL,
+						RAS_CNTLR_INTERRUPT_CLEAR, 1);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
+
+		if (!ras->disable_ras_err_cnt_harvest) {
+			/*
+			 * clear error status after ras_controller_intr
+			 * according to hw team and count ue number
+			 * for query
+			 */
+			nbio_v7_9_query_ras_error_count(adev, &err_data);
+
+			/* logging on error cnt and printing for awareness */
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
+
+			if (err_data.ce_count)
+				dev_info(adev->dev, "%ld correctable hardware "
+						"errors detected in %s block, "
+						"no user action is needed.\n",
+						obj->err_data.ce_count,
+						get_ras_block_str(adev->nbio.ras_if));
+
+			if (err_data.ue_count)
+				dev_info(adev->dev, "%ld uncorrectable hardware "
+						"errors detected in %s block\n",
+						obj->err_data.ue_count,
+						get_ras_block_str(adev->nbio.ras_if));
+		}
+
+		dev_info(adev->dev, "RAS controller interrupt triggered "
+					"by NBIF error\n");
+
+		/* ras_controller_int is dedicated for nbif ras error,
+		 * not the global interrupt for sync flood
+		 */
+		amdgpu_ras_reset_gpu(adev);
+	}
+}
+
+static void nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_device *adev)
+{
+	uint32_t bif_doorbell_intr_cntl;
+
+	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+		BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
+						BIF_BX0_BIF_DOORBELL_INT_CNTL,
+						RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
+
+		amdgpu_ras_global_ras_isr(adev);
+	}
+}
+
+static int nbio_v7_9_set_ras_controller_irq_state(struct amdgpu_device *adev,
+						  struct amdgpu_irq_src *src,
+						  unsigned type,
+						  enum amdgpu_interrupt_state state)
+{
+	/* The ras_controller_irq enablement should be done in psp bl when it
+	 * tries to enable ras feature. Driver only need to set the correct interrupt
+	 * vector for bare-metal and sriov use case respectively
+	 */
+	uint32_t bif_intr_cntl;
+
+	bif_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL);
+
+	if (state == AMDGPU_IRQ_STATE_ENABLE) {
+		/* set interrupt vector select bit to 0 to select
+		 * vetcor 1 for bare metal case */
+		bif_intr_cntl = REG_SET_FIELD(bif_intr_cntl,
+					      BIF_BX0_BIF_INTR_CNTL,
+					      RAS_INTR_VEC_SEL, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL, bif_intr_cntl);
+	}
+
+	return 0;
+}
+
+static int nbio_v7_9_process_ras_controller_irq(struct amdgpu_device *adev,
+						struct amdgpu_irq_src *source,
+						struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for ras_controller_irq should be written
+	 * to BIFring instead of general iv ring. However, due to known bif ring
+	 * hw bug, it has to be disabled. There is no chance the process function
+	 * will be involked. Just left it as a dummy one.
+	 */
+	return 0;
+}
+
+static int nbio_v7_9_set_ras_err_event_athub_irq_state(struct amdgpu_device *adev,
+						       struct amdgpu_irq_src *src,
+						       unsigned type,
+						       enum amdgpu_interrupt_state state)
+{
+	/* The ras_controller_irq enablement should be done in psp bl when it
+	 * tries to enable ras feature. Driver only need to set the correct interrupt
+	 * vector for bare-metal and sriov use case respectively
+	 */
+	uint32_t bif_intr_cntl;
+
+	bif_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL);
+
+	if (state == AMDGPU_IRQ_STATE_ENABLE) {
+		/* set interrupt vector select bit to 0 to select
+		 * vetcor 1 for bare metal case */
+		bif_intr_cntl = REG_SET_FIELD(bif_intr_cntl,
+					      BIF_BX0_BIF_INTR_CNTL,
+					      RAS_INTR_VEC_SEL, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL, bif_intr_cntl);
+	}
+
+	return 0;
+}
+
+static int nbio_v7_9_process_err_event_athub_irq(struct amdgpu_device *adev,
+						 struct amdgpu_irq_src *source,
+						 struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for err_event_athub_irq should be written
+	 * to BIFring instead of general iv ring. However, due to known bif ring
+	 * hw bug, it has to be disabled. There is no chance the process function
+	 * will be involked. Just left it as a dummy one.
+	 */
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_controller_irq_funcs = {
+	.set = nbio_v7_9_set_ras_controller_irq_state,
+	.process = nbio_v7_9_process_ras_controller_irq,
+};
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_err_event_athub_irq_funcs = {
+	.set = nbio_v7_9_set_ras_err_event_athub_irq_state,
+	.process = nbio_v7_9_process_err_event_athub_irq,
+};
+
+static int nbio_v7_9_init_ras_controller_interrupt (struct amdgpu_device *adev)
+{
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_controller_irq.funcs =
+		&nbio_v7_9_ras_controller_irq_funcs;
+	adev->nbio.ras_controller_irq.num_types = 1;
+
+	/* register ras controller interrupt */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__RAS_CONTROLLER_INTERRUPT,
+			      &adev->nbio.ras_controller_irq);
+
+	return r;
+}
+
+static int nbio_v7_9_init_ras_err_event_athub_interrupt (struct amdgpu_device *adev)
+{
+
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_err_event_athub_irq.funcs =
+		&nbio_v7_9_ras_err_event_athub_irq_funcs;
+	adev->nbio.ras_err_event_athub_irq.num_types = 1;
+
+	/* register ras err event athub interrupt */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+			      &adev->nbio.ras_err_event_athub_irq);
+
+	return r;
+}
+
+const struct amdgpu_ras_block_hw_ops nbio_v7_9_ras_hw_ops = {
+	.query_ras_error_count = nbio_v7_9_query_ras_error_count,
+};
+
+struct amdgpu_nbio_ras nbio_v7_9_ras = {
+	.ras_block = {
+		.ras_comm = {
+			.name = "pcie_bif",
+			.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+		},
+		.hw_ops = &nbio_v7_9_ras_hw_ops,
+		.ras_late_init = amdgpu_nbio_ras_late_init,
+	},
+	.handle_ras_controller_intr_no_bifring = nbio_v7_9_handle_ras_controller_intr_no_bifring,
+	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring,
+	.init_ras_controller_interrupt = nbio_v7_9_init_ras_controller_interrupt,
+	.init_ras_err_event_athub_interrupt = nbio_v7_9_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
index 8e04eb484328..73709771950d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
@@ -28,5 +28,6 @@
 
 extern const struct nbio_hdp_flush_reg nbio_v7_9_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v7_9_funcs;
+extern struct amdgpu_nbio_ras nbio_v7_9_ras;
 
 #endif
-- 
2.35.1

