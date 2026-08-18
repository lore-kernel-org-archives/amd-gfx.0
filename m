Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC668C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424E810ECA5;
	Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+UbRZmx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DDD10EC9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE1TDc/pn0G1p9xfeb/TLf2PJH6GoXQj8nAe5xANV36ynKf5V7g88LwPtWIK9fwIRidP9uCngTwAfXv3HboFFmmAM3ASe2RsEgBkopkuIi/CB84K4tL1/jRK0DwAMlrTgQoOAgdMGC5UuDWwIKW48o318L/iRJeN6GuobvwyrI4Fd0YosgMnG43l7qMZ3DOSGqpZDHDt9eDn8tO343ylQfmZCRtIG8p9ANH2OJseOwnSTfHOI06mD/bW9jRUhVj2K7DrNDJGxG7qV7vspspnEiLozb85cJDH7jsBdpbE76uOBY9Z5I6wwiIoMp8iRankjw7FOfhy0D5NCFzPvYUihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FXGaxq+noapMpFvPBujV2S3Sjqe5kCNkyAkNVj/zzk=;
 b=ApGBXyU4214vM7ZNJ1NIKQ+ETSMfyqTWvQ5ZCC37ZJbBLMueoBr4KcdmbzaHkGO/lweYR9JSYIxqDSiCiSpjgAh81NWdsr5kQt/RZtpeFCUnAZxRt4IwNDfX21SmS+pfVQ0Oap2DJgWJy0qe5c0AXjtw076MO36Y9HqSNRwYqj6yMVPFdJMXYZHtF+sv03pBuxfOJ5Xst6vDM/+KnvxvYHpT22dE5N3nOoD/F4DlEAYaxAgG7htsP+mu6veq2byH76ip3FJQVXe24uQTsAjTXQCNDWqqdw6KmYTaBQFkrweho7rbM5sm4/TjxZtTHrY5ZBIXegNAst5ploM3O2vXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FXGaxq+noapMpFvPBujV2S3Sjqe5kCNkyAkNVj/zzk=;
 b=x+UbRZmxLsU2Br7mEVPwYEOgyhV+A27OLaerk+MnB+fR50LIcbaVZECRlpQDIHvCDgDP8Ue1NBHJ006v4nOJpzGWbWLaB6XPVLr0p6PvSR7Nu9sfISbI3KXBUbTzxNoNlEsmqszbSkjKabpJylUDVTXxbbBCbXxZs7O+YA8sBfc=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Tue, 18 Aug
 2026 20:22:30 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::26) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:01 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:01 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 11/82] drm/amd/display: Cover MST-start failure in detect_mst
