Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BCAC433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC3260724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEC3260724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141616E110;
	Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC376E115
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5DQkehH+ggiHcIMag4Xo8soEHNFUNSfPjbBpkDIbDuupX9YXEM4Kgnbxk8Bav9wtdtZcNyd/xrBEQJGU56C7lLWAFeJSZlXUJmz5ftgXIb/07ZpL4q3pcm38VJpZxonXeIfhGEaJ0qeHTdSDjR2290pElXm1lGsgTxHLmQZd1aJH7AKdxEP6bORk6YbAqcJxuZSx/Gux7CkV6NOj3hZ3ImC19lL4INYkkfJWhflekFj4nj3laoQYttGJFvOPvndQbp7eUR1toNwa83j3UO1WcV2PmaKsQcMlkpfHUG8ByFZ/WLauRoiwdsvtTRU5wfROg3OHlGPkFRdP4PZ+oiNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67s3JduHgVAjpXHf4ZIqIxQKXY09R17rPUaxsC2xYkg=;
 b=NjDl8ht9rOAlktyGixkYJOKoq/qgUkJIn5fzlo92TU6U51e/rQrpRQcV7TA9m6PL2s/0xfWgdte1hm7p57/fBc1wQfrVFqzfvshn4rL47J1lEd7LQ93K/TDrkNlo9Dk5jYEDcjZfrCS5lV/JSSOARsiqnR90hbSj/LczbMDGzzZL4A9xWS7RbDomIH8LvkMNNv2jHH0TSZmGt+aiytzHh0RZJEoHjSvhnHOup5xt47aW7WZPmUYNOuQeLOex1UKiaekT9aOTVZBCWLt/I34cebxz1paCviuRU5xayXmXREHXo1GDWhjoppxdWCQZ282Y3SAXHFNHJsl9ua2mqcUP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67s3JduHgVAjpXHf4ZIqIxQKXY09R17rPUaxsC2xYkg=;
 b=Lf+kXQDbhn81F3CoJBzLIXymggEX5kpXL7oVKvOTGiPhUDGBsS5RqB5Lnf0vI8PLebukA0Gl5BPRHCY1UfhplzQGtcRFDJ2xbe7+8mb0+f7Y1F8N/i7VAdaKrpgDSiY7HkX3+zPFDx8kya5o79Uk5p0p0gOab0hW4jpx84En3w4=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f1) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:32 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>
Subject: [PATCH 19/33] drm/amd/display: allow windowed mpo + odm
Date: Sun, 24 Oct 2021 09:31:27 -0400
Message-ID: <20211024133141.239861-20-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84c6982e-4057-40af-7fce-08d996f2bbc0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33507913F1430AE77C3FB02498829@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVgfwglaWXAgCcaRagjiGKz3hlBsHaAXThjte4Bfm3rBf0IX3ig5CImQD5RBoD+g+X4R9n0M09i5birZghzvcMlQLNwRYd4a4c+UUqVV3MV1PYaIO/FI8xrI776mPk/Gj4cakVUdJrQTzXzjCiReoTVQhtt3MjJgYh2cwQ37BRUbHIRrOcbR0FKLJq60QDCugIs7seCuuBSV3o66ZoH/6ALZMXQeYo9BW+FcPGzZ07J8c4kRDMQ8cdoaaxo9UR6SPDuRo56ywNdemUM2zy7e81HVbPwfmT7Nw5Ra65FRLeUyEUTRKZvrW6owJe8AETrCHpxg1SiFd9JxDu3yMyuBo7ZNPf7bNvX6l4jDPGlYPTECf5tCBwSLmMOvmvO6ewUUU7J+axf1B4efLXU0w9qzxQCvVT7qSLvtRDRER5CwBRXKbi+qn2eFD07KBsnOQ4IQj0sGrj2PyQgzm4Y9Hp8FJiUpTohI387E98ndrNwTzSwaHmMZPPnxl0lyd9CTRHL0mq0KptAtnlmC+RUFI9u6vgHbNV4jjMfrqxwOCnXXzAdlxWI5uX1WNOE9zrUyYGFwNcxSjb6ouoY08oQa/Z6cUrRLzJYC8CfDw0hB0jLWGWaRR6NwoUrcJeVCRoWclLrc1UbKrCsBj7BoHpTN74TCIRxqIZ3P/DHgUJDepigXaZavBtNZyeSnRCddjgdnkK5bXanaJYYmcHcs2tNR78hgDWhdKc9m5KL+nlQlBbWE1YU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(81166007)(83380400001)(5660300002)(47076005)(2616005)(336012)(86362001)(356005)(1076003)(6916009)(54906003)(70206006)(508600001)(4326008)(36860700001)(316002)(16526019)(186003)(426003)(26005)(70586007)(36756003)(82310400003)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:32.4303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c6982e-4057-40af-7fce-08d996f2bbc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This change adds a config flag to allow non fullscreen MPO during ODM.
Scaling calculation will still fail configurations where video is only
one one side of the screen.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 30 ++++++++++---------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9e83fd54e2ca..c32fdccd4d92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1155,9 +1155,17 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.recout.x += pipe_ctx->plane_res.scl_data.recout.width;
 	}
 
-	if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE ||
-			pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
-		res = false;
+	if (!pipe_ctx->stream->ctx->dc->config.enable_windowed_mpo_odm) {
+		if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE ||
+				pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
+			res = false;
+	} else {
+		/* Clamp minimum viewport size */
+		if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE)
+			pipe_ctx->plane_res.scl_data.viewport.height = MIN_VIEWPORT_SIZE;
+		if (pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
+			pipe_ctx->plane_res.scl_data.viewport.width = MIN_VIEWPORT_SIZE;
+	}
 
 	DC_LOG_SCALER("%s pipe %d:\nViewport: height:%d width:%d x:%d y:%d  Recout: height:%d width:%d x:%d y:%d  HACTIVE:%d VACTIVE:%d\n"
 			"src_rect: height:%d width:%d x:%d y:%d  dst_rect: height:%d width:%d x:%d y:%d  clip_rect: height:%d width:%d x:%d y:%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1225406d3381..4cd26ca26fe0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -323,6 +323,7 @@ struct dc_config {
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
+	bool enable_windowed_mpo_odm;
 	bool allow_edp_hotplug_detection;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool clamp_min_dcfclk;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3a8a3214f770..6d70ccb108af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1929,23 +1929,25 @@ noinline bool dcn30_internal_validate_bw(
 	if (vlevel == context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
+	if (!dc->config.enable_windowed_mpo_odm) {
+		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
 
-		if (!pipe->stream)
-			continue;
+			if (!pipe->stream)
+				continue;
 
-		/* We only support full screen mpo with ODM */
-		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
-				&& pipe->plane_state && mpo_pipe
-				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
-						&pipe->plane_res.scl_data.recout,
-						sizeof(struct rect)) != 0) {
-			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
-			goto validate_fail;
+			/* We only support full screen mpo with ODM */
+			if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
+					&& pipe->plane_state && mpo_pipe
+					&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
+							&pipe->plane_res.scl_data.recout,
+							sizeof(struct rect)) != 0) {
+				ASSERT(mpo_pipe->plane_state != pipe->plane_state);
+				goto validate_fail;
+			}
+			pipe_idx++;
 		}
-		pipe_idx++;
 	}
 
 	/* merge pipes if necessary */
-- 
2.25.1

