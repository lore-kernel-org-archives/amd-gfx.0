Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6F606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i35RruKs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B032010E3F3;
	Mon, 16 Nov 2026 19:29:24 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1D910E3F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wifAvrgwsYKc2GhdEFbtdFazBMaDAFVJUL4IWWT3/li6zIsXjrcMsaNuFCpNuCpRvQHGwZYH9daCUgxs44c42YIqzWYq/OeVEJ67dr/jWoAcs6GULgeiYI7SK8xpAgw+ZaFmqYRoIfRkjl0OtnxMi/zQDN08rnFbEbV1A5h399ll/1D9iqaMjLjH3kmxPezxSgQf8VL8hUxrhqR/WSLuEOdvNwWBFokYQfPd63Y9BlncL7Bk0rGvT3o2VkezTgw+HXpCeMDtEL7q7A4NRm9OX89VqjhEhfF8Q6+isU8YsL7QCoxs7525IUvNFmM516pziNOeV7z1Z305fnUVWeMlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0ubmsO/8o1I6e/8A9077h8ludHoWwxMGSBqxerQV4I=;
 b=OOMjNCCiCDUxy0aBqiqwbCXTWzDq8UsJTZCHPBlvjZAm9r7KXeuMF3F/32mGxtOoUPpLgoP0PefnrauO0wbAJAVWu/fdIYp945JtOMitsD7Pjo2JoOW2A6kgbQfKlPCrebrkEoYaCH45rVysYezE0A/8N9Md1WWF9GG3To5SoJq6D0UZiJ7RoxF9Xq3jXHIkhsGuF5ndLMK8/3nwUs6PBA/T5+UYFMxQi/m9g0I77QEDBJ73YWe8yzCet0pbrputcxYms1Q0hpdQgPZwgF/SA61scOlgYgTORVeeETDTZ4s+/CYPYiKxKVa59AUaYU1cX6ps1gxfC0oeG2xHh3bA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0ubmsO/8o1I6e/8A9077h8ludHoWwxMGSBqxerQV4I=;
 b=i35RruKsPaU2gHCM5yEqQ7jmNUrhNSKk6HyLaSwCjnqxikknD8dOeYbu8M0hRJi81uLUb/19PHMKFcL+6S45X6/oZtVoGY3dW55tDTpVd8g6k/E6vAd+awTLosVOFBvrDvYesUJpADvjfbfI3ioxZOI+YdKsq4GoeG5v51my8sw=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 16 Nov
 2026 19:29:14 +0000
Received: from PH7PEPF00000006.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::96) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:29:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH7PEPF00000006.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:29:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:13 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:13 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Mon, 16 Nov 2026 13:29:10 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?=
 <viktor_jaegerskuepper@freenet.de>, Dan Wheeler <daniel.wheeler@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Alex Hung
 <alex.hung@amd.com>, Leandro Ribeiro <leandro.ribeiro@collabora.com>
Subject: [PATCH 2/2] drm/amd/display: advertise PIXEL_NONE and PREMULTI blend
 mode for DCE
