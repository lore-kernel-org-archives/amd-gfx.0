Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA7C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5609A10F421;
	Fri, 31 Jul 2026 21:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvDTfSXf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C9510E24B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdetQxPZLZcV3ZjHdGYFn7KlavZwOIADZ7vkGtimGs0McwXp87erg6IobWOCdqHCi7SE6KeJIK565fgZmYeEcI3FDZcK5bl4riYqigO12SXj1KMQwGMAlUl9KXnHzPgWgz5MiYnKI4fYI20ku/vqgV6ZGPBKXBKzG1gzbXlfCYD0l7+9fxzkL/gCueVZ8IxYv8fJEAN2m0+LeTZF8jNaZ5rzmLTiRdzKECD3FS1PS4o1iKeA6NU8IWi+WBFkPJhRyNybO1pbCiYLBK4nC0+zYDebbHDY+B9b/ly3suRxyIVpzbvGkvOhuZpE39pRyYdPF+o1lxW18NQPvcB2a2h8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wymVz7Pcm0elJi1pGReyO1JE/AF+M7u0MNARrp4XDhQ=;
 b=BJjWy8h2N/RFWpv3oMbUAQbPPa7v3a3fujhnqZeNVsB53Fyoq9G5YpZo5mBtyY4hnaoT4E4SPU913oldmrl/Eg6uEKoo7DBP36j5xhHp9OlkfR2KmilgW1gNWoNYghNJ2+FpsE8BeSWNbCOLJbDcnliY71lYEhbm5vVLsHxOy9HzrrvuLhLWPBe4kRO6DlqXdE1UZe/Cu+1WxgQNk0mw0Sq4vHEHn5zA1E+I/DuDzbbOScJsXInOPVBQbogc5oii4x/z1rZa+tOmPVDSJrBDbekS6FAOj16juNCXGV/27sNN9nbReYwFJ4JctPrgWw8z1Xufvw4zS6ST99Z4bBRBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wymVz7Pcm0elJi1pGReyO1JE/AF+M7u0MNARrp4XDhQ=;
 b=ZvDTfSXfOCwIwKz8VsDgeDgax9cDxiY08CyTKoJq2YSZxaSeIPjcKRFAkwEQhBGMAD4izT3dy6DjBBFpJj0HHVXX43ZbtuLGoaYn/X1LolTeMwdh76z4bBwlxpVnFanyjFL9t3+GbK9RPBY/5h8FU8nyyXKxpFSNF4UqFPU1xzg=
Received: from CH0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:32::16)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:46 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::76) by CH0PR07CA0011.outlook.office365.com
 (2603:10b6:610:32::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:15:45 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:44 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 17/41] drm/amd/display: Add active plane count tests for crtc
Date: Fri, 31 Jul 2026 17:12:38 -0400
Message-ID: <20260731211302.3040343-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fadb47-226c-42a4-ec37-08deef48e33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|11063799006|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: FUQtL50GyqnyCu2I1HNsCkEEwanJQJS9PdtWBIdWMg9hzqMN0n7oSjLeLMTCQApyroTJ7Mt20ExK0o0ThHjLXPZexhBfZEL4Oe2qc4i7yj5lJ4VLqiXUxROg9OaQWFkDivhxTMpFb00OgEvVc7sc51ctQ5KZ4gfk8OEEvtRcaeIRltPKq7ZzCdLiPtf2a8aTAjyjlYtBdD6E0aFFxRXfKjirXmspLTUyk1bJHVHgrCe01Iehs2F89dlMwD7uDPNHiZa+gBc0mblKa6DyPi3Xz88OIu2keAOxidzyas/8fpO6J8lAsy0CpCo7dA0cvJSu/joZdxBSITFcRAlS+4jJZAcmJxh4eNCkCnnI2dvccA07DfWoh/+3YdHIl1Vy+JnUtpWucUS5uENux6/v0zOR1tkMDxj3tka7TDgdHFxWD+PHy7J6pbX7RwP8BGQW8FdRszRtC0TrZNA5y/RRs9sbCqDAf9j221zjIXm+gG0miaZIX8e1Qp4S5EZGbkglyFDKJJc/KRFmXnADwa4C/NxVxO7q0yhFZUhJ17/ufGmNzwPi+Zhua1OrpJaWXm/AKaRaZc0hitwWyMBDRIXHojHcADK2qeTx4HqrBbitO7g1oaT8y6d/oc7Y3RECnHVOO9rFijE/eTS1QSUate0EKsqrU1DgQ9OcbKDRs7L+mf6FgzxB0hmH3yE8aZLcQu0L/gAUoNQk2DyyL7tA8ya7JFWRAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uvmp58xLjzWvM9ScRoxPZy0f2mU9AEqukTZNFgeK2dYdSOh2qyQsiXQe7FUAduLY2+DLQ4Remr6+Z1lMYmclw/O/56mg1aK4F5Wybzg/1qBUVHsgdbBg6akMu3L/SWTL82Rd0bjUuCIfkeIVE+vAhnLdxEqmxnCUbCwbAGdkOz8HyveReVbpVF5nQxrxDgnmeqwIF8xSktw80xeBv2USZXd7L5VprpL7JyUNB61UpxMH7JuXC8AFxJb8MqbRGzedAV7x2sXnawXyxZLWHcLprk9z6rgPHgWeu6e1knVC86GOLQnziTOcOWURihH0Qn0GNWG+k+C7gUpM86F3iZDxL3DG6fsIYb/yx8/vxqAcrs7A4LAa+o/zmx9WRP8cZjIjcWnT9vMAfgnI53k7y7kHo62ouzvrnOGdLwh8XzKMdlCDxtxCnr+ObxwpK3zdayjT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:46.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fadb47-226c-42a4-ec37-08deef48e33f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

