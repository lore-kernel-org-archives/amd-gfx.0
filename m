Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lQOBh97b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE5F10F82D;
	Tue, 17 Nov 2026 17:14:48 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A76B10F82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFOjFMfKNjldQNuI40FjXSmGzsVWZ+stBRohGTt9CCwtsr5mCS0kxjughXmSNyq4GIWqxgYUKxOywv0p89sadCJ3WQcqqwfepL7U3+Y15mG1aAIJmrwYbtFDCc062cSktwILW1/H/uAtp+lrET91msFL/Qmx+qQ1nRTEb40FcwgQkSHhE/xlLQi1JLW7QyCmZI+vUwkduh03Y/BPFek8C9+JDvpw4wA71/eAc08x8SewDjLAA90FEJiq52SfLxKSXTy8pa43wKL/ln20oxPNXCMaEpyRF8/nyIdZz/33MjoseE05JH5AgEEvSF2xy4fMH5a4+H6Rm+rtYdi4xgFvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XZm7IichDuplFpBNqMY2TdMcUpxIZ8FfzvUe5tceZ4=;
 b=RTZn5SXjkRknck3zizK+zhBsds/juTcEnTEPkzf2mJDeqZYhKj/9RFjtu6DxrgJKt2Ic4cPlfstPtRN/yw0RUcKyacXZBPVICU+AARoEEDE2grnq0KrbuBWZlPUfiRk+K+/Os3lwy3W0qx84v/LmEv8bhl6Ff2nlfCIUO7foHaHaF0om9vtVKiOgSgPyUZLwn1lm2wTq7bjoHcjlpaIuzmAgnhYabUFqEICD3XxcheCsMxZVYNtG9Upkph/M7PqoHezTp5qITM+tnMEYBDIXo8khsWZtJCbKfuepdNxkN99ygKnTHu97MPA/947Y7iY2WrxsKSymXsijbyJ6oFFsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XZm7IichDuplFpBNqMY2TdMcUpxIZ8FfzvUe5tceZ4=;
 b=lQOBh97bHtkOR6kYdvRgK2xsn6iYGAQJZa5f4GEyg3z/JzXLu1mAiYji5bDZdF7HeqWG8nSpYM2NjhXjwvgY95BrJs1BUJI4u+GzoDYP7522qgFJgPiTVzsO3rHuWjKWawNTwZzOahWIt/9gLJy4PGvygWwn2OwZAsRhNCRkTv4=
Received: from CY5PR22CA0027.namprd22.prod.outlook.com (2603:10b6:930:16::8)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:14:35 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::ab) by CY5PR22CA0027.outlook.office365.com
 (2603:10b6:930:16::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:14:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:33 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:24 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 14/33] drm/amd/display: Queue vblank control work to sleepable
 context
