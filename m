Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19592C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3C310EAE4;
	Thu, 20 Jun 2024 16:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtgPfY7i";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C6610EAE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUHfZSS5zynzOjXA28uXHVDT8X0Iys2PHXuq5c+tbE+ZMcBBxc3DMaQT8F/OJNKXN/0JU5iFy7GMOHrLyr0ZQB9pf5/Ns4qbBU6b79RAdK4sgz7KQh4g7IXo1Udj7nXK+XNQkjK9aVcccAnr2ySVKqpXS8qe9MMrCwZdARVWntlsGB7AJiM9D4EjZtLLQUEKwXDF46mgpaSLD8udhIr7/ekOvA7EzaRWF86b5uWzuaoJz5AjgFktjusxHeNx3SYshgXoFAfR8piy2x1jHqzvNgc5DzrB7ThRSEI6QBMmk5WLDeuq2CsFrb2n9n81CY8FrnAgl8yFwB3l/jw595LnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy1LFGDUHHd4VVhdgYtr7lTNTmp2/sgRolngLGnai18=;
 b=nQBMtLgJK2v4gl/GeEO4KcaCAoYIKL0PSVjO5FijhVQsVjuOEuDuYhC/bsBwYHW/FV18BB+EVkw+sL0zO1hG1Wc3ieOFv1LiEvQ6ZYHEIPdNmzmI69DrMnR143SoQjSGaPXWfdjwNH9RU8NCEoGqDjH/Nclwpb7/518qjvFKXL6BZX96SQQg+CU/28Z2EVeEzW6ZY8btEoOFKe8+o71+2P7fZipWX9aBbO7hSMbODmdFU23fEhzqQlF+22Z4Hsv5uA/DBRtVL8+1SAvznClGXrT4pY8rcNBBUGuLBMolxYSDsTi2BMWiGZsegf5vdL9IAz0HvzVnZkYTEMUEPQKkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy1LFGDUHHd4VVhdgYtr7lTNTmp2/sgRolngLGnai18=;
 b=VtgPfY7i3lg2ZEAx5DlMYcI6B2PVG8CPI5/YhQf//FSvOc+jq13CAZAb5iSUi/wvvPxkJ2Pyt7pR3qq2W01DHCuGbDHkrm+XdxIehUu79vMnpKyz7sFBoJWvwknmhqe3X7ndkb3lUfOI2xG2HOUZF5YGk8eXS/VNFPBHWUJBdpQ=
Received: from PH7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:510:339::9)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:13:17 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::93) by PH7PR03CA0007.outlook.office365.com
 (2603:10b6:510:339::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:13:16 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:13:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/39] drm/amd/display: Fix cursor issues with ODMs and HW
 rotations
