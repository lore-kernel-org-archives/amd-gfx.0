Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B23D597A9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A928310E66E;
	Tue, 12 Nov 2024 21:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dF125cWr";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD9E10E66E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDiM1WDVfVii6aC4zmX3ihxHJ6LN2ri5MJWWQ1Bx3rWL115kJ1dmd0O866tGCrgv+e+EjYcRZwkvHktA4V7El0WWkCLbNGyYYWVoStcMmik3hWd/TgnM6V3R3YktR9yoBBU9mwKJSSY/hLikg99wl345/g5A6swCHZeVqRaZTPfiJloA2olxi9gXe+vjFhHeMW+BhJ6eEmZeEpAxkWaPfrXxiPQ3609XYZMh6fRVzmtYWXghdNsxBEFhyBIKZdLwQkV4zlnRcLMT7nH/90WWEtwe6wtdE7PEvnf/12AQ5eznIScSVPgY2QEcYo1QgLXpoVwc6yGcdP4Rq5wHUaKymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4n5HC5Jp5Cqju9a1kI5io6alnGeo+xcm5J4rTbAaTY=;
 b=GF4rzI4YmDm3+7JIJSsGUuzb1MZ7XUFat2RduducKjItpGBu5RA9SzWKEUtIQnYTGNf6Qz2jbLtdxjBLpCL1X5HPq2HY5/4suNbq7WdiJctkSCpwMm1u0TiROptW1rA7wBCYQGjnywKFsYdWk8ZEZMiBfgdFAcBr3WVbE3Rzq+4VTy85iza+pPIXsaQMaPpKA1ScDTkeDIG5eoS57+5B1fiRKClGZBQ3P3i2c51KQ+G2gxkd+oeiFHAskjG+hu2ONSC2jLTlHTPgev0yPm+0lAmCw9jGMCmitraHa4V2W5JW1ZeXhhASkZs09PWkPaAmW9KaAyc3i/OjkTw76a2juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4n5HC5Jp5Cqju9a1kI5io6alnGeo+xcm5J4rTbAaTY=;
 b=dF125cWrrpGFVnNOfowlEcEaNLhr4KuIc3hljEjRcSg/GotmxtoeIXt29ejFKQZXC3Yan1L8/ujTQ82KyjU4DesPP5Rag6GKy0/9sZem+4gilD200yjoBq6lT7HQPdRZMv7/iXGLNVSidYtPSPJiWPDmd+JtJbZRZxlPyJlXzYE=