Date: Tue, 17 Nov 2026 05:50:51 +0800
Message-ID: <20261116215641.2800595-15-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: c2687709-1df4-4b08-a684-08df44ce4063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|6133799003|3023799007|5023799004|11063799006|56012099006|261022075727099003|261026121527099003|261028144727099003|261009223327099003|261009221227099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009221727099003|261009223027099003|261102130727099003|261009220027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 7y11Vekms9xdM95ZkhvUcB/ggkrKZWLd+tXjMRcRpN2NkZ9H0ujrQuRRoZfOh/2wjI+WY5gjAjNstOwHM2NAx3a9RReIM2iZqhb/8l5/GHoFBhBQwbHZ4RaiLlCwhE0Wn7O9pbKdwU8kCUFR2ULdO8fmDYmXB6FQlql04HZLoopzo3dOoIChO6WwhqDO5cCry5ncWD9T3kurXrn2TD+jI3xxJpjvfeO2S82p+iPm4Q1ELx99g24aplcIxY3NcCO9heoiWICnK0XQFUxR30bk5RVRT2BhFf6IphjQty/lGLyFDpqGNalM4zkAb/l+Lc1F4qI72NwVBiZlFh8JuZ5p+NmLM1f4uPwSTtydsMMNdqtO/Jf25i093pelmpLNKG7xsBbpe8bwBRFDt7RFxPz9J7RBa8IG4L3gKhpBq4j1/3tOerAgm9WsflpsFO7dfq7hiVROCaqurqckvN3CbeZsazJgJX2Z5P+EHR/W7fLHX7/9cLSn72gbrm7CpXD3WTLqL9iWHfhTGqy9Y0QZFlDat42gY4sqKRxUWxugzPBrcwU062Gap94cfonueigi2NBtiS5Bc7Ekc80yJcIJ4vP4DnUtoABaXKlMNo2yVieNz8v9czjtHKq8THYyICs/Kpwde3rUYrsohe0shcYs4AbuMjxjMSyFjCqeO3lArUrTXAORYnoOqvDqziWtFYLrtCcPw2DU7wmMWm28I/283Haiqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261028144727099003)(261009223327099003)(261009221227099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009221727099003)(261009223027099003)(261102130727099003)(261009220027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ff6tlVbbpx3yfRP9QBJE3ju8xJqH0lxyHzel7uJimHepf6Dl7DXIfLPYEvl9/8yKKliFafPD9Mwx1ermfklI/c+6bYkpze11OpxPJnAayrqNMjOH4dNdIwtdjp23q/s3Fw4a+844ciHti+lhBdiEmOeeVqnZnN7gZPdGuzhU0bYMlDBZL0W3KZi9OT58KyVf8J/uQJG8ZiL28R1+1n79e7+o9cOmHSWatRmzY/oxbacDFzZxuDeJcKhNo05u46qfkZ/pJHQqjTIIF6duyFA+OtVYEsSC/5MgH+tKUU840BMykU6SLoXT/xh54PxJ52L6nvCfiAzBpJkpUXniUMIh7/4b7ewdkSDa1dJby2NVMTG3m3o7EVt4WmvMndquI6s4oTKeLSvAELDlgdKjX4AN/PjTiXzQSafl/ztGwaR+iUaICkvEOjvLcecAb+mfILU1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:34.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2687709-1df4-4b08-a684-08df44ce4063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Zhang <george.zhang@amd.com>

[why & how]
Currently, vblank control exits idle to program HW, but it does not (and
cannot) hold dc_lock to prevent another thread from entering device-wide
idle.

Add a flag to check if we are able to use the HW vblank counter or not.
If not, assume that we are in idle, and queue a worker to enable/disable
vblank in a sleepable context. Update the value of the flag accordingly
in the ISM.

In the gap between returning from vblank_control and the worker enabling
HW, use the flag to determine if we should output a virtual vblank
counter or not.

Finally, lock DM internal callers of dm_vblank_get_counter.

Cc: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  93 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  49 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 225 ++++++++++++------
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  20 +-
 5 files changed, 302 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2f4c6a2dd4ec..29d7c87a94ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -172,6 +172,7 @@ static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
 STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 {
 	struct amdgpu_crtc *acrtc = NULL;
+	struct amdgpu_display_manager *dm = &adev->dm;
 
 	if (crtc >= adev->mode_info.num_crtc)
 		return 0;
@@ -184,7 +185,19 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 		return 0;
 	}
 
-	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
+	guard(spinlock_irqsave)(&adev->dm.sw_counter_lock);
+
+	if (acrtc->otg_inst < 0) {
+		drm_err(adev_to_drm(adev), "dm_vblank_get_counter: no otg_inst for crtc '%d'!\n",
+			crtc);
+		return 0;
+	}
+
+	if (dm->use_sw_vblank_counter)
+		return dm->otg_sw_counter[acrtc->otg_inst].frozen;
+
+	return (dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream) +
+		dm->otg_sw_counter[acrtc->otg_inst].offset) & 0xffffff;
 }
 EXPORT_IF_KUNIT(dm_vblank_get_counter);
 
@@ -192,8 +205,8 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 					    u32 *vbl, u32 *position)
 {
 	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
+	struct amdgpu_display_manager *dm = &adev->dm;
 	struct amdgpu_crtc *acrtc = NULL;
-	struct dc *dc = adev->dm.dc;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -206,8 +219,20 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 		return 0;
 	}
 
