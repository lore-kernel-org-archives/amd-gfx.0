Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22AC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797D110ED0D;
	Wed,  5 Aug 2026 06:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5bPVAwx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CF010ED0D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1J/mJnEU3mHZkx6C1sCkhf+DhkrYpQjG76fzJ4UlYQF2xbSsd0+EOf5MFSUXgUcJsLiNCes27LBljYBaCZqvVlv1SnOpkA7aDwtSjfWmrPH2DnS3reaNcvcmbRN9gHMoEMuwv5r+VhNGRglzZGyWGmQrzZvie26iTNuEiulw/EYGyFpKzKIJPKMCJ648Gz4mDHd96luK/cWqkqnJlql6csz30IAbOZY6twk3GeDt80HErlz96TZniessDhVTy9kMZ/gbP0alKBE22EO0F2Rs3AJo/fdWjv+DfosWkMcWxZo3fu2wrQqKSa6y5lEkjatc9XsxIswdg3AqXM9N9Fqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXf4MMH1LS6BuXCRnYJ3rNz08fL9gJQSKlCLnPN0mQA=;
 b=SNyQ1lXLw1cDcRbPcyYA6xArDJVQOwoc0opJg8fs9eWN4TOQJ/cOE9U9M7r2G5Vwo5YXOgPVdxNiNAHP5m9Z079SaeksMxSJixFORAdYqA6qUsdGCeG6i7YW80azCSIQ9KVYPlYmEMvmYvdICwT5bqH0SiV/3Bt2o8sqmQs4Xd5dHNXRpJ9lAj2S5JFb49B3Jp4THRjdJnDC5S3uoV6IsArBDhvPVGHJyOhpOZronZUauFhjzQ04/ULsEJvSFBm4rL9JhjWODMFP8/rdIeRB3y3wkfPF1cXPaJcb7wZGLYV+xMTXhwvvpT5cZWUSHrXIpCQwrhpzb08DFZ55sE+zqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXf4MMH1LS6BuXCRnYJ3rNz08fL9gJQSKlCLnPN0mQA=;
 b=C5bPVAwxbSwIxLqbVG8+06Nn4owjx0cNW4vgMUhiCch51IW0ghdmYSoP4KVc4kE/yss8p/yzOeUKQZM2p8QHezFhEqKf1UZLxLetbJoiblWpxc1gNgCH/a5Kj7QfsHGJQ3Z+CvXLKksp4r+L+V9N15JY4xFb2OIOAPYPltvQ178=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 06:41:01 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::6e) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 23:41:01 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 18/34] drm/amd/display: test VRR IRQ parameters
Date: Wed, 5 Aug 2026 14:36:30 +0800
Message-ID: <20260805063937.2145774-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1166b287-fe52-4e71-a060-08def2bc8430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: fOPnLJhiI68GUSgdwZo7JrG7yeeKKO4vJNte7TJrRV4y1Y3uVdqTE9DVnxanbYJh/6L9taN1fGyxeH+whVxsyTzHVz27YEcW2JU9F8upmvy4TCCfZzivgjmkzMGA70Hg7AawgTIedgdflBcLVxgPUusYZupzRZ7VH6GOZCvg2/93tmHMUk2TcW1jRzO2H29Asjy2JNHJ0kr5/i3qZZZMbuiZR7BPEa8JckC2RbVHQMYYbCNUMCFeIYuEagB15MnjkEIeg5/uysy3ggNgt+Zma/tLdhA7h5ZgeqYfJheQ0rAu1ZOwg3AzwORPe+xWapXrpvWKJOj9d1zWpY+Ir/arJ0fDOXi5PrDBfQwWbM6ViaMWxMKki/G6Hp++pp3RG0/R4mPwWNHGYvHPwk9HCvgTUmlBj9NOOsDa/IZP8fxKU19TXbhuAr/3u17yWKHxnkIY3OxgnQaCLe7WyytE6y/erS7c8pRApqcK57b0AhOYJQg0AURgTexrbn/jivt7CwAtSG9f9Bk0aFdD9gpj+QBZu98Pr2SCBU7Q7Q69oCmNgMFhnqYclGBam4wXDxr4C716pcIkJtnNNdABeYIxZz2ivU5LCIgidDVvSiAASyblWJQjoTjToKnse2if9n2uosIDE1Dd4N9voDikTdfOS45V3uCwdOp7Pa2x0uzH4X4NgQs8L7nD0CvH/oQN3tpayApcR+tEWzOX8OXnTwye9zREJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z6f3wIAjuxTSo42MnJHpl37p1DQCvIy1vbJKTxk2w086Ee13YC3FnQ8848FA+W3rqCJlETedD0sdJGj+1ThzPW/2w5yHb/bnkmOiFrXTD3e9HHAN2WFCPhnFKcUZAPEG7Uu/NJFqkyST+SOF14WdsYo7zzEiM5RXlighoIAx9wbp0ESQpV/wbGXMQF4nbziJ/xzHJU/7NTkwa7jcK+VHEMwHKkvxfSdgtQOnO7jyjdGzkstR2p8XOyJP4qufCHVcyJXX0VgvkIlH/5JRR4XPtJmK5ffqqIvFXmZsthhezy3R3wJUxZq+6KcQJkOXWKKk0GHITgllzmfpzNL/o8A4X1LxhpEr5yQdxWNmu5QyXWYIOCwJqR58o7JWjhHSLxbEjLytsOLhCa1r8Pd7JdNU5aCgswS8BHvcIy2BxQH3JtLew1AFXXwq7aHSsb6+58jo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:01.8312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1166b287-fe52-4e71-a060-08def2bc8430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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
Add tests for amdgpu_dm_update_stream_irq_parameters() covering stream
and timing guards, unsupported configuration, and variable, inactive,
and fixed VRR states.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 148 ++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index de5115faebc3..a127b3633fe5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -308,6 +308,7 @@ void amdgpu_dm_update_stream_irq_parameters(
 	acrtc->dm_irq_params.vrr_params = vrr_params;
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_stream_irq_parameters);
 
 void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 				     struct dm_crtc_state *old_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 069c27f46a7d..9db7bfa90fce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -604,6 +604,147 @@ static void dm_test_update_freesync_state_pcon_default(struct kunit *test)
 	dm_test_update_freesync_state_pcon_version(test, 0);
 }
 
