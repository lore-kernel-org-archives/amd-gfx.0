Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2692606A33F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JVlGbaNM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7393110E188;
	Mon,  9 Nov 2026 17:52:22 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F5C10E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 17:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNuta/Mvbaty+0H04Pv0dI6ilps+8nPo9bX6fwcDsDikHnF2CMRwLUN5FT/Mo+fZKydku275TTcygr929dEcJrmdfi02MXdcSexqTmB/YVB4hT8+SpTWFwKWK3wmGYbojt+SA64DdRpBptpSmYE2cDxNSQ35k2WknBa9TDNgEQpvBT56y7B1esoBWmlfBKx5w9BHmpPYbX75x93yNHi98w8i7+mriDOSigl6AsU3xd/PWD+pkMcWr8Eqvou+XI+wz6FS7AvGk5MZ0BFEZnlIgq8gBN2pIteug4F9GlIW45SDFA+crMOh65CI+ZbCpksFXG8fNIKSo0xW2i49Q7IOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCrFZYebWfuXXN5fc7iHSqL8dbgAlziDx1pCU2G2rJ0=;
 b=P6dtzF5lb4sCwVjCIskkIFz2nUPSjkvrM7hC5ZRmSAVZyPrvX/MSMg7NCr2rDgBN/zn3LPO9Sj5PLGKcMIgfv93epSd7PhCjSlgWE3FzLY9x8kXSTMKlDNfaTb/SyCzhfwuRtc9ig8PA6T9HN0TaafzqbLu3SyYVUh4+Q9ADiuBH5cF30ArXSHZeGRZKhBjvEoFCzfJzTCI1qORoUXXTsC/NzJ9Xdrf4GBoMuPnYTcRfm1vdiJ+v1/e82n/D6NlwlplgjQwWtm62T1MRBZdDOUiXVuqP2XvvVtQUFwDomerfkAh9OaXVH7vL93ZVGQpwLKOcU5Q16Wi12TopLQZZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCrFZYebWfuXXN5fc7iHSqL8dbgAlziDx1pCU2G2rJ0=;
 b=JVlGbaNMXOiEdBYdSmMetFmYYc9pzO7Ts8WHsWUMIfb43O36rOfTXSSwyfE6EGbJwwMDEHap7VQL27RXgNEQZkHc3V50LtOTGlqbUB6tJtBzEuKWbZ9dQoTRMlAPymSdJPId2+Ip/I/apjYiThSo2Sqf/AWvxGJwiEirY3C9aj8=
Received: from MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 17:52:12 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::45) by MN2PR20CA0047.outlook.office365.com
 (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 17:52:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:52:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 11:52:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 11:52:01 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 9 Nov 2026 11:51:55 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>
CC: Sun peng Li <Sunpeng.Li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, 
 Ping Lei Lin <PingLei.Lin@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH] drm/amd/display: Attach blend mode property for alpha planes
Date: Mon, 9 Nov 2026 06:36:12 +0800
Message-ID: <20261108223626.13681-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b323f-3f69-47eb-7e6b-08df3e8a2d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261009223027099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 62z/dSa/CrtQTFP0UW7AEDsMCxLp9xu0Mz5okH9iYWw8xY+UE2ngu1cjecm5kKHkVCgreMuhE/EGqqfU2CcPZlebUcDM9y7k8/p5Oe71zCiiPR0aSaMsXBBMQDSnmQMnaVHV1ZBU9SOokbNLUp/pFt7hA0kHKa+0FTeHzZpyocOFZj1MfaAopDja3Zj4qgcb/OSgcn2q6XvpRlmlnmUY/fVoJISOKZjdTXzDp3X+32PsjQKjC76yuoS/xN6LADOfUPpEL/gIoBeMnABVZnp2swJOhNabxFf7whSFKA+iyEJI8dyXG/vJVy9EiXpE0HEz5sk8OBYSQ+Phyt5yMka6NDn4FEu/xGKIq4Hpvcutv1uPWTnGOeCPb39RSA/N3Vippv8aNRiqStJ6bJRujZyy/m80Anp/nPm4P+XGSSC5ICKSQTXMVhnXugwL0Dxjovbg0ILtUBuCBZ6CPYo/Jmtj+/XLxQCry52ljvLM4U3uFTHSXR+bEBNwlbJ4QdLT/jX1mslqt7Wr5JXmtcvRlRHVHiUzIlUkVSkCrpjJ9oMPbZXJ17LbrvUWmpvakUm/m2/NUrSJmOMBmgf0a+NFiyS5ihvFogYub8b3yZtog5FzG/Q72atLn2el18Y3QNCo5GFUY1CyNrk+oh/xQ9Bj6hML2rOjZ5QDT0J+wMA5kyD3PY1SrIGsckuXzs9KR6nJdk9O+4VtlXp4tor27flQ3QKpZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7z2Oz3Da1QgC9+SvmuH5SbSpW7WiC/kMuSMA1icYV325d2fN8003CAE0cyf1X0YuZAgkXYtaEgZziAhrdWxGLUGYUU8DzPM81atIPC36v6SG0fTn753jGe/mv7W6qd0qtkvTS+DrlRi+kX5fPbNVT42IPiSXZtAwd9JdKElSU9EFkbmdDfr+oz5b9ZDfoTi4HCFxXHP87tymofgC67YBzvYRqMc07MxP60aZkkbajlCLgDarTLWvGF2bKcpBDUT7a00NIMPCN/l7nDIQ/fT4rvVOETOVFmX7U70okCSlphtLhJ9JXNwgTy6ZtwYI73tpGFt3RW7UHCRNg7YnwTXggIFRGKVtwi1fVRhGSP41EZfHakz9dSbjXElJBofHSXZiKq9F6fL7CGGtkP+g0faqbc6jQBcnZlLlO1YYQ74QcF43EuRYC0wqTD+XucXNG9Ll
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:52:09.9560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b323f-3f69-47eb-7e6b-08df3e8a2d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491
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

From: James Lin <pinglei.lin@amd.com>

drm_mode_config_validate() warns when a plane exposes an alpha-capable
pixel format without a blend_mode_property. amdgpu DM only created that
property for overlay planes, so PRIMARY and CURSOR triggered the warning
on every probe and reload in kernel 7.2.

Create the blend mode property for every plane that advertises an alpha
format. Keep overlay-only alpha_property. Cursor advertises only
pre-multiplied blend mode because native cursor programming is
pre-multiplied.

This re-applies commit 3f3139234c28 ("drm/amd/display: Attach blend mode
property for alpha planes"), which was reverted by
commit 07df8cb29c8b ("Revert \"drm/amd/display: Attach blend mode property for alpha planes\"").
As that revert log states, it "regresses blend mode handling due to
conflicts in drm-next" - i.e. it was a mechanical conflict resolution
during a drm-next backmerge, not a defect in the fix, and it was never
re-applied. The plane registration code therefore still matches the
pre-fix state and the warning persists, so re-apply the original, reviewed
change.

Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 06d9ff2c32c5..d6a51303ffb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2204,6 +2204,21 @@ static const struct drm_plane_funcs dm_plane_funcs = {
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
@@ -2234,14 +2249,8 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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
@@ -2261,6 +2270,21 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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
2.43.0

