Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CE2CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553FF10EEDD;
	Wed, 13 May 2026 14:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qbwBYfI";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00CE10EEDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQQHF+MdG15HVlT9W0Z4VYVNILDBdNRSllXD/UsOA955qmZr751DXYqpUByWe9gGt6lWrinilr48CeXQ4DLfFXl2CvTBoR7iZI0wwd0Gg6sSVzZZ0zg1g6qQ6DHmZXg7GeDUYVQ6og8yofYfs7a2nynf+jzbhQYOTc+WNBcteMtxCq3QxtGIyTFa5f2543dz3qCuPFrXckTDCBFDKNqSnzoc6QWXY9/FsOKXDc5FNIQt3Q+oH5I2SKp4LENPVOxPIYHNZbpul4j42uY0/hoZsUOobfCEjzXQiJ8COzWvKVJRhAMnSmEZNOv/XX6B09F4la3mcu6fBhOYIFxDfkGSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fIvO1mKUy1OvmPFk55ThgpfhdusTtfZsVRmyyYHIWA=;
 b=gCmqTgZslCX724Al9FxNNtz3GZphvASw4AIlg93sP6vVElyLvzGFyp3arA6WOP/I3w1GXDC7h8983Jp2P3IVrvHUDYzfv+LLBWjz0+QzKOmwMhftSQv3QKA8iqsz/TUpE5HqDLoCthVU+gJhKz/t6l0+QwC79HT0h7VA4I0iEyR9rQdihi0RpjuQ9Iw8ls7WC2MVg66jo6nvt3r+GokNncWTqnvQYrgtOBl1nThGt1BSW/o0SwYQcJGADsCcGbfnFIbJWba5/Oj0gFtTi+KFS2PGw4kwfZfgzv0HGu5vUA4jkq6zdY0PhqZ99Q5+O3T7nkYdqtSp7ThGWW8WbFP0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fIvO1mKUy1OvmPFk55ThgpfhdusTtfZsVRmyyYHIWA=;
 b=5qbwBYfIRO+5GkM431wcdEsRyrUTztDVvr3XmdGlXUP3biRrDcY3u+CKlEHr4wRrrGYT31jZCBHEduUp6FwNextD+3cVKdFrRMy7UspUoLeyK0pifUlEmCpJ7AnpLuEFj0Qi6oAo41ufH0kzhJ6R5/fqeygSucqkTp6nU+DH9AI=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:40 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::ee) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:30 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 16/28] drm/amd/display: Fix ISM dc_lock deadlock during suspend
