Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B42C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B785210F1D9;
	Thu, 23 Jul 2026 20:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UboURbeN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B0710E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3pJTh4jaMTwhxhKWtpU7ShCUeCA1JueixDPRGCCCdigYkoEmnkg3O2vpnt3uwud6MTt3+TSNoTV4+zmsJTJV4eFdAVrS+JMMR//uI4NAAvSyHj5McycUiuhJP9pYzKfqeEyB6+Y5NJHdSxl1BINQ5qSGuav/m4cJ2V5/7bZCvM85R5pXlWMg3qWOVVpURoFeK63i2NRbXFHHqk3mB/Or/izbYGBRQkAznvCA/LssDh9GJrt3XP7uBvGEYXfN5F3yg6Qd3d099aFInU3NXrdS7AddYy3oWdbLfQf9qIFwLivcEixIKwW3iKKscJdlhs/hyCKnyOOZi54WVcv3S1eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apLMxjneQeo+bAyzLUREkolOp5FCA/qKl4igzQLLCg0=;
 b=ekWqOJXLY8TKih3mJo3ZWq34TBJSB51GBHLILx2aP/jkLPVHTdwxQy/MZUnd/tUjcI3hkW1YLMP5n/JLl9vKte+ftQ1FBy3uD4WTL1YF44HJVPpXsTNREK82dkY1gMajV+tf6L90GcKdoPRj62s/G6JVU/cdQf+3Ss1L67iMNF87YGSD8QaKPPsRdaJC/gNAO2Gxs2V/TL0C3Xa0LH9MDrlEm6/ULv36C2zvuNORx4IqgzMI0xpEob3mFkarn9Cgef4ZewAE9i3cI7fhYBqMK2erl3/8Q394436WycHJjlKrTHiJ5T3tC8cEGKpRffRumMQ7dTG2C7Tx4EVcBEsV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apLMxjneQeo+bAyzLUREkolOp5FCA/qKl4igzQLLCg0=;
 b=UboURbeNyjBA7gT/UVe93nw//a1XIBQcVlpdXrlmZ/5yZmBnOtxcTumBvCzLLWhpOH5eE6Yc1HtrYkRO+qwpn8IzijJ97/F9soNqiQ3bGP5WfpryHRCUKwMVJWG/+EbQHhjWlLd6nCwQfgsyRTtBiq7FKwKZWfzqLbdXrLeVgfw=
Received: from BN1PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:e1::13)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:16 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::4e) by BN1PR12CA0008.outlook.office365.com
 (2603:10b6:408:e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:16 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:04 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 22/49] drm/amd/display: Add KUnit test for native backlight
 registration
