Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F644C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 20:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795F210F015;
	Tue, 18 Oct 2022 20:27:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0041110F015
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 20:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaeeLH95dyFmjNtGtvh0+ZwRDjrvNC5HGTshF/eAPjpYSReoXAHTEKnlYaWJSD43bP8UBrepyR0F4lOIVSO9lvGVLASS7sa7ns1yZe3IoCj92JXGfoakCxrBh0Z3vBgLe/Jw7ZkWLLfB5s4BSFARzlaVs1xYAtb8DVEjJ60VVE8FhrCHLgJdoDlskwGyducD+Y4ZJuuWB31mGDKPo9STmU0v34ft2YbcIFqs8NzwBeLChbSFUp0GqGYWQ3isOyavj4/6qmcuF5tRk+vMExN9OM9pJwY5BBxFoXULb778US46SGKiMMYWY/0N2wVpigbSMrjfMnIxtityz4pQVGNH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXGJTiXl5PeB+CBtOCTlY04wdnRmKHLnM3t0gDBJYCk=;
 b=ObRt08zB0v0Nr3hsRuQVCpXKGhvnBGEPMgLlpLDOZvdc1EkoMNDdW//IPZiDLlw/y5L4XGsywpP8FLvgJD9TfM3KYepoQ/WLLVDrhTQCQvdHVGDiOedfUqA03v1/02XQ93lFNmmpbkOYOEdjtlG1Bi7k8hnBrURLOeZ0KIqkTjhQm+60z4xPmvjtzVFbhbzJEMLA1hbF74BHalpjTP4ii4Rkov49ClvQWXud3RxWGFjUgb7wf9DWXR6XMtGI4wwJPAsrYIaUZkdDuypRvIz0pdPGnHuI8HoSSFgC+ybtbmUoLRmdiFYLu9WuxRiDJ5yeNJFc7I3mGT8VlWkONsBGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXGJTiXl5PeB+CBtOCTlY04wdnRmKHLnM3t0gDBJYCk=;
 b=5pkavD84cn8M8Czn+vweI6KMyufgQkSGHHOcW8sPxHwMfPQh8ro7t5Hx/SDUWISrIlt8EM5NTU3AOiTQxcLFOThILjaUORz2hP3gcmuuWry5lddBZEtRp4QLFFSxHlVH8reiOfTMCvaVAprwr9kCBP6aH1mSxf6pvk4YlpTmTmw=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 20:27:20 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::9d) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 20:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 18 Oct 2022 20:27:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 15:27:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 15:27:20 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 15:27:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Rework comments on dc file
