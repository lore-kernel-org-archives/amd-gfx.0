Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A11DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 20:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04B510E9FB;
	Fri,  9 Aug 2024 20:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nappxuP2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A9E10E9FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 20:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb8PWjDr0xddh7GrDYoiCaGkmZY0FmC4/XjdhnKDdxpeedGesEbLqtXQjxozjL35tNk2lFkAk1FrqdqRFYA82Xj2k7SPguUWFqpcfDhtjkHTb89Ux1oFomMvHrDjXyYfb2wWf5h5iJlHX0EsiUbi9prdQauSKMCG0vQrLR7H3PdNxUsi0NjZdCJ+MBdfhRPMY0jLanJaeR4/WMplHsqJBVxO4tYRU9G9DHgHS4pWNbLSvzHRWxSrOQ8i0PdJdYQHgOiK1LRYeCwgsrkMxS6DjdRI61GzHfhW6b3Ux04x1GYi7fK7ItLSvcfHUhoR4+sy/tfW4O2pszN++pH/pSsGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSgvWGZU0fn4c1qHoTMH9AKXo85qosr1N/Idcx1miJg=;
 b=JcKZiLt4TuRnekr1jf5HmR6+jlkB0h5k8bYQbw3+nt97Ymkgc8qWd6mu3hFmQhsBbFT8jdsJR/tjRUDH/X8JqRT7ZFHjb/04SotRG9QZdMNFI358Ph0vWeL7m5cztxKcBxcRVA2qod2R/7NCSA316ahAA7DZNd+gvyerDC6MetL+XqjhUnEN9abE4qRtAvI2gdNNNxHIUMm9IJKzd2oCqAyDuuDwxEypvOXwV2To3GXGDEdfB8JS26mOSYroll82iRDejHF9mal5cq+slxsrZwF3wVbI3be5JJ3jHcpTCW1MFLNupckwXF9mCJ42lDrJ9KIiRjvJ4wVgAz2P7lojTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSgvWGZU0fn4c1qHoTMH9AKXo85qosr1N/Idcx1miJg=;
 b=nappxuP2OBG8Dnwzc6zTGhhKAD6Iw194Hr2cZB5xnUXvkf6iqpeVmKLqgAgRro8orTBv2iLRKcmeL7l04U9kj+C8g6ros2+B5X8wHmBQ7pnRgywhNougR+vpKmnN1qVzEN40P+k3xuLdY4u3IoETaUXm+qV0r9MBxUxdMtgcA7k=
