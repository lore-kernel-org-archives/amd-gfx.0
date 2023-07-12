Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124F0EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F9810E5B2;
	Wed, 12 Jul 2023 17:14:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E462F10E5B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoz/tx9K0UuNhHHEw71Ew3XO5FI5ICfm77/rMTXEYENy251wkd4vYP69h+jeyNcBUFh5zRbVMd+c5MJdwdKwCtHNFiJFQ2SNB3kKuFRcVUpxqcgJTC0TCMKBGMlprzFFCW46Sk9KuW+ryqDGeVZkn0koAfMJql5qflibmC+wyX4TWoROBrF0bd9+tkI2b1GTflSeLi9DnxGOmgf57QOIGEZh73mZ+tMhREiUAyl1MYDZVgLj/WfDY0wFTUVuoJ4w3yWJpETBfreaJpLfj8L5eNr2lnvXdPcQyoFbzmks9Jo0d0/qRRuvlLpsI0hCW3i/lnrm8y/GBGdx7Xj/vOXD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3WZpVun/hahksI4aLEDaf8wOC5wjJYmlvuN1ENU5Fc=;
 b=W0rQoSsG5TU+XbNEVZtVf+dvyuPPZNY7tp4D/ha1u52niwJcIXlLqsrhfCz4IcTBcBMBfdxEPkMXbCp0MYYm9MSNZtfsNVOuCWIL6DZjH4WoL4KsNBsQn0lNZwNlGw410Bz/pSrK42cn7LyG4hUQNxdAY7kb4BwGE3QA8ydXqlk1iV4or5lHWv6GfJlAvrZ790zZPQgH9Qa2ceNVg6sD00DGx1OCBxuOt075ZhnTvmAM2AG7TxtqbUi2MylMzLjyE24GtZIxhBE4m3bHLevJJRunH7l2jv5z4/tCQkBitxVVALlJZeLfMJ+WXS22nfC1WK8VbOeLux+QtHVMa9TAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3WZpVun/hahksI4aLEDaf8wOC5wjJYmlvuN1ENU5Fc=;
 b=vikBy54TPWDJzR3R06Jl52kx4+dcrn5S//peegYge26uJqtTurcXJc+dDGV8l1BhTYfu4aXNOqjwhz78NeNGmd2qucjQzOMCg1lWgfhoJY/vQBXwqLLpj7JqJRVljw1Pc1tTxB5K+Y0uZVYBeNdD1zJ06hSyCojnh6T5Fq/c9PQ=
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:14:13 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::bd) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:13 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:09 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: ABM pause toggle
Date: Thu, 13 Jul 2023 01:11:28 +0800
Message-ID: <20230712171137.3398344-25-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd6fdfe-5529-4ed8-55db-08db82fb6a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0FbZUeQrddj57eCKB59wY2JWDih5QCTuMnfCtInXIuwoIrATD2gBkMQLT2BPMIiHXeVXCzcWzpgAq0DjFcw0zN+TF6wpR3bI3VMyS5fWZMc4PDwhQDi/89bBkoHUF8gkDNqus32Aql4WKhDQnZRb/IMpVk54HlxGDgWJ5d7pyWbTyIpTaUG0gLHRDewxPHSjKXqdRw4oiVSvl2XT3G9GKWSxdnmORyftjn8AVvoy5BGiLuosnDEQINMnZxq1E1eTpmJMfdmY23PA2NsSIlkHbkoL575c7RCXi5DPZH4XcvH8A0vHB8QUwzkuoD7aG4U7XywZgT7q3N4uxQ6i0inhXC/ycfWdRe3luBzXLF7Tt6EjCJXzVXZEY4KTXTWjcBkIao3NhrTlGEVBxsTcsMvKTqdCNuzOmLajEDelphUsM4GSIO5rnufFvIkdUcyC/wtjIgaWhQDsuv56YDWNTgDLguj2zC+mN2b7pSvlwqn9QAW3tejiVaGJ47RXTQr1xhThXdEdLVwmdCRp/R1ILa9A5c5l6wJIlsQ7bawKLoL4fFvYUyqfjNV/JeGiZEVIHn2nLPVqDAUCs09UmBoGEmfi7H+YfIvqDoqrqwa+NzPXMjYWm0YFuuiFKcK4SUmj83asgXFOgtWvYaIGAnuxJK0NOJ8rE909SsE7yMJkkfNQs9zOHl2ActXoSkXJnMSAX61/E2W06cGVxtNdgF5bIHr9/ys/kUC0G6dhtJ6FYap6q6eY4utdBrqynykNSUoNqz4MkAyySxILmekSiSBOPD50g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(4326008)(70586007)(70206006)(82310400005)(356005)(81166007)(86362001)(186003)(336012)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(83380400001)(426003)(36756003)(478600001)(7696005)(6666004)(54906003)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(30864003)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:13.4574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd6fdfe-5529-4ed8-55db-08db82fb6a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>,
 Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Harry Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <reza.amini@amd.com>