Date: Mon, 16 Nov 2026 07:59:11 +0800
Message-ID: <20261116001326.2360302-3-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116001326.2360302-1-PingLei.Lin@amd.com>
References: <20261116001326.2360302-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000006:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 06668985-1789-43ea-6d64-08df4417e60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|6133799003|13003099007|261026121527099003|11063799006|261028144727099003|56012099006|261026140227099003|261021121427099003|261009223027099003|261021123027099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: V4ngQpLlTSxZL5Wdjkcv1UD8qdcWFiDrdnpFla+ha11EfM54CspP3QY40b4PB2I6OmnkQ7S1s13w+l2AajAf4baggPjjvPBl6yJpntuWgiK9pYUm0zcV1Pwrta3lF9Ki0zU+OjQM4sF9j0Zm/ltitg7FyB/xhBvMy/1UTfmHikkxaa7RQPYOKkVkXFph8sYSlOdwab5hAYy1sITuwEAxoN0EG7Nh9XlqBfOLhKnvFO0NeR7x9SAeNDoZ74jmdR6/QJ2k1HMKCosNOkOdB8a+fnBiqBuwybmQx5BV69nqK7kUpfadpELSqbn32QstSBHMmWvglvJOWE9x8R71MAk7YmOP9AJP4gcR+ribwI7RxsbpcLKY3m0ep/EQmA8s55b/LQrKWG3+VkTVNcQA9bJwuJnUHCknzhZQtZ0N3Y7uH6vcpFlI4YEp9qBJ8C5UrUQuecmojqXvb2tg4yUF1rTVWLHRuLOV4MNZ9tb4z/crOAWvG+GAqm8GCmg/2saHE0QTRV+AU6oP0X67yeEQudagYWb9ukhKwIcj9EphMjbsVXlHhi8ynzPIdH5Io5iXyM58+jadlFX5r+8hPHIDKvyO0eMw7NEXrskTe5Py7Gz+ZK3mbevUFSEhmKDwVCOrlUwvhQHLs/tTrqgmJQB+nJ3igg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(6133799003)(13003099007)(261026121527099003)(11063799006)(261028144727099003)(56012099006)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fNglyp2dLJ3q2B/SRFbjgg8kq+Y2co3apTdAXc61/g23ZKmWsJqv99niEwYnA7u83PMGlHCH8JRjKLaGCrHMmCOHZfghd1V0ZJWb4UOLDIwitSz5KkrwplDhwwq8+uU8dI0fitkCv+JNQp6230nPsULq9E/zrfiJKbYPYFvctBAEtb8kweYBJziCjtU67aZ6L+Bx2KlaAtzXJvIj30rAZtP7xltqjTNYoMUMwuDs9KHexgo10RxLLi+mc8gt6lHL2yVQnGPNHvMlpuV4bS/uztAQBS4zyPPe+ImAVvCY0UAueRIJIupqYMfTV9oRBD1BYwb3Psnv6wXt/0uBKy/AGxtRSRas0w0VJYRGLtEJpZpSTAQrVdX1gXWDjOFSdQYbHQnwWQxgUc9PLSQCXZPhXDdqzyXERVWgMxqsiQvq4Gk9trqYV/tnE1i0/zWghEPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:29:14.3624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06668985-1789-43ea-6d64-08df4417e60b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000006.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Melissa Wen <mwen@igalia.com>

DCE can support PREMULTI and COVERAGE blend mode depending on its
generation, however current driver implementation either doesn't expose
more than primary and cursor plane, or doesn't program registers for any
blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
warning according to current DCE plane caps, create blend mode property
with PIXEL_NONE and PREMULTI for primary planes. As long as the
background is black and there is no overlay plane, PIXEL_NONE and
PREMULTI are equivalent, and PREMULTI has been the mandatory/default
mode for years, so keep it to avoid regressions.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com> #v3
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com> #v2
Signed-off-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260826104143.39077-4-mwen@igalia.com
(cherry picked from commit 332ad707e38fb82dd998b4d0782c15579e5784f1)
Signed-off-by: James Lin <PingLei.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 9d7be2fd29aa..db07b6d9110c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2233,14 +2233,24 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	/* TODO: Check which blend modes are supported in DCE-generation
-	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
-	 * property accordingly.
+	/* Blend mode support varies on DCE generations according to HW caps
+	 * and number of planes per CRTC. However, as current driver
+	 * implementation only creates one primary and one cursor plane per
+	 * CRTC for DCE (overlay is only created if
+	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode is
+	 * ignored across DCE versions. Keep PREMULTI to avoid uAPI
+	 * regressions: it was the default/mandatory mode for many years and,
+	 * with no overlay plane, primary composes on top of a black
+	 * background, where PREMULTI and PIXEL_NONE are equivalent.
 	 */
-	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
-	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
-	    plane_cap && plane_cap->per_pixel_alpha &&
-	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
+	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
+		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					  BIT(DRM_MODE_BLEND_PREMULTI);
+
+		drm_plane_create_blend_mode_property(plane, blend_caps);
+	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+		   plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
-- 
2.43.0

