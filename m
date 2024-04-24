Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB884C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DE410EB44;
	Wed, 24 Apr 2024 08:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Im17PPf4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A22810EB44
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSjVdUbD/L1uqg2uQ6nGZNAO9vKVW/l2EEAy9VnJg0LaMBu2q3nKWGCah8wsUrzQY61yMWuYu5S04rVnO6+zImVIGO94D2hnlQ2j1BpKtp50PT4P9wGF0irUrOjF+tr/q+NtXcIpGsahWWiPvdx4itzktjYrZqwPu6cCGTxKHXpWZqNx9HL/DYEUIg1B8eDwbUITvHLmJkIod9XqF/qXKo3ep87o+nA0KmlyrhDDYqFHBACHjSPNXRuAgp4Mk8q0/wUeGsWIUcqUpgD6rZivru9HdcrbzaFeARxWSCO7YHiPBEHtcxyGAQBkqjtfi2LF1cm6/Ul3jpLgqCx46ZdrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpLs2Gnbq14eV9bBhba/mrwk7bHw5rLYcxuTmZAaSWU=;
 b=SVJRRpXKiMPEgLJ5m72stm+Gft15ZC82f3ZkOaTCEKGB1miwndCAGiygg3M5tsAo9CHL89xGZcO6IlNd7LoUB4610BSn1zafGx3HSbXbR9dAcJHnIRhliE7BsD2Pqh5L8uMlCT/Tz4UgOP5TtEXdKrr6uN6t38yn5eaflDqw2MTMJlryI4iylgvmGN/aOQ/CxEjxZAC3JNPJI1cPChL8EJyMAsSb1KYZa6cYt4tClUcg4uFjwF/zllPDbHRTE2Zu5C/NkmSWKejRfHKe0gmUxz8Yafn92WA1/RfQDr9UZPXflHvW25nmd+hXT/HT+CIpokzo6kO09DWga8OdTCMcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpLs2Gnbq14eV9bBhba/mrwk7bHw5rLYcxuTmZAaSWU=;
 b=Im17PPf4BaQyRlaXH35vgKiS8RqJcb+kzEX6eqCjxuMx6RARlC1bwoJYGBXQie/9oStbdzETPKGKFDcES2NZr5TVpdn+JWsBeivIe+7KEJIP0dGC/Uklc+UkiKf/M5WQ8zfuVISQTVkJtR0C3vd+zqCXavm38Bs7nl8kRRGoVYI=
Received: from MN2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:208:120::27)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:32:34 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:120:cafe::5) by MN2PR10CA0014.outlook.office365.com
 (2603:10b6:208:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:32:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:32:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:32:33 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:32:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 01/46] drm/amd/display: Do cursor programming with rest of pipe
Date: Wed, 24 Apr 2024 16:31:17 +0800
Message-ID: <20240424083202.2647227-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 1074f400-c668-4945-2e10-08dc643916eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PlmYg2bE2C92A1OGvZTbIfye5FG2k6eKHrSJGZtR+EhZ5BWM1uwj7za0JsjU?=
 =?us-ascii?Q?YVhbTeMAQkY2S1zmWzldgSkQKYxfJ1xBowQkr38UFWnGgRKhKyrYWlVUNz4X?=
 =?us-ascii?Q?lFbVMfInhNr1MJ3CABmuZlZ8Ccm5+DO/8SSMcIOZlZnzamnpLjlZfu6ClD1/?=
 =?us-ascii?Q?miYTCpSoZd3BKfUZVG097vIejDmDUMRlGRHpbuAmjLz9D3ZonRFdLCzRGIId?=
 =?us-ascii?Q?MlN41yvy8FaF382F6ztrO2Aor0mB6anLDLGx+ByUMQ2NDNQc2UU2Pj9cwiSQ?=
 =?us-ascii?Q?d9RdNx55QKzFUMAwwjvCo98/R5PRy11OOf6ZDXnYk3LXrkRFgb6auB7sVX+H?=
 =?us-ascii?Q?7AFmBcwKlCZ7mnmegbKVTHWo0oMsA9871ZwLK7kLfO74OBpgeqGBm1eBxvQo?=
 =?us-ascii?Q?vJOkKBRDBXXI6RjYNmcX2ij9+9V4umakpSJbBf5UXP87lTTFQozeUi827F/h?=
 =?us-ascii?Q?ekbcQDJ4GRQ26j9/Iw9XYq7MZnxkGr0klQVvV0u924J+8Cx1JN4cx/6LopQY?=
 =?us-ascii?Q?imoZpA3IFeT/pMhe91Kidwfo6XC8QpwRMrHYZLT2SSUUCDN/hT2lzGBNS4er?=
 =?us-ascii?Q?D5nXc00eUrWyPFb6DDifjEcyFYNuViMGZR1TUdPvy5O4zvD+QGqnCyDqha8Q?=
 =?us-ascii?Q?of0CvTOj+uQwlb8Uci3vs35nev3yT6N0JQdfTQOBS5iElfjIyH2EOvyjXD4t?=
 =?us-ascii?Q?kmfvvNXPA5FNKXhfS/N8Wof9W+7Zk+kiXkBRmsUfEKFHaiqVpB+VQVbOv9D8?=
 =?us-ascii?Q?asI96mHYb6sxBDTV2DN0xs3nvlMK3AvJ9pfXxZxMg75LDnzkMgyJe/lzqz4m?=
 =?us-ascii?Q?rGmSWVYyxIODlMxG92DIENl1DgoxUpnBxd5SiQiB3t06pRBwROkZGfsLNrHh?=
 =?us-ascii?Q?ODvoQ90Gg/Pe9+KpyPSb+OBOYBuMs5gGnZpX0HChZw+zokl8KVRFODLEGH21?=
 =?us-ascii?Q?nVrEanyMaapYGnyX/ramV5MARqu1BcO8E+TviqYtydrFmneGsq3IuqXDWlXo?=
 =?us-ascii?Q?CtxABX47HiZd/Gq49fmGfkvNqQ+zDLl2581ov9xdiSQHInGKU5c+WsyVFE9T?=
 =?us-ascii?Q?QNqWqWwFhcgBl4nlPZ2+hJKAcbFbl37TWGYsDZdo5pUV2oHE5P8DuWvglZCh?=
 =?us-ascii?Q?YxE3xPDLZsxcYae6b7ByHvwhbE7bb0Ky9awBQCH5nXI/uVH8Qxg8vmUNJUSq?=
 =?us-ascii?Q?DSIkBjsTypCfqzZXEb8+XHdd9D0mE73BwCXSOTyBq+ucqW9+BiPfWuplSE94?=
 =?us-ascii?Q?ZUG+q4qzEMqpCsZf6cs8Sff8BGV/7buhENwlzn49KV0Vs0kxDIjeYFnnIzKt?=
 =?us-ascii?Q?2S5r8x4HyKy+l7OYoBiGRNiu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:32:33.9880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1074f400-c668-4945-2e10-08dc643916eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

