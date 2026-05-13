Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AAECD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA89310EEEA;
	Wed, 13 May 2026 14:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aV3lmgfG";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3667010EED1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qni7DbBiD/IL89SJ6wQsSvXMQY01he7Sj9vVrtOWJOqkl8Lo4DctGoGT70l6AnMobTyFXzIVqRLkQandzfWJl7LcVua3I0dw7+btSVnWMm846t0gkNXGBQziSEYugQ5AJYSE1pmb09wiQdO924jc7nI95HgQBLYDo4njizrnpy6qZE4JODSxwhpBkQmkbL0HCkZoZeGl9XhM49/5k/2AqhXmQrUa4zNDDJ5wUI4PuRfKuckysAtsCzo1U5GCphUqOdDdGRN8dKkaEtaxDiJjMsB5DyAi8aLlrd5+Buta/42cTN2Ai8UkHxJI/FmfLSFNkkQomsa/iStrx5lcRJYE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj/q4EA3N6l3muI4yEJDpT1LdPiaqeBLtY6mi98W9No=;
 b=gzvNbij9RyXzWKTBOtU1hlvsXoxGswAIjR9NYFu+7zeivoGvx6ak9Rod5f5gorXMgkGdYMPnyEEJH7RBp1+G8tDkoqpTG4bW3mCqGeZKKwAsSCRifQLWqhX6u5A7hdPFrJknT5VcEkKJ8vZvtYqk6CSHuVXVaDRO2/bkAgH9OrRrry/lES+i8CaiaGMBdk/gh/MN4BLO29oIfMK8i45a4jsmyaOU11qm/SkQ608JoB2INcHjZA8ARz2VzVVXGt0n4eLGbvwdUAjdHm2WbvNVrstKm1xW1B46Dmo9MaXsZrnTIA6e6H3iWHZp7u5nYK46J3BVTA33dmsJ4I9Qmb2okQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj/q4EA3N6l3muI4yEJDpT1LdPiaqeBLtY6mi98W9No=;
 b=aV3lmgfG999Q9NL4aCPJvjxO8JnMzk8fbfqmMj5WN2zjqiUyN5lzR48dQUBhGPyfKCtcBB34TX/Uw8xQAPtIJBZTOVAuw5lQongchcUG3J4o6xFnaiV1kft4aqXrvUNjjfzMECSmEK70ElTASdc+MbTDBy3v0RreHt6Mz5jWXjc=
Received: from CYZPR19CA0022.namprd19.prod.outlook.com (2603:10b6:930:8e::25)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:21 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::a9) by CYZPR19CA0022.outlook.office365.com
 (2603:10b6:930:8e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:19 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:19 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 08/28] drm/amd/display: Add KUnit test for color helpers
Date: Wed, 13 May 2026 10:29:30 -0400
Message-ID: <20260513143213.1852892-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 967ebd05-6365-4987-0ffd-08deb0fc950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: xa+XZ7BwXQCqDnm5uqeS38R4kSfhNdjDgCCyzYIvkA7FmXN8A220UIjwKpOWfCGxGZxiFnGzfz9Ti09mCqwRsCfiin0aH4EO4ZKLJ2g/RNshh0Ubocw0NL9hLpsQv34La/onMKECgcxuWwS4pcMUkJzAvQEWX3UIHHL50RiCE6wacPCXgEC+K73ZsXKgcdUkh19nlzWlmKabwOvcME6Mq+YBoId1O6emirHUcjtOXpV/VeQGogTPA/KoAPPxERdRYYjfErzl5Oqnr1EHx1kcR7/rwjMNA49rvM51tHd9nG2B9wbKUjg/fo8RemdXz+sRkYYtdrsJur/xpu57HikHPxt7f1OtuwckaqddeeUIYRKnYICUJwYAo/08duJcKH50q69lZOAYTh7KqltQoTW6Srl3QZRc6CHlOrBmfR/XyYrLadB2QUmShGKy5sjJVad6ZnCxhu4dIqtn0VKoxAKvoYXwVYH7+ChcDgZGcML0vr3MNRc30HsYSXWsu9INF1Gi6Ot+8MO7a2YQuZuPy8f0K6mX6RLaxJZkXjnP8IkHoJvL9vnezw9m4c2uKfyXmvsZFVp042tvtqUg4fugQ9bbmhz+cPRpYMz+K9uvxYCWFnpiIkhzmUiJWKtiIGJL05Qr0VfmCD0mcUreE88so75tGwrJwacWjWk6NvF5ZBJx2Ywx2MI8dSGbxIxJaYcQT/RjYdi3KLesJTp+CGV9ciO5yNKRa0siZAEPhWKUjEUHbqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bbNkKr04v88oZUin2nkHg6RxZJVtu7MG9fe4doDkPx0u6TIaaQ+QWSOL3PbJ82bbk8BXzVhvNU7iSCR8vzh08xnoytANRLjsG1vy39U0bewTIKDKL9BvxPmp0DYDidH0LOsnQI4TXbVO7X5FDJMc2YAk9E3z/X7um3KHlvjbQu28xSWtOyOdxaD0uQnJjzgmCD7ca6t1+a9wZPDgaU88kERTm1UmXlm6uRNd+q70n7eg7n6MbXHePhw/sxIqDNxnIIkXmQCg2lV8dbLN2Xz8G8DYFw3MWMFoChOlwGwOFmdJlJ645hG1BDwP5dO3msgCtEx0J0HZtXANv/maOPm2RvVszDDCofRhk1MFVqsWGlXeFK80FGszvbGBzJ85THVAMJQ8o1AMqGARs2zkjeFl/jI9DeZcWjWSafwGO3GqROdU0SmUYgw6BHGADkpj2akg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:21.1673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967ebd05-6365-4987-0ffd-08deb0fc950b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

Add KUnit tests for six pure-logic functions in
amdgpu_dm_color.c: amdgpu_dm_fixpt_from_s3132,
__is_lut_linear, __drm_ctm_to_dc_matrix,
__drm_ctm_3x4_to_dc_matrix, amdgpu_tf_to_dc_tf,
and amdgpu_colorop_tf_to_dc_tf.

Expose these static functions under CONFIG_DRM_AMD_DC_KUNIT_TEST
and add a new amdgpu_dm_color.h header with the KUnit-only
prototypes. The test file re-declares the dc and amdgpu
transfer function enums locally to avoid pulling in the full
DC/amdgpu include chain that fails under UML.

26 test cases cover signed-magnitude to two's complement
conversion, LUT linearity detection, CTM-to-DC matrix
conversion, and transfer function enum mapping.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   65 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   89 ++
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 1071 +++++++++++++++++
 4 files changed, 1209 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 20a76d81d532..59a7d563451e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -29,9 +29,12 @@
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_color.h"
 #include "amdgpu_dm_colorop.h"
 #include "dc.h"
 #include "modules/color/color_gamma.h"
