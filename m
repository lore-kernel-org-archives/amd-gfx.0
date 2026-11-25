Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5150606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GGsySLUT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6CB10E1D1;
	Wed, 25 Nov 2026 09:43:10 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5216610E1D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 09:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNW7e38VPAxm9wzH79o1MbMDFkesfWU2hqUfD8EPf4GXuB1IWw9zg1/ohlhw06mt/RhC3Is2fcdUCXSjnjxjyH9PUf+Q2snkHEPwYd01bx1L8lontt2kS43vvI7gBWUcAsF5Mr/d9D+igm1KalApZYLUXqDiC7jKO55VfeCuyEuhWJdlEaPcH2L7OtZ/66nMtJNr0I3wbBGuk/KaM8xCs1yolAMBlwl2N2ChP2VRZcVOjLP9uUVMZ3AUqGV75Z1uRfX4q54s6uXCMIHmNGlOtC+PtcN+pzdmM6AWwOKFBC3hxs6ZKiNWOG+UVOD0o/p+gcwTiWfSfiy9NEEeNty1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92qKR40DqmKRxIiWkwEYc0G5P8IEIJAhLYRcllcEMI0=;
 b=NuHxSefywsJr+r/MHESACIEE+qD2VEAoEcNnJ216gcQF9CQP5p1ORNlAbJLSxg/YRIrIgwJu+PtlaRB5ASkE0LwfbHpl7d0WYRPPRP4Tc2nKmDWLGTd/Q7X0Bj0b0X0C3PXvMK7cpwRjk+CftjR+PpLREggenuuY4sk/0qPZ1YTmZJRA1OrZN2bQXlVvsf0JfVwpM8Wvt4J3rYqo8JOLY2B/83Fq86Y/lieIR68zAP/9PLs7tMBOb/wx32auXBalzhGitTTWEPewfKqUjwolgEXwJI4uQYQdCwhp7Ghfd9dj8iUPWEWdkndaJQDpD9a21BwjgT+t6nOl9edrvJpx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92qKR40DqmKRxIiWkwEYc0G5P8IEIJAhLYRcllcEMI0=;
 b=GGsySLUTZ0Ve47iV5DWCboiXzNcolr3ScFnU4GeS1knJCn+YA72WKuKrAWMObFMH+XD7SoJv+dMI7bCoCqskA5qOujNq4KhbQkBYDs0hu4E45RMOVINU6FokyvoNBa3zMoa5svr9M2RXQUIiJ5PkGXWI/xT76ioun53axO8d35w=
