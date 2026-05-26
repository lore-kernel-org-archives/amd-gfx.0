Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A93CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D784C10E507;
	Tue, 26 May 2026 07:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7PIx0Yc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A786C10E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn8j8qNUs5wib0Bpn0BGdw5FqFHks6FRXY+LSi1DozyzhaU+BubTxEgKZ6GBBoiNYimOsk4DLFJREjj3Lz6KxyzyE+Q7J7MLweKbflCgkH2aPQatlqtmLxa7tjpVj5ryK9Vs/0Xnkw05xsDMS/T6vGF9PgxqfgLZo6L0uDM+WaldWgSU66aUadhgx0ntuOnDrqTqMDgqr29bP7akse+em5UVeNZkuMFJUlIi4JjTV5UbXwiDfCezI7mKDPiuAFnivkPI7tzutPR3HipxozRQ2+V3ofY2VlvVCMDZGAu2LoPPf0qSZ5JJDqeP3RZCxYa4WllYlcjCHNFy3aCZYdJ2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjqiEr1BteJ6u1OszTrhZDGBhPZi3/P/jdRmmALqjJ8=;
 b=NJKldyAUpK/1PPky5x/+KDKpvZNINoaV6DwpYJPyPXiqqWZRDxLoVQvy7bmGic8fUumYs5EgsnBnK9mqZt9E+ow5q3OfGNdhcoD0WjTi0t/TAiyRdRt091fkzkmjX0NdDTp+GgkbKILkTe5RPPV7J2w0g/svN1n9MQOTzRXMHWEoEQznN6DFKlHVC7i+XLz4KelR1FL1JMZyc656sd+V0/9MkMnlQ+uZjUfTJhgw8Q56+7s1tkrNswmZ+XMXHcO2tybyFpRXMZ+IToISglYyVDHzAL+R86AZZNZWkl5+jmwcqX/6zVaR4YtuSMLtQVkRT1pcLAph7VXGx6EA7Ne5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjqiEr1BteJ6u1OszTrhZDGBhPZi3/P/jdRmmALqjJ8=;
 b=m7PIx0YctYfgrrwcIivyLj/OrQmXFXdsI5UaU9VWEo+3zXf2Iu/BWd3NPxdfYZ/mpFkITz0s11lR6vQoX/DUFHnAAo0BQuisPDy5pJBrWQJn0XtxMDf7xdkeDOVnf9mu+DWcYUQoCLzfdMwBVrURG9ljJqopvimRDD2/vGtzILI=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 07:18:53 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::2d) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:18:51 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:18:42 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 31/41] drm/amd/display: Add no_native_i2c codepath
Date: Tue, 26 May 2026 15:01:54 +0800
Message-ID: <20260526071413.2181251-32-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d915f7-251a-4065-bfa9-08debaf70a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: +ZxjTfNi/c/D0XEdmbGcq2CNpDI47gvuzsBEJ8MzXotTZ+7j69HWgzxSzWh4cFpnmZTyXNjVv1m29vmXFAtP8IT5Y2LfXazLwGN/K9UUxEncmo3YZ90qpAcB3FI0I361/gPMA04RZe2DN0dDo+3Ir6ziS9cdyW7bP/NahRo3FRePiXAwSpksDoJRFsoScB4ps+MAZLAG2X0VgnLeXtv8cmIdf2LY5zbHnem7AE9GRiMNXRvYTsXIMzwscNn2sEB5+Z8gji9ic2/3/e80fUwcqf/WqoAG7NR037ZUBnW0YV+A/LQ8eJI/dUKM0HG3WqCPYvYUzMvRKGwvcrBAofCCpM38M38kCxTnnMkRZG4CSAAkEi4W1jm648C6NoEQix9PZLOmwOhsH9uBzwbryVk1Gxad8lEl/MQTTR4POzQsltmD272pRJiKAPx9f+27GQewMrPzRz13n/KhmnPeQYQQZVBUS6yvLNHwF/OrHTc6OtX8tko0NM8BWGJG0alnB5SOA3z8lk6vmtMtmNVlTPdXgW6nQL0mWhAXuk/abezo3UL7BY1iFWlW9XJE3rFjr/2UuDKiPXxW8/Ku00u9AvDTQKOnnVSyDM67OdR0sztzH/qCPUHcy8dXeelHSRZ5el0pjRQvWPNCmDLSp3w3RBw2owB2eOjqUFWyCtt2RO9PI+3khqQo/yZkYPRJ6Td8lDtsUmAqImt9/YC+B1mRq19+Qtl1QPcRQTA89ZZEAORgTB0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n5tZ3Lra3IvytbBck6kN3j2SswTunBcDVNtlX4DVOtXvFYkszKP7JamcV50IhlEP/UwLuP8FqSgydHAo/TXrxbPRAT0oiq7eLgkQRRjluID/IytJ+xJH02Wj0L7U7QtibG993aLB55TtBb1Fz7YWwVido1xMgllLvxLJbD0uxp3y7qj78Bl6sD+64e/HJQFQ35vsWHaHzuA+v7Sr6Si2YP7qajLRhqn+BXCapIs2qfYamRIfLfWRm7DyWaoXqXFCY8I1e+myveNJVN2ZP64JBDLnR0QsjEIgitHzGmy1ijCvkMP8gNvUhtU9n9x5YdEglFZ6MDFJ4tv+vxgxcsWBOmxbKSZguR2RRXPRnkm0I3x1KcQ82+BhtzS3sp8Luc2hGZ64BYuKz2a7g7ABPOKYVPvaTNpoZN8xneiKvtb4iRnkbU72PnWD3t3flpbNCyka
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:52.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d915f7-251a-4065-bfa9-08debaf70a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[Why]
ASICs which do not have native DDC capability must use a different
codepath to access the AUX channel.