Date: Tue, 18 Oct 2022 16:27:59 -0400
Message-ID: <20221018202759.1999835-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 0697924e-0cf7-4f4e-f1ee-08dab147286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdPEl8VPBr57rxtu8PEGAphIytG/wEE3OWrW7jHUr0J85yXs/KM5VxLFpIWH9mMP8Tn3IgUhyLJOAEysKUbatPlp6q90NRzHzmdPK+mPFB0rS3LyhMqxhLisG4Xs92Cq5dC0LXRMakUL2OGNCu1OjcylrlBN2MocnSrhX5fieE+rgJdb4jQoQGT+YQDIQJ7tBs0rIiHYletNez59J7vEZm387pHL7qTE5pZmjmsA3jt1iqTLZVsIdyP+WmZq6novuKRXyVxY5frfTsC0oYNnXgjM67nuBqcfGAho9tuoDHm9J/MLEL+K1OZjLvNUaISIR1qbFQHuTwzQ4UYOVbDnkmPWUFqGgK743gq4OPa+EuibqadWl6Rlh6v6hiyk7x121qQucZs3MGLXb42u4S3xL+fQX/SBwY2EFufR9JHowPE83srt0yybr1Z+jqthpgGz/XpkO3eBk4uTS8fLBfDbzI1e5MkxC6b4yXy4QO+BPTTUm9eaeg3Agp1CNmeQibwT1gAcp/UNFpdsTpgP7VL35fvqtSlI2ZR8iO6yNbmzLtdZGLFR5W1AFEcVrK+W3l/LVt5YAXI4sczVrJc1iZYEquvsNPju1LVmxdqwKteVDz5mVQa61ssahcVJkrbPFZRDZ9ClqtpXMdVj5ve8suiRB466DI7lH19umDEcJdo45HUpEKArdqyVH/xGSq5YKzlSxqSAjrkUuelkunXPx63HsSyrq2Huh+wWMR6WAhgfcen6dO4boWaEL9/6KGG+UZnJdULb8bMAEwva/ZpR4l3a+g/hZrrFq4+XylO9Z95oYodEF9nhvhTrfkPk5aqVNa13
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(6916009)(30864003)(186003)(5660300002)(70586007)(70206006)(316002)(478600001)(41300700001)(8676002)(26005)(336012)(2906002)(1076003)(8936002)(2616005)(4326008)(83380400001)(426003)(82740400003)(36756003)(356005)(47076005)(82310400005)(81166007)(6666004)(36860700001)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 20:27:20.4925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0697924e-0cf7-4f4e-f1ee-08dab147286a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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
Cc: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The file dc.c has multiple comments that do not follow the kernel-doc or
are made in a distracting way. This commit alleviates part of this issue
by reorganizing some comments inside the dc file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 161 +++++++++--------------
 drivers/gpu/drm/amd/display/dc/dc.h      |  32 ++---
 2 files changed, 70 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2858917a66be..d446e6098948 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -135,9 +135,7 @@ static const char DC_BUILD_ID[] = "production-build";
  * one or two (in the pipe-split case).
  */
 
-/*******************************************************************************
- * Private functions
- ******************************************************************************/
+/* Private functions */
 
 static inline void elevate_update_type(enum surface_update_type *original, enum surface_update_type new)
 {
@@ -421,18 +419,14 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_stream_get_last_vrr_vtotal
+ * dc_stream_get_last_used_drr_vtotal - dc_stream_get_last_vrr_vtotal
  *
- *  @brief
- *     Looks up the pipe context of dc_stream_state and gets the
- *     last VTOTAL used by DRR (Dynamic Refresh Rate)
+ * @dc: [in] dc reference
+ * @stream: [in] Initial dc stream state
+ * @adjust: [in] Updated parameters for vertical_total_min and
  *
- *  @param [in] dc: dc reference
- *  @param [in] stream: Initial dc stream state
- *  @param [in] adjust: Updated parameters for vertical_total_min and
- *  vertical_total_max
- *****************************************************************************
+ * Looks up the pipe context of dc_stream_state and gets the last VTOTAL used
+ * by DRR (Dynamic Refresh Rate)
  */
 bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
 		struct dc_stream_state *stream,
@@ -1209,9 +1203,7 @@ static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 	PERF_TRACE();
 }
 
-/*******************************************************************************
- * Public functions
- ******************************************************************************/
+/* Public functions */
 
 struct dc *dc_create(const struct dc_init_data *init_params)
 {
@@ -4552,21 +4544,17 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
 		dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down = true;
 }
 
