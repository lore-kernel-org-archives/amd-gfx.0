Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C0CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DFD10E84A;
	Wed, 10 Jun 2026 09:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="10UcsupG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B89710E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+uQzLsa4Svz0gfINg8pPTanufCRJMWOu2pIPLKpoK4CQ6abUcs8a+DS3CzBdeld+qLdOkFDHXxLh3DsFt3G0tLBk80836OAS4Aapd5o+I0pgBxd3Go8RdyskGWWylHiPwLxWmAgp3E4ssIRQuW3gjPaJl9Ga6YW340Xz9h2zUigK6VlcJNmNQ9XtmHST5fbDuEijiutrBbKJBYxsmUJIYPz6/6fJHC65jOzG2b+10Ydi0OtQnb202n5lQYKjYx2IREgCAlw82zsi2AurWV6chz/AjnF3zsUItHUi7qPqvwoSMfo5xIIKsRnq8tJ08FecyeLOUaVEdRp4ycpf4pB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqx7nTV9CXeHNdbVnmOKWEFsQVlxK0xdwJHZdAbU80g=;
 b=FkLJCpKVRrVIDipoULvGPMi2d3Y0G765jmVgPZ8TZvhpOuLmKlVI7Hxh6c6bBTcYKnqYCxdxqJ0+6VaTsVCC5NiIJk/o+oDe/7wjaAa0+PWqdbbIS032yisWD6o0UU0ykGnDNl6e9mmkDsOMY93Kg6pu26MsheavebElhpB7qSs+poJ4Pnw80vgjoZ6F58+tRWJ5nQudAUrEp8kzskbZw+UgUW2u3MIxxVhs0SgYn1e5nLyDoaUCohcnQ4CBaIvUWqWvSnBGTxc/HsGA5hc7dME+ltSOoYtbgwQ4qQj+ufmRjBDacEeshajdi7RPN42BEJFlrucyAL71zOI7IhAH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqx7nTV9CXeHNdbVnmOKWEFsQVlxK0xdwJHZdAbU80g=;
 b=10UcsupGasoQFa9cw4A6NfmPdikrmv/43A3q/fMASvatmMUid2/PWVTKeTKTVFmSADLIj1r9ncdgv5ftuXxIg3nhyTKs4Yk8sYuJl3VecsDwTvP8T43Zk9Hk4AF6vKsQf4J49K8yOuRajBCRyo4EG90fmymFXKm0DIFlErY3hZw=
Received: from SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:49:29 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::88) by SN7PR04CA0089.outlook.office365.com
 (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:49:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:27 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:49:18 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 10/32] drm/amd/display: Move HPD and IRQ handler code to
 amdgpu_dm_irq
Date: Wed, 10 Jun 2026 17:44:54 +0800
Message-ID: <20260610094639.1965367-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a6a830-7c0e-44ff-1ecc-08dec6d5905a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|13003099007|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: NZIDRjmSua/GOVnSyQ8hlHmn+89NINXr05zI/vq69Bcs6fwU7MGhOeex04L8soPi9O8yu0oi3AaYWbrmF4OcQk3zJQ8+I9UvuDrBFaPNAvDrYbCpkPF6hv/VItK9gj2755C3fWtGo/Y3Zf1wkIdgpgd0E2Dlnbs93A8NurjMGmN4XMGnv8z6HEmuWmupDsbbkilLAs+BRYjY8ewQABJ8KvCJPrMm8L5IEvfDWCwpIypUsZTYy+87tksBWV49rJMBEh+rfzOiF/TI+EjEoxX2k2oWbTGMKNv0LDiOpYOX+quwsYX04mqduq8gpPCI90EItD7E1ldgtjiNZbnLJPwJ/Sa2hJlksMHug4wDOx/9nZxOa8q0dE5MOUVgOuEjHBw2NMLi9AebcuiN/9zrd6CXp5Vx0Je2MDtCCHqlh8ChAKlVU58eqndXERDE6p6R7GP2rnQ3w9s9h3NUTGDP/5+5UPec9v52snfwjWLIjys2lvzbVJkE89tE2RSLVNgTRkjlBWi0cBG8ZlaQ1LpzzGRa7im0u1WAZSNLXwUWk62eTUdlVPcPQHhzGoj0NrvUGE+76hlmN8eI9Z36jlW3IDYsItn/V078rzwcA5VSsZhmJlKiJn0Ry57QjB4Mv6gxVoIR/T/B4I5Zt93z9CY2q0X3+LZ6F2VuRZ+G8KIWm1ZxEt9DfUWgFG7nD4z4Iup2clNhaOkOPs3Jm0yv7h4bGsvCluHGUkXjVMnduNvb6v3IShY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NkVWSm8kL1hpQ1Sat0T96/SLaeY2/BeNQqPqrhuxAzDnfb3zcOt5vbBYO7/ccoqxrTrddC/m6doHqgnQJcApPye4ZarKWPkCPD9INnFh4XUE95syZFRghwafqGa8EwuLYpyA3ghQfKIhTbJqaUWz+VBYcwc5exIJFimKBKOpTosHuPNyPptOLzWEpcTXzSOLCpTQVNDppN3PKhw3vJl0rCq7Gqg5aTiPXvUxQqdFyt/b5Whbzf8CmF4brxR8+cadf2aVWKZyrkGqyW6xHw7+hEa1qgFt5KJKdqyU/zVHI26m6bPZjQzguCwXw7jaiGk5EuSxB5fJbj3BFu2DV3piYr6xgVuNwOmCJry1S21g8CFzWZsA/e6ZSBlM6VoczvFJz8fUF1hVtrzcYRVzW/U3X+ruiLwA6lyBkVBYImaYtSHd2+LgvlZK9cIN0C6zMbM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:49:28.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a6a830-7c0e-44ff-1ecc-08dec6d5905a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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

Move HPD handling (workqueue creation, debounce, handler registration)
and IRQ handler callbacks (vblank, pflip, vupdate, vline0, outbox) from
amdgpu_dm.c into the existing amdgpu_dm_irq.c. This keeps all
IRQ-related code together rather than creating additional files.

No functional change intended.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1540 +----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    4 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 1500 +++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   19 +
 4 files changed, 1551 insertions(+), 1512 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7090e366f85f..c247f64681dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -193,10 +193,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
 
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
-				  enum dc_detect_reason reason);
-static void handle_hpd_rx_irq(void *param);
-
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -291,27 +287,6 @@ static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static struct amdgpu_crtc *
-get_crtc_by_otg_inst(struct amdgpu_device *adev,
-		     int otg_inst)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-
-	if (WARN_ON(otg_inst == -1))
-		return adev->mode_info.crtcs[0];
-
-	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-		amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-		if (amdgpu_crtc->otg_inst == otg_inst)
-			return amdgpu_crtc;
-	}
-
-	return NULL;
-}
-
 static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					      struct dm_crtc_state *new_state)
 {
@@ -378,563 +353,6 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 					   stream_update);
 }
 
