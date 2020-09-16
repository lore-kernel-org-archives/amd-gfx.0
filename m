Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF7C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41E7208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xqgtyA/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41E7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2176EB1D;
	Wed, 16 Sep 2020 19:42:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993946EB18
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf/A19nSLyPwJDs45ZsXjdNp1hcR1J9mtHSxQe95upzIVal0cfkggfzQwd87jTklUT/DIbu3amcg487+Jw4DEW2GjP8QtTf4hcyPmUjKDah7b7O8P1r8sL1HovAij4SuBQWmifD8DaXRq8vqdvnluk+Y6wGFXFGEpKyX7gaW8XQW7kzlIRpCwoVzbyVlcFAxZZoXMceUnT4pl28dLpQAaT9jXKdAwJ3Zsx8ocCBMNp1+N9zAJ6plInAiuCnTw0Z40Jrw6360fbC9AzwNRr7B0vwPw5LYlplXDUo2wxdDPGDWBRjwQdbDya0RqqfM0B1/56faA2ElR1ZvWL2UVjFzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zckvZWSEDsyMQNKyWlxrNX83U0aknJRdUswJsbxxwM=;
 b=IUggjHokmX5h4aFlY+Lg+fNCYqRLZCOA3Bi+XloPvdXtkdYtQlxA8gFw0zRwVReUPqvbigB/aqTCxTb8UdUjJRRbANfb/yOx8fH9O/eDsXGI+8zhmk/sGbcgc5pFZoOX46bZyywMDYVW0XCCAI+84cmQ+dVun/hX+urAbd8bjPihHdRJO6q/iyT73G5uQSJa5igLguCamCqohSsGdOUYIQ8OmvjNvVOx1gWgtelICjitSfE3716N9ffTxr3i7hy4610vkIocYFTe1Zw5uGqiuHHRSU+nAkwwXP2IGWE7aK1Da6XS7L4RTba3aLnRZCSvlF/gojGm3BiksX5BjshSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zckvZWSEDsyMQNKyWlxrNX83U0aknJRdUswJsbxxwM=;
 b=xqgtyA/hcIPKDdwd1mib399+jVsOxiBN89PFfzgcYcHxlvrph+Qb9/MVcQBL+/B/1YutMir1OjpJBH0CT90p4Iy+qxvNJJcfHsZUOn3dQ+2I9l6OHT7e5dgP6M0vSm4EwxNekirXygIz/8gpTp4AR1Hk/dFmubEbovzVDJMeBhE=
Received: from BN6PR17CA0047.namprd17.prod.outlook.com (2603:10b6:405:75::36)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 19:36:44 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::da) by BN6PR17CA0047.outlook.office365.com
 (2603:10b6:405:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:43 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:43 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/15] drm/amd/display: Check for flip pending before locking
 pipes.
Date: Wed, 16 Sep 2020 15:36:32 -0400
Message-ID: <20200916193635.5169-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e55944-44fa-41b8-b4a9-08d85a77d819
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3981C0A83799874BC58B6FD4FB210@MN2PR12MB3981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxx/C8H6eaOiHHqmZPx9vtnON0i663ZQ8aiUzODaA3VIzXQty6XnmF2aK0f9IzE6orAjWd43oQqKsLjhWmCDDJ8X+touBQDTFSjw5jxvEeZcbk8XS5egrsqkZ2OnsRMZNUncogCpxKEBiLYNuq2eLyGCGrNoGW5qJs7aa0q7DohYDx2uygSMF80w+ho1Sp5dA2qZSxB5LeVbaibYtFI3VrOpbCdlgjqW5TD1wreQfE8Py5Jj31WYGjXWon7AuiYSkS4gOgXFK03zFI9G0ecai3dMx9h9tLDzgYiDl9cMsloxzlv0iX+Hb2GMQqwMVUWtSDY/BlH2g8CFnj+3XjNLkPpZaoCM1eEuqBE4A8vzdCU/ZMXsycy4PuONDXt528RtxTexldTEsnC3SyQwnxpzWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(6916009)(86362001)(2906002)(81166007)(5660300002)(4326008)(8676002)(47076004)(82740400003)(356005)(82310400003)(186003)(26005)(83380400001)(54906003)(336012)(1076003)(70586007)(6666004)(426003)(70206006)(36756003)(478600001)(44832011)(2616005)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:44.5656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e55944-44fa-41b8-b4a9-08d85a77d819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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
 Taimur Hassan <syed.hassan@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
When running a game/benchmark with v-sync disabled, disabling a plane
(which is v-sync) can cause an underflow. This is due to flips that are
pending before pipe locking being applied after locks are released and
pipes have been re-arranged or disconnected. This can potentially apply
a flip on the incorrect pipe.

[How]
Check that any pending flips are cleared before locking any pipes to
ensure flips are applied on the correct pipes.

Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c             | 11 ++---------
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 12 ++++++++++--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h    |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 83ce55edb3aa..1efc823c2a14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2324,7 +2324,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2355,14 +2354,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
-		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
-		dc->hwss.interdependent_update_lock(dc, context, true);
-		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
-		dc->hwss.interdependent_update_lock(dc, context, false);
-		if (mpcc_disconnected)
-			dc->hwss.wait_for_pending_cleared(dc, context);
-	}
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock && dc->hwss.wait_for_pending_cleared)
+		dc->hwss.disconnect_pipes(dc, context);
 
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d0f3bf953d02..79fe9571cf5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2761,7 +2761,7 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
-bool dcn10_disconnect_pipes(
+void dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -2772,6 +2772,10 @@ bool dcn10_disconnect_pipes(
 		bool mpcc_disconnected = false;
 		struct pipe_ctx *old_pipe;
 		struct pipe_ctx *new_pipe;
+
+		dc->hwss.wait_for_pending_cleared(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, true);
+
 		DC_LOGGER_INIT(dc->ctx->logger);
 
 		/* Set pipe update flags and lock pipes */
@@ -2874,7 +2878,11 @@ bool dcn10_disconnect_pipes(
 				}
 			}
 		}
-	return mpcc_disconnected;
+
+		dc->hwss.interdependent_update_lock(dc, context, false);
+
+		if (mpcc_disconnected)
+			dc->hwss.wait_for_pending_cleared(dc, context);
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index e5691e499023..9a0f7a8a85cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -194,7 +194,7 @@ void dcn10_get_surface_visual_confirm_color(
 void dcn10_get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-bool dcn10_disconnect_pipes(
+void dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 64c1be818b0e..f48ee24d42f9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,7 +67,7 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	bool (*disconnect_pipes)(struct dc *dc,
+	void (*disconnect_pipes)(struct dc *dc,
 			struct dc_state *context);
 	void (*wait_for_pending_cleared)(struct dc *dc,
 			struct dc_state *context);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
