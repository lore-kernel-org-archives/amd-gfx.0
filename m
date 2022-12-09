Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E74C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7380C10E561;
	Fri,  9 Dec 2022 16:37:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB9310E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDTCcEb7Fwp2VZOF2eReiMBZizr8gywSHTMk3dVpnwU9Iss4RpBn/FkeOKYbQ/ViaC7TfxMqFb0YJLONkktUpFuhSFkwA3k6pA7uUT1sfAn81kJwg6l9qS8ny0q0dfYe/VlSUSE0wiALTeS50Kj+SxM8zp46nbgEcW2vqGqWt/VlfFlGvycqiSjFFedcKYKEF8QWsrQisrCMeHXKglyytIWbOBKQ68s9EQmC9eo3xRuHQi4CBToQ10eCc49tDvTdTzzSNO8/sxVYfP/z5V5iHvTCysLLQ8oSdOMDPMwrv2BCkmjSqvZCtRLoqnfI1AiS1bmeDD++Vy8T2spWsAJIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VMcpfXWFig3Q1RK416X4bJuno/FnhMbVyrZW1D9hQ0=;
 b=ljLxjrJBMsc5JSB0H/IgCsVyflWPirfoFvd7vpYXZTFAA+1Qo8Fcabi3cQeiJZQH1tesGVsdYn9f5wfAdX/ufelBC3h9eNN7a3GWIi2RGI4aJRqR9YBJMM1nnWjGPm4g4MgkGGfflMF6XwEbUh4bsea9Rd+nrMTCVmhEIb2Xh0Yjya4hA4pmoiEYeIl+62H2Nq4RKVVCG1fNBMfePDE6VhPJKLfNZBkh3utwRR5YhZqih0yGRN/Hb+j//DhnrnFOnLG2Xq8SXdc12FA/aDm785ddqSziK5RrryDfD48l345kFPP2oBYHQKOEtMRbV7O6WO6DfwioIOARNpD/5kkADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VMcpfXWFig3Q1RK416X4bJuno/FnhMbVyrZW1D9hQ0=;
 b=v0xit7MPXI4r6RcO0rIS0GrtnM0aSvOLVB3fJWtAfL5qmnmYvNvVrXD3Xz2fk7l1qUUut4AdJSGYmi4qLaotMRYemoaqaxYZDbz9qQdcTS0i6che4292Uve3Rb5PzmbCqgMnD5uxSp0oDvRvLYdBkhk7a2MESTAnUxCWZgoSElU=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:19 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::58) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:19 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:16 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/23] drm/amd/display: Add debug bit to disable unbounded
 requesting
Date: Fri, 9 Dec 2022 11:36:26 -0500
Message-ID: <20221209163647.25704-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d8c3b7-a99b-4d51-1341-08dada03a3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqfHSuy8CuFMTnsrA33T5dUr3tDOyuQbiiOErVbjr9T2j6nKsGRVjr2oBM7PzzZ/b3kVi+RqiJSE/LZ7IAaecaGQRVgBTJgJfl+4CINoytcils47sMVkEj0xBFhS8sNqzoUDxQqHb3O+zgg+iFY3jNt82f8HxB8x8BhQ7j5xi4ACV6awPeuwv0aDTAdZCzkX5paK4ALLpgg3idkt6fzyO51cBDHpfkWwoA+iXj2fg8ItAJL4hi6LgEcwcI2qbxKtgHWA0/hvR2SQ6YyDQjvpDOdH+suLr74yD46/B47PFbQyjeE04DDAQDjcuHJowOFpCYf19vdcMt7TkVDvsP+SWKyowF12AYTqxqvBbryBqd13sYqb1WNu77YnH2aqnaKghNP1Jp9RhblX58LaaaxDCauySdAES7X5VDlfsgozedKgS5QzMaKt2Kteh0rgAf5YMA3kozHvMuCklPgh83lGTVcJMarArWNh0gsuXfGRmjNJrgjrGJrnajPVDZfk0UQphIhfQmoA0bj+Mh0ZsGqtFgudJQG9MBci4J6a1Lkfi5WKHt+meJl2bD+kAGo+8v1VTEuxt3bidXj9rDo14Hcu9hpt0i9Op29fWXQEkoDJDXxsX6EXP+bk6BywGfqPQp6viEkDX4mZxhDzNmG05AMprlaNr+Gzfwe1O5E3StGLV4w2u3C3sOqDRPjFh19meLGb2t99qprDNzTIkwLcCuI/bq5PY7uhBFESa/9Id/MHv4w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(1076003)(426003)(41300700001)(16526019)(2616005)(6666004)(47076005)(8936002)(26005)(4326008)(40460700003)(83380400001)(81166007)(356005)(36756003)(40480700001)(5660300002)(6916009)(186003)(54906003)(316002)(2906002)(70206006)(336012)(82310400005)(70586007)(36860700001)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:19.0857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d8c3b7-a99b-4d51-1341-08dada03a3af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Add debug bit to disable unbounded requesting.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c         | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c       | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 85ebeaa2de18..a76031d7e202 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -872,6 +872,7 @@ struct dc_debug_options {
 	enum lttpr_mode lttpr_mode_override;
 	unsigned int dsc_delay_factor_wa_x1000;
 	unsigned int min_prefetch_in_strobe_ns;
+	bool disable_unbounded_requesting;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e4dbc8353ea3..dfecdf3e25e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -726,6 +726,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.allow_sw_cursor_fallback = false, // Linux can't do SW cursor "fallback"
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
+	.disable_unbounded_requesting = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 783935c4e664..04fca788c50b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -357,6 +357,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
+	bool disable_unbounded_requesting = dc->debug.disable_z9_mpc || dc->debug.disable_unbounded_requesting;
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 
@@ -373,7 +374,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	 */
 	if (pipe_cnt == 1) {
 		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
-		if (pipe->plane_state && !dc->debug.disable_z9_mpc && pipe->plane_state->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
+		if (pipe->plane_state && !disable_unbounded_requesting && pipe->plane_state->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
 			if (!is_dual_plane(pipe->plane_state->format)) {
 				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
 				pipes[0].pipe.src.unbounded_req_mode = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index d1f36df03c2e..62e400e90b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -724,6 +724,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.allow_sw_cursor_fallback = false, // Linux can't do SW cursor "fallback"
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
+	.disable_unbounded_requesting = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.34.1