+/* Tests for amdgpu_dm_update_stream_irq_parameters() */
+
+/**
+ * dm_test_update_stream_irq_parameters_no_stream - Test a NULL stream is ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_invalid_timing - Test zero stream timing is ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_invalid_timing(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.stream = dm_kunit_alloc_stream(test, NULL);
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_unsupported - Test unsupported config update
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.stream = dm_kunit_alloc_stream(test, NULL);
+	crtc_state.stream->timing.h_total = 2200;
+	crtc_state.stream->timing.v_total = 1125;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_EXPECT_EQ(test, (int)crtc_state.freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+	KUNIT_EXPECT_EQ(test, (int)acrtc->dm_irq_params.freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+}
+
+static void dm_test_update_stream_irq_parameters_supported(struct kunit *test, bool vrr_enabled)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.base.vrr_enabled = vrr_enabled;
+	crtc_state.stream = dm_kunit_alloc_stream(test, NULL);
+	crtc_state.stream->timing.h_total = 2200;
+	crtc_state.stream->timing.v_total = 1125;
+	crtc_state.vrr_supported = true;
+	crtc_state.freesync_config.min_refresh_in_uhz = 48000000;
+	crtc_state.freesync_config.max_refresh_in_uhz = 120000000;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_EXPECT_EQ(test, (int)crtc_state.freesync_config.state,
+			vrr_enabled ? (int)VRR_STATE_ACTIVE_VARIABLE : (int)VRR_STATE_INACTIVE);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_variable - Test variable VRR configuration
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_variable(struct kunit *test)
+{
+	dm_test_update_stream_irq_parameters_supported(test, true);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_inactive - Test inactive VRR configuration
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_inactive(struct kunit *test)
+{
+	dm_test_update_stream_irq_parameters_supported(test, false);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_fixed - Test fixed VRR configuration
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_fixed(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.base.mode_changed = true;
+	crtc_state.stream = dm_kunit_alloc_stream(test, NULL);
+	crtc_state.stream->timing.h_total = 2200;
+	crtc_state.stream->timing.v_total = 1125;
+	crtc_state.vrr_supported = true;
+	crtc_state.freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+	crtc_state.freesync_config.min_refresh_in_uhz = 48000000;
+	crtc_state.freesync_config.max_refresh_in_uhz = 120000000;
+	crtc_state.freesync_config.fixed_refresh_in_uhz = 60000000;
+	adev->dm.adev = adev;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->dm_irq_params.vrr_params.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	KUNIT_EXPECT_EQ(test, acrtc->dm_irq_params.vrr_params.fixed_refresh_in_uhz,
+			60000000U);
+}
+
 static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	/* amdgpu_dm_is_timing_unchanged_for_freesync */
 	KUNIT_CASE(dm_test_timing_unchanged_null_args),
@@ -636,6 +777,13 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_update_freesync_state_pcon_v2),
 	KUNIT_CASE(dm_test_update_freesync_state_pcon_v3),
 	KUNIT_CASE(dm_test_update_freesync_state_pcon_default),
+	/* amdgpu_dm_update_stream_irq_parameters */
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_no_stream),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_invalid_timing),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_unsupported),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_variable),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_inactive),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_fixed),
 	{}
 };
 
-- 
2.43.0

