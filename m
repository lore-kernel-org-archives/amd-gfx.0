Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDFEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2693D10E5A5;
	Wed, 12 Jul 2023 17:12:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D9810E5A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDmRac6M1qzzWp/3slHIXAiKTqklMQCKPp1NJIPgmKZI1qhm+skX9iEC6lKCYcE62Mcvldjk6W9o+WgVCUHLo8FD79OCzK2JhiaoWWLC3bO4Wsf/XlBayF+5M2VDPcwLOE48hTxxwNAxyRDVORrfARdvat2l+sLX5f2yjtysjswUPtRPHlihtZJqYHQ1hCoqqiXNelMcvQx9p4zWJXrxuKP18wRhUhrEdS1IE8LsKMX6MrkFh8OlCxfvQWndY1kO7trA0P9w3QFGN30bnSV4Qfescav/j390bV5nluDExL1b5JrG0uJqTAdwCegWGL6XNak50jOJ9Qx63c84+0pUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCUE+ObADuRfqR1L96kbwyO9k2BoSUIAFJ42MFVTQog=;
 b=nQqcRN1N8Z5TEN1vSTtqO8QM5wisPXlh7IAZWbxwoDP7v0Rze64U1/71EHU5tVJ1wejJGFvopjBuiO+OdvdPhsJL1mVDyeYFxuAWjaJsjzEyPjHLhauzwsl7Uq8Aa9axZWLkpDnTkaF0YC25sm8oOflqnSPQ8eUR8KEVYKNgDrnx9YORhsf3PRE/4UObNQZekGvdkv4/B5QVo2pngFTblNcUPSaQN4gR9giaCmNVHeXPJCu/xSgBfs6n3Ltq6e/bmttZraHH8/dcP5tOz42hdVeq8fZzSz68TRJ34QITlsBwtLdrfuJfckOlSBIRew5GvMkIIs5KnP9zGhOLmPv54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCUE+ObADuRfqR1L96kbwyO9k2BoSUIAFJ42MFVTQog=;
 b=mCR/yUX/fb5v+20BWIDQ7jjPCpFxQhV+/pYnRsVGFDyCkKRBh4VKatEZFxp60VX/1ZOBS3zsKiG8w4BnS7J4YpnOpcqKgBCYEGO5IiWrAC0tov+/88JTC6BIqpgDKjvIGz9G58zEY7BfPbuLJoHWNHhMtk7c/tq1OzB3w9pY6L0=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:12:43 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::27) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:12:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:41 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:32 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: Add missing static
Date: Thu, 13 Jul 2023 01:11:11 +0800
Message-ID: <20230712171137.3398344-8-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f8928a0b-a3e3-4d56-f85b-08db82fb33ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USrmrKNPQ7pZUV+toUtYEUs3bdppo/erd2EaM6WXb3qbE5QgFrbUJgFDiMjQTCfsGMIfFKo9xzdEpKIHoQdX/ClFqZy2CKgJPLV168IuKxcarJmdFvr71RqJZjNaP/qqbRq5/mNoXA1lI+utpMvnEMvbUc2T8/ogQSJKJoePK9y4gArECMAevIhN1OiGbEliYW5koT/qX9O7e/ayvGYb3RwpvZQ4Ie/Lff5ZbA3HFkfaB5irGhE/k+jgNcb1XBHK5dtI+E2qTR9MbavGAP1Kgu4p2H0i5v09fCYQcus5ZsQEun57G+RjgcGxATEd600vBEsPII0Bc+zrPua8ol16PgCMqOdc0CjAXN95dLu/7WXKXi1nk49FqLRU/OdupbDpI7e12Iei2uv09x5I1LTwpJK+aQW3xHPp45N00drlNabwvmLLvLyiqcojgzGmhBIAsez02PnuzONHEHJY7gb0ehenti1xXS7tBI6UqA318Dq7ewQta1OA0z2mJJEwDrX/Cn67pQPQyynT8pmVn7pBP27PuKKmgeduZDh6Q190xkEcXXJNMsAz57TwU9RXOKrFyf4VaDQv1GXMkfeV80rAsf8dHJIADX4/9sE6VBsmbCdCVHSmfWUYIV+2uZmGs7jRP0SV6BvHXSPQ+4JDMGeYmC+OX+uvYzO5kTYd/6W5fUyOYYrxTneem5RqxLvkBQwLdzwM+I0IwfCBd88FWwVG39CVZkkO9l3ENztg0z8pprshc0pxeGoY9RQcTf2c0Xti+jTNul8BPX4oVEUHUWT5kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(4326008)(70586007)(70206006)(82310400005)(356005)(81166007)(86362001)(186003)(336012)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(83380400001)(426003)(36756003)(478600001)(7696005)(6666004)(54906003)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(30864003)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:42.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8928a0b-a3e3-4d56-f85b-08db82fb33ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

