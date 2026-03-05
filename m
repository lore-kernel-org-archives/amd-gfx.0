Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D68F513E5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FDA10E2EF;
	Thu,  5 Mar 2026 22:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4nbva09";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582DB10EC8E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 22:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2234MAPtbBQPDRn3mo+D8c9CG8e7PmGttYvKcT/z9Iy3KzNCYfk4VhFacnmJjs3QtMm8ifeIjD+1D59pI32UkMhGkWxg6nO4RyLOZr9tTkq+TraBT14JmjF+fLAdnzTjjmsX4yJfsEfWTWqAUq/zdlifvbJ/lvC+9lRDe52VkQl5ScCPBYsjRPDOyKiwLSLxpJFWzNu9Lqq3O+1JNiGVSnqvkpmC8TxUMMj/gXog5Jl0EHuqh4aTDLA2X5jEEVrd3LxoZkjjIWHqZlpdPT7IlzRZ1vSe74Hc6G42pojogUdmI3Myp3FnKRrCPqlC9ECVDWpGIkV3gIzL8HA5wwlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0lGCUzxVqBiVeAJVEp0EFsnRJIQG5w7owOkNxrMw3o=;
 b=adfItqb867TpXU5xF0hAkdWkh7qfzGrG7P4sHWwAdzTxWheoscucl2ikN0KU653+EO32WKShgyMuyOvysKn+jdIPbUGPTcWzeof21NPrc6BzXDOwCrEA5vddqYh4zXnAmCVRCFK8QVlUq/aP7JW5MbyRlQPk7y+5Iw8H3zBBdIcfAYtMQiTkmUQPfROUqNcTCNiYjvW1P+Dv8i04MqfiFiJlglju7gNbwZ/aUMmyHrgeWt622qJRwwacEjVZeqT9iLV6OuPN5f0WEOdeCm4sW1r4mpt0ziVDUKg2DIkEq06hCLkbhiQpzwNXkc6D6ZsRYdlSLJ5AMOlSudFesQsT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0lGCUzxVqBiVeAJVEp0EFsnRJIQG5w7owOkNxrMw3o=;
 b=N4nbva09DTfuP4n0gOlGaOQzNfMtFlSaKLcvu8yURRUaXhoXNIrLvEE5weyrLSuglurIbzpSKnuSCvampKq+CfbsTp4MUZL90Yj4c7mT5dNraoIgJB3ak4l14Hkj819mhGccGrDLviJ6Rmk9JkVw7IB55Ub9geVZ46gitHh1sjs=