-/*
- *****************************************************************************
- * Function: dc_is_dmub_outbox_supported -
+/**
+ * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox notification
  *
- * @brief
- *      Checks whether DMUB FW supports outbox notifications, if supported
- *		DM should register outbox interrupt prior to actually enabling interrupts
- *		via dc_enable_dmub_outbox
+ * @dc: [in] dc structure
  *
- *  @param
- *		[in] dc: dc structure
+ * Checks whether DMUB FW supports outbox notifications, if supported DM
+ * should register outbox interrupt prior to actually enabling interrupts
+ * via dc_enable_dmub_outbox
  *
- *  @return
- *		True if DMUB FW supports outbox notifications, False otherwise
- *****************************************************************************
+ * Return:
+ * True if DMUB FW supports outbox notifications, False otherwise
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
@@ -4584,21 +4572,17 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
 
-/*
- *****************************************************************************
- *  Function: dc_enable_dmub_notifications
+/**
+ * dc_enable_dmub_notifications - Check if dmub fw supports outbox
  *
- *  @brief
- *		Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
- *		notifications. All DMs shall switch to dc_is_dmub_outbox_supported.
- *		This API shall be removed after switching.
+ * @dc: [in] dc structure
  *
- *  @param
- *		[in] dc: dc structure
+ * Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
+ * notifications. All DMs shall switch to dc_is_dmub_outbox_supported.  This
+ * API shall be removed after switching.
  *
- *  @return
- *		True if DMUB FW supports outbox notifications, False otherwise
- *****************************************************************************
+ * Return:
+ * True if DMUB FW supports outbox notifications, False otherwise
  */
 bool dc_enable_dmub_notifications(struct dc *dc)
 {
@@ -4606,18 +4590,11 @@ bool dc_enable_dmub_notifications(struct dc *dc)
 }
 
 /**
- *****************************************************************************
- *  Function: dc_enable_dmub_outbox
+ * dc_enable_dmub_outbox - Enables DMUB unsolicited notification
  *
- *  @brief
- *		Enables DMUB unsolicited notifications to x86 via outbox
+ * dc: [in] dc structure
  *
- *  @param
- *		[in] dc: dc structure
- *
- *  @return
- *		None
- *****************************************************************************
+ * Enables DMUB unsolicited notifications to x86 via outbox.
  */
 void dc_enable_dmub_outbox(struct dc *dc)
 {
@@ -4718,21 +4695,17 @@ uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_set_config_async
+ * dc_process_dmub_set_config_async - Submits set_config command
  *
- *  @brief
- *		Submits set_config command to dmub via inbox message
+ * @dc: [in] dc structure
+ * @link_index: [in] link_index: link index
+ * @payload: [in] aux payload
+ * @notify: [out] set_config immediate reply
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] link_index: link index
- *		[in] payload: aux payload
- *		[out] notify: set_config immediate reply
+ * Submits set_config command to dmub via inbox message.
  *
- *  @return
- *		True if successful, False if failure
- *****************************************************************************
+ * Return:
+ * True if successful, False if failure
  */
 bool dc_process_dmub_set_config_async(struct dc *dc,
 				uint32_t link_index,
@@ -4768,21 +4741,17 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_set_mst_slots
+ * dc_process_dmub_set_mst_slots - Submits MST solt allocation
  *
- *  @brief
- *		Submits mst slot allocation command to dmub via inbox message
+ * @dc: [in] dc structure
+ * @link_index: [in] link index
+ * @mst_alloc_slots: [in] mst slots to be allotted
+ * @mst_slots_in_use: [out] mst slots in use returned in failure case
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] link_index: link index
- *		[in] mst_alloc_slots: mst slots to be allotted
- *		[out] mst_slots_in_use: mst slots in use returned in failure case
+ * Submits mst slot allocation command to dmub via inbox message
  *
- *	@return
- *		DC_OK if successful, DC_ERROR if failure
- *****************************************************************************
+ * Return:
+ * DC_OK if successful, DC_ERROR if failure
  */
 enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 				uint32_t link_index,
@@ -4822,19 +4791,12 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_dpia_hpd_int_enable
- *
- *  @brief
- *		Submits dpia hpd int enable command to dmub via inbox message
+ * dc_process_dmub_dpia_hpd_int_enable - Submits DPIA DPD interruption
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] hpd_int_enable: 1 for hpd int enable, 0 to disable
+ * @dc [in]: dc structure
+ * @hpd_int_enable [in]: 1 for hpd int enable, 0 to disable
  *
