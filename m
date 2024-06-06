Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE0DC27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6EB10EAFD;
	Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="meD1RibF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7D710EAEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxOgr+DQ42GFKXOQ3fYSuotLcg+cG86CfzhhW+nlIvzr6NDndSNWKqymrvNj3ryzkCOHcIQJi1MlBHNDG4zvwzhgo7F3gb1JKxePVAd0BD7g7CiekzWOlJr0q9dl5C+Sc2bEb5ckYY1oijbnY9BfVNnTlZJkxQsirQk+lEh7IfO8w+vvWj77XxhcvHU+yWx2tTVg2T3dAtS5vZqfJpcczsq6R33RgV5n5hjYkvp2ol+999blfu3sHyP/k5j09ZtweO4PnGkiBMDj648Jo+wmuIGsRygJ2Dt/6jBcGzPGjChCQZ7NycvgXgyiWcW1DjxJvLHUbOVrINkuQIywL6Z05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0WW7QaZZ0bkvn6sfE9IKiF0mmitIAtNLBR4FAbmuUc=;
 b=llfLznv37zt4BTVtC1RAXTYKWX0Tg6UC6I3PgeOEm5aeDkrB7c0Z87bE9//E2yR/9iS8pYZNUmNVUt0ZATCzrR+G9XzNXcpjoUYP5kD8vHVTGwdw88U5NsSYaOy76G0Jf7+j4zy6BZKDzZzBHCwCBe4GH3SNAgVI/dGY0VcnWWZrZCWK2aQwCPGmiOpxI6/u1gijiDFVqOgC+2kGuPpsjsoPhE5k6XLYpfv7/ewDFEaP7r1LnvE/7THZA9sGHtYXcLn5kND5YsdPzlkaMJq4aLX7nMa018M9Ny7CMHeCVuw2mYaqSijYq03btJv21tVokSD120xlPSfX+NxYW7RjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0WW7QaZZ0bkvn6sfE9IKiF0mmitIAtNLBR4FAbmuUc=;
 b=meD1RibFBdt9SwG7oAfufW7TN4SDepDBPwJT5G0o/E6mBMJx7WaaAg8kOqMo2tvImitmZY92FdXnzTknwkL4Z8vESwlAdEjLMr0bOcYfA3JqIHGOzZOvg9ga6CnC8Bvm3Tvx5UAYvTfaK23yyxWewKOBTMoYMqrbbQhCDE0ry2s=