[How]
- BIOS cap NO_DDC_PIN is set to 1 for links which do not have the DDC pin.
- dp_connector_no_native_i2c in dc_config must also be set to true to
  use this codepath.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  67 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 181 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   4 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  27 +++
 .../drm/amd/display/dc/link/link_factory.c    |  86 +++++----
 .../amd/display/dc/link/protocols/link_ddc.c  |  60 +++---
 .../dc/link/protocols/link_dp_capability.c    |   6 +
 .../link/protocols/link_edp_panel_control.c   |   5 +-
 .../amd/display/include/bios_parser_types.h   |   1 +
 12 files changed, 382 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c02fb2ca0317..9244a4397022 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -718,6 +718,69 @@ static enum bp_result bios_parser_get_gpio_pin_info(
 	return BP_RESULT_NORECORD;
 }
 
+static enum bp_result bios_parser_get_connector_aux_info(struct dc_bios *dcb,
+	struct graphics_object_id id,
+	struct graphics_object_i2c_info *info)
+{
+	uint32_t offset;
+	struct atom_display_object_path_v2 *object;
+	struct atom_display_object_path_v3 *object_path_v3;
+	struct atom_common_record_header *header;
+	struct atom_i2c_record *record;
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+
+	if (!info)
+		return BP_RESULT_BADINPUT;
+
+	switch (bp->object_info_tbl.revision.minor) {
+	case 4:
+	default:
+		object = get_bios_object(bp, id);
+
+		if (!object)
+			return BP_RESULT_BADINPUT;
+
+		offset = object->disp_recordoffset + bp->object_info_tbl_offset;
+		break;
+	case 5:
+		object_path_v3 = get_bios_object_from_path_v3(bp, id);
+
+		if (!object_path_v3)
+			return BP_RESULT_BADINPUT;
+
+		offset = object_path_v3->disp_recordoffset + bp->object_info_tbl_offset;
+		break;
+	}
+
+	for (;;) {
+		header = GET_IMAGE(struct atom_common_record_header, offset);
+
+		if (!header)
+			return BP_RESULT_BADBIOSTABLE;
+
+		if (header->record_type == LAST_RECORD_TYPE ||
+			!header->record_size)
+			break;
+
+		if (header->record_type == ATOM_I2C_RECORD_TYPE
+			&& sizeof(struct atom_i2c_record) <=
+			header->record_size) {
+			/* get_connector_aux_info - which aux instance is used it is based
+			 * on record->i2c_id field only, does not need GPIO DDC
+			 */
+			record = (struct atom_i2c_record *)header;
+
+			info->i2c_line = record->i2c_id & I2C_HW_LANE_MUX;
+
+			return BP_RESULT_OK;
+		}
+
+		offset += header->record_size;
+	}
+
+	return BP_RESULT_NORECORD;
+}
+
 static struct device_id device_type_from_device_id(uint16_t device_id)
 {
 
@@ -2349,6 +2412,9 @@ static enum bp_result bios_parser_get_disp_connector_caps_info(
 									? 1 : 0;
 		info->INTERNAL_DISPLAY_BL = (record_path_v3->connector_caps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL)
 										? 1 : 0;
+		// All aux transactions for this connector should rely only on aux instance, not on ddc instance
+		info->NO_DDC_PIN = (record_path_v3->connector_caps & ATOM_CONNECTOR_CAP_DP_PLUS_PLUS_TYPE2_ONLY) ? 1 : 0;
+
 		break;
 	}
 
@@ -3717,6 +3783,7 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.get_lttpr_interop = bios_parser_get_lttpr_interop,
 
 	.get_connector_speed_cap_info = bios_parser_get_connector_speed_cap_info,
+	.get_connector_aux_info = bios_parser_get_connector_aux_info,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75f59ca927ff..3ffcb74552c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -559,6 +559,7 @@ struct dc_config {
 	bool enable_dpia_pre_training;
 	bool unify_link_enc_assignment;
 	bool enable_cursor_offload;
+	bool dp_connector_no_native_i2c;
 	bool frame_update_cmd_version2;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
@@ -1652,6 +1653,13 @@ struct dc_scratch_space {
 	struct dc_link_training_overrides preferred_training_settings;
 	struct dp_audio_test_data audio_test_data;
 
+	/* On ASICs with dp_connector_no_native_i2c cap set and no_ddc_pin cap
+	 * set by IFWI, link aux_hw_inst is used in aux layer functions instead
+	 * of ddc_pin to know which aux instance is associated with link.
+	 */
+	bool no_ddc_pin;
+	enum gpio_ddc_line aux_hw_inst;
+
 	enum gpio_ddc_line ddc_hw_inst;
 
 	uint8_t hpd_src;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 526f71616f94..5f9560147939 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -172,6 +172,10 @@ struct dc_vbios_funcs {
 		struct dc_bios *bios,
 		struct graphics_object_id object_id,
 		struct bp_connector_speed_cap_info *info);
+	enum bp_result(*get_connector_aux_info)(
+		struct dc_bios *dcb,
+		struct graphics_object_id id,
+		struct graphics_object_i2c_info *info);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
index 664cb4abf623..923f70724419 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
@@ -102,8 +102,8 @@ bool dm_atomic_write_poll_read_i2c(
 	if (!link)
 		return false;
 
-	const bool over_aux = false;
-	const uint32_t ddc_line = link->ddc->ddc_pin->pin_data->en;
+	const bool over_aux = link->no_ddc_pin;
+	const uint32_t ddc_line = over_aux ? link->aux_hw_inst : link->ddc->ddc_pin->pin_data->en;
 
 	union dmub_rb_cmd commands[3] = { 0 };
 	const bool converted = op_i2c_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line, over_aux)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 181944ce77ab..72ad3ee3d6a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -274,8 +274,14 @@ static void submit_channel_request(
 	}
 
 	REG_UPDATE(AUX_SW_CONTROL, AUX_SW_GO, 1);
-	EVENT_LOG_AUX_REQ(engine->ddc->pin_data->en, EVENT_LOG_AUX_ORIGIN_NATIVE,
-					request->action, request->address, request->length, request->data);
+
+	if (engine->ddc) {
+		EVENT_LOG_AUX_REQ(engine->ddc->pin_data->en, EVENT_LOG_AUX_ORIGIN_NATIVE,
+		    request->action, request->address, request->length, request->data);
+	} else {
+		EVENT_LOG_AUX_REQ(engine->inst, EVENT_LOG_AUX_ORIGIN_NATIVE,
+		    request->action, request->address, request->length, request->data);
+	}
 }
 
 static int read_channel_reply(struct dce_aux *engine, uint32_t size,
@@ -421,6 +427,21 @@ static bool acquire(
 	return true;
 }
 
+static bool acquire_aux_engine_without_ddc_pin(
+	struct dce_aux *engine,
+	struct ddc *ddc)
+{
+	(void)ddc;
+	if ((engine == NULL) || !is_engine_available(engine))
+		return false;
+
+	if (!acquire_engine(engine)) {
+		release_engine(engine);
+		return false;
+	}
+	return true;
+}
+
 void dce110_engine_destroy(struct dce_aux **engine)
 {
 
@@ -431,6 +452,73 @@ void dce110_engine_destroy(struct dce_aux **engine)
 
 }
 
+static uint32_t dce_aux_configure_timeout_without_ddc_pin(struct ddc_service *ddc,
+	uint32_t timeout_in_us)
+{
+	uint32_t multiplier = 0;
+	uint32_t length = 0;
+	uint32_t prev_length = 0;
+	uint32_t prev_mult = 0;
+	uint32_t prev_timeout_val = 0;
+	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
+	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
+
+	/* 1-Update polling timeout period */
+	aux110->polling_timeout_period = timeout_in_us * SW_AUX_TIMEOUT_PERIOD_MULTIPLIER;
+
+	/* 2-Update aux timeout period length and multiplier */
+	if (timeout_in_us == 0) {
+		multiplier = DEFAULT_AUX_ENGINE_MULT;
+		length = DEFAULT_AUX_ENGINE_LENGTH;
+	} else if (timeout_in_us <= TIME_OUT_INCREMENT) {
+		multiplier = 0;
+		length = timeout_in_us / TIME_OUT_MULTIPLIER_8;
+		if (timeout_in_us % TIME_OUT_MULTIPLIER_8 != 0)
+			length++;
+	} else if (timeout_in_us <= 2 * TIME_OUT_INCREMENT) {
+		multiplier = 1;
+		length = timeout_in_us / TIME_OUT_MULTIPLIER_16;
+		if (timeout_in_us % TIME_OUT_MULTIPLIER_16 != 0)
+			length++;
+	} else if (timeout_in_us <= 4 * TIME_OUT_INCREMENT) {
+		multiplier = 2;
+		length = timeout_in_us / TIME_OUT_MULTIPLIER_32;
+		if (timeout_in_us % TIME_OUT_MULTIPLIER_32 != 0)
+			length++;
+	} else if (timeout_in_us > 4 * TIME_OUT_INCREMENT) {
+		multiplier = 3;
+		length = timeout_in_us / TIME_OUT_MULTIPLIER_64;
+		if (timeout_in_us % TIME_OUT_MULTIPLIER_64 != 0)
+			length++;
+	}
+
+	length = (length < MAX_TIMEOUT_LENGTH) ? length : MAX_TIMEOUT_LENGTH;
+
+	REG_GET_2(AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, &prev_length, AUX_RX_TIMEOUT_LEN_MUL, &prev_mult);
+
+	switch (prev_mult) {
+	case 0:
+		prev_timeout_val = prev_length * TIME_OUT_MULTIPLIER_8;
+		break;
+	case 1:
+		prev_timeout_val = prev_length * TIME_OUT_MULTIPLIER_16;
+		break;
+	case 2:
+		prev_timeout_val = prev_length * TIME_OUT_MULTIPLIER_32;
+		break;
+	case 3:
+		prev_timeout_val = prev_length * TIME_OUT_MULTIPLIER_64;
+		break;
+	default:
+		prev_timeout_val = DEFAULT_AUX_ENGINE_LENGTH * TIME_OUT_MULTIPLIER_8;
+		break;
+	}
+
+	REG_UPDATE_SEQ_2(AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, length, AUX_RX_TIMEOUT_LEN_MUL, multiplier);
+
+	return prev_timeout_val;
+}
+
 static uint32_t dce_aux_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout_in_us)
 {
@@ -440,6 +528,10 @@ static uint32_t dce_aux_configure_timeout(struct ddc_service *ddc,
 	uint32_t prev_mult = 0;
 	uint32_t prev_timeout_val = 0;
 	struct ddc *ddc_pin = ddc->ddc_pin;
+
+	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin)
+		return dce_aux_configure_timeout_without_ddc_pin(ddc, timeout_in_us);
+
 	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
 	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
 
@@ -560,11 +652,20 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc ||
-	    !ddc->ddc_pin) {
-		return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
+	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+		/* Check whether aux to be processed via dmub or dcn directly */
+		if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc) {
+			return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
+		} else {
+			return dce_aux_transfer_raw_without_ddc_pin(ddc, payload, operation_result);
+		}
 	} else {
-		return dce_aux_transfer_raw_with_ddc_pin(ddc, payload, operation_result);
+		if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc ||
+		    !ddc->ddc_pin) {
+			return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
+		} else {
+			return dce_aux_transfer_raw_with_ddc_pin(ddc, payload, operation_result);
+		}
 	}
 }
 
