Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79555C33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75020838
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tjJra00g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EE96EA42;
	Fri, 10 Jan 2020 14:47:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94616EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2VsWAhbYXdxSRbUTElkRzmBBG2OUDVN7vawNRGf5xI6tLEW9Aorr/z8auezysX0ebtayk7/OjBaTRaBoRp0OKRghUfw893lf6IfYQqnIW2IePDSw9Kfk7hpdp9W69KLE9ygP9fcZzl15qSajKSRJlaW44tNus6B0miCB9jMiA0kAlbXFUGDtQrg4t260lpkKg900baDVbS232pLZ/FfyC90taFYpny1lgw6CD5PiVbP6eQdoAmxm6o2Hs5PbvMldlTHE5FWk6mXLApmBnFM+8XpRzVnIiZdUcR2bj17YfX8emZ8WA8OjzrjL3Vqe1vuD/4vyNhENjKdRRzaFi0zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YG1ZJJ5wbCXsChe6ftBKOA1WCY+XRSVlUZi39op5o=;
 b=Re8j/+pf7FKwY8vEg7oA+J+p3JqXINpYgxW4HVTWY7WnElxCMqxQOgqJIPrnN0zxtvAChlkuuKbhpvdadYoCXXyTD7r9tI0mDPen42hPTyTn7F9BeNlmw5LlCpJf/LkQMqrdOVuiohnLhiyuAOJwqf7ieVg1w50hVFLZy0cJFLkDzDd6Jhd6yBH5igv2AjdcKQTAvhqh0D8E0nJM91ObAIA8szT7Tl6EKPRGzv277i8Z3skjUcIDHg8SFwwdg3uEQl0vUZHWjyKh/kevC+jW3+Ygnr3YwPIvjCN+35JWeD+wTbbCFOjWBZqrRA9Zn0uI7EtRiNNoJaucUXkT2O+i9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YG1ZJJ5wbCXsChe6ftBKOA1WCY+XRSVlUZi39op5o=;
 b=tjJra00gs1fUHr187ktPXR/BJDnS28Lzq3pTZXQZbiqgzoTkuJwMQUY5/AeSqARL4On8U3svAS/Km7eBj6PSPZbfmSK4hPXCVtuwaYlU6SCqR6bLWLVaTVYaByhyVByl4oCfEEzngknWMMEgjOShkbx3cvTc4ELrovK/1FvWw6M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/43] drm/amd/display: Driverside changes to support PSR in
 DMCUB
Date: Fri, 10 Jan 2020 09:46:32 -0500
Message-Id: <20200110144655.55845-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:37 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68cff196-02a3-43a1-2738-08d795dc099d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524E54D5B154E5F0F078D0598380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(30864003)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1s+ttX2XYKtGX7xkvlS1OhiGUBFXb7+WKJOhkRhIrlODyXBwIgtFJy1oxMYf4/U673JjQnl/zMAFOiKERSKwrMw2k9JItfEzC4wjjmctW+ueZqG3EJODPTkwWZ7bVvmiVFvU3fBjb5A0kkYA9ITf48rU2awMKjSR/gZ/6YPxDYf+jONjSvKU5fn1KJ8p9UcwCzuCyMIe5TfIEOIA3XglP01Iq2RdU5ZDFDSmxR34ZfEfDLvRxWXNRCuVrLLsYWUmk0A4ao/D3ZNe+13za5qZC7cim9euJ+iMrRwaFqNg8ShjGV8OZn/yqHTiDI0+eIfQ1HSfbC0OSzJA43sLZcUhSKTQUXC5Vqchep9t6Rzs6MI8y6H17y+M7w/LKFQHOEwoNLDZmH1Q7ie5XrIsGVumlP/AUxrY7YCMfs5HgW2wrdWf3N1hb7TfE1z5LDmOgg3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cff196-02a3-43a1-2738-08d795dc099d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:38.4631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppClS37cP5mgLJER0oII2KjioYJULwWbbKGBZ2jkmU/Yuxc7L9MIfW3eqXe3QS2YNIGAgZgwf6Lv5K8whQTkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Moving PSR from DMCU to DMCUB.