Date: Thu, 20 Jun 2024 10:11:11 -0600
Message-ID: <20240620161145.2489774-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 8983487a-fc5d-47c7-5b20-08dc9143e502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b2KrCFpEp8Ys9rFG6lqfhdmxYiy+fSotUEIG0agQFVJLLj7+A425UsChAdzZ?=
 =?us-ascii?Q?AgxMfCo1TiQmhJcty7GZrA5W/f4ZNuJicUc9u7Q44QidSv1mX8CZw8e6CtFW?=
 =?us-ascii?Q?y9WZLPx5DHkkujQ0eRI+DbKO/zZb3VKsRq9Xd5n7F0u5S1k+brLbbeHRMTzH?=
 =?us-ascii?Q?2O975/NLO9MOpej19/Bdn+RUphR6EnhnG23iQxVtBVDJijsHdLALomFCZQEr?=
 =?us-ascii?Q?MzUHB7AKAV1gLWo50wNAEPgIRKh6fxWotupK4W6PcBj8mlHwVp7HFoyG8xaT?=
 =?us-ascii?Q?4UfchfX5HiAfAEhOVka/lLA7QsRmup2fRCJD3XFFzSvVUPbPF0y53LAni4R9?=
 =?us-ascii?Q?2rBfv5CPqm8tmvVaRLWGdR+Rg00o8OjonHLw47lzgjQd+f1QVh7JcQznJpNA?=
 =?us-ascii?Q?udqgX0GzcQngvDIFv+d2DHTYh+t9grP/igEm208uQcVXVCT9GyTwcNPn/t+i?=
 =?us-ascii?Q?4CVn2WFnbl8L8omapiXHeHW4J5grRs8NZMLgH3fYWaWcrKRbtWM+m/PvmW24?=
 =?us-ascii?Q?p4Y2GsZ57/saXrO46qwiBbxpA3AfotEwiyfcEm4KDEe347IFfMmUW3kIVHav?=
 =?us-ascii?Q?J8UvmwDtltltkpCbt/N2GHyhZsrR+81GrxeR018Fxggx2JrQZKzzgOMGkFeD?=
 =?us-ascii?Q?jR53TYgR0LfRPVcTOGWFdJOlAdRtnbvehlBbfUSpmCi+SHAH5SAn+PmkVljg?=
 =?us-ascii?Q?QVxw7Pz5rMvW/w/35vtksaR1BRf6EfCKNPdEe1SXwtzMXaVjBMZFY45hjvuQ?=
 =?us-ascii?Q?miVdXMMzqUUYNC7DH/kUdF7xl/cRRFzYj9jkhIVyB4UX/BQRr2khO3xYbi0M?=
 =?us-ascii?Q?AvKXsIKCHV8eqshR/m+a+8ihpEADsZSVNks7ms5+D6TMr9t8a3nqgHUQ5T7R?=
 =?us-ascii?Q?02/YzUWLsFLQZRi4lgHT4TXeCArww6ti/pbX2iMz4XxBg1+wHRUF2DE18Jeu?=
 =?us-ascii?Q?N18m/2pkpoxTMv2XGsEwFs7n6QfjoZLS3g6iPEL+v2YFMxCctR3A9Crkm3en?=
 =?us-ascii?Q?RH3QX7kGgARqa8YW/vfQp/o7VkyinAGAfh+KVplpqE82lLDRLYsJpq31TglI?=
 =?us-ascii?Q?KyDQgK7EUKcpnoJY4g3xn0BKkt4JEtO1xrz6b9XT0wysIrq4L45wxIRuOtoy?=
 =?us-ascii?Q?oPCRQSzLbSZ37csV69aop2QE1Mu8NjA7w6o5LZ7K3amMf/4Ygvtf4zBIlSMX?=
 =?us-ascii?Q?X1npyfebUdjHNSMK7PYqZIUpSpc1CMifZ58La1OfYCpLtAr/x1sSZ1opRa3i?=
 =?us-ascii?Q?5VsyRhJpZYxDzd21vbElz8dWrHGiS3o5HbTRTGDNTjmpczSDUj0Xijm7kdvI?=
 =?us-ascii?Q?hSRXj/H4CrdPJfwa0N0A7yx5pTQ9jy07/Koqz1QVy9TLORviraVC0Z/vaU0l?=
 =?us-ascii?Q?dwZy9YgnVFQloR5osXkYTcQf8TaSY7GUtQq911sfqUCoZvdTqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:13:16.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8983487a-fc5d-47c7-5b20-08dc9143e502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

[WHY & HOW]
Current code for cursor positions does not work properly
with different ODM options and HW rotations like ODM
2to1, 3to1 and 4to1, and has different issues depending on
angle of HW rotations.

