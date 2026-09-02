Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4AC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E60F10E44F;
	Wed,  2 Sep 2026 05:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dPC+qy+Q";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE8A10E44F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH+qXOYKtQiaST4PFtz2k0S68oqf4NUDBRKTB2+IgC5lc//ll2pKZkaDR0wKfTIMuIxmuj/LG3XAJIH0/qRgI3dYrALRkrlupkXqNcjC0mF4WlhAuXStSwNXr6HnhFKgQtgd49KB1DUd7Sz51/QnYVYQ8UDtFmXhvo25eNI8vFjRV9HCCdvVykKyhTeqGDOr2zN5GzRJdR4HNj7fznLusjAegZ/7Co+yxV4l014wzvoKH0ZpahJ7tPBbNXJRBeWtD4RvRhmNR+EifKOdJ4GE6WEw0gdX/2CNgurSgYHlJl7DTzZk1CY65JNF5FCjLwcbf0R2TVhuvokcm6WBgIseKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0p2iqgcLJUneOxxp9GDUE9TugdDws21ld4wYvdT4k0=;
 b=exUSz3KLrKntVPe7hDjpF7ZwhziTPJIABpJobYGfTn6LOUIiPhvN4u/1+ZgG/HhUdAV+/4fkPyU+VyMHS7pcfpMCR4GkyoKltaBDcus1RtfPmVevhbPKPY1WXRv7+IGUXH6saBAHrC9BGDUVO1h8Mg0B6NqyIgtlYP+ND6VzaiC9F3rxM7IE0RF//7qA2uSRMUqkQgrDzLtT0TV49C9ZbF04Q/toU0jtgh+u/tXWakbpO4UwYQ6yaiXV8jx8hgLq/ICCvbvaj7Hqll6EjhYh8Jxfd8nk4kY6jNFyHspLIS8LI3ZKP2JkB6y4cAbQt90bDoTkpDtsKPzxh6Pz6QyUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0p2iqgcLJUneOxxp9GDUE9TugdDws21ld4wYvdT4k0=;
 b=dPC+qy+QVN5vNGW9G2uIBgROk8FgOhebwQYW2yNueQkiXFJ1WQ0K6bacV0IuU2fY95EcswS7VRYDDF1Fsy0dsWG2/Iklb6rUs8mCl+cNGZNkggFCzxMrQTZ4vqp1fQP9Qkpajapn1YUVXZ1Ajyz6/QqbH540PLu8KII0QM4vzaw=
Received: from CH0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:33::31)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:13 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::6e) by CH0PR08CA0026.outlook.office365.com
 (2603:10b6:610:33::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:10 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:02 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 12/40] drm/amd/display: Cover dm_restore_drm_connector_state
Date: Wed, 2 Sep 2026 12:58:34 +0800
Message-ID: <20260902050411.3473916-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 440d481b-4d66-4ae9-cefb-08df08afe8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: plImKMIYRlPM2P4bvSWSFORe8DmBZyirouHItD9RrkRrPKeklUDGqhh+rirGEZkBjclpJgrgxDOye56MwYtkKkRWCwb5ty9slAiRTr5Y6TcUTq1Q12bmcRKJ1y+6q+P0cL6fFKnJpDHmeyHj44COgkJU8QGf788YhkkMj/M6Njf4abTOduNAnduBAf1DO/9WPrZNgW3lLOyPJwAxL+/7hH2qO5xm0YySya/I47bfMrSgOjRIVZIjlqpxLmkDY+nMa1RA04CnQWnW+h92d59IJRzjycdI9Hceyof7INvVnQ21N9Mgct0QDeHKtzVq1R8h9HgJMfRFv+kUYxEfNitG2Wj9A035UCzaomNDNV84RTYezsPhUQiwSdimpK6FLCfA68PF+asfjeAglShB+/GxPyrLdA2b24k0xXXEZjOU5YH8sTVgWdNvrfW8S0vTtk6qqQ4/56/YZ3I5G/hYnalfvDwX8WxFTw8hMG9nuEoYxSSTWMaAVLAis7KwAmOVwsFX5CviXccf/3himIlDOAU/AhaYL2F6JS7rC9ukTMVTfVil9ZzjCD4zR0OCeNoBB5m6/AxlQWAQZ2KkQgU9H3j7OS+2AddoEm8r0Lzp/BxqbjKTkdosuh1yh6i9ynucyVoEixN/8felX/trQSGNDMYtoVc2BZmlnUHWtz+ck0fBExnJJgFQVJRqwgnmDziKX8hHDKKKdtOfU5bHcoQ1uBz8PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y/k2MDuO6W2qiSjMZZz4rIZrckcwtc0AeaQXiQ6t7v+Km0yFThScxpHw1gDYHKVU8VCz3EeZvdgiH36UewnRMH/AwvWi0Ha+Wahl+lcDoA+4TAD5kOhJH26DFcnpXbuPfAhnGvF61kewTJ48HH1C9YkGa4q1Rp/9es+jssaMPK1o9Nw4zDovt0mMTSGb5/DkKvj1Gcgvhx5Hf8KJ2zCprRqiJa956WQbKFC/YO1Ob3Mgib6GT3pVKCgND0ZsvX0Gog5xVWyKV364uFv9e1DI+j/Bx0PB+7ijAA+ntXTM01Ff05LH5S1IBH4gN1H0NAtjRoma00Dveruir2u8s3gLALYytptxhcYsVFXsWe9FN7wLz6mYVC5+CK2k6TW2zBP//bLS0tkUGjNagjnNGXDuinF9lXizfr9ZMaPw+gt70B7GW0qpeh12wudFhtYr3M5t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:12.9747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440d481b-4d66-4ae9-cefb-08df08afe8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