-/**
- * dm_pflip_high_irq() - Handle pageflip interrupt
- * @interrupt_params: ignored
- *
- * Handles the pageflip interrupt by notifying all interested parties
- * that the pageflip has been completed.
- */
-static void dm_pflip_high_irq(void *interrupt_params)
-{
-	struct amdgpu_crtc *amdgpu_crtc;
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct drm_device *dev = adev_to_drm(adev);
-	unsigned long flags;
-	struct drm_pending_vblank_event *e;
-	u32 vpos, hpos, v_blank_start, v_blank_end;
-	bool vrr_active;
-
-	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
-
-	/* IRQ could occur when in initial stage */
-	/* TODO work and BO cleanup */
-	if (amdgpu_crtc == NULL) {
-		drm_dbg_state(dev, "CRTC is null, returning.\n");
-		return;
-	}
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
-		drm_dbg_state(dev,
-			      "amdgpu_crtc->pflip_status = %d != AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
-			      amdgpu_crtc->pflip_status, AMDGPU_FLIP_SUBMITTED,
-			      amdgpu_crtc->crtc_id, amdgpu_crtc);
-		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-		return;
-	}
-
-	/* page flip completed. */
-	e = amdgpu_crtc->event;
-	amdgpu_crtc->event = NULL;
-
-	WARN_ON(!e);
-
-	vrr_active = amdgpu_dm_crtc_vrr_active_irq(amdgpu_crtc);
-
-	/* Fixed refresh rate, or VRR scanout position outside front-porch? */
-	if (!vrr_active ||
-	    !dc_stream_get_scanoutpos(amdgpu_crtc->dm_irq_params.stream, &v_blank_start,
-				      &v_blank_end, &hpos, &vpos) ||
-	    (vpos < v_blank_start)) {
-		/* Update to correct count and vblank timestamp if racing with
-		 * vblank irq. This also updates to the correct vblank timestamp
-		 * even in VRR mode, as scanout is past the front-porch atm.
-		 */
-		drm_crtc_accurate_vblank_count(&amdgpu_crtc->base);
-
-		/* Wake up userspace by sending the pageflip event with proper
-		 * count and timestamp of vblank of flip completion.
-		 */
-		if (e) {
-			drm_crtc_send_vblank_event(&amdgpu_crtc->base, e);
-
-			/* Event sent, so done with vblank for this flip */
-			drm_crtc_vblank_put(&amdgpu_crtc->base);
-		}
-	} else if (e) {
-		/* VRR active and inside front-porch: vblank count and
-		 * timestamp for pageflip event will only be up to date after
-		 * drm_crtc_handle_vblank() has been executed from late vblank
-		 * irq handler after start of back-porch (vline 0). We queue the
-		 * pageflip event for send-out by drm_crtc_handle_vblank() with
-		 * updated timestamp and count, once it runs after us.
-		 *
-		 * We need to open-code this instead of using the helper
-		 * drm_crtc_arm_vblank_event(), as that helper would
-		 * call drm_crtc_accurate_vblank_count(), which we must
-		 * not call in VRR mode while we are in front-porch!
-		 */
-
-		/* sequence will be replaced by real count during send-out. */
-		e->sequence = drm_crtc_vblank_count(&amdgpu_crtc->base);
-		e->pipe = amdgpu_crtc->crtc_id;
-
-		list_add_tail(&e->base.link, &adev_to_drm(adev)->vblank_event_list);
-		e = NULL;
-	}
-
-	/* Keep track of vblank of this flip for flip throttling. We use the
-	 * cooked hw counter, as that one incremented at start of this vblank
-	 * of pageflip completion, so last_flip_vblank is the forbidden count
-	 * for queueing new pageflips if vsync + VRR is enabled.
-	 */
-	amdgpu_crtc->dm_irq_params.last_flip_vblank =
-		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
-
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-
-	drm_dbg_state(dev,
-		      "crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
-		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
-}
-
-static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
-{
-	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
-	struct amdgpu_device *adev = work->adev;
-	struct dc_stream_state *stream = work->stream;
-	struct dc_crtc_timing_adjust *adjust = work->adjust;
-
-	mutex_lock(&adev->dm.dc_lock);
-	dc_stream_adjust_vmin_vmax(adev->dm.dc, stream, adjust);
-	mutex_unlock(&adev->dm.dc_lock);
-
-	dc_stream_release(stream);
-	kfree(work->adjust);
-	kfree(work);
-}
-
-static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
-	struct dc_stream_state *stream,
-	struct dc_crtc_timing_adjust *adjust)
-{
-	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_NOWAIT);
-	if (!offload_work) {
-		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
-		return;
-	}
-
-	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_NOWAIT);
-	if (!adjust_copy) {
-		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
-		kfree(offload_work);
-		return;
-	}
-
-	dc_stream_retain(stream);
-	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
-
-	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
-	offload_work->adev = adev;
-	offload_work->stream = stream;
-	offload_work->adjust = adjust_copy;
-
-	queue_work(system_percpu_wq, &offload_work->work);
-}
-
-static void dm_vupdate_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_crtc *acrtc;
-	struct drm_device *drm_dev;
-	struct drm_vblank_crtc *vblank;
-	ktime_t frame_duration_ns, previous_timestamp;
-	unsigned long flags;
-	int vrr_active;
-
-	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
-
-	if (acrtc) {
-		vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
-		drm_dev = acrtc->base.dev;
-		vblank = drm_crtc_vblank_crtc(&acrtc->base);
-		previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
-		frame_duration_ns = vblank->time - previous_timestamp;
-
-		if (frame_duration_ns > 0) {
-			trace_amdgpu_refresh_rate_track(acrtc->base.index,
-						frame_duration_ns,
-						ktime_divns(NSEC_PER_SEC, frame_duration_ns));
-			atomic64_set(&irq_params->previous_timestamp, vblank->time);
-		}
-
-		drm_dbg_vbl(drm_dev,
-			    "crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
-			    vrr_active);
-
-		/* Core vblank handling is done here after end of front-porch in
-		 * vrr mode, as vblank timestamping will give valid results
-		 * while now done after front-porch. This will also deliver
-		 * page-flip completion events that have been queued to us
-		 * if a pageflip happened inside front-porch.
-		 */
-		if (vrr_active && acrtc->dm_irq_params.stream) {
-			bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-			bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-			bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
-				== VRR_STATE_ACTIVE_VARIABLE;
-
-			amdgpu_dm_crtc_handle_vblank(acrtc);
-
-			/* BTR processing for pre-DCE12 ASICs */
-			if (adev->family < AMDGPU_FAMILY_AI) {
-				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-				mod_freesync_handle_v_update(
-				    adev->dm.freesync_module,
-				    acrtc->dm_irq_params.stream,
-				    &acrtc->dm_irq_params.vrr_params);
-
-				if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-					schedule_dc_vmin_vmax(adev,
-						acrtc->dm_irq_params.stream,
-						&acrtc->dm_irq_params.vrr_params.adjust);
-				}
-				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-			}
-		}
-	}
-}
-
-/**
- * dm_crtc_high_irq() - Handles CRTC interrupt
- * @interrupt_params: used for determining the CRTC instance
- *
- * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
- * event handler.
- */
-static void dm_crtc_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct drm_writeback_job *job;
-	struct amdgpu_crtc *acrtc;
-	unsigned long flags;
-	int vrr_active;
-
-	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
-	if (!acrtc)
-		return;
-
-	if (acrtc->wb_conn) {
-		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
-
-		if (acrtc->wb_pending) {
-			job = list_first_entry_or_null(&acrtc->wb_conn->job_queue,
-						       struct drm_writeback_job,
-						       list_entry);
-			acrtc->wb_pending = false;
-			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
-
-			if (job) {
-				unsigned int v_total, refresh_hz;
-				struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
-
-				v_total = stream->adjust.v_total_max ?
-					  stream->adjust.v_total_max : stream->timing.v_total;
-				refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
-					     100LL, (v_total * stream->timing.h_total));
-				mdelay(1000 / refresh_hz);
-
-				drm_writeback_signal_completion(acrtc->wb_conn, 0);
-				dc_stream_fc_disable_writeback(adev->dm.dc,
-							       acrtc->dm_irq_params.stream, 0);
-			}
-		} else
-			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
-	}
-
-	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
-
-	drm_dbg_vbl(adev_to_drm(adev),
-		    "crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
-		    vrr_active, acrtc->dm_irq_params.active_planes);
-
-	/**
-	 * Core vblank handling at start of front-porch is only possible
-	 * in non-vrr mode, as only there vblank timestamping will give
-	 * valid results while done in front-porch. Otherwise defer it
-	 * to dm_vupdate_high_irq after end of front-porch.
-	 */
-	if (!vrr_active)
-		amdgpu_dm_crtc_handle_vblank(acrtc);
-
-	/**
-	 * Following stuff must happen at start of vblank, for crc
-	 * computation and below-the-range btr support in vrr mode.
-	 */
-	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
-
-	/* BTR updates need to happen before VUPDATE on Vega and above. */
-	if (adev->family < AMDGPU_FAMILY_AI)
-		return;
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-
-	if (acrtc->dm_irq_params.stream &&
-		acrtc->dm_irq_params.vrr_params.supported) {
-		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
-
-		mod_freesync_handle_v_update(adev->dm.freesync_module,
-					     acrtc->dm_irq_params.stream,
-					     &acrtc->dm_irq_params.vrr_params);
-
-		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
-		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-			schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
-					&acrtc->dm_irq_params.vrr_params.adjust);
-		}
-	}
-
-	/*
-	 * If there aren't any active_planes then DCH HUBP may be clock-gated.
-	 * In that case, pageflip completion interrupts won't fire and pageflip
-	 * completion events won't get delivered. Prevent this by sending
-	 * pending pageflip events from here if a flip is still pending.
-	 *
-	 * If any planes are enabled, use dm_pflip_high_irq() instead, to
-	 * avoid race conditions between flip programming and completion,
-	 * which could cause too early flip completion events.
-	 */
-	if (adev->family >= AMDGPU_FAMILY_RV &&
-	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
-	    acrtc->dm_irq_params.active_planes == 0) {
-		if (acrtc->event) {
-			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
-			acrtc->event = NULL;
-			drm_crtc_vblank_put(&acrtc->base);
-		}
-		acrtc->pflip_status = AMDGPU_FLIP_NONE;
-	}
-
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-}
-
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-/**
- * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
- * DCN generation ASICs
- * @interrupt_params: interrupt parameters
- *
- * Used to set crc window/read out crc value at vertical line 0 position
- */
-static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_crtc *acrtc;
-
-	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VLINE0);
-
-	if (!acrtc)
-		return;
-
-	amdgpu_dm_crtc_handle_crc_window_irq(&acrtc->base);
-}
-#endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
-
-/**
- * dmub_hpd_callback - DMUB HPD interrupt processing callback.
- * @adev: amdgpu_device pointer
- * @notify: dmub notification structure
- *
- * Dmub Hpd interrupt processing callback. Gets displayindex through the
- * ink index and calls helper to do the processing.
- */
-static void dmub_hpd_callback(struct amdgpu_device *adev,
-			      struct dmub_notification *notify)
-{
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_dm_connector *hpd_aconnector = NULL;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
-	struct dc_link *link;
-	u8 link_index = 0;
-	struct drm_device *dev;
-
-	if (adev == NULL)
-		return;
-
-	if (notify == NULL) {
-		drm_err(adev_to_drm(adev), "DMUB HPD callback notification was NULL");
-		return;
-	}
-
-	if (notify->link_index > adev->dm.dc->link_count) {
-		drm_err(adev_to_drm(adev), "DMUB HPD index (%u)is abnormal", notify->link_index);
-		return;
-	}
-
-	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
-	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
-		drm_info(adev_to_drm(adev), "Skip DMUB HPD IRQ callback in suspend/resume\n");
-		return;
-	}
-
-	link_index = notify->link_index;
-	link = adev->dm.dc->links[link_index];
-	dev = adev->dm.ddev;
-
-	drm_connector_list_iter_begin(dev, &iter);
-	drm_for_each_connector_iter(connector, &iter) {
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-			continue;
-
-		aconnector = to_amdgpu_dm_connector(connector);
-		if (link && aconnector->dc_link == link) {
-			if (notify->type == DMUB_NOTIFICATION_HPD)
-				drm_info(adev_to_drm(adev), "DMUB HPD IRQ callback: link_index=%u\n", link_index);
-			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
-				drm_info(adev_to_drm(adev), "DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
-			else
-				drm_warn(adev_to_drm(adev), "DMUB Unknown HPD callback type %d, link_index=%u\n",
-						notify->type, link_index);
-
-			hpd_aconnector = aconnector;
-			break;
-		}
-	}
-	drm_connector_list_iter_end(&iter);
-
-	if (hpd_aconnector) {
-		if (notify->type == DMUB_NOTIFICATION_HPD) {
-			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
-				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link_index=%u\n", link_index);
-			handle_hpd_irq_helper(hpd_aconnector, DETECT_REASON_HPD);
-		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
-			handle_hpd_rx_irq(hpd_aconnector);
-		}
-	}
-}
-
-/**
- * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
- * @adev: amdgpu_device pointer
- * @notify: dmub notification structure
- *
- * HPD sense changes can occur during low power states and need to be
- * notified from firmware to driver.
- */
-static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
-			      struct dmub_notification *notify)
-{
-	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
-}
-
-static void dm_handle_hpd_work(struct work_struct *work)
-{
-	struct dmub_hpd_work *dmub_hpd_wrk;
-
-	dmub_hpd_wrk = container_of(work, struct dmub_hpd_work, handle_hpd_work);
-
-	if (!dmub_hpd_wrk->dmub_notify) {
-		drm_err(adev_to_drm(dmub_hpd_wrk->adev), "dmub_hpd_wrk dmub_notify is NULL");
-		return;
-	}
-
-	if (dmub_hpd_wrk->dmub_notify->type < ARRAY_SIZE(dmub_hpd_wrk->adev->dm.dmub_callback)) {
-		dmub_hpd_wrk->adev->dm.dmub_callback[dmub_hpd_wrk->dmub_notify->type](dmub_hpd_wrk->adev,
-		dmub_hpd_wrk->dmub_notify);
-	}
-
-	kfree(dmub_hpd_wrk->dmub_notify);
-	kfree(dmub_hpd_wrk);
-
-}
-
-static const char *dmub_notification_type_str(enum dmub_notification_type e)
-{
-	switch (e) {
-	case DMUB_NOTIFICATION_NO_DATA:
-		return "NO_DATA";
-	case DMUB_NOTIFICATION_AUX_REPLY:
-		return "AUX_REPLY";
-	case DMUB_NOTIFICATION_HPD:
-		return "HPD";
-	case DMUB_NOTIFICATION_HPD_IRQ:
-		return "HPD_IRQ";
-	case DMUB_NOTIFICATION_SET_CONFIG_REPLY:
-		return "SET_CONFIG_REPLY";
-	case DMUB_NOTIFICATION_DPIA_NOTIFICATION:
-		return "DPIA_NOTIFICATION";
-	case DMUB_NOTIFICATION_HPD_SENSE_NOTIFY:
-		return "HPD_SENSE_NOTIFY";
-	case DMUB_NOTIFICATION_FUSED_IO:
-		return "FUSED_IO";
-	default:
-		return "<unknown>";
-	}
-}
-
-#define DMUB_TRACE_MAX_READ 64
-/**
- * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
- * @interrupt_params: used for determining the Outbox instance
- *
- * Handles the Outbox Interrupt
- * event handler.
- */
-static void dm_dmub_outbox1_low_irq(void *interrupt_params)
-{
-	struct dmub_notification notify = {0};
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_display_manager *dm = &adev->dm;
-	struct dmcub_trace_buf_entry entry = { 0 };
-	u32 count = 0;
-	struct dmub_hpd_work *dmub_hpd_wrk;
-
-	do {
-		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
-			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
-							entry.param0, entry.param1);
-
-			drm_dbg_driver(adev_to_drm(adev), "trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
-				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
-		} else
-			break;
-
-		count++;
-
-	} while (count <= DMUB_TRACE_MAX_READ);
-
-	if (count > DMUB_TRACE_MAX_READ)
-		drm_dbg_driver(adev_to_drm(adev), "Warning : count > DMUB_TRACE_MAX_READ");
-
-	if (dc_enable_dmub_notifications(adev->dm.dc) &&
-		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
-
-		do {
-			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
-			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
-				drm_err(adev_to_drm(adev), "DM: notify type %d invalid!", notify.type);
-				continue;
-			}
-			if (!dm->dmub_callback[notify.type]) {
-				drm_warn(adev_to_drm(adev), "DMUB notification skipped due to no handler: type=%s\n",
-					dmub_notification_type_str(notify.type));
-				continue;
-			}
-			if (dm->dmub_thread_offload[notify.type] == true) {
-				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
-				if (!dmub_hpd_wrk) {
-					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk");
-					return;
-				}
-				dmub_hpd_wrk->dmub_notify = kmemdup(&notify, sizeof(struct dmub_notification),
-								    GFP_ATOMIC);
-				if (!dmub_hpd_wrk->dmub_notify) {
-					kfree(dmub_hpd_wrk);
-					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk->dmub_notify");
-					return;
-				}
-				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
-				dmub_hpd_wrk->adev = adev;
-				queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
-			} else {
-				dm->dmub_callback[notify.type](adev, &notify);
-			}
-		} while (notify.pending_notification);
-	}
-}
-
 static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		  enum amd_clockgating_state state)
 {
@@ -1067,168 +485,23 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
-static void force_connector_state(
-	struct amdgpu_dm_connector *aconnector,
-	enum drm_connector_force force_state)
-{
-	struct drm_connector *connector = &aconnector->base;
-
-	mutex_lock(&connector->dev->mode_config.mutex);
-	aconnector->base.force = force_state;
-	mutex_unlock(&connector->dev->mode_config.mutex);
+struct amdgpu_stutter_quirk {
+	u16 chip_vendor;
+	u16 chip_device;
+	u16 subsys_vendor;
+	u16 subsys_device;
+	u8 revision;
+};
 
-	mutex_lock(&aconnector->hpd_lock);
-	drm_kms_helper_connector_hotplug_event(connector);
-	mutex_unlock(&aconnector->hpd_lock);
-}
+static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	{ 0, 0, 0, 0, 0 },
+};
 
