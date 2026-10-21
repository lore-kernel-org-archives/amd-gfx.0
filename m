Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46297606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s6BdMaub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC61310F958;
	Wed, 21 Oct 2026 06:27:22 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C0410F958
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZYRgs4S4nMCdg7yWvQDYUtPWz8dkPnUZmxJTShdkJobtLLnMBAvs0UjaxGFLhzs1pz8i/6VMhy6DV15LqN417qvjKq6fnlsmi4DbYPsS5bUBAaLeEm6UHgbrBOCJDSMEHDor9X3f2i+XG4OrnuZ5jiGVxPaw5hLQl5RzTBLA4CW72DftCDUADMlnFS4OzAMMlOYj60IfNcdfd/ToFcT37rM/EOXweK95aZwZ39D1mXMSSl8dT9AYIcSmgZRQLDkN8FTuNcnckO8MxC1XtwhSfWuZI/tB+yHvvwBmMs+KdycR7m/ul5jdvR6Uo1jkojRrbtqn+L4JEhiK5iVq2xTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYv0NPcy74Lx/H+zNS/mtsLEzx6pMY0ybVHsU6GlL7Q=;
 b=raOPeIAehQnAGjN3YK8uK7bEhKSdYAf9QDhnJdctBOr2Nq+Hg4w67uR47aMhcc8N7H1IejvlyaBhbIdIGl0U+iWuEg+4UlAs1RAfKD5TdphXja+IakT7zyoEWOEu3zp1ejOpXj7/siPEFiXNn0DA3vh+hsFh9uub8xuh5OwMDvqVGs4+Yh6sAMpljVhzjyU+EbTPAUVXjqi37cLSCYhBkTnGnv9cM9Ss/Mr0EbAZrRUTsH9/q+kn/KI+oF2fIkwsw/aP6HvDpgi4dtr7MJPwSf0eW1xGm5NW8fOH8sg/Jvf2LJeSplEfwiUOHtBPQa2/73Bo8qYsxdX0qjthFRTtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYv0NPcy74Lx/H+zNS/mtsLEzx6pMY0ybVHsU6GlL7Q=;
 b=s6BdMaubC1BDfEXY0sThURBhHthLJT2/WwsTapsCm0NPrJJqhOFThFiVHWXVyy08DUs/4LkrAMn4xopERcJzeltgzfMEL9o6HRrlUHUAn65tJ37KOt/KzLIIvXmHFObPNmj3y5F4P5alfX1zo+UJC9oWqiNacFlo8fM5yFmNKJc=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Wed, 21 Oct 2026 06:26:36 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::43) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:35 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:32 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 20/49] drm/amd/display: Fix coding style errors