Received: from BL6PEPF0001641D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:12) by SA3PR12MB9225.namprd12.prod.outlook.com
 (2603:10b6:806:39e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 21:37:37 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF0001641D.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amd/display: add DC drm_panic support
Date: Tue, 12 Nov 2024 16:37:15 -0500
Message-ID: <20241112213716.49355-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 515045ee-97ee-448c-5a2e-08dd03623a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNESd6+kXgVT3ZisAHn4emc8fnC8ev14cCeNNWM10Ph/V5xYei7sW4nuhs2w?=
 =?us-ascii?Q?VbvZIAFYrG6CR3CnWyxtaGblCwH+42fo1jgt2+I/kzwmiotejeuQnsSCKU09?=
 =?us-ascii?Q?mHGps2j6SMc/C7RCezv37oZK5JXe1pq0Ds55jsO2ojlxAKDe9naeJBB+J+uR?=
 =?us-ascii?Q?F6jaozOz2tuRqbfizgZ/0+3jXlPWufCW3KZQ6cuj9gMNuagozCxEgF4Q89sA?=
 =?us-ascii?Q?KrHWYMCBWyVYuh9bqbKZuGDABLkF9umXdVsy1iVU/gkaf/qfxpBmAT33h2sX?=
 =?us-ascii?Q?UyvM/Le+Gl4mSZBz6QPi03A6Nh4RhCrY8bjsAB519etbCijs7wz6hvmg9CWK?=
 =?us-ascii?Q?Nl4J8fdsWN/swLK929C7alD0PTtyzaHtdOGF31QL2w+/A8hql3wX4Po67nrx?=
 =?us-ascii?Q?rN8/Egg0GVOkjFQ3Q+tSaOft4TAtotW3sUxB4qmukNASBqkRWHfKUWTOjMrR?=
 =?us-ascii?Q?aLXzX1Phr0idtXLjzP05YYB6Y5SuEQDY/11rApXS5KjpcJPqKTCK0eNnH+fe?=
 =?us-ascii?Q?IoRSpcrltvlnlXPQmIYDDzGRPn/cE+ill07Z25Wa7fO5VWOAuK/fDILJHgjV?=
 =?us-ascii?Q?F/naDn3TJwAIyUpeT02P2YaXXqv6qJLAikJ5m8PDowtt/eVMduPFCE1VpEh7?=
 =?us-ascii?Q?8mKL/lh60jento0hJlOJULiOsFYhQcAIVaACGMQ2dKvtzxtLlcyNjOfK/Fol?=
 =?us-ascii?Q?0kIR23XVHKhyjl+HZSy4Y/RRcaEkKR2buDdLqrfuvS2RCVxjyppW8THx3hGu?=
 =?us-ascii?Q?34qoQL6yZMz7F7ZYQD17VpsRWM3liqtd2fVgjdh+sl5UqF90RghLqSV6frNO?=
 =?us-ascii?Q?1FovRtemRuecyvbINokiWNPbmCJlHhxaa8tuGipMp8semKpXU0nr9nvurd5b?=
 =?us-ascii?Q?zeWsLO+qpPz06+OBTKEhD7ddzyccxXXx6Yljazdm1PM1HL0n4i1nI7pRxJwa?=
 =?us-ascii?Q?EdbuBvOZl12kk1UX02NEn2643yvmbsxiGG4IAbG3zG2KyZ/HEd2GfOsV8UMd?=
 =?us-ascii?Q?s3sWrrBNgm9h3gp5H4J8VlOFMy5Gi7pygtwxdHQj3NlTzSFew12b+7XcZREf?=
 =?us-ascii?Q?1j0sRfyWFgHn4Kk5JJJoK0QEqDXIPkmbPbLj9aKyvZhu43CbO1MR4jUMYJuR?=
 =?us-ascii?Q?mHMR4h0h2tm557k1VDKR5yzyeB5n8ESNVmQTRMD2WVnrbtCMgEDp0GKmq4u8?=
 =?us-ascii?Q?ZG2oPAXAU8o3acssa2dZNEIPasd9mkOok97Db7q8PwUpvw/3DGRLQawMcswb?=
 =?us-ascii?Q?Xlfsk5ua1MHh/9wkNWY3+ES3Iw4aFHXDHgdFm9QzNX7mSF4QX6hIAh8jXyVc?=
 =?us-ascii?Q?wxCjiuRmWLrn36JglOmprVMiOS9BZZsjvA4LcNHmSSe8IlK2DHeo/6IIuwoO?=
 =?us-ascii?Q?ojAHhqzPYCUXafTwmXBMi7w5IJE7qlZqBb8NYOV1Z6TQ3s3rBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:37.1369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515045ee-97ee-448c-5a2e-08dd03623a10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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
Cc: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426..c10cabb8b42b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -26,6 +26,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include "drm/drm_framebuffer.h"
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -1421,6 +1422,20 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
 
+static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
+{
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
+	struct drm_framebuffer *fb = plane->state->fb;
+	struct dc_plane_state *dc_plane_state;
+
+	if (!dm_plane_state || !dm_plane_state->dc_state)
+		return;
+
+	dc_plane_state = dm_plane_state->dc_state;
+
+	dc_plane_force_update_for_panic(dc_plane_state, fb->modifier ? true : false);
+}
+
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
 	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
@@ -1429,6 +1444,16 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
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
@@ -1855,7 +1880,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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

