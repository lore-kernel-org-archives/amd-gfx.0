Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC5DCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2A710E4F8;
	Tue, 26 May 2026 07:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ud/jJGkB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB7E10E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPidyUV1UpdOAX8PZgv6qLNVScqTYe5e+cR4ocQmGKODtLTojFjYIiI34d9CeuUgS8DAEOCXW9JKcXF26NCnkSOxw/Me57YzFs7NCsU2CzvsCnLjjFaqXNUKpWFMVbX9oIRkJ9xqPofcL9Z98oOS8hF7sgoeFYRUtO5/eWuKTPbExuKKdOgxf9q3HSaMp6tGPotd9hovzvYInVLeTE8dg+7bGFfMO7gL93xGG6j/jN6hSa3Ybqe3d3xmNSLgM6JX/hWbPXBevkSRVAm79KCuOsKAU9EezxslUlEGKURyuszF+iW0T57fC3oOAyjblKeheCabNR6hnV6oc/3mlbhwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdrWag73Fi0PMd0wXcZKxh3m5wilqclYTec7x8XSbFk=;
 b=Fg7meld9sRKw3tOTN0g/ZW4YZTK61xPbatR7HXvp5ZcyrYpgmprdXZ1qb8iUflC9Ig1r+tRTnL5utcFqZL1BECDF6uNG8ntKJX9X5Tl+jYZz2/JLMhSr8XsJVlKuM/D1cvSeS4oQLkR5jYjs4i+5Pwq4oZQ7cylNUTIyaAlW2ehlGV5fZKXSZWrfZKIzhJ+H+cWU56+3sWA3iNW+vrd/+dF4wH0tCPWTL/PwqVUwPFkp08p94+15jIGqITRJtC6+yyqJyuKfw40K3FGNytCNJiD3OyvkN5opeBgMdB/zQoi0iCeqF7Hg/dsy2TaOhuks/RQxD33AfVneNHQLQOgTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdrWag73Fi0PMd0wXcZKxh3m5wilqclYTec7x8XSbFk=;
 b=ud/jJGkBqvZxFKAln5Q1IFalrQHz7b8+d9PfXlOvbd9idLCOarBDVpORKM90VCeCuS8V92IPqYPR11YhMiaBK1xlQb5Ykq6kErr6x6eX/FhfTjNzHG3wJOkBWP4hZdNcrvBEj3u5+2PFnfQ0Aypmg8GLDkmw6Gowwnp4rOnJmiw=
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 07:17:34 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::1b) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:17:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:32 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:17:24 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 22/41] drm/amd/display: Add more color KUnit tests
Date: Tue, 26 May 2026 15:01:45 +0800
Message-ID: <20260526071413.2181251-23-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b0566a-8ce6-4a25-2ab3-08debaf6db59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|3023799007|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pcmSjDEwl4LxpYGxSAK7XKfxCRa4MfICvbeVAOV16zzH3gcKA1YdBIQtvG8wLbUzoByCBav2kU0J5t/bBI9op1DoOZIgqZw6idNPyBDjJwCPjHI3G536bSUHN0t5PQC1UlC/M6ZomNBqK8aE/fVz9/CGL9j+XVgl/tpIExDvfucsexFzVZbt8ZdBM9XgS98x4U/+6UfAeb+dL8ZpQCoFVIuyGcrdL39/aPrzzo9RrTUVGpjSXQpdocwLlHpOVENw3ZL0bkXkwpZHRTuv0hwEy23+X+jcWzzlR5ewgGxjjC8AuZpYVBJXjDe9miM/VDOYMhf7ErLzSi05P7cbamdLUZgDE/RQIjxdk6ssXSqIKYydWM7pBL1jXpVFFuuKXhKe6q68wTn4HdwTlWqr96rZ6bH5OdEQ3Fp33sAeTgjTbbgPNkuy2JNPYhKFDR0AFTTUjTH/CwvzWHkLNboWiJRUNEuZpfcnrGx5PLCzIY4Yv0zd7nSLXd3ZitzvKEzbsFO4Emq09l/QHzOLgYxg3PlredmNrqcJdjPJikU4noKVf5Qf1TqnMWavQue9nBeVRYrWq8kBfNa35AdAYHFA2lJ/LSeuk4EfixoZAuThTDwyTRZXskTokl6gkoDT9yLk2CqpOEX2ukNB+wYo5NchK+qOZwpC2hEVpXZVBcG93np7rBxqjiFAqYnVKSxuzMRFsv9dMMdr9GCvLpNmwP4djqfLhFJfgjuHKrImHPE2P6IO6aw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KhVI9JEOofgCJCr3hgEJjRiGQXW43bGy7Eh6PmNWAb0KNxsFcjQqhFC30Pb9nmdkagVGrclSJEDvKGz+0+KkmNOpPmSXniXxN7EhRjpIkwf0huJLkzp5RVpCwTck2KO+tEQQjugd8phnKP1ot99ICA0BuFS5HPyM4sP7u521pW7EqzVgGZKy/VI7uG5nNcgawnB1Ty8xEkRa/HVmbrOg8YV4aegHuNUJM15SCTcYOZZ+3ZzvWlcNdyItIXL8e7gJe/sChTuzCgUTN6aRObsZcJ1+qp1RSwwDDcc6og4uBZlQTRZYWhwSZpaUfP664gZteEOWCBN97S6rB3HtCgfM2nCckkAsVvo4OUulBxXGoRS3rawn0O/cWOyMXEvA2x4hKYCsvNtotRleJU/zM7r+XqF5ARaN/s4ifq21nltW80lvW+bn7MV+/etoYF2fXopU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:17:33.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b0566a-8ce6-4a25-2ab3-08debaf6db59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
Add KUnit tests for __set_tf_bypass(), __set_tf_distributed_points(),
the bypass paths of amdgpu_dm_set_atomic_regamma(),
amdgpu_dm_atomic_shaper_lut(), and amdgpu_dm_atomic_blend_lut(), and
all three input branches of __set_colorop_in_tf_1d_curve().

