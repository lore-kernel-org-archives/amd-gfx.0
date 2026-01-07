Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E8CFD65A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DECF10E626;
	Wed,  7 Jan 2026 15:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y5ghEKWt";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D128210E624
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsGbLG1KXGtIWDV5ZsV2QtaUnZhao0XWnq/Nj50GSS6k6MAfArMafMunn06jYhzGXeb8CELwrFmUtyf529FdrRQZRZiuwZSZBOTb+a6Dow3S15SM7gZn09N1a6iiMLFQ/Q+1sM/woKwX5SshMgct8+tot0Dr4JBCwSL9+WC8VFPHKe5esyUoFEVBNoB3UiTpwshy7Bxwl7r2SVHVZ38XUTC9yYFNYO4Bd/G8Ah/u7yIvs+uhCRMv8O1Cyfzy1JC0r9B7gS2qmSnU5KoHrw6ufOoYvA5FHn8jKBFW9nI3OZrQR9JuL/S7ZpEAlAM0ITNli5AoBb7cPB5HBtLPylppQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsGzzpQRPoO5QdaMIzwD5gapc4zv9AuS/+0BmH65G+g=;
 b=U/RHYbuajX/fmPfK3tLmaq12jBUHrVM5s98DpjE2xtj5Hg1NbNsuW7WQgiFH0l/2tKGRaQltCFK48qbAgW3KE+rSI7cBIKiBaztPPjFou64x4b87eBtTDb/K1ZwkADNyzzaOKIMuPqEnaalk5RXEFqGVNll/pVcZd3u1167QxgXg4BCwrJA02m6uJzN8PRw2L3DXH6oN717cKQf+B+Se6s78wqQm/Npp+a7QldmT/FD0/ugsa2aKjyOPdUjky15m20BNIUaZEf754YjPVLoWgY3KwG2WRzS+uYNHOY7I4aTpdqVFBWrfK83fzi7c42KSZZPDO/2DO8jhkpTeiQuqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsGzzpQRPoO5QdaMIzwD5gapc4zv9AuS/+0BmH65G+g=;
 b=Y5ghEKWt6CBKZtXggR3Rbp8WJOhH5RNNfj1UUVuiLier8Hc5xOpCj3T0XJAuAIxN0XvOnRHj9CYjgGSsjazM9u8hlH63Ev+CIMia268CqtSWeKkHqk6Sv9Im5hzpWNN6Xe9mrlAa79aTkSj4Fv2V2456ITn551j+OfTv0gxW0cE=
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:01 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f8) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:57 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:57 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 07/21] drm/amd/display: PR error HPD_IRQ handling
Date: Wed, 7 Jan 2026 10:47:59 -0500
Message-ID: <20260107155421.1999951-8-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 140566cc-e62b-4851-babc-08de4e05891e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NCyAcWSOaQ24Yp8yqZ6uMEjQo7ygHcHUvgGSidFhCeN8vllnzTsJhhS0E/yq?=
 =?us-ascii?Q?L1IMDIYAKiUiAJ5MzQ28qMLtg7kXCckPrZtACpClfGdjxzFzu33Xz+Wfl1Rz?=
 =?us-ascii?Q?3XnB1TMAKxmkGGsmWmHX1V3Yadh7YsuB3P3+OtCnEa96d3HsRafaKjk5jsJt?=
 =?us-ascii?Q?FcSx5V0++uRrZk0EGRpBMXb7CbzNuEG4aoEdvxAeThsJsb8A1xoVo5tASyUI?=
 =?us-ascii?Q?B+OWWmRLbrVXyv00keZeQppYT3VLGE0aQ20wJ5W/pelWp4eDzZYQr0aAZ1LC?=
 =?us-ascii?Q?CkCexzDNeNwLtTo2amjrXXnnmxZFVmf0//FrIz8fAUESvDjyxsj4Q6MPTEAa?=
 =?us-ascii?Q?NhubRYCjkkpCT6e6xA5B2K722AvllV3O8OsCvv/MmJmi0JFLzG+8imxYYizg?=
 =?us-ascii?Q?5rf71zXNY+sKx8NhrVNmbLKTG5SOhlVfg1H+KMrwIKUMtFCPJjyoxxrq/KR2?=
 =?us-ascii?Q?qLD3pXkkFr3HVMgGLxR2PGJQP37MNOjoNKzTIPVeGWEG1rx6LhbGb0tfQC6X?=
 =?us-ascii?Q?oE5XYkyc1/4GxN5TlCE4hYwDxzFoYUWbdEZKamhSFeQjS0VHb1GOR6gGp3zQ?=
 =?us-ascii?Q?dgTQjrHP6ejCvdIFqdBmYKX32vC0meBSNhW45UpqUeSNRxSKkqEaWBBrGA8f?=
 =?us-ascii?Q?U17VvjzD8u3DJ+GmZIs6c0a4PSMPZWrP+NLl1BbHKP1ESV59ybpW8kc5nQwT?=
 =?us-ascii?Q?nRbPST6yyJgEoO4X3Dxd466BJ6epOHiMkkjvtPs2HzciDuzDHscnwSrFX2hH?=
 =?us-ascii?Q?LF5hzD4nwZQ9+Y3WC8jCfErOzvm78d5wtqK62WaKwAfHmZ480x73cFd3O42A?=
 =?us-ascii?Q?3RlHVFesfdLefFHzjQzURl1pW0A4HxutesFJg0x0Hud4EYXuI4FwQ6NUH6bb?=
 =?us-ascii?Q?HIYKjRoanuFG9vCY9rAcGwhaVRzqAO0VeFV/srwRY5UONgEFzgJTpodZ36rF?=
 =?us-ascii?Q?QIZWy9BBNnHFu+swHulSJU4xNmFd1NNnaj7h7bWEzvgTjRTC8GsjT7rRgnbJ?=
 =?us-ascii?Q?H5zzJJnuro8NC4oD3gVSiq8UfrPCKCoETUOKon9m085q1U50Jg4OtgxHLePH?=
 =?us-ascii?Q?uOfmVlRjfm5meSNhJINixTyS8DvIfC9oK3Gkd4larD3zSeDyTxg5XuU44Wd5?=
 =?us-ascii?Q?lAUUdH7YtZ2/wmTxYC7VjlxjLiunMRuFZqWjPG5DOvNx1+8eMP1Et4QUNq7J?=
 =?us-ascii?Q?ikKoC634CYSrc2JdSUMxl3PEwKuMty3g5pdghPZ1R3DbjAwMqdmLfwhSje0w?=
 =?us-ascii?Q?oSnLbeRO3J24bxJt2SQtZRlGKCbwv42LB4i6pCZoDfOMlEiuBgybziVwTy2Z?=
 =?us-ascii?Q?OM9izm5kbS0atvvMnee/cgVPl5Nlud5gs+bxB48isxaQByWmaONNzYM9Ul5K?=
 =?us-ascii?Q?7bfWA0ORbQCe7shebZI17U1Mq6jtHUuQGiVYLkzTKmicidkb09QwkI9PuEgJ?=
 =?us-ascii?Q?fxKFt94KZYa+Mo1TRTTsK2LhrFfQIDjD75y1GIQf6stBojcKILXjoDDNI5TS?=
 =?us-ascii?Q?KbGPkL5OWsxIq3eOPDnE1hGyCkUruSfE8CDR6AoxiIVt3KKF9awBW0HQlL8k?=
 =?us-ascii?Q?OoYtC05SkWQkxWCFldA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:01.4357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140566cc-e62b-4851-babc-08de4e05891e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