@@ -625,6 +726,59 @@ int dce_aux_transfer_raw_with_ddc_pin(struct ddc_service *ddc,
 	return res;
 }
 
+int dce_aux_transfer_raw_without_ddc_pin(struct ddc_service *ddc,
+	struct aux_payload *payload,
+	enum aux_return_code_type *operation_result)
+{
+	struct ddc *ddc_pin = ddc->ddc_pin;
+	struct dce_aux *aux_engine;
+	struct aux_request_transaction_data aux_req;
+	uint8_t returned_bytes = 0;
+	int res = -1;
+	uint32_t status;
+
+	memset(&aux_req, 0, sizeof(aux_req));
+
+	aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
+
+	if (!acquire_aux_engine_without_ddc_pin(aux_engine, ddc_pin)) {
+		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		return -1;
+	}
+
+	if (payload->i2c_over_aux)
+		aux_req.type = AUX_TRANSACTION_TYPE_I2C;
+	else
+		aux_req.type = AUX_TRANSACTION_TYPE_DP;
+
+	aux_req.action = i2caux_action_from_payload(payload);
+
+	aux_req.address = payload->address;
+	aux_req.delay = 0;
+	aux_req.length = payload->length;
+	aux_req.data = payload->data;
+
+	submit_channel_request(aux_engine, &aux_req);
+	*operation_result = get_channel_status(aux_engine, &returned_bytes);
+
+	if (*operation_result == AUX_RET_SUCCESS) {
+		int __maybe_unused bytes_replied = 0;
+
+		bytes_replied = read_channel_reply(aux_engine, payload->length,
+			payload->data, payload->reply,
+			&status);
+		EVENT_LOG_AUX_REP(aux_engine->inst,
+			EVENT_LOG_AUX_ORIGIN_NATIVE, *payload->reply,
+			bytes_replied, payload->data);
+		res = returned_bytes;
+	} else {
+		res = -1;
+	}
+
+	release_engine(aux_engine);
+	return res;
+}
+
 int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