Export the three shaper/blend/regamma helpers and
__set_colorop_in_tf_1d_curve with STATIC_IFN_KUNIT and EXPORT_IF_KUNIT
to make their branches reachable from tests.
Add the following test cases in amdgpu_dm_color_test.c:
- dm_test_set_tf_bypass: verify bypass TF setup
- dm_test_set_tf_distributed_points_srgb: validate sRGB gamma
- dm_test_set_tf_distributed_points_pq: validate PQ gamma
- dm_test_set_atomic_regamma_bypass: verify regamma bypass path
- dm_test_atomic_shaper_lut_bypass: verify shaper LUT bypass path
- dm_test_atomic_blend_lut_bypass: verify blend LUT bypass path
- dm_test_set_colorop_in_tf_1d_curve_invalid_type: verify invalid
  colorop type returns -EINVAL
- dm_test_set_colorop_in_tf_1d_curve_unsupported_curve: verify
  unsupported curve type returns -EINVAL
- dm_test_set_colorop_in_tf_1d_curve_bypass: verify bypass path sets
  TF_TYPE_BYPASS and TRANSFER_FUNCTION_LINEAR

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  18 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |  22 ++
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 226 ++++++++++++++++++
 3 files changed, 260 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ab0ed80c0e0e..cc03e9adf7a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -759,21 +759,23 @@ static int __set_output_tf_32(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
-static void __set_tf_bypass(struct dc_transfer_func *tf)
+STATIC_IFN_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
 {
 	tf->type = TF_TYPE_BYPASS;
 	tf->tf = TRANSFER_FUNCTION_LINEAR;
 }
+EXPORT_IF_KUNIT(__set_tf_bypass);
 
-static void __set_tf_distributed_points(struct dc_transfer_func *tf,
+STATIC_IFN_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 					enum dc_transfer_func_predefined predefined_tf)
 {
 	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 	tf->tf = predefined_tf;
 	tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
 }
+EXPORT_IF_KUNIT(__set_tf_distributed_points);
 
-static int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
+STATIC_IFN_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
 					const struct drm_color_lut *regamma_lut,
 					uint32_t regamma_size, bool has_rom,
 					enum dc_transfer_func_predefined tf)
