Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C43C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0056D10EB69;
	Tue,  8 Sep 2026 11:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QyA0DH3G";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68ED610EB69
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXZg4/Md/oXPuKnMIBE1bdQl97DkyPvQMyWjtl8BD/NYxyj1pOykO6NEOrNR+g7/Ng7Q8I9glpRrB/coLpyasiv9sF5cSDW5CTcnRbgSq1zhEWpp65UKs7jFTUUt3FLlJBEyhzlnnegP/U6rhqTYnKeGKZsJgzRnHJV+3QWkCdo63u9IvvtF4ZL06RSytu1a/D22xdmMSvQSOFGLJy4vBE+V2sTR55caW6p2QGU9kWqtrrFoXWivzXpom7i8veOvNCWMjZIsiU6eITlgTv86w03CJk3FD+yq5mA7vShRAojAV7o+v+JFg7DjJDRSOk8zLyxgel8aoePaRmOxjHedOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shjUCQAS8lQRwrmLcOLMBpdwhfn9E81+L8HTxE9b32M=;
 b=E9RdKXTHQuRVy3peIjvjIlErj32qJLbdtyITTntiZuf3UDFRlPurotHwk7VmTPAFAnkBgWkDxJ9t2xP3vqqzynGDuPOTOU6bQdU84W47Q+OLIDQYbxuZ0M1up1BoMj4GXcRsu53+JU9Kz5jYDaXJ0nqw7TAlhcykq8KRa4nbdFnNNS4EgAK/ueb58saum0mQtuH/qvxQVsGvGVS/CHXPvgoqAMD+5mfqDCwFhMw8WXHcwJ4xeV6c1BoRSXVOiHqAx8NzUqVGDjK1u1KQz3JY9wtIASP7gRc/oHnwogZm/fjyZ5LPz6jlRQ2DIUygcjT6//H84gxTYX3efi3FXZEenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shjUCQAS8lQRwrmLcOLMBpdwhfn9E81+L8HTxE9b32M=;
 b=QyA0DH3GRvifHXFPe24ML3B2/1vbPIsT3eWHfcD9dJRMJeuY0luw19OnyTuRvwcWu8+wUI2PNsBKWFI99DKEw1YNm70YGVNzbtO1SOXiJD68HWQStPjXEbgpUuP5JbI88GUFUwWn4SdRDfDSPKqokiVsF06fPGW/Y89flyk/8LI=
Received: from BN0PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:143::34)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:41:54 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::ae) by BN0PR10CA0028.outlook.office365.com
 (2603:10b6:408:143::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:41:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:43 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:41:29 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 50/66] drm/amd/display: Flush ISM work before releasing the
 stream
Date: Tue, 8 Sep 2026 19:31:43 +0800
Message-ID: <20260908113338.2433445-51-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb09db5-799d-4be3-32db-08df0d9e2e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RHv4eX02MpCMNX6xkyYmHv6XtdHhEw6275eCgalIb18MilIFTV71pF61dpGR8AZeeg3lWS+OpF3g4hsOVpv1CdmmEGRdqnWjn8+nMa8aRf+znmmJhbHmOdMc44VISgX9mA0gEMUAehmNfHna2YdBk72gLL5G+R87PFwdDWOtaQww1NZvWVp8w/WniuJKee+3dSoaX7hl01yqSdcZfU7Vjan4w30Fjaudd8dyvmXKqYJC92NrZA4GMw2idaFbMSnzsN4xe93sAje+StjPyA+YCtaNYC63uvNFmomYHEqZCe6Jn/XvGHH5zqmYFoNNDfHxMeSUYTL82x9zw4I8VelzWxWtqw8A3xS1uYycrnXYthrXKQXlFjrO9CdSEgcUQ2m94MXDRSRfe70TPYMT5usJnCzONeigOfFD+M6RITt0bJSy1xbBCERmJjypOzR9usioxRBgweZNPECW5+wBDbAnvufRjI24gNRPLo/tsr4ifvvH8P1UkUkx5qFJJfdF+ylSomvJWZ7RVD+JHSSY9/9h4enqI66l9sW4eTn0hbxNtYLvUvnSCg7bOr58K6hUQ/ZiXbIXO0kiQemEQRyIVquVzPBG0uPvkcrqKX08Iy9Uy+DGinwZIFu1mhqWcI/8JL0ks6/VMlHSS6RRswpRYOsuXAPLmnN7m4KcXWBEWs79JjH9MUuKgSfDA0piAv+pnSneVw2bvGBgzf+f0HUEqhwwWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /wdIfvI6YwvADbpetSV385JBs6Zi4AUCJ0wQnuzpQZsn2+hfm7HcqFoSp6w0nS5CUfV8cH5wakmDavJ18HXPw8pr5TqBFPoGtCIsVrHfywj5XNuPxquHrsOxtVHpsp1d61Z54pqsW2OJE60A45mQvfaiquUO0HT4pAHdWDThEjVrByh2Uu4GPYvm9zndfm9TVzrYnzvdurqI+yCbEeYtIq53QeVQ5m4zGLli6UPsvkKjmCW2YbfiKvpViiNSoJcrpCBlUz3zjvQ6kL/ns+9FzsNVVs1DvfV8+dIXfxEZsaB5PT5xG/mrcVJHgacdklsOvScvO5uiZbXUfx4ZbxlG4YWWpi9YvaoLskrQAEWZeu3nxsYkiat2g5o4GkRul0TMiYWC+GzQe66j4Qqz7hELXdM+l95rUO5QJXrSgxhkgcteohjcpK7Jh9eZHFv0Y8UX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:41:53.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb09db5-799d-4be3-32db-08df0d9e2e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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

