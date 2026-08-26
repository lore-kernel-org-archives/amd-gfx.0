Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A159C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D635410EE5E;
	Wed, 26 Aug 2026 23:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s300MTuZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAFA10EE5E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCVosbElwhpn8fm+AmeAIxuRjYcmeTQM/HjGQJaNX3Wuz5ioJPNDk1DGYY4FEdZgxq7k3sTEJRdS3FUNy5I5f3LfH36FcXMjdjCvnf9XGysl6MB/6oHv0FA7vKnMj3ZYUxJxTT45akgfMyieqpqEPE/ubrEW+2PKudyqmz3CT6QTHr9ElnYxyzdNYD9Rv9UmMgbfDrdS0exthANApJyK9mQpVFt66CPr0pp0wqYB/exPP2b6tlOovPiwCDrJnIAAvVO5aNABZj6uCC6MjxA31gY/e44nz6NAgAcc4xxH4Gnlm+qBHPdhPrZef0GmfRWNZ2wsx6W6Ag1jl771WWDVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIOsP7Nm90wJ42Fe+LRi9RSdjJP2G8NU+3iIXXR0cbY=;
 b=leFOFNZvQtehswPJDy6f6KAPrLfOv5BtbSj8xGIqMIPDaBsyS4Dux3RKjUvmd9RlRNPTU/JJ2gdOiw8B8xSBMVXL3UDFHt+QltvPXoWMcTpS/EOlDdZe+mErUqY40dNZI122PcqKjwfjFE/MTpU53/JMWDxyx79MEo5qXcqSiravCbfpEiLHSwgrnY/euAoYEbYvfK6PKG1HHL2z/7F6OydmDXXgl9Wi+72kTOQlQBm9s8tyZXOibrxKLQA9wv5psXY8jNJinM6hp9jC/AaVLv004miCExvlynGRIhMDCrvwWWM/KsRXe5m5SiEGq0ddYYZp/2VzkH09iqROaS/nnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIOsP7Nm90wJ42Fe+LRi9RSdjJP2G8NU+3iIXXR0cbY=;
 b=s300MTuZ/Syb0kWKMzR2+KPZ8wdqroiOiYg/wjzvAqtcEtxmS+zc1RO/UEfJAxtLTJRPhFWbRRF3j8vMcx1bo+I8k+P/D7vd8PTWTJmRL5BMQzXpEuFwze/hQvtRmOZ+Ss1t0kY9o8DpfSwoYzECdKtc1XRhe+xhMC7FG9ADCTc=
Received: from SN7PR18CA0027.namprd18.prod.outlook.com (2603:10b6:806:f3::22)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:30:28 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::85) by SN7PR18CA0027.outlook.office365.com
 (2603:10b6:806:f3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:30:28 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:30:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 44/59] drm/amd/display: Test atomic commit setup
Date: Wed, 26 Aug 2026 17:05:15 -0600
Message-ID: <20260826231519.881949-45-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d525180-0d1d-4356-4513-08df03ca0337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7YWLAWFtq3VYUMKGH1QRKJQx9lY2CtdTCRrjy7Vgd0/XnY6ZMu7kPcq8WgedALF7jr+heC+YKDTvKmWEw0XN3Npc68VQu9l1hxAdmtMzSVw545V+yoy8KNHwbFG7Cf0XL6hD8GDqJXtORHpvOz1TypU4U6R2ANIGFDhm8B/dusDLl7I6mEiCrBYQA26nJkdDCmjGVpbgrfgzB8CcpVPuL+WbvBuws4DzJHF78Gox60X0eLfgA9D0909V8VXZDkZAZNsmX2tcy+GsfrWaMU2i8nAzEjLbCtD/vR3K5JPPsfFwLaciULb7L4fuEBlyKS+yz2LUnlNnuwesSg1v9KEcvX8lGjfmLyYxVc3YU7Ail1uNKlQmdpJSrkIcXqkyTABrptyJ2EiGsf2Ya6ph3oqEGQXEBOmiV1y/67WkMzE8UZYJ4qc+1sU0hOhEwGgR7UWuUekbX3h6/F+5sIUif7c7icPx7KWyAlhbk2nd8/isRs4vD1UbHPX6Vg6SpcPcVHwxkCnhb1djBVykzx7a0P/O28j/VCV4WPbc+M9NpX+kwUxCV7X/qeRWLBxLAHDjhSRxyFEK1lvRfhXcbD7zH1IjlkV3/YA+9kaVPO4v+EHBDW2oooNMBIL6ZF4colWzviGDZG+qNpyIFLDEvWmqrOnZzEqJgY4fiAVFygrZfvGeHVr/wczhYFb9OErt0YAk8iuxAFBWLT4h5/jA7o8dW8pGkw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OTihQpRj1JVb89OVDE0ObUW3drH4soppMFqd+V54NS6+0R41dgvvK9b38EOl4o41Cd3Qja+7uU/EJvX0Io49sDwvV0TxreHvph6V3pSnm2q1465D1p0DArdngen1eRYZDd/RFXRlFfbvQlleYUN/5ZBBYHxTLTi0b5zef6f8zd2/mQRqLtEXMIDXpdEUS8bdjJwo/UMk/KPQDkPILXnewMeVx6kpgpZ95r57BShAEvt4zKLpmGeIu3eupQmz3CCVuGOZp8kpr2+v10WAgNzpkUwcoUi4LMlsuztIX87CdR90V+BpTJ4wyHSfPf/qbJ27KE6endmK/N/uwEahUHpDxk9HvB+O4iETsnHCstZKJQcqquW6/p+DLFY42oeW1pWyCpO/FnXYrhaOlSFjENueRhvhAnxTGFDN/T124BVoIPr60dnafsJry4aV8cBUq8lR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:30:28.0908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d525180-0d1d-4356-4513-08df03ca0337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

