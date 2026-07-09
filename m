Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D357C4450A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9C810F6ED;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ths1XKSc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120A410F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0CvUEbaVa9b13QjZm+ZKDguLbzwtVTSr3yTMY9azPFO3OBWrqBtFUlyvkiJT1Gmd40trdXMgtd6NvSWpVvGLHZKkV8bO14PeEOqcUWcMDHrtvwBh3Mt3UnL0Kkzv8eq9DHBRrt7wpAyDL66krbPux0En8OaR/pnsjCjxNahH4GfAtLM57vl772t43SLgumeiElySV1MZ4b9SzNomWLmRSSNaAukzCwtGFMMmJhDiOGkVKUGG7Bh3z3HpiybCOoKzI0q97zJS1UBbT612sQAM6E1u/sS0jCljlV2cfF5aOJ8YEeVXeMaTz5dlPNk59AF85+khk3OyeCBS5pn4tt3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHGXv5S3RzwxRhhAly21G76gE4hcemsa3FAXCsk+/P8=;
 b=Y6JkJ9JcwEbIKmHXcVfESMvVmucWnLZpVfRYmCvE55ucZXMXpkHAXLr0kzA/rIt+Y9AASeSEn06aiaUFGLmhHKZ18VyUgQP2SP3y6mAfVouKLmXAB+ouQm0Wf/LUDUmKQ0vRfJPMOULhCIKdH6RbYzBvOXaocWgRIg0iepLI3pUTTsL7jOIyw1er/wSiZqAkj2DZkikBLYd8QKkRoj0bZELDNtCm4B1QVfreZzeLtpGpMn21pxX0xfQW4CFoCjhLele21neam3PcTtSlEWWeyvLqES7faan5RV6ix3Cp1tw2gLc42adZNFk+XcDgRTxCxWt+lJ4r58sDAhMtVlkg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHGXv5S3RzwxRhhAly21G76gE4hcemsa3FAXCsk+/P8=;
 b=ths1XKScVz4TfSY21+fc3bF7mLG1dOYxc7Vz7/wjbG8g61CqwRvUHdroqwfGtaRIfyaXEwXsE+E/IC+L9gyBtvhV1Zzuef1BnyLYXVmqwqelzkjxL8LTvUeimdJd7bv3d5PdvwoieTwfek6Fi1j41I9MYXWvxtC2VIWzX+vOOyg=
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:35 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::82) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:25 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 64/80] drm/amd/display: Test backlight device registration
Date: Thu, 9 Jul 2026 16:48:32 -0400
Message-ID: <20260709205936.5719-65-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e16d83-803d-4f67-d8cc-08deddfd670a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4CSYZT17s7CO/JSC7esjfWp8NTSu5kT7q4dnyLIZ/dxmQ1wWU1jZRoT+7SfZ1Vbx6zDh1clvxM3vI/zvJltwPi/kqYMzNEpyTxD9dgvMOwC9Nlr4r8C3gW5vfF1YbIW44+5nNIsLiQla7oqj53bWe8F50azSth3Mv6hXppmLmNvJG2XVB0a7Dd1boxXRHw/8i15mYgOSl/D5/kwcdgFwfvRgqGIErdR03uuJ7Xw9Eg6e6X+ZghvH5yWUXLsWxq1iKYgvF/JoT87ofBBs7Sr+yo4HCAv2CaKEqOF+i8M6R4fJcnylVJz/B2oON9c4OhhB8HCGpiUpVRhSwRj3PpDVnPgg/W/VYZdi8W1t3gYeFjX/6ZMc25oXNs8hdwSENaWga4/4MHQ4IGkio/JQy8PgpblM18HbrQQkuY1fwu6F9ktRy0SMCET4dr8OIm058Oq5ReX0HGYulyt/XiTGIKVBOarYF/qQ7MA1BanGMsK99Xgocik6X3E96eIgkFh2MMQS7WSRueGWI00BjAHa7sfqCZNotnmwdpcHCAxEe76Sty22BP2QAEybJp/Uux4vVgiXROHizjGBB6GtrnZ4byOOl4NLzGQbsn58yIgZHKDFoBbK0vBW6QQzKaKmXEMH4jlMPvLZqgERu0wvy0zsJ3YjiEwpi0DdbIUZZ3ldJ/8uURg+V/GLPtXs4bJCQ/rZKJ5Yx2LhwV7g/BtepZYLadWewA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BB7xTzESdDw3x4Km0KbnqFBXhZNB/4Le9o/nCg5pFYqJ9jz1I/t/ypbiYnqnHWuB6S+njwbBl7lgXLyfCAcCyk6hglvcxLN/0KodS0a2T1UJzY+Ggmvb1ybZqcjO+viI24MOU/AlS6/QLiInS6Zju3lXxnL5tbH+ZG+SAzZ15DqwhcFl3eG/+cylxjdSmu0AGLPYuy7Piu7TZF/v//6vcNO9mX/H7GQyul1kQmrsGdvjrtywqEoidhauywPdL2PsqqPdzuCZHP3M/0m7O+PwrgXNg7XYUhaXCAD3XUk5YwhK+ZTvYFpk5MVjxGjuH55FZEmZUap9zJVDv0Ah5uWVFlniKZ4zucXa8hAmnIDqEYVIWmtDmC4GVkTWhUuO9ADfQQygykvXlcHxsOpFNr1HMniBfqz0lVXCInLlKl0q6CFT+plh8el1VHR8PdmmYwM1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:35.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e16d83-803d-4f67-d8cc-08deddfd670a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
Add KUnit test to amdgpu_dm_register_backlight_device() and
cover its bl_idx == -1 early return, which must leave the
backlight device slot untouched.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  1 +
 .../tests/amdgpu_dm_backlight_test.c          | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 452e772ef136..859cbce2cdaf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -494,6 +494,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_register_backlight_device);
 
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 10965306e29d..5a2c32d53487 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -440,6 +440,24 @@ static void dm_test_backlight_get_brightness_uses_device_index(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_brightness(bd), 2468);
 }
 
+/* Tests for amdgpu_dm_register_backlight_device() */
+
+/**
+ * dm_test_register_backlight_device_negative_index - Test invalid index no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_register_backlight_device_negative_index(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	aconnector->bl_idx = -1;
+
+	amdgpu_dm_register_backlight_device(aconnector);
+	KUNIT_EXPECT_NULL(test, adev->dm.backlight_dev[0]);
+}
+
 /* Tests for amdgpu_dm_backlight_get_device_index() */
 
 /**
@@ -1616,6 +1634,8 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_get_level_aux_success),
 	KUNIT_CASE(dm_test_backlight_get_level_aux_error),
 	KUNIT_CASE(dm_test_backlight_get_brightness_uses_device_index),
+	/* amdgpu_dm_register_backlight_device */
+	KUNIT_CASE(dm_test_register_backlight_device_negative_index),
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
-- 
2.55.0

