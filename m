Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA0C109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D809D10E93D;
	Thu, 26 Mar 2026 03:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="atCRtUEy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68BA10E93D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6zIkLuuEr0jJwbWITV9RnEtb8oPpmgYgqS4GPryUh9P19vxuESby70sKKBts2JkoiMIpkPSHLzlmfDai84wMmYHkKwFFz6bNvoq7mynhUktVlgnQYKY/8sFqiC8fGEdo7MHtfSv1s2Q4h3e3yCgc+daf1ZtCTPs3wxfB2HsrF+DWfoNuClZF0gXo51Hwuin60lZ25RGLiwYOS0uItJrOlq++/5bCe4lcvJIJpdVhY4Q5r/YWF9wQnFZgUHtBgThOus5Insdf0witIDDuJKLBuFIqCIp8rF/jqBPWR3WJP/tGP+cs8jHdZdt4tJop2EVOU2rN8BGfCpChoU7DIO7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILNbdBzAKeWodQ+Cmfxmaad38i6dXbBAWozaAzujKPU=;
 b=ppfSW0KxIVopuytbfvnKxJY8aX5rkvQDnK8Ja/Xz4QVh0loDcqKWm3+F7ZDV1FK0jEob5hRkgGW/vqKJpWg4mTJHNJ6tGyzqEM3bkteH7mMMaw6FFL7k8lYRVzVDdi02XxOETiD+n5pcrK1rp9pHN+asBu0iD807rlS5iFE/cVsnf6FAYhCSv6gCqEXDwgN0OTCUqYU9I2fk0IHYMXAiIDn8b8f/SHveVmNhlR0x98/M+Apmw0bDQ2Bp+RXibcEbJ2oLEyQcZvO9OQFJV/IVhtCXabhsszw2Ecdd0fjgoTazxTxXekcHoYU2gUFTVlL1YBM4tntlOiay/GJ5QQ6CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILNbdBzAKeWodQ+Cmfxmaad38i6dXbBAWozaAzujKPU=;
 b=atCRtUEyCsDDqkwox2jPoCJFv5LPv+JhpwPhRxq16D2Pn8rVd3vZj+mX0NmSB2aCftb80M0s+DsWSvztZVaTDEqlFQnd6bLBV/NEMzxT+AlSmNWlwIz/BCCRIYalwlf0fy2YEcHAq/Ue9YcC23MZjyQAimrK4MvZzKJgE/K+gMo=
Received: from IA1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::12)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 03:01:56 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::4) by IA1P220CA0024.outlook.office365.com
 (2603:10b6:208:464::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:55 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:47 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Martin Leung
 <Martin.Leung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 21/30] Revert "drm/amd/display: Refactor DC update checks"
