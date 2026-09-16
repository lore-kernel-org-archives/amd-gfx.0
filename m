Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD7C982D4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7BD10ECCC;
	Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m15OyAYK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDC710ECCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKD4eWr3Y+CKP5R61ERZROVjuGhE4+h81ubrg7h9Op6eogGmka5jojZUCKidUdtRNxQcN14s4tpOShlfiA6Cy1WyFHrGSN2ZiELVUgl5wDheiW2l7gBRhSla46HZsuRSNSrDq/MaQcU9i2s+CQdGTAd/2ujf3b5g6wG/Sw17Ag/H4kRBWO9BAuX5fdHTn2cSwQbE+AmuK5tGERvgk9pxtj8O+TWwOpFXlo1JJupBlFdNVP9ct0zxxRg51PvZikjC9tw4izz/PgTVQeAZQPYexmZnxcfSutxsJCepGlH2XuxxZpYZ09RpdS9Ak4a34YFfunjWwGuFQ+536KreiLlF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO4YNGRJFjdfLeUIS1LIw2f6ZfDh2ilId2mDFrw/fNQ=;
 b=DCRCvTBuya5lP/ttknElt+G1/76jebr7ZZppLJvzMBG7QjthO/v5AC1y5i0BF3Mb5ULfAeBGrY1tvNGG8L49I1YutTDxtlKvbLYtpkvUSIgUQpBTXJWp0BSxTF2h2+pzl5dFDkwsptUkdQMp5lMwqWEHYsAzqJ37+xrL55OQws/szBCafwwNmlMt/HCjsmGCHhvJ/+ziaFfJ0Q7C5wmftUFMdc8NU8P5M65FpLyt7XHJeCc9NIU2rHQze4xd26LVBhXzGcbT03zpEuJ5KyJ5qgF6r+Rfjznk3tvSHKwu165/d+i6fGm5zXkLTBx9L3RGBlY2LMx6vseVzluWh7LNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO4YNGRJFjdfLeUIS1LIw2f6ZfDh2ilId2mDFrw/fNQ=;
 b=m15OyAYK+BJwSGP6yYlOQCQrDpl6lHnyCx0hJPnK1X1HnHmsHMeKm1TcmbpyY9A81T6I8J3Mx0gK4UKA+BOj3Q2OOF/8TQNe/s5kTzrAUqD5dXZXn+gs8dB7WNisqVvilKz7txINmuNGO4HX3qcCem+v3ZRroYtKUQhMVnWQ00k=
