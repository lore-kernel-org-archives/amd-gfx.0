Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B98606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o+ruHYuT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5B510F8F2;
	Wed, 11 Nov 2026 01:45:10 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C26710F8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYvBFH2xWTumQNEwBSw0RxufLjloufyc1Mqt2e3opNngxM5EzJUR4h7cfpO5Jy6LNCKrXOrqFs6oprWDKJTWtqU2kPHwD2vKX6CTMOBsCmJPVo3UDgQCB0YUJkzKFX6rbdrHCJtK7Yb3AqmFdexnm0gI6CMkiBF3A/7xuCFKHiR2pSxyhMnx+syDLS+lr0pNnGevlH+QV+GtEaPy9StzBOiboKuRiKnlpGbGfaz6XabadnVjL5HXqfQMM8fAM9mD2C3zVhmxBJ3AmidBdl7q22YWNl+tRFRYtmUKQpTLv2AOUJt9ETaX+tj+jG2plw12YDvrSVxw50f3tWjidv+Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dm7haw41rPOA91zGEju0qmTOdMEXjvhSBXYRkx9vJw=;
 b=r9CwG4bBsyfkdnk7cKAHkWdEooX4AiSxqqSnZ3hn0AUmeoL/jPU2hj6WJg3w2ocwzcg1G/UXyh8kyu+6i/lcodAUA2hlfSWy6X6hEN8WpCe/Af1p5ZCR1MnP3iOlz+jvh6KPYnEA/44Wchq6qJpgjOjQuyl2j1P02a3nku00eDp/SXh6BA8T7klmPheaFnWXDgf2i3p9XHbdVY1MEiRVLLWKA5/ko8URHkLhAw3hHeU84znWk40RPHhzjLk+EE6/kbz6MkJz9Ww2iYOhK75ZEvQiNS60AeW3q9WXapDMw1FQU4QgfwESNdENY7e9rAAeU+QCeYW9PlZ7rsI/iLo43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dm7haw41rPOA91zGEju0qmTOdMEXjvhSBXYRkx9vJw=;
 b=o+ruHYuTBmWQJkCa8cW2CJGRnCrKA6pE88f/TGOG0HfXvLs+yJqcq+HdiEzNrOe5tRLZlA9+zHAvmo80aNeW1a7RU9yl+Zwm3aIK99p2VDWv4+CwljepmTAzipcq3E+A7DpryCFEOnKixZQEjh/J2oPaTdodHZZtjIM8tUxB0TY=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by SA3PR12MB324744.namprd12.prod.outlook.com (2603:10b6:806:531::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:58 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::6) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:56 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:53 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 39/74] drm/amd/display: Enable HDCP on DCN6
