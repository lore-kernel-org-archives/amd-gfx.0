Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABC7C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 02:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DED10E425;
	Thu, 23 Mar 2023 02:24:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101BE10E425
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 02:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVbvgmXF2pQ5q44VhzbyA8mjMbZpmcIvyJGkMRFZJImi4tCON9+/AT0vluXXcZxV9anvVeR6jvlqec5DiMrRMaL7ooyvg6iChdY+5CmkfH9mHYRNFpnCuknHWjQ0NRtGbjkS03xtMkqk3cmSfR6VfaSufBj21VVgo6uu6pwHZ0NwzKms0XyeAHIk848d4HfSty2JIEfqtR5sMzi3GjcSCIbZDGSeoblF2M9EEyufnwRocdjGvQZ/bhZjYvnIzytLZA227jzFWrOoY5xBuq19LK3PwLZpOOMTpBzzPj59UVpmvbB4y4pxQiS+guZZkL6LThl++54H/gd7JiTRYRs6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI3/QhBqwcZxG/XPTDDmQEKuSBh1o0hUjn5/RXN/iyI=;
 b=d/hHWoIA+2ZSrLZsky7WSaPN6r2g8/M3AjNMHCDL6bKIYHOXiRU9pW2VSfKkG2PzQYVpsf3lOYc6+2krRkpIwhrqaGNUld9pArjskVeFNqPdKPRVQNmuYoOuxYPSQkEjvTfI/gNPHVwkvXKLTQxvKGihWoJHdgXrKCwCD1cS4Xlw0AuNHrJgd/8tG04ZpyYO8GIsMdv42W5qxwdzYPgf+ycbJ+yZ9MHwzZORmzpAE4ipXXjhyHiLtjTXDdQdqiRYZpGG/HIxMc5Z2wkBCDRHiXr/8S0X4HpdOW4wh13Hn+79TV/l8W6yQrD5wzKbPwbcOzRs1qlkAQlsNsOTtZVx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI3/QhBqwcZxG/XPTDDmQEKuSBh1o0hUjn5/RXN/iyI=;
 b=ajNmM+frMzM/kk1jnAdI0IWBpvBzP6SFwjv1qz+q7lgQE2fhy+5CcwEj0LAV5uMzMsx+/3vCY2N7/MwGK0s5m5iJf5fqK6DxKAq9DO+BpGBbiuBKcM6U3MOQfbYhrRwN5qUDrRJ574+/CK0VnPjWGVwn0odv3zVJSnobrHTMq40=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 02:24:01 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::bf) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 02:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 02:24:01 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 21:23:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