- *	@return
- *		None
- *****************************************************************************
+ * Submits dpia hpd int enable command to dmub via inbox message
  */
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable)
@@ -4863,16 +4825,13 @@ void dc_disable_accelerated_mode(struct dc *dc)
 
 
 /**
- *****************************************************************************
- *  dc_notify_vsync_int_state() - notifies vsync enable/disable state
+ *  dc_notify_vsync_int_state - notifies vsync enable/disable state
  *  @dc: dc structure
- *	@stream: stream where vsync int state changed
- *	@enable: whether vsync is enabled or disabled
+ *  @stream: stream where vsync int state changed
+ *  @enable: whether vsync is enabled or disabled
  *
- *  Called when vsync is enabled/disabled
- *	Will notify DMUB to start/stop ABM interrupts after steady state is reached
- *
- *****************************************************************************
+ *  Called when vsync is enabled/disabled Will notify DMUB to start/stop ABM
+ *  interrupts after steady state is reached.
  */
 void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable)
 {
@@ -4914,14 +4873,18 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
-/*
- * dc_extended_blank_supported: Decide whether extended blank is supported
+
+/**
+ * dc_extended_blank_supported 0 Decide whether extended blank is supported
  *
- * Extended blank is a freesync optimization feature to be enabled in the future.
- * During the extra vblank period gained from freesync, we have the ability to enter z9/z10.
+ * @dc: [in] Current DC state
  *
- * @param [in] dc: Current DC state
- * @return: Indicate whether extended blank is supported (true or false)
+ * Extended blank is a freesync optimization feature to be enabled in the
+ * future.  During the extra vblank period gained from freesync, we have the
+ * ability to enter z9/z10.
+ *
+ * Return:
+ * Indicate whether extended blank is supported (true or false)
  */
 bool dc_extended_blank_supported(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0757ca449290..d9f510b4e848 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -56,9 +56,7 @@ struct dmub_notification;
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
 
-/*******************************************************************************
- * Display Core Interfaces
- ******************************************************************************/
+/* Display Core Interfaces */
 struct dc_versions {
 	const char *dc_ver;
 	struct dmcu_version dmcu_version;
@@ -1000,9 +998,7 @@ void dc_init_callbacks(struct dc *dc,
 void dc_deinit_callbacks(struct dc *dc);
 void dc_destroy(struct dc **dc);
 
-/*******************************************************************************
- * Surface Interfaces
- ******************************************************************************/
+/* Surface Interfaces */
 
 enum {
 	TRANSFER_FUNC_POINTS = 1025
@@ -1363,9 +1359,7 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx);
 void dc_retain_state(struct dc_state *context);
 void dc_release_state(struct dc_state *context);
 
-/*******************************************************************************
- * Link Interfaces
- ******************************************************************************/
+/* Link Interfaces */
 
 struct dpcd_caps {
 	union dpcd_rev dpcd_rev;
@@ -1467,9 +1461,7 @@ struct hdcp_caps {
 
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
 
-/*******************************************************************************
- * Sink Interfaces - A sink corresponds to a display output device
- ******************************************************************************/
+/* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
 	// 128bit GUID in binary form
@@ -1552,9 +1544,7 @@ struct dc_cursor {
 };
 
 
-/*******************************************************************************
- * Interrupt interfaces
- ******************************************************************************/
+/* Interrupt interfaces */
 enum dc_irq_source dc_interrupt_to_irq_source(
 		struct dc *dc,
 		uint32_t src_id,
@@ -1566,9 +1556,7 @@ enum dc_irq_source dc_get_hpd_irq_source_at_index(
 
 void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable);
 
-/*******************************************************************************
- * Power Interfaces
- ******************************************************************************/
+/* Power Interfaces */
 
 void dc_set_power_state(
 		struct dc *dc,
@@ -1641,14 +1629,10 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable);
 
-/*******************************************************************************
- * DSC Interfaces
- ******************************************************************************/
+/* DSC Interfaces */
 #include "dc_dsc.h"
 
-/*******************************************************************************
- * Disable acc mode Interfaces
- ******************************************************************************/
+/* Disable acc mode Interfaces */
 void dc_disable_accelerated_mode(struct dc *dc);
 
 #endif /* DC_INTERFACE_H_ */
-- 
2.38.0

