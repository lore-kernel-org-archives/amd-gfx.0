Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036E3C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876E910F1E4;
	Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OphOSoI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF6110F1DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqAsdWFksqHKC3KrF2iZusXRsdaGatCtTRyo6RGdYe/l/U3iOBAuK/OiL304WkEh4s3CY4Bqkh15hEUDw3eYPbq17Qq/8WkLjKjsXO16G+609xjg6JGvdh5/IHxoFbWRAhHl+0q4aRT7AeAh0POKIdMftoKaGsWbEcTaUdaqhcRFr21Y4zaE2q3oTPluVTa9g360C4YzFEjJ0zm9qceeAFPwow5uZ/rXp5jq5rdJ4EtNhVAJ0o6z3kIO/SgR8DUl8S8CbMOXRgj/rpF240BsOJ6qJmfaskdCr1GHHDMFg9Fjxdqp3fdXmCalFpRvR1ZOQObRTOPkEwmbwOL2KGAYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f63/f0Oz8MZlERIBhMdkqMt5iP5oIzwxWEVsA1XVWFg=;
 b=MycQVfoOFlNITY3TGF4UKuWw0e9bZDrmAt4+dtsuhImhEkWeSDXfJEyDBooYOWDtmShTfDBi0EOSB+Fauu+Ns+mlr12+HUoJ+/iw+aAxwlbV4xMWRUdVlzj5BBQFpDNLZJKNpp/vsapt0QjA3/J1ZL7TGNCO5cNeXwvlcrxAH1fEbBYVXeKDAm2uDYqIZ1oIcpwUSrzRW96XAOzbwN7+gL7prSh+y/4nm/hScfsmG+N2f1tBkgOVmtz/Mle74rDbfigpMvw5K7g0XrsGr0ZEirmMhRhIIYU4frVkbWV+2/jHwYDmOl/Hm4W7k+nDBn0pcDAbmPAIqtjLSuNQNy68Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f63/f0Oz8MZlERIBhMdkqMt5iP5oIzwxWEVsA1XVWFg=;
 b=5OphOSoIBQVoCM5dpN9kp/Apj5p3p77vTk1pnT6mTxbDQfZRYv/VLrzveDY/dvEktbwbgiMCjk//zvQojVzA/r3mQgG46F3Nqh1En+bkSKpLArFHIipm2NFvRaABBpxR6JLq9JQDQHP60Y0x8y4pwi4TimTp7gzMXECPZC3Ztt0=
Received: from BN1PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:e1::24)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::11) by BN1PR12CA0019.outlook.office365.com
 (2603:10b6:408:e1::24) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 15:19:10 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 30/49] drm/amd/display: Add KUnit tests for update_config
