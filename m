Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283BDC5478C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE64810E968;
	Tue, 27 Feb 2024 18:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SAzYuRDF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C08110E968
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 18:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci5apXFkfldQEvQDbjZJim4Fp4kN+szrdtef1GLcVgXwGTpnQE3s+MkBCdvwn9gns3Swt2lnbHzSYgIRqBDDk9eq1XBiDT4eLvbMpHtG2ydORElNfI6ENtNeNZRfSzl/VWJJBZBo26Nqcqz3kwSGjFca9ARlWm6xcNmfp2AxIcwgLwW/ZQiDrFS5vrLrpd0Jtu87+5adnr5NdDlMRHd4o+XiA9wvMfuLbcETvS8RWQrVKKqzZZeym4BaU2+bW3sAT7q+TNM8invB0rtKgwq8wy/KgdL702Z4UBV7Wjazv5jZsulG3y1sbfYoLU9gnhp+YxByd8WcgW5Tp4ycy+jICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q4V8zX+TZOON6P211ZT60GLfC0/ypr9szbL6+hLCDc=;
 b=nl2aF1evx1yDEm/ZxWdDqf4Z8oD0q/0xUxSolctU36ZaeMckDRJ5AzFnw06Rsip/8ZfFNzS2tMfXoRUzsyswW9Se3Tjtz7pr1RDNVJ7nKzYc966qcCIDJFalaoxClwxAxz1S17Tpte/SpDVP7s2cLU15lv98a3SRiwO6/z8qrKK6erMOQb9c+nwmnAfr1CaAxBWjrrvMwYEhm7dNcUY0/G1uy605UxvaaSRy925rnAB6GHgz++mGHpAkum1XTpBuPZbAvUd/ADkFDgfKFw2dq/J7YYGyqQhNEMp2NLSelTxMdE9G68NAWMeqelPvQL5USB9WAmwiYDalOu56C9mfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q4V8zX+TZOON6P211ZT60GLfC0/ypr9szbL6+hLCDc=;
 b=SAzYuRDFaoSMGsCDJ8I17Bh/rreHZzNXSLl2wyMkOuPrkmhz9mLeYSD4/lQf3q3u/K1P8ZqwqavMKDYKY1G098fIagMarIinFzZQ9i8n0sf+Eo1mrvN2qpLUbzEmG5qfU9ACumDxwYowDkuKSegsQkdYHBYd9yw+xYELHZikP9s=
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 18:49:03 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::9b) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 18:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:49:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 12:49:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] Reapply "Revert drm/amd/display: Enable Freesync Video
 Mode by default"
Date: Tue, 27 Feb 2024 13:48:47 -0500
Message-ID: <20240227184847.3078099-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227184847.3078099-1-alexander.deucher@amd.com>
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cb673d-779e-4196-d53f-08dc37c4c4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fnMRGxCD6gNJFWjG8NUll4ZI5nmVSJ/l0daRw142YjnBs2rasuIaHAvNxa3reE5YKcJwLVj5TmdYDxv1xunAbEm11nqFL7N80aCQl/GqQLvR1+v/26Z6nzo+S0oM0Zaj/zo7FL8/hl1slkRH/qFgF19x9DMAewXC8KT8UUFcPJFMOZnhsL4dafMOKKqX8Y2CSk2yRBQdCAYMudw/TZ5Y0ri/y0AVLbjfW/jdElNySuTC4WeIwQlqQhXfAWwUr3A0l/K1ItxD71lOCdnAMsKKLqGtxnb/ta7R+xlY4A5klER8RMCriovy1HUtYshVFP5qHuCIYAbkJy18g2QBUhx1ZH6DFWEUk6jqcyd/pvy3iqHZQnNFUDI+X1sdxUBmAiCu84E3EPdEPAct0X/nVj+qBT4ViS/wBWZeUgH5gpbReuaCaMxnrbqP6VNvyOvsuCPvncthQzW5U91cdwffjH/CG6AIotfcQrYvxHusHTgUAIScinZfAF78+eqNgUphL7Js/OP7QeVuRyeQjvwp5/++tIggjDoQoR8h1/MebdDX+tkzEdqAmV5KQjWClg+KF1mSvpwj7Rs7AtAvwlGUuU2PAcsBochVcXFjOnVGBw6eN4gAzqQGkU2K7YcpQQLsQmyRL2TWap8JZamW/9ss6m/3A054XAzHuGSRjfTNc2mXoIhbW59yHMDSaJlX6eOdHueuCwnySV0QsChzkg8SV7/WeaR5Y9whPbXjsuTBWtYnws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:49:03.3060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cb673d-779e-4196-d53f-08dc37c4c4bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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

This reverts commit 11b92df8a2f7f4605ccc764ce6ae4a72760674df.

This conflicts with how compositors want to handle VRR.  Now
that compositors actually handle VRR, we probably don't need
freesync video.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5765e492c4557..2c283c47bcf6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6230,7 +6230,8 @@ create_stream_for_sink(struct drm_connector *connector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else if (aconnector) {
-		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
+		recalculate_timing = amdgpu_freesync_vid_mode &&
+				 is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
@@ -7541,7 +7542,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-	if (!edid)
+	if (!(amdgpu_freesync_vid_mode && edid))
 		return;
 
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
@@ -9835,7 +9836,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * TODO: Refactor this function to allow this check to work
 		 * in all conditions.
 		 */
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode &&
+		    dm_new_crtc_state->stream &&
 		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
 			goto skip_modeset;
 
@@ -9875,7 +9877,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		}
 
 		/* Now check if we should set freesync video mode */
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
@@ -9888,7 +9890,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
-		} else if (aconnector &&
+		} else if (amdgpu_freesync_vid_mode && aconnector &&
 			   is_freesync_video_mode(&new_crtc_state->mode,
 						  aconnector)) {
 			struct drm_display_mode *high_mode;
-- 
2.43.2

