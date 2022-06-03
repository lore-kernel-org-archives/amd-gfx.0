Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A51AC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EBD112406;
	Fri,  3 Jun 2022 20:12:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5511112406
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpPIxDzsH1LP8TBTNVQny8xJNZNtxw6XEi2woWQzY3xoWBp8KklEf7IlqDonJVz/+xygoKRjCulKzCufg4lNYAnpgr5vjSBy/v5LV7Mi0sUhrdT06xgHSjbm0fp5rMPfeE2wxL9Ib7m3OJCHPrk1e98onq8Dj59m20skPceHV+yZbWVtzpPWgodmPHuGPATP88lOsrAplts2SqEPfuK7EGeUBUW8xOFqV36Dq64pzq0+RzT2hbym4c9mYN/cHjQS2ZW3iWDEQqpqAAb0ejV4MyAtYhwaBFmv9ehZoWH0VZrA1YVjIZRvnnCoGe3uXbNZBybSkc+FSkOk5hYdVr+O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buXft95B1nKZfu3+9PowjcGEYw20Jkk6gLLCde4UNbk=;
 b=FUNnMjW6IR9ulIi3UfmoEiOkH9zmIh+zlEt86pm6RTbCC5EZ/u8zJ+prJ2ueKjJOsqdDOSX7EEaipF0nmashSZl9fYxaAYXtkXKrK7xmuSb8yNGtkL4Wn1Iu+we0ViI+VIco0jA5jFxLWPyRzGxfdm8Uggy2QetLNMHRRvB2536IWWM3n6BabvvUkpQeqCUftTaquHsUYCGhqmmGvpYiKCCouJifbglWO00FiMq7egyC2cKSJ2ZeKGESr4pYpG7xzDWgNrK9t9V76E0tdtpUwbU0Sg1VDhBXKAjVMy0U5nNce2XcLoXyvgEGEpnwh3uhe967T1G0RlF56XF99zIE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buXft95B1nKZfu3+9PowjcGEYw20Jkk6gLLCde4UNbk=;
 b=lWbavmTAnr1ULNbf8g7Jrkpy/pLjAL3HOMVN+G6i5tDnCAoGlZINA+2ZyveepGnsq/pTky8ijXrbHgdDCbAqBuCfUq2BlCUUVT4lBT9ywiD6Ru5NdbOrtCjy3PDYwCHtHrBy1IxYBpi+ZVNwH2lsSI0M5OnfrNmg80JFkYCL66c=
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:45 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::fb) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:43 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Fix entry into transient encoder
 assignment mode.
Date: Fri, 3 Jun 2022 16:11:43 -0400
Message-ID: <20220603201147.121817-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e38b5c4-ec8d-481b-e49b-08da459d6bfb
X-MS-TrafficTypeDiagnostic: IA1PR12MB6020:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6020DFE9517D181E3ED97A6BF4A19@IA1PR12MB6020.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oU3weptVeO2GKgo4fI2m5ylYU7f4OO9UcvAGNi7m1YADEVHrH9lsMky/rHwCRKDRbUwQ0JHTBTAzY10hCYf+0bBTAjFm3PQjmnyr6WPU1DSbSOMzW9PW5gN2S53IyiRSuaA4vXxn8V5YOS4GeAIqo8JMc3e7KT8KJBonEKtB7x/rDT9/XVZzuG9UZ6X25AEg7I2BKfkcdhPK/12Lq1kGZXSV6dUaLybKM+b/L7D5JYpj+MPsSXghac5F/OaryPn215MFu7kmE2f12hcUNQL1D4X4U3AU2OOiX2Jdg9ZmR2AFJ8h8bL7f7/9Kavp2J6If3TbVS+RjcFkZB/6mUc5fGt9s6/Sr1QrKoFaq4fSdWzgTJHnexhk2rMKdw9D+bhIET7ML4Y2mr1hYX4BNyfRvGuRKbc3Y0petO1m/njQ6jIvJQ4H08kDURk2nDdrhQgaTNL0x+mDZdNEhiBed09XQlakk800nCsH/d/bUMQHZYJrLWz/MwZbskVyz4RNCBgY7+0xYfMpN36VLF6V1Cb4aw9kTAnX/ssSpDnKP8rzMo74waMGjttIXSeLtZXTDDLo4FHaNbvEFs8ZJBF/1cueOiXuRPKzf3tniQ6uMYnt18Hi5x2v1y6Iqym6gtoTEyRERSZB6Pa+dqaraZC6byqt9olE78yutWqO8aJgqHA8zBXLF2Hq+CwezMFIhDOHFSCzmlXQsmUu1u5bjDe4/7n7Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(81166007)(54906003)(6916009)(356005)(26005)(316002)(40460700003)(86362001)(508600001)(36756003)(186003)(5660300002)(47076005)(336012)(2906002)(70206006)(70586007)(426003)(16526019)(8676002)(4326008)(82310400005)(8936002)(36860700001)(83380400001)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:44.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e38b5c4-ec8d-481b-e49b-08da459d6bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
In some scenarios it is possible for the encoder assignment module to be
set to "transient" mode even though there are no new encoder
assignments.

This can lead to incorrect results when querying encoder assignment,
which in turn can cause incorrect displays to be manipulated.

