Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E41C531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7DF10F1DA;
	Thu, 23 Jul 2026 20:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywnms92S";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCDA10F1DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL9XH0ney4TZ1gRYy2Csn3xgxQZcBE9Hl611ZMJGZyJhWf8HBDJG0qQz7XoNiamY5vTV+xMI3xjyqVpgAID3N+QmZk9aBfWBsSrzowNzDzoG5TY59NzrHkZlmm9FkeOs4hiA941Wzna5fQLvyjzchEZUTfKZsQU2GyjSLKVv9FTB1dcKE/hjzZZ/EDTgGz3iOg1M25yaFuFYhawU0ii7FVFfRvi3sUIB5ljDOlctdGviXxiS5Y1PC6em6OJoU8YTrD5gLi04Kw8L/Fe9APYAeSCTTOIMQC86uaYmQK7xIWCkPW3K2FLj7F+47lZaEfu8y/Dm209soBczsCXQyGLQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv3D4321bHrcaRwpy/S+jC1jYCPXtMjZITEfFwpuchc=;
 b=u6nxPxvLFNfuz4A//aS4mfQq/PdTIYK93FR68Jb3McMegHVgmGsrPuJnTxrsfy7AgYpa6J529E3XE9uIrJBke1pDfNEcGiQGVv5BACETzRV9sAHcrkTov2kom7Ig1gWx44PD7b0NNTr1byLMSMAfORfsiyI7V+dxjB1lu/ug9F48PkQrhnqBgCpNXL7NRiUJ2Nw7KJuiSW0YAywKNaVWzOnSuX/pNjo6jOw6FlNAKqv1Wd8sd5ktxyCaWJ7dKrSVJB7zjnGzwzZA0EhUK1zsmAOzu0/SbU3razkJEjB2DEgb1k8l5RdFAdTPqJdfl7PTvGr/IzX208Bg2g2hSPlxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv3D4321bHrcaRwpy/S+jC1jYCPXtMjZITEfFwpuchc=;
 b=ywnms92SfNz06ehCDm2DByVbJlrPHZUFyHNFXhjMi82lxZ4GMDss3wKSu3FnQsugTcAwyw0lBZmL1qKcrpmxGJtAzvvtg+ODJl2kLI6vMGQEeqRlDssQ4Kv8vdMhHDAoSInwV5QSXhNXXhlEUBkUJX2mOLEMyx6DIo7QLSIDGY0=
Received: from BN1PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:e1::11)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:21 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::50) by BN1PR12CA0006.outlook.office365.com
 (2603:10b6:408:e1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:20 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:08 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 27/49] drm/amd/display: Add truncated colorop tests
Date: Thu, 23 Jul 2026 16:13:35 -0400
Message-ID: <20260723201908.373300-28-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 423a2737-b4bb-4b68-1052-08dee8f7ae23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HDnksSRuCxPXgfo8sDMuhrB5g3hKnP14gXJahVaaT8Eh82rOwWCs/iY4QcN3ZNOSyrJ0Rl/KRjM60vsG5yulIVhM5ART+0PvAo8wSJiRQ0F1ikO06+YxByaQ1xAjzYeFJSv1D+Evfzwllrhzc7m/4PkL4UJUamzIZyWkiHjMwCssAFUGaZyiJ14Q0IMOlqFl0YEiSkpLfHieXzBTER2TWl6qgNV6qD5HYNMJk2XJJ7u3548jY+l3hcUa0EnRfk+5rmWU5rYHQoxJCu6rj3I+4DLQLnjBAVh+CAEKSNp1UOVhW4jua6ubIT5VcqNw98kfXfWNdSH7ojcy9+OXbhJ57AdZUPeX/ix3s7wYBXXq+Oe5pXHq5nQg6BKlnW+CKfp9zjkXR3I9eiZHWwY8+0/wqi+I0QRUhfkH1kbTJc3LtkO6rBerwNlog+3Eue65mQNIP3VQc1eiMYLrCZsuY+VKgiPAAJSt9BU6byXv6PPIXaMcA2JjwFycpb7ybuz834ocu5DWyFNOt3AbkmUC0+x022DAQNDh+lLD33LGo9k7cJZXI4NSt9eWHmyt9WyT/iFfwncVhInDfpaqVJIqjmc+aY08TzAW+ZNUwGtLh0mNt2k2DOEPMTbS7LmZWNzl1JgQwJU8zEDIZA+uRkH4U83StQ7K4U4DogHiaux4DqEIIL5Z0QCPBPfb2VfTAEFjJ2elab8lRD6Q/dxxYyiRsHEdIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IjS6mQSyh4yroCr/X2wD/RuhPYRbmK/7m5GSkmBmqMX9NwMKLxihyPC5snpSblTsnVGRg+Yq7ayqP/BHrg62L7+UMPgHlEATtIH9WW36T6QjwMn6rwIXbamT/3dzsJN1rQcTalBA08+daqyBAi7fmAGfxlHaJ6S/qA6rOljwxxJl71IXgrmJdjrgnuiT9OnvKoWJ74QalZHpmSZhFd7eAqKyhjmKKIlEcIp9aLQlz/U5CAT8RrVUUGbB4OyS2Q68YQwyyn7ESC5/zH3rc+PjCwx5gt84jDmU4qTudkPfxCllZd3Yf78idHfvkcPINEPBYbGpxbwdAtN043oa/ojOD4LyDeqslLxdOFwu4l39RPkYjlfzqinNYnCNZBnVVEjvSs0vfn6dEm/nFDBGAQaDl880JdQyelzZ/6sHQoBvwQWWUUK/tMsJf1U+fmFaxVJd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:20.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423a2737-b4bb-4b68-1052-08dee8f7ae23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

[WHY]
Truncated colorop pipelines that end after the 3x4 matrix had no
coverage for their fallback exits.

[HOW]
Exercise every remaining pipeline length with bypassed operations
and verify that the plane color stages stay disabled.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 025e408a8ae6..11d42ff59dff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2581,6 +2581,57 @@ static void dm_test_update_plane_color_mgmt_colorop_missing_3x4(struct kunit *te
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
 }
 
+/**
+ * dm_test_update_plane_color_mgmt_colorop_truncated - truncated pipelines fall back
+ * @test: KUnit test context
+ *
+ * Covers each pipeline exit after the 3x4 matrix while all present colorops
+ * remain bypassed, avoiding the floating-point color calculation paths.
+ */
+static void dm_test_update_plane_color_mgmt_colorop_truncated(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,
+	};
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = {
+		true, true, true, true, true, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct dc_plane_state *dc_plane_state = f.dc_plane_state;
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct dm_crtc_state *crtc_state = f.crtc_state;
+	int count, ret;
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+
+	for (count = 3; count <= ARRAY_SIZE(types); count++) {
+		f.dm_plane_state->base.color_pipeline =
+			dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass, count);
+		memset(f.dc_plane_state, 0, sizeof(*f.dc_plane_state));
+
+		ret = amdgpu_dm_update_plane_color_mgmt(crtc_state, plane_state, dc_plane_state);
+		KUNIT_EXPECT_EQ_MSG(test, ret, 0, "pipeline length %d should fall back", count);
+		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+	}
+}
+
 /**
  * dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw - no 3D LUT skips 3D ops
  * @test: KUnit test context
@@ -2766,6 +2817,7 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_bypass_pipeline),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_multiplier),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_3x4),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_truncated),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw),
 	{}
 };
-- 
2.53.0

