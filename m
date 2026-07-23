Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E8C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04A510F1DF;
	Thu, 23 Jul 2026 20:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2x1BCudy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078BC10E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+5IkSp8PMyvPfk65vAbfWW3FGFbE3Mj0sNzIIj+NPChVc48WHYgxfKFuvxvN89ZiGf4SNtazXjC9RqJixFrGX9Z5vvy1prqPg/YxdRyVo0hodJJTALEUV9+t0YCwp6pUik4quZwcEofUL+nlFvi69GT+Vj4NFwFnaULR/iYNEsEUSjU4utJNKrKn2jUI9C0Rq9SwoBbnMRI/zpOspYLSP9xlR+LQCpnyr3rp9IQk8W/Bgf3OJGmC6lpAEQvDmWm7cvab5SpAHZwUt+BaiRYt2by6UdTwKLL4K7+y/VMw3qNG30a0QentZgy/TCk+pvvWbX7DKwYZ6ddjZVAGTHwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI9/yiY/V79u9citkenN8+3RatbX6qLWoWskVpo3Xsw=;
 b=DjvuwCyyhQE7ctPkyUp9d4xCP5gpzXP7JiZyNk5yQUiPmK76HDk+QxL41JqlbqNVpNOblaATA1PnsVNhNhqNQYbB9ZvOuhelXnFo4wn40Q8L3jI130i8+r/sp+Etn8G8vCVlHUzUs+RCNad+aPnEuB2FXGkCQY/isHBew4uZr+1vHwLBRL7AosJBmRTKeETS7H8lPqGx9VwhXSJIsmsS8FCq4zNu9GNqFUDotZYALBrXPDW3Pls2EvOaddkxplEhNJ3mcFUsZArPwIzkJyoI0DV9kNkR6Alwnk5gfAZ6XBcX95FwrN1uCr1As9LdkAQj1GJL9AYgKjw/iWGWU1OKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI9/yiY/V79u9citkenN8+3RatbX6qLWoWskVpo3Xsw=;
 b=2x1BCudycCpKFH1eaG/wkPfFpyQcPkioybXqef1Y+e5/kzD0cS9fsPZWNxsA12tuOND9vcx9vtt6nH8wgvR0fsp4towYOb3wovM9DHUus+oTjPWvx9ItyuIStAMEm9bL0HPYFaWzHLER6Nbn192D9tpCGLjQFM3bV9dAh/52Zsg=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:18 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::2e) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:17 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:05 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 23/49] drm/amd/display: Add color transfer-function tests
Date: Thu, 23 Jul 2026 16:13:31 -0400
Message-ID: <20260723201908.373300-24-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: e7991d5c-75b6-4700-6517-08dee8f7abf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lP7S4D3wSxJ4s64S5xSThmVd4UaVF0HxvXb/PLy41IPe2Mp5JEnfifDD27tkOGoWSxEcwCfr5Njb9d+ohArFe5VZ7afbFb8hyIglv4+XbccJtt2d5nAOnQ9mOTabx1RE4jGy/yVh4DFG3J7zDoDwX7MXowLPFdxNm/BjD6Q4i5mOHhqah9zrRc8QjhWHftMqF4LU2TkdLr9g/DIyEVaR+V+EVuc38rWFbDva/V1g7/eRlceeSb+CTOn1KgT4cAqR3jP0oedJOZ8F6zEOUod5aOUmSwZKFSLHRp6eJHVjf6k5Hb3UE4IsCBZPNJaKPRSJb8ojeUGjP7DQzIDXFa91jdqvSZM0ePTk/Lv4oJnYVxHmqAXrGkFF3ToftszM9u/16KJlQWfGprukI1vyNH1euVSNUHMmAyKH6T0vGsqkq5jwNhuqcqHd49MTEJWROu07KLyrBH/YFfHZG85gd20X3+Xgo1GkMZwxkCXD8JeI4/isrYPaAlhgid/aX6MNRak+Kbcbp2LUqqvU0aeqQEAwLKRuRDXSeYlKPNLcD16oCy07AXYXRgjHB2qNNhDAqikfDXiV1bWyKuEYoJEpIz5+Q6ytYBid6o5SkjiayMLYp6kO3ygvl4iNTVs9DG9Oc2TKnJKVcJDwUhzN6aJzR0+s6yy2s2D1kT5/PWcdJ9+3FsAPakgILbe82Hi11+1QLpja9DTkTPAD1UKFa5X4Bpdh2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 73rQTdLn1aMBIA/5a6QufMe9Jlrt2I/dZc0ZTy4uL5oJmmmqDPoIPmlVCOVh7Uikr5sL/CbwLQCm/nHDlYEfD4SCLQXiamQgaHnjlma1VYMr8yPVH8ln5QWmdWE/XQUrKNj7KAUQAFbIyJEGasbUifSs8l7zeajpq3QhmyYTFGm7ArR3kec+QtaSxoycUEa/zu4fLHBb+ks03dUcAxdu/zJ7TdVbY74RsNSU6VqQ6DyrYNzOZ+K9g2popmORfoZV23tXF12SkArUGHWwiJ4JOmVZxlkW//QwkTzP9eiEQrAXk0GFrhHBU2g5fOVdnZe6kTW+l7rOZRupgl7Yrh318WKZmSz65mTHrjm+3Hx8F04nc33+7nfDDxgGXTBqjvfgoxnAK1oSzV+grLgUO0ZBphIl4rLX8gebfmHBTJx07pwfMFDfYNv7ZOcnuDMlpODn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:17.1974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7991d5c-75b6-4700-6517-08dee8f7abf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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
The color transfer-function calculation helpers were not covered by
the amdgpu_dm_color KUnit suite. They rely on DAL fixed-point math
and run under the KUnit UML build without native floating point.