Received: from CH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::6)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 17:52:56 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a7) by CH5P220CA0011.outlook.office365.com
 (2603:10b6:610:1ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:54 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:41 -0500
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
Subject: [PATCH 36/64] drm/amd/display: Test HPD RX downstream handling
Date: Wed, 16 Sep 2026 13:51:51 -0400
Message-ID: <20260916175301.368306-37-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c95991-cfba-4f7d-9015-08df141b55dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tI+7P61Xdtwl5C7iHW31Bu6hrVp/gxwjaWCnRPrwHhNcZ7wrn4z4MOg4ekT8IFT3QKR2aSyFWh/1gD/FW9pBgmrUGIfxDd+Qcv7VE2ZAEd/MjSY/S/aBWW1GyB1/VnZUlaeuynIDgqCQc00P0aY+TYimnROc2FLY8D2OROxnKnwjh/oTP3bSPES8SGv3kI2yv9oVn9VzMceFOO9Yzx+3mhzgaayMR35R78wYDDVNggoQnPpm9vQPZ36sKw9dzsQhrnpzNjjTg43j8n5M83bo7VDXpymX9GFMxtFYJMfVsWzl5iw+Xfe1pVvR31Nui2VQW4G2CG5h64/KH59X+YcMB3qIOdFcbXxbuwrKAxkJ4i35SLZob5pB01mZsvN58b522I0dwzrihbC2u/xMskXd7ZSe6SOFEsvDhIeWJ5u2AC+RfsyqBBjSoJvvIuKSZTNvvsvRD7cmpV8RCffP6vybG1M187KqKrklV9ECkpwDz8aF7jLwpCMXoQ+bulpaasWM1bffZPP5u4tmCLZ73Q4Envs9Ztx4SKYar5UStUgc+lFnNPyF4uF6UlYu+Ll8JIkUQN/jc9sJD+sBHOxyCnGJxEbczJsfncylx8dUtzoQIIY58kyPaYuKUDKtZFEIiiYasz/0lHLmMSmK5C1uDtLeltaA0EiEx/bz80wfw4AD3D1eq+vh54DMNuWRC5cmTeFLUIBGJc4f4zHPk/V+L53pmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BILp5uotuGnW8NqLnf8u57UeHsysvRDs0NGhldS/R8l9lMfoKfn0ydzwoe1qFvH1mOcaPV1iwcdxVIMANWgEmXLX+pVIyLpuKT/uyfoAUbTsxdzcecif3/mcokIxyX3xOmLg/MRMbM9A+2bjdsdUAu4PZUii7QtuN2qh465Rx4r+7u0oGuuU6AgEaWdWtqnfd+yWwlv3ptncIPJtAVrmxU7h8ASnM1eL5b8gnEU6XRzZn6d+P8ZeKnLjjivENWN8jHI34nfTg5aP+7d5gZn6iclP8BzNmF9Sk0Jq1tsAXUVN2+WSoVY9tsl9pa84o64Dgy5dgTNgB+18OwRRNpYFlXum14bnr9TMfRUmwo5zflDmWBy5dRIiaox5694iawf3c7KWx74RauNQefG1BqrJ7EMDBfUNqsGOCXyYiGkGNme1u+Zdl9YsYBy3aeC1G8IB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:54.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c95991-cfba-4f7d-9015-08df141b55dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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
handle_hpd_rx_irq() left its whole post-detect block untested
apart from a failing re-detect, and never dispatched a CP_IRQ.

[HOW]
Add four tests covering a failing connection-type probe, a
connector forced on that is emulated instead of detected, a successful
re-detect that notifies userspace, and a CP_IRQ that must be handed to
the HDCP work queue for the connector that raised it.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 5f877c50b120..a4fd30613419 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -231,6 +231,19 @@ static bool dm_test_handle_hpd_rx_result_true(struct dc_link *link,
 	return true;
 }
 
+static bool dm_test_handle_hpd_rx_cp_irq(struct dc_link *link,
+					 union hpd_irq_data *hpd_irq_data,
+					 bool *link_loss,
+					 bool defer_handling,
+					 bool *has_left_work)
+{
+	*link_loss = false;
+	*has_left_work = false;
+	hpd_irq_data->bytes.device_service_irq.bits.CP_IRQ = 1;
+
+	return false;
+}
+
 static bool dm_test_allow_hpd_rx_irq_true(const struct dc_link *link)
 {
 	return true;
@@ -3594,6 +3607,123 @@ static void dm_test_handle_hpd_rx_irq_downstream_change(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
 }
 
+/**
+ * dm_test_handle_hpd_rx_irq_detect_type_fails - Test HPDRX detect failure logging
+ * @test: The KUnit test context
+ *
+ * A handled HPD RX IRQ on a connector that is not an MST root means a
+ * downstream port status change, so the handler must re-detect the link. The
+ * connection-type probe is stubbed to fail, so it logs an error and continues
+ * into the re-detect branch, and a non-MST-branch link also exercises the
+ * trailing CEC IRQ dispatch.
+ */
+static void dm_test_handle_hpd_rx_irq_detect_type_fails(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	dm_test_detect_link_count = 0;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_result_true;
+	link_srv->detect_connection_type = dm_test_detect_connection_fail;
+	link_srv->detect_link = dm_test_detect_link_false_count;
+
+	aconn->mst_mgr.mst_state = false;
+	aconn->dc_link->type = dc_connection_single;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_EQ(test, dm_test_detect_link_count, 1);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_forced_detect - Test HPDRX forced-connector branch
+ * @test: The KUnit test context
+ *
+ * A connector forced on but reporting no connection is emulated rather than
+ * detected, and userspace is always notified. An unset connector signal keeps
+ * amdgpu_dm_emulated_link_detect() to its unsupported-signal early return, and
+ * a sink-less link keeps amdgpu_dm_update_connector_after_detect() to its
+ * unchanged-sink early return.
+ */
+static void dm_test_handle_hpd_rx_irq_forced_detect(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	dm_test_detect_link_count = 0;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	dm_test_register_drm_dev(test, drm_to_adev(aconn->base.dev));
+
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_result_true;
+	link_srv->detect_connection_type = dm_test_detect_connection_none;
+	link_srv->detect_link = dm_test_detect_link_false_count;
+
+	aconn->mst_mgr.mst_state = false;
+	aconn->base.force = DRM_FORCE_ON;
+	aconn->dc_link->ctx->driver_context = drm_to_adev(aconn->base.dev);
+	aconn->fake_enable = true;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
+	KUNIT_EXPECT_EQ(test, dm_test_detect_link_count, 0);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_detect_true - Test HPDRX connected detect branch
+ * @test: The KUnit test context
+ *
+ * A downstream-port change that re-detects a display refreshes the connector
+ * and notifies userspace. A sink-less link keeps
+ * amdgpu_dm_update_connector_after_detect() to its unchanged-sink early return.
+ */
+static void dm_test_handle_hpd_rx_irq_detect_true(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	dm_test_register_drm_dev(test, drm_to_adev(aconn->base.dev));
+
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_result_true;
+	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	link_srv->detect_link = dm_test_detect_link_true;
+
+	aconn->mst_mgr.mst_state = false;
+	aconn->fake_enable = true;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_cp_irq - Test HPDRX content-protection dispatch
+ * @test: The KUnit test context
+ *
+ * A CP_IRQ in the device service field must be handed to the HDCP work queue
+ * for the connector that raised it.
+ */
+static void dm_test_handle_hpd_rx_irq_cp_irq(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct hdcp_workqueue *hdcp_work;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_cp_irq;
+
+	hdcp_work = dm_test_alloc_hdcp_workqueue(test);
+	drm_to_adev(aconn->base.dev)->dm.hdcp_workqueue = hdcp_work;
+
+	handle_hpd_rx_irq(aconn);
+
+	dm_test_flush_hdcp_workqueue(hdcp_work);
+}
+
 /* Tests for dmub_hpd_callback()/dmub_hpd_sense_callback() */
 
 /**
@@ -5545,6 +5675,10 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_msg_rdy),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_link_loss),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_downstream_change),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_detect_type_fails),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_forced_detect),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_detect_true),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_cp_irq),
 	KUNIT_CASE(dm_test_schedule_hpd_rx_offload_work),
 	/* dmub_hpd_callback/dmub_hpd_sense_callback */
 	KUNIT_CASE(dm_test_dmub_hpd_callback_null_inputs),
-- 
2.55.0

