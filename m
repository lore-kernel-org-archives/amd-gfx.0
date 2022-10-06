Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64EC10E8BC;
	Thu,  6 Oct 2022 21:28:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4453B10E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO9aE+Da0bL7mNjckAO9cNsyamIhkj8gyed3isNmQyyncId8h74Q0FSDBV3b96kTCdyHELQW1XgJWLctx/X+AdZbLa1HkdjdTZTV7Vt7JcGE8BS8fIV5pe70gKxgAN6uyAszrVGtTW9B8J806GJ8MgbbY5FiMvL8NCkh0rjcJObaPC8a0tas6cQ7YYCXLNBUIySsVJcrVFJH5dwHsBMMNA8XKGcDSoXyBlP/AkTyVyOI+fMvZ1x5BTJ67yHwMgLlHEJCe0McorkqffiYmKkWPIRWt2l+223vrmLkgYLhJN2rBqFfAgAqPUPpXCd1eOcPJm2uIE76MApb0682209C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHqi4h8/liquJecWruxBrHnI0gcxUJdvDuSDpUz3tFM=;
 b=NcqH9cziO5MPi3mXsQDMKGRYTRXsXafbevbW9s3OVdRuFvZ/0aUkTFYbKXzoFpKiIoGZUy2nLiOp21CHQirwStX8G1XPaauj95Z0UvKMdrsF8OWC2SGLz/z66qvDUfRePnmfASNTwjNk6Ex6NDH/cXYfozGHOL7G2ALHuooSS8wNukeY6wk1b+E0OGMNsGxTeOoIV6MmbBpV1N8L7dCkiJja/QE9K1IRnrVVdEDC6FyGBUHWxQouIAyI98AqYSM/15KPql5vGc0yZ9aTPVAuhbmbxO0Wi3e/zwwz+bZuFctPEFHdq5VfEiw2g1qCtxFX6qT8X+IkHPnu5ueAKwb5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHqi4h8/liquJecWruxBrHnI0gcxUJdvDuSDpUz3tFM=;
 b=ozQrLlti5Uuz9fuRVjFzxwVh2apQc/j072wR9rK01p0zPChKOhxOmLa1vAzaSlopzOvNlZz6+rHo38wyHA8vyLr32Tw3x5wgGuU8mqIx/expoKCbRzC4/ML/IsKyAsX+FfIyMZOgJghiba1FwmcPi4keAg8ApMPIWxFgro1RAy4=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:55 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::89) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:50 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/23] drm/amd/display: Use set_vtotal_min_max to configure
 OTG VTOTAL
Date: Thu, 6 Oct 2022 17:26:45 -0400
Message-ID: <20221006212650.561923-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: c3667b19-3584-47f9-6f37-08daa7e1a1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iC+epV4C6BmF8fMCjA5TYyI2pxAiyEY6hHNO4t1CjtvH2Kr819oBm8Xf6eFBJvuoeikDq4ATdW/Rb4XU8TE1g1YedoRtFxb4UykNZ9DlLRAqXf+hEBvTuwRhzCcMYcPSRmUfaAoDS0pE4YyUxUtCG8wHzRiW9dLrfpFkysyqvwAcSrlBnQL9zhAjWlc1MTzTdZIwar3QWoLGXrWc+pzqg6kMXRjmhFqtt6DYGhlvKhl+FvtEn45UyvyY7Y6Zy+BAN9wjgpVv3MkAb5004VbOz9HsTljzls4kWDT2osvIdfjealUEuYFQYdmz8RpPZ2WMM34YOwkE/q6C2Vpyq95wyrVXO0sCSlKUx41zzYYuXRVPes0AXm909bK4jzBNKQVSk4mtA7P0nWOuDteySZ4nXulPEyR1W33QaUFbiO+OgyJU0za4Lx3YgWuybpRsONBSninKplsCvihDrWNfJ3i5d1gdiIg9gb7eoLCJ+uRet8Aqe5d6nddkcX9vFsuEVsjvX/J/1yHXuAQuywQ4TF3Rlmfp3x4Z7MS5rj6hNsPODW6QD/wJpKC7+FLMikSsrLPYXiKi00V5xdU5P2qDgMkUZkMnJRmFPr03xgI7K7IKIbJFXgP5whJ6DDhb7MAfjLyexBETcgbywquJYhwMZwJtdZa53PZnjVHcr8CdC6syBeiuF1P1kOw79BDl+ybNzcAFGfdpGcFDgVs3PqC9L1wqE1AWCHwlkJHGxWJFTLsfj34pWlRqDkTB0vpY1EnhuaaPwswIpGskTxxHk+7y6f2pS3oMHhZ0FdUyc5Pil5l8rPWp4C12C78r+ZEi6QAJ5onD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(6916009)(36756003)(86362001)(36860700001)(44832011)(336012)(16526019)(1076003)(2616005)(83380400001)(356005)(82740400003)(81166007)(47076005)(426003)(186003)(26005)(8676002)(478600001)(6666004)(316002)(70206006)(54906003)(70586007)(4326008)(8936002)(82310400005)(41300700001)(5660300002)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:54.9408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3667b19-3584-47f9-6f37-08daa7e1a1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

