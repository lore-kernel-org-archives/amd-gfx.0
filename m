Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB2CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E8010F097;
	Wed, 24 Jun 2026 18:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BW0+g8AB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D1410F086
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfndD/g9iEGl/eJhUrY4Gd1rWjewmjhGcliaJmoYCllicD79fPcPhw6FhoEoXlnpJuzSQE2WM2j7OgU+/bezvgxxe0FkxN+z5AQMGuMWsYYk/W3WMnQb3LYxWymILKiMDm69y86LDxk7QO6lVGs/CE3Q0Jkpb+efN7wjRDpORqLxUJrHSfn8SK23sv5YfPjX7uQNSnHJTfKhwheCg1SSiSmELzrTYxMvZZu5rMoy+g9gAClIonKaMGRnDQPzSwkwD0L4SPFxOR1wwKDVXra5hIP5kAqQbDgEH2gGReFNjVOVeJitsmRJmlCXPhg2SvZjvTrff77+teb2+UJ5fwyKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3td4V/Zurz4cWBYUhnb/AYgMYgq0u6xptIIYknm+4o=;
 b=tU7WQ5M1Bu9JZmt6fXC5n9gesVWZ4W9FsXeD0/MO3PMGWjxFSWrrUeZhmF8/zay9ynoAXZncpntVfe76SjSQnB3ByGYn42LE5aOyUWVTo3V/r0qkuM9NI6WP8jj3G5KvdKOJFWDZkwaq7Wif+HEI1ESIhMlDkIhDOX2byDI7dt12JHd0Htl25l4mq5NzZKuIEHrCmJBLkpV4m0vOZa2G7HjO/qKDhp7z6qrRURuFv9QC8ufLHihctE+vw0qUj7lOx6nlgD3MpZsB+ylw/6MlToonKS+O+vvJsvZbM+bcqiPcF40d9EH7gwaqwh+bMtFhUCX6lU7fGkv173tpn+G7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3td4V/Zurz4cWBYUhnb/AYgMYgq0u6xptIIYknm+4o=;
 b=BW0+g8AB8V8nbJ3L337lR3edtwixdhB9I7u0w+2SaeFidd/AROQ9VlWrVk+y4ge9QaaiIa/tNHEBjda1nD3FM9MckzhZ4pCUJbhEwlsUJ8UmSSAWvpHBvkKM2G+ikaVVdMGjNhgtpSS037L1VBFaiKpiowU/GZi2ADCPeC0tZD8=
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 18:09:36 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::78) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:36 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:27 -0500
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
Subject: [PATCH 17/28] drm/amd/display: Add KUnit test for amdgpu_dm_wb
Date: Wed, 24 Jun 2026 14:03:15 -0400
Message-ID: <20260624180829.4775-18-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b8a896-69c7-42af-374b-08ded21bc04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Xpz11R4TkNYp8+4J364ucT+wgtRUr23KRJHtX2A4vAYPWaojA896fE+g7mwT8L1aBPOgcuN0n5Uj93XgSSOhe/QTa22uR6dMFHKJcq6+fKoJ8BEfV/ooCHncd/FDWcQyqGRPxT4OIsPsu152X3o4JcxseIK4kxa9XbutroDVjKm0kxoKiqWEhQUdibndQeuparhUNrndng50rrIZNljsWq91AJ1ucnIS64EERgIpG1kHZuu5A7QaYDLTnhKOpQshu3wt0+437gZd7Nl9HXoVijAwUaZFHS3cxpncKqtWHhdrBASYNhpTVEgjvOLapYOwclZ98YKRu9HTWjXUs7ogP1h2bLQT5Padqs4mneW4SWKgVzM0dUyf+PqBHzGi+1QA5f8cv/A8WDuhs3lHYaAGPAYHOeK1/xK39ZgU4kYRT/KWacdYfKxtQv13VzYXajfM5WCy77qaZgN+aFO3d8bnPTGGbUl5GZQB+ldXpuJs+snhUrsdE3lIkLO0KJa3CJYuBkv0bx2wRxsllTvMBoJaZ826QHJaUjS07HKFFD4t641wIRvrKeHy+4d67y7GNIlMSI4hQIZyjW9CjkbM6rX13qlG8jvAt8sra3ssPmJh4UK8mkMbIRVHoJO6dAUgzLwEDlMcUS+ixIU3q/H413ZqcqUhQlLk3/Et0DEyx5yZOwY9igceRBluNFzazBNJqerpuDqZ4fJKtgIfZoIRkGjt1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9n6Pq20e+AsQQJoS45gLS6J/tkJ4C5v53J7cMLFkZ0CcGxD8Ahz2rPXk73MIgAPyuD5m3l6eoaLRW5AQ9eypB4HhJzauS8vfq2pbehnLdKrOv/YjViJEbt/84lylSZnjv3Fd0yxZklSTBu4jsNolzDSgKab6g8zmmbkeKrwZpT8lue+7UdlkIAgq/ZgzxZxe0OeRsjFNKghA/QGoYLLVbtfHxv5f2CVMYSBAf3lzgfRu53cR2qirV1u9SkeR3uIzhQ48MJQGte8ST+YrEsbEaCW/wXltbtGsqtQui4E2CM+Jc9GvIF3cUot+RSlYxN24DjbU0Ow283+X4Z7EvFpwCSYuP7kR6W06AHHIkchhuN2UVodAKws3nE6JQMCKYWTl5ZpKKLhThuLcuLyqn/XdtoeFvIMUaAo/l1sy9//wGxDvd+S1mUgazZVINfNLxIA1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:36.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8a896-69c7-42af-374b-08ded21bc04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
Add KUnit test with DRM mock for amdgpu_dm_wb_connector_init().

