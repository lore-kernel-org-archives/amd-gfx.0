Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCEFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B63E113949;
	Wed, 24 Apr 2024 08:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WvdQa0vg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C4D113949
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYLXgKJIdzDb+HSYxpUeC3dgfRuVP6aOIJVCbvU3Slsslp073BEnb3DsrZewGXSEs3KNaayu/TD5DZNyRglV/3YJmAZjdjQo/XhfSn3GUY7/gNjCTFP6bZMsvdru/ymD5kicIho5P3YiVTxscVqKyXXSw6RXP7/gxDkwqEbeYwClw90ZtUlhcnfKSa1Bfdf24qmIXIRCfTEEh5twy5X4mn7TEgmBlOzEwbPkWPhkLP4TXByL4cAGcfD1jQhAO3CNRskT6vBVcIEOSUvhmbAioOVous+mQXCFj+6ZAcTAIKFz8tabPnQztnJKmMpEYWtG1e/3INlvplb4cN4HDcUniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpLs2Gnbq14eV9bBhba/mrwk7bHw5rLYcxuTmZAaSWU=;
 b=ZrGTb2BVlkwJh0qPY3uTVerD7McGvqZ/rZG13EH9s+MP08uF50LLRCqUQ4scOSk8IOawJxkOa7Cq/FO8nXrT6OD91xYGaIM6MVg8v9OvV3SJpc/cFqe4v6ntxdbpQBVMnjW85CMVXLPfuWKZxFjHal+gnW5MPsn0bvQ4Pxe40sdlqTV3JfH1nhcvrkgZO5e3+pVNUS0DscP85BCniZIcQ7CzBZF/LyrKIJoGQ+YT4fVGv2e2RVPrmLobTj8kwihweN0PY7aiZ8kOzr/XORncWCK8br8+MGs4uj+ZOxW8l/n1rA/HqHDpQxvx28Ks6/hqdq2x5DnQh9s7eRRCZV0M6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpLs2Gnbq14eV9bBhba/mrwk7bHw5rLYcxuTmZAaSWU=;
 b=WvdQa0vgIXkdJf08SRTEFw2RkWImoLrhd4Vuc6yTf068ViYy/jVnvvwlQEuh4/7Ii75RpZ4+xUpllK2whExVmaeUjgT90d50P2T3P6CqXpmheLX2WC3HqB/eUZzhEaKNSs7mQ/ag+0LgT86ineCU3UegwLFU8LwJ+ogvljUrsRU=
Received: from BN0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:e7::28)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:49:56 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::50) by BN0PR03CA0053.outlook.office365.com
 (2603:10b6:408:e7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:49:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:49:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:49:55 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:49:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 01/46] drm/amd/display: Do cursor programming with rest of pipe