-static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+static bool dm_should_disable_stutter(struct pci_dev *pdev)
 {
-	struct hpd_rx_irq_offload_work *offload_work;
-	struct amdgpu_dm_connector *aconnector;
-	struct dc_link *dc_link;
-	struct amdgpu_device *adev;
-	enum dc_connection_type new_connection_type = dc_connection_none;
-	unsigned long flags;
-	union test_response test_response;
-
-	memset(&test_response, 0, sizeof(test_response));
-
-	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
-	aconnector = offload_work->offload_wq->aconnector;
-	adev = offload_work->adev;
-
-	if (!aconnector) {
-		drm_err(adev_to_drm(adev), "Can't retrieve aconnector in hpd_rx_irq_offload_work");
-		goto skip;
-	}
-
-	dc_link = aconnector->dc_link;
-
-	mutex_lock(&aconnector->hpd_lock);
-	if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-	mutex_unlock(&aconnector->hpd_lock);
-
-	if (new_connection_type == dc_connection_none)
-		goto skip;
-
-	if (amdgpu_in_reset(adev))
-		goto skip;
-
-	if (offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
-		offload_work->data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
-		dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_OR_UP_MSG_RDY_EVENT);
-		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
-		offload_work->offload_wq->is_handling_mst_msg_rdy_event = false;
-		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
-		goto skip;
-	}
-
-	mutex_lock(&adev->dm.dc_lock);
-	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
-		dc_link_dp_handle_automated_test(dc_link);
-
-		if (aconnector->timing_changed) {
-			/* force connector disconnect and reconnect */
-			force_connector_state(aconnector, DRM_FORCE_OFF);
-			msleep(100);
-			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
-		}
-
-		test_response.bits.ACK = 1;
-
-		core_link_write_dpcd(
-		dc_link,
-		DP_TEST_RESPONSE,
-		&test_response.raw,
-		sizeof(test_response));
-	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
-			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
-			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		/* offload_work->data is from handle_hpd_rx_irq->
-		 * schedule_hpd_rx_offload_work.this is defer handle
-		 * for hpd short pulse. upon here, link status may be
-		 * changed, need get latest link status from dpcd
-		 * registers. if link status is good, skip run link
-		 * training again.
-		 */
-		union hpd_irq_data irq_data;
-
-		memset(&irq_data, 0, sizeof(irq_data));
-
-		/* before dc_link_dp_handle_link_loss, allow new link lost handle
-		 * request be added to work queue if link lost at end of dc_link_
-		 * dp_handle_link_loss
-		 */
-		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
-		offload_work->offload_wq->is_handling_link_loss = false;
-		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
-
-		if ((dc_link_dp_read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
-			dc_link_check_link_loss_status(dc_link, &irq_data))
-			dc_link_dp_handle_link_loss(dc_link);
-	}
-	mutex_unlock(&adev->dm.dc_lock);
-
-skip:
-	kfree(offload_work);
-
-}
-
-static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct amdgpu_device *adev)
-{
-	struct dc *dc = adev->dm.dc;
-	int max_caps = dc->caps.max_links;
-	int i = 0;
-	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq = NULL;
-
-	hpd_rx_offload_wq = kcalloc(max_caps, sizeof(*hpd_rx_offload_wq), GFP_KERNEL);
-
-	if (!hpd_rx_offload_wq)
-		return NULL;
-
-
-	for (i = 0; i < max_caps; i++) {
-		hpd_rx_offload_wq[i].wq =
-				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
-
-		if (hpd_rx_offload_wq[i].wq == NULL) {
-			drm_err(adev_to_drm(adev), "create amdgpu_dm_hpd_rx_offload_wq fail!");
-			goto out_err;
-		}
-
-		spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
-	}
-
-	return hpd_rx_offload_wq;
-
-out_err:
-	for (i = 0; i < max_caps; i++) {
-		if (hpd_rx_offload_wq[i].wq)
-			destroy_workqueue(hpd_rx_offload_wq[i].wq);
-	}
-	kfree(hpd_rx_offload_wq);
-	return NULL;
-}
-
-struct amdgpu_stutter_quirk {
-	u16 chip_vendor;
-	u16 chip_device;
-	u16 subsys_vendor;
-	u16 subsys_device;
-	u8 revision;
-};
-
-static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
-	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
-	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
-	{ 0, 0, 0, 0, 0 },
-};
-
-static bool dm_should_disable_stutter(struct pci_dev *pdev)
-{
-	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
+	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
 
 	while (p && p->chip_device != 0) {
 		if (pdev->vendor == p->chip_vendor &&
@@ -1621,7 +894,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
+	adev->dm.hpd_rx_offload_wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
 		goto error;
@@ -1708,7 +981,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
 		 * It is expected that DMUB will resend any pending notifications at this point. Note
-		 * that hpd and hpd_irq handler registration are deferred to register_hpd_handlers() to
+		 * that hpd and hpd_irq handler registration are deferred to amdgpu_dm_register_hpd_handlers() to
 		 * align legacy interface initialization sequence. Connection status will be proactivly
 		 * detected once in the amdgpu_dm_initialize_drm_device.
 		 */
@@ -2458,7 +1731,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 	int i = 0;
 
 	for (i = 0; i < state->stream_count; i++) {
-		acrtc = get_crtc_by_otg_inst(
+		acrtc = amdgpu_dm_get_crtc_by_otg_inst(
 				adev, state->stream_status[i].primary_otg_inst);
 
 		if (acrtc && state->stream_status[i].plane_count != 0) {
@@ -2535,16 +1808,6 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 	return dc_commit_streams(dc, &params);
 }
 
-static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
-{
-	int i;
-
-	if (dm->hpd_rx_offload_wq) {
-		for (i = 0; i < dm->dc->caps.max_links; i++)
-			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
-	}
-}
-
 static int dm_cache_state(struct amdgpu_device *adev)
 {
 	int r;
@@ -2640,7 +1903,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 		amdgpu_dm_irq_suspend(adev);
 
-		hpd_rx_irq_work_suspend(dm);
+		amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
 		return 0;
 	}
@@ -2666,7 +1929,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	scoped_guard(mutex, &dm->dc_lock)
 		amdgpu_dm_ism_force_full_power(dm);
 
-	hpd_rx_irq_work_suspend(dm);
+	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
@@ -2697,7 +1960,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 	return NULL;
 }
 
-static void emulated_link_detect(struct dc_link *link)
+void amdgpu_dm_emulated_link_detect(struct dc_link *link)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct display_sink_capability sink_caps = { 0 };
@@ -2818,8 +2081,8 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	}
 }
 
-static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
-					    struct dc_sink *sink)
+void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
+											   struct dc_sink *sink)
 {
 	struct dc_panel_patch *ppatch = NULL;
 
@@ -3061,14 +2324,14 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
-			emulated_link_detect(aconnector->dc_link);
+			amdgpu_dm_emulated_link_detect(aconnector->dc_link);
 		} else {
 			guard(mutex)(&dm->dc_lock);
 			dc_exit_ips_for_hw_access(dm->dc);
 			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			if (ret) {
 				/* w/a delay for certain panels */
-				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+				amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
 			}
 		}
 
@@ -3389,751 +2652,6 @@ void amdgpu_dm_update_connector_after_detect(
 		mutex_unlock(&dev->mode_config.mutex);
 }
 
