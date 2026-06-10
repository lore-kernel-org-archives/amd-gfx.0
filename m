Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A7FCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1BF10E893;
	Wed, 10 Jun 2026 09:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="102zImLa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AA910E893
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUzDqw0ETu5L1kwip4UWth9qtCWD1hTDUABU5tMYtVvc+SW3GbK+hm0DCEJnvkePLAOVopZrG6U5Qmr7d70Yro8MRCJ4hdrNweGnHwlJ7OfS44cvXxFYG9R3A71YbrRbOkv0ucKymmo+cwDGcytXXk0GU7CR8m4DeP4+h9ppTSgtb5R0qocwWCR4ztpaP319ZxaCw7awNeq9qnRxMJy7Yk9vRXPWpmAx7FXSBtzdUPfx8JjIAlvySMo/N/d+a1gX88l5H5vM5n02f0Brk8hBhObJHHYNlMORdU8D+nNNonUfZgAkDUXBY49rLuHMAi028n3a0SkuPmKQRx3lPct0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxNRegAIL9I1lGSaSSYiqkabAkEOkXH2lbJvFhoxj7A=;
 b=KCWZhMH/gT9gMZZ3i4Isj5+gyEc+0roA1yH4JMSRVj+cirbA267XXSuwmJhKjug83XY7FHzOSDVA3CeHL/WMP4RKDvXqmCFkPCAEV/6L/C6jifLp68vZifNuh4G3y1LwxkR6N6pofRc/Eal8SsfFYYs1Uv9PqTAJBRUrRLi2cBirnA43pRgd2J/CxUjWfWvjZPo/L0xKmWDYz59MB4QK9AF+b/kb7TUBweHnTm1hc4eT9XVZYtheO89kzqeU+kkhllRiTDqRLu3i1qko/Qk85ByEnWG4+yWjri6d+T8azel0NM//Xvs1SDjl83on0oyUAeqMYVodIpiolIQlm5MwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxNRegAIL9I1lGSaSSYiqkabAkEOkXH2lbJvFhoxj7A=;
 b=102zImLagzSieozyuoVFTD3ZTlwT8TX2q/lOpTZ55M8J1uq7n1bLMsHBZom6Ug3ADVYvBl5IckhR3cwzVwKWJuLzFMhm9rc+ZB2sAWaeGhsX86shjjqGrfUajrQ56dJxQm9yRqSO1Nin1ZzcOVD7O0iuAVxkmm/5YVRu6sA4TpM=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 09:52:34 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::1e) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 09:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:33 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:52:24 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 30/32] drm/amd/display: Move backlight macros to backlight
 header
Date: Wed, 10 Jun 2026 17:45:14 +0800
Message-ID: <20260610094639.1965367-31-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 4636c1a2-12b2-4af3-a461-08dec6d5feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v4N6zcfnwLISjHWIfR8Ldbu3CT5b0Debml9W+H/ny9Y4lR4/B213e6fnkqlknNKqlY9UcVPukmrtr7uWNjBpPwHe5qn1IefLpvrdNMT/gV7roHgeothchR4Z3CVeQna6BKkYA1AZNykbyJADWIw/htz39WCt2NOYerBnVrgONWnpfTE9UU2FM52oCp4zBpTcgAyZKDKwFo03Nt4LdS/RDrQMW/yKBBfORgHDbOz8qP2ITZevE1zf9nHXJ/Mk9eseJ7fEWIyRmr1uY0Ej68GhrD+JK+AFxfc0znGJhmW5lF2aArJU6A2NE3gqXiPP2Zr9GnfOsjH5sBvLx88Y0JBpgJnbvc+kYXh2Ro3lN+ggE0911WtSlDyy+UfIUeF9TfA8OwmWoXAXNK6Btfqr7i08JsLoQHcCaxWPaC/rN4eUvRNfKzMniu5zjwrjWiCtGdsEbLDckglKMT9pcMRJ1GBcgDjaay8ra6dn6ogvmLd5VdGbDbCY/XqN5MkaFcry+A3eZ8EqNenLhFEmmzoOVFNC1HcvNt8jO52D+1eS6WpqoYJKepKHmkZJzaGXv8RpPdIUE1WV2kD2Ag8wsOiEkoQmVheBpqzjS8ametrG9oGgO0fS/dpgZL4v3lbbJuF/WjLzxAnWYU9G1JdWYfYD//FQpf8hTRti+s+2SugEKHa+alHK/m3OMd4hRvgxraVPMrYkjG77WVI1nCMh3YgPkRuOSz5+9rrk00PlVby1EsJs8Ic=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xSNf4sgO6RTSwI2ttLvNljvlL9d0qGKez9QK3JlfisrdkO/96lq3eKOCyeH48qvj2+/t2LDWKH9/0kfv6sj4TEcs/Zkwl5a4QWY1KW73iZu3RSL5xG9/dfMpr4+seTnTZ5zA97Y+0gtmczUm8P1q6CKBlDnGjM9NyGhEMyy8YaLH2yyo//TrM8heXoebYBHNB6sKa4mgAZFqAB+IiesgBkUa+WfCYMfmQ8X2eXffLFQZcefZ0eN0bgoj75eVkEDSpZQyLFBZ3HDJz66IJnONhszcIfbOTcaIfHZj9hPonj3CUp/bYnev0559k+EnghLvYrbOnyTyVCYPwYRPVMKVks3q+ETtg0ypDZFYJX728HFsqjb598P6/g0Bidnhf0KXaLAKeZ/MFrbXHMq6p2z8Ie+701NFLONzDSawjX6kdtWoC+asTduzfmYb9X8ml98Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:33.6416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4636c1a2-12b2-4af3-a461-08dec6d5feb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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

