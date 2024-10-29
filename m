Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F830D3A670
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED84710E69A;
	Tue, 29 Oct 2024 16:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXhYY4Su";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA2610E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEs/4p5irFlBco3fyIHbTPiZoBCHsrxcz2Y1DOTMWQWMZbyathMThVMGVwQFyd9/NmpdIBzqkggD/LlgYO7O9tUJ2PyUmfUQ9yRpL9yd60MPxCbLEX+TfiItsHOa/q+NzG51OTofGxzXyGQ8IGYgaETmxMRIPUAjua97/nmDJuQqH+tJAJUyX5bgS8N3MVGnOvIx78IQhy9q/6ps8MOYv/AnTWGPGUj3VDAJ5kSLeuibMQbjM++Oc601eE1G8rvIlg5xwae6a3E+Y8dxNVOl/4FydwxvCEXxS/bz3byw4C07B0gJ2C8nt6EGbdcqgYBROhDrL3HiX2+WXJPr6N09SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP0IhQz17Fd+jpZoUklaUsa3XY7Dcguug/8a1XY9uVY=;
 b=otm1QLo3wQ63dgaVvUAIh+lbvKnU5MbbKgTjlT4e5FvfrS2vgdwiUjDNxUimz6J9T2i/gQ4CZ9Vw3LN+Hjy+dPdFn5HRJ/zAvFPmb8J83Y5v/HFyYqtfVQPBzYfAaUezn6LwdbwmQHWYUQD9ZizFemD1YGIgxWTen2TV2+c4zSDioqOGPWxssx8r8fuk7cg6vADlMJlPgx0Rk/KdG+6YsfThBsiHUgY5mz7iets1nHE7qMCHvatQgG826DrvnrVlcbgc1uQoG8SUFYbo/qtuq0zrdcjQgOF2xqYwranEYx2KEjVkP6HQXMw4rKcWuicVAmcCBypOCbC/5kGpsugRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP0IhQz17Fd+jpZoUklaUsa3XY7Dcguug/8a1XY9uVY=;
 b=cXhYY4Su6OT3nH80XnSY/DYfMv30b12/YhgDybtGwfcoEALUTcz2T3abEZlVR7yJE3VkOe5rMCsO+IyEU1O1dq7Kyl/vCyTGZL2pv+36oVFiBRzoKL9CQn8+G4iZeO/2UjBn5c5xFudEgCiAtk/isdqEhfk3EdRqK+/uqEsndmg=
