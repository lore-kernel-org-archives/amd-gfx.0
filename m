Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E70CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C13710ECE2;
	Wed,  6 May 2026 07:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K4VgLx6/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCDE10ECE2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDQBJpy7T6rvHBei7qbxUqf4mQHwQv0hpAAJzi686NYYwNCaM+jIn+/E77CGzjie63v5zsqwAfflA4Dt9dla3kmXQjt7qFtRvCwSl+1YPQ37+lnPxTJX3z+SyB08B4ZXwRmbvVKRsej+LHcx2So8bbLnS3ZS2uiX/w5DLAu1ljp/zefNLNybM3cCAsqXwHx+dKfZSDQJsmMDnBjHrWTZSi9/1CEf6ZUAGEIyRioM/YjdBsN2golWtrppO0N0pXzkANjs47fbcsrXltk7lgX/sid6SbaW17+kmupaPuVZg5OaIBhSfNbVyXRCCyzqaRaVvm3am5L4dy2s7ksDb37UWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDTdbETtNQeAL7g5J+PWxLB01ZL/eVz1QiFMWnmC9ms=;
 b=KG7uyBbvrHyXgk4PBrkelbOXRU5UVe4sDy6T7/CQ8KRQofLRpnhyxw75Rln9XLEwGYD0hl6cI2aAlbSX/SMYeM7O5tJY/XA1DtVOcUYzuRaev9NK02SY68rcljH40783Mwd88iom1GVd2ML3Ho4R20FaFhwK+WF0Ssj9z8RbsnQnA14apSxMVfzQ+HpaWVaUZNjAMbW/DdDfvwcxqkGTpQ9wmBFntmxWj2G6rsjUzfvTED0yLo6HAOWbDmFIhKsSDlOMXDHEspgO2g1k9umTZjXkOYqW9gbYTDEaXhU9APonm79vWNW6h8aU+jD1ZyFBlfdP7MSyMvXIzvWNKrRmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDTdbETtNQeAL7g5J+PWxLB01ZL/eVz1QiFMWnmC9ms=;
 b=K4VgLx6/QDjDsfeCKW+CiWIQxb3D7ZO0b8HEvajCbjmnGFs1V/FagulvnFKaoDKiChecqqgPj96zkEGQnKAZOZNWcE5rNtsf1CQY+hzM5AiyHoKZ70+U39RWhK1ObvDXnfJ1m/z2nrb9E4L6CLJIlVclimkpLdiKa+QVzO0KJdU=
Received: from MN2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:23a::14)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:05:15 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::80) by MN2PR03CA0009.outlook.office365.com
 (2603:10b6:208:23a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:05:03 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:04:55 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 12/20] drm/amd/display: Add additional IPS entry/exit for
 PSR/Replay
Date: Wed, 6 May 2026 12:31:10 +0800
Message-ID: <20260506043342.2164710-13-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 20271bc0-38e7-4ef1-817d-08deab3dd2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xAdQSqrrZs+yM7ZCeOoPUQ4iHT8CvDyU+etrjO9YREWueMXzfnEVtA4iqPtP8jNt7i7XmvkzzXiyVWABDm5rQvMDGR4XnVf8gtgWw4851+nCXMT3twcXTH2BPUajqbr8gYu8UxvlVNxW2khd0/2J/CwWHZS5nKDEP+EHjIUhsWb1IlQpf3DwnmLtZ4zVepJg3qf35BNHVp7LK3RXpJdiIxgk5dyoJYG+60FViOFGAKA8IQ2IM3I05WGkBzHP5pCgibJ7ceEBjNSL/7tqTqvQN7OUfRV6LeLebZfgSU6DMK/XFOETpPlQsJtp0pXogHr2MP401p6UILPy/6P2YjfVUJoS+vS4iMtmvMJ4MS0+YEamQMoa0URMX3cE1PtMz3gUeswim+8QGISPlg0EvRfA1YpMxxKClpxv146JfJvFAPseY4ue5vgGm86Y0qN7SBNnFm/yX37h4iwT8FVV9gW0I4ur+WuNrndiHPaHoHuG5Vn3jMMXzOjs2HWEJQLE0lqRAwk5sBplRykYw78n5f0xJMiBI8ZTrvYArEH9HvGP9mxfndxNeHpbtZV1CpMu4IFMdXg/JQF6Qrqe0xMdN4me9ZXtHQxlb4mpv3XNXlqxw69c1uGUNwzXL5VQPcp03MxT6oRJLZcHqnPjLYma/UyfT9Ev4+HKkpFFHUb8k0kssCD3gMrl3iZqTgiMIXQPdCfiTwbsmRTlSH7DQ3f75TlXw+my04zRibxbPTqTjrcFGZs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 43WvwoUU0YN7h4arq6ma1KM++sO4lRi5mVjgkxspPsj8t6DrXQTTxI2/Vodp82viguVP9+r5GzuIZerNV3woEhxi3BG0+QD2WMuFCR4t0D//GdFsfdleu7j13pED0Ze+xBdG9lQhoztFUzt6Qt2oVYyROFSU/nvWbYRnz7nYqToGvSF0dKEmxtdCSD7GGazCXtIUAaYYktkNmf+ZCRfRHRtgMQG2AWDv1CPF83RopO4SrIHFRiHyiXnxAvuukLthYqaCwYT89+kBcZqjyKQy30R+a/18buXwCNFcpwriYj2X3rzF26SGgzMHTmZW0vvGyQcOAib8G96QL7mOQaF+8N98Z+mxo4JrvJuGIIUnZ6nUZiPXLNUa1hJ+5Ee+1SHfYp8FjSvAYrgtbptPuimSLYChd1+ynIXIw6bDQnVYOvrXlf4hacCFzWd8c91fUpop
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:15.3841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20271bc0-38e7-4ef1-817d-08deab3dd2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
Multiple paths issue DMUB commands without managing IPS state, causing
dc_wake_and_execute_gpint/dmub_cmd to internally wake from IPS and
reallow idle. This flips idle_allowed back to true while
idle_optimizations_allowed remains false during in-flight commits,
desynchronizing the two flags.

