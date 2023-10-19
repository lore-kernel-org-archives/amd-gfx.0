Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA798CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBA310E4F1;
	Thu, 19 Oct 2023 13:34:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BEA10E4F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYayAW6PhBOhQwrCDIt7lfaCduPU1KTmlHV2uodq3I/4F6Nctz6DKbnBRgaGFbWuhJN3UyaHp8z0M7ixaCEpkUoS3qu0g1ud3iNOhEU/R6XZU1C3y0LIuXz5HqzgKJKrO2HZKRxplmCqjT6rZNsG3NJPWaDCk80ZYoKxJd6x+CSo/s2WmjC/u0dqR0j1SFQcNkdtbqteGR1PmlA4pMkbLPABDPXrvxezGB4aB45NzeiqelrtLgSdzaR4KjH/bE65+VEqLcmxWVAf6VyVr6Fk5VGWsBjNAfDhzPZo3i5PurelN56oIJO1xdqCtBJe62h1hTwzFPIGOgA6GB12B71tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WlmCPuwM2Rl2BUzKsnzYiSEl6slirDN9z481MJQ0r8=;
 b=hfGR8pyMeAqKwETZF0YbsWUxUVK/zmZi9X2vhqbZnzPyWc6hOl2VpbexnQ7u1ouDxmKRlhgncy0tcvomjQG0azqbkjXWwMZGmxOYF660Fu8HvGOoMhbLjz2FDmgvhWcylfGjl4d78kcg1cBEVRcUUlT6Osnl0APU/uH3nKjThMKhQPeBqr1u9OOhAJyk8KKS/5u07+S19bN/p78/JORgzu9Hl9OHlkkksQmJoCs29nTmhWuFQzqiDJUkCLJ/LSf0QahPXio9sHW14Sufmx2Kt4burbgzEhB9s5SpS8Gp0JdrtH5BeucpTR0qhhY2E623TDxYcYl/CwLNdlTbGHwc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WlmCPuwM2Rl2BUzKsnzYiSEl6slirDN9z481MJQ0r8=;
 b=lhTYwVT6HNSHP6rCxyKQx34in8LcPU6v4nzQIQ2w58Cc9JbkBpOMzEfd75Qobzk9W/O1yTX+TMclnY6iyqoj7WXMTGbFlsqiQK/bo6YLHLGPgwC89XounB06KtNsT1E7pibjkBWvdMP716jbYtmT7UQHXBK1wqAehYGyC11CWcE=
Received: from MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.41; Thu, 19 Oct
 2023 13:34:18 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::9b) by MN2PR08CA0020.outlook.office365.com
 (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:34:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:16 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 16/24] drm/amd/display: Add prefix for plane functions
Date: Thu, 19 Oct 2023 09:32:14 -0400
Message-ID: <20231019133222.1633077-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f78d30b-286c-4faa-19e9-08dbd0a817e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEHs7oAiZVA3ZVUumk/ZYz/rT9g+tE4xVi+4eB07OgaT++YD+TufHA5BsIufLMQOHEvWqCNXtsp7E0Q/NbC0QQX2kqt8fzbjyET+3cAFXY5sRmh02jTE88YBXZMugwgcuFuTFtxdgglDAm7NK9AGPBYOLiI1jtbJiaZDhbMQlKPKlpPC0VI8xYTdCyPlnl53a9Z/Gf7DFpInUgsvPaq0QlM0vTOYjwSv5xS/0xUHBNR6aFrxaIGZ6Wo+k8PuYWBo3Nlzs14VLJ02r5SAfARbwutt64kG5xALKTCj96Y5kWjZNM6iRQnpXZiNwLPVoNQh5KAxJPnIw1A/8mxx9Wfs9nDZ0PVowBpPUP7tK9MDvZkMYF4mqWMF2uebwDa91RqOArgxWFAv+ZABoXCo+SISH4TG7NlgbVYnmV50z2E8TkGZkjvHTJTsEtBwAKhWao4bo5xGiYk5zGSTO5b6eWt6ZnWav3ivNRNeZnzQq2T8r6uMu6GPiEI8W6W/EDmL5bWKeKtl+YqOxvUzh2QyByW0OyOdCVs8zOIiI3rANQJXUeUgB3nv6+UUhEO/40V7HVWxqjEo/cC0gyNJwLxKLrFEqx/y6PvkeK08BojuERV/JdDyNCSCtv7DDEWj8Zj8uV9YsziJizaBDV0OgOpUASvtHSAMeSVm0tsAJbEr9u6dCU7MKvjDVW0qY11NJur6+9YbNjXFjBZ32XREv3SZkflKU6ic0rM27NWTzmOvfR0TPzHpYDe9LH3L66ZqpQbzaHYIYCwvP+mdOE51gRB/b0kRLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(30864003)(47076005)(36756003)(8676002)(4326008)(41300700001)(2876002)(86362001)(83380400001)(1076003)(82740400003)(7696005)(26005)(81166007)(426003)(356005)(336012)(36860700001)(2616005)(40480700001)(6666004)(5660300002)(478600001)(8936002)(70586007)(54906003)(316002)(6916009)(70206006)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:17.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f78d30b-286c-4faa-19e9-08dbd0a817e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