Date: Wed, 11 Nov 2026 09:28:45 +0800
Message-ID: <20261111014100.3596072-40-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA3PR12MB324744:EE_
X-MS-Office365-Filtering-Correlation-Id: cef557ae-3938-4932-87d0-08df3f951cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|10067099003|261102123227099003|261021123027099003|261021121427099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zP0XYiDtwVipZVueNbzTrUOG8lR1CXaF3DkmEVZuCQEE1kwak7Lq1dwfvCYKlwxtUbKTbgb7dx9+kMbduZwTUxB+uSgvG9/2P3KcHTiInhu9lfHnwq7+XGRkJqHxaUmtl8FZHg+U31xzkPuFzLC+i0x7e6JnxLK6WBd5h9SzkbSDgCNsLsZDyQ4ktgo6OoLI7C8Aeqha8Zk4qYLJi9BxwJRutLVVuImH7hUIiia6qtiAC5DbzW5C1NpOEqJXXSKzYB7hPbtynrqeIUYhKwQ2/oxjc+yoAsCU6s1W2GgmOlEzSwALqKzNeT3YZd6VB3uQvYzWGblB+iO2pU9xlmAThA8Su4HJTOGM8LgqsfeTdk1/kgV5+9egIfTvNfKu5VGthkX2HcA7bTO659MrCjyaKBd18cdn4AtPYiKqWAoASBhnZ1G42JViVcsDVZ/vy3y/qrlTu8ncbr/LKbs2EFfC2kBapwZHV3gowbdRt9BHh5hQhdkmpfSjCaxLldgqEI4qMf+yBB9Yx6c/9elFSLTMM3/XGTWYmjX5lKypLlC/fFMyEjhE8SAP5it8QDZCK60XYSXf+ds4nyskLJZyLeZE4w7OyrSoRNfnGx7KmKKrhBi37yll3woSwvGSmaotPz30Tt3PjeliA/Y5LLXYaiqs7MDRjPrlajKZK22D9L2qsu4OGkb3LsfRqA3Wez30n3i7A72L22OY5GEKnZEhTserkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KMNq5zwUktueTn/q7+71FS2FaY6P831RseIqbXnrtWF7ZHWHocRTPcQbJ/lW1+yN+VNtjXDTI96iayopufX4DwcL/6L7dsx2qEgdTqognsn6tbha6n83PkmZL1VLcgm5vJTS6BvftwofsNYT6Htbf8HnRYHFtuZ0m804ScBXzThmEDuZs3Cwp5XKt3BrbGSaXQEDC2QUalgG1i/iMLLVmo1mwYA8dwo3P9T1DpojoeHCuY3JyprG7jeqNAGoIctVlZdCwTyZrsg8BTb/OD4WGtG+/Jl2OLSYo/T9IZaFd/dBJdBsNvzbVlY1LinLAfzlVkb1Q2UxEJYNDawkGUq4oTZ8MuPQsgv1xkfQt+3WPmltwQ2zB8JYwY/BjUpl3Y0fscr1bAQNhyDrtJXsqJdlmewLjUTLcwzFZHZCa7pVwJZXc0xp5/FCc/ZV2LFOb9PJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:57.7801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef557ae-3938-4932-87d0-08df3f951cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB324744
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Enable HDCP on DCN6 by
- Enabling dc_is_dmub_outbox_supported if fused_io (fw locality)
  is supported
- Plumbing DTM TA v3 support to it.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  3 ++-
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 47cbc826ed45..3cf96cc38575 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -883,7 +883,8 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		    dc->ctx->dce_version == DCN_VERSION_3_5  ||
 		    dc->ctx->dce_version == DCN_VERSION_3_51 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_6  ||
-		    dc->ctx->dce_version == DCN_VERSION_4_01)
+		    dc->ctx->dce_version == DCN_VERSION_4_01 ||
+		    dc->ctx->dce_version == DCN_VERSION_6_0)
 			config->psp.caps.dtm_v3_supported = 1;
 
 		config->ddc.handle = dc_get_link_at_index(dc, i);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 5af6ae47bb21..b0691a83d3da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1247,6 +1247,32 @@ static void dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn31(struct kunit *te
 	hdcp_destroy(&adev->dev->kobj, work);
 }
 
+/**
+ * dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn60 - DCN 6.0 enables DTM v3
+ * @test: KUnit test context
+ *
+ * On a DCN 6.0 device, hdcp_create_workqueue() must set the per-link
+ * dtm_v3_supported cap.
+ */
+static void dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn60(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct cp_psp cp_psp = {0};
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct hdcp_workqueue *work;
+
+	adev->dev = adev->ddev.dev;
+	dc->caps.max_links = 1;
+	dc->ctx->dce_version = DCN_VERSION_6_0;
+
+	work = hdcp_create_workqueue(adev, &cp_psp, dc);
+
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	KUNIT_EXPECT_EQ(test, work[0].hdcp.config.psp.caps.dtm_v3_supported, 1);
+
+	hdcp_destroy(&adev->dev->kobj, work);
+}
+
 /**
  * dm_test_hdcp_create_workqueue_initializes_all_links - loop covers every link
  * @test: KUnit test context
@@ -2564,6 +2590,7 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_zero_max_links_returns_null),
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_initializes_work),
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn31),
+	KUNIT_CASE(dm_test_hdcp_create_workqueue_sets_dtm_v3_for_dcn60),
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_initializes_all_links),
 	/* hdcp_destroy() */
 	KUNIT_CASE(dm_test_hdcp_destroy_frees_and_removes_sysfs),
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f2f219a928a..656a941b1ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6850,6 +6850,10 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 		break;
 	}
 
+	/* Fused IO replies (e.g. HDCP FW locality check) arrive via outbox notifications */
+	if (dc->caps.fused_io_supported)
+		return true;
+
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 
-- 
2.43.0

