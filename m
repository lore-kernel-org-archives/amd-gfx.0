Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E459C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9B810F6DE;
	Thu,  9 Jul 2026 21:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ySllyAzA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A514110F6D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS2fifwM7F9IbNorRUM0mNZE9KurXW7AoF31Ast+l0vkKFDXSIpOn2cqALP1rYaXyHKjPnzvcO8W/rEUOPO0JBxweqMFypVg5Y0z9oCkjgk1ybIo6thohoQvh//QCGTanaYYnmuj3cr1cP20xzjSvLWNb0oJw+mMQRzAQR8giQCPGlqGbm0ZSSLBHJYye2+0H/JLJZmHwfzlgm8DTQVTsFIBkZ0HJpzt1h6CnKzTsSbcDlcRGg3OsC0vGrEdO2YbuyAcNNo0c0aa5n9NbAZspHFEHU/AmN3PGhYe29k68Wld0rBbqv4bo7VWmBdLnqst0nfTLUUp0NXX35quTMLc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHp7txY0EtLDylShbt2u6hoXAXsJRx0Mb7rmI12dlCo=;
 b=AFw/jetRbm8uHU0Gi9jHki7395PqBUxK3JdRA8mbHuJChBF0kODIi92tm6BWftnTQLNMqUWnIFgcesunfIsfxdZmPm8Xt9mjjBxcgYk5TxXdw8sl18c1J9OosynFtSzkMnpD7AfPe/m2+TT6VFvQa2N6gBKeeZ067SIsr6X92QgniSUGDmvT3tgDvvFzCmD15KtmNDswSv2ZMOC//jwUeX3Uk7Vwe39yP48PBr/gfxWNicFcsVdlhTOY/AfeR1C7wyCgM18pKyAUcs4Ampze+I7oaVPgVG6JJsqXdaSuIZLZiYPfHHk519xiDYb0su7FAGWET8dsV1LlPl2qqNEZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHp7txY0EtLDylShbt2u6hoXAXsJRx0Mb7rmI12dlCo=;
 b=ySllyAzAF9GbFCGFF0iTVHYsNaBNU3aipikJjEv0WZwOxz6b1b7eKdPPL1zBJ6jMNYlpE+tYsLPUACyzqV/Yq4qvD62e7kJBjLPOVn50ytrvLzN5RssT6nFUST21FPFp3nq/gWQ/q1YyHPpeUiguS52g2o6MeInkGBLEjtigdrc=
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:18 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:18 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:56 -0500
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
Subject: [PATCH 27/80] drm/amd/display: Test I2C, stubs and MST early returns
Date: Thu, 9 Jul 2026 16:47:55 -0400
Message-ID: <20260709205936.5719-28-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7ac64e-5f86-42b1-e4ec-08deddfd5c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: J+iR5G4dhhAP73yzTshBxmcSWWz9JWH2rx6iocqOYI03X59L8k/a8Msuja/Zts1D8SlS+XRjn4Dd42Hgk8z/rc47WFb3nwD3TAFYM+0hwShH5qsGTWQ8jNtGRApaXs0C5HekYVpFpx5rfwrZOJnbQZLuGIeG05XS5u78s+r7xRm/lnV43OsGdiaZg/+ysnHJEGc34DiEU9rMJt9iEzi1zJBUtQXRFC1qN9yJiyvrplKLKmQOvcANUUa7BCrHBsfcrcg4R+0z4mM4kju1VcKJdwe70CXSY19I7ZaIT/j3MixfYlIHG8Wivw70ddR9dYMyelHu3jp4sEAA7HYpVzJlcfMLuYlxa9FswqjMerWTal0VdUkTk3b6wp1CxIXi+WdPp/8gusIiMhlXJtbI81n7qcuE2gCpRPIK2MREplmou3wQwdKriSPO1ERMLy2UzhBtx7qJgwPY8g9JljIOdJEc1UTzI/0Uakc2keEPovq5UHteeYjclYd019uqkHzqycK6FwRDmZpRaCEnWomujNKBiH9QkNqOpEEm8zZCTl9PSWBZNZN3srVAwjyQAVXTuwzdzBfA2eg0aI3PRf7a8dKIu/5/QzpmgYCA1IDOmIJd2oag15XOW3kCfbW06ZES4VGWG2eFuyEO1yCtrhJnTbx1t/TvztEyuLIPK+t7G6GhFPw9mMwfgDzGBH7QGpE10jRRUD3oRLGAmIAofe3S4spg0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRULcO9ObN9Eeo/Lc/5ZaaoxIpjEnSgyXUVOS9FqQjA7ygYTZaTxFXpgD0zgF/gu2xmcHKv2mAI48HgbXR924go/oBnWh+ccBldlAE1XK2sxY+xrbgUYZYgwa3Eess+nBNwlYBawYALaYKFaBWiBX2lvNflDfqgbKmMuY8Ha52cGbZyHiRQjdzlLtdDo9H1TsmQXtufAN/oK2FCdOLhYuiOYdi1N8JQHP+Q8pstRP6Zhh4+LV9rdUWHoVXBIeD2dwtW2sPWNjF5qRJpE5bCzfT2wqwyv9gZxAfpIzed+ASzazSu9/fAMAV8qmA+T+YUS9nPPekFtLAKuvei5SzeQALc8s2Fwqgyz/ysNY5EjpZvb53pq/uYhiduMNlBBq7mC0zfNiOWfs8JvwXmbzyGS0I4EEt5GyrtKIdQ8sf1fbdbDw2rN+Xd+Hmn5j3fJxbAO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:18.2055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7ac64e-5f86-42b1-e4ec-08deddfd5c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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
Add KUnit coverage for dm_helpers_submit_i2c,
dm_helper_dmub_aux_transfer_sync, the empty stub helpers, the MST
null-connector early returns, dm_helpers_dmub_outbox_interrupt_control,
dm_helpers_mst_enable_stream_features and
dm_helpers_enable_periodic_detection.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 541 ++++++++++++++++++
 2 files changed, 559 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index aa4bd99528a3..04e3c34b9e50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -296,6 +296,7 @@ void dm_helpers_dp_update_branch_info(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
+EXPORT_IF_KUNIT(dm_helpers_dp_update_branch_info);

 static void dm_helpers_construct_old_payload(
 			struct drm_dp_mst_topology_mgr *mgr,
@@ -380,6 +381,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(

 	return true;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_write_payload_allocation_table);

 /*
  * poll pending down reply
@@ -388,6 +390,7 @@ void dm_helpers_dp_mst_poll_pending_down_reply(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_poll_pending_down_reply);

 /*
  * Clear payload allocation table before enable MST DP link.
@@ -396,6 +399,7 @@ void dm_helpers_dp_mst_clear_payload_allocation_table(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_clear_payload_allocation_table);

 /*
  * Polls for ACT (allocation change trigger) handled and sends
@@ -426,6 +430,7 @@ enum act_return_status dm_helpers_dp_mst_poll_for_allocation_change_trigger(

 	return ACT_SUCCESS;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_poll_for_allocation_change_trigger);

 void dm_helpers_dp_mst_send_payload_allocation(
 		struct dc_context *ctx,
@@ -460,6 +465,7 @@ void dm_helpers_dp_mst_send_payload_allocation(
 			clr_flag, false);
 	}
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_send_payload_allocation);

 void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 		struct dc_context *ctx,
@@ -488,6 +494,7 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, set_flag, true);
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, clr_flag, false);
  }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_mst_mgr_for_deallocation);

 void dm_dtn_log_begin(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx)
@@ -707,6 +714,7 @@ bool dm_helpers_submit_i2c(

 	return result;
 }
+EXPORT_IF_KUNIT(dm_helpers_submit_i2c);

 bool dm_helpers_execute_fused_io(
 		struct dc_context *ctx,
@@ -1023,6 +1031,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 	mutex_unlock(&aconnector->dm_dp_aux.aux.hw_mutex);
 	return dp_sink_present;
 }
+EXPORT_IF_KUNIT(dm_helpers_is_dp_sink_present);

 STATIC_IFN_KUNIT int
 dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
@@ -1312,6 +1321,7 @@ int dm_helper_dmub_aux_transfer_sync(
 	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload,
 			operation_result);
 }
+EXPORT_IF_KUNIT(dm_helper_dmub_aux_transfer_sync);

 int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
@@ -1326,18 +1336,21 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
 	/* TODO: something */
 }
+EXPORT_IF_KUNIT(dm_set_dcn_clocks);

 void dm_helpers_dmu_timeout(struct dc_context *ctx)
 {
 	// TODO:
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
+EXPORT_IF_KUNIT(dm_helpers_dmu_timeout);

 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)
 {
 	// TODO:
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
+EXPORT_IF_KUNIT(dm_helpers_smu_timeout);

 void dm_helpers_init_panel_settings(
 	struct dc_context *ctx,
@@ -1410,6 +1423,7 @@ bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enabl
 			 enable ? "en" : "dis", ret);
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_helpers_dmub_outbox_interrupt_control);

 void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 {
@@ -1435,6 +1449,7 @@ void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 					 &new_downspread.raw,
 					 sizeof(new_downspread));
 }