Received: from BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::18)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 16:57:15 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::93) by BN9P221CA0016.outlook.office365.com
 (2603:10b6:408:10a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Add dcn30 drm_panic support
Date: Tue, 29 Oct 2024 12:56:51 -0400
Message-ID: <20241029165653.1873243-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029165653.1873243-1-alexander.deucher@amd.com>
References: <20241029165653.1873243-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: c98acfdb-7a43-4c09-ac3f-08dcf83abdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xthnjs8DbxX33lteSgvlTLzvYLrZBa3xZz2X44TEj4JRlkCWUT78UzQrYzhQ?=
 =?us-ascii?Q?z+ooN3X18FROlgihWG7uihGKhI7cldSnMzorFJVcpzpgmScSVLkX3oGaGOl2?=
 =?us-ascii?Q?6UaKDkuMxJ0/EiaXwBIYgAl1HmauJLeEuUliMsXOlOkv8JkSolqemeCqkgx8?=
 =?us-ascii?Q?U8ul2Zqk/7FVr82OECDeiorzCKnVGetv9N9xf0LFeqbY64pSGNl3tInt37aF?=
 =?us-ascii?Q?i9KZXvhhqqUNefEW1ia8zeu1DYOyZW0O4XjMl/e6rHRVwrP9EIotoLOjwApR?=
 =?us-ascii?Q?cqL01hhdezErZlHC1U/mv1B6ElWaSUMXB7gWSW0QU91jRxeroTH3YYHYO47S?=
 =?us-ascii?Q?hkjTotHOJIhvtgytUqrYnlNDvRocOTDqzSThGwZcdZycDWfo/KXa65jjnRA1?=
 =?us-ascii?Q?wWWdCvlbJthIDZxJMCWa6/Bb/ogVqskhdwJ59Ta6mAXvDRc+TCAZ0Wry3jwp?=
 =?us-ascii?Q?Dz2Gt7b6bpy1/qLU1iRyYR09XO8clg8Dau0OuQcKwMPpmMM6bkHcif8QIIqJ?=
 =?us-ascii?Q?XLrm9nsMsmH81pps23PH316J1XMPEhkSS1jzgQsxvdNdgVUuGvNk3NkPzdcd?=
 =?us-ascii?Q?etwshptJxNeGXRBorpTbOuLa0RsyGmRkX6v1SwlXDTB9jFALYHXSGh+7uuE8?=
 =?us-ascii?Q?TISOaGr3fdemeLaINs+9pGRhqqQDHbk/PeOOxwidxyNiHpgkiVVRRlae3NUT?=
 =?us-ascii?Q?vGX7Oyd/Pv6eFiIfe32E7Dshw8n8ZYMQ83udts9WUYOYWzzne+ByedDccoVk?=
 =?us-ascii?Q?sU64Le54tiM7OPr2xHB2oryI/oTQcCKTc7kSx/kNquEj2vR4HHP4a8+z1Dv/?=
 =?us-ascii?Q?pyngOj8oo3weXPZki9Do2cpayLy7asKdIw3/WOYY/lPw1s8g3zt0iT60U9lz?=
 =?us-ascii?Q?NA/r/oJgEfvLTLjO5EVffLJ1+6l8Pa57If9busUhxvApc37GzU8EqznSJl7z?=
 =?us-ascii?Q?eoTWUE25k6y5GbMHwHxKqwHIsZk2GbiDUnZpzGK+nLNj/QqjtdBbhTg6R3EC?=
 =?us-ascii?Q?HldC2Ey91aaGlHWHr/HyVEeuTx8W2ApZQC2MOzXB9DBAMbxrOpLNtd/DWI67?=
 =?us-ascii?Q?juDwsxHgc0l7Vw8J3tOLdYcHo9jdLfrb76DiS7kpRT9d/qiFTdqoF9/c7mta?=
 =?us-ascii?Q?McQ4wVAog2qfFROPsIYn1pf1TmI1wqQrf6127hf+gxlH4trjHHL0GSu9JEou?=
 =?us-ascii?Q?JN2zSs3H1LXbidG+73yJiwAUaBHDizMOF/iPGxE+IAP2d5G3kAdcUK/Jol78?=
 =?us-ascii?Q?Brmn06MlmMuSvW4Kn1bqh4ydEdBq4gyLdWxswQDymS4l2KCxo333VX3p65Aj?=
 =?us-ascii?Q?kT7wnT8FiXTjpAkace3xRgrR/E6cet5IQX4FGjFut4XU6KOE2Ro7+TqLgmDA?=
 =?us-ascii?Q?otoLNpN6yf4Q0CvSfU8n9noFKptHtMbr9CK+cBTf+p83oaCbkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:15.4913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98acfdb-7a43-4c09-ac3f-08dcf83abdc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

It should work on all radeon using amdgpu_dm_plane.c, when the
framebuffer is linear (like when in a VT). For tiled framebuffer, it
will only work on radeon with dcn3x. It should be easy to add support
for dcn20, but I can't test it.
I've tested it on a Radeon W6400 pro, Radeon 7900XTX and
Radeon RX 5700.
Also it doesn't work yet on laptop's panel, maybe due to PSR.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 136 +++++++++++++++++-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 7 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426..60606b36f07b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -26,7 +26,9 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include "drm/drm_framebuffer.h"
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
@@ -36,6 +38,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_plane.h"
+#include "bif/bif_4_1_d.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 
@@ -1421,6 +1424,124 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
 
+/* panic_bo is set in amdgpu_dm_plane_get_scanout_buffer() and only used in amdgpu_dm_set_pixel()
+ * they are called from the panic handler, and protected by the drm_panic spinlock.
+ */
+static struct amdgpu_bo *panic_abo;
+
+/* Use the indirect MMIO to write each pixel to the GPU VRAM,
+ * This is a simplified version of amdgpu_device_mm_access()
+ */
+static void amdgpu_dm_set_pixel(struct drm_scanout_buffer *sb,
+				unsigned int x,
+				unsigned int y,
+				u32 color)
+{
+	struct amdgpu_res_cursor cursor;
+	unsigned long offset;
+	struct amdgpu_bo *abo = panic_abo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	uint32_t tmp;
+
+	offset = x * 4 + y * sb->pitch[0];
+	amdgpu_res_first(abo->tbo.resource, offset, 4, &cursor);
+
+	tmp = cursor.start >> 31;
+	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t) cursor.start) | 0x80000000);
+	if (tmp != 0xffffffff)
+		WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
+	WREG32_NO_KIQ(mmMM_DATA, color);
+}
+
+static int amdgpu_dm_plane_get_scanout_buffer(struct drm_plane *plane,
+					      struct drm_scanout_buffer *sb)
+{
+	struct amdgpu_bo *abo;
+	struct drm_framebuffer *fb = plane->state->fb;
+
+	if (!fb)
+		return -EINVAL;
+
+	DRM_DEBUG_KMS("Framebuffer %dx%d %p4cc\n", fb->width, fb->height, &fb->format->format);
+
+	abo = gem_to_amdgpu_bo(fb->obj[0]);
+	if (!abo)
+		return -EINVAL;
+
+	sb->width = fb->width;
+	sb->height = fb->height;
+	/* Use the generic linear format, because tiling will be disabled in panic_flush() */
+	sb->format = drm_format_info(fb->format->format);
+	if (!sb->format)
+		return -EINVAL;
+
+	sb->pitch[0] = fb->pitches[0];
+
+	if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
+		if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
+			drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
+			return -EINVAL;
+		}
+		/* Only handle 32bits format, to simplify mmio access */
+		if (fb->format->cpp[0] != 4) {
+			drm_warn(plane->dev, "amdgpu panic, pixel format is not 32bits\n");
+			return -EINVAL;
+		}
+		sb->set_pixel = amdgpu_dm_set_pixel;
+		panic_abo = abo;
+		return 0;
+	}
+	if (!abo->kmap.virtual &&
+	    ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
+		drm_warn(plane->dev, "amdgpu bo map failed, panic won't be displayed\n");
+		return -ENOMEM;
+	}
+	if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
+	else
+		iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
+
+	return 0;
+}
+
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
+
+		if (!pipe_ctx)
+			continue;
+
+		hubp = pipe_ctx->plane_res.hubp;
+		if (!hubp)
+			continue;
+
+		/* if framebuffer is tiled, disable tiling */
+		if (fb->modifier && hubp->funcs->hubp_clear_tiling)
+			hubp->funcs->hubp_clear_tiling(hubp);
+
+		/* force page flip to see the new content of the framebuffer */
+		hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
+								&dc_plane_state->address,
+								true);
+	}
+}
+
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
 	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
