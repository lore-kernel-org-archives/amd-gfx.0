Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E87FF31E21
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE9510E0ED;
	Thu,  9 Apr 2026 15:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ysa94wYA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2B810E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUk0OhGYhwNM5PY0DUT5u36IvEnCvWhoBK5YG8ICVGQBe4azXiUJjysltukD6lbVqu/R/XwNr92D/8dSWZLBCxXvlCiCO+4iBGjX5Htm3nKQ+nhnMtwoxbTaxm5SXWO9Sq+eTEsH56vf3ZNalPnQsTPIjwNdpZEvbG4RLw0iI1T/SzlQwNtLP1ZzGsudrdYxTcH4L5m3mBrFl+RovWVc5k78u+wERGC7Q0OZ8jHTv36SmtvR9WgyDGOB7XgurYS62oTxrySj9UBa3zRWbsuoP732iU47/3MgKwF+W8Kvhu/Cr/WH06DvhnUDnfPuNs3b6t88cgYjaFpRFEeOsPKxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9NJ34dVPNtaT3smTXotsRLZkR2bsIoImV3tcs+O2s=;
 b=aOoiTS1JQ3wvAL1k2yZJYacteBL1pUmjit+n3F7Q8Pi7PFZq/ukFitQ7umVbZfv3JBoy87oRMCW08QOxwujQniQ/czSArMI1dmq8vf6TKNGHCWP9iyUVY490eEscmT++3hECuf7xAnwQDmYECxzPvMB5HI4Afm5bN5LlqUV3yBq0ncOP2wVZ3eHVr13rLIz6Yd8Lnk8WIiHYfNYjg/ACdM0CHRBgd9CGXyJx1jcqE6fVlPFZYEOvb1Vio7iYG39CHR9baGn6K0N0wkH4rQC7VLrdNt+WDi0xRwnaPu/9oiFWy7JAwUQy5jN4O74IdZeUdwT9aEdwuytRcOuizZkISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9NJ34dVPNtaT3smTXotsRLZkR2bsIoImV3tcs+O2s=;
 b=Ysa94wYA2yHHT/LZ/0h22Cclf1Bk7H2GXoqcPHxhYlNrWSgVFbd7S+bt1xU9pHAk6MHMp2Ao0R541Dwmq2vMkDCNPz5/96EAS6/Rv8abFMJsCKO6k5klWuV1S/9+xU+wk7ERJRqUVSQZrOeZHl8oZP+YyTKFEd27eIFzqQlNpMc=
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 15:04:21 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a7) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 15:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:15 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 2/6] drm/amd/display: Use overlay cursor when color pipeline
 is active
Date: Thu, 9 Apr 2026 11:03:10 -0400
Message-ID: <20260409150413.34779-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0124d187-5365-4352-23cb-08de96494757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: q9g5YOX6XJVhwW6XnliAFR3oD4td0RHYlcdr+Sec/AcNilvz6cXbmDE9ZWQZ8GN1m7J6lOIlvPF3eC8/1DkCc/xIocHAqnJ9k/vO0dKHx0LtKT59FMMJHrjVDvBa7dIzRpDBO7Sf3mGwiq1auyBqJHxwkhtE0nqTD2evb9/NE/QxtCEfsis6ArmuhCfmcyR+BNA9e0FFW901I3t/O5/JiBiXvJ3NAfDAxuuu4DfbPKYktqn8TB0qcyB6G2NvoCu5GyJZeX+Uyj7H61mbbrgHCzwIATSz69OCJhwbBizKfEuSSse2j76T9ZndrCSwe2/9TneOgsQLbN5Dg0+mAn9HWXfAf9f3L5bhpvGaXSBb6LaaTLT3Rnlz/EluMnb1qUAQ1PNuIagB3dk93Vc0POah8Ju7FQ2LcHEyZ5VUf64BOKMHSqQ35WyjdXShVEwjU2IypNb3cFlaB3255WEKsCY2FQaO02oLAUPL2GKON2JnjjoKIhjDSqzH2JF3TXAg+jcB07NEAC5hkqmNr4nJP97NZ24c8p+eHsCWCVxiA6a7/KWxtv51hNG2y1fdNsH0JUuGvS4cbPgklmMknE7nEBq15a43iEhjvye/c+7ODt1aG7nWymZrEUQfEH6osWAj/510zqlLl+TUOuNQBFokusXdFjk4D+EiPahZOetZj+bgvHhdFY3NODNVJihQwTw/akNFw9EZsreX3zR5qeN+OW88fh5ChdUZfUcwRgFPcZEh9IBR2RXWumPxSZFxtDZJ89q9KKq7QD3jllAQO4nnFQHS1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UagAd3Fi8TG6UFFjYGYgofJspPR+g6kn/s3zSldbmCSCXTxrlrGFC4wNVlX6YlhYa3xkArpipK++YppaK5uRNLU3sM4Mfo7ioB4pfebEOaECAzSCGTO1GX/UQNzH5703Ql5OwA742AIWguDwcU9KnPBNZ6TjW4KJPWKaC6fbzyZvDR0aN68AJg1aX78wjuN1BAiFD/FJhS5dcqRCsrv+/QFA0nv1kcl/6qLt+ED8ITASh31mXeT27D9JAncQ5kHHL59Glrk0iMdxyowJi8lvD/LvLPS6XwiC0/E2gkhqvVGEDxT809rAEDckl5/6j1lnGpK3+xSk+dE3ZrGpgJ6JNht2qGk1o+xREz79OBwoLf5uOLLax5/lJACBE7VeStoevTx6T3Krh+FgknJZDBgJCsoyQgbYZeWbrvm+2TP7vA7CrDRRWld79s/O3woSShsW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:20.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0124d187-5365-4352-23cb-08de96494757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
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

