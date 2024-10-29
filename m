Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E229D3A674
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1B810E360;
	Tue, 29 Oct 2024 16:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p3mDqbO2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1DC10E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN5fpGHt4txOHhTk2/gSTP8i8TSNSnE3ogn+5TDoy2u1HfBPX1I/SbZkGthZwkciE0HSn2NYo68sNqBgYwtsRo2snWtCOa6NVhyNH595sjVHT4c2MrOEVRacOxERvnpqQdxgmSgJ0kP8a+ZoRMzCxKTnC33CkxyL6JqEwAdNAEZc+cnS+eVFpwW2X3hCzwq07RdeCGltDd9h5oeWlwz28+JY5wCO5xaYO8c4nJQhK42nDqW8wVBRFRXJyPMWVyJAhLKLbWWYeVkjl3zv9qnqMTGU1ejVaFXohwxnaNscZA8BtDN/KLOxlDlEG+TwFMqSOtPpYIpKWNTcjAQ93UE+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zoFP4JLG961ZDny6QrMvd4Lknr2N6aIAu51YlplEVs=;
 b=SD3IjVYbjwkLX/DypnRGLJnGrAQ5IJKo5/9NGYxYZENQ8cOpHGTbwvlG7zsnJFoUKMeHKtrjSXctQah6+JrdepYUmH58or05tOrvb/hEWA3lTu04iSBOmK6BkkQx8fycE0VCuVEgU7yJV4jXaV2PhIRdr6p+FybyzZDh90MFVEv3OjVWOwxzA87q0/kXYBPtCe2wDEl7Dsi4PaB4XrsaBOFrVxDeXLPJsmM8jyMtmh/je8cTPM4x6taz/CvokL5NKFTCjQeaULQcmP8w1vj2v1GsHxbdf4zzRFAQk3zS4ni3BsvzRLx5mF9v7XBG4cCfuzt0ouN41i8DhpxwK8BEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zoFP4JLG961ZDny6QrMvd4Lknr2N6aIAu51YlplEVs=;
 b=p3mDqbO2H/O1JJtWzLPihGw6QFPQ5x7nDK/rb9Rl0Wo5lFtKDorFi+L8Lqd3DGnicYeJyBxfNEgPLSHVALTZ34/SB1iyfsjNbHvIz/s6r7oUnplDIHy8lPExgIJwn3sRnVWJlB2AYTO4ZmPT1ChwZ9sKYDudqXq7r57Q1mzD9UM=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 16:57:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::4d) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add dce10 drm_panic support
Date: Tue, 29 Oct 2024 12:56:49 -0400
Message-ID: <20241029165653.1873243-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcd88bd-13b0-4948-097c-08dcf83abc81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rL9LxmctpPMBfQW/FjmmQWs+jSUsVDvUMd5OzMJd1nZtpV6zVay+xXJS5rcS?=
 =?us-ascii?Q?5/ANe/jZglsKMoJhVvU9SnhuRhLcEQMJSMarYHxraUZN6/ytuhksUVQqyoB5?=
 =?us-ascii?Q?vgh9OoQlr7DsQgCYh8Q+2iXWkSmhcioOVBhzC8KVogTW4rvZi2KUVf377W59?=
 =?us-ascii?Q?sZjD0aDCtw6IXlJe0U7YcBmrjQdO12Ra9pxnUu4H5DPIKzsdh82hwrK50i8a?=
 =?us-ascii?Q?idC4krlyWGsr2BtCGQOIIO/dg0MUlnQ3q6XksFROQ9/wUAM9uw8AIRDp2R6L?=
 =?us-ascii?Q?B7CDiV0+5AahpKA4PieG/9y1nZMCJnW8ZRSkQrgmIsull2c7sP/q3OZd1gHa?=
 =?us-ascii?Q?AAD9ZCDcocAKWmH+yRyI5GYahslXZxWW5ERCVcL1RqaZTcStVcC9qbTHaFM9?=
 =?us-ascii?Q?e8LQhi+RCC19PfBa7yhp76SbSu+esfJ4GQeHzfproLDR0vzF+7gktL+L37Ek?=
 =?us-ascii?Q?SV4HlsfNvEm+qozwxwyUowk/aFXaSphK6xOJ3+Oxijr5FnYtVjxRxsO7Hh6p?=
 =?us-ascii?Q?7sfOynS589ZbiLvzO6V252ti3ZeKAi3xyYJDviAEyDtx8+LIQ1dIir6CZnNN?=
 =?us-ascii?Q?abivyeg674dudR7ophnN76qETImaXZMx5TU0qF3RD4L9ND77z6/HQd3MmVlt?=
 =?us-ascii?Q?CPrgsO9Gi1hTCjoGE5gmzStLDXEqABxQAqldEsQImSgFxwEdtR8qiVl4Z1LL?=
 =?us-ascii?Q?oZHBt+pkDMH74jRoETjcF4Jtxe8dpBJV3OYx4ZaGowCBHfL1ljuYMEBU0ATT?=
 =?us-ascii?Q?m+56tFr9uB37J3KhyRUzeKHKQrJE0dl6gUWqODWz5oBGOfJGd+YVgC+rFJkj?=
 =?us-ascii?Q?XsOwayIf0Aem4d2+OjPBh53ka5WjNtbe1eAe/2lqtvBx9IP7SVc1l3X1Db6c?=
 =?us-ascii?Q?MyoaKZK6WYmhMNcWnXaXyi5x2UPzoHVsAi1Mo06g/M02Rgw6DP9buWhzdwLy?=
 =?us-ascii?Q?gpIrPNGG9KOoRaQNdjxRfkeISSzYFRhidDWjjiu3BT9E8fmQYXlJUKHdl8up?=
 =?us-ascii?Q?Uacl5Ip448dwssk0DrqEXLJwkrizNFTgbFlnJvG+MUJYu2ZBLIQnFplLCCMD?=
 =?us-ascii?Q?cHojmydWASSo3HtWoJpGfqbzG5NRdq2+m2tT5XkkJVv1OtPK5Z8hDA7gGR5E?=
 =?us-ascii?Q?NZ1ycutt4qnBSkClQfqepCn9QZWScars1cwrd53MrNK7VlhJVFgDPCnobv6J?=
 =?us-ascii?Q?KYYOGMgbW9xZN6Kyzfcm+EqB1g8pNEcKUNb0uAmgY2PF5auInbKgJy1xXIYz?=
 =?us-ascii?Q?puvOi53EXrUNlEBFS5XuKdKVuVaSmddWsJ2Cj8BDiD++tEof5nRIr9xhNipx?=
 =?us-ascii?Q?q0YDX8dU7fXt0sEesrar+xudJAmCwM/yV3ulmfeNXCvyGGvqXKG8TWXA0gda?=
 =?us-ascii?Q?2sXiXwBSQiO55+WK11pI/q41DkDV9L4NPmyVb+DF9kCC7fji1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:13.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd88bd-13b0-4948-097c-08dcf83abc81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..88da5a97ca19 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_panic.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -2687,6 +2688,52 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static int dce_v10_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
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
+static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = dce_v10_0_drm_primary_plane_get_scanout_buffer
+};
+
 static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2734,6 +2781,7 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v10_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v10_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