After enable DRM_AMDGPU_WERROR, clang highlight multiple functions that
need to have `static`, and this commit address those issues and also
improve the indents.

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/basics/vector.c    | 11 +++++-----
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 16 +++++++--------
 .../drm/amd/display/dc/bios/bios_parser2.c    | 20 ++++++++-----------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 ++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  6 +++---
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   | 16 +++++++--------
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   | 16 ++++++---------
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h |  1 -
 .../dc/irq/dcn314/irq_service_dcn314.c        |  7 +++----
 11 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 84aeccf36b4b..6d2924114a3e 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -50,12 +50,11 @@ bool dal_vector_construct(
 	return true;
 }
 
-static bool dal_vector_presized_costruct(
-	struct vector *vector,
-	struct dc_context *ctx,
-	uint32_t count,
-	void *initial_value,
-	uint32_t struct_size)
+static bool dal_vector_presized_costruct(struct vector *vector,
+					 struct dc_context *ctx,
+					 uint32_t count,
+					 void *initial_value,
+					 uint32_t struct_size)
 {
 	uint32_t i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 27af9d3c2b73..4f005ae1516c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2593,11 +2593,10 @@ static struct integrated_info *bios_parser_create_integrated_info(
 	return NULL;
 }
 
-static enum bp_result update_slot_layout_info(
-	struct dc_bios *dcb,
-	unsigned int i,
-	struct slot_layout_info *slot_layout_info,
-	unsigned int record_offset)
+static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
+					      unsigned int i,
+					      struct slot_layout_info *slot_layout_info,
+					      unsigned int record_offset)
 {
 	unsigned int j;
 	struct bios_parser *bp;
@@ -2696,10 +2695,9 @@ static enum bp_result update_slot_layout_info(
 }
 
 
-static enum bp_result get_bracket_layout_record(
-	struct dc_bios *dcb,
-	unsigned int bracket_layout_id,
-	struct slot_layout_info *slot_layout_info)
+static enum bp_result get_bracket_layout_record(struct dc_bios *dcb,
+						unsigned int bracket_layout_id,
+						struct slot_layout_info *slot_layout_info)
 {
 	unsigned int i;
 	unsigned int record_offset;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index cce47d3f1a13..540d19efad8f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -340,9 +340,8 @@ static struct atom_display_object_path_v2 *get_bios_object(
 }
 
 /* from graphics_object_id, find display path which includes the object_id */
-static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(
-	struct bios_parser *bp,
-	struct graphics_object_id id)
+static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(struct bios_parser *bp,
+									struct graphics_object_id id)
 {
 	unsigned int i;
 	struct graphics_object_id obj_id = {0};
@@ -521,9 +520,8 @@ static enum bp_result get_gpio_i2c_info(
 	return BP_RESULT_OK;
 }
 
-static struct atom_hpd_int_record *get_hpd_record_for_path_v3(
-	struct bios_parser *bp,
-	struct atom_display_object_path_v3 *object)
+static struct atom_hpd_int_record *get_hpd_record_for_path_v3(struct bios_parser *bp,
+							      struct atom_display_object_path_v3 *object)
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
@@ -2175,9 +2173,8 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 	return NULL;
 }
 
-static struct atom_connector_caps_record *get_connector_caps_record(
-	struct bios_parser *bp,
-	struct atom_display_object_path_v3 *object)
+static struct atom_connector_caps_record *get_connector_caps_record(struct bios_parser *bp,
+								    struct atom_display_object_path_v3 *object)
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
@@ -2264,9 +2261,8 @@ static enum bp_result bios_parser_get_disp_connector_caps_info(
 	return BP_RESULT_OK;
 }
 
-static struct atom_connector_speed_record *get_connector_speed_cap_record(
-	struct bios_parser *bp,
-	struct atom_display_object_path_v3 *object)
+static struct atom_connector_speed_record *get_connector_speed_cap_record(struct bios_parser *bp,
+									  struct atom_display_object_path_v3 *object)
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d133e4186a52..de3b891cba51 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1047,8 +1047,10 @@ static void disable_all_writeback_pipes_for_stream(
 		stream->writeback_info[i].wb_enabled = false;
 }
 
-static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context,
-					  struct dc_stream_state *stream, bool lock)
+static void apply_ctx_interdependent_lock(struct dc *dc,
+					  struct dc_state *context,
+					  struct dc_stream_state *stream,
+					  bool lock)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index cb2bf9a466f5..f99ec1b0efaf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -187,6 +187,7 @@ static bool is_ycbcr709_limited_type(
 		ret = true;
 	return ret;
 }
+
 static enum dc_color_space_type get_color_space_type(enum dc_color_space color_space)
 {
 	enum dc_color_space_type type = COLOR_SPACE_RGB_TYPE;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 63009db8b5a7..b87bfecb7755 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -76,9 +76,9 @@ static bool dce_dmcu_init(struct dmcu *dmcu)
 }
 
 static bool dce_dmcu_load_iram(struct dmcu *dmcu,
-		unsigned int start_offset,
-		const char *src,
-		unsigned int bytes)
+			       unsigned int start_offset,
+			       const char *src,
+			       unsigned int bytes)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
 	unsigned int count = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 6d1b01c267b7..4f552c3e7663 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -442,10 +442,9 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 	return dce_i2c_hw;
 }
 
