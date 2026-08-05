Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A5FC561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7206710ED0C;
	Wed,  5 Aug 2026 06:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLyT5tzf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61C910ED0C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTdPiVjDwBN99/+E+bd0Ji4ymW6kBneNAxrE/HA1rCaDiuSi+VrfiNeTFgY0+SXrAfg1XaqJJnFiFzTRyq3R/T/5cbyAnm0rxdBfx+IijGA7Mzxz3ICzx+zpyQZoyaPLedy4n6ZA+pd132xZ8GWz74lGqTxxHJSMwBJqFiMBLakCN5Ygb1QN5Qcbyxhu9SWsr9PYdtPmKE3jlMNTBwlpBPT6kKwJt9VNmQSz6slXK2yCjirJD6RzbY9KMMSqgy6bgh0GMTfb/8D25OND2Of3ctUPK0NO6XYyXEMfLoJEyqc06rBhma2IEs6LytkH8AHMj/wNt0sdhY45znvvfunrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kDXaflWCUexrZlM13KpcwG7Q5OBfR42GtbHu3qqcd0=;
 b=sKozrXMEX9fQ6Ka9a1TSSPBaT4LCv6aq/pRZcr97L5iEGGe/ea+two949oRDk9B1rF+tutxLU1ok/IYj+XY1Uc6RDIIlOWDMgTcIlka7a1ojlMPr6AKQ14lWZ5AYZncK3IWZK+Y4uwCwr/U+v4dUIkQQQriOQyHbK/t8DU1SaT1+V7QyqgZQ+juqRSR8NA3UzF8MSDw+OvHN8ImOP8/RdjEmDW2ydqNGw8AYsSTCX8lND03zb7y55cv+wxIWejr/q85dw5Kiq6AzkYAEu+lZ/OPIoupBekhZonPIq6lMcFjXZALwoOwC8s2ZH3gpT9G0ox53H6amrwZAr3EDSHsw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kDXaflWCUexrZlM13KpcwG7Q5OBfR42GtbHu3qqcd0=;
 b=lLyT5tzfFPVU3p+50CRATQ7Lb/k6CD84vTt7LtZmKQA03W+CCBpoMpMI4f26IKNppKV/DKTOxlHAnb1HxcYR+pxsSOjTne2efQ/TjniHK6Xyna0ljNbVpZ8aQkIRmBcO0YDAVyv0TF8iX1Kilz+mvMQcpJ59p0xu2Q1uXooBTU0=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Wed, 5 Aug 2026 06:40:59 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::60) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:57 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 17/34] drm/amd/display: test stream VRR updates
Date: Wed, 5 Aug 2026 14:36:29 +0800
Message-ID: <20260805063937.2145774-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5cd572-4439-43fe-5c68-08def2bc8268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|3023799007|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6sPIY1TgcPo4rOZpqMMEy69enf/8bUTS1A74ofJXpUuAa9P07iS5BTnLEbroIrc/K69xbzE4AwfTT9iw4LPghHlARIc8uEGWdy5sHj0appsvUz14f526sIL8gG4FS/U/arYldwuoGrVfEsajFhf69qhj8RqB0muKlLA+wDpEfQRTFgz+RwleKAGpk5KrFAM/uD4rowC7/Ih8q6bg8/NUI3nsbk3HxHmiulXP5jzsYokEa1SZPrNyM8LTNLYogIDyneDC47zmpeApRiF9fzNb8lIkWJz91VL4AY2yQvhd/AL5Hb2FY5I5fIWp7MpUsJ8P/JulXtnN4YTbB8aUxoMDZXrddXMD7fMtciBivX0fu5sUMrAg3tui8kV+fDWTVCiE5zhc61cV21R2eSoxDe8v17PdEQorGSpf5b9QPEF+xo/iuIqIZ5OBeQgmWDxcDotFt5GSHgRBDBTrZtmidAVleoRVsgNXwM9ddBcq+GmDCBi62PTSTYxrBjrM7uVva33zn9YPQ4vRIBvdfIopkDabCU2NaX201DIzIbWfmXptSKRWr87BFKuQRAOrolpUl1ZHvBRWSlGdsjDv3FAAtZeXSIE2Qwv92IDR5mYZ4YbsVO8asmddQeVlkrf4x5CNzXg7sAu+lfS7sdu1hw5+9S3JJboP7TT8YlHKaPse0oBgHhHbdm0iADQHClOjWk4rtBHYrxZPGbmiECZK6IbiitNbEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QeZtE4L4yMwG+HbC8JAAvEuaa3FH4mLH7Bte5Gct7UBNVO6g+YMeD7LFxWgLho9Hbc4/3voGjI6b+SuAodhe/5+KDVo7+FlFxrPwQuI2QQAxXKTJvp87yZgi6okVcH71H/ToSNtYux906ABjwdQTX02A/K9KR2h73EJTB8zTJ2/A6dv0FL2pfCO+o0mFrhMkWkQE3yo4YF5FvInstkVorhesBnfaiWxK8M+7NUbdbyiA3pYA1yHVI0suh/q0ckAoiAKkmSgYJ/FOT6OyZPrMG0WET5jB/JKFFUcA/semPgsIz0GGg7wLxUSFB0G1sINx1VYeK2EFsRo7Edx8ib0BFFas2Eykip5Ohy3zyiGYA+jatTWJA8hrwYp+nQGVL0APkzBDYGBklu5MI80KHrTKjKtsfVuLe/BnoBK/J87zW0tvFg05JR55fGsN6Y+Q5IO3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:58.8147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5cd572-4439-43fe-5c68-08def2bc8268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
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
Add tests for amdgpu_dm_update_freesync_state_on_stream() covering
stream and timing guards, packet updates, pre-AI adjustment, and PCON
AMD VSDB packet selection.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 198 ++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 7e484adb4120..de5115faebc3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -248,6 +248,7 @@ void amdgpu_dm_update_freesync_state_on_stream(
 
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_freesync_state_on_stream);
 
 void amdgpu_dm_update_stream_irq_parameters(
 	struct amdgpu_display_manager *dm,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 0ae636dcbbe4..069c27f46a7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -416,6 +416,194 @@ static void dm_test_reset_freesync_config(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_infopacket.valid);
 }
 
