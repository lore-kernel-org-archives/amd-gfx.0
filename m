Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4AEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 09:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466F10E1CB;
	Mon,  7 Aug 2023 09:09:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF28B10E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 09:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvIY+ZsWvfyvxM++YZxmVOYTXTvXuQoEnrr806F4UoCb0sFFImNghXuzPxDL9AQDJuUAgkDdZ6c8r0Zn2n/tlMowqCkbXq/8r/0Tm/ms9KPDJYqrV4DuLf/zYEPqZCIKKwVIdpRaReWrNGNf50ZSBpSoOxgyCDIjttwN8mzwQ/yhewAHeSHwOSp3Xl9l9YZMuo9RSi3JVU+CtKlyxYglLLOuKgTwWyDOiWQY8XMDthWxs+MWFDhIzgdxW9l7sfyYVMWc5lcpy15jWIJcmYfwWk/ArE25kHNLPq26EV/8NzPtyq1seulxueZHxPa511Pmf/34+erpayqIwOmtGIQvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgZcOaxrhtospsSqGUeaSk0JEQDef7wfhrlTtaYVVkI=;
 b=hLKYABb31+NmY9AYisJEPG2euIn8Yh6eGBotLZri+h4YS411JmFO5QrScI7mYe/Le/MtuUp5CpbU47HT1YCoidh22TykYWhzKScvSTxbhpDRJH1AY74YdZTlXQpjVS5zhxQpoeaZFi2AerB27T5Q9OvME56kNPm9y4k2YXYYxMEsWTSI3XfP8pEprYJnFozMD+fjGiNJyPTTUlmRcN5v2Sht0pUjjemQHYzgi6jRymrJAIRsUJpymGdLqT9F1GC845ljDbTb7ifCq/5LQ+m56AlRzBZ4R+22fS5yQb8Sb0ugEV1tynT0LJheucdgz3/OkR882KufFHwPbB4OfZb0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgZcOaxrhtospsSqGUeaSk0JEQDef7wfhrlTtaYVVkI=;
 b=m10NSjXF06OAAEG5o7O8yyoDG8Z8VGb3CMPCpKa5CUFvPjUf95IH9S1/2I+Eb+qRp14EdVczC1zO61bytG4yaQ2y8dkhF/rFwy8MaowHUPUiYnhkvNsr26nH9J6noQJMARLzDMoQmQYvDxLhXrBWo2sYqy8YVhy6sOHb3Isqofw=
Received: from DM6PR14CA0059.namprd14.prod.outlook.com (2603:10b6:5:18f::36)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 09:09:24 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::99) by DM6PR14CA0059.outlook.office365.com
 (2603:10b6:5:18f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 09:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 09:09:24 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 04:09:21 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: add RAS fatal error handler for NBIO v7.9
Date: Mon, 7 Aug 2023 17:09:12 +0800
Message-ID: <20230807090912.12145-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 542d1264-e9fb-4a08-649c-08db9725feac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFo/n1Se6VO1CxQnzwj1NrYuoAdoEyd31sQqJe+aYLSP7hpEF12P0aAzfp+AU0r4sJpBlyOAmWFWIG5X6bK+dR9sngmcNZXn7JOtwhRWaYW7DULNh8rzVb0EbSaotVr+wncIAMFOm5zyCOLyLPBELU5GL5YuOnC83J9dPTW1HSES64SgUMkUU8AJefkSOcakIqu5FxvsoxHCXLFR83O0ncCMzfkZyFKUXanYLo5p1cJa7V/VK1a0EJiqnJS5atCQ9Y0ytGWHzhhcqvIqay50dvQ0mNuk/rzIib//AXUNzzAAo1o18WFnqbAZrkID4V0161PG0O3op2rG8VmzSWq0pCe5/uXm5F8Zk2BUeJBR62ViHn+pM+tvu4x/HHxkJJXu42HjpjJcLe4VazfLPB5/VwDH7lw0NMheVGlcPpp0w89qDMef5qxK3MS+SPHmPl2mdIlLa9S/s1p5M0P/XQBHhPda1Lbu6sSFdbYTHmt7DhGL0RdseI93zleSS292fHDYxALxkoaBh3SUR34n3L1/zMTOPO2IAQcXkvqYn+LKPTWnI4cohTaCAPX7w/gdiGM+7tbO7qhfqTKrC+pqTNqIB8Fyc2vUhhQz9eb4yi1l4Yn5c0m32UdM6Xo1UpX7nkx6G3lThhewuuYbXcXeTXL1k5IfE0IEhsdhs+l6QYs5aiFK1oV9YOiA3vd2RQQUFAz5L9BOsU6g34fzO3QsMH0WTRqJOHQ9gY/8/cPjVs171SfGUiklpUA5LlJ+zhmboh73XNNs7ZKCuWnsXmX4g3DIIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186006)(1800799003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(54906003)(110136005)(2906002)(6636002)(4326008)(316002)(5660300002)(8936002)(8676002)(336012)(70206006)(70586007)(16526019)(86362001)(478600001)(82740400003)(81166007)(6666004)(7696005)(356005)(41300700001)(36756003)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:09:24.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542d1264-e9fb-4a08-649c-08db9725feac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register RAS fatal error interrupt and add handler.

v2: only register NBIO RAS for dGPU platform.
    change nbio_v7_9_set_ras_controller_irq_state and nbio_v7_9_set_ras_err_event_athub_irq_state
    to dummy functions.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   5 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  | 187 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h  |   1 +
 3 files changed, 193 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bb29cb57add5..00658c2816dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,6 +35,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "nbio_v4_3.h"
+#include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
 
@@ -2644,6 +2645,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			 * check DF RAS */
 			adev->nbio.ras = &nbio_v4_3_ras;
 		break;
+	case IP_VERSION(7, 9, 0):
+		if (!adev->gmc.is_app_apu)
+			adev->nbio.ras = &nbio_v7_9_ras;
+		break;
 	default:
 		/* nbio ras is not available */
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 1d1ab188ef15..781f98655567 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -471,3 +471,190 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
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
+	/* Dummy function, there is no initialization operation in driver */
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
+	/* Dummy function, there is no initialization operation in driver */
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

