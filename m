Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3857FD2B92F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC86E10E5BB;
	Tue,  5 Nov 2024 14:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tRh1Bkad";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C581210E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/bPGwRo9p4Y8eH6cJ8GsqqqALK++di/7k+8TgvXPqVZ5hrv3K4/1PJNSUdl46rTrHWsxRqHd851Y6F9UbyfIpjk/KHuc1Qw0CwoC0Ddgh/Jv3u9y3XeuMAJdoZYZNQtU7nzqgV+g+j5auY6zgPRcZqK2FTcq9o4jpzpURyg5q8G6fLBZdqIdJXTd98OjLbFhxvmAlPU6qk1eT+U7EjiolGMOumpxbZYjDux2k0DeWlOC8xn330U9Jgt1RrarPybiqENZIH3A+l6imZhVplVFpWSZgckCdsdXecTtYrZmp8YrCL1QDxkxg9irt36LhCot26DCBuOK38rvgxpJ7Ctzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq7bAFcWcte/ayE/oT37w8fAUL2BIGD0I4kbKdQnkkU=;
 b=ZS9eHDMSJhOQuQGS3dLPqDNrozHMisJvKMt6g6xdiHVmW74d2qBoaiNDTwzTjzNfSQPmX1jyBtbv+bU9l+0gnCb5oeljQJJ5qZHh1MhP+DlXbwgEEYLHtHpLlUmgRvh4yVB6CvHz7FFV8qBW99km0HtGYfhDQUihD8F4ZG1zp+B1oLBlkkc8ZxrOkNUOJnapXG8WY/rIGo8NRwNwe+HrcfUyuo76nWczZM+Tr4YOVLZu94RmBEmUWgNQjZg4aWgnLgX42sjHwALRwD1T1eXxXQnHl871WhapMCsb9X+DXPxqf5ZnHj5uWWnyWwG7N2sL3WaVuawUYciMYQzWoeSKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq7bAFcWcte/ayE/oT37w8fAUL2BIGD0I4kbKdQnkkU=;
 b=tRh1Bkadx+zwI9DlWBVnPdWVTdWw0ur5XNv8tb/lU7xg4k/Ug13+QggaXiMu/TfwvQV4okDVHAY/Mx10YHufP3DhVlG9FUG6N8+6kvqOxJIkuvkXdwYzJfviu1GTNkgr2rMlXBpnAnfWM89tDQ1414j3qGsqJxrS5n41CDEz8J0=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 14:06:44 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::70) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amd/display: add non-DC drm_panic support
