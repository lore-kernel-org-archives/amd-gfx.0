Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE80D3A674
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0125610E39D;
	Tue, 29 Oct 2024 16:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UoIHDyMk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B6B10E396
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2msYtHQzJ8+Md8zer/KvoxOusi5FNgIz16GOz/U7KEY7bsEEwfc1YWos/9iwa4G7NF0cF/jOvszAzJC1XpxlYGolCzf1gnPMX59C4CFl/SZlD4GItKoPChWcGcMzvhePw53AS+vN2eMT/heVXXCiluniXqOKjIBoBpNEYVGQLs0k4/i/xQtvBr4KyfVPeb1/7It7nMIA8dBQpVlsRa4vcNjLReq6KP6Yu31DbCL3OGGWDdRG9qwwRwH3HLZ6tScsnkVnIsh4sBNT5OcKxofB3h+R1fGenh6LZYNlwQ9f5CAoESuNUXp3BZem4hKJaf9zKxMCcZIghBf/e33BuljLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVyntQ8NiEn4WYHv8abWKaQJhIesqR8mvAt4bgw7EKc=;
 b=jqsIIrWgBhTI/qQ5ccyJJT9sbmoqIjmWuXboiGWOlEWav4Mjrqsv/xIuoOIx08mowTGpTKQRsyh6EjSjxHnTz5rR9sDplc97HZ60TNPUsyJ8vDkS5P806x1Y4AXod9pjd/g2OYb+MRasB3OPtzUVBE4KtoKOoa6wvfFDUbt8DLj47pI40IF+Hk3IyswPgCmH/ah2+jrR0FsuurujmwGETprBXFyP4u3nRPYeKQ8R8RmaiGZRqIEaAO/aSN36r7o+MW5Cwn7Qgk5768vZJXO01bkFlfn61bAPuXCR5XcV+tjwFAXtb+5UgI0qFzNiRv6ajVJ4nGLUQSI1Iy257DRo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVyntQ8NiEn4WYHv8abWKaQJhIesqR8mvAt4bgw7EKc=;
 b=UoIHDyMkThTjeAhlI3CFpMyG845yBAU4N/lk5b6Ne6JdYUaNR4GOPWBz5O8JimgmfLiENlNiQAjRsoBHawGWrxvRaaSjYWSaihamCYXw1xwPWnPB5wl/lTuL6W1ic9EVscJ4unEa4KntsCWkuBYvbhHUCktslTOuSaVE9yRwkt0=
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 16:57:11 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::2f) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add dce6 drm_panic support
Date: Tue, 29 Oct 2024 12:56:47 -0400
Message-ID: <20241029165653.1873243-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: be47e719-17d6-46ef-c827-08dcf83ab996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyNxcCpXN5efEVM00nlNy6/GkzLgjBfrUKs+W52iE9wYrtZMBOJmE0seR4Qb?=
 =?us-ascii?Q?+a1orOq1Xgh4XjkgXza6L45990II6o4p9e/Og/I+Q4B/O/PypwsCyfA4B4Yk?=
 =?us-ascii?Q?rx7moD8/w75Xb6A0YslQrnrQS5pDJaC/D6eiySSeFu2p8H1TuA8I+hCRHlPY?=
 =?us-ascii?Q?nj4qWi64sQQyUArUKQ2vxq7xB/vNpGbYmKvUwAQYe62yP/6WyR56iLxNRaGw?=
 =?us-ascii?Q?xOTaChBOAHbOzcWCS/cSkQNS7aNEDB8ebMSlV7s5vY+bQbn/eQFaKXX3G4Lj?=
 =?us-ascii?Q?SxrVNft2wn+Fa7wI4AtLQFO/0okPH8wdfWeyTDTzoru0dyG5eekoLmEjxJVa?=
 =?us-ascii?Q?ROEr6pUxyL274Mgl+yfifvZQDkeMapm6sGegSXpTJ1vwZd0cgWpckU6BTVzM?=
 =?us-ascii?Q?s5uoYoD/Wj9+j/nN/TcqTynyoIcZ26K+x2w+fRl+cnFebuyQCbN/jy6QErzF?=
 =?us-ascii?Q?crLCJf/qkcbQwdCheR+mzD60ZVSvw02mbRKONlCQ9eOgAq/syv3Nf/BJWy02?=
 =?us-ascii?Q?QDZn4Hh22KvgBI/AJm/6fHYXI+gcDJq5YDu+8W+4niN3lwTIMOaFjFtLnTx8?=
 =?us-ascii?Q?cIgZeTWy25/AkM/txxGFn+bjlRPhGgfDoVKx/Ei+tq88hrwAwb6PNnjvpmy7?=
 =?us-ascii?Q?35N92vfQGqMjYVEN/WIgn8C8OftQE31ewgCvHY4l3GCAUsAm2kydTZ7dLFJc?=
 =?us-ascii?Q?/s0paxmNvO73ku4hMB1IPVZt6Is6QqD3NK1dKUhfE8e/d1Fxg9NMAppj89bd?=
 =?us-ascii?Q?ABUxcq+RaM7jQ9Hvm3VpmM9IXS/tKxcl/jdgjuc727sUxxPeBItGnjxCERdY?=
 =?us-ascii?Q?id+USPOWdrRtaIsEiYHAV9fk+Jg+33w8l+y8OhJrpg2uaTCp8fn6AoWPGBbr?=
 =?us-ascii?Q?1A4TQ5ZF83vw+w9RmeKzHE2AJv2kdKFcS11qsGfzH6uSKxrfzgiYfKDBxdEQ?=
 =?us-ascii?Q?f3hdWgOBStl7bgiVefLfkX10MucRbfWWr9jll3yqtxQVWU4u7p3CJlBSTq5e?=
 =?us-ascii?Q?DG9GXMw01oL81NqNKOJb3MUBgItCsn9JnNQHazw0RF10GC3M6YSTlECoBLYG?=
 =?us-ascii?Q?w1hM0w7iCpLpVAhNCGd+WcZiPBIsNKZv1Rpu0icpUTOV91IUXFAIMHyTwF93?=
 =?us-ascii?Q?IhHUVaaLYyEPnS6xZTO6woamN7l49n77XL3wxsICaeaEGO/FTZFJ7+mKMlfN?=
 =?us-ascii?Q?1YE4TmiEJW3/7Jw97xevnpSU3TsdQ3t16ooJImO0l4JugOTltrBar+6qrMdB?=
 =?us-ascii?Q?IqeUf9fWgQeC31Y0aNyAH3fBn9yuf3O0MSKVgJG+MTIWkExP6X/XhnF0l4zx?=
 =?us-ascii?Q?Yyj8Z9ePBWXXGLW1r1iDPoezTlvyZvgiQHXrmWSqRKoYiFvPhqhJM7y+Reeg?=
 =?us-ascii?Q?p+vt9AVRtOsIVl4wYjio4t6P10BHR0oWtnlyc0NSUFjWVKX1Xg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:08.4601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be47e719-17d6-46ef-c827-08dcf83ab996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

From: Lu Yao <yaolu@kylinos.cn>

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..13611d3d0b8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -28,6 +28,7 @@
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_panic.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -2602,6 +2603,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+							 struct drm_scanout_buffer *sb)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_bo *abo;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return -EINVAL;
+
+	fb = plane->fb;
+
+	abo = gem_to_amdgpu_bo(fb->obj[0]);
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	if (!abo->kmap.virtual &&
+	    ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
+		DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
+		return -ENOMEM;
+	}
+
+	if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
+	else
+		iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
+
+	sb->width = fb->width;
+	sb->height = fb->height;
+	sb->format = fb->format;
+	sb->pitch[0] = fb->pitches[0];
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_ARRAY_MODE(0x7);
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+	return 0;
+}
+
+static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
+};
+
 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2629,6 +2676,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