[HOW]
Fixed these issues so to work properly when ODM is used with HW rotations.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  50 -------
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  38 -----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 135 +++---------------
 3 files changed, 19 insertions(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index aef73bd1221a..d0f8c9ff5232 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -153,58 +153,8 @@ void dpp401_set_cursor_position(
 	uint32_t height)
 {
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
-	int x_pos = pos->x - param->recout.x;
-	int y_pos = pos->y - param->recout.y;
-	int x_hotspot = pos->x_hotspot;
-	int y_hotspot = pos->y_hotspot;
-	int rec_x_offset = x_pos - pos->x_hotspot;
-	int rec_y_offset = y_pos - pos->y_hotspot;
-	int cursor_height = (int)height;
-	int cursor_width = (int)width;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
-	// Transform cursor width / height and hotspots for offset calculations
-	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
-		swap(cursor_height, cursor_width);
-		swap(x_hotspot, y_hotspot);
-
-		if (param->rotation == ROTATION_ANGLE_90) {
-			// hotspot = (-y, x)
-			rec_x_offset = x_pos - (cursor_width - x_hotspot);
-			rec_y_offset = y_pos - y_hotspot;
-		} else if (param->rotation == ROTATION_ANGLE_270) {
-			// hotspot = (y, -x)
-			rec_x_offset = x_pos - x_hotspot;
-			rec_y_offset = y_pos - (cursor_height - y_hotspot);
-		}
-	} else if (param->rotation == ROTATION_ANGLE_180) {
-		// hotspot = (-x, -y)
-		if (!param->mirror)
-			rec_x_offset = x_pos - (cursor_width - x_hotspot);
-
-		rec_y_offset = y_pos - (cursor_height - y_hotspot);
-	}
-
-	if (param->rotation == ROTATION_ANGLE_0 && !param->mirror) {
-		if (rec_x_offset >= (int)param->recout.width)
-			cur_en = 0;  /* not visible beyond right edge*/
-
-		if (rec_y_offset >= (int)param->recout.height)
-			cur_en = 0;  /* not visible beyond bottom edge*/
-	} else {
-		if (rec_x_offset > (int)param->recout.width)
-			cur_en = 0;  /* not visible beyond right edge*/
-
-		if (rec_y_offset > (int)param->recout.height)
-			cur_en = 0;  /* not visible beyond bottom edge*/
-	}
-
-	if (rec_x_offset + cursor_width <= 0)
-		cur_en = 0;  /* not visible beyond left edge*/
-
-	if (rec_y_offset + cursor_height <= 0)
-		cur_en = 0;  /* not visible beyond top edge*/
-
 	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 
 	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 6692d57d5cce..a893160ae775 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -654,12 +654,8 @@ void hubp401_cursor_set_position(
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	int x_pos = pos->x - param->recout.x;
 	int y_pos = pos->y - param->recout.y;
-	int x_hotspot = pos->x_hotspot;
-	int y_hotspot = pos->y_hotspot;
 	int rec_x_offset = x_pos - pos->x_hotspot;
 	int rec_y_offset = y_pos - pos->y_hotspot;
-	int cursor_height = (int)hubp->curs_attr.height;
-	int cursor_width = (int)hubp->curs_attr.width;
 	uint32_t dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
@@ -672,28 +668,6 @@ void hubp401_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	// Transform cursor width / height and hotspots for offset calculations
-	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
-		swap(cursor_height, cursor_width);
-		swap(x_hotspot, y_hotspot);
-
-		if (param->rotation == ROTATION_ANGLE_90) {
-			// hotspot = (-y, x)
-			rec_x_offset = x_pos - (cursor_width - x_hotspot);
-			rec_y_offset = y_pos - y_hotspot;
-		} else if (param->rotation == ROTATION_ANGLE_270) {
-			// hotspot = (y, -x)
-			rec_x_offset = x_pos - x_hotspot;
-			rec_y_offset = y_pos - (cursor_height - y_hotspot);
-		}
-	} else if (param->rotation == ROTATION_ANGLE_180) {
-		// hotspot = (-x, -y)
-		if (!param->mirror)
-			rec_x_offset = x_pos - (cursor_width - x_hotspot);
-
-		rec_y_offset = y_pos - (cursor_height - y_hotspot);
-	}
-
 	dst_x_offset = (rec_x_offset >= 0) ? rec_x_offset : 0;
 	dst_x_offset *= param->ref_clk_khz;
 	dst_x_offset /= param->pixel_clk_khz;
@@ -705,18 +679,6 @@ void hubp401_cursor_set_position(
 			dc_fixpt_from_int(dst_x_offset),
 			param->h_scale_ratio));
 
