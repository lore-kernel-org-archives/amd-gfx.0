Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EA6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870C910E6F2;
	Fri, 17 Dec 2021 21:24:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E976110E6D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwkJ2WYwMpcJ+u3eOVEATf0NhV6Di1axnKIL8WKP+KjdOwG1QdwoJV17P7soEKko4ladlnqPG4MkANHEubyw1FUQ+AMuqPtVdRauL+7OT28oJ14LVqPeZcGyeomWLmfnO4+y1hkrK1+k3qCwObmWIiXT5578Es2VBpAWwRFoJkS/lMRID7OzGXfHb1mawrg+S32bauMMq6a7+OR3NWqGlO8L3g+SviVJIYh9vcbQamqyszDzuQGOvSQYyKlgsCD1gNgDHqREBWvy7Mj1vNxKdmu/hxPhbYnoTNJy+qhj1hlYpDswzahy+cgaFhHVR0bUksTKP/xtUlPMlsO4/kJlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xszK6SR4ZQMirDYcTHhOZoxHCWalLYomi/6aUacpvtk=;
 b=G8L4wD9vTJZxT8C6xyssWTEbwnrcd8Y1sElBjdkOfPWFSFK6BGQltHIpeAO14Ji36zoOPdDwLT6EpLih16OrMe/vnPn3MxwBYy28/3VJ2kSAVVMNIjbR7vXura1hgSp1HZAw7dkjBVzqe4QXe1NcBMbKbdwMaZLfOHXOsEkISojWRFH5AFQ70eHJb91ZDftEfIYAOBINNQz6JXbDlD6SN88454RjBVv5ZL8xyW0K3bKxkCJ5MG8JaeM+3QbAwvl/bY+p21IldSBDe/7o1/Tjis5GTL/0ulCtAIgz5S52ioBuz5v7gxdZqmoAhjj7zyLjPMVSvjnZRV3Nnf63HIR1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xszK6SR4ZQMirDYcTHhOZoxHCWalLYomi/6aUacpvtk=;
 b=ikqY+O9lkqIdwLc56bC1EZU6bxwQDBy6RyUbtYoPp56L7Y1ga01l00ylEGtST178Ymdj+/n2+ALlcuiri8tQJaPu/dcQrR4y7daBwS+8PvnCuhV0UONRbM7hzdT+fahUhAfRPrrFSMfX1zaf1zOYEYhwDUStUs+2ufnnKHHQhN8=