@@ -641,6 +795,16 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 		release_engine(aux_engine);
 	}
 
+	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+		struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
+
+		if (!acquire_aux_engine_without_ddc_pin(aux_engine, ddc_pin)) {
+			*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+			return -1;
+		}
+		release_engine(aux_engine);
+	}
+
 	return dm_helper_dmub_aux_transfer_sync(ddc->ctx, ddc->link, payload, operation_result);
 }
 
@@ -729,6 +893,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		aux110 = FROM_AUX_ENGINE(aux_engine);
 	}
 
+	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+		aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
+		aux110 = FROM_AUX_ENGINE(aux_engine);
+	}
+
 	if (!payload->reply) {
 		payload_reply = false;
 		payload->reply = &reply;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index 8f4745694016..b2153cb03b51 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -308,6 +308,10 @@ int dce_aux_transfer_raw_with_ddc_pin(struct ddc_service *ddc,
 		struct aux_payload *cmd,
 		enum aux_return_code_type *operation_result);
 
+int dce_aux_transfer_raw_without_ddc_pin(struct ddc_service *ddc,
+	struct aux_payload *cmd,
+	enum aux_return_code_type *operation_result);
+
 int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 124a1ccec741..d88dc668c7ca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -40,6 +40,7 @@
 #include "link_enc_cfg.h"
 #include "../hw_sequencer.h"
 #include "dio/dcn10/dcn10_dio.h"
+#include "gpio_service_interface.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -319,6 +320,32 @@ void dcn401_init_hw(struct dc *dc)
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
 			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
 		}
