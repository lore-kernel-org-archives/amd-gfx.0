Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE437C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C600C10ECB2;
	Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnSCftkO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6637B10EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq7hVgINOAkGwjvXnEWf6SzoryaJejD6LFKdiuaU7yldUvEUYku1/L2dime17aXnVBjoD6wf+EwD93v3ErwsWiahcugqDXgKfBkWN6eaHiQvE9MgngBupynOtx+FQK4nSR1QTXq2LWTK6SdDHcomv2nFudsW2qPna0mC2lvDeUKIdheZbX8EX5DdHkqWmMjMXnQeZ+Aw6UenMFEMMwd9t39gDWGl7HOFsSJWqhI/PigOfmowPykQlLQ53EG1vUVnHU4LAJ8wjNOcqi5S1L3ChjSP1m2/JD4L08eapCG6NFb3JStz9r1qTZb+OvlTJOkMqEAzlPyyHfw3YKzQU3d9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip5zUlVe1jwsF9yiuLOUQ/I8Cd6LKYBzQvFCz7BODWU=;
 b=OVbtF/tyZ3GElBnaJvJCNaBzIlyJyayI9bBIBvC+6XWcHS0JpEs+pZ8Ei84wAvodAYPY0eJYXcT1DQCUhkih8gTYU1wA6Xh9NmbN1iGfjrx9tZXjS2THxNXuXEJWjyfQ0kCbC+hUH3Zk1YmoSH17NpVfDl/hzAqTG3YiHJtynFig9rSw2tfBmsscp4QYwrI8o29YIlcodIF4iRrLktzcrpDbRq1h4d4cE8Kw8VvRd0Uj0DsUzOxpDoKM8Mi+21Mqa5ubgNkAS0xneX96+oqt5vGuV1BJp09xd9KVp5sjjIAq/KC8EGB07wjOB8RpyKTViz2vsZi63AB+jdQdIvbUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip5zUlVe1jwsF9yiuLOUQ/I8Cd6LKYBzQvFCz7BODWU=;
 b=mnSCftkOC9x08HajgWLXuk9TZsT6mC/gEdITsTguiYscBpJcjM5HtIXjZPwg/RshxmtJiRPSIagfxQupkpvEaAn6dZ1SE1NulgiN52dFIurKN8OpXkTmFmAaOsCESYU87g3DIFQnfTrzMmqBMrAH7mV9rJJMfRY8TQpTQdzym74=
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:54 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::75) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:53 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:39 -0500
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
Subject: [PATCH 34/64] drm/amd/display: Test HDMI HPD debounce re-detect
Date: Wed, 16 Sep 2026 13:51:49 -0400
Message-ID: <20260916175301.368306-35-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CHXPR12MB999243:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d283952-0950-4307-93c7-08df141b5576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ip0Wy29/L8FChqmiBdCYQK2mjXvlAqGLUTlcflj2R2QxCk9UdQ3W3IRNJx/pShCqGC7QvNTad18U5ZJxPRdvx86L3hUUhjaNQdlJMiXmwtJ6oGcn8gaW65I3UzPZEH2qolzUV6UVc6E2gY54NLdICj/HAxQVJpl9P9Dqed7n98CDYh85p1VTmbv6RhkGYENeygDbW6QvNgxPkmfFIwpR3GP7YXYXxrWRRLyMkdPLu9C0gH8yxLjgPu6i6nN+psryTlja5euNW+96fnfNk8sL/4yE1Uy2C6Vn3ZJJcR7wXlU6Ii7ykCtp/FILo4oaDp6NXMTeWGJoYIst7LOW2Wtm6v7DfhKzNCwuWVL5PXcqdsAKGsTnIESsdLqpgs8ucHppJQYkanqiNy9DrlARYj+Hc/eCEFeg3h810FXIt+mIP1wpBc5t7p/tODqfhXy4rWgZJO07LoISucNPuTHxs2BOvK4rIGg/XEQi5B3KtZq0alG5vn1aRKwLbF8WdjFCW9698cv8sMTZt1mUPg8fnnMMTmFeTY893BeRLJEaSwmCp4EWRqtSrnJipwGdeGfSIMICUng/OSet9ACw0jZEbmQl0B8BoaXpwq1Dku4lRgPCzuYBkgE4AH6I+6uVwqO4QHMmo2CNwibFolh/H8ZyWmBG3+MtJVYLaBWzj8qPNj598yg2RKsfCr/fa/Itu41EAI4Zgf7yfRwI9bYY3+g/c5rf+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5fi/7cmLhyKU/bJXCYrimEjaIjr0hhKD1/OS/1q0eeARrHun7vWelwE8G2YWIAi6YUzNEbUMbTJiOwS69Zmnv0vLpyYPlC89zwMiNNTVYJSCtQNbddr8Y96zfheK0/OfpnzB4l9+kEwkUPpRlKontvWbZ0F1tg+QZweSMagT1uDLA5B40SyTsoQ9e6wL9wFEfzaSyLYIEbMAILe12CdmtzEw+v3pSunuoSNyQbIdGN2jDaYfZAXO5rkJeWSIwzGNwh008SR5UlE/IWOmkrt/1g1mBlVsgbbzLFfvjnrT6Si47T++ihjOUk5cc4YEMAhuEhzTADLl3dUCxna/+fFSSPKohkUYHG6rQzuNI3StSxWoXAYNz3hdcoMjrbcb2KK+Y27fo+jS+qp6UYDVYkljttp0vq3J3v7pPZUmI2a3vV8+2h8VzmBw3nM5QOXLyMJp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:53.9851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d283952-0950-4307-93c7-08df141b5576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243
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
amdgpu_dm_hdmi_hpd_debounce_work() only ran with detection
failing, so neither outcome of the sink comparison that decides whether
an HPD toggle was spurious was covered.

