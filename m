Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B0D3A674
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C954710E39E;
	Tue, 29 Oct 2024 16:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZgElJOuA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE9E10E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu05fe7v5eVbSCZuJnrg3fJrIi339EsY+cX8UcLZzwlC5sW7wrZWbbAqArl4W7PnWiUhEAhDIybxr1x/y4AAXmEGGlHD6aGSY0HPM3lxyFnxmXNTxjgdiDU+nonuU3bZxC1LhjdsoN6O+lq6iy0RESsvMkUGakO+3Jk73ICZJ0YBA02U5R+5i29VJusMwFFPBJSESsuSn6NbbfmrgP1a7CHN8EX9XOw0sAlszRTIj1rweRsNwccMxCp3A078SfkscLV2bgeJrGyhtEUVGiMC6wrAFt9gUGzQsxHzb5t7tg1HAehsWB8gn7v7OXXtCFVj72EJ1kbJamKYmufM+IMMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpabJQ7TnwWC1PSK5L+/Uqch0c+323T9fGlgajJvE6o=;
 b=C+E/jFgsnMnIQ+HEnJq3RpS05NQr2s0yeLZjBsp68UrEB1sPGkn6H9KZy3gXeTDGM+YORyYvVwxjtS2a/BIP6T0TzG6dub2cHndF2eq+lW9gVl7RTjMpddL+wpklVLc1tc0e5ZiBc/VH0hDSi+sGYwPsJpxq6qDJnDdo69L4lLwursz/D8LQ25dTURyMJDZ6Ris6UW6gno8x2xQeEyvkicyY5yted1gUKRWPOdU4N+vIjJPtqeJ6Twe+i3U1fF9Tp3TtS9RdpyNTzT4gKfLhJmkqw9T7vL5U9cOeuCGElTAHMzmZzEXn9dGzNLvG1p7iU5K8GyO/5t6X+Fd3mkZh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpabJQ7TnwWC1PSK5L+/Uqch0c+323T9fGlgajJvE6o=;
 b=ZgElJOuAuR6PDzwq62AbOHgqQKWdvdSOClbpdo6TZ0en4BB0QxR7/7JOh7Ts/R1fMyN/kqumInoogNjuZjZ941Wko6YTiRdJt0+sCvFgGZqJs5tpnwtfCMyj87EgaKgTm+CANjBenSFrkyr7AYdAuUSw83nvShYwkpOlZdqXdf4=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:57:12 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::8e) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add dce8 drm_panic support
Date: Tue, 29 Oct 2024 12:56:48 -0400
Message-ID: <20241029165653.1873243-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1157c77d-540c-4f20-34c4-08dcf83abc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TmRxf0CP2xcBtnHzXF6A9uUDDYb2GMDQwq++Q0tcW4VDpfOtt5tXfuSKsBSb?=
 =?us-ascii?Q?npFfOSGVriieQd+6I3cOHLOeADOdomWl3w/9IpmplG3/Ky2eKZcIAduiDt0j?=
 =?us-ascii?Q?zZs4CHabGhKQMTXpKEB1DomFcydjVGXnD04xErNI6ft5nRb/W0y63ogUFQJe?=
 =?us-ascii?Q?pLUZwoqSC/5P0b5gKAa7zbYLLf5KnTElLS+xCUCeaHAo3PNTQAonZynpBpmJ?=
 =?us-ascii?Q?TC59vhN29cmZpGmP8uFvSXXtSxxg4bGY8FIsYc2TjUKw0Wkuevwt/dktt09o?=
 =?us-ascii?Q?Pmg+wgmdFPN0uczVWOf/nDdATUis8QKbmxD8QMB1WwWIgbM0RXFV46udWUli?=
 =?us-ascii?Q?PiPd/3iVBfgz7LvuqAFIV2LPFiCdwYV5O59Mmddq8CdfmxH0OILZV1Iuz2dR?=
 =?us-ascii?Q?+9+pZXYPLWPfW6DeBoVEqWavtIKjFByt/6+j4Ep91ELW/kuQaXCwG1blfYhm?=
 =?us-ascii?Q?9p2hJdsXHd6mvPovb9F5tzWvjwiBSOXejdtW9f/eZ/lwF0bdzVUPwd6CDIxw?=
 =?us-ascii?Q?tjPl36PalamqEyhBjvaoNJzyNQB5AExVM86U2YorTlaVXsSyavYF+ZN6aJkQ?=
 =?us-ascii?Q?zAVSYkf1mY7KDKUNYecf1wAI3jmSoX0spk9KM1OjISGCw1ErjQx1mGmVWsnb?=
 =?us-ascii?Q?QojgZa4YaqkQblsy8WCL2mpVUicgzX/gTXOVHKnGJap5Vyph4PA8PW3JLLTK?=
 =?us-ascii?Q?p3AOf5vs2cEoOvT5I6s585EYVCy92uP35Fbklcczw/GT5tuzF2EyDG2+LF9A?=
 =?us-ascii?Q?p4vpZyGIllWCZRTPZ3ZCZJdgEc1Mt8DlY0pTCOxKVc++tp07w8AhTKG7eXYp?=
 =?us-ascii?Q?pPi02EeolRk1QPAPQ0K9+Aw9a4cah60hgC7x1lYqz1GflLzzRVPJlAEUJ5AJ?=
 =?us-ascii?Q?5U9Fgn/fFmvT1kajCtwZDJnBRhO+eJJZohvpGFB35CW8hzXtfJow0WmQQPA9?=
 =?us-ascii?Q?c2cbbMXu68AD4uJ/znGGreUkgT1HGSG0iDB+UK6kKS/oKbuYdDfvbXaLdftJ?=
 =?us-ascii?Q?kWcdOyWPAqUR3T6clDEVe195w1OI2MB70jW9O2/YE7ROl1zrQEgKFOb5BhTx?=
 =?us-ascii?Q?st3juHrDHzUhDce7KHvz6c6LH3I/smarMV8sox3nODy/05tHU/d4uYSXT7Em?=
 =?us-ascii?Q?P5xdcbT3q01RlvzGOdmlTv/dmYwsn5NotzLT3P63Oolqx9DwbhssvtD2W51e?=
 =?us-ascii?Q?qdT6p34BdnSQ7EBX6/ucPF7kQqPUcXArBZiI3s356yISeFMOpnJuVDPnDlAF?=
 =?us-ascii?Q?qcf+OQg3toN7bTUhPD9GrjrUEjeG/lswFMX0RWcpgdVHAK5w02fZIve5lbOG?=
 =?us-ascii?Q?wubGp6dxiU1Ml7lHf6zZHJpPqgHo0iZeDgjeYxMdb0wmcCRIV1IQ3fn/cStP?=
 =?us-ascii?Q?NvEkuY1RyastfChJEQ/SWq0mc1MRA9bPjt+iwYBLGuV59+EbQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:12.7882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1157c77d-540c-4f20-34c4-08dcf83abc2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..25b4b445385d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_panic.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -2613,6 +2614,52 @@ static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static int dce_v8_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
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
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+	return 0;
+}
+
+static const struct drm_plane_helper_funcs dce_v8_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = dce_v8_0_drm_primary_plane_get_scanout_buffer
+};
+
 static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2640,6 +2687,7 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v8_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v8_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