-	if (rec_x_offset >= (int)param->recout.width)
-		cur_en = 0;  /* not visible beyond right edge*/
-
-	if (rec_x_offset + cursor_width <= 0)
-		cur_en = 0;  /* not visible beyond left edge*/
-
-	if (rec_y_offset >= (int)param->recout.height)
-		cur_en = 0;  /* not visible beyond bottom edge*/
-
-	if (rec_y_offset + cursor_height <= 0)
-		cur_en = 0;  /* not visible beyond top edge*/
-
 	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
 		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 7a456618f313..8d0da56e4cc5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1099,31 +1099,21 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
 		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
 		.rotation = pipe_ctx->plane_state->rotation,
-		.mirror = pipe_ctx->plane_state->horizontal_mirror
+		.mirror = pipe_ctx->plane_state->horizontal_mirror,
+		.stream = pipe_ctx->stream
 	};
-	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
 		(pipe_ctx->prev_odm_pipe != NULL);
 	int prev_odm_width = 0;
 	int prev_odm_offset = 0;
-	int next_odm_width = 0;
-	int next_odm_offset = 0;
-	struct pipe_ctx *next_odm_pipe = NULL;
 	struct pipe_ctx *prev_odm_pipe = NULL;
 
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
+	int recout_x_pos = 0;
+	int recout_y_pos = 0;
 
-	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
-		if ((pipe_ctx->plane_state->src_rect.width != pipe_ctx->plane_res.scl_data.viewport.width) ||
-			(pipe_ctx->plane_state->src_rect.height != pipe_ctx->plane_res.scl_data.viewport.height)) {
-			pipe_split_on = true;
-		}
-	}
-
-
-	/**
-	 * DCN4 moved cursor composition after Scaler, so in HW it is in
+	/* DCN4 moved cursor composition after Scaler, so in HW it is in
 	 * recout space and for HW Cursor position programming need to
 	 * translate to recout space.
 	 *
@@ -1148,8 +1138,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
 		pipe_ctx->stream->src.height;
 
-	/**
-	 * If the cursor's source viewport is clipped then we need to
+	/* If the cursor's source viewport is clipped then we need to
 	 * translate the cursor to appear in the correct position on
 	 * the screen.
 	 *
@@ -1169,38 +1158,15 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 * next/prev_odm_offset is to account for scaled modes that have underscan
 	 */
 	if (odm_combine_on) {
-		next_odm_pipe = pipe_ctx->next_odm_pipe;
 		prev_odm_pipe = pipe_ctx->prev_odm_pipe;
 
-		while (next_odm_pipe != NULL) {
-			next_odm_width += next_odm_pipe->plane_res.scl_data.recout.width;
-			next_odm_offset += next_odm_pipe->plane_res.scl_data.recout.x;
-			next_odm_pipe = next_odm_pipe->next_odm_pipe;
-		}
 		while (prev_odm_pipe != NULL) {
 			prev_odm_width += prev_odm_pipe->plane_res.scl_data.recout.width;
 			prev_odm_offset += prev_odm_pipe->plane_res.scl_data.recout.x;
 			prev_odm_pipe = prev_odm_pipe->prev_odm_pipe;
 		}
 
-		if (param.rotation == ROTATION_ANGLE_0) {
-			x_pos -= (prev_odm_width + prev_odm_offset);
-		}
-	}
-
-	/**
-	 * If the position is negative then we need to add to the hotspot
-	 * to shift the cursor outside the plane.
-	 */
-
-	if (x_pos < 0) {
-		pos_cpy.x_hotspot -= x_pos;
-		x_pos = 0;
-	}
-
-	if (y_pos < 0) {
-		pos_cpy.y_hotspot -= y_pos;
-		y_pos = 0;
+		x_pos -= (prev_odm_width + prev_odm_offset);
 	}
 
 	pos_cpy.x = (uint32_t)x_pos;
@@ -1209,86 +1175,23 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	if (pos_cpy.enable && dcn401_can_pipe_disable_cursor(pipe_ctx))
 		pos_cpy.enable = false;
 
