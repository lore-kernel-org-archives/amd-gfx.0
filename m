Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FACA1002
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4816810E550;
	Tue,  2 Sep 2025 00:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbtJYtBg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1B410E550
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN4mwZETW4mmHiLj7iy0eDkuRPuQHpcpDobBoc9Mn8Nhaf+IuCcF5zR8TT2Jp8L5ZeQN66EESnrpoe9I6XDxHytslHIzox6DMLl8FPNWVGPp1wZwRF4qNELqfMJN72bkc3Ct7W+VdL0DhZ1inCKmgbOVa6dSSY+NAniqrV1TZZdjdEsU065Izv6BWuFOc0ROsj5KnUS42/SNIlmh03UwBNuVsTPRgw0bUrnFC09Ui+4Q2MlNnNKGra2T5ugKQuAMi83nH1R+cmabQuUmlI+IkWAswYh/4p68bl8Q7FBxWC6ID3nfHJXl/EsrKnVDcmfcGQpBUIlWR6acqXh2oDNZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJhyqILz4ggadwC1VlvhXuaMwMwwTXw0ft1mYdZVf8E=;
 b=GuzEgm8el5fraG0yyGT+n/CRvkxpvAkpJMOI02EdRfQ8YAMmJn10+LLjtk2E/mt7xxHOuiwsASjrp/tM6pCaWWjrKwZo1KxasW3gnWDRaRGJLcdSKD5xxM6X0vyxd/m6LOfZbttarTokki0p/uHYlYHAtj32ocUHAke5XQjSx9P8FEEOT1mzc0LNbIeK1Ku8edCo8D2W7/aevQQv8WGaz1XQ9Imnjl+GSZQmadwYGLJNfokP/Tgi+uI8QQEDqfi1jT9YdxMabBHd8XksNPDE+FbhdTdwz+NxZxQm0AiuTAP4p4m03pLVPNwfonZF24GZ8Vb6NiKydKKn0Og4cMWVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJhyqILz4ggadwC1VlvhXuaMwMwwTXw0ft1mYdZVf8E=;
 b=mbtJYtBg1IXz1Aa/HGFJaGoJ23Ng/hskFbDQbZyQR0YRByP6WFnMU4d9n4rTEyNrMUU7kUKHB4ccIQ+e87qi2ukYIb2MvpZ9tktCM/WoGXMTviWcav++PkoPA1c+xa3J6JpqUa5uYYRGHH0hHBv9KIUPbq9KC98eYXXMhNwfLJI=
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 00:47:13 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::21) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Tue,
 2 Sep 2025 00:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 00:47:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:47:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:47:09 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:47:03 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 10/11] drm/amd/display: Disable stutter when programming
 watermarks on dcn32
Date: Tue, 2 Sep 2025 08:42:55 +0800
Message-ID: <20250902004532.1833436-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ff2f26-dc27-453a-c2f5-08dde9ba4174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|30052699003|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LY9Ofui8ihiGwlHbumxUuOyMRW8YpUd2kw3I+VIIXap7MDi7OokbwRzgdMF7?=
 =?us-ascii?Q?LdVX3CrBAEMYVZmfSvZk2ODDOtHiWSPaLwq43O41T96Pxv7RmoLxg40dtg6w?=
 =?us-ascii?Q?OpnuWYed08UvSEsHW5rYcdtE8Ka9H2SZQwkCa3SEkXFUaf1u4NAJnNC3uSHW?=
 =?us-ascii?Q?2CLKxepBrS837jBcJdz4GuK0WtVO0b3phOXC/bCrGqXQ30pcxHuagUzLE9Bj?=
 =?us-ascii?Q?NqgHhrxFwZXPJWZ6bJnKTXlnV3OecgDneYa40AzcheU7jwU4IM3BMcXhIaEi?=
 =?us-ascii?Q?xe9vn9Bh4m3LFTLCjP1YLREmTSKnmBt6AOF4BZyr6CAEkk8brWNKw5YO32Ki?=
 =?us-ascii?Q?UZ1nZf7itGSO+bSyAl7wGwYkmsm8YmGNYkSFWtG9beIu3Ti0dc52NGaPpN3B?=
 =?us-ascii?Q?gcgvlWVwtryAhYk+dodHkf2BPzavZTaa0WdGV3XOXoqs8KGqQ4t1VNgT1Icp?=
 =?us-ascii?Q?newnESgiJAPOGSzzXlj3qRJKTgkFXm5LXxHdcO41r3fBTun+Wgz6z/vwAoaD?=
 =?us-ascii?Q?bOnng6TQ1dpPSrTHwdS2C5pPiWMiPmTc5jtfxijGF0CBZChcUUmetcw55hGp?=
 =?us-ascii?Q?scd98jF2yIM0i5c0rH99ILsyvf4EtQTuoGyYRbiNZBznUSseHSqWdSOFjFQ8?=
 =?us-ascii?Q?hirU8hlomsQHnxcc6i8+OvABX3IxPmE/Q519Jfl50MNemV6O7EmW/CozTxVY?=
 =?us-ascii?Q?1K+lG/TrTfR9rxurpW6Po9f9lMOE/lDE0tkj8W0R2gFGSA5QtzbUFUvHh15H?=
 =?us-ascii?Q?HwtOkG9GPharXiJymnudtWMpuPVAB1/7FpcJaF9RmbIhs4M/AR/7DGR3kNh+?=
 =?us-ascii?Q?aYJgk0lH0FxNKPhb+1M9i1qoBtSYOLBmNMWXflNkF8bouOq0lj0DBhgmMSU7?=
 =?us-ascii?Q?IBGgkJulF4wP280+p6yiV4wSMrM/xfDFQMc4xD7feV1G/qD+EmpPz0E6CpTG?=
 =?us-ascii?Q?FrDdAx53ZJJyv35nOrnmK/dRFpeDzbuUwUWu8ccinIMUME9RTu25u0sUANwX?=
 =?us-ascii?Q?4SujrI1CMjuR3nOAOTnB4ffHdRCd9e9gQCFTNrd/VQLb4higuma49Dib8ev/?=
 =?us-ascii?Q?SGE8meorbrozTqJmCv+pTEuKN3rsJ3kvYJJ6vGJR330GqOeW/z3J0DiPysj7?=
 =?us-ascii?Q?btLK8nvPHtoiSwvHzgEh30KtctyYYuhhd27OHt1AyZHhweChZTYdPUcqPhuW?=
 =?us-ascii?Q?I2AE33VcEnwn2yMzVr7qqf6+xnD57pYY58EGyfLfOy63kdKkrLS4b6gRZw0r?=
 =?us-ascii?Q?L4RogpyNjdechFpNBpC7w1ughXisZ5rYc8rMFm7NL9NNaNM+h+5XOBr1oLG/?=
 =?us-ascii?Q?pDEc9Y8M+IZIlpbeI5t+V5oQ+FiOnHI6HdK+GXI0ON4Fyw0FyB75YWhACNzd?=
 =?us-ascii?Q?IBmPJXhM1Zx1P9B4VfB1mVLsZaT/3ChCoavzLctfaAoOcKRjFAR8Smc0tJhd?=
 =?us-ascii?Q?6wb6JEirzfH7Lz98hUMA0YhlSHO4sIr5RNxNCapQ86vtG5gCofJL0L+tHxTG?=
 =?us-ascii?Q?OKDhpRZ0B6S4oepOyhMbZn8DWoJJji98Pv1ZQ5qq8XoevI9MnBInxjrx7Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(30052699003)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:47:12.6953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff2f26-dc27-453a-c2f5-08dde9ba4174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Reprogramming watermarks with stutter allowed can cause instability on