Expose amdgpu_dm_crtc_count_crtc_active_planes() for KUnit and add tests
covering the empty plane list and the mixed case exercising the mask
filter, cursor skip, missing plane state, and framebuffer presence
branches.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 115 ++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index fd816be907c4..82a30097072e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -587,7 +587,7 @@ static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
 {
 }
 
-static int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 {
 	struct drm_atomic_commit *state = new_crtc_state->state;
 	struct drm_plane *plane;
@@ -618,6 +618,7 @@ static int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_cr
 
 	return num_active;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_count_crtc_active_planes);
 
 STATIC_IFN_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 						     struct drm_crtc_state *new_crtc_state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index d1e2cb4efc54..93c6d0d8d7fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -50,6 +50,7 @@ void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state);
 struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
+int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index f5d9424171e8..9948d1780454 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -706,6 +706,118 @@ static void dm_test_crtc_update_active_planes_no_stream(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_state->active_planes, 0);
 }
 
+/* Tests for amdgpu_dm_crtc_count_crtc_active_planes() */
+
+static void dm_test_add_plane(struct drm_device *dev, struct drm_plane *plane,
+			      unsigned int index, enum drm_plane_type type)
+{
+	INIT_LIST_HEAD(&plane->head);
+	plane->index = index;
+	plane->type = type;
+	list_add_tail(&plane->head, &dev->mode_config.plane_list);
+}
+
+/**
+ * dm_test_count_crtc_active_planes_none - Test empty plane list counts zero
+ * @test: The KUnit test context
+ *
+ * With no planes attached to the CRTC the active plane count must be zero.
+ */
+static void dm_test_count_crtc_active_planes_none(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_device *dev;
+
+	dev = dm_kunit_alloc_drm_with_connector_list(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	INIT_LIST_HEAD(&dev->mode_config.plane_list);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = dev;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	crtc_state->state = state;
+	crtc_state->plane_mask = 0;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_count_crtc_active_planes(crtc_state), 0);
+}
+
+/**
+ * dm_test_count_crtc_active_planes_mixed - Test counting across all plane cases
+ * @test: The KUnit test context
+ *
+ * Exercises every branch of the counting loop: a plane excluded by the mask,
+ * a cursor plane (skipped), a masked plane with no new state (counted), a
+ * masked plane with a framebuffer (counted) and a masked plane without a
+ * framebuffer (not counted). Only two planes should be reported active.
+ */
+static void dm_test_count_crtc_active_planes_mixed(struct kunit *test)
+{
+	struct drm_plane *plane_no_state;
+	struct drm_plane *plane_cursor;
+	struct drm_plane *plane_with_fb;
+	struct drm_plane *plane_no_fb;
+	struct drm_plane *plane_excluded;
+	struct drm_plane_state *ps_fb;
+	struct drm_plane_state *ps_no_fb;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_framebuffer *fb;
+	struct drm_device *dev;
+
+	dev = dm_kunit_alloc_drm_with_connector_list(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	INIT_LIST_HEAD(&dev->mode_config.plane_list);
+
+	plane_no_state = kunit_kzalloc(test, sizeof(*plane_no_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_no_state);
+	plane_cursor = kunit_kzalloc(test, sizeof(*plane_cursor), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cursor);
+	plane_with_fb = kunit_kzalloc(test, sizeof(*plane_with_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_with_fb);
+	plane_no_fb = kunit_kzalloc(test, sizeof(*plane_no_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_no_fb);
+	plane_excluded = kunit_kzalloc(test, sizeof(*plane_excluded), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_excluded);
+
+	dm_test_add_plane(dev, plane_no_state, 0, DRM_PLANE_TYPE_PRIMARY);
+	dm_test_add_plane(dev, plane_cursor, 1, DRM_PLANE_TYPE_CURSOR);
+	dm_test_add_plane(dev, plane_with_fb, 2, DRM_PLANE_TYPE_PRIMARY);
+	dm_test_add_plane(dev, plane_no_fb, 3, DRM_PLANE_TYPE_PRIMARY);
+	dm_test_add_plane(dev, plane_excluded, 4, DRM_PLANE_TYPE_PRIMARY);
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb);
+	ps_fb = kunit_kzalloc(test, sizeof(*ps_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ps_fb);
+	ps_fb->fb = fb;
+	ps_no_fb = kunit_kzalloc(test, sizeof(*ps_no_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ps_no_fb);
+	ps_no_fb->fb = NULL;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = dev;
+	state->planes = kunit_kzalloc(test, sizeof(*state->planes) * 5, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->planes);
+	state->planes[0].new_state = NULL;
+	state->planes[1].new_state = ps_fb;
+	state->planes[2].new_state = ps_fb;
+	state->planes[3].new_state = ps_no_fb;
+	state->planes[4].new_state = ps_fb;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	crtc_state->state = state;
+	/* Exclude plane index 4 from the CRTC. */
+	crtc_state->plane_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_count_crtc_active_planes(crtc_state), 2);
+}
+
 /* Tests for amdgpu_dm_crtc_duplicate_state() */
 
 /**
@@ -1044,6 +1156,9 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_rejects_unconfigured),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
+	/* amdgpu_dm_crtc_count_crtc_active_planes */
+	KUNIT_CASE(dm_test_count_crtc_active_planes_none),
+	KUNIT_CASE(dm_test_count_crtc_active_planes_mixed),
 	/* amdgpu_dm_crtc_duplicate_state */
 	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
 	/* amdgpu_dm_crtc_reset_state */
-- 
2.34.1