-	if (param.rotation == ROTATION_ANGLE_270) {
-		// Swap axis and mirror vertically
-		uint32_t temp_x = pos_cpy.x;
+	x_pos = pos_cpy.x - param.recout.x;
+	y_pos = pos_cpy.y - param.recout.y;
 
-		int recout_height =
-			pipe_ctx->plane_res.scl_data.recout.height;
-		int recout_y =
-			pipe_ctx->plane_res.scl_data.recout.y;
+	recout_x_pos = x_pos - pos_cpy.x_hotspot;
+	recout_y_pos = y_pos - pos_cpy.y_hotspot;
 
-		/**
-		 * Display groups that are 1xnY, have pos_cpy.x > 2 * recout.height
-		 * For pipe split cases:
-		 * - apply offset of recout.y to normalize pos_cpy.x
-		 * - calculate the pos_cpy.y as before
-		 * - shift pos_cpy.y back by same offset to get final value
-		 * - since we iterate through both pipes, use the lower
-		 *   recout.y for offset
-		 * For non pipe split cases, use the same calculation for
-		 *  pos_cpy.y as the 180 degree rotation case below,
-		 *  but use pos_cpy.x as our input because we are rotating
-		 *  270 degrees
-		 */
-		if (pipe_split_on || odm_combine_on) {
-			int pos_cpy_x_offset;
-			int other_pipe_recout_y;
-
-			if (pipe_split_on) {
-				if (pipe_ctx->bottom_pipe) {
-					other_pipe_recout_y =
-						pipe_ctx->bottom_pipe->plane_res.scl_data.recout.y;
-				} else {
-					other_pipe_recout_y =
-						pipe_ctx->top_pipe->plane_res.scl_data.recout.y;
-				}
-				pos_cpy_x_offset = (recout_y > other_pipe_recout_y) ?
-					other_pipe_recout_y : recout_y;
-				pos_cpy.x -= pos_cpy_x_offset;
-				if (pos_cpy.x > recout_height) {
-					pos_cpy.x = pos_cpy.x - recout_height;
-					pos_cpy.y = recout_height - pos_cpy.x;
-				} else {
-					pos_cpy.y = 2 * recout_height - pos_cpy.x;
-				}
-				pos_cpy.y += pos_cpy_x_offset;
+	if (recout_x_pos >= (int)param.recout.width)
+		pos_cpy.enable = false;  /* not visible beyond right edge*/
 
-			} else {
-				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width + next_odm_width + next_odm_offset - pos_cpy.y;
-				pos_cpy.y = temp_x;
-			}
-		}
-	} else if (param.rotation == ROTATION_ANGLE_180) {
-		// Mirror horizontally and vertically
-		int recout_width =
-			pipe_ctx->plane_res.scl_data.recout.width;
-		int recout_x =
-			pipe_ctx->plane_res.scl_data.recout.x;
-
-		if (!param.mirror) {
-			if (odm_combine_on) {
-				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width + next_odm_width - pos_cpy.x;
-			} else if (pipe_split_on) {
-				if (pos_cpy.x >= recout_width + recout_x) {
-					pos_cpy.x = 2 * recout_width
-						- pos_cpy.x + 2 * recout_x;
-				} else {
-					uint32_t temp_x = pos_cpy.x;
-
-					pos_cpy.x = 2 * recout_x - pos_cpy.x;
-					if (temp_x >= recout_x +
-						(int)hubp->curs_attr.width || pos_cpy.x
-						<= (int)hubp->curs_attr.width +
-						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = temp_x + recout_width;
-					}
-				}
-			}
+	if (recout_y_pos >= (int)param.recout.height)
+		pos_cpy.enable = false;  /* not visible beyond bottom edge*/
 
-		}
+	if (recout_x_pos + (int)hubp->curs_attr.width <= 0)
+		pos_cpy.enable = false;  /* not visible beyond left edge*/
 
-	}
+	if (recout_y_pos + (int)hubp->curs_attr.height <= 0)
+		pos_cpy.enable = false;  /* not visible beyond top edge*/
 
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
 	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
-- 
2.34.1