Received: from CO2PR06CA0071.namprd06.prod.outlook.com (2603:10b6:104:3::29)
 by CY4PR12MB1334.namprd12.prod.outlook.com (2603:10b6:903:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 21:24:46 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::a5) by CO2PR06CA0071.outlook.office365.com
 (2603:10b6:104:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:46 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:42 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: support dynamic HPO DP link encoder
 allocation
Date: Fri, 17 Dec 2021 16:24:06 -0500
Message-ID: <20211217212407.3583190-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04434d84-f855-45c8-72c4-08d9c1a3a69e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1334:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1334013A4886D16C9A32FCB998789@CY4PR12MB1334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ofie8ms176GbJW1Z8Ss6hj+vS9Sv+7aj4GvxfqXCK6RhuVUb5XNy5bq6ul4ZCTS37vSgH69imDbAJxwv16gy6k/4ARbPLqKvwY+8C9OsLBWKqhxHXy7psOrOEro1gY48iR/cAlhaMxftBS9a6UTZH7xQqdL3g8sTfEOFIz5No8/+VOrbVu7udMSuwoH47sRnxNJ+8YHwsU34TzPCnCvwCj8rnfWCAs0nrMozKsvyQGpJUi8y1+iLjE5A+uFvs/uCYa4xgAQhQMd49C/C/EyvknHScGQv3GKXcNNOIL0Cz/vermIxAJc8tgWzyZunTcPKMcX8zgIGbH0cnUoJvfZAc9CK855Hf1r1X5PCqULcuYXNuJfohaCx6mDFsnhQMFyYjLWAWc+9cL/KDlJj1bYleixv5u4SwGemm/o6oc8BtoGhaJNawdO/D4SR2Rg1jbmbYawfk2jWSw2RZOszpOx6dll9oXyH3ERsMyaGIwut46LZfldMrwE021DDIvvVb/9JqrRKYWM//e6wC60GUcOei5wWZAZeFta+8WiwnjVPeOKvKlUw1Z6z2HIfFZlr0gorkd590gjIy16kjAO7p0xCcM/O2mw6DExXo8775sFAbvvc6YN8Aqj2aVdTDVJ2pMzFAYiGEeFVhA6UhZ9jlm2qanlcx8grB1rsWoVP7I3gcLDn0my3m2kUS1pwqh+rw9tThM5/PjM1yamK9nQ97j8J57vcCRUo0dpMeQJCUTgqVmyNs3lr5VOpkq+ocZLbLGbMf4GEpzHBkdox9TO/sJUWaBD2flhg8hvy6wVqGaPxiFk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(83380400001)(1076003)(36756003)(186003)(2906002)(6666004)(47076005)(54906003)(2616005)(356005)(16526019)(81166007)(4326008)(316002)(70206006)(82310400004)(26005)(5660300002)(426003)(40460700001)(30864003)(336012)(8676002)(86362001)(8936002)(36860700001)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:46.7275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04434d84-f855-45c8-72c4-08d9c1a3a69e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1334
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
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When there are more DP2.0 RXs connected than the number HPO DP link
encoders we have, we need to dynamically allocate HPO DP link encoder to
the port that needs it.

[how]
Only allocate HPO DP link encoder when it is needed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 ---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  43 ++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 119 ++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   3 -
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   6 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |   3 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +-
 12 files changed, 134 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c250f6de5136..91c4874473d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -274,24 +274,6 @@ static bool create_links(
 			goto failed_alloc;
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) &&
-				dc->caps.dp_hpo &&
-				link->dc->res_pool->res_cap->num_hpo_dp_link_encoder > 0) {
-			/* FPGA case - Allocate HPO DP link encoder */
-			if (i < link->dc->res_pool->res_cap->num_hpo_dp_link_encoder) {
-				link->hpo_dp_link_enc = link->dc->res_pool->hpo_dp_link_enc[i];
-
-				if (link->hpo_dp_link_enc == NULL) {
-					BREAK_TO_DEBUGGER();
-					goto failed_alloc;
-				}
-				link->hpo_dp_link_enc->hpd_source = link->link_enc->hpd_source;
-				link->hpo_dp_link_enc->transmitter = link->link_enc->transmitter;
-			}
-		}
-#endif
-
 		link->link_status.dpcd_caps = &link->dpcd_caps;
 
 		enc_init.ctx = dc->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 21be2a684393..643762542e4d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -422,6 +422,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "The operation is not supported.";
 	case DC_UNSUPPORTED_VALUE:
 		return "The value specified is not supported.";
+	case DC_NO_LINK_ENC_RESOURCE:
+		return "No link encoder resource";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9197dd73c6d2..c5d3e2417ef6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -66,31 +66,6 @@
 /*******************************************************************************
  * Private functions
  ******************************************************************************/
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-static bool add_dp_hpo_link_encoder_to_link(struct dc_link *link)
-{
-	struct hpo_dp_link_encoder *enc = resource_get_unused_hpo_dp_link_encoder(
-					link->dc->res_pool);
-
-	if (!link->hpo_dp_link_enc && enc) {
-		link->hpo_dp_link_enc = enc;
-		link->hpo_dp_link_enc->transmitter = link->link_enc->transmitter;
-		link->hpo_dp_link_enc->hpd_source = link->link_enc->hpd_source;
-	}
-
-	return (link->hpo_dp_link_enc != NULL);
-}
-
-static void remove_dp_hpo_link_encoder_from_link(struct dc_link *link)
-{
-	if (link->hpo_dp_link_enc) {
-		link->hpo_dp_link_enc->hpd_source = HPD_SOURCEID_UNKNOWN;
-		link->hpo_dp_link_enc->transmitter = TRANSMITTER_UNKNOWN;
-		link->hpo_dp_link_enc = NULL;
-	}
-}
-#endif
-
 static void dc_link_destruct(struct dc_link *link)
 {
 	int i;
@@ -118,12 +93,6 @@ static void dc_link_destruct(struct dc_link *link)
 		link->link_enc->funcs->destroy(&link->link_enc);
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (link->hpo_dp_link_enc) {
-		remove_dp_hpo_link_encoder_from_link(link);
-	}
-#endif
-
 	if (link->local_sink)
 		dc_sink_release(link->local_sink);
 
@@ -975,10 +944,11 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-			if (dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING) {
-				add_dp_hpo_link_encoder_to_link(link);
-				link_res.hpo_dp_link_enc = link->hpo_dp_link_enc;
-			}
+			if (dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING)
+				link_res.hpo_dp_link_enc = resource_get_hpo_dp_link_enc_for_det_lt(
+						&link->dc->current_state->res_ctx,
+						link->dc->res_pool,
+						link);
 #endif
 
 			if (link->type == dc_connection_mst_branch) {
@@ -4083,7 +4053,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 			config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 		if (is_dp_128b_132b_signal(pipe_ctx)) {
 			config.stream_enc_idx = pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
-			config.link_enc_idx = pipe_ctx->stream->link->hpo_dp_link_enc->inst;
+
+			config.link_enc_idx = pipe_ctx->link_res.hpo_dp_link_enc->inst;
 			config.dp2_enabled = 1;
 		}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index dd69e8f22e75..45d03d3a95c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -800,7 +800,8 @@ void enable_dp_hpo_output(struct dc_link *link,
 		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
 				link_res->hpo_dp_link_enc,
 				link_settings,
-				link->link_enc->transmitter);
+				link->link_enc->transmitter,
+				link->link_enc->hpd_source);
 	}
 
 	/* DCCG muxing and DTBCLK DTO */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 60a9eb6e521f..eaeef72773f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1724,6 +1724,94 @@ static void update_hpo_dp_stream_engine_usage(
 			res_ctx->is_hpo_dp_stream_enc_acquired[i] = acquired;
 	}
 }
