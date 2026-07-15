Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B5EC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2847A10F095;
	Wed, 15 Jul 2026 13:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qhdTCpUZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14ECC10F094
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYMUmbPhLi9fVz/WbJL0zhK3VsILBna6dZzVEx/1TPH6rgq3JsG2wXK9wHzNQdIV931cf7Fk+8gM/DgHJ8u3OOKeyZdf7CzxQCkb7pH/fJq4hQ5Cimpx9gndLixbPWNZxIw2uIs2i4c2Xe8XAxlKtOkxV6t1AD8RTl577IYSA6tc6HNPbwORmb++PkkcTdBkxUqZJHQtdM7RX5reVHOph+Z3c5bP5EuefFXqWU56+4YlZ1wxsfhC0VvCPeH0rVDF0OAGrWw8vEbO/akUzjR+MRCzKjI548OSgD69Mc0tZEs3yaCnBVewm298UIlXn1J19+o0GjrfySTTn8yP25IUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PIT9d5koIKPaK50yGSxm1UOvyxdJGuV4d/fN3dyxJI=;
 b=xhilT2ySBgB7qe16DxCocQeLKZ7Yb6y5F0viJ+vf0bVemxAfnLo3Tbbnqt+jqzLHFxdr76hdMd6A74pgY+eJ1dDPcTkJ3/qbOlLK20Mup60GJ6SJzEaPFdk3wgDcSHUBKMm75MOXbFQaUl+VTpHVXUwNanf8oUVd1TiiKcve3Rlgh296URXcxjE5gzCz64n5ZCZozFVuGEWp9r9k7rRyx4KBRm/jTBGTQJ8oEiQ5zyODAxe66B8PLT5C6Ut1UzqN70ZChuu6WJCGIlK/wE7T0xwA55vNBVKWWqpXWrUfxTiN9Q7KWyR2CCYge0cHbEFzeO1HTPegFvI3oJTW7KMHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PIT9d5koIKPaK50yGSxm1UOvyxdJGuV4d/fN3dyxJI=;
 b=qhdTCpUZNLpcPNGdkSpw6F5tFK64WxYoIs/4zD7Hc/Kw9bPzBvyQXWtqtq2noQZvFSDb1OE1x0jdkrrWJwkgGnguwdCfG4KEn35GgV5+YANYBS+G695uZGF9kWIQ7JbXgd3zTowKp2YZjb62j5GRURynNJ/yQQEWaGleTEZKOVg=
Received: from DS7P220CA0073.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::7) by
 SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:47:18 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::a5) by DS7P220CA0073.outlook.office365.com
 (2603:10b6:8:259::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 38/70] drm/amd/display: add KUnit tests for DPCD poweroff delay
