Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD333C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476DB10EE32;
	Wed, 26 Aug 2026 23:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEUOTB3X";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A9010EE32
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNJl73ZpdXWGiuCofLIIy37jvzSw6Skj4QB4QKyWjqp4iFPmvCrXSpWe6yKP+t87h6kmqNTaccW3TFjWKpzLRX1eq6enA+yqiu7FWK6DS3nTuB7yeqYP+q90SFtAoXsLtFbVDdLANSZaJfXkuCcjkC4U4xZK8dv0oh7LhEY07BmwYcbfvJqWNFp50F4XucfaQwi2vhAg2Hmee81y2aj1aSHR1sXgiHk+YMwidA/j1Z8cJNuOxZoMpiAk4O5auV7gEQ+g/T5swaWULXCZhiA6tJavS/OjW5rIukhdMVcEPAflZ5c/r5PHlIokwf1D6wjtb/TQ4ChB9n0T9ZyndEKy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPzP/exEFW1hifKv2eBt1/YP1PfvGR7Ahdq5veEu49s=;
 b=TvtHaVhRJ/ANzw6/YJCb+ptY4+9KyY8tZ+tjV/vImtrwF091o7yngw4wqkxzm+SCX90j4lcIpmwwCSkHujxLbJu7fknJTKPuUkfKlwwVG+Wfvpdei0LnvJesS6CyLClndHPmvcrQVvaSIvUJAZvusgPKbagb2DOkHA4e+mTRH5HSELjmsfj7oCpsXFQyupOZCpBbGy2aRGjhBspFRpdeJcnROGWRlcuPbdH1wMFdaRWadsbhgU4KRjNgxjRAm9gv44MB/iKhNxxVkAWv0kyzWn9m5So5qJgF9lc2F0SG61L2JK7SvtnaKToT9YWmT+2i0FLEFnFYqEMMi8dtQgOtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPzP/exEFW1hifKv2eBt1/YP1PfvGR7Ahdq5veEu49s=;
 b=AEUOTB3X8qemt9RhflKqQnI5t76ARSP91OR4b9emvcSFFDEx4H0I9Z3KC18cVRADlrp26xtNqy4gM4vRfr8g6hCyak18JM901abOt9u0tmqPmc3ItcBdkZ4DmFGoNzPH2XGGVAIRaqMJe9LQUP0Hr6lZJXM20sYOdVwnRykhzhw=
Received: from PH8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:2cd::25)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:17:27 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::4c) by PH8PR07CA0014.outlook.office365.com
 (2603:10b6:510:2cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.9 via Frontend Transport; Wed, 26
 Aug 2026 23:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:17:27 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:17:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 05/59] drm/amd/display: Test colorop error paths