+
+		if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+			struct graphics_object_i2c_info i2c_info;
+			struct ddc *ddc_pin;
+			struct gpio_ddc_hw_info hw_info;
+
+			if (link->ctx->dc_bios->funcs->get_i2c_info(dcb, link->link_id, &i2c_info) == BP_RESULT_OK) {
+				hw_info.ddc_channel = i2c_info.i2c_line;
+				hw_info.hw_supported = i2c_info.i2c_hw_assist;
+
+				ddc_pin = dal_gpio_create_ddc(
+					link->ctx->gpio_service,
+					i2c_info.gpio_info.clk_a_register_index,
+					1 << i2c_info.gpio_info.clk_a_shift,
+					&hw_info);
+
+				if (ddc_pin) {
+					// need to switch pad to aux mode, one time only
+					// TODO: Handle result
+					dal_ddc_open(ddc_pin, GPIO_MODE_HARDWARE,
+						GPIO_DDC_CONFIG_TYPE_MODE_AUX);
+
+					dal_gpio_destroy_ddc(&ddc_pin);
+				}
+			}
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 2cc646425207..9544abc5b90a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -415,40 +415,43 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 
 	channel = CHANNEL_ID_UNKNOWN;
 
-	ddc = get_ddc_pin(link->ddc);
+	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+		channel = link->aux_hw_inst + 1;
+	} else {
+		ddc = get_ddc_pin(link->ddc);
 
-	if (ddc) {
-		switch (dal_ddc_get_line(ddc)) {
-		case GPIO_DDC_LINE_DDC1:
-			channel = CHANNEL_ID_DDC1;
-			break;
-		case GPIO_DDC_LINE_DDC2:
-			channel = CHANNEL_ID_DDC2;
-			break;
-		case GPIO_DDC_LINE_DDC3:
-			channel = CHANNEL_ID_DDC3;
-			break;
-		case GPIO_DDC_LINE_DDC4:
-			channel = CHANNEL_ID_DDC4;
-			break;
-		case GPIO_DDC_LINE_DDC5:
-			channel = CHANNEL_ID_DDC5;
-			break;
-		case GPIO_DDC_LINE_DDC6:
-			channel = CHANNEL_ID_DDC6;
-			break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			channel = CHANNEL_ID_DDC_VGA;
-			break;
-		case GPIO_DDC_LINE_I2C_PAD:
-			channel = CHANNEL_ID_I2C_PAD;
-			break;
-		default:
-			BREAK_TO_DEBUGGER();
-			break;
+		if (ddc) {
+			switch (dal_ddc_get_line(ddc)) {
+			case GPIO_DDC_LINE_DDC1:
+				channel = CHANNEL_ID_DDC1;
+				break;
+			case GPIO_DDC_LINE_DDC2:
+				channel = CHANNEL_ID_DDC2;
+				break;
+			case GPIO_DDC_LINE_DDC3:
+				channel = CHANNEL_ID_DDC3;
+				break;
+			case GPIO_DDC_LINE_DDC4:
+				channel = CHANNEL_ID_DDC4;
+				break;
+			case GPIO_DDC_LINE_DDC5:
+				channel = CHANNEL_ID_DDC5;
+				break;
+			case GPIO_DDC_LINE_DDC6:
+				channel = CHANNEL_ID_DDC6;
+				break;
+			case GPIO_DDC_LINE_DDC_VGA:
+				channel = CHANNEL_ID_DDC_VGA;
+				break;
+			case GPIO_DDC_LINE_I2C_PAD:
+				channel = CHANNEL_ID_I2C_PAD;
+				break;
+			default:
+				BREAK_TO_DEBUGGER();
+				break;
+			}
 		}
 	}
-
 	return channel;
 }
 
@@ -546,6 +549,7 @@ static bool construct_phy(struct dc_link *link,
 		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
 		link->is_internal_display = (disp_connect_caps_info.INTERNAL_DISPLAY != 0);
 		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
+		link->no_ddc_pin = disp_connect_caps_info.NO_DDC_PIN != 0;
 	}
 
 	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
@@ -568,15 +572,19 @@ static bool construct_phy(struct dc_link *link,
 		goto ddc_create_fail;
 	}
 
-	/* Embedded display connectors such as LVDS may not have DDC. */
-	if (!link->ddc->ddc_pin &&
-	    !dc_is_embedded_signal(link->connector_signal)) {
-		DC_ERROR("Failed to get I2C info for connector!\n");
-		goto ddc_create_fail;
-	}
+	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+		link->ddc_hw_inst = link->aux_hw_inst;
+	} else {
+		/* Embedded display connectors such as LVDS may not have DDC. */
+		if (!link->ddc->ddc_pin &&
+		    !dc_is_embedded_signal(link->connector_signal)) {
+			DC_ERROR("Failed to get I2C info for connector!\n");
+			goto ddc_create_fail;
+		}
 
-	link->ddc_hw_inst =
-		dal_ddc_get_line(get_ddc_pin(link->ddc));
+		link->ddc_hw_inst =
+			dal_ddc_get_line(get_ddc_pin(link->ddc));
+	}
 
 	enc_init_data.ctx = dc_ctx;
 	enc_init_data.connector = link->link_id;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 70f854cca029..211fd3396164 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -119,25 +119,32 @@ static void ddc_service_construct(
 	ddc_service->link = init_data->link;
 	ddc_service->ctx = init_data->ctx;
 
-	if (init_data->is_dpia_link ||
-	    dcb->funcs->get_i2c_info(dcb, init_data->id, &i2c_info) != BP_RESULT_OK) {
-		ddc_service->ddc_pin = NULL;
-	} else {
-		DC_LOGGER_INIT(ddc_service->ctx->logger);
-		DC_LOG_DC("BIOS object table - i2c_line: %d", i2c_info.i2c_line);
-		DC_LOG_DC("BIOS object table - i2c_engine_id: %d", i2c_info.i2c_engine_id);
-
-		hw_info.ddc_channel = i2c_info.i2c_line;
-		if (ddc_service->link != NULL)
-			hw_info.hw_supported = i2c_info.i2c_hw_assist;
-		else
-			hw_info.hw_supported = false;
-
-		ddc_service->ddc_pin = dal_gpio_create_ddc(
-			gpio_service,
-			i2c_info.gpio_info.clk_a_register_index,
-			1 << i2c_info.gpio_info.clk_a_shift,
-			&hw_info);
+	if (ddc_service->link && ddc_service->ctx->dc->config.dp_connector_no_native_i2c &&
+		ddc_service->link->no_ddc_pin) {
+		// Obtain aux instance info from i2c_info without GPIO DDC pin info
+		if (dcb->funcs->get_connector_aux_info(dcb, init_data->id, &i2c_info) == BP_RESULT_OK)
+			ddc_service->link->aux_hw_inst = (uint8_t)i2c_info.i2c_line;
+	}  else {
+		if (init_data->is_dpia_link ||
+		dcb->funcs->get_i2c_info(dcb, init_data->id, &i2c_info) != BP_RESULT_OK) {
+			ddc_service->ddc_pin = NULL;
+		} else {
+			DC_LOGGER_INIT(ddc_service->ctx->logger);
+			DC_LOG_DC("BIOS object table - i2c_line: %d", i2c_info.i2c_line);
+			DC_LOG_DC("BIOS object table - i2c_engine_id: %d", i2c_info.i2c_engine_id);
+
+			hw_info.ddc_channel = i2c_info.i2c_line;
+			if (ddc_service->link != NULL)
+				hw_info.hw_supported = i2c_info.i2c_hw_assist;
+			else
+				hw_info.hw_supported = false;
+
+			ddc_service->ddc_pin = dal_gpio_create_ddc(
+				gpio_service,
+				i2c_info.gpio_info.clk_a_register_index,
+				1 << i2c_info.gpio_info.clk_a_shift,
+				&hw_info);
+		}
 	}
 
 	ddc_service->flags.EDID_QUERY_DONE_ONCE = false;
@@ -518,11 +525,18 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
 	if (ddc->link->ep_type != DISPLAY_ENDPOINT_PHY)
 		return true;
 
-	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
-		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
-		result = true;
-	}
+	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout) {
+			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout(ddc, timeout);
+			result = true;
+		}
+	} else {
+		if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
+			ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
+			result = true;
+		}
 