From: Alex Hung <alex.hung@amd.com>

Force overlay cursor mode when an underlying plane has a non-bypassed
color pipeline to avoid incorrect cursor transformation.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bac02ea15b8a..bb3a92916bc8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -95,6 +95,7 @@
 #include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
+#include <drm/drm_colorop.h>
 #include <drm/drm_gem_atomic_helper.h>
 
 #include <media/cec-notifier.h>
@@ -12325,6 +12326,38 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
  * available.
  */
 
+/**
+ * dm_plane_color_pipeline_active() - Check if a plane's color pipeline active.
+ * @state: DRM atomic state
+ * @plane: DRM plane to check
+ * @use_old: if true, inspect the old colorop states; otherwise the new ones
+ *
+ * A color pipeline may be selected (color_pipeline != NULL) but still is
+ * inactive if every colorop in the chain is bypassed.  Only return
+ * true when at least one colorop has bypass == false, meaning the cursor
+ * would be subjected to the transformation in native mode.
+ *
+ * Return: true if the pipeline modifies pixels, false otherwise.
+ */
+static bool dm_plane_color_pipeline_active(struct drm_atomic_state *state,
+					   struct drm_plane *plane,
+					   bool use_old)
+{
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
+	int i;
+
+	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
+		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
+
+		if (cstate->colorop->plane != plane)
+			continue;
+		if (!cstate->bypass)
+			return true;
+	}
+	return false;
+}
+
 /**
  * dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
  * @adev: amdgpu device
@@ -12336,8 +12369,8 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
  * the dm_crtc_state.
  *
  * The cursor should be enabled in overlay mode if there exists an underlying
- * plane - on which the cursor may be blended - that is either YUV formatted, or
- * scaled differently from the cursor.
+ * plane - on which the cursor may be blended - that is either YUV formatted,
+ * scaled differently from the cursor, or has a color pipeline active.
  *
  * Since zpos info is required, drm_atomic_normalize_zpos must be called before
  * calling this function.
@@ -12375,7 +12408,7 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 
 	/*
 	 * Cursor mode can change if a plane's format changes, scale changes, is
-	 * enabled/disabled, or z-order changes.
+	 * enabled/disabled, z-order changes, or color management properties change.
 	 */
 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, plane_state, i) {
 		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
@@ -12400,6 +12433,12 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 			consider_mode_change = true;
 			break;
 		}
+
+		if (dm_plane_color_pipeline_active(state, plane, true) !=
+		    dm_plane_color_pipeline_active(state, plane, false)) {
+			consider_mode_change = true;
+			break;
+		}
 	}
 
 	if (!consider_mode_change && !crtc_state->zpos_changed)
@@ -12440,6 +12479,12 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 			return 0;
 		}
 
+		/* Underlying plane has an active color pipeline - cursor would be transformed */
+		if (dm_plane_color_pipeline_active(state, plane, false)) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
 		dm_get_plane_scale(plane_state,
 				   &underlying_scale_w, &underlying_scale_h);
 		dm_get_plane_scale(cursor_state,
@@ -12819,7 +12864,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		} else if (required_cursor_mode == DM_CURSOR_OVERLAY_MODE) {
 			drm_dbg_driver(crtc->dev,
-				       "[CRTC:%d:%s] Cannot enable native cursor due to scaling or YUV restrictions\n",
+				       "[CRTC:%d:%s] Cannot enable native cursor due to scaling, YUV, or color pipeline restrictions\n",
 				       crtc->base.id, crtc->name);
 			ret = -EINVAL;
 			goto fail;
-- 
2.53.0

