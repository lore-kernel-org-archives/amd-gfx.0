Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B3FC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3723D600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3723D600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077ED89D4F;
	Sun, 24 Oct 2021 13:32:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67D06E0FE
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDFWh+4V+Y1+NFJtgCn7iqKbSSPbazvrM3MxnZZZD1Ns2luFa7X+6+2o4L13i2ZR7KGrk7vF3nKGVVL5s9HgGlq6UCikx0HQkIB6defHUd+BtQjDc2TyPKofQ7TMb9xiInPEYC/O1PHXQnQscFzA4vUokyUk83f2CtX0yGjZjZZukCgC62ndx6DeJpT4bzI5St/fhKRokLbWpE+RpTv2tvUXJM567IywkPMXjFlCTGMMaMxAk43LWpvMz7He2fK4D1LWLu+udJ+EmqbAsUjFHbkM5/rZyghGPqBt7wAeAjr146hAG+z6Mfzhfn1YLxILazXMsIQa0a40m/raeUc6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rYbaUK/ly2i0pqd6YTx4kCpx9uwDO3cWGGCJ/2rCIY=;
 b=UK1K1lCRW+RlkXF38sRy84HpDZulPRBta+gu93UuBzWbc8wqKiEYFAY7qNEq/rgAAXamzR7ROZMzvdwhMPgQDFRSDfnlk1v058RQ4MVhg519/PwE1HkL7NgC/EJXVFVoxCKublR0IgU31VBgibJZKdJzVXwZj28aj634/I4Bg+l6+Wv/WwAM2V/rM7S2Yr1HQMhwjnByxTwqF5VamryPV3FGzp8kX2oj5VzL59Xv1sxa9fosRyIp3xya09//uCa2LjyAv9s2/kHt5fTCcrzxB/CznWE2Yn3n3M7+9LSA8FJgeRIJ+vL1C95o5XHr5rtZm9K7ok+iZiBU4Nw/AENe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rYbaUK/ly2i0pqd6YTx4kCpx9uwDO3cWGGCJ/2rCIY=;
 b=DgbRk+0lUkDMknMmspnNrl22fszFvPzAgu1/ZJcAxq49lXEDv79/CAh4aMrH/UA6PI7rTaX8JjZZzt2HxYlUG8lZPSMjDMrVPxTMCkAb9V/NPPVUJdDyEk9satqA5RqViuzRSByHDhJi/YR2yYYYd6S98WwVHaNCdqr05Wb47oE=