Date: Wed, 13 May 2026 10:29:38 -0400
Message-ID: <20260513143213.1852892-18-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 50caa97a-c937-4992-d151-08deb0fca033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: jmwdYWFLmg6edGTsbZXJAz+XxPzm0nUJ2VVFH34aFWWu1P6kVcF0Ud3VfBk3VGGEEpZpdoKZ1//Q2XdmuwgkcrdTo9/OLDlczy14BDdYhGClmQrVfq2PPma94o0lmAxBuJkmuBFE2NfDfgoUWz9r3TE8JYaUt+Bc/d+j49E2+Nn8rU8pK7gPGe1HS3ocE0wBZ6g2SOhry00lTqurCO0VU616FfobCVRMrvBC/khPx1gjW0muXq9FUbutbSCwi+Ep+reEv7vLdjptn9kIzjaE9ibjvrcFxkDYb4GXbNiej4yCOWOdGi8yUhknpEYlhsv0zYgLGmsnRN9Yo6Kp/yEoO2uGnZnJsNoklNO/5okbXEyvlBv4J0QuIU5WTIRDYbps+50bqCWhP1pNp0DuKNBCp3xrTAP7AU+Ce7jeCZ3KcwLYMEtp0IGba2rms6aQS7qHj8KdlTJ3K1nb2PhzfviQVqUTQ+YjPwBX3EMQUkfjjwsZANaUjvkdW4tIDgynSxJ6JKEJ/rP4B1IZdDcaROwAAFK46bR8oDeFHdebpxY5WeWyUktcpQeJLtzx+5skXakvDuVgNW+9V/1yYvKrXpLrs9pcHxHUKZ3K+X1r6YCgCAfTBXpfEK96gjlYE7/dcCOiCOtRF1cn/ibJ/PkWBRX/QERDrAz05HOyQK3QnNatEvbTAmZj5MxqjEPKdnBscDFsK7cX7m7X8ZAEv4TEwRMbgFHqo49BYA/cGYNP0hYhRZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWbY0MA18jWRnzPI1rzbxxv6vQnnEGGqdI11FunOr9wVShEKAYfGHay1lbewbVIjA9Nr5QB88iaPG8pAO8G85qvdaxwbc7r7QKkGMk4oQ9n9nkmEkOdqMcxDixcLwMIaNKHqYxm+t8zs+teUxnZ69Hl32EUhEwlFAc3HrVhEKu7++DecAY6Z0qvgu3FxBFU7w104i7JGcjqBd99p+gp/LIm31cEO5JwBEFRGoUKauwS5UgB/YBRho0+yDs4QyItnO/3dZTBGRaZg4mZG3bdIXVWwI4X6/X/XOugSj9fnIAdzic0Xr4BWsrruJuGJDI4EtyyMeI4dHTxsUBH/7FG3F6v/dwJJI8Bv11wPEeti3jc6T3jyITx/Z9Bl5GsH+NE9k2mJ8AJkBDY/Kg7RrvdR+3/PjxLy2DOpIFacmKRXQRGu3slwJj2YgYfaz+Vvh60L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:39.8093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50caa97a-c937-4992-d151-08deb0fca033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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
System hang observed during suspend/resume while video is playing.
amdgpu_dm_ism_disable() is called under dc_lock and waits for ISM
delayed work via disable_delayed_work_sync(). The work handlers
themselves take dc_lock, producing an ABBA deadlock when a worker is
in flight at suspend time.

[How]
Split the disable path into two phases with opposite locking
contracts:
  1. amdgpu_dm_ism_disable() -- quiesces workers, must NOT hold
     dc_lock.
  2. amdgpu_dm_ism_force_full_power() (new) -- drives the ISM FSM
     back to FULL_POWER_RUNNING, must hold dc_lock.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 56 ++++++++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |  1 +
 3 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c41f017fe8f2..af0af7519517 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2327,9 +2327,16 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.idle_workqueue = NULL;
 	}
 
-	/* Disable ISM before dc_destroy() invalidates dm->dc */
+	/*
+	 * Disable ISM before dc_destroy() invalidates dm->dc.
+	 *
+	 * Quiesce workers first without dc_lock (they take dc_lock
+	 * themselves, so syncing under it would deadlock), then drive the
+	 * FSM back to FULL_POWER_RUNNING under dc_lock.
+	 */
+	amdgpu_dm_ism_disable(&adev->dm);
 	scoped_guard(mutex, &adev->dm.dc_lock)
