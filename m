Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A1AC98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D690110F742;
	Thu, 24 Sep 2026 18:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/28/fpT";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1169E10F741
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpwQR0Bxp8GjeSdW+JuiYdzHDrfmdKagjfO6gRrdPbyfpnHu8V+tSzqUCnUZobSGJnQBs2sVe3q23+dCdWi7tD6nZyhpPQtx8UMvZ9aO5VdpHB9KkIt/9HG0rMUSa/D2MLUWKaLgK3BeunKxHSuEe7j6L06gPnx1OajL3u9+OXxJCc5nlGEOvK+OO9eVBJOfGWj/pvB+ZxFjL+/UbsKkHSXF/Og38Tycs5DsF80vlEFhSVg2rloWjw9DdHqUAabCw65W+JAfKRXhb7zCrucUMesqKRrO3CF76B194aXoehyi/I5fjzlnbTiRLJITf0GKaqNLGDJcUG0Lh6gDsuKT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv8uLZgP/78MVTbfN/4tpIdcizluHvXaUyHu1gz0hjc=;
 b=LCSxYwZMHfh6SftebwHrEwiuLdVC3Z4/XYFwJ6BwfCcVuyia2ZMq4UVpYukMw2pNm0k5bbcck9HLiJNBGlwmRPk8KlBudDKUriJcQXFSDCIhoNf5HFeZo3GereDDbMjMFo7LQJaFG+o7ntxgLpqap5ecV7CooluGnps0qoBIZC1xyfwrN/oWkJzBaLea+Jeqtc1lNz0Md1MPeeRBgbpdDlGIQY94qWBitepDibnPCvB63i8eeWiPZt7e5Vm3+v8q/6XTZ88zoDuWDzJ0LR4H3zDtrMiteURS9G99X2fDeyl3ISaqjhGjNU6qL284yZsWt6sutPbjLnHcq9gT77Sczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv8uLZgP/78MVTbfN/4tpIdcizluHvXaUyHu1gz0hjc=;
 b=o/28/fpTCJMy5+86ED9zvO36T6uMTobRYLsJmd46nPzk2ZIf+NUQwwC1UhpinMTG4zCTeObKYeHEFQvmnenop8+Jz0RsH/ydhMNF3EJgHrtEVL15ED4Z/d5Iauaay25oILdfmJs2kFVKlFtD5Fs+iVmRyhB77p2Dp47E6lLaS3Q=
Received: from PH8P221CA0049.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::6)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:40 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::94) by PH8P221CA0049.outlook.office365.com
 (2603:10b6:510:346::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:39 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:20 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 27/34] drm/amd/display: Attach blend mode property for alpha
 planes
