Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064CC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B5310F414;
	Fri, 31 Jul 2026 21:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wy3I0XCx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4716110F3F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPATQNmyQ2Z0KNyAP2/Zjwkrk6l13OO04S2d31rDP78iyE2jIVGW+pYsl5ifFgavBhOD3zi7CKOPcwO5Ygwbs1mmwzyAyI6C2Gj9ypeauH2zLaY7Yk9ODyCs1Kjy33GStvC0RdDyDTqvCeOISvQddB4d0hKNp6Cpw5iKHfp+ighR4E+RapcM7UnYVZ66eXyVNoE0tzGWGZOtZmDg5YediOjaJDpNp5i4YYI+25M1ZcVlWuqkX3Gt2/rE79Sj/KPsO7GPMNjSSUWsNnf/J5/pX4e70lmDK8W+2+RLk2tDsGccshtbM0/C6oiF3qBC5NgaGfhtpSufeUowvAAmAYEXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9Q61Dg/bODCt3pSTDKqoTlabzQUPgte3QfZtW7lTRA=;
 b=o6wGQO1itMzSH71ubsxWKTZ09Kr5/y4WpOyGPE8zRtHdSF+wxznBdW5u84QOxx0jRqsza8ehT7e61kwVyRbqYpvynZGbjnWcYji/jOsURTMP/Vs/ptHJ5Ir26B//y4AEKEKK1iUBlVndIYSc2cVfqn3WWNE6002BhAZ1vhceGk9jZ7Npa2smS1Je/gVhcmg5oZ025cqWrwmHwBLLIGewng3DNQjioV2Y2mazG5RC3WxLcZ0/fT014i6JR7sc2SuUzDUmCkguBl7ZsVrNJzAu6dWGPM7GHVDU3OC4oNfpSMidCg/FM4V4mbHFZ6bZwi2o28Xhp1uOyNJwTqJ5vyrEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9Q61Dg/bODCt3pSTDKqoTlabzQUPgte3QfZtW7lTRA=;
 b=wy3I0XCxFOMndWvgMErCUOKQJo8SXtm8ndLSwxIzEMsdIcisRn0yUJTzwntgRKuRwjCMegB/3c7w7mZa6xxPcG0VRG9vESVdZoW29Hsn21+Vl2IqDqsaGyytuEJA3JizoU7tY6G0Nk/unAjRC8heOY/0iWnpAJeotKl8HqozI7Q=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:43 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::5a) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 21:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:42 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:42 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 14/41] drm/amd/display: Add KUnit tests for more crtc functions
Date: Fri, 31 Jul 2026 17:12:35 -0400
Message-ID: <20260731211302.3040343-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c522a2-c76d-4fd9-27a3-08deef48e17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Md5E0Z/fkzWPQ20us0RRBMzn4vvTBkfNmcIyH7xR7qasJ4zPLo88+UzevZUSNOBRyG215NnsrZ6vAJYM2lHcKkd+3BECBZGHMu1mW6C7dZasvHpBBXPsrO1rnGc7jgmh4/lPtE2A9XPknYDHyTG/Lop+LrOukoNJrHY9366Xg+ADxvlOBk6jBoVasU0jWacbG5HNFD/DxrvHmUXJQjKnQyZxvWSXIarUQC6zkivEPcL0LQi7ZDnD8VbSp9YP3aHWB2fyW5+arh1aZeUTpYjWEZNQLmplKkrpOMKno1G+e/XLeHMVm/4AQLA5WzybVl8pkPiPZSBPPx48NnsPphpP7hGCF1fg/iJMyPEO93svYroP45dV9kodeBTX7/Yv7t5URvWRbQaN7a+ovw3J+MJQ66FeaGpecjhVYSVgcMV7VRegzN3CmJwyo/tF/xLAFmw7JQZb5qjanSLP002cavPeL7XNjXekPAYgF0GwJmiPd6W4Jpa9DT5B+9iHPou9/eEVy9Xs7FauuJiRcrrzJQt5Au1IjCdLe80nJ1mDWt+SxRzIhufUt87Dq58ttqrjI3OaoMax90tdvSI31PJrsTmhOkeWVuvPZFSrkM5/oTYpfg4upWIWO1GeuqSQgJ4qpiZGVgpb3d/JAIj609PmMbpdkFwNhMioOIoVrqwuBfZbK4qn/0ryNeFqWVZMnf6MUeQksMbe49sVujykB+bDA3q57g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vq6qvsEgpqlBlCIvcdM8b8+HcktqwqyTebwb+UY/isvpzmj+OeINwSGazuCy3fINNbn4lz/hdsr5b6i2ITocA1g9/Z5TaAVAO3HRTfppoJdTfN2C6fKwtL5Gnfa2hodsQbn1t9VytsXZsdnmUUEysBTCgTIPBUA3Jh7fTGspQNYCSq86J8uzXjHuanIriYL4bmJ9X4qbsfURhKH+EfzoR0H7limaQCN6GKGt07BUpbBEE2XoxDvQdQBrIhSmQadx0L2eY9b0qjv24cyqSaE5iCuNsI7AMU5mgjLNNYDc87plOMJrz1tPlITfh4BtK/vksnHw1COJVwFtOP4nB8k430jXFtUsejX8CUAAMG4z7UAc7Kz+huc5nWOpC8UnbnG12W1pcu8ULQyzf5PZzQ459a5bUQf6G4c1oQ1gesaQ3EbyAYAt+EXCsBvP/Fw1t6X4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:43.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c522a2-c76d-4fd9-27a3-08deef48e17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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