This commit adds the amdgpu_dm_plane_ prefix for all functions in the
amdgpu_dm_plane.c. This change enables an easy way to filter code paths
via ftrace.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 542 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 3 files changed, 275 insertions(+), 271 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 23088ddac649..cc0c819506cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10144,7 +10144,7 @@ static int dm_update_plane_state(struct dc *dc,
 
 		/* Block top most plane from being a video plane */
 		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
-			if (is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
+			if (amdgpu_dm_plane_is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
 				return -EINVAL;
 
 			*is_top_most_overlay = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 03df26bd8e83..116121e647ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -139,7 +139,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 	}
 }
 
-static void add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
+static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
 {
 	if (!*mods)
 		return;
@@ -164,12 +164,12 @@ static void add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_
 	*size += 1;
 }
 
-static bool modifier_has_dcc(uint64_t modifier)
+static bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 
-static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
+static unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -177,8 +177,8 @@ static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
 
-static void fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
-				 uint64_t tiling_flags)
+static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
+							     uint64_t tiling_flags)
 {
 	/* Fill GFX8 params */
 	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
@@ -209,8 +209,8 @@ static void fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
 			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
 }
 
-static void fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-				  union dc_tiling_info *tiling_info)
+static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+							      union dc_tiling_info *tiling_info)
 {
 	/* Fill GFX9 params */
 	tiling_info->gfx9.num_pipes =
@@ -230,9 +230,9 @@ static void fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
 
-static void fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-				    union dc_tiling_info *tiling_info,
-				    uint64_t modifier)
+static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+								union dc_tiling_info *tiling_info,
+								uint64_t modifier)
 {
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
 	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
@@ -241,7 +241,7 @@ static void fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev
 
 	pipes_log2 = min(5u, mod_pipe_xor_bits);
 
-	fill_gfx9_tiling_info_from_device(adev, tiling_info);
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, tiling_info);
 
 	if (!IS_AMD_FMT_MOD(modifier))
 		return;
@@ -258,13 +258,13 @@ static void fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev
 	}
 }
 
-static int validate_dcc(struct amdgpu_device *adev,
-	     const enum surface_pixel_format format,
-	     const enum dc_rotation_angle rotation,
-	     const union dc_tiling_info *tiling_info,
-	     const struct dc_plane_dcc_param *dcc,
-	     const struct dc_plane_address *address,
-	     const struct plane_size *plane_size)
+static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
+					const enum surface_pixel_format format,
+					const enum dc_rotation_angle rotation,
+					const union dc_tiling_info *tiling_info,
+					const struct dc_plane_dcc_param *dcc,
+					const struct dc_plane_address *address,
+					const struct plane_size *plane_size)
 {
 	struct dc *dc = adev->dm.dc;
 	struct dc_dcc_surface_param input;
@@ -303,23 +303,23 @@ static int validate_dcc(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
-					  const struct amdgpu_framebuffer *afb,
-					  const enum surface_pixel_format format,
-					  const enum dc_rotation_angle rotation,
-					  const struct plane_size *plane_size,
-					  union dc_tiling_info *tiling_info,
-					  struct dc_plane_dcc_param *dcc,
-					  struct dc_plane_address *address,
-					  const bool force_disable_dcc)
+static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+								     const struct amdgpu_framebuffer *afb,
+								     const enum surface_pixel_format format,
+								     const enum dc_rotation_angle rotation,
+								     const struct plane_size *plane_size,
+								     union dc_tiling_info *tiling_info,
+								     struct dc_plane_dcc_param *dcc,
+								     struct dc_plane_address *address,
+								     const bool force_disable_dcc)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
 