Date: Thu, 23 Jul 2026 16:13:38 -0400
Message-ID: <20260723201908.373300-31-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcd4686-75ee-4df6-93c6-08dee8f7b0af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: f0Bug5Ns4JCDy4LL7Hj0SQTZ4q7IEjPHcpBx8zJ0XCtMF1z2Rp6SL5DiMjhLdY8yhsdriOFe4qMZkSuSlgbT6HbAETs+H9uddwpiZl9nm7vnvlVY0xHJ5wOlbgM4ioZAmDaJS/0C2mPZfCq1Sbo8aoa8ahiZbG4a01coULg/XBqGfdH54eD8BvZA8R5ASNuY9DuQhbtFHa1VA++o67juSpIZuRWgA8lMkw1529K3g9kxdXrt19zKFU1c5egVwg6NP6urbwPsdBV57oJ+4OzhVjnfY7H/BFeZ8YQUGfkVNsE7PxzL/OpsOoWS5w48fp+pucqWx444fnYnGWxvOUFAdtY1zJimeCdk/mD9R1e6Nlzm1tx9ezaFF82wU1ptOmkDPbxHMdayUHFUiFtlo7L2x0DPKIQ5R3oA457sq+ktHW3NNn7PyHOELRGDV5BFhwqUf11Lr39bVO52qKK8DRBCfyTZJMmRZqUvtCGM22hqtH6b47yR0thyxRlf5WEX3bmQRP9NDMaq7rEN23ENnp72Jrd7HHaPdPXCBveOCDXpG/fJuIx3R6kOeJI59yKM8UjMXwL2ASoYlwjolWdnve4CMQ8ha4seKUAf2acbjOZ0guNHeTstvrvmtYn3vwmKzmo3NFSuujxJ3xHwo/NBV79lbKO7cBEuT9VVbmsx9o9GCC0+UdPPS8DCT2qIijqNM7zEfMRORATfyW0muQGaGDx4dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VLJTqURRLqTzVAuxJHfiJ+rT5gOnUW8g9Svj82vTf6ysQY6m1+ZZtmukRJugHA86pWKi9yqBwdYZ0XYaJxh1RaFP91P2e9fVPxMSyalmC7+GqZfXmA6i9EjxFz6UV8tOjuFwkvwwid2bWS9SZPgdshCmk2ngfPrXNceYMQZz7PxqV93qUbqKwhNRIJZdBrniThAHkJoZkIOmLv8FpkAAzH3LhdL8+eqklCXcFGhXzcnPu8eLb3P61MiWfvtgRRBl6kxUYpQ2FpyHUfUUe7eZsm6ErfrYGOKINfmghf36wOU8Uc4Mul6rZY7PYCJ9XlbU5RA2219ATqvAmKgdj5JzLH8E1388ahzkadjwGiQBiNiVdQyeVG8GwkIgN2jB3slujPr8dFxMNSb8n31hDkcEt03RviPn/tkZYbmmQPDYq9ooMguc1Uw9SaoS55ewXnVy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:25.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcd4686-75ee-4df6-93c6-08dee8f7b0af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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

Expose update_config() for KUnit and cover the NULL connector and NULL
dc_link early returns, the dpms_off removal path and the active path
that builds the display/link state and registers the connector. The
active path leaves the DTM TA uninitialized so add_display_to_topology()
returns early without touching firmware.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 144 ++++++++++++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 7115cc0c7746..560bfa43dc8a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -606,7 +606,8 @@ bool enable_assr(void *handle, struct dc_link *link)
 }
 EXPORT_IF_KUNIT(enable_assr);
 
-static void update_config(void *handle, struct cp_psp_stream_config *config)
+STATIC_IFN_KUNIT
+void update_config(void *handle, struct cp_psp_stream_config *config)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct amdgpu_dm_connector *aconnector;
@@ -692,6 +693,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	hdcp_w->aconnector[conn_index] = aconnector;
 	process_output(hdcp_w);
 }
+EXPORT_IF_KUNIT(update_config);
 
 /**
  * DOC: Add sysfs interface for set/get srm
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index b8ba2888a2ef..30c1e7b1af1a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -124,6 +124,7 @@ void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_ind
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size);
 int psp_set_srm(struct psp_context *psp, u8 *srm, uint32_t srm_size, uint32_t *srm_version);
 bool enable_assr(void *handle, struct dc_link *link);
+void update_config(void *handle, struct cp_psp_stream_config *config);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 1580562727cd..b75fadd4e14e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1580,6 +1580,145 @@ static void dm_test_enable_assr_initialized_builds_command_and_fails(struct kuni
 
 /* End of tests for enable_assr() */
 
