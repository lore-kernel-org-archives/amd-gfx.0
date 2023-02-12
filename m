Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F5C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D1E10E2EF;
	Sun, 12 Feb 2023 17:00:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0817D88FAE
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCT90bV9LCreXBEU+m9rSFbL4R+vGGlNtLGr17NL6l9iGOAKHPBWYhEutQQVpKjjUjU5zcuMPxmCVhnx0zcZVGSDIsKHczwoR2cZJPme0IQu36mONCTEO4zeilp1sGlBskrKAz5+XglQypitSQqXXirWHjbj4gLo/UM45ftLNE0QOABUD4VB+LGzDK5u2qTBFndcOMh82hdqtlwHnrtR60V53IsAjUsiUbIWwg2/UYo8HP6qZZd9vKlkz9knIsQQZ0ORsY8p2uBy+a+wYYGbyVMJpudsP6ukUgqW3NyTSOT2+15yuIwsTlqABQbmrR3Gg2L8L7kRWOK/sgT/mIlqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrGpF3izru5rQk10D+isfW4CwvbDevK0bK3g32cGWOg=;
 b=dUt4ZoS0C+1kTLueffqQgOeo7knISX3gutLs3DnKV70LTH4atC73EAYX2eqUNLr4GJuXNjf7Jn3FEC8cPXU/7JxciQmPtEj02Hv5pwj51sUprd/yteaOdGqQMn7XS3tYKdi3VOK0Kx508Y0EprCL5cpJH8ala9LC2UCjVxj5wdZBp+QPY4Z/nY1O7gKdhPUY5GZxwYtO9QijAjhUEzwPv3mbijG07fMDFSEqKDitVEQhEoLrLpNNuefbpxj/K4Q24G7QdWOMbRd/fFjXMsOtiPuTpxmfRzXkkYJ2EUCZXGGtYlqcodqW6aTXrbY0UQneAQ0h29+uu90rqZD4WGqUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrGpF3izru5rQk10D+isfW4CwvbDevK0bK3g32cGWOg=;
 b=c+kbpmWC+VOsoAnwKJgb1LdRL/BCC/mk7Mze65e26oFvzKLnjFWUzuWzfrSRxbea2qt/kW0VoNFWt11MIUdKke67q7xlDH8qklRmn7bYlXYZJYZpiinao9W+VmK/UIdPvtVQu5vc/d/5REsLBmadqA+HrLIMSHiRSXs/0i4EUUE=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 17:00:39 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::54) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:38 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: enable DPG when disabling plane for
 phantom pipe
Date: Sun, 12 Feb 2023 11:59:41 -0500
Message-ID: <20230212165955.1993601-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: e277b55f-ee5e-4cc6-fad4-08db0d1aab34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cVlS/AudmEhKKYOOO+8eie1oL6Doi2DbRUey7PR1wCUVtmP0wGSw3poVjxlVJAm0luo3wc/s0ZPqRAh60slSNrDFC+EpArgvrq5GrEy0zIc0HZCi6wWWvUijtdcld8h72fADsjhGAtYeUfN0Q/tjNwqWTupCPLs1qBhDhWuku6wk2SG9ICg4Hx1K9ufJ4RHcCnX4loHleOxEQwNlFl+RtVjNAHTsBr92Mec9UrpdBsvjM4krH/OIvoZ27lwPKPawf9eIU9nI1IQYFh40briwKD2LOfN1fDgX1Wzsp9U0j0Pv31CEM9NvmpNIAZsR37+DO1QwjBPAGw9w0FT/bRBPys3qKmAU1Wc/Kl1PMZowc1OzLBYwbv0r0zxnTeAtYNuahwbZfp2j0DoJSKpH1FhpNyndC2XW2oXIG1ildpWT3/bgklP0txwhzuC4meicPi9ReHK2VlJ03JleFK5Qigb5kgyuwfTm/b503VFYDr2O0uIBwX7o+VJsiXXM4ilXhp5ZhAVj8aWEpW3UncSLcV9oUtH/EkYaEVmSoef3VAunlmqaCCZkG7M/r69hlGaeslU0nozcrtGOsXBErqjTboiOUqPF/gAgKZsho8cazDGchED90GEVezsnG2lXMaCvbjKoqtci09+ye4nzCyR/Njvea3vfAo/Zxl0xBb4AmbJhUPlbelxCfIpjz2q6F32ATDdbbl3e1Y7X7dUyaJhZ+g4O2QCjISCDkIp4l4S8abdtck=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(82740400003)(41300700001)(40480700001)(36756003)(86362001)(356005)(82310400005)(6666004)(8676002)(4326008)(70206006)(6916009)(70586007)(16526019)(8936002)(5660300002)(186003)(1076003)(54906003)(26005)(478600001)(316002)(36860700001)(2906002)(2616005)(44832011)(336012)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:39.4962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e277b55f-ee5e-4cc6-fad4-08db0d1aab34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
In disable_dangling_plane, for phantom pipes, we enable OTG so
disable programming gets the double buffer update.  But this
causes an underflow to occur.

[How]
Enable DPG prior to enabling OTG.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1c218c526650..510661d303e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -74,6 +74,8 @@
 
 #include "dc_trace.h"
 
+#include "hw_sequencer_private.h"
+
 #include "dce/dmub_outbox.h"
 
 #define CTX \
@@ -1057,6 +1059,44 @@ static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *contex
 	}
 }
 
+static void phantom_pipe_blank(
+		struct dc *dc,
+		struct timing_generator *tg,
+		int width,
+		int height)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	enum dc_color_space color_space;
+	struct tg_color black_color = {0};
+	struct output_pixel_processor *opp = NULL;
+	uint32_t num_opps, opp_id_src0, opp_id_src1;
+	uint32_t otg_active_width, otg_active_height;
+
+	/* program opp dpg blank color */
+	color_space = COLOR_SPACE_SRGB;
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	otg_active_width = width;
+	otg_active_height = height;
+
+	/* get the OPTC source */
+	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
+	opp = dc->res_pool->opps[opp_id_src0];
+
+	opp->funcs->opp_set_disp_pattern_generator(
+			opp,
+			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+			CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+			COLOR_DEPTH_UNDEFINED,
+			&black_color,
+			otg_active_width,
+			otg_active_height,
+			0);
+
+	hws->funcs.wait_for_blank_complete(opp);
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -1115,8 +1155,13 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				if (tg->funcs->enable_crtc)
+				if (tg->funcs->enable_crtc) {
+					int main_pipe_width, main_pipe_height;
+					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
+					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
+					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
 					tg->funcs->enable_crtc(tg);
+				}
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.25.1