[How]
Add driverside PSR changes required to send inbox messages to fw.
These changes are non-functional until the psr structure allocation
is uncommented.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  22 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 220 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  47 ++++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   5 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  34 ++-
 6 files changed, 313 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cef8c1ba9797..0faf582084d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -45,6 +45,7 @@
 #include "dpcd_defs.h"
 #include "dmcu.h"
 #include "hw/clk_mgr.h"
+#include "../dce/dmub_psr.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -2404,10 +2405,11 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct dmub_psr *psr = dc->res_pool->psr;
 
-
-
-	if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_feature_enabled)
+	if ((psr != NULL) && link->psr_feature_enabled)
+		psr->funcs->set_psr_enable(psr, allow_active);
+	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 
 	link->psr_allow_active = allow_active;
@@ -2419,8 +2421,11 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct dmub_psr *psr = dc->res_pool->psr;
 
-	if (dmcu != NULL && link->psr_feature_enabled)
+	if (psr != NULL && link->psr_feature_enabled)
+		psr->funcs->get_psr_state(psr_state);
+	else if (dmcu != NULL && link->psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, psr_state);
 
 	return true;
@@ -2467,6 +2472,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 {
 	struct dc *dc;
 	struct dmcu *dmcu;
+	struct dmub_psr *psr;
 	int i;
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
@@ -2478,8 +2484,9 @@ bool dc_link_setup_psr(struct dc_link *link,
 
 	dc = link->ctx->dc;
 	dmcu = dc->res_pool->dmcu;
+	psr = dc->res_pool->psr;
 
-	if (!dmcu)
+	if (!dmcu && !psr)
 		return false;
 
 
@@ -2588,7 +2595,10 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->frame_delay = 0;
 
-	link->psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
+	if (psr)
+		link->psr_feature_enabled = psr->funcs->setup_psr(psr, link, psr_context);
+	else
+		link->psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
 	/* psr_enabled == 0 indicates setup_psr did not succeed, but this
 	 * should not happen since firmware should be running at this point
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
new file mode 100644
index 000000000000..225955ec6d39
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -0,0 +1,220 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dmub_psr.h"
+#include "dc.h"
+#include "dc_dmub_srv.h"
+#include "../../dmub/inc/dmub_srv.h"
+#include "dmub_fw_state.h"
+#include "core_types.h"
+#include "ipp.h"
+
+#define MAX_PIPES 6
+
+/**
+ * Get PSR state from firmware.
+ */
+static void dmub_get_psr_state(uint32_t *psr_state)
+{
+	// Not yet implemented
+	// Trigger GPINT interrupt from firmware
+}
+
+/**
+ * Enable/Disable PSR.
+ */
+static void dmub_set_psr_enable(struct dmub_psr *dmub, bool enable)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	cmd.psr_enable.header.type = DMUB_CMD__PSR;
+
+	if (enable)
+		cmd.psr_enable.header.sub_type = DMUB_CMD__PSR_ENABLE;
+	else
+		cmd.psr_enable.header.sub_type = DMUB_CMD__PSR_DISABLE;
+
+	cmd.psr_enable.header.payload_bytes = 0; // Send header only
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_enable.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
+/**
+ * Set PSR level.
+ */
+static void dmub_set_psr_level(struct dmub_psr *dmub, uint16_t psr_level)
+{
+	union dmub_rb_cmd cmd;
+	uint32_t psr_state = 0;
+	struct dc_context *dc = dmub->ctx;
+
+	dmub_get_psr_state(&psr_state);
+
+	if (psr_state == 0)
+		return;
+
+	cmd.psr_set_level.header.type = DMUB_CMD__PSR;
+	cmd.psr_set_level.header.sub_type = DMUB_CMD__PSR_SET_LEVEL;
+	cmd.psr_set_level.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_level_data);
+	cmd.psr_set_level.psr_set_level_data.psr_level = psr_level;
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_set_level.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
+/**
+ * Setup PSR by programming phy registers and sending psr hw context values to firmware.
+ */
+static bool dmub_setup_psr(struct dmub_psr *dmub,
+		struct dc_link *link,
+		struct psr_context *psr_context)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+	struct dmub_cmd_psr_copy_settings_data *copy_settings_data
+		= &cmd.psr_copy_settings.psr_copy_settings_data;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		if (res_ctx &&
+				res_ctx->pipe_ctx[i].stream &&
+				res_ctx->pipe_ctx[i].stream->link &&
+				res_ctx->pipe_ctx[i].stream->link == link &&
+				res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			pipe_ctx = &res_ctx->pipe_ctx[i];
+			break;
+		}
+	}
+
+	if (!pipe_ctx ||
+			!&pipe_ctx->plane_res ||
+			!&pipe_ctx->stream_res)
+		return false;
+
+	// Program DP DPHY fast training registers
+	link->link_enc->funcs->psr_program_dp_dphy_fast_training(link->link_enc,
+			psr_context->psrExitLinkTrainingRequired);
+
+	// Program DP_SEC_CNTL1 register to set transmission GPS0 line num and priority to high
+	link->link_enc->funcs->psr_program_secondary_packet(link->link_enc,
+			psr_context->sdpTransmitLineNumDeadline);
+
+	cmd.psr_copy_settings.header.type = DMUB_CMD__PSR;
+	cmd.psr_copy_settings.header.sub_type = DMUB_CMD__PSR_COPY_SETTINGS;
+	cmd.psr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_psr_copy_settings_data);
+
+	// Hw insts
+	copy_settings_data->dpphy_inst				= psr_context->phyType;
+	copy_settings_data->aux_inst				= psr_context->channel;
+	copy_settings_data->digfe_inst				= psr_context->engineId;
+	copy_settings_data->digbe_inst				= psr_context->transmitterId;
+
+	copy_settings_data->mpcc_inst				= pipe_ctx->plane_res.mpcc_inst;
+
+	if (pipe_ctx->plane_res.hubp)
+		copy_settings_data->hubp_inst			= pipe_ctx->plane_res.hubp->inst;
+	else
+		copy_settings_data->hubp_inst			= 0;
+	if (pipe_ctx->plane_res.dpp)
+		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
+	else
+		copy_settings_data->dpp_inst			= 0;
+	if (pipe_ctx->stream_res.opp)
+		copy_settings_data->opp_inst			= pipe_ctx->stream_res.opp->inst;
+	else
+		copy_settings_data->opp_inst			= 0;
+	if (pipe_ctx->stream_res.tg)
+		copy_settings_data->otg_inst			= pipe_ctx->stream_res.tg->inst;
+	else
+		copy_settings_data->otg_inst			= 0;
+
+	// Misc
+	copy_settings_data->psr_level				= psr_context->psr_level.u32all;
+	copy_settings_data->hyst_frames				= psr_context->timehyst_frames;
+	copy_settings_data->hyst_lines				= psr_context->hyst_lines;
+	copy_settings_data->phy_type				= psr_context->phyType;
+	copy_settings_data->aux_repeat				= psr_context->aux_repeats;
+	copy_settings_data->smu_optimizations_en	= psr_context->allow_smu_optimizations;
+	copy_settings_data->skip_wait_for_pll_lock	= psr_context->skipPsrWaitForPllLock;
+	copy_settings_data->frame_delay				= psr_context->frame_delay;
+	copy_settings_data->smu_phy_id				= psr_context->smuPhyId;
+	copy_settings_data->num_of_controllers		= psr_context->numberOfControllers;
+	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
+	copy_settings_data->phy_num					= psr_context->frame_delay & 0x7;
+	copy_settings_data->link_rate				= psr_context->frame_delay & 0xF;
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_copy_settings.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+static const struct dmub_psr_funcs psr_funcs = {
+	.set_psr_enable			= dmub_set_psr_enable,
+	.setup_psr				= dmub_setup_psr,
+	.get_psr_state			= dmub_get_psr_state,
+	.set_psr_level			= dmub_set_psr_level,
+};
+
+/**
+ * Construct PSR object.
+ */
+static void dmub_psr_construct(struct dmub_psr *psr, struct dc_context *ctx)
+{
+	psr->ctx = ctx;
+	psr->funcs = &psr_funcs;
+}
+
+/**
+ * Allocate and initialize PSR object.
+ */
+struct dmub_psr *dmub_psr_create(struct dc_context *ctx)
+{
+	struct dmub_psr *psr = kzalloc(sizeof(struct dmub_psr), GFP_KERNEL);
+
+	if (psr == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	dmub_psr_construct(psr, ctx);
+
+	return psr;
+}
+
+/**
+ * Deallocate PSR object.
+ */
+void dmub_psr_destroy(struct dmub_psr **dmub)
+{
+	kfree(dmub);
+	*dmub = NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
new file mode 100644
index 000000000000..229958de3035
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2012-16 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_PSR_H_
+#define _DMUB_PSR_H_
+
+#include "os_types.h"
+
+struct dmub_psr {
+	struct dc_context *ctx;
+	const struct dmub_psr_funcs *funcs;
+};
+
+struct dmub_psr_funcs {
+	void (*set_psr_enable)(struct dmub_psr *dmub, bool enable);
+	bool (*setup_psr)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
+	void (*get_psr_state)(uint32_t *psr_state);
+	void (*set_psr_level)(struct dmub_psr *dmub, uint16_t psr_level);
+};
+
+struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
+void dmub_psr_destroy(struct dmub_psr **dmub);
+
+
+#endif /* _DCE_DMUB_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 81e087e85721..0dd724de201a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -83,6 +83,7 @@
 #include "dcn21_resource.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
+#include "../dce/dmub_psr.h"
 
 #define SOC_BOUNDING_BOX_VALID false
 #define DC_LOGGER_INIT(logger)
@@ -1744,6 +1745,10 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
+	// Leave as NULL to not affect current dmcu psr programming sequence
+	// Will be uncommented when functionality is confirmed to be working
+	pool->base.psr = NULL;
+
 	pool->base.abm = dce_abm_create(ctx,
 			&abm_regs,
 			&abm_shift,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 16f6ef22367b..f285b76888fb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -212,6 +212,7 @@ struct resource_pool {
 
 	struct abm *abm;
 	struct dmcu *dmcu;
+	struct dmub_psr *psr;
 
 	const struct resource_funcs *funcs;
 	const struct resource_caps *res_cap;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b10728f33f62..d8fdf7e76ded 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -187,9 +187,28 @@ struct dmub_rb_cmd_dpphy_init {
 };
 
 struct dmub_cmd_psr_copy_settings_data {
-	uint32_t reg1;
-	uint32_t reg2;
-	uint32_t reg3;
+	uint16_t psr_level;
+	uint8_t hubp_inst;
+	uint8_t dpp_inst;
+	uint8_t mpcc_inst;
+	uint8_t opp_inst;
+	uint8_t otg_inst;
+	uint8_t digfe_inst;
+	uint8_t digbe_inst;
+	uint8_t dpphy_inst;
+	uint8_t aux_inst;
+	uint8_t hyst_frames;
+	uint8_t hyst_lines;
+	uint8_t phy_num;
+	uint8_t phy_type;
+	uint8_t aux_repeat;
+	uint8_t smu_optimizations_en;
+	uint8_t skip_wait_for_pll_lock;
+	uint8_t frame_delay;
+	uint8_t smu_phy_id;
+	uint8_t num_of_controllers;
+	uint8_t link_rate;
+	uint8_t frame_cap_ind;
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
@@ -206,10 +225,6 @@ struct dmub_rb_cmd_psr_set_level {
 	struct dmub_cmd_psr_set_level_data psr_set_level_data;
 };
 
-struct dmub_rb_cmd_psr_disable {
-	struct dmub_cmd_header header;
-};
-
 struct dmub_rb_cmd_psr_enable {
 	struct dmub_cmd_header header;
 };
@@ -224,8 +239,8 @@ struct dmub_rb_cmd_notify_vblank {
 };
 
 struct dmub_cmd_psr_notify_static_state_data {
-	uint32_t ss_int;   // Which static screen interrupt was triggered
-	uint32_t ss_enter; // Enter (1) or exit (0) static screen
+	uint32_t ss_int;	// Which static screen interrupt was triggered
+	uint32_t ss_enter;	// Enter (1) or exit (0) static screen
 };
 
 struct dmub_rb_cmd_psr_notify_static_state {
@@ -245,7 +260,6 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_dpphy_init dpphy_init;
 	struct dmub_rb_cmd_dig1_transmitter_control dig1_transmitter_control;
 	struct dmub_rb_cmd_psr_enable psr_enable;
-	struct dmub_rb_cmd_psr_disable psr_disable;
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
 };
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