Received: from CH0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:610:b2::13)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Wed, 25 Nov 2026 09:42:56 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::37) by CH0PR13CA0038.outlook.office365.com
 (2603:10b6:610:b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Wed, 25
 Nov 2026 09:42:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 09:42:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 03:42:53 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: turn vblank off in DRM across GPU reset
Date: Wed, 25 Nov 2026 17:42:39 +0800
Message-ID: <20261125094239.815850-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125094239.815850-1-Prike.Liang@amd.com>
References: <20261125094239.815850-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5111bc-641d-4ed1-7ea6-08df4ad87c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261022115727099003|261009223027099003|261009221227099003|261102130727099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: HI9E7iU8+M5CUcXAcQp4QTBAhDUD/cQCjzzJZC2F1VdkfYNsjF68TktTsLo0GipFbRt60I7KY5xIwzHK5kF4/XkSvPfGpSCvei7cHcj/zDEeLoIL4Ljue6JMXoVXbxED6bm+AeAsU5fH65VJRDc3mAayTxO/WxDEhXuJHP6JL8zd2owQRtBvTupy4bbLJyrJqEOQRuTkW7U33+UpSlSzEKRUov4V+Gtk0IjDOH4kV1mTZIilx4pbkhXQFJ7IWcItOFwfyBDnet27/2zpJ5hm69ImEL+sKfT1tUDNCB2JQCm6ZlI9YlR3YJWZyzzXMSHW4R4bj2ulw11zEdeGFvLqDpQfDMpwDK55Y0i3j8D2n9vPBHIYrS4O2kjajf+bKylJYBzAvlXYedAHNeKw1uzJPCWbI5PDGClZKZqed89nXmQpgSIeko9J1yHSkKYW78GNtlkUWDS9fmzXfi5Q8RGEeRiQKVsYu1TFVL3mr2mn0k1l3dozZiejrqoE0rs8SlgzpoBSPpkTMs37DF/txNYlmbyEUsIl4yB/pue1FAGpjmJyvoyonkGL1ozONrHp6XgCTNmev43JmhyqYqheCyr6agpTzzhHSUPreK5sJrZqKB00lKpPjsChEJlruce8wci3xrWljrvsDvzj+nNXzAfjt8MAjYZLtK5cVBLyAzP6uShh/g1N5wqTl08hUlftY18jRyLMwMaIJFNQgnZircn1Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261009221227099003)(261102130727099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u/WOO7BSAwYNBN4r1pibinAQs2KEubMVTKZHoalCdj4J7+z0VhLvmWiAlwYy09JzScYaWTA8LpPHyFAdf54dW8+j5FhlrjTy1YrZFqFemSIHaYK7v4WGh6DOfvdo/drgrL1loawQD+Oc0c3zV/ucA8jgXV9+Dc11Ik2V9R8O89+63jwD4docq1j43JicPd7XeK82qIOneqBM19hrvtnb+b6xIz63pjtaMhwE5XXJ3eYAp/+UkXST6b30l2h3aqAsevYKLnrNPl/romUOb+7FkYmGC63f6KGeeovM2gRbcjtoa0VNaEJliCFTEs++DaVYae2Zo/nqOCG3OkdGFJstv0iVE/J02jTx5x2V8LlpNrZEUGWcK/mW95bf6tthNufv3yioQlYqfOYZyx4KRs6N7XggbfDOoDAOOViZKnVv93kntpZ/4fkLSJOFWWW0hgJs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:42:56.3671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5111bc-641d-4ed1-7ea6-08df4ad87c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For a GPU reset, dm_suspend() stops all streams with
amdgpu_dm_commit_zero_streams() and toggles the OTG interrupts
directly, and dm_resume() restores the cached DC state the same way.
Neither goes through manage_dm_interrupts(), so DRM is never told that
vblank stops: drm_crtc_vblank_get() keeps succeeding while no vblank
interrupt can arrive until the streams are back.

Since commit ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM
clients during GPU recovery"), the fbdev client keeps running during
recovery, and its damage worker rate-limits display updates with
drm_client_modeset_wait_for_vblank(). Every display update during the
reset then waits for a vblank that never comes, until the wait times
out and warns:

  amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
  WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x200
  Workqueue: events drm_fb_helper_damage_work
  Call Trace:
   drm_client_modeset_wait_for_vblank+0x63/0x80
   drm_fb_helper_damage_work+0x89/0x1a0

FBIO_WAITFORVSYNC runs into the same timeout, and DRM_IOCTL_WAIT_VBLANK
sleeps until its own 3 second timeout.

Do what a regular CRTC disable does: call drm_crtc_vblank_off() for the
CRTCs of the cached DC state before their streams are stopped, and
drm_crtc_vblank_on_config() with their existing configuration once the
streams and interrupts are restored. drm_crtc_vblank_get() then fails
for the duration of the reset, so drm_client_modeset_wait_for_vblank()
doesn't wait at all, and DRM_IOCTL_WAIT_VBLANK waiters are woken up.
Page flips that get to amdgpu_dm_commit_planes() meanwhile have their
event sent right away, see the previous patch.

drm_crtc_vblank_off() also clears the vblank timestamping constants,
which a modeset sets again before it turns vblank back on. Save the
timestamping mode before vblank is turned off and set the constants
from it again after the reset; otherwise the vblank timestamp query in
drm_crtc_vblank_on_config() warns about an uninitialized mode. The CRTC
state can't be used for this: commits swap it without dc_lock, and a
commit that never takes dc_lock can free the old state during the
reset.

Commits call manage_dm_interrupts() without dc_lock so far, so they
could turn vblank off or on between dm_suspend() and dm_resume(). Call
it under dc_lock, which the reset holds for that whole time. A commit
that already has vblank off when the reset starts turns it on again
itself, if at all, so leave such a CRTC alone and only turn vblank back
on for the CRTCs that the reset turned it off for.

A modeset that waits for dc_lock during the reset may also be turning
one of these CRTCs off. Leave vblank off for a CRTC that is no longer
enabled; amdgpu_dm_crtc_set_vblank() would refuse to enable vblank on
it anyway.

dm_resume() doesn't run if amdgpu_dm_commit_zero_streams() fails in
dm_suspend(), so turn the interrupts and vblank back on there.

Neither call can block on the reset: drm_crtc_vblank_off() only takes
spinlocks and flushes the DRM vblank worker, which DM doesn't use, and
amdgpu_dm_crtc_set_vblank() queues vblank_control_work without waiting
for it. Unlike suspending the DRM clients, this doesn't make recovery
wait for anything that may itself depend on the reset.

Add KUnit tests for the new helper.

Fixes: ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients during GPU recovery")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  91 +++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 138 ++++++++++++++++++
 3 files changed, 232 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9cee9104112c..d0d712352a2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1599,6 +1599,84 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(dm_gpureset_toggle_interrupts);
 
+/**
+ * dm_gpureset_toggle_vblank() - Turn DRM vblank off or on around a GPU reset
+ * @adev: amdgpu device
+ * @state: DC state whose streams the reset stops and restores
+ * @enable: false before the streams are stopped, true once they are restored
+ *
+ * The GPU reset path stops and restores the streams through DC directly and
+ * bypasses manage_dm_interrupts(). Turn vblank off in DRM like a CRTC
+ * disable does, so that drm_crtc_vblank_get() fails while no vblank
+ * interrupt can arrive, instead of letting vblank waiters such as the fbdev
+ * damage worker sleep until they time out.
+ *
+ * The caller holds dc_lock from the off call to the on call, and commits call
+ * manage_dm_interrupts() under dc_lock, so only this function changes vblank
+ * in between. It only touches CRTCs whose vblank is on: where a commit has
+ * turned vblank off, that commit also turns it on again, if at all.
+ */
+STATIC_IFN_KUNIT void dm_gpureset_toggle_vblank(struct amdgpu_device *adev,
+						struct dc_state *state, bool enable)
+{
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct drm_vblank_crtc_config config;
+	struct drm_vblank_crtc *vblank;
+	struct drm_display_mode *mode;
+	struct amdgpu_crtc *acrtc;
+	struct drm_crtc *crtc;
+	int i;
+
+	if (!enable) {
+		dm->reset_vblank_crtcs = 0;
+
+		for (i = 0; i < state->stream_count; i++) {
+			int otg_inst = state->stream_status[i].primary_otg_inst;
+
+			acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, otg_inst);
+			if (!acrtc)
+				continue;
+
+			crtc = &acrtc->base;
+			vblank = drm_crtc_vblank_crtc(crtc);
+			if (vblank->inmodeset)
+				continue;
+
+			/* drm_crtc_vblank_off() clears the timestamping constants. */
+			mode = &dm->reset_vblank_modes[drm_crtc_index(crtc)];
+			drm_mode_copy(mode, &vblank->hwmode);
+			dm->reset_vblank_crtcs |= drm_crtc_mask(crtc);
+
+			drm_crtc_vblank_off(crtc);
+		}
+
+		return;
+	}
+
+	drm_for_each_crtc(crtc, adev_to_drm(adev)) {
+		if (!(dm->reset_vblank_crtcs & drm_crtc_mask(crtc)))
+			continue;
+
+		/*
+		 * A modeset waiting for dc_lock may be turning the CRTC off,
+		 * and amdgpu_dm_crtc_set_vblank() refuses to enable vblank on
+		 * it then. Leave its vblank off.
+		 */
+		if (!crtc->enabled)
+			continue;
+
+		mode = &dm->reset_vblank_modes[drm_crtc_index(crtc)];
+		drm_calc_timestamping_constants(crtc, mode);
+
+		/* Keep the off delay that manage_dm_interrupts() configured. */
+		config = drm_crtc_vblank_crtc(crtc)->config;
+		drm_crtc_vblank_on_config(crtc, &config);
+	}
+
+	dm->reset_vblank_crtcs = 0;
+}
+EXPORT_IF_KUNIT(dm_gpureset_toggle_vblank);
+
 DEFINE_FREE(state_release, struct dc_state *, dc_state_release(_T))
 
 STATIC_IFN_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