Date: Thu, 23 Mar 2023 10:23:44 +0800
Message-ID: <20230323022344.7533-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e57a32-681a-4368-bc3f-08db2b45aa24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C01s7141TTdB2N0c0f+HvMADxVYcCNtswhd5G+5R5oJf4vdeR3wDnQhn99I3ZMGAGO/X8yDkpidOfeLWxokgsixSPE7TDuTR8omugVqqyErCpRLvGFSYjI24JhIt+YpH1ivJk+TOyUGx/VlnbVbWuChvpi8bYaRwrurnsWXYNPEy+4cOY88wC/n61MjCR8Yeh67AWaj5OrZo9ucYsdIEGt/rL6fHIRePCB77MtlROhNbMUZZ+On9f7qR79GLYXscwUEk0QtLPcrvRO6QAodRpNvkM3KbyuJL7vioiAzPKKd5bhTXwThQ6PpQPN0RZVnFpazXi1lnDPfxDNvaQEcu4EPl6nGuYw9t8wZU4yoqiSMlLAMqmINWTgHI0S+/M/AfgCnt63uuo4nI6g3w5r91j2dhYls6PM+k9JJ9NhnUrGZ2NtkbAfYAMi/BMSXbrAhSSwcQ8H92qZn1qjkxB9G/focuKemUirSM+nuyxYYRxmMqOpCYfibcYwD8uSF4rXDL5jM2RHX7laHD9EuArOQnaExs46pau2U6OI7/qQjqVoaEgHuLwYgSXiQXPxNQggf4ITnPqyZOyh45U8LUGO5gVNJBHSr5filQG/fXUq30mqvIM9Z8c7SpkcoY+yh9aoBtkMPqyuQys8ID167rlaJuxxeMuxcrygtuPuLnMWfknGs1pdmD2P+kua87Svymcbhf1m7pnQHEg2BK+QnlGuludp9w0ln/qW2mwDLnx6OQWvw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(86362001)(356005)(426003)(316002)(5660300002)(36756003)(478600001)(336012)(70586007)(110136005)(81166007)(8676002)(41300700001)(70206006)(6636002)(8936002)(2906002)(36860700001)(1076003)(83380400001)(82740400003)(40480700001)(16526019)(6666004)(26005)(186003)(47076005)(7696005)(2616005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 02:24:01.0016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e57a32-681a-4368-bc3f-08db2b45aa24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU will stop working once fatal error is detected.
it will inform driver to do reset to recover from
the fatal error.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c  | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 15 ++++-
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c6dc3cd2a9de..5b1779021881 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,7 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
+#include "nbio_v4_3.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
 
@@ -2562,6 +2563,16 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->nbio.ras = &nbio_v7_4_ras;
 		break;
+	case IP_VERSION(4, 3, 0):
+		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
+			/* unlike other generation of nbio ras,
+			 * nbio v4_3 only support fatal error interrupt
+			 * to inform software that DF is freezed due to
+			 * system fatal error event. driver should not
+			 * enable nbio ras in such case. Instead,
+			 * check DF RAS */
+			adev->nbio.ras = &nbio_v4_3_ras;
+		break;
 	default:
 		/* nbio ras is not available */
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 09fdcd20cb91..d5ed9e0e1a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -26,6 +26,7 @@
 
 #include "nbio/nbio_4_3_0_offset.h"
 #include "nbio/nbio_4_3_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
@@ -538,3 +539,81 @@ const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs = {
 	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
 };
+
+static int nbio_v4_3_set_ras_err_event_athub_irq_state(struct amdgpu_device *adev,
+						       struct amdgpu_irq_src *src,
+						       unsigned type,
+						       enum amdgpu_interrupt_state state)
+{
+	/* The ras_controller_irq enablement should be done in psp bl when it
+	 * tries to enable ras feature. Driver only need to set the correct interrupt
+	 * vector for bare-metal and sriov use case respectively
+	 */
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+	bif_doorbell_int_cntl = REG_SET_FIELD(bif_doorbell_int_cntl,
+					      BIF_BX0_BIF_DOORBELL_INT_CNTL,
+					      RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE,
+					      (state == AMDGPU_IRQ_STATE_ENABLE) ? 0 : 1);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_cntl);
+
+	return 0;
+}
+
+static int nbio_v4_3_process_err_event_athub_irq(struct amdgpu_device *adev,
+						 struct amdgpu_irq_src *source,
+						 struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for err_event_athub_irq should be written
+	 * to bif ring. since bif ring is not enabled, just leave process callback
+	 * as a dummy one.
+	 */
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v4_3_ras_err_event_athub_irq_funcs = {
+	.set = nbio_v4_3_set_ras_err_event_athub_irq_state,
+	.process = nbio_v4_3_process_err_event_athub_irq,
+};
+
+static void nbio_v4_3_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_device *adev)
+{
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+	if (REG_GET_FIELD(bif_doorbell_int_cntl,
+			  BIF_DOORBELL_INT_CNTL,
+			  RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_int_cntl = REG_SET_FIELD(bif_doorbell_int_cntl,
+						BIF_DOORBELL_INT_CNTL,
+						RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_cntl);
+		amdgpu_ras_global_ras_isr(adev);
+	}
+}
+
+static int nbio_v4_3_init_ras_err_event_athub_interrupt(struct amdgpu_device *adev)
+{
+
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_err_event_athub_irq.funcs =
+		&nbio_v4_3_ras_err_event_athub_irq_funcs;
+	adev->nbio.ras_err_event_athub_irq.num_types = 1;
+
+	/* register ras err event athub interrupt
+	 * nbio v4_3 uses the same irq source as nbio v7_4 */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+			      &adev->nbio.ras_err_event_athub_irq);
+
+	return r;
+}
+
+struct amdgpu_nbio_ras nbio_v4_3_ras = {
+	.handle_ras_err_event_athub_intr_no_bifring = nbio_v4_3_handle_ras_err_event_athub_intr_no_bifring,
+	.init_ras_err_event_athub_interrupt = nbio_v4_3_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
index 711999ceedf4..399037cdf4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
@@ -29,5 +29,6 @@
 extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v4_3_funcs;
 extern const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs;
+extern struct amdgpu_nbio_ras nbio_v4_3_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 67580761b44d..514bfc705d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -754,6 +754,14 @@ static int soc21_common_late_init(void *handle)
 							     sriov_vcn_4_0_0_video_codecs_decode_array_vcn0,
 							     ARRAY_SIZE(sriov_vcn_4_0_0_video_codecs_decode_array_vcn0));
 		}
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			/* don't need to fail gpu late init
+			 * if enabling athub_err_event interrupt failed
+			 * nbio v4_3 only support fatal error hanlding
+			 * just enable the interrupt directly */
+			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
 	return 0;
@@ -801,8 +809,13 @@ static int soc21_common_hw_fini(void *handle)
 	/* disable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, false);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_put_irq(adev);
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
 
 	return 0;
 }
-- 
2.17.1