-	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
-	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
+	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
 
-	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
 		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
 		bool independent_128b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_128B, modifier);
@@ -347,60 +347,64 @@ static int fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
 		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
 	}
 
-	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
+	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
 	if (ret)
-		drm_dbg_kms(adev_to_drm(adev), "validate_dcc: returned error: %d\n", ret);
+		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %d\n", ret);
 
 	return ret;
 }
 
-static void add_gfx10_1_modifiers(const struct amdgpu_device *adev,
-		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
+static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
+						  uint64_t **mods,
+						  uint64_t *size,
+						  uint64_t *capacity)
 {
 	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
 
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
-
-
-	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+
+	/* Only supported for 64bpp, will be filtered in amdgpu_dm_plane_format_mod_supported */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 }
 
-static void add_gfx9_modifiers(const struct amdgpu_device *adev,
-		   uint64_t **mods, uint64_t *size, uint64_t *capacity)
+static void amdgpu_dm_plane_add_gfx9_modifiers(const struct amdgpu_device *adev,
+					       uint64_t **mods,
+					       uint64_t *size,
+					       uint64_t *capacity)
 {
 	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
 	int pipe_xor_bits = min(8, pipes +
@@ -421,163 +425,164 @@ static void add_gfx9_modifiers(const struct amdgpu_device *adev,
 		 */
 
 		if (has_constant_encode) {
-			add_modifier(mods, size, capacity, AMD_FMT_MOD |
-				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-				    AMD_FMT_MOD_SET(DCC, 1) |
-				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
+			amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+						     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+						     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+						     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+						     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+						     AMD_FMT_MOD_SET(DCC, 1) |
+						     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+						     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+						     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
 		}
 
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-			    AMD_FMT_MOD_SET(DCC, 1) |
-			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+					     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+					     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+					     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+					     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+					     AMD_FMT_MOD_SET(DCC, 1) |
+					     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+					     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+					     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
 
 		if (has_constant_encode) {
-			add_modifier(mods, size, capacity, AMD_FMT_MOD |
-				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-				    AMD_FMT_MOD_SET(DCC, 1) |
-				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-
-				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-				    AMD_FMT_MOD_SET(RB, rb) |
-				    AMD_FMT_MOD_SET(PIPE, pipes));
+			amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+						     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+						     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+						     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+						     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+						     AMD_FMT_MOD_SET(DCC, 1) |
+						     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+						     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+						     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+						     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+						     AMD_FMT_MOD_SET(RB, rb) |
+						     AMD_FMT_MOD_SET(PIPE, pipes));
 		}
 
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-			    AMD_FMT_MOD_SET(DCC, 1) |
-			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
-			    AMD_FMT_MOD_SET(RB, rb) |
-			    AMD_FMT_MOD_SET(PIPE, pipes));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+					     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+					     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+					     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+					     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+					     AMD_FMT_MOD_SET(DCC, 1) |
+					     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+					     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+					     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+					     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
+					     AMD_FMT_MOD_SET(RB, rb) |
+					     AMD_FMT_MOD_SET(PIPE, pipes));
 	}
 
 	/*
 	 * Only supported for 64bpp on Raven, will be filtered on format in
-	 * dm_plane_format_mod_supported.
+	 * amdgpu_dm_plane_format_mod_supported.
 	 */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
 
 	if (adev->family == AMDGPU_FAMILY_RV) {
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+					     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+					     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+					     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+					     AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
 	}
 
 	/*
 	 * Only supported for 64bpp on Raven, will be filtered on format in
-	 * dm_plane_format_mod_supported.
+	 * amdgpu_dm_plane_format_mod_supported.
 	 */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 
 	if (adev->family == AMDGPU_FAMILY_RV) {
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+					     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+					     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 	}
 }
 
-static void add_gfx10_3_modifiers(const struct amdgpu_device *adev,
-		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
+static void amdgpu_dm_plane_add_gfx10_3_modifiers(const struct amdgpu_device *adev,
+						  uint64_t **mods,
+						  uint64_t *size,
+						  uint64_t *capacity)
 {
 	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
 	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
 
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs));
-
-	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+				     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+				     AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				     AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	/* Only supported for 64bpp, will be filtered in amdgpu_dm_plane_format_mod_supported */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 }
 