+
+static inline int find_acquired_hpo_dp_link_enc_for_link(
+		const struct resource_context *res_ctx,
+		const struct dc_link *link)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_to_link_idx); i++)
+		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] > 0 &&
+				res_ctx->hpo_dp_link_enc_to_link_idx[i] == link->link_index)
+			return i;
+
+	return -1;
+}
+
+static inline int find_free_hpo_dp_link_enc(const struct resource_context *res_ctx,
+		const struct resource_pool *pool)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts); i++)
+		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] == 0)
+			break;
+
+	return (i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts) &&
+			i < pool->hpo_dp_link_enc_count) ? i : -1;
+}
+
+static inline void acquire_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		unsigned int link_index,
+		int enc_index)
+{
+	res_ctx->hpo_dp_link_enc_to_link_idx[enc_index] = link_index;
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] = 1;
+}
+
+static inline void retain_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
+}
+
+static inline void release_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
+}
+
+static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		retain_hpo_dp_link_enc(res_ctx, enc_index);
+	} else {
+		enc_index = find_free_hpo_dp_link_enc(res_ctx, pool);
+		if (enc_index >= 0)
+			acquire_hpo_dp_link_enc(res_ctx, stream->link->link_index, enc_index);
+	}
+
+	if (enc_index >= 0)
+		pipe_ctx->link_res.hpo_dp_link_enc = pool->hpo_dp_link_enc[enc_index];
+
+	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
+}
+
+static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		release_hpo_dp_link_enc(res_ctx, enc_index);
+		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
+	}
+}
 #endif
 
 /* TODO: release audio object */
@@ -1886,6 +1974,7 @@ enum dc_status dc_remove_stream_from_ctx(
 			&new_ctx->res_ctx, dc->res_pool,
 			del_pipe->stream_res.hpo_dp_stream_enc,
 			false);
+		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
 	}
 #endif
 
@@ -2161,7 +2250,8 @@ enum dc_status resource_map_pool_resources(
 					&context->res_ctx, pool,
 					pipe_ctx->stream_res.hpo_dp_stream_enc,
 					true);
-			pipe_ctx->link_res.hpo_dp_link_enc = stream->link->hpo_dp_link_enc;
+			if (!add_hpo_dp_link_enc_to_ctx(&context->res_ctx, pool, pipe_ctx, stream))
+				return DC_NO_LINK_ENC_RESOURCE;
 		}
 	}
 #endif