Date: Thu, 26 Mar 2026 10:57:12 +0800
Message-ID: <20260326030153.406612-22-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f565aff-64fc-4fed-6e92-08de8ae409fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KL3nhLyOEV7ypsYooSKPAGoqVRSXVCSC2anOTik7AkdsoPNqf3knOhSY1aPR65Vpz17kF4eLuealVrsbHpReglH3WO9oGqz51Da4qZRhRDir4HsvEyVeiK3CL7ZVEun+G50598Eg3gA+9xF4IHB5zJuNDyn1zWTp00wB4fnSz7jKEsDmXsvXtBk0ZYdS5w6Y7t36MCIwjoVxaUyZGyW1nMvyP97Yl1axcGCyNtZyJTbJh6baEO4TvtLbIf5YWV+Ow8gXqY0ltyF9rqD15pUss72OeVl0Y4Sh2b/d8qhBweLpwp1IDFkyDnnsJYjzYMU5PyaJ+toOtqQWlUgbtol79L1kio/3kv50ZegQAo+LDz7XbSspZL/Xds4b9fx3RXKSQmRZbwLhV7OqOKPzeuvzRm4dxXVpiydBSza8bGNRv5zsF8QOecN85AF1Fbk/DCIgHOUHSw8NVK0Vm+OSSYVq24XxmbomBbSs8SlPWPeJb0NsGIG8+4h+2uDvV4WbN6DmJdBZA5fgl0sZxkjpPt2VB/Hrb+/x1v890+eyVdPzeCpIpP9gv+4UWcfsEFSaEMB7riIYiH2+afo3V53fZdAUxWJGRoCvf+sxGUk80Bjrsnk7zfp13Fbc3xCE+wJzJqcJgxEZp3gr3JzpNyHu7eRR7FIo377hVQ/nIC/47oW3D422obZPKB8gNebYli5JIgBcLMuEtbOCmYHfnV+eZymBFPsqYRlYvWMJLP/hAeAtTezz+YbgxaFQ4YCFYeVIa6Uh6kTtqmYMQxJU3yXkfcoWjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iEV3AGvGr/r8NwGp2lrH6jWvKSzmOUGl4uOIHr3AGkrox0DxdqVt/c3KYdFg2mb3JuYv3ZLDHsvCgZO84ABGhdCLfxokzOKSKNmv93cJPFxGIQ2Retmve6Bd8yYfnwKVzWpYVofXNFXZzRMplRdhduYZ7Z9y7aKndEmHS8s8ieBnZ/n1kPXErDSr5dgSdgTzKJKslAPrC/UYkGMQtRyuHomP7e6sOfsZNXEM4EEosOX+HWq01P+rMrCuxUyHWvwKzgNqhVNrcJWB/TIGLYw9H18wfe0PD0m0ms3P97E7uuuvWD8pfNwLWT18EyzFzp13jzWCQk9vU0/eUNiaS9xwJODdGfq1OI4ckuUpmIu9h87PaHJNTs/3Q4WEQaB/PpAyX+cq90474hGcZYjgJawOW0YwtLSu1MUUtej+6zACXy4Evf1Sog6NygmmuTjNN+dx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:55.7613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f565aff-64fc-4fed-6e92-08de8ae409fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602
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

From: Dillon Varone <Dillon.Varone@amd.com>

Revert commit 90fe5f44136d ("drm/amd/display: Refactor DC update checks")

