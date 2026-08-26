Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A702C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA3010EE4A;
	Wed, 26 Aug 2026 23:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pmj9SYyn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2D710EE4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEiRp2/1fEgPedKNPc/KuhfVbfmk5bgenHVTWIq/muqBpUbUALZr+uTcwm+rNlEU4FWsINtk399G3yPB5j48wrKTsrDl9N/wr4k8JBLju+99OFv1xjcAfz/Y/37SGMbP/skP0DWP+3iBTrWXXKHdaCMPtCyIegFnEvgcCAAnefgBIfktVkPbG70HqbjE3NkLCjOdUayKd9XMXvOCJ9bNRHUYPdcSBep/QVM2dntZohVJxxk69dzycIyJRI+Xz5kIPWZJibVOpTqcmjxTlGd5O9ZMKfULg9zVGkSPdrbfvoqvifM0pboD2ngtDQ7LbXrDv+vIU5eVoWK0YWT2bj6Wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIVXaXDMmEIM8p9AXfQymdxgH1rWu5q/JVAWh+rOQbo=;
 b=g6KkEYfy98U8Nun3+zq1WN6u1gUUMlqNrmmwNIcUMn5NW6NR+GMd4q2nxliNzeMe4TudpFPdodJPbzd6T5cn1Y7AgO5XNgKvRm7i+LAxQuDpeYrID8XkysWyjgLVo65wlVr71zlgg2d9o6tHnHRoR+ve8eXmjmTxhUvQtc/B1MKt/nCQULl7Gwecz42b2eTeqOUGku0HsvTmuBNEMcVSfOO2L8JwIrksvpfdp6+tCFnKxdfC7foAHS3SdudjPgqUemKjZ9l4AUTBCKFHT1Hk84P3IfyqG4jBk1rZ/CrPWyhS2AHBoO+C8IUgTI400tI0++8tEzEvGx4RDYU1UTuMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIVXaXDMmEIM8p9AXfQymdxgH1rWu5q/JVAWh+rOQbo=;
 b=pmj9SYynPZNVXWXFwbPpTjAGMiHn3a/fMFYhvhiZQZfZ5CBYaH/vX9z8cSBb5xBVN/XfnVOVll2Swtrom+zLieASHioGbTDyu9E1TFcBdDIMlbDZG3t+ucH1X3xN6kjwgP4/C9Vvyst8JSGSqR/BiHilV8NFuZY0Bim0xt9ewOw=
Received: from SA1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:806:2cf::25)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:24:33 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::5c) by SA1PR02CA0023.outlook.office365.com
 (2603:10b6:806:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:24:33 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:24:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 26/59] drm/amd/display: Test backlight caps validation
Date: Wed, 26 Aug 2026 17:04:57 -0600
Message-ID: <20260826231519.881949-27-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb64c9b-cab9-434a-0e0d-08df03c92f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: PIWnoJIYSVhUWiR56Sr80Bx1nkmHLlj1vKXBUvLQu6werHRlVi3p42uZN21uedFJEgTgYo2XIhle+yDbuEXCQnip2GGMsfqrY72OmbQg0m4Squ5G3Qgqo9T49Msg1SgADucAAVGhFMvgHyyJIzBy92JOihzQj7BWORVxbgWUSW/on6OGUHInZQSzqgnkL5J/+VBhN3yvpp0uJNqylkD5Cj9bAWTwnF3oUkhGV+u38cZwVYjGmjUz1eS5bgyhCB7hPxBpy8LINVNnRPU6yDt8rRw/GlDANkrydGnifT4ahiSGS04MK6hBIusWN/KW3cvgmhU2mobfKF+vuCpvCeOZvAOf4/MJbGFYbdLGU+iPS8UtVJpms/w0xUpr9prpHT50QTZroTpTkezJiLDePtA3+x/EN++3bCXVAZvmfHCkvGmH+D0LVQGOTjXqqVYUFaoTpiySg90rvrE+504HmQ4W7yIVa3CCPcAHaHiFbF27YzRjfp/vwWDGLdsw8VP01w3GR0SUcF/hqRb3kYJuqqBdqJBUhgw/7UPlRYcAtH9Cdlcd0f4+3BzF+YUenXbJHxV6uMurdYKfrrQBWYC1WJDC52S1dABcPqAhQf9ENMLYFpcsKd99tKciFNTcxWOyyaI52qUIPVnc1r2tGJCIsW1GDP53iig80S9SbKUXx7QF/wBnQWZfzpRnJ98ZYlMTXyeHvDLDgZvR+GuU4/hAOo6xZw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ca56O5ibS75UMLajB29JSsZgwfPR3Yt4C0cpEEPJvHb/jNayqfDdcu42A0s6d1N1WYVIwtCLTZEX3bzJQOfyXqk47hQq36SKXYypAO1djbxi/BY2ko0dlL5lQy3MmaQrgFE3iuJlFszJHs7I/K/sfjpxaVa1LpGLk4zejuR8cPXEK9lyH4c61vXVBX23GD+kvvnjKx58dh3fyepaipB8f3kAc/FWkjXbvWwISMhebAWsv69eoUaRazE2CvrFWhqU3Ym0lomkC0pZ5DVBLGOeioH+VmIUSGQaFWxzCSK8z8oJLsFzTQr7+qG8eRIFJEq8+wYkN6VndoABXM5KwME1oX+D3FP14GvR/lofD4453a80t77CR11AlpIV6u87MdxEpHrIItw/bpq1WSzJnvWBwzfS7lHUfMOcxU6hy4m1yL5DooXtALxBP9YTp9F0ET/m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:24:33.0878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb64c9b-cab9-434a-0e0d-08df03c92f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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
The sanity check applied to the backlight caps reported by the
firmware sits inside a CONFIG_ACPI block. The UML KUnit build cannot
enable CONFIG_ACPI, so that logic is never built and stays uncovered.

