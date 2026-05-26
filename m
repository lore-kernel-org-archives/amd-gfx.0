Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A686ACD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F7110E4F9;
	Tue, 26 May 2026 07:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJ61rRHR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CDE10E4F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlunMWsgrFd9/grvZpGrEkUduK35ZjodtLdqtxZKUk4X5awdJzS3klcgxjSQANrXwR4uFSbfyaBPonQOASsLXRPvDKEtXk0rizYWdpFA0aS1pdolEiLC/XdQ15Bj2F3DafXHHd5Ei1mtfITIAu0jZ8H4Fjz8WAXrAD0+DLhalBORhaVTPN2v14TvtA9A4slTaz8wedtPn8jApy5a0fILCOGGJUWXTY9OEpBS122b0ITKzwu9f9Lg+RY1Z88ddcaD1vhEaqWohxNL06COnXLxT8nF/32cx7oVyUBe4+xXd4x20i7tIQtPgjPGViNFVKLSc+M9J6C2tEQ6+52vlMNNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IQh0IR5Y6Vu7LDHxaGKaBzM96rvSrqzhDIfek1WNq0=;
 b=FNN7zD28eYcwbWm02dq+6OAivE5MLXx0tXvdQp1sMrTJqB4IcU9p6qkuIspG1CQEySXcGzzvWXjhjGpaD8bub9g60d7zsmExRPCNAL6R+gBHlBJVIUrhAw3lZkv5tPg4M0MMHofRCiL8QRsYNhBRXt/nv04GR5aFIo6jNmtN6HZqqJIgqmXZtmzpE1yxa1t8JBdh6rKMQ5AJPDMqGGzgW8axfr5e+uRIy1ZQDlpJzDsokElTeltK1RDbxKy8OiSf18UvAyx/alF0Mnc7wCLmKQv/WZGHn0YhxrfAGaUfQltOsPrDWox1GDpmTNTjH5//zv74TEP1McyqIRQPJJ6w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IQh0IR5Y6Vu7LDHxaGKaBzM96rvSrqzhDIfek1WNq0=;
 b=jJ61rRHRyAXF57hPbZ6S6e9E9SdCaJu3L5fdGeSqtrtlRwXHkcWhemCrS5pnzL1rbisSGIoy5GP+kfsjY4YLGFaBSPrSzL/AtkOCt9I+BSlpExuDJ2uTMoS/TGuzskLs2Opt+6Bf5EZUpSVq4IO7vY1ksEdsTzMk3XyrsHowtyI=
Received: from PH8P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::29)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:17:52 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::8e) by PH8P223CA0004.outlook.office365.com
 (2603:10b6:510:2db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:17:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:17:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:17:50 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:17:42 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 24/41] drm/amd/display: Fix gamma 2.2 colorop TF direction in
 tests
Date: Tue, 26 May 2026 15:01:47 +0800
Message-ID: <20260526071413.2181251-25-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7da860-b8aa-44ae-379f-08debaf6e5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yJfJwKWrArbL2A4d7evZq2ZMnQQAT3zUPMo0vpcmSqPWTOd5iaVPdxWjZyczPuf5Wyvt2D7oh2gHCJKLVDVNvFtSLdmR8+roC5LZz7UI5Y/PmQpBrXFLx2ZnH5Xg8CfDfl+eP8NEpGhHEpGG3cd5LQWzbWuqIs5k6JzwoQklhy92S+lwOmhhqBUe+w3/4O/YbRaOvUbxliLz1R8iKCztqi/hiFvS99KsUiB34JA9UDBo1678EKZFScTnm5vjfBoFgRMcNxYSTEM4HyK2gfboLgm5HCUJlvm5yPhQLz0n36tsmNCjUGGJgHVIbkYKzirHJFUssYiVLXO95fPqei2cY+aKMed83kyVpx6ne91zT0jfingsmxTpe05yF/NKtyzcp/0hC8gikfzio+Ef3FCBmJVKNlzghtph/T7KZGZ4jIFA6rsf09yHagiTR8qPwZJ1G4BtTZk+k70j4u+QBf2J4ofk6wXsJ9CbLK1dXGoJqp7ahEtvmGwGspPH9oANs2x4o9PdQSrpxvjRnHbsvZV7yWJvcaOEtQWaJ83ITDguCpQqbKTuEW2G7BxUNE8D5JyTfETnBd264mKpahvUmoXGxnK0H8h33QH5NgY7kAzTkn8701WkbY0qiN70oJ3H8V8bXc6qs6BQq5T5n/9mcBVEBaqJXG8idFERr05Yb4jCd7WAt7RD5leb/QeBvoIS8Tp29qYw+X81gvF0RKzQNRwTTjF7+ki/9DTnKTUENNAZgBo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V5buKi2oWmf1nlGEU9DWV0i7AZNcUQqIatrm1r6/o/ykHGpEP/xtrj0xjt1+kc3cJNGi7IoClegXkYKnHQnScjNWSZnA+DmfZTwc9rnwXKxyRpCvbuTGIo4CKpR0EXY5hxOjzY5Z/BGPk5yVZiVKzWstm6/jGkT687d4k56Qt1yuXb2RF1W+gqjnO5IVHneGaEpEsn7QGytHskPjruNoZBtddxYeSS/aniM5p5Hgr16RvSn9DnefgzTaePUCfcTgkR6f+bCaZPftedpfmscZexpPO2i2KRoZ/ouCyQ1TyfRdYFQPE1KifYYUsJvuE4RTZVjc6voWxuX75K0O7dQa7YT4Xe8hjHBuQb+G20LQ72mMUIxof9DCd5lbToOMVdcsjyAvoUYL1r022r6iSEYJouB05lfvz0DlRAstKpkHsIu/9uqeXsXZUtE5HGX9kvOx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:17:51.2022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7da860-b8aa-44ae-379f-08debaf6e5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