[why]
Allow ABM states to be transferred across display
adapters for smooth display transitions.

[how]
We call DMUB to pause and get ABM states. We
transfer data to other gpu, and deliver data and
ask ABM to un-pause.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Reza Amini <reza.amini@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  53 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  28 ++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  46 ++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 131 ++++++++++++++++++
 7 files changed, 277 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4284a3609e98..5d29b0aa6056 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5276,3 +5276,56 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
+
+/*****************************************************************************
+ *  dc_abm_save_restore() - Interface to DC for save+pause and restore+un-pause
+ *                          ABM
+ *  @dc: dc structure
+ *	@stream: stream where vsync int state changed
+ *  @pData: abm hw states
+ *
+ ****************************************************************************/
+bool dc_abm_save_restore(
+		struct dc *dc,
+		struct dc_stream_state *stream,
+		struct abm_save_restore *pData)
+{
+	int i;
+	int edp_num;
+	struct pipe_ctx *pipe = NULL;
+	struct dc_link *link = stream->sink->link;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+
+
+	/*find primary pipe associated with stream*/
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && pipe->stream_res.tg)
+			break;
+	}
+
+	if (i == MAX_PIPES) {
+		ASSERT(0);
+		return false;
+	}
+
+	dc_get_edp_links(dc, edp_links, &edp_num);
+
+	/* Determine panel inst */
+	for (i = 0; i < edp_num; i++)
+		if (edp_links[i] == link)
+			break;
+
+	if (i == edp_num)
+		return false;
+
+	if (pipe->stream_res.abm &&
+		pipe->stream_res.abm->funcs->save_restore)
+		return pipe->stream_res.abm->funcs->save_restore(
+				pipe->stream_res.abm,
+				i,
+				pData);
+	return false;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b0f53ef8c848..b9e5d217573c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -40,6 +40,8 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
+struct abm_save_restore;
+
 /* forward declaration */
 struct aux_payload;
 struct set_config_cmd_payload;
@@ -2243,6 +2245,11 @@ void dc_z10_save_init(struct dc *dc);
 bool dc_is_dmub_outbox_supported(struct dc *dc);
 bool dc_enable_dmub_notifications(struct dc *dc);
 