+EXPORT_IF_KUNIT(dm_helpers_mst_enable_stream_features);

 bool dm_helpers_dp_handle_test_pattern_request(
 		struct dc_context *ctx,
@@ -1578,6 +1593,7 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
        // TODO
 }
+EXPORT_IF_KUNIT(dm_set_phyd32clk);

 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
@@ -1589,6 +1605,7 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 			schedule_work(&adev->dm.idle_workqueue->work);
 	}
 }
+EXPORT_IF_KUNIT(dm_helpers_enable_periodic_detection);

 void dm_helpers_dp_mst_update_branch_bandwidth(
 		struct dc_context *ctx,
@@ -1596,6 +1613,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 {
 	// TODO
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_branch_bandwidth);

 STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_0060AD,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 599de8240bee..29feb8c3940b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -1421,6 +1421,14 @@ static ssize_t dm_test_synaptics_aux_transfer(struct drm_dp_aux *aux,
 	return msg->size;
 }

+static struct dm_test_synaptics_aux *dm_test_current_aux_recorder;
+
+static ssize_t dm_test_current_aux_transfer(struct drm_dp_aux *aux,
+					    struct drm_dp_aux_msg *msg)
+{
+	return dm_test_synaptics_aux_transfer(&dm_test_current_aux_recorder->aux, msg);
+}
+
 static struct dm_test_synaptics_aux *dm_test_alloc_synaptics_aux_with_dev(struct kunit *test,
 								 struct drm_device *drm_dev)
 {
@@ -2022,6 +2030,507 @@ static void dm_test_fill_mst_payload_table_empty(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].slot_count, 12);
 }