-	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
-		dc_allow_idle_optimizations(dc, false);
+	guard(spinlock_irqsave)(&adev->dm.sw_counter_lock);
+
+	if (acrtc->otg_inst < 0) {
+		drm_err(adev_to_drm(adev), "dm_crtc_get_scanoutpos: no otg_inst for crtc '%d'!\n",
+			crtc);
+		return 0;
+	}
+
+	if (dm->use_sw_vblank_counter) {
+		*vbl = dm->otg_sw_counter[acrtc->otg_inst].vblank_start |
+		       (dm->otg_sw_counter[acrtc->otg_inst].vblank_end << 16);
+		*position = dm->otg_sw_counter[acrtc->otg_inst].vblank_end;
+		return 0;
+	}
 
 	/*
 	 * TODO rework base driver to use values directly.
@@ -226,6 +251,61 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 }
 EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 
+/* active_vblank_irq_count must be 0 before calling this function */
+void amdgpu_dm_sw_counter_freeze(struct amdgpu_display_manager *dm)
+{
+	struct dc *dc = dm->dc;
+
+	lockdep_assert_held(&dm->dc_lock);
+
+	if (!dc->caps.ips_support || dc->config.disable_ips == DMUB_IPS_DISABLE_ALL)
+		return;
+
+	guard(spinlock_irqsave)(&dm->sw_counter_lock);
+
+	if (dm->use_sw_vblank_counter)
+		return;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		u32 hw, h_position, v_position;
+
+		hw = dc_otg_get_vblank_counter(dc, i);
+		dm->otg_sw_counter[i].frozen = (hw + dm->otg_sw_counter[i].offset + 1) & 0xffffff;
+		dc_otg_get_scanoutpos(dc, i,
+				      &dm->otg_sw_counter[i].vblank_start,
+				      &dm->otg_sw_counter[i].vblank_end,
+				      &h_position, &v_position);
+	}
+
+	dm->use_sw_vblank_counter = true;
+
+}
+
+/* should only be called after IPS exit */
+void amdgpu_dm_sw_counter_resume(struct amdgpu_display_manager *dm)
+{
+	struct dc *dc = dm->dc;
+
+	lockdep_assert_held(&dm->dc_lock);
+
+	if (!dc->caps.ips_support || dc->config.disable_ips == DMUB_IPS_DISABLE_ALL)
+		return;
+
+	guard(spinlock_irqsave)(&dm->sw_counter_lock);
+
+	if (!dm->use_sw_vblank_counter)
+		return;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		u32 hw;
+
+		hw = dc_otg_get_vblank_counter(dc, i);
+		dm->otg_sw_counter[i].offset = (dm->otg_sw_counter[i].frozen - hw) & 0xffffff;
+	}
+
+	dm->use_sw_vblank_counter = false;
+}
+
 STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
@@ -516,6 +596,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 
 	spin_lock_init(&adev->dm.dmub_lock);