Date: Wed, 26 Aug 2026 17:04:36 -0600
Message-ID: <20260826231519.881949-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: e9386308-38b3-4ea0-cc89-08df03c831ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8O00ZiW5uecrv/BZvV29KIE8edNqvPbjlw5bbSA9Czjj0jkEk2UFAIK/Wujk6fuN+pLoKIqZP/iOj1rBPS8SyaPRipR0AD2M5q8Aq9Ii/MtAXetmE20LdKcW8O+/djlkts8Ic1baRgTL4YmYrSJFOZfx70AwaahVa5grmSdwrdi8xamIM+EmwCsGCVWZ9zXn8SXUXI991mVUCpIxXiyICEZR3f3D9YkJVAL3p8G/gou2FDtZxk+K/6Zu8+NwKOylyKUGwVVMSFAE9EzI/dM8wOHtLftJjU6vKryrp9L2NtKgZPEniTsAQbparRl2ySwh4aNV5V10j7EHnTxByXqU2RpqNeOpV0bq6xK3MfdvF4i6zv3UdOTXIbNXED/jTJTuFNjBjSxWUbk5HpklMd2yEilaV3zj5PdPsHRavnFYbMWtPTL4v/2Ro77glqxFnNnt3vGT9zdKUGaX2qTDxqnBxE00kWctuLPQ/ibmDqK6VSzx+kcJuapf7vF/oisDkMdSaEORhh7LCS8cmq+hncg/fuXvYONqBeOC/EOOyNsxKGpZoA5WKVaWsZ4A1aK1PIO6y4vBaBITM7pVuUYmIiP4n4jU0P2BPyBPcqv4b2GJnQBsIRjURiRojahUyGySEqMqXZxudPveNiF1zmW7CCxtWp2sTOLJEWqO5MouSfyXNOvD1/lrADCOLLEgVZ8G/V1BlMBJosx72wTox4KJZo6EpA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 85Hi36QWEk2lCGKMH2dT7FDLVNYQn/k1EUAvpyNF1cKKSRRfJlht7z/HBDMUF30hFGM42163MlJKx+d1W6H+3V9uHeI8rwhJdNRIC8y3Tq9zjIwFEG1o8YXdjIkfxihF4uoS5hp/OqkGmxd/DW04p6pfHbBlPwMpsSBBtWEeumlZZY1Z4KQ7FuvwCPqr2D5r/CHlFnKORVOvghdO8hhESETRJbp95ug7BYEK0jJuk3pMLWGvi0VxOuwNpTCmuu4PrugnX2Eh2D07nfk5ec37kLkZBL7MP20ekqwLM6LOwJLADgx5Im8EK8NL2STrmNU0FiUIomNTFODk2PepmDgBeC4iP32zFpP9rIQguP2ylPlp0xbAIBZ9WMBssCfumnIyScBZO3wmZxWG/aWpg8iQp0s/ME8rnpLOMoeWs/hT3EB4WLtNLwnbdjSScryNuUiq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:17:27.1685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9386308-38b3-4ea0-cc89-08df03c831ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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

[WHAT]
Add KUnit tests for the failure paths of
amdgpu_dm_build_default_pipeline(): a failed allocation and a failed
initialization at each of the eight pipeline steps.

[HOW]
Add struct amdgpu_dm_colorop_kunit_ops, a KUnit-only indirection table
for the colorop allocation and the five DRM colorop constructors. The
constructors cannot be made to fail through their arguments, so tests
install a fake allocator and spies that delegate to the real
constructors and override the return value of one selected call.
Non-KUnit builds call the same functions directly.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 110 ++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  28 +++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 232 ++++++++++++++++--
 3 files changed, 312 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index fae9007b9998..d7260518a23e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -63,6 +63,48 @@ static const struct drm_colorop_funcs dm_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static struct drm_colorop *amdgpu_dm_colorop_kzalloc(void)
+{
+	return kzalloc_obj(struct drm_colorop);
+}
+
+static const struct amdgpu_dm_colorop_kunit_ops amdgpu_dm_colorop_default_ops = {
+	.colorop_kzalloc_obj = amdgpu_dm_colorop_kzalloc,
+	.curve_1d_init = drm_plane_colorop_curve_1d_init,
+	.curve_1d_lut_init = drm_plane_colorop_curve_1d_lut_init,
+	.ctm_3x4_init = drm_plane_colorop_ctm_3x4_init,
+	.mult_init = drm_plane_colorop_mult_init,
+	.lut3d_init = drm_plane_colorop_3dlut_init,
+};
+
+static const struct amdgpu_dm_colorop_kunit_ops *amdgpu_dm_colorop_ops =
+	&amdgpu_dm_colorop_default_ops;
+
+void amdgpu_dm_colorop_kunit_set_ops(const struct amdgpu_dm_colorop_kunit_ops *ops)
+{
+	amdgpu_dm_colorop_ops = ops ? ops : &amdgpu_dm_colorop_default_ops;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_colorop_kunit_set_ops);
+
+#define colorop_kzalloc_obj		amdgpu_dm_colorop_ops->colorop_kzalloc_obj
+#define colorop_curve_1d_init		amdgpu_dm_colorop_ops->curve_1d_init
+#define colorop_curve_1d_lut_init	amdgpu_dm_colorop_ops->curve_1d_lut_init
+#define colorop_ctm_3x4_init		amdgpu_dm_colorop_ops->ctm_3x4_init
+#define colorop_mult_init		amdgpu_dm_colorop_ops->mult_init
+#define colorop_3dlut_init		amdgpu_dm_colorop_ops->lut3d_init
+
+#else
+
+#define colorop_kzalloc_obj()		kzalloc_obj(struct drm_colorop)
+#define colorop_curve_1d_init		drm_plane_colorop_curve_1d_init
+#define colorop_curve_1d_lut_init	drm_plane_colorop_curve_1d_lut_init
+#define colorop_ctm_3x4_init		drm_plane_colorop_ctm_3x4_init
+#define colorop_mult_init		drm_plane_colorop_mult_init
+#define colorop_3dlut_init		drm_plane_colorop_3dlut_init
+
+#endif
+
 STATIC_IFN_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				  bool hw_3d_lut, struct drm_prop_enum_list *list)