Received: from MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 21:57:55 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::39) by MN2PR20CA0027.outlook.office365.com
 (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:53 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Leo Li <sunpeng.li@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Pekka
 Paalanen" <pekka.paalanen@collabora.com>
Subject: [PATCH 40/67] drm/amd/display: Introduce overlay cursor mode
Date: Thu, 6 Jun 2024 17:56:05 -0400
Message-ID: <20240606215632.4061204-41-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f718dbc-2c98-47df-3d42-08dc8673b882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vbAcelEH9fhTxDSSPwbDp0+5guwlT8NIJ62bYqX9OscjJRIsKADmhjirDFuZ?=
 =?us-ascii?Q?nIuxThs/TV8FZaX0u/1qp/AdQ/KWOiaK/oPaU9dvHoE9mbz3c7Jc5RtV40bv?=
 =?us-ascii?Q?ZAoRuwMJ6INkuX3AZzEvEGe7JBjoGI6PuJ4pWF5bqlyfa15n69fGLT/94VKd?=
 =?us-ascii?Q?sFNI5dJiyF+uo0p5snjBXJW0aIzo4XsQUR5FBMuFz4b/UfmnDLcpmLImpwc9?=
 =?us-ascii?Q?NvqGdsSNMqRGhwfFBFZ6TOQaR7Fv3MJ3979/WnCFWe4mrY9cPTYet9asvVmb?=
 =?us-ascii?Q?YWYKuUjh4H2YEy4q8+WzDXSq9fb/KgkLUNUL8/eOl8OsntZYalJnR+nl5aJE?=
 =?us-ascii?Q?+AiJ5s4B9PwZd3plWdsPo5SVQQgskOS4zkY+XX+xbj/+cdVBv6cMpptoj3T/?=
 =?us-ascii?Q?8KrXLmKteoS1OUfE5HlaRVhCteSTBgghglf7jY7qaSJsTdb0Tv8088sUn44s?=
 =?us-ascii?Q?40kpgYr22QdXiPci2ymCTA0wQ5jY3IjL3NIUaOE8Zq0ZsOMSWeks/d29W4eP?=
 =?us-ascii?Q?8vyEnDp7yyBZXqPYCaEt2+3I2Z5e41lKsIqZQzlNiOGgNJAjxkfymZQRshIh?=
 =?us-ascii?Q?e4mxdRG2IyhVuJ1OuJWtabcNadLD4VK2Sl4NNt4U7YpSbxhYvgpM6u4XiJJ9?=
 =?us-ascii?Q?BmzT2t+hLS9xbfHxAb27N6mlVLgJeTfXB1Z1vUeQLtPUKU1T0gQtMYrohI35?=
 =?us-ascii?Q?daQRzLFsX9+qRWQlSiIxwWrxd4FORTSvChvXoOCZhqX0rTIxo4TSOPUYHltS?=
 =?us-ascii?Q?pCODw4vXRSQtRRsUFjaEhgvcLpRYl7WR3wPSRdXLeK44ZMdtBGbMfH+AQovG?=
 =?us-ascii?Q?u1vp3Z7QDpkxQ0/JTKc/oyoyCb9Ur8NMtU/6sOqKChroHx0t/c4xVFnXNrsc?=
 =?us-ascii?Q?4KchXNYhsFteFISX/AAUOPkUYvIjDpqP52ZGPO5VefdIIUFfgbsCESM22/FX?=
 =?us-ascii?Q?qr04JzKdVxNuee7dUJdj5JyT14zKg/AD8O6BIeYGxF4SSIC8KYmOhC1Hqud9?=
 =?us-ascii?Q?jhAsr17ZL74nLb8VzElkGlgyYK9j9kapSm2bNaJ/BEG5RdKPnf6zGVcdeAr5?=
 =?us-ascii?Q?Kyx+5oFsjUb8VzXuM8W36k9fO37CSVZzT1fMofLdej8f0Nv3PnnD/xJakFUK?=
 =?us-ascii?Q?ro98m7aDea6tMpD7OreV1Y1LxRE6CR7lIDUdAr7+Dcow649NVa/RBblrT3AZ?=
 =?us-ascii?Q?1E39Eiiia0BP/7d3N2fUlv+Lyyb9GiGX4l94Iwb/Ti8B/8vfmFAlFYpySa4Z?=
 =?us-ascii?Q?OZub/SqzZRuDeGFn85ko3sLHKOTLQ1ctA9jQiDHLowmeIqWldo2RsKd75gOs?=
 =?us-ascii?Q?EIl69s17mQww/f4u8rgU6+4tyeuxDmbAP0E+ovJILP3yMyEvMiblEliGqTK9?=
 =?us-ascii?Q?6reE1sbMuB4tWwR+jodw+KGQro06raCU6C7yJ7vceBaCiIpDEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:55.3890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f718dbc-2c98-47df-3d42-08dc8673b882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801
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

DCN is the display hardware for amdgpu. DRM planes are backed by DCN
hardware pipes, which carry pixel data from one end (memory), to the
other (output encoder).

Each DCN pipe has the ability to blend in a cursor early on in the
pipeline. In other words, there are no dedicated cursor planes in DCN,
which makes cursor behavior somewhat unintuitive for compositors.

For example, if the cursor is in RGB format, but the top-most DRM plane
is in YUV format, DCN will not be able to blend them. Because of this,
amdgpu_dm rejects all configurations where a cursor needs to be enabled
on top of a YUV formatted plane.

From a compositor's perspective, when computing an allocation for
hardware plane offloading, this cursor-on-yuv configuration result in an
atomic test failure. Since the failure reason is not obvious at all,
compositors will likely fall back to full rendering, which is not ideal.

Instead, amdgpu_dm can try to accommodate the cursor-on-yuv
configuration by opportunistically reserving a separate DCN pipe just
for the cursor. We can refer to this as "overlay cursor mode". It is
contrasted with "native cursor mode", where the native DCN per-pipe
cursor is used.

[How]

On each crtc, compute whether the cursor plane should be enabled in
overlay mode. If it is, mark the CRTC as requesting overlay cursor mode.

Overlay cursor should be enabled whenever there exists a underlying
plane that has YUV format, or is scaled differently than the cursor. It
should also be enabled if there is no underlying plane, or if underlying
planes do not cover the entire CRTC.

During DC validation, attempt to enable a separate DCN pipe for the
cursor if it's in overlay mode. If that fails, or if no overlay mode is
requested, then fallback to native mode.

v2:
* Update commit message for when overlay cursor should be enabled
* Also consider scale and no-underlying-plane case (cursor on crtc bg)
* Consider all underlying planes when determinig overlay/native, not
  just the plane immediately beneath the cursor, as it may not cover the
  entire CRTC.
* Fix typo s/decending/descending/
* Force native cursor on pre-DCN hardware

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 490 +++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  13 +-
 4 files changed, 389 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9e9ec74b27b0..6697ee9b3d72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8756,8 +8756,24 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	 * Disable the cursor first if we're disabling all the planes.
 	 * It'll remain on the screen after the planes are re-enabled
 	 * if we don't.
+	 *
+	 * If the cursor is transitioning from native to overlay mode, the
+	 * native cursor needs to be disabled first.
 	 */
-	if (acrtc_state->active_planes == 0)
+	if (acrtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE &&
+	    dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE) {
+		struct dc_cursor_position cursor_position = {0};
+
+		if (!dc_stream_set_cursor_position(acrtc_state->stream,
+						   &cursor_position))
+			drm_err(dev, "DC failed to disable native cursor\n");
+
+		bundle->stream_update.cursor_position =
+				&acrtc_state->stream->cursor_position;
+	}
+
+	if (acrtc_state->active_planes == 0 &&
+	    dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE)
 		amdgpu_dm_commit_cursors(state);
 
 	/* update planes when needed */
@@ -8771,7 +8787,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
 
 		/* Cursor plane is handled after stream updates */
-		if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
+		    acrtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE) {
 			if ((fb && crtc == pcrtc) ||
 			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
@@ -9127,7 +9144,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	 * to be disabling a single plane - those pipes are being disabled.
 	 */
 	if (acrtc_state->active_planes &&
-	    (!updated_planes_and_streams || amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0))
+	    (!updated_planes_and_streams || amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) &&
+	    acrtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE)
 		amdgpu_dm_commit_cursors(state);
 
 cleanup:
@@ -10445,7 +10463,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 {
 	struct drm_plane *other;
 	struct drm_plane_state *old_other_state, *new_other_state;
-	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct dm_crtc_state *old_dm_crtc_state, *new_dm_crtc_state;
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	int i;
 
@@ -10467,10 +10486,24 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 
 	new_crtc_state =
 		drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+	old_crtc_state =
+		drm_atomic_get_old_crtc_state(state, old_plane_state->crtc);
 
 	if (!new_crtc_state)
 		return true;
 
+	/*
+	 * A change in cursor mode means a new dc pipe needs to be acquired or
+	 * released from the state
+	 */
+	old_dm_crtc_state = to_dm_crtc_state(old_crtc_state);
+	new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
+	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
+	    old_dm_crtc_state != NULL &&
+	    old_dm_crtc_state->cursor_mode != new_dm_crtc_state->cursor_mode) {
+		return true;
+	}
+
 	/* CRTC Degamma changes currently require us to recreate planes. */
 	if (new_crtc_state->color_mgmt_changed)
 		return true;
@@ -10622,6 +10655,68 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	return 0;
 }
 
