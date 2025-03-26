Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B280EC36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8F010E1E1;
	Wed, 26 Mar 2025 19:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbBs8hIX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F6A10E786
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ7eTAe8foK3Su4DJwp9mngJy7ZIxJuU6yNzlamTTQlCuFSkAhA+PbpeFsVw0eorAwI/C7IiK+zcYhOOkUbmxwifeHocTeBSYRXXTsyOmnSBYjlAJaUXYbEEeTcZx3uAXKnlvbWpNK9HubumYJK7XWOsy5OqGwRi41yNrBT1KFebr7QOZuLMP2jOce3RHuDZ31lqg1IH9U/TEwJU56xcGSxXFe5AeNQG6QrLJxASQ5SCfZbyB9NsZSXOjJrGCe6FwAVOXUyaAtNhgtBWdH38WHQzl40KbYgOmjyAZrWqPYqFQPbsYCD8xko4fkWeHRbEmjw9Bd7wMSbYVE2FKzj9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqGz6bKGmZWHM8IEA1qAHPiNU2nlnCczqwUqkxVEjLg=;
 b=vkykxYsgArrOrKTsYilBXCO5leypkzB5smSA7Ucg+Socp+4RAd3YjI92GpSZKwcKO/we/Pruvu5E9XNvBJwZLN4AdUC03f9A1ARDwxtO0duzuMfEZ88dHPhxWbnevxAogfGlET3E6hOi7QGQrHXC96rryZDYhzjuj/rMlQ8ak8d/0ZFZHzK69ofhvdWZ6x2zRGVcjd5ERFXsQjhyqbPUJoWHHWvEzHcGMUF7e9QDAkoCxs2eibEJs5s95H6SPhS7Qp1+h2/J9GYeExe0kWToVUrtsI/10/l417QvLIRhDK3iSFF7FNLzgKpb6ToqCJ9wpw2mHMk2b8Cd0KPyJvxvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqGz6bKGmZWHM8IEA1qAHPiNU2nlnCczqwUqkxVEjLg=;
 b=PbBs8hIXEbBongV9r6WmAbVwxS9RiIrs3dezPtg7ajssT/nrXFtRzIWuMGQdUojspTmu0vF5hI3DGWbrkngGGg9B2lRUBEIayYexW/yw4dTyyKcDHpxDxsH/Sd6kGYNWpjCAdMz3V4GVMCzmoZNE3TBIgfCcxWJtUEzQRedurcs=