[Why & How]
Add KUnit tests exercising every guard branch of
dm_restore_drm_connector_state(): the writeback short-circuit, a missing
dc_sink, a NULL connector atomic state, a NULL encoder, a crtc state
without a dc stream, and an unchanged sink that skips the forced atomic
commit.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0e71ba498e8a..1b184699e955 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3542,6 +3542,7 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 	if (acrtc_state->stream->sink != aconnector->dc_sink)
 		dm_force_atomic_commit(&aconnector->base);
 }
+EXPORT_IF_KUNIT(dm_restore_drm_connector_state);
 
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 76334fb840d6..9b3802dc6836 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5929,6 +5929,176 @@ static void dm_test_create_i2c_hw_bus(struct kunit *test)
 	kfree(i2c);
 }
 
+/**
+ * dm_test_restore_state_writeback - Test writeback connectors are skipped
+ * @test: The KUnit test context
+ *
+ * A writeback connector short-circuits before dc_sink is ever read, so leaving
+ * it NULL must not crash and no connector state is created.
+ */
+static void dm_test_restore_state_writeback(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_WRITEBACK);
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, aconnector->base.state);
+}
+
+/**
+ * dm_test_restore_state_no_dc_sink - Test a connector without a dc_sink is a no-op
+ * @test: The KUnit test context
+ *
+ * With no dc_sink there is nothing to restore, so the function returns before
+ * touching the connector state or encoder.
+ */
+static void dm_test_restore_state_no_dc_sink(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_HDMIA);
+	/* dc_sink left NULL by kzalloc. */
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, aconnector->base.state);
+}
+
+/**
+ * dm_test_restore_state_no_connector_state - Test a NULL connector state bails out
+ * @test: The KUnit test context
+ *
+ * A dc_sink is present but the connector has no atomic state, so the function
+ * returns before dereferencing the encoder.
+ */
+static void dm_test_restore_state_no_connector_state(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_HDMIA);
+	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+	/* connector->state left NULL: the guard must catch it. */
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, aconnector->base.encoder);
+}
+
+/**
+ * dm_test_restore_state_no_encoder - Test a NULL encoder bails out
+ * @test: The KUnit test context
+ *
+ * A dc_sink and connector state are present but the connector is not routed to
+ * any encoder, so the function returns before reading the encoder's crtc.
+ */
+static void dm_test_restore_state_no_encoder(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_HDMIA);
+	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+	aconnector->base.funcs->reset(&aconnector->base);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->base.state);
+	/* connector->encoder left NULL. */
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, aconnector->base.encoder);
+}
+
+/**
+ * dm_test_restore_state_no_stream - Test a crtc without a stream bails out
+ * @test: The KUnit test context
+ *
+ * The connector is routed to an encoder and crtc, but the crtc state carries no
+ * dc stream, so the function returns before comparing sinks.
+ */
+static void dm_test_restore_state_no_stream(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_crtc_state *acrtc_state;
+	struct drm_encoder *enc;
+	struct drm_crtc *crtc;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_HDMIA);
+	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+	aconnector->base.funcs->reset(&aconnector->base);
+
+	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, enc);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	acrtc_state = kunit_kzalloc(test, sizeof(*acrtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc_state);
+
+	crtc->state = &acrtc_state->base;
+	enc->crtc = crtc;
+	aconnector->base.encoder = enc;
+	/* acrtc_state->stream left NULL. */
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, acrtc_state->stream);
+}
+
+/**
+ * dm_test_restore_state_same_sink - Test an unchanged sink skips the commit
+ * @test: The KUnit test context
+ *
+ * When the streamed sink already matches the connector's dc_sink there is
+ * nothing to restore, so the forced atomic commit is not issued.
+ */
+static void dm_test_restore_state_same_sink(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_crtc_state *acrtc_state;
+	struct dc_stream_state *stream;
+	struct drm_encoder *enc;
+	struct drm_crtc *crtc;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_HDMIA);
+	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+	aconnector->base.funcs->reset(&aconnector->base);
+
+	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, enc);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	acrtc_state = kunit_kzalloc(test, sizeof(*acrtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc_state);
+	stream = dm_kunit_alloc_stream(test, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	/* Same sink as the connector: the final branch is not taken. */
+	stream->sink = aconnector->dc_sink;
+	acrtc_state->stream = stream;
+	crtc->state = &acrtc_state->base;
+	enc->crtc = crtc;
+	aconnector->base.encoder = enc;
+
+	dm_restore_drm_connector_state(drm, &aconnector->base);
+
+	KUNIT_EXPECT_PTR_EQ(test, stream->sink, aconnector->dc_sink);
+}
+
 /**
  * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
  * @test: The KUnit test context
@@ -8685,6 +8855,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_create_i2c */
 	KUNIT_CASE(dm_test_create_i2c_oem),
 	KUNIT_CASE(dm_test_create_i2c_hw_bus),
+	/* dm_restore_drm_connector_state */
+	KUNIT_CASE(dm_test_restore_state_writeback),
+	KUNIT_CASE(dm_test_restore_state_no_dc_sink),
+	KUNIT_CASE(dm_test_restore_state_no_connector_state),
+	KUNIT_CASE(dm_test_restore_state_no_encoder),
+	KUNIT_CASE(dm_test_restore_state_no_stream),
+	KUNIT_CASE(dm_test_restore_state_same_sink),
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-- 
2.43.0

