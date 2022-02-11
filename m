Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6B510EB3F;
	Fri, 11 Feb 2022 21:52:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC5510EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgM3KAwl27HhqCOWroQE3gfHTukW/LaYg4KS6GYKfxB2UxOkiTkdZjoID4WbAsm2hQOIKom8P4ArzmhPMm9Lksrz6+3UGAOt2DqoV50MQUYOR/EfXBl9bVKAj56ESrjWonO5aYPloom3j1kF5G+9EmLXJQsry64hSKtbznknJeUn+vAjhQj4bW7LViDMC265zXDy7FaSadLdGBjimkf4i8fbxIPSL1NlikhcBuEF66fO4paNk4L+qzDnI0w8rsptCZOjclCU7uuT7JlrMxYS0fdjW9n1EdR+u3c032AoP+hWtO/i87uj/Fxq8GwVBFL3AfsKEznSlXT4OD9MNvWRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/kdt/GcfgLt8VhgD6Qg6A3GfA/GNSdwikCByWClUzc=;
 b=jEnlCnugL8fJHNMe6lXEeBztpzRaA/ikOuH8nHHGQSGA/dahImJ9Yj0pnM0Shjd0CsoTJGUUCwXyPeTT6x2/jyKy8ioozPAWo95bKHm3lL8mEoJQcP1Sytn6CwB0JsroEi4AM2XXNJ1kfLrZgnFYSS8N1mJlHGAqpiC5YhypVcdqVA3ccOTjnnLmDSMLZBCY9a8O9uFsDNlVZ8vrfqDudwZSRCR69CtmeEdytKC2LSeBPPmofFBnYMEtPbOE1NNG4LmoD2NWXrxDdBUQMwVuDZWgZLqrFodMBIuUNGuHytklz6+XitJmvfuQadh1dCzF+L8W8E66my11iVQ75fRNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/kdt/GcfgLt8VhgD6Qg6A3GfA/GNSdwikCByWClUzc=;
 b=44h4uL1tdd92xsMjL9qAOLhXhURv1WEVCBPEr5r8GmiAX4G7Bnn7iqaL53PWvTWrGb5ArwWm/61WY037mw+4R8V/kRk7coafBupbJ5gsWJdGpgEJuE1dxde77+MVCugGxvJVovBu9VSg8vo+LdHbEv5JjiJDyjggg553FQM2uhE=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by BL0PR12MB4753.namprd12.prod.outlook.com (2603:10b6:208:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 21:52:02 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ec) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:02 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:51:56 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Fix for dmub outbox notification enable
Date: Fri, 11 Feb 2022 16:51:33 -0500
Message-ID: <20220211215142.94169-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f79bdb7-6d9f-4891-6679-08d9eda8bcc2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4753:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB475354D221F75E2D2C4AFDBFFB309@BL0PR12MB4753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrlfpZxLHfBmz32VRWc27IFir0PUlAS3akxjtEaWf9GTvphHjwzvNUYWYo7BliTG0TbawfHG83KmIuREXLVcYdVMltCuCs5JB6Ec7GzD2xuwN6b5EztTwI6A+X1nLRt/8+uGgTpnLoua4GsqfyGZEMxb6G+Cmb9hlemnH09MvmDAL1xgMo8n3scyaeKDkX8e5t5OW9a60TV3Xenp43kGYTSR8aGP8BQ0+fjvAQ4+EF7Wf61kwCxPJsXyBZxdlrV+KoxPO8s1dCIDBWyhZgbRPOdC/gtjEHPyeOa9Vsl9TyryfHalhH1IxZaR+BsZ7Q4S28w1T50YZD53TMB31dURI4c7OArZs/yMbnFK7nN7Hd0zkrDGuiuiJz9YaV24Awhz8b1TPaJNyEOono49lnYas5QehnHuiw2TyqIgdz75j4Z8B7Bjgn046RZeHZA2IPSpEJ6VeaWFz/2bHloBdmKReek7nuWYJWmdfPETpklm0beZyy/I+Loo4UOjkRSDBO/86M8CzxCF3CjyKYRpCSgpMO1VHjp6NxLfk8u6C9GWLhz8GzQahjpotrF0SoODDp/63ibuZl7h2X2v9W5n1rBZa7T6jzzXtO8jWVgw/UvBexXUfLb/Hw8TFvHilyq3pyNbFxckUceXSf1hIJE3pTlvF3cko+GWfIIGyMXzPXR5ZNNsNeSFY+J/AcNlRd0/JCB9BVsrlWw4rBU8rXZPxJj6KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(426003)(336012)(54906003)(26005)(1076003)(6916009)(186003)(2616005)(16526019)(70206006)(8936002)(4326008)(8676002)(316002)(70586007)(36860700001)(2906002)(356005)(81166007)(508600001)(82310400004)(6666004)(47076005)(83380400001)(36756003)(15650500001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:02.4750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79bdb7-6d9f-4891-6679-08d9eda8bcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4753
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Meenakshikumar
 Somasundaram <meenakshikumar.somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Currently driver enables dmub outbox notification before oubox ISR is
registered. During boot scenario, sometimes dmub issues hpd outbox
message before driver registers ISR and those messages are missed.

[How]
Enable dmub outbox notification after outbox ISR is registered. Also,
restructured outbox enable code to call from dm layer and renamed APIs.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 66 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  | 25 +++----
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.h  |  4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 --
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 6 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 467f606ba2c7..7ebd9ba5f3e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -76,6 +76,8 @@
 
 #include "dc_trace.h"
 
+#include "dce/dmub_outbox.h"
+
 #define CTX \
 	dc->ctx
 
@@ -3703,13 +3705,23 @@ void dc_hardware_release(struct dc *dc)
 }
 #endif
 