+#include "amdgpu_dm_kunit_helpers.h"
+
 
 /**
  * DOC: overview
@@ -157,8 +160,6 @@
  *
  */
 
-#define MAX_DRM_LUT_VALUE 0xFFFF
-#define MAX_DRM_LUT32_VALUE 0xFFFFFFFF
 #define SDR_WHITE_LEVEL_INIT_VALUE 80
 
 /**
@@ -172,7 +173,8 @@ void amdgpu_dm_init_color_mod(void)
 	setup_x_points_distribution();
 }
 
-static inline struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
+STATIC_IFN_KUNIT INLINE_IFN_KUNIT
+struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 {
 	struct fixed31_32 val;
 
@@ -183,6 +185,7 @@ static inline struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 	val.value = x;
 	return val;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_fixpt_from_s3132);
 
 #ifdef AMD_PRIVATE_COLOR
 /* Pre-defined Transfer Functions (TF)
@@ -421,12 +424,14 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
  * Returns:
  * DRM LUT or NULL
  */
-static const struct drm_color_lut *
+STATIC_IFN_KUNIT
+const struct drm_color_lut *
 __extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size)
 {
 	*size = blob ? drm_color_lut_size(blob) : 0;
 	return blob ? (struct drm_color_lut *)blob->data : NULL;
 }
+EXPORT_IF_KUNIT(__extract_blob_lut);
 
 /**
  * __extract_blob_lut32 - Extracts the DRM lut and lut size from a blob.
@@ -436,12 +441,14 @@ __extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size)
  * Returns:
  * DRM LUT or NULL
  */
-static const struct drm_color_lut32 *
+STATIC_IFN_KUNIT
+const struct drm_color_lut32 *
 __extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size)
 {
 	*size = blob ? drm_color_lut32_size(blob) : 0;
 	return blob ? (struct drm_color_lut32 *)blob->data : NULL;
 }
+EXPORT_IF_KUNIT(__extract_blob_lut32);
 
 /**
  * __is_lut_linear - check if the given lut is a linear mapping of values
@@ -456,7 +463,8 @@ __extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size)
  * True if the given lut is a linear mapping of values, i.e. it acts like a
  * bypass LUT. Otherwise, false.
  */
-static bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
+STATIC_IFN_KUNIT
+bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 {
 	int i;
 	uint32_t expected;
@@ -476,6 +484,7 @@ static bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 	}
 	return true;
 }
+EXPORT_IF_KUNIT(__is_lut_linear);
 
 /**
  * __drm_lut_to_dc_gamma - convert the drm_color_lut to dc_gamma.
@@ -485,7 +494,8 @@ static bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-static void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
+STATIC_IFN_KUNIT
+void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 				  struct dc_gamma *gamma, bool is_legacy)
 {
 	uint32_t r, g, b;
@@ -515,6 +525,7 @@ static void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 		gamma->entries.blue[i] = dc_fixpt_from_fraction(b, MAX_DRM_LUT_VALUE);
 	}
 }
+EXPORT_IF_KUNIT(__drm_lut_to_dc_gamma);
 
 /**
  * __drm_lut32_to_dc_gamma - convert the drm_color_lut to dc_gamma.
@@ -523,7 +534,8 @@ static void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-static void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma *gamma)
+STATIC_IFN_KUNIT
+void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma *gamma)
 {
 	int i;
 
@@ -533,6 +545,7 @@ static void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc
 		gamma->entries.blue[i] = dc_fixpt_from_fraction(lut[i].blue, MAX_DRM_LUT32_VALUE);
 	}
 }
+EXPORT_IF_KUNIT(__drm_lut32_to_dc_gamma);
 
 /**
  * __drm_ctm_to_dc_matrix - converts a DRM CTM to a DC CSC float matrix
@@ -541,8 +554,9 @@ static void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
-				   struct fixed31_32 *matrix)
+STATIC_IFN_KUNIT
+void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
+			   struct fixed31_32 *matrix)
 {
 	int i;
 
@@ -565,6 +579,7 @@ static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i - (i / 4)]);
 	}
 }
+EXPORT_IF_KUNIT(__drm_ctm_to_dc_matrix);
 
 /**
  * __drm_ctm_3x4_to_dc_matrix - converts a DRM CTM 3x4 to a DC CSC float matrix
@@ -573,8 +588,9 @@ static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-static void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
-				       struct fixed31_32 *matrix)
+STATIC_IFN_KUNIT
+void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
+				struct fixed31_32 *matrix)
 {
 	int i;
 
@@ -587,6 +603,7 @@ static void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i]);
 	}
 }
+EXPORT_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
 
 /**
  * __set_legacy_tf - Calculates the legacy transfer function
@@ -851,7 +868,8 @@ static int __set_input_tf_32(struct dc_color_caps *caps, struct dc_transfer_func
 	return res ? 0 : -ENOMEM;
 }
 
-static enum dc_transfer_func_predefined
+STATIC_IFN_KUNIT
+enum dc_transfer_func_predefined
 amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 {
 	switch (tf) {
@@ -879,8 +897,10 @@ amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 		return TRANSFER_FUNCTION_GAMMA26;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_tf_to_dc_tf);
 
-static enum dc_transfer_func_predefined
+STATIC_IFN_KUNIT
+enum dc_transfer_func_predefined
 amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 {
 	switch (tf) {
@@ -900,8 +920,10 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 		return TRANSFER_FUNCTION_LINEAR;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_colorop_tf_to_dc_tf);
 
-static void __to_dc_lut3d_color(struct dc_rgb *rgb,
+STATIC_IFN_KUNIT
+void __to_dc_lut3d_color(struct dc_rgb *rgb,
 				const struct drm_color_lut lut,
 				int bit_precision)
 {
@@ -909,8 +931,10 @@ static void __to_dc_lut3d_color(struct dc_rgb *rgb,
 	rgb->green = drm_color_lut_extract(lut.green, bit_precision);
 	rgb->blue  = drm_color_lut_extract(lut.blue, bit_precision);
 }
+EXPORT_IF_KUNIT(__to_dc_lut3d_color);
 
-static void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
+STATIC_IFN_KUNIT
+void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 				    uint32_t lut3d_size,
 				    struct tetrahedral_params *params,
 				    bool use_tetrahedral_9,
@@ -953,8 +977,10 @@ static void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 	/* lut0 has 1229 points (lut_size/4 + 1) */
 	__to_dc_lut3d_color(&lut0[lut_i], lut[i], bit_depth);
 }
+EXPORT_IF_KUNIT(__drm_3dlut_to_dc_3dlut);
 