+bool dc_abm_save_restore(
+		struct dc *dc,
+		struct dc_stream_state *stream,
+		struct abm_save_restore *pData);
+
 void dc_enable_dmub_outbox(struct dc *dc);
 
 bool dc_process_dmub_aux_transfer_async(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 2fb9572ce25d..d3e6544022b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -27,6 +27,7 @@
 #include "dmub_abm_lcd.h"
 #include "dc.h"
 #include "core_types.h"
+#include "dmub_cmd.h"
 
 #define TO_DMUB_ABM(abm)\
 	container_of(abm, struct dce_abm, base)
@@ -118,6 +119,32 @@ static bool dmub_abm_set_pause_ex(struct abm *abm, bool pause, unsigned int pane
 	return ret;
 }
 
+/*****************************************************************************
+ *  dmub_abm_save_restore_ex() - calls dmub_abm_save_restore for preserving DMUB's
+ *                              Varibright states for LCD only. OLED is TBD
+ *  @abm: used to check get dc context
+ *  @panel_inst: panel instance index
+ *  @pData: contains command to pause/un-pause abm and abm parameters
+ *
+ *
+ ***************************************************************************/
+static bool dmub_abm_save_restore_ex(
+		struct abm *abm,
+		unsigned int panel_inst,
+		struct abm_save_restore *pData)
+{
+	bool ret = false;
+	unsigned int feature_support;
+	struct dc_context *dc = abm->ctx;
+
+	feature_support = abm_feature_support(abm, panel_inst);
+
+	if (feature_support == ABM_LCD_SUPPORT)
+		ret = dmub_abm_save_restore(dc, panel_inst, pData);
+
+	return ret;
+}
+
 static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
 {
 	bool ret = false;
@@ -155,6 +182,7 @@ static const struct abm_funcs abm_funcs = {
 	.get_target_backlight = dmub_abm_get_target_backlight_ex,
 	.init_abm_config = dmub_abm_init_config_ex,
 	.set_abm_pause = dmub_abm_set_pause_ex,
+	.save_restore = dmub_abm_save_restore_ex,
 	.set_pipe_ex = dmub_abm_set_pipe_ex,
 	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm_ex,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 39da73eba86e..592a8f7a1c6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -208,6 +208,52 @@ bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, un
 	return true;
 }
 
+
+/*****************************************************************************
+ *  dmub_abm_save_restore() - dmub interface for abm save+pause and restore+
+ *                           un-pause
+ *  @dc: dc context
+ *  @panel_inst: panel instance index
+ *  @pData: contains command to pause/un-pause abm and exchange abm parameters
+ *
+ *  When called Pause will get abm data and store in pData, and un-pause will
+ *  set/apply abm data stored in pData.
+ *
+ *****************************************************************************/
+bool dmub_abm_save_restore(
+		struct dc_context *dc,
+		unsigned int panel_inst,
+		struct abm_save_restore *pData)
+{
+	union dmub_rb_cmd cmd;
+	uint8_t panel_mask = 0x01 << panel_inst;
+	unsigned int bytes = sizeof(struct abm_save_restore);
+
+	// TODO: Optimize by only reading back final 4 bytes
+	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+
+	// Copy iramtable into cw7
+	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)pData, bytes);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_save_restore.header.type = DMUB_CMD__ABM;
+	cmd.abm_save_restore.header.sub_type = DMUB_CMD__ABM_SAVE_RESTORE;
+
+	cmd.abm_save_restore.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.abm_save_restore.abm_init_config_data.bytes = bytes;
+	cmd.abm_save_restore.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_save_restore.abm_init_config_data.panel_mask = panel_mask;
+
+	cmd.abm_save_restore.header.payload_bytes = sizeof(struct dmub_rb_cmd_abm_save_restore);
+
+	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	// Copy iramtable data into local structure
+	memcpy((void *)pData, dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, bytes);
+
+	return true;
+}
+
 bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 00b4e268768e..853564d7f471 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -28,6 +28,8 @@
 
 #include "abm.h"
 
+struct abm_save_restore;
+
 void dmub_abm_init(struct abm *abm, uint32_t backlight);
 bool dmub_abm_set_level(struct abm *abm, uint32_t level, uint8_t panel_mask);
 unsigned int dmub_abm_get_current_backlight(struct abm *abm);
@@ -38,6 +40,10 @@ void dmub_abm_init_config(struct abm *abm,
 	unsigned int inst);
 
 bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst);
+bool dmub_abm_save_restore(
+		struct dc_context *dc,
+		unsigned int panel_inst,
+		struct abm_save_restore *pData);
 bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
 bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index d2190a3320f6..33db15d69f23 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -27,6 +27,8 @@
 
 #include "dm_services_types.h"
 
