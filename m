Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB225C02184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE1510E83A;
	Tue, 14 Jan 2025 02:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ed7SrwjS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EEC10E83A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8rl7vfuzYgo5HiuUH4nHv6IBV4Ux286Lt9Bi7bVWBx1Xk1Xr4CEEOmPkl9ikDqQbtnxAc8vQ2VhRwBwdmtfngqMKBE2LgQDP2Hf4Uxo1269yT3jAFVjYl8B0fIKIWgt2K1bxMLwprVmcelB1ABuzKIWSbYL85Jh22V24kESLNgE2eHq9WlYmsA55b9/zFMISW9xJIBYviKv1rVVyowQwa/btxY32v7E31WGxHjEm3kOOw7UMy40sqLcrTe0X0jIFJA4bwE6Gv2fRn0vYgsYTJ3rP11Rd2yvkOS3w6iWKFIrD+H/Ynn40KbJxScwK+mT7DxpqcnD/G9iW5BUd7jyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FAmAVCTd8vvaAwYnOIHJZOYgO/xztfLXtEsL2WYMxA=;
 b=i3PgTjbElP0fZv6TenIhfTm29e6pBQE5N+YL4QBZ+75iuKSAmnCpVPTiiTtb3KeNWqcl/4dWsbHzPzCUd+Koc0E5bwk9PEHREhPqmFSxZNzvi258NsZVIveF9xq8UjbVvuM8qjW5BiDrujADAx/TEOJuU+9qFrxx84sGdz7kaVxFzJgxmpd+CmKuDn1ASdYh9AuE788WRxMLPpw3jYZloDm5dWETHLd+wlRwu9nFMXu10Olm0t1pp7Dkg7gLZBzJ2hMa7EYssOo8/z13Y3pg4Q6ahgtZJIqwEuN1DpsRd3gJUEhyhRJcpjCNh2UB8039Wnjx2N+E9nyvCFA5WO/QvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FAmAVCTd8vvaAwYnOIHJZOYgO/xztfLXtEsL2WYMxA=;
 b=Ed7SrwjSgOARf8CJKiKbrCgQOxuTWxrFlTiWUZizFUDZzI7XOwPR8tkF0y4aeJswAzmWLZETsMLPnn+hE7ghlMO+5WPvsjaqzREFJ0M9vveFlZknoc6OKuHZCtOh0S3D+JZfDFcd6Y4EnQrCyZlHjkPbPP5nMvANnSDfP3Me0Yc=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 02:09:28 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::16) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:09:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:27 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:09:23 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Yan Li
 <yan.li@amd.com>
Subject: [PATCH 01/11] drm/amd/display: Support "Broadcast RGB" drm property
Date: Tue, 14 Jan 2025 10:08:50 +0800
Message-ID: <20250114020900.3804152-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c08762-d7e2-4191-0269-08dd34407a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gipRk8Jt8MqFZCLqJpJ31lNe4fKweW4ugP1+b6JsHjsdntMUu/y/3va+b+Ic?=
 =?us-ascii?Q?CavVfElm1EOu8koiOLjk1ts2oWb8NY8dr5Gw6CxUTikt+YFvKg22PNy6wu+M?=
 =?us-ascii?Q?tB7aeZymOPk0r9zH4kCXNmlRU2Tsz4KuY5xMJCsh2/EbVD487ZjPeMQhiMow?=
 =?us-ascii?Q?8rKYw8TQwPul3AYOnOVQ7Q7VzKwfxEknREV2JL9DpVPRNAMUknDvs/DAx7rf?=
 =?us-ascii?Q?d2NaW7eMZz2KY7Zc5rZb9DrPX+HFUqjGZg6SgdT2NkMChNwQfbArol/ZtdeV?=
 =?us-ascii?Q?nFFKB/AufcqA+qKgXigvfxUhKJ6q9RdhMO0JF/FfRYtKHedGGs/heBvjJXnv?=
 =?us-ascii?Q?EgwEjbaFS6LpqSPb+40zrWr9yXKKSnKsvmjrybpVhI+keKEmu9F3aTuZiQFA?=
 =?us-ascii?Q?lo2OK0VLNez4M5uhwxT7jzVVggRZt/7yduNEGQYGdqJZ4ncTGTYCQb+tN8ev?=
 =?us-ascii?Q?JEpEufquXQ17QKtUg1ehpesXtAnVTEMlKcGHoM42l4/UqcEXk9NmJJ+J0p8C?=
 =?us-ascii?Q?/Qjm5VTUybQlb5KbkD4lpz/maV/g2Fqz4lUDCs0HyJnZmqkdCP6SxgJmKBjq?=
 =?us-ascii?Q?+k7vDltmqVwHp8x7TrMJzxILfo3/n5ecscz8z009KG4hHM4dMY6y5o55YRNy?=
 =?us-ascii?Q?1yEtd4lJZzkhG3/mVlRB+vSWjlrp8K5c/mkSg7FVEeg8nXwDOq7NzK+Y2Bc7?=
 =?us-ascii?Q?wEepNUfzodCKGEPTitUhDvwgJCfYZYYuf6pQWH/bWRI5SRexbsCHP0a/5TYa?=
 =?us-ascii?Q?Kpd2h2iG0phPCwE4+PSPzs5Pos7zcAqFYxreaxAx3mnxydezCsZ8v0/YbF+/?=
 =?us-ascii?Q?UoG8P15fQcO3nJuIU0fxTUW9o31BLQzWA3LDnikyD89RRR8weEzYei0b6AGO?=
 =?us-ascii?Q?kdKmNLxlsiTdDjjzrrCk4+TPjUrQvbQV0xpo9QSGYcEg+e7hpXXN7B6Mvyrc?=
 =?us-ascii?Q?DMjFwRyC0rwTpPXUPfiIIvUy91zT6cw2oMnb7APiCXF1SJpfQBo5PdWURUUQ?=
 =?us-ascii?Q?vQnRdXsZ+FiXwlssc/u8xwWjlGmVLDxrTtiSCbCubPYwPKHgv1tsJ7Hlrbyl?=
 =?us-ascii?Q?PKyoQgsDn58dGeAPHNDnvoknnRw9P9sNKGlcEG1/xnJGunVVu4Enjm7MAf62?=
 =?us-ascii?Q?gh6kXgiOCuMTXEgI+fD0f+Tz1xvD9qg3eIQ1mdgiOU6x3yZhJXdpVSSHz1Wd?=
 =?us-ascii?Q?JkGFd8DXaP25MduPk3yp/TCdY11cEogdyB0Y0xY57wekv3zu4xmBNRt/Z7gW?=
 =?us-ascii?Q?OM775ufP0RuO9Zy+2wZW7dAn4PwKdwm7peO/5A8fc9gtJwqeoVzRh5oslF4B?=
 =?us-ascii?Q?HugIC0xcmY3fX0EU+HzwBo9Z7HrInwvXlAaaqkHjvO4d2Uqv0Bmy+rkPye3Y?=
 =?us-ascii?Q?zhCIQEEmSFUDvfxoeZ0LmavpBJYnMo4FpoRVFwCTktQCuHCNpbMgYYFUa0ZE?=
 =?us-ascii?Q?8xm4c3aY+Sq4m/xCtCNnRtbrYREod3mTBQbTXSnmdnPBjyXprdngpMhAY6gE?=
 =?us-ascii?Q?XSIWDUNYktIXDL4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:09:28.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c08762-d7e2-4191-0269-08dd34407a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