Expand KUnit coverage for amdgpu_dm_crtc.c with tests for functions that
are easy to exercise in isolation:

- amdgpu_dm_crtc_set_static_screen_optimze(): the !allow_sr_entry early
  return.
- amdgpu_dm_crtc_enable_vblank(): rejection with -EINVAL when enabling
  vblank on an unconfigured CRTC.
- amdgpu_dm_crtc_update_crtc_active_planes(): the no-stream branch that
  resets active_planes to zero.
- amdgpu_dm_crtc_duplicate_state(): DM-specific fields are carried over.
- amdgpu_dm_crtc_reset_state(): a fresh state is allocated and installed.
- amdgpu_dm_crtc_destroy_state(): a stream-less state is freed cleanly.

Expose amdgpu_dm_crtc_destroy_state(), amdgpu_dm_crtc_duplicate_state(),
amdgpu_dm_crtc_reset_state() and amdgpu_dm_crtc_update_crtc_active_planes()
to the tests via STATIC_IFN_KUNIT/EXPORT_IF_KUNIT.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   6 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 177 ++++++++++++++++++
 3 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 079d4ccc88da..ce42102109bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -134,6 +134,7 @@ void amdgpu_dm_crtc_set_static_screen_optimze(
 		amdgpu_dm_psr_set_event(dm, stream,
 			set_vsync_event, psr_event_vsync, set_vsync_event);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_static_screen_optimze);
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 {
@@ -393,13 +394,14 @@ int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	return amdgpu_dm_crtc_set_vblank(crtc, true);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_enable_vblank);
 
 void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	amdgpu_dm_crtc_set_vblank(crtc, false);
 }
 
-static void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
 {
 	struct dm_crtc_state *cur = to_dm_crtc_state(state);
@@ -414,8 +416,9 @@ static void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 
 	kfree(state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy_state);
 
-static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state, *cur;
 
@@ -450,6 +453,7 @@ static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *cr
 
 	return &state->base;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
 
 static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
@@ -463,7 +467,7 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 	kfree(crtc);
 }
 
-static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
@@ -476,6 +480,7 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_reset_state);
 
 #ifdef CONFIG_DEBUG_FS
 static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
@@ -610,7 +615,7 @@ static int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_cr
 	return num_active;
 }
 
-static void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 						     struct drm_crtc_state *new_crtc_state)
 {
 	struct dm_crtc_state *dm_new_crtc_state =
@@ -624,6 +629,7 @@ static void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 	dm_new_crtc_state->active_planes =
 		amdgpu_dm_crtc_count_crtc_active_planes(new_crtc_state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_update_crtc_active_planes);
 
 STATIC_IFN_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 					       const struct drm_display_mode *mode,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index d8b004f613ab..ed6e8021d69e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -46,6 +46,12 @@ bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode);
+void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
+				  struct drm_crtc_state *state);
+struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
+void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
+void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
+					      struct drm_crtc_state *new_crtc_state);
 #endif
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index ac21bbec92ab..ce20692959d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -456,6 +456,171 @@ static void dm_test_idle_create_workqueue(struct kunit *test)
 	kfree(idle_work);
 }
 
