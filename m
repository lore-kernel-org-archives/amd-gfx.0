Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A89DC44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D4D10F6D6;
	Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzhkJYtc";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E606310F6D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIW3EfpjfUhxSv9QXrH4bXls6vcM24V6Onf8TlpOMD3XmH/m+cDb+ADtEhMEFvFhN5zNyGSya2Tm7AvfgCTLzww5J0HJJtNuLhZMss0c3++FOBxvMzwW05/WlLg90Y02cRbLQimkJk3VZh3hC+kwhxUNT3rz0x6JwSuALRgtFcWNn/hqWWYpjag1d5wOUpzu3ZNcGmSVoXe1H9KYFMiXsEoIBK5fz4byQxGq0pwA+BhgT3twJ0P99z74XRg2NMRsA7xPv1bcTm0ab/EwJF0+ts4ZjYFvW/4Okr/GR9SJ3SShOs0dqNVhfma+FQeI4+FluOPPeHZ6SzXgK1+ZOai8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTLQ9oO7Q4WsmhmuEaDaHSLrf3pjjtgBfqfZWyUbR7Y=;
 b=rOxVkSBTSY2/9a3RyQgOgeY9GcSiswAgRb3JOKAZQIfvTPs6aWBNtt8/e0SLivTR1KYMYKFIHornYcwfJQbYqt8WFzOADkwDUesuw+8GxDZVS4/y3TRP06JI0Z5pfM5+jiBugmlQJNRyeM+c6E7j5tu8fJDwNDniq6JEQ6Zyc/pun4TaXf/SE3/HFbmO07tqqM1Mlr+5G2MhIdP+kH4H+lYEn6W4Qy+u1twpl0krLJAugU0VvfSfq6loE0sC+ultGAZIK1aJTAZU2bNw6O7Ye2TJGGlRiNhzcr9NwghaVuLlfU8GovD9uSopIRXa1hyxisW3Mb7mPmkX1ILySJ8EZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTLQ9oO7Q4WsmhmuEaDaHSLrf3pjjtgBfqfZWyUbR7Y=;
 b=wzhkJYtc+8KvyX2ECNJojyGp8wA5m1sa89a1JYVdKtazoJCttGhDGQbIyDglB+9TJ57JTmo41cZa5lstAxQYOjzrswdJpNaH6n8gYA7Rnvy3rmxXZdewOFzbIDIWhQjMlmr5m62AbTK5qHu3d68q49MTcEBesIiV8mwugUZNZRk=
Received: from MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17) by
 PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:19 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::8f) by MN2PR01CA0048.outlook.office365.com
 (2603:10b6:208:23f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 9
 Jul 2026 21:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:18 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:57 -0500
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
Subject: [PATCH 28/80] drm/amd/display: Test MCCS FreeSync VCP helpers
Date: Thu, 9 Jul 2026 16:47:56 -0400
Message-ID: <20260709205936.5719-29-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed67840-d62c-497a-5710-08deddfd5ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P3Pw8rWESpeF4FKu2VKjEv7lKHbZ6r6hDaw2XoKqGqHn7UD7pQZGA41ykAVRiix+KcsgkSLVHgijuG2XepC9gdHYg8+5WajOHerUGowEsKzqX7eL5UQWuoD2/z+3iNFrCOpGe5vixLJ0yA+0XZiz+1khiHgZoszkmIVJ55TtTjFIjcDflUBdayVqDAXIOfF2g5QvCVJLJ4NrzUHsNrt3uiV5986ytSW3SYxl8HD3Rh/OsYbMs0hiJo503MIT2uWC6EuGcLiNh0IMddSvTOZYT1acDDviFBTfA1WHcHCJh1el6OM7cE8dyy9dO9myyOggtC9Zat3u35AdHkt+c1M5tG4neVx+E/6aprqaQ2G9wW1VYHbY70eJF12PKpskCVgZLQylDKXnKKvHXXpnFq+H1OQoKJxOKOtRLz6F0OUtIBBIQJZtf14D6r5XhLHYeVGY1vSt9FobG9CZxnTBSFdWeQXoThDLl7q6Pab4RWk/kcq/zvhsIxNPMr0jpoggy13tlMx2jTxyeexF7AgDN13vxIhQ+kMXNGWc+lSjWHMlTEe/6Q3A+c76+MRfysM5JhYYfMWdWKXMOS7KyxK6WdA7GZJHEhl/4s33v5K3pqwe2D6/leoZ+A44aR7RYVSbQ93DsOeBWNjD3WvaEx7BAXn6VBJVRNAvUFGR+N9GvSvLFRhRKr5+3Pen3KPsHgAyPKCrJ1/cXAyc0tu+Kb+PAOGU0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sfO8VCzjF6TlIoZpb4h0iTO1mnbYth0IsL77IJ7ejrHCsTT5+O5wcNWUjEfp7alr5MLsxu6ikHoukYqvZzvH6rDxvFb2h+IEEn/xIw7iy8pKnOJ3JVgNDHYzCcrtJkFWph3AUmMMywEI0eXAo5NwczB7UPU4YNQhKAotlfOxapG3uzeN7snZoLJuEhIqNtZE08DzFCHd/XRz//Gut+0boa/dr6QMMNr8Ma36MXizU2Ym1CxqP3sS/mIauVtfgTrf1jo+k1VlIQc6FHUdDYJlxEGGpRUVYI2gLPwqn6YffQUqw5uv7+jTTaAqoR/mBuG7CMUEmBzj6sQXvtS874S5XfCqRIh/16swEZM6ce4MDSZMj54+PNw+M5XJ7jhJoZxAFoxTu3Gwc5gsB6MtWRAAEmngtZDbVt6/cfNwi+6YkctIIQWSvuRhMoblS+uymrfs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:18.6054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed67840-d62c-497a-5710-08deddfd5ccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
Add KUnit coverage for dm_helpers_read_mccs_caps and
dm_helpers_mccs_vcp_set, including the DP/HDMI/legacy-PCON selection,
the i2c VCP request and set packets and the retry-failure paths.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 419 ++++++++++++++++++
 2 files changed, 421 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 04e3c34b9e50..48ed6d8d9580 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1800,6 +1800,7 @@ void dm_helpers_read_mccs_caps(struct dc_context *ctx, struct dc_link *link,
 		}
 	}
 }
