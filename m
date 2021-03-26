Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A370FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947AD619FF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947AD619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C406F4C3;
	Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF746F4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WES3+oHX48Ngcvjaj9dXPzb8o4Z8BY6LTY48UiPtUmSxk5KqqtfA6SfsBVujTUPRxYN8Qhjwh3FhFs+7US3lfBOu7qEk3yLlPxSphBgtsPxQosqkO4jDPXnNuhWcsPMjnojZpNwFqynPNrnviGYmdf1FD0zCRzyKQx+ECU0RcXzwBCape6FYb05jw8wwt+UfnvIIadC8+v8VBitfyXnwKMAfu8f0v60cQxpYYUeIDw1xCnmyZgjfm7pDTiO4UIxfU/OE97WZzUUELgDAuZFvAgne7w9rAe6Le0USl4sSuT/7PFngMh5axwztbNMTLYBxCxay5b3DIGzI1jkoQKNRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot/YNmup9hrpBwBUXED2n3+KvntNUYt74ucT//P6fE0=;
 b=j/54U/7qglq0WU9UYf0vuJXrkQKPk6CAXIpwHI2sOn1BOmeCp0nT1xBZOA0yku4F29HAFO7ek8VAVRwDSzkHYNdiNXaUKvyj/T3w3pAXEXlo+yCbMjE5urrO2VJBIYuk+N3DuN+3Enf8aym8iGaza/OpKVz+uLqkHP3x/hERnFO0fety2XhTVNfvBOGqYqRCnxTAR/k8rSoudXu/XmDwUNhZRsg2JM8zH08MJtM1Z1Hlh8YbvX4l82KarS0/ZNcrEVM+JYBkiznjFU9WKB9KoRapSaYOBwYiOofYVyUHPyBBpDVz+t/DJ47lVzknbQznlbvz3Bhit4WEAo3AzNy+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot/YNmup9hrpBwBUXED2n3+KvntNUYt74ucT//P6fE0=;
 b=1iKAndYcUyrns7Vz0615MJlwdZaQoy5/+3FMrhlDB4UYgmYUSe0u/mvE6A2y73WI/2OrrzXUU84MCxanBQlBvl9LXGdj/4uPgWNkk7Kad2Kj+SSepCqEJ4jQ8hUSCgZMgIWTtyqX+qXI8/+6q3enHVBsjS5ao/koQGwMHljR2ec=
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:06:14 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::1a) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:12 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:11 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: Add dynamic link encoder selection.
Date: Fri, 26 Mar 2021 18:05:27 -0400
Message-ID: <20210326220534.918023-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82539d4-cf99-4a65-4eaa-08d8f0a35eed
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40121A457B96AC7EBF29A557EB619@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S93EY6cHEC2vU5+kTw1TGPGuLh7b8VWSnOPQQHbVVxLyS+1ifrKR7FNAonmeDaFuLCqVCnGsbI2LQEv86F5Ks1ESq9Q+uRSSTDgHhgUmvq1iC5fUupEJ+f/0lw+XPwNf8uarxqEwVQNXG6rUK9P3VTK7m1h1bseTDYEONkmLGeGEDtXHwf/Bhp5FLcvBmkS69VIbuttGFTTl9lb9h+ubSHXSb7gJzhAbSnx6JsILKLTygfvqCKgwSbetvcUgO53Mg+JoYFCyaN2EOSFsI2fXf4zzmZwSph+bq0Sc9bG1BnvvVrKx4FdGCd692FtYNzGgcfshfpNeMTIRJXmX3ci25p+V6mGeAjZczr5EDxOivFg7QSgj27qjmy2KLhlAFV9utung0DRcNWfiF3eHJFQxYA+j+MDeCVHvLZaEY8RVH19xH4zp5ja5ZcbxADE0Ii8U/LHfroC1ZrzTBgeIA0GQFncZpAC7VJCGOz0hI2xGe4cr5CKvyJIKKIh/VsBWa64oan1OxZtYNigOjqZfgU5h7kV9NzzH852TcHdzJ/x8G84+3W15Ta7UYtoPzPKoz8FHmdvQibAwRwP2pU3f1SkNPw/lKIGn4tido8qTwpFdAwJTUUHvamFt754yQkSLw+Y9k2XHijAXF+Og9d8pleHzZ5F9k5LHohDF98PfAlCWpNmdVYrsS61n3symfwrlchy5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(186003)(6666004)(2616005)(26005)(83380400001)(30864003)(426003)(36860700001)(356005)(336012)(1076003)(54906003)(36756003)(4326008)(316002)(70206006)(82310400003)(47076005)(81166007)(5660300002)(82740400003)(478600001)(2906002)(8676002)(86362001)(70586007)(6916009)(7696005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:13.5421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82539d4-cf99-4a65-4eaa-08d8f0a35eed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some display endpoints may be programmably mapped to compatible link
encoders. The assignment of link encoders to links has to be dynamic to
accommodate the increased flexibility in comparison to conventional
display endpoints.

[How]
- Add link encoder assignment tracking variables.
- Execute link encoder assignment algorithm before enabling link and
release link encoders from links once they are disabled.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 204 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  10 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  15 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  27 +++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  13 ++
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  68 ++++++
 11 files changed, 366 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index bbde6e6a4e43..f33847299bca 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -54,8 +54,9 @@ AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LI
 
 include $(AMD_DC)
 
-DISPLAY_CORE = dc.o dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
-dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o
+DISPLAY_CORE = dc.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
+dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
+dc_link_enc_cfg.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DISPLAY_CORE += dc_vm_helper.o
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d55c1dd6464c..12cb95c5a1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -52,6 +52,7 @@
 
 #include "link_hwss.h"
 #include "link_encoder.h"
+#include "link_enc_cfg.h"
 
 #include "dc_link_ddc.h"
 #include "dm_helpers.h"
@@ -870,6 +871,9 @@ static bool dc_construct(struct dc *dc,
 	if (!create_links(dc, init_params->num_virtual_links))
 		goto fail;
 
+	/* Initialise DIG link encoder resource tracking variables. */
+	link_enc_cfg_init(dc, dc->current_state);
+
 	return true;
 
 fail:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2cfb53387c55..719fc6b502b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -92,11 +92,14 @@ static void dc_link_destruct(struct dc_link *link)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
 	if (link->link_enc) {
-		/* Update link encoder tracking variables. These are used for the dynamic
-		 * assignment of link encoders to streams.
+		/* Update link encoder resource tracking variables. These are used for
+		 * the dynamic assignment of link encoders to streams. Virtual links
+		 * are not assigned encoder resources on creation.
 		 */
-		link->dc->res_pool->link_encoders[link->link_enc->preferred_engine] = NULL;
-		link->dc->res_pool->dig_link_enc_count--;
+		if (link->link_id.id != CONNECTOR_ID_VIRTUAL) {
+			link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = NULL;
+			link->dc->res_pool->dig_link_enc_count--;
+		}
 		link->link_enc->funcs->destroy(&link->link_enc);
 	}
 
@@ -1409,6 +1412,8 @@ static bool dc_link_construct(struct dc_link *link,
 	link->link_id =
 		bios->funcs->get_connector_id(bios, init_params->connector_index);
 
+	link->ep_type = DISPLAY_ENDPOINT_PHY;
+
 	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
 
 	if (bios->funcs->get_disp_connector_caps_info) {
@@ -1547,7 +1552,8 @@ static bool dc_link_construct(struct dc_link *link,
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
 	 */
-	link->dc->res_pool->link_encoders[link->link_enc->preferred_engine] = link->link_enc;
+	link->eng_id = link->link_enc->preferred_engine;
+	link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = link->link_enc;
 	link->dc->res_pool->dig_link_enc_count++;
 
 	link->link_enc_hw_inst = link->link_enc->transmitter;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
new file mode 100644
index 000000000000..c2bf9e5d9675
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "link_enc_cfg.h"
+#include "resource.h"
+#include "dc_link_dp.h"
+
+/* Check whether stream is supported by DIG link encoders. */
+static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
+{
+	bool is_dig_stream = false;
+	struct link_encoder *link_enc = NULL;
+	int i;
+
+	/* Loop over created link encoder objects. */
+	for (i = 0; i < stream->ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
+		link_enc = stream->ctx->dc->res_pool->link_encoders[i];
+
+		if (link_enc &&
+				((uint32_t)stream->signal & link_enc->output_signals)) {
+			if (dc_is_dp_signal(stream->signal)) {
+				/* DIGs do not support DP2.0 streams with 128b/132b encoding. */
+				struct dc_link_settings link_settings = {0};
+
+				decide_link_settings(stream, &link_settings);
+				if ((link_settings.link_rate >= LINK_RATE_LOW) &&
+						link_settings.link_rate <= LINK_RATE_HIGH3) {
+					is_dig_stream = true;
+					break;
+				}
+			} else {
+				is_dig_stream = true;
+				break;
+			}
+		}
+	}
+
+	return is_dig_stream;
+}
+
+/* Update DIG link encoder resource tracking variables in dc_state. */
+static void update_link_enc_assignment(
+		struct dc_state *state,
+		struct dc_stream_state *stream,
+		enum engine_id eng_id,
+		bool add_enc)
+{
+	int eng_idx;
+	int stream_idx;
+	int i;
+
+	if (eng_id != ENGINE_ID_UNKNOWN) {
+		eng_idx = eng_id - ENGINE_ID_DIGA;
+		stream_idx = -1;
+
+		/* Index of stream in dc_state used to update correct entry in
+		 * link_enc_assignments table.
+		 */
+		for (i = 0; i < state->stream_count; i++) {
+			if (stream == state->streams[i]) {
+				stream_idx = i;
+				break;
+			}
+		}
+
+		/* Update link encoder assignments table, link encoder availability
+		 * pool and link encoder assigned to stream in state.
+		 * Add/remove encoder resource to/from stream.
+		 */
+		if (stream_idx != -1) {
+			if (add_enc) {
+				state->res_ctx.link_enc_assignments[stream_idx] = (struct link_enc_assignment){
+					.valid = true,
+					.ep_id = (struct display_endpoint_id) {
+						.link_id = stream->link->link_id,
+						.ep_type = stream->link->ep_type},
+					.eng_id = eng_id};
+				state->res_ctx.link_enc_avail[eng_idx] = ENGINE_ID_UNKNOWN;
+				stream->link_enc = stream->ctx->dc->res_pool->link_encoders[eng_idx];
+			} else {
+				state->res_ctx.link_enc_assignments[stream_idx].valid = false;
+				state->res_ctx.link_enc_avail[eng_idx] = eng_id;
+				stream->link_enc = NULL;
+			}
+		} else {
+			dm_output_to_console("%s: Stream not found in dc_state.\n", __func__);
+		}
+	}
+}
+
+/* Return first available DIG link encoder. */
+static enum engine_id find_first_avail_link_enc(
+		struct dc_context *ctx,
+		struct dc_state *state)
+{
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+	int i;
+
+	for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
+		eng_id = state->res_ctx.link_enc_avail[i];
+		if (eng_id != ENGINE_ID_UNKNOWN)
+			break;
+	}
+
+	return eng_id;
+}
+
+void link_enc_cfg_init(
+		struct dc *dc,
+		struct dc_state *state)
+{
+	int i;
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
+		if (dc->res_pool->link_encoders[i])
+			state->res_ctx.link_enc_avail[i] = (enum engine_id) i;
+		else
+			state->res_ctx.link_enc_avail[i] = ENGINE_ID_UNKNOWN;
+	}
+}
+
+void link_enc_cfg_link_encs_assign(
+		struct dc *dc,
+		struct dc_state *state,
+		struct dc_stream_state *streams[],
+		uint8_t stream_count)
+{
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+	int i;
+
+	/* Release DIG link encoder resources before running assignment algorithm. */
+	for (i = 0; i < stream_count; i++)
+		dc->res_pool->funcs->link_enc_unassign(state, streams[i]);
+
+	/* (a) Assign DIG link encoders to physical (unmappable) endpoints first. */
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
+
+		/* Skip stream if not supported by DIG link encoder. */
+		if (!is_dig_link_enc_stream(stream))
+			continue;
+
+		/* Physical endpoints have a fixed mapping to DIG link encoders. */
+		if (!stream->link->is_dig_mapping_flexible) {
+			eng_id = stream->link->eng_id;
+			update_link_enc_assignment(state, stream, eng_id, true);
+		}
+	}
+
+	/* (b) Then assign encoders to mappable endpoints. */
+	eng_id = ENGINE_ID_UNKNOWN;
+
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
+
+		/* Skip stream if not supported by DIG link encoder. */
+		if (!is_dig_link_enc_stream(stream))
+			continue;
+
+		/* Mappable endpoints have a flexible mapping to DIG link encoders. */
+		if (stream->link->is_dig_mapping_flexible) {
+			eng_id = find_first_avail_link_enc(stream->ctx, state);
+			update_link_enc_assignment(state, stream, eng_id, true);
+		}
+	}
+}
+
+void link_enc_cfg_link_enc_unassign(
+		struct dc_state *state,
+		struct dc_stream_state *stream)
+{
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+
+	/* Only DIG link encoders. */
+	if (!is_dig_link_enc_stream(stream))
+		return;
+
+	if (stream->link_enc)
+		eng_id = stream->link_enc->preferred_engine;
+
+	update_link_enc_assignment(state, stream, eng_id, false);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3c91d16c2710..ac7a75887f95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1930,6 +1930,9 @@ enum dc_status dc_remove_stream_from_ctx(
 				dc->res_pool,
 			del_pipe->stream_res.stream_enc,
 			false);
+	/* Release link encoder from stream in new dc_state. */
+	if (dc->res_pool->funcs->link_enc_unassign)
+		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
 
 	if (del_pipe->stream_res.audio)
 		update_audio_usage(
@@ -2842,6 +2845,10 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.dsc != pipe_ctx->stream_res.dsc)
 		return true;
 
+	/* DIG link encoder resource assignment for stream changed. */
+	if (pipe_ctx_old->stream->link_enc != pipe_ctx->stream->link_enc)
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 7b927e634279..b0013e674864 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -132,6 +132,11 @@ struct dc_link {
 	uint8_t hpd_src;
 
 	uint8_t link_enc_hw_inst;
+	/* DIG link encoder ID. Used as index in link encoder resource pool.
+	 * For links with fixed mapping to DIG, this is not changed after dc_link
+	 * object creation.
+	 */
+	enum engine_id eng_id;
 
 	bool test_pattern_enabled;
 	union compliance_test_state compliance_test_state;
@@ -151,6 +156,11 @@ struct dc_link {
 	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
 	struct graphics_object_id link_id;
+	/* Endpoint type distinguishes display endpoints which do not have entries
+	 * in the BIOS connector table from those that do. Helps when tracking link
+	 * encoder to display endpoint assignments.
+	 */
+	enum display_endpoint_type ep_type;
 	union ddi_channel_mapping ddi_channel_mapping;
 	struct connector_device_tag_info device_tag;
 	struct dpcd_caps dpcd_caps;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e747370fc43b..2bc057e0b447 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -136,6 +136,10 @@ struct dc_stream_state {
 	struct dc_sink *sink;
 
 	struct dc_link *link;
+	/* For dynamic link encoder assignment, update the link encoder assigned to
+	 * a stream via the volatile dc_state rather than the static dc_link.
+	 */
+	struct link_encoder *link_enc;
 	struct dc_panel_patch sink_patches;
 	union display_content_support content_support;
 	struct dc_crtc_timing timing;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 80757a0ea7c6..b5e875ee9027 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -934,4 +934,19 @@ enum dc_psr_version {
 	DC_PSR_VERSION_UNSUPPORTED		= 0xFFFFFFFF,
 };
 
+/* Possible values of display_endpoint_id.endpoint */
+enum display_endpoint_type {
+	DISPLAY_ENDPOINT_PHY = 0, /* Physical connector. */
+	DISPLAY_ENDPOINT_UNKNOWN = -1
+};
+
+/* Extends graphics_object_id with an additional member 'ep_type' for
+ * distinguishing between physical endpoints (with entries in BIOS connector table) and
+ * logical endpoints.
+ */
+struct display_endpoint_id {
+	struct graphics_object_id link_id;
+	enum display_endpoint_type ep_type;
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index eb1a19bf0d81..81b92f20d5b6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -118,6 +118,27 @@ struct resource_funcs {
 		display_e2e_pipe_params_st *pipes,
 		bool fast_validate);
 
+	/*
+	 * Algorithm for assigning available link encoders to links.
+	 *
+	 * Update link_enc_assignments table and link_enc_avail list accordingly in
+	 * struct resource_context.
+	 */
+	void (*link_encs_assign)(
+			struct dc *dc,
+			struct dc_state *state,
+			struct dc_stream_state *streams[],
+			uint8_t stream_count);
+	/*
+	 * Unassign a link encoder from a stream.
+	 *
+	 * Update link_enc_assignments table and link_enc_avail list accordingly in
+	 * struct resource_context.
+	 */
+	void (*link_enc_unassign)(
+			struct dc_state *state,
+			struct dc_stream_state *stream);
+
 	enum dc_status (*validate_global)(
 		struct dc *dc,
 		struct dc_state *context);
@@ -358,6 +379,12 @@ struct resource_context {
 	uint8_t clock_source_ref_count[MAX_CLOCK_SOURCES];
 	uint8_t dp_clock_source_ref_count;
 	bool is_dsc_acquired[MAX_PIPES];
+	/* A table/array of encoder-to-link assignments. One entry per stream.
+	 * Indexed by stream index in dc_state.
+	 */
+	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
+	/* List of available link encoders. Uses engine ID as encoder identifier. */
+	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 7f5acd8fb918..80bc99500645 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -187,4 +187,17 @@ struct link_encoder_funcs {
 		struct link_encoder *enc);
 };
 
+/*
+ * Used to track assignments of links (display endpoints) to link encoders.
+ *
+ * Entry in link_enc_assignments table in struct resource_context.
+ * Entries only marked valid once encoder assigned to a link and invalidated once unassigned.
+ * Uses engine ID as identifier since PHY ID not relevant for USB4 DPIA endpoint.
+ */
+struct link_enc_assignment {
+	bool valid;
+	struct display_endpoint_id ep_id;
+	enum engine_id eng_id;
+};
+
 #endif /* LINK_ENCODER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
new file mode 100644
index 000000000000..ad641632eadd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef DC_INC_LINK_ENC_CFG_H_
+#define DC_INC_LINK_ENC_CFG_H_
+
+/* This module implements functionality for dynamically assigning DIG link
+ * encoder resources to display endpoints (links).
+ */
+
+#include "core_types.h"
+
+/*
+ * Initialise link encoder resource tracking.
+ */
+void link_enc_cfg_init(
+		struct dc *dc,
+		struct dc_state *state);
+
+/*
+ * Algorithm for assigning available DIG link encoders to streams.
+ *
+ * Update link_enc_assignments table and link_enc_avail list accordingly in
+ * struct resource_context.
+ *
+ * Loop over all streams twice:
+ * a) First assign encoders to unmappable endpoints.
+ * b) Then assign encoders to mappable endpoints.
+ */
+void link_enc_cfg_link_encs_assign(
+		struct dc *dc,
+		struct dc_state *state,
+		struct dc_stream_state *streams[],
+		uint8_t stream_count);
+
+/*
+ * Unassign a link encoder from a stream.
+ *
+ * Update link_enc_assignments table and link_enc_avail list accordingly in
+ * struct resource_context.
+ */
+void link_enc_cfg_link_enc_unassign(
+		struct dc_state *state,
+		struct dc_stream_state *stream);
+
+#endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