+struct abm_save_restore;
+
 struct abm {
 	struct dc_context *ctx;
 	const struct abm_funcs *funcs;
@@ -55,6 +57,10 @@ struct abm_funcs {
 			unsigned int bytes,
 			unsigned int inst);
 	bool (*set_abm_pause)(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int otg_inst);
+	bool (*save_restore)(
+			struct abm *abm,
+			unsigned int panel_inst,
+			struct abm_save_restore *pData);
 	bool (*set_pipe_ex)(struct abm *abm,
 			unsigned int otg_inst,
 			unsigned int option,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index af1f50742371..15fea2bcb34a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -144,6 +144,96 @@
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
 
+#define ABM_NUM_OF_ACE_SEGMENTS         5
+
+union abm_flags {
+	struct {
+		/**
+		 * @abm_enabled: indicates if abm is enabled.
+		 */
+		unsigned int abm_enabled : 1;
+
+		/**
+		 * @disable_abm_requested: indicates if driver has requested abm to be disabled.
+		 */
+		unsigned int disable_abm_requested : 1;
+
+		/**
+		 * @disable_abm_immediately: indicates if driver has requested abm to be disabled immediately.
+		 */
+		unsigned int disable_abm_immediately : 1;
+
+		/**
+		 * @disable_abm_immediate_keep_gain: indicates if driver has requested abm
+		 * to be disabled immediately and keep gain.
+		 */
+		unsigned int disable_abm_immediate_keep_gain : 1;
+
+		/**
+		 * @fractional_pwm: indicates if fractional duty cycle for backlight pwm is enabled.
+		 */
+		unsigned int fractional_pwm : 1;
+
+		/**
+		 * @abm_gradual_bl_change: indicates if algorithm has completed gradual adjustment
+		 * of user backlight level.
+		 */
+		unsigned int abm_gradual_bl_change : 1;
+	} bitfields;
+
+	unsigned int u32all;
+};
+
+struct abm_save_restore {
+	/**
+	 * @flags: Misc. ABM flags.
+	 */
+	union abm_flags flags;
+
+	/**
+	 * @pause: true:  pause ABM and get state
+	 *         false: un-pause ABM after setting state
+	 */
+	uint32_t pause;
+
+	/**
+	 * @next_ace_slope: Next ACE slopes to be programmed in HW (u3.13)
+	 */
+	uint32_t next_ace_slope[ABM_NUM_OF_ACE_SEGMENTS];
+
+	/**
+	 * @next_ace_thresh: Next ACE thresholds to be programmed in HW (u10.6)
+	 */
+	uint32_t next_ace_thresh[ABM_NUM_OF_ACE_SEGMENTS];
+
+	/**
+	 * @next_ace_offset: Next ACE offsets to be programmed in HW (u10.6)
+	 */
+	uint32_t next_ace_offset[ABM_NUM_OF_ACE_SEGMENTS];
+
+
+	/**
+	 * @knee_threshold: Current x-position of ACE knee (u0.16).
+	 */
+	uint32_t knee_threshold;
+	/**
+	 * @current_gain: Current backlight reduction (u16.16).
+	 */
+	uint32_t current_gain;
+	/**
+	 * @curr_bl_level: Current actual backlight level converging to target backlight level.
+	 */
+	uint16_t curr_bl_level;
+
+	/**
+	 * @curr_user_bl_level: Current nominal backlight level converging to level requested by user.
+	 */
+	uint16_t curr_user_bl_level;
+
+};
+
+
+
 /**
  * OS/FW agnostic memcpy
  */
@@ -2672,6 +2762,12 @@ enum dmub_cmd_abm_type {
 	 * unregister vertical interrupt after steady state is reached
 	 */
 	DMUB_CMD__ABM_PAUSE	= 6,
+
+	/**
+	 * * Save and Restore ABM state. On save we save parameters, and
+	 * on restore we update state with passed in data.
+	 */
+	DMUB_CMD__ABM_SAVE_RESTORE	= 7,
 };
 
 /**
@@ -3071,6 +3167,36 @@ struct dmub_rb_cmd_abm_pause {
 	struct dmub_cmd_abm_pause_data abm_pause_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SAVE_RESTORE command.
+ */
+struct dmub_rb_cmd_abm_save_restore {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * OTG hw instance
+	 */
+	uint8_t otg_inst;
+
+	/**
+	 * Enable or disable ABM pause
+	 */
+	uint8_t freeze;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t debug;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_INIT_CONFIG command.
+	 */
+	struct dmub_cmd_abm_init_config_data abm_init_config_data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
  */
@@ -3508,6 +3634,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_pause abm_pause;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_SAVE_RESTORE command.
+	 */
+	struct dmub_rb_cmd_abm_save_restore abm_save_restore;
+
 	/**
 	 * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
 	 */
-- 
2.34.1