@@ -804,6 +806,7 @@ static int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
 
 /**
  * __set_input_tf - calculates the input transfer function based on expected
@@ -1073,7 +1076,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_lut3d);
 
-static int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t shaper_size,
@@ -1094,8 +1097,9 @@ static int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_atomic_shaper_lut);
 
-static int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t blend_size,
@@ -1119,6 +1123,7 @@ static int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_atomic_blend_lut);
 
 /**
  * amdgpu_dm_verify_lut3d_size - verifies if 3D LUT is supported and if user
@@ -1496,7 +1501,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	return 0;
 }
 
-static int
+STATIC_IFN_KUNIT int
 __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop_state *colorop_state)
 {
@@ -1522,6 +1527,7 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
 
 static int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 6f4e97fe6694..e4f53b7bc753 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -36,11 +36,14 @@ struct drm_color_lut;
 struct drm_color_lut32;
 struct drm_color_ctm;
 struct drm_color_ctm_3x4;
+struct drm_colorop_state;
 struct drm_property_blob;
 struct dc_gamma;
 struct dc_rgb;
+struct dc_plane_state;
 struct fixed31_32;
 struct tetrahedral_params;
+struct dc_transfer_func;
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 /*
@@ -91,6 +94,25 @@ void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
 int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
 			uint32_t drm_lut3d_size,
 			struct dc_3dlut *lut);
+void __set_tf_bypass(struct dc_transfer_func *tf);
+void __set_tf_distributed_points(struct dc_transfer_func *tf,
+				 enum dc_transfer_func_predefined predefined_tf);
+int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
+				 const struct drm_color_lut *regamma_lut,
+				 uint32_t regamma_size, bool has_rom,
+				 enum dc_transfer_func_predefined tf);
+int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
+				bool has_rom,
+				enum dc_transfer_func_predefined tf,
+				uint32_t shaper_size,
+				struct dc_transfer_func *func_shaper);
+int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
+			       bool has_rom,
+			       enum dc_transfer_func_predefined tf,
+			       uint32_t blend_size,
+			       struct dc_transfer_func *func_blend);
+int __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
+				 struct drm_colorop_state *colorop_state);
 #endif
 
 #endif /* __AMDGPU_DM_COLOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 56eea0f5a75d..f943361b70e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1316,6 +1316,217 @@ static void dm_test_set_colorop_3dlut_data_forwarded(struct kunit *test)
 			drm_color_lut32_extract(0x40000000, 12));
 }
 
+/**
+ * dm_test_set_tf_bypass - __set_tf_bypass: sets TF_TYPE_BYPASS and TRANSFER_FUNCTION_LINEAR
+ * @test: KUnit test context
+ */
+static void dm_test_set_tf_bypass(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+
+	__set_tf_bypass(tf);
+
+	KUNIT_EXPECT_EQ(test, (int)tf->type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)tf->tf, (int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/**
+ * dm_test_set_tf_distributed_points_srgb - __set_tf_distributed_points: sRGB predefined TF
+ * @test: KUnit test context
+ */
+static void dm_test_set_tf_distributed_points_srgb(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+
+	__set_tf_distributed_points(tf, TRANSFER_FUNCTION_SRGB);
+
+	KUNIT_EXPECT_EQ(test, (int)tf->type, (int)TF_TYPE_DISTRIBUTED_POINTS);
+	KUNIT_EXPECT_EQ(test, (int)tf->tf, (int)TRANSFER_FUNCTION_SRGB);
+	KUNIT_EXPECT_EQ(test, tf->sdr_ref_white_level, 80U);
+}
+
+/**
+ * dm_test_set_tf_distributed_points_pq - __set_tf_distributed_points: PQ predefined TF
+ * @test: KUnit test context
+ */
+static void dm_test_set_tf_distributed_points_pq(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+
+	__set_tf_distributed_points(tf, TRANSFER_FUNCTION_PQ);
+
+	KUNIT_EXPECT_EQ(test, (int)tf->type, (int)TF_TYPE_DISTRIBUTED_POINTS);
+	KUNIT_EXPECT_EQ(test, (int)tf->tf, (int)TRANSFER_FUNCTION_PQ);
+	KUNIT_EXPECT_EQ(test, tf->sdr_ref_white_level, 80U);
+}
+
+/**
+ * dm_test_set_atomic_regamma_bypass - No LUT and linear TF: must take bypass path
+ * @test: KUnit test context
+ */
+static void dm_test_set_atomic_regamma_bypass(struct kunit *test)
+{
+	struct dc_transfer_func *out_tf;
+
+	out_tf = kunit_kzalloc(test, sizeof(*out_tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, out_tf);
+
+	/* size=0 and tf=LINEAR: must take the bypass branch */
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_set_atomic_regamma(out_tf, NULL, 0, false,
+					     TRANSFER_FUNCTION_LINEAR),
+		0);
+	KUNIT_EXPECT_EQ(test, (int)out_tf->type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)out_tf->tf, (int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/**
+ * dm_test_atomic_shaper_lut_bypass - No LUT and linear TF: must take bypass path
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_shaper_lut_bypass(struct kunit *test)
+{
+	struct dc_transfer_func *func_shaper;
+
+	func_shaper = kunit_kzalloc(test, sizeof(*func_shaper), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, func_shaper);
+
+	/* size=0 and tf=LINEAR: must take the bypass branch */
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_atomic_shaper_lut(NULL, false,
+					    TRANSFER_FUNCTION_LINEAR,
+					    0, func_shaper),
+		0);
+	KUNIT_EXPECT_EQ(test, (int)func_shaper->type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)func_shaper->tf, (int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/**
+ * dm_test_atomic_blend_lut_bypass - amdgpu_dm_atomic_blend_lut bypass: no LUT, linear TF -> bypass
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_blend_lut_bypass(struct kunit *test)
+{
+	struct dc_transfer_func *func_blend;
+
+	func_blend = kunit_kzalloc(test, sizeof(*func_blend), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, func_blend);
+
+	/* size=0 and tf=LINEAR: must take the bypass branch */
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_atomic_blend_lut(NULL, false,
+					   TRANSFER_FUNCTION_LINEAR,
+					   0, func_blend),
+		0);
+	KUNIT_EXPECT_EQ(test, (int)func_blend->type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)func_blend->tf, (int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/* ---- Tests for __set_colorop_in_tf_1d_curve ---- */
+
+/**
+ * dm_test_set_colorop_in_tf_1d_curve_invalid_type - Non-1D colorop type must be rejected
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_in_tf_1d_curve_invalid_type(struct kunit *test)
+{
+	struct dc_plane_state *dc_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+
+	colorop_state = kunit_kzalloc(test, sizeof(*colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_state);
+
+	colorop->type = DRM_COLOROP_3D_LUT;
+	colorop_state->colorop = colorop;
+	colorop_state->curve_1d_type = DRM_COLOROP_1D_CURVE_SRGB_EOTF;
+
+	KUNIT_EXPECT_EQ(test,
+		__set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state),
+		-EINVAL);
+}
+
+/**
+ * dm_test_set_colorop_in_tf_1d_curve_unsupported_curve - Unsupported 1D curve type must be rejected
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_in_tf_1d_curve_unsupported_curve(struct kunit *test)
+{
+	struct dc_plane_state *dc_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+
+	colorop_state = kunit_kzalloc(test, sizeof(*colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_state);
+
+	colorop->type = DRM_COLOROP_1D_CURVE;
+	colorop_state->colorop = colorop;
+	colorop_state->curve_1d_type = DRM_COLOROP_1D_CURVE_COUNT;
+
+	KUNIT_EXPECT_EQ(test,
+		__set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state),
+		-EINVAL);
+}
+
+/**
+ * dm_test_set_colorop_in_tf_1d_curve_bypass - Bypass mode forces linear bypass transfer function
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_in_tf_1d_curve_bypass(struct kunit *test)
+{
+	struct dc_plane_state *dc_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+
+	colorop_state = kunit_kzalloc(test, sizeof(*colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_state);
+
+	colorop->type = DRM_COLOROP_1D_CURVE;
+	colorop_state->colorop = colorop;
+	colorop_state->curve_1d_type = DRM_COLOROP_1D_CURVE_SRGB_EOTF;
+	colorop_state->bypass = true;
+
+	KUNIT_EXPECT_EQ(test,
+		__set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state),
+		0);
+	KUNIT_EXPECT_EQ(test,
+		(int)dc_plane_state->in_transfer_func.type,
+		(int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test,
+		(int)dc_plane_state->in_transfer_func.tf,
+		(int)TRANSFER_FUNCTION_LINEAR);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -1398,6 +1609,21 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_set_colorop_3dlut_zero_size),
 	KUNIT_CASE(dm_test_set_colorop_3dlut_nonzero_state_bits),
 	KUNIT_CASE(dm_test_set_colorop_3dlut_data_forwarded),
+	/* __set_tf_bypass */
+	KUNIT_CASE(dm_test_set_tf_bypass),
+	/* __set_tf_distributed_points */
+	KUNIT_CASE(dm_test_set_tf_distributed_points_srgb),
+	KUNIT_CASE(dm_test_set_tf_distributed_points_pq),
+	/* amdgpu_dm_set_atomic_regamma */
+	KUNIT_CASE(dm_test_set_atomic_regamma_bypass),
+	/* amdgpu_dm_atomic_shaper_lut */
+	KUNIT_CASE(dm_test_atomic_shaper_lut_bypass),
+	/* amdgpu_dm_atomic_blend_lut */
+	KUNIT_CASE(dm_test_atomic_blend_lut_bypass),
+	/* __set_colorop_in_tf_1d_curve */
+	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_invalid_type),
+	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_unsupported_curve),
+	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_bypass),
 	{}
 };
 
-- 
2.43.0

