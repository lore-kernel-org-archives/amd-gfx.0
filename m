Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E08C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F07B10F6D7;
	Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5iqUVhHm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312D610F6D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkbvHydNuVMIdjA07xlQykQty6+8u53/MZNXuvPOAqRzoKPArB28motJDYcgOyvFm67Or8nEicl4YBkszPYw6e+f5s0R8vb87IIJryn0320qN53x6k/g856s1EegCNB07b4YpPdMvuP1gHA4OFFtCT7LNp1Z3j9vUSuolI8t6370f/FGAnSWiP1VRNTSd5cKEEK6xZhJxxvn4qGkezA+AZuFhrVTuD8whs1UusykfSEpyvrKP12jlM9/eHXnlqjkG1/W9BVH3oE9fHmGCA861Z/UEXfCIhPuLfbs3D8MEMBnpTHRQl55x5BtvjmJaUBpF9+FR+hzQR7iuiQOZtc1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44Z3zMAiTuFhLA1O6MgfhIUhlusvoQq6KgTRb4X6gBI=;
 b=gJOpMy/jk0cJzGyt7sLss83J0FEDtoWIrfoFFoRZlpMnA0wBRbw/ba+PFd8xkiz/n6jP3tQIBs1g5Us2YREOeMkbgYK/8dScHTPcExJn7eN5XfF9jz418yLtEYcnw6DusWrP59FjCZP1EwnPrwYmvr2duCHiJTcFuQmoZaKbH6qMXnXnqitP3oKu0jPEyGnzn0b2rtgOk6yYzbRRLgZwtOSG4HUBb+cn/Rxqrn5Dp2JzlkiRFlFW3RXyvU9jMQVz89FF4/1wvVSiJze4cq5FZTBR0CSzIMdSnfbru4QHofkC/wBJFaAGrleaiegN9MDfoNKn4zLo7s8JJ/KkEBLJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44Z3zMAiTuFhLA1O6MgfhIUhlusvoQq6KgTRb4X6gBI=;
 b=5iqUVhHmPTeTUMMbMQASTVUekPhC3x75Sk3IRzgbtXS7Zw/EZUdcvDfEtA23mRBrlAicRwu18B9L+8M4VxT9+5tsIUvzwPq4bSBcs5z3RibMNbIbY+JltM3IozdQKP8KhHrrvsNGBmPh3c5WHaCKNmUvCzSEYFl9L3hqJKIJj7s=
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:17 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::22) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:17 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:55 -0500
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
Subject: [PATCH 25/80] drm/amd/display: Test DPCD AUX and Synaptics helpers
Date: Thu, 9 Jul 2026 16:47:53 -0400
Message-ID: <20260709205936.5719-26-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b5fecc-95ff-4ddc-f437-08deddfd5bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|6133799003|22082099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oMKYCVq0j0ALcbZ4W44KtuPMuPtdS1NzU05DLYiq3CrUopGhnGgVd5qY4CbRxDRsH38yveEJvI1c/d61izjxE5LvaXPR3/9WhQTn0eh8I891qkLdywarndpjHW56PG3gnzlqRN+yJZslL0QM1PXVkIcqAq1BfPBz6d+7ct1jjKPVYY9D06GSce3fyeRgksdl+kWbXbuN7wroWxA68bKEXJ7vZ9UGMot/jLKVyR/oqXqIXDTNxCDcKBzjTrurBQwh2YPzauFtsYcXGuSkfwfvqK7jEnJW3+Bvu1BmuGvQtK3v3nXK/1w2Z78Lt4YG/uG0TuGAqpZKQooCpth3oa2iBG2+z9Jb8oB+94SaaQ6iUHxPb53SviN+mqVq6s45stjoq4Lxh/2LrS+EjybGtyHJs6GgOB6E23+8VGik/RnueNoua9xumnCokOqxxVqXqDFElA72LTiFYyqI9ajQGiEsjSmwTtWu/neAD0mvQB4oElk8y7RpR5ahAOMAe53x3JkcIU74yhZxJSygzXlsTKSGO32LLg7xhcJUMRlDTAhKnCmmwKwtGV+hMeXuXsh+u0GL8J9op94/GxHvnY9RedV6Pm0mzs1f+meJsL7os2sG6vGDxAqSfEk11VTHWdfl39ETSGckcCntKvC9eIFJdlOIFc1B+CwAwtZUnRpuJRH+CERt06lPgOpJ+0D/mqxYAIEuiuSruPF4Ks2IgGWXs2Ypxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cqmcxIXuGA0oPVSPUsP3PbHHH+nXd6fIG2dZTsUGIsc6IUA8ppgC10LEkzkfrGcbA4djxW/uOrI7YleM+stmP+m5L+W7TtWM8XqcPRO8jwjNXn86yW8XNWR1RcPDvVaRiOPuEm8JiaiSvGORnS3SAAu60bCqZ5yDxiy3LyYl8j1li8mRI9OP1c/OAuidzu522mMXJuVpsjx7yHPJ/o+gVJT6/e9oahReKvbJpA5u93NtucCJk8ShvjIhpQgrTSyDBogklWXFhtzP8yCGhf777bdhzeOlxPFKrIa3qQGSxNgTN3sA6NGaPk62D2DPs9vCTw6R2Va1e2cjEI8tDnPtn6q/bJ4+y7YHSSbrSnJifvaQUS/bit9vaZpBhBGksCCDZTZWaz95OmNSWeRM2y65u1iCRW0Dy70xFRBSryw3zgnv4CAvsE44VX6knmzkd4dn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:17.0105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b5fecc-95ff-4ddc-f437-08deddfd5bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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
Add KUnit coverage for DTN logging, DPCD read/write, fused IO and the
Synaptics DSC workaround helpers execute_synaptics_rc_command,
apply_synaptics_fifo_reset_wa,
write_dsc_enable_synaptics_non_virtual_dpcd_mst and
dm_helpers_dp_write_dsc_enable.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |  13 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 485 ++++++++++++++++++
 3 files changed, 506 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 881518a861d5..804a95a19acf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -719,8 +719,9 @@ bool dm_helpers_execute_fused_io(

 	return amdgpu_dm_execute_fused_io(dev, link, commands, count, timeout_us);
 }
