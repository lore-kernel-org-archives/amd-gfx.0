Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FED9C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E6D10F08D;
	Wed, 15 Jul 2026 13:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P3vllUyz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FB110F092
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0QlI2qpYPU6PEzrIfia9ivyoR/f/5tmB2J6LqvYyx6waXTEWrv8Xbz+VGUlhszs4MBfseCWeV1V7ZW4ncjEu9nUzU/I7RFCGKHO0saC1URBVlJOZo4WRgrkU3fu/GSk4YOGHiq/r/3KSTHKruwxoHKZCh7KYWh409vN0qzTvKbhmFDAFeA1Wf69oGhdd8AcInEtF0wOBzwfrQ1sQoUKLu9DZvNtQ+73+wNrCrpV46ml+sSpD5NPLMWwq9ogOMPQa7G2mx/17Exh15d7LRlBoCVILf/VW9w+vRNvW8Kwltyouy0zR6jXnNDiaj25qwJLnmXxQ4nOXms+KR1+S07t7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UyymOIvxMcpv0w6bFNbLGUW1/eSulJwqwlm3YSEu7M=;
 b=RCOJz2XWmVBBHywj20SCDjzlVGR/fACPeHcfOgdejvvXv11DNR7Bwe3sPLPdAWcZeC4uqikQkxdo5hzdwwcLIDF13cRzBmyr1mWaKq/YFcgnNXd4Dmzb0cRlhTer/ItlXysbF/Fl7oVRIQvG6S0S3ST38qr1zKiZoFyUFWhbV419rKpSlc/rbYKIw8rSRrY8QkJT4msjWI8604/TuPiaKp9lB6Ustd/MrENj8nVM2LaV3DDSbZ6uQhRHJG2tLLz77ZsB5GSwN0LaZnPo68TBnNOECWw89I3cTVB6JJEBO06RavN7yK3jvGLlaHbwjckowtuYIGoI+gGPNBRE1G8oSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UyymOIvxMcpv0w6bFNbLGUW1/eSulJwqwlm3YSEu7M=;
 b=P3vllUyzsyMs+jbNxBeikmkKXTsHLG6uFxZMu6K3qvSEA4eh8vSty10tX7ynovPdWzyOje6ArQKmP5ll46qYXA3k9+lp4MGZLOWhP541QUw/4Nb1joni21+T6eHrSWPhnYetQUQqsJN6uuPg81vZNU57xgA7de3MIQXPpCps+h8=
Received: from SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::12)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 13:47:06 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::64) by SJ2P220CA0001.outlook.office365.com
 (2603:10b6:a03:5da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:05 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 35/70] drm/amd/display: add KUnit tests for freesync config