+/*
+ * Helper function for checking the cursor in native mode
+ */
+static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
+					struct drm_plane *plane,
+					struct drm_plane_state *new_plane_state,
+					bool enable)
+{
+
+	struct amdgpu_crtc *new_acrtc;
+	int ret;
+
+	if (!enable || !new_plane_crtc ||
+	    drm_atomic_plane_disabling(plane->state, new_plane_state))
+		return 0;
+
+	new_acrtc = to_amdgpu_crtc(new_plane_crtc);
+
+	if (new_plane_state->src_x != 0 || new_plane_state->src_y != 0) {
+		DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
+		return -EINVAL;
+	}
+
+	if (new_plane_state->fb) {
+		ret = dm_check_cursor_fb(new_acrtc, new_plane_state,
+						new_plane_state->fb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool dm_should_update_native_cursor(struct drm_atomic_state *state,
+					   struct drm_crtc *old_plane_crtc,
+					   struct drm_crtc *new_plane_crtc,
+					   bool enable)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+
+	if (!enable) {
+		if (old_plane_crtc == NULL)
+			return true;
+
+		old_crtc_state = drm_atomic_get_old_crtc_state(
+			state, old_plane_crtc);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		return dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
+	} else {
+		if (new_plane_crtc == NULL)
+			return true;
+
+		new_crtc_state = drm_atomic_get_new_crtc_state(
+			state, new_plane_crtc);
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
+	}
+}
+
 static int dm_update_plane_state(struct dc *dc,
 				 struct drm_atomic_state *state,
 				 struct drm_plane *plane,
@@ -10637,8 +10732,7 @@ static int dm_update_plane_state(struct dc *dc,
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *dm_new_crtc_state, *dm_old_crtc_state;
 	struct dm_plane_state *dm_new_plane_state, *dm_old_plane_state;
-	struct amdgpu_crtc *new_acrtc;
-	bool needs_reset;
+	bool needs_reset, update_native_cursor;
 	int ret = 0;
 
 
@@ -10647,24 +10741,16 @@ static int dm_update_plane_state(struct dc *dc,
 	dm_new_plane_state = to_dm_plane_state(new_plane_state);
 	dm_old_plane_state = to_dm_plane_state(old_plane_state);
 
-	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
-		if (!enable || !new_plane_crtc ||
-			drm_atomic_plane_disabling(plane->state, new_plane_state))
-			return 0;
-
-		new_acrtc = to_amdgpu_crtc(new_plane_crtc);
+	update_native_cursor = dm_should_update_native_cursor(state,
+							      old_plane_crtc,
+							      new_plane_crtc,
+							      enable);
 
-		if (new_plane_state->src_x != 0 || new_plane_state->src_y != 0) {
-			DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
-			return -EINVAL;
-		}
-
-		if (new_plane_state->fb) {
-			ret = dm_check_cursor_fb(new_acrtc, new_plane_state,
-						 new_plane_state->fb);
-			if (ret)
-				return ret;
-		}
+	if (plane->type == DRM_PLANE_TYPE_CURSOR && update_native_cursor) {
+		ret = dm_check_native_cursor_state(new_plane_crtc, plane,
+						    new_plane_state, enable);
+		if (ret)
+			return ret;
 
 		return 0;
 	}
@@ -10730,20 +10816,14 @@ static int dm_update_plane_state(struct dc *dc,
 
 		ret = amdgpu_dm_plane_helper_check_state(new_plane_state, new_crtc_state);
 		if (ret)
-			return ret;
+			goto out;
 
 		WARN_ON(dm_new_plane_state->dc_state);
 
 		dc_new_plane_state = dc_create_plane_state(dc);
-		if (!dc_new_plane_state)
-			return -ENOMEM;
-
-		/* Block top most plane from being a video plane */
-		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
-			if (amdgpu_dm_plane_is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
-				return -EINVAL;
-
-			*is_top_most_overlay = false;
+		if (!dc_new_plane_state) {
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
@@ -10756,13 +10836,13 @@ static int dm_update_plane_state(struct dc *dc,
 			new_crtc_state);
 		if (ret) {
 			dc_plane_state_release(dc_new_plane_state);
-			return ret;
+			goto out;
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret) {
 			dc_plane_state_release(dc_new_plane_state);
-			return ret;
+			goto out;
 		}
 
 		/*
@@ -10779,7 +10859,8 @@ static int dm_update_plane_state(struct dc *dc,
 				dm_state->context)) {
 
 			dc_plane_state_release(dc_new_plane_state);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		dm_new_plane_state->dc_state = dc_new_plane_state;
@@ -10794,6 +10875,16 @@ static int dm_update_plane_state(struct dc *dc,
 		*lock_and_validation_needed = true;
 	}
 
+out:
+	/* If enabling cursor overlay failed, attempt fallback to native mode */
+	if (enable && ret == -EINVAL && plane->type == DRM_PLANE_TYPE_CURSOR) {
+		ret = dm_check_native_cursor_state(new_plane_crtc, plane,
+						    new_plane_state, enable);
+		if (ret)
+			return ret;
+
+		dm_new_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
+	}
 
 	return ret;
 }
@@ -10827,99 +10918,64 @@ dm_get_plane_scale(struct drm_plane_state *plane_state,
 	*out_plane_scale_h = plane_state->crtc_h * 1000 / plane_src_h;
 }
 
-static int dm_check_crtc_cursor(struct drm_atomic_state *state,
-				struct drm_crtc *crtc,
-				struct drm_crtc_state *new_crtc_state)
+/*
+ * The normalized_zpos value cannot be used by this iterator directly. It's only
+ * calculated for enabled planes, potentially causing normalized_zpos collisions
+ * between enabled/disabled planes in the atomic state. We need a unique value
+ * so that the iterator will not generate the same object twice, or loop
+ * indefinitely.
+ */
+static inline struct __drm_planes_state *__get_next_zpos(
+	struct drm_atomic_state *state,
+	struct __drm_planes_state *prev)
 {
-	struct drm_plane *cursor = crtc->cursor, *plane, *underlying;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
-	struct drm_plane_state *new_cursor_state, *new_underlying_state;
-	int i;
-	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
-	bool any_relevant_change = false;
-
-	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
-	 * cursor per pipe but it's going to inherit the scaling and
-	 * positioning from the underlying pipe. Check the cursor plane's
-	 * blending properties match the underlying planes'.
-	 */
-
-	/* If no plane was enabled or changed scaling, no need to check again */
-	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
-		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
-
-		if (!new_plane_state || !new_plane_state->fb || new_plane_state->crtc != crtc)
-			continue;
-
-		if (!old_plane_state || !old_plane_state->fb || old_plane_state->crtc != crtc) {
-			any_relevant_change = true;
-			break;
-		}
-
-		if (new_plane_state->fb == old_plane_state->fb &&
-		    new_plane_state->crtc_w == old_plane_state->crtc_w &&
-		    new_plane_state->crtc_h == old_plane_state->crtc_h)
-			continue;
-
-		dm_get_plane_scale(new_plane_state, &new_scale_w, &new_scale_h);
-		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
+	unsigned int highest_zpos = 0, prev_zpos = 256;
+	uint32_t highest_id = 0, prev_id = UINT_MAX;
+	struct drm_plane_state *new_plane_state;
+	struct drm_plane *plane;
+	int i, highest_i = -1;
 
-		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
-			any_relevant_change = true;
-			break;
-		}
+	if (prev != NULL) {
+		prev_zpos = prev->new_state->zpos;
+		prev_id = prev->ptr->base.id;
 	}
 
-	if (!any_relevant_change)
-		return 0;
-
-	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
-	if (IS_ERR(new_cursor_state))
-		return PTR_ERR(new_cursor_state);
-
-	if (!new_cursor_state->fb)
-		return 0;
-
-	dm_get_plane_scale(new_cursor_state, &cursor_scale_w, &cursor_scale_h);
-
-	/* Need to check all enabled planes, even if this commit doesn't change
-	 * their state
-	 */
-	i = drm_atomic_add_affected_planes(state, crtc);
-	if (i)
-		return i;
-
-	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
-		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
-		if (new_underlying_state->crtc != crtc || underlying == crtc->cursor)
-			continue;
-
-		/* Ignore disabled planes */
-		if (!new_underlying_state->fb)
+	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
+		/* Skip planes with higher zpos than the previously returned */
+		if (new_plane_state->zpos > prev_zpos ||
+		    (new_plane_state->zpos == prev_zpos &&
+		     plane->base.id >= prev_id))
 			continue;
 
-		dm_get_plane_scale(new_underlying_state,
-				   &underlying_scale_w, &underlying_scale_h);
-
-		if (cursor_scale_w != underlying_scale_w ||
-		    cursor_scale_h != underlying_scale_h) {
-			drm_dbg_atomic(crtc->dev,
-				       "Cursor [PLANE:%d:%s] scaling doesn't match underlying [PLANE:%d:%s]\n",
-				       cursor->base.id, cursor->name, underlying->base.id, underlying->name);
-			return -EINVAL;
+		/* Save the index of the plane with highest zpos */
+		if (new_plane_state->zpos > highest_zpos ||
+		    (new_plane_state->zpos == highest_zpos &&
+		     plane->base.id > highest_id)) {
+			highest_zpos = new_plane_state->zpos;
+			highest_id = plane->base.id;
+			highest_i = i;
 		}
-
-		/* If this plane covers the whole CRTC, no need to check planes underneath */
-		if (new_underlying_state->crtc_x <= 0 &&
-		    new_underlying_state->crtc_y <= 0 &&
-		    new_underlying_state->crtc_x + new_underlying_state->crtc_w >= new_crtc_state->mode.hdisplay &&
-		    new_underlying_state->crtc_y + new_underlying_state->crtc_h >= new_crtc_state->mode.vdisplay)
-			break;
 	}
 
-	return 0;
+	if (highest_i < 0)
+		return NULL;
+
+	return &state->planes[highest_i];
 }
 
+/*
+ * Use the uniqueness of the plane's (zpos, drm obj ID) combination to iterate
+ * by descending zpos, as read from the new plane state. This is the same
+ * ordering as defined by drm_atomic_normalize_zpos().
+ */
+#define for_each_oldnew_plane_in_descending_zpos(__state, plane, old_plane_state, new_plane_state) \
+	for (struct __drm_planes_state *__i = __get_next_zpos((__state), NULL); \
+	     __i != NULL; __i = __get_next_zpos((__state), __i))		\
+		for_each_if(((plane) = __i->ptr,				\
+			     (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			     (old_plane_state) = __i->old_state,		\
+			     (new_plane_state) = __i->new_state, 1))
+
 static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
@@ -10950,6 +11006,165 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->mst_mgr);
 }
 
+/**
+ * DOC: Cursor Modes - Native vs Overlay
+ *
+ * In native mode, the cursor uses a integrated cursor pipe within each DCN hw
+ * plane. It does not require a dedicated hw plane to enable, but it is
+ * subjected to the same z-order and scaling as the hw plane. It also has format
+ * restrictions, a RGB cursor in native mode cannot be enabled within a non-RGB
+ * hw plane.
+ *
+ * In overlay mode, the cursor uses a separate DCN hw plane, and thus has its
+ * own scaling and z-pos. It also has no blending restrictions. It lends to a
+ * cursor behavior more akin to a DRM client's expectations. However, it does
+ * occupy an extra DCN plane, and therefore will only be used if a DCN plane is
+ * available.
+ */
+
+/**
+ * dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
+ * @adev: amdgpu device
+ * @state: DRM atomic state
+ * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
+ * @cursor_mode: Returns the required cursor mode on dm_crtc_state
+ *
+ * Get whether the cursor should be enabled in native mode, or overlay mode, on
+ * the dm_crtc_state.
+ *
+ * The cursor should be enabled in overlay mode if there exists an underlying
+ * plane - on which the cursor may be blended - that is either YUV formatted, or
+ * scaled differently from the cursor.
+ *
+ * Since zpos info is required, drm_atomic_normalize_zpos must be called before
+ * calling this function.
+ *
+ * Return: 0 on success, or an error code if getting the cursor plane state
+ * failed.
+ */
+static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
+				   struct drm_atomic_state *state,
+				   struct dm_crtc_state *dm_crtc_state,
+				   enum amdgpu_dm_cursor_mode *cursor_mode)
+{
+	struct drm_plane_state *old_plane_state, *plane_state, *cursor_state;
+	struct drm_crtc_state *crtc_state = &dm_crtc_state->base;
+	struct drm_plane *plane;
+	bool consider_mode_change = false;
+	bool entire_crtc_covered = false;
+	bool cursor_changed = false;
+	int underlying_scale_w, underlying_scale_h;
+	int cursor_scale_w, cursor_scale_h;
+	int i;
+
+	/* Overlay cursor not supported on HW before DCN */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+		return 0;
+	}
+
+	/* Init cursor_mode to be the same as current */
+	*cursor_mode = dm_crtc_state->cursor_mode;
+
+	/*
+	 * Cursor mode can change if a plane's format changes, scale changes, is
+	 * enabled/disabled, or z-order changes.
+	 */
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, plane_state, i) {
+		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
+
+		/* Only care about planes on this CRTC */
+		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0)
+			continue;
+
+		if (plane->type == DRM_PLANE_TYPE_CURSOR)
+			cursor_changed = true;
+
+		if (drm_atomic_plane_enabling(old_plane_state, plane_state) ||
+		    drm_atomic_plane_disabling(old_plane_state, plane_state) ||
+		    old_plane_state->fb->format != plane_state->fb->format) {
+			consider_mode_change = true;
+			break;
+		}
+
+		dm_get_plane_scale(plane_state, &new_scale_w, &new_scale_h);
+		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
+		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
+			consider_mode_change = true;
+			break;
+		}
+	}
+
+	if (!consider_mode_change && !crtc_state->zpos_changed)
+		return 0;
+
+	/*
+	 * If no cursor change on this CRTC, and not enabled on this CRTC, then
+	 * no need to set cursor mode. This avoids needlessly locking the cursor
+	 * state.
+	 */
+	if (!cursor_changed &&
+	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state->plane_mask)) {
+		return 0;
+	}
+
+	cursor_state = drm_atomic_get_plane_state(state,
+						  crtc_state->crtc->cursor);
+	if (IS_ERR(cursor_state))
+		return PTR_ERR(cursor_state);
+
+	/* Cursor is disabled */
+	if (!cursor_state->fb)
+		return 0;
+
+	/* For all planes in descending z-order (all of which are below cursor
+	 * as per zpos definitions), check their scaling and format
+	 */
+	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, plane_state) {
+
+		/* Only care about non-cursor planes on this CRTC */
+		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0 ||
+		    plane->type == DRM_PLANE_TYPE_CURSOR)
+			continue;
+
+		/* Underlying plane is YUV format - use overlay cursor */
+		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
+		dm_get_plane_scale(plane_state,
+				   &underlying_scale_w, &underlying_scale_h);
+		dm_get_plane_scale(cursor_state,
+				   &cursor_scale_w, &cursor_scale_h);
+
+		/* Underlying plane has different scale - use overlay cursor */
+		if (cursor_scale_w != underlying_scale_w &&
+		    cursor_scale_h != underlying_scale_h) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
+		/* If this plane covers the whole CRTC, no need to check planes underneath */
+		if (plane_state->crtc_x <= 0 && plane_state->crtc_y <= 0 &&
+		    plane_state->crtc_x + plane_state->crtc_w >= crtc_state->mode.hdisplay &&
+		    plane_state->crtc_y + plane_state->crtc_h >= crtc_state->mode.vdisplay) {
+			entire_crtc_covered = true;
+			break;
+		}
+	}
+
+	/* If planes do not cover the entire CRTC, use overlay mode to enable
+	 * cursor over holes
+	 */
+	if (entire_crtc_covered)
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+	else
+		*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	return 0;
+}
+
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  *
@@ -11119,6 +11334,21 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		goto fail;
 	}
 
