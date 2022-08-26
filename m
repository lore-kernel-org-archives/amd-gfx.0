Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BDAECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0512010EB7E;
	Sat, 27 Aug 2022 02:52:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5C010EB7E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEYyf3CHVVS7TIooc84DFzmELVgR+ANxOb7KkLhJSjR64GwYjyIldX6nFJVWHeTyJkQ5AKCa75mUUezCX8QCy0ma2cWe/Co8aw48bssesPpZZkSVOrJHFTS+DfW0pQCfalg4gKkLXzdfoAeKHS1TMuyUvQxf1l5cyvL0c2nZhlaqeHpszsZ5vmdrMRmRdaGfc9iJqABDTkrqxDrv3BDn52os62zfQMG/J0OkdReXFJKv1wd0+JL4AdWP/vqe1A5NGdeV0NLUP0a2JfIQeh+ElHZrEQFidl++EyO4PpG0Dc8m0oNzlW/x8FaJ5K5/6r1mrX0dRWYS0KU4FKdOov+jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFNeHvQ9xBrLfA+UE3hogr5M4zShgLx+OAZF0ZLuD/U=;
 b=Gx7DXfTgiqGSTUheFX8IBiUBsqu0295xkM/v/LbaZtw19onvBY7UEQkXa15PV88Yl9v4aL0Q0P+pe6yLD7U8BTzLN5ByE1Klzk2XkTQafmid8s2bnp6vTFYfrEq6TgE0me7OJ0IE4AGW+x+JxQIxiny/8QWeSgYBDh8YfBzsSrm5lsE71ACLsIrbhnU7iEacTs+oFKBkw4NglpfiBeA5vkfRPwyLP9E97nJJrU6oYIlJtSgCwOSHhYjMT7HdZbtdSgcmW3epVEsO3kOlrTiRH9XHRltWXYfP9O91Q4pP+n9po7IEymxMH1QxFRi+fbmdXRWn0eKSRqQPFCwYTGBe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFNeHvQ9xBrLfA+UE3hogr5M4zShgLx+OAZF0ZLuD/U=;
 b=3gsHQBVKRsBEgj+egddbuE14ddIfdy0mB9dZ1BREVfFYvwt4MyOp//ZnyaogE+N724/nMXB9zwOz2DbW0+gUKSYBC/mUEpMX7h07Vo18JJjM3twTtAJmO3JdqbukkBbU1dhvznl9qqKMeXAeRk8fTnaHXzgZebLVt1YNFwiSuIc=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:57 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::60) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:56 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:47
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: disable display fresh from MALL on an
 edge case for DCN321
Date: Sat, 27 Aug 2022 06:50:41 +0800
Message-ID: <20220826225053.1435588-22-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74bef0f9-0b86-4d8b-0d5c-08da87d71b7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqc02ClR9v4zu9mWYKJbRB1UVjoreJQECWBRQtfIgsB0dDVVOrejNEBLatK/HLV01g4Q3ZawUDqdsZyCk4FVxNrjrLEsnP1B0k51T+fxs49AGeMDfUlNDQdz3sHy4CDucL12kMmyxsSRn+LbpyKAIDf7rhn+OsZA6Hf0mxm3DPSxmd/DZFkqnlPriMBnKC0tB7qXWRBjMj18s0oUbCp2FfvgcPZOElO8qdYGRhqr0sZdj9GyMeamkmK168AkANzwTCEO9BAiZi8LIBQf/Ny7bpD9qtEvhIeSWRQffwe07mCufypXofFnKQHNotSv/G4TlXAAehAZLCKXK5LyKRsd0rbbSr2Id8rxaWFYu8J8nzW72KpB3NPAiEBv1tN79pVkA8zyjsjNHaZ7Z3+IRzOKvbzC6w+O35vpIxIWQw4t0MOZOTnc7BUBzZNn1E0zxBaZuHMv2gOVGYlthg5+VHX2YjFEfYlZ9JLwGmCMsnORc9KDzn2OPZUsuXIRUc+75IzIgvKD3Avzj6rPBFmkc2yI3bK1OtdBaPUXon57hFLLFYuItVo2dYSBSRsjbxskrgJBgAfBslEqIgAjRgwqtx8XXmASAT7sVrIpv1T54ncCIOCLD9NwmORAJrApepA63NJK6DMEi7JkTMbmzDoyfZlI+SIAqIje77G4678l7gZIyfaWn3sOmDQ4w3jI5C8gu1uffFP0NF7kOcuaYeBE+pKjZ/w2lcRARU2gkEwjaDglcU0QP2sa6TiLw7vz0Ce1ubokFw6lUXCsvAAeKcCEX0STeyh6Aizl4EnPwV3LoVXzb7dQ3bzKgl7/jWRTCROyQnZZUretbqBNg5hb7GmDU0/aNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(316002)(82310400005)(36756003)(82740400003)(81166007)(6916009)(54906003)(36860700001)(356005)(40480700001)(47076005)(478600001)(41300700001)(8676002)(4326008)(426003)(2906002)(6666004)(70586007)(83380400001)(70206006)(2616005)(1076003)(336012)(5660300002)(8936002)(26005)(7696005)(40460700003)(86362001)(186003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:57.4126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bef0f9-0b86-4d8b-0d5c-08da87d71b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
When using a 4k monitor when cursor caching is not supported due to
framebuffer being on an uncacheable address, enabling display refresh
from MALL would trigger corruption if SS is enabled.

Prevent entering SS if we are on the edge case and cursor caching is not
possible. Do this only if cursor size larger than a 64x64@4bpp. Pull the
cursor size calculation out of if condition since cursor address may not
be set on all platforms

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 4e965a0c2484..a54cb79e7ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -295,23 +295,24 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		}
 
 		// Include cursor size for CAB allocation
+		cursor_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size;
+		switch (stream->cursor_attributes.color_format) {
+		case CURSOR_MODE_MONO:
+			cursor_size /= 2;
+			break;
+		case CURSOR_MODE_COLOR_1BIT_AND:
+		case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+		case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+			cursor_size *= 4;
+			break;
+
+		case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+		case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+			cursor_size *= 8;
+			break;
+		}
+
 		if (stream->cursor_position.enable && plane->address.grph.cursor_cache_addr.quad_part) {
-			cursor_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size;
-			switch (stream->cursor_attributes.color_format) {
-			case CURSOR_MODE_MONO:
-				cursor_size /= 2;
-				break;
-			case CURSOR_MODE_COLOR_1BIT_AND:
-			case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
-			case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
-				cursor_size *= 4;
-				break;
-
-			case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
-			case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
-				cursor_size *= 8;
-				break;
-			}
 			cache_lines_used += dcn32_cache_lines_for_surface(dc, cursor_size,
 					plane->address.grph.cursor_cache_addr.quad_part);
 		}
@@ -325,6 +326,16 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	if (cache_lines_used % lines_per_way > 0)
 		num_ways++;
 
+	if (stream->cursor_position.enable &&
+	    !plane->address.grph.cursor_cache_addr.quad_part &&
+	    cursor_size > 16384)
+		/* Cursor caching is not supported since it won't be on the same line.
+		 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
+		 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
+		 * from MALL. We only need to cache cursor if its greater that 64x64 at 4 bpp.
+		 */
+		num_ways++;
+
 	return num_ways;
 }
 
-- 
2.25.1