From: Jack Chang <jack.chang@amd.com>

[Why & How]
Add error handling for IRQ_HPD in Panel Replay

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 11 +++++
 .../dc/link/protocols/link_dp_irq_handler.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/display/include/dpcd_defs.h   | 15 +++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index d0d9297ccac0..5e3646b7550c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1423,6 +1423,17 @@ union dpcd_sink_active_vtotal_control_mode {
 	unsigned char raw;
 };
 
+union pr_error_status {
+	struct {
+		unsigned char LINK_CRC_ERROR        :1;
+		unsigned char RFB_STORAGE_ERROR     :1;
+		unsigned char VSC_SDP_ERROR         :1;
+		unsigned char ASSDP_MISSING_ERROR   :1;
+		unsigned char RESERVED              :4;
+	} bits;
+	unsigned char raw;
+};
+
 union psr_error_status {
 	struct {
 		unsigned char LINK_CRC_ERROR        :1;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 47abd3ec69b3..cc18a3bebef2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -34,6 +34,7 @@
 #include "link_dp_training.h"
 #include "link_dp_capability.h"
 #include "link_edp_panel_control.h"
+#include "link_dp_panel_replay.h"
 #include "link/accessories/link_dp_trace.h"
 #include "link/link_dpms.h"
 #include "dm_helpers.h"
@@ -186,6 +187,42 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 	return false;
 }
 
+static void handle_hpd_irq_vesa_replay_sink(struct dc_link *link)
+{
+	union pr_error_status pr_error_status = {0};
+
+	if (!link->replay_settings.replay_feature_enabled ||
+			link->replay_settings.config.replay_version != DC_VESA_PANEL_REPLAY)
+		return;
+
+	dm_helpers_dp_read_dpcd(
+		link->ctx,
+		link,
+		DP_PR_ERROR_STATUS,
+		&pr_error_status.raw,
+		sizeof(pr_error_status.raw));
+
+	if (pr_error_status.bits.LINK_CRC_ERROR ||
+			pr_error_status.bits.RFB_STORAGE_ERROR ||
+			pr_error_status.bits.VSC_SDP_ERROR ||
+			pr_error_status.bits.ASSDP_MISSING_ERROR) {
+
+		/* Acknowledge and clear error bits */
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_PR_ERROR_STATUS, /*DpcdAddress_PR_Error_Status*/
+			&pr_error_status.raw,
+			sizeof(pr_error_status.raw));
+
+		/* Replay error, disable and re-enable Replay */
+		if (link->replay_settings.replay_allow_active) {
+			dp_pr_enable(link, false);
+			dp_pr_enable(link, true);
+		}
+	}
+}
+
 static void handle_hpd_irq_replay_sink(struct dc_link *link)
 {
 	union dpcd_replay_configuration replay_configuration = {0};
@@ -197,6 +234,11 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 	if (!link->replay_settings.replay_feature_enabled)
 		return;
 
+	if (link->replay_settings.config.replay_version != DC_FREESYNC_REPLAY) {
+		handle_hpd_irq_vesa_replay_sink(link);
+		return;
+	}
+
 	while (retries < 10) {
 		ret = dm_helpers_dp_read_dpcd(
 			link->ctx,
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 43d58df67bab..7d8359a7d99d 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -61,6 +61,21 @@
 #ifndef DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 0x1b1
 #endif /* DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 */
+#ifndef DP_PR_ERROR_STATUS                  // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_ERROR_STATUS                  0x2020  /* DP 2.0 */
+#endif /* DP_PR_ERROR_STATUS */
+#ifndef DP_PR_LINK_CRC_ERROR               // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_LINK_CRC_ERROR               (1 << 0)
+#endif /* DP_PR_LINK_CRC_ERROR */
+#ifndef DP_PR_RFB_STORAGE_ERROR            // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_RFB_STORAGE_ERROR            (1 << 1)
+#endif /* DP_PR_RFB_STORAGE_ERROR */
+#ifndef DP_PR_VSC_SDP_UNCORRECTABLE_ERROR // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_VSC_SDP_UNCORRECTABLE_ERROR  (1 << 2) /* eDP 1.4 */
+#endif /* DP_PR_VSC_SDP_UNCORRECTABLE_ERROR */
+#ifndef DP_PR_ASSDP_MISSING_ERROR          // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_ASSDP_MISSING_ERROR          (1 << 3) /* eDP 1.5 */
+#endif /* DP_PR_ASSDP_MISSING_ERROR */
 
 enum dpcd_revision {
 	DPCD_REV_10 = 0x10,
-- 
2.52.0

