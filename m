Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B87EE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C568410EB07;
	Tue,  7 Jan 2025 15:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7lSoIkV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE2810EB07
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTUc6natLUE2ntzAK0wctEQo2MjdxUYDHneTpp6wtBptGWvivQJ6CQS86qEhF6H2ziCHQQtJ/j+w6D0XTcOGkVKa1cp/lCzoZ85noHQj5ZepQcod3sFfEyZxMbt0Q7W9Q/33tk/1nFbLBc9ZP4h4j500AD51rjU7C4uwhbvuHmOxGG8PpIREUtJFQA6iJ9wGOJYAkb7EVUmyqhr3USr8a3JefbFIh9mt2zB4qJQ3xjI5ZT8xmi+v68iL5yEXl4BF0fdq/bz3BDEWdJTudRl4w0/xFeGrjx43Yy93xpNGRdpGPkKpQiZuYlPaJ+ILIwDgHbXtkRwFQiaCnWlvghMzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyJ3xkdX2Hpsl2KuqF2a8UlBiBSSRK/ireLDkSsuEtI=;
 b=mUAK5F7BgfJNte9dvMeZSR8Y6GIcbqBI9AtWoaByBFs28w5BKjX0XUhRMRZIPhPtawfo6Auk9jdeFvaiRRnfDpbJwbb73qkRvYFRmPYFXPaaB1srxdUgiwJpnUN6xOOlmAVRFS604DQlIcS13ye1L3tufGmVrTqnqKRdzQ/eYdSMXJu/H2TvF9qsaDmK+8SmuIc/kqVMKFVejKhsGeAMgeyX/GXu6dROHUZULyVYkWT7ewvfhaKXs/DbQJkKIZWFjHXVExOAdf9vo19gJHmTNBpxqz70C1NxXTCfoTmrZ1JVAlHsVtP+1EVYXoAV2J9zB4/XoGKLLFkeOZ2al493Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyJ3xkdX2Hpsl2KuqF2a8UlBiBSSRK/ireLDkSsuEtI=;
 b=r7lSoIkVUT59QJS8L5qhc+Po0Phgc8BgFV59bEzZfnyTMbtjqHw2EGbIdrdj2D21+2DrBMAhdA3GcEN6lx7LQFGkhaH9T4cumzRA6ZEQgo0OnpB5aPoX1TznQMaKbWQTZyNVCZ2wh9rZJ344gVZWMZ26Qs3rDzHhiZFW265cC/E=
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:22 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9c) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:21 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:18 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Do not wait for PSR disable on vbl
 enable
