Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB992C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517732224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u6lFPPf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517732224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3241F6E841;
	Fri, 13 Nov 2020 20:58:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260586E83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWhmczgZ+vu6MqKnx3amaeMehjKmnVH2vE7aFkkSvukx6XD9SojSh/5qM4IqNL6NREwfXEz9/3kKsShkqYvATI6YcPJ+xQ5mXC+bXJo30SlPRjYBb1XIFtGS8r1YCQl1btjOO0uA9TjviBPlUj9IgC6OiOhXN8oifl/P3IoGg0MN/PIwmGUmu65jF1WvmNn/ud5z3z+mOaPrytgbut4jqVqjrHdaMk0G3LrLRWZqoHlEJc1ue2BuOJS+2dM1igbPUGI78pjiOsqM0w4PRy8H2BaI6sUW6kaOdN5ax0zcz7XfL/gKcSHimA6rvGTTAvx4WvPdSOqKmPMCozpil1aHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVwOXnYnBV7yXdqxZzIdWKp/I/U30u8rZ4hR1VReV5M=;
 b=PBvkgdxCZTw9I+B66+vVNzkimCJxSitkcPzdA+kYBURob0eQGsv7xFQf30SYH+qqOlu14YrT4yu05LRJ076Pr27Khm2fCqv+8wD212/GKSSvmSkDEmgpw/r5w9D1z/Q5NqN4+LfMEFVlTxLrK5OwjEXMKvNWrC3OXa0Xirbo/WOrWg/3dpo7qrlKCTvqOQUvDQwCmRLFYWigsbDgFpW7mF7OFYpm2n5n14UcezF+09cC+55TvldL14AWUTV3IZv7kH4oX2oFqwzpO/I4LJ3VbDZikzZJh6yglfKnKBxFw8G71QD2CO54By10hRWcds92m+Ypl3+VfPSfOCXVRU5IzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVwOXnYnBV7yXdqxZzIdWKp/I/U30u8rZ4hR1VReV5M=;
 b=u6lFPPf9Rs37cDkjNYF9Q2X/kcyMgtS9q0tMw0J/sRMf0knl3IK4uMwEtHodDE8s+BwUj5iRVuuiq0RAM+fEJUqE3+Pf0Lowu6+eH4jqbKyh7M6dHvNOs/hrKbcLSv0FqjivEkOfoybC0oAPpfldA6z5ryboS5vS2TMgI66uyhs=
Received: from DM5PR2201CA0018.namprd22.prod.outlook.com (2603:10b6:4:14::28)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 20:58:02 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::cb) by DM5PR2201CA0018.outlook.office365.com
 (2603:10b6:4:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:59 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:58 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/17] drm/amd/display: fix cursor calculation for 1xnY
 rotated display groups
Date: Fri, 13 Nov 2020 15:56:34 -0500
Message-ID: <20201113205645.640981-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca263b4-7407-40af-56d0-08d88816cec1
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:
X-Microsoft-Antispam-PRVS: <BN7PR12MB261198616D34183F8A5B29E5F5E60@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh6Xzik5hSZ7vVRcA64G2Ub2jlbo91FABsl1OqF0E8lJHqqJg0WquICX03/GNYlT9XclB4VaPB6izWrShfI3sJ50mqXGmPWB19tgE28YbiIYa8MTSZHnNa6RzPFeL3kuPwtXJYbN6Eeh6mcJwoQ6KJH8SuY7GfzcSKAJ/TaAK67+t/KsVsk1gmBkDes2YGUERyRNkWEPQbmwRvZGO0+7YGkE8+fNsmn2MlH97WRonS5zRwsbuZZEU3UAv5D6Y07WXVONbOFV18wXpjgq96YKss5TfFk7c8sPyBEoLg2mlYF5NUgjY2YD3i0Uii6S/zcl8OZfuIg5+Z5gou7+cBIohaSnHU4BMSnmKaXV4TON3AgDdTibJGNRdSbllE5mbc7d1eUKD20IJ/9afykXVo3wWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(4326008)(26005)(47076004)(426003)(5660300002)(1076003)(36756003)(8676002)(8936002)(70586007)(186003)(336012)(7696005)(2906002)(82740400003)(6916009)(356005)(2616005)(83380400001)(54906003)(82310400003)(316002)(81166007)(70206006)(86362001)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:01.1271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca263b4-7407-40af-56d0-08d88816cec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <Samson.Tam@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Cursor is missing on displays 2 and up when doing rotated
 display groups in 1xnY setup.  Calculation puts cursor
 out of bounds so it is not enabled.

