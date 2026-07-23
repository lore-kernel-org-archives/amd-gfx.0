Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F94C531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1B610F1D0;
	Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bo4sDvIt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6419910E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH7u+/dtEo3RM5RDKeKWbU8xGubk70Ed0qdRAI39RMakDEei2W83IRXUbunJ7R/5P3VWlt2ZVLdeRPgzy/0CS/hUznTca9Uh4IwVZtpUiCrCvuFZGBMOdn+IRp6fEauVEtzHlBTg7//kWrAvMFcVnBpaZqYdZ0a5XKYF0kN7q+nmfhQ6TeJVHXqZ3+8EJXKo/hUZ/bwRFhv8ccvwxQO4yvYVUnYh5ww1+19M0aohdE7FFv0/ZhJO3AlYidsDwu0+ALY4CeMJimq3IEp/4IxpO/8v8z/GD0QUyUJ6HrtI0QPrsqF7iiEf2Uv/L5ucZ3h8yDecnspaIf+sGTRZZdCXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NRMRRUmw1wi0MziRszzqpiRhHJS358odgjb2QsOB+k=;
 b=h6iyAWBIYVLXtS/V0r3fyc8RXiaWV4/19wTXB395sGtzO7W/1iajxLmWiL0hgVJgllIeW7ymdZOr3IjCAWmv1bd777RB3en6M1LRYbx5r7lbRaaigRxB4lSoyXeIDklLXmrZlW5se7gAn0fPBfs9xUiTVFrOtvaHxiYVbS6acF3t+mIswHL4Gr4IP+XdsxsTGaVGfnKanoki58AEvksVn91xMyCbEMdrpderX5ArJpfoRPF2f5H0EwMsBYs0hFPQUO77WJRV9C5e7knRWwcGmV3VYRz9Ig1QWRx1vzPSo6gd6ooFvq0EdWHuOY3+nNNDM2XDZb25B/a6K3n39F8ZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NRMRRUmw1wi0MziRszzqpiRhHJS358odgjb2QsOB+k=;
 b=Bo4sDvItrLNm2bcfXz6/R7MQTi3WPpTawp10tkx8/nz+BiLqqNrdtG71GjqyYj3DmLkqqDTE42ierLVCYzfgRu9quLU/wajlu1g8+v/2+8wvmuiuEcJkEoW6KucSLt9/3IY3mBdFyUhALhte/NsoyqRzb01amAD5zUGxU8309wU=
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:19 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::1a) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:18 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:06 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 24/49] drm/amd/display: Add atomic transfer-function tests
Date: Thu, 23 Jul 2026 16:13:32 -0400
Message-ID: <20260723201908.373300-25-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e2af49-ff15-4cc0-2c28-08dee8f7acf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SjDRiv7FZJ6SGJdrgPNHQ6SpKVoxWwTXkdu3FgIlc27CXUMWoH7OrbT52qwGKzn8HKAzTJhGJsWbZFjfE0pnz/6pfPo3ZeYJ8OYLdSF4bDUcLRf65DtfCCGu0iB7TLm1VzFh8KHeXx6lN1SDMyQEawxw1GNeWWRHftl4tC75JvwmoXxV5a2qJUXAAdDEQVQwe6sL6MOUswA9rxQWzWfibe48KDvRFimofG/zVs37E/RKgxsoNvqWRCOYYOYZDmQtsg5nmJLydiGw0+nVznZoo+QJ/JzxmhZ8GcwWOFG2B2S6j9p+1Syx0QpQNBSEay+wpVuMwRBYRCVqHcZedt3DGobS0JjhcAYy9klsfkv+salBAp2Y7i1jPC6AR+PAr/GJFfB5MWgeSDOAz2c8LaM5lhMPCT2NlGEr8VHxl5J0WY975FURsBkhtPjWKkZJuhhUpJ3cZMePWbHXfi+tQo414l2oR1NU6OrZmJhiilo2cRn71FR1rw2y3CA0ifru4lfTmdNADDiqLcLL1tg/26V73zhxFo21Jcx6bcNScMplANRGAXEm7IV2rcDygxDKR7vz42YFJvBWQEPC7PDn8FIvEaNIzbsB/qBqpeYgipAqFm+dN+qpvyL5aAeEwA44g/ZLFuXhvEN/E/Qgd++WXauscDWHCthz83Ku0i6T6zwajikj215LEIJsNmK5H/4+AzyO1v1ZR6hGMkn12D7ywj88rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vMyZ9HiI+FwY1j0cyEArA/LV7pPpeokSB1SDZis/fDjz7jGZf/KBAig3gRcmQxywQXp86lazqra009Q6hWy//jmi+OMmc8OtuMtTEwqPoH5dC+2kgUy/54SdJ8EnMfs6BeN/Ld6wWsCwvtCthPllnQWCaEjh5HCOhyrGNX3FA5A4V8F0JdfzUCtUxxF6FukYGedbZ1xMpzQI95SlkGUPRUPLIfyusaYVljp4veDtcXMYYnYG1ElEDsw8tMIwRsoO7hYjYYPILuWwdkOcHT3MCdAl1UATEy1nG8z0GwhrVH+ZdH0a6MSSwR7rH7rQGT8/oB3mxTbBXdhg9qj468nl1MitXG8c83gTH8zHa2uoJYIZBjjFPE0dVu7YjpaawMEUi0+jUrCy3xgCQZEYak3TK+s4Cr1YVi8pe9WnZRH0Bl0NqE59O6LASo5JAeUaAeij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:18.9005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e2af49-ff15-4cc0-2c28-08dee8f7acf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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
The atomic regamma, shaper, and blend helpers were only exercised on
their linear bypass paths, leaving the generated transfer-function
cases untested.