In multiple parts of the DCN code, we
write directly to the OTG_V_TOTAL_* registers
in some OPTC functions. Let's avoid it by using
the set_vtotal_min_max.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  | 18 ++++--------------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c  |  1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  4 ----
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 143a900d4d3d..dca8a1446120 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -207,10 +207,7 @@ void optc1_program_timing(
 	/* In case of V_TOTAL_CONTROL is on, make sure OTG_V_TOTAL_MAX and
 	 * OTG_V_TOTAL_MIN are equal to V_TOTAL.
 	 */
-	REG_SET(OTG_V_TOTAL_MAX, 0,
-		OTG_V_TOTAL_MAX, v_total);
-	REG_SET(OTG_V_TOTAL_MIN, 0,
-		OTG_V_TOTAL_MIN, v_total);
+	optc->funcs->set_vtotal_min_max(optc, v_total, v_total);
 
 	/* v_sync_start = 0, v_sync_end = v_sync_width */
 	v_sync_end = patched_crtc_timing.v_sync_width;
@@ -931,11 +928,7 @@ void optc1_set_drr(
 
 		}
 
-		REG_SET(OTG_V_TOTAL_MAX, 0,
-			OTG_V_TOTAL_MAX, params->vertical_total_max - 1);
-
-		REG_SET(OTG_V_TOTAL_MIN, 0,
-			OTG_V_TOTAL_MIN, params->vertical_total_min - 1);
+		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
 
 		REG_UPDATE_5(OTG_V_TOTAL_CONTROL,
 				OTG_V_TOTAL_MIN_SEL, 1,
@@ -954,11 +947,7 @@ void optc1_set_drr(
 				OTG_V_TOTAL_MAX_SEL, 0,
 				OTG_FORCE_LOCK_ON_EVENT, 0);
 
-		REG_SET(OTG_V_TOTAL_MIN, 0,
-			OTG_V_TOTAL_MIN, 0);
-
-		REG_SET(OTG_V_TOTAL_MAX, 0,
-			OTG_V_TOTAL_MAX, 0);
+		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
 }
 
@@ -1577,6 +1566,7 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
 		.get_last_used_drr_vtotal = NULL,
+		.set_vtotal_min_max = optc1_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.set_test_pattern = optc1_set_test_pattern,
 		.program_stereo = optc1_program_stereo,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 02459a64ee21..892d3c4d01a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -325,6 +325,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
+		.set_vtotal_min_max = optc3_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
@@ -365,4 +366,3 @@ void dcn30_timing_generator_init(struct optc *optc1)
 	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index d873def1a8f9..63a677c8ee27 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -201,7 +201,6 @@ void optc31_set_drr(
 
 		// Setup manual flow control for EOF via TRIG_A
 		optc->funcs->setup_manual_trigger(optc);
-
 	} else {
 		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
 				OTG_SET_V_TOTAL_MIN_MASK, 0,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1d36f0fceb3e..7a8f61517424 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2941,11 +2941,7 @@ struct dmub_rb_cmd_get_visual_confirm_color {
 struct dmub_optc_state {
 	uint32_t v_total_max;
 	uint32_t v_total_min;
-	uint32_t v_total_mid;
-	uint32_t v_total_mid_frame_num;
 	uint32_t tg_inst;
-	uint32_t enable_manual_trigger;
-	uint32_t clear_force_vsync;
 };
 
 struct dmub_rb_cmd_drr_update {
-- 
2.25.1