@@ -2837,6 +2927,8 @@ bool pipe_need_reprogram(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (pipe_ctx_old->stream_res.hpo_dp_stream_enc != pipe_ctx->stream_res.hpo_dp_stream_enc)
 		return true;
+	if (pipe_ctx_old->link_res.hpo_dp_link_enc != pipe_ctx->link_res.hpo_dp_link_enc)
+		return true;
 #endif
 
 	/* DIG link encoder resource assignment for stream changed. */
@@ -3105,22 +3197,23 @@ void get_audio_check(struct audio_info *aud_modes,
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
-		const struct resource_pool *pool)
+struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
+		const struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct dc_link *link)
 {
-	uint8_t i;
-	struct hpo_dp_link_encoder *enc = NULL;
+	struct hpo_dp_link_encoder *hpo_dp_link_enc = NULL;
+	int enc_index;
 
-	ASSERT(pool->hpo_dp_link_enc_count <= MAX_HPO_DP2_LINK_ENCODERS);
+	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, link);
 
-	for (i = 0; i < pool->hpo_dp_link_enc_count; i++) {
-		if (pool->hpo_dp_link_enc[i]->transmitter == TRANSMITTER_UNKNOWN) {
-			enc = pool->hpo_dp_link_enc[i];
-			break;
-		}
-	}
+	if (enc_index < 0)
+		enc_index = find_free_hpo_dp_link_enc(res_ctx, pool);
+
+	if (enc_index >= 0)
+		hpo_dp_link_enc = pool->hpo_dp_link_enc[enc_index];
 
-	return enc;
+	return hpo_dp_link_enc;
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 88d11724db5d..a6b8327936da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -162,9 +162,6 @@ struct dc_link {
 
 	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct hpo_dp_link_encoder *hpo_dp_link_enc;
-#endif
 	struct graphics_object_id link_id;
 	/* Endpoint type distinguishes display endpoints which do not have entries
 	 * in the BIOS connector table from those that do. Helps when tracking link
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 6c08e21bb708..80dfaa4d4d81 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -499,7 +499,8 @@ static enum bp_result link_transmitter_control(
 void dcn31_hpo_dp_link_enc_enable_dp_output(
 	struct hpo_dp_link_encoder *enc,
 	const struct dc_link_settings *link_settings,
-	enum transmitter transmitter)
+	enum transmitter transmitter,
+	enum hpd_source_id hpd_source)
 {
 	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
 	struct bp_transmitter_control cntl = { 0 };
@@ -508,6 +509,9 @@ void dcn31_hpo_dp_link_enc_enable_dp_output(
 	/* Set the transmitter */
 	enc3->base.transmitter = transmitter;
 
+	/* Set the hpd source */
+	enc3->base.hpd_source = hpd_source;
+
 	/* Enable the PHY */
 	cntl.action = TRANSMITTER_CONTROL_ENABLE;
 	cntl.engine_id = ENGINE_ID_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
index 0706ccaf6fec..e324e9b83136 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
@@ -184,7 +184,8 @@ void hpo_dp_link_encoder31_construct(struct dcn31_hpo_dp_link_encoder *enc31,
 void dcn31_hpo_dp_link_enc_enable_dp_output(
 	struct hpo_dp_link_encoder *enc,
 	const struct dc_link_settings *link_settings,
-	enum transmitter transmitter);
+	enum transmitter transmitter,
+	enum hpd_source_id hpd_source);
 
 void dcn31_hpo_dp_link_enc_disable_output(
 	struct hpo_dp_link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index d34b0b0eea65..444182a97e6e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -53,6 +53,8 @@ enum dc_status {
 	DC_NOT_SUPPORTED = 24,
 	DC_UNSUPPORTED_VALUE = 25,
 
+	DC_NO_LINK_ENC_RESOURCE = 26,
+
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 0bd28a332fcb..08f1222fdd26 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -422,6 +422,8 @@ struct resource_context {
 	struct link_enc_cfg_context link_enc_cfg_ctx;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
+	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
+	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index bb0e91756ddd..2ce15cd10d80 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -268,7 +268,8 @@ struct hpo_dp_link_encoder_funcs {
 
 	void (*enable_link_phy)(struct hpo_dp_link_encoder *enc,
 		const struct dc_link_settings *link_settings,
-		enum transmitter transmitter);
+		enum transmitter transmitter,
+		enum hpd_source_id hpd_source);
 
 	void (*disable_link_phy)(struct hpo_dp_link_encoder *link_enc,
 		enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c208925f8247..ee4a5df428e3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -206,8 +206,10 @@ int get_num_mpc_splits(struct pipe_ctx *pipe);
 int get_num_odm_splits(struct pipe_ctx *pipe);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
-		const struct resource_pool *pool);
+struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
+		const struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct dc_link *link);
 #endif
 
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
-- 
2.25.1