Date: Wed, 21 Oct 2026 14:22:26 +0800
Message-ID: <20261021062519.674697-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 104b7cca-ecaa-4814-b077-08df2f3c41fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6h47+bXtMRhJaWd26+cdGlLahVU1RtMAHQkwDEZi7qmDMghFMfQLDZuOmoc0bUi2G4Af8hw5kFKw3/DJ40ehx9nZkzh0Di1vaJAgIPzgnJoIlOXzzlA1OAS9ZuEO6tBa+sEgolefghzBGxNx2ihhmoEvbpAKRAN63JuJMtTT7Y4kMuhA4xK/RXJW5zyc1SCKtGBLdin5LkEdnV6/DyHEwWIsZruDDovP0UIW2mtOjyiI8SHjGZ6akEELeCMVCt/GNk+xRnvc3CKxBlSB7/IYYgpLtSwJLPw5qgKf66dGFwcFI7NHUh9zC6D/1fLqyLrtbVVT0M9dFNwefmoIexWZmkL7Uo60Wg3av4OR8E+Pfrx6t0yNoLJcm4EKHhC0e5pURP7RK7F9scCy3YjNxAy5AZhnRkXgD65Cqt0fijHg6YSuBqyKRA9ZBozlwnk56Ep6PuwfEd+3X4fBxRK2TuEMa7kDtseQ8rDI6M92JTe6SZS7CYSpZ/faAUypEyfb1dKx7Bl3r2KiC3+06hM5xtA7OuOJjMSJry/E93K9sijRlkAE1tTvX82U/VJi9Swk071VW7DRQcO54j9mRVQin1bdVhHCjmSjFesOiW+178b5YKpO9E5IOuF85ZX/5wmLs3WqAwzFBdtmFkL/telr3NeII5fK6aRYG1XFmZGXGArM94+d/59k9qx+ygpqUTox6TJ/TvufM2a+oxc6P8DlzfiFmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZnMioyCsxBeaw92JMV4fkwtOxMTK7IjEJKtwPdvWA2psx5g5snEMKvpd2xy7qkqaeoQMT7BDtmYO1Ybm2mDjSCcroI0pPsNIDqU5nA+1vX/cRlxTXTdpPt7m5wMAg5ajPMQQpCU5Fy4FR/E//nw3BlQNXdYJTAIpmmnj1ZadQNL8jbTaU7rKlXe4QBa9iR8/G3bKYZWD2wiP7IdjUEQCXNpW8d+croJH0dDNdP7BW9PgcevGRsDDnLMwlGsC1riOub/wSsRWjaJZIj/kEGoQTV9amPqxEFBHvugzaBiBMJFv9dfQ+7nagAFdO4n/cs6YXlNHSNZ+CNrTlJJOBYynPcuVAbO4SPeH3ptDK39bCDMxigkG3XBg3lTAIQkXcuycCuADNtIRYql8FlsQNyeNyVY4F+WqzOacwNV1UWOhvnhafnCb0mROb4aW0t0AeIJL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:36.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104b7cca-ecaa-4814-b077-08df2f3c41fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Fix checkpatch warnings in AMDGPU DM by correcting
- SPDX comments
- mixed indentation
- block comment formatting
- redundant braces.

No functional changes.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 22 +++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  4 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  5 ++---
 11 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 594d275918d5..656aa0e465eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -65,9 +65,9 @@ enum amd_vsdb_panel_type {
  */
 #define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
 /*
-#include "include/amdgpu_dal_power_if.h"
-#include "amdgpu_dm_irq.h"
-*/
+ * #include "include/amdgpu_dal_power_if.h"
+ * #include "amdgpu_dm_irq.h"
+ */
 
 #include "irq_types.h"
 #include "signal_types.h"
@@ -349,7 +349,7 @@ struct hpd_rx_irq_offload_work {
  * @disable_hpd_irq: disables all HPD and HPD RX interrupt handling in the
  *		     driver when true
  * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
- * 			    transfers are done
+ *			    transfers are done
  * @delayed_hpd_wq: work queue used to delay DMUB HPD work
  */
 struct amdgpu_display_manager {
@@ -833,8 +833,10 @@ struct amdgpu_dm_connector {
 
 	struct cec_notifier *notifier;
 
-	/* we need to mind the EDID between detect
-	   and get modes due to analog/digital/tvencoder */
+	/*
+	 * we need to mind the EDID between detect
+	 * and get modes due to analog/digital/tvencoder
+	 */
 	const struct drm_edid *drm_edid;
 
 	/* shared with amdgpu */
@@ -843,8 +845,10 @@ struct amdgpu_dm_connector {
 	/* number of modes generated from EDID at 'dc_sink' */
 	int num_modes;
 
-	/* The 'old' sink - before an HPD.
-	 * The 'current' sink is in dc_link->sink. */
+	/*
+	 * The 'old' sink - before an HPD.
+	 * The 'current' sink is in dc_link->sink.
+	 */
 	struct dc_sink *dc_sink;
 	struct dc_link *dc_link;
 
@@ -880,7 +884,7 @@ struct amdgpu_dm_connector {
 	 * @max_vfreq: Maximum frequency supported by the display in Hz. This
 	 * value is set to zero when there is no FreeSync support.
 	 */
-	int max_vfreq ;
+	int max_vfreq;
 
 	/* Audio instance - protected by audio_lock. */
 	int audio_inst;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 5fdb2d2e5273..45cea72111c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1525,7 +1525,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 				     degamma_lut, degamma_size);
 		if (ret)
 			return ret;
-       } else {
+	} else {
 	       /* Check if format requires post-scale color processing (subsampled formats) */
 		is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
 					dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ded8e21897f1..349a6eae4556 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2326,7 +2326,7 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 * Since we check for it a few times below, cache the result.
 	 */
 	is_hdmi_ep = (signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-		     signal == SIGNAL_TYPE_HDMI_FRL 	||
+		     signal == SIGNAL_TYPE_HDMI_FRL	||
 		     aconnector->dc_link->dpcd_caps.dongle_type ==
 			     DISPLAY_DONGLE_DP_HDMI_CONVERTER);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6622a686e5e0..0cef66e20a86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2756,6 +2756,7 @@ static int ips_residency_show(struct seq_file *m, void *unused)
 		seq_printf(m, "ISP query failed\n");
 	} else {
 		unsigned int pct, frac;
+
 		pct = info.residency_millipercent / 1000;
 		frac = info.residency_millipercent % 1000;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9774ea33272d..a4cd5902d428 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -531,7 +531,7 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, set_flag, true);
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, clr_flag, false);
- }
+}
 EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_mst_mgr_for_deallocation);
 
 void dm_dtn_log_begin(struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 6ba567df5f0a..b9d90b0c62df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -71,8 +71,8 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev);
  * @handler_args: arguments which will be passed to ih
  *
  * Returns:
- * 	IRQ Handler Index on success.
- * 	NULL on failure.
+ *	IRQ Handler Index on success.
+ *	NULL on failure.
  *
  * Cannot be called from an interrupt handler.
  */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 39c50d2bcf3a..06d9ff2c32c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2129,15 +2129,15 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
 	} else if (property == adev->mode_info.plane_ctm_property) {
 		*val = (dm_plane_state->ctm) ?
 			dm_plane_state->ctm->base.id : 0;
-	} else 	if (property == adev->mode_info.plane_shaper_lut_property) {
+	} else if (property == adev->mode_info.plane_shaper_lut_property) {
 		*val = (dm_plane_state->shaper_lut) ?
 			dm_plane_state->shaper_lut->base.id : 0;
 	} else if (property == adev->mode_info.plane_shaper_tf_property) {
 		*val = dm_plane_state->shaper_tf;
-	} else 	if (property == adev->mode_info.plane_lut3d_property) {
+	} else if (property == adev->mode_info.plane_lut3d_property) {
 		*val = (dm_plane_state->lut3d) ?
 			dm_plane_state->lut3d->base.id : 0;
-	} else 	if (property == adev->mode_info.plane_blend_lut_property) {
+	} else if (property == adev->mode_info.plane_blend_lut_property) {
 		*val = (dm_plane_state->blend_lut) ?
 			dm_plane_state->blend_lut->base.id : 0;
 	} else if (property == adev->mode_info.plane_blend_tf_property) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 18b500585bed..4d86a3871603 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: MIT
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2022 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 23f1db81a154..b376185875ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: MIT
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 7f05f73e5b33..9027933cec3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: MIT
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 172999cc84e5..35331d339780 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -120,11 +120,10 @@ void dc_fpu_end(const char *function_name, const int line)
 	int depth;
 
 	depth = this_cpu_dec_return(fpu_recursion_depth);
-	if (depth == 0) {
+	if (depth == 0)
 		kernel_fpu_end();
-	} else {
+	else
 		WARN_ON_ONCE(depth < 0);
-	}
 
 	TRACE_DCN_FPU(false, function_name, line, depth);
 	preempt_enable();
-- 
2.43.0