+	}
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 817b4010edcb..47abb4066709 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2570,6 +2570,12 @@ bool dp_is_sink_present(struct dc_link *link)
 		(connector_id == CONNECTOR_ID_EDP) ||
 		(connector_id == CONNECTOR_ID_USBC));
 
+	/* We can't perform the step below for ASICs with no Native
+	 * I2C signaling support on DP connectors, so skip it.
+	 */
+	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin)
+		return present;
+
 	ddc = get_ddc_pin(link->ddc);
 
 	if (!ddc) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 3db4f10d1654..80a372ceaa51 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -788,7 +788,10 @@ bool edp_setup_psr(struct dc_link *link,
 		}
 	}
 
-	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
+	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin)
+		psr_context->channel = (enum channel_id)link->aux_hw_inst;
+	else
+		psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
 	psr_context->transmitterId = link->link_enc->transmitter;
 	psr_context->engineId = link->link_enc->preferred_engine;
 
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index b5d97b394131..13da300fd4b7 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -317,6 +317,7 @@ struct bp_spread_spectrum_parameters {
 struct bp_disp_connector_caps_info {
 	uint32_t INTERNAL_DISPLAY    : 1;
 	uint32_t INTERNAL_DISPLAY_BL : 1;
+	uint32_t NO_DDC_PIN : 1;
 };
 
 struct bp_encoder_cap_info {
-- 
2.43.0

