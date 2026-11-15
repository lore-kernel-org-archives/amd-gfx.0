Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1A606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hlq2G/m7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D809D10E456;
	Mon, 16 Nov 2026 19:29:26 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1064010E96B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLQas7WmjSdHQtxNZS2ldsZKc0Y/aNcsZ09WKplPWSzD1F3ucepwNOMqRKHV/2//J1L2BRiLYmn58kPUwhNfNRmzwxE/ej7oC1gr+DWXxQFETvikh4qf/x5IwKJPkkJ9JxlIpem44Q9kdhWc/NyRB8Q9dAKoFn+vyhJmMuAdgr8cTyvwiFkdmnNezPBZRop+64dyOrHzhMlZlSzE0M2hRlI/b/DCVH9ZU/8bsDP5rCgwoYhqh3D9dN+zQPEY7OkmIuVWggSfc51fw4XsbV0TIjJ581slWR31x8h4jG4dEK7eZc7mt/zOJ2UMs66Zs1D26Q01db31LR2LmuacjbiAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq2fsyBIfMQsHQtPdO/qhnTVFawfm3yhT94UfZiI7bs=;
 b=WwOjmFvtHexgwrFdikl0y4gu8U2wIeFhHYI3edEiv0s20xLWh92U1EmEL4qWvWQH/uTo7Y17fUsPDYc0F+pnZ/ZDMmwjl45xr1Do+LkdSiPYeCEnRwchWOqLe402baiJCL3M9z5+R/yKsu2R0zzfAnKIhmLHp37e8EIk9/FcYAQs4CUiuQdqC2ydqr3ZqsbvsbvFT7F9RGCA3lPjtZn4B5wrdVsfjKjYSF9GMLEgPkpz+3Yz7P4C40c1BueOvuvK2fPlIvG4uNPU/fObSsPj1JFpAUot/XmPZ/Tp/pMS1DItlQUUTTJrM7FnDv3w0ktksgovb5teF2MFPKaT09VeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq2fsyBIfMQsHQtPdO/qhnTVFawfm3yhT94UfZiI7bs=;
 b=hlq2G/m7kQUXNyDLh6AqB9mlAANYT8MUaU33Pkg/1aZAOiXYoAOEESaBzvKF8VfW+zhfMFmVgJMrJdByb9IMi3C6+vEk3sGNmifclyR0SQO97J7+RTeyRXhBrOkyClplFGKks4u4x/cr4SoJm6V9X6F0ThQzhkn51sa4jMoCWEA=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:29:13 +0000
Received: from PH7PEPF00000006.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::11) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:29:12 +0000
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
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:29:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:10 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Mon, 16 Nov 2026 13:29:07 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Melissa Wen <mwen@igalia.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Alex Hung
 <alex.hung@amd.com>, Leandro Ribeiro <leandro.ribeiro@collabora.com>
Subject: [PATCH 1/2] drm/amd/display: fix missing blend-mode-prop warning for
 DCN
Date: Mon, 16 Nov 2026 07:59:10 +0800
Message-ID: <20261116001326.2360302-2-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116001326.2360302-1-PingLei.Lin@amd.com>
References: <20261116001326.2360302-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000006:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 875b21e4-729f-455d-884f-08df4417e492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|13003099007|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: Jw7j8FH2Q3ti79eFyZozUUSRP54ObmrNM1Ay/1aSZAkIxAIBIxvV6Z4codc10F1IG+4pteny6GMSsnTweoODzRdOpxw5Vqr69KVCeVaMmjXSp8fVx3q1ldjddyJng1vfx6LCFh29/DN2XT0XD/XTrV3p57GBm5sITCoDr4RwC0PYM5KWAGzgOZxfa5ALJYUQ5uUO9r8uiCVXV5MpCK5nGzrovmXOFb0GQpIlEYMJm2QEnTu5AeQtFvYnBoXWeR8Upkkq0Ykh0rKnqWd8N8sE+JLp3ZnHLLwMRH6Th9xDPxYlftCthsVD3QlTDQO8skqOPjhsR79MH+1gHDzMLPb3hyvz/nSbeM2NmZcfaCsVxOUjiEVbbp6iWPm9Grz1OBGGfuwz3Hrh4hIQHLj+tUGfD5EcXVq/MUgwI1jrTzamoj0RpwOJRlX8+cZKe4/ratkg+DXk9vKzSj74RfD8LVBpqaAOtGu/h1yTm3K0xncju0QNmDPpnWrPsFvVOvWBCoreVtFjhm7ILVDyPHVK/gZ4CBzv2YkTSXGcfFUjZAK60lQcW/xrlYQztoIQcOooBr0irsIfSWysIviV4cwCXB4z6rwu5+3Dw0Ca+bUCZw+8bzvFADT2dvqf8mM8w8x7bZNzGb9pR4cdITyXMbBzgTyilrU+kES8mykR6DZtXkk0xys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zmWVKr1ZkGGD4cOkRYSDKF1sIPjtQ54FSUPufmMRRQMzPHF8Z4y7LDcpHZNCSEWJ4S+neQV2/YX5rf+WzvanNhKsYcnVr5b6WsVk5Puq0IPRpHfTYQk/X0IAPU78JknNCeqvHIyUUeeVJ4UJHGZyo2flqK5JFS9J6f/YqTHXnKB0rTVMDnsqp8IKg5jPIDe8RyELyTlB7RTK9Q8LNodLOln7MTAUJrOvV5qrbWYp3P41etaSzt7XyccWIVCXKecBle84XPIredNr0Q9yr+Wo/XaG8Y3lGUODJrjW1/hbdHeBe7GtlbEqqIgxX0s1IKZxWp8DSnkwL0uDBzO2FpY3oDmSRXgYKNk4gOwq/jG4V3ZmonnRZ0ZkYiSJz/hGYxROtV/MuHJXqiN3i/mJQNRFHz+j7KFHnvZa+3hiPoskYoAWKLmtECzvpHfQybw3qEYw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:29:11.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875b21e4-729f-455d-884f-08df4417e492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000006.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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

validate_blend_mode_for_alpha_formats() warns when a plane supports
formats with alpha but doesn't expose the blend mode property. Fix this
by adding the same overlay plane blend modes to primary plane, since
they are all universal planes in DCN-generation. Cursor planes support
ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by
default (other color formats are not implemented), so only expose
support to PREMULTI, which is the default blend mode on DRM.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260826104143.39077-3-mwen@igalia.com
(cherry picked from commit f0c75da0a6b4084e00cd6faefebcc976ffaccf52)
Signed-off-by: James Lin <PingLei.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 06d9ff2c32c5..9d7be2fd29aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2233,16 +2233,31 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
-	    plane_cap && plane_cap->per_pixel_alpha) {
+	/* TODO: Check which blend modes are supported in DCE-generation
+	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
+	 * property accordingly.
+	 */
+	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+	    plane_cap && plane_cap->per_pixel_alpha &&
+	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
 
-		drm_plane_create_alpha_property(plane);
 		drm_plane_create_blend_mode_property(plane, blend_caps);
+
+		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
+			drm_plane_create_alpha_property(plane);
 	}
 
+	/* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
+	 * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode for
+	 * this type of plane.
+	 */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR)
+		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI));
+
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		/*
 		 * Allow OVERLAY planes to be used as underlays by assigning an
-- 
2.43.0