Date: Wed, 15 Jul 2026 21:37:45 +0800
Message-ID: <20260715134432.1975118-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c1809f-e134-47a4-98a0-08dee2778f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: xeCyOvPsLIADgJEW20cSvJxtCiiqU/1i24UD4LAVIyy6Tt9p+/LetFTP5KMvQU/j3YBJ3G8VpzS8EJ+iS17isOuBn80BigCqw/SqjlZEN+7yZRJ5g1e5gY+/wcRbrCYnN88TstufzN83W+xSwzZGkktb9LuEqXCjBiOerXC1t5tMe+MkBmAmFLrbTH9l7Y2aGRQACE7u9zZou+BU484wWxoG6nT4LQdSZ7355zfa8RbD6kGoh2qMuxhAULRM6SuwM1orwd0Md3KCP9//mVXh7lIapZ3I46SZSL1PwyBK5YkcmZPx2G3RIVNApOpVB2ERPyxmzBvmPGKWk0/155aBCiQH1UQZdV5XVWNdRI4c1UgtVHRgt7EKWnqx6OyosRnDNZ3V5lLLRl8gYlXh/C6OFmyNaO9xO6+QUZLkruKIpv4tEC8Ly96xeCAcIdJFDPgI/261PUQQ7vKaNbT6U2064ys2elLfwzd+vCBeSYJZYRfKwtMsaWdtENDW778CLA7o4YAM2I3+64HUtvu0aHEdC8Ef1jIxXHdGAjFD+wn8rRi7F5+NqcVmQNNtN1UQq0cAHt84r4k9kOM8ogKf3q/hVL/wMSAvG8TXHAmQCNAQMqpiyJkTzccLNFHgamlMX4oc/UN0+hYtL/NdhFuGp++aV2aSxn4IJbaEDgu1hB7ifzyzGMFDUoej+1rALjOyT33DaB9Au2W5eyVx9YSFBkhb7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WpjdltNkzvR7G0IEPxiTanlUvZtM27zvlBRIxEvfjX7rLmdxDz4VJ6Z7SW5cJoaPYhBaDloqHBNI6JhCq+uKXS7CeNgbiLtjYaCsJy664L51u4aBLQfAye+jbaYwqrgd+pCJdRSWVS3ql6pdXQhwFFxtLLKjwXvcqDn1ENNzl0vml6DUYE2ufSSHmRuCOTgOr2ZVBRKpe9iKA9jupJudRbngXmFAruk/2OGkldOzO677XYFVU9lCrS+nQufUnDENLThoyP9EO88T1/2HB7uskqd0NdP9Sac46PL6rDi0oxrOgV/SZ2tP4gYXtjZLm8dGF5l4C3I45acbrEGmkhKc1hlvK95cIdqiNYHGnKWJF0DHOf/Fm7J4x7JdymdOj6s61b66HZIRNgZlNhEG0AjEBm4zDOlTY6+kvNqm1GOwj1d16Mr4YywXJEQM7K8JNtjq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:06.2052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c1809f-e134-47a4-98a0-08dee2778f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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
Add KUnit tests for get_freesync_config_for_crtc and
reset_freesync_config_for_crtc using a shared connector/crtc/stream
fixture. Cover the writeback early return, the not-capable and
out-of-range unsupported paths, the active-variable, inactive and
active-fixed states, and the config reset.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 197 ++++++++++++++++++
 3 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03b9079ce818..fa0add5bcabf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -126,7 +126,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 /* basic init/fini API */
 static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
