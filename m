Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D9CC531FC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6270510F1E5;
	Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A7HwMwmD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379910F1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcgETMNiEc9mevplfL9Ip+wTyP8KTYBJ/Zf3jtD8i6YurDWPsXinT1x0EqXC4uo+CezrbEl3+6orakVQ1Zxsy7G/cLUM4+kxk3XMVvxH4sJVmd6x1sVO8/jXP7UuhwjRRhpxcP2dPEqBYfReogM0t7J1kDS7QdDWLTJwRS3xawxvKWsVao/2RVXFDQwrcIOPSK+UfBqsEKoIdmsfWPCNXq13pCd3JeqNQpm3iHY1PwKosMEwnVvMBHa7g1iTbIXVWAI433YcdrFwy0UHJynNZkeAgtPoVx9I/fylA0M+5u4+gHV8fbMZxp1AWIVlBVDwS2MvGjyvpIZaNYACOeOTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1y98bPSvgtSQCm6gS1/PxbOpp1Ubw8sa+W6u+W3kPk=;
 b=M1mVg3bJ1oa+/IubF7SuunUUvAriFvFvAru/uuXMfdCljRJPccjc7EfyXn44WrgMxuYdsbyikyzpqmP/llWgZUeKNSHdqmVvXhUcTBQ8clffjCPy6qh54hcE9p1t4AxH2mN7b94ZF0SmdZiNXk5b5CFjoAHOCxOVy/GwnFx+6B6J9dWpEJHtwBzz29qolNzGGWIruqq/6NoAtIm7nXC8LRQ9MotL9zangJAhGkE/UOlh36tPztPxL6lJSNFjX9U3atVhPuZo8iRPcD3MO39QsadSDhFRIaNTkK4cPjepjH306eYo02mrz2nIEntFGoqhIeAWFdgC/eEdVex0MK+fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1y98bPSvgtSQCm6gS1/PxbOpp1Ubw8sa+W6u+W3kPk=;
 b=A7HwMwmDJ3o9z3zvWsJ4p+wKKT13/TEkv2sD2TahkyDjtipM+iV8mLKG4rE4Qpk6pgG3dh/ksH1mNIYWoNXcSom3+rWnRhDKAb54a+6vZQmtXAFM0AS3BrQLYtds8RJxgwrg1k54FVfCLp1ux5ZwURuKko+aw9m3bo19ik95eMA=
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::50) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:25 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:11 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 31/49] drm/amd/display: Add KUnit tests for
 hdcp_create_workqueue
Date: Thu, 23 Jul 2026 16:13:39 -0400
Message-ID: <20260723201908.373300-32-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4f6a2b-5d94-43fa-3e35-08dee8f7b106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NcuBMJ2HLNrQWnRYX88SiAPGNVOO3ky77a6FVOv22x0pzBRM5ASoQ7Mu5ZqkZYC4RPiIX+TWxWhGBfku2aBg87jjZWbU9keGWhE9BHqy9mUGVaEkQIO8Sf8yAywLoMr8D2tChbCYN1JivRRRTL5pGyMNjkDhE92RyzlmWi5ERIpzOF+4vACnPeFSMwAaN7CYRNpOsIIwTTWh1AIURTK+NuX2NuCTMjdQIyMMYTLzwN47jTECNwW4hXk3zz+C1NKwYMKm887LOnUt1m6N3IB7iEy+wip9pP+daIFLE4Y41XUfgqzoeuKf0D5GTduqauh83BWge1cvkbBRfCUa2XH9xIdwbEj/eh/ZG63stvnIUnknOlCM4nRfDeRFAXnDEb0gZYFP5gEwfzurBUCDF+XwY1Kw3arM7jgN30rypQqDVq3CbEdaFfRMF/cy5GkJJ4dd707KAeKI0VZ05Qxx9Qt7mUBe6Ej+VhF7oaRFyDlG8QqcZlzqdvMKl2wHwIe9uTaLaCidDeiX7sDn+lJBRK+A3c7pz92jV/tRKOvIMzWgKK8uun9UQsioJLpoKsTAuf0c7xJIvvOWMafV9F4ZzzjTyMaI4IgZ5ZLJiAh4xL5e+hSHijntKhnuR0iFApKu1DX3fXRFNSIFgwvqlTewCPtEHgJSeJKTfq/IBNceHOW/Ksf6LOyGglQhrQLVobnDHyWc3rzK9UR6jIo4mgOOpwSmUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mjncm5X9cC8kafQxzDO6zOc8e6e9Hqae87xL7ENeDBgmrXE4QbBR9UQl6misLokmu7sYUtzEJIVnFlyHLkaH1cB7fZ9hN4lCvzFqu+v2LDytPKCEx/pBx2cO8mCkuv3G0nCap/cv+3kyj/o0gh8qbU5iEjXETOEIijE2FuSfGw7ALUOv14clereQAyhw0u/9Vi4SssJfhO8K3GatEyAnMTwaw9c1c2mCWnYbt7D/anoo+1fL+8KTooPS75RcVcCdTKn3Rnu6vD1zRjsxI14HbHco7fzTlZrE2H2A80Spngr5sShPEEqn6q/p7EpRKAttOfznqRLK14EIe74/Wi+RX2kJmflBYNB9zlJmwi7QruYXk1bh5x55KNTIkGSH5HBndLiVDuCeJzLbMBGwpIq3ATPleDqfLEBllf0uFVuPbHK+MeXvbaCkOU/Anc+R20nJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:25.7284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f6a2b-5d94-43fa-3e35-08dee8f7b106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Cover the success path of hdcp_create_workqueue(): the workqueue and SRM
buffers are allocated, max_link is recorded, the cp_psp callbacks and
handle are published and every link's psp handle points at the device
psp. Also cover the dtm_v3_supported branch (set for DCN 3.1, clear
otherwise) and the init loop running for more than one link, alongside
the existing zero-link early-return case.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index b75fadd4e14e..d95babb73711 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1010,6 +1010,106 @@ static void dm_test_hdcp_create_workqueue_zero_max_links_returns_null(struct kun
 	KUNIT_EXPECT_PTR_EQ(test, work, NULL);
 }
 