Received: from SN1PR12CA0068.namprd12.prod.outlook.com (2603:10b6:802:20::39)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 22:21:44 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::a9) by SN1PR12CA0068.outlook.office365.com
 (2603:10b6:802:20::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 22:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 22:21:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 16:21:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 14:21:42 -0800
Received: from thonkpad (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Thu, 5 Mar 2026 16:21:41 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <superm1@kernel.org>, <sysdadmin@m1k.cloud>,
 <michel.daenzer@mailbox.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Save cursor-only vblank event seperately
 from pflips
Date: Thu, 5 Mar 2026 17:21:31 -0500
Message-ID: <20260305222131.160914-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f86bfc-cf09-4493-9b44-08de7b0594c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: d8X9vM1zxJIvBRzy1MzBzTos3j7PHCjY2VQIzhFNPrnTvmfWMHOES3GUhV4lh9v1X9dxo15dl5ZwQex4oW0LUIYoaRH9dsa8JmlBb+n7i8xSyduDGiDiQdhbaXyDccu9JBzMqiT2We3PaozM2LENg+3d+3treRZ1SfM8n7YoMIVRA3PBoU28EJHZW5zGoW1zo4TGKwcFkBiIRSFikWUuHBsSoxnxnJ1C9LiFDLRHf/c7FrAyWohTR08UUg0vQ3/K97aYhlleX+Xefhra4AdadB4QA7dIGZvkvSZO7KFG0DJBcP6bPoC+xCNC7ujWBUH4cPGvcIS7EEXwwCFuCyUMUBmm+mZIxAUeJSI1g2Sw+MpsunXMN36YQC86AGtUmQd4nrFVSnBK2gZ8PVP24nHzO/ao5iutYEvy5NcoY2Vzs0guObvk0xowb5nhRnvxAyA1g2YAHN85iVQKEcAVLk3ELdwtaAAfB7taEgk7ZbrR6iVYCGfkc6Fj8Ce1bRm+/DHNzyaKBYu0egywhvCoXTBJAljntGlV6f/jtKQ/gBKgqMiHZ9VUAURZthTUHbX30vRxaVwSsBTK4M3bcqJ7ACeu2zDsz3akMjvWIU2zWRL4JQo8Hblh3+qFTha2NQGKI50GlZSKpt+ZOmoFoopZKSOHyZzHJ9SZSJ6JF3EtUZPUo8pgLiAip0MgN4wdMkcaQPcWuNpeigxBB3O5QuUiss8gpuPYWhaHJCq+SBsj3A+3Fdfdwo+IA8nyW2Pg6hccFaKD9uVGWjmm/FZiSb4PYqjcpJ9auHhPeZOPOhAQqoM784s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U4DjnsqPXDuBBmUyQKC4y3vSQ3olPA5G8YjRhMKcAyVISZeOEqMxD7c90TgHYawHVQq9GSnh10liEWB4FttaetDtg4JcvcvvKn7UGZ6YL7D5iS9Enwie0QDxDp8nTgBeu3dsKVcsMiZdzMLXyGF5rzp8ETg6A3tyqutJEdAlX6F6P5xIxwuswhMrrvjIGImWlDcb/xbvuNJLTecsTL9Y4mgPbSxTZG8X4tFNH7NzEzpNieJYcTm6Ys6ZTFusqtJD1Y4/mQWtlbU6J4CAvwaJv+dpYMgluj577LvWsXvDMRpRwIyvZlTGxtvWVPHWaTw3YF2TkgteXidz5IRiYiit7Pa8E9KSn3V24fvhkNchEnOG/dUWafNElaf6XGPf53qvoxardQKZofqJuOJp/1p6CoO3F+/ws/yMAb0Z1OXpG8ZJWoYlgFpBKXBQnJmHU9A+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:21:43.3793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f86bfc-cf09-4493-9b44-08de7b0594c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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

It's suspected that there's a race condition where cursor-only updates
can race with page-flip updates when updating the amdgpu_crtc->event,
which is used to track the pending vblank event until it's send by the
interrupt handler.

Theoretically, DRM should prevent concurrent updates on the same CRTC.
But evidently, according to findings[1] on a previous attemp to fix
this, there is a race.

[How]

Save pending vblank events from cursor-only updates seperately in
amdgpu_crtc->cursor_event. Since cursor updates won't arm the pflip_irq
to fire, we'll send it in crtc/vupdate_irq handlers.

[1] https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  6 +++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dc8d2f52c7d61..67a3b56b6632b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -506,6 +506,7 @@ struct amdgpu_crtc {
 
 	int otg_inst;
 	struct drm_pending_vblank_event *event;
+	struct drm_pending_vblank_event *cursor_event;
 
 	bool wb_pending;
 	bool wb_enabled;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 50a10b4fbb3ff..b31f64592f7ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9515,6 +9515,21 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 		      acrtc->crtc_id);
 }
 
+static void prepare_cursor_event(struct amdgpu_crtc *acrtc)
+{
+	assert_spin_locked(&acrtc->base.dev->event_lock);
+	WARN_ON(acrtc->cursor_event);
+
+	acrtc->cursor_event = acrtc->base.state->event;
+
+	/* Mark this event as consumed */
+	acrtc->base.state->event = NULL;
+
+	drm_dbg_state(acrtc->base.dev,
+		      "crtc:%d, cursor event prepared\n",
+		      acrtc->crtc_id);
+}
+
 static void update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -10129,8 +10144,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 		if (acrtc_attach->base.state->event) {
 			drm_crtc_vblank_get(pcrtc);
-			acrtc_attach->event = acrtc_attach->base.state->event;
-			acrtc_attach->base.state->event = NULL;
+			prepare_cursor_event(acrtc_attach);
 		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 2e7ee77c010e1..567f9dc0ef300 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -49,10 +49,10 @@ void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
 	spin_lock_irqsave(&dev->event_lock, flags);
 
 	/* Send completion event for cursor-only commits */
-	if (acrtc->event && acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
-		drm_crtc_send_vblank_event(crtc, acrtc->event);
+	if (acrtc->cursor_event) {
+		drm_crtc_send_vblank_event(crtc, acrtc->cursor_event);
 		drm_crtc_vblank_put(crtc);
-		acrtc->event = NULL;
+		acrtc->cursor_event = NULL;
 	}
 
 	spin_unlock_irqrestore(&dev->event_lock, flags);
-- 
2.52.0