Date: Tue, 5 Nov 2024 09:06:24 -0500
Message-ID: <20241105140624.2897662-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: df0530be-ec42-4ca5-cf17-08dcfda314ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X59d6qjfTbaGekkuTiDs/BzQ8jjzWBlhj87fQ7Qsl1FrxpN+cUnjQNq5pQwE?=
 =?us-ascii?Q?nwQZdiL9+h3hh9NLTVQUpWOXe4ke2fbFtTXC9v6vOZN7KQXKSs+qVkkIdtq8?=
 =?us-ascii?Q?6ID9jLMt6zbd672+AJ8HKH9BBrQ+rOw61mRfSdPW/wT0a3K3FFkuhr5XviQn?=
 =?us-ascii?Q?l8VsjZ4ZYIGzptDOGIU70NIHedmqdjzIu0tVjHAdgIdRFsdpwX4+npJELEJJ?=
 =?us-ascii?Q?9hwAZap8pU+wT3HzRgbmmzg92pd1sf8wgZEniguWJ9STwn1ZvQekKAivOOlX?=
 =?us-ascii?Q?jv8oCe+qCq0PGhxBEHd5qzKOEMhrFa0NEV/JRTbhSJOnraqCkC5yveGxcukn?=
 =?us-ascii?Q?fKeltUiF1Yzltox/duG6WP+3orv6dMht5YhDXv7hrdFUoiWOK7ohIjxsvM5+?=
 =?us-ascii?Q?TZDa6gdEcBxjtz+lgTyWpTSeDlNDPiFQu//fYe4CDbaDfl7nrIWpdOjJpjmq?=
 =?us-ascii?Q?di+lS1xkOq2/Xz2tIg4bXN9kWBbmFTt2iGuKqXWio/Hq+1K5i0bSPFW62prj?=
 =?us-ascii?Q?dTbDmbK7nAvpz8PunFx715QBTBHPwboxexBzng7MHbx/RvEqTLVty1wxGZ7G?=
 =?us-ascii?Q?Y4TgTNjMS5+fYWPb2D16+6o44pBIFjqHHQOdUirlj9Uv4wyr20MRxvzMzJau?=
 =?us-ascii?Q?oReYF1UO1+K0NjTgxBvxsI9wJped9Y4Rc+rUshPsTd+KADU8TX6p85YVRAcW?=
 =?us-ascii?Q?3arVuuqqhWAvRjlxWFBlilRYnenMmMSQT0cgFM/LJQiCNYmd8z9D/y1u9yTm?=
 =?us-ascii?Q?nlCvXcMPQ5bcpjgud18mhze2yAZzhwL/u/oC0kcZ7FpfjasnHr0LHqSzC7yy?=
 =?us-ascii?Q?vLXlkJpBuibX/ydkFFcVXCmKrfGFAnAKDLQFbXzuLnn6flKzYemMERH6n4BZ?=
 =?us-ascii?Q?e58iWtPeiXjSTTULp6NSOixIb4z/rZ1dxL9yNrrCfkueCDsG8je1CTT2gqdO?=
 =?us-ascii?Q?TYQ180HEtRXaYTG4dtIjfluMad9UJCpTschXM+finOHdSMZpYcK+RGU+Fl0d?=
 =?us-ascii?Q?O2KLz7dhVnbsPKEQEN4010aq5boCpVGOR8Th2OIaXDoRgecP5AId/vPGSSaf?=
 =?us-ascii?Q?0fz0rYmDv7NgZg8qbM5W9ntJXKIk4BqalSN3SProWNad1ubTEuaOBBkbPBA9?=
 =?us-ascii?Q?uVPOQJx8YTxgxyS7oqsXF510hyX/r3Uv/qdbAjABuFXUYN66bGCgyq9QJx0m?=
 =?us-ascii?Q?kGLi+W/eMFe8grXauMTDa+Mtiss6VZd63D926g6bbnqFvBsCKZcbZH4kAte+?=
 =?us-ascii?Q?QZJRh1wGJ06FB2wLjtoM7X1f5JMWx1tQIl7UXEhpKfu4tOqg2+qpy7gvRkKK?=
 =?us-ascii?Q?IDCAr+GhYvvyzmLNANl+jvSMrzIkPhw6lMgsIZb1VREoU77TfjF97pU0Ccxy?=
 =?us-ascii?Q?Rvn3IvSirPwrCIhWaEx2klRBh0wI8gpxXX8ZMdnSAuDbEWdLzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:44.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0530be-ec42-4ca5-cf17-08dcfda314ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Adapt Lu Yao's code to use common helpers derived from
Jocelyn's patch.  This extends the non-DC code to enable
access to non-CPU accessible VRAM and adds support for
other DCE versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 26 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..a26f2381504b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2687,6 +2687,32 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v10_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v10_0_panic_flush,
+};
+
 static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2734,6 +2760,7 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v10_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v10_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..d02c754a92b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2800,6 +2800,32 @@ static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v11_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v11_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v11_0_panic_flush,
+};
+
 static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2847,6 +2873,7 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v11_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v11_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..fab1145254aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2602,6 +2602,32 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v6_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_ARRAY_MODE(0x7);
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v6_0_panic_flush,
+};
+
 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2629,6 +2655,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..a130d49da8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2613,6 +2613,31 @@ static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v8_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+}
+
+static const struct drm_plane_helper_funcs dce_v8_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v8_0_panic_flush,
+};
+
 static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2640,6 +2665,7 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v8_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v8_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