[WHAT]
Move AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT,
AMDGPU_DM_MIN_SPREAD, and AUX_BL_DEFAULT_TRANSITION_TIME_MS from
amdgpu_dm_backlight.c to amdgpu_dm_backlight.h so they can be reused
by KUnit tests. Update the test file to use these macros instead of
hardcoded literal values.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  5 --
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  5 ++
 .../tests/amdgpu_dm_backlight_test.c          | 62 +++++++++----------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 0a861d846677..f19092a3237e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -49,11 +49,6 @@
 #include "amd_shared.h"
 #include "amdgpu_dm_kunit_helpers.h"
 
-#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
-#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
-#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
-#define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
-
 void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 				     int bl_idx)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 5234da6ae484..a6c01b7ccab3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -29,6 +29,11 @@ struct amdgpu_dm_connector;
 struct drm_connector;
 struct attribute_group;
 
+#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
+#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
+#define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
+
 void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 				     int bl_idx);
 void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 2f4293cfd478..8763cd635ae1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -110,8 +110,8 @@ static void dm_test_backlight_caps_non_aux_sets_defaults(struct kunit *test)
 	amdgpu_dm_update_backlight_caps(dm, 0);
 
 	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
-	KUNIT_EXPECT_EQ(test, caps->min_input_signal, 12);
-	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 255);
+	KUNIT_EXPECT_EQ(test, caps->min_input_signal, AMDGPU_DM_DEFAULT_MIN_BACKLIGHT);
+	KUNIT_EXPECT_EQ(test, caps->max_input_signal, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
 }
 #endif
 
@@ -141,13 +141,13 @@ static void dm_test_brightness_range_pwm(struct kunit *test)
 	unsigned int min, max;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
-	/* 0x101 * 12 = 3084, 0x101 * 255 = 65535 */
-	KUNIT_EXPECT_EQ(test, min, 0x101U * 12);
-	KUNIT_EXPECT_EQ(test, max, 0x101U * 255);
+	/* 0x101 * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, 0x101 * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT */
+	KUNIT_EXPECT_EQ(test, min, 0x101U * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT);
+	KUNIT_EXPECT_EQ(test, max, 0x101U * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
 }
 
 /**
@@ -195,10 +195,10 @@ static void dm_test_brightness_to_user_below_min(struct kunit *test)
 	struct amdgpu_dm_backlight_caps caps = {};
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	/* brightness < min (0x101*12 = 3084), should return 0 */
+	/* brightness < min (0x101*AMDGPU_DM_DEFAULT_MIN_BACKLIGHT), should return 0 */
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, 100), 0U);
 }
 
@@ -212,8 +212,8 @@ static void dm_test_brightness_to_user_at_max(struct kunit *test)
 	unsigned int min, max;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	get_brightness_range(&caps, &min, &max);
 
@@ -231,8 +231,8 @@ static void dm_test_brightness_to_user_at_min(struct kunit *test)
 	unsigned int min, max;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	get_brightness_range(&caps, &min, &max);
 
@@ -251,8 +251,8 @@ static void dm_test_brightness_to_user_midpoint_pwm(struct kunit *test)
 	u64 expected;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	get_brightness_range(&caps, &min, &max);
 
@@ -286,8 +286,8 @@ static void dm_test_brightness_from_user_zero(struct kunit *test)
 	unsigned int min, max;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	/* no custom curve */
 	caps.data_points = 0;
 
@@ -307,8 +307,8 @@ static void dm_test_brightness_from_user_max(struct kunit *test)
 	unsigned int min, max;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 0;
 
 	get_brightness_range(&caps, &min, &max);
@@ -403,7 +403,7 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 3;
 	caps.luminance_data[0].input_signal = 50;
 	caps.luminance_data[0].luminance = 20;
@@ -453,7 +453,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 2;
 	caps.luminance_data[0].input_signal = 100;
 	caps.luminance_data[0].luminance = 40;
@@ -498,7 +498,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 2;
 	caps.luminance_data[0].input_signal = 50;
 	caps.luminance_data[0].luminance = 20;
@@ -539,7 +539,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 2;
 	caps.luminance_data[0].input_signal = 50;
 	caps.luminance_data[0].luminance = 20;
@@ -580,7 +580,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 1;
 	caps.luminance_data[0].input_signal = 128;
 	caps.luminance_data[0].luminance = 50;
@@ -616,7 +616,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 2;
 	caps.luminance_data[0].input_signal = 50;
 	caps.luminance_data[0].luminance = 0;	/* zero lower luminance */
@@ -650,8 +650,8 @@ static void dm_test_brightness_to_user_above_max(struct kunit *test)
 	unsigned int min, max, result;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	get_brightness_range(&caps, &min, &max);
 
@@ -672,8 +672,8 @@ static void dm_test_brightness_from_user_midrange(struct kunit *test)
 	u32 result;
 
 	caps.aux_support = false;
-	caps.min_input_signal = 12;
-	caps.max_input_signal = 255;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 0;
 
 	get_brightness_range(&caps, &min, &max);
@@ -700,7 +700,7 @@ static void dm_test_brightness_from_user_with_curve(struct kunit *test)
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
-	caps.max_input_signal = 255;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 2;
 	caps.luminance_data[0].input_signal = 50;
 	caps.luminance_data[0].luminance = 20;
-- 
2.43.0