[How]
In dcn10_set_cursor_position(), add in viewport.y into cursor
 calculations for 1xnY rotated display groups.
For pipe split, check viewport.y for both pipes and use lower one
 to normalize cursor position before calculations.
Add odm 2:1 support ( using same calculations as pipe split ).

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 64 +++++++++++++++++--
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8eb88a50af51..1e18f0bb40b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3279,6 +3279,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	};
 	bool pipe_split_on = (pipe_ctx->top_pipe != NULL) ||
 		(pipe_ctx->bottom_pipe != NULL);
+	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
+		(pipe_ctx->prev_odm_pipe != NULL);
 
 	int x_plane = pipe_ctx->plane_state->dst_rect.x;
 	int y_plane = pipe_ctx->plane_state->dst_rect.y;
@@ -3362,16 +3364,56 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		uint32_t temp_y = pos_cpy.y;
 		int viewport_height =
 			pipe_ctx->plane_res.scl_data.viewport.height;
-
-		if (pipe_split_on) {
+		int viewport_y =
+			pipe_ctx->plane_res.scl_data.viewport.y;
+
+		/**
+		 * Display groups that are 1xnY, have pos_cpy.x > 2 * viewport.height
+		 * For pipe split cases:
+		 * - apply offset of viewport.y to normalize pos_cpy.x
+		 * - calculate the pos_cpy.y as before
+		 * - shift pos_cpy.y back by same offset to get final value
+		 * - since we iterate through both pipes, use the lower
+		 *   viewport.y for offset
+		 * For non pipe split cases, use the same calculation for
+		 *  pos_cpy.y as the 180 degree rotation case below,
+		 *  but use pos_cpy.x as our input because we are rotating
+		 *  270 degrees
+		 */
+		if (pipe_split_on || odm_combine_on) {
+			int pos_cpy_x_offset;
+			int other_pipe_viewport_y;
+
+			if (pipe_split_on) {
+				if (pipe_ctx->bottom_pipe) {
+					other_pipe_viewport_y =
+						pipe_ctx->bottom_pipe->plane_res.scl_data.viewport.y;
+				} else {
+					other_pipe_viewport_y =
+						pipe_ctx->top_pipe->plane_res.scl_data.viewport.y;
+				}
+			} else {
+				if (pipe_ctx->next_odm_pipe) {
+					other_pipe_viewport_y =
+						pipe_ctx->next_odm_pipe->plane_res.scl_data.viewport.y;
+				} else {
+					other_pipe_viewport_y =
+						pipe_ctx->prev_odm_pipe->plane_res.scl_data.viewport.y;
+				}
+			}
+			pos_cpy_x_offset = (viewport_y > other_pipe_viewport_y) ?
+				other_pipe_viewport_y : viewport_y;
+			pos_cpy.x -= pos_cpy_x_offset;
 			if (pos_cpy.x > viewport_height) {
 				pos_cpy.x = pos_cpy.x - viewport_height;
 				pos_cpy.y = viewport_height - pos_cpy.x;
 			} else {
 				pos_cpy.y = 2 * viewport_height - pos_cpy.x;
 			}
-		} else
-			pos_cpy.y = viewport_height - pos_cpy.x;
+			pos_cpy.y += pos_cpy_x_offset;
+		} else {
+			pos_cpy.y = (2 * viewport_y) + viewport_height - pos_cpy.x;
+		}
 		pos_cpy.x = temp_y;
 	}
 	// Mirror horizontally and vertically
@@ -3381,7 +3423,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		int viewport_x =
 			pipe_ctx->plane_res.scl_data.viewport.x;
 
-		if (pipe_split_on) {
+		if (pipe_split_on || odm_combine_on) {
 			if (pos_cpy.x >= viewport_width + viewport_x) {
 				pos_cpy.x = 2 * viewport_width
 						- pos_cpy.x + 2 * viewport_x;
@@ -3399,7 +3441,17 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		} else {
 			pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
 		}
-		pos_cpy.y = pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.y;
+
+		/**
+		 * Display groups that are 1xnY, have pos_cpy.y > viewport.height
+		 * Calculation:
+		 *   delta_from_bottom = viewport.y + viewport.height - pos_cpy.y
+		 *   pos_cpy.y_new = viewport.y + delta_from_bottom
+		 * Simplify it as:
+		 *   pos_cpy.y = viewport.y * 2 + viewport.height - pos_cpy.y
+		 */
+		pos_cpy.y = (2 * pipe_ctx->plane_res.scl_data.viewport.y) +
+			pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.y;
 	}
 
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