@@ -74,15 +116,15 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	memset(ops, 0, sizeof(ops));
 
 	/* 1D curve - DEGAM TF */
-	ops[i] = kzalloc_obj(*ops[0]);
+	ops[i] = colorop_kzalloc_obj();
 	if (!ops[i]) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
-					      amdgpu_dm_supported_degam_tfs,
-					      DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
+				    amdgpu_dm_supported_degam_tfs,
+				    DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
@@ -91,14 +133,14 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	i++;
 
 	/* Multiplier */
-	ops[i] = kzalloc_obj(struct drm_colorop);
+	ops[i] = colorop_kzalloc_obj();
 	if (!ops[i]) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_mult_init(dev, ops[i], plane, &dm_colorop_funcs,
-					  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = colorop_mult_init(dev, ops[i], plane, &dm_colorop_funcs,
+				DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
@@ -107,15 +149,14 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	i++;
 
 	/* 3x4 matrix */
-	ops[i] = kzalloc_obj(struct drm_colorop);
+	ops[i] = colorop_kzalloc_obj();
 	if (!ops[i]) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane,
-					     &dm_colorop_funcs,
-					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = colorop_ctm_3x4_init(dev, ops[i], plane, &dm_colorop_funcs,
+				   DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
@@ -125,15 +166,15 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 
 	if (hw_3d_lut) {
 		/* 1D curve - SHAPER TF */
-		ops[i] = kzalloc_obj(*ops[0]);
+		ops[i] = colorop_kzalloc_obj();
 		if (!ops[i]) {
 			ret = -ENOMEM;
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
-						amdgpu_dm_supported_shaper_tfs,
-						DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		ret = colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
+					    amdgpu_dm_supported_shaper_tfs,
+					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
 			goto cleanup;
 
@@ -142,17 +183,16 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 		i++;
 
 		/* 1D LUT - SHAPER LUT */
-		ops[i] = kzalloc_obj(*ops[0]);
+		ops[i] = colorop_kzalloc_obj();
 		if (!ops[i]) {
 			ret = -ENOMEM;
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane,
-							&dm_colorop_funcs,
-							MAX_COLOR_LUT_ENTRIES,
-							DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
-							DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		ret = colorop_curve_1d_lut_init(dev, ops[i], plane, &dm_colorop_funcs,
+						MAX_COLOR_LUT_ENTRIES,
+						DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
+						DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
 			goto cleanup;
 
@@ -161,16 +201,16 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 		i++;
 
 		/* 3D LUT */
-		ops[i] = kzalloc_obj(*ops[0]);
+		ops[i] = colorop_kzalloc_obj();
 		if (!ops[i]) {
 			ret = -ENOMEM;
 			goto cleanup;
 		}
 
-		ret = drm_plane_colorop_3dlut_init(dev, ops[i], plane,
-					&dm_colorop_funcs, LUT3D_SIZE,
-					DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
-					DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		ret = colorop_3dlut_init(dev, ops[i], plane, &dm_colorop_funcs,
+					 LUT3D_SIZE,
+					 DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
+					 DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
 			goto cleanup;
 
@@ -180,15 +220,15 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	}
 
 	/* 1D curve - BLND TF */
-	ops[i] = kzalloc_obj(*ops[0]);
+	ops[i] = colorop_kzalloc_obj();
 	if (!ops[i]) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
-					      amdgpu_dm_supported_blnd_tfs,
-					      DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
+				    amdgpu_dm_supported_blnd_tfs,
+				    DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
@@ -197,16 +237,16 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	i++;
 
 	/* 1D LUT - BLND LUT */
-	ops[i] = kzalloc_obj(struct drm_colorop);
+	ops[i] = colorop_kzalloc_obj();
 	if (!ops[i]) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	ret = drm_plane_colorop_curve_1d_lut_init(dev, ops[i], plane, &dm_colorop_funcs,
-						  MAX_COLOR_LUT_ENTRIES,
-						  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
-						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	ret = colorop_curve_1d_lut_init(dev, ops[i], plane, &dm_colorop_funcs,
+					MAX_COLOR_LUT_ENTRIES,
+					DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
+					DRM_COLOROP_FLAG_ALLOW_BYPASS);
 	if (ret)
 		goto cleanup;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 77364d954d3b..ff46c4f7b126 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -34,8 +34,36 @@ extern const u64 amdgpu_dm_supported_blnd_tfs;
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#include <drm/drm_colorop.h>
+
+struct amdgpu_dm_colorop_kunit_ops {
+	struct drm_colorop *(*colorop_kzalloc_obj)(void);
+	int (*curve_1d_init)(struct drm_device *dev, struct drm_colorop *colorop,
+			     struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+			     u64 supported_tfs, uint32_t flags);
+	int (*curve_1d_lut_init)(struct drm_device *dev, struct drm_colorop *colorop,
+				 struct drm_plane *plane,
+				 const struct drm_colorop_funcs *funcs,
+				 uint32_t lut_size,
+				 enum drm_colorop_lut1d_interpolation_type interpolation,
+				 uint32_t flags);
+	int (*ctm_3x4_init)(struct drm_device *dev, struct drm_colorop *colorop,
+			    struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+			    uint32_t flags);
+	int (*mult_init)(struct drm_device *dev, struct drm_colorop *colorop,
+			 struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
+			 uint32_t flags);
+	int (*lut3d_init)(struct drm_device *dev, struct drm_colorop *colorop,
+			  struct drm_plane *plane,
+			  const struct drm_colorop_funcs *funcs,
+			  uint32_t lut_size,
+			  enum drm_colorop_lut3d_interpolation_type interpolation,
+			  uint32_t flags);
+};
+
 int amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				      bool hw_3d_lut, struct drm_prop_enum_list *list);
+void amdgpu_dm_colorop_kunit_set_ops(const struct amdgpu_dm_colorop_kunit_ops *ops);
 #endif
 
 #endif /* __AMDGPU_DM_COLOROP_H__*/
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 2e557ff66818..90cc5592ef5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -136,6 +136,30 @@ static void kunit_colorop_pipeline_destroy(void *drm)
 	drm_colorop_pipeline_destroy((struct drm_device *)drm);
 }
 
+/*
+ * A plain drm_device (not an amdgpu_device) is enough: building the pipeline
+ * only needs the DRM mode-config infrastructure. The pipeline is destroyed
+ * before the DRM device so the colorops are freed while the device is valid.
+ */
+static struct drm_plane *dm_colorop_alloc_plane(struct kunit *test, struct drm_device **drm)
+{
+	struct drm_plane *plane;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	*drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(**drm), 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, *drm);
+
+	plane = drm_kunit_helper_create_primary_plane(test, *drm, NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	kunit_add_action(test, kunit_colorop_pipeline_destroy, *drm);
+
+	return plane;
+}
+
 static void dm_expect_colorop_pipeline(struct kunit *test, struct drm_device *drm,
 				       const struct drm_prop_enum_list *list,
 				       const enum drm_colorop_type *expected,
@@ -177,34 +201,12 @@ static void dm_test_initialize_default_pipeline(struct kunit *test)
 		DRM_COLOROP_1D_CURVE,	/* blnd TF */
 		DRM_COLOROP_1D_LUT,	/* blnd LUT */
 	};
-	struct device *dev;
 	struct drm_device *drm;
 	struct drm_plane *plane;
 	struct drm_prop_enum_list list = {};
 	int ret;
 
-	dev = drm_kunit_helper_alloc_device(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
-
-	/*
-	 * Allocate a plain drm_device (not an amdgpu_device) — sufficient
-	 * because amdgpu_dm_build_default_pipeline() only needs the DRM
-	 * mode-config infrastructure, not the amdgpu device wrapper.
-	 */
-	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
-						   sizeof(*drm), 0, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
-
-	plane = drm_kunit_helper_create_primary_plane(test, drm,
-						       NULL, NULL, NULL, 0, NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
-
-	/*
-	 * Destroy the pipeline before the DRM device is cleaned up so
-	 * that the colorop objects (kzalloc'd inside the function) are
-	 * freed while the device is still valid.
-	 */
-	kunit_add_action(test, kunit_colorop_pipeline_destroy, drm);
+	plane = dm_colorop_alloc_plane(test, &drm);
 
 	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, &list);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -308,6 +310,187 @@ static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *test)
 						 expected, ARRAY_SIZE(expected));
 }
 
+/* Failure paths of amdgpu_dm_build_default_pipeline() */
+
+/*
+ * The DRM colorop constructors cannot be made to fail through their arguments,
+ * so failures are injected with a fake allocator and with spies that delegate
+ * to the real constructors and override the return value of one call.
+ */
+struct dm_colorop_fault {
+	int alloc_fail_at;	/* allocation index returning NULL, -1 to disable */
+	int init_fail_at;	/* init call index returning an error, -1 to disable */
+	int allocs;
+	int inits;
+};
+
+static struct dm_colorop_fault dm_colorop_fault;
+
+static struct drm_colorop *dm_colorop_test_alloc(void)
+{
+	if (dm_colorop_fault.allocs++ == dm_colorop_fault.alloc_fail_at)
+		return NULL;
+
+	return kzalloc_obj(struct drm_colorop);
+}
+
+static int dm_colorop_test_init_ret(int ret)
+{
+	if (ret)
+		return ret;
+
+	if (dm_colorop_fault.inits++ == dm_colorop_fault.init_fail_at)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dm_colorop_test_curve_1d_init(struct drm_device *dev, struct drm_colorop *colorop,
+					 struct drm_plane *plane,
+					 const struct drm_colorop_funcs *funcs,
+					 u64 supported_tfs, uint32_t flags)
+{
+	return dm_colorop_test_init_ret(drm_plane_colorop_curve_1d_init(dev, colorop, plane,
+									funcs, supported_tfs,
+									flags));
+}
+
+static int dm_colorop_test_1d_lut_init(struct drm_device *dev, struct drm_colorop *colorop,
+				       struct drm_plane *plane,
+				       const struct drm_colorop_funcs *funcs,
+				       uint32_t lut_size,
+				       enum drm_colorop_lut1d_interpolation_type interpolation,
+				       uint32_t flags)
+{
+	return dm_colorop_test_init_ret(drm_plane_colorop_curve_1d_lut_init(dev, colorop, plane,
+									    funcs, lut_size,
+									    interpolation,
+									    flags));
+}
+
+static int dm_colorop_test_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs, uint32_t flags)
+{
+	return dm_colorop_test_init_ret(drm_plane_colorop_ctm_3x4_init(dev, colorop, plane,
+								       funcs, flags));
+}
+
+static int dm_colorop_test_mult_init(struct drm_device *dev, struct drm_colorop *colorop,
+				     struct drm_plane *plane,
+				     const struct drm_colorop_funcs *funcs, uint32_t flags)
+{
+	return dm_colorop_test_init_ret(drm_plane_colorop_mult_init(dev, colorop, plane,
+								    funcs, flags));
+}
+
+static int dm_colorop_test_3dlut_init(struct drm_device *dev, struct drm_colorop *colorop,
+				      struct drm_plane *plane,
+				      const struct drm_colorop_funcs *funcs, uint32_t lut_size,
+				      enum drm_colorop_lut3d_interpolation_type interpolation,
+				      uint32_t flags)
+{
+	return dm_colorop_test_init_ret(drm_plane_colorop_3dlut_init(dev, colorop, plane, funcs,
+								     lut_size, interpolation,
+								     flags));
+}
+
+static const struct amdgpu_dm_colorop_kunit_ops dm_colorop_test_ops = {
+	.colorop_kzalloc_obj = dm_colorop_test_alloc,
+	.curve_1d_init = dm_colorop_test_curve_1d_init,
+	.curve_1d_lut_init = dm_colorop_test_1d_lut_init,
+	.ctm_3x4_init = dm_colorop_test_ctm_3x4_init,
+	.mult_init = dm_colorop_test_mult_init,
+	.lut3d_init = dm_colorop_test_3dlut_init,
+};
+
+static void dm_colorop_test_reset_ops(void *unused)
+{
+	amdgpu_dm_colorop_kunit_set_ops(NULL);
+}
+
+/*
+ * Build the full (3D LUT) pipeline with one injected failure and return the
+ * error reported by amdgpu_dm_build_default_pipeline().
+ */
+static int dm_colorop_build_with_fault(struct kunit *test, struct drm_device **drm,
+				       int alloc_fail_at, int init_fail_at)
+{
+	struct drm_prop_enum_list list = {};
+	struct drm_plane *plane;
+	int ret;
+
+	plane = dm_colorop_alloc_plane(test, drm);
+
+	dm_colorop_fault = (struct dm_colorop_fault){
+		.alloc_fail_at = alloc_fail_at,
+		.init_fail_at = init_fail_at,
+	};
+
+	amdgpu_dm_colorop_kunit_set_ops(&dm_colorop_test_ops);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_colorop_test_reset_ops, NULL), 0);
+
+	ret = amdgpu_dm_build_default_pipeline(*drm, plane, true, &list);
+	kfree(list.name);
+
+	return ret;
+}
+
+struct dm_colorop_step_param {
+	const char *name;
+	int index;
+};
+
+/* Pipeline steps in creation order when the 3D LUT block is built. */
+static const struct dm_colorop_step_param dm_colorop_step_params[] = {
+	{ "degam_tf",	0 },
+	{ "multiplier",	1 },
+	{ "ctm_3x4",	2 },
+	{ "shaper_tf",	3 },
+	{ "shaper_lut",	4 },
+	{ "lut3d",	5 },
+	{ "blnd_tf",	6 },
+	{ "blnd_lut",	7 },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_colorop_step, dm_colorop_step_params, name);
+
+/**
+ * dm_test_build_pipeline_alloc_fail() - Verify a failed alloc returns -ENOMEM and cleans up.
+ * @test: KUnit test context.
+ */
+static void dm_test_build_pipeline_alloc_fail(struct kunit *test)
+{
+	const struct dm_colorop_step_param *param = test->param_value;
+	struct drm_device *drm;
+	int ret;
+
+	ret = dm_colorop_build_with_fault(test, &drm, param->index, -1);
+
+	KUNIT_EXPECT_EQ(test, ret, -ENOMEM);
+	KUNIT_EXPECT_EQ(test, dm_colorop_fault.allocs, param->index + 1);
+	KUNIT_EXPECT_EQ(test, dm_colorop_fault.inits, param->index);
+	KUNIT_EXPECT_EQ(test, drm->mode_config.num_colorop, 0);
+}
+
+/**
+ * dm_test_build_pipeline_init_fail() - Verify a failed init propagates the error and cleans up.
+ * @test: KUnit test context.
+ */
+static void dm_test_build_pipeline_init_fail(struct kunit *test)
+{
+	const struct dm_colorop_step_param *param = test->param_value;
+	struct drm_device *drm;
+	int ret;
+
+	ret = dm_colorop_build_with_fault(test, &drm, -1, param->index);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_colorop_fault.allocs, param->index + 1);
+	KUNIT_EXPECT_EQ(test, dm_colorop_fault.inits, param->index + 1);
+	KUNIT_EXPECT_EQ(test, drm->mode_config.num_colorop, 0);
+}
+
 static struct kunit_case dm_colorop_test_cases[] = {
 	/* degam TFs */
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_srgb_eotf),
@@ -334,6 +517,9 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_initialize_default_pipeline_dpp_3d_lut),
 	KUNIT_CASE(dm_test_initialize_default_pipeline_mpc_preblend),
 	KUNIT_CASE(dm_test_initialize_default_pipeline_no_3d_lut),
+	/* amdgpu_dm_build_default_pipeline failure paths */
+	KUNIT_CASE_PARAM(dm_test_build_pipeline_alloc_fail, dm_colorop_step_gen_params),
+	KUNIT_CASE_PARAM(dm_test_build_pipeline_init_fail, dm_colorop_step_gen_params),
 	{}
 };
 
-- 
2.43.0

