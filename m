Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA62C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655E710E801;
	Fri,  3 Feb 2023 15:25:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846E110E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/wWjMfKmDC/mme5mD5nhLXte/qFzFRBPGdDWRA3tbpao9jQFtBMwLeIRnUwEQfThIEs2NHPdGJxIYkcJF8Ji2Gd5eLB0BjBrPQK47EO0a9MocbFCFPsEgnZrZTqVMgXcwM8LfouoTMBYwuKbqaCgnsFQyidHPAbgLV2HcEJZw48CXWcjYHu4RWOgcbC91tHRXPKhwR1+8BApIlWulDejc8oZdjFoZMycnAmo4KtwiNsFcHBWIcNGPkB5Pzqh9jymG6xRpaYwg9UnotBMxUuaSm5L451+6V1qAePrviCja04NDQDsBjpr6taYyxF900K6W5Q/LdvescQJb8oG5OmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94aIXkXrJqJkodo2DaJGDTwqVpw094eadcZ8MDiVPt0=;
 b=KMKPn/pICY/yJmfQZTUNQGRQG/H254Ia3vWi+Ri4xklENTp3mBocCe2ZkI1TdPdM8Z8od9HHsHxmKmEZ7sxfWAvi0y6m2eyXNI2blQOIUoRF9Ffb9KnDM5QE8K8aOZzqCmA0wJV7JD2ee1bcbC+yOv5Ig8ZKURhIeYSUsvZYjE3Rf7l60dGThY9hukIwXZwOqr2F4yTLqRksBb9pOQvUtPcW7lGcsiRqcBwBnL/hYJ6pwXQgZFBHna62OO3ZkdPjHR7g4QwNA43lQrLVTjGr3ji8uyHkxwPs7ir27cshkUdAjgYlm8iYLQIOvyG0S6Q5YWK1e8ch5ye7xGT6zuueJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94aIXkXrJqJkodo2DaJGDTwqVpw094eadcZ8MDiVPt0=;
 b=Oduh1mk2ro4FR9CBc2R4WyevXkalefo+f9+syHPVBoCicuyA2MTRserpG+rKeLhlHUCUP3G9qnPLaW3DKyw0OaS/JjTDPwMGVWsz7YoUUwRZ6eRH7D8rt+8Nyr7/onB1VogoDYRo/kbfYHV60lAak2PTTzP0ExU/y+nxA2Qh+lw=
Received: from MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 15:25:39 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::e4) by MN2PR03CA0025.outlook.office365.com
 (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:35 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: avoid disable otg when dig was disabled
Date: Fri, 3 Feb 2023 10:24:51 -0500
Message-ID: <20230203152452.1441747-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f99be5-88dd-4c6d-1ed2-08db05fae7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0QzIq26W5oGAkJ4BgnAYlsmRQ8AbZ1co9sZNVBPUYqi6FhxVXzc050MxJO1VCaTC5daSXGXORaEmN9iFQ0OO/XFpRzZSg09zF78XCBSSyzY3cRrSpO+y/mRszJSExwAf3Bj2mptrUfZuLVn5unnBZqn2xQNAv/wnv9gjqZ7c2h/qF/taIYjLX9n0oGJCgvW3Qp350GJD1BKN5RXf5/dBa5hqkKgmX3vuQPfxG922JrKm60OZtb0aTWjSuOmMtNrmsJVM1cLleGt1KtF9mejblHP7jSqDcExLqPbNSJ+4In6oVfqX4YQIv3wPjUUgtH1ZphcU14roCTmahJehfC5uIJFC91OFvWM4q7mOPv3TvuMDqa6c+OiGgPh3MpbPs94LaVnHm0IU4RNgx903vcP4jG+3gE2iat3F4QLq8a7GYhLEyR/ulkh7RL3FiCbwafCq7QFe/T2UqMKzWZFJhwt0LK/VtpvYEixnOAsD228XYzrBJwi8uvOUKuycov8UYvfFhH3PMq1DxVuNkT+qOqiKfeH2Zof48GQeszH7CU9rN+jaCO3QphyypoU+zvMKqn8hRf3Eoh3zlvW1/2O6kRl2WhLbS15Z9naa602nOLjjU4+4oQuVvfnA+eB38X5T/pZfu7tCRllm+jJM1VGFkU2yQ5hHYx4DG36aG7YgXe4kHWPwf8sGctrSmK1Cp1v8SYAsLAWHrAn9csv/ieYNe1at7ZFyvqld6XU2Y3XdKZMdmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(2616005)(54906003)(5660300002)(4326008)(316002)(2906002)(41300700001)(8676002)(70206006)(70586007)(6916009)(26005)(6666004)(478600001)(1076003)(16526019)(186003)(83380400001)(336012)(426003)(82310400005)(356005)(81166007)(47076005)(44832011)(36756003)(40480700001)(86362001)(82740400003)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:39.0457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f99be5-88dd-4c6d-1ed2-08db05fae7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>,
 Jingwen Zhu <Jingwen.Zhu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why]
This is a workaround for an dcn3.15 hang
that happens if otg dispclk is ramped while
otg is on and stream enc is off. But this
w/a should not trigger when we have a dig active.

[How]
Avoid disable otg when dig was disabled.

[Note]
Reapplying commit 82dca8576d14f3dcb775b3be5f1bbb5df9a682ac
which was incorrectly reverted.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 43d1f38b94ce..8c368bcc8e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -87,6 +87,16 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
+bool should_disable_otg(struct pipe_ctx *pipe)
+{
+	bool ret = true;
+
+	if (pipe->stream->link->link_enc && pipe->stream->link->link_enc->funcs->is_dig_enabled &&
+			pipe->stream->link->link_enc->funcs->is_dig_enabled(pipe->stream->link->link_enc))
+		ret = false;
+	return ret;
+}
+
 static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
@@ -98,12 +108,16 @@ static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
-			if (disable) {
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-				reset_sync_context_for_pipe(dc, context, i);
-			} else
-				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+					dc_is_virtual_signal(pipe->stream->signal))) {
+
+			/* This w/a should not trigger when we have a dig active */
+			if (should_disable_otg(pipe)) {
+				if (disable) {
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+					reset_sync_context_for_pipe(dc, context, i);
+				} else
+					pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+			}
 		}
 	}
 }
-- 
2.25.1