[WHAT]
Add KUnit tests for amdgpu_dm_atomic_setup_commit() covering an empty
commit, changed color management, a modeset-only color update, and an
invalid degamma LUT.

[HOW]
Reuse the modeset fixture for active CRTC paths and attach a one-entry LUT
to exercise size validation without hardware programming.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 67 +++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e62d451e0b1..71fe85498766 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -141,7 +141,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
 /* removes and deallocates the drm structures, created by the above function */
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
-static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
 STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 
@@ -4901,7 +4901,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_hdcp);
 
-static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
@@ -4933,6 +4933,7 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_atomic_setup_commit);
 
 STATIC_IFN_KUNIT void set_multisync_trigger_params(
 		struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7308067b4d13..5ffaca8a6efe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1203,6 +1203,7 @@ bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 				     struct drm_crtc_state *crtc_state);
 void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
 void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
+int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 int do_aquire_global_lock(struct drm_device *dev,
 			  struct drm_atomic_commit *state);
 void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index bb09ebc07435..a8140747c25d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -2858,6 +2858,19 @@ static void dm_test_update_hdcp_no_workqueue(struct kunit *test)
 	amdgpu_dm_update_hdcp(dm_test_alloc_commit(test, adev));
 }
 
+/**
+ * dm_test_atomic_setup_commit_empty - Test an empty commit needs no color setup
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_setup_commit_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_atomic_setup_commit(dm_test_alloc_commit(test, adev)),
+			0);
+}
+
 /*
  * A commit with one connector of @type bound to a CRTC that keeps its stream.
  * The content protection state is unchanged, so amdgpu_dm_update_hdcp() walks
@@ -3336,6 +3349,56 @@ static void dm_test_mod_power_setup_streams_no_modeset(struct kunit *test)
 	amdgpu_dm_mod_power_setup_streams(ctx->state, &ctx->adev->dm);
 }
 
+/**
+ * dm_test_atomic_setup_commit_color_mgmt - Test color management is reprogrammed
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_setup_commit_color_mgmt(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.active = true;
+	ctx->new_crtc_state->base.color_mgmt_changed = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_atomic_setup_commit(ctx->state), 0);
+}
+
+/**
+ * dm_test_atomic_setup_commit_modeset - Test a modeset alone reprograms color state
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_setup_commit_modeset(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.active = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_atomic_setup_commit(ctx->state), 0);
+}
+
+/**
+ * dm_test_atomic_setup_commit_bad_lut - Test an invalid degamma LUT is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_setup_commit_bad_lut(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+	struct drm_property_blob *blob;
+	struct drm_color_lut *lut;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	blob->length = sizeof(*lut);
+	blob->data = lut;
+	ctx->new_crtc_state->base.active = true;
+	ctx->new_crtc_state->base.degamma_lut = blob;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_atomic_setup_commit(ctx->state), -EINVAL);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3482,6 +3545,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_update_hdcp_no_workqueue),
 	KUNIT_CASE(dm_test_update_hdcp_writeback_skipped),
 	KUNIT_CASE(dm_test_update_hdcp_unchanged),
+	KUNIT_CASE(dm_test_atomic_setup_commit_empty),
+	KUNIT_CASE(dm_test_atomic_setup_commit_color_mgmt),
+	KUNIT_CASE(dm_test_atomic_setup_commit_modeset),
+	KUNIT_CASE(dm_test_atomic_setup_commit_bad_lut),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
-- 
2.43.0