Date: Thu, 24 Sep 2026 14:45:40 -0400
Message-ID: <20260924184824.596894-28-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: d87f819a-b586-48bf-ef4c-08df1a6c2b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q/YOWl9OckqcF01LZoXkNUp7qDOLRQbj/5VYhu+qjQjVLrp9vlJpA6wZXZheXxObQOV6LJzg84onvwfzsG4YxDxF7QMwKKg511y01Gp4NzrdoEafzpps9IRj7rFvFvSFLtT0xDvg+WGF5i7bsLjEiW9jcuC79hMA7kxmURTfJhvpzJthmsBuhaOXsHmS5gwVYXfH9BCWqbRFbR+8qWNQ9ZBXH4WSHxeQqXG55fGfShntniI3Uuizd6cr3a4pvlPSmwbj/v+Jm5NRV0PfgeL+irQbgUI7eEd0h2YFW4L/xHfPm6whNsktRfTrBUUyKX5fWOHSRsM5UVc3x56HXeQOXvvM7s7TOzrVkT/yHXL82j1ppUDkcbBdPJjs55VnJ837uSGRGXHyPfLWzj2SUTBK4bbQ7YOnVtmObuulCYbkHkuRE88xbF+aB8EhigYm2Qv2z/eucLsm4RaWK7MINg7+rTYA/c92n7oroLlpHadIYCkf5KCzm9QVLklDAEOv+eloQeJADySUOWD3vGjkdpO3BG72O64iXGP01l4T2omsUlebo0UjAmYMgMoJ1PsuIE+qjK72u5KSMIHcmYR4ZkMSaCOjp+kDD/35J4la8YxbpsU7vzUjGWmjP2Yvcv8ClTg02ofHK3Kx/mwaOKch5VXkrD6zzkAxe1eQN6sUPLZNSoYbnL8i5FtEwVYlGAuEhyTDCBRG9YJSycQQoH+RKfao0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kZnhJa6YKd0D0yzLYeCdMxX027KPK/FToBg2Cbcf9znU9/Y+BRue9Fe1n4iXTk0MuKasaAcIXMYsSA4XdcSMvuPfHMpsM9BcN5YTNpxStwh4Oj20CAV/2Z3Pxw7MvQFiiSadGkcJAGTFokC+Tzu2LYSraq4YwGyXrUjPBO+rigpoue/gexHbuzanO7BuPnBSTFmc+vWn4yhELFren23tWGE44baEE1+z98vs0eZcr3CK1pvzxJ0dm683rkAXJTWfF+C7gP8oPRuLouZ0rvuBiPH5BKAfZ84trBfuv/Bvlf4C3jV2iHCQc66w6uSR/xkB53dHmmHnGt/gegIs0A8qBaI+3k1WbIfrej9yhuiF0F1HK82woUFnB/vqqTk48LcyXDYT5rO7jjhwN8henWZPa3EuH4aB1kG9k/2r2EH5X4TUqRLu/t0GeVZT5FZ/04Wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:39.7616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87f819a-b586-48bf-ef4c-08df1a6c2b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
drm_mode_config_validate() warns when a plane exposes an alpha-capable
pixel format without a blend_mode_property. amdgpu DM only created that
property for overlay planes, so PRIMARY and CURSOR triggered the warning
on every probe and reload in kernel 7.2.

Create the blend mode property for every plane that advertises an alpha
format. Keep overlay-only alpha_property. Cursor advertises only
pre-multiplied blend mode because native cursor programming is
pre-multiplied.

Assisted-by: Cursor:Claude-Opus-4.8
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 6c1b2407f2da..590a015fc7ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2222,6 +2222,21 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 #endif
 };
 
+static bool amdgpu_dm_plane_exposes_alpha_format(const struct drm_plane *plane)
+{
+	unsigned int i;
+
+	for (i = 0; i < plane->format_count; i++) {
+		const struct drm_format_info *fmt =
+			drm_format_info(plane->format_types[i]);
+
+		if (fmt && fmt->has_alpha)
+			return true;
+	}
+
+	return false;
+}
+
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 				struct drm_plane *plane,
 				unsigned long possible_crtcs,
@@ -2252,14 +2267,8 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		return res;
 
 	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
-	    plane_cap && plane_cap->per_pixel_alpha) {
-		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
-					  BIT(DRM_MODE_BLEND_PREMULTI) |
-					  BIT(DRM_MODE_BLEND_COVERAGE);
-
+	    plane_cap && plane_cap->per_pixel_alpha)
 		drm_plane_create_alpha_property(plane);
-		drm_plane_create_blend_mode_property(plane, blend_caps);
-	}
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		/*
@@ -2279,6 +2288,21 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
 
+	/*
+	 * drm_mode_config_validate() warns about planes exposing a pixel format
+	 * with alpha but no blend mode property, so attach one to every plane
+	 * advertising such a format.
+	 */
+	if (amdgpu_dm_plane_exposes_alpha_format(plane)) {
+		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PREMULTI);
+
+		if (plane->type != DRM_PLANE_TYPE_CURSOR)
+			blend_caps |= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				      BIT(DRM_MODE_BLEND_COVERAGE);
+
+		drm_plane_create_blend_mode_property(plane, blend_caps);
+	}
+
 	if ((plane->type == DRM_PLANE_TYPE_PRIMARY ||
 	     plane->type == DRM_PLANE_TYPE_OVERLAY) &&
 	    plane_cap &&
-- 
2.53.0

