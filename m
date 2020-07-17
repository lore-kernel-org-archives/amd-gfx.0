Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E5C433E5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C747F20737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xE7lm90d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C747F20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7C96EE1E;
	Fri, 17 Jul 2020 17:38:28 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6F06EE1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je0l0sUfWAbC+Mocq3+mDRFHSwveHgJKdMm8VT5dK2ymr1y+ka7RsurckoPK81kZy51L80r3T7gF55HOklCqq0qU3sLYuMno6kW2uzI4wPTy3eetaykwyAJNvu/PsshQya98D1T18N2QhUkbS5bRTGVKMVEl0r7Bfgho3nWh+qG3SirJtWACdlpvTl3Oae3Rj88fLMUg+8ZF2LUpyPbd8DdJffhQ+s5H5I653fswNTLjSLMhX+w9cxEFzbTCqFzjfTsc1+lYm2wWubSR6WIsALy8/PncCNcy96ChbksSncdCxG6aFvRtAhY4VszwIlNvXq/D5Tg1oENIce47QY8ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKHrDZpfVjEBNamVmKuJJPBwdJADHl3Tyyz73oTSgTQ=;
 b=edONvfSFTxopOtKGiKKWO60cvTjb4Zpah117BECnVL+qvfUYkeCUNP3hzWWgx32Weav8P9zsYsyXDYvJxqL35ruhjJmsfPABMt7C7B4SYxWN8tvqH1FLk2MSy/DnKh9Kzp5/iH2oS2+5bsOIm3guQUYBVd7cpve31EVcIgKyBtohD4z3HSxRZiD85fXqEZIFrm5wKZPz0kNC9+fFg0MH3zR2pUH/FkioKKDJHfyTOmfytfJzOp9ueWG6qHbqCVX5LFgTprD8m4R+ADVsHJ28MIWn53rbl2X4Le0ylgrSoe6J7d+zIy1Y6fi/8pt6NVqGwtFvovJOg+XpNPqyGKxNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKHrDZpfVjEBNamVmKuJJPBwdJADHl3Tyyz73oTSgTQ=;
 b=xE7lm90dHIp47h4kAJ/Xvich8UMQH7MTJaAsqJ3gPdxme09KFST0ittrgNWZy6jvK3GF/rUOVCfUerikcXcJBuBtIY0eh6PdIUgsX5enELXB1ZkTkXhyRVGUru40OSXjw8Y6A3LqJ35f7zXo1KncYa9S15qrbIOSc87SNa+2uzA=
Received: from CO2PR05CA0086.namprd05.prod.outlook.com (2603:10b6:104:1::12)
 by DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Fri, 17 Jul 2020 17:38:24 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::f6) by CO2PR05CA0086.outlook.office365.com
 (2603:10b6:104:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:23 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:22 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Make new dc interface for adding dsc
 resource
Date: Fri, 17 Jul 2020 13:38:07 -0400
Message-ID: <20200717173813.11674-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(336012)(6666004)(36756003)(426003)(478600001)(44832011)(316002)(81166007)(86362001)(2616005)(8936002)(83380400001)(8676002)(54906003)(356005)(6916009)(26005)(82310400002)(70586007)(5660300002)(47076004)(4326008)(186003)(2906002)(82740400003)(70206006)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a59f84d-9273-48b3-47c1-08d82a783481
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1692F05A6ECA7A113959B361FB7C0@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQAZUjlrFeiz46Mi8r61QQkTtKkQcMfZ8zlWyXdPCNbBB4reH3zJbnoWVGLTwiZBEQNSj7KDxpJlwRCpvp6Ot4gZgrmwLwOcem5YUCaM38fMcG3YebvJksn8A6UUpiGgOL6xz5HEzNYY6MWgcfObczG4/rIKkPbz15mXaalWUnzCKLfAaENnK0bIR0zLWwLKnLyl8ceXGYBq3F1aEsY/y4LqPU4/9/2bvjzPZZ0fmFDvVQsFi/8/Gcgjx6Li7+3a7GEEeYtzNtD3J+lxweFBJad60Svow95OyzaxlZZXrQTrAtGf/nm97niIz3LJMzH0uyhisbuzRqq98mXR1+Y7voJz/C5nGGDvOzBlM+hsznN+M9OEumIKLIxl+LoCyC9crDYmuX4thCi//srmBzDwwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:23.6675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59f84d-9273-48b3-47c1-08d82a783481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
dcn20_add_dsc_to_stream_resource is accessed in amdgpu_dm directly.
This creates build error for configuration with DCN disabled.

[How]
Make the function available through a resource pool function so
that dcn20 function need not be called directly.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c       | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h            |  4 ++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h       |  4 +++-
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 41c278519b67..10d69ada88e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -674,6 +674,17 @@ bool dc_stream_set_dynamic_metadata(struct dc *dc,
 	return true;
 }
 
+enum dc_status dc_stream_add_dsc_to_resource(struct dc *dc,
+		struct dc_state *state,
+		struct dc_stream_state *stream)
+{
+	if (dc->res_pool->funcs->add_dsc_to_stream_resource) {
+		return dc->res_pool->funcs->add_dsc_to_stream_resource(dc, state, stream);
+	} else {
+		return DC_NO_DSC_RESOURCE;
+	}
+}
+
 void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 {
 	DC_LOG_DC(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f599a72dab50..e4e85a159462 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -363,6 +363,10 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst);
 
+enum dc_status dc_stream_add_dsc_to_resource(struct dc *dc,
+		struct dc_state *state,
+		struct dc_stream_state *stream);
+
 bool dc_stream_warmup_writeback(struct dc *dc,
 		int num_dwb,
 		struct dc_writeback_info *wb_info);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e226647088b9..c8c6225c7e9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3364,6 +3364,7 @@ static struct resource_funcs dcn20_res_pool_funcs = {
 	.validate_bandwidth = dcn20_validate_bandwidth,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
+	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 61b337267a72..7d82648bec90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1759,6 +1759,7 @@ static struct resource_funcs dcn21_res_pool_funcs = {
 	.validate_bandwidth = dcn21_validate_bandwidth,
 	.populate_dml_pipes = dcn21_populate_dml_pipes_from_context,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
+	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 5f985fcbedf1..329395ee7461 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -165,7 +165,9 @@ struct resource_funcs {
 			struct dc_3dlut **lut,
 			struct dc_transfer_func **shaper);
 #endif
-
+	enum dc_status (*add_dsc_to_stream_resource)(
+			struct dc *dc, struct dc_state *state,
+			struct dc_stream_state *stream);
 };
 
 struct audio_support{
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
