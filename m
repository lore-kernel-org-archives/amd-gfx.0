Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E6AC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075C410F1D7;
	Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UIL93/or";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C6210F1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfYmvH+Oa3DV2qEU4rHnXgJ7DanKOFi+7hXTDBFgxg0a440/2QB0QRDcLp9XrAj0g1E7l6x6I0WS0bfg9PtBdl2n3BDR/Tm/Xj1Ic6faH4K56GE4JBVFjU/SjClG57hYPgfMMkM1w3G+viQIazwi5B/cc5YsimzDULJruSU1l4/cG48FPDT5czP0+4EZAPl+rxh22jax19p2/sprw9DEphnP0FSAEc4qvnKRQPZVTfEfj+LNfed6YVGQISU9hT70NeU49XvEvrwx8kq+JoXcTdj38Nb+WOSLjj18lGEFBnPmg7ZedgEhDB7o6KnFF06rviDVhLOF/PCBj/nOm+9qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rexbSd/75CPr0IPm6NK9isBDUDKGix+XYQ+tsDul+HU=;
 b=L5mQMtKlEM1IDAwgBrohh9QEqDXM/h+ROpEe6zbUvvfO2KlnjoZd6egNSx2m6iAjuAD/CFFpzsCgpv6U5wcD0FaAfrIDcTXEQcLjFrm2O3WkpsT+Rz0+BFTgEr322lHVVAc4P1w/ZETSmCGbxD+WRZJtguhnDI5HJRxLy/BfaGGpz2DlpQDS+tCU8XPgjWqpej3uKEVkmgmYUNCG/WOym0Ae4AY4dQom4nNjmEeorI5lmORoAyQnNtRjBJThIAvU1MZ9bSmy40MhLuOSVo1CeOzREuTfWGRHDT8bmHROf5nlhm/I6hZK8eST7xGu/RBIg+gRlVQV33loFrXTv+V8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rexbSd/75CPr0IPm6NK9isBDUDKGix+XYQ+tsDul+HU=;
 b=UIL93/or8tLTQZGkCmyqNiV99pOG+FQX/4S4afrdZwHYt0nMOaG4QXSJxzMsMgOfZIarsczXZRdXC2hiog1GSvos99YIVhgV1ZiwMQ2ukM9xRyYyHIDhtXFwfA+alhZ47DgJTIDh8MXXvLd2VpHc8lFzwGfSW+kzVPQzfvwpWT8=
Received: from MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::26)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:03 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::29) by MN0P223CA0014.outlook.office365.com
 (2603:10b6:208:52b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:01 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:57 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 13/49] drm/amd/display: move stutter quirk to quirks file
Date: Thu, 23 Jul 2026 16:13:21 -0400
Message-ID: <20260723201908.373300-14-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 119fe133-1680-4ed0-f1d2-08dee8f7a2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|10067099003|11063799006|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 19/b4A59tk6MxYYCtSaeZPR6WSqvvdmSKNGhfoEa9qyNY8Oqa+8sc0k7tpHLKeuLyg5S8H5qUhD2XpEIYv0IkMqK289Ep4EeEIU3IFLFeFd3B/zdWW+st4lFYzn3TNxEI49VKXHK7VXP3fgtQvkKfXCztlTcrHd4EKlf74Hze94hM0mt1XV3AGZAeAaIOjfGoUtsoMOkPIvdqGMkbpd2CPb2YUoJ0AygqgISDTk0qswogepaEvJNfx7D8eoeQvlegxa+vzaoOfAguyfEZwT2JuoAjvvm8X3375tZsCIX4vr41HDl9fbtt7n0rBgF+oWpDcA8jvssM8uZ9QwNc+aDsLiomwdNOzXfAm/ubdH/ZIQNWWcd0wLXs0N8tmOwnCyE5ech9r3OTfrEhR4I4g9PSrDU1DhSTx9tmCFZFETqWfUh2bocYV02hwM+MS/IvisgMBkkmBFY9C1TepkX/LuruTEq6t1lagW+cVaSjYzAB4G14ZtU4cV18rjHgP7fFg+h3jSJgcgga4FJM956S5l+GMMp/fpKuS2bqU441ByhK+9/Xsdv4rvo6ZhZmjoDiitigXmgb3GA6EsiMdiPE9QNnX9/ri7mYT+09z/8/MXmPWqKcOlvOExq9kTwT90HCBc9zcq0Si0/n5pyCMPFq2Hp++3jGFCUfjxJ7BdvSb5m9NWoJ1Wf6hsGPw33WD7Vg5IkYGAvqktURlGWR2vbb5fHnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIjdArcZ72f5tmL41fG7zMltGLkvB4Te7X4DcK0EOZwnXTksqBqZnxsiOem8nhPI2qauYaPuoNrTUXDraSbayvl98qxzcA1rhHS/w4mlEggpz8Vk8EGSz/KLbM2mtXuVYkOSm0/Sk6FRmSnhQQjD0yJChHf1InFiEXtgYmqy/sqOLjZ/68RcPX41qIdGWkgVZfnMNH4+P7XsSjVd7EBsEDJ6YoYWKI974l82ClNA6DGMOXHS5j6r7R6MM0TcEOSWmwXP7E4j3ZaNx0X+qOmnVdqQfPZbcaC14rPpttiGIO7qmM4wP/CRnqzwbXLosqOhmggWc01q1lcu7l24sq0ijFkQn4swCbo3owKkvR04KrBcP5kZqDFjiOSk6mW0g17IWToMLqItHUoC9rW36qHCV8ytWVg9E0XZ9Nko3c05oJ9zraH0Q6O0TVff0GJBEO47
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:01.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119fe133-1680-4ed0-f1d2-08dee8f7a2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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
dm_should_disable_stutter() and its amdgpu_stutter_quirk PCI match
table are self-contained quirk logic. Move them out of amdgpu_dm.c
into amdgpu_dm_quirks.c alongside the existing DMI quirk handling.