Received: from MWHPR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:301:4b::19) by DM5PR12MB1500.namprd12.prod.outlook.com
 (2603:10b6:4:11::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Sun, 24 Oct
 2021 13:32:17 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::c2) by MWHPR1401CA0009.outlook.office365.com
 (2603:10b6:301:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:16 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Ahmad Othman <ahmad.Othman@amd.com>, Wenjing Liu
 <Wenjing.Liu@amd.com>, Ahmad Othman <Ahmad.Othman@amd.com>
Subject: [PATCH 05/33] drm/amd/display: Add support for USB4 on C20 PHY for
 DCN3.1
Date: Sun, 24 Oct 2021 09:31:13 -0400
Message-ID: <20211024133141.239861-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f617a72-9fd4-4537-8996-08d996f2b265
X-MS-TrafficTypeDiagnostic: DM5PR12MB1500:
X-Microsoft-Antispam-PRVS: <DM5PR12MB150046534CDD5AE43AAF509D98829@DM5PR12MB1500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncDeAOoCPdijuycBmGVd6RcUcy8TnKhQqk9Qh7IkTDN0mIBYNaEqF4GPJ2It97/cR4xEWvSzHYsgf5IJ+u6RSpa+lnHY25+EqQEKbL94NBgslD4Jbi4XCtaq/otzkwBWcnOrH5jd/NI2Xcy58nfl5CvQ0ccGzPzdmQcL7Qs+d5DUDnJIH8ofXXacAUnF9QcOslXBifMNjS45bdiuG1uznw064tTFvKXRxFFzpzQWPqGKliJRqA+bNe4MGDUUbGlDthM8QsX2LQWvZBdPuYWvSU8BOHwMMZFn1FyKVu5al/O12Map8ehLEJcL2YrR+t06J5fl8CyGSj/KxvL3n0KfY47NTDf+AfqywATxk9Ps03QdfXYG+65FeaQZsQG0fo/cVzb7bZza5e/G7HY4BDL7CPnP/BljFxyUPsiaB+qiK7oxBli5MobfaREPRp72E5ylZlflt087j2pR1N67XvnrsQBiRiCQH3toLVet/vc0ZpCF6N2nGft9YpNh192saoJmTsALETBMyGjTsif2hmU8N1OxwKEoeLHdZO6uVjPBSMun68WzBMU6K2Cgvb5R7lrsnB2A+ojlpZMBFedm6MmpOGe+knxFE5gjJ61mGZRTczJ+uv+CFpxVZ7tBf3PKfIfi0z2ubB4Bv598tp9r3sRe8XHrQcaO9bQ3MQB6GoiqWEDGGEbUR3VL4xZ8zEivYU9iCFdM9XxUmmdcaUSnVLqSuO4PzDgVKu/uxAomj9aWjEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(82310400003)(86362001)(4326008)(426003)(336012)(70586007)(54906003)(6916009)(36756003)(2906002)(47076005)(70206006)(2616005)(8936002)(26005)(8676002)(508600001)(1076003)(16526019)(186003)(83380400001)(81166007)(356005)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:16.7317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f617a72-9fd4-4537-8996-08d996f2b265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
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

From: Ahmad Othman <ahmad.Othman@amd.com>

[Why]
Created new fields that matches new B0 structs On DCN31 the mapping of
DIO output to PHY differs from A0 to B0 boards with new PHY C20 & this
new mapping needed to be handled.

[How]
Mapped new structure based on new structs Added logic for mapping over
A0 and B0 boards Hooked all new structs together.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Ahmad Othman <Ahmad.Othman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 53 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 +++--
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |  2 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  2 +
 4 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index dfec35caf426..42f96de496cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3582,6 +3582,9 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct link_encoder *link_enc = NULL;
+	struct dc_state *state = pipe_ctx->stream->ctx->dc->current_state;
+	struct link_enc_assignment link_enc_assign;
+	int i;
 #endif
 
 	if (cp_psp && cp_psp->funcs.update_stream_config) {
@@ -3595,9 +3598,57 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
-		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY) {
+		
+		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY ||
+				pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 			link_enc = pipe_ctx->stream->link->link_enc;
+			config.dio_output_type = pipe_ctx->stream->link->ep_type;
+			config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+			// Initialize PHY ID with ABCDE - 01234 mapping except when it is B0
 			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+
+			//look up the link_enc_assignment for the current pipe_ctx
+			for (i = 0; i < state->stream_count; i++) {
+				if (pipe_ctx->stream == state->streams[i]) {
+					link_enc_assign = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+				}
+			}
+
+			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0)
+				config.dig_be = link_enc_assign.eng_id;
+
+			// Add RegKey to guard B0 implementation
+			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 && link_enc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+				if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+					link_enc = pipe_ctx->stream->link->link_enc;
+
+					// enum ID 1-4 maps to DPIA PHY ID 0-3
+					config.phy_idx = link_enc_assign.ep_id.link_id.enum_id - ENUM_ID_1;
+				} else {  // for non DPIA mode over B0, ABCDE maps to 01564
+
+					switch (link_enc->transmitter) {
+					case TRANSMITTER_UNIPHY_A:
+						config.phy_idx = 0;
+						break;
+					case TRANSMITTER_UNIPHY_B:
+						config.phy_idx = 1;
+						break;
+					case TRANSMITTER_UNIPHY_C:
+						config.phy_idx = 5;
+						break;
+					case TRANSMITTER_UNIPHY_D:
+						config.phy_idx = 6;
+						break;
+					case TRANSMITTER_UNIPHY_E:
+						config.phy_idx = 4;
+						break;
+					default:
+						config.phy_idx = 0;
+						break;
+					}
+
+				}
+			}
 		} else if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
 			link_enc = link_enc_cfg_get_link_enc_used_by_stream(
 					pipe_ctx->stream->ctx->dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f0141f27880f..23977de4811b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -211,12 +211,12 @@ struct dc_dcc_setting {
 	unsigned int max_uncompressed_blk_size;
 	bool independent_64b_blks;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	//These bitfields to be used starting with DCN 3.0
+	//These bitfields to be used starting with DCN
 	struct {
-		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN 3.0 (the worst compression case)
-		uint32_t dcc_128_128_uncontrained : 1;  //available in ASICs before DCN 3.0
-		uint32_t dcc_256_128_128 : 1;		//available starting with DCN 3.0
-		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN 3.0 (the best compression case)
+		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN (the worst compression case)
+		uint32_t dcc_128_128_uncontrained : 1;  //available in ASICs before DCN
+		uint32_t dcc_256_128_128 : 1;		//available starting with DCN
+		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN (the best compression case)
 	} dcc_controls;
 #endif
 };
@@ -731,6 +731,9 @@ struct dc {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool idle_optimizations_allowed;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	bool enable_c20_dtm_b0;
+#endif
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 43f33e186088..511f9e1159c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -35,6 +35,8 @@ struct cp_psp_stream_config {
 	uint8_t link_enc_idx;
 	uint8_t stream_enc_idx;
 	uint8_t phy_idx;
+	uint8_t dio_output_idx;
+	uint8_t dio_output_type;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
 	uint8_t dp2_enabled;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index f37101f5a777..6d648c889866 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -249,6 +249,8 @@ struct mod_hdcp_link {
 	uint8_t ddc_line;
 	uint8_t link_enc_idx;
 	uint8_t phy_idx;
+	uint8_t dio_output_type;
+	uint8_t dio_output_id;
 	uint8_t hdcp_supported_informational;
 	union {
 		struct mod_hdcp_displayport dp;
-- 
2.25.1