From: Yan Li <yan.li@amd.com>

[WHY]
The source device outputs a full RGB signal, but TV may
be set to use limited RGB. The mismatch in color
range leads to a degradation in image quality.
Display driver should have the ability to switch
between the full and limited RGB to match TV's settings.

[HOW]
Add support of the linux DRM "Broadcast RGB" property, which
indicates the Quantization Range (Full vs Limited) used.
User space can set this property to be "Automatic", "Full"
or "Limited 16:235" to adjust the output color range.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Yan Li <yan.li@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 ++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f78f69a7b793..5f496002eb57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6064,6 +6064,8 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	default:
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
 			color_space = COLOR_SPACE_SRGB;
+			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+				color_space = COLOR_SPACE_SRGB_LIMITED;
 		/*
 		 * 27030khz is the separation point between HDTV and SDTV
 		 * according to HDMI spec, we use YCbCr709 and YCbCr601
@@ -8219,6 +8221,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				dm->ddev->mode_config.scaling_mode_property,
 				DRM_MODE_SCALE_NONE);
 
+	if (connector_type == DRM_MODE_CONNECTOR_HDMIA
+		|| (connector_type == DRM_MODE_CONNECTOR_DisplayPort && !aconnector->mst_root))
+		drm_connector_attach_broadcast_rgb_property(&aconnector->base);
+
 	drm_object_attach_property(&aconnector->base.base,
 				adev->mode_info.underscan_property,
 				UNDERSCAN_OFF);
@@ -9978,7 +9984,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
-		bool abm_changed, hdr_changed, scaling_changed;
+		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
 
 		memset(&stream_update, 0, sizeof(stream_update));
 
@@ -9997,13 +10003,18 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		scaling_changed = is_scaling_state_different(dm_new_con_state,
 							     dm_old_con_state);
 
+		if ((new_con_state->hdmi.broadcast_rgb != old_con_state->hdmi.broadcast_rgb) &&
+			(dm_old_crtc_state->stream->output_color_space !=
+				get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state)))
+			output_color_space_changed = true;
+
 		abm_changed = dm_new_crtc_state->abm_level !=
 			      dm_old_crtc_state->abm_level;
 
 		hdr_changed =
 			!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state);
 
-		if (!scaling_changed && !abm_changed && !hdr_changed)
+		if (!scaling_changed && !abm_changed && !hdr_changed && !output_color_space_changed)
 			continue;
 
 		stream_update.stream = dm_new_crtc_state->stream;
@@ -10015,6 +10026,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			stream_update.dst = dm_new_crtc_state->stream->dst;
 		}
 
+		if (output_color_space_changed) {
+			dm_new_crtc_state->stream->output_color_space
+				= get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state);
+
+			stream_update.output_color_space = &dm_new_crtc_state->stream->output_color_space;
+		}
+
 		if (abm_changed) {
 			dm_new_crtc_state->stream->abm_level = dm_new_crtc_state->abm_level;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cecaadf741ad..4c798236d614 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2834,10 +2834,13 @@ static enum surface_update_type check_update_surfaces_for_stream(
 		if (stream_update->sharpening_required)
 			su_flags->bits.sharpening_required = 1;
 
+		if (stream_update->output_color_space)
+			su_flags->bits.out_csc = 1;
+
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
-		if (stream_update->output_csc_transform || stream_update->output_color_space)
+		if (stream_update->output_csc_transform)
 			su_flags->bits.out_csc = 1;
 
 		/* Output transfer function changes do not require bandwidth recalculation,
-- 
2.37.3

