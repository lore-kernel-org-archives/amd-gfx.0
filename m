Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CEC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BDC61953
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BDC61953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426B46F4B2;
	Fri, 26 Mar 2021 22:05:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131156F4B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml4kcLUZTFpPXyT4YuPiYgedxmIgTWjX9Hg9U2/WAT1sA/NKf8Alf9G0FbMmBLSwO4YGt4VbWZwVY0uMT0VlmUfvooNd2+NPL3nGJJwM+vAV2QyP1TjZW8wLWXq/raxp3HOziB5VQOlora6/rl5MbblAR1R+8+NCCnqHoBc8L24dk9DDPdj0cB4a5bZoXKXBtPsT2ke2gnwOvjWlF/JmNrRhgiuvgoNl7cvYCNXCOkwASpBa9i30V/zlgcNXPpmAOKPJ9dsQoF9TGc9FYI/2RKnyorEQuk6bx81ox+gQ2L9Q8sTeLLrkvkhojV7f3FA6ce2HvqJJ238L8fk3ZAP6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIxhDlhQlopwjT7HELkfh+Ocqj+UXGfde4SMiH06W24=;
 b=KM8BRGDlbgaqmauk4gpAxJlkLcDu5hUo7sRu/NjMz7q5+5rz3bSFy5DDvBBVNDDpoAAcWNexqbVa0Ji9wZXuJ/u61Vgs+UoV1+T/8O+tHDHiHZpimutriNVrRGbWJHsAKki9M39xWe2qHWoNGVAUrdjH4PPi29gVM4b6PZtf2uKChVf5e+OHkx3709IYxGfOkWWZBUlarSEqMiUbEeIHkjHcZ+u0M9PZqX3hT7sj1Fd1ar/xhPhJqg6zJdhRGt4jxwcITvQWGk7/0U4XGBqm6NWOC6cyoP86sjN2A9eFkhMM1IK4R5vca+wMCnIBzdNZYLK0vP5UgFaK5+19LxU28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIxhDlhQlopwjT7HELkfh+Ocqj+UXGfde4SMiH06W24=;
 b=HZeKFklugDYh13ICKWal25SLPYcF3DeUaDg1ywDRtC7uaUONffDYjeEJbYRxqX7xFVkZFq2TeTpUo2+hfr4esQYrqajo4gqn7RorxSJa+WtfAuxwoET/qC/Assl5ojgXKNekxO7o02bs4MdES195/vO5HnEJ9i2yINuEgVCnmqM=
Received: from DM5PR07CA0060.namprd07.prod.outlook.com (2603:10b6:4:ad::25) by
 MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 22:05:52 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::81) by DM5PR07CA0060.outlook.office365.com
 (2603:10b6:4:ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:51 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:45 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amd/display: enable DP DSC Compliance automation
Date: Fri, 26 Mar 2021 18:05:18 -0400
Message-ID: <20210326220534.918023-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9419956e-50c0-4cc2-c738-08d8f0a35228
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44425374F5B82ED0D4EBF79BEB619@MW3PR12MB4442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDlKUlwa8skz7+mgh18fy/nbaM7D404V5Xc6L7HfpWWBSC7DoqeS7SB9yh2A4MTHfTbPvOiFlGcmDrdxC4ge1TmPkQ7u2uvLiyVM7QRBWQzYTFF8SuaHZZ4GVK3XjoHBiB3ufJNvw9kWh5wQ8cEG6wKZP2jNYxuJ02ft2v0XEXd/gCPEsk/wxlDNyOfwHHpHX84PI9CQd8QAGRn2cgvlhUYNXxcbYEcxSbE2l11J/cMsqCeJXMce531/eYGM9WJ+U9KmzhttuU8J5RJSAOWr+gSmKGL+9RD7USW65PgI9K6+vrRUFGVgIFWfBxA8wxhIBQ2czuQHbXF7ZLlC6uVXBlSzS8x9tcKI9ynoznYbC6t36f/XxwUgbaI3vqQJztj0wQJ+UXincrYTJ8TfvhyywD9P737GwDd4T0HHFKDcUfFTlDStK51amgTHACp7r7Epwp2ONxAM8o64WUFss94L+V05J+AioTh0uVQvAie0Z5RGLwefhG//HtFzlAN7DVTtK7p8pUAOyWifhBxXR4g4Ufz6p8oSmNavStgxnxQR6b4xn/ulB9NyxPa38TjLy/GvhcwnPoqTKUH2JEi6UIIjf5Cac6DKmECqUCpyTlAiV0E8t8DsYxZ5YfIuKyECpTh3U3YW1jOEoRAhNpwFSZIAqS+OtPlV0eDIuaK6wnpAgsrCEFEcrBUvfpOvtuL9e9dm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(6916009)(478600001)(47076005)(36756003)(6666004)(2616005)(426003)(336012)(7696005)(54906003)(83380400001)(8676002)(1076003)(82740400003)(4326008)(86362001)(316002)(8936002)(81166007)(5660300002)(70586007)(186003)(82310400003)(36860700001)(26005)(2906002)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:52.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9419956e-50c0-4cc2-c738-08d8f0a35228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Color depth data is not parsed during test requests.

[How]
Update display color depth according to color depth
request from the test equipment.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a92fc1875474..962e88dd8dda 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2808,10 +2808,27 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 	enum dp_test_pattern test_pattern;
 	enum dp_test_pattern_color_space test_pattern_color_space =
 			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
+	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
+	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
+	struct pipe_ctx *pipe_ctx = NULL;
+	int i;
 
 	memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
 	memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
 
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream == NULL)
+			continue;
+
+		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
+			pipe_ctx = &pipes[i];
+			break;
+		}
+	}
+
+	if (pipe_ctx == NULL)
+		return;
+
 	/* get link test pattern and pattern parameters */
 	core_link_read_dpcd(
 			link,
@@ -2849,6 +2866,29 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
 				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
 
+	switch (dpcd_test_params.bits.BPC) {
+	case 0: // 6 bits
+		requestColorDepth = COLOR_DEPTH_666;
+		break;
+	case 1: // 8 bits
+		requestColorDepth = COLOR_DEPTH_888;
+		break;
+	case 2: // 10 bits
+		requestColorDepth = COLOR_DEPTH_101010;
+		break;
+	case 3: // 12 bits
+		requestColorDepth = COLOR_DEPTH_121212;
+		break;
+	default:
+		break;
+	}
+
+	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
+			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
+		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
+		dp_update_dsc_config(pipe_ctx);
+	}
+
 	dc_link_dp_set_test_pattern(
 			link,
 			test_pattern,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