@@ -1429,6 +1550,16 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.atomic_async_update = amdgpu_dm_plane_atomic_async_update
 };
 
+static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
+	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
+	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
+	.atomic_check = amdgpu_dm_plane_atomic_check,
+	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
+	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
+	.get_scanout_buffer = amdgpu_dm_plane_get_scanout_buffer,
+	.panic_flush = amdgpu_dm_plane_panic_flush,
+};
+
 static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state = NULL;
@@ -1855,7 +1986,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	    plane->type != DRM_PLANE_TYPE_CURSOR)
 		drm_plane_enable_fb_damage_clips(plane);
 
-	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
+		drm_plane_helper_add(plane, &dm_primary_plane_helper_funcs);
+	else
+		drm_plane_helper_add(plane, &dm_plane_helper_funcs);
 
 #ifdef AMD_PRIVATE_COLOR
 	dm_atomic_plane_attach_color_mgmt_properties(dm, plane);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 60a64d290352..3b16c3cda2c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -334,6 +334,22 @@ void hubp3_program_tiling(
 
 }
 
+void hubp3_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
+		PRIMARY_SURFACE_DCC_EN, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
+		SECONDARY_SURFACE_DCC_EN, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK_C, 0);
+}
+
 void hubp3_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size blk_size)
 {
@@ -512,6 +528,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index b010531a7fe8..cfb01bf340a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -297,6 +297,8 @@ void hubp3_read_state(struct hubp *hubp);
 
 void hubp3_init(struct hubp *hubp);
 
+void hubp3_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN30_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 8394e8c06919..46b804ed05fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -96,6 +96,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index ca5b4b28a664..8b5bd73b8094 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -201,7 +201,8 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_force_cursor_pstate_disallow = hubp32_update_force_cursor_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
-	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering
+	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index d1f05b82b3dd..eb62042dfafc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -216,6 +216,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp35_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 16580d624278..d0878fc0cc94 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -275,6 +275,7 @@ struct hubp_funcs {
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
+	void (*hubp_clear_tiling)(struct hubp *hubp);
 };
 
 #endif
-- 
2.47.0