+	spin_lock_init(&adev->dm.sw_counter_lock);
 
 	if (amdgpu_dm_irq_init(adev)) {
 		drm_err(adev_to_drm(adev), "failed to initialize DM IRQ support.\n");
@@ -768,8 +849,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.vblank_control_workqueue =
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
-		if (!adev->dm.vblank_control_workqueue)
+		if (!adev->dm.vblank_control_workqueue) {
 			drm_err(adev_to_drm(adev), "failed to initialize vblank_workqueue.\n");
+			goto error;
+		}
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 761d2b40aece..63c1c2ea80aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -319,6 +319,28 @@ struct hpd_rx_irq_offload_work {
 	struct amdgpu_device *adev;
 };
 
+/**
+ * struct dm_otg_sw_counter - Per-OTG sw vblank counter state
+ * @frozen: Frozen vblank counter snapshot, valid while
+ *	    dm->use_sw_vblank_counter is set.
+ * @offset: Offset applied to the live hw vblank counter to keep it
+ *	    continuous across a freeze/resume cycle.
+ * @vblank_start: Frozen scanout vblank start position, valid while
+ *		  dm->use_sw_vblank_counter is set.
+ * @vblank_end: Frozen scanout vblank end position, valid while
+ *		dm->use_sw_vblank_counter is set.
+ *
+ * Indexed by otg_inst rather than by CRTC, so a value survives a CRTC's
+ * stream being reassigned to a different OTG. Guarded by
+ * dm->sw_counter_lock.
+ */
+struct dm_otg_sw_counter {
+	u32 frozen;
+	u32 offset;
+	u32 vblank_start;
+	u32 vblank_end;
+};
+
 /**
  * struct amdgpu_display_manager - Central amdgpu display manager device
  *
@@ -467,6 +489,30 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex dc_lock;
 
+	/**
+	 * @sw_counter_lock
+	 *
+	 * Guards sw_vblank counter.
+	 */
+	spinlock_t sw_counter_lock;
+
+	/**
+	 * @use_sw_vblank_counter
+	 *
+	 * use sw vblank counter instead of hw vblank counter. Can only be set
+	 * under dc_lock and sw_counter_lock.
+	 * Set implies active_vblank_irq_count == 0.
+	 */
+	bool use_sw_vblank_counter;
+
+	/**
+	 * @otg_sw_counter:
+	 *
+	 * Per-OTG sw vblank counter state, indexed by otg_inst. Guarded by
+	 * sw_counter_lock. See &struct dm_otg_sw_counter.
+	 */
+	struct dm_otg_sw_counter otg_sw_counter[AMDGPU_MAX_CRTCS];
+
 	/**
 	 * @dmub_lock:
 	 *
@@ -1171,6 +1217,9 @@ bool amdgpu_dm_execute_fused_io(
 int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int link_index,
 					struct set_config_cmd_payload *payload, enum set_config_status *operation_result);
 
+void amdgpu_dm_sw_counter_freeze(struct amdgpu_display_manager *dm);
+void amdgpu_dm_sw_counter_resume(struct amdgpu_display_manager *dm);
+
 int dm_atomic_get_state(struct drm_atomic_commit *state,
 			struct dm_atomic_state **dm_state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8d31c673817c..8d25b034111f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -223,33 +223,6 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(idle_create_workqueue);
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
-{
-	struct vblank_control_work *vblank_work =
-		container_of(work, struct vblank_control_work, work);
-	struct amdgpu_display_manager *dm = vblank_work->dm;
-
-	mutex_lock(&dm->dc_lock);
-
-	if (vblank_work->enable) {
-		dm->active_vblank_irq_count++;
-		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
-				DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
-	} else {
-		if (dm->active_vblank_irq_count > 0)
-			dm->active_vblank_irq_count--;
-		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
-				DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
-	}
-
-	mutex_unlock(&dm->dc_lock);
-
-	dc_stream_release(vblank_work->stream);
-
-	kfree(vblank_work);
-}
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
-
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 STATIC_IFN_KUNIT int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int irq_type,
 						   bool enable)
@@ -274,45 +247,20 @@ STATIC_IFN_KUNIT int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int ir
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_vline0_irq);
 #endif
 
-static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
+static int amdgpu_dm_program_vblank_irq(struct amdgpu_crtc *acrtc, bool enable)
 {
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct drm_crtc *crtc = &acrtc->base;
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	struct amdgpu_display_manager *dm = &adev->dm;
-	struct vblank_control_work *work;
-	int irq_type;
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	int rc = 0;
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable && !acrtc->base.enabled) {
-		drm_dbg_vbl(crtc->dev,
-				"Reject vblank enable on unconfigured CRTC %d (enabled=%d)\n",
-				acrtc->crtc_id, acrtc->base.enabled);
-		return -EINVAL;
-	}
-
-	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
-
-	if (enable && acrtc_state->stream) {
-		struct dc *dc = adev->dm.dc;
-		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
-		struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
-		bool sr_supported = (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED) ||
-								pr->config.replay_supported;
-
-		/*
-		 * IPS & self-refresh feature can cause vblank counter resets between
-		 * vblank disable and enable.
-		 * It may cause system stuck due to waiting for the vblank counter.
-		 * Call this function to estimate missed vblanks by using timestamps and
-		 * update the vblank counter in DRM.
-		 */
-		if (dc->caps.ips_support &&
-			dc->config.disable_ips != DMUB_IPS_DISABLE_ALL &&
-			sr_supported && vblank->config.disable_immediate)
-			drm_crtc_vblank_restore(crtc);
-	}
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	rc = amdgpu_dm_crtc_set_vline0_irq(crtc, irq_type, enable);
+	if (rc)
+		return rc;
+#endif
 
 	/*
 	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
@@ -382,33 +330,154 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			return rc;
 	}
 
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	rc = amdgpu_dm_crtc_set_vline0_irq(crtc, irq_type, enable);
+	return 0;
+}
+
+static int amdgpu_dm_sync_vblank_irq(struct amdgpu_crtc *acrtc, bool enable)
+{
+	struct amdgpu_display_manager *dm = &drm_to_adev(acrtc->base.dev)->dm;
+	int rc = 0;
+
+	lockdep_assert_held(&dm->ddev->vbl_lock);
+
+	if (enable == acrtc->dm_irq_params.vblank_irq_programmed)
+		return 0;
+
+	rc = amdgpu_dm_program_vblank_irq(acrtc, enable);
 	if (rc)
 		return rc;
-#endif
 
-	if (amdgpu_in_reset(adev))
-		return 0;
+	acrtc->dm_irq_params.vblank_irq_programmed = enable;
 
-	if (dm->vblank_control_workqueue) {
-		work = kzalloc_obj(*work, GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
+	if (enable)
+		dm->active_vblank_irq_count++;
+	else if (!WARN_ON(!dm->active_vblank_irq_count))
+		dm->active_vblank_irq_count--;
 
-		INIT_WORK(&work->work, amdgpu_dm_crtc_vblank_control_worker);
-		work->dm = dm;
-		work->acrtc = acrtc;
-		work->enable = enable;
+	return 0;
+}
+
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
+{
+	struct vblank_control_work *vblank_work =
+		container_of(work, struct vblank_control_work, work);
+	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_crtc *acrtc = vblank_work->acrtc;
+	bool program;
+
+	mutex_lock(&dm->dc_lock);
+
+	if (vblank_work->enable) {
+		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
+				DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+	}
+
+	scoped_guard(spinlock_irqsave, &dm->sw_counter_lock) {
+		WARN_ON(!acrtc->dm_irq_params.vblank_irq_desired &&
+			acrtc->dm_irq_params.vblank_irq_programmed);
+		program = acrtc->dm_irq_params.vblank_irq_desired &&
+			  !acrtc->dm_irq_params.vblank_irq_programmed;
+	}
 
-		if (acrtc_state->stream) {
-			dc_stream_retain(acrtc_state->stream);
-			work->stream = acrtc_state->stream;
+	if (program) {
+		/*
+		 * The ISM has corner cases where an idle exit event
+		 * (EXIT_IDLE_REQUESTED, BEGIN_CURSOR_UPDATE) does not call
+		 * dc_allow_idle_optimizations(false). E.g. another CRTC's ISM
+		 * can do the release while this ISM is in FULL_POWER_RUNNING,
+		 * where EXIT commits nothing. Acquire and resume here until HW
+		 * ref counting resolves this.
+		 */
+		if (dm->use_sw_vblank_counter) {
+			dc_allow_idle_optimizations(dm->dc, false);
+			amdgpu_dm_sw_counter_resume(dm);
+		}
+
+		scoped_guard(spinlock_irqsave, &dm->ddev->vbl_lock) {
+			if (acrtc->dm_irq_params.vblank_irq_desired &&
+			    !acrtc->dm_irq_params.vblank_irq_programmed)
+				WARN_ON(amdgpu_dm_sync_vblank_irq(acrtc, true));
 		}
