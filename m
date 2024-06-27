Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF060C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B44A10EB5A;
	Thu, 27 Jun 2024 21:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/Fxqm6j";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8474110EB5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3vGvxwf6ZKhdTdCTol9tEo+4WTTv9N0nH0FFTpRl7H8brOi+D08rKgrGoZd4g+X4Si0+uSEtOd6KWet7EA38dDP0BEtYbOQiDWScS8PscFrg6RbztTMLYaQqNNXzySPOwyT0jQ1EY7hqlrZ0pUvtvmg8sehgo+TnwKhbJ/vMG80hCP1XJzavgiRd2hfGhJZ4rRWd5sguFWlzk6hF7n6iKIYhpkr6fC3Qe1NtySj95Xg+AiZenq3eNNiySy4BZn7TiptJHRFOe35eYsmjF129UsltZpfISBEIOcvG8mLj3L5+VRv5MY2lHf12rIGDMvuAvJhSlmX4h4FfA4s2YeBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8JF4B+fDoZ3bEsXeGZg6kYYlLTt5L/Qe5vCTUc8DRE=;
 b=aKkl/orWdsuo2P85gMUVLSXDH8iW4via61erG9nWGIPz+KoLILxyiiG29ren05TGh5Jf/SwLjZ4C0+Drv5YPC7FDGG4ar4Gre9abnf/IOk5AZZuHZStJMGo+CTvE4pNLXeo5gMNHPVQEfprpLt+HygFuilfjQtJ71ej3E/lfDOI43HYjw+bq6p295CS5hmGNu53lskOVexYcJntRKTFy0JtAI7yjFkRom0Mty+K1JIwMOI65ojwAS2r4bIPIVTHYoS85XmKl0qOfUMEpq4uQJV/YzNCW3D+uaq1ZNxXgtJdiuTr+pwIir0pRbrcCokgqxUHrfQCQh9SttVoGTGogmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8JF4B+fDoZ3bEsXeGZg6kYYlLTt5L/Qe5vCTUc8DRE=;
 b=a/Fxqm6jE9oHRgBQ1axN1MzHwC2XPma1xxie82zxXS9nHVdGkIsqaMGOojDHpEXr56lXRSyjSML+LN02oFSZFqQBHCU+xJDuIkedOB3zPRiyh+Y6pm1nwVaYaNfyg3ZO3CAiPLlZeTadKgCidYC4+F2G0nmz9gztC1EICTLdK3g=
Received: from PH7PR13CA0020.namprd13.prod.outlook.com (2603:10b6:510:174::27)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 21:14:10 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::67) by PH7PR13CA0020.outlook.office365.com
 (2603:10b6:510:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:08 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:08 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>
Subject: [PATCH 10/26] drm/amd/display: Adjust cursor visibility between MPC
 slices
Date: Thu, 27 Jun 2024 17:13:13 -0400
Message-ID: <20240627211329.26386-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 35319899-12ec-4f34-9a2c-08dc96ee16ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L1fArTPi9DJdO+m2M1wbmIcnz2n9gIdGM9eKhFvfhhO2viYcaq0jw0FnrDK9?=
 =?us-ascii?Q?bi3PTVn1+WDYSlMy2BHgj78h4CEtCHOLXHE4gKDGHRxgPQd/K+hPUEEcZQEU?=
 =?us-ascii?Q?GbH2MH7a1yj7IFaLGeHMIQi3ry96OHsOzQiQQo2W/IL+zkJs5vAxSUxq8ylq?=
 =?us-ascii?Q?K5eZWQ9H/Goq2I0ibux7oVDMOiM0D1vhIxDRa372Y3laRxE5uOn+lh+W2jEZ?=
 =?us-ascii?Q?Wfivvc/xUs8T8ZpvIWrQANPeY6e0LkCMYSTYralUAp2EcrV+XFEnDbNmSy1f?=
 =?us-ascii?Q?aG+Ua9qHv1kKugCwyDlvlWQO+GIA8BzhKMkJ/dcuojkAFGPtJYigtPj8cSOp?=
 =?us-ascii?Q?Gg7xDyHxE5YaPm7tVSyBj+w8P6iP0/BQ8CEVOFtRJgUsM2cM8iwL3ifsmI9W?=
 =?us-ascii?Q?1zf0flc1BngDAzJpVb8V1ObomW5sk/nrTd/4Z8OKHx6yIneqEJwOQbsfPF0d?=
 =?us-ascii?Q?bLt8wPbcrJbsIGTj61l7e69zvr/785fO2PiJ8Ssjt6RfI08H9cVySKmAQfdh?=
 =?us-ascii?Q?45xdYs4u1bT4/9R7LwpDNub7BTh18FWaWtpWU1JB/XA+PLGimHpj8EOElSe+?=
 =?us-ascii?Q?Bn0l1LLoGXC93Xu48fy8hXymi5QuscjhdnHqQdhZwg5bUae6MbQyo2w2OyZJ?=
 =?us-ascii?Q?RNyPNY6C7Som1NxPbmoY8SGNf8zKs5xt5g9IunHGDDGbgUi5b1mKZhM1Fsm7?=
 =?us-ascii?Q?Bl2aM+uv0zHJsjKub6P+tfkMiTO7sDbU6gEeHlIigAU6Qyzj+gBZWjBgA/1b?=
 =?us-ascii?Q?RgCFfjsPGwRxzfBYAbYaP/ij0vJXGmzDVgFZHxYmLsq3vutz588AaFWEV58G?=
 =?us-ascii?Q?2sJK0hKNKi6AkFtl/HGRH3iPecp23hmaOfX1v+o3EnQohIRUmNNmCQm2VLJW?=
 =?us-ascii?Q?mEKZimJhpFwKZpjPi/qWHVSbUO3MzMUXHBlpfGHFMzbDM2jq8I61c6eYu2MW?=
 =?us-ascii?Q?pgTgKkddTbook6xgkFI7aQ5JaihttE1dp0RA4qtJmNZYoee3O9xBlmesPHOZ?=
 =?us-ascii?Q?Ub3co0dnOtw/cjFhKkSBzjhSGJDqCd91APSKqMIJmu9m8j6VIQi75pLHJHlk?=
 =?us-ascii?Q?YAqQnf6RcQv9+yrpyhvj57jLGF6vs9tcu2ZZmW1Zz8le3vYDYRwhFlTfEx78?=
 =?us-ascii?Q?Fhze1AN0E7/yYYu/H1wRF/jJicQXUyZRTu3REULByFQ5BfORdrCy363CPb4A?=
 =?us-ascii?Q?14s2e8tTiVq5rjg3QVqnNxV3+4cxYbK2fPrKsys+7miMrnZOB9KXQ6Yig7dQ?=
 =?us-ascii?Q?kUqRrk9KN7tKix4orvRXQrYv3Uh2b5D+f2FCrxPVGOd1874vS+97FM4u2DSh?=
 =?us-ascii?Q?4zMmmlkwmJSj8A9BoUa3rUn9QdC61XQIuToEq/tnRCPwKcPJKp8Vyki9Vdje?=
 =?us-ascii?Q?Bbs8L2fwCrt91jQPokZ2a9zrZBhTFI5ztzuVsJBdsrfmRzPxOVb0l86aI8Ny?=
 =?us-ascii?Q?23zq7X3PVno+BTgRHFraeluhXxz3RUXH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:10.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35319899-12ec-4f34-9a2c-08dc96ee16ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

From: Nevenko Stupar <nevenko.stupar@amd.com>

[Why & How]
When MPC enabled, need to adjust x and hot spot x
position on one pipe when the cursor is between
MPC slices i.e. when the cursor is moving from one
MPC slice to next slice, while whole cursor size is not
contained within one pipe, to make part of the cursor
to be visible on the other pipe.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 47 +++++++++++++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  1 +
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 11570ef06086..2c50c0f745a0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1088,6 +1088,17 @@ static bool dcn401_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
+void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy)
+{
+	if (cursor_width <= 128) {
+		pos_cpy->x_hotspot /= 2;
+		pos_cpy->x_hotspot += 1;
+	} else {
+		pos_cpy->x_hotspot /= 2;
+		pos_cpy->x_hotspot += 2;
+	}
+}
+
 void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