[HOW]
Move the check into amdgpu_dm_validate_backlight_caps() and build it
whenever CONFIG_ACPI or the KUnit tests are enabled. Behaviour of
amdgpu_dm_update_backlight_caps() is unchanged.

Add a parameterized test for amdgpu_dm_validate_backlight_caps()
covering sane caps, a max above the 8-bit range, a negative min and a
spread narrower than AMDGPU_DM_MIN_SPREAD.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 33 +++++++++-----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  1 +
 .../tests/amdgpu_dm_backlight_test.c          | 44 +++++++++++++++++++
 3 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index e61bbc310f33..a5ad59ec3e81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -49,6 +49,25 @@
 #include "amd_shared.h"
 #include "dm_helpers.h"
 
+#if defined(CONFIG_ACPI) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+STATIC_IFN_KUNIT
+void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx)
+{
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
+	int spread = caps->max_input_signal - caps->min_input_signal;
+
+	if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+	    caps->min_input_signal < 0 ||
+	    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+	    spread < AMDGPU_DM_MIN_SPREAD) {
+		drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
+			    caps->min_input_signal, caps->max_input_signal);
+		caps->caps_valid = false;
+	}
+}
+EXPORT_IF_KUNIT(amdgpu_dm_validate_backlight_caps);
+#endif
+
 void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 				     int bl_idx)
 {
@@ -61,18 +80,8 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 	amdgpu_acpi_get_backlight_caps(caps);
 
 	/* validate the firmware value is sane */
-	if (caps->caps_valid) {
-		int spread = caps->max_input_signal - caps->min_input_signal;
-
-		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps->min_input_signal < 0 ||
-		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    spread < AMDGPU_DM_MIN_SPREAD) {
-			drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
-				      caps->min_input_signal, caps->max_input_signal);
-			caps->caps_valid = false;
-		}
-	}
+	if (caps->caps_valid)
+		amdgpu_dm_validate_backlight_caps(dm, bl_idx);
 #else
 	if (caps->aux_support)
 		return;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 07b75064847c..9ad888d3ae7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -53,6 +53,7 @@ bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 extern const struct attribute_group amdgpu_group;
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx);
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 7ca17f803f9d..5a8eb9e54b6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -792,6 +792,48 @@ static void dm_test_backlight_caps_non_aux_sets_defaults(struct kunit *test)
 }
 #endif
 
+/* Tests for amdgpu_dm_validate_backlight_caps() */
+
+struct dm_validate_caps_param {
+	const char *name;
+	int min_input_signal;
+	int max_input_signal;
+	bool caps_valid;
+};
+
+static const struct dm_validate_caps_param dm_validate_caps_params[] = {
+	{ "sane", AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT, true },
+	{ "max_too_large", AMDGPU_DM_DEFAULT_MIN_BACKLIGHT,
+	  AMDGPU_DM_DEFAULT_MAX_BACKLIGHT + 1, false },
+	{ "negative_min", -1, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT, false },
+	{ "narrow_spread", 100, 100 + AMDGPU_DM_MIN_SPREAD - 1, false },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_validate_caps, dm_validate_caps_params, name);
+
+/**
+ * dm_test_validate_backlight_caps - Test the firmware caps sanity check
+ * @test: The KUnit test context
+ *
+ * Caps above the 8-bit range, with a negative min or with a spread narrower
+ * than AMDGPU_DM_MIN_SPREAD must be rejected.
+ */
+static void dm_test_validate_backlight_caps(struct kunit *test)
+{
+	const struct dm_validate_caps_param *param = test->param_value;
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	dm->adev = dm_kunit_alloc_adev(test);
+	caps->caps_valid = true;
+	caps->min_input_signal = param->min_input_signal;
+	caps->max_input_signal = param->max_input_signal;
+
+	amdgpu_dm_validate_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_EQ(test, caps->caps_valid, param->caps_valid);
+}
+
 /* Tests for get_brightness_range() */
 
 /**
@@ -1928,6 +1970,8 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
 	KUNIT_CASE(dm_test_backlight_caps_non_aux_sets_defaults),
 #endif
+	/* amdgpu_dm_validate_backlight_caps */
+	KUNIT_CASE_PARAM(dm_test_validate_backlight_caps, dm_validate_caps_gen_params),
 	/* get_brightness_range */
 	KUNIT_CASE(dm_test_brightness_range_null_caps),
 	KUNIT_CASE(dm_test_brightness_range_pwm),
-- 
2.43.0