-static void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
+STATIC_IFN_KUNIT
+void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 				   const struct drm_color_lut32 lut,
 				   int bit_precision)
 {
@@ -962,8 +988,10 @@ static void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 	rgb->green = drm_color_lut32_extract(lut.green, bit_precision);
 	rgb->blue  = drm_color_lut32_extract(lut.blue, bit_precision);
 }
+EXPORT_IF_KUNIT(__to_dc_lut3d_32_color);
 
-static void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
+STATIC_IFN_KUNIT
+void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 				       uint32_t lut3d_size,
 				       struct tetrahedral_params *params,
 				       bool use_tetrahedral_9,
@@ -1006,6 +1034,7 @@ static void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 	/* lut0 has 1229 points (lut_size/4 + 1) */
 	__to_dc_lut3d_32_color(&lut0[lut_i], lut[i], bit_depth);
 }
+EXPORT_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
 
 /* amdgpu_dm_atomic_lut3d - set DRM 3D LUT to DC stream
  * @drm_lut3d: user 3D LUT
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
new file mode 100644
index 000000000000..5e484359b8a7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __AMDGPU_DM_COLOR_H__
+#define __AMDGPU_DM_COLOR_H__
+
+#define MAX_DRM_LUT_VALUE    0xFFFF
+#define MAX_DRM_LUT32_VALUE  0xFFFFFFFF
+
+#include <linux/types.h>
+
+struct drm_color_lut;
+struct drm_color_lut32;
+struct drm_color_ctm;
+struct drm_color_ctm_3x4;
+struct drm_property_blob;
+struct dc_gamma;
+struct dc_rgb;
+struct fixed31_32;
+struct tetrahedral_params;
+
+#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+/*
+ * Prototypes for functions exposed to KUnit tests. The enum types
+ * used below (dc_transfer_func_predefined, amdgpu_transfer_function,
+ * drm_colorop_curve_1d_type) must be defined before this header is
+ * included — the source file (amdgpu_dm_color.c) ensures this via
+ * its own includes of dc.h, amdgpu_dm.h, and drm/drm_colorop.h.
+ */
+struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x);
+bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size);
+void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
+			    struct dc_gamma *gamma, bool is_legacy);
+void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut,
+			      struct dc_gamma *gamma);
+void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
+			     struct fixed31_32 *matrix);
+void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
+				 struct fixed31_32 *matrix);
+enum dc_transfer_func_predefined
+amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf);
+enum dc_transfer_func_predefined
+amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf);
+const struct drm_color_lut *
+__extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size);
+const struct drm_color_lut32 *
+__extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size);
+void __to_dc_lut3d_color(struct dc_rgb *rgb,
+			 const struct drm_color_lut lut,
+			 int bit_precision);
+void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
+			     uint32_t lut3d_size,
+			     struct tetrahedral_params *params,
+			     bool use_tetrahedral_9,
+			     int bit_depth);
+void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
+			    const struct drm_color_lut32 lut,
+			    int bit_precision);
+void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
+				uint32_t lut3d_size,
+				struct tetrahedral_params *params,
+				bool use_tetrahedral_9,
+				int bit_depth);
+#endif
+
+#endif /* __AMDGPU_DM_COLOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index e300bcf39835..2b442353beae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -7,7 +7,9 @@ ccflags-y += -I$(src)/../..
 ccflags-y += -I$(src)/../../include
 ccflags-y += -I$(src)/../../modules/inc
 ccflags-y += -I$(src)/../../dc
