Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BFEC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FEA310F1E2;
	Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2RW0j5z1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BC110F1DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weXfhONqwNUrNPn9saCt3g6lFtAMKr0J2Ef6RKDqX9FwvaqGUPzLHqsqu2ns5jaD19Q6M14tZUxUM12WPBYnYdYbNtxoVQnDAtRCXuMJsjFeFEV5cFJKMDBYiC9IVF6CXz6nLZEII2205VGiS25WZSXvjj6wWUHux1V/qyK6aE7suIA4O90qciOwFZ2hbYwyjY9VsI2A/Q2qFiNwkBaIZYdVxJDxa9ldIO3ISqIl9WIMXXaWs/Ze+ZM5s/Jwu0gFNREO/mgcZyApQ8at7vrvh+S7Kki6ry+O8CTXnZjX2WLRwA8uc9zYLQ6MJWz7TMGgxpWF3Ytj2pPOrdNsCpWZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vOD7sd0ZKnXvDwF8Fqn/IW1qr1iqkCfOuaoqTwIsuY=;
 b=kBjOZpH/cHdnZjhWput3j74W7uY9ygaXSOo8fwNx0HoVscMggygoePlgbNN9Z/5hu8daQDztlrFOEA44WpvVzdWtxP2JlLxuFgp+nzAkuvMcNJnSVmZ/Aubran+LolaTV4yqY/OFyYRCfhmv+pYb11IeM619giY14ehckdKjjVA0JRsdVIt8aQBYf1FUrzCdkt+kVcjpkHTieEt606pB/ok8Q4K7d2+GmgE4do7+UYFxk/Nxyiohu1sxgrtKbhWRTU2padfuz4A3TcugkE3ScaSRWxjZqn5aHkF6cm8tcM2u1MZzgaUXEg8yuiQ0tFp2x00aAKElw5mdaNbq5hOxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vOD7sd0ZKnXvDwF8Fqn/IW1qr1iqkCfOuaoqTwIsuY=;
 b=2RW0j5z1CVd0B185caY8NOJ8nwouhqXQCuU3cbjGbMZk4Z3wupiCWE2vt3IvgLMCYFeSiDgAUaWtMpJMj2X7ynkdg1TI6IB35cF2UartKDT1vyB3KECnuWToSX+CpgCdJflAd44zzutG9uH27f+YU6jg9sSJvNtVntETLEm7hdQ=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:20 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::a2) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 15:19:07 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 26/49] drm/amd/display: Add legacy plane LUT tests
Date: Thu, 23 Jul 2026 16:13:34 -0400
Message-ID: <20260723201908.373300-27-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eafe67e-117d-43df-ce33-08dee8f7adab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JyNhicYmLEX9Eg6UuQ+OFlyfcoPmbS95cElWvBCTyXra7eNlXjSmcSPb2/2iY/8bT3ksd3G0viYg3+W8KaTWWaYuaftyflyd4S7bTyqDDQmQJ7Rn/GyX2va2ieG0uyQZYlMDoUe80nzZXP651GF9TXp74voGSfLteAjIqY4FxKXzygmeDxYJUsogPA1DjWPnizzB85zbqkOikT6Ipw+qILaJrSe+0Vg0z5U3NBN3Mix0FiTQbdD0RvUHBwhDq3shPgN7iha+klKKWRY/RsD/pskYcL78SIZQ313zB15kH4lNcTseCX07V96opffiVX+c0t++yZsqbA/gWx42WZRMsWB9GGK3Pxw/94xSr1P1mmXlvk/ujBf/md/svTkO6PcZqazmzyDDtUzhKIAEtw3SciVSJohHThTYKJKp7CnlefF6wOBtZuicwei2h5WVl4Y6tNXr4/ziVuQpvvRWbAVvedwPTje6VBBnO8125xpkx1rp9sydcxYtcnJcuuogINxHqFLQE847q1vIc38K0Lf9QFoCY5PzGwFlKGUjOQiWMPnV/SoI2kF9cf+laq/BMhjlnW60f6ggsg05FBHx7k1XgQorOlqrG1Re14i5/WSjzKmvGv4bRDkB1sXdUBMre4Jfb6Oj8hdfkEQ2Yh4m42fGUxSCPXIrPKINYnlDvC1A+Rje3uo0L6oUO1cAPn6ac81Ydy+nlkpkCtEM1HtcrOoEiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rbMUS1EYP09n1QJgHf68tkk2hjCQlMUf25OeA9vr5/SJ309I6P+nTNsHLc88Jya0r+Pmk6H/836Top1MWjhcunhp8jEQMwrMVV2+L1wFMG+QnVk/Iu92094vOOXqFUbp4KqUrFSwQbkz9b07oGUhZdqX8yj8er6U3YWfKfMZVTLrYUTotOEp4CHi6l9Wi9PYItqUmP7mTg6orZpM8Kw4U+TnN6gzmnLWFYnvQsGzfBVkZrS80bataDbBFyUYHUj8w1p4VbbszKciJdYzDwnGrJQYaZ3RlTaeHyZSCLiAQtvjMrPNtCTw37MZ11pbK/GnuH1koDPUe7L3t9+hPQZptr3euGRsaPkKOIcU8i4DZWzaGpNYH3PbZg0L0gKAMBah4mh7MlfqFKvQr9d0vclHYpkBMUUyoSsk9hH96czUobCkrXb/2q36T0Yueaf2mNe7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:20.1035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eafe67e-117d-43df-ce33-08dee8f7adab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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
The legacy plane color path did not exercise successful shaper, 3D
LUT, and blend LUT programming as a single transaction.

[HOW]
Provide valid legacy LUT blobs and verify that all three plane
color-management stages are enabled.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 0835177c98d2..025e408a8ae6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2355,6 +2355,33 @@ static void dm_test_update_plane_color_mgmt_uses_color_caps(struct kunit *test)
 			0);
 }
 
+/**
+ * dm_test_update_plane_color_mgmt_legacy_luts - Legacy shaper and blend LUTs succeed
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_legacy_luts(struct kunit *test)
+{
+	const u32 lut3d_entries =
+		MAX_COLOR_3DLUT_SIZE * MAX_COLOR_3DLUT_SIZE * MAX_COLOR_3DLUT_SIZE;
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	int ret;
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->shaper_lut =
+		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+	f.dm_plane_state->lut3d = dm_test_make_lut_blob(test, lut3d_entries);
+	f.dm_plane_state->blend_lut =
+		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+}
+
 /**
  * dm_test_update_plane_color_mgmt_plane_ctm - Plane CTM maps to gamut remap
  * @test: KUnit test context
@@ -2734,6 +2761,7 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_degamma_lut),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_rejects_dual_degamma),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_uses_color_caps),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_legacy_luts),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_ctm),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_bypass_pipeline),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_multiplier),
-- 
2.53.0