-static enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_result(
-	struct dce_i2c_hw *dce_i2c_hw,
-	uint32_t timeout,
-	enum i2c_channel_operation_result expected_result)
+static enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_result(struct dce_i2c_hw *dce_i2c_hw,
+										    uint32_t timeout,
+										    enum i2c_channel_operation_result expected_result)
 {
 	enum i2c_channel_operation_result result;
 	uint32_t i = 0;
@@ -509,11 +508,10 @@ static uint32_t get_transaction_timeout_hw(
 	return period_timeout * num_of_clock_stretches;
 }
 
-static bool dce_i2c_hw_engine_submit_payload(
-	struct dce_i2c_hw *dce_i2c_hw,
-	struct i2c_payload *payload,
-	bool middle_of_transaction,
-	uint32_t speed)
+static bool dce_i2c_hw_engine_submit_payload(struct dce_i2c_hw *dce_i2c_hw,
+					     struct i2c_payload *payload,
+					     bool middle_of_transaction,
+					     uint32_t speed)
 {
 
 	struct i2c_request_transaction_data request;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index f1aeb6d1967c..e188447c8156 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -367,6 +367,7 @@ static bool dce_i2c_sw_engine_acquire_engine(
 
 	return true;
 }
+
 bool dce_i2c_engine_acquire_sw(
 	struct dce_i2c_sw *dce_i2c_sw,
 	struct ddc *ddc_handle)
@@ -392,12 +393,8 @@ bool dce_i2c_engine_acquire_sw(
 	return result;
 }
 
-
-
-
-static void dce_i2c_sw_engine_submit_channel_request(
-	struct dce_i2c_sw *engine,
-	struct i2c_request_transaction_data *req)
+static void dce_i2c_sw_engine_submit_channel_request(struct dce_i2c_sw *engine,
+						     struct i2c_request_transaction_data *req)
 {
 	struct ddc *ddc = engine->ddc;
 	uint16_t clock_delay_div_4 = engine->clock_delay >> 2;
@@ -439,10 +436,9 @@ static void dce_i2c_sw_engine_submit_channel_request(
 		I2C_CHANNEL_OPERATION_FAILED;
 }
 
-static bool dce_i2c_sw_engine_submit_payload(
-	struct dce_i2c_sw *engine,
-	struct i2c_payload *payload,
-	bool middle_of_transaction)
+static bool dce_i2c_sw_engine_submit_payload(struct dce_i2c_sw *engine,
+					     struct i2c_payload *payload,
+					     bool middle_of_transaction)
 {
 	struct i2c_request_transaction_data request;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
index 33fc9aa8621b..d07c04458d31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
@@ -43,7 +43,7 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
+static void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
index e44a37491c1e..b7efa777ec73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
@@ -32,6 +32,5 @@ struct dccg *dccg21_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask);
 
-void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
 
 #endif /* __DCN21_DCCG_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index c923b2af8510..37bc98faa7a0 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -38,10 +38,9 @@
 
 #define DCN_BASE__INST0_SEG2                       0x000034C0
 
-static enum dc_irq_source to_dal_irq_source_dcn314(
-		struct irq_service *irq_service,
-		uint32_t src_id,
-		uint32_t ext_id)
+static enum dc_irq_source to_dal_irq_source_dcn314(struct irq_service *irq_service,
+						   uint32_t src_id,
+						   uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
-- 
2.34.1