+/* Tests for dm_helpers_submit_i2c() */
+
+/**
+ * dm_test_submit_i2c_null_priv - Test i2c submit returns false without connector
+ * @test: The KUnit test context
+ */
+static void dm_test_submit_i2c_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+	struct i2c_command cmd = {0};
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_submit_i2c(NULL, link, &cmd));
+}
+
+struct dm_test_i2c_adapter {
+	struct i2c_adapter base;
+	struct kunit *test;
+	struct i2c_payload *expected_payloads;
+	int expected_num;
+	int ret;
+	int calls;
+};
+
+static void dm_test_i2c_lock_bus(struct i2c_adapter *adapter,
+					 unsigned int flags)
+{
+	rt_mutex_lock(&adapter->bus_lock);
+}
+
+static int dm_test_i2c_trylock_bus(struct i2c_adapter *adapter,
+					   unsigned int flags)
+{
+	return rt_mutex_trylock(&adapter->bus_lock);
+}
+
+static void dm_test_i2c_unlock_bus(struct i2c_adapter *adapter,
+					   unsigned int flags)
+{
+	rt_mutex_unlock(&adapter->bus_lock);
+}
+
+static const struct i2c_lock_operations dm_test_i2c_lock_ops = {
+	.lock_bus = dm_test_i2c_lock_bus,
+	.trylock_bus = dm_test_i2c_trylock_bus,
+	.unlock_bus = dm_test_i2c_unlock_bus,
+};
+
+static int dm_test_i2c_master_xfer(struct i2c_adapter *adapter,
+					   struct i2c_msg *msgs,
+					   int num)
+{
+	struct dm_test_i2c_adapter *fake;
+	int i;
+
+	fake = container_of(adapter, struct dm_test_i2c_adapter, base);
+	fake->calls++;
+
+	KUNIT_EXPECT_EQ(fake->test, num, fake->expected_num);
+
+	for (i = 0; i < num; i++) {
+		KUNIT_EXPECT_EQ(fake->test, msgs[i].flags,
+				 fake->expected_payloads[i].write ? 0 : I2C_M_RD);
+		KUNIT_EXPECT_EQ(fake->test, msgs[i].addr,
+				 (u16)fake->expected_payloads[i].address);
+		KUNIT_EXPECT_EQ(fake->test, msgs[i].len,
+				 (u16)fake->expected_payloads[i].length);
+		KUNIT_EXPECT_PTR_EQ(fake->test, msgs[i].buf,
+				    fake->expected_payloads[i].data);
+	}
+
+	return fake->ret;
+}
+
+static const struct i2c_algorithm dm_test_i2c_algorithm = {
+	.master_xfer = dm_test_i2c_master_xfer,
+};
+
+static void dm_test_submit_i2c_transfer(struct kunit *test,
+					bool full_transfer)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_test_i2c_adapter *fake;
+	struct dc_link *link;
+	u8 write_data[2] = { 0x12, 0x34 };
+	u8 read_data[3] = { 0 };
+	struct i2c_payload payloads[] = {
+		{ true, 0x50, sizeof(write_data), write_data },
+		{ false, 0x51, sizeof(read_data), read_data },
+	};
+	struct i2c_command cmd = {
+		.payloads = payloads,
+		.number_of_payloads = ARRAY_SIZE(payloads),
+	};
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	fake = kunit_kzalloc(test, sizeof(*fake), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fake);
+
+	fake->test = test;
+	fake->expected_payloads = payloads;
+	fake->expected_num = ARRAY_SIZE(payloads);
+	fake->ret = full_transfer ? ARRAY_SIZE(payloads) : 1;
+	fake->base.algo = &dm_test_i2c_algorithm;
+	fake->base.lock_ops = &dm_test_i2c_lock_ops;
+	rt_mutex_init(&fake->base.bus_lock);
+	rt_mutex_init(&fake->base.mux_lock);
+
+	aconnector->i2c = (struct amdgpu_i2c_adapter *)fake;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_submit_i2c(NULL, link, &cmd), full_transfer);
+	KUNIT_EXPECT_EQ(test, fake->calls, 1);
+}
+
+/**
+ * dm_test_submit_i2c_success - Test payloads are mapped to i2c_msg array
+ * @test: The KUnit test context
+ */
+static void dm_test_submit_i2c_success(struct kunit *test)
+{
+	dm_test_submit_i2c_transfer(test, true);
+}
+
+/**
+ * dm_test_submit_i2c_partial_transfer - Test short i2c transfer returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_submit_i2c_partial_transfer(struct kunit *test)
+{
+	dm_test_submit_i2c_transfer(test, false);
+}
+
+/* Tests for dm_helper_dmub_aux_transfer_sync() */
+
+/**
+ * dm_test_dmub_aux_transfer_sync_hpd_discon - Test aux transfer with HPD disconnected
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_transfer_sync_hpd_discon(struct kunit *test)
+{
+	struct dc_link *link;
+	struct dc_context *ctx;
+	struct aux_payload payload = {0};
+	enum aux_return_code_type result = AUX_RET_SUCCESS;
+	int ret;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	link->hpd_status = false;
+
+	ret = dm_helper_dmub_aux_transfer_sync(ctx, link, &payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)AUX_RET_ERROR_HPD_DISCON);
+}
+
+/* Tests for empty stub functions (must not crash) */
+
+/**
+ * dm_test_dp_update_branch_info_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_update_branch_info_no_crash(struct kunit *test)
+{
+	dm_helpers_dp_update_branch_info(NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mst_poll_pending_down_reply_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_poll_pending_down_reply_no_crash(struct kunit *test)
+{
+	dm_helpers_dp_mst_poll_pending_down_reply(NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mst_clear_payload_alloc_table_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_clear_payload_alloc_table_no_crash(struct kunit *test)
+{
+	dm_helpers_dp_mst_clear_payload_allocation_table(NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_set_dcn_clocks_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_set_dcn_clocks_no_crash(struct kunit *test)
+{
+	dm_set_dcn_clocks(NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_dmu_timeout_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_dmu_timeout_no_crash(struct kunit *test)
+{
+	dm_helpers_dmu_timeout(NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_smu_timeout_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_smu_timeout_no_crash(struct kunit *test)
+{
+	dm_helpers_smu_timeout(NULL, 0, 0, 0);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_set_phyd32clk_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_set_phyd32clk_no_crash(struct kunit *test)
+{
+	dm_set_phyd32clk(NULL, 0);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mst_update_branch_bandwidth_no_crash - Test empty stub does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_update_branch_bandwidth_no_crash(struct kunit *test)
+{
+	dm_helpers_dp_mst_update_branch_bandwidth(NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/* Tests for MST functions null-connector early returns */
+
+/**
+ * dm_test_mst_write_payload_alloc_table_null_ctx - Test null connector returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_write_payload_alloc_table_null_ctx(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	/* dm_stream_context is NULL → aconnector is NULL → return false */
+	KUNIT_EXPECT_FALSE(test,
+			   dm_helpers_dp_mst_write_payload_allocation_table(NULL, stream, NULL, true));
+}
+
+/**
+ * dm_test_mst_poll_for_act_null_ctx - Test null connector returns ACT_FAILED
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_poll_for_act_null_ctx(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_helpers_dp_mst_poll_for_allocation_change_trigger(NULL, stream),
+			(int)ACT_FAILED);
+}
+
+/**
+ * dm_test_mst_send_payload_alloc_null_ctx - Test null connector does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_send_payload_alloc_null_ctx(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	/* Should early-return without crash */
+	dm_helpers_dp_mst_send_payload_allocation(NULL, stream);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mst_update_mgr_dealloc_null_ctx - Test null connector does not crash
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_update_mgr_dealloc_null_ctx(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	dm_helpers_dp_mst_update_mst_mgr_for_deallocation(NULL, stream);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_is_dp_sink_present_null_priv - Test null connector returns true
+ * @test: The KUnit test context
+ */
+static void dm_test_is_dp_sink_present_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* NULL priv → DRM_ERROR + return true */
+	KUNIT_EXPECT_TRUE(test, dm_helpers_is_dp_sink_present(link));
+}
+
+/* Tests for dm_helpers_dmub_outbox_interrupt_control() */
+
+/**
+ * dm_test_dmub_outbox_interrupt_control_null_dc - Test outbox irq control with NULL dc
+ * @test: The KUnit test context
+ *
+ * dc_interrupt_set() is NULL-safe and returns false when dc is NULL, so the
+ * helper returns false without touching real interrupt hardware.
+ */
+static void dm_test_dmub_outbox_interrupt_control_null_dc(struct kunit *test)
+{
+	struct dc_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	/* ctx->dc is NULL → dc_interrupt_set returns false */
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dmub_outbox_interrupt_control(ctx, true));
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dmub_outbox_interrupt_control(ctx, false));
+}
+
+/* Tests for dm_helpers_mst_enable_stream_features() */
+
+/**
+ * dm_test_mst_enable_stream_features_aux_disabled - Test early return when aux disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_enable_stream_features_aux_disabled(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->link = link;
+	link->aux_access_disabled = true;
+
+	/* aux_access_disabled → early return without DPCD access */
+	dm_helpers_mst_enable_stream_features(stream);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mst_enable_stream_features_writes_downspread - Test MSA ignore write
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_enable_stream_features_writes_downspread(struct kunit *test)
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
+	dm_test_current_aux_recorder = fixture;
+	aconnector->dm_dp_aux.aux.drm_dev = &adev->ddev;
+	aconnector->dm_dp_aux.aux.transfer = dm_test_current_aux_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+	link->priv = aconnector;
+	stream->link = link;
+	stream->ignore_msa_timing_param = true;
+
+	dm_helpers_mst_enable_stream_features(stream);
+
+	KUNIT_EXPECT_EQ(test, fixture->downspread_reads, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->downspread_writes, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->last_dpcd_write_address,
+			 DP_DOWNSPREAD_CTRL);
+	KUNIT_EXPECT_EQ(test, fixture->dpcd_write_value, (u8)BIT(7));
+}
+
+/* Tests for dm_helpers_enable_periodic_detection() */
+
+struct dm_test_idle_work {
+	struct idle_workqueue base;
+	bool ran;
+};
+
+static void dm_test_idle_work_func(struct work_struct *work)
+{
+	struct dm_test_idle_work *idle_work;
+
+	idle_work = container_of(work, struct dm_test_idle_work, base.work);
+	idle_work->ran = true;
+}
+
+/**
+ * dm_test_enable_periodic_detection_no_workqueue - Test no-op without idle workqueue
+ * @test: The KUnit test context
+ */
+static void dm_test_enable_periodic_detection_no_workqueue(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->driver_context = adev;
+
+	/* adev->dm.idle_workqueue is NULL → no-op, no crash */
+	dm_helpers_enable_periodic_detection(ctx, true);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_enable_periodic_detection_updates_enable - Test idle work enable flag
+ * @test: The KUnit test context
+ *
+ * Keeps idle_workqueue->running set so the helper only updates the enable flag
+ * and does not queue the idle worker.
+ */
+static void dm_test_enable_periodic_detection_updates_enable(struct kunit *test)
+{
+	struct idle_workqueue *idle_work;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+
+	adev = dm_kunit_alloc_adev(test);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
+
+	ctx->driver_context = adev;
+	adev->dm.idle_workqueue = idle_work;
+	idle_work->running = true;
+
+	dm_helpers_enable_periodic_detection(ctx, true);
+	KUNIT_EXPECT_TRUE(test, idle_work->enable);
+
+	dm_helpers_enable_periodic_detection(ctx, false);
+	KUNIT_EXPECT_FALSE(test, idle_work->enable);
+}
+
+/**
+ * dm_test_enable_periodic_detection_schedules_work - Test headless schedule path
+ * @test: The KUnit test context
+ */
+static void dm_test_enable_periodic_detection_schedules_work(struct kunit *test)
+{
+	struct dm_test_idle_work *idle_work;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+
+	adev = dm_kunit_alloc_adev(test);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
+
+	ctx->driver_context = adev;
+	adev->dm.ddev = &adev->ddev;
+	adev->dm.idle_workqueue = &idle_work->base;
+	INIT_WORK(&idle_work->base.work, dm_test_idle_work_func);
+
+	dm_helpers_enable_periodic_detection(ctx, true);
+	flush_work(&idle_work->base.work);
+
+	KUNIT_EXPECT_TRUE(test, idle_work->base.enable);
+	KUNIT_EXPECT_TRUE(test, idle_work->ran);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -2127,6 +2636,38 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_mst_payload_table_enable),
 	KUNIT_CASE(dm_test_fill_mst_payload_table_disable),
 	KUNIT_CASE(dm_test_fill_mst_payload_table_empty),
+	/* dm_helpers_submit_i2c */
+	KUNIT_CASE(dm_test_submit_i2c_null_priv),
+	KUNIT_CASE(dm_test_submit_i2c_success),
+	KUNIT_CASE(dm_test_submit_i2c_partial_transfer),
+	/* dm_helper_dmub_aux_transfer_sync */
+	KUNIT_CASE(dm_test_dmub_aux_transfer_sync_hpd_discon),
+	/* Empty stub functions */
+	KUNIT_CASE(dm_test_dp_update_branch_info_no_crash),
+	KUNIT_CASE(dm_test_mst_poll_pending_down_reply_no_crash),
+	KUNIT_CASE(dm_test_mst_clear_payload_alloc_table_no_crash),
+	KUNIT_CASE(dm_test_set_dcn_clocks_no_crash),
+	KUNIT_CASE(dm_test_dmu_timeout_no_crash),
+	KUNIT_CASE(dm_test_smu_timeout_no_crash),
+	KUNIT_CASE(dm_test_set_phyd32clk_no_crash),
+	KUNIT_CASE(dm_test_mst_update_branch_bandwidth_no_crash),
+	/* MST null-connector early returns */
+	KUNIT_CASE(dm_test_mst_write_payload_alloc_table_null_ctx),
+	KUNIT_CASE(dm_test_mst_poll_for_act_null_ctx),
+	/* dm_helpers_dp_mst_poll_for_allocation_change_trigger success/fail */
+	KUNIT_CASE(dm_test_mst_send_payload_alloc_null_ctx),
+	KUNIT_CASE(dm_test_mst_update_mgr_dealloc_null_ctx),
+	/* dm_helpers_is_dp_sink_present */
+	KUNIT_CASE(dm_test_is_dp_sink_present_null_priv),
+	/* dm_helpers_dmub_outbox_interrupt_control */
+	KUNIT_CASE(dm_test_dmub_outbox_interrupt_control_null_dc),
+	/* dm_helpers_mst_enable_stream_features */
+	KUNIT_CASE(dm_test_mst_enable_stream_features_aux_disabled),
+	KUNIT_CASE(dm_test_mst_enable_stream_features_writes_downspread),
+	/* dm_helpers_enable_periodic_detection */
+	KUNIT_CASE(dm_test_enable_periodic_detection_no_workqueue),
+	KUNIT_CASE(dm_test_enable_periodic_detection_updates_enable),
+	KUNIT_CASE(dm_test_enable_periodic_detection_schedules_work),
 	{}
 };

--
2.55.0

