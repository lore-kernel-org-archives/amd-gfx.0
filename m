Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A528BD767F2
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 18:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B4910E901;
	Thu, 31 Oct 2024 18:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KImu6BRx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B4510E8FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 18:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO5W0DmSu8JXRsKIHOhgVLjGgNkcp9qG94RM1cULJUcoYKVU4mwIZ6B26+NjJCW/X4bujpnAiwgHsWVcQ+msHq8bWHSHGQ6WsQfXHry2d1r29ez5cD+QvhPmDSPBJ37DF2ijwq5cCYesPx2YGhMiT4pRkTQR/ut/FBA7Jr3F43EQToiksPGqM8gbNS7uyEFLgaMw+M7ucLiiuSHq/hPUnGhobxZyh8iAYi30jU9CUAN8cNNzURmFf+okPTzr4piCd3pQoLyi0PpL2wCeDo6MyvHXTDd8PSXzr6vg5o5F26RZzUqybMBEavZEo9hE9Wg7tXWV8HBXW68nPnAhy0qcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2KUvHR1AHU3iYTvGJwlh40VPMpx8PgFKUk2Xkt/Uj0=;
 b=iy72Pw4Pxwb+rRl415icO50Bn9eYpQYtgnb1GXsoFhmXzfSOx0gtbUkmoJsXXldBGAY5J88odIyaRhJ7Bwrty15npPGYl6Ov9P4gfk+/5Awrme++v08gYqIHsQl+MZMIytpHfcKMcVYWHttHA9L65dYMSohp2FVZ+HTP0gjE4QgpnHBj3LsPD2gAK71GPbBAySWx8v3OUZbqQb5JvdWVJo2wlGz8LeqS8jOT3ulXi0au4krROG/Vjl3cJ0dOm1ZDoS63kdoxBBbQ21IRXui3qLjJbP/UfZHgCTsFF1/L2IulHeEQ+F1V1AzcMbNNFDbdJS8VQLWSSr9u3x0OoovpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2KUvHR1AHU3iYTvGJwlh40VPMpx8PgFKUk2Xkt/Uj0=;
 b=KImu6BRxjleK+sg2l8WlJABHe4gKTxOvssaRyD14eWM0SXwuejc5hB3jE4MNgGSipCKnfmvHn7WF6m9h04xtaFZPF03dMhmLKcz6nDSGnYJa7hLgabRXmyQRob9zoD0TE8r/jstQi+MlI3QTdChep6/xvcSUKdL9TCDD33y6v/M=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:04:50 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::46) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Thu, 31 Oct 2024 18:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:04:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:04:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/display: add DC drm_panic support
Date: Thu, 31 Oct 2024 14:04:29 -0400
Message-ID: <20241031180430.3993389-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031180430.3993389-1-alexander.deucher@amd.com>
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: fe529577-b3c9-4d72-0a21-08dcf9d68347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CNQWirrglZqVftytjUtvTOK2MrOyGygTLoBFn/XS5GiOAOOW86SN+9xAh0TR?=
 =?us-ascii?Q?NbWPpDdhU0A1LpaFFy7qE3y87yqHFisW02YHhIj3NBSQMinMmBSED1hZzMld?=
 =?us-ascii?Q?YCyGncx/S5QFb8e6IbrODm+exeI9aBLX3g26jTlIf4UpQHhiKExHscNRATp/?=
 =?us-ascii?Q?NWAD1Vrhyb/sOu2IOjtfXmoEb2l7eMQQUfEgb7QqraeNWjETBYf0mKNYfN11?=
 =?us-ascii?Q?LJcUV2cdpjZLAR4PRbNvBSQvU5P7HrJRmR5KmAFn9dtxAuQ14f0yu9SG3snP?=
 =?us-ascii?Q?/6PHw1zh3/dIxcr0gZ7qXqLxSEvEN+WbnuOo9pvsbxDJCieqqIMonhWiwmW/?=
 =?us-ascii?Q?0pm4gXipmMxi4F6faWvfqYg/kxL6XTOF5S3c3PRm1B4cn4loyUwmSpGr+73f?=
 =?us-ascii?Q?tBEIPnHTLTJjs4P7NHR61n9EVNVmbGWNZecHKmLEy4EyoeR/JEeYyX7RvHsa?=
 =?us-ascii?Q?fmvjvloPf/9uqyqVftEhwmqiL/bPu18hSyGaIuae72mTdfj39L5LdObPHJA3?=
 =?us-ascii?Q?gqiPj/nCy2NCx2xSu21OD+ex9En0FXEC8Nx71ufH1rhIIztRtnQxICts9qT0?=
 =?us-ascii?Q?/I1s8rNDJ6AZBlxzycUnYoAKgEYgtUV70YSj4NmU5yEM4NrhVrbsxylCewBt?=
 =?us-ascii?Q?mnzLlsQPiWtFegkGrsJKmHcmvUaWFnNAbuyd6saTvx70VifJJMNvUjoqMEHV?=
 =?us-ascii?Q?L0yh+QbeSVxtkTSHLwYJhF7PM24V4dhDYVdGquFMs88zFXhEZWvYmeXqFcU8?=
 =?us-ascii?Q?KCB+lqz7PeLoDFc12PIJAJUlM+b/VVWFHXSquxy860PkbCsIohfo7weUpNMq?=
 =?us-ascii?Q?A9Hwuu/WvluWi3MN1Zi1p47FZJBZ+XsOcUYSYWTQEQm11bOMU7zC32y1twPr?=
 =?us-ascii?Q?BpepWpOlp820Bc4kB0Kbj4A7pLoA5TcELF/Sn57wp+yoRL2wrX1DHFVUfJOY?=
 =?us-ascii?Q?+tdx15WW2t8kuknLv3NNrH+9BaLbxO+IoLEVh59gzC7MIBQOOIoJu41dfw+R?=
 =?us-ascii?Q?jYYwovGgtJBF75iiahnr04qofBzbrSv6yMZlYiCkL2HJjZtN3W2x62XqvKmi?=
 =?us-ascii?Q?N4HCb3o8ukL+EcoiMi8G/afzqs6xU6BceyHqfz/3hfAog4y3p39NV6h5B1kq?=
 =?us-ascii?Q?8JoZijKK2jWCKbsgYOEbAXnhQ2Pp93y3Ox8JCAq6+lWnoLZg/W7TZUKSVf6g?=
 =?us-ascii?Q?Z0XIbBy1yi34M8nNpq0K45qytV9dP3tYcya6JdLN8tPe4udTkC4kZPTz5iBD?=
 =?us-ascii?Q?uctc6IWmgFoglqKL0tZfkTJ3GjYj9vPBEvSQEegFznuv7t2LlnlO7a9Ctfbp?=
 =?us-ascii?Q?Vbtv5BES8NCPeDXfXz3+2VSxLmpmyBkPCV5vahyMcRsm4vaxN/ATj7Zpbz1I?=
 =?us-ascii?Q?TbNDMMXVQmz5bhKFO89PQQiFiajpLFnEkoIJXqGh95Ky/b1jCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:04:49.8993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe529577-b3c9-4d72-0a21-08dcf9d68347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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