-static void add_gfx11_modifiers(struct amdgpu_device *adev,
+static void amdgpu_dm_plane_add_gfx11_modifiers(struct amdgpu_device *adev,
 		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
 {
 	int num_pipes = 0;
@@ -628,21 +633,21 @@ static void add_gfx11_modifiers(struct amdgpu_device *adev,
 				  AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
 				  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
 
-		add_modifier(mods, size, capacity, modifier_dcc_best);
-		add_modifier(mods, size, capacity, modifier_dcc_4k);
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, modifier_dcc_best);
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, modifier_dcc_4k);
 
-		add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
-		add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
 
-		add_modifier(mods, size, capacity, modifier_r_x);
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, modifier_r_x);
 	}
 
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
-			AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D));
 }
 
-static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
+static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
 	*mods = NULL;
@@ -654,15 +659,15 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
-		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
-		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+		amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+		amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
 		return *mods ? 0 : -ENOMEM;
 	}
 
 	switch (adev->family) {
 	case AMDGPU_FAMILY_AI:
 	case AMDGPU_FAMILY_RV:
-		add_gfx9_modifiers(adev, mods, &size, &capacity);
+		amdgpu_dm_plane_add_gfx9_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
@@ -670,21 +675,21 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 	case AMDGPU_FAMILY_GC_10_3_6:
 	case AMDGPU_FAMILY_GC_10_3_7:
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
-			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
+			amdgpu_dm_plane_add_gfx10_3_modifiers(adev, mods, &size, &capacity);
 		else
-			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
+			amdgpu_dm_plane_add_gfx10_1_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
 	case AMDGPU_FAMILY_GC_11_0_1:
 	case AMDGPU_FAMILY_GC_11_5_0:
-		add_gfx11_modifiers(adev, mods, &size, &capacity);
+		amdgpu_dm_plane_add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	}
 
-	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+	amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
 
 	/* INVALID marks the end of the list. */
-	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+	amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
 
 	if (!*mods)
 		return -ENOMEM;
@@ -692,9 +697,9 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 	return 0;
 }
 
-static int get_plane_formats(const struct drm_plane *plane,
-			     const struct dc_plane_cap *plane_cap,
-			     uint32_t *formats, int max_formats)
+static int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
+					     const struct dc_plane_cap *plane_cap,
+					     uint32_t *formats, int max_formats)
 {
 	int i, num_formats = 0;
 
@@ -818,22 +823,22 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	}
 
 	if (adev->family >= AMDGPU_FAMILY_AI) {
-		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
-								rotation, plane_size,
-								tiling_info, dcc,
-								address,
-								force_disable_dcc);
+		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
+										rotation, plane_size,
+										tiling_info, dcc,
+										address,
+										force_disable_dcc);
 		if (ret)
 			return ret;
 	} else {
-		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
+		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	}
 
 	return 0;
 }
 
-static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
-				      struct drm_plane_state *new_state)
+static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
+					     struct drm_plane_state *new_state)
 {
 	struct amdgpu_framebuffer *afb;
 	struct drm_gem_object *obj;
@@ -928,8 +933,8 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	return r;
 }
 
-static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
-				       struct drm_plane_state *old_state)
+static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
+					      struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
 	int r;
@@ -949,7 +954,7 @@ static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	amdgpu_bo_unref(&rbo);
 }
 
-static void get_min_max_dc_plane_scaling(struct drm_device *dev,
+static void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 					 struct drm_framebuffer *fb,
 					 int *min_downscale, int *max_upscale)
 {
@@ -1030,8 +1035,8 @@ int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 		}
 
 		/* Get min/max allowed scaling factors from plane caps. */
-		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
-					     &min_downscale, &max_upscale);
+		amdgpu_dm_plane_get_min_max_dc_plane_scaling(state->crtc->dev, fb,
+							     &min_downscale, &max_upscale);
 		/*
 		 * Convert to drm convention: 16.16 fixed point, instead of dc's
 		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
@@ -1101,8 +1106,8 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 
 	/* Validate scaling per-format with DC plane caps */
 	if (state->plane && state->plane->dev && state->fb) {
-		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
-					     &min_downscale, &max_upscale);
+		amdgpu_dm_plane_get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
+							     &min_downscale, &max_upscale);
 	} else {
 		min_downscale = 250;
 		max_upscale = 16000;
@@ -1128,8 +1133,8 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dm_plane_atomic_check(struct drm_plane *plane,
-				 struct drm_atomic_state *state)
+static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
+					struct drm_atomic_state *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -1167,8 +1172,8 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	return -EINVAL;
 }
 