[WHY]
Causing issues with PSR/Replay, reverting until those can be fixed.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 482 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  22 +-
 4 files changed, 308 insertions(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc1127aaea9e..ecd0bdc0fd26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9886,7 +9886,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	}
 
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
-	if (acrtc_state->update_type <= UPDATE_TYPE_FAST &&
+	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
 	    (psr->psr_feature_enabled || pr->config.replay_supported)) {
 		if (aconn->sr_skip_count > 0)
 			aconn->sr_skip_count--;
@@ -10094,7 +10094,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * fast updates.
 		 */
 		if (crtc->state->async_flip &&
-		    (acrtc_state->update_type > UPDATE_TYPE_FAST ||
+		    (acrtc_state->update_type != UPDATE_TYPE_FAST ||
 		     get_mem_type(old_plane_state->fb) != get_mem_type(fb)))
 			drm_warn_once(state->dev,
 				      "[PLANE:%d:%s] async flip with non-fast update\n",
@@ -10102,7 +10102,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type <= UPDATE_TYPE_FAST &&
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
 			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 50f2fb704539..39fcbc3e702d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -685,7 +685,7 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	 * pitch, the DCC state, rotation, etc.
 	 */
 	if (crtc_state->async_flip &&
-	    dm_crtc_state->update_type > UPDATE_TYPE_FAST) {
+	    dm_crtc_state->update_type != UPDATE_TYPE_FAST) {
 		drm_dbg_atomic(crtc->dev,
 			       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
 			       crtc->base.id, crtc->name);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e0eba1bf2dde..e55ffdade662 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2762,7 +2762,7 @@ static bool is_surface_in_context(
 static struct surface_update_descriptor get_plane_info_update_type(const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->plane_info)
 		return update_type;
@@ -2854,7 +2854,7 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->scaling_info)
 		return update_type;
@@ -2905,11 +2905,11 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 	return update_type;
 }
 
-static struct surface_update_descriptor check_update_surface(
+static struct surface_update_descriptor det_surface_update(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *u)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
 	if (u->surface->force_full_update) {
@@ -2929,7 +2929,7 @@ static struct surface_update_descriptor check_update_surface(
 
 	if (u->flip_addr) {
 		update_flags->bits.addr_update = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 
 		if (u->flip_addr->address.tmz_surface != u->surface->address.tmz_surface) {
 			update_flags->bits.tmz_changed = 1;
@@ -2943,43 +2943,27 @@ static struct surface_update_descriptor check_update_surface(
 
 	if (u->input_csc_color_matrix) {
 		update_flags->bits.input_csc_change = 1;
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
-	}
-
-	if (u->cursor_csc_color_matrix) {
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->coeff_reduction_factor) {
 		update_flags->bits.coeff_reduction_change = 1;
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->gamut_remap_matrix) {
 		update_flags->bits.gamut_remap_change = 1;
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm || (u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->surface->format))) {
 		update_flags->bits.gamma_change = 1;
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm && (u->cm->flags.bits.lut3d_enable || u->surface->cm.flags.bits.lut3d_enable)) {
 		update_flags->bits.lut_3d = 1;
-		elevate_update_type(&overall_type,
-				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-				LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm && u->cm->flags.bits.lut3d_dma_enable != u->surface->cm.flags.bits.lut3d_dma_enable &&
@@ -2995,10 +2979,9 @@ static struct surface_update_descriptor check_update_surface(
 
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
+			// TODO: Should be fast?
 			update_flags->bits.hdr_mult = 1;
-			elevate_update_type(&overall_type,
-					check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
-					LOCK_DESCRIPTOR_STREAM);
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 		}
 
 	if (u->sdr_white_level_nits)
@@ -3052,7 +3035,7 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	/* When countdown finishes, promote this flip to full to trigger deferred final transition */
 	if (check_config->deferred_transition_state && !check_config->transition_countdown_to_steady_state) {
@@ -3119,18 +3102,7 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		if (su_flags->raw)
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 
-		/* Non-global cases */
-		if (stream_update->hdr_static_metadata ||
-				stream_update->vrr_infopacket ||
-				stream_update->vsc_infopacket ||
-				stream_update->vsp_infopacket ||
-				stream_update->hfvsif_infopacket ||
-				stream_update->adaptive_sync_infopacket ||
-				stream_update->vtem_infopacket ||
-				stream_update->avi_infopacket) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
-		}
-
+		// Non-global cases
 		if (stream_update->output_csc_transform) {
 			su_flags->bits.out_csc = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
@@ -3140,32 +3112,11 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.out_tf = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
-
-		if (stream_update->periodic_interrupt) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
-		}
-
-		if (stream_update->dither_option) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
-		}
-
-		if (stream_update->cursor_position || stream_update->cursor_attributes) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
-		}
-
-		/* TODO - cleanup post blend CM */
-		if (stream_update->func_shaper || stream_update->lut3d_func) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
-		}
-
-		if (stream_update->pending_test_pattern) {
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
 		struct surface_update_descriptor inner_type =
-				check_update_surface(check_config, &updates[i]);
+				det_surface_update(check_config, &updates[i]);
 
 		elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
 	}
@@ -3192,84 +3143,6 @@ struct surface_update_descriptor dc_check_update_surfaces_for_stream(
 	return check_update_surfaces_for_stream(check_config, updates, surface_count, stream_update);
 }
 
-/*
- * check_update_state_and_surfaces_for_stream() - Determine update type (fast, med, or full)
- *
- * This function performs checks on the DC global state, and is therefore not re-entrant.  It
- * should not be called from DM.
- *
- * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
- */
-static struct surface_update_descriptor check_update_state_and_surfaces_for_stream(
-		const struct dc *dc,
-		const struct dc_check_config *check_config,
-		const struct dc_stream_state *stream,
-		const struct dc_surface_update *updates,
-		const int surface_count,
-		const struct dc_stream_update *stream_update)
-{
-	(void)check_config;
-	(void)stream_update;
-
-	const struct dc_state *context = dc->current_state;
-
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE};
-
-	if (updates)
-		for (int i = 0; i < surface_count; i++)
-			if (!is_surface_in_context(context, updates[i].surface))
-				elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-
-	if (stream) {
-		const struct dc_stream_status *stream_status = dc_stream_get_status_const(stream);
-		if (stream_status == NULL || stream_status->plane_count != surface_count)
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-	}
-	if (dc->idle_optimizations_allowed)
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-
-	if (dc_can_clear_cursor_limit(dc))
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-
-	return overall_type;
-}
-
-/*
- * dc_check_update_state_and_surfaces_for_stream() - Determine update type (fast, med, or full)
- *
- * This function performs checks on the DC global state, stream and surface update, and is
- * therefore not re-entrant.  It should not be called from DM.
- *
- * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
- */
-static struct surface_update_descriptor dc_check_update_state_and_surfaces_for_stream(
-		const struct dc *dc,
-		const struct dc_check_config *check_config,
-		struct dc_stream_state *stream,
-		struct dc_surface_update *updates,
-		int surface_count,
-		struct dc_stream_update *stream_update)
-{
-	/* check updates against the entire DC state (global) first */
-	struct surface_update_descriptor overall_update_type = check_update_state_and_surfaces_for_stream(
-			dc,
-			check_config,
-			stream,
-			updates,
-			surface_count,
-			stream_update);
-
-	/* check updates for stream and plane */
-	struct surface_update_descriptor stream_update_type = dc_check_update_surfaces_for_stream(
-			check_config,
-			updates,
-			surface_count,
-			stream_update);
-	elevate_update_type(&overall_update_type, stream_update_type.update_type, stream_update_type.lock_descriptor);
-
-	return overall_update_type;
-}
-
 static struct dc_stream_status *stream_get_status(
 	struct dc_state *ctx,
 	struct dc_stream_state *stream)
@@ -3626,6 +3499,13 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
+static bool full_update_required_weak(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream);
+
 struct pipe_split_policy_backup {
 	bool dynamic_odm_policy;
 	bool subvp_policy;
@@ -3695,11 +3575,12 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		struct surface_update_descriptor *update_descriptor,
+		enum surface_update_type *new_update_type,
 		struct dc_state **new_context)
 {
 	struct dc_state *context;
 	int i, j;
+	enum surface_update_type update_type;
 	const struct dc_stream_status *stream_status;
 	struct dc_context *dc_ctx = dc->ctx;
 
@@ -3713,20 +3594,17 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	context = dc->current_state;
-	*update_descriptor = dc_check_update_state_and_surfaces_for_stream(
-			dc,
-			&dc->check_config,
-			stream,
-			srf_updates,
-			surface_count,
-			stream_update);
+	update_type = dc_check_update_surfaces_for_stream(
+			&dc->check_config, srf_updates, surface_count, stream_update).update_type;
+	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
+		update_type = UPDATE_TYPE_FULL;
 
 	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
 	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
 	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
 	 */
 	force_immediate_gsl_plane_flip(dc, srf_updates, surface_count);
-	if (update_descriptor->update_type == UPDATE_TYPE_FULL)
+	if (update_type == UPDATE_TYPE_FULL)
 		backup_planes_and_stream_state(&dc->scratch.current_state, stream);
 
 	/* update current stream with the new updates */
@@ -3752,7 +3630,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		}
 	}
 
-	if (update_descriptor->update_type == UPDATE_TYPE_FULL) {
+	if (update_type == UPDATE_TYPE_FULL) {
 		if (stream_update) {
 			uint32_t dsc_changed = stream_update->stream->update_flags.bits.dsc_changed;
 			stream_update->stream->update_flags.raw = 0xFFFFFFFF;
@@ -3762,13 +3640,13 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			srf_updates[i].surface->update_flags.raw = 0xFFFFFFFF;
 	}
 
-	if (update_descriptor->update_type >= update_surface_trace_level)
+	if (update_type >= update_surface_trace_level)
 		update_surface_trace(dc, srf_updates, surface_count);
 
 	for (i = 0; i < surface_count; i++)
 		copy_surface_update_to_plane(srf_updates[i].surface, &srf_updates[i]);
 
-	if (update_descriptor->update_type >= UPDATE_TYPE_FULL) {
+	if (update_type >= UPDATE_TYPE_FULL) {
 		struct dc_plane_state *new_planes[MAX_SURFACES] = {0};
 
 		for (i = 0; i < surface_count; i++)
@@ -3806,7 +3684,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *surface = srf_updates[i].surface;
 
-		if (update_descriptor->update_type != UPDATE_TYPE_MED)
+		if (update_type != UPDATE_TYPE_MED)
 			continue;
 		if (surface->update_flags.bits.position_change) {
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -3820,7 +3698,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		}
 	}
 
-	if (update_descriptor->update_type == UPDATE_TYPE_FULL) {
+	if (update_type == UPDATE_TYPE_FULL) {
 		struct pipe_split_policy_backup policy;
 		bool minimize = false;
 
@@ -3849,7 +3727,8 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 
 	*new_context = context;
-	if (update_descriptor->update_type == UPDATE_TYPE_FULL)
+	*new_update_type = update_type;
+	if (update_type == UPDATE_TYPE_FULL)
 		backup_planes_and_stream_state(&dc->scratch.new_state, stream);
 
 	return true;
@@ -3929,7 +3808,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				program_cursor_position(dc, stream);
 
 			/* Full fe update*/
-			if (update_type <= UPDATE_TYPE_FAST)
+			if (update_type == UPDATE_TYPE_FAST)
 				continue;
 
 			if (stream_update->dsc_config)
@@ -4238,7 +4117,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
 	bool should_offload_fams2_flip = false;
-	bool should_lock_all_pipes = (update_type > UPDATE_TYPE_FAST);
+	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 
 	if (should_lock_all_pipes)
 		determine_pipe_unlock_order(dc, context);
@@ -4298,7 +4177,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				continue;
 
 			pipe_ctx->plane_state->triplebuffer_flips = false;
-			if (update_type <= UPDATE_TYPE_FAST &&
+			if (update_type == UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
 					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 				/*triple buffer for VUpdate only*/
@@ -4355,7 +4234,7 @@ static void commit_planes_for_stream(struct dc *dc,
 {
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
-	bool should_lock_all_pipes = (update_type > UPDATE_TYPE_FAST);
+	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
 	bool subvp_curr_use = false;
 	uint8_t current_stream_mask = 0;
@@ -4372,7 +4251,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
-	if (update_type > UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
+	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -4434,7 +4313,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if ((update_type > UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_inbox1_lock(dc, stream->link)) {
@@ -4505,7 +4384,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
-		if (update_type > UPDATE_TYPE_FAST)
+		if (update_type != UPDATE_TYPE_FAST)
 			if (dc->hwss.commit_subvp_config)
 				dc->hwss.commit_subvp_config(dc, context);
 
@@ -4521,7 +4400,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		return;
 	}
 
-	if (update_type > UPDATE_TYPE_FAST) {
+	if (update_type != UPDATE_TYPE_FAST) {
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
@@ -4549,7 +4428,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 				continue;
 			pipe_ctx->plane_state->triplebuffer_flips = false;
-			if (update_type <= UPDATE_TYPE_FAST &&
+			if (update_type == UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
 					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 				/*triple buffer for VUpdate only*/
@@ -4576,7 +4455,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				continue;
 
 			/* Full fe update*/
-			if (update_type <= UPDATE_TYPE_FAST)
+			if (update_type == UPDATE_TYPE_FAST)
 				continue;
 
 			stream_status =
@@ -4595,7 +4474,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			continue;
 
 		/* Full fe update*/
-		if (update_type <= UPDATE_TYPE_FAST)
+		if (update_type == UPDATE_TYPE_FAST)
 			continue;
 
 		ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
@@ -4606,7 +4485,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (dc->hwss.program_front_end_for_ctx && update_type > UPDATE_TYPE_FAST) {
+	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
 
 		//Pipe busy until some frame and line #
@@ -4634,7 +4513,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	// Update Type FAST, Surface updates
-	if (update_type <= UPDATE_TYPE_FAST) {
+	if (update_type == UPDATE_TYPE_FAST) {
 		if (dc->hwss.set_flip_control_gsl)
 			for (i = 0; i < surface_count; i++) {
 				struct dc_plane_state *plane_state = srf_updates[i].surface;
@@ -4691,7 +4570,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 	}
 
-	if ((update_type > UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
@@ -4724,13 +4603,13 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* If enabling subvp or transitioning from subvp->subvp, enable the
 		 * phantom streams before we program front end for the phantom pipes.
 		 */
-		if (update_type > UPDATE_TYPE_FAST) {
+		if (update_type != UPDATE_TYPE_FAST) {
 			if (dc->hwss.enable_phantom_streams)
 				dc->hwss.enable_phantom_streams(dc, context);
 		}
 	}
 
-	if (update_type > UPDATE_TYPE_FAST)
+	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
 	if (subvp_prev_use && !subvp_curr_use) {
@@ -4743,7 +4622,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.disable_phantom_streams(dc, context);
 	}
 
-	if (update_type > UPDATE_TYPE_FAST)
+	if (update_type != UPDATE_TYPE_FAST)
 		if (dc->hwss.commit_subvp_config)
 			dc->hwss.commit_subvp_config(dc, context);
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
@@ -5215,12 +5094,198 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
+void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update)
+{
+	int i = 0;
+
+	if (stream_update) {
+		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
+		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
+	} else {
+		fast_update[0].out_transfer_func = NULL;
+		fast_update[0].output_csc_transform = NULL;
+	}
+
+	for (i = 0; i < surface_count; i++) {
+		fast_update[i].flip_addr = srf_updates[i].flip_addr;
+		fast_update[i].gamma = srf_updates[i].gamma;
+		fast_update[i].gamut_remap_matrix = srf_updates[i].gamut_remap_matrix;
+		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
+		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
+		fast_update[i].cursor_csc_color_matrix = srf_updates[i].cursor_csc_color_matrix;
+#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
+		fast_update[i].cm_hist_control = srf_updates[i].cm_hist_control;
+#endif
+	}
+}
+
+static bool fast_updates_exist(const struct dc_fast_update *fast_update, int surface_count)
+{
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform)
+		return true;
+
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].flip_addr ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].input_csc_color_matrix ||
+				fast_update[i].cursor_csc_color_matrix ||
+#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
+				fast_update[i].cm_hist_control ||
+#endif
+				fast_update[i].coeff_reduction_factor)
+			return true;
+	}
+
+	return false;
+}
+
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count)
+{
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform)
+		return true;
+
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].input_csc_color_matrix ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].coeff_reduction_factor ||
+#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
+				fast_update[i].cm_hist_control ||
+#endif
+				fast_update[i].cursor_csc_color_matrix)
+			return true;
+	}
+
+	return false;
+}
+
+static bool full_update_required_weak(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
+{
+	(void)stream_update;
+	const struct dc_state *context = dc->current_state;
+	if (srf_updates)
+		for (int i = 0; i < surface_count; i++)
+			if (!is_surface_in_context(context, srf_updates[i].surface))
+				return true;
+
+	if (stream) {
+		const struct dc_stream_status *stream_status = dc_stream_get_status_const(stream);
+		if (stream_status == NULL || stream_status->plane_count != surface_count)
+			return true;
+	}
+	if (dc->idle_optimizations_allowed)
+		return true;
+
+	if (dc_can_clear_cursor_limit(dc))
+		return true;
+
+	return false;
+}
+
+static bool full_update_required(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
+{
+	const union dc_plane_cm_flags blend_only_flags = {
+		.bits = {
+			.blend_enable = 1,
+		}
+	};
+
+	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
+		return true;
+
+	for (int i = 0; i < surface_count; i++) {
+		if (srf_updates &&
+				(srf_updates[i].plane_info ||
+				srf_updates[i].scaling_info ||
+				(srf_updates[i].hdr_mult.value &&
+				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
+				(srf_updates[i].sdr_white_level_nits &&
+				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
+				srf_updates[i].in_transfer_func ||
+				srf_updates[i].surface->force_full_update ||
+				(srf_updates[i].flip_addr &&
+				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
+				(srf_updates[i].cm &&
+				((srf_updates[i].cm->flags.all != blend_only_flags.all && srf_updates[i].cm->flags.all != 0) ||
+				(srf_updates[i].surface->cm.flags.all != blend_only_flags.all && srf_updates[i].surface->cm.flags.all != 0)))))
+			return true;
+	}
+
+	if (stream_update &&
+			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
+			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
+			stream_update->integer_scaling_update) ||
+			stream_update->hdr_static_metadata ||
+			stream_update->abm_level ||
+			stream_update->periodic_interrupt ||
+			stream_update->vrr_infopacket ||
+			stream_update->vsc_infopacket ||
+			stream_update->vsp_infopacket ||
+			stream_update->hfvsif_infopacket ||
+			stream_update->vtem_infopacket ||
+			stream_update->adaptive_sync_infopacket ||
+			stream_update->avi_infopacket ||
+			stream_update->dpms_off ||
+			stream_update->allow_freesync ||
+			stream_update->vrr_active_variable ||
+			stream_update->vrr_active_fixed ||
+			stream_update->gamut_remap ||
+			stream_update->output_color_space ||
+			stream_update->dither_option ||
+			stream_update->wb_update ||
+			stream_update->dsc_config ||
+			stream_update->mst_bw_update ||
+			stream_update->func_shaper ||
+			stream_update->lut3d_func ||
+			stream_update->pending_test_pattern ||
+			stream_update->crtc_timing_adjust ||
+			stream_update->scaler_sharpener_update ||
+			stream_update->hw_cursor_req))
+		return true;
+
+	return false;
+}
+
+static bool fast_update_only(
+		const struct dc *dc,
+		const struct dc_fast_update *fast_update,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
+{
+	return fast_updates_exist(fast_update, surface_count)
+			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
+}
+
 static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *context;
+	enum surface_update_type update_type;
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -5228,9 +5293,11 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
+	bool is_fast_update_only;
 
-	struct surface_update_descriptor update_descriptor = {0};
-
+	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
+	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
+			surface_count, stream_update, stream);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -5249,7 +5316,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 			surface_count,
 			stream,
 			stream_update,
-			&update_descriptor,
+			&update_type,
 			&context))
 		return false;
 
@@ -5259,7 +5326,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 			dc_state_release(context);
 			return false;
 		}
-		elevate_update_type(&update_descriptor, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+		update_type = UPDATE_TYPE_FULL;
 	}
 
 	if (dc->hwss.is_pipe_topology_transition_seamless &&
@@ -5268,13 +5335,13 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (update_descriptor.update_type <= UPDATE_TYPE_FAST) {
+	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
 				stream,
 				stream_update,
-				update_descriptor.update_type,
+				update_type,
 				context);
 	} else {
 		if (!stream_update &&
@@ -5290,7 +5357,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 				surface_count,
 				stream,
 				stream_update,
-				update_descriptor.update_type,
+				update_type,
 				context);
 	}
 	if (dc->current_state != context)
@@ -5304,8 +5371,14 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		enum surface_update_type update_type)
 {
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
+
 	ASSERT(update_type < UPDATE_TYPE_FULL);
-	if (update_type <= UPDATE_TYPE_FAST)
+	populate_fast_updates(fast_update, srf_updates, surface_count,
+			stream_update);
+	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
+			stream_update, stream) &&
+			!dc->check_config.enable_legacy_fast_update)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -5396,7 +5469,7 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *new_context;
-	struct surface_update_descriptor update_descriptor = {0};
+	enum surface_update_type update_type;
 
 	/*
 	 * When this function returns true and new_context is not equal to
@@ -5408,26 +5481,22 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 	 * replaced by a newer context. Refer to the use of
 	 * swap_and_free_current_context below.
 	 */
-	if (!update_planes_and_stream_state(dc,
-				srf_updates,
-				surface_count,
-				stream,
-				stream_update,
-				&update_descriptor,
+	if (!update_planes_and_stream_state(dc, srf_updates, surface_count,
+				stream, stream_update, &update_type,
 				&new_context))
 		return false;
 
 	if (new_context == dc->current_state) {
 		commit_planes_and_stream_update_on_current_context(dc,
 				srf_updates, surface_count, stream,
-				stream_update, update_descriptor.update_type);
+				stream_update, update_type);
 
 		if (dc->check_config.transition_countdown_to_steady_state)
 			dc->check_config.transition_countdown_to_steady_state--;
 	} else {
 		commit_planes_and_stream_update_with_new_context(dc,
 				srf_updates, surface_count, stream,
-				stream_update, update_descriptor.update_type, new_context);
+				stream_update, update_type, new_context);
 	}
 
 	return true;
@@ -7199,7 +7268,7 @@ struct dc_update_scratch_space {
 	struct dc_stream_update *stream_update;
 	bool update_v3;
 	bool do_clear_update_flags;
-	struct surface_update_descriptor update_descriptor;
+	enum surface_update_type update_type;
 	struct dc_state *new_context;
 	enum update_v3_flow flow;
 	struct dc_state *backup_context;
@@ -7282,28 +7351,45 @@ static bool update_planes_and_stream_prepare_v3(
 	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
+	/* HWSS path determination needs to be done prior to updating the surface and stream states. */
+	struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
+
+	populate_fast_updates(fast_update,
+			      scratch->surface_updates,
+			      scratch->surface_count,
+			      scratch->stream_update);
+
+	const bool is_hwss_fast_path_only =
+		fast_update_only(scratch->dc,
+				 fast_update,
+				 scratch->surface_updates,
+				 scratch->surface_count,
+				 scratch->stream_update,
+				 scratch->stream) &&
+		!scratch->dc->check_config.enable_legacy_fast_update;
+
 	if (!update_planes_and_stream_state(
 			scratch->dc,
 			scratch->surface_updates,
 			scratch->surface_count,
 			scratch->stream,
 			scratch->stream_update,
-			&scratch->update_descriptor,
+			&scratch->update_type,
 			&scratch->new_context
 	)) {
 		return false;
 	}
 
 	if (scratch->new_context == scratch->dc->current_state) {
-		ASSERT(scratch->update_descriptor.update_type < UPDATE_TYPE_FULL);
+		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
 
-		scratch->flow = scratch->update_descriptor.update_type <= UPDATE_TYPE_FAST
+		scratch->flow = is_hwss_fast_path_only
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
 	}
 
-	ASSERT(scratch->update_descriptor.update_type >= UPDATE_TYPE_FULL);
+	ASSERT(scratch->update_type >= UPDATE_TYPE_FULL);
 
 	const bool seamless = scratch->dc->hwss.is_pipe_topology_transition_seamless(
 			scratch->dc,
@@ -7376,7 +7462,7 @@ static void update_planes_and_stream_execute_v3_commit(
 			intermediate_update ? scratch->intermediate_count : scratch->surface_count,
 			scratch->stream,
 			use_stream_update ? scratch->stream_update : NULL,
-			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_descriptor.update_type,
+			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_type,
 			// `dc->current_state` only used in `NO_NEW_CONTEXT`, where it is equal to `new_context`
 			intermediate_context ? scratch->intermediate_context : scratch->new_context
 	);
@@ -7394,7 +7480,7 @@ static void update_planes_and_stream_execute_v3(
 				scratch->surface_count,
 				scratch->stream,
 				scratch->stream_update,
-				scratch->update_descriptor.update_type,
+				scratch->update_type,
 				scratch->new_context
 		);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ab7dea9d47f7..afc06dfc161f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -467,7 +467,6 @@ struct dc_static_screen_params {
  */
 
 enum surface_update_type {
-	UPDATE_TYPE_ADDR_ONLY, /* only surface address is being updated, no other programming needed */
 	UPDATE_TYPE_FAST, /* super fast, safe to execute in isr */
 	UPDATE_TYPE_MED,  /* ISR safe, most of programming needed, no bw/clk change*/
 	UPDATE_TYPE_FULL, /* may need to shuffle resources */
@@ -1881,6 +1880,20 @@ struct dc_scaling_info {
 	struct scaling_taps scaling_quality;
 };
 
+struct dc_fast_update {
+	const struct dc_flip_addrs *flip_addr;
+	const struct dc_gamma *gamma;
+	const struct colorspace_transform *gamut_remap_matrix;
+	const struct dc_csc_transform *input_csc_color_matrix;
+	const struct fixed31_32 *coeff_reduction_factor;
+	struct dc_transfer_func *out_transfer_func;
+	struct dc_csc_transform *output_csc_transform;
+	const struct dc_csc_transform *cursor_csc_color_matrix;
+#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
+	struct cm_hist_control *cm_hist_control;
+#endif
+};
+
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
@@ -2019,7 +2032,12 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
-	/*
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
+void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update);
+/*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
  *
-- 
2.43.0

