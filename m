Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DDC25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A2C10E819;
	Thu, 26 Oct 2023 14:20:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5233B10E810
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiCGzX3IXfTn7wlwYHBoS3gVDyWeBzR/8VplBXi/EAMUmfPsIo2w+ArwFuP4pkcvZXT48HAhSgbSDaXbTgTk8rhbVZ8E99zZR0It/lgoL7ssZKGdKk9QxouW7ngP0ALXW2EXt/B9LfQu06oK3+9AqY3fmRLe6eWXwC3jpvkoUqe1uskDQwMu2vREk2acZovLhlJtPRqseSDPiyrxkshMZdiWCJ8Vo2oZ5/2oFG/aA6neaz6E09HYpBr9ESictTr9D1oD8F4fqRua5187LE73kjU0UD+uqHaQa880G4QHjJwlHz3zWazKrG7mCkmQOaeLwHhU0SQ1jJWwjkKjLxxoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u590RFmuAEr+KT8Hy6qX0oQBqH9WXBbDK/DkVvRyNBw=;
 b=LB9N5e0MldZptVlCr42KD5rQkfCxpfF0FJ5loZ4HG1h2Vvon0NjVT8JjUprB3JWTSwyI8cZO5MDScZ49Aeb3kB/6ydlyO2sRdTVrOifY0FEa2V3kf06V0o6sFp8Eu1Yl8Yst6MPLx+fiYHwA8eFWa+YBmjtGDoQa6j/IFruEiMNcJMG1FYpgIubWED33dLcsGqJwXXWfJiW71T6GEBueDbXLjSLpD6XXNL8AA/bSyd3j/B9tdwnYorj2IYV2t0rXA2BNjJfkyoTi3TtWoM4WZ10k/sLMELLyeryWM06msXB+y7ngJOIo1sxh9/XE7HK1pMKVtrv55c8xQXAmf3Mx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u590RFmuAEr+KT8Hy6qX0oQBqH9WXBbDK/DkVvRyNBw=;
 b=el/DfSIfo+ZY/fi8v1ZMaKXQULa4K7NqQGNTutfED0a7SVTlxTj0JN5nzjtlzlMnov+Yrx7IeEmTL49s0720dM3iQq+2HRB6uLlrI9Z/p/NpL/hDUYc4Q0DVV18ey+Ya8OVCzTqjM4oX31lvg8XwB1HEb2r46qssa3YsGl3lBis=
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:39 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::a6) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 07:20:38 -0700
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:37 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/25] drm/amd/display: Update DP HPO MSA with colorimetry
 from test request
Date: Thu, 26 Oct 2023 10:20:05 -0400
Message-ID: <20231026142020.67861-11-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e01865d-87b4-4e03-50f0-08dbd62ebb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3o+zLH5el5SK3RnW27lYL15u/VQcZJrGjfpdKzO03GLIUUNVASlhjCe8o4X3jP3Cvc/ELJ6mWXvlWIYJfRUp2T5ziZX9GesduI51GY0Ifb6k2mKU12Vr9jSn1yNQSCBxjjUg2uxAyYr8IlTeQKP72f6D6HuhNIorXOg1w0i94eYkqtzr/lqCRbwLgjsg5wEFudAqH3ENbocqM0761bIVHvzZzlqOlaCJ2/XLVrF9nt9azk/04BGN6C1WMPIcyA1n+LrmFJ5386LeFM+AnNfKHiimLeRyebXQPtqlzTg9AIzwHjsl70yWC85RAycixighFyjffEI8JwxXNhJXC34we8f9eJ1LZiNyWWyXgx+eAOg69TKErK3YRfZJLmua0j/2raN14DiJAxyuIg9xFMvfrP1ZznCTDjRowjMMeCj8jGs4At6yp4iET/UWx9p57iJZwfJAjG/SD91Id6qeczdgMj8CQcpXqrz9xmuK9llnr7P/7dmUu1Mk0jX3C0Y+7xTIgEunKXtuqRDjpqgUZmxfed4Dzv/thJ6PEmxuAzKWgZfFgTM3My7ZEfvPwn7X3RzuKSMUpN6M5RYPHkiQcgHdVB1IJkUJZH6HRtmpUzzQpcIHg/FfnnQrq5owyQ18OBgYlrBX3NHQxlL8U5DpqNmANrpKhNTwtfrL9BMx7+AX/973ywpG9FLbVh/ZUFfNZ8VJzhNIxlZQTRBl5gLu1WFX+OZTjPdNkbAAdcP7Jp0MeDATBc4dpU24s7TJND6EKoRQoiHj1k5IbVszbQv0vDKzkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(36756003)(41300700001)(2906002)(5660300002)(15650500001)(40480700001)(40460700003)(356005)(26005)(82740400003)(81166007)(4326008)(8936002)(83380400001)(8676002)(70206006)(70586007)(2616005)(54906003)(86362001)(316002)(6916009)(1076003)(6666004)(478600001)(36860700001)(426003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:39.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e01865d-87b4-4e03-50f0-08dbd62ebb04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Some DP link layer tests request a different colorimetry than the
default one that is used. Currently, our test automation logic does not
update the MSA with the test request value for DP HPO case.

[How]
Update HPO MSA colorimetry with test automation request value.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../drm/amd/display/dc/link/accessories/link_dp_cts.c    | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 21a39afd274b..02d1a397ecc9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -592,6 +592,7 @@ bool dp_set_test_pattern(
 	const unsigned char *p_custom_pattern,
 	unsigned int cust_pattern_size)
 {
+	const struct link_hwss *link_hwss;
 	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
 	struct pipe_ctx *pipe_ctx = NULL;
 	unsigned int lane;
@@ -828,11 +829,9 @@ bool dp_set_test_pattern(
 
 		pipe_ctx->stream_res.tg->funcs->lock(pipe_ctx->stream_res.tg);
 		/* update MSA to requested color space */
-		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(pipe_ctx->stream_res.stream_enc,
-				&pipe_ctx->stream->timing,
-				color_space,
-				pipe_ctx->stream->use_vsc_sdp_for_colorimetry,
-				link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
+		link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+		pipe_ctx->stream->output_color_space = color_space;
+		link_hwss->setup_stream_attribute(pipe_ctx);
 
 		if (pipe_ctx->stream->use_vsc_sdp_for_colorimetry) {
 			if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
-- 
2.25.1