@@ -1733,11 +1811,15 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 			return -ENOMEM;
 		}
 
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, false);
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
 		if (res != DC_OK) {
 			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
+			/* dm_resume() doesn't run after an error, undo the above */
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
+			dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, true);
 			dc_state_release(dm->cached_dc_state);
 			dm->cached_dc_state = NULL;
 			mutex_unlock(&dm->dc_lock);
@@ -2072,6 +2154,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, true);
 
 		dc_state_release(dm->cached_dc_state);
 		dm->cached_dc_state = NULL;
@@ -4871,7 +4954,9 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 		if (old_crtc_state->active &&
 		    (!new_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
-			manage_dm_interrupts(adev, acrtc, NULL);
+			/* Under dc_lock, see dm_gpureset_toggle_vblank() */
+			scoped_guard(mutex, &dm->dc_lock)
+				manage_dm_interrupts(adev, acrtc, NULL);
 			/*
 			 * ISM hysteresis lives on system_dfl_wq, not the
 			 * vblank workqueue. Wait it out so a timer armed while
@@ -5567,7 +5652,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
 			dc_stream_retain(dm_new_crtc_state->stream);
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
-			manage_dm_interrupts(adev, acrtc, dm_new_crtc_state);
+			/* Under dc_lock, see dm_gpureset_toggle_vblank() */
+			scoped_guard(mutex, &dm->dc_lock)
+				manage_dm_interrupts(adev, acrtc, dm_new_crtc_state);
 		}
 		/* Handle vrr on->off / off->on transitions */
 		amdgpu_dm_handle_vrr_transition(dm, dm_old_crtc_state, dm_new_crtc_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 971ac1804c03..afc1e9781f55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -362,6 +362,8 @@ struct dm_otg_sw_counter {
  * @soc_bounding_box: SOC bounding box values provided by gpu_info FW
  * @cached_state: Caches device atomic state for suspend/resume
  * @cached_dc_state: Cached state of content streams
+ * @reset_vblank_crtcs: Mask of the CRTCs whose vblank a GPU reset turned off
+ * @reset_vblank_modes: Vblank timestamping modes of those CRTCs, by CRTC index
  * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
  * @force_timing_sync: set via debugfs. When set, indicates that all connected
  *		       displays will be forced to synchronize.
@@ -663,6 +665,8 @@ struct amdgpu_display_manager {
 
 	struct drm_atomic_commit *cached_state;
 	struct dc_state *cached_dc_state;
+	u32 reset_vblank_crtcs;
+	struct drm_display_mode reset_vblank_modes[AMDGPU_MAX_CRTCS];
 
 	struct dm_compressor_info compressor;
 
@@ -1406,6 +1410,7 @@ void amdgpu_dm_fill_power_nits_range(const struct amdgpu_dm_backlight_caps *caps
 				     struct mod_power_init_params *init_data);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
+void dm_gpureset_toggle_vblank(struct amdgpu_device *adev, struct dc_state *state, bool enable);
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
 int dm_cache_state(struct amdgpu_device *adev);
 void dm_destroy_cached_state(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 317e1f13655c..0bedeb52e0b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -5489,6 +5489,138 @@ static void dm_test_gpureset_toggle_interrupts_dcn(struct kunit *test)
 	dm_gpureset_toggle_interrupts(adev, state, true);
 }
 
+/* Tests for dm_gpureset_toggle_vblank() */
+
+/*
+ * One stream on the OTG of the CRTC from dm_test_irq_mgmt_ctx_alloc(), which
+ * is enabled with a 1080p60 mode and has its vblank set up like on a regular
+ * CRTC enable: timestamping constants first, then manage_dm_interrupts().
+ */
+static struct dc_state *dm_test_gpureset_vblank_state(struct kunit *test,
+						      struct dm_test_irq_mgmt_ctx *ctx)
+{
+	struct drm_display_mode *mode = &ctx->acrtc_state->base.adjusted_mode;
+	struct dc_state *state = dm_kunit_alloc_dc_state(test);
+
+	mode->crtc_clock = 148500;
+	mode->crtc_htotal = 2200;
+	mode->crtc_vtotal = 1125;
+	ctx->acrtc->base.state = &ctx->acrtc_state->base;
+	ctx->acrtc->base.enabled = true;
+	drm_calc_timestamping_constants(&ctx->acrtc->base, mode);
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	state->stream_count = 1;
+	state->stream_status[0].primary_otg_inst = ctx->acrtc->otg_inst;
+
+	return state;
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_off - Test vblank is off while streams are down
+ * @test: The KUnit test context
+ *
+ * drm_crtc_vblank_get() has to fail, or vblank waiters such as the fbdev
+ * damage worker sleep until they time out.
+ */
+static void dm_test_gpureset_toggle_vblank_off(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->adev->ddev.vblank[0].enabled);
+	KUNIT_EXPECT_EQ(test, drm_crtc_vblank_get(crtc), -EINVAL);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_on - Test vblank comes back with its config and mode
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_toggle_vblank_on(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+	/* The CRTC state isn't read, a commit may swap it during the reset. */
+	ctx->acrtc_state->base.adjusted_mode.crtc_clock = 74250;
+	dm_gpureset_toggle_vblank(ctx->adev, state, true);
+
+	/* manage_dm_interrupts() derived this off delay from the timing. */
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].config.offdelay_ms, 34);
+	/* Vblank timestamps need the mode that drm_crtc_vblank_off() cleared. */
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].hwmode.crtc_clock, 148500);
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_no_crtc - Test streams without a CRTC are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_toggle_vblank_no_crtc(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	state->stream_status[0].primary_otg_inst = ctx->acrtc->otg_inst + 1;
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_crtc_disabled - Test a disabled CRTC stays off
+ * @test: The KUnit test context
+ *
+ * A modeset that waits for the reset to finish may be turning the CRTC off.
+ */
+static void dm_test_gpureset_toggle_vblank_crtc_disabled(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+	ctx->acrtc->base.enabled = false;
+	dm_gpureset_toggle_vblank(ctx->adev, state, true);
+
+	KUNIT_EXPECT_EQ(test, drm_crtc_vblank_get(&ctx->acrtc->base), -EINVAL);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_commit_off - Test vblank that a commit has off is left alone
+ * @test: The KUnit test context
+ *
+ * A commit that waits for the reset to finish has turned vblank off, and has
+ * set the timestamping constants for the mode it is about to program.
+ */
+static void dm_test_gpureset_toggle_vblank_commit_off(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, NULL);
+	drm_calc_timestamping_constants(crtc, &ctx->acrtc_state->base.adjusted_mode);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].hwmode.crtc_clock, 148500);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, true);
+	KUNIT_EXPECT_EQ(test, drm_crtc_vblank_get(crtc), -EINVAL);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -5747,6 +5879,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_initialize_plane_overlay),
 	/* dm_gpureset_toggle_interrupts */
 	KUNIT_CASE(dm_test_gpureset_toggle_interrupts_dcn),
+	/* dm_gpureset_toggle_vblank */
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_off),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_on),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_no_crtc),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_crtc_disabled),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_commit_off),
 	{}
 };
 
-- 
2.34.1