+EXPORT_IF_KUNIT(dm_helpers_read_mccs_caps);

 static int mccs_operation_vcp_set(unsigned int vcp_code, struct dc_link *link, uint16_t value)
 {
@@ -1874,4 +1875,5 @@ void dm_helpers_mccs_vcp_set(struct dc_context *ctx, struct dc_link *link,
 		drm_dbg_driver(dev, "%s: Failed to set VCP code %d", __func__,
 				sink->edid_caps.freesync_vcp_code);
 }
+EXPORT_IF_KUNIT(dm_helpers_mccs_vcp_set);

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 29feb8c3940b..bde697092032 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2110,6 +2110,83 @@ static const struct i2c_algorithm dm_test_i2c_algorithm = {
 	.master_xfer = dm_test_i2c_master_xfer,
 };

+struct dm_test_mccs_i2c_adapter {
+	struct i2c_adapter base;
+	u8 write_data[16];
+	u8 read_reply[11];
+	int write_ret;
+	int read_ret;
+	unsigned int write_len;
+	unsigned int writes;
+	unsigned int reads;
+};
+
+static int dm_test_mccs_i2c_master_xfer(struct i2c_adapter *adapter,
+						struct i2c_msg *msgs,
+						int num)
+{
+	struct dm_test_mccs_i2c_adapter *fake;
+	struct i2c_msg *msg = msgs;
+	size_t copy_len;
+
+	fake = container_of(adapter, struct dm_test_mccs_i2c_adapter, base);
+
+	if (num != 1)
+		return 0;
+
+	if (msg->flags & I2C_M_RD) {
+		fake->reads++;
+		if (fake->read_ret != 1)
+			return fake->read_ret;
+
+		copy_len = min_t(size_t, msg->len, sizeof(fake->read_reply));
+		memcpy(msg->buf, fake->read_reply, copy_len);
+		return 1;
+	}
+
+	fake->writes++;
+	if (fake->write_ret != 1)
+		return fake->write_ret;
+
+	copy_len = min_t(size_t, msg->len, sizeof(fake->write_data));
+	memcpy(fake->write_data, msg->buf, copy_len);
+	fake->write_len = copy_len;
+
+	return 1;
+}
+
+static const struct i2c_algorithm dm_test_mccs_i2c_algorithm = {
+	.master_xfer = dm_test_mccs_i2c_master_xfer,
+};
+
+static struct dm_test_mccs_i2c_adapter *dm_test_alloc_mccs_i2c(struct kunit *test)
+{
+	struct dm_test_mccs_i2c_adapter *fake;
+
+	fake = kunit_kzalloc(test, sizeof(*fake), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fake);
+
+	fake->base.algo = &dm_test_mccs_i2c_algorithm;
+	fake->base.lock_ops = &dm_test_i2c_lock_ops;
+	fake->write_ret = 1;
+	fake->read_ret = 1;
+	rt_mutex_init(&fake->base.bus_lock);
+	rt_mutex_init(&fake->base.mux_lock);
+
+	return fake;
+}
+
+static u8 dm_test_mccs_checksum(const u8 *data, unsigned int len)
+{
+	u8 checksum = 0x6e;
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		checksum ^= data[i];
+
+	return checksum;
+}
+
 static void dm_test_submit_i2c_transfer(struct kunit *test,
 					bool full_transfer)
 {
@@ -2531,6 +2608,334 @@ static void dm_test_enable_periodic_detection_schedules_work(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, idle_work->ran);
 }

+/* Tests for dm_helpers_read_mccs_caps() */
+
+/**
+ * dm_test_read_mccs_caps_null_ctx - Test early return with NULL context
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_null_ctx(struct kunit *test)
+{
+	/* NULL ctx → early return, no crash */
+	dm_helpers_read_mccs_caps(NULL, NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_read_mccs_caps_null_link - Test early return with NULL link
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_null_link(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_sink *sink;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->driver_context = adev;
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	/* link is NULL → drm_dbg_driver + return */
+	dm_helpers_read_mccs_caps(ctx, NULL, sink);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_read_mccs_caps_no_vcp_code - Test no-vcp-code path clears freesync support
+ * @test: The KUnit test context
+ *
+ * With freesync_vcp_code == 0 the i2c/MCCS path is skipped entirely and the
+ * function only clears sink->mccs_caps.freesync_supported.
+ */
+static void dm_test_read_mccs_caps_no_vcp_code(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc_sink *sink;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->driver_context = adev;
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	sink->edid_caps.freesync_vcp_code = 0;
+	sink->mccs_caps.freesync_supported = true; /* should be cleared */
+
+	dm_helpers_read_mccs_caps(ctx, link, sink);
+
+	KUNIT_EXPECT_FALSE(test, sink->mccs_caps.freesync_supported);
+}
+
+/*
+ * Allocate and wire the adev/ctx/link/sink/connector/i2c objects shared by the
+ * MCCS read/set tests so each test only configures the fields it exercises.
+ */
+struct dm_test_mccs_fixture {
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc_sink *sink;
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_test_mccs_i2c_adapter *fake;
+};
+
+static struct dm_test_mccs_fixture dm_test_alloc_mccs_fixture(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture;
+
+	fixture.adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.adev);
+	fixture.ctx = kunit_kzalloc(test, sizeof(*fixture.ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.ctx);
+	fixture.link = kunit_kzalloc(test, sizeof(*fixture.link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.link);
+	fixture.sink = kunit_kzalloc(test, sizeof(*fixture.sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.sink);
+	fixture.aconnector = kunit_kzalloc(test, sizeof(*fixture.aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.aconnector);
+	fixture.fake = dm_test_alloc_mccs_i2c(test);
+
+	fixture.ctx->driver_context = fixture.adev;
+	fixture.aconnector->i2c = (struct amdgpu_i2c_adapter *)fixture.fake;
+	fixture.link->priv = fixture.aconnector;
+
+	return fixture;
+}
+
+/**
+ * dm_test_read_mccs_caps_i2c_vcp_request - Test MCCS VCP request packet
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_i2c_vcp_request(struct kunit *test)
+{
+	static const u8 expected_prefix[] = { 0x51, 0x82, 0x01, 0xe3 };
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	link->dpcd_caps.dpcd_rev.raw = DP_DPCD_REV_14;
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_0060AD;
+	link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+	fake->read_reply[1] = 0x82;
+	fake->read_reply[9] = 0x01;
+
+	dm_helpers_read_mccs_caps(ctx, link, sink);
+
+	KUNIT_EXPECT_TRUE(test, sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_EQ(test, fake->writes, 1U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 1U);
+	KUNIT_EXPECT_EQ(test, fake->write_len, (unsigned int)sizeof(expected_prefix) + 1);
+	KUNIT_EXPECT_EQ(test, memcmp(fake->write_data, expected_prefix,
+					     sizeof(expected_prefix)), 0);
+	KUNIT_EXPECT_EQ(test, fake->write_data[4],
+			dm_test_mccs_checksum(expected_prefix, sizeof(expected_prefix)));
+}
+
+/**
+ * dm_test_read_mccs_caps_hdmi_vcp_request - Test local HDMI MCCS path
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_hdmi_vcp_request(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+	fake->read_reply[1] = 0x82;
+	fake->read_reply[9] = 0x01;
+
+	dm_helpers_read_mccs_caps(ctx, link, sink);
+
+	KUNIT_EXPECT_TRUE(test, sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_EQ(test, fake->writes, 1U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 1U);
+}
+
+/**
+ * dm_test_read_mccs_caps_legacy_pcon_vcp_request - Test legacy PCON path
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_legacy_pcon_vcp_request(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_CONVERTER;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+	fake->read_reply[1] = 0x82;
+	fake->read_reply[9] = 0x01;
+
+	dm_helpers_read_mccs_caps(ctx, link, sink);
+
+	KUNIT_EXPECT_TRUE(test, sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_EQ(test, fake->writes, 1U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 1U);
+}
+
+/**
+ * dm_test_read_mccs_caps_i2c_failure - Test VCP request retry failure
+ * @test: The KUnit test context
+ */
+static void dm_test_read_mccs_caps_i2c_failure(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	fixture.aconnector->base.dev = &fixture.adev->ddev;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	link->dpcd_caps.dpcd_rev.raw = DP_DPCD_REV_14;
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_0060AD;
+	link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+	fake->write_ret = 0;
+
+	dm_helpers_read_mccs_caps(ctx, link, sink);
+
+	KUNIT_EXPECT_FALSE(test, sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_EQ(test, fake->writes, 5U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
+}
+
+/* Tests for dm_helpers_mccs_vcp_set() */
+
+/**
+ * dm_test_mccs_vcp_set_null_ctx - Test early return with NULL context
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_null_ctx(struct kunit *test)
+{
+	/* NULL ctx → early return, no crash */
+	dm_helpers_mccs_vcp_set(NULL, NULL, NULL);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mccs_vcp_set_not_supported - Test early return when freesync unsupported
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_not_supported(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc_sink *sink;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->driver_context = adev;
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	sink->mccs_caps.freesync_supported = false;
+
+	/* freesync not supported → early return without i2c */
+	dm_helpers_mccs_vcp_set(ctx, link, sink);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mccs_vcp_set_null_link - Test early return with NULL link
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_null_link(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_sink *sink;
+
+	adev = dm_kunit_alloc_adev(test);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	ctx->driver_context = adev;
+	dm_helpers_mccs_vcp_set(ctx, NULL, sink);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/**
+ * dm_test_mccs_vcp_set_i2c_packet - Test MCCS VCP set packet
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_i2c_packet(struct kunit *test)
+{
+	static const u8 expected_prefix[] = {
+		0x51, 0x84, 0x03, 0xe3, 0x01, 0x01,
+	};
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	sink->mccs_caps.freesync_supported = true;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+
+	dm_helpers_mccs_vcp_set(ctx, link, sink);
+
+	KUNIT_EXPECT_EQ(test, fake->writes, 1U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
+	KUNIT_EXPECT_EQ(test, fake->write_len, (unsigned int)sizeof(expected_prefix) + 1);
+	KUNIT_EXPECT_EQ(test, memcmp(fake->write_data, expected_prefix,
+					     sizeof(expected_prefix)), 0);
+	KUNIT_EXPECT_EQ(test, fake->write_data[6],
+			dm_test_mccs_checksum(expected_prefix, sizeof(expected_prefix)));
+}
+
+/**
+ * dm_test_mccs_vcp_set_i2c_failure - Test VCP set retry failure path
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_i2c_failure(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+	struct dm_test_mccs_i2c_adapter *fake = fixture.fake;
+	struct dc_context *ctx = fixture.ctx;
+	struct dc_link *link = fixture.link;
+	struct dc_sink *sink = fixture.sink;
+
+	sink->mccs_caps.freesync_supported = true;
+	sink->edid_caps.freesync_vcp_code = 0xe3;
+	fake->write_ret = 0;
+
+	dm_helpers_mccs_vcp_set(ctx, link, sink);
+
+	KUNIT_EXPECT_EQ(test, fake->writes, 5U);
+	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -2668,6 +3073,20 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_enable_periodic_detection_no_workqueue),
 	KUNIT_CASE(dm_test_enable_periodic_detection_updates_enable),
 	KUNIT_CASE(dm_test_enable_periodic_detection_schedules_work),
+	/* dm_helpers_read_mccs_caps */
+	KUNIT_CASE(dm_test_read_mccs_caps_null_ctx),
+	KUNIT_CASE(dm_test_read_mccs_caps_null_link),
+	KUNIT_CASE(dm_test_read_mccs_caps_no_vcp_code),
+	KUNIT_CASE(dm_test_read_mccs_caps_i2c_vcp_request),
+	KUNIT_CASE(dm_test_read_mccs_caps_hdmi_vcp_request),
+	KUNIT_CASE(dm_test_read_mccs_caps_legacy_pcon_vcp_request),
+	KUNIT_CASE(dm_test_read_mccs_caps_i2c_failure),
+	/* dm_helpers_mccs_vcp_set */
+	KUNIT_CASE(dm_test_mccs_vcp_set_null_ctx),
+	KUNIT_CASE(dm_test_mccs_vcp_set_not_supported),
+	KUNIT_CASE(dm_test_mccs_vcp_set_null_link),
+	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_packet),
+	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_failure),
 	{}
 };

--
2.55.0