-/**
- * dc_enable_dmub_notifications - Returns whether dmub notification can be enabled
- * @dc: dc structure
+/*
+ *****************************************************************************
+ * Function: dc_is_dmub_outbox_supported -
+ * 
+ * @brief 
+ *      Checks whether DMUB FW supports outbox notifications, if supported
+ *		DM should register outbox interrupt prior to actually enabling interrupts
+ *		via dc_enable_dmub_outbox
  *
- * Returns: True to enable dmub notifications, False otherwise
+ *  @param
+ *		[in] dc: dc structure
+ *
+ *  @return
+ *		True if DMUB FW supports outbox notifications, False otherwise
+ *****************************************************************************
  */
-bool dc_enable_dmub_notifications(struct dc *dc)
+bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* YELLOW_CARP B0 USB4 DPIA needs dmub notifications for interrupts */
@@ -3724,6 +3736,48 @@ bool dc_enable_dmub_notifications(struct dc *dc)
 
 /**
  * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via inbox message
+ *  Function: dc_enable_dmub_notifications
+ *
+ *  @brief
+ *		Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
+ *		notifications. All DMs shall switch to dc_is_dmub_outbox_supported.
+ *		This API shall be removed after switching.
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *
+ *  @return
+ *		True if DMUB FW supports outbox notifications, False otherwise
+ *****************************************************************************
+ */
+bool dc_enable_dmub_notifications(struct dc *dc)
+{
+	return dc_is_dmub_outbox_supported(dc);
+}
+
+/**
+ *****************************************************************************
+ *  Function: dc_enable_dmub_outbox
+ *
+ *  @brief
+ *		Enables DMUB unsolicited notifications to x86 via outbox
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *
+ *  @return
+ *		None
+ *****************************************************************************
+ */
+void dc_enable_dmub_outbox(struct dc *dc)
+{
+	struct dc_context *dc_ctx = dc->ctx;
+
+	dmub_enable_outbox_notification(dc_ctx->dmub_srv);
+}
+
+/**
+ *****************************************************************************
  *                                      Sets port index appropriately for legacy DDC
  * @dc: dc structure
  * @link_index: link index
@@ -3825,7 +3879,7 @@ uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
  *		[in] payload: aux payload
  *		[out] notify: set_config immediate reply
  *
- *	@return
+ *  @return
  *		True if successful, False if failure
  *****************************************************************************
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fcb021bf0c96..2957758a7abd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1443,8 +1443,11 @@ void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
 #endif
 
+bool dc_is_dmub_outbox_supported(struct dc *dc);
 bool dc_enable_dmub_notifications(struct dc *dc);
 
+void dc_enable_dmub_outbox(struct dc *dc);
+
 bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				uint32_t link_index,
 				struct aux_payload *payload);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
index faad8555ddbb..fff1d07d865d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
@@ -22,20 +22,23 @@
  * Authors: AMD
  */
 
-#include "dmub_outbox.h"
+#include "dc.h"
 #include "dc_dmub_srv.h"
+#include "dmub_outbox.h"
 #include "dmub/inc/dmub_cmd.h"
 
-/**
- *  dmub_enable_outbox_notification - Sends inbox cmd to dmub to enable outbox1
- *                                    messages with interrupt. Dmub sends outbox1
- *                                    message and triggers outbox1 interrupt.
- * @dc: dc structure
+/*
+ *  Function: dmub_enable_outbox_notification
+ *
+ *  @brief
+ *		Sends inbox cmd to dmub for enabling outbox notifications to x86.
+ *
+ *  @param
+ *		[in] dmub_srv: dmub_srv structure
  */
-void dmub_enable_outbox_notification(struct dc *dc)
+void dmub_enable_outbox_notification(struct dc_dmub_srv *dmub_srv)
 {
 	union dmub_rb_cmd cmd;
-	struct dc_context *dc_ctx = dc->ctx;
 
 	memset(&cmd, 0x0, sizeof(cmd));
 	cmd.outbox1_enable.header.type = DMUB_CMD__OUTBOX1_ENABLE;
@@ -45,7 +48,7 @@ void dmub_enable_outbox_notification(struct dc *dc)
 		sizeof(cmd.outbox1_enable.header);
 	cmd.outbox1_enable.enable = true;
 
-	dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
-	dc_dmub_srv_wait_idle(dc_ctx->dmub_srv);
+	dc_dmub_srv_cmd_queue(dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dmub_srv);
+	dc_dmub_srv_wait_idle(dmub_srv);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
index 4e0aa0d1a2d5..58ceabb9d497 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
@@ -26,8 +26,8 @@
 #ifndef _DMUB_OUTBOX_H_
 #define _DMUB_OUTBOX_H_
 
-#include "dc.h"
+struct dc_dmub_srv;
 
-void dmub_enable_outbox_notification(struct dc *dc);
+void dmub_enable_outbox_notification(struct dc_dmub_srv *dmub_srv);
 
 #endif /* _DMUB_OUTBOX_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 915eecb40788..8dc1afc03961 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1500,10 +1500,6 @@ void dcn10_init_hw(struct dc *dc)
 				hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 	}
 
-	/* Enable outbox notification feature of dmub */
-	if (dc->debug.enable_dmub_aux_for_legacy_ddc)
-		dmub_enable_outbox_notification(dc);
-
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index b2cfd277b913..ef72d2b82d64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -194,7 +194,7 @@ void dcn31_init_hw(struct dc *dc)
 
 	/* Enables outbox notifications for usb4 dpia */
 	if (dc->res_pool->usb4_dpia_count)
-		dmub_enable_outbox_notification(dc);
+		dmub_enable_outbox_notification(dc->ctx->dmub_srv);
 
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
-- 
2.25.1

