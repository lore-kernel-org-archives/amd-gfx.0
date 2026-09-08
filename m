Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C490C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C1610EB1A;
	Tue,  8 Sep 2026 11:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbAFyw5F";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A4A10EB16
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2iH983ntgNTclx9MJ0U2gyEk2NSvTg9C2eevf8KdZswZjzlRhgV2xL3h+IIfaemhPqddkhihfr+teukR2iwisBALzDxfaGSG0uDvZp1pE9ztQi7QlwrUA+fXdtr4ZHrGWw1CfKpKWQKWNUYNiJNDkCqQApw8Ma15ArMsh9kZQMFXGZw/GR6Wu1C8slDtPGYG4d3BvgEaOwqsPHnNn0t4bnWNdlIPryvyCDE6AlaJKR2W5zjoKfZlWYKAxuae5l86O35fb8ZTt5uyWdZ1QG4gMGWV+aVQLmXaFcjlMonS6yNBzqxDREt0eo7PfLveGAHAkf4vyxHfn3/Elxv2mj6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ki1MMrP1elVnrwTNEP2Y6q70MmDOBavUPwFcsX5fY8=;
 b=ULvtalWsPTkFDCYPwT+YE47/Obo1d+z7fQo8PHgTowWBp5pyYlHfrePJfkS9ovyaKyU5VemZLYtNfDPbW4fZhbmVXrzNncrq2i1WS20PVAdKgF+DFvWE2bQ+v+Dp2+i665i3ZCHMN5XQKL7W4D3SETeSWmPinWmWkgikh0mnKJaJckkkTYm+A6wx47dU03EWbOYvKQYBRLkX+0queU6GvKfinPz6oTxVMUY2eSNeEUGbJJDb6hhtGVFKCRAsOCCQfTTI2bCWxqsGh8iZMvhfLuWiNdQmcLKOwXG0kVZOcOXFvKA+PZnWBMHCdeLHdZ0bnND2/E6HEyFoQWI9dii0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ki1MMrP1elVnrwTNEP2Y6q70MmDOBavUPwFcsX5fY8=;
 b=dbAFyw5FQRdbM3LkNstgN52u12qNEHcZtVlYZpdAlarTRfilplu31O6rLHDrrzfZ35DC24E8L++vmuGh3YWBtJpTnmKXNlVbF6JC7km6cz0gYxCvWZsSK6asK7/AhbE4TASdL/D25HaFyalDqhlWvVH6OJuaoORPGYug9UI0uKg=
Received: from DS1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:8:44f::18)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:41:25 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::86) by DS1PR04CA0013.outlook.office365.com
 (2603:10b6:8:44f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:41:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:15 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:41:01 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 48/66] drm/amd/display: Send stream_update to DC only when it
 changed
