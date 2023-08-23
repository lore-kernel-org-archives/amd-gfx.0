Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306BBEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829F210E462;
	Wed, 23 Aug 2023 16:04:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6B710E462
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaJsFNfze1Y7QvsL+i+vfrJO4MLaNEjyF9k3VbRM5HPt2uMagTClyikJcdzHWi1pIxLHC2Sgym/9L20sL9oPOXJjE4aMGOlLbWzaZ7dURcSManI8gfYRORC5h2KDjHGc95HDn7ukEU1ZWthqMduNVxIyhi+FrJIUJ+e5JAVK+3oDOLvWrsQim4I/818M9Mc5z17FZTsoKrdaG7ukQuvlVn14fCKB/CI8PpqydYGX45KrDgIudGXRpKa3/ZAOFrR9a77nD1xzL48AQuM1b3lpvAXLJyAEnPcdJtqEnxVr+5r3eC4jBDxH7y5miynqkXvCNtYs4voDnOutyZ8VyvbNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEMMxd3ETBcObLGxWztkqyzl9kOuIzxmLi0v9nmJ6xE=;
 b=MknE4nL7fAXzbVZKXm5YGWGdRMtdYNPzgVOWtDiSVJ0Sgmvn364wJhuw2701inHZe2nFxNsDtwdSesCWDnf1ek5TnS/ws/4REeAK9MpIXhOsuc7OF1F/j3N7MQb9kb/OLDAWSt+9c/KJJWLdiQ11CJpBoHbCaYQu2L0Gz8zxhvIQh+o4xmky06lmhh3exxQ87QMKwWJGMJSOUOJS6xCv4xk7oSRTzttxjL6e4T6yCY00IHhH33cn5pqBoLSXv+ALpweSBnGVdic3RQlxhydDCeNCRnr3aEb3LRGK9CicxLZzBhMPs4E2u05zwJgkCFgB32bAFB3kqBibu9x/GHVfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEMMxd3ETBcObLGxWztkqyzl9kOuIzxmLi0v9nmJ6xE=;
 b=unj7Wfaiik8s/F0wOr86TwAnzhcVDUPpWNwN+ILZ9Lzm6rHiZdCgAm1RnXonC6wxJ+kvuVDr10eagqn3nooQVyaVZPC+dbo6Iac04lm/pn+mOkDnWO6NmE+2A1Kti5lmK7MJBpWTWTqhE6LYZn0R9iJnmLpOY8W9V2YQ2ycPfGM=
