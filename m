Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E5C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35AF10E469;
	Wed,  7 Sep 2022 18:12:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A9610E6B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQDslq8J5vehg/pWjbhd4sQGuHuQmVdt0ZhZStzPC1WC2BgoQ1/rTq5hMPflLGhhU/TJ6r+6dWu9/oA0Bx3TVZ9rkUCLDUXbE019cCH1GIPF2xjCTv+Y2WrNs3WPQcgtkfTOJVDlF6yqk+5TBFHbeQB2C7w6RCDvQzRlj2U8hxtKnZ1pvx/h35D8iQGuDK4FT0BbBFw01Z7Qajf+mVENtEhdRJXOub95cdPFtQ727JhAO1f4CCcL9ZQfDh5ndEbY3JzoQ1IM9OvoIj7UY1hbaCPtwDy652whK2Nn+jBdg3sJfkHMsMnHYjDp8hrJQRyS/dnyXp1EuYSB+JOFH3EZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkXF6vZdDSKBZAJL1m4U21+oDHDQ2VIQKF1M8CVedho=;
 b=BJF2apUrP3Mx+AMpO2FnyyjJeIuMNqBjxdxZTUd889ropJ4VbtNQi2xbfWzCQyKVM5dsSt9KA4HJ+Hq9dB4KGsWvQ5omYTduQXXT8VWan8gDGK47amw2o22hVk1MKnS+TyEXvqLss6TWp0VWJRw6nwZct9DiHc2BPdbMCXufeB70KYtSaYNN6PZo1xVcrou4m+6AKpltswLn2vZToaQlSK7lz+Mac8k2lD7OlOth4B8+Xw5mWWkkAHiQC1P0mJ7rgTpkY2MShQM80E6YJsAF0u+KX87vdjTkDLcq3DiKAzMiCXAMp9GgGLv50rOAgiigPVnVNp1DOTwTX7yBCjPMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkXF6vZdDSKBZAJL1m4U21+oDHDQ2VIQKF1M8CVedho=;
 b=zzOGKtzkQQuipeJxp9xdYiJYE3IKJCa0EXomqLDTxs47w5EXbBPXIljnL9Ww8fe3Dj46Rzk3rJXMMxJCmAeRabdQda5DHFSl7KhurmIsumhgjZkJjMjtgilNjP8i51Vi/GeY9kj5s1N0d8Ify5DpGtcKj3X6t8VAAKl5ocaDJsU=
Received: from DS7PR05CA0011.namprd05.prod.outlook.com (2603:10b6:5:3b9::16)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 7 Sep
 2022 18:12:17 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::f5) by DS7PR05CA0011.outlook.office365.com
 (2603:10b6:5:3b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:16 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:15 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: Reverted DSC programming sequence
 change
Date: Wed, 7 Sep 2022 14:11:40 -0400
Message-ID: <20220907181200.54726-1-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4883d6-2b97-4485-52a1-08da90fc7f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0CrZctyQNwtlceTDIQO2Jb7Sh6WeQvTz+GeQXMnD8DDlJqiu2lKVinvu9bsdKDyZFyNzKivhKvjFGaQc77aFSVCPubQEP3PznL2+jVYOAV18U8C/IKR5S1o9OL5lZrpTaDqlLMFB0yf+SOXn0nLFhefHkRQylcANH5F37WnrU/ad1/QpQ0QCM7io6S7/ObKtoEalGTNjvYIz2R0YELow2UOyITAD44DsLs6R0gjUI9Y4JbQAZu0bxaM6WMrv280n2oQuMHd5j0z/9ltDJb55fw4CoqmrAZrQc6qXayxBTIn7FhaRIyG/obmMM3OJ65wfYM+p4uIIxpDZr3J93J6WWjVD6F8TwJ4G8odiyhx6vWHrq1Jcg4ZEuDL+CcoA5bAQGXego4D1RD6L+qaKjt/Iy8BbxtSWVNb953tPBg9eZmABni6kquj94LyPR09qHkqRRmL+GnyCQNH0QEliDH51u4k8bnelnAdXOgP98dw6BE/JJnAD4lbGf86J0/VsKKND6pzw63It8z66dY/fXnGCKXaufj5bByBnHTs9dvGpo/5C66KpVCrZUO5pqMxhjkyc3fdab2NdZfdUWLleTXcDkyfWG+NjtA9Qa84R3JyuIlOISAuvDLjusFf4phs45v2a+EJTFpxUaYjCBR2U3VdrfKnUMiSSiBax6A7mwRMLhxgrg77bB7v4YPRnfuLYOe71WEbmUrAfcqN6zmtmbfDPjDatTZ5REg2qvW6jJKkUCGH1PctjMWp/wCO9JJOnkIPNwdlSg4su9rAueM1aWq2PgqFl1/C7ldKEQ8GchWGr+7aOX6yxWOQguxwz2+VIV7b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(81166007)(36860700001)(40480700001)(44832011)(356005)(5660300002)(2906002)(8936002)(40460700003)(82740400003)(7696005)(478600001)(83380400001)(41300700001)(54906003)(82310400005)(6666004)(6916009)(316002)(70586007)(2616005)(4326008)(8676002)(70206006)(1076003)(186003)(336012)(16526019)(426003)(47076005)(86362001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:16.9110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4883d6-2b97-4485-52a1-08da90fc7f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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
Cc: stylon.wang@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Iswara Nagulendran <Iswara.Nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[HOW&WHY]
Revert a previous commit by moving DSC programming
back to before link enablement.

Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c       | 13 +++++++++++++
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 38fa63d43ad9..db45a6fdffca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4303,6 +4303,19 @@ void core_link_enable_stream(
 		if (pipe_ctx->stream->dpms_off)
 			return;
 
+		/* Have to setup DSC before DIG FE and BE are connected (which happens before the
+		 * link training). This is to make sure the bandwidth sent to DIG BE won't be
+		 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
+		 * will be automatically set at a later time when the video is enabled
+		 * (DP_VID_STREAM_EN = 1).
+		 */
+		if (pipe_ctx->stream->timing.flags.DSC) {
+			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
+				dc_is_virtual_signal(pipe_ctx->stream->signal))
+			dp_set_dsc_enable(pipe_ctx, true);
+
+		}
+
 		status = enable_link(state, pipe_ctx);
 
 		if (status != DC_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index fe346e96c2d1..801206aed63a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1577,19 +1577,6 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
-	/* Have to setup DSC before DIG FE and BE are connected (which happens before the
-	 * link training). This is to make sure the bandwidth sent to DIG BE won't be
-	 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
-	 * will be automatically set at a later time when the video is enabled
-	 * (DP_VID_STREAM_EN = 1).
-	 */
-	if (pipe_ctx->stream->timing.flags.DSC) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-			dc_is_virtual_signal(pipe_ctx->stream->signal))
-			dp_set_dsc_enable(pipe_ctx, true);
-
-	}
-
 	if (!stream->dpms_off) {
 		if (dc->hwss.update_phy_state)
 			dc->hwss.update_phy_state(context, pipe_ctx, TX_ON_SYMCLK_ON);
-- 
2.34.1