The helper is called from amdgpu_dm_init(), so it becomes a plain
exported function instead of STATIC_IFN_KUNIT, and its declaration
moves from the KUnit-only block to a regular prototype in amdgpu_dm.h.
Relocate its KUnit tests from the amdgpu_dm suite to the
amdgpu_dm_quirks suite. No functional change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  | 32 +++++++++
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   | 65 +++++++++++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 64 ------------------
 5 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e6452237ba70..c6b9cd1ce489 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -410,39 +410,6 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
-struct amdgpu_stutter_quirk {
-	u16 chip_vendor;
-	u16 chip_device;
-	u16 subsys_vendor;
-	u16 subsys_device;
-	u8 revision;
-};
-
-static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
-	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
-	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
-	{ 0, 0, 0, 0, 0 },
-};
-
-STATIC_IFN_KUNIT bool dm_should_disable_stutter(struct pci_dev *pdev)
-{
-	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
-
-	while (p && p->chip_device != 0) {
-		if (pdev->vendor == p->chip_vendor &&
-		    pdev->device == p->chip_device &&
-		    pdev->subsystem_vendor == p->subsys_vendor &&
-		    pdev->subsystem_device == p->subsys_device &&
-		    pdev->revision == p->revision) {
-			return true;
-		}
-		++p;
-	}
-	return false;
-}
-EXPORT_IF_KUNIT(dm_should_disable_stutter);
-
-
 void*
 dm_allocate_gpu_mem(
 		struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 03189f44efd4..617328497203 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1134,6 +1134,8 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc);
 
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
+struct pci_dev;
+bool dm_should_disable_stutter(struct pci_dev *pdev);
 
 void amdgpu_dm_emulated_link_detect(struct dc_link *link);
 void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
@@ -1178,8 +1180,6 @@ bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 				struct dm_crtc_state *new_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
 void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
-struct pci_dev;
-bool dm_should_disable_stutter(struct pci_dev *pdev);
 void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 void get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
 				  struct dm_connector_state *new_con_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
index 0a7602ed70b2..259966703cef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
@@ -178,3 +178,35 @@ void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 	}
 }
 EXPORT_IF_KUNIT(retrieve_dmi_info);
+
+struct amdgpu_stutter_quirk {
+	u16 chip_vendor;
+	u16 chip_device;
+	u16 subsys_vendor;
+	u16 subsys_device;
+	u8 revision;
+};
+
+static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	{ 0, 0, 0, 0, 0 },
+};
+
+bool dm_should_disable_stutter(struct pci_dev *pdev)
+{
+	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
+
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device &&
+		    pdev->revision == p->revision) {
+			return true;
+		}
+		++p;
+	}
+	return false;
+}
+EXPORT_IF_KUNIT(dm_should_disable_stutter);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
index a09f31ee0a2a..150c53a68bed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
@@ -6,6 +6,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/pci.h>
 
 #include "dc.h"
 #include "amdgpu_mode.h"
@@ -83,11 +84,75 @@ static void dm_test_quirks_no_dmi_match_both_false(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, dm->edp0_on_dp1_quirk);
 }
 