Date: Wed, 24 Apr 2024 16:48:46 +0800
Message-ID: <20240424084931.2656128-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: e07e1cdb-1e80-44eb-4db7-08dc643b8402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FSVxwD3xNu/nUAMVbJJkSN4sq26/zXaGmhdUMmP+RBm1ks0ENjPcGyRExsiH?=
 =?us-ascii?Q?lbPRyrulRpbusVKFmPYsZIlMdAyKRamxbkAWNmeFmvDe3UBA1Y/g5aMzjRbm?=
 =?us-ascii?Q?Roz63t/Fe+rjp7jBSv+2puct7+cvDgyX1WdyvvkIHcN3vKQfz2d0+ThfHFAz?=
 =?us-ascii?Q?vY5b/Gg73NulKUkQXCeGSaQnHR5rKz8NPk5lcKowOtYZiGYzLh4H2uVnivgZ?=
 =?us-ascii?Q?K1te7FD4ZBrNAjr1zrhgEDmn1wnpP68ffrYxvaTIJl78Qq8hbGaKzxq7emXT?=
 =?us-ascii?Q?PQixol5r/CNvTavn2WW+mRF032eERgwcq2OMkKnVbNWLFxu/PdoxHq4FNnCY?=
 =?us-ascii?Q?Ce8e1Uw5ztH3XOfT04ZUCPI4VQY9qBaKTISNWj9VFItz5w3IjwWf4imkM2/3?=
 =?us-ascii?Q?Ks4xgiUfABFyW1tSQrVWHi559xedfbsrCtY71Rjg0/hjXfIDg5xlSlXw/7au?=
 =?us-ascii?Q?xPRv9IiCtIPzucC9j9R1v0VvFNtPSpKUBkDoEOmcxK5ap32rdJRpS94/Yq2P?=
 =?us-ascii?Q?MmjpW445yILL74teRFle7ZgeGOwZhQu/QLyDASMgKebFyXhixfhDOau754Hs?=
 =?us-ascii?Q?Icfb1LzX+QdXzQu6ZPYA3Sa8l2dISDP8NO4Q8N2uazZ2+e6dc3WQgqyzr9zj?=
 =?us-ascii?Q?Bt1iPzLO+XRBu1WPWKC5KOZYSEdYczZm/z7cU9iy40DdiifF3iS4s9u0WhYR?=
 =?us-ascii?Q?0brdU3An65kagekQ6xeF+R3SmuwimXRkhY4vRhx68zElJ+cKrGUY0hgqKTCQ?=
 =?us-ascii?Q?supkMJABrr9LNhYx2zOTV0q6UdUaYQ85MB6BpWp1uBUSISSL2T5SeIMge9Xf?=
 =?us-ascii?Q?dCxb+S1VH0CdW06MtSQaCtplzillBkyU7WhgbaDxEKVysHIfh8Cu58C5KDuU?=
 =?us-ascii?Q?UZxkZ2W0/yUnDr3bXlMfGv8TxRRMdAHnwcqrW2asysCoA75KN3b0HpKEeOog?=
 =?us-ascii?Q?jCQhyNxyM4UOV8/wPr4Exq5eifBYN6mG3pU0awzIcvF1Yulwfxx2F/ifRWGU?=
 =?us-ascii?Q?kM3hQEWWE6Vv1iWSn2DVFZo9a8FK2nAIWuaLevm13Sxr4jAKkJiST/Zg91ch?=
 =?us-ascii?Q?D/z2+kXTy7O8OUc38c4+XpiUauniiGMG4NPBjtPjwMoHU04m/PS4/i8WFvTP?=
 =?us-ascii?Q?GzZkeZt0fLLfKnqOnSt6aoVAiYXgRxhM4DDGKBB6mbZwlLxwBpoQsw9hcpQw?=
 =?us-ascii?Q?sKYC8kNxwXQw+11Cni4gDFy3LbemL/O2U6doTmuyK/7K5iPLFc3riqCbWEnD?=
 =?us-ascii?Q?THMKvtq6QcCmqcGxZF2Ws1cPhrBGJguQKe1Nze7fb4wFtRhFoe9bwxltEKlH?=
 =?us-ascii?Q?hKRYPtBYyt0Jw0jVdOHtZ7sc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:49:55.9890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07e1cdb-1e80-44eb-4db7-08dc643b8402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

From: Harry Wentland <harry.wentland@amd.com>

Cursors are always programmed independently of updates on other
planes. When atomic commits program cursor and surface updates
together the cursor update might be locked out by the surface
update and not take effect.

To combat this program cursor and surface updates together via
dc_update_planes_and_stream to ensure they can be applied
atomically.

When cursor updates come on their own use the old method
to program the cursor as dc_update_planes_and_stream isn't
handling this case correctly (yet), leading to a flickering
screen.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2186

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 79 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 14 ++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 12 +++
 6 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7481440ab124..75b65b243f1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8365,6 +8365,77 @@ static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
 	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
 }
 
+static void amdgpu_dm_update_cursor(struct drm_plane *plane,
+				    struct drm_plane_state *old_plane_state,
+				    struct dc_stream_update *update)
+{
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
+	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
+	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	uint64_t address = afb ? afb->address : 0;
+	struct dc_cursor_position position = {0};
+	struct dc_cursor_attributes attributes;
+	int ret;
+
+	if (!plane->state->fb && !old_plane_state->fb)
+		return;
+
+	drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
+		       amdgpu_crtc->crtc_id, plane->state->crtc_w,
+		       plane->state->crtc_h);
+
+	ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
+	if (ret)
+		return;
+
+	if (!position.enable) {
+		/* turn off cursor */
+		if (crtc_state && crtc_state->stream) {
+			dc_stream_set_cursor_position(crtc_state->stream,
+						      &position);
+			update->cursor_position = &crtc_state->stream->cursor_position;
+		}
+		return;
+	}
+
+	amdgpu_crtc->cursor_width = plane->state->crtc_w;
+	amdgpu_crtc->cursor_height = plane->state->crtc_h;
+
+	memset(&attributes, 0, sizeof(attributes));
+	attributes.address.high_part = upper_32_bits(address);
+	attributes.address.low_part  = lower_32_bits(address);
+	attributes.width             = plane->state->crtc_w;
+	attributes.height            = plane->state->crtc_h;
+	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
+	attributes.rotation_angle    = 0;
+	attributes.attribute_flags.value = 0;
+
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
+	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+
+	if (crtc_state->stream) {
+		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
+						     &attributes))
+			DRM_ERROR("DC failed to set cursor attributes\n");
+
+		update->cursor_attributes = &crtc_state->stream->cursor_attributes;
+
+		if (!dc_stream_set_cursor_position(crtc_state->stream,
+						   &position))
+			DRM_ERROR("DC failed to set cursor position\n");
+
+		update->cursor_position = &crtc_state->stream->cursor_position;
+	}
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -8388,6 +8459,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool cursor_update = false;
 	bool pflip_present = false;
 	bool dirty_rects_changed = false;