Date: Tue, 7 Jan 2025 23:28:46 +0800
Message-ID: <20250107152855.2953302-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: b883f344-36e1-4350-a5f1-08dd2f303384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zne14PU9NrPd5UDl66m5KhReNqvNQ2XtcwPZRYn9Tc+4QH1NRqVdWI5opgFk?=
 =?us-ascii?Q?1Xu0JPMp4Z7RuWt6/bERBOL3baPO5bJ/Dyib0lEgozlChx5929XvWYbzB9Ci?=
 =?us-ascii?Q?SV9cnK4DrfE8ZF823JiYlAEa79fQxHVoWpJCI8Af2+i/RsIESLLxSUgS/N4d?=
 =?us-ascii?Q?CyZ+ehxBena5SjhUHnpGmCmEwS97mGXI4mp5rsF46uvtk6eREvuizauRKgDB?=
 =?us-ascii?Q?8+vqAfaJgC/smTFc+6NMpLdcEv1KwRScLI5/JnHnC33BPgMIV73JsSfMNQ60?=
 =?us-ascii?Q?FvO2SLoDX2ozweaEshkSF12bWpTNrFZ296PkFleKbZKGAHuLubPZBi/8xvr5?=
 =?us-ascii?Q?xTniei0jtl42b3CQWfbcSQMsuxgM8V2k1NJEBWWio7dqLwG5wFleIFFRLPTH?=
 =?us-ascii?Q?V7Pd1looNv3hkNqAN+z/nP4wDS47esLfoMKj4ZLrNi5ffaFVtwUk7crpOuQn?=
 =?us-ascii?Q?iHQArb2oLaGKcx3NqLpiRVMkpiH4xBT8II28sfBWIU9Cgdcz+lOUKvMKzHy+?=
 =?us-ascii?Q?CHa1TDwqUdpr9HQIscDpkm94ojz4DhbD7xif/Z6zto3boEfQbKJK8PlUZEBz?=
 =?us-ascii?Q?+vQv+vJ7ofMrXHSvPmg10rlmPlgaD2ityr9PdosxJVWoKpfubdPZq/Tl26o3?=
 =?us-ascii?Q?1pEp8ekMOrfuS3CyHdeErTsMMPgiPTnNTzKvBpTEuph7gde1pt3bqgIzw4E/?=
 =?us-ascii?Q?FxTxjCw3i+Rg/z8UbfqSxjgW3lg6s3qONrRtXvSmEGj44GxiEqZQUevKKqsF?=
 =?us-ascii?Q?x4aO3LqLAsAfCq3IzeWnre9eveREZBBLF3SYF0KRNDXYuaD2wp67+GS+09WS?=
 =?us-ascii?Q?7mS5Cvs9TY+yczetzH6xwZcy12BMkgr/fpIXGJnsPZg9xTfm0HDrIkSCYPMP?=
 =?us-ascii?Q?2+ryqCA63NBnV5zp5IOpK0uyZqFMuPgD2ADXQIU9NW4j5izGvqQ1VscIc4ZU?=
 =?us-ascii?Q?nm80Y6q6K8kFKtlLWrrh9h/QM+XJngDbk3jiYqype7wWIOqOFfaLsvVVN+8J?=
 =?us-ascii?Q?WCR8i/R0H0/nwZ1Khhn5x8JWJqTYqTrH9J2rwgvmICh5qrZKTfBpJIG5Um7v?=
 =?us-ascii?Q?4oOfPhX+AyJdxJ3FgDsYg6e0udT7ESh2mZV72Oh7cNbir59H8fcMjkWF3Uca?=
 =?us-ascii?Q?CVMu++c575pqsRNMCZsyO+iDzC1bgwgpEqIRpoz5/jCNEO6BTdoZDK0Thzdj?=
 =?us-ascii?Q?rnKi52t9AIefl2HF3Zl663+Ir8qko4ujl2hRQ1EFAa38tlq0JTiLWN1b+tMa?=
 =?us-ascii?Q?KzJMl7Vm7dJ8RZUaUJuC6bOwAEJntGFiA1a/EOtkYaiujKwzGm4soajP358h?=
 =?us-ascii?Q?j990Ndvmh75qCmr1jb5p8Zo2lKlbXSF7IkQJ+bfVVm8iPVTSACUBf+iM2+iT?=
 =?us-ascii?Q?CU4mKrfCmdcO9LwYDEbiL62hS959QLEG3DDbkpfLPhV6th1Rcmb1VJ1sk+Yy?=
 =?us-ascii?Q?uzo4MSn5K+w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:22.5120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b883f344-36e1-4350-a5f1-08dd2f303384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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

Outside of a modeset/link configuration change, we should not have to
wait for the panel to exit PSR. Depending on the panel and it's state,
it may take multiple frames for it to exit PSR. Therefore, waiting in
all scenarios may cause perceived stuttering, especially in combination
with faster vblank shutdown.

[How]

PSR1 disable is hooked up to the vblank enable event, and vice versa. In
case of vblank enable, do not wait for panel to exit PSR, but still wait
in all other cases.

We also avoid a call to unnecessarily change power_opts on disable -
this ends up sending another command to dmcub fw.

When testing against IGT, some crc tests like kms_plane_alpha_blend and
amd_hotplug were failing due to CRC timeouts. This was found to be
caused by the early return before HW has fully exited PSR1. Fix this by
first making sure we grab a vblank reference, then waiting for panel to
exit PSR1, before programming hw for CRC generation.

Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3743

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 25 ++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 35 +++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  3 +-
 6 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 49baef9dda7f..6bc3a1d5e85d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9104,7 +9104,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
 				timestamp_ns;
 				if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-					amdgpu_dm_psr_disable(acrtc_state->stream);
+					amdgpu_dm_psr_disable(acrtc_state->stream, true);
 				mutex_unlock(&dm->dc_lock);
 			}
 		}