Date: Tue, 8 Sep 2026 19:31:41 +0800
Message-ID: <20260908113338.2433445-49-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c47dfa2-b07e-4d93-b978-08df0d9e1cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aXonz1byRz9kEErrwrWFjZO536IRjDIxos+Eff5pL3MW911d+nwF4j81qiY1YNZLPTP/JSILRhTDYfR6+XbiUXw/fNtDH+dQXRn7j6gI+h2Nl4NTay6DRN7bVogciQDK5Wg2Ygf6DxXR3kkfR/1cXGDIW/0UgHNd4zKL+18NH6jCPeriwby+9w7nv0lsOVUrFs1NFYdLD+P/QpIh2OcknCf1CyLq9Hx0F0qqaOb6HjUKiNVSZmTxCni1aDfi4hA04oPhBIRXT+qDEycbdqZy1ragkWmbidlstIEFmlPVA3AIJauliwIbXs8elfYS+FW7zCfrmgl1qVEvYQpwkDpBtKQq/gqUXCUnvKYZjgGPp+aOWxG+6Xh1RQuJkv9jPf7eYXSktjT4dCSMTmfy024bnALWwQp13cz8bItKj9gMyj+tiTlihWSjQpso2GSax80CJqgP15H1iEjyXv0GHzjEqY3tgKxmkUEbs6fBza1KlrZmFPl5/ukFdt8L7UGxTg57u3ZqH9gek6+HJmxOr8zdWBu3ykzsLQEuMWb0iagiGy9hTNJHWYjyE+qPvHxkY7XUCEM63puVc6fyL802fia02ZZ+KzHTcQ7Ck4YQQ4wqR/+dh1uKuuYFhG7TuDRhExtZ/J/6QUWR+jSa1ArWBUF03SxL+WSanYq4blD8mIVTOpD5bvoLfrh2OsggvEU9ifq+FP8UuZnfRoVSUKBcucyHbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: boZHbs3sMckeMZ0mjPcnrwY3zMgBWvyLL4CnBXkHDQKph9i9B39FE3JoQSbxZFSUgOssJJ2APsIgSzuL+Lr5H82Gpq8SlCUD/lZ1iPn2YeEJPZGd99kp2hFWZrF6G/IGPsUNQxSKOXb4S6mc7ZUpmQNe8qp5HhKh2rf3xeevZW9870xycXPASYeNL17kk85WLXsE5DB+DZ05X6nl/MsK+hm2Q+QUWedAYhXk6fP5udK4PzbXa+l9Lm5ApbRQBdqUcyGVaSeJp9oEfa8BcrYPQ1kxhDGBtLifzUh/NzJ27x1zssnV4VCh2slJZ7zdlrQ4ArKM+WMuwWRpFyjNkXDsvYqVLMcE/nyk5tNOHuFoi4Tz/DPctQFKybhjP4J6j+nhE0tWouBFxcZUcMEwa0IFxKX0IB6k33sKxz4OBrgRkeqpVeu4sTU5kgin3u7QQA/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:41:24.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c47dfa2-b07e-4d93-b978-08df0d9e1cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

From: James Lin <pinglei.lin@amd.com>

[Why & How]
Track stream_update_needed and pass &bundle->stream_update to DC only when a
real stream property was actually written (native-cursor disable, cursor
position/attributes, VRR infopacket, modeset src/dst, color management, ABM
level); otherwise pass NULL. An address-only flip then carries no
stream_update and stays on the FAMS2 offload path.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 24cd21a39690..301e09e60e75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3885,6 +3885,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 	bool flip_latched_during_prog = false;
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
+	bool stream_update_needed = false;
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_plane_info plane_infos[MAX_SURFACES];
@@ -3918,6 +3919,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 
 		bundle->stream_update.cursor_position =
 				&acrtc_state->stream->cursor_position;
+		stream_update_needed = true;
 	}
 
 	if (acrtc_state->active_planes == 0 &&
@@ -3941,8 +3943,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			if ((fb && crtc == pcrtc) ||
 			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
-				if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0)
+				if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
 					amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
+					stream_update_needed = true;
+				}
 			}
 
 			continue;
@@ -4149,6 +4153,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 					&acrtc_state->stream->vrr_infopacket;
 				bundle->stream_update.vsp_infopacket =
 					&acrtc_state->stream->vsp_infopacket;
+				stream_update_needed = true;
 			}
 		}
 	}
@@ -4183,6 +4188,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		if (new_pcrtc_state->mode_changed) {
 			bundle->stream_update.src = acrtc_state->stream->src;
 			bundle->stream_update.dst = acrtc_state->stream->dst;
+			stream_update_needed = true;
 		}
 
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -4200,11 +4206,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				(struct dc_3dlut *) acrtc_state->stream->lut3d_func;
 			bundle->stream_update.func_shaper =
 				(struct dc_transfer_func *) acrtc_state->stream->func_shaper;
+			stream_update_needed = true;
 		}
 
 		acrtc_state->stream->abm_level = acrtc_state->abm_level;
-		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
+		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level) {
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
+			stream_update_needed = true;
+		}
 
 		/*
 		 * If FreeSync state on the stream has changed then we need to
@@ -4223,7 +4232,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 					 acrtc_state->update_type,
 					 planes_count,
 					 acrtc_state->stream,
-					 &bundle->stream_update,
+					 stream_update_needed ? &bundle->stream_update : NULL,
 					 bundle->surface_updates);
 		updated_planes_and_streams = true;
 
-- 
2.43.0