[HOW]
Add sRGB success-path tests that verify the generated transfer
functions and the corresponding plane color-management enable flags.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index de11a606a88c..4945f5429bc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1535,6 +1535,23 @@ static void dm_test_set_atomic_regamma_bypass(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)out_tf->tf, (int)TRANSFER_FUNCTION_LINEAR);
 }
 
+/**
+ * dm_test_set_atomic_regamma_srgb - Non-linear TF enables generated regamma
+ * @test: KUnit test context
+ */
+static void dm_test_set_atomic_regamma_srgb(struct kunit *test)
+{
+	struct dc_transfer_func *out_tf;
+
+	out_tf = kunit_kzalloc(test, sizeof(*out_tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, out_tf);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_set_atomic_regamma(out_tf, NULL, 0, true, TRANSFER_FUNCTION_SRGB),
+			0);
+	KUNIT_EXPECT_EQ(test, (int)out_tf->type, (int)TF_TYPE_DISTRIBUTED_POINTS);
+}
+
 /**
  * dm_test_atomic_shaper_lut_bypass - No LUT and linear TF: must take bypass path
  * @test: KUnit test context
@@ -1577,6 +1594,28 @@ static void dm_test_atomic_blend_lut_bypass(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)cm->blend_func.tf, (int)TRANSFER_FUNCTION_LINEAR);
 }
 
+/**
+ * dm_test_atomic_shaper_blend_srgb - Non-linear TFs enable shaper and blend
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_shaper_blend_srgb(struct kunit *test)
+{
+	struct dc_plane_cm *cm;
+
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_atomic_shaper_lut(NULL, true, TRANSFER_FUNCTION_SRGB, 0, cm),
+			0);
+	KUNIT_EXPECT_TRUE(test, cm->flags.bits.shaper_enable);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_atomic_blend_lut(NULL, false, TRANSFER_FUNCTION_SRGB, 0, cm),
+			0);
+	KUNIT_EXPECT_TRUE(test, cm->flags.bits.blend_enable);
+}
+
 /* ---- Tests for __set_colorop_in_tf_1d_curve ---- */
 
 /**
@@ -2533,10 +2572,12 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_set_transfer_funcs_with_luts),
 	/* amdgpu_dm_set_atomic_regamma */
 	KUNIT_CASE(dm_test_set_atomic_regamma_bypass),
+	KUNIT_CASE(dm_test_set_atomic_regamma_srgb),
 	/* amdgpu_dm_atomic_shaper_lut */
 	KUNIT_CASE(dm_test_atomic_shaper_lut_bypass),
 	/* amdgpu_dm_atomic_blend_lut */
 	KUNIT_CASE(dm_test_atomic_blend_lut_bypass),
+	KUNIT_CASE(dm_test_atomic_shaper_blend_srgb),
 	/* __set_colorop_in_tf_1d_curve */
 	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_invalid_type),
 	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_unsupported_curve),
-- 
2.53.0