@@ -9274,7 +9274,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
 				amdgpu_dm_replay_disable(acrtc_state->stream);
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-				amdgpu_dm_psr_disable(acrtc_state->stream);
+				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
 		mutex_unlock(&dm->dc_lock);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 2412b9d7c86f..033bd817d871 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -30,6 +30,7 @@
 #include "amdgpu_dm.h"
 #include "dc.h"
 #include "amdgpu_securedisplay.h"
+#include "amdgpu_dm_psr.h"
 
 static const char *const pipe_crc_sources[] = {
 	"none",
@@ -507,6 +508,10 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	mutex_lock(&adev->dm.dc_lock);
 
+	/* For PSR1, check that the panel has exited PSR */
+	if (stream_state->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+		amdgpu_dm_psr_wait_disable(stream_state);
+
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
@@ -644,6 +649,17 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	}
 
+	/*
+	 * Reading the CRC requires the vblank interrupt handler to be
+	 * enabled. Keep a reference until CRC capture stops.
+	 */
+	enabled = amdgpu_dm_is_valid_crc_source(cur_crc_src);
+	if (!enabled && enable) {
+		ret = drm_crtc_vblank_get(crtc);
+		if (ret)
+			goto cleanup;
+	}
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* Reset secure_display when we change crc source from debugfs */
 	amdgpu_dm_set_crc_window_default(crtc, crtc_state->stream);
@@ -654,16 +670,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		goto cleanup;
 	}
 
-	/*
-	 * Reading the CRC requires the vblank interrupt handler to be
-	 * enabled. Keep a reference until CRC capture stops.
-	 */
-	enabled = amdgpu_dm_is_valid_crc_source(cur_crc_src);
 	if (!enabled && enable) {
-		ret = drm_crtc_vblank_get(crtc);
-		if (ret)
-			goto cleanup;
-
 		if (dm_is_crc_source_dprx(source)) {
 			if (drm_dp_start_crc(aux, crtc)) {
 				DRM_DEBUG_DRIVER("dp start crc failed\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8bc73922e3a6..36a830a7440f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -142,7 +142,7 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
-			amdgpu_dm_psr_disable(vblank_work->stream);
+			amdgpu_dm_psr_disable(vblank_work->stream, false);
 	} else if (link->psr_settings.psr_feature_enabled &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0d84308c5996..6d372835d416 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3629,7 +3629,7 @@ static int crc_win_update_set(void *data, u64 val)
 		/* PSR may write to OTG CRC window control register,
 		 * so close it before starting secure_display.
 		 */
-		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream);
+		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream, true);
 
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f40240aafe98..45858bf1523d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -201,14 +201,13 @@ void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
  *
  * Return: true if success
  */
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait)
 {
-	unsigned int power_opt = 0;
 	bool psr_enable = false;
 
 	DRM_DEBUG_DRIVER("Disabling psr...\n");
 
-	return dc_link_set_psr_allow_active(stream->link, &psr_enable, true, false, &power_opt);
+	return dc_link_set_psr_allow_active(stream->link, &psr_enable, wait, false, NULL);
 }
 
 /*
@@ -251,3 +250,33 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 
 	return allow_active;
 }
+
+/**
+ * amdgpu_dm_psr_wait_disable() - Wait for eDP panel to exit PSR
+ * @stream: stream state attached to the eDP link
+ *
+ * Waits for a max of 500ms for the eDP panel to exit PSR.
+ *
+ * Return: true if panel exited PSR, false otherwise.
+ */
+bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream)
+{
+	enum dc_psr_state psr_state = PSR_STATE0;
+	struct dc_link *link = stream->link;
+	int retry_count;
+
+	if (link == NULL)
+		return false;
+
+	for (retry_count = 0; retry_count <= 1000; retry_count++) {
+		dc_link_get_psr_state(link, &psr_state);
+		if (psr_state == PSR_STATE0)
+			break;
+		udelay(500);
+	}
+
+	if (retry_count == 1000)
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index cd2d45c2b5ef..e2366321a3c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -34,8 +34,9 @@
 void amdgpu_dm_set_psr_caps(struct dc_link *link);
 void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait);
 bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
 bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
+bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream);
 
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
-- 
2.34.1