+	}
 
-		queue_work(dm->vblank_control_workqueue, &work->work);
+	if (!vblank_work->enable) {
+		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
+				DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
 	}
 
+	mutex_unlock(&dm->dc_lock);
+
+	dc_stream_release(vblank_work->stream);
+
+	kfree(vblank_work);
+}
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
+
+static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
+{
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct vblank_control_work *work;
+	int rc = 0;
+
+	lockdep_assert_held(&crtc->dev->vbl_lock);
+
+	if (enable && !acrtc->base.enabled) {
+		drm_dbg_vbl(crtc->dev,
+				"Reject vblank enable on unconfigured CRTC %d (enabled=%d)\n",
+				acrtc->crtc_id, acrtc->base.enabled);
+		return -EINVAL;
+	}
+
+	work = kzalloc_obj(*work, GFP_ATOMIC);
+	if (!work && enable)
+		return -ENOMEM;
+
+	if (enable) {
+		if (acrtc_state->stream && dm->dc->caps.ips_support &&
+		    dm->dc->config.disable_ips != DMUB_IPS_DISABLE_ALL &&
+		    drm_crtc_vblank_crtc(crtc)->config.disable_immediate)
+			drm_crtc_vblank_restore(crtc);
+
+		acrtc->dm_irq_params.vblank_irq_desired = true;
+
+		scoped_guard(spinlock_irqsave, &dm->sw_counter_lock) {
+			if (!dm->use_sw_vblank_counter) {
+				rc = amdgpu_dm_sync_vblank_irq(acrtc, enable);
+				if (rc) {
+					acrtc->dm_irq_params.vblank_irq_desired = false;
+					kfree(work);
+					return rc;
+				}
+			}
+		}
+	} else {
+		acrtc->dm_irq_params.vblank_irq_desired = false;
+
+		scoped_guard(spinlock_irqsave, &dm->sw_counter_lock)
+			WARN_ON(dm->use_sw_vblank_counter &&
+				acrtc->dm_irq_params.vblank_irq_programmed);
+
+		amdgpu_dm_sync_vblank_irq(acrtc, enable);
+	}
+
+	if (!work)
+		return -ENOMEM;
+
+	INIT_WORK(&work->work, amdgpu_dm_crtc_vblank_control_worker);
+	work->dm = dm;
+	work->acrtc = acrtc;
+	work->enable = enable;
+
+	if (acrtc_state->stream) {
+		dc_stream_retain(acrtc_state->stream);
+		work->stream = acrtc_state->stream;
+	}
+
+	queue_work(dm->vblank_control_workqueue, &work->work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index f0c1b0c1faa9..94a3e2f4161c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -36,6 +36,8 @@ struct dm_irq_params {
 	int active_planes;
 	bool allow_sr_entry;
 	struct mod_freesync_config freesync_config;
+	bool vblank_irq_desired;
+	bool vblank_irq_programmed;
 
 #ifdef CONFIG_DEBUG_FS
 	enum amdgpu_dm_pipe_crc_source crc_src;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 127eaba4de60..74b33d9d8833 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -293,8 +293,10 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	 * If there is an active vblank requestor, or if SSO is being engaged,
 	 * then disallow idle optimizations.
 	 */
-	if (vblank_enabled || allow_panel_sso)
+	if (vblank_enabled || allow_panel_sso) {
 		dc_allow_idle_optimizations(dm->dc, false);
+		amdgpu_dm_sw_counter_resume(dm);
+	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -326,9 +328,19 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	 * optimizations at the start of this func -- we should disallow
 	 * whenever there's *an* active CRTC.
 	 */
-	if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
-		dc_post_update_surfaces_to_stream(dm->dc);
-		dc_allow_idle_optimizations(dm->dc, true);
+	if (!vblank_enabled) {
+		bool allow;
+
+		scoped_guard(spinlock_irqsave, &dm->ddev->vbl_lock) {
+			allow = !dm->active_vblank_irq_count;
+			if (allow)
+				amdgpu_dm_sw_counter_freeze(dm);
+		}
+
+		if (allow) {
+			dc_post_update_surfaces_to_stream(dm->dc);
+			dc_allow_idle_optimizations(dm->dc, true);
+		}
 	}
 }
 
-- 
2.43.0

