Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E71ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB68110EB9E;
	Sat, 27 Aug 2022 02:53:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA50610EB95
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFdRKWJzzZ0NDL5MbL2eOHFaxiJ5isaXBCanY5lTgE6/Hk0WWOPHNtXLY9Vkc8uW6AHZ2xAn0FT0b/cpSyjZ7KqMocYf4GNnpx0cl0S7pTrWqGRnCKMY+u+lvVXow67dxjGd/xphWvXxjNzdHHBFreIAH/Ucr2gOfjYE7rqaZkRvf9U1wqKOuoaj9HYgH9xTXEVR6seqMS8oHjgJnYs0z8aEWRb3SJHFkYa195TM52H9+79ZC9FGeeLBpLP4VsS8TDY0DRupY0X6c8bh0OzmfZ2JV+wwzBu7quQXhfQCYvCIUZV2Y0EhGTs/L2VuBph0eUEtwePshQK6tN5LChochQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZanMNk8Pq6opES8g2UAF/SPuoExlnDSyBpZKYTNeRQ=;
 b=dPjpCw5apv6KMcvwZUw/81PQSvdg0wNVVuUz1Mdm9mbzjI2/KWjRUZeaXj08mMOGvDgLCGNVqJcS/aMn0Ed8O8P5QlQzo7UNWkW6M6ZxCO5gAnil7ZIfys2sIlpvv3mvN9fZNMwRf1/s5lbxQUk8rCyRqlpXUDQUqxI2s/dSvW0776IK+vWi4moFOj2r4O+Thmm583dglpjfXXlOKY3u8vFaGvonJe3MYCWjrCYXx4+8IW0ljQmI3OJTX5bdHZBz5dpcQGKa2ua4QlsOOWfur/SALHlfrsKvzQNJwMXXHFOn4s3XEvuYieAQyPogLds8gd4b4c7QSJ2pImSbOz3zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZanMNk8Pq6opES8g2UAF/SPuoExlnDSyBpZKYTNeRQ=;
 b=BaDOhtJyBHZfBDYJLOiV2afZ4ceBuBeJBqOwC3c1NKDbicXJlb1+39Al60kbpO5aMNw2MrVVwq5HhYEli13uVCBx2hNmXootFx9YXxjoQfcnIEVAI7aM4VbGzHLz8EpLEnA1YuUPPsBpDwL0F/OT5iiPcXFtK9rQtEzoRpuLv84=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:53:07 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::36) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.5 via Frontend
 Transport; Sat, 27 Aug 2022 02:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:53:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:53:06 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:53:03
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: Correct cursor position on horizontal
 mirror
Date: Sat, 27 Aug 2022 06:50:53 +0800
Message-ID: <20220826225053.1435588-34-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 874253a2-000f-4069-c003-08da87d74552
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HK6TClfPtT0TM6JlyAACvep4P3B703St4GguO9J9lfH+N43Jf7a6b93b7rwzkh8R5Az7EPy9F0xPtjsBcotkb4jm0bFkcIOnDO/7no8E/pQCOh8IMiI3RFAIHv9+4W4F79BH56Llp5MyP86UR0kHPLx+ngoyBrelC+PBUHRmsZEfViSB7PbwhGxP0eTll7qqYEY0UVxzwqtv5VqAGNKpi1DqQ14AC8AvwygOgu2R05mP9tnt3GW0nt313WZS1rfy9eUzEboEnzobhMMGm568n2zA+nslgdtW4TZzEjkpR9ptUuCAhrXsugDgGxXuUVtLo/44gtKvnHGrMq7qH20e9yq6h5IYQTE92Fx3RPXdKu1aSAfAarVFVg6TlbESdTsVU7iarUDi1IRhyyyPfWEWc8gybiK/16CaiCUGmdxToORlkH05dXbMJhwbN4xxI7IPbL+pPYQpZfuDpAhYCXukB92GorLpVS08f48vigURqr6xGHKWFuHmrNGSIcIdl1sRhxzA1wI/1IwJ2CNCpBi/XZC0erDRl34DWIH2CWU5KUhuzyuJoFnBPLsAaySDkIjTsuw0HUhpotjzOZ18jty6LGLK4pQM5LqE7qKD7PetV1iOnauUuz21b8sZhV6/HwbavttGWsUvTjGsto/IB3ZFN6WTYTBoplU27yKDjL4tSa+FgtxFG7ThHfMbim2K0ppMw2DFeI4OtZXFmsYcWfSEvSe+75jYZ5tZrpIzaCzrxnGWDMnyqnsgfaQoCxlkWmwL+FqJkNQ+aih0nApaTLZzW9HJZjTZna03ok5gzsj6FfCIxYsveRaU01kwUQX3MFr4BHt32gKYCjy+kLO4LAmbeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(8936002)(36860700001)(2906002)(82310400005)(83380400001)(478600001)(2616005)(5660300002)(36756003)(70206006)(54906003)(316002)(6666004)(336012)(426003)(70586007)(7696005)(8676002)(6916009)(40480700001)(86362001)(40460700003)(82740400003)(1076003)(356005)(47076005)(186003)(41300700001)(26005)(81166007)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:53:07.6178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874253a2-000f-4069-c003-08da87d74552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <Eric.Bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Incorrect cursor position will induce system hang on pipe split.

[How]
1.Handle horizontal mirror on rotation,
2.Correct cursor set on piep split.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  9 +--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 72 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  9 +--
 4 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index db7ca4b0cdb9..897f412f539e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -448,11 +448,12 @@ void dpp1_set_cursor_position(
 			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
-		src_x_offset = pos->x - param->viewport.x;
+		if (!param->mirror)
+			src_x_offset = pos->x - param->viewport.x;
+
 		src_y_offset = pos->y - param->viewport.y;
 	}
 