+/**
+ * dm_test_hdcp_create_workqueue_initializes_work - success path wires everything up
+ * @test: KUnit test context
+ *
+ * With a single link, hdcp_create_workqueue() must allocate the workqueue and
+ * both SRM buffers, record max_link, publish the cp_psp callbacks and handle,
+ * and point every link's psp handle at the device psp. A non-matching
+ * dce_version must leave dtm_v3_supported clear. hdcp_destroy() is used to
+ * tear the workqueue down (it also removes the SRM sysfs file created on the
+ * device kobject).
+ */
+static void dm_test_hdcp_create_workqueue_initializes_work(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct cp_psp cp_psp = {0};
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct hdcp_workqueue *work;
+
+	/* sysfs_create_bin_file() needs a real device kobject. */
+	adev->dev = adev->ddev.dev;
+	dc->caps.max_links = 1;
+	/* DCE_VERSION_UNKNOWN (0) is not in the DTM v3 list. */
+	dc->ctx->dce_version = DCE_VERSION_UNKNOWN;
+
+	work = hdcp_create_workqueue(adev, &cp_psp, dc);
+
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	KUNIT_EXPECT_EQ(test, work->max_link, 1);
+	KUNIT_EXPECT_NOT_NULL(test, work->srm);
+	KUNIT_EXPECT_NOT_NULL(test, work->srm_temp);
+	KUNIT_EXPECT_PTR_EQ(test, (void *)cp_psp.funcs.update_stream_config,
+			    (void *)update_config);
+	KUNIT_EXPECT_PTR_EQ(test, (void *)cp_psp.funcs.enable_assr,
+			    (void *)enable_assr);
+	KUNIT_EXPECT_PTR_EQ(test, cp_psp.handle, work);
+	KUNIT_EXPECT_PTR_EQ(test, work[0].hdcp.config.psp.handle, &adev->psp);
+	KUNIT_EXPECT_EQ(test, work[0].hdcp.config.psp.caps.dtm_v3_supported, 0);
+
+	hdcp_destroy(&adev->dev->kobj, work);
+}
+
+/**
+ * dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn31 - DCN 3.1 enables DTM v3
+ * @test: KUnit test context
+ *
+ * On a DCN 3.1 device, hdcp_create_workqueue() must set the per-link
+ * dtm_v3_supported cap; an unmatched dce_version must leave it clear.
+ */
+static void dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn31(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct cp_psp cp_psp = {0};
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct hdcp_workqueue *work;
+
+	adev->dev = adev->ddev.dev;
+	dc->caps.max_links = 1;
+	dc->ctx->dce_version = DCN_VERSION_3_1;
+
+	work = hdcp_create_workqueue(adev, &cp_psp, dc);
+
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	KUNIT_EXPECT_EQ(test, work[0].hdcp.config.psp.caps.dtm_v3_supported, 1);
+
+	hdcp_destroy(&adev->dev->kobj, work);
+}
+
+/**
+ * dm_test_hdcp_create_workqueue_initializes_all_links - loop covers every link
+ * @test: KUnit test context
+ *
+ * With more than one link, hdcp_create_workqueue() must run its init loop for
+ * every entry: each link records max_link, points its psp handle at the device
+ * psp and gets the DTM v3 cap set for a matching dce_version.
+ */
+static void dm_test_hdcp_create_workqueue_initializes_all_links(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct cp_psp cp_psp = {0};
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct hdcp_workqueue *work;
+	int i;
+
+	adev->dev = adev->ddev.dev;
+	dc->caps.max_links = 3;
+	dc->ctx->dce_version = DCN_VERSION_3_1;
+
+	work = hdcp_create_workqueue(adev, &cp_psp, dc);
+
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	KUNIT_EXPECT_EQ(test, work->max_link, 3);
+	for (i = 0; i < 3; i++) {
+		KUNIT_EXPECT_PTR_EQ(test, work[i].hdcp.config.psp.handle,
+				    &adev->psp);
+		KUNIT_EXPECT_EQ(test, work[i].hdcp.config.psp.caps.dtm_v3_supported, 1);
+	}
+
+	hdcp_destroy(&adev->dev->kobj, work);
+}
+
 /* End of tests for hdcp_create_workqueue() */
 
 /* Tests for hdcp_destroy() */
@@ -1765,6 +1865,9 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate),
 	/* hdcp_create_workqueue() */
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_zero_max_links_returns_null),
+	KUNIT_CASE(dm_test_hdcp_create_workqueue_initializes_work),
+	KUNIT_CASE(dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn31),
+	KUNIT_CASE(dm_test_hdcp_create_workqueue_initializes_all_links),
 	/* hdcp_destroy() */
 	KUNIT_CASE(dm_test_hdcp_destroy_frees_and_removes_sysfs),
 	KUNIT_CASE(dm_test_hdcp_destroy_zero_links_null_srm),
-- 
2.53.0