Date: Wed, 15 Jul 2026 21:37:48 +0800
Message-ID: <20260715134432.1975118-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: f287a88f-0283-41a2-c171-08dee2779633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|3023799007|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: auhjQR2CZ8tzKGDoob91HyJ9yhrE+j4CAHIzzlomYpryTTqbem81KQbSy8+oduMX/PtDTnhZI+ELMNHTWb3PhBmmgArXO/GcOPQ9CBUbP2lGh70sYZqaXUZw6mLpz6bN8Mw2yqnzvlR3Xjy17uCEEA6DqV7nkkVUSseFVL2sio+JBkZPJ0SFE+0qZTDVmNPKIxkbDv9N0jCoTTKg5VXLbPoyqS5W5sS/bBrW5RzTKOi9oCEcocc959FXytNvZu5crdfPKjfA7jfS/7EmEaBRCWj9bR/qUnpjzmnWPWrcDM2GLAd/pspkD8rHmIetxx1A8GTnYPSQQQ66xTvtn3Cn9NBUlKhVNMhcXfKR3fISLFr386UvuO/rFNrBdosqrbRga9KZcInekjG/ujWNqjKhCx6xW+0hWkEn0Vkh1YePSL0Qn/+kX1WFV61Ihi0QrMloPYmbK2uMu0ru1yOZDOaBaV9D+zReJKmPsmOtaZJm0RxLXgUv0nPNm+9Cx1xA2legzdJWez6bQkTlBXeHkhke2WQYK4klw+be81et11CaJmwibPGnExJrkSyex0gsczLVRmtJptINO5E3xXK6CWl+4XUu9Nac8cI06Ea9uSx0iEJOKMhdHRPZXcrYJ1MYJOcblcLqC9ULpSlL01Bd4UvOARuMr3iF6O+SayFaW5hv6G45aJo7gm6MHqwGrDeOd+dX6z7eZLHnSxLK5QNIkQFA5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /S0zHaEnmtp7XEzgM2HsJyQnSRRi7Y18avDNeHOdL7h1UhAOlqmQyCefFNOtJw6R6bpRdWA3xtL9DyPz6FsHZ/Gp+nxhbJbWiOmh7k/kxQGTf4buyFbiua1gfNT+8Cu81boSEA+adUEwMZa4zWIdAhSfS85fIHJ48/8wlR2EzUQcd9+J/OFSX0oBSAn8Nyim5dE/ZgCH08Sy9qk26rLlE5SbHH3LB7wFmdsZEHe0uJA8sVDyXhVITDPGIzLDT/VUjIrYko6v1q7+jmQj8qFQVrZJ0/pxPz5HW/pfi4yLS1XLZlhuviOg8ITM8WsTo+a5+eXhM+9sm2A5RU8qyEaFAtQjoKSCmNpndtrurZdkvjQAbe0EcWrV9RU0CIEGygD9ziGFF4zGutcAJsdJTZ0X7yCOz6OkDAGO7GmlgDFqtbSe8C6bY5KxOCawBKDD2yMH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:18.1280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f287a88f-0283-41a2-c171-08dee2779633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
Add KUnit tests for amdgpu_dm_apply_delay_after_dpcd_poweroff covering
the NULL-sink early return, the zero-wait skip path, and the non-zero
wait interval.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8195ca386419..9a3f78c17a5a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1919,6 +1919,7 @@ void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 			       ppatch->wait_after_dpcd_poweroff_ms / 1000);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
 
 /**
  * amdgpu_dm_dump_links_and_sinks - Debug dump of all DC links and their sinks
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index dfdef08343a4..c1a00e0e94a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1997,6 +1997,50 @@ static void dm_test_should_disable_stutter_revision_differs(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, dm_should_disable_stutter(pdev));
 }
 
+/* Tests for amdgpu_dm_apply_delay_after_dpcd_poweroff() */
+
+/**
+ * dm_test_apply_delay_null_sink - Test a NULL sink returns without delay
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_delay_null_sink(struct kunit *test)
+{
+	/* NULL sink: early return, no delay, no dereference */
+	amdgpu_dm_apply_delay_after_dpcd_poweroff(NULL, NULL);
+}
+
+/**
+ * dm_test_apply_delay_zero_wait - Test a zero wait interval skips the delay
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_delay_zero_wait(struct kunit *test)
+{
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	/* wait == 0: no msleep, adev is unused so NULL is safe */
+	sink->edid_caps.panel_patch.wait_after_dpcd_poweroff_ms = 0;
+	amdgpu_dm_apply_delay_after_dpcd_poweroff(NULL, sink);
+}
+
+/**
+ * dm_test_apply_delay_nonzero_wait - Test a non-zero wait interval executes delay path
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_delay_nonzero_wait(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	sink->edid_caps.panel_patch.wait_after_dpcd_poweroff_ms = 1;
+	amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, sink);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_is_idle),
@@ -2106,6 +2150,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_should_disable_stutter_match),
 	KUNIT_CASE(dm_test_should_disable_stutter_no_match),
 	KUNIT_CASE(dm_test_should_disable_stutter_revision_differs),
+	/* amdgpu_dm_apply_delay_after_dpcd_poweroff */
+	KUNIT_CASE(dm_test_apply_delay_null_sink),
+	KUNIT_CASE(dm_test_apply_delay_zero_wait),
+	KUNIT_CASE(dm_test_apply_delay_nonzero_wait),
 	{}
 };
 
-- 
2.43.0

