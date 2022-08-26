Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6215FECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD7010EB93;
	Sat, 27 Aug 2022 02:53:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0255010EB92
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5xdxbST2mSDMJduWkvVow3bIBrVwAFhfy+QxfDiqPgwqcd10NnG2YdTSbmencIpcIUIbGIm73u6h43SuB+gIH9a0FMl2UWn+vCJZjlHzB+MNZAc8tbMmGMZtW5JCzcWon90weBAHgvGQaxNGpSW1E760R8OmEmcdzwFvSuPEol5n3j/NLxjJzDJSeFMIwz6SmJmoIXYxISkR8JwY18r4FSoKoREFu5AiBqeSwDzqLRr5I+0fSs6g50Jjj18yDfVDumfVn47b+ymdrSbhKhMUJIWbWRa3EaBFz/La2qtiDpKLLsWKlDi6q/j8zP8+BurzJllamBf7BVhQsxHWpRbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZaMNhpbv6vRu6fi9Y776zcRmZDQYuTlhAwYNwecFdw=;
 b=CDTHGcg/BiiJLRLSbAP1E5AvbH2Ew50JA2NZoJwF5Q0G68N+FgEOYFjxwP4cyKhNVsn/OkGad2cmLNDyiZuUeowBwOPxEx2z7oXzpcrntP4pdX3kG3v0iWgi6PilvtzS8ieQj5bkY/qSmIVamNnrEx6xBWVno1UR5RCKLalaTpkjD/ny5i2ljbg8GWP0BZohLb/XcyKWipqpnzfD8RNjbk0FbJjCGJ+GvMIdRjtFSjSy8NGvoJcsaVRxEhBqz1wG6wpP0HlD1dLEDu80nfxD4wtwzKTkLDKPTxoMuw/jeNQLg+YanWITQWgyWmafCtc4LD4raYUkDrcURG8h/iyfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZaMNhpbv6vRu6fi9Y776zcRmZDQYuTlhAwYNwecFdw=;
 b=AspPMdauTsiWgLQacMz6knCiDhQSlM7fQQafzHqp7dGnaMCDBmBrHTzcVjN1BB0GVWTetCxcvH3eFvBgi5XElE9EbNHiXhu0kOcLFW1rlvy/MT3NfTaAbBh24ME34HFjOaQfkqLE2k2RaDYaGTWjzZiPXmTY3FMn3Fi+QLkxLPM=
Received: from DM6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:5:60::18) by
 CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:52:51 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::e2) by DM6PR10CA0005.outlook.office365.com
 (2603:10b6:5:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:50 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:41
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: Use correct plane for CAB cursor size
 allocation
Date: Sat, 27 Aug 2022 06:50:49 +0800
Message-ID: <20220826225053.1435588-30-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b05bd3f-2e03-4804-3938-08da87d73b6d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1yL9ik62fDY9UixPdt9fyWZIbyAxJ1N2QdlfocjPOhsw/blp1VxGt8koXmi6eDPuXxg4dtZ/ja9tpzjbIcdYsDFdqbDbVS6nPSmRS0djzKQT/kXlaC0LNCVUBXa1GhxmuPmH6SiJVr7cUxr64uUAUXvyXjT/xUmMQiIpg9+yT5DJhgspNOg4v+3s3GJb9lDpENBld8oQ/9HIO92lSU2iRh5h3Wlz3Sqgd8gHWAOnG7ZBAaJAz59dnDo29+xKHqig7jRekEr8XJ4laY4ZY/gN5esY+rEuLVml5wvAeNA7JK7sirm1AQYfiwbXgBUd1b9pldizZ20nu3vpi/+ELsqStQCx3omZWJ8TLfXohYE1Icdh9Iv78FXHuJXsH1b0PO9NvmbDqLzyzkzhD1wwrQ/D5rhRfn4jmHXXJqqE2coWL0Ia9Dbp2N80uEFb6bQ4AT3t2PIeqTxk7zFiK+R6HcIosjLO6AsLf3zvFAIXllBioaUPuQzu+Pkm4+UkbDxSP9c/YVCah0vSMeyYuFW/iE7pUTYhmvvpaNTmUqFH6PEQi2uXoEBfrslPIrpYj1apDdm4O9HcVyWSXJNVo0neuatrx/304tz03/1bBVBAq5klK8p9bUR2BH4dJyu3VfsLZfF2Yj2azUo/IcMFw8RrvohINwRtC7Gl59dE8jP7mvPMRDXP+OKsG1Q/eZjxFeEGofyFgGg62gFGWfpZjBJPCKmCnbvSwxItBAA8sfPX/2JyV8rbDFpK1d2BvspO5hQNPrQLiQpccq1AJanqwuFengTH5vOBoSqi9pHfALnTQd83bUonG9/0qVAYlxx4eaEff4ATMF+GGofWTtWpHjMcZOtTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(40480700001)(2616005)(70586007)(8676002)(316002)(8936002)(70206006)(4326008)(82740400003)(478600001)(40460700003)(54906003)(82310400005)(7696005)(2906002)(86362001)(426003)(83380400001)(26005)(356005)(36860700001)(1076003)(81166007)(186003)(36756003)(336012)(6916009)(5660300002)(41300700001)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:51.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b05bd3f-2e03-4804-3938-08da87d73b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
plane and stream variables used for cursor size allocation calculation
were stale from previous iteration. Redo the iteration to find the
correct cursor plane for the calculation.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 7717d00b60dc..8587b67fe824 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -295,8 +295,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		}
 
 		// Include cursor size for CAB allocation
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[i];
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[j];
 			struct hubp *hubp = pipe->plane_res.hubp;
 
 			if (pipe->stream && pipe->plane_state && hubp)
@@ -339,15 +339,25 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	if (cache_lines_used % lines_per_way > 0)
 		num_ways++;
 
-	if (stream->cursor_position.enable &&
-	    !plane->address.grph.cursor_cache_addr.quad_part &&
-	    cursor_size > 16384)
-		/* Cursor caching is not supported since it won't be on the same line.
-		 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
-		 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
-		 * from MALL. We only need to cache cursor if its greater that 64x64 at 4 bpp.
-		 */
-		num_ways++;
+	for (i = 0; i < ctx->stream_count; i++) {
+		stream = ctx->streams[i];
+		for (j = 0; j < ctx->stream_status[i].plane_count; j++) {
+			plane = ctx->stream_status[i].plane_states[j];
+
+			if (stream->cursor_position.enable && plane &&
+				!plane->address.grph.cursor_cache_addr.quad_part &&
+				cursor_size > 16384) {
+				/* Cursor caching is not supported since it won't be on the same line.
+				 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
+				 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
+				 * from MALL. We only need to cache cursor if its greater that 64x64 at 4 bpp.
+				 */
+				num_ways++;
+				/* We only expect one cursor plane */
+				break;
+			}
+		}
+	}
 
 	return num_ways;
 }
-- 
2.25.1

