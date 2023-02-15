Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C49C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 07:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0164D10E168;
	Wed, 15 Feb 2023 07:39:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7712810E168
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 07:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5uDd3Tr4NxtkkJRIS6S6s55/oZWB226e3/0Qk6NgkhKplSjbRjbzZoddmeUIdIp5bboCGaA50/UUH2umpC8CE4L/ik+4LQqORlF7d9FiflsRtEG5476bom5W5QiyMCBc+wyWNsN4loOOWVmO+t89HTisQE2lHQSaSh/vWwb1sCr02WCJVSpIaqMOOLUFDCAmn5EJUVvyrg/hHy9s6t5kYD+X8lsnBchrwqwOWjUyuWuNWqsY7Sz21uDmidldW+KHm4AzDVYBUM3I9c1aTgDkQZadj4Kt3b1nj4OFhmYQdyKcBMb1csME+izNpvKEgQKEuzvthmHaENgdvsoPExvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wObfQgEPaNVCci2Pci+ces0NDbZcEGsAKoYyH+EVTVA=;
 b=D2PCjPPz1tG/9R1VleqIACQ8dJ3ZuPWM5n7Q7DOmHS1ljme9P84Ye3boHlI63fkWXVDPperYnvfMg6TDbqK7IZnWjTaoi0OFFwSV6KSnZS9zUnKB5bYgPxjLerbegNDIXrLciIA/6D7Uvux6YUfx2HYtVwqTOYHmA2AKav5Xj+6SWKquZ8E1DA3m8B9TXxTQmdgjrcKfvI7AxG508w2Wd2guzx+NsHJEEz/HaGId431qdpHOiv+BPb46xK1G2MMQNuiuVcY9e3Cvsz1xmI34MC9c+pUp+GUKAYexlRFu4lt5yY7RbpMe89fFI5U13qYf+4XWoSSz9uqViq5dRXjhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wObfQgEPaNVCci2Pci+ces0NDbZcEGsAKoYyH+EVTVA=;
 b=et6Qm4PZICuW7BG/qHT3wJyiUSGEp8/bOIkL8xCUz0cEc9D7E4hJyXBd0YCjmXyKn0+KQZJcWvvwKu9uNO9bhgbcclxBc2Lp+llcNdjXX6CXgd/GcbhfskIYWmgYX+Z2OBo2Y1dWtMOSrEksEBf9ilpt3Z195rhlxRxNrhWM/pY=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Wed, 15 Feb
 2023 07:39:22 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ff) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.27 via Frontend
 Transport; Wed, 15 Feb 2023 07:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 07:39:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 01:39:17 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: enable DPG when disabling plane for
 phantom pipe"
Date: Wed, 15 Feb 2023 02:37:30 -0500
Message-ID: <20230215073730.7630-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eb33d0-d96f-43a7-eb25-08db0f27c126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OrVCvQ57KB31aZH5WWSX+otRbRkx8OvMtk9qFlB4TyOYCOXvEdWmip5iNmtkhTEhPBvuSRc8i/3SAZihIt0VBZnPfstwZ1hLrnzcDetyemF+CmxtXsopb7WMBQKIQ6gdv2+CECdnorKgwr6gb7o78/FjAAXJAF+1ArkXoN2z/dyemB7yblWkamiaR9MtukcUfLs1b8CVWWWlYOyAza9EEANqOKI2k7DNwOpVARonjuTatQe96yG9NZNo5PLF7kRf8/k+3Vmmzi38shzIoMgJaVXM1DjZQ7kswzeGVUVIIStcyt+Jty1sZuehtaCKcs7iJpHv0mPFZoSJexyxJu4/r4KScVuCr0z7yo7ob9ErnQQldMCnFJjPCUrW9OxgMc7bqVrvt7S5Kx78Fnskd+PLOUyFtcKVuEK9lUOp0SiZL31+p8XD/uzsf5Z1hiytQanoF5HSQ1BXLQ8MwJaMQJAVLPjrRDaOGdcctkGUQnkTAxV+jI8tmPdujMPvqRz3VDLoDgWx+IMV+4q9NRq1NGwy6VYvVOV6qwmHNbOBJmCD3c9yFR7BIc3qfij2pE4MfEd6Cc7VyCYQVXL2ognXJsxGCQTbtOK3d2ikHVqYiY803C1ecvxo0i9PbGghlB3Vl244NBfsbC5gU5kOOZMkEhyEqgZyJ6SrhoofEXc1XstqS9Z8LVejaVHnF0fiH9ci8cgAwdeVoZno1aMwvQ4BINQNi4pBnZglSlWQXrMk1ln+t1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(82740400003)(2906002)(81166007)(36860700001)(40480700001)(44832011)(40460700003)(16526019)(478600001)(26005)(426003)(47076005)(186003)(36756003)(82310400005)(356005)(1076003)(86362001)(336012)(54906003)(316002)(41300700001)(6666004)(6916009)(2616005)(70586007)(83380400001)(4326008)(8676002)(70206006)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:39:22.0970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb33d0-d96f-43a7-eb25-08db0f27c126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

This reverts commit b73cf50bd1d0008027cc1b41881b671d9c9054b9.

regression detected by the change. Revert until
fix is available.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +-----------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 510661d303e8..1c218c526650 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -74,8 +74,6 @@
 
 #include "dc_trace.h"
 
-#include "hw_sequencer_private.h"
-
 #include "dce/dmub_outbox.h"
 
 #define CTX \
@@ -1059,44 +1057,6 @@ static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *contex
 	}
 }
 
-static void phantom_pipe_blank(
-		struct dc *dc,
-		struct timing_generator *tg,
-		int width,
-		int height)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
-	struct output_pixel_processor *opp = NULL;
-	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
-
-	/* program opp dpg blank color */
-	color_space = COLOR_SPACE_SRGB;
-	color_space_to_black_color(dc, color_space, &black_color);
-
-	otg_active_width = width;
-	otg_active_height = height;
-
-	/* get the OPTC source */
-	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
-	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
-	opp = dc->res_pool->opps[opp_id_src0];
-
-	opp->funcs->opp_set_disp_pattern_generator(
-			opp,
-			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
-			CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-			COLOR_DEPTH_UNDEFINED,
-			&black_color,
-			otg_active_width,
-			otg_active_height,
-			0);
-
-	hws->funcs.wait_for_blank_complete(opp);
-}
-
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -1155,13 +1115,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				if (tg->funcs->enable_crtc) {
-					int main_pipe_width, main_pipe_height;
-					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
-					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
-					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
+				if (tg->funcs->enable_crtc)
 					tg->funcs->enable_crtc(tg);
-				}
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.34.1

