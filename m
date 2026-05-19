Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E4ECD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C07810E408;
	Tue, 19 May 2026 22:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNgXUJdt";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CE010E408
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBXIX8Kwf5gykbty7Q24CN6gP/08vZTPNnr0MLWTE35GjXwZVaJcR7bvIeiCaW6HK4F9PQFBEO9J7pwXOhbwvqp9rBEIZMMK+hYwIl4pVtdGBPcZMXOBzEuOhzeQApkiI+HEI1wokIJS1vyXripgPQG5r2akjSXibPWGt9EBj0onVm8C4o3dBWRZ3eyPib9xOgFhK4dpFe+0w9OZB/wHJLghOAGX+eJ0+6t5PyJJQjfPV60eFALytz789z0mSem8sYKIo2F+a6PH92OZLounjsMKV3cT3L0kyGiadoCIOEt22XUGnKbzvs+BPVfuXWBwdfs3VdNC6SYKcsjEMFinEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MnWG06n9AwTkYY2Osnd/4GdwXxj9XUQkD5szCv6O+o=;
 b=EYK19YBk3PFT6vUFmT3pOdkoZ8ZqDcGrUf0YgOOT6+H8W34B1Iq9GeUqlgjjVxSJNhW+ZGu4st5kJ0XikkIDvddli2ejPCsJ5u+oXrJze/ESdKU8FdlPlfTbtFlS/JRDIET9skhZwUgCdq1WAhCSCpMdqhyP8+knVcTvZ+qPcrvzfg/QF5Hu4CfsTlA+JeFy3jxnkbYsejnGkc0s52uIxwSqTwf+rjL8hXfuLK/mHYfMSyUckb51vSATQYjxdAh8rY9pi5Z4Gvm4jV2RFlOzC978Cync1SVPeIve2l3U47qUhPuwiESZbLl8OyDtAgxPMPsfe/Y7iHRgg62a0VRf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MnWG06n9AwTkYY2Osnd/4GdwXxj9XUQkD5szCv6O+o=;
 b=gNgXUJdtjFaaoAlfd99ms7BLiucB99vB0vsRCIlx0soxuJpBuQzVZ4G5Xe35eMybfVxV5kbpHBTYsbSNT0InSeYyD0Y5CitW2mH8tTUi+21fv7woiezVTeMH2bEkBbsoDi44nSTxw78tFXcGvx2FQyXE2lCoWx/1j09jCuqwG6U=
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 22:06:24 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::50) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 22:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Tue, 19 May 2026 22:06:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:17 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 19 May 2026 17:06:17 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Li <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>,
 <Aurabindo.Pillai@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <michel.daenzer@mailbox.org>, <alexander.deucher@amd.com>
Subject: [PATCH v2 3/3] drm/amd/display: Check for flip completion in OTG
 interrupt handlers
Date: Tue, 19 May 2026 18:04:44 -0400
Message-ID: <20260519220529.202096-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519220529.202096-1-sunpeng.li@amd.com>
References: <20260519220529.202096-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddfbe58-6bcc-4aed-bf97-08deb5f2de27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|32650700020|13003099007|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ZAtfxRLECFHvj9GTl2ysZGqp3Y51tBLbkSEci2EkFjh6ycpfu6AVPeBNpMpNWFJLOBeW0QGcsG8DghGNpP0iB5wdpk0x6AGzgWcMd/fZN8QRMqtqaUO7W8tC4bNIVYmBzn1/FWUsTxpk6eCecPuLhH18Lo58ync61Dwud+nFe40mUH8DbGkVNoigJUMR1mLwZEC4ne498e4xCcW6K4tGmVKFw2wsxd5YIgoDmcT85aCmtlpClovqANwELLhCVnr/ZXqM5FaAXW8K1w1tw1GHA0jHH7hN1BuagWmLFNJ502Kdm1w5Lap2bqRqG6rjFH/217b7wsNeIqY5a6qWNVi+k8myUi9SsGNnS8g9Tp38Rm3YhG6OoVUl+0u4xvpyf22pFnbPVe6W//hepLVrHhuA3WpWqgx9rQ/NVm0OGPrwrKlR2DJcWAIslCp5mUHeDz0Gudo76uovY8eEJBiFS4F0bUn9Z614Dv6cicA+NC/PRWMhh75tc1f3nQLq/G1lpLuA6SnEE+oXDH54tAolnWeC1rdt5jBE0rCgitqYRbo/ZHyg173obff8bx3eNHLlL8qq0QLoI4wQBft6fMWix86ckGpyOxYN7y88AW4LOM68dhMjTbxddlk5jLncj/R19cfIzUd+UgciuOk6ihBzBeC5TTkQtZQWgcbf4JILDgXjFsi6RboFIHWLMvMiuH+7TgLV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(32650700020)(13003099007)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K/woYwQ5iBe3Mf4+Fc5mdWxtzdO02MtAL3pBUqSUOjsUC3n4tMacFGmeLq4BFtNAsK6vc+3Xhfs4DWjnNEvJr44sq6kvzlk4EdJAWe0sFW/My4EsB2XY6dyAG5ADGGQ5kfGI/U1Soy87oWdSw11fa9+W4TVZy9JFiWzPq04Z2rnVSXRj++YL/pP9WHFAHZqjApxENrYSrq0Cj1HG1zLebK38ZmhRFP0gHWVhvqA9JRASk4yfAsMHseIPzbSMIbi1tVY66Eu7n3OB1JTA9AQ1qA5VgIdmot2e545faRyW07rYh+im90RCCLhNR7Zd8pLzh9ihL8+EvQp6D15ciC1gKIUnfJh2Gs2gK2rACTrwxz4DpCNm8PTgHPVy3ej5gt+yD2s8TXdvY6Rk8MwTw1co1lXwkKEzJjhz6YGZLwDwWhZBnkkQZHNiETmejT3QSfou
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:06:24.6231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddfbe58-6bcc-4aed-bf97-08deb5f2de27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