-		amdgpu_dm_ism_disable(&adev->dm);
+		amdgpu_dm_ism_force_full_power(&adev->dm);
 
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
@@ -3362,9 +3369,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_in_reset(adev)) {
 		enum dc_status res;
 
+		/* Quiesce ISM workers before taking dc_lock (workers take
+		 * dc_lock themselves; syncing under it would deadlock).
+		 */
+		amdgpu_dm_ism_disable(dm);
+
 		mutex_lock(&dm->dc_lock);
 
-		amdgpu_dm_ism_disable(dm);
+		amdgpu_dm_ism_force_full_power(dm);
 		dc_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
@@ -3398,8 +3410,13 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_irq_suspend(adev);
 
+	/*
+	 * Quiesce ISM workers before taking dc_lock (workers take dc_lock
+	 * themselves; syncing under it would deadlock).
+	 */
+	amdgpu_dm_ism_disable(dm);
 	scoped_guard(mutex, &dm->dc_lock)
-		amdgpu_dm_ism_disable(dm);
+		amdgpu_dm_ism_force_full_power(dm);
 
 	hpd_rx_irq_work_suspend(dm);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index bc7db5e759d1..857c22007743 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -524,13 +524,20 @@ static void dm_ism_sso_delayed_work_func(struct work_struct *work)
 }
 
 /**
- * amdgpu_dm_ism_disable - Disable the ISM
+ * amdgpu_dm_ism_disable - Quiesce ISM workers
  *
  * @dm: The amdgpu display manager
  *
- * Disable the idle state manager by disabling any ISM work, canceling pending
- * work, and waiting for in-progress work to finish. After disabling, the system
- * is left in DM_ISM_STATE_FULL_POWER_RUNNING state.
+ * Cancels and disables any pending or in-flight ISM delayed work and waits
+ * for in-progress work to finish. After this returns, no ISM worker can run
+ * and subsequent mod_delayed_work() calls become no-ops via
+ * clear_pending_if_disabled().
+ *
+ * Must NOT be called with dc_lock held: the workers themselves take dc_lock,
+ * so a synchronous wait under dc_lock would deadlock.
+ *
+ * The caller is responsible for driving the FSM back to FULL_POWER_RUNNING
+ * (under dc_lock) by calling amdgpu_dm_ism_force_full_power().
  */
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 {
@@ -538,21 +545,54 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 	struct amdgpu_crtc *acrtc;
 	struct amdgpu_dm_ism *ism;
 
-	ASSERT(mutex_is_locked(&dm->dc_lock));
+	/*
+	 * Caller must NOT hold dc_lock: the ISM delayed work handlers
+	 * acquire dc_lock themselves, so waiting for them via
+	 * disable_delayed_work_sync() while holding dc_lock would
+	 * self-deadlock against an in-flight worker.
+	 */
+	lockdep_assert_not_held(&dm->dc_lock);
 
 	drm_for_each_crtc(crtc, dm->ddev) {
 		acrtc = to_amdgpu_crtc(crtc);
 		ism = &acrtc->ism;
 
-		/* Cancel and disable any pending work */
 		disable_delayed_work_sync(&ism->delayed_work);
 		disable_delayed_work_sync(&ism->sso_delayed_work);
+	}
+}
+
+/**
+ * amdgpu_dm_ism_force_full_power - Force every CRTC's ISM FSM to FULL_POWER
+ *
+ * @dm: The amdgpu display manager
+ *
+ * Sends DM_ISM_EVENT_EXIT_IDLE_REQUESTED to every CRTC's ISM, leaving each
+ * FSM in FULL_POWER_RUNNING. Intended to be paired with
+ * amdgpu_dm_ism_disable(): callers should first quiesce workers (without
+ * dc_lock), then take dc_lock and call this helper.
+ *
+ * Must be called with dc_lock held.
+ */
+void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *acrtc;
+
+	/*
+	 * Caller must hold dc_lock: commit_event() drives the FSM and
+	 * may touch dc state via dc_allow_idle_optimizations() etc.
+	 */
+	lockdep_assert_held(&dm->dc_lock);
+
+	drm_for_each_crtc(crtc, dm->ddev) {
+		acrtc = to_amdgpu_crtc(crtc);
 
 		/*
 		 * When disabled, leave in FULL_POWER_RUNNING state.
-		 * EXIT_IDLE will not queue any work
+		 * EXIT_IDLE will not queue any work.
 		 */
-		amdgpu_dm_ism_commit_event(ism,
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
 					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index 4df6a82972a8..72e2dac49e55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -146,6 +146,7 @@ void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism);
 void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 				enum amdgpu_dm_ism_event event);
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
+void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm);
 void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-- 
2.43.0