Date: Thu, 23 Jul 2026 16:13:30 -0400
Message-ID: <20260723201908.373300-23-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcf36c3-0ad8-45a3-1053-08dee8f7ab56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tmKcTfs8d43VxK2+YOik94DiDSwzICvmBR3c6/aarPubTTCpiwOu9dYvL3MNDLhBjqSwKVFr8+TR7Zzy+XP+Fw0mintwdqMNcimOyqNOKJl0F7SbS/gPc020nPVny8RHMO8tdxXHO+cQ4/AzWFQU8+9CT1ZnfydNaFElmdH0qc+NQTmZ/oqsPhTMKVW0LGXzdI/FlrK/Z0pWJaAwB0zBl8ulj13zXcXdf/XCHQ+p9o3QAOKd+jRAUW3IpG0aEYTD7rZ5o51xXveg19fQdPWPf7iTlSu0bWSolJdUG7zMCtXZrfKrPO/ycoGLzY61VU9SoFCQwNyVKIhuUAmAWOsYj3qm6PDfdGPL7EJ8WJqEfOKRtYXltMMiKP1JtJBBB48ajFzK4vBAGpTR1SYna3HHM1E9G7HqDFyBEXYrAvZo4WXKJVK70qVspEwoybJKUcphR8HarWN8/zXB54zU5OogS7GaBl9F1duw0PgUby5R2f46UuK7+yz1OSsH2G4gMggjcoHinVw8ih4VzhBKvzTbbnmv0NP2S/pwa6klVPQwrBytu+GPX0JzU+k8i8MEhkAa1a3ijaCkJbQpTinzY41B2+FauNjPp8MCVQS6GSaQ/kJaOEDCI+0swKpmZcKK4JaTjSMR7pkpS+n0Gxbv0pSMlKUMswavm7aphpmqLCgioRTfor4c6hIxBCAJS+hciV219wVciKgM+o8K6U5dy65j0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0lPSCxXFP5vZPhJA3dThZDMvwj5rO3ZmVGai50UXDh2KchqmQjyeSeOGfxRmzPC9UWl6hg6f2RMzcekQr7EvtEAzkAkjQnZpVyaIeCvmAkU+3kQGXraX9uQx9LeaoXusrOQP+3OfS1VRmTfX4+Q98LoZVDfEqsgveINVgR4jwnYHqUMlOHTGLLGUuvMQYwb9yuTh0sbI26RPHN9/YpPXuNKW+sCzVllZ0ZSvj45DYW/X5FnJRfzaGuJ4n8Dat1wzPwmPbQfDtrjqaAI6HCh+Von82WzdIrIFAmikneTqaZlXLSYl6dARLIIwksUY2EnZJdi3SWIvOJgKEoNp6N6Rq+YOY14Zgzw/ws2Mro6rBdsVDbTgW2Ozv/xHnQBawdSoBcIVpIAek630sbLFWYXNAzK93/MF8pHgNBJ5XWEoIzmuLmuQO31Vreu+HEeTk1rU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:16.1874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcf36c3-0ad8-45a3-1053-08dee8f7ab56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add a KUnit case covering the successful path of
amdgpu_dm_register_backlight_device(). The test uses the standard DRM
KUnit device helpers to register a native backlight device, verifies the
calculated backlight properties and cached brightness, and unregisters
the device through KUnit cleanup to avoid leaking a class device across
cases.

Assisted-by: Copilot:GPT-5.6-Terra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 618fd5142da0..7ca17f803f9d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -326,6 +326,11 @@ static int dm_test_get_backlight_level_error(const struct dc_link *link)
 	return DC_ERROR_UNEXPECTED;
 }
 
+static void dm_test_unregister_backlight_device(void *data)
+{
+	backlight_device_unregister(data);
+}
+
 static bool dm_test_get_backlight_level_nits(struct dc_link *link,
 					     uint32_t *avg,
 					     uint32_t *peak)
@@ -463,6 +468,52 @@ static void dm_test_register_backlight_device_negative_index(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.backlight_dev[0]);
 }
 
+/**
+ * dm_test_register_backlight_device_success - Test native backlight registration
+ * @test: The KUnit test context
+ *
+ * A native backlight device must be registered with the calculated
+ * properties, and its initial readback must retain the initial brightness.
+ */
+static void dm_test_register_backlight_device_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_backlight_caps *caps;
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct drm_minor *primary;
+	unsigned int max;
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
+	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	adev->ddev.primary = primary;
+	adev->dm.backlight_link[0] = link;
+
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+	aconnector->bl_idx = 0;
+	aconnector->base.kdev = adev->ddev.dev;
+	caps = &adev->dm.backlight_caps[0];
+	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->ac_level = 50;
+	caps->dc_level = 25;
+	max = 0x101 * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+
+	amdgpu_dm_register_backlight_device(aconnector);
+
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.backlight_dev[0]);
+	KUNIT_EXPECT_EQ(test, adev->dm.backlight_dev[0]->props.max_brightness, max);
+	KUNIT_EXPECT_EQ(test, adev->dm.backlight_dev[0]->props.brightness,
+			DIV_ROUND_CLOSEST(max * caps->ac_level, 100));
+	KUNIT_EXPECT_EQ(test, adev->dm.brightness[0],
+			adev->dm.backlight_dev[0]->props.brightness);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			dm_test_unregister_backlight_device,
+			adev->dm.backlight_dev[0]), 0);
+}
+
 static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
 							 struct device **device_out,
 							 struct dm_connector_state **state_out)
@@ -1861,6 +1912,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_get_brightness_uses_device_index),
 	/* amdgpu_dm_register_backlight_device */
 	KUNIT_CASE(dm_test_register_backlight_device_negative_index),
+	KUNIT_CASE(dm_test_register_backlight_device_success),
 	/* panel_power_savings_show / store */
 	KUNIT_CASE(dm_test_panel_power_savings_show_maps_disable_to_zero),
 	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
-- 
2.53.0