+/* Tests for dm_should_disable_stutter() */
+
+/**
+ * dm_test_should_disable_stutter_match - Test the quirk device matches
+ * @test: The KUnit test context
+ */
+static void dm_test_should_disable_stutter_match(struct kunit *test)
+{
+	struct pci_dev *pdev;
+
+	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	pdev->vendor = 0x1002;
+	pdev->device = 0x15dd;
+	pdev->subsystem_vendor = 0x1002;
+	pdev->subsystem_device = 0x15dd;
+	pdev->revision = 0xc8;
+
+	KUNIT_EXPECT_TRUE(test, dm_should_disable_stutter(pdev));
+}
+
+/**
+ * dm_test_should_disable_stutter_no_match - Test a non-quirk device does not match
+ * @test: The KUnit test context
+ */
+static void dm_test_should_disable_stutter_no_match(struct kunit *test)
+{
+	struct pci_dev *pdev;
+
+	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	pdev->vendor = 0x1002;
+	pdev->device = 0x1234;
+
+	KUNIT_EXPECT_FALSE(test, dm_should_disable_stutter(pdev));
+}
+
+/**
+ * dm_test_should_disable_stutter_revision_differs - Test a partial match (revision) fails
+ * @test: The KUnit test context
+ */
+static void dm_test_should_disable_stutter_revision_differs(struct kunit *test)
+{
+	struct pci_dev *pdev;
+
+	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	/* Everything matches the quirk except the revision */
+	pdev->vendor = 0x1002;
+	pdev->device = 0x15dd;
+	pdev->subsystem_vendor = 0x1002;
+	pdev->subsystem_device = 0x15dd;
+	pdev->revision = 0x00;
+
+	KUNIT_EXPECT_FALSE(test, dm_should_disable_stutter(pdev));
+}
+
 static struct kunit_case amdgpu_dm_quirks_tests[] = {
 	/* retrieve_dmi_info */
 	KUNIT_CASE(dm_test_quirks_aux_hpd_discon_reset),
 	KUNIT_CASE(dm_test_quirks_edp0_on_dp1_reset),
 	KUNIT_CASE(dm_test_quirks_no_dmi_match_both_false),
+	/* dm_should_disable_stutter */
+	KUNIT_CASE(dm_test_should_disable_stutter_match),
+	KUNIT_CASE(dm_test_should_disable_stutter_no_match),
+	KUNIT_CASE(dm_test_should_disable_stutter_revision_differs),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 88ac5e4f6c04..72d5a4012a3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1737,66 +1737,6 @@ static void dm_test_per_frame_master_sync_skips_null_stream(struct kunit *test)
 			    stream);
 }
 
-/* Tests for dm_should_disable_stutter() */
-
-/**
- * dm_test_should_disable_stutter_match - Test the quirk device matches
- * @test: The KUnit test context
- */
-static void dm_test_should_disable_stutter_match(struct kunit *test)
-{
-	struct pci_dev *pdev;
-
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, pdev);
-
-	pdev->vendor = 0x1002;
-	pdev->device = 0x15dd;
-	pdev->subsystem_vendor = 0x1002;
-	pdev->subsystem_device = 0x15dd;
-	pdev->revision = 0xc8;
-
-	KUNIT_EXPECT_TRUE(test, dm_should_disable_stutter(pdev));
-}
-
-/**
- * dm_test_should_disable_stutter_no_match - Test a non-quirk device does not match
- * @test: The KUnit test context
- */
-static void dm_test_should_disable_stutter_no_match(struct kunit *test)
-{
-	struct pci_dev *pdev;
-
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, pdev);
-
-	pdev->vendor = 0x1002;
-	pdev->device = 0x1234;
-
-	KUNIT_EXPECT_FALSE(test, dm_should_disable_stutter(pdev));
-}
-
-/**
- * dm_test_should_disable_stutter_revision_differs - Test a partial match (revision) fails
- * @test: The KUnit test context
- */
-static void dm_test_should_disable_stutter_revision_differs(struct kunit *test)
-{
-	struct pci_dev *pdev;
-
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, pdev);
-
-	/* Everything matches the quirk except the revision */
-	pdev->vendor = 0x1002;
-	pdev->device = 0x15dd;
-	pdev->subsystem_vendor = 0x1002;
-	pdev->subsystem_device = 0x15dd;
-	pdev->revision = 0x00;
-
-	KUNIT_EXPECT_FALSE(test, dm_should_disable_stutter(pdev));
-}
-
 /* Tests for amdgpu_dm_apply_delay_after_dpcd_poweroff() */
 
 /**
@@ -1938,10 +1878,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_per_frame_master_sync_single_stream),
 	KUNIT_CASE(dm_test_per_frame_master_sync_two_streams),
 	KUNIT_CASE(dm_test_per_frame_master_sync_skips_null_stream),
-	/* dm_should_disable_stutter */
-	KUNIT_CASE(dm_test_should_disable_stutter_match),
-	KUNIT_CASE(dm_test_should_disable_stutter_no_match),
-	KUNIT_CASE(dm_test_should_disable_stutter_revision_differs),
 	/* amdgpu_dm_apply_delay_after_dpcd_poweroff */
 	KUNIT_CASE(dm_test_apply_delay_null_sink),
 	KUNIT_CASE(dm_test_apply_delay_zero_wait),
-- 
2.53.0

