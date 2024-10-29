Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36693D3A675
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51C710E3A0;
	Tue, 29 Oct 2024 16:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ay7kuwgo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0356010E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCawAloR3x3WtwkRirj3aq2R2dhx7yXGDL0oboARSjessyZvO3EpZumvs85WmhRxiqmOR+sWBvZTc+LETLnuZpwSkybx16qSNQWNPokp5yRnBGZ3PcydD4JXmYUBzZ+yNiyFNzEs4d/gH8KNZyUDCtgIZGwlmB58RF9fZV8f8jGMmhSx/OAzncpDrBKSVihbG/JIAwI5Ln0BDf2T4G4pMJuoJouQN6hT3MJpk2RbnyBPekcxsFNJACKvvqncYvVG1OzhwmoSYbJO0tjpsfzPJeXeLqBPwp/sc+M/V3VRka3WeI5tfuASAlRKMlJB6d5ILIbgU80ho8iAJGRMMKMuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od2aIAsuNpZsBTX7LFJ68Dy2JgxLaYgj1+Q77XHnmIQ=;
 b=dpRYtHZsh9yRHhf0+TjrWDHD89FccsgyaaL5Rp7zMzaVvnxqM1rXMCCMZJYj+7aGFFh908LPLXFU3ZryBccjBCPDGxr7DZjAu5B5xY8kqwHAhIwqm7VEs5R5MN4XVxvWlB5V/1RNMEwPcQ4VXNjxofEXQBfo1LKfEZSob9p00hWv/1fsEAQ84KBNPAUDcazfeqLBbdR68EU/e6YG7Z8p7BWb/zviow++/k04z9XjM9QkZ5JR0PawD5sNBfWTMOSSIJtY1MEkNqKubgfOUJs18Onnc1fOjFPRWZQ8FVdaYyP+2hayeqhUH5WveJn5a/N5Gs/W8NYPu81x7HYa5Fbr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od2aIAsuNpZsBTX7LFJ68Dy2JgxLaYgj1+Q77XHnmIQ=;
 b=ay7kuwgo92mBzhGzojPFnNRstKVx15GLFg4ws4mz740FZmE+ZE9H1TXNPvWZS8EWMR/9jg9mCBi+kFWd7ubOCtrOOinp9nz5vI05hv9eqZCy882GItzxBhAtZFmYzoFctMaWFussj70w5f3h7iyRCWWMBSksvJQp3Qd+JwcrX6U=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:57:15 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::95) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add dce11 drm_panic support
Date: Tue, 29 Oct 2024 12:56:50 -0400
Message-ID: <20241029165653.1873243-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b65a15b-2629-4abf-c747-08dcf83abd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFcAUwC1hGTTR/RyolOi3NrQztUvnbPMngUv2nGwo5Vo3/BUQV/2gnQF0yb2?=
 =?us-ascii?Q?t2FU3EneCZVkhp4nExw4fcYtAvweB0Usv9Y2ik13zp3BOB72NRvgML0CNRKY?=
 =?us-ascii?Q?KHRgiWdb+hv//3sLtuT8vOVWdBbJr7SV0jqhYOla8i9IvcqcmWbtJRD3Lp+v?=
 =?us-ascii?Q?SFgVAy7K4h0vzjNnMJqT/xeC0l6MC5uy23K0NlvgmjToqdqKV4uT8rC05yvO?=
 =?us-ascii?Q?TUTZjkwp0xgIM4aVy0CIc7wl/aJ6VEIAd57vKJdT4w58XrNvsd8N6G7rfqo0?=
 =?us-ascii?Q?Xpl8iUhGu+hb0PCMfg63uM6C5Kl9oDIAi/FMcvmuQWW9TmiMWcmwPDQsyszG?=
 =?us-ascii?Q?/HP0rC5J7qmzAz3rDnlR+yfQW4xcSEIhQd44Fd9FbhZKdEMBii4IakHxVpXG?=
 =?us-ascii?Q?XJtPCicLrvEFhToCUr8zUrgHBkPDtWUVJftLdNjkISCLAbmMtEjla0gaZiU3?=
 =?us-ascii?Q?MVPvlAEYZrFv+VZg6hH5MrWFOug4T1cYl2lpZBG8JC3o7YMuLQgu7eG/yhZf?=
 =?us-ascii?Q?hjBi1RjWBNz7E/hGHSDrD1IAAEUnba5+nGMKWBrZWXnHRn9A+D6wMp8V3fex?=
 =?us-ascii?Q?kvosgKBf+5NxDDucd9eREbrikptk4bqo/Ey0rNPZnf6hS3352bICqQlkLGSs?=
 =?us-ascii?Q?fr3v6sMPcQxe+/m89g4ssCVQDwc9jtfXznhQDsN2x5tiQLVo5MoDP/L/bFuv?=
 =?us-ascii?Q?eh1LcrhMCqPkk3B1+TedWhDQSM1DF/5WYy8wgk4R1Z+rW8XBIdwYDrPPMDi4?=
 =?us-ascii?Q?pAnbe0x+cnN8A2MP6XKYbYn0I+SjsvFwPpsAx7BiDBOHJ2bnFg1jt9fr/TF6?=
 =?us-ascii?Q?edbwrXxMjo4U8BVBa0ARyzL87DNV+5hOHZ4J8GfmNb8Znjo00OY3npVdJlmW?=
 =?us-ascii?Q?zQMVLVE95XnbTnFgCkbSrYGtf5E6LSKlHBeeSE1EqcKu0V1Gb2Dv6VTn2zgR?=
 =?us-ascii?Q?xK5+24F79MPjGwYlbSjAuDkMPg2/mxcHZvrads2Hec6B5UFv7qn1KxDUEgw8?=
 =?us-ascii?Q?MoRci4T5JY4MBAf0bmMJnHfSXYmuZuR4TdlvVF3kd6qV0gZz/AO5rS4W3ipg?=
 =?us-ascii?Q?7WymSDvB9yCigqlwHDRNC8l0v7GmZ3J/O/pqNbX2TtrVcWZiNYJvh7cdOl0X?=
 =?us-ascii?Q?SYrxni6waU9rZ6xGkFh6DczIMxTv7aybOdOt+M8zCXgv3vgojfk8rqMLkCpT?=
 =?us-ascii?Q?81R0CQULpfbymOhjIkYcwGQj1Qpw0dDZ/zHTDFUEadS/po6h7Bd2P/2OoIsN?=
 =?us-ascii?Q?vqVLr2PFCW/5exfJurErB++SWwaCaj6+VFF/AQ75cv3eDUJ0+tUq4TBkprkY?=
 =?us-ascii?Q?QirC9XBSfV2voGHKjXRUQb+sTi7vUZWTprFvvwqE9QRYpNZ7XWsw0pxoU8XS?=
 =?us-ascii?Q?uA6UIp/ydaoteE7rftH++P0J4a2tnVAeKPT48c8lyksSMz3xHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:14.3820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b65a15b-2629-4abf-c747-08dcf83abd20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..4aaadfa2b870 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_panic.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -2800,6 +2801,52 @@ static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static int dce_v11_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+							  struct drm_scanout_buffer *sb)
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
+static const struct drm_plane_helper_funcs dce_v11_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = dce_v11_0_drm_primary_plane_get_scanout_buffer
+};
+
 static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2847,6 +2894,7 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v11_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v11_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