Received: from BYAPR07CA0047.namprd07.prod.outlook.com (2603:10b6:a03:60::24)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 20:43:18 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::89) by BYAPR07CA0047.outlook.office365.com
 (2603:10b6:a03:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17 via Frontend
 Transport; Fri, 9 Aug 2024 20:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 20:43:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 15:43:14 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Sebastian Wick <sebastian@sebastianwick.net>
Subject: [PATCH] drm/amd/display: change the panel power savings level without
 a modeset
Date: Fri, 9 Aug 2024 16:42:53 -0400
Message-ID: <20240809204253.317856-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: eb822bde-1da3-4cd6-9abf-08dcb8b3e642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LXgbLT9oS76hajdCJSA3N8x1GChjnX4ZhhPS0kTmxJvP0+KToeRze3wIiJ41?=
 =?us-ascii?Q?NpNEBbzokmVTxklQDCV53b+eEdindLX5FCWYTQMtE/QMdJ6QbhQnKCQc+4VH?=
 =?us-ascii?Q?9k3bkhNal6cihVLJmmxV4knrw+gLCaGQyCBKRW/jju326cTYU+wiA5qZGPT9?=
 =?us-ascii?Q?RFRKJ3+fB6uaGBE/FznAXep9KfRilC0c5f0kKzdWRSbf/tZGoiu/EwrjNZZ4?=
 =?us-ascii?Q?rfEjH2j6j3BKXR8hThtS4XZQoLdVD/0FijkxmdyONSPERSd50mp24k9fg1Lk?=
 =?us-ascii?Q?1Mk18xoLwh+Nh7rwIZIgJx6FXijCI3q2BDXqOK3VMdeXsX7Q+JlL5zTM3F/8?=
 =?us-ascii?Q?IMJoN+qEeP43HE+u3PBpLQ9WV77FaxwZ1xmjOzMQDo320RcY/whA42SK2DXR?=
 =?us-ascii?Q?AslUJOtaVYpxhONOMH9vSYDMHvWfowSyju8b3DtM32sU91fbp6KejKRsqBDg?=
 =?us-ascii?Q?0GlNHyewhEMyqXGCuzgpJauDFWvESXoY0BuuiXOGTgeZzcUrJjLUdT7zxKGN?=
 =?us-ascii?Q?lPMVpHWzMIoe2z/icFzLw9robeSGXl5O3941W1hpY2yqrWUUOfA6fv3Q0B7/?=
 =?us-ascii?Q?9jaD0CPul6GqGZizyAfZUmHvfX6oJIa5E1IUFfKI/zPF5YVAggkgpD9MYfie?=
 =?us-ascii?Q?qe41Vrc24MD6B4c8lMGRlvhKaOLddGtkyv3AEXNYzgd5CuzmBYd8LkOf0PKg?=
 =?us-ascii?Q?iXUutds2v+MYxWXOOzVX4lyYPBrj0cEK1TQd5XXHWEUPAo2i+q0noCAKpvc9?=
 =?us-ascii?Q?wT0GjkJ8Cfn+ID9MyP4lPK6iguZ7AVK/sLDcASdg+IcPjszc5+sVoqCniFN3?=
 =?us-ascii?Q?TwtBoa3hviAN1uK9PZjFHExW+s6jGCqYF1b5UEEJP6GMXzABcllJNK5NEvgi?=
 =?us-ascii?Q?7MUPUyVgWtrqTQjtvM9BtBgDMyr9GRujzre4pYAnrX+tH1syR7ijs9RoUkWb?=
 =?us-ascii?Q?Ooyzq/6htaQGIWqTbfs4dpYDKq4JEeNj9P3fwHRyroSrs/WvoyEwBCdsE1QF?=
 =?us-ascii?Q?6I6inLR2ht0mKzYnSOicutkyOi1qy+AdTKvawKJ6repWpycUKWqKDmMEclI5?=
 =?us-ascii?Q?xN+oa+LTwgLAT93XIfl9YeINdd3rrNDww4zIx8Cc2ucJnFRRBN6w0qcxSC0q?=
 =?us-ascii?Q?unDNq7k2Ox9tTdBaHceTJwiEcps8kXkhOe0MDpVG20NrTW2jQoOKUSiO8ner?=
 =?us-ascii?Q?2bFBJGfVClLBfbg84PYndhKfzG+ZUvmi6SrKavOFbAt8lVrMAqOqf9v6q2Du?=
 =?us-ascii?Q?JD0VhZ4wlL9UrHXCzWn/btAghzsjyWrxr64u7mekTC3QL7ZuVNbAprTgb4KE?=
 =?us-ascii?Q?kDluxF2icWv+0tKykd0XNAV/PfZ/Nd3PBKgTZj4jyiG7GEzSkYq5ueIfZszk?=
 =?us-ascii?Q?j6MQmhVGJWawAVQk67sYxm3rwvhmTbvQOFvApQs4chRMRzQYznCBaEBJOCOh?=
 =?us-ascii?Q?FxaT5mKU0VnOe22fOC1ZpRce89n/j0PV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 20:43:17.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb822bde-1da3-4cd6-9abf-08dcb8b3e642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

We don't actually need to request that the compositor does a full
modeset to modify the panel power savings level, we can instead
just make a request to DMUB, to set the new level dynamically.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sebastian Wick <sebastian@sebastianwick.net>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 +++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 39 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dd8353283bda..00a8a5959aa9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6819,9 +6819,14 @@ static ssize_t panel_power_savings_store(struct device *device,
 					 const char *buf, size_t count)
 {
 	struct drm_connector *connector = dev_get_drvdata(device);
+	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = adev->dm.dc;
+	struct pipe_ctx *pipe_ctx;
 	long val;
 	int ret;
+	int i;
 
 	ret = kstrtol(buf, 0, &val);
 
@@ -6836,7 +6841,17 @@ static ssize_t panel_power_savings_store(struct device *device,
 		ABM_LEVEL_IMMEDIATE_DISABLE;
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 
-	drm_kms_helper_hotplug_event(dev);
+	mutex_lock(&adev->dm.dc_lock);
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconn->dc_link) {
+			dc_set_abm_level(dc, pipe_ctx, val);
+			break;
+		}
+	}
+	mutex_unlock(&adev->dm.dc_lock);
 
 	return count;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3ba2acfdae2a..60081cd978b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3319,6 +3319,23 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 }
 
+void dc_set_abm_level(struct dc *dc, struct pipe_ctx *pipe_ctx, int level)
+{
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct abm *abm = pipe_ctx->stream_res.abm;
+
+	if (!abm)
+		return;
+
+	if (tg->funcs->is_blanked && !tg->funcs->is_blanked(tg))
+		tg->funcs->wait_for_state(tg, CRTC_STATE_VBLANK);
+
+	if (level == ABM_LEVEL_IMMEDIATE_DISABLE)
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	else
+		abm->funcs->set_abm_level(abm, level);
+}
+
 static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
@@ -3447,22 +3464,12 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
 			}
 
-			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
-				bool should_program_abm = true;
-
-				// if otg funcs defined check if blanked before programming
-				if (pipe_ctx->stream_res.tg->funcs->is_blanked)
-					if (pipe_ctx->stream_res.tg->funcs->is_blanked(pipe_ctx->stream_res.tg))
-						should_program_abm = false;
-
-				if (should_program_abm) {
-					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
-						dc->hwss.set_abm_immediate_disable(pipe_ctx);
-					} else {
-						pipe_ctx->stream_res.abm->funcs->set_abm_level(
-							pipe_ctx->stream_res.abm, stream->abm_level);
-					}
-				}
+			if (stream_update->abm_level) {
+				dc_set_abm_level(dc, pipe_ctx,
+						 *stream_update->abm_level ==
+						 ABM_LEVEL_IMMEDIATE_DISABLE ?
+						 ABM_LEVEL_IMMEDIATE_DISABLE :
+						 stream->abm_level);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7873daf72608..134ef00d9668 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2494,6 +2494,8 @@ void dc_z10_save_init(struct dc *dc);
 bool dc_is_dmub_outbox_supported(struct dc *dc);
 bool dc_enable_dmub_notifications(struct dc *dc);
 
+void dc_set_abm_level(struct dc *dc, struct pipe_ctx *pipe_ctx, int level);
+
 bool dc_abm_save_restore(
 		struct dc *dc,
 		struct dc_stream_state *stream,
-- 
2.45.2