+EXPORT_IF_KUNIT(dm_helpers_execute_fused_io);

-static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
+STATIC_IFN_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
 		unsigned int length,
@@ -792,8 +793,9 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
 	return false;
 }
+EXPORT_IF_KUNIT(execute_synaptics_rc_command);

-static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
+STATIC_IFN_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
 	unsigned char data[16] = {0};

@@ -857,11 +859,12 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)

 	drm_dbg_dp(aux->drm_dev, "Done\n");
 }
+EXPORT_IF_KUNIT(apply_synaptics_fifo_reset_wa);

 /* MST Dock */
 static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";

-static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
+STATIC_IFN_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 		struct drm_dp_aux *aux,
 		const struct dc_stream_state *stream,
 		bool enable)
@@ -897,6 +900,7 @@ static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(

 	return ret;
 }
+EXPORT_IF_KUNIT(write_dsc_enable_synaptics_non_virtual_dpcd_mst);

 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
@@ -980,6 +984,7 @@ bool dm_helpers_dp_write_dsc_enable(

 	return ret;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_write_dsc_enable);

 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 uint dm_helpers_get_dc_debug_mask(void)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
index e5cbcd425847..343650b50707 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -28,12 +28,25 @@ uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane);
 bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id);
 extern const uint32_t dm_freesync_pcon_whitelist[];
 uint32_t dm_freesync_pcon_whitelist_count(void);
+bool dm_helpers_dp_write_dsc_enable(struct dc_context *ctx,
+				    const struct dc_stream_state *stream,
+				    bool enable);
 uint dm_helpers_get_dc_debug_mask(void);
 void dm_helpers_set_dc_debug_mask(uint debug_mask);
 int dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len);
 const struct drm_edid *dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector);
 const struct drm_edid *dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link,
 							    struct amdgpu_dm_connector *aconnector);
+bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
+				  bool is_write_cmd,
+				  unsigned char cmd,
+				  unsigned int length,
+				  unsigned int offset,
+				  unsigned char *data);
+void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux);
+uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(struct drm_dp_aux *aux,
+							const struct dc_stream_state *stream,
+							bool enable);
 #endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */

 #endif /* __AMDGPU_DM_HELPERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 3766d8d211e4..eed941a889e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -1211,6 +1211,475 @@ static void dm_test_dp_write_dpcd_null_priv(struct kunit *test)
 			   dm_helpers_dp_write_dpcd(NULL, link, 0, &data, sizeof(data)));
 }

+/*
+ * Stub AUX transfer that ACKs every transaction (zero-filling reads), so
+ * drm_dp_dpcd_read()/drm_dp_dpcd_write() report the full transfer size.
+ */
+static ssize_t dm_test_dpcd_ack_transfer(struct drm_dp_aux *aux,
+					 struct drm_dp_aux_msg *msg)
+{
+	if ((msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ)
+		memset(msg->buffer, 0, msg->size);
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+	return msg->size;
+}
+
+/*
+ * Wire a connector-backed link with a working AUX channel so the DPCD
+ * read/write helpers can complete a real transaction.
+ */
+static struct dc_link *dm_test_dpcd_link(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+
+	aconnector->dm_dp_aux.aux.drm_dev = &adev->ddev;
+	aconnector->dm_dp_aux.aux.transfer = dm_test_dpcd_ack_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+
+	link->priv = aconnector;
+
+	return link;
+}
+
+/**
+ * dm_test_dp_read_dpcd_success - Test DPCD read returns true on ACKed transfer
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_read_dpcd_success(struct kunit *test)
+{
+	struct dc_link *link = dm_test_dpcd_link(test);
+	uint8_t data = 0;
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_helpers_dp_read_dpcd(NULL, link, 0, &data, sizeof(data)));
+}
+
+/**
+ * dm_test_dp_write_dpcd_success - Test DPCD write returns true on ACKed transfer
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dpcd_success(struct kunit *test)
+{
+	struct dc_link *link = dm_test_dpcd_link(test);
+	uint8_t data = 0;
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_helpers_dp_write_dpcd(NULL, link, 0, &data, sizeof(data)));
+}
+
+/* Tests for dm_helpers_execute_fused_io() */
+
+/**
+ * dm_test_execute_fused_io_null_dmub_srv - Test fused IO fails without DMUB service
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_fused_io_null_dmub_srv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	union dmub_rb_cmd *commands;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	mutex_init(&adev->dm.dpia_aux_lock);
+	spin_lock_init(&adev->dm.dmub_lock);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	commands = kunit_kzalloc(test, sizeof(*commands), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, commands);
+
+	ctx->driver_context = adev;
+	link->ctx = ctx;
+	commands[0].fused_io.request.u.aux.ddc_line = 0;
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_execute_fused_io(ctx, link, commands, 1, 1));
+}
+
+struct dm_test_synaptics_aux {
+	struct drm_dp_aux aux;
+	u32 fail_address;
+	u32 last_dpcd_write_address;
+	u8 rc_result;
+	u8 dpcd_read_value;
+	u8 dpcd_write_value;
+	u8 last_rc_data[16];
+	u8 read_rc_data[16];
+	u8 last_rc_command;
+	u8 rc_commands[32];
+	u8 dsc_enable_values[8];
+	u32 last_rc_offset;
+	u32 last_rc_length;
+	unsigned int rc_data_writes;
+	unsigned int rc_data_reads;
+	unsigned int rc_command_reads;
+	unsigned int rc_result_reads;
+	unsigned int rc_command_count;
+	unsigned int downspread_reads;
+	unsigned int downspread_writes;
+	unsigned int dsc_enable_writes;
+};
+
+static ssize_t dm_test_synaptics_aux_transfer(struct drm_dp_aux *aux,
+					      struct drm_dp_aux_msg *msg)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 request;
+	u8 *buffer;
+	size_t copy_size;
+	unsigned int index;
+
+	fixture = container_of(aux, struct dm_test_synaptics_aux, aux);
+	request = msg->request & ~DP_AUX_I2C_MOT;
+	buffer = msg->buffer;
+
+	if (fixture->fail_address == msg->address)
+		return -EIO;
+
+	if (request == DP_AUX_NATIVE_WRITE) {
+		switch (msg->address) {
+		case DP_DOWNSPREAD_CTRL:
+			fixture->last_dpcd_write_address = msg->address;
+			if (msg->size)
+				fixture->dpcd_write_value = buffer[0];
+			fixture->downspread_writes++;
+			break;
+		case SYNAPTICS_RC_DATA:
+			copy_size = min_t(size_t, msg->size, sizeof(fixture->last_rc_data));
+			memset(fixture->last_rc_data, 0, sizeof(fixture->last_rc_data));
+			memcpy(fixture->last_rc_data, buffer, copy_size);
+			fixture->rc_data_writes++;
+			break;
+		case SYNAPTICS_RC_OFFSET:
+			if (msg->size >= 4)
+				fixture->last_rc_offset = buffer[0] | buffer[1] << 8 |
+							  buffer[2] << 16 | buffer[3] << 24;
+			break;
+		case SYNAPTICS_RC_LENGTH:
+			if (msg->size >= 2)
+				fixture->last_rc_length = buffer[0] | buffer[1] << 8;
+			break;
+		case SYNAPTICS_RC_COMMAND:
+			fixture->last_rc_command = buffer[0];
+			if (fixture->rc_command_count < ARRAY_SIZE(fixture->rc_commands)) {
+				fixture->rc_commands[fixture->rc_command_count] = buffer[0] & 0x7f;
+				fixture->rc_command_count++;
+			}
+			break;
+		case DP_DSC_ENABLE:
+			if (fixture->dsc_enable_writes < ARRAY_SIZE(fixture->dsc_enable_values)) {
+				fixture->dsc_enable_values[fixture->dsc_enable_writes] = buffer[0];
+				fixture->dsc_enable_writes++;
+			}
+			break;
+		}
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	}
+
+	if (request == DP_AUX_NATIVE_READ) {
+		memset(buffer, 0, msg->size);
+		switch (msg->address) {
+		case DP_DOWNSPREAD_CTRL:
+			if (msg->size)
+				buffer[0] = fixture->dpcd_read_value;
+			fixture->downspread_reads++;
+			break;
+		case SYNAPTICS_RC_COMMAND:
+			if (msg->size)
+				buffer[0] = fixture->last_rc_command & 0x7f;
+			fixture->rc_command_reads++;
+			break;
+		case SYNAPTICS_RC_RESULT:
+			if (msg->size)
+				buffer[0] = fixture->rc_result;
+			fixture->rc_result_reads++;
+			break;
+		case SYNAPTICS_RC_DATA:
+			copy_size = min_t(size_t, msg->size, sizeof(fixture->read_rc_data));
+			for (index = 0; index < copy_size; index++)
+				buffer[index] = fixture->read_rc_data[index];
+			fixture->rc_data_reads++;
+			break;
+		}
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	}
+
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+	return msg->size;
+}
+
+static struct dm_test_synaptics_aux *dm_test_alloc_synaptics_aux_with_dev(struct kunit *test,
+								 struct drm_device *drm_dev)
+{
+	struct dm_test_synaptics_aux *fixture;
+	unsigned int index;
+
+	fixture = kunit_kzalloc(test, sizeof(*fixture), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture);
+
+	for (index = 0; index < ARRAY_SIZE(fixture->read_rc_data); index++)
+		fixture->read_rc_data[index] = 0x03;
+
+	fixture->rc_result = 0;
+	fixture->aux.drm_dev = drm_dev;
+	fixture->aux.transfer = dm_test_synaptics_aux_transfer;
+	drm_dp_aux_init(&fixture->aux);
+
+	return fixture;
+}
+
+static struct dm_test_synaptics_aux *dm_test_alloc_synaptics_aux(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	return dm_test_alloc_synaptics_aux_with_dev(test, &adev->ddev);
+}
+
+static void dm_test_expect_synaptics_commands(struct kunit *test,
+					      struct dm_test_synaptics_aux *fixture,
+					      const u8 *expected_commands,
+					      unsigned int expected_count)
+{
+	unsigned int index;
+
+	KUNIT_ASSERT_EQ(test, fixture->rc_command_count, expected_count);
+
+	for (index = 0; index < expected_count; index++)
+		KUNIT_EXPECT_EQ(test, fixture->rc_commands[index], expected_commands[index]);
+}
+
+static void dm_test_setup_synaptics_stream(struct dc_stream_state *stream,
+						  struct dc_link *link)
+{
+	stream->link = link;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DP_DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+	memcpy(link->dpcd_caps.branch_dev_name, "SYNA", 4);
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_write_success - Test RC write success
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_write_success(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data[5] = { 'P', 'R', 'I', 'U', 'S' };
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+
+	KUNIT_EXPECT_TRUE(test, execute_synaptics_rc_command(&fixture->aux, true,
+							     0x01, sizeof(data), 0x123456,
+							     data));
+	KUNIT_EXPECT_EQ(test, memcmp(fixture->last_rc_data, data, sizeof(data)), 0);
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_offset, 0x123456U);
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_length, (u32)sizeof(data));
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_command, (u8)0x81);
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_reads, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->rc_result_reads, 1U);
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_read_success - Test RC read success
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_read_success(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data[4] = { 0 };
+	u8 expected[4] = { 0xa5, 0x5a, 0xc3, 0x3c };
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	memcpy(fixture->read_rc_data, expected, sizeof(expected));
+
+	KUNIT_EXPECT_TRUE(test, execute_synaptics_rc_command(&fixture->aux, false,
+							     0x31, sizeof(data), 0x220998,
+							     data));
+	KUNIT_EXPECT_EQ(test, memcmp(data, expected, sizeof(expected)), 0);
+	KUNIT_EXPECT_EQ(test, fixture->rc_data_writes, 0U);
+	KUNIT_EXPECT_EQ(test, fixture->rc_data_reads, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_offset, 0x220998U);
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_length, (u32)sizeof(data));
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_write_fail - Test RC write failure
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_write_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data = 0;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->fail_address = SYNAPTICS_RC_LENGTH;
+
+	KUNIT_EXPECT_FALSE(test, execute_synaptics_rc_command(&fixture->aux, true,
+							      0x01, sizeof(data), 0, &data));
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_count, 0U);
+}
+
+/**
+ * dm_test_apply_synaptics_fifo_reset_wa_full - Test full FIFO reset sequence
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_synaptics_fifo_reset_wa_full(struct kunit *test)
+{
+	static const u8 expected_commands[] = {
+		0x01, 0x31, 0x21, 0x31, 0x21, 0x31, 0x21,
+		0x31, 0x21, 0x31, 0x31, 0x21, 0x02,
+	};
+	struct dm_test_synaptics_aux *fixture;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+
+	apply_synaptics_fifo_reset_wa(&fixture->aux);
+
+	dm_test_expect_synaptics_commands(test, fixture, expected_commands,
+					  ARRAY_SIZE(expected_commands));
+	KUNIT_EXPECT_EQ(test, fixture->rc_result_reads, (unsigned int)ARRAY_SIZE(expected_commands));
+}
+
+/**
+ * dm_test_apply_synaptics_fifo_reset_wa_first_fail - Test FIFO reset early exit
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_synaptics_fifo_reset_wa_first_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->rc_result = 0xff;
+
+	apply_synaptics_fifo_reset_wa(&fixture->aux);
+
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_count, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->rc_commands[0], (u8)0x01);
+}
+
+static void dm_test_write_dsc_enable_synaptics(struct kunit *test,
+					       bool link_active,
+					       bool enable,
+					       bool synaptics_branch,
+					       unsigned int expected_dsc_writes,
+					       unsigned int expected_rc_commands)
+{
+	struct dm_test_synaptics_aux *fixture;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	u8 ret;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	link = dm_kunit_alloc_link(test);
+
+	dm_test_setup_synaptics_stream(stream, link);
+	link->link_status.link_active = link_active;
+	if (!synaptics_branch)
+		memcpy(link->dpcd_caps.branch_dev_name, "ABCD", 4);
+
+	ret = write_dsc_enable_synaptics_non_virtual_dpcd_mst(&fixture->aux, stream, enable);
+
+	KUNIT_EXPECT_EQ(test, ret, expected_dsc_writes ? 1 : 0);
+	KUNIT_EXPECT_EQ(test, fixture->dsc_enable_writes, expected_dsc_writes);
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_count, expected_rc_commands);
+	if (expected_dsc_writes)
+		KUNIT_EXPECT_EQ(test, fixture->dsc_enable_values[0], enable ? 1 : 0);
+}
+
+/**
+ * dm_test_write_dsc_enable_synaptics_enable_inactive - Test enable plus FIFO reset
+ * @test: The KUnit test context
+ */
+static void dm_test_write_dsc_enable_synaptics_enable_inactive(struct kunit *test)
+{
+	dm_test_write_dsc_enable_synaptics(test, false, true, true, 1, 13);
+}
+
+/**
+ * dm_test_write_dsc_enable_synaptics_enable_active - Test enable skips FIFO reset
+ * @test: The KUnit test context
+ */
+static void dm_test_write_dsc_enable_synaptics_enable_active(struct kunit *test)
+{
+	dm_test_write_dsc_enable_synaptics(test, true, true, true, 1, 0);
+}
+
+/**
+ * dm_test_write_dsc_enable_synaptics_disable_inactive - Test inactive disable writes DPCD
+ * @test: The KUnit test context
+ */
+static void dm_test_write_dsc_enable_synaptics_disable_inactive(struct kunit *test)
+{
+	dm_test_write_dsc_enable_synaptics(test, false, false, true, 1, 0);
+}
+
+/**
+ * dm_test_write_dsc_enable_synaptics_disable_active - Test active disable skips DPCD
+ * @test: The KUnit test context
+ */
+static void dm_test_write_dsc_enable_synaptics_disable_active(struct kunit *test)
+{
+	dm_test_write_dsc_enable_synaptics(test, true, false, true, 0, 0);
+}
+
+/**
+ * dm_test_write_dsc_enable_synaptics_enable_non_synaptics - Test non-Synaptics enable
+ * @test: The KUnit test context
+ */
+static void dm_test_write_dsc_enable_synaptics_enable_non_synaptics(struct kunit *test)
+{
+	dm_test_write_dsc_enable_synaptics(test, false, true, false, 1, 0);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_routes_synaptics - Test public DSC helper workaround route
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_routes_synaptics(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	link = dm_kunit_alloc_link(test);
+
+	dm_test_setup_synaptics_stream(stream, link);
+	stream->dm_stream_context = aconnector;
+	aconnector->dc_link = link;
+	aconnector->dsc_aux = &fixture->aux;
+
+	KUNIT_EXPECT_TRUE(test, dm_helpers_dp_write_dsc_enable(NULL, stream, true));
+	KUNIT_EXPECT_EQ(test, fixture->dsc_enable_writes, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->dsc_enable_values[0], (u8)1);
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_count, 13U);
+}
+
 /* Tests for dm_helpers_dp_mst_start_top_mgr() / dm_helpers_dp_mst_stop_top_mgr() */

 /**
@@ -1341,6 +1810,22 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* dm_helpers_dp_read_dpcd / dm_helpers_dp_write_dpcd */
 	KUNIT_CASE(dm_test_dp_read_dpcd_null_priv),
 	KUNIT_CASE(dm_test_dp_write_dpcd_null_priv),
+	KUNIT_CASE(dm_test_dp_read_dpcd_success),
+	KUNIT_CASE(dm_test_dp_write_dpcd_success),
+	/* dm_helpers_execute_fused_io */
+	KUNIT_CASE(dm_test_execute_fused_io_null_dmub_srv),
+	/* Synaptics RC/FIFO/DSC helpers */
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_write_success),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_read_success),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_write_fail),
+	KUNIT_CASE(dm_test_apply_synaptics_fifo_reset_wa_full),
+	KUNIT_CASE(dm_test_apply_synaptics_fifo_reset_wa_first_fail),
+	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_enable_inactive),
+	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_enable_active),
+	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_disable_inactive),
+	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_disable_active),
+	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_enable_non_synaptics),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_routes_synaptics),
 	/* dm_helpers_dp_mst_start_top_mgr / dm_helpers_dp_mst_stop_top_mgr */
 	KUNIT_CASE(dm_test_mst_start_top_mgr_null_priv),
 	KUNIT_CASE(dm_test_mst_stop_top_mgr_null_priv),
--
2.55.0