From: Ray Wu <ray.wu@amd.com>

[Why]
ISM timers are not tied to the atomic commit, so a timer armed before a
DPMS off can still fire after the stream is released. The external display
check in dcn35_apply_idle_power_optimizations() loops over the active
streams, so with none left it never runs and idle is allowed on an
external-only system.

[How]
Wait out pending and in-flight ISM work before dc_stream_release(); dc_lock
is not held there, so the sync wait is safe. Rename amdgpu_dm_ism_fini() to
amdgpu_dm_ism_flush() and assert dc_lock is not held.

Assisted-by: Cursor:Claude-Opus-5
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 21 ++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 83 ++++++++++---------
 5 files changed, 72 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9a585f8b3d67..607aa5ae9b67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4612,6 +4612,13 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 		    (!new_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
 			manage_dm_interrupts(adev, acrtc, NULL);
+			/*
+			 * ISM hysteresis lives on system_dfl_wq, not the
+			 * vblank workqueue. Wait it out so a timer armed while
+			 * the stream existed cannot allow idle after the
+			 * stream is released.
+			 */
+			amdgpu_dm_ism_flush(&acrtc->ism);
 			dc_stream_release(dm_old_crtc_state->stream);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 4b8530d734e5..a7979b418c2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -480,9 +480,9 @@ EXPORT_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
 STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
 	/*
-	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
-	 * It must be called before dc_destroy() in amdgpu_dm_fini()
-	 * to avoid ISM accessing an invalid dc handle once dc is released.
+	 * ISM workers are intentionally quiesced by amdgpu_dm_ism_disable()
+	 * in amdgpu_dm_fini(). That must happen before dc_destroy() so ISM
+	 * cannot access an invalid dc handle once dc is released.
 	 */
 
 	drm_crtc_cleanup(crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 4e57572e12b6..127eaba4de60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -647,9 +647,26 @@ void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 EXPORT_IF_KUNIT(amdgpu_dm_ism_init);
 
 
-void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
+/**
+ * amdgpu_dm_ism_flush - Cancel any pending, or wait out in-flight ISM work
+ *
+ * @ism: The CRTC's idle state manager
+ *
+ * Cancels the hysteresis and SSO timers and waits for a running worker to
+ * finish. Callers that are about to drop the CRTC's stream use this so that a
+ * timer armed while the stream was still around cannot allow idle afterwards.
+ *
+ * Must not be called with dc_lock held: the workers take dc_lock themselves,
+ * so waiting for them under it would deadlock.
+ */
+void amdgpu_dm_ism_flush(struct amdgpu_dm_ism *ism)
 {
+	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+
+	lockdep_assert_not_held(&adev->dm.dc_lock);
+
 	cancel_delayed_work_sync(&ism->sso_delayed_work);
 	cancel_delayed_work_sync(&ism->delayed_work);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_fini);
+EXPORT_IF_KUNIT(amdgpu_dm_ism_flush);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index afce16f7085a..893e062bb281 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -142,7 +142,7 @@ struct amdgpu_dm_ism {
 
 void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 			struct amdgpu_dm_ism_config *config);
-void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism);
+void amdgpu_dm_ism_flush(struct amdgpu_dm_ism *ism);
 void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 				enum amdgpu_dm_ism_event event);
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index b77df47d3095..a9c6485e2a9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -642,31 +642,6 @@ static void dm_test_ism_init_sets_initial_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ism->config.sso_num_frames, config.sso_num_frames);
 }
 