+/* Tests for amdgpu_dm_crtc_set_static_screen_optimze() */
+
+/**
+ * dm_test_crtc_set_static_screen_optimze_no_sr_entry - Test early return when SR entry disallowed
+ * @test: The KUnit test context
+ *
+ * When self-refresh entry is not allowed the function must return immediately
+ * without touching replay or PSR events, regardless of the requested SSO state.
+ */
+static void dm_test_crtc_set_static_screen_optimze_no_sr_entry(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct dc_link *link;
+	struct dc_stream_state *stream;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	/* allow_sr_entry == false -> returns before any event is set. */
+	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, true, false);
+	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, false, false);
+}
+
+/* Tests for amdgpu_dm_crtc_enable_vblank() */
+
+/**
+ * dm_test_crtc_enable_vblank_rejects_unconfigured - Test vblank enable on disabled CRTC
+ * @test: The KUnit test context
+ *
+ * Enabling vblank on a CRTC that is not enabled must be rejected with -EINVAL
+ * before any interrupt state is touched.
+ */
+static void dm_test_crtc_enable_vblank_rejects_unconfigured(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->base.dev = &adev->ddev;
+	acrtc->base.enabled = false;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), -EINVAL);
+}
+
+/* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
+
+/**
+ * dm_test_crtc_update_active_planes_no_stream - Test active plane reset without a stream
+ * @test: The KUnit test context
+ *
+ * Without a DC stream attached the active plane count must be reset to zero
+ * and the plane-counting path must be skipped.
+ */
+static void dm_test_crtc_update_active_planes_no_stream(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	dm_state->stream = NULL;
+	dm_state->active_planes = 5;
+
+	amdgpu_dm_crtc_update_crtc_active_planes(NULL, &dm_state->base);
+
+	KUNIT_EXPECT_EQ(test, dm_state->active_planes, 0);
+}
+
+/* Tests for amdgpu_dm_crtc_duplicate_state() */
+
+/**
+ * dm_test_crtc_duplicate_state_copies_fields - Test duplicated state carries DM fields
+ * @test: The KUnit test context
+ *
+ * Duplicating a CRTC state without a stream must produce a new state that
+ * carries over the DM-specific fields from the current state.
+ */
+static void dm_test_crtc_duplicate_state_copies_fields(struct kunit *test)
+{
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *cur;
+	struct drm_crtc_state *dup;
+	struct dm_crtc_state *dm_dup;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	cur = kunit_kzalloc(test, sizeof(*cur), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cur);
+
+	cur->abm_level = 3;
+	cur->active_planes = 2;
+	cur->vrr_supported = true;
+	cur->cm_has_degamma = true;
+	cur->cm_is_degamma_srgb = true;
+	cur->crc_skip_count = 7;
+	cur->mpo_requested = true;
+	crtc->state = &cur->base;
+
+	dup = amdgpu_dm_crtc_duplicate_state(crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dup);
+
+	dm_dup = to_dm_crtc_state(dup);
+	KUNIT_EXPECT_EQ(test, dm_dup->abm_level, 3);
+	KUNIT_EXPECT_EQ(test, dm_dup->active_planes, 2);
+	KUNIT_EXPECT_TRUE(test, dm_dup->vrr_supported);
+	KUNIT_EXPECT_TRUE(test, dm_dup->cm_has_degamma);
+	KUNIT_EXPECT_TRUE(test, dm_dup->cm_is_degamma_srgb);
+	KUNIT_EXPECT_EQ(test, dm_dup->crc_skip_count, 7);
+	KUNIT_EXPECT_TRUE(test, dm_dup->mpo_requested);
+
+	amdgpu_dm_crtc_destroy_state(crtc, dup);
+}
+
+/* Tests for amdgpu_dm_crtc_reset_state() */
+
+/**
+ * dm_test_crtc_reset_state_allocates_state - Test reset installs a fresh state
+ * @test: The KUnit test context
+ *
+ * Resetting a CRTC with no existing state must allocate and install a new
+ * drm_crtc_state.
+ */
+static void dm_test_crtc_reset_state_allocates_state(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_crtc *crtc;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+	crtc->state = NULL;
+
+	amdgpu_dm_crtc_reset_state(crtc);
+
+	KUNIT_EXPECT_NOT_NULL(test, crtc->state);
+
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+}
+
+/* Tests for amdgpu_dm_crtc_destroy_state() */
+
+/**
+ * dm_test_crtc_destroy_state_no_stream - Test destroy frees a stream-less state
+ * @test: The KUnit test context
+ *
+ * Destroying a CRTC state with no stream attached must free the state without
+ * attempting to release a DC stream.
+ */
+static void dm_test_crtc_destroy_state_no_stream(struct kunit *test)
+{
+	struct dm_crtc_state *dm_state;
+
+	/* destroy_state kfree()s the state, so use a plain (unmanaged) alloc. */
+	dm_state = kzalloc_obj(*dm_state, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+
+	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -488,6 +653,18 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_no_otg),
 	/* idle_create_workqueue */
 	KUNIT_CASE(dm_test_idle_create_workqueue),
+	/* amdgpu_dm_crtc_set_static_screen_optimze */
+	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_no_sr_entry),
+	/* amdgpu_dm_crtc_enable_vblank */
+	KUNIT_CASE(dm_test_crtc_enable_vblank_rejects_unconfigured),
+	/* amdgpu_dm_crtc_update_crtc_active_planes */
+	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
+	/* amdgpu_dm_crtc_duplicate_state */
+	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
+	/* amdgpu_dm_crtc_reset_state */
+	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
+	/* amdgpu_dm_crtc_destroy_state */
+	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
 	{}
 };
 
-- 
2.34.1