-static int dm_plane_atomic_async_check(struct drm_plane *plane,
-				       struct drm_atomic_state *state)
+static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
+					      struct drm_atomic_state *state)
 {
 	/* Only support async updates on cursor planes. */
 	if (plane->type != DRM_PLANE_TYPE_CURSOR)
@@ -1177,8 +1182,8 @@ static int dm_plane_atomic_async_check(struct drm_plane *plane,
 	return 0;
 }
 
-static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
-			       struct dc_cursor_position *position)
+static int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
+					       struct dc_cursor_position *position)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int x, y;
@@ -1241,7 +1246,7 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		       amdgpu_crtc->crtc_id, plane->state->crtc_w,
 		       plane->state->crtc_h);
 
-	ret = get_cursor_position(plane, crtc, &position);
+	ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
 	if (ret)
 		return;
 
@@ -1290,8 +1295,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	}
 }
 
-static void dm_plane_atomic_async_update(struct drm_plane *plane,
-					 struct drm_atomic_state *state)
+static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
+						struct drm_atomic_state *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -1315,14 +1320,14 @@ static void dm_plane_atomic_async_update(struct drm_plane *plane,
 }
 
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
-	.prepare_fb = dm_plane_helper_prepare_fb,
-	.cleanup_fb = dm_plane_helper_cleanup_fb,
-	.atomic_check = dm_plane_atomic_check,
-	.atomic_async_check = dm_plane_atomic_async_check,
-	.atomic_async_update = dm_plane_atomic_async_update
+	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
+	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
+	.atomic_check = amdgpu_dm_plane_atomic_check,
+	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
+	.atomic_async_update = amdgpu_dm_plane_atomic_async_update
 };
 
-static void dm_drm_plane_reset(struct drm_plane *plane)
+static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state = NULL;
 
@@ -1336,8 +1341,7 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
 		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
 }
 
-static struct drm_plane_state *
-dm_drm_plane_duplicate_state(struct drm_plane *plane)
+static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
 
@@ -1356,15 +1360,15 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 	return &dm_plane_state->base;
 }
 
-static bool dm_plane_format_mod_supported(struct drm_plane *plane,
-					  uint32_t format,
-					  uint64_t modifier)
+static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
+						 uint32_t format,
+						 uint64_t modifier)
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
 	int i;
 
-	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
+	enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
 
 	if (!info)
 		return false;
@@ -1401,7 +1405,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 	    info->cpp[0] < 8)
 		return false;
 
-	if (modifier_has_dcc(modifier)) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		/* Per radeonsi comments 16/64 bpp are more complicated. */
 		if (info->cpp[0] != 4)
 			return false;
@@ -1415,8 +1419,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 	return true;
 }
 
-static void dm_drm_plane_destroy_state(struct drm_plane *plane,
-				struct drm_plane_state *state)
+static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
+						    struct drm_plane_state *state)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
 
@@ -1430,10 +1434,10 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset = dm_drm_plane_reset,
-	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
-	.atomic_destroy_state = dm_drm_plane_destroy_state,
-	.format_mod_supported = dm_plane_format_mod_supported,
+	.reset = amdgpu_dm_plane_drm_plane_reset,
+	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
+	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
+	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
 };
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
@@ -1447,10 +1451,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	unsigned int supported_rotations;
 	uint64_t *modifiers = NULL;
 
-	num_formats = get_plane_formats(plane, plane_cap, formats,
-					ARRAY_SIZE(formats));
+	num_formats = amdgpu_dm_plane_get_plane_formats(plane, plane_cap, formats,
+							ARRAY_SIZE(formats));
 
-	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
+	res = amdgpu_dm_plane_get_plane_modifiers(dm->adev, plane->type, &modifiers);
 	if (res)
 		return res;
 
@@ -1520,7 +1524,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	return 0;
 }
 
-bool is_video_format(uint32_t format)
+bool amdgpu_dm_plane_is_video_format(uint32_t format)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 930f1572f898..b51a6b57bd9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -62,5 +62,5 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 				    bool *per_pixel_alpha, bool *pre_multiplied_alpha,
 				    bool *global_alpha, int *global_alpha_value);
 
-bool is_video_format(uint32_t format);
+bool amdgpu_dm_plane_is_video_format(uint32_t format);
 #endif
-- 
2.34.1

