Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3EDC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA65010EC98;
	Tue, 18 Aug 2026 20:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d8ZY5+h2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D044510EC98
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQglCOw5zOBvgKFYo4x9KrODSA0UPLOAyjifFWEsXhvNtxwh3HbMpINEJcX37rfQl28RM86B7SuPU0YO9Vy6PyngUZKo35d633M1RjA3cSerey1rzpQngidMUYyWNOcBuX7oxs6vbpP3s54zGZqU52JXVaQZGBBQEb/3Q2zg7J+6U+fJnoAY7/2pRgZFersmLJrIYOEzJNqiMkDoZi3rKC65RF+1ui+XvHpGVGcku4rZflwpJUS0qz170109PhX67ogWFBfNpTerp7n3mgaossd/2LlYBzGwIFwtvtmpVUflCviTKQTlHYR7acUU3rQExXjtpfmMlh/jRUTDRFmGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1kmISqdPpt/LRZQI3MdjZsWz5tSlhNo3wloJmkrlhs=;
 b=TG1i9yokDGhsd1MFe2RHF6Gt9QyKE3w3vuS+zQIHCxo5gRW9a+sIVXE6zHFmayaxQn+oKydhpwHHkX92ODgUoe4GRmRtWq5J37MALQ5KjYQ3cPx8IScUaWCmfTbg6DL+1UG3VcWeEXmfK/0Hwciln61XI6SoVeIgUqouHzXSTPj+9noTWPKXi7lYpXin6d9jFbUsK4uCRISUjsSx+KtYRFNSuduf2FVxLLZDUgDpG8wxcK8EXYuykuf9va0bHDLND0SpkGeijwBgvskyK5Im7FFZ6KevsdQskoDeIRUIhukCsZzQ8DLG7wG8/6NpS0f+18Q/W0PUuSvH8BlsqvnUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1kmISqdPpt/LRZQI3MdjZsWz5tSlhNo3wloJmkrlhs=;
 b=d8ZY5+h2o9FXHz+QZjo99OaSlZwUGtyBXgCJbcfbHXHnVeD+qufOk57HMX16KIuOYE8LFaJEHYNdi4tVu34W9IMulbvupyyuNw+dQk6Jcd/umZJTNBgDKAU+J/mO+wx4Mt9X802ZKSt/MlA38m+hC9XqFOCLAFV8J8OWNP1ALR8=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:21 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::8b) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:07 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:06 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 19/82] drm/amd/display: Test MST stream feature read failure
Date: Tue, 18 Aug 2026 16:15:11 -0400
Message-ID: <20260818202139.4172592-20-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: 503e379c-1467-4a7a-3f44-08defd666856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HZXxpaAZRmohFMbhgvppKrRHyKsSTgJUWE7WR7QOwohaGaNvqSrM244oD1k3dJeF+3dNYIpwtvpnpsepfiHRWhSgDyrivY2UeHgc/skIdIEjlSmAd/q9hjTKztzaRwbdZ3ed0VdBtkb8KL+7vSxQMPtTAamUMrEVbPUq9R7fv3DS5YfINGE8T7JQgZlvCpQorgzmM8OzVTffe5m8h9UInEMAw45qhzHhw5Z/GaFPz66B50x2FdnP1bg9xynS9bjgXs4vBadFcn6cURc2c8QXouBirYEPzRlUM9/1HtAxbciwB43PvaU3A2XfcwFg7hAydm68aQfOap3Y5rVZwCrMXpbnGtwsT6PGur7LpDEGhtdE/ZG1OC0uFMfnsrMAKAf39n69G8F+qgnJAzQyzvbzoDVTKDdJeiIRQAWxBNoMPj6uVuREUrxBdOLdWgMlbg7N10AamKW8RGr2V/xhbVxYtdmTntiS6HAeqDoWBZ80JQ2/ifcpeSiczh/A5KUpvOBz95fYQQG45v/DUX62JhiVELajoGYYXpaBG2an/EuTQ2C4ULDJ79/zZX0ZDdpdIJy2vpugrzpme6GXyD6Fz2XxGNv4JUCwx2ZaICYpU4qHdzIOXKtDCYcyeZ6xzFGsG3Q3Mn0Gj1VdQjfwAU3FtBDDda2FVvxiXuxswROOB/UbuszRh9D/D9Jpy8XNhD/nToUluMs10pllqjgTrClVxfUb0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XOCeA8u557y9FiX2QkP3VyAY/aGmdtGj7FoqlnUolHdXHaAHnlVJEkeNJYmmGkCe5upyVUblUibZECMSCydiATWJiXw41f9kGlQCU6HOH6fz0m84Nl8Pw+Sx11x/h+Wi8vemr5CaLYFSxlHSVfewNDHxj/+tKJg8t3PfVLkiAVaXoXLF3C9FLXLkGhKHM37l9IYVqRMcIvJIzJnrp13XSHerd3uw3Mlcrrba4moY6TzBjncmTEJRu6je8/sMP4C8XWFdWxbHhPlN6GNz373u2+ANhyhj+PyAwBkYR/l2yMgXg2e3njyu0ffPOhFg8L4ebr9IwHoFbaCVtMYDmR0KBkcdQM+ImZlPkQECqwKubj/x0rk/klaWqrGRVwhd9QdUA46oB97b09jWho5P43CiIriHZ8VdPCxMFwqCxZyaN/uG2s6KT55oLDEcNK+S6QPd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:21.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e379c-1467-4a7a-3f44-08defd666856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280
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
Add a KUnit test for dm_helpers_mst_enable_stream_features() that fails
the DP_DOWNSPREAD_CTRL read.

The helper must bail out without writing the register back, which covers
the early return on a failed DPCD read.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index bc8b607b6c83b..6b4f6993ace94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2661,6 +2661,38 @@ static void dm_test_mst_enable_stream_features_writes_downspread(struct kunit *t
 	KUNIT_EXPECT_EQ(test, fixture->dpcd_write_value, (u8)BIT(7));
 }
 
+/**
+ * dm_test_mst_enable_stream_features_read_fail - Test early return on DPCD read failure
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_enable_stream_features_read_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	fixture = dm_test_alloc_synaptics_aux_with_dev(test, &adev->ddev);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	link = dm_kunit_alloc_link(test);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	fixture->fail_address = DP_DOWNSPREAD_CTRL;
+	dm_test_current_aux_recorder = fixture;
+	aconnector->dm_dp_aux.aux.drm_dev = &adev->ddev;
+	aconnector->dm_dp_aux.aux.transfer = dm_test_current_aux_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+	link->priv = aconnector;
+	stream->link = link;
+
+	dm_helpers_mst_enable_stream_features(stream);
+
+	KUNIT_EXPECT_EQ(test, fixture->downspread_writes, 0U);
+}
+
 /* Tests for dm_helpers_enable_periodic_detection() */
 
 struct dm_test_idle_work {
@@ -4013,6 +4045,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* dm_helpers_mst_enable_stream_features */
 	KUNIT_CASE(dm_test_mst_enable_stream_features_aux_disabled),
 	KUNIT_CASE(dm_test_mst_enable_stream_features_writes_downspread),
+	KUNIT_CASE(dm_test_mst_enable_stream_features_read_fail),
 	/* dm_helpers_enable_periodic_detection */
 	KUNIT_CASE(dm_test_enable_periodic_detection_no_workqueue),
 	KUNIT_CASE(dm_test_enable_periodic_detection_updates_enable),
-- 
2.43.0