+/* Tests for update_config() */
+
+/**
+ * dm_test_update_config_null_connector_is_noop - NULL stream ctx returns early
+ * @test: KUnit test context
+ *
+ * When config->dm_stream_ctx is NULL, update_config() must return before
+ * touching the workqueue, leaving the per-link aconnector array untouched.
+ */
+static void dm_test_update_config_null_connector_is_noop(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct cp_psp_stream_config config = {0};
+
+	config.dm_stream_ctx = NULL;
+
+	update_config(work, &config);
+
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], NULL);
+}
+
+/**
+ * dm_test_update_config_null_dc_link_is_noop - NULL dc_link returns early
+ * @test: KUnit test context
+ *
+ * A connector without a dc_link must cause update_config() to return before
+ * registering the connector, leaving the aconnector array untouched.
+ */
+static void dm_test_update_config_null_dc_link_is_noop(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct cp_psp_stream_config config = {0};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aconnector->dc_link = NULL;
+
+	config.dm_stream_ctx = aconnector;
+
+	update_config(work, &config);
+
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], NULL);
+}
+
+/**
+ * dm_test_update_config_dpms_off_removes_display - dpms_off path removes display
+ * @test: KUnit test context
+ *
+ * With config->dpms_off set, update_config() must take the removal path:
+ * hdcp_remove_display() reverts an ENABLED connector to DESIRED and clears
+ * its per-link aconnector entry.
+ */
+static void dm_test_update_config_dpms_off_removes_display(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+	struct drm_connector_state *conn_state;
+	struct cp_psp_stream_config config = {0};
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	aconnector->base.state = conn_state;
+	work->aconnector[0] = aconnector;
+
+	config.dm_stream_ctx = aconnector;
+	config.dpms_off = true;
+
+	update_config(work, &config);
+
+	KUNIT_EXPECT_EQ(test, conn_state->content_protection,
+			DRM_MODE_CONTENT_PROTECTION_DESIRED);
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], NULL);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/**
+ * dm_test_update_config_populates_display_and_link - active path fills state
+ * @test: KUnit test context
+ *
+ * With dpms_off clear, update_config() must build the display and link from
+ * @config, reset the connector's encryption_status to HDCP_OFF, register the
+ * connector and reach process_output() (which enqueues property_validate).
+ *
+ * mod_hdcp_add_display() reaches add_display_to_topology(), which returns
+ * early because the DTM TA is left uninitialized, so no firmware is touched.
+ */
+static void dm_test_update_config_populates_display_and_link(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+	struct psp_context *psp;
+	struct cp_psp_stream_config config = {0};
+
+	/* add_display_to_topology() dereferences the psp handle. */
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+	work->hdcp.config.psp.handle = psp;
+
+	config.dm_stream_ctx = aconnector;
+	config.dpms_off = false;
+	config.otg_inst = 1;
+	config.dig_fe = 4;
+	config.dig_be = 5;
+	config.stream_enc_idx = 6;
+	config.link_enc_idx = 7;
+	config.dio_output_idx = 8;
+	config.phy_idx = 2;
+
+	update_config(work, &config);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], aconnector);
+
+	KUNIT_EXPECT_EQ(test, work->display.state, MOD_HDCP_DISPLAY_ACTIVE);
+	KUNIT_EXPECT_EQ(test, work->display.controller,
+			CONTROLLER_ID_D0 + config.otg_inst);
+	KUNIT_EXPECT_EQ(test, work->display.dig_fe, config.dig_fe);
+	KUNIT_EXPECT_EQ(test, work->display.stream_enc_idx, config.stream_enc_idx);
+
+	KUNIT_EXPECT_EQ(test, work->link.dig_be, config.dig_be);
+	KUNIT_EXPECT_EQ(test, work->link.link_enc_idx, config.link_enc_idx);
+	KUNIT_EXPECT_EQ(test, work->link.dio_output_id, config.dio_output_idx);
+	KUNIT_EXPECT_EQ(test, work->link.phy_idx, config.phy_idx);
+
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->property_validate_dwork.work));
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/* End of tests for update_config() */
+
 static struct kunit_case dm_hdcp_test_cases[] = {
 	/* hdcp_get_content_protection_from_status() */
 	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
@@ -1645,6 +1784,11 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_enable_assr_uninitialized_dtm_returns_false),
 	KUNIT_CASE(dm_test_enable_assr_uninitialized_dtm_ignores_link),
 	KUNIT_CASE(dm_test_enable_assr_initialized_builds_command_and_fails),
+	/* update_config() */
+	KUNIT_CASE(dm_test_update_config_null_connector_is_noop),
+	KUNIT_CASE(dm_test_update_config_null_dc_link_is_noop),
+	KUNIT_CASE(dm_test_update_config_dpms_off_removes_display),
+	KUNIT_CASE(dm_test_update_config_populates_display_and_link),
 	{}
 };
 
-- 
2.53.0