some ASICs. Disable it prior to raising watermarks (prepare bandwidth),
then re-enable after lowering (optimize bandwidth).

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    | 37 ++++++++++++++++---
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 09d705cf5c9b..d32304443abc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1163,6 +1163,7 @@ struct dc_debug_options {
 	unsigned int auxless_alpm_lfps_t1t2_us;
 	short auxless_alpm_lfps_t1t2_offset_us;
 	bool enable_pg_cntl_debug_logs;
+	bool disable_stutter_for_wm_program;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 92957398ac0a..3b71bfaca291 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -28,6 +28,7 @@
 #include "dcn32_hubbub.h"
 #include "dm_services.h"
 #include "reg_helper.h"
+#include "dal_asic_id.h"
 
 
 #define CTX \
@@ -72,6 +73,14 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
+static void hubbub32_set_sdp_control(struct hubbub *hubbub, bool dc_control)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
+			SDPIF_PORT_CONTROL, dc_control);
+}
+
 void hubbub32_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -754,8 +763,17 @@ static bool hubbub32_program_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	struct dc *dc = hubbub->ctx->dc;
 	bool wm_pending = false;
 
+	if (!safe_to_lower && dc->debug.disable_stutter_for_wm_program &&
+			(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+			ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
+		hubbub32_set_sdp_control(hubbub, false);
+		hubbub1_allow_self_refresh_control(hubbub, false);
+	}
+
 	if (hubbub32_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
 		wm_pending = true;
 
@@ -786,10 +804,20 @@ static bool hubbub32_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower) {
+		/* after lowering watermarks, stutter setting is restored, SDP control given to DC */
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+
+		if (dc->debug.disable_stutter_for_wm_program &&
+				(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+				ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+			hubbub32_set_sdp_control(hubbub, true);
+		}
+	} else if (dc->debug.disable_stutter) {
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+	}
 
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, dc->debug.force_usr_allow);
 
 	return wm_pending;
 }
@@ -974,8 +1002,7 @@ void hubbub32_init(struct hubbub *hubbub)
 	ignore the "df_pre_cstate_req" from the SDP port control.
 	only the DCN will determine when to connect the SDP port
 	*/
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
-			SDPIF_PORT_CONTROL, 1);
+	hubbub32_set_sdp_control(hubbub, true);
 	/*Set SDP's max outstanding request to 512
 	must set the register back to 0 (max outstanding = 256) in zero frame buffer mode*/
 	REG_UPDATE(DCHUBBUB_SDPIF_CFG1,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 9917b366f00c..e81b9a0499d2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -739,6 +739,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
+	.disable_stutter_for_wm_program = true
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 20d714596021..99f0432288b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1230,7 +1230,8 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SR(DCHUBBUB_ARB_MALL_CNTL),                                              \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
       SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
-      SR(SDPIF_REQUEST_RATE_LIMIT)
+      SR(SDPIF_REQUEST_RATE_LIMIT),                                            \
+      SR(DCHUBBUB_SDPIF_CFG0)
 
 /* DCCG */
 
-- 
2.43.0