HUBP fires the pflip interrupt when it consumes the last programmed flip
address. However, when it is in dynamic power gating (DPG), the pflip
interrupt can be masked. If the flip addr is programmed prior to HUBP
fully exiting DPG, the pflip interrupt may never fire.

This was observed on some PSR systems, where PSR exit in FW did not
fully complete before programming the flip address.

[How]

DC has a function for checking the flip status of a plane. DM can
consult it in one of the OTG interrupts -- which will fire regardless of
HUBP status -- as a backup for delivering events.

First, DM needs to track the dc_plane on which the flip was programmed.
Introduce a dc_plane_state flip_target on the acrtc to do so, following
the existing acrtc->pflip_status lifecycle.

Then, in the OTG interrupt handlers, check if the flip_target plane has
any pending flips. If a flip was armed, and there aren't any pending
flips (indicating that HUBP consumed the new flip addr but did not
deliver a pflip interrupt), then deliver and clear the armed flip.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Fixes: e45b6716de4b ("drm/amd/display: use a more lax vblank enable policy for DCN35+")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 +++++++++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  8 +++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1daea5644d535..9df48ed69acb9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -427,6 +427,23 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 					   stream_update);
 }
 
+/**
+ * clear_flip_isr - clear armed flip after it's been handled
+ *
+ * See also prepare_flip_isr.
+ */
+static void clear_flip_isr(struct amdgpu_crtc *acrtc)
+{
+	assert_spin_locked(&acrtc->base.dev->event_lock);
+
+	WARN_ON(acrtc->pflip_status == AMDGPU_FLIP_NONE);
+	WARN_ON(acrtc->dm_irq_params.flip_target == NULL);
+
+	acrtc->pflip_status = AMDGPU_FLIP_NONE;
+	dc_plane_state_release(acrtc->dm_irq_params.flip_target);
+	acrtc->dm_irq_params.flip_target = NULL;
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -523,7 +540,8 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	amdgpu_crtc->dm_irq_params.last_flip_vblank =
 		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
 
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
+	clear_flip_isr(amdgpu_crtc);
+
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
 	drm_dbg_state(dev,
@@ -750,7 +768,37 @@ static void __dm_crtc_high_irq(void *interrupt_params,
 			acrtc->event = NULL;
 			drm_crtc_vblank_put(&acrtc->base);
 		}
-		acrtc->pflip_status = AMDGPU_FLIP_NONE;
+		clear_flip_isr(acrtc);
+	}
+
+	/*
+	 * If pflip irq failed to fire (possible if HW master update lock is
+	 * held, or HUBP was in DPG when flip was programmed), check if HUBP
+	 * consumed the fb addr. If so, send the event here.
+	 *
+	 * Not applicable to DCE HW with no pflip interrupts.
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0 &&
+	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {
+		const struct dc_plane_status *status;
+		union dc_plane_status_update_flags flags = {0};
+
+		flags.bits.address = 1;
+		/*
+		 * Note that dc_plane_get_status() has a built-in IPS exit from
+		 * non-sleep context. That's ok though, since if interrupts are
+		 * active, then HW is not in IPS. Otherwise, this would have
+		 * been illegal.
+		 */
+		status = dc_plane_get_status(acrtc->dm_irq_params.flip_target,
+					     flags);
+
+		if (!status->is_flip_pending && acrtc->event) {
+			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
+			acrtc->event = NULL;
+			drm_crtc_vblank_put(&acrtc->base);
+		}
+		clear_flip_isr(acrtc);
 	}
 
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
@@ -9792,7 +9840,8 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
-static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
+static void prepare_flip_isr(struct amdgpu_crtc *acrtc,
+			     struct dc_plane_state *flip_target)
 {
 
 	assert_spin_locked(&acrtc->base.dev->event_lock);
@@ -9806,6 +9855,9 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 	/* Mark this event as consumed */
 	acrtc->base.state->event = NULL;
 
+	dc_plane_state_retain(flip_target);
+	acrtc->dm_irq_params.flip_target = flip_target;
+
 	drm_dbg_state(acrtc->base.dev,
 		      "crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
 		      acrtc->crtc_id);
@@ -10162,6 +10214,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(new_pcrtc_state);
 	struct dm_crtc_state *dm_old_crtc_state =
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
+	struct dc_plane_state *flip_target = NULL;
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
 	u32 target_vblank, last_flip_vblank;
@@ -10269,6 +10322,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 		}
 
+		flip_target = dc_plane;
+
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
 			afb->tiling_flags,
@@ -10414,7 +10469,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 
 			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
-			prepare_flip_isr(acrtc_attach);
+			prepare_flip_isr(acrtc_attach, flip_target);
 
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index f0c1b0c1faa9f..233a6462f0826 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -33,6 +33,14 @@ struct dm_irq_params {
 	u32 last_flip_vblank;
 	struct mod_vrr_params vrr_params;
 	struct dc_stream_state *stream;
+
+	/*
+	 * If not NULL, the plane for which a flip interrupt is expected. For
+	 * multi-plane configurations, this should be a plane that had it's fb
+	 * address updated. See also &prepare_flip_isr() and &clear_flip_isr()
+	 */
+	struct dc_plane_state *flip_target;
+
 	int active_planes;
 	bool allow_sr_entry;
 	struct mod_freesync_config freesync_config;
-- 
2.53.0

