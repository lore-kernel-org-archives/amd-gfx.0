Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60630C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9928A10E56B;
	Fri,  9 Dec 2022 16:37:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90EE10E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGKa7pu7pZ83NTpQD03/dvJ1WIZGT876uDlIh6VlkbtA2NUJ5T7AVmXdfUxxtNlmpDm/uWq7UWxdCFHjtP7oDXWDPXcst4HXyWdafkRHUmNKlovidlWVdYVpmNPzbarKKeFJAEoisrZxHZg4+/MblqowEXx4DejNzE4ux56fPVk0wrgMw31ERFI3tNIkEfx30Nb7VBwo0c/ZHDB39psrKu88/uWhd2vMUM4FEdeAgw7QzqGkATOLiGXHYNdeuFUAEUd/PLSSErrulzZBLE1KPW4eFuAHM9UupzzqoVgZZrSHgXPCwnonT27tno30v9/MOCgqQqNUZCp9Ak2ncYCFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LyEyNvqHNq8XIyBhNKbISUASc4qXqFvMvz5/8sBvDc=;
 b=Ydh1jlMuXMZNd+mep/EZkhiwfTxGv4NupO9DWZniYJFCVptMCjAElIljgudMfZV3wcgqdX20L9jo/Z6+gWS42SIHZo8qDbyJZCXGHAXquKwPSkKXnjvgSfYMwwJEDkrCdNMHiAXkXv5brG+ytYcoQYnzpkCXQ74xGlGg9Hxujom8smse4TA2P4+25oVcflGKytKqy+0AvKbt7YaWfJWkMBxkcf27P/kCMu7HXF761WPDNZR4YZJYyv7V/A9JnKijAO5cqptGZPnJ2jG//vis90ZVYD2xcJUzNtyG3Q+16FJfSm9aYIDb4a11jYzeYCcsCaNFbnWsHXVcT2BQ7EHBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LyEyNvqHNq8XIyBhNKbISUASc4qXqFvMvz5/8sBvDc=;
 b=H2QIs559uuL6OkLTBQS4bYltVTn/VceeA2CdQS12Qlj5ziaenKCi0C2AVcCIuHD0H++l06Dd9i9yHgEAcJgojkUcQ+f3yH49cZGmP5Ps1QWdlKS4Y0k4keGmk/r4xVfdFQvwuddWIYt3l80jU4XE0SpkVUvRDZss37pFlGJUvX4=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:21 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::14) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:21 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:18 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/23] drm/amd/display: Fix when disabling secure_display
Date: Fri, 9 Dec 2022 11:36:28 -0500
Message-ID: <20221209163647.25704-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a61f281-2f98-456c-5faa-08dada03a506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJX+HujmldEnQ6vLkm+Z5g8u53R8/O4QFl6qM9clnPa+adWY+wnne3trlFm5o5bniOSoROfFjsgcqI6UafgGRj1vYrtcNDzORCVsjNJzfjCsyrUlIfzUEAbhQ9XvqrlB1fFz1s/YZ7/I58RudPXdkQdFRcXMbSt+nAakmLBIgybmTuGZUoHkJBsKQfjedAoMkYvUl9PMYKvvBw+aVj1o9U/L6L3BzYq7NW4FxdfX+T7z701xnYjHC1ZF3irZhykEypz8eBiuVOjw/qnkj4eYeVwLmda/OPlpyp02d8qGn6PrSnS8axWoV9mehq561mzkYhdOyQQq+B595uDozq6G8HTsbbtUXA9YqOVfSiDfedK4vnb6tPBpI8tyeE5YnokUGL8RUi3zhi51rnLsjWDyjuqcSSWmIS0C9KAJZdLChyYW7ymbR9PNVBoOwfoj0/wCB8nMDeU/VPcEctK7pHHL4uNFyj286G+bAJ0av67vp/iXdWdGOuKxm2HgakkWSf/FzsCfRH2gonFehOL1XJ1gdbPsoBIagwmo7dfGPCKO9d6bBRqCIUmrhzjcgoaA5zqqoe93RbYHmv3ZvprnFgeowlvNJnej4sCm49CrsKv1S6vqHAbA1ppZBk4Edc2DkQDD0rU7uemgQ7xLK2ZWXwO6q7o73Vk21PqtV/xENyprQurWpTuehUabC9TPeP7kxqoiT5P3UCh3UD6Ql7vxokqdq/JM+hvYPocOm5LHHbCiIZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(26005)(4326008)(8676002)(82310400005)(1076003)(83380400001)(8936002)(41300700001)(70206006)(16526019)(70586007)(2616005)(186003)(82740400003)(336012)(478600001)(426003)(356005)(54906003)(81166007)(6916009)(36860700001)(40480700001)(5660300002)(40460700003)(36756003)(2906002)(6666004)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:21.3355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a61f281-2f98-456c-5faa-08dada03a506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