Assisted-by: Copilot:GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 058d478a073d..0bf82e46f773 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -216,3 +216,4 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_init);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index b8ad4b87163a..f9a839c10bf4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -16,6 +16,9 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_writeback.h>
 
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_wb.h"
 
 
@@ -68,6 +71,23 @@ static struct drm_connector_state *alloc_test_conn_state(struct kunit *test,
 	return conn_state;
 }
 
+static struct amdgpu_device *alloc_test_adev(struct kunit *test)
+{
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(struct amdgpu_device),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	return drm_to_adev(drm);
+}
+
 /* Tests for amdgpu_dm_wb_encoder_atomic_check */
 
 /**
@@ -310,6 +330,54 @@ static void dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
 	}
 }
 
+/* Tests for amdgpu_dm_wb_connector_init using DRM mock */
+
+/**
+ * dm_test_wb_connector_init_success - Verify writeback connector initialization
+ * @test: KUnit test context
+ *
+ * Uses a DRM mock device embedded in struct amdgpu_device to verify that
+ * amdgpu_dm_wb_connector_init() initializes the writeback connector, stores
+ * the DC link, installs connector state through reset, and wires the expected
+ * DRM callbacks.
+ */
+static void dm_test_wb_connector_init_success(struct kunit *test)
+{
+	struct amdgpu_dm_wb_connector *wbcon;
+	struct amdgpu_display_manager *dm;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+	int ret;
+
+	adev = alloc_test_adev(test);
+	adev->mode_info.num_crtc = 1;
+	dm = &adev->dm;
+	dm->adev = adev;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	dc->links[0] = link;
+	dm->dc = dc;
+
+	wbcon = kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wbcon);
+
+	ret = amdgpu_dm_wb_connector_init(dm, wbcon, 0);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_PTR_EQ(test, wbcon->link, link);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.base.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.base.helper_private != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.base.state != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.encoder.funcs != NULL);
+	KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
+}
+
 static struct kunit_case dm_wb_test_cases[] = {
 	/* amdgpu_dm_wb_encoder_atomic_check */
 	KUNIT_CASE(dm_test_wb_atomic_check_no_job),
@@ -322,6 +390,8 @@ static struct kunit_case dm_wb_test_cases[] = {
 	/* amdgpu_dm_wb_connector_get_modes */
 	KUNIT_CASE(dm_test_wb_get_modes_returns_modes),
 	KUNIT_CASE(dm_test_wb_get_modes_bounded_by_max),
+	/* amdgpu_dm_wb_connector_init */
+	KUNIT_CASE(dm_test_wb_connector_init_success),
 	{}
 };
 
-- 
2.53.0