[How]
Only allow encoder assignment to be in transient mode of operation when
there are valid new encoder assignments.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 17 ++++---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 45 ++++++++++++++++++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  6 +++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  7 +++
 5 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b70fdab5a97f..9b20f340c21f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2812,8 +2812,8 @@ bool perform_link_training_with_retries(
 	j = 0;
 	while (j < attempts && fail_count < (attempts * 10)) {
 
-		DC_LOG_HW_LINK_TRAINING("%s: Beginning link training attempt %u of %d @ rate(%d) x lane(%d)\n",
-			__func__, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
+		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d)\n",
+			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
 			cur_link_settings.lane_count);
 
 		dp_enable_link_phy(
@@ -2883,8 +2883,8 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
-		DC_LOG_WARNING("%s: Link training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
-			__func__, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
+		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
+			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
 			cur_link_settings.lane_count);
 
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
@@ -2927,8 +2927,13 @@ bool perform_link_training_with_retries(
 			 */
 			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
 			link_bw = dc_link_bandwidth_kbps(link, &cur_link_settings);
-			if (req_bw > link_bw)
-				break;
+			is_link_bw_low = (req_bw > link_bw);
+			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
+				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
+			if (is_link_bw_low)
+				DC_LOG_WARNING(
+					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
+					__func__, link->link_index, req_bw, link_bw);
 		}
 
 		msleep(delay_between_attempts);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 42da7f430113..639a0a276a08 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -26,6 +26,8 @@
 #include "resource.h"
 #include "dc_link_dp.h"
 
+#define DC_LOGGER dc->ctx->logger
+
 /* Check whether stream is supported by DIG link encoders. */
 static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 {
@@ -383,6 +385,30 @@ void link_enc_cfg_link_encs_assign(
 			state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 	}
 
+	/* Log encoder assignments. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment =
+				dc->current_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+
+		if (assignment.valid)
+			DC_LOG_DEBUG("%s: CUR %s(%d) - enc_id(%d)\n",
+					__func__,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
+					assignment.ep_id.link_id.enum_id - 1,
+					assignment.eng_id);
+	}
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment =
+				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+
+		if (assignment.valid)
+			DC_LOG_DEBUG("%s: NEW %s(%d) - enc_id(%d)\n",
+					__func__,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
+					assignment.ep_id.link_id.enum_id - 1,
+					assignment.eng_id);
+	}
+
 	/* Current state mode will be set to steady once this state committed. */
 	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
@@ -658,8 +684,25 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 			((valid_uniqueness & 0x1) << 2) |
 			((valid_avail & 0x1) << 3) |
 			((valid_streams & 0x1) << 4);
-		dm_error("Invalid link encoder assignments: 0x%x\n", valid_bitmap);
+		DC_LOG_ERROR("%s: Invalid link encoder assignments - 0x%x\n", __func__, valid_bitmap);
 	}
 
 	return is_valid;
 }
+
+void link_enc_cfg_set_transient_mode(struct dc *dc, struct dc_state *current_state, struct dc_state *new_state)
+{
+	int i = 0;
+	int num_transient_assignments = 0;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (current_state->res_ctx.link_enc_cfg_ctx.transient_assignments[i].valid)
+			num_transient_assignments++;
+	}
+
+	/* Only enter transient mode if the new encoder assignments are valid. */
+	if (new_state->stream_count == num_transient_assignments) {
+		current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_TRANSIENT;
+		DC_LOG_DEBUG("%s: current_state(%p) mode(%d)\n", __func__, current_state, LINK_ENC_CFG_TRANSIENT);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 8b12b4111c88..a788d160953b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -458,6 +458,7 @@ void dcn31_link_encoder_enable_dp_output(
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
 		dcn20_link_encoder_enable_dp_output(enc, link_settings, clock_source);
 
 	} else {
@@ -489,6 +490,7 @@ void dcn31_link_encoder_enable_dp_output(
 			return;
 		}
 
+		DC_LOG_DEBUG("%s: DPIA(%d) - enc_id(%d)\n", __func__, dpia_control.dpia_id, dpia_control.enc_id);
 		link_dpia_control(enc->ctx, &dpia_control);
 	}
 }
@@ -503,6 +505,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
 		dcn10_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
 
 	} else {
@@ -534,6 +537,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 			return;
 		}
 
+		DC_LOG_DEBUG("%s: DPIA(%d) - enc_id(%d)\n", __func__, dpia_control.dpia_id, dpia_control.enc_id);
 		link_dpia_control(enc->ctx, &dpia_control);
 	}
 }
@@ -547,6 +551,7 @@ void dcn31_link_encoder_disable_output(
 	/* Disable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
 		dcn10_link_encoder_disable_output(enc, signal);
 
 	} else {
@@ -578,6 +583,7 @@ void dcn31_link_encoder_disable_output(
 			return;
 		}
 
+		DC_LOG_DEBUG("%s: DPIA(%d) - enc_id(%d)\n", __func__, dpia_control.dpia_id, dpia_control.enc_id);
 		link_dpia_control(enc->ctx, &dpia_control);
 
 		link_encoder_disable(enc10);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 55f2e30b8e5a..1ed1404e969d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -613,7 +613,7 @@ void dcn31_reset_hw_ctx_wrap(
 	}
 
 	/* New dc_state in the process of being applied to hardware. */
-	dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_TRANSIENT;
+	link_enc_cfg_set_transient_mode(dc, dc->current_state, context);
 }
 
 void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index c6f6baa6e677..7beb14169f92 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -110,4 +110,11 @@ bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct
 /* Returns true if encoder assignments in supplied state pass validity checks. */
 bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state);
 
+/* Set the link encoder assignment mode for the current_state to LINK_ENC_CFG_TRANSIENT mode.
+ * This indicates that a new_state is in the process of being applied to hardware.
+ * During this transition, old and new encoder assignments should be accessible from the old_state.
+ * Only allow transition into transient mode if new encoder assignments are valid.
+ */
+void link_enc_cfg_set_transient_mode(struct dc *dc, struct dc_state *current_state, struct dc_state *new_state);
+
 #endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.36.1