+	/*
+	 * Determine whether cursors on each CRTC should be enabled in native or
+	 * overlay mode.
+	 */
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+					      &dm_new_crtc_state->cursor_mode);
+		if (ret) {
+			drm_dbg(dev, "Failed to determine cursor mode\n");
+			goto fail;
+		}
+	}
+
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		if (old_plane_state->fb && new_plane_state->fb &&
@@ -11199,11 +11429,29 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			drm_dbg_atomic(dev, "MPO enablement requested on crtc:[%p]\n", crtc);
 	}
 
-	/* Check cursor planes scaling */
+	/* Check cursor planes restrictions */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
-		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
+		enum amdgpu_dm_cursor_mode required_cursor_mode;
+
+		/* Overlay cusor not subject to native cursor restrictions */
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
+			continue;
+
+		/* If HW can only do native cursor, check restrictions again */
+		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+					      &required_cursor_mode);
+ 
 		if (ret) {
-			drm_dbg_atomic(dev, "dm_check_crtc_cursor() failed\n");
+			drm_dbg_driver(crtc->dev,
+				       "[CRTC:%d:%s] Checking cursor mode failed\n",
+				       crtc->base.id, crtc->name);
+			goto fail;
+		} else if (required_cursor_mode == DM_CURSOR_OVERLAY_MODE) {
+			drm_dbg_driver(crtc->dev,
+				       "[CRTC:%d:%s] Cannot enable native cursor due to scaling or YUV restrictions\n",
+				       crtc->base.id, crtc->name);
+			ret = -EINVAL;
 			goto fail;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ca1867702742..484f1f054eb6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -834,6 +834,11 @@ struct dm_plane_state {
 	enum amdgpu_transfer_function blend_tf;
 };
 
+enum amdgpu_dm_cursor_mode {
+	DM_CURSOR_NATIVE_MODE = 0,
+	DM_CURSOR_OVERLAY_MODE,
+};
+
 struct dm_crtc_state {
 	struct drm_crtc_state base;
 	struct dc_stream_state *stream;
@@ -864,6 +869,8 @@ struct dm_crtc_state {
 	 * encoding.
 	 */
 	enum amdgpu_transfer_function regamma_tf;
+
+	enum amdgpu_dm_cursor_mode cursor_mode;
 };
 
 #define to_dm_crtc_state(x) container_of(x, struct dm_crtc_state, base)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 83ea0afddda7..e16eecb146fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -361,6 +361,7 @@ static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *cr
 	state->regamma_tf = cur->regamma_tf;
 	state->crc_skip_count = cur->crc_skip_count;
 	state->mpo_requested = cur->mpo_requested;
+	state->cursor_mode = cur->cursor_mode;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b339642b86c0..969fc42f9a68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -104,7 +104,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 	*global_alpha = false;
 	*global_alpha_value = 0xff;
 
-	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
+	if (plane_state->plane->type == DRM_PLANE_TYPE_PRIMARY)
 		return;
 
 	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
@@ -1190,10 +1190,21 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 					      struct drm_atomic_state *state)
 {
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane_state *new_plane_state;
+	struct dm_crtc_state *dm_new_crtc_state;
+
 	/* Only support async updates on cursor planes. */
 	if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		return -EINVAL;
 
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+	/* Reject overlay cursors for now*/
+	if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.34.1