Received: from SA1PR05CA0017.namprd05.prod.outlook.com (2603:10b6:806:2d2::20)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:28 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::d2) by SA1PR05CA0017.outlook.office365.com
 (2603:10b6:806:2d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:21 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:21 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <dillon.varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Fix VUpdate offset calculations for
 dcn401
Date: Wed, 26 Mar 2025 15:49:12 -0400
Message-ID: <20250326195202.17343-16-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 02478eee-3638-453a-924b-08dd6c9fe07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UwJAgGL4PZiDiGOfFdoWf/TcaNtLaPcFY64c4jlxmJbiR48S1cGiIyLW4ld5?=
 =?us-ascii?Q?NzWJweE4y70j41GQO+iJ5QfIEeUQ83xFc5/iFt4Y82nLykyaFZ8/UFonctiF?=
 =?us-ascii?Q?0KHGTB9jXvyrPmaZmGmOzDPAkD7cpEHA5i+wWy8YRM+iWBOYJmxGJ7Antwvd?=
 =?us-ascii?Q?Ocl0I4oLlIaH8d2sXdHlcjo7DTb319/vdMHyo33S0QfS8o9mPFxWt1VvGxgQ?=
 =?us-ascii?Q?CbEbVbDAWlgF+WeLFK1QT3a0yTD/5tYYiSdUknr6hkcjhuCfxdsVGEnm6XrZ?=
 =?us-ascii?Q?0i4kbucHd98BPWqUhgtXYnHtopAV5IIh86vCmqZ+ubLqiDw4n3w7sWo5cmu8?=
 =?us-ascii?Q?EczZQKqDAxsB3srPWhio+7qLkdiQYVHtTcU7GZF6bMKYc0z1u5X/ZQyM3gYz?=
 =?us-ascii?Q?4KGfpNVP6DY9joZlMRpZ+awt1c5vR1pRAtQzBlYdri/Hb19VDyUVjLPi6QP+?=
 =?us-ascii?Q?ggUCikjvaY+z+oxqcMv/e82q3l0yrgXCp30Uc551mLXgHygl+TiF/Owj1IYb?=
 =?us-ascii?Q?gPA0kQZ3PVx1KZh378I5UFUvr5OykAJ9n018CcE8DLQCmEO2ib3K5GaSuu/H?=
 =?us-ascii?Q?f8ZLnEOjKrSgvvfC6n6colz+9u8I2py9a6ugjWSgZwNcwipFl6vprF8OGl/U?=
 =?us-ascii?Q?Ab0S1dRumnkyc0be0oCZ/W+ujpgkB+pv5+3sLAHMJnSqhXy30F80hSe/7VOU?=
 =?us-ascii?Q?AIxA4xagQquIn0YQ9xv6DUpO5Dl/GcqhZXcCAaAs3tM0Nz/HhvJSkc39wnX5?=
 =?us-ascii?Q?yl/pG//O1K518hrOXiCMDLlLc4dqGStyAZNrvbgBEp3BlpA9VUCyICYl1fYM?=
 =?us-ascii?Q?EaW96LyyKrPJ9Uu1o7vfs2vH5D+CQl29u2fVG2BN/mBewLX4yXGqtQa0PBhd?=
 =?us-ascii?Q?8E1u0KDbBE/p1bRzZ6FW6c6zoiQeY17XWjZzd3tXYIQ5dmA6GbKKzsalp7Nb?=
 =?us-ascii?Q?Gi9h+2Z2EUHrHtVZJdq92Z/2f/2GzqhogdCJ+p83prFX3c7YLqBYmZQFw6ws?=
 =?us-ascii?Q?VgkI1ysj4hvLtARJ4adfh0TwXEWRjEiG06yEFOhkIMkBefow0E7AUT2t9rr0?=
 =?us-ascii?Q?UpnKTcmro9ductZx2/xiyTjCW/9QtU7kGVWLdVFTs465XRCVed8+mTo6be79?=
 =?us-ascii?Q?pF7fxIpaUVRdwp/iMT2OzZuCUTwawp53uxpC8kf/fOFAxUcL2wetw+jhCrPF?=
 =?us-ascii?Q?qvtkkaybaWHLldE+DP1FFKQvLwmnIpGelOKIlPeE7GRfJqj167boX0dQv4mH?=
 =?us-ascii?Q?ve9qv75ocKH299Nqt7w5EgmVOJc+pa9qge/9Z8Ax0dbAtUbvxR/aG89oG3hH?=
 =?us-ascii?Q?YHN8ppJxfQgYA1TH496dfjtDgzhefV83Q7tYsJg12cSl2RMASzXHcWMVxQqW?=
 =?us-ascii?Q?+VHfl2ZBAnIHujTpygev3gSjV28GXvSnb6OR3auw4giuXNOCBspso1rn7k+J?=
 =?us-ascii?Q?k4KuLMe6V9aD+IZenKQ9Gsu+hYUH4jEbdgWD09CPSTEiAsYGr9yfD2qaYQ7j?=
 =?us-ascii?Q?Y83NPDiqF1czjf4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:27.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02478eee-3638-453a-924b-08dd6c9fe07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
DCN401 uses a different structure to store the VStartup offset used to
calculate the VUpdate position, so adjust the calculations to use this
value.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 44 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5489f3d431f6..79f4eaf8fc52 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2646,3 +2646,47 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
+
+/*
+ * apply_front_porch_workaround
+ *
+ * This is a workaround for a bug that has existed since R5xx and has not been
+ * fixed keep Front porch at minimum 2 for Interlaced mode or 1 for progressive.
+ */
+static void apply_front_porch_workaround(
+	struct dc_crtc_timing *timing)
+{
+	if (timing->flags.INTERLACE == 1) {
+		if (timing->v_front_porch < 2)
+			timing->v_front_porch = 2;
+	} else {
+		if (timing->v_front_porch < 1)
+			timing->v_front_porch = 1;
+	}
+}
+
+int dcn401_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
+{
+	const struct dc_crtc_timing *dc_crtc_timing = &pipe_ctx->stream->timing;
+	struct dc_crtc_timing patched_crtc_timing;
+	int vesa_sync_start;
+	int asic_blank_end;
+	int interlace_factor;
+
+	patched_crtc_timing = *dc_crtc_timing;
+	apply_front_porch_workaround(&patched_crtc_timing);
+
+	interlace_factor = patched_crtc_timing.flags.INTERLACE ? 2 : 1;
+
+	vesa_sync_start = patched_crtc_timing.v_addressable +
+			patched_crtc_timing.v_border_bottom +
+			patched_crtc_timing.v_front_porch;
+
+	asic_blank_end = (patched_crtc_timing.v_total -
+			vesa_sync_start -
+			patched_crtc_timing.v_border_top)
+			* interlace_factor;
+
+	return asic_blank_end -
+			pipe_ctx->global_sync.dcn4x.vstartup_lines + 1;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 781cf0efccc6..37c915568afc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,4 +109,5 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
+int dcn401_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index fe7aceb2f510..aa9573ce44fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -73,7 +73,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.init_sys_ctx = dcn20_init_sys_ctx,
 	.init_vm_ctx = dcn20_init_vm_ctx,
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
-	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.get_vupdate_offset_from_vsync = dcn401_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
-- 
2.43.0