+	bool updated_planes_and_streams = false;
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_plane_info plane_infos[MAX_SURFACES];
@@ -8424,8 +8496,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		/* Cursor plane is handled after stream updates */
 		if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 			if ((fb && crtc == pcrtc) ||
-			    (old_plane_state->fb && old_plane_state->crtc == pcrtc))
+			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
+				amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
+			}
 
 			continue;
 		}
@@ -8698,6 +8772,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 					 acrtc_state->stream,
 					 &bundle->stream_update,
 					 bundle->surface_updates);
+		updated_planes_and_streams = true;
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8775,7 +8850,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	 * This avoids redundant programming in the case where we're going
 	 * to be disabling a single plane - those pipes are being disabled.
 	 */
-	if (acrtc_state->active_planes)
+	if (acrtc_state->active_planes && !updated_planes_and_streams)
 		amdgpu_dm_commit_cursors(state);
 
 cleanup:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 3c03f690852c..a64f20fcddaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1197,8 +1197,8 @@ static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 	return 0;
 }
 
-static int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
-					       struct dc_cursor_position *position)
+int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
+					struct dc_cursor_position *position)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int x, y;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index b51a6b57bd9b..6498359bff6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -29,6 +29,9 @@
 
 #include "dc.h"
 
+int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
+					struct dc_cursor_position *position);
+
 void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 			  struct drm_plane_state *old_plane_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3e16041bf4f9..e955c97697ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3340,6 +3340,11 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
+			if (stream_update->cursor_attributes)
+				program_cursor_attributes(dc, stream);
+
+			if (stream_update->cursor_position)
+				program_cursor_position(dc, stream);
 
 			/* Full fe update*/
 			if (update_type == UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 3ac1fec4bf53..b5a89b587d86 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -219,10 +219,9 @@ struct dc_stream_status *dc_stream_get_status(
 	return dc_state_get_stream_status(dc->current_state, stream);
 }
 
-static void program_cursor_attributes(
+void program_cursor_attributes(
 	struct dc *dc,
-	struct dc_stream_state *stream,
-	const struct dc_cursor_attributes *attributes)
+	struct dc_stream_state *stream)
 {
 	int i;
 	struct resource_context *res_ctx;
@@ -318,7 +317,7 @@ bool dc_stream_program_cursor_attributes(
 			reset_idle_optimizations = true;
 		}
 
-		program_cursor_attributes(dc, stream, attributes);
+		program_cursor_attributes(dc, stream);
 
 		/* re-enable idle optimizations if necessary */
 		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
@@ -330,10 +329,9 @@ bool dc_stream_program_cursor_attributes(
 	return false;
 }
 
-static void program_cursor_position(
+void program_cursor_position(
 	struct dc *dc,
-	struct dc_stream_state *stream,
-	const struct dc_cursor_position *position)
+	struct dc_stream_state *stream)
 {
 	int i;
 	struct resource_context *res_ctx;
@@ -410,7 +408,7 @@ bool dc_stream_program_cursor_position(
 			reset_idle_optimizations = true;
 		}
 
-		program_cursor_position(dc, stream, position);
+		program_cursor_position(dc, stream);
 		/* re-enable idle optimizations if necessary */
 		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
 			dc_allow_idle_optimizations(dc, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 8dd65a95d84b..1469a20f2511 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -341,6 +341,9 @@ struct dc_stream_update {
 
 	struct test_pattern *pending_test_pattern;
 	struct dc_crtc_timing_adjust *crtc_timing_adjust;
+
+	struct dc_cursor_attributes *cursor_attributes;
+	struct dc_cursor_position *cursor_position;
 };
 
 bool dc_is_stream_unchanged(
@@ -480,6 +483,15 @@ struct dc_stream_status *dc_stream_get_status(
  * Cursor interfaces - To manages the cursor within a stream
  ******************************************************************************/
 /* TODO: Deprecated once we switch to dc_set_cursor_position */
+
+void program_cursor_attributes(
+	struct dc *dc,
+	struct dc_stream_state *stream);
+
+void program_cursor_position(
+	struct dc *dc,
+	struct dc_stream_state *stream);
+
 bool dc_stream_set_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes);
-- 
2.37.3