From: Jocelyn Falempe <jfalempe@redhat.com>

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

It doesn't work yet on laptop panels, maybe due to PSR.

Adapted from Jocelyn's original patch to add DC drm_panic
support.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426..5ba64e7ad3f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -26,6 +26,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include "drm/drm_framebuffer.h"
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -1421,6 +1422,93 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
 
+static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
+{
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
+	struct drm_framebuffer *fb = plane->state->fb;
+	struct dc_plane_state *dc_plane_state;
+	struct dc *dc;
+	int i;
+
+	if (!dm_plane_state || !dm_plane_state->dc_state)
+		return;
+
+	dc_plane_state = dm_plane_state->dc_state;
+	dc = dc_plane_state->ctx->dc;
+	if (!dc || !dc->current_state)
+		return;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct hubp *hubp;
+		struct mem_input *mi;
+
+		if (!pipe_ctx)
+			continue;
+
+		switch (dc->ctx->dce_version) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+		case DCE_VERSION_6_0:
+		case DCE_VERSION_6_1:
+		case DCE_VERSION_6_4:
+#endif
+		case DCE_VERSION_8_0:
+		case DCE_VERSION_8_1:
+		case DCE_VERSION_8_3:
+		case DCE_VERSION_10_0:
+		case DCE_VERSION_11_0:
+		case DCE_VERSION_11_2:
+		case DCE_VERSION_11_22:
+		case DCE_VERSION_12_0:
+		case DCE_VERSION_12_1:
+			mi = pipe_ctx->plane_res.mi;
+			if (!mi)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (fb->modifier && mi->funcs->mem_input_clear_tiling)
+				mi->funcs->mem_input_clear_tiling(mi);
+
+			/* force page flip to see the new content of the framebuffer */
+			mi->funcs->mem_input_program_surface_flip_and_addr(mi,
+									   &dc_plane_state->address,
+									   true);
+			break;
+		case DCN_VERSION_1_0:
+		case DCN_VERSION_1_01:
+		case DCN_VERSION_2_0:
+		case DCN_VERSION_2_01:
+		case DCN_VERSION_2_1:
+		case DCN_VERSION_3_0:
+		case DCN_VERSION_3_01:
+		case DCN_VERSION_3_02:
+		case DCN_VERSION_3_03:
+		case DCN_VERSION_3_1:
+		case DCN_VERSION_3_14:
+		case DCN_VERSION_3_16:
+		case DCN_VERSION_3_15:
+		case DCN_VERSION_3_2:
+		case DCN_VERSION_3_21:
+		case DCN_VERSION_3_5:
+		case DCN_VERSION_3_51:
+		case DCN_VERSION_4_01:
+			hubp = pipe_ctx->plane_res.hubp;
+			if (!hubp)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (fb->modifier && hubp->funcs->hubp_clear_tiling)
+				hubp->funcs->hubp_clear_tiling(hubp);
+
+			/* force page flip to see the new content of the framebuffer */
+			hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
+									&dc_plane_state->address,
+									true);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
 	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
@@ -1429,6 +1517,16 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.atomic_async_update = amdgpu_dm_plane_atomic_async_update
 };
 
+static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
+	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
+	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
+	.atomic_check = amdgpu_dm_plane_atomic_check,
+	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
+	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = amdgpu_dm_plane_panic_flush,
+};
+
 static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state = NULL;
@@ -1855,7 +1953,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	    plane->type != DRM_PLANE_TYPE_CURSOR)
 		drm_plane_enable_fb_damage_clips(plane);
 
-	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
+		drm_plane_helper_add(plane, &dm_primary_plane_helper_funcs);
+	else
+		drm_plane_helper_add(plane, &dm_plane_helper_funcs);
 
 #ifdef AMD_PRIVATE_COLOR
 	dm_atomic_plane_attach_color_mgmt_properties(dm, plane);
-- 
2.47.0