Date: Tue, 18 Aug 2026 16:15:03 -0400
Message-ID: <20260818202139.4172592-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: e3295cbd-4cad-4b03-b235-08defd666c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: i3ZL9l7sm9Ksttyr5N5A+cqpGpNZSY7HzjrV6TZ/kf+kPTK2TfQ2tdyM3EiBN5zo2B57czoX9Y9/ymezg+E53k7QaiCziLt/Lti4hwStCUNbeutOMTVwgG3tlOhFXG3H6S9eyVycABIpn4tZoiuMTJkAbmmLAiTODM1JGAJO3R6ia9DZaC2SKKivGqupah86JeAE/7bamnWx45NpeiOHHMkKhqwaRX5K+jPGWLC4F9gf+k2hxPTBLCA9JdMFNlcfeK9pYEL4QSeLuHFJydxfEITmlAS/v6YNzlIWxcfIpzv3YTTBo8mQU9nW9YVsZ2qPkECGb5RX4+UDGs3VXx9nL/IhT37xn10GF/CwZttSrewfNoIr+CUGWfYQEDnr0BdaKy8boOUvXxGLxcjw6sr5xDGqQRcBez+ePotqmfcVM6ZbR1uiqabCGpOgl075ON+kO8HaXMLHE5okpu582Ivi0BIJ5xgrNuVyPqpx3UXcewmr3VAoD9229jY4iLqTQ4nru0pdsCf99JuZytBxSjf/WQRh9mup/ZazOixC+ZV7oREL9569TaFRDG7u/BgJGjhVNufuhPAKklcLbEdg2Qlc+L14+UnvBDlp6t8g5JILnV8Bnl7PD1dVZopY60SDR0HFqunMANW4R/JqJJWVlWVTqfY9TpV/AtNBglr9VMKc9DXIYfEX1FHKAhv3pYP/IEt2RJW0jMGS5SzU8dyjAJ3RUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: maY5VlxOkwO/LDD0P5NDto7PzmGFyj9zuB7+UEhTs53KFP+xzlSD1R7/xvVUkVLG3Q6/1ThET4pG8UDNboLKpZJllnKvGpYynkCjUTUlT7ol/I2WzZ71Q6EXg6qXNx8AzybrfBat8MxF3xVVz9sN0KL+CeFhWvkjnANI5yAIxIVniRIQ02W4JXy3gLNqFsGJeHIuWr1tbYVFYwHnm7BdfWd77Ms7gaxstOMuiTZmceBmhLmQa+gWFOJ2mTROScIeVtumrALVBY0N4lZBqiAFYZxgScuWy4ZIpJIDXpGxQU8C3c3y8917zrJtDphpuJKC/p45xB8YYwBWqxdFHlt87ZLIO/TDDYoIenpPO7mo95RQFe/gbhszyMAj4xFrgm409D1Yy+NNAuljL23CstgQBRX1ILBylC4PXFF+Caxxah4sne4yDdfg9e4jKyOQcmqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:27.9859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3295cbd-4cad-4b03-b235-08defd666c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
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

Add a KUnit test for amdgpu_dm_detect_mst_link_for_all_connectors() where
an MST branch fails to start its topology manager. A powered-down aux
forces drm_dp_mst_topology_mgr_set_mst() to fail on its initial DPCD read,
exercising the error path that downgrades the link and stops the manager.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index b51aba8c07c3c..14240e6485049 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2906,6 +2906,54 @@ static void dm_test_detect_mst_branch_without_aux(struct kunit *test)
 		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
 }
 
+/**
+ * dm_test_detect_mst_start_fail - Test the MST-start failure path
+ * @test: The KUnit test context
+ *
+ * An MST branch whose topology manager fails to start must downgrade the link
+ * to a single connection and attempt to stop the topology manager. The failure
+ * is forced by giving the manager a powered-down aux, so its initial DPCD read
+ * returns an error before any real transfer is attempted.
+ */
+static void dm_test_detect_mst_start_fail(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct drm_dp_aux *aux;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_DisplayPort);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+
+	link->type = dc_connection_mst_branch;
+	aconnector->dc_link = link;
+
+	/*
+	 * A powered-down aux makes the initial DPCD read return -EBUSY before
+	 * any transfer, so drm_dp_mst_topology_mgr_set_mst() fails fast.
+	 */
+	mutex_init(&aux->hw_mutex);
+	aux->name = "kunit-mst-aux";
+	aux->powered_down = true;
+	mutex_init(&aconnector->mst_mgr.lock);
+	aconnector->mst_mgr.dev = drm;
+	aconnector->mst_mgr.aux = aux;
+
+	/*
+	 * link->priv is left NULL so dm_helpers_dp_mst_stop_top_mgr() returns
+	 * early without recursing back into the topology manager.
+	 */
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
+
+	/* The failure path downgrades the link to a single connection. */
+	KUNIT_EXPECT_EQ(test, link->type, dc_connection_single);
+}
+
 /* Tests for amdgpu_dm_find_first_crtc_matching_connector() */
 
 /*
@@ -5835,6 +5883,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_detect_mst_skips_writeback),
 	KUNIT_CASE(dm_test_detect_mst_non_mst_link),
 	KUNIT_CASE(dm_test_detect_mst_branch_without_aux),
+	KUNIT_CASE(dm_test_detect_mst_start_fail),
 	/* amdgpu_dm_find_first_crtc_matching_connector */
 	KUNIT_CASE(dm_test_find_first_crtc_match),
 	KUNIT_CASE(dm_test_find_first_crtc_no_match),
-- 
2.43.0