@@ -1109,12 +1120,21 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int prev_odm_width = 0;
 	int prev_odm_offset = 0;
 	struct pipe_ctx *prev_odm_pipe = NULL;
+	bool mpc_combine_on = false;
+	int  bottom_pipe_x_pos = 0;
 
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
 	int recout_x_pos = 0;
 	int recout_y_pos = 0;
 
+	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
+		if ((pipe_ctx->plane_state->src_rect.width != pipe_ctx->plane_res.scl_data.viewport.width) ||
+			(pipe_ctx->plane_state->src_rect.height != pipe_ctx->plane_res.scl_data.viewport.height)) {
+			mpc_combine_on = true;
+		}
+	}
+
 	/* DCN4 moved cursor composition after Scaler, so in HW it is in
 	 * recout space and for HW Cursor position programming need to
 	 * translate to recout space.
@@ -1177,15 +1197,8 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 
 	if (x_pos < 0) {
 		pos_cpy.x_hotspot -= x_pos;
-		if ((odm_combine_on) && (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)) {
-			if (hubp->curs_attr.width <= 128) {
-				pos_cpy.x_hotspot /= 2;
-				pos_cpy.x_hotspot += 1;
-			} else {
-				pos_cpy.x_hotspot /= 2;
-				pos_cpy.x_hotspot += 2;
-			}
-		}
+		if (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)
+			adjust_hotspot_between_slices_for_2x_magnify(hubp->curs_attr.width, &pos_cpy);
 		x_pos = 0;
 	}
 
@@ -1194,6 +1207,22 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		y_pos = 0;
 	}
 
+	/* If the position on bottom MPC pipe is negative then we need to add to the hotspot and
+	 * adjust x_pos on bottom pipe to make cursor visible when crossing between MPC slices.
+	 */
+	if (mpc_combine_on &&
+		pipe_ctx->top_pipe &&
+		(pipe_ctx == pipe_ctx->top_pipe->bottom_pipe)) {
+
+		bottom_pipe_x_pos = x_pos - pipe_ctx->plane_res.scl_data.recout.x;
+		if (bottom_pipe_x_pos < 0) {
+			x_pos = pipe_ctx->plane_res.scl_data.recout.x;
+			pos_cpy.x_hotspot -= bottom_pipe_x_pos;
+			if (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)
+				adjust_hotspot_between_slices_for_2x_magnify(hubp->curs_attr.width, &pos_cpy);
+		}
+	}
+
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index c1d4287d5a0d..8e9c1c17aa66 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -80,4 +80,5 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *l
 void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		struct pipe_ctx *otg_master);
+void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy);
 #endif /* __DC_HWSS_DCN401_H__ */
-- 
2.34.1