Affected paths:

- amdgpu_dm_psr_set_event() and amdgpu_dm_replay_set_event() calls from
  amdgpu_dm_handle_vrr_transition(), amdgpu_dm_commit_planes() and
  amdgpu_dm_mod_power_update_streams(), that are invoked on atomic commits.
- debugfs psr_get(), psr_read_residency(), replay_get_state(),
  replay_set_residency() access hardware without holding dc_lock or
  disabling IPS.

[How]
- Explicitly exit IPS before PSR/Replay set_event w/ hw_programming,
  called within atomic commit.
- Wrap debugfs PSR/Replay state getters and setters with IPS exit/entry +
  dc_lock.

Reviewed-by: Sunpeng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 77 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7ff1af3528dd..4e9b4fd505c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9937,6 +9937,7 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 				 __func__, new_state->base.crtc->base.id);
 
 		scoped_guard(mutex, &dm->dc_lock) {
+			dc_exit_ips_for_hw_access(dm->dc);
 			amdgpu_dm_psr_set_event(dm, new_state->stream, true,
 				psr_event_vrr_transition, true);
 			amdgpu_dm_replay_set_event(dm, new_state->stream, true,
@@ -9952,6 +9953,7 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 				 __func__, new_state->base.crtc->base.id);
 
 		scoped_guard(mutex, &dm->dc_lock) {
+			dc_exit_ips_for_hw_access(dm->dc);
 			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
 				psr_event_vrr_transition, false);
 			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
@@ -10253,6 +10255,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				mutex_lock(&dm->dc_lock);
 				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
 				timestamp_ns;
+				dc_exit_ips_for_hw_access(dm->dc);
 				amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
 					psr_event_hw_programming, true);
 				mutex_unlock(&dm->dc_lock);
@@ -10610,6 +10613,7 @@ static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_state *state,
 		 */
 		if (old_crtc_state->active) {
 			scoped_guard(mutex, &dm->dc_lock) {
+				dc_exit_ips_for_hw_access(dm->dc);
 				amdgpu_dm_psr_set_event(dm, dm_old_crtc_state->stream, true,
 					psr_event_hw_programming, true);
 				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, true,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 49226d6d0311..4e68a3541639 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3163,10 +3163,25 @@ static int replay_get_state(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dc *dc = adev->dm.dc;
 	uint64_t state = REPLAY_STATE_INVALID;
+	bool reallow_idle = false;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
 
 	dc_link_get_replay_state(link, &state);
 
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
 	*val = state;
 
 	return 0;
@@ -3179,10 +3194,26 @@ static int replay_set_residency(void *data, u64 val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dc *dc = adev->dm.dc;
 	bool is_start = (val != 0);
 	u32 residency = 0;
+	bool reallow_idle = false;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
 
 	link->dc->link_srv->edp_replay_residency(link, &residency, is_start, PR_RESIDENCY_MODE_PHY);
+
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
 	return 0;
 }
 
@@ -3193,9 +3224,25 @@ static int replay_get_residency(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dc *dc = adev->dm.dc;
 	u32 residency = 0;
+	bool reallow_idle = false;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
 
 	link->dc->link_srv->edp_replay_residency(link, &residency, false, PR_RESIDENCY_MODE_PHY);
+
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
 	*val = (u64)residency;
 
 	return 0;
@@ -3208,10 +3255,25 @@ static int psr_get(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dc *dc = adev->dm.dc;
 	enum dc_psr_state state = PSR_STATE0;
+	bool reallow_idle = false;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
 
 	dc_link_get_psr_state(link, &state);
 
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
 	*val = state;
 
 	return 0;
@@ -3224,10 +3286,25 @@ static int psr_read_residency(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dc *dc = adev->dm.dc;
 	u32 residency = 0;
+	bool reallow_idle = false;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
 
 	link->dc->link_srv->edp_get_psr_residency(link, &residency, PSR_RESIDENCY_MODE_PHY);
 
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
 	*val = (u64)residency;
 
 	return 0;
-- 
2.43.0