-static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
-{
-	if (!sink1 || !sink2)
-		return false;
-	if (sink1->sink_signal != sink2->sink_signal)
-		return false;
-
-	if (sink1->dc_edid.length != sink2->dc_edid.length)
-		return false;
-
-	if (memcmp(sink1->dc_edid.raw_edid, sink2->dc_edid.raw_edid,
-		   sink1->dc_edid.length) != 0)
-		return false;
-	return true;
-}
-
-
-/**
- * DOC: hdmi_hpd_debounce_work
- *
- * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
- * (such as during power save transitions), this delay determines how long to
- * wait before processing the HPD event. This allows distinguishing between a
- * physical unplug (>hdmi_hpd_debounce_delay)
- * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
- *
- * If the toggle is less than this delay, the driver compares sink capabilities
- * and permits a hotplug event if they changed.
- *
- * The default value of 1500ms was chosen based on experimental testing with
- * various monitors that exhibit spontaneous HPD toggling behavior.
- */
-static void hdmi_hpd_debounce_work(struct work_struct *work)
-{
-	struct amdgpu_dm_connector *aconnector =
-		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
-			     hdmi_hpd_debounce_work);
-	struct drm_connector *connector = &aconnector->base;
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct dc *dc = aconnector->dc_link->ctx->dc;
-	bool fake_reconnect = false;
-	bool reallow_idle = false;
-	bool ret = false;
-	guard(mutex)(&aconnector->hpd_lock);
-
-	/* Re-detect the display */
-	scoped_guard(mutex, &adev->dm.dc_lock) {
-		if (dc->caps.ips_support && dc->ctx->dmub_srv->idle_allowed) {
-			dc_allow_idle_optimizations(dc, false);
-			reallow_idle = true;
-		}
-		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
-	}
-
-	if (ret) {
-		/* Apply workaround delay for certain panels */
-		apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
-		/* Compare sinks to determine if this was a spontaneous HPD toggle */
-		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
-			/*
-			* Sinks match - this was a spontaneous HDMI HPD toggle.
-			*/
-			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
-			fake_reconnect = true;
-		}
-
-		/* Update connector state */
-		amdgpu_dm_update_connector_after_detect(aconnector);
-
-		drm_modeset_lock_all(dev);
-		dm_restore_drm_connector_state(dev, connector);
-		drm_modeset_unlock_all(dev);
-
-		/* Only notify OS if sink actually changed */
-		if (!fake_reconnect && aconnector->base.force == DRM_FORCE_UNSPECIFIED)
-			drm_kms_helper_hotplug_event(dev);
-	}
-
-	/* Release the cached sink reference */
-	if (aconnector->hdmi_prev_sink) {
-		dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = NULL;
-	}
-
-	scoped_guard(mutex, &adev->dm.dc_lock) {
-		if (reallow_idle && dc->caps.ips_support)
-			dc_allow_idle_optimizations(dc, true);
-	}
-}
-
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
-				  enum dc_detect_reason reason)
-{
-	struct drm_connector *connector = &aconnector->base;
-	struct drm_device *dev = connector->dev;
-	enum dc_connection_type new_connection_type = dc_connection_none;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
-	struct dc *dc = aconnector->dc_link->ctx->dc;
-	bool ret = false;
-	bool debounce_required = false;
-
-	if (adev->dm.disable_hpd_irq)
-		return;
-
-	/*
-	 * In case of failure or MST no need to update connector status or notify the OS
-	 * since (for MST case) MST does this in its own context.
-	 */
-	guard(mutex)(&aconnector->hpd_lock);
-
-	if (adev->dm.hdcp_workqueue) {
-		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
-		dm_con_state->update_hdcp = true;
-	}
-	if (aconnector->fake_enable)
-		aconnector->fake_enable = false;
-
-	aconnector->timing_changed = false;
-
-	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-
-	/*
-	 * Check for HDMI disconnect with debounce enabled.
-	 */
-	debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
-			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
-			      new_connection_type == dc_connection_none &&
-			      aconnector->dc_link->local_sink != NULL);
-
-	if (aconnector->base.force && new_connection_type == dc_connection_none) {
-		emulated_link_detect(aconnector->dc_link);
-
-		drm_modeset_lock_all(dev);
-		dm_restore_drm_connector_state(dev, connector);
-		drm_modeset_unlock_all(dev);
-
-		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
-		    reason == DETECT_REASON_HPDRX)
-			drm_kms_helper_connector_hotplug_event(connector);
-	} else if (debounce_required) {
-		/*
-		 * HDMI disconnect detected - schedule delayed work instead of
-		 * processing immediately. This allows us to coalesce spurious
-		 * HDMI signals from physical unplugs.
-		 */
-		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
-			    aconnector->hdmi_hpd_debounce_delay_ms);
-
-		/* Cache the current sink for later comparison */
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_retain(aconnector->hdmi_prev_sink);
-
-		/* Schedule delayed detection. */
-		if (mod_delayed_work(system_percpu_wq,
-				 &aconnector->hdmi_hpd_debounce_work,
-				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
-			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
-
-	} else {
-
-		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
-		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
-			return;
-
-		scoped_guard(mutex, &adev->dm.dc_lock) {
-			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(aconnector->dc_link, reason);
-		}
-		if (ret) {
-			/* w/a delay for certain panels */
-			apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
-			amdgpu_dm_update_connector_after_detect(aconnector);
-
-			drm_modeset_lock_all(dev);
-			dm_restore_drm_connector_state(dev, connector);
-			drm_modeset_unlock_all(dev);
-
-			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
-			    reason == DETECT_REASON_HPDRX)
-				drm_kms_helper_connector_hotplug_event(connector);
-		}
-	}
-}
-
-static void handle_hpd_irq(void *param)
-{
-	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
-
-	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
-
-}
-
-static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
-							union hpd_irq_data hpd_irq_data)
-{
-	struct hpd_rx_irq_offload_work *offload_work =
-				kzalloc(sizeof(*offload_work), GFP_KERNEL);
-
-	if (!offload_work) {
-		drm_err(adev_to_drm(adev), "Failed to allocate hpd_rx_irq_offload_work.\n");
-		return;
-	}
-
-	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
-	offload_work->data = hpd_irq_data;
-	offload_work->offload_wq = offload_wq;
-	offload_work->adev = adev;
-
-	queue_work(offload_wq->wq, &offload_work->work);
-	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work");
-}
-
-static void handle_hpd_rx_irq(void *param)
-{
-	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
-	struct drm_connector *connector = &aconnector->base;
-	struct drm_device *dev = connector->dev;
-	struct dc_link *dc_link = aconnector->dc_link;
-	bool is_mst_root_connector = aconnector->mst_mgr.mst_state;
-	bool result = false;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	union hpd_irq_data hpd_irq_data;
-	bool link_loss = false;
-	bool has_left_work = false;
-	int idx = dc_link->link_index;
-	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
-
-	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
-
-	if (adev->dm.disable_hpd_irq)
-		return;
-
-	/*
-	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
-	 * conflict, after implement i2c helper, this mutex should be
-	 * retired.
-	 */
-	mutex_lock(&aconnector->hpd_lock);
-
-	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data,
-						&link_loss, true, &has_left_work);
-
-	if (!has_left_work)
-		goto out;
-
-	if (hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
-		schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
-		goto out;
-	}
-
-	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
-			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
-			bool skip = false;
-
-			/*
-			 * DOWN_REP_MSG_RDY is also handled by polling method
-			 * mgr->cbs->poll_hpd_irq()
-			 */
-			spin_lock(&offload_wq->offload_lock);
-			skip = offload_wq->is_handling_mst_msg_rdy_event;
-
-			if (!skip)
-				offload_wq->is_handling_mst_msg_rdy_event = true;
-
-			spin_unlock(&offload_wq->offload_lock);
-
-			if (!skip)
-				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
-
-			goto out;
-		}
-
-		if (link_loss) {
-			bool skip = false;
-
-			spin_lock(&offload_wq->offload_lock);
-			skip = offload_wq->is_handling_link_loss;
-
-			if (!skip)
-				offload_wq->is_handling_link_loss = true;
-
-			spin_unlock(&offload_wq->offload_lock);
-
-			if (!skip)
-				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
-
-			goto out;
-		}
-	}
-
-out:
-	if (result && !is_mst_root_connector) {
-		/* Downstream Port status changed. */
-		handle_hpd_irq_helper(aconnector, DETECT_REASON_HPDRX);
-	}
-	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
-		if (adev->dm.hdcp_workqueue)
-			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
-	}
-
-	if (dc_link->type != dc_connection_mst_branch)
-		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
-
-	mutex_unlock(&aconnector->hpd_lock);
-}
-
-static int register_hpd_handlers(struct amdgpu_device *adev)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_connector *connector;
-	struct amdgpu_dm_connector *aconnector;
-	const struct dc_link *dc_link;
-	struct dc_interrupt_params int_params = {0};
-
-	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
-	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
-
-	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
-		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
-			dmub_hpd_callback, true)) {
-			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
-			return -EINVAL;
-		}
-
-		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
-			dmub_hpd_callback, true)) {
-			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
-			return -EINVAL;
-		}
-
-		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
-			dmub_hpd_sense_callback, true)) {
-			drm_err(adev_to_drm(adev), "fail to register dmub hpd sense callback");
-			return -EINVAL;
-		}
-	}
-
-	list_for_each_entry(connector,
-			&dev->mode_config.connector_list, head)	{
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-			continue;
-
-		aconnector = to_amdgpu_dm_connector(connector);
-		dc_link = aconnector->dc_link;
-
-		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
-			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
-			int_params.irq_source = dc_link->irq_source_hpd;
-
-			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
-				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
-				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
-				return -EINVAL;
-			}
-
-			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				handle_hpd_irq, (void *) aconnector))
-				return -ENOMEM;
-		}
-
-		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
-
-			/* Also register for DP short pulse (hpd_rx). */
-			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
-			int_params.irq_source =	dc_link->irq_source_hpd_rx;
-
-			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
-				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
-				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
-				return -EINVAL;
-			}
-
-			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				handle_hpd_rx_irq, (void *) aconnector))
-				return -ENOMEM;
-		}
-	}
-	return 0;
-}
-
-/* Register IRQ sources and initialize IRQ callbacks */
-static int dce110_register_irq_handlers(struct amdgpu_device *adev)
-{
-	struct dc *dc = adev->dm.dc;
-	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
-	int r;
-	int i;
-	unsigned int src_id;
-	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
-	/* Use different interrupts for VBLANK on DCE 6 vs. newer. */
-	const unsigned int vblank_d1 =
-		adev->dm.dc->ctx->dce_version >= DCE_VERSION_8_0
-		? VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0 : 1;
-
-	if (adev->family >= AMDGPU_FAMILY_AI)
-		client_id = SOC15_IH_CLIENTID_DCE;
-
-	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
-	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
-
-	/*
-	 * Actions of amdgpu_irq_add_id():
-	 * 1. Register a set() function with base driver.
-	 *    Base driver will call set() function to enable/disable an
-	 *    interrupt in DC hardware.
-	 * 2. Register amdgpu_dm_irq_handler().
-	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
-	 *    coming from DC hardware.
-	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling.
-	 */
-
-	/* Use VBLANK interrupt */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		src_id = vblank_d1 + i;
-		r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->crtc_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, src_id, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_crtc_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
-		/* Use VUPDATE interrupt */
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			src_id = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT + i * 2;
-			r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->vupdate_irq);
-			if (r) {
-				drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
-				return r;
-			}
-
-			int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-			int_params.irq_source =
-				dc_interrupt_to_irq_source(dc, src_id, 0);
-
-			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-				int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
-				int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-				drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
-				return -EINVAL;
-			}
-
-			c_irq_params = &adev->dm.vupdate_params[
-				int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
-			c_irq_params->adev = adev;
-			c_irq_params->irq_src = int_params.irq_source;
-
-			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_vupdate_high_irq, c_irq_params))
-				return -ENOMEM;
-		}
-	}
-
-	/* Use GRPH_PFLIP interrupt */
-	for (i = VISLANDS30_IV_SRCID_D1_GRPH_PFLIP;
-			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
-		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
-			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_pflip_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* HPD */
-	r = amdgpu_irq_add_id(adev, client_id,
-			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
-	if (r) {
-		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
-		return r;
-	}
-
-	r = register_hpd_handlers(adev);
-
-	return r;
-}
-
-/* Register IRQ sources and initialize IRQ callbacks */
-static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
-{
-	struct dc *dc = adev->dm.dc;
-	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
-	int r;
-	int i;
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	static const unsigned int vrtl_int_srcid[] = {
-		DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
-		DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
-		DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL,
-		DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL,
-		DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
-		DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL
-	};
-#endif
-
-	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
-	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
-
-	/*
-	 * Actions of amdgpu_irq_add_id():
-	 * 1. Register a set() function with base driver.
-	 *    Base driver will call set() function to enable/disable an
-	 *    interrupt in DC hardware.
-	 * 2. Register amdgpu_dm_irq_handler().
-	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
-	 *    coming from DC hardware.
-	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling.
-	 */
-
-	/* Use VSTARTUP interrupt */
-	for (i = DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP;
-			i <= DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP + adev->mode_info.num_crtc - 1;
-			i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
-
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_crtc_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* Use otg vertical line interrupt */
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	for (i = 0; i <= adev->mode_info.num_crtc - 1; i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
-				vrtl_int_srcid[i], &adev->vline0_irq);
-
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add vline0 irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, vrtl_int_srcid[i], 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
-			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
-			drm_err(adev_to_drm(adev), "Failed to register vline0 irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vline0_params[int_params.irq_source
-					- DC_IRQ_SOURCE_DC1_VLINE0];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_dcn_vertical_interrupt0_high_irq,
-			c_irq_params))
-			return -ENOMEM;
-	}
-#endif
-
-	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
-	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
-	 * to trigger at end of each vblank, regardless of state of the lock,
-	 * matching DCE behaviour.
-	 */
-	for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
-	     i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->mode_info.num_crtc - 1;
-	     i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
-
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_vupdate_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* Use GRPH_PFLIP interrupt */
-	for (i = DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT;
-			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + dc->caps.max_otg_num - 1;
-			i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
-			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_pflip_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* HPD */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
-			&adev->hpd_irq);
-	if (r) {
-		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
-		return r;
-	}
-
-	r = register_hpd_handlers(adev);
-
-	return r;
-}
-/* Register Outbox IRQ sources and initialize IRQ callbacks */
-static int register_outbox_irq_handlers(struct amdgpu_device *adev)
-{
-	struct dc *dc = adev->dm.dc;
-	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
-	int r, i;
-
-	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
-	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
-
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT,
-			&adev->dmub_outbox_irq);
-	if (r) {
-		drm_err(adev_to_drm(adev), "Failed to add outbox irq id!\n");
-		return r;
-	}
-
-	if (dc->ctx->dmub_srv) {
-		i = DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT;
-		int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
-		int_params.irq_source =
-		dc_interrupt_to_irq_source(dc, i, 0);
-
-		c_irq_params = &adev->dm.dmub_outbox_params[0];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_dmub_outbox1_low_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 /*
  * Acquires the lock for the atomic state object and returns
  * the new atomic state.
@@ -4436,7 +2954,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 2, 0):
 	case IP_VERSION(4, 2, 1):
-		if (register_outbox_irq_handlers(dm->adev)) {
+		if (amdgpu_dm_register_outbox_irq_handlers(dm->adev)) {
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
@@ -4549,7 +3067,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
-			emulated_link_detect(link);
+			amdgpu_dm_emulated_link_detect(link);
 			amdgpu_dm_update_connector_after_detect(aconnector);
 		} else {
 			bool ret = false;
@@ -4613,7 +3131,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
-		if (dce110_register_irq_handlers(dm->adev)) {
+		if (amdgpu_dm_dce110_register_irq_handlers(dm->adev)) {
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
@@ -4643,7 +3161,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
-			if (dcn10_register_irq_handlers(dm->adev)) {
+			if (amdgpu_dm_dcn10_register_irq_handlers(dm->adev)) {
 				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 				goto fail;
 			}
@@ -7755,7 +6273,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
 		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
 							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
-		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
+		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
 		aconnector->hdmi_prev_sink = NULL;
 	} else {
 		aconnector->hdmi_hpd_debounce_delay_ms = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 01f614e6da75..c995faff4a07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1167,4 +1167,8 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
 
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
 
+void amdgpu_dm_emulated_link_detect(struct dc_link *link);
+void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
+											   struct dc_sink *sink);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5948e2a6219e..2433180d014f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -26,10 +26,24 @@
 
 #include "dm_services_types.h"
 #include "dc.h"
+#include "dc/dc_dmub_srv.h"
+#include "dc/dc_stat.h"
 
 #include "amdgpu.h"
+#include "amdgpu_display.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
+#include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_hdcp.h"
+#include "amdgpu_dm_mst_types.h"
+#include "amdgpu_dm_dmub.h"
+#include "amdgpu_dm_trace.h"
+#include "link/protocols/link_dpcd.h"
+#include "link_service_types.h"
+#include "ivsrcid/ivsrcid_vislands30.h"
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+#include "modules/inc/mod_freesync.h"
+#include <drm/drm_vblank.h>
 
 /**
  * DOC: overview
@@ -55,7 +69,8 @@
  * are all set to the DM generic handler amdgpu_dm_irq_handler(), which looks up
  * DM's IRQ tables. However, in order for base driver to recognize this hook, DM
  * still needs to register the IRQ with the base driver. See
- * dce110_register_irq_handlers() and dcn10_register_irq_handlers().
+ * amdgpu_dm_dce110_register_irq_handlers() and
+ * amdgpu_dm_dcn10_register_irq_handlers().
  *
  * To expose DC's hardware interrupt toggle to the base driver, DM implements
  * &amdgpu_irq_src_funcs.set hooks. Base driver calls it through
@@ -1020,3 +1035,1486 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_fini(dev);
 }
+
+/* ========== HPD handling ========== */
+static void force_connector_state(
+	struct amdgpu_dm_connector *aconnector,
+	enum drm_connector_force force_state)
+{
+	struct drm_connector *connector = &aconnector->base;
+
+	mutex_lock(&connector->dev->mode_config.mutex);
+	aconnector->base.force = force_state;
+	mutex_unlock(&connector->dev->mode_config.mutex);
+
+	mutex_lock(&aconnector->hpd_lock);
+	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_unlock(&aconnector->hpd_lock);
+}
+
+static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *dc_link;
+	struct amdgpu_device *adev;
+	enum dc_connection_type new_connection_type = dc_connection_none;
+	unsigned long flags;
+	union test_response test_response;
+
+	memset(&test_response, 0, sizeof(test_response));
+
+	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
+	aconnector = offload_work->offload_wq->aconnector;
+	adev = offload_work->adev;
+
+	if (!aconnector) {
+		drm_err(adev_to_drm(adev), "Can't retrieve aconnector in hpd_rx_irq_offload_work");
+		goto skip;
+	}
+
+	dc_link = aconnector->dc_link;
+
+	mutex_lock(&aconnector->hpd_lock);
+	if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
+		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
+	mutex_unlock(&aconnector->hpd_lock);
+
+	if (new_connection_type == dc_connection_none)
+		goto skip;
+
+	if (amdgpu_in_reset(adev))
+		goto skip;
+
+	if (offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
+		offload_work->data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+		dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_OR_UP_MSG_RDY_EVENT);
+		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
+		offload_work->offload_wq->is_handling_mst_msg_rdy_event = false;
+		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+		goto skip;
+	}
+
+	mutex_lock(&adev->dm.dc_lock);
+	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
+		dc_link_dp_handle_automated_test(dc_link);
+
+		if (aconnector->timing_changed) {
+			/* force connector disconnect and reconnect */
+			force_connector_state(aconnector, DRM_FORCE_OFF);
+			msleep(100);
+			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
+		}
+
+		test_response.bits.ACK = 1;
+
+		core_link_write_dpcd(
+		dc_link,
+		DP_TEST_RESPONSE,
+		&test_response.raw,
+		sizeof(test_response));
+	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
+			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
+		/* offload_work->data is from handle_hpd_rx_irq->
+		 * schedule_hpd_rx_offload_work.this is defer handle
+		 * for hpd short pulse. upon here, link status may be
+		 * changed, need get latest link status from dpcd
+		 * registers. if link status is good, skip run link
+		 * training again.
+		 */
+		union hpd_irq_data irq_data;
+
+		memset(&irq_data, 0, sizeof(irq_data));
+
+		/* before dc_link_dp_handle_link_loss, allow new link lost handle
+		 * request be added to work queue if link lost at end of dc_link_
+		 * dp_handle_link_loss
+		 */
+		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
+		offload_work->offload_wq->is_handling_link_loss = false;
+		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+
+		if ((dc_link_dp_read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
+			dc_link_check_link_loss_status(dc_link, &irq_data))
+			dc_link_dp_handle_link_loss(dc_link);
+	}
+	mutex_unlock(&adev->dm.dc_lock);
+
+skip:
+	kfree(offload_work);
+
+}
+
+struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	int max_caps = dc->caps.max_links;
+	int i = 0;
+	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq = NULL;
+
+	hpd_rx_offload_wq = kcalloc(max_caps, sizeof(*hpd_rx_offload_wq), GFP_KERNEL);
+
+	if (!hpd_rx_offload_wq)
+		return NULL;
+
+
+	for (i = 0; i < max_caps; i++) {
+		hpd_rx_offload_wq[i].wq =
+				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
+
+		if (hpd_rx_offload_wq[i].wq == NULL) {
+			drm_err(adev_to_drm(adev), "create amdgpu_dm_hpd_rx_offload_wq fail!");
+			goto out_err;
+		}
+
+		spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
+	}
+
+	return hpd_rx_offload_wq;
+
+out_err:
+	for (i = 0; i < max_caps; i++) {
+		if (hpd_rx_offload_wq[i].wq)
+			destroy_workqueue(hpd_rx_offload_wq[i].wq);
+	}
+	kfree(hpd_rx_offload_wq);
+	return NULL;
+}
+
+void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
+{
+	int i;
+
+	if (dm->hpd_rx_offload_wq) {
+		for (i = 0; i < dm->dc->caps.max_links; i++)
+			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
+	}
+}
+
+static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+{
+	if (!sink1 || !sink2)
+		return false;
+	if (sink1->sink_signal != sink2->sink_signal)
+		return false;
+
+	if (sink1->dc_edid.length != sink2->dc_edid.length)
+		return false;
+
+	if (memcmp(sink1->dc_edid.raw_edid, sink2->dc_edid.raw_edid,
+		   sink1->dc_edid.length) != 0)
+		return false;
+	return true;
+}
+
+
+/**
+ * DOC: amdgpu_dm_hdmi_hpd_debounce_work
+ *
+ * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
+ * (such as during power save transitions), this delay determines how long to
+ * wait before processing the HPD event. This allows distinguishing between a
+ * physical unplug (>hdmi_hpd_debounce_delay)
+ * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
+ *
+ * If the toggle is less than this delay, the driver compares sink capabilities
+ * and permits a hotplug event if they changed.
+ *
+ * The default value of 1500ms was chosen based on experimental testing with
+ * various monitors that exhibit spontaneous HPD toggling behavior.
+ */
+void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
+{
+	struct amdgpu_dm_connector *aconnector =
+		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
+			     hdmi_hpd_debounce_work);
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = aconnector->dc_link->ctx->dc;
+	bool fake_reconnect = false;
+	bool reallow_idle = false;
+	bool ret = false;
+
+	guard(mutex)(&aconnector->hpd_lock);
+
+	/* Re-detect the display */
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		if (dc->caps.ips_support && dc->ctx->dmub_srv->idle_allowed) {
+			dc_allow_idle_optimizations(dc, false);
+			reallow_idle = true;
+		}
+		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+	}
+
+	if (ret) {
+		/* Apply workaround delay for certain panels */
+		amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+		/* Compare sinks to determine if this was a spontaneous HPD toggle */
+		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
+			/*
+			 * Sinks match - this was a spontaneous HDMI HPD toggle.
+			 */
+			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
+			fake_reconnect = true;
+		}
+
+		/* Update connector state */
+		amdgpu_dm_update_connector_after_detect(aconnector);
+
+		drm_modeset_lock_all(dev);
+		dm_restore_drm_connector_state(dev, connector);
+		drm_modeset_unlock_all(dev);
+
+		/* Only notify OS if sink actually changed */
+		if (!fake_reconnect && aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+			drm_kms_helper_hotplug_event(dev);
+	}
+
+	/* Release the cached sink reference */
+	if (aconnector->hdmi_prev_sink) {
+		dc_sink_release(aconnector->hdmi_prev_sink);
+		aconnector->hdmi_prev_sink = NULL;
+	}
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		if (reallow_idle && dc->caps.ips_support)
+			dc_allow_idle_optimizations(dc, true);
+	}
+}
+
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+				  enum dc_detect_reason reason)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	enum dc_connection_type new_connection_type = dc_connection_none;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
+	struct dc *dc = aconnector->dc_link->ctx->dc;
+	bool ret = false;
+	bool debounce_required = false;
+
+	if (adev->dm.disable_hpd_irq)
+		return;
+
+	/*
+	 * In case of failure or MST no need to update connector status or notify the OS
+	 * since (for MST case) MST does this in its own context.
+	 */
+	guard(mutex)(&aconnector->hpd_lock);
+
+	if (adev->dm.hdcp_workqueue) {
+		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
+		dm_con_state->update_hdcp = true;
+	}
+	if (aconnector->fake_enable)
+		aconnector->fake_enable = false;
+
+	aconnector->timing_changed = false;
+
+	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
+		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
+
+	/*
+	 * Check for HDMI disconnect with debounce enabled.
+	 */
+	debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
+			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
+			      new_connection_type == dc_connection_none &&
+			      aconnector->dc_link->local_sink != NULL);
+
+	if (aconnector->base.force && new_connection_type == dc_connection_none) {
+		amdgpu_dm_emulated_link_detect(aconnector->dc_link);
+
+		drm_modeset_lock_all(dev);
+		dm_restore_drm_connector_state(dev, connector);
+		drm_modeset_unlock_all(dev);
+
+		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+		    reason == DETECT_REASON_HPDRX)
+			drm_kms_helper_connector_hotplug_event(connector);
+	} else if (debounce_required) {
+		/*
+		 * HDMI disconnect detected - schedule delayed work instead of
+		 * processing immediately. This allows us to coalesce spurious
+		 * HDMI signals from physical unplugs.
+		 */
+		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
+			    aconnector->hdmi_hpd_debounce_delay_ms);
+
+		/* Cache the current sink for later comparison */
+		if (aconnector->hdmi_prev_sink)
+			dc_sink_release(aconnector->hdmi_prev_sink);
+		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
+		if (aconnector->hdmi_prev_sink)
+			dc_sink_retain(aconnector->hdmi_prev_sink);
+
+		/* Schedule delayed detection. */
+		if (mod_delayed_work(system_percpu_wq,
+				 &aconnector->hdmi_hpd_debounce_work,
+				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
+			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
+
+	} else {
+
+		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
+		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
+			return;
+
+		scoped_guard(mutex, &adev->dm.dc_lock) {
+			dc_exit_ips_for_hw_access(dc);
+			ret = dc_link_detect(aconnector->dc_link, reason);
+		}
+		if (ret) {
+			/* w/a delay for certain panels */
+			amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+			amdgpu_dm_update_connector_after_detect(aconnector);
+
+			drm_modeset_lock_all(dev);
+			dm_restore_drm_connector_state(dev, connector);
+			drm_modeset_unlock_all(dev);
+
+			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+			    reason == DETECT_REASON_HPDRX)
+				drm_kms_helper_connector_hotplug_event(connector);
+		}
+	}
+}
+
+static void handle_hpd_irq(void *param)
+{
+	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
+
+	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
+
+}
+
+static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
+							union hpd_irq_data hpd_irq_data)
+{
+	struct hpd_rx_irq_offload_work *offload_work =
+				kzalloc(sizeof(*offload_work), GFP_KERNEL);
+
+	if (!offload_work) {
+		drm_err(adev_to_drm(adev), "Failed to allocate hpd_rx_irq_offload_work.\n");
+		return;
+	}
+
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+	offload_work->data = hpd_irq_data;
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+
+	queue_work(offload_wq->wq, &offload_work->work);
+	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work");
+}
+
+static void handle_hpd_rx_irq(void *param)
+{
+	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct dc_link *dc_link = aconnector->dc_link;
+	bool is_mst_root_connector = aconnector->mst_mgr.mst_state;
+	bool result = false;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	union hpd_irq_data hpd_irq_data;
+	bool link_loss = false;
+	bool has_left_work = false;
+	int idx = dc_link->link_index;
+	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
+
+	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
+
+	if (adev->dm.disable_hpd_irq)
+		return;
+
+	/*
+	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
+	 * conflict, after implement i2c helper, this mutex should be
+	 * retired.
+	 */
+	mutex_lock(&aconnector->hpd_lock);
+
+	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data,
+						&link_loss, true, &has_left_work);
+
+	if (!has_left_work)
+		goto out;
+
+	if (hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
+		schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
+		goto out;
+	}
+
+	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
+		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
+			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+			bool skip = false;
+
+			/*
+			 * DOWN_REP_MSG_RDY is also handled by polling method
+			 * mgr->cbs->poll_hpd_irq()
+			 */
+			spin_lock(&offload_wq->offload_lock);
+			skip = offload_wq->is_handling_mst_msg_rdy_event;
+
+			if (!skip)
+				offload_wq->is_handling_mst_msg_rdy_event = true;
+
+			spin_unlock(&offload_wq->offload_lock);
+
+			if (!skip)
+				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
+
+			goto out;
+		}
+
+		if (link_loss) {
+			bool skip = false;
+
+			spin_lock(&offload_wq->offload_lock);
+			skip = offload_wq->is_handling_link_loss;
+
+			if (!skip)
+				offload_wq->is_handling_link_loss = true;
+
+			spin_unlock(&offload_wq->offload_lock);
+
+			if (!skip)
+				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
+
+			goto out;
+		}
+	}
+
+out:
+	if (result && !is_mst_root_connector) {
+		/* Downstream Port status changed. */
+		handle_hpd_irq_helper(aconnector, DETECT_REASON_HPDRX);
+	}
+	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
+		if (adev->dm.hdcp_workqueue)
+			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
+	}
+
+	if (dc_link->type != dc_connection_mst_branch)
+		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
+
+	mutex_unlock(&aconnector->hpd_lock);
+}
+
+/**
+ * dmub_hpd_callback - DMUB HPD interrupt processing callback.
+ * @adev: amdgpu_device pointer
+ * @notify: dmub notification structure
+ *
+ * Dmub Hpd interrupt processing callback. Gets displayindex through the
+ * ink index and calls helper to do the processing.
+ */
+static void dmub_hpd_callback(struct amdgpu_device *adev,
+			      struct dmub_notification *notify)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *hpd_aconnector = NULL;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct dc_link *link;
+	u8 link_index = 0;
+	struct drm_device *dev;
+
+	if (adev == NULL)
+		return;
+
+	if (notify == NULL) {
+		drm_err(adev_to_drm(adev), "DMUB HPD callback notification was NULL");
+		return;
+	}
+
+	if (notify->link_index > adev->dm.dc->link_count) {
+		drm_err(adev_to_drm(adev), "DMUB HPD index (%u)is abnormal", notify->link_index);
+		return;
+	}
+
+	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
+	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
+		drm_info(adev_to_drm(adev), "Skip DMUB HPD IRQ callback in suspend/resume\n");
+		return;
+	}
+
+	link_index = notify->link_index;
+	link = adev->dm.dc->links[link_index];
+	dev = adev->dm.ddev;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (link && aconnector->dc_link == link) {
+			if (notify->type == DMUB_NOTIFICATION_HPD)
+				drm_info(adev_to_drm(adev), "DMUB HPD IRQ callback: link_index=%u\n", link_index);
+			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
+				drm_info(adev_to_drm(adev), "DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
+			else
+				drm_warn(adev_to_drm(adev), "DMUB Unknown HPD callback type %d, link_index=%u\n",
+						notify->type, link_index);
+
+			hpd_aconnector = aconnector;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+
+	if (hpd_aconnector) {
+		if (notify->type == DMUB_NOTIFICATION_HPD) {
+			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
+				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link_index=%u\n", link_index);
+			handle_hpd_irq_helper(hpd_aconnector, DETECT_REASON_HPD);
+		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
+			handle_hpd_rx_irq(hpd_aconnector);
+		}
+	}
+}
+
+/**
+ * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
+ * @adev: amdgpu_device pointer
+ * @notify: dmub notification structure
+ *
+ * HPD sense changes can occur during low power states and need to be
+ * notified from firmware to driver.
+ */
+static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+			      struct dmub_notification *notify)
+{
+	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
+}
+
+int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_connector *connector;
+	struct amdgpu_dm_connector *aconnector;
+	const struct dc_link *dc_link;
+	struct dc_interrupt_params int_params = {0};
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
+			dmub_hpd_callback, true)) {
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
+			return -EINVAL;
+		}
+
+		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
+			dmub_hpd_callback, true)) {
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
+			return -EINVAL;
+		}
+
+		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
+			dmub_hpd_sense_callback, true)) {
+			drm_err(adev_to_drm(adev), "fail to register dmub hpd sense callback");
+			return -EINVAL;
+		}
+	}
+
+	list_for_each_entry(connector,
+			&dev->mode_config.connector_list, head)	{
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+		dc_link = aconnector->dc_link;
+
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
+			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+			int_params.irq_source = dc_link->irq_source_hpd;
+
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
+				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
+				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
+				return -EINVAL;
+			}
+
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				handle_hpd_irq, (void *) aconnector))
+				return -ENOMEM;
+		}
+
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
+
+			/* Also register for DP short pulse (hpd_rx). */
+			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+			int_params.irq_source =	dc_link->irq_source_hpd_rx;
+
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
+				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
+				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
+				return -EINVAL;
+			}
+
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				handle_hpd_rx_irq, (void *) aconnector))
+				return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/* ========== IRQ handlers ========== */
+struct amdgpu_crtc *
+amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
+		     int otg_inst)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+
+	if (WARN_ON(otg_inst == -1))
+		return adev->mode_info.crtcs[0];
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+		if (amdgpu_crtc->otg_inst == otg_inst)
+			return amdgpu_crtc;
+	}
+
+	return NULL;
+}
+
+/**
+ * dm_pflip_high_irq() - Handle pageflip interrupt
+ * @interrupt_params: ignored
+ *
+ * Handles the pageflip interrupt by notifying all interested parties
+ * that the pageflip has been completed.
+ */
+static void dm_pflip_high_irq(void *interrupt_params)
+{
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct drm_device *dev = adev_to_drm(adev);
+	unsigned long flags;
+	struct drm_pending_vblank_event *e;
+	u32 vpos, hpos, v_blank_start, v_blank_end;
+	bool vrr_active;
+
+	amdgpu_crtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
+
+	/* IRQ could occur when in initial stage */
+	/* TODO work and BO cleanup */
+	if (amdgpu_crtc == NULL) {
+		drm_dbg_state(dev, "CRTC is null, returning.\n");
+		return;
+	}
+
+	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		drm_dbg_state(dev,
+			      "amdgpu_crtc->pflip_status = %d != AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
+			      amdgpu_crtc->pflip_status, AMDGPU_FLIP_SUBMITTED,
+			      amdgpu_crtc->crtc_id, amdgpu_crtc);
+		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+		return;
+	}
+
+	/* page flip completed. */
+	e = amdgpu_crtc->event;
+	amdgpu_crtc->event = NULL;
+
+	WARN_ON(!e);
+
+	vrr_active = amdgpu_dm_crtc_vrr_active_irq(amdgpu_crtc);
+
+	/* Fixed refresh rate, or VRR scanout position outside front-porch? */
+	if (!vrr_active ||
+	    !dc_stream_get_scanoutpos(amdgpu_crtc->dm_irq_params.stream, &v_blank_start,
+				      &v_blank_end, &hpos, &vpos) ||
+	    (vpos < v_blank_start)) {
+		/* Update to correct count and vblank timestamp if racing with
+		 * vblank irq. This also updates to the correct vblank timestamp
+		 * even in VRR mode, as scanout is past the front-porch atm.
+		 */
+		drm_crtc_accurate_vblank_count(&amdgpu_crtc->base);
+
+		/* Wake up userspace by sending the pageflip event with proper
+		 * count and timestamp of vblank of flip completion.
+		 */
+		if (e) {
+			drm_crtc_send_vblank_event(&amdgpu_crtc->base, e);
+
+			/* Event sent, so done with vblank for this flip */
+			drm_crtc_vblank_put(&amdgpu_crtc->base);
+		}
+	} else if (e) {
+		/* VRR active and inside front-porch: vblank count and
+		 * timestamp for pageflip event will only be up to date after
+		 * drm_crtc_handle_vblank() has been executed from late vblank
+		 * irq handler after start of back-porch (vline 0). We queue the
+		 * pageflip event for send-out by drm_crtc_handle_vblank() with
+		 * updated timestamp and count, once it runs after us.
+		 *
+		 * We need to open-code this instead of using the helper
+		 * drm_crtc_arm_vblank_event(), as that helper would
+		 * call drm_crtc_accurate_vblank_count(), which we must
+		 * not call in VRR mode while we are in front-porch!
+		 */
+
+		/* sequence will be replaced by real count during send-out. */
+		e->sequence = drm_crtc_vblank_count(&amdgpu_crtc->base);
+		e->pipe = amdgpu_crtc->crtc_id;
+
+		list_add_tail(&e->base.link, &adev_to_drm(adev)->vblank_event_list);
+		e = NULL;
+	}
+
+	/* Keep track of vblank of this flip for flip throttling. We use the
+	 * cooked hw counter, as that one incremented at start of this vblank
+	 * of pageflip completion, so last_flip_vblank is the forbidden count
+	 * for queueing new pageflips if vsync + VRR is enabled.
+	 */
+	amdgpu_crtc->dm_irq_params.last_flip_vblank =
+		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
+
+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
+	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+
+	drm_dbg_state(dev,
+		      "crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
+		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
+}
+
+static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
+{
+	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
+	struct amdgpu_device *adev = work->adev;
+	struct dc_stream_state *stream = work->stream;
+	struct dc_crtc_timing_adjust *adjust = work->adjust;
+
+	mutex_lock(&adev->dm.dc_lock);
+	dc_stream_adjust_vmin_vmax(adev->dm.dc, stream, adjust);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	dc_stream_release(stream);
+	kfree(work->adjust);
+	kfree(work);
+}
+
+static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
+	struct dc_stream_state *stream,
+	struct dc_crtc_timing_adjust *adjust)
+{
+	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_NOWAIT);
+	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_NOWAIT);
+
+	if (!offload_work) {
+		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
+		return;
+	}
+
+	if (!adjust_copy) {
+		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
+		kfree(offload_work);
+		return;
+	}
+
+	dc_stream_retain(stream);
+	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
+
+	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
+	offload_work->adev = adev;
+	offload_work->stream = stream;
+	offload_work->adjust = adjust_copy;
+
+	queue_work(system_percpu_wq, &offload_work->work);
+}
+
+static void dm_vupdate_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_crtc *acrtc;
+	struct drm_device *drm_dev;
+	struct drm_vblank_crtc *vblank;
+	ktime_t frame_duration_ns, previous_timestamp;
+	unsigned long flags;
+	int vrr_active;
+
+	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
+
+	if (acrtc) {
+		vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
+		drm_dev = acrtc->base.dev;
+		vblank = drm_crtc_vblank_crtc(&acrtc->base);
+		previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
+		frame_duration_ns = vblank->time - previous_timestamp;
+
+		if (frame_duration_ns > 0) {
+			trace_amdgpu_refresh_rate_track(acrtc->base.index,
+						frame_duration_ns,
+						ktime_divns(NSEC_PER_SEC, frame_duration_ns));
+			atomic64_set(&irq_params->previous_timestamp, vblank->time);
+		}
+
+		drm_dbg_vbl(drm_dev,
+			    "crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
+			    vrr_active);
+
+		/* Core vblank handling is done here after end of front-porch in
+		 * vrr mode, as vblank timestamping will give valid results
+		 * while now done after front-porch. This will also deliver
+		 * page-flip completion events that have been queued to us
+		 * if a pageflip happened inside front-porch.
+		 */
+		if (vrr_active && acrtc->dm_irq_params.stream) {
+			bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+			bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+			bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
+				== VRR_STATE_ACTIVE_VARIABLE;
+
+			amdgpu_dm_crtc_handle_vblank(acrtc);
+
+			/* BTR processing for pre-DCE12 ASICs */
+			if (adev->family < AMDGPU_FAMILY_AI) {
+				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+				mod_freesync_handle_v_update(
+				    adev->dm.freesync_module,
+				    acrtc->dm_irq_params.stream,
+				    &acrtc->dm_irq_params.vrr_params);
+
+				if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+					schedule_dc_vmin_vmax(adev,
+						acrtc->dm_irq_params.stream,
+						&acrtc->dm_irq_params.vrr_params.adjust);
+				}
+				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+			}
+		}
+	}
+}
+
+/**
+ * dm_crtc_high_irq() - Handles CRTC interrupt
+ * @interrupt_params: used for determining the CRTC instance
+ *
+ * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
+ * event handler.
+ */
+static void dm_crtc_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct drm_writeback_job *job;
+	struct amdgpu_crtc *acrtc;
+	unsigned long flags;
+	int vrr_active;
+
+	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
+	if (!acrtc)
+		return;
+
+	if (acrtc->wb_conn) {
+		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
+
+		if (acrtc->wb_pending) {
+			job = list_first_entry_or_null(&acrtc->wb_conn->job_queue,
+						       struct drm_writeback_job,
+						       list_entry);
+			acrtc->wb_pending = false;
+			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+
+			if (job) {
+				unsigned int v_total, refresh_hz;
+				struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
+
+				v_total = stream->adjust.v_total_max ?
+					  stream->adjust.v_total_max : stream->timing.v_total;
+				refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
+					     100LL, (v_total * stream->timing.h_total));
+				mdelay(1000 / refresh_hz);
+
+				drm_writeback_signal_completion(acrtc->wb_conn, 0);
+				dc_stream_fc_disable_writeback(adev->dm.dc,
+							       acrtc->dm_irq_params.stream, 0);
+			}
+		} else
+			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+	}
+
+	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
+
+	drm_dbg_vbl(adev_to_drm(adev),
+		    "crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
+		    vrr_active, acrtc->dm_irq_params.active_planes);
+
+	/**
+	 * Core vblank handling at start of front-porch is only possible
+	 * in non-vrr mode, as only there vblank timestamping will give
+	 * valid results while done in front-porch. Otherwise defer it
+	 * to dm_vupdate_high_irq after end of front-porch.
+	 */
+	if (!vrr_active)
+		amdgpu_dm_crtc_handle_vblank(acrtc);
+
+	/**
+	 * Following stuff must happen at start of vblank, for crc
+	 * computation and below-the-range btr support in vrr mode.
+	 */
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+
+	/* BTR updates need to happen before VUPDATE on Vega and above. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return;
+
+	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+
+	if (acrtc->dm_irq_params.stream &&
+		acrtc->dm_irq_params.vrr_params.supported) {
+		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+
+		mod_freesync_handle_v_update(adev->dm.freesync_module,
+					     acrtc->dm_irq_params.stream,
+					     &acrtc->dm_irq_params.vrr_params);
+
+		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
+		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+			schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
+		}
+	}
+
+	/*
+	 * If there aren't any active_planes then DCH HUBP may be clock-gated.
+	 * In that case, pageflip completion interrupts won't fire and pageflip
+	 * completion events won't get delivered. Prevent this by sending
+	 * pending pageflip events from here if a flip is still pending.
+	 *
+	 * If any planes are enabled, use dm_pflip_high_irq() instead, to
+	 * avoid race conditions between flip programming and completion,
+	 * which could cause too early flip completion events.
+	 */
+	if (adev->family >= AMDGPU_FAMILY_RV &&
+	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+	    acrtc->dm_irq_params.active_planes == 0) {
+		if (acrtc->event) {
+			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
+			acrtc->event = NULL;
+			drm_crtc_vblank_put(&acrtc->base);
+		}
+		acrtc->pflip_status = AMDGPU_FLIP_NONE;
+	}
+
+	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+}
+
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+/**
+ * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
+ * DCN generation ASICs
+ * @interrupt_params: interrupt parameters
+ *
+ * Used to set crc window/read out crc value at vertical line 0 position
+ */
+static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VLINE0);
+
+	if (!acrtc)
+		return;
+
+	amdgpu_dm_crtc_handle_crc_window_irq(&acrtc->base);
+}
+#endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
+
+static void dm_handle_hpd_work(struct work_struct *work)
+{
+	struct dmub_hpd_work *dmub_hpd_wrk;
+
+	dmub_hpd_wrk = container_of(work, struct dmub_hpd_work, handle_hpd_work);
+
+	if (!dmub_hpd_wrk->dmub_notify) {
+		drm_err(adev_to_drm(dmub_hpd_wrk->adev), "dmub_hpd_wrk dmub_notify is NULL");
+		return;
+	}
+
+	if (dmub_hpd_wrk->dmub_notify->type < ARRAY_SIZE(dmub_hpd_wrk->adev->dm.dmub_callback)) {
+		dmub_hpd_wrk->adev->dm.dmub_callback[dmub_hpd_wrk->dmub_notify->type](dmub_hpd_wrk->adev,
+		dmub_hpd_wrk->dmub_notify);
+	}
+
+	kfree(dmub_hpd_wrk->dmub_notify);
+	kfree(dmub_hpd_wrk);
+
+}
+
+static const char *dmub_notification_type_str(enum dmub_notification_type e)
+{
+	switch (e) {
+	case DMUB_NOTIFICATION_NO_DATA:
+		return "NO_DATA";
+	case DMUB_NOTIFICATION_AUX_REPLY:
+		return "AUX_REPLY";
+	case DMUB_NOTIFICATION_HPD:
+		return "HPD";
+	case DMUB_NOTIFICATION_HPD_IRQ:
+		return "HPD_IRQ";
+	case DMUB_NOTIFICATION_SET_CONFIG_REPLY:
+		return "SET_CONFIG_REPLY";
+	case DMUB_NOTIFICATION_DPIA_NOTIFICATION:
+		return "DPIA_NOTIFICATION";
+	case DMUB_NOTIFICATION_HPD_SENSE_NOTIFY:
+		return "HPD_SENSE_NOTIFY";
+	case DMUB_NOTIFICATION_FUSED_IO:
+		return "FUSED_IO";
+	default:
+		return "<unknown>";
+	}
+}
+
+#define DMUB_TRACE_MAX_READ 64
+/**
+ * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
+ * @interrupt_params: used for determining the Outbox instance
+ *
+ * Handles the Outbox Interrupt
+ * event handler.
+ */
+static void dm_dmub_outbox1_low_irq(void *interrupt_params)
+{
+	struct dmub_notification notify = {0};
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dmcub_trace_buf_entry entry = { 0 };
+	u32 count = 0;
+	struct dmub_hpd_work *dmub_hpd_wrk;
+
+	do {
+		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
+			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
+							entry.param0, entry.param1);
+
+			drm_dbg_driver(adev_to_drm(adev), "trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
+				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
+		} else
+			break;
+
+		count++;
+
+	} while (count <= DMUB_TRACE_MAX_READ);
+
+	if (count > DMUB_TRACE_MAX_READ)
+		drm_dbg_driver(adev_to_drm(adev), "Warning : count > DMUB_TRACE_MAX_READ");
+
+	if (dc_enable_dmub_notifications(adev->dm.dc) &&
+		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
+
+		do {
+			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
+			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
+				drm_err(adev_to_drm(adev), "DM: notify type %d invalid!", notify.type);
+				continue;
+			}
+			if (!dm->dmub_callback[notify.type]) {
+				drm_warn(adev_to_drm(adev), "DMUB notification skipped due to no handler: type=%s\n",
+					dmub_notification_type_str(notify.type));
+				continue;
+			}
+			if (dm->dmub_thread_offload[notify.type] == true) {
+				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
+				if (!dmub_hpd_wrk) {
+					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk");
+					return;
+				}
+				dmub_hpd_wrk->dmub_notify = kmemdup(&notify, sizeof(struct dmub_notification),
+								    GFP_ATOMIC);
+				if (!dmub_hpd_wrk->dmub_notify) {
+					kfree(dmub_hpd_wrk);
+					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk->dmub_notify");
+					return;
+				}
+				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
+				dmub_hpd_wrk->adev = adev;
+				queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
+			} else {
+				dm->dmub_callback[notify.type](adev, &notify);
+			}
+		} while (notify.pending_notification);
+	}
+}
+
+/* Register IRQ sources and initialize IRQ callbacks */
+int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r;
+	int i;
+	unsigned int src_id;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	/* Use different interrupts for VBLANK on DCE 6 vs. newer. */
+	const unsigned int vblank_d1 =
+		adev->dm.dc->ctx->dce_version >= DCE_VERSION_8_0
+		? VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0 : 1;
+
+	if (adev->family >= AMDGPU_FAMILY_AI)
+		client_id = SOC15_IH_CLIENTID_DCE;
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	/*
+	 * Actions of amdgpu_irq_add_id():
+	 * 1. Register a set() function with base driver.
+	 *    Base driver will call set() function to enable/disable an
+	 *    interrupt in DC hardware.
+	 * 2. Register amdgpu_dm_irq_handler().
+	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
+	 *    coming from DC hardware.
+	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
+	 *    for acknowledging and handling.
+	 */
+
+	/* Use VBLANK interrupt */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		src_id = vblank_d1 + i;
+		r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->crtc_irq);
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, src_id, 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
+			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_crtc_high_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
+		/* Use VUPDATE interrupt */
+		for (i = 0; i < adev->mode_info.num_crtc; i++) {
+			src_id = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT + i * 2;
+			r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->vupdate_irq);
+			if (r) {
+				drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
+				return r;
+			}
+
+			int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+			int_params.irq_source =
+				dc_interrupt_to_irq_source(dc, src_id, 0);
+
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
+				int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
+				drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
+				return -EINVAL;
+			}
+
+			c_irq_params = &adev->dm.vupdate_params[
+				int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
+			c_irq_params->adev = adev;
+			c_irq_params->irq_src = int_params.irq_source;
+
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				dm_vupdate_high_irq, c_irq_params))
+				return -ENOMEM;
+		}
+	}
+
+	/* Use GRPH_PFLIP interrupt */
+	for (i = VISLANDS30_IV_SRCID_D1_GRPH_PFLIP;
+			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
+		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
+			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
+			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_pflip_high_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	/* HPD */
+	r = amdgpu_irq_add_id(adev, client_id,
+			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
+	if (r) {
+		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
+		return r;
+	}
+
+	r = amdgpu_dm_register_hpd_handlers(adev);
+
+	return r;
+}
+
+/* Register IRQ sources and initialize IRQ callbacks */
+int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r;
+	int i;
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	static const unsigned int vrtl_int_srcid[] = {
+		DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL
+	};
+#endif
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	/*
+	 * Actions of amdgpu_irq_add_id():
+	 * 1. Register a set() function with base driver.
+	 *    Base driver will call set() function to enable/disable an
+	 *    interrupt in DC hardware.
+	 * 2. Register amdgpu_dm_irq_handler().
+	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
+	 *    coming from DC hardware.
+	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
+	 *    for acknowledging and handling.
+	 */
+
+	/* Use VSTARTUP interrupt */
+	for (i = DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP;
+			i <= DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP + adev->mode_info.num_crtc - 1;
+			i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
+
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
+			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_crtc_high_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	/* Use otg vertical line interrupt */
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	for (i = 0; i <= adev->mode_info.num_crtc - 1; i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
+				vrtl_int_srcid[i], &adev->vline0_irq);
+
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add vline0 irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, vrtl_int_srcid[i], 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
+			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
+			drm_err(adev_to_drm(adev), "Failed to register vline0 irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.vline0_params[int_params.irq_source
+					- DC_IRQ_SOURCE_DC1_VLINE0];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_dcn_vertical_interrupt0_high_irq,
+			c_irq_params))
+			return -ENOMEM;
+	}
+#endif
+
+	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
+	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
+	 * to trigger at end of each vblank, regardless of state of the lock,
+	 * matching DCE behaviour.
+	 */
+	for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
+	     i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->mode_info.num_crtc - 1;
+	     i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
+
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
+			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_vupdate_high_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	/* Use GRPH_PFLIP interrupt */
+	for (i = DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT;
+			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + dc->caps.max_otg_num - 1;
+			i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
+		if (r) {
+			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
+			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
+			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
+			return -EINVAL;
+		}
+
+		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_pflip_high_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	/* HPD */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
+			&adev->hpd_irq);
+	if (r) {
+		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
+		return r;
+	}
+
+	r = amdgpu_dm_register_hpd_handlers(adev);
+
+	return r;
+}
+
+/* Register Outbox IRQ sources and initialize IRQ callbacks */
+int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r, i;
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT,
+			&adev->dmub_outbox_irq);
+	if (r) {
+		drm_err(adev_to_drm(adev), "Failed to add outbox irq id!\n");
+		return r;
+	}
+
+	if (dc->ctx->dmub_srv) {
+		i = DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT;
+		int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+		int_params.irq_source =
+		dc_interrupt_to_irq_source(dc, i, 0);
+
+		c_irq_params = &adev->dm.dmub_outbox_params[0];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_dmub_outbox1_low_irq, c_irq_params))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 4f6b58f4f90d..ba6968f5626f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -27,6 +27,12 @@
 
 #include "irq_types.h" /* DAL irq definitions */
 
+struct amdgpu_device;
+struct amdgpu_crtc;
+struct amdgpu_display_manager;
+struct hpd_rx_irq_offload_work_queue;
+struct work_struct;
+
 /*
  * Display Manager IRQ-related interfaces (for use by DAL).
  */
@@ -101,4 +107,17 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
 void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
 void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
 
+/* HPD handling */
+struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev);
+void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
+int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
+void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
+
+/* IRQ handlers */
+struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
+						    int otg_inst);
+int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev);
+int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev);
+int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DM_IRQ_H__ */
-- 
2.43.0