-static void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
+STATIC_IFN_KUNIT void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 
 /*
  * initializes drm_device display related structures, based on the information
@@ -5733,7 +5733,7 @@ static int do_aquire_global_lock(struct drm_device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static void get_freesync_config_for_crtc(
+STATIC_IFN_KUNIT void get_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state,
 	struct dm_connector_state *new_con_state)
 {
@@ -5776,8 +5776,9 @@ static void get_freesync_config_for_crtc(
 out:
 	new_crtc_state->freesync_config = config;
 }
+EXPORT_IF_KUNIT(get_freesync_config_for_crtc);
 
-static void reset_freesync_config_for_crtc(
+STATIC_IFN_KUNIT void reset_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state)
 {
 	new_crtc_state->vrr_supported = false;
@@ -5785,6 +5786,7 @@ static void reset_freesync_config_for_crtc(
 	memset(&new_crtc_state->vrr_infopacket, 0,
 	       sizeof(new_crtc_state->vrr_infopacket));
 }
+EXPORT_IF_KUNIT(reset_freesync_config_for_crtc);
 
 STATIC_IFN_KUNIT bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c508f0be1b55..29cefa4d8468 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1178,6 +1178,9 @@ bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 				struct dm_crtc_state *new_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
 void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
+void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
+void get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
+				  struct dm_connector_state *new_con_state);
 struct hdcp_workqueue;
 bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 				     struct drm_crtc_state *old_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 1caacad43106..1464eeda704b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1650,6 +1650,194 @@ static void dm_test_cp_diff_desired_to_undesired(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
 }
 
+/* Tests for get_freesync_config_for_crtc() */
+
+struct dm_test_freesync_ctx {
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_crtc_state *crtc_state;
+	struct dm_connector_state *conn_state;
+	struct dc_stream_state *stream;
+};
+
+static struct dm_test_freesync_ctx *dm_test_freesync_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+	ctx->stream = dm_kunit_alloc_stream(test, NULL);
+
+	ctx->conn_state->base.connector = &ctx->aconnector->base;
+	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	ctx->crtc_state->stream = ctx->stream;
+
+	/* 1080p60 timing so drm_mode_vrefresh() == 60 */
+	ctx->crtc_state->base.mode.clock = 148500;
+	ctx->crtc_state->base.mode.htotal = 2200;
+	ctx->crtc_state->base.mode.vtotal = 1125;
+
+	return ctx;
+}
+
+/**
+ * dm_test_freesync_config_writeback - Test writeback connector is left untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_writeback(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->vrr_supported = true;	/* sentinel: must stay set */
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	/* Writeback: early return leaves vrr_supported sentinel untouched */
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+}
+
+/**
+ * dm_test_freesync_config_not_capable - Test a non-freesync sink reports UNSUPPORTED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_not_capable(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = false;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+}
+
+/**
+ * dm_test_freesync_config_out_of_range - Test a refresh outside the range is UNSUPPORTED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_out_of_range(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 90;	/* 60 < 90 -> out of range */
+	ctx->aconnector->max_vfreq = 120;
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+}
+
+/**
+ * dm_test_freesync_config_active_variable - Test vrr_enabled yields ACTIVE_VARIABLE
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_active_variable(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->base.vrr_enabled = true;
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_TRUE(test, ctx->stream->ignore_msa_timing_param);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_VARIABLE);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.min_refresh_in_uhz,
+			48000000U);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.max_refresh_in_uhz,
+			120000000U);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.vsif_supported);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.btr);
+}
+
+/**
+ * dm_test_freesync_config_inactive - Test supported-but-off yields INACTIVE
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_inactive(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->base.vrr_enabled = false;
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_INACTIVE);
+}
+
+/**
+ * dm_test_freesync_config_active_fixed - Test freesync-video mode yields ACTIVE_FIXED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_active_fixed(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	/* Pre-set fixed state selects the freesync-video (fixed) path */
+	ctx->crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+	ctx->crtc_state->freesync_config.fixed_refresh_in_uhz = 60000000;
+	ctx->crtc_state->base.vrr_enabled = true;	/* ignored on the fixed path */
+
+	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.fixed_refresh_in_uhz,
+			60000000U);
+}
+
+/* Tests for reset_freesync_config_for_crtc() */
+
+/**
+ * dm_test_reset_freesync_config - Test reset clears vrr support and info packet
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_freesync_config(struct kunit *test)
+{
+	struct dm_crtc_state *crtc_state;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	crtc_state->vrr_supported = true;
+	crtc_state->vrr_infopacket.valid = true;
+
+	reset_freesync_config_for_crtc(crtc_state);
+
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_supported);
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_infopacket.valid);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_is_idle),
@@ -1742,6 +1930,15 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_cp_diff_s3_undesired_to_enabled),
 	KUNIT_CASE(dm_test_cp_diff_desired_to_enabled),
 	KUNIT_CASE(dm_test_cp_diff_desired_to_undesired),
+	/* get_freesync_config_for_crtc */
+	KUNIT_CASE(dm_test_freesync_config_writeback),
+	KUNIT_CASE(dm_test_freesync_config_not_capable),
+	KUNIT_CASE(dm_test_freesync_config_out_of_range),
+	KUNIT_CASE(dm_test_freesync_config_active_variable),
+	KUNIT_CASE(dm_test_freesync_config_inactive),
+	KUNIT_CASE(dm_test_freesync_config_active_fixed),
+	/* reset_freesync_config_for_crtc */
+	KUNIT_CASE(dm_test_reset_freesync_config),
 	{}
 };
 
-- 
2.43.0

