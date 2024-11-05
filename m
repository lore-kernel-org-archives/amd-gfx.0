Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19825D2B932
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6ECF10E5B7;
	Tue,  5 Nov 2024 14:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BGHElfD9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBCA10E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3MDvm7LhhDGb8LA/T44lzciM5BdguQ0J95fwRhNfm1LDo+Uca+/L4VtWoUsw7j52iL/DcUkMm56c+TCbmQcvrAkGKLku3z2eUiuF31u+JiS8CzMcxdbCYQWOl+HqL+ZrCMrrv2qYiIeoyE0zAtHkf53f9cuWxIlEE8rMS0/pW/6VoZyH49MFGSlYJmMH/hIxgWIS1m9hOt1DI/i/dZz95NFMBzAOoEOy7GuxAJJrowQhkGTiPJ8cWAcnHlJZU9j3kbSyEqYCkN1qJxIp/w5MaSaJ2qS4LzZxyVpmzekUL+bBDLEuSeucDdLrAKwIae4d/5CE9q7VJyqvjoShiXJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2KUvHR1AHU3iYTvGJwlh40VPMpx8PgFKUk2Xkt/Uj0=;
 b=DTOmQVoycUhoPrkFUk9jl28uaVl4Rv8IEjXuwdtTLKHMMA96DNScm955yNrxKyE1twQkNu+12iO1af+l/3ufjP95TKAjMWjA/bbssNqnC06u5+tuZnkp69SIbBydcqZUeGfpjBIqvFzLs5bepIvxe8NNkibvaBunC70WMEaTOiNGdacrvJou3tIER1vXnaLX+66wLIFgxTH3SVAZulPGZx8L3JRRemEKDZrmfzujLpHUeuNAcOgsShzU2SUZqVpaXtu5un6FYE4RA8M0UNfu6552Vk/442OPO8rgVTAGtHuWHuZgxBgGFG6jvbiCWCdsIrYJ+z1ryMmkaYbHpL6FMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2KUvHR1AHU3iYTvGJwlh40VPMpx8PgFKUk2Xkt/Uj0=;
 b=BGHElfD9UP4YnIe3pexpd4lquXpOyalenWtv/5im+VPaC88Gt86FXctdMB9HAzZM3iannkKhgxAJ9IJnUaTsWx/UC2qf9u8979EHXi4XbQ5jL3LmORsWtCdZbmps5a0UIObVaQNJ6HMDefd+AtZm9gWHZThoqE011IcbQ5SHqZM=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:06:44 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::d0) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amd/display: add DC drm_panic support
Date: Tue, 5 Nov 2024 09:06:23 -0500
Message-ID: <20241105140624.2897662-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105140624.2897662-1-alexander.deucher@amd.com>
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: d84e9a77-f3c6-4e1a-fd13-08dcfda31419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iilOTX6o0BRyS20TN9o0hDD0NxU1NmnjpjMUAPk4OVRIMpZDg2ePRhjWdul/?=
 =?us-ascii?Q?rQ+wG58CDQpjWjwsIu8mZyjbXeg9hSHSrorN1SQ3VzfXT38dYFxR2bADM04u?=
 =?us-ascii?Q?HD1se/dkJJGmDvNgCvQYwin10OAsnLSi9ehP+Rs8FC1avTDLEZfoyL7sJazm?=
 =?us-ascii?Q?UcOoKFv4+c6Qumrr/jdu3s2qoAknY2BXFaKORLZ+ADKmYnvYRw6tzxe0rYkf?=
 =?us-ascii?Q?v4YvpI77vn4bpxy3LIuSAVC8ogVqdKl3oFu6Uyh0BoFXv++rgN8jyCYabM4f?=
 =?us-ascii?Q?uDfs+k1BnldxbBloWXj5qy+t7hpficlEmFQCr7uW+uVa6AfooFDddPgcAnME?=
 =?us-ascii?Q?8+4UNnAc4DKdFXQ7k89wzCF94xU5PWs83dtXAZtql6u1wQpVIbBYGeA5tFVH?=
 =?us-ascii?Q?VAxGDJYP8sjRQbeLVJnpeUyG0IxqJd+hqHu9YhtqlQIxSgsEUg3Z0uwrsDnK?=
 =?us-ascii?Q?D91hfge5A5amy6mQOUSTsTso+SxZft2WYvCuixn9jtFj94ByiZvCEKa+FNzp?=
 =?us-ascii?Q?WTgwosWrJz9l1ZSU8KDaw2AWdAIB49qD9uR7RQZW4AwVhf5WbMz7TrMmdMNe?=
 =?us-ascii?Q?OD75RqXPest3YZjxC9cY2RjOaiAyJez9sw5DiTM0FyQ9ewHWyBo0OgkYJzKQ?=
 =?us-ascii?Q?wPqIe/y4Tx32PExW0eLXdtZi/1cbfcOJN6T9WOuaTQB+Tsy0mChBuIby9KXa?=
 =?us-ascii?Q?ryz4PVKI0rO3pK8H6KCsFmyBDije3vDPTQ40bjbIVoIb7yPIaVxNMboUF5tj?=
 =?us-ascii?Q?uHFkPPVO1QjpUZa7lNv1oH3AWnvoISJTg0roV8QiK/COlp2OquIJ9XwWtbiQ?=
 =?us-ascii?Q?Lz/PZKGnDEQysPgicAnife27dgk7sl0xjG1S78z157C5BY2Ze5KvzZldQa6N?=
 =?us-ascii?Q?AlKGxJB+2dN5tCbMMCpgaUjJlUVlONwgwM0mBTUjiyhXdb055BpuSPn95F6y?=
 =?us-ascii?Q?OEvxxYlAbcQ9BVJ25MPWbHe8GcYblcjZzUn8xH2bPq6ard0T/ghgCVOsWVB7?=
 =?us-ascii?Q?sf0Va1Zsrce6sTjpshNLo3B3LIoYb1XKoJhzLhdOaWLf/wzDVbetVlZhp40w?=
 =?us-ascii?Q?tFWq3NqkILlyAWPzcZhkVgOqQME1E3m6xHicXijv6QKPh2dNimucd3MBqsxs?=
 =?us-ascii?Q?6WDvZDwF5yki1p9MU9UghlLesOMssV1cMTgKMKQBeOYvdODa9Bak2aVEoyj6?=
 =?us-ascii?Q?8KEN/f54v+T5b8uBw9WVh9wVfuVZjUac6QjSEWyxzlXDvk+p4yr0TVOXEj46?=
 =?us-ascii?Q?SJk6ssMG1Qia9grP4vkm4JsL/aUcmbVknmgaTUwqSjXpw9zQlZO/S7QBi5G3?=
 =?us-ascii?Q?wr3nGhmnEDYLVrtcyqH7/ftTs7OtKOxY9YD8nvzE8gk5Q9Sqzf8jYVfLQ6OM?=
 =?us-ascii?Q?LlRNG5eQFT+YMcqpHYuHRViACGIyuhdkMN9aPkiOMaptuRtK/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:43.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e9a77-f3c6-4e1a-fd13-08dcfda31419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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

