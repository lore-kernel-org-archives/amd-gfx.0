Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDAC982D7
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D675E10ECF9;
	Wed, 16 Sep 2026 17:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwCk9di3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B38F10ED02
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0Mh3dLD2vzU8CNN/jZyn9I85cIpwW+czgrEQ0N8u0gYDAm8C9D4GXRvGTU60ozcx70iDSb/ny+iYJfCcM7NfXxMrtPJuHpzvRswq5OYaYRbu7MKTjhal01/jrVZjxFkgxqzG/7NNp+6N8V1VyGKz5W0Yu3QE5EoMaM7IcSitLxZhHlJB8JyBDH8MQ2imj1u/koV7+EjrPyDLUx3kd2sL5OjLrtoiIUC3u1lf/DAR5uVqk+U066CI+8Xz9nyWvedjjFo7GnqYKgN7d/7FZxeI3i/FFQVAe3hTXbSXGiOMzz42WHkBCCklzW9mSpfXNqIsqvfTlzXhXNQnNY2qPmpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iztqZWrIqqlzWk+CC+eWEl09CSYCi1VYIr0UUHqU28s=;
 b=Uy55td3tBojdqTOfznXdUGY/lZs3slFvzVZqRrGwHhM+WTDFtf+kWKi7g/DdPA0bqDZ0LvaOlJQ+X7H1/LrdOtbuIW+tbEOcisYgivLxLbteyMpI5QLMzBnDal2xzaVOXz+XJGxgoBwEV81zAA/TTbWMEzSGQ9Y/MtID+hOw0T00QYWAzF8ivlwJU7CjyhUq+RFTMq7FULC1uKkxMoQR51jZA2V52tIxicUmd3BimW/TbifD9pwLuCBGWCwu/JKA2mtRhGFH76kA4rJkI8Lvwp+ePa+lHuEoReegEfrfLs/V+dlKT1tPBnQszC3CIevFi9l5XFXN6mXVceoVCwlIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iztqZWrIqqlzWk+CC+eWEl09CSYCi1VYIr0UUHqU28s=;
 b=rwCk9di3ErZKZsDrVtdqinGoiz7JHhVLF8F4jaqLe5Pp90x8qSuCCDV1TzoZYVPAXqnLRiA4WBhUa9mjzbBbufbwxFWhnNeVmF0vKUdoEsscqhvVWCOhKb1A7kJvxrAmO1oU69yk7VcK+meviSXN9296dKJNhidYnsgw/7rOb34=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:53:11 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::82) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:09 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:58 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 57/64] drm/amd/display: clamp cursor hotspot at the register
 write
Date: Wed, 16 Sep 2026 13:52:12 -0400
Message-ID: <20260916175301.368306-58-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e31dc2-6d2b-4746-76ff-08df141b5e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tBLxLBjJMzlFrkX9UfGu9AXANmULnlGACWJHP7Xrf+XvBCjn6sqg5Zeg9n1JIbqSdeIq5xpml/qTt7wb3g9ckmexX438Fe2xMbyvqgZZg1Rqk9+bH9vc558FO380gRrujMYxUnEDHIVL1/vou3IJAA4cHxD/4wlAb9zQH4Pq0JPwJU/7TJA1BBljJL75h4YJDr8HJ/Y/PgCzcI4DAq7pCmEr/IV1pDfJpk+dysBQECX+k8xq12xvEr8DqqsI+FqFJNkJV7wVa/RYrV24i97m7JHpELkaG1mJQI59W/Z04j+T7EYlIvS2arwCjFj0XxTkmwdhYEOIa8dZOgLqopeRlYUkkk4VQwX88xcGDKtHFmsTDYTGdR3sTIjy3ij0P3230hVp/Q0RQeTYVuueNbnV/Of5x4UrmbBJrvNJBcLYVD0rGrSvmAgMm937lY3xWpuIN/crksd1dX04BNY3lT696Ijt9E66PfE1qPNxXu0gg5xdfXyHGu+ra4LQgsIxv8rYdx/e2+KS5cUOaBnsU4WE6FU5YX/x2lYskEvgfA+TVCgcEauD7bPQHfGkzHuakzypBfDd8fYK7m3ve6D/wOZjfTKwlePP7jnf6ffd/GltK+gQNioKTGfAe77Ds4VZtb26/b0el7RXB93Pf8ir2NWb09CLNfQAMWtEuVFE62OodanfQZSx0+kfjQCEf7J+p+uDUGuRBY/bCznjpr3I4I0qzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1ZsjIdbaaXTrl5ItJt7mcRfSl6Ly3fj8UeMkDhU8R6XJGsqhjn8XV68CJMzqs54B9fkhx9vy92YqWDOQnR9a+V9dJhkbpBruejHlM4mIvjsoEZfH1sg7KVG1rk4gULXSDNGo/ijYegQydL291Go2oVUEQlfRXDgJdi+l3CAvprmP023de7FmPRehxda1nwGXhWsTahrWo7jNcMh7yfmx0OKI44HIbfaKaL0LYLvTwFvn1qSPuwS4iV+kVP4yH3Cz7jitDoxD/zkwX6Qj6Wb62NQ/cZu0MOgelgvgZ9uudvWa06fPlvJMe0Frh7US9Bv15Q8gqwQesGC0tUkbYSgJR4ujj9Hj02oCVSdhGLMQebgNxESmz+EWxseWgTER6ht9gWQ7gkCFli13DWYM+XJyQQsmgjBB0Z0Xv+C9Lh+GowhDSkBJ7FoW707hmveNDr+8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:09.2173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e31dc2-6d2b-4746-76ff-08df141b5e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[Why]
dcn401_build_cursor_position() clamped x_hotspot to 0xFF before
publishing *pos_out, but that field is also stored into hubp->curs_pos
and forwarded to dpp1_set_cursor_position(), which derives
src_x_offset from it. The ODM/MPC slice adjustments earlier in the same
function deliberately grow x_hotspot past 255 to keep the cursor
visible across a slice boundary, so the clamp corrupted DPP source
addressing in exactly the case it was meant to handle.

[How]
Clamp in hubp401_cursor_set_position() instead, where the 8-bit
CURSOR_HOT_SPOT_X field lives. A local is used for the register write
only; pos->x_hotspot passes through unmodified.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 4 +++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a985c3e00dca..91e87fb51fe4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -818,6 +818,8 @@ void hubp401_cursor_set_position(
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	int dst_x_offset = param->dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
+	/* CURSOR_HOT_SPOT_X is 8 bits wide; clamp only the register write */
+	uint32_t x_hotspot_clamped = pos->x_hotspot > 0xFF ? 0xFF : pos->x_hotspot;
 	hubp->curs_pos = *pos;
 
 	/*
@@ -842,7 +844,7 @@ void hubp401_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_X, x_hotspot_clamped,
 			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 		REG_SET(CURSOR_DST_OFFSET, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 37b699c69144..98398dac9861 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1264,10 +1264,6 @@ void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
 	param.cur_rect_x = rec_x_offset + param.recout.x;
 	param.cur_rect_y = rec_y_offset + param.recout.y;
 
-	/* Clamp hotspot to the CURSOR_HOT_SPOT_X register field width */
-	if (pos_cpy.x_hotspot > 0xFF)
-		pos_cpy.x_hotspot = 0xFF;
-
 	*pos_out = pos_cpy;
 	*param_out = param;
 }
-- 
2.55.0