-/* ===== Tests for amdgpu_dm_ism_fini ===== */
-
-/**
- * dm_test_ism_fini_after_init - fini cancels never-scheduled work without error
- * @test: KUnit test context
- */
-static void dm_test_ism_fini_after_init(struct kunit *test)
-{
-	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
-	struct amdgpu_dm_ism_config config = {
-		.filter_num_frames = 5,
-		.filter_entry_count = 3,
-		.activation_num_delay_frames = 10,
-		.sso_num_frames = 2,
-	};
-
-	amdgpu_dm_ism_init(ism, &config);
-	/* Work was never scheduled; cancel_delayed_work_sync is a no-op. */
-	amdgpu_dm_ism_fini(ism);
-
-	/* FSM state is untouched by fini */
-	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
-			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
-}
-
 /* ===== Tests for dm_ism_set_last_idle_ts ===== */
 
 /**
@@ -897,6 +872,32 @@ static void register_test_acrtc(struct amdgpu_device *adev,
 	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
 }
 
+/* ===== Tests for amdgpu_dm_ism_flush ===== */
+
+/**
+ * dm_test_ism_flush_after_init - flush cancels never-scheduled work without error
+ * @test: KUnit test context
+ */
+static void dm_test_ism_flush_after_init(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, NULL);
+	struct amdgpu_dm_ism *ism = &acrtc->ism;
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.sso_num_frames = 2,
+	};
+
+	amdgpu_dm_ism_init(ism, &config);
+	/* Work was never scheduled; cancel_delayed_work_sync is a no-op. */
+	amdgpu_dm_ism_flush(ism);
+
+	/* FSM state is untouched by flush */
+	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
 /* ===== Tests for amdgpu_dm_ism_commit_event ===== */
 
 /**
@@ -922,7 +923,7 @@ static void dm_test_ism_commit_event_no_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -958,7 +959,7 @@ static void dm_test_ism_commit_event_cursor_transition(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -988,7 +989,7 @@ static void dm_test_ism_commit_event_invalid_event(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /* ===== Tests for amdgpu_dm_ism_force_full_power ===== */
@@ -1020,7 +1021,7 @@ static void dm_test_ism_force_full_power(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /* ===== Tests for amdgpu_dm_ism_disable / amdgpu_dm_ism_enable ===== */
@@ -1048,7 +1049,7 @@ static void dm_test_ism_disable_enable_cycle(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /* ===== Tests for dm_ism_dispatch_power_state (via commit_event) ===== */
@@ -1127,7 +1128,7 @@ static void dm_test_ism_dispatch_hysteresis_schedule_and_cancel(struct kunit *te
 				(int)DM_ISM_STATE_HYSTERESIS_BUSY);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1183,7 +1184,7 @@ static void dm_test_ism_dispatch_optimized_idle_defers_sso(struct kunit *test)
 		cancel_delayed_work(&acrtc->ism.sso_delayed_work);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /*
@@ -1285,7 +1286,7 @@ static void dm_test_ism_commit_allows_idle_on_optimized_idle(struct kunit *test)
 		cancel_delayed_work(&acrtc->ism.sso_delayed_work);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1322,7 +1323,7 @@ static void dm_test_ism_commit_enables_sso_on_optimized_idle_sso(struct kunit *t
 		KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1371,7 +1372,7 @@ static void dm_test_ism_commit_disallows_idle_on_timer_aborted(struct kunit *tes
 		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1413,7 +1414,7 @@ static void dm_test_ism_exit_from_optimized_idle_disallows_idle(struct kunit *te
 		KUNIT_EXPECT_EQ(test, acrtc->ism.next_record_idx, 1);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1452,7 +1453,7 @@ static void dm_test_ism_exit_from_sso_disallows_idle(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, acrtc->ism.next_record_idx, 1);
 	}
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1496,7 +1497,7 @@ static void dm_test_ism_delayed_work_runs_timer_elapsed(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
 	KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 /**
@@ -1534,7 +1535,7 @@ static void dm_test_ism_sso_delayed_work_runs_sso_elapsed(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 3);
 	KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
 static struct kunit_case dm_ism_test_cases[] = {
@@ -1582,8 +1583,8 @@ static struct kunit_case dm_ism_test_cases[] = {
 	KUNIT_CASE(dm_test_ism_idle_delay_entry_count_exceeds_history_size),
 	/* amdgpu_dm_ism_init */
 	KUNIT_CASE(dm_test_ism_init_sets_initial_state),
-	/* amdgpu_dm_ism_fini */
-	KUNIT_CASE(dm_test_ism_fini_after_init),
+	/* amdgpu_dm_ism_flush */
+	KUNIT_CASE(dm_test_ism_flush_after_init),
 	/* dm_ism_set_last_idle_ts */
 	KUNIT_CASE(dm_test_ism_set_last_idle_ts_updates_timestamp),
 	/* dm_ism_insert_record */
-- 
2.43.0