[HOW]
Add a fixture for the debounce work item and two tests: a
re-detect finding the same sink, which re-enables internally without
notifying userspace, and one finding a different sink, which sends the
hotplug event.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 352ec7773e32..04cc5dd5812b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -61,6 +61,12 @@ static bool dm_test_detect_link_false(struct dc_link *link,
 	return false;
 }
 
+static bool dm_test_detect_link_true(struct dc_link *link,
+				     enum dc_detect_reason reason)
+{
+	return true;
+}
+
 /* Spy on dc_link_detect() to prove the debounce early-return skipped it. */
 static int dm_test_detect_link_count;
 
@@ -2764,6 +2770,51 @@ static void dm_test_hpd_rx_offload_work_link_loss(struct kunit *test)
 
 /* Tests for amdgpu_dm_hdmi_hpd_debounce_work() */
 
+/*
+ * Build an aconnector wired for amdgpu_dm_hdmi_hpd_debounce_work(): an HPD
+ * lock, the debounce work item and a dc/link pair whose re-detect fails.
+ * Caller sets the link_srv stubs and any sinks the branch under test needs.
+ */
+static struct amdgpu_dm_connector *dm_test_setup_hdmi_debounce(struct kunit *test,
+							       struct link_service **link_srv_out)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link_srv->detect_link = dm_test_detect_link_false;
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+
+	*link_srv_out = link_srv;
+
+	return aconn;
+}
+
 /**
  * dm_test_hdmi_hpd_debounce_detect_false - Test debounce false detect path
  * @test: The KUnit test context
@@ -2874,6 +2925,67 @@ static void dm_test_hdmi_hpd_debounce_reallow_idle(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
 }
 
+/**
+ * dm_test_hdmi_hpd_debounce_sink_unchanged - Test the spontaneous-toggle path
+ * @test: The KUnit test context
+ *
+ * A re-detect that finds the same sink as before the HPD toggle is an internal
+ * re-enable, so the connector state is refreshed but no hotplug event is sent
+ * to userspace. An MST-state connector keeps
+ * amdgpu_dm_update_connector_after_detect() to its early return.
+ */
+static void dm_test_hdmi_hpd_debounce_sink_unchanged(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct dc_link *link;
+
+	aconn = dm_test_setup_hdmi_debounce(test, &link_srv);
+	link_srv->detect_link = dm_test_detect_link_true;
+	aconn->mst_mgr.mst_state = true;
+	link = aconn->dc_link;
+
+	/* Two identically zeroed sinks compare equal, i.e. a spurious toggle. */
+	link->local_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link->local_sink);
+	aconn->hdmi_prev_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
+
+	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
+
+	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
+
+	dm_test_sink_release(link->local_sink);
+}
+
+/**
+ * dm_test_hdmi_hpd_debounce_sink_changed - Test the real-hotplug path
+ * @test: The KUnit test context
+ *
+ * A re-detect that finds a different sink than the one cached before the HPD
+ * toggle is a real hotplug, so userspace must be notified. Sending the uevent
+ * needs a registered DRM device.
+ */
+static void dm_test_hdmi_hpd_debounce_sink_changed(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hdmi_debounce(test, &link_srv);
+	dm_test_register_drm_dev(test, drm_to_adev(aconn->base.dev));
+
+	link_srv->detect_link = dm_test_detect_link_true;
+	aconn->mst_mgr.mst_state = true;
+
+	/* The link lost its sink, so it cannot match the cached one. */
+	aconn->hdmi_prev_sink = dm_test_sink_create(aconn->dc_link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
+
+	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
+
+	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
+}
+
 /* Tests for handle_hpd_irq()/handle_hpd_irq_helper() */
 
 /**
@@ -5298,6 +5410,8 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hdmi_hpd_debounce_work */
 	KUNIT_CASE(dm_test_hdmi_hpd_debounce_detect_false),
 	KUNIT_CASE(dm_test_hdmi_hpd_debounce_reallow_idle),
+	KUNIT_CASE(dm_test_hdmi_hpd_debounce_sink_unchanged),
+	KUNIT_CASE(dm_test_hdmi_hpd_debounce_sink_changed),
 	/* handle_hpd_irq/handle_hpd_irq_helper */
 	KUNIT_CASE(dm_test_handle_hpd_irq_disabled),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_schedule),
-- 
2.55.0