-
 	if (src_x_offset >= (int)param->viewport.width)
 		cur_en = 0;  /* not visible beyond right edge*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 564e061ccb58..52e201e9b091 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1208,13 +1208,10 @@ void hubp1_cursor_set_position(
 			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
-		src_x_offset = pos->x - param->viewport.x;
-		src_y_offset = pos->y - param->viewport.y;
-	}
+		if (!param->mirror)
+			src_x_offset = pos->x - param->viewport.x;
 
-	if (param->mirror) {
-		x_hotspot = param->viewport.width - x_hotspot;
-		src_x_offset = param->viewport.x + param->viewport.width - src_x_offset;
+		src_y_offset = pos->y - param->viewport.y;
 	}
 
 	dst_x_offset = (src_x_offset >= 0) ? src_x_offset : 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d3f6a2609c8c..b92c14b9043f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3470,8 +3470,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.rotation = pipe_ctx->plane_state->rotation,
 		.mirror = pipe_ctx->plane_state->horizontal_mirror
 	};
-	bool pipe_split_on = (pipe_ctx->top_pipe != NULL) ||
-		(pipe_ctx->bottom_pipe != NULL);
+	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
 		(pipe_ctx->prev_odm_pipe != NULL);
 
@@ -3480,6 +3479,13 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
 
+	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
+		if ((pipe_ctx->plane_state->src_rect.width != pipe_ctx->plane_res.scl_data.viewport.width) ||
+			(pipe_ctx->plane_state->src_rect.height != pipe_ctx->plane_res.scl_data.viewport.height)) {
+			pipe_split_on = true;
+		}
+	}
+
 	/**
 	 * DC cursor is stream space, HW cursor is plane space and drawn
 	 * as part of the framebuffer.
@@ -3551,8 +3557,36 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	if (pos_cpy.enable && dcn10_can_pipe_disable_cursor(pipe_ctx))
 		pos_cpy.enable = false;
 
+
+	if (param.rotation == ROTATION_ANGLE_0) {
+		int viewport_width =
+			pipe_ctx->plane_res.scl_data.viewport.width;
+		int viewport_x =
+			pipe_ctx->plane_res.scl_data.viewport.x;
+
+		if (param.mirror) {
+			if (pipe_split_on || odm_combine_on) {
+				if (pos_cpy.x >= viewport_width + viewport_x) {
+					pos_cpy.x = 2 * viewport_width
+							- pos_cpy.x + 2 * viewport_x;
+				} else {
+					uint32_t temp_x = pos_cpy.x;
+
+					pos_cpy.x = 2 * viewport_x - pos_cpy.x;
+					if (temp_x >= viewport_x +
+						(int)hubp->curs_attr.width || pos_cpy.x
+						<= (int)hubp->curs_attr.width +
+						pipe_ctx->plane_state->src_rect.x) {
+						pos_cpy.x = temp_x + viewport_width;
+					}
+				}
+			} else {
+				pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
+			}
+		}
+	}
 	// Swap axis and mirror horizontally
-	if (param.rotation == ROTATION_ANGLE_90) {
+	else if (param.rotation == ROTATION_ANGLE_90) {
 		uint32_t temp_x = pos_cpy.x;
 
 		pos_cpy.x = pipe_ctx->plane_res.scl_data.viewport.width -
@@ -3623,23 +3657,25 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		int viewport_x =
 			pipe_ctx->plane_res.scl_data.viewport.x;
 
-		if (pipe_split_on || odm_combine_on) {
-			if (pos_cpy.x >= viewport_width + viewport_x) {
-				pos_cpy.x = 2 * viewport_width
-						- pos_cpy.x + 2 * viewport_x;
-			} else {
-				uint32_t temp_x = pos_cpy.x;
-
-				pos_cpy.x = 2 * viewport_x - pos_cpy.x;
-				if (temp_x >= viewport_x +
-					(int)hubp->curs_attr.width || pos_cpy.x
-					<= (int)hubp->curs_attr.width +
-					pipe_ctx->plane_state->src_rect.x) {
-					pos_cpy.x = temp_x + viewport_width;
+		if (!param.mirror) {
+			if (pipe_split_on || odm_combine_on) {
+				if (pos_cpy.x >= viewport_width + viewport_x) {
+					pos_cpy.x = 2 * viewport_width
+							- pos_cpy.x + 2 * viewport_x;
+				} else {
+					uint32_t temp_x = pos_cpy.x;
+
+					pos_cpy.x = 2 * viewport_x - pos_cpy.x;
+					if (temp_x >= viewport_x +
+						(int)hubp->curs_attr.width || pos_cpy.x
+						<= (int)hubp->curs_attr.width +
+						pipe_ctx->plane_state->src_rect.x) {
+						pos_cpy.x = temp_x + viewport_width;
+					}
 				}
+			} else {
+				pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
 			}
-		} else {
-			pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
 		}
 
 		/**
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 9570c2118ccc..b1ec0e6f7f58 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -987,13 +987,10 @@ void hubp2_cursor_set_position(
 			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
-		src_x_offset = pos->x - param->viewport.x;
-		src_y_offset = pos->y - param->viewport.y;
-	}
+		if (!param->mirror)
+			src_x_offset = pos->x - param->viewport.x;
 
-	if (param->mirror) {
-		x_hotspot = param->viewport.width - x_hotspot;
-		src_x_offset = param->viewport.x + param->viewport.width - src_x_offset;
+		src_y_offset = pos->y - param->viewport.y;
 	}
 
 	dst_x_offset = (src_x_offset >= 0) ? src_x_offset : 0;
-- 
2.25.1