[HOW]
Expose the five static helpers to KUnit and add direct coverage for
the legacy, 16-bit, and 32-bit input and output transfer-function
paths, including sRGB, linear, and ROM-backed variants.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  36 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |  14 ++
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 147 ++++++++++++++++++
 3 files changed, 184 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 658dfc37d4d4..7b68c6846039 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -618,9 +618,10 @@ EXPORT_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
  * Returns:
  * 0 in case of success, -ENOMEM if fails
  */
-static int __set_legacy_tf(struct dc_transfer_func *func,
-			   const struct drm_color_lut *lut, uint32_t lut_size,
-			   bool has_rom)
+STATIC_IFN_KUNIT int
+__set_legacy_tf(struct dc_transfer_func *func,
+		const struct drm_color_lut *lut, uint32_t lut_size,
+		bool has_rom)
 {
 	struct dc_gamma *gamma = NULL;
 	struct calculate_buffer cal_buffer = {0};
@@ -645,6 +646,7 @@ static int __set_legacy_tf(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
+EXPORT_IF_KUNIT(__set_legacy_tf);
 
 /**
  * __set_output_tf - calculates the output transfer function based on expected input space.
@@ -656,9 +658,10 @@ static int __set_legacy_tf(struct dc_transfer_func *func,
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-static int __set_output_tf(struct dc_transfer_func *func,
-			   const struct drm_color_lut *lut, uint32_t lut_size,
-			   bool has_rom)
+STATIC_IFN_KUNIT int
+__set_output_tf(struct dc_transfer_func *func,
+		const struct drm_color_lut *lut, uint32_t lut_size,
+		bool has_rom)
 {
 	struct dc_gamma *gamma = NULL;
 	struct calculate_buffer cal_buffer = {0};
@@ -703,6 +706,7 @@ static int __set_output_tf(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
+EXPORT_IF_KUNIT(__set_output_tf);
 
 /**
  * __set_output_tf_32 - calculates the output transfer function based on expected input space.
@@ -714,9 +718,10 @@ static int __set_output_tf(struct dc_transfer_func *func,
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-static int __set_output_tf_32(struct dc_transfer_func *func,
-			      const struct drm_color_lut32 *lut, uint32_t lut_size,
-			      bool has_rom)
+STATIC_IFN_KUNIT int
+__set_output_tf_32(struct dc_transfer_func *func,
+		   const struct drm_color_lut32 *lut, uint32_t lut_size,
+		   bool has_rom)
 {
 	struct dc_gamma *gamma = NULL;
 	struct calculate_buffer cal_buffer = {0};
@@ -759,6 +764,7 @@ static int __set_output_tf_32(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
+EXPORT_IF_KUNIT(__set_output_tf_32);
 
 STATIC_IFN_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
 {
@@ -820,8 +826,9 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-static int __set_input_tf(struct dc_color_caps *caps, struct dc_transfer_func *func,
-			  const struct drm_color_lut *lut, uint32_t lut_size)
+STATIC_IFN_KUNIT int __set_input_tf(struct dc_color_caps *caps,
+				    struct dc_transfer_func *func,
+				    const struct drm_color_lut *lut, uint32_t lut_size)
 {
 	struct dc_gamma *gamma = NULL;
 	bool res;
@@ -844,6 +851,7 @@ static int __set_input_tf(struct dc_color_caps *caps, struct dc_transfer_func *f
 
 	return res ? 0 : -ENOMEM;
 }
+EXPORT_IF_KUNIT(__set_input_tf);
 
 /**
  * __set_input_tf_32 - calculates the input transfer function based on expected
@@ -856,8 +864,9 @@ static int __set_input_tf(struct dc_color_caps *caps, struct dc_transfer_func *f
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-static int __set_input_tf_32(struct dc_color_caps *caps, struct dc_transfer_func *func,
-			     const struct drm_color_lut32 *lut, uint32_t lut_size)
+STATIC_IFN_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
+				       struct dc_transfer_func *func,
+				       const struct drm_color_lut32 *lut, uint32_t lut_size)
 {
 	struct dc_gamma *gamma = NULL;
 	bool res;
@@ -880,6 +889,7 @@ static int __set_input_tf_32(struct dc_color_caps *caps, struct dc_transfer_func
 
 	return res ? 0 : -ENOMEM;
 }
+EXPORT_IF_KUNIT(__set_input_tf_32);
 
 STATIC_IFN_KUNIT
 enum dc_transfer_func_predefined
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index cec23a020c3d..3e8a3d3fc855 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -64,6 +64,20 @@ void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 			     struct fixed31_32 *matrix);
 void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 				 struct fixed31_32 *matrix);
+int __set_legacy_tf(struct dc_transfer_func *func,
+		    const struct drm_color_lut *lut, uint32_t lut_size,
+		    bool has_rom);
+int __set_output_tf(struct dc_transfer_func *func,
+		    const struct drm_color_lut *lut, uint32_t lut_size,
+		    bool has_rom);
+int __set_output_tf_32(struct dc_transfer_func *func,
+		       const struct drm_color_lut32 *lut, uint32_t lut_size,
+		       bool has_rom);
+struct dc_color_caps;
+int __set_input_tf(struct dc_color_caps *caps, struct dc_transfer_func *func,
+		   const struct drm_color_lut *lut, uint32_t lut_size);
+int __set_input_tf_32(struct dc_color_caps *caps, struct dc_transfer_func *func,
+		      const struct drm_color_lut32 *lut, uint32_t lut_size);
 enum dc_transfer_func_predefined
 amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf);
 enum dc_transfer_func_predefined
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index e76e533a8323..de11a606a88c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1375,6 +1375,146 @@ static void dm_test_set_tf_distributed_points_pq(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, tf->sdr_ref_white_level, 80U);
 }
 
+/**
+ * dm_test_set_legacy_tf_identity - Legacy identity LUT uses the sRGB ROM path
+ * @test: KUnit test context
+ */
+static void dm_test_set_legacy_tf_identity(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_transfer_func *tf;
+	int i;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+	lut = kunit_kcalloc(test, MAX_COLOR_LEGACY_LUT_ENTRIES, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	for (i = 0; i < MAX_COLOR_LEGACY_LUT_ENTRIES; i++) {
+		u16 value = i * MAX_DRM_LUT_VALUE / (MAX_COLOR_LEGACY_LUT_ENTRIES - 1);
+
+		lut[i].red = value;
+		lut[i].green = value;
+		lut[i].blue = value;
+	}
+
+	tf->type = TF_TYPE_PREDEFINED;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_legacy_tf(tf, lut, MAX_COLOR_LEGACY_LUT_ENTRIES, true),
+			0);
+}
+
+/**
+ * dm_test_set_output_tf_linear - Linear output without a LUT calculates degamma
+ * @test: KUnit test context
+ */
+static void dm_test_set_output_tf_linear(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+	tf->type = TF_TYPE_PREDEFINED;
+	tf->tf = TRANSFER_FUNCTION_LINEAR;
+
+	KUNIT_EXPECT_EQ(test, __set_output_tf(tf, NULL, 0, false), 0);
+}
+
+/**
+ * dm_test_set_output_tf_32_srgb_rom - sRGB output uses the no-LUT ROM path
+ * @test: KUnit test context
+ */
+static void dm_test_set_output_tf_32_srgb_rom(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+	tf->type = TF_TYPE_PREDEFINED;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+
+	KUNIT_EXPECT_EQ(test, __set_output_tf_32(tf, NULL, 0, true), 0);
+}
+
+/**
+ * dm_test_set_input_tf_srgb - Predefined sRGB input needs no generated curve
+ * @test: KUnit test context
+ */
+static void dm_test_set_input_tf_srgb(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+	tf->type = TF_TYPE_PREDEFINED;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+
+	KUNIT_EXPECT_EQ(test, __set_input_tf(NULL, tf, NULL, 0), 0);
+}
+
+/**
+ * dm_test_set_input_tf_32_srgb - 32-bit input wrapper accepts predefined sRGB
+ * @test: KUnit test context
+ */
+static void dm_test_set_input_tf_32_srgb(struct kunit *test)
+{
+	struct dc_transfer_func *tf;
+
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+	tf->type = TF_TYPE_PREDEFINED;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+
+	KUNIT_EXPECT_EQ(test, __set_input_tf_32(NULL, tf, NULL, 0), 0);
+}
+
+/**
+ * dm_test_set_transfer_funcs_with_luts - LUT-backed transfer functions succeed
+ * @test: KUnit test context
+ */
+static void dm_test_set_transfer_funcs_with_luts(struct kunit *test)
+{
+	struct drm_color_lut32 *lut32;
+	struct drm_color_lut *lut;
+	struct dc_transfer_func *tf;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+	lut32 = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES, sizeof(*lut32), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut32);
+	tf = kunit_kzalloc(test, sizeof(*tf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tf);
+
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_LINEAR;
+	KUNIT_EXPECT_EQ(test,
+			__set_output_tf(tf, lut, MAX_COLOR_LUT_ENTRIES, false),
+			0);
+
+	memset(tf, 0, sizeof(*tf));
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_LINEAR;
+	KUNIT_EXPECT_EQ(test,
+			__set_output_tf_32(tf, lut32, MAX_COLOR_LUT_ENTRIES, false),
+			0);
+
+	memset(tf, 0, sizeof(*tf));
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+	KUNIT_EXPECT_EQ(test,
+			__set_input_tf(NULL, tf, lut, MAX_COLOR_LUT_ENTRIES),
+			0);
+
+	memset(tf, 0, sizeof(*tf));
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+	KUNIT_EXPECT_EQ(test,
+			__set_input_tf_32(NULL, tf, lut32, MAX_COLOR_LUT_ENTRIES),
+			0);
+}
+
 /**
  * dm_test_set_atomic_regamma_bypass - No LUT and linear TF: must take bypass path
  * @test: KUnit test context
@@ -2384,6 +2524,13 @@ static struct kunit_case dm_color_test_cases[] = {
 	/* __set_tf_distributed_points */
 	KUNIT_CASE(dm_test_set_tf_distributed_points_srgb),
 	KUNIT_CASE(dm_test_set_tf_distributed_points_pq),
+	/* Transfer-function calculation helpers */
+	KUNIT_CASE(dm_test_set_legacy_tf_identity),
+	KUNIT_CASE(dm_test_set_output_tf_linear),
+	KUNIT_CASE(dm_test_set_output_tf_32_srgb_rom),
+	KUNIT_CASE(dm_test_set_input_tf_srgb),
+	KUNIT_CASE(dm_test_set_input_tf_32_srgb),
+	KUNIT_CASE(dm_test_set_transfer_funcs_with_luts),
 	/* amdgpu_dm_set_atomic_regamma */
 	KUNIT_CASE(dm_test_set_atomic_regamma_bypass),
 	/* amdgpu_dm_atomic_shaper_lut */
-- 
2.53.0