Received: from SA0PR11CA0133.namprd11.prod.outlook.com (2603:10b6:806:131::18)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:20 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::b2) by SA0PR11CA0133.outlook.office365.com
 (2603:10b6:806:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:12 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Add support for 1080p SubVP to reduce
 idle power
Date: Wed, 23 Aug 2023 11:58:04 -0400
Message-ID: <20230823160347.176991-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: ff629bf0-0b88-44f3-0ee6-08dba3f29c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FJ8Q+ORBow2CWLyvSNnNCMtOXnNktcVQkFHXmz1lWL7jVxEwbURGm0SGjDWVy2XIp5dnO3VpbTPDSbeWHEa/Rxxu1detiTRD5tioVEqj1s8ES63XUbKfAzIO8xxoXeuXgnLnwVzPtVB74HhYcBIhczArKh58rIBOEJL7DTa4Bo/LcWu+D67TyFszIAmkmrXi+Skek914ugK5J7cW/19HG8rAoH1fuRpmvSBWCXFL36GtvBGhVDKu8Kwtnu+ujfqpXMimb+KbYMCelaP8BS9ftdIdSqHaxB8LiH7cO/KDXsvS4p1C5RZqUbAn/tdPiZVLa0O51QvbHhEOFiylmAzUGA6Ovmkbhf4Q6jHZjkpCYOEVip8og8x9nU03xS6vs/ytn5vdWBspHrt6N8MtC/acYl3RXnupJpkJNXbGxF3xXwOiR5jvRxo3ri3hj2XKbjLlbGU2gbW9C0GjyCTfYjh6o66U0FCO7U8YgPYQT+40dueZ8sWmUcOE/UgOP/oXFvmExTArnIO6/mafzQW9Yvxf7ORUBBrobNTn0vleHoPkX8l4tVxKA1kfxBGgrQhCCCFZyKSvjU9k85O9U6xgzuJmhoSSPZVF6KZmySNaOhCG4UPEiEYqUIs5h+XX/fuhy71yDbTeZ1TUgQ6sgZouDdrxw9krC1l6P6I+r/xcY3rG6e+n0sxghHRuXf9Latoq/LVX/PmtEafhR8U0e+fAuduhK7R5EplibDxUV19BkYg5UIXLu5Xi/sduGzRdu6BIXhKEuD/gxiIs2hQDY/QYYKQdKG/Nd7xtKAvLO8p82EWBMyhn9zaJhSaGdob7YMfy/1F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(6916009)(316002)(4326008)(8676002)(8936002)(40480700001)(54906003)(70586007)(70206006)(41300700001)(1076003)(26005)(16526019)(336012)(426003)(44832011)(5660300002)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(86362001)(36756003)(2906002)(82740400003)(81166007)(356005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:20.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff629bf0-0b88-44f3-0ee6-08dba3f29c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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
 Alvin Lee <alvin.lee2@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Ethan
 Bitnun <ethan.bitnun@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <ethan.bitnun@amd.com>

- Override the det to adjust microschedule timings allow for
  1080p configs with SubVP
- To lower unnecessary risk, we prevent multi 1080p configs
  from using SubVP, as multi 1080p already has low idle power.
- Count the number of streams to verify that we are in a
  SubVP config before overriding

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ethan Bitnun <ethan.bitnun@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 46 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  3 +-
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 01fe2d2fd241..dad1c85a1df3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -322,7 +322,7 @@ static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
 	 * then cause corruption.
 	 */
 	if ((refresh_rate >= 120 && refresh_rate <= 175 &&
-			stream->timing.v_addressable >= 1440 &&
+			stream->timing.v_addressable >= 1080 &&
 			stream->timing.v_addressable <= 2160) &&
 			(dc->current_state->stream_count > 1 ||
 			(dc->current_state->stream_count == 1 && !stream->allow_freesync)))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 103a2b54d025..0c6ca3da66d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -38,7 +38,7 @@
 #define DCN3_2_MBLK_HEIGHT_4BPE 128
 #define DCN3_2_MBLK_HEIGHT_8BPE 64
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
-#define SUBVP_HIGH_REFRESH_LIST_LEN 3
+#define SUBVP_HIGH_REFRESH_LIST_LEN 4
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 3ad2b48954e0..f5705b3e6e42 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -255,6 +255,51 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 	return psr_capable;
 }
 
+static void override_det_for_subvp(struct dc *dc, struct dc_state *context, uint8_t pipe_segments[])
+{
+	uint32_t i;
+	uint8_t fhd_count = 0;
+	uint8_t subvp_high_refresh_count = 0;
+	uint8_t stream_count = 0;
+
+	// Do not override if a stream has multiple planes
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->stream_status[i].plane_count > 1) {
+			return;
+		}
+		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			stream_count++;
+		}
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream && pipe_ctx->plane_state && pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+			if (dcn32_allow_subvp_high_refresh_rate(dc, context, pipe_ctx)) {
+
+				if (pipe_ctx->stream->timing.v_addressable == 1080 && pipe_ctx->stream->timing.h_addressable == 1920) {
+					fhd_count++;
+				}
+				subvp_high_refresh_count++;
+			}
+		}
+	}
+
+	if (stream_count == 2 && subvp_high_refresh_count == 2 && fhd_count == 1) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->stream && pipe_ctx->plane_state && pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+				if (pipe_ctx->stream->timing.v_addressable == 1080 && pipe_ctx->stream->timing.h_addressable == 1920) {
+					if (pipe_segments[i] > 4)
+						pipe_segments[i] = 4;
+				}
+			}
+		}
+	}
+}
+
 /**
  * dcn32_determine_det_override(): Determine DET allocation for each pipe
  *
@@ -336,6 +381,7 @@ void dcn32_determine_det_override(struct dc *dc,
 			}
 		}
 
+		override_det_for_subvp(dc, context, pipe_segments);
 		for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 			if (!context->res_ctx.pipe_ctx[i].stream)
 				continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b3252db43ecb..96e3075e6dd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -41,7 +41,8 @@ static const struct subvp_high_refresh_list subvp_high_refresh_list = {
 			.res = {
 				{.width = 3840, .height = 2160, },
 				{.width = 3440, .height = 1440, },
-				{.width = 2560, .height = 1440, }},
+				{.width = 2560, .height = 1440, },
+				{.width = 1920, .height = 1080, }},
 };
 
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
-- 
2.41.0