+/* Tests for amdgpu_dm_update_freesync_state_on_stream() */
+
+/**
+ * dm_test_update_freesync_state_no_stream - Test a NULL stream is ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, NULL, NULL, 0);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_update_freesync_state_invalid_timing - Test zero stream timing is ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_invalid_timing(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, NULL, 0);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_update_freesync_state_default_packet - Test default packet state update
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_default_packet(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, NULL, 0);
+
+	KUNIT_EXPECT_FALSE(test, crtc_state.freesync_vrr_info_changed);
+	KUNIT_EXPECT_FALSE(test, crtc_state.vrr_infopacket.valid);
+	KUNIT_EXPECT_FALSE(test, stream->allow_freesync);
+}
+
+/**
+ * dm_test_update_freesync_state_packet_changed - Test packet changes are recorded
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_packet_changed(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dc_plane_state *surface;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	surface = kunit_kzalloc(test, sizeof(*surface), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, surface);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.vrr_infopacket.valid = true;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+	adev->family = AMDGPU_FAMILY_AI;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, surface, 0);
+
+	KUNIT_EXPECT_TRUE(test, crtc_state.freesync_vrr_info_changed);
+	KUNIT_EXPECT_FALSE(test, crtc_state.vrr_infopacket.valid);
+}
+
+/**
+ * dm_test_update_freesync_state_pre_ai_active - Test pre-AI active VRR adjustment
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_pre_ai_active(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dc_plane_state *surface;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	surface = kunit_kzalloc(test, sizeof(*surface), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, surface);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.stream = stream;
+	crtc_state.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+	adev->dm.adev = adev;
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	adev->dm.dc->current_state = dm_kunit_alloc_dc_state(test);
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, surface, 0);
+
+	KUNIT_EXPECT_FALSE(test, stream->adjust.timing_adjust_pending);
+}
+
+static void dm_test_update_freesync_state_pcon_version(struct kunit *test, u8 version)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, link);
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc_state.base.crtc = &acrtc->base;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+	stream->dm_stream_context = aconnector;
+	aconnector->as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
+	aconnector->vsdb_info.amd_vsdb_version = version;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, NULL, 0);
+
+	KUNIT_EXPECT_TRUE(test, stream->adaptive_sync_infopacket.valid);
+	KUNIT_EXPECT_EQ(test, stream->adaptive_sync_infopacket.hb2, (u8)AS_SDP_VER_1);
+}
+
+/**
+ * dm_test_update_freesync_state_pcon_v1 - Test PCON AMD VSDB version 1
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_pcon_v1(struct kunit *test)
+{
+	dm_test_update_freesync_state_pcon_version(test, 1);
+}
+
+/**
+ * dm_test_update_freesync_state_pcon_v2 - Test PCON AMD VSDB version 2
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_pcon_v2(struct kunit *test)
+{
+	dm_test_update_freesync_state_pcon_version(test, 2);
+}
+
+/**
+ * dm_test_update_freesync_state_pcon_v3 - Test PCON AMD VSDB version 3
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_pcon_v3(struct kunit *test)
+{
+	dm_test_update_freesync_state_pcon_version(test, 3);
+}
+
+/**
+ * dm_test_update_freesync_state_pcon_default - Test unknown AMD VSDB version
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_pcon_default(struct kunit *test)
+{
+	dm_test_update_freesync_state_pcon_version(test, 0);
+}
+
 static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	/* amdgpu_dm_is_timing_unchanged_for_freesync */
 	KUNIT_CASE(dm_test_timing_unchanged_null_args),
@@ -438,6 +626,16 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_freesync_config_active_fixed),
 	/* amdgpu_dm_reset_freesync_config_for_crtc */
 	KUNIT_CASE(dm_test_reset_freesync_config),
+	/* amdgpu_dm_update_freesync_state_on_stream */
+	KUNIT_CASE(dm_test_update_freesync_state_no_stream),
+	KUNIT_CASE(dm_test_update_freesync_state_invalid_timing),
+	KUNIT_CASE(dm_test_update_freesync_state_default_packet),
+	KUNIT_CASE(dm_test_update_freesync_state_packet_changed),
+	KUNIT_CASE(dm_test_update_freesync_state_pre_ai_active),
+	KUNIT_CASE(dm_test_update_freesync_state_pcon_v1),
+	KUNIT_CASE(dm_test_update_freesync_state_pcon_v2),
+	KUNIT_CASE(dm_test_update_freesync_state_pcon_v3),
+	KUNIT_CASE(dm_test_update_freesync_state_pcon_default),
 	{}
 };
 
-- 
2.43.0