+ccflags-y += -I$(src)/../../../amdgpu
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
new file mode 100644
index 000000000000..377fa4342ca1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -0,0 +1,1071 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_color.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <linux/types.h>
+#include <drm/drm_colorop.h>
+#include <drm/drm_property.h>
+#include <uapi/drm/drm_mode.h>
+
+#include "dc.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_color.h"
+
+/* ---- Tests for amdgpu_dm_fixpt_from_s3132 ---- */
+
+static void dm_test_fixpt_from_s3132_zero(struct kunit *test)
+{
+	struct fixed31_32 val = amdgpu_dm_fixpt_from_s3132(0ULL);
+
+	KUNIT_EXPECT_EQ(test, val.value, 0LL);
+}
+
+static void dm_test_fixpt_from_s3132_one(struct kunit *test)
+{
+	/* 1.0 in S31.32 signed-magnitude = 1ULL << 32 */
+	struct fixed31_32 val = amdgpu_dm_fixpt_from_s3132(1ULL << 32);
+
+	KUNIT_EXPECT_EQ(test, val.value, (long long)(1ULL << 32));
+}
+
+static void dm_test_fixpt_from_s3132_negative_one(struct kunit *test)
+{
+	/* -1.0 in S31.32 signed-magnitude: sign bit set | magnitude 1<<32 */
+	__u64 neg_one = (1ULL << 63) | (1ULL << 32);
+	struct fixed31_32 val = amdgpu_dm_fixpt_from_s3132(neg_one);
+
+	/* 2's complement of 1.0 is -(1<<32) */
+	KUNIT_EXPECT_EQ(test, val.value, -(long long)(1ULL << 32));
+}
+
+static void dm_test_fixpt_from_s3132_half(struct kunit *test)
+{
+	/* 0.5 in S31.32 = 1ULL << 31 */
+	struct fixed31_32 val = amdgpu_dm_fixpt_from_s3132(1ULL << 31);
+
+	KUNIT_EXPECT_EQ(test, val.value, (long long)(1ULL << 31));
+}
+
+static void dm_test_fixpt_from_s3132_neg_half(struct kunit *test)
+{
+	__u64 neg_half = (1ULL << 63) | (1ULL << 31);
+	struct fixed31_32 val = amdgpu_dm_fixpt_from_s3132(neg_half);
+
+	KUNIT_EXPECT_EQ(test, val.value, -(long long)(1ULL << 31));
+}
+
+/* ---- Tests for __is_lut_linear ---- */
+
+static void dm_test_is_lut_linear_with_linear_lut(struct kunit *test)
+{
+	const uint32_t size = 256;
+	struct drm_color_lut *lut;
+	int i;
+
+	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+
+	for (i = 0; i < size; i++) {
+		uint16_t val = (uint16_t)(i * MAX_DRM_LUT_VALUE / (size - 1));
+
+		lut[i].red = val;
+		lut[i].green = val;
+		lut[i].blue = val;
+	}
+
+	KUNIT_EXPECT_TRUE(test, __is_lut_linear(lut, size));
+}
+
+static void dm_test_is_lut_linear_with_nonlinear_lut(struct kunit *test)
+{
+	const uint32_t size = 256;
+	struct drm_color_lut *lut;
+	int i;
+
+	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+
+	/* Fill with all-max values: clearly non-linear */
+	for (i = 0; i < size; i++) {
+		lut[i].red = MAX_DRM_LUT_VALUE;
+		lut[i].green = MAX_DRM_LUT_VALUE;
+		lut[i].blue = MAX_DRM_LUT_VALUE;
+	}
+
+	KUNIT_EXPECT_FALSE(test, __is_lut_linear(lut, size));
+}
+
+static void dm_test_is_lut_linear_rgb_mismatch(struct kunit *test)
+{
+	const uint32_t size = 256;
+	struct drm_color_lut *lut;
+	int i;
+
+	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+
+	for (i = 0; i < size; i++) {
+		uint16_t val = (uint16_t)(i * MAX_DRM_LUT_VALUE / (size - 1));
+
+		lut[i].red = val;
+		lut[i].green = val;
+		lut[i].blue = val;
+	}
+
+	/* Introduce R/G mismatch at entry 128 */
+	lut[128].red = lut[128].green + 10;
+
+	KUNIT_EXPECT_FALSE(test, __is_lut_linear(lut, size));
+}
+
+/* ---- Tests for __drm_ctm_to_dc_matrix ---- */
+
+static void dm_test_drm_ctm_to_dc_matrix_identity(struct kunit *test)
+{
+	struct drm_color_ctm ctm;
+	struct fixed31_32 matrix[12];
+	int i;
+	long long one = 1LL << 32;
+
+	memset(&ctm, 0, sizeof(ctm));
+
+	/* Identity 3x3 in S31.32 signed-magnitude: diagonal = 1.0 */
+	ctm.matrix[0] = 1ULL << 32; /* [0][0] */
+	ctm.matrix[4] = 1ULL << 32; /* [1][1] */
+	ctm.matrix[8] = 1ULL << 32; /* [2][2] */
+
+	__drm_ctm_to_dc_matrix(&ctm, matrix);
+
+	/* Expect 3x4 identity: diag=1.0, 4th column=0, off-diag=0 */
+	for (i = 0; i < 12; i++) {
+		if (i == 0 || i == 5 || i == 10)
+			KUNIT_EXPECT_EQ(test, matrix[i].value, one);
+		else
+			KUNIT_EXPECT_EQ(test, matrix[i].value, 0LL);
+	}
+}
+
+static void dm_test_drm_ctm_to_dc_matrix_negative(struct kunit *test)
+{
+	struct drm_color_ctm ctm;
+	struct fixed31_32 matrix[12];
+	long long neg_one = -(1LL << 32);
+
+	memset(&ctm, 0, sizeof(ctm));
+
+	/* -1.0 in S31.32 signed-magnitude */
+	ctm.matrix[0] = (1ULL << 63) | (1ULL << 32);
+
+	__drm_ctm_to_dc_matrix(&ctm, matrix);
+
+	KUNIT_EXPECT_EQ(test, matrix[0].value, neg_one);
+}
+
+static void dm_test_drm_ctm_to_dc_matrix_4th_col_zero(struct kunit *test)
+{
+	struct drm_color_ctm ctm;
+	struct fixed31_32 matrix[12];
+
+	memset(&ctm, 0, sizeof(ctm));
+
+	/* Fill all 9 CTM entries with 1.0 */
+	for (int i = 0; i < 9; i++)
+		ctm.matrix[i] = 1ULL << 32;
+
+	__drm_ctm_to_dc_matrix(&ctm, matrix);
+
+	/* 4th column (indices 3, 7, 11) must always be zero */
+	KUNIT_EXPECT_EQ(test, matrix[3].value, 0LL);
+	KUNIT_EXPECT_EQ(test, matrix[7].value, 0LL);
+	KUNIT_EXPECT_EQ(test, matrix[11].value, 0LL);
+}
+
+/* ---- Tests for __drm_ctm_3x4_to_dc_matrix ---- */
+
+static void dm_test_drm_ctm_3x4_to_dc_matrix_identity(struct kunit *test)
+{
+	struct drm_color_ctm_3x4 ctm;
+	struct fixed31_32 matrix[12];
+	int i;
+	long long one = 1LL << 32;
+
+	memset(&ctm, 0, sizeof(ctm));
+
+	/* Identity with offsets in 4th column */
+	ctm.matrix[0] = 1ULL << 32;  /* [0][0] */
+	ctm.matrix[5] = 1ULL << 32;  /* [1][1] */
+	ctm.matrix[10] = 1ULL << 32; /* [2][2] */
+
+	__drm_ctm_3x4_to_dc_matrix(&ctm, matrix);
+
+	for (i = 0; i < 12; i++) {
+		if (i == 0 || i == 5 || i == 10)
+			KUNIT_EXPECT_EQ(test, matrix[i].value, one);
+		else
+			KUNIT_EXPECT_EQ(test, matrix[i].value, 0LL);
+	}
+}
+
+static void dm_test_drm_ctm_3x4_to_dc_matrix_offset(struct kunit *test)
+{
+	struct drm_color_ctm_3x4 ctm;
+	struct fixed31_32 matrix[12];
+	long long half = 1LL << 31;
+
+	memset(&ctm, 0, sizeof(ctm));
+
+	/* Set 4th column (offsets) to 0.5 */
+	ctm.matrix[3] = 1ULL << 31;
+	ctm.matrix[7] = 1ULL << 31;
+	ctm.matrix[11] = 1ULL << 31;
+
+	__drm_ctm_3x4_to_dc_matrix(&ctm, matrix);
+
+	KUNIT_EXPECT_EQ(test, matrix[3].value, half);
+	KUNIT_EXPECT_EQ(test, matrix[7].value, half);
+	KUNIT_EXPECT_EQ(test, matrix[11].value, half);
+}
+
+/* ---- Tests for amdgpu_tf_to_dc_tf ---- */
+
+static void dm_test_tf_to_dc_tf_default(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_DEFAULT),
+			(int)TRANSFER_FUNCTION_LINEAR);
+}
+
+static void dm_test_tf_to_dc_tf_identity(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_IDENTITY),
+			(int)TRANSFER_FUNCTION_LINEAR);
+}
+
+static void dm_test_tf_to_dc_tf_srgb(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF),
+			(int)TRANSFER_FUNCTION_SRGB);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_SRGB_INV_EOTF),
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+static void dm_test_tf_to_dc_tf_bt709(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_BT709_OETF),
+			(int)TRANSFER_FUNCTION_BT709);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_BT709_INV_OETF),
+			(int)TRANSFER_FUNCTION_BT709);
+}
+
+static void dm_test_tf_to_dc_tf_pq(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_PQ_EOTF),
+			(int)TRANSFER_FUNCTION_PQ);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_PQ_INV_EOTF),
+			(int)TRANSFER_FUNCTION_PQ);
+}
+
+static void dm_test_tf_to_dc_tf_gamma22(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA22_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA22);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA22_INV_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA22);
+}
+
+static void dm_test_tf_to_dc_tf_gamma24(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA24_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA24);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA24_INV_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA24);
+}
+
+static void dm_test_tf_to_dc_tf_gamma26(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA26_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA26);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_tf_to_dc_tf(AMDGPU_TRANSFER_FUNCTION_GAMMA26_INV_EOTF),
+			(int)TRANSFER_FUNCTION_GAMMA26);
+}
+
+/* ---- Tests for amdgpu_colorop_tf_to_dc_tf ---- */
+
+static void dm_test_colorop_tf_to_dc_tf_srgb(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_SRGB_EOTF),
+			(int)TRANSFER_FUNCTION_SRGB);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF),
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+static void dm_test_colorop_tf_to_dc_tf_pq(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_PQ_125_EOTF),
+			(int)TRANSFER_FUNCTION_PQ);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF),
+			(int)TRANSFER_FUNCTION_PQ);
+}
+
+static void dm_test_colorop_tf_to_dc_tf_bt2020(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF),
+			(int)TRANSFER_FUNCTION_BT709);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_BT2020_OETF),
+			(int)TRANSFER_FUNCTION_BT709);
+}
+
+static void dm_test_colorop_tf_to_dc_tf_gamma22(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA22),
+			(int)TRANSFER_FUNCTION_GAMMA22);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA22_INV),
+			(int)TRANSFER_FUNCTION_GAMMA22);
+}
+
+static void dm_test_colorop_tf_to_dc_tf_default(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_COUNT),
+			(int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/* ---- Tests for __drm_lut_to_dc_gamma (legacy path) ---- */
+
+static void dm_test_drm_lut_to_dc_gamma_legacy_zero(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_gamma *gamma;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LEGACY_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	__drm_lut_to_dc_gamma(lut, gamma, true);
+
+	/* All-zero LUT should produce all-zero gamma entries */
+	for (int i = 0; i < MAX_COLOR_LEGACY_LUT_ENTRIES; i++) {
+		KUNIT_EXPECT_EQ(test, gamma->entries.red[i].value, 0LL);
+		KUNIT_EXPECT_EQ(test, gamma->entries.green[i].value, 0LL);
+		KUNIT_EXPECT_EQ(test, gamma->entries.blue[i].value, 0LL);
+	}
+}
+
+static void dm_test_drm_lut_to_dc_gamma_legacy_max(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_gamma *gamma;
+	long long expected = (long long)MAX_DRM_LUT_VALUE << 32;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LEGACY_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	/* Set first and last entries to max */
+	lut[0].red = MAX_DRM_LUT_VALUE;
+	lut[0].green = MAX_DRM_LUT_VALUE;
+	lut[0].blue = MAX_DRM_LUT_VALUE;
+	lut[MAX_COLOR_LEGACY_LUT_ENTRIES - 1].red = MAX_DRM_LUT_VALUE;
+	lut[MAX_COLOR_LEGACY_LUT_ENTRIES - 1].green = MAX_DRM_LUT_VALUE;
+	lut[MAX_COLOR_LEGACY_LUT_ENTRIES - 1].blue = MAX_DRM_LUT_VALUE;
+
+	__drm_lut_to_dc_gamma(lut, gamma, true);
+
+	/* Legacy uses dc_fixpt_from_int(val) = val << 32 */
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[0].value, expected);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[0].value, expected);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[0].value, expected);
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[MAX_COLOR_LEGACY_LUT_ENTRIES - 1].value,
+			expected);
+}
+
+static void dm_test_drm_lut_to_dc_gamma_legacy_channels(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_gamma *gamma;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LEGACY_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	/* Set distinct values per channel at index 1 */
+	lut[1].red = 100;
+	lut[1].green = 200;
+	lut[1].blue = 300;
+
+	__drm_lut_to_dc_gamma(lut, gamma, true);
+
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[1].value, 100LL << 32);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[1].value, 200LL << 32);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[1].value, 300LL << 32);
+}
+
+/* ---- Tests for __drm_lut_to_dc_gamma (non-legacy path) ---- */
+
+static void dm_test_drm_lut_to_dc_gamma_nonlegacy_zero(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_gamma *gamma;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	__drm_lut_to_dc_gamma(lut, gamma, false);
+
+	/* All-zero LUT → fraction(0, 0xFFFF) = 0 */
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[0].value, 0LL);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[0].value, 0LL);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[0].value, 0LL);
+}
+
+static void dm_test_drm_lut_to_dc_gamma_nonlegacy_max(struct kunit *test)
+{
+	struct drm_color_lut *lut;
+	struct dc_gamma *gamma;
+	long long one = 1LL << 32;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	/* Max LUT value should map to 1.0 in fixed-point */
+	lut[0].red = MAX_DRM_LUT_VALUE;
+	lut[0].green = MAX_DRM_LUT_VALUE;
+	lut[0].blue = MAX_DRM_LUT_VALUE;
+
+	__drm_lut_to_dc_gamma(lut, gamma, false);
+
+	/* dc_fixpt_from_fraction(0xFFFF, 0xFFFF) = 1.0 */
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[0].value, one);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[0].value, one);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[0].value, one);
+}
+
+/* ---- Tests for __drm_lut32_to_dc_gamma ---- */
+
+static void dm_test_drm_lut32_to_dc_gamma_zero(struct kunit *test)
+{
+	struct drm_color_lut32 *lut;
+	struct dc_gamma *gamma;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	__drm_lut32_to_dc_gamma(lut, gamma);
+
+	/* All-zero LUT → fraction(0, 0xFFFFFFFF) = 0 */
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[0].value, 0LL);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[0].value, 0LL);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[0].value, 0LL);
+}
+
+static void dm_test_drm_lut32_to_dc_gamma_max(struct kunit *test)
+{
+	struct drm_color_lut32 *lut;
+	struct dc_gamma *gamma;
+	long long one = 1LL << 32;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	/* Max 32-bit LUT value should map to 1.0 in fixed-point */
+	lut[0].red = MAX_DRM_LUT32_VALUE;
+	lut[0].green = MAX_DRM_LUT32_VALUE;
+	lut[0].blue = MAX_DRM_LUT32_VALUE;
+
+	__drm_lut32_to_dc_gamma(lut, gamma);
+
+	/* dc_fixpt_from_fraction(0xFFFFFFFF, 0xFFFFFFFF) = 1.0 */
+	KUNIT_EXPECT_EQ(test, gamma->entries.red[0].value, one);
+	KUNIT_EXPECT_EQ(test, gamma->entries.green[0].value, one);
+	KUNIT_EXPECT_EQ(test, gamma->entries.blue[0].value, one);
+}
+
+static void dm_test_drm_lut32_to_dc_gamma_channels(struct kunit *test)
+{
+	struct drm_color_lut32 *lut;
+	struct dc_gamma *gamma;
+
+	lut = kunit_kcalloc(test, MAX_COLOR_LUT_ENTRIES,
+			    sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	gamma = kunit_kzalloc(test, sizeof(*gamma), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gamma);
+
+	/* Set distinct values per channel at index 1 */
+	lut[1].red = 1000;
+	lut[1].green = 2000;
+	lut[1].blue = 3000;
+
+	__drm_lut32_to_dc_gamma(lut, gamma);
+
+	/* Channels should differ */
+	KUNIT_EXPECT_NE(test, gamma->entries.red[1].value,
+			gamma->entries.green[1].value);
+	KUNIT_EXPECT_NE(test, gamma->entries.green[1].value,
+			gamma->entries.blue[1].value);
+	/* Red < Green < Blue since 1000 < 2000 < 3000 */
+	KUNIT_EXPECT_LT(test, gamma->entries.red[1].value,
+			 gamma->entries.green[1].value);
+	KUNIT_EXPECT_LT(test, gamma->entries.green[1].value,
+			 gamma->entries.blue[1].value);
+}
+
+/* ---- Tests for __extract_blob_lut ---- */
+
+static void dm_test_extract_blob_lut_null(struct kunit *test)
+{
+	uint32_t size = 42;
+	const struct drm_color_lut *lut;
+
+	lut = __extract_blob_lut(NULL, &size);
+
+	KUNIT_EXPECT_NULL(test, lut);
+	KUNIT_EXPECT_EQ(test, size, 0);
+}
+
+static void dm_test_extract_blob_lut_valid(struct kunit *test)
+{
+	const int num_entries = 4;
+	struct drm_property_blob *blob;
+	struct drm_color_lut *data;
+	const struct drm_color_lut *lut;
+	uint32_t size = 0;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+
+	data = kunit_kcalloc(test, num_entries, sizeof(*data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	data[0].red = 100;
+	data[0].green = 200;
+	data[0].blue = 300;
+
+	blob->data = data;
+	blob->length = num_entries * sizeof(struct drm_color_lut);
+
+	lut = __extract_blob_lut(blob, &size);
+
+	KUNIT_EXPECT_EQ(test, size, (uint32_t)num_entries);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+	KUNIT_EXPECT_EQ(test, lut[0].red, 100);
+	KUNIT_EXPECT_EQ(test, lut[0].green, 200);
+	KUNIT_EXPECT_EQ(test, lut[0].blue, 300);
+}
+
+/* ---- Tests for __extract_blob_lut32 ---- */
+
+static void dm_test_extract_blob_lut32_null(struct kunit *test)
+{
+	uint32_t size = 42;
+	const struct drm_color_lut32 *lut;
+
+	lut = __extract_blob_lut32(NULL, &size);
+
+	KUNIT_EXPECT_NULL(test, lut);
+	KUNIT_EXPECT_EQ(test, size, 0);
+}
+
+static void dm_test_extract_blob_lut32_valid(struct kunit *test)
+{
+	const int num_entries = 4;
+	struct drm_property_blob *blob;
+	struct drm_color_lut32 *data;
+	const struct drm_color_lut32 *lut;
+	uint32_t size = 0;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+
+	data = kunit_kcalloc(test, num_entries, sizeof(*data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	data[0].red = 100000;
+	data[0].green = 200000;
+	data[0].blue = 300000;
+
+	blob->data = data;
+	blob->length = num_entries * sizeof(struct drm_color_lut32);
+
+	lut = __extract_blob_lut32(blob, &size);
+
+	KUNIT_EXPECT_EQ(test, size, (uint32_t)num_entries);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+	KUNIT_EXPECT_EQ(test, lut[0].red, (uint32_t)100000);
+	KUNIT_EXPECT_EQ(test, lut[0].green, (uint32_t)200000);
+	KUNIT_EXPECT_EQ(test, lut[0].blue, (uint32_t)300000);
+}
+
+/* ---- Tests for __to_dc_lut3d_color ---- */
+
+static void dm_test_to_dc_lut3d_color_zero(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut lut = {0};
+
+	__to_dc_lut3d_color(&rgb, lut, 12);
+
+	KUNIT_EXPECT_EQ(test, rgb.red, 0U);
+	KUNIT_EXPECT_EQ(test, rgb.green, 0U);
+	KUNIT_EXPECT_EQ(test, rgb.blue, 0U);
+}
+
+static void dm_test_to_dc_lut3d_color_max(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut lut = {
+		.red = 0xFFFF,
+		.green = 0xFFFF,
+		.blue = 0xFFFF,
+	};
+
+	/* 12-bit extraction: 0xFFFF maps to (1 << 12) - 1 = 4095 */
+	__to_dc_lut3d_color(&rgb, lut, 12);
+
+	KUNIT_EXPECT_EQ(test, rgb.red, 4095U);
+	KUNIT_EXPECT_EQ(test, rgb.green, 4095U);
+	KUNIT_EXPECT_EQ(test, rgb.blue, 4095U);
+}
+
+static void dm_test_to_dc_lut3d_color_channels(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut lut = {
+		.red = 0x8000,
+		.green = 0x4000,
+		.blue = 0xC000,
+	};
+
+	__to_dc_lut3d_color(&rgb, lut, 12);
+
+	/* Channels should be distinct and ordered: green < red < blue */
+	KUNIT_EXPECT_GT(test, rgb.red, rgb.green);
+	KUNIT_EXPECT_GT(test, rgb.blue, rgb.red);
+}
+
+/* ---- Tests for __drm_3dlut_to_dc_3dlut ---- */
+
+static void dm_test_3dlut_to_dc_3dlut_distribution(struct kunit *test)
+{
+	/*
+	 * Use 9 entries: loop processes 2 groups of 4, then lut0 gets
+	 * one extra final entry. Total: lut0=3, lut1=2, lut2=2, lut3=2.
+	 */
+	const uint32_t lut3d_size = 9;
+	struct drm_color_lut *lut;
+	struct tetrahedral_params *params;
+	int i;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	/* Fill LUT with distinct values per entry */
+	for (i = 0; i < lut3d_size; i++) {
+		lut[i].red = (i + 1) * 1000;
+		lut[i].green = (i + 1) * 2000;
+		lut[i].blue = (i + 1) * 3000;
+	}
+
+	__drm_3dlut_to_dc_3dlut(lut, lut3d_size, params, true, 12);
+
+	/* Group 0: lut[0]→lut0[0], lut[1]→lut1[0], lut[2]→lut2[0], lut[3]→lut3[0] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].red,
+			drm_color_lut_extract(lut[0].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut1[0].red,
+			drm_color_lut_extract(lut[1].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut2[0].red,
+			drm_color_lut_extract(lut[2].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].red,
+			drm_color_lut_extract(lut[3].red, 12));
+
+	/* Group 1: lut[4]→lut0[1], lut[5]→lut1[1], lut[6]→lut2[1], lut[7]→lut3[1] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[1].red,
+			drm_color_lut_extract(lut[4].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut1[1].red,
+			drm_color_lut_extract(lut[5].red, 12));
+
+	/* Final extra entry: lut[8]→lut0[2] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[2].red,
+			drm_color_lut_extract(lut[8].red, 12));
+}
+
+static void dm_test_3dlut_to_dc_3dlut_tetrahedral_17(struct kunit *test)
+{
+	/* Minimal test with 5 entries using tetrahedral_17 path */
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut *lut;
+	struct tetrahedral_params *params;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	lut[0].red = 0xFFFF;
+	lut[0].green = 0;
+	lut[0].blue = 0;
+	lut[1].red = 0;
+	lut[1].green = 0xFFFF;
+	lut[1].blue = 0;
+	lut[2].red = 0;
+	lut[2].green = 0;
+	lut[2].blue = 0xFFFF;
+	lut[3].red = 0x8000;
+	lut[3].green = 0x8000;
+	lut[3].blue = 0x8000;
+	lut[4].red = 0xFFFF;
+	lut[4].green = 0xFFFF;
+	lut[4].blue = 0xFFFF;
+
+	__drm_3dlut_to_dc_3dlut(lut, lut3d_size, params, false, 12);
+
+	/* lut[0]→lut0[0]: red=4095, green=0, blue=0 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].red, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].green, 0U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].blue, 0U);
+
+	/* lut[1]→lut1[0]: red=0, green=4095, blue=0 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut1[0].green, 4095U);
+
+	/* lut[2]→lut2[0]: red=0, green=0, blue=4095 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut2[0].blue, 4095U);
+
+	/* lut[4]→lut0[1] (extra final entry): all 4095 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].red, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].green, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].blue, 4095U);
+}
+
+static void dm_test_3dlut_to_dc_3dlut_green_blue(struct kunit *test)
+{
+	/* Verify green and blue channels are also correctly distributed */
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut *lut;
+	struct tetrahedral_params *params;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	lut[0].red = 100;
+	lut[0].green = 200;
+	lut[0].blue = 300;
+	lut[3].red = 400;
+	lut[3].green = 500;
+	lut[3].blue = 600;
+
+	__drm_3dlut_to_dc_3dlut(lut, lut3d_size, params, true, 12);
+
+	/* lut[0]→lut0[0]: verify all channels */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].red,
+			drm_color_lut_extract(100, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].green,
+			drm_color_lut_extract(200, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].blue,
+			drm_color_lut_extract(300, 12));
+
+	/* lut[3]→lut3[0]: verify all channels */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].red,
+			drm_color_lut_extract(400, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].green,
+			drm_color_lut_extract(500, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].blue,
+			drm_color_lut_extract(600, 12));
+}
+
+/* ---- Tests for __to_dc_lut3d_32_color ---- */
+
+static void dm_test_to_dc_lut3d_32_color_zero(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut32 lut = {0};
+
+	__to_dc_lut3d_32_color(&rgb, lut, 12);
+
+	KUNIT_EXPECT_EQ(test, rgb.red, 0U);
+	KUNIT_EXPECT_EQ(test, rgb.green, 0U);
+	KUNIT_EXPECT_EQ(test, rgb.blue, 0U);
+}
+
+static void dm_test_to_dc_lut3d_32_color_max(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut32 lut = {
+		.red = 0xFFFFFFFF,
+		.green = 0xFFFFFFFF,
+		.blue = 0xFFFFFFFF,
+	};
+
+	/* 12-bit extraction: 0xFFFFFFFF maps to (1 << 12) - 1 = 4095 */
+	__to_dc_lut3d_32_color(&rgb, lut, 12);
+
+	KUNIT_EXPECT_EQ(test, rgb.red, 4095U);
+	KUNIT_EXPECT_EQ(test, rgb.green, 4095U);
+	KUNIT_EXPECT_EQ(test, rgb.blue, 4095U);
+}
+
+static void dm_test_to_dc_lut3d_32_color_channels(struct kunit *test)
+{
+	struct dc_rgb rgb = {0};
+	struct drm_color_lut32 lut = {
+		.red = 0x80000000,
+		.green = 0x40000000,
+		.blue = 0xC0000000,
+	};
+
+	__to_dc_lut3d_32_color(&rgb, lut, 12);
+
+	/* Channels should be distinct and ordered: green < red < blue */
+	KUNIT_EXPECT_GT(test, rgb.red, rgb.green);
+	KUNIT_EXPECT_GT(test, rgb.blue, rgb.red);
+}
+
+/* ---- Tests for __drm_3dlut32_to_dc_3dlut ---- */
+
+static void dm_test_3dlut32_to_dc_3dlut_distribution(struct kunit *test)
+{
+	/*
+	 * Use 9 entries: loop processes 2 groups of 4, then lut0 gets
+	 * one extra final entry. Total: lut0=3, lut1=2, lut2=2, lut3=2.
+	 */
+	const uint32_t lut3d_size = 9;
+	struct drm_color_lut32 *lut;
+	struct tetrahedral_params *params;
+	int i;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	/* Fill LUT with distinct values per entry */
+	for (i = 0; i < lut3d_size; i++) {
+		lut[i].red = (i + 1) * 100000;
+		lut[i].green = (i + 1) * 200000;
+		lut[i].blue = (i + 1) * 300000;
+	}
+
+	__drm_3dlut32_to_dc_3dlut(lut, lut3d_size, params, true, 12);
+
+	/* Group 0: lut[0]→lut0[0], lut[1]→lut1[0], lut[2]→lut2[0], lut[3]→lut3[0] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].red,
+			drm_color_lut32_extract(lut[0].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut1[0].red,
+			drm_color_lut32_extract(lut[1].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut2[0].red,
+			drm_color_lut32_extract(lut[2].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].red,
+			drm_color_lut32_extract(lut[3].red, 12));
+
+	/* Group 1: lut[4]→lut0[1], lut[5]→lut1[1], lut[6]→lut2[1], lut[7]→lut3[1] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[1].red,
+			drm_color_lut32_extract(lut[4].red, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut1[1].red,
+			drm_color_lut32_extract(lut[5].red, 12));
+
+	/* Final extra entry: lut[8]→lut0[2] */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[2].red,
+			drm_color_lut32_extract(lut[8].red, 12));
+}
+
+static void dm_test_3dlut32_to_dc_3dlut_tetrahedral_17(struct kunit *test)
+{
+	/* Minimal test with 5 entries using tetrahedral_17 path */
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut32 *lut;
+	struct tetrahedral_params *params;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	lut[0].red = 0xFFFFFFFF;
+	lut[0].green = 0;
+	lut[0].blue = 0;
+	lut[1].red = 0;
+	lut[1].green = 0xFFFFFFFF;
+	lut[1].blue = 0;
+	lut[2].red = 0;
+	lut[2].green = 0;
+	lut[2].blue = 0xFFFFFFFF;
+	lut[3].red = 0x80000000;
+	lut[3].green = 0x80000000;
+	lut[3].blue = 0x80000000;
+	lut[4].red = 0xFFFFFFFF;
+	lut[4].green = 0xFFFFFFFF;
+	lut[4].blue = 0xFFFFFFFF;
+
+	__drm_3dlut32_to_dc_3dlut(lut, lut3d_size, params, false, 12);
+
+	/* lut[0]→lut0[0]: red=4095, green=0, blue=0 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].red, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].green, 0U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[0].blue, 0U);
+
+	/* lut[1]→lut1[0]: red=0, green=4095, blue=0 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut1[0].green, 4095U);
+
+	/* lut[2]→lut2[0]: red=0, green=0, blue=4095 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut2[0].blue, 4095U);
+
+	/* lut[4]→lut0[1] (extra final entry): all 4095 */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].red, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].green, 4095U);
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_17.lut0[1].blue, 4095U);
+}
+
+static void dm_test_3dlut32_to_dc_3dlut_green_blue(struct kunit *test)
+{
+	/* Verify green and blue channels are also correctly distributed */
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut32 *lut;
+	struct tetrahedral_params *params;
+
+	lut = kunit_kcalloc(test, lut3d_size, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	params = kunit_kzalloc(test, sizeof(*params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, params);
+
+	lut[0].red = 100000;
+	lut[0].green = 200000;
+	lut[0].blue = 300000;
+	lut[3].red = 400000;
+	lut[3].green = 500000;
+	lut[3].blue = 600000;
+
+	__drm_3dlut32_to_dc_3dlut(lut, lut3d_size, params, true, 12);
+
+	/* lut[0]→lut0[0]: verify all channels */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].red,
+			drm_color_lut32_extract(100000, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].green,
+			drm_color_lut32_extract(200000, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut0[0].blue,
+			drm_color_lut32_extract(300000, 12));
+
+	/* lut[3]→lut3[0]: verify all channels */
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].red,
+			drm_color_lut32_extract(400000, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].green,
+			drm_color_lut32_extract(500000, 12));
+	KUNIT_EXPECT_EQ(test, params->tetrahedral_9.lut3[0].blue,
+			drm_color_lut32_extract(600000, 12));
+}
+
+static struct kunit_case dm_color_test_cases[] = {
+	/* amdgpu_dm_fixpt_from_s3132 */
+	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
+	KUNIT_CASE(dm_test_fixpt_from_s3132_one),
+	KUNIT_CASE(dm_test_fixpt_from_s3132_negative_one),
+	KUNIT_CASE(dm_test_fixpt_from_s3132_half),
+	KUNIT_CASE(dm_test_fixpt_from_s3132_neg_half),
+	/* __is_lut_linear */
+	KUNIT_CASE(dm_test_is_lut_linear_with_linear_lut),
+	KUNIT_CASE(dm_test_is_lut_linear_with_nonlinear_lut),
+	KUNIT_CASE(dm_test_is_lut_linear_rgb_mismatch),
+	/* __drm_ctm_to_dc_matrix */
+	KUNIT_CASE(dm_test_drm_ctm_to_dc_matrix_identity),
+	KUNIT_CASE(dm_test_drm_ctm_to_dc_matrix_negative),
+	KUNIT_CASE(dm_test_drm_ctm_to_dc_matrix_4th_col_zero),
+	/* __drm_ctm_3x4_to_dc_matrix */
+	KUNIT_CASE(dm_test_drm_ctm_3x4_to_dc_matrix_identity),
+	KUNIT_CASE(dm_test_drm_ctm_3x4_to_dc_matrix_offset),
+	/* amdgpu_tf_to_dc_tf */
+	KUNIT_CASE(dm_test_tf_to_dc_tf_default),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_identity),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_srgb),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_bt709),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_pq),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_gamma22),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_gamma24),
+	KUNIT_CASE(dm_test_tf_to_dc_tf_gamma26),
+	/* amdgpu_colorop_tf_to_dc_tf */
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_srgb),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_pq),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_bt2020),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_gamma22),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_default),
+	/* __drm_lut_to_dc_gamma */
+	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_legacy_zero),
+	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_legacy_max),
+	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_legacy_channels),
+	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_nonlegacy_zero),
+	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_nonlegacy_max),
+	/* __drm_lut32_to_dc_gamma */
+	KUNIT_CASE(dm_test_drm_lut32_to_dc_gamma_zero),
+	KUNIT_CASE(dm_test_drm_lut32_to_dc_gamma_max),
+	KUNIT_CASE(dm_test_drm_lut32_to_dc_gamma_channels),
+	/* __extract_blob_lut */
+	KUNIT_CASE(dm_test_extract_blob_lut_null),
+	KUNIT_CASE(dm_test_extract_blob_lut_valid),
+	/* __extract_blob_lut32 */
+	KUNIT_CASE(dm_test_extract_blob_lut32_null),
+	KUNIT_CASE(dm_test_extract_blob_lut32_valid),
+	/* __to_dc_lut3d_color */
+	KUNIT_CASE(dm_test_to_dc_lut3d_color_zero),
+	KUNIT_CASE(dm_test_to_dc_lut3d_color_max),
+	KUNIT_CASE(dm_test_to_dc_lut3d_color_channels),
+	/* __drm_3dlut_to_dc_3dlut */
+	KUNIT_CASE(dm_test_3dlut_to_dc_3dlut_distribution),
+	KUNIT_CASE(dm_test_3dlut_to_dc_3dlut_tetrahedral_17),
+	KUNIT_CASE(dm_test_3dlut_to_dc_3dlut_green_blue),
+	/* __to_dc_lut3d_32_color */
+	KUNIT_CASE(dm_test_to_dc_lut3d_32_color_zero),
+	KUNIT_CASE(dm_test_to_dc_lut3d_32_color_max),
+	KUNIT_CASE(dm_test_to_dc_lut3d_32_color_channels),
+	/* __drm_3dlut32_to_dc_3dlut */
+	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_distribution),
+	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_tetrahedral_17),
+	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_green_blue),
+	{}
+};
+
+static struct kunit_suite dm_color_test_suite = {
+	.name = "amdgpu_dm_color",
+	.test_cases = dm_color_test_cases,
+};
+
+kunit_test_suite(dm_color_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_color");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