[Why]
Fix problems when we disable secure_display.

[How]
- Reset secure display context after disabled
- A secure_display_context is dedicate to a crtc, so we set the crtc for
it when we create the context.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 28 +++++++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  5 ++--
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4c2a99fbcd70..bbacd764bf0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1642,7 +1642,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 #endif
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev->dm.dc->caps.max_links);
+	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev);
 #endif
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 6453abcf5f4b..733041a55ed1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -214,14 +214,12 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 		/* Disable secure_display if it was enabled */
 		if (!enable) {
-			if (adev->dm.secure_display_ctxs) {
-				for (i = 0; i < adev->mode_info.num_crtc; i++) {
-					if (adev->dm.secure_display_ctxs[i].crtc == crtc) {
-						/* stop ROI update on this crtc */
-						flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
-						dc_stream_forward_crc_window(stream_state, NULL, true);
-						adev->dm.secure_display_ctxs[i].crtc = NULL;
-					}
+			for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+				if (adev->dm.secure_display_ctxs[i].crtc == crtc) {
+					/* stop ROI update on this crtc */
+					flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
+					flush_work(&adev->dm.secure_display_ctxs[i].forward_roi_work);
+					dc_stream_forward_crc_window(stream_state, NULL, true);
 				}
 			}
 		}
@@ -496,7 +494,12 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	}
 
 	secure_display_ctx = &adev->dm.secure_display_ctxs[acrtc->crtc_id];
-	secure_display_ctx->crtc = crtc;
+	if (WARN_ON(secure_display_ctx->crtc != crtc)) {
+		/* We have set the crtc when creating secure_display_context,
+		 * don't expect it to be changed here.
+		 */
+		secure_display_ctx->crtc = crtc;
+	}
 
 	if (acrtc->dm_irq_params.window_param.update_win) {
 		/* prepare work for dmub to update ROI */
@@ -527,19 +530,20 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 }
 
 struct secure_display_context *
-amdgpu_dm_crtc_secure_display_create_contexts(int num_crtc)
+amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
 {
 	struct secure_display_context *secure_display_ctxs = NULL;
 	int i;
 
-	secure_display_ctxs = kcalloc(num_crtc, sizeof(struct secure_display_context), GFP_KERNEL);
+	secure_display_ctxs = kcalloc(AMDGPU_MAX_CRTCS, sizeof(struct secure_display_context), GFP_KERNEL);
 
 	if (!secure_display_ctxs)
 		return NULL;
 
-	for (i = 0; i < num_crtc; i++) {
+	for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
 		INIT_WORK(&secure_display_ctxs[i].forward_roi_work, amdgpu_dm_forward_crc_window);
 		INIT_WORK(&secure_display_ctxs[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
+		secure_display_ctxs[i].crtc = &adev->mode_info.crtcs[i]->base;
 	}
 
 	return secure_display_ctxs;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 4323f723c0de..935adca6f048 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -54,7 +54,7 @@ struct crc_window_param {
 };
 
 struct secure_display_context {
-	/* work to notify PSP TA to transmit CRC over I2C */
+	/* work to notify PSP TA*/
 	struct work_struct notify_ta_work;
 
 	/* work to forward ROI to dmcu/dmub */
@@ -95,7 +95,8 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc);
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc);
-struct secure_display_context *amdgpu_dm_crtc_secure_display_create_contexts(int num_crtc);
+struct secure_display_context *amdgpu_dm_crtc_secure_display_create_contexts(
+						struct amdgpu_device *adev);
 #else
 #define amdgpu_dm_crc_window_is_activated(x)
 #define amdgpu_dm_crtc_handle_crc_window_irq(x)
-- 
2.34.1

