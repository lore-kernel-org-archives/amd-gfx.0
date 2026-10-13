Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B985CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9FE10F767;
	Tue, 13 Oct 2026 11:18:00 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5D710F766
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXoSaymGEggJ3/CggFhs7TsO9emT2MgLwZctTs0SyPHTvlmg0/xPuGnF6kavcJRMifOxSu4CzXpptO9Ly8wr6KleLKkm3Tnl8sVybsDDPFktV/koBr/1eIMyo5v0av8obyAjoD5IQX2Mnz2ciyh2AHIEV0dptYtepQVlsHNC6+62tGq2z1Ek+OY+53iopYG611F6S26gLGgFFtjv3EGh7/xAPAcCxqUylU/RdCme94U9EeIIuu6SYihrARWeln2BkZGnPfU91XxO5Tsxe5m50kmZQfX2RxKy2VCfv/0zebFCQM3SCMk9GJwCF2GY2BO5SiAj36fmt0B++AO2I59OAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNBpHBk8WArxOQ2O0APfrcV45KNtrMu27Fs4fWRzEXE=;
 b=Pf2o/M0JT27LWixuAk+E23P5BcJJj0Px7vhyPTMqLPL5ophB9xWDoBr31TYm8JiAoLElZuGgkGc5NOw7y4t5h7onQlq1kfh6I7GHA4juAbwTzmT+EnIqju2k9mXxzQJha8Wx81VuhULixZmRCmexbO8fdd4PglDNleQGgTtAsGfco9Zrkms7rVCbKxpjVIiLRu9yivOv4Ud79psz9SUfJQMf3d+o/y8yYmHUx/Br+0175iDw3DBsnx2jHVyQ3rcCwehj7kiHBdyceVnSmRxQcLCzbZw9+K+6B54utn5zt6ylv+FB4iJLYn9a/n24qXtYTa2zQALLUpp9xmHnRp5DWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNBpHBk8WArxOQ2O0APfrcV45KNtrMu27Fs4fWRzEXE=;
 b=XH4xuO8i+2/xKzaRurXq5FsQa5kgoMGea8hhGROD12bq99kWnlDaVhbqfV+7WtcmKzoHX0h3XJRdY0TvYiq6AC9vgfvs4vWzQYRq1LRbytwerWPwGESUWVLR2FYbZcvtbEI61cCw9KUCPUCzbEsQdC1A/Bm/4TMl0SZ19J0/pPg=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by DS6PR12MB646826.namprd12.prod.outlook.com (2603:10b6:8:4b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:17:51 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::17) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:17:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:29 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:21 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/30] drm/amd/display: Exit PSR/Replay on non-modeset full
 updates
Date: Tue, 13 Oct 2026 19:07:58 +0800
Message-ID: <20261013111616.2267344-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS6PR12MB646826:EE_
X-MS-Office365-Filtering-Correlation-Id: f45b7fc5-53a2-430c-c409-08df291b9e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6ZGDIEBaEl4wI/z14b9pR33MWCcd0Hoe2FsLrvERLvWYQPjdeqweVdCz08PPaDhyWnGZ9U5r4j/b7FZyU22o9fiJnVOhJkgiqwfjbiQUp7Oi83HtSoDZ7O70O12wH6FmZkAGu0CSFpbKaVzxhL87rJyUnUlq27pPEExwDLNw9aI/OOJFQ76Dks32LHKB9CtuLeOJMfXBxGxLL70jpu0qyGE2t9+GqnIAXsvrorncGyB5IhljmiDQ9OJQaTfQnbMWuOsW7xSbFHOMkgDorOyScgEzkKF0RjX1XyUThgBUP7hskJs1KisNMwRsw/NCdK2i5FlxkAVI+mGSFsjYP2FF/zBdBsqmzPZVO1yfWhFr6GhAQagVhD779Pii1ZxqPrbj7yVl0O2fQ4akJGRJ2JU4X7fMUX2PWSPivEstx/jtpL64LvP2F/yGq++DO6gOKMbLYIkNgvlUmehDhgpj0T7Ujbz882XyniN7+vm15HJTCq/nFd2N+TcOloeDJ9/WINb4/55TGaqU8+mFloBwdBFgMpQJwmuCFk15osmGiV6yHgYFQ2jvbPcuAcWIk/G2uAQxET7zv48ujdh/utT5XAcUInmkBRHA+gl2IIhA4kW0uXBXCmixJFII848tsgESP9x2bG1rt/gUIr/uoN2pLnHE+UY2mytQf0U303SmUXe2YhqJHr38WQVFBKDBgCMTBAHyhoh3iOQKN3g+zIoQBGYSBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dYtnx1/8iawTGMuubXFA+efeBDJCC+ULJk8tEzn+m5ErgXOI8Mp9oB+qNu30hUhI3JzWfFV/8G/blPdRO/5M2cGCBYc3XlOvvq77vXNRvSyDY0Ifc5FVvi0wYrRyCaBfDN4fsbb9eLNJ7ASnUyg4IU6VwePdZXTLjJQX2D/zQjeVFupPezIpce6aR8AXG2GPF0HimQ5bcvZWWYnnlfPH+CVPMeB7RN4t+g/oqvm0cESqwz/6YRqUuqYOO3+kcJ85I0HJ+89ShBmZT0AMbUZfhAPJJNDST4JWOHG/MNOF7NHf1GT8tGVfvY+MlPfv2B6xPMC55RVOFeXxxvXiJYJFU/Mpv3gk0ysdEIe/piOvb1zXKJAFJTyIy5iwKJGR7bFlv0iFET5tXq8ZL8JUR3e1XG6Irr/3YFLGCY06yBdtnx9ZYBTq+aV/1WgdC3ZYdHCV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:50.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b7fc5-53a2-430c-c409-08df291b9e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB646826
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

