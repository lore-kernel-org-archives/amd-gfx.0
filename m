Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB66C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1FF10F094;
	Wed, 15 Jul 2026 13:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H2eJv7Lb";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC2710F094
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqPC0jsMZhoKINU5rrctkJCLjZEhPdxhpw17Rjv95P1BglF3OUl0MtEdQChH74tm3C1upcnWW8ZZS2r3dUD7/ygd9u9N0Ga5U8MVFRoxM9/qiU67DVjka6L2tGxzhifz+3QShHjlFjW2PHQqnIeTZvMIGxi8CcKX8hPSSyLotBjbk4xk1Fhoyf9P8KF1Dln0VJUlGzQD/gP5WQ8OzIIqGXWZbSZYCffbbpGOEzC6fCvYormNUDRzH5Kiy/n1nqovvVLJBVGxBMVCGv3mx1KN9OIKAMNBxUdPtyLYGUFXwKzMgdSv+CKg0fID+hWG7wvcuhH2GFLmXNNI0ZaJb45aUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRvyXjqzLuBlRpam/hdQ9dg/svp0R6CFVv63tR2ARgw=;
 b=FvGONM1s3wjH06IRLf3NAYse6cePmIlRKNcWC0ifjGqDWAHikHokx+EO6W8MtnvS+qTUW20yUOKZ3DFO5WfOQQ/u6UhhnaMLZmDYfP6wLKlBKos8IHxJGf8T2jmtzVAr7U7FLz5rryA/P58vdxLH1Kht7fa+4CnXWBROQlTb1sv0+SEQHC0QFh2LzRiJf9OfJfhax2WOg4QMWB81m+Q4oNketOBJvicKMlR6knvhdb0rxawJRYO4zngday2HW79qpBd/U5nLHx3bbQaWUB9HtkKEBRAXeiqVztMPTjfoVY5vZgEIiAMF67DmGn4uIozYMU0Ulz+ESsAUBsW0fSFn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRvyXjqzLuBlRpam/hdQ9dg/svp0R6CFVv63tR2ARgw=;
 b=H2eJv7LbnE+3mM2B9973ihW3QQz7loNzi2zpwbMU86T0XN+n/33ZrIJrYC1E/qss0uRPhhUvpsd6UrATyUQthlpBqWEBl1j9CfsKQpXwo2tlsNnskzOB5M++cLOaozKIPTxY3Ectvv/7UYRWJFxHg404vh1iEzPj/Ktryr9wmww=
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Wed, 15 Jul
 2026 13:47:13 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::98) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:12 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 37/70] drm/amd/display: add KUnit tests for stutter quirk
Date: Wed, 15 Jul 2026 21:37:47 +0800
Message-ID: <20260715134432.1975118-38-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dff836-adc7-44b1-5867-08dee2779356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|22082099003|10067099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: YBDx72Vy77Wip2+UfVRvlpjAN5T0mbOsZ+VqEzBHnDD0YSXT/SLLIw1S2rb5HsEbAbYalvGWXAXk+oapZdAhyKtpMiWPJWhcj56lW1Vo4BBW/IlczsvBIGAng3Qpy3xJXnWkUTsbk5yuURpsvH2x2qv64cRQEYm9RdeihT7lQBAtyluO+w5oqjMoxrWpgdunpQJeCvzWBm1A3/civikx5G3o7PAkQecPumHyZKm43OIaNClXQwqRBWT2edr5mVzK0Rs2wA1uJ+CsanOrpzk01NcyxNQeldpsxoTWx/1Sljlqy+CjKZ6V3OwzYxAXizhYt+Ls2lP79cM12iz9Lbzlor+spppAoYZTaUfiLtz66N0B5Gy96/DqmiJihQd0p7w7fmdzaCY4TzB3Jl7vPRFq/Fub2P0se4FQWS0EGaJuOX8R3loWGPDdOEekzw5Xzz0xgLQna9skWEhoi8Uhm0j+ieaYvKp09hvuSyHGkOV3Y5GHUwOn3yOhDIkefRsXZYCHYJ1VS1Pw+pGTU2Md3WEbySqmgufRcxDZl8KoxoSFpCeknpt+FQUjgyekpe/BhNH8RX9wSwg0p/BhmwpCYnduL2s6l0yaz9WVY3y74Xq9HzZa9N9cbhLi8S9rDL2G2ypl6deLUM9SUYTudXCaRVzQKgpoDc4d5/H3ypR8mr/9Tqx16zaos9pOUBbc/46zDh1tyvhMGvJtiUCFINOaYP5amw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gx/HjIssPorBFPqj4wDOWb0N4jPUXuqk5hTkFZKmWJi5nFc6RceIZQEUvAERgvpQEjB498mv9Rr2ny7aKHoYij/SPQ4GO8iyWVBZd7S+0/+e5NP5B0LuMLvMGSgpDsB6G+7Er5f6Z+9t1weI0jQZcgM9603slUWGd7RK7nYk80V6WuqHRDAGZrhG38xC5kBbBp5ORWCyy+R66kwdvTeGilKBqhMhXvo+yS/MAgqA6BLrXHc+IzRE7EH1DO5CGpZocrXt8EBCU3WdBQ1HUjK2nYpo2EznKNmk5EmsVCMhahosJKzBsSPH9wgkkV4orrc1eXyfM6YpfDwx0BiouO8SxgaFOFlVNO5oTfphZcoC6f6BsVHhGJ9HgqqD0eu+pruCkU0EjopztAHQZnuaCUsxTvtgmy/7FTsexuLu5E9ysXBS8WWNbvpC6FI38ORZK5Z5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:13.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dff836-adc7-44b1-5867-08dee2779356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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
Add KUnit tests for dm_should_disable_stutter covering a full quirk
match, a non-matching device, and a partial match that differs only in
the PCI revision.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 64 +++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8fe7e125e14a..8195ca386419 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -424,7 +424,7 @@ static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
 	{ 0, 0, 0, 0, 0 },
 };
 
-static bool dm_should_disable_stutter(struct pci_dev *pdev)
+STATIC_IFN_KUNIT bool dm_should_disable_stutter(struct pci_dev *pdev)
 {
 	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
 
@@ -440,6 +440,7 @@ static bool dm_should_disable_stutter(struct pci_dev *pdev)
 	}
 	return false;
 }
+EXPORT_IF_KUNIT(dm_should_disable_stutter);
 
 
 void*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 897434504459..84c0bcfc093f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1178,6 +1178,8 @@ bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 				struct dm_crtc_state *new_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
 void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
+struct pci_dev;
+bool dm_should_disable_stutter(struct pci_dev *pdev);
 void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 void get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
 				  struct dm_connector_state *new_con_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index b988198418c6..dfdef08343a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1937,6 +1937,66 @@ static void dm_test_per_frame_master_sync_skips_null_stream(struct kunit *test)
 			    stream);
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
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_is_idle),
@@ -2042,6 +2102,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_per_frame_master_sync_single_stream),
 	KUNIT_CASE(dm_test_per_frame_master_sync_two_streams),
 	KUNIT_CASE(dm_test_per_frame_master_sync_skips_null_stream),
+	/* dm_should_disable_stutter */
+	KUNIT_CASE(dm_test_should_disable_stutter_match),
+	KUNIT_CASE(dm_test_should_disable_stutter_no_match),
+	KUNIT_CASE(dm_test_should_disable_stutter_revision_differs),
 	{}
 };
 
-- 
2.43.0