[Why & How]
Correct the gamma 2.2 TF direction used in the supported-TF bitmask
tests. Degam and blnd use DRM_COLOROP_1D_CURVE_GAMMA22 (EOTF
direction); shaper uses DRM_COLOROP_1D_CURVE_GAMMA22_INV (inverse
EOTF direction).

This aligns the tests with commit b49814033cb5
("drm/amd/display: Fix gamma 2.2 colorop TFs").

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 6c77a7159188..4245ebd3725b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -30,10 +30,10 @@ static void dm_test_supported_degam_tfs_has_bt2020_inv_oetf(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF));
 }
 
-static void dm_test_supported_degam_tfs_has_gamma22_inv(struct kunit *test)
+static void dm_test_supported_degam_tfs_has_gamma22(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
-			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
 }
 
 static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
@@ -41,7 +41,7 @@ static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_degam_tfs, expected);
 }
@@ -66,10 +66,10 @@ static void dm_test_supported_shaper_tfs_has_bt2020_oetf(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF));
 }
 
-static void dm_test_supported_shaper_tfs_has_gamma22(struct kunit *test)
+static void dm_test_supported_shaper_tfs_has_gamma22_inv(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
-			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
 }
 
 static void dm_test_supported_shaper_tfs_no_extra_bits(struct kunit *test)
@@ -77,7 +77,7 @@ static void dm_test_supported_shaper_tfs_no_extra_bits(struct kunit *test)
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_shaper_tfs, expected);
 }
@@ -102,10 +102,10 @@ static void dm_test_supported_blnd_tfs_has_bt2020_inv_oetf(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF));
 }
 
-static void dm_test_supported_blnd_tfs_has_gamma22_inv(struct kunit *test)
+static void dm_test_supported_blnd_tfs_has_gamma22(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
-			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
 }
 
 static void dm_test_supported_blnd_tfs_no_extra_bits(struct kunit *test)
@@ -113,7 +113,7 @@ static void dm_test_supported_blnd_tfs_no_extra_bits(struct kunit *test)
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_blnd_tfs, expected);
 }
@@ -130,19 +130,19 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_srgb_eotf),
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_pq125_eotf),
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_bt2020_inv_oetf),
-	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma22_inv),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma22),
 	KUNIT_CASE(dm_test_supported_degam_tfs_no_extra_bits),
 	/* shaper TFs */
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_srgb_inv_eotf),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_pq125_inv_eotf),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_bt2020_oetf),
-	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma22),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma22_inv),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_no_extra_bits),
 	/* blnd TFs */
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_srgb_eotf),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_pq125_eotf),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_bt2020_inv_oetf),
-	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma22_inv),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma22),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_no_extra_bits),
 	/* cross-check */
 	KUNIT_CASE(dm_test_degam_and_blnd_tfs_match),
-- 
2.43.0