[Why]
The greeter issues non-modeset full updates on the existing stream, but
amdgpu_dm_mod_power_update_streams() returns early for those, so
Replay is not exited. Xorg then renders directly to the front buffer
and no further commit reaches the driver.

[How]
Set psr_event_hw_programming and replay_event_hw_programming for every
active CRTC before the modeset check, so PSR/Replay is exited whenever
the DC state is reprogrammed, not only on modeset. Keep the mod_power
add, replace and remove stream calls for modesets that change the
stream.

Assisted-by: Cursor:Claude-Opus-5.5
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e3b0abcfff3..bdabb4bf14da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4451,12 +4451,12 @@ STATIC_IFN_KUNIT void dm_clear_writeback(struct amdgpu_display_manager *dm,
 EXPORT_IF_KUNIT(dm_clear_writeback);
 
 /**
- * amdgpu_dm_mod_power_update_streams - update mod_power stream state on modeset
+ * amdgpu_dm_mod_power_update_streams - update mod_power stream state
  * @state: the drm atomic state
  * @dm: the display manager to update mod_power on
  *
- * Notify mod_power of stream changes on modeset events, and disable PSR/Replay
- * in preparation for hardware programming. See also
+ * Disable PSR/Replay before hardware programming for active streams, and
+ * update mod_power stream state when a modeset changes the stream. See also
  * amdgpu_dm_mod_power_setup_streams() for post-modeset mod_power setup.
  */
 STATIC_IFN_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
@@ -4472,15 +4472,15 @@ STATIC_IFN_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commi
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
-		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
-			continue;
-
 		/*
-		 * Update mod_power on modeset event in preparation for hw
-		 * programming. Always use the old stream, since it would have
-		 * been previously added to mod_power. If old stream is null (on
-		 * crtc enable, for example), mod_power will no-op, which is the
-		 * desried behavior.
+		 * Notify mod_power that hardware programming is about to occur.
+		 * This must be done before the modeset check because a non-modeset
+		 * commit can still update an active framebuffer or plane while
+		 * PSR/Replay is enabled.
+		 *
+		 * Always use the old stream since it is the stream currently
+		 * registered with mod_power. If old stream is NULL, the event
+		 * helpers will no-op.
 		 */
 		if (old_crtc_state->active) {
 			scoped_guard(mutex, &dm->dc_lock) {
@@ -4489,11 +4489,15 @@ STATIC_IFN_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commi
 					psr_event_hw_programming, true);
 				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, true,
 					replay_event_hw_programming, true);
-				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, false,
-					replay_event_general_ui, false);
 			}
 		}
 
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+
+		if (dm_old_crtc_state->stream == dm_new_crtc_state->stream)
+			continue;
+
 		if (new_crtc_state->active) {
 			aconnector = (struct amdgpu_dm_connector *)
 				dm_new_crtc_state->stream->dm_stream_context;
-- 
2.43.0

