Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BBFC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A572C10F0A3;
	Wed, 15 Jul 2026 13:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWM1yvxf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04E010F0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKJCVY+NRDPQ75UDhExynB0Fk3Vh/yx5C2O7Dtj6nP+K6mq6xIOj+skV4wtnP3ga8zwnjmBqwXGNzNAG6pSRICgudefWwzQG1884Rwlj603hIEdYJQi4zFaPj5oGLI7GNRNDTZ7XOlT/vKcbdg7oEMfGuYhq0sILJzwxsWcUtDRv6Jd/k+1yWF2gXYGb6h5A3PmSg3CJH7F3mi2AFfA6aC7s3/EUpVwKeQWqEtr5Qjb/6X3mOLT3GAFv1Ge6dTKl0WHYJvao6TP7hf/KO18iRfCIEa5gpC7SwVFt3PUXsp6YbCbgB4+OnhuTg42b+XK+hHFP9+/jPMSUyUlS8osXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luy8he4KfTaIXtiO4BmthhehfhpztQ2wx8e4GOaJmLQ=;
 b=WtyhP+evfCpRJN9hMecHtf0WwwwqPAX3aCgtIePKwBxy0xh6zhktuKMtKXALYUXUsIeipZSerWQApBkKW8nQ1jOEkwGZ+6a2WD9hlIOV0Yv8g4xqDtjTGLQHRlcK0zNFcpnNqLVfAmWwkfmGsPXB/Fb8WRHcTkw0yXfIO/0e8J/xQCLpubu9uZc8AzXtUsLvqiMfrgclCSaGUgCcgwUBqgtwx4Itn6S639Jqk5LmaizENNk2hGFngTYboNCKDHppdXYop2+YuEtcBanrGFNBmdycfjGZDLYXiS1mNFJ5gJ8m5iVmdy2I5bC2YuBVfDK7rxR8UAwD7qeTkGczV+Bs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luy8he4KfTaIXtiO4BmthhehfhpztQ2wx8e4GOaJmLQ=;
 b=nWM1yvxffIRoVMwIFSIw3b+kdjvpb0sAUp1V1JMU3dzhtmZBfqIorCAOTVQvjbF2RMkVcD9pHa7TZKAdPHfuApO2z42syCxCJK5K3aiPidDX3Kjk2vTp1Nz3hTXrpH3INr2ZV3CvDQpgJVLCB+006fzM+Iamb58eB5QBjkClkaM=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:48:18 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::82) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:05 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>
Subject: [PATCH 51/70] drm/amd/display: Introduce dc_probe public object model
Date: Wed, 15 Jul 2026 21:38:01 +0800
Message-ID: <20260715134432.1975118-52-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fe63f0-4e9c-4571-98ab-08dee277b9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|30052699003|82310400026|6133799003|11063799006|56012099006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lmmmpo3dZqXa4fKsyHg1I4tfYwRm6um6HXxITz8cQLd56s/h5MVoXhItGNQxMk3ugj8M/FHsDjI3IZ0VADkQGjoloiH3vvS9aRZSuyTjp3/ZFuVu4icVurLJOvjp0Tnxmu0QsYXaoNKBInDIbaLd4c2Vf18WgoaZcrWS4HXvjRfzDKHwAS1jjj6fKg9nYYKRoLZV0XJykP/YTpKRaCSUrgAN3+TO4bqp6LxZYHU6nAD1isgMCnPksNeVEnb2IUS7r/QJEjaq2Gl7q5RbDdGgm8NA2E8OZKDo6w0UEaFzLYUZwfO/qwPaEdVbyWlOSQr0RnAAhScxdWZxzW4/+QRYzkDkLlNwkmTGGqBKvi6CJFUNkV1UuJUdKErOP/QWCU9HbAOjNw83vJwEIP9lAhuNHW+l+OAzruhC4GjHjnoXLSuiejMgt3WG4P8x8guE+cw6+X8dnbxl9C/Kboc8qNtc4thZzIeBduLaZU0J4tp41zlFiVd4UMl99SNXp7KRPqQb0bmEgnStxDxzbx7k9jRdLkPLkn345212CRTtjJ0HDS9GXdiN50MNlmAj4BaWiFOiY3j/MDiQazLeVH33kPZsM2noEOXLxo6jW4aJ3uNQHL3UpG09to7+BiNj9EYV7x297JyVU6NQoorHEl6BmdvHd+b5WxuZJud1k7sFGNI2dYjecIMon/XpkuZCHuc32G+gg8DKZNYZEgb1vhQ35UGjJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(30052699003)(82310400026)(6133799003)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mNE3WT8yrP6N5INsTMlozuuS4HfmPXzY0gdO3a6eVmlwO8Yo14tMdNvB/T1bU7D1VZcjVLhyJp85CtvBGe5L+y848IsIZ08N7rz7H8ih9Adq7pkoE5Lw/KW6EqXrK7Dv6KnPF27DjuriK16rRzhWzQRqPOHDW9R0JUl83xma7rpJOekJxsB0av41lr0DbywL60wGfnBE/Z4HNY0I5aoBIpcA6I0389tsjaiSOepoJxfSlZSmoOX09P2utS6OUq9rSimB3WKTtWmZ8rTkud3qiU7xy/qroSmJ5d8p8UpPbaRUSDNlzXF2lL5YrP64NdytIu0ErM2xVbnkN1wjrdhptv7ry34xAm3s7oCJ9+dg38q1n5sWobfB/+GVUzIQGJdlIx2ENM+UUnjI0JZdlh+ISMzPDSKgg9zvE0w/KjLpy/PUSl4lnL6JhYIwOMcxKzZp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:18.0257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fe63f0-4e9c-4571-98ab-08dee277b9ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Performance measurement needs to commit through the same update entry
point as planes and streams, with DM working against an abstraction of
what to measure rather than the hardware block that performs it.

[How]
Add dc_probe.h defining dc_probe_type (the measurable quantity),
dc_probe_target_state (not measuring / measuring / measured),
dc_probe_scope (global only, per-stream/plane deferred), and
dc_probe_state (an inline descriptor with copy semantics, no refcount).
dc_state carries the committed set as probes[MAX_PROBES] plus
probe_count. dc_state_update carries dc_probe_updates as the desired
absolute set that DC diffs against the committed set.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  9 ++
 drivers/gpu/drm/amd/display/dc/dc_probe.h     | 97 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 12 +++
 4 files changed, 121 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_probe.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 1f183ae85a3f..a5df0101b504 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -360,6 +360,9 @@ void dc_state_destruct(struct dc_state *state)
 	}
 	state->phantom_plane_count = 0;
 
+	memset(state->probes, 0, sizeof(state->probes));
+	state->probe_count = 0;
+
 	state->stream_mask = 0;
 	memset(&state->res_ctx, 0, sizeof(state->res_ctx));
 	memset(&state->pp_display_cfg, 0, sizeof(state->pp_display_cfg));
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 436277acd034..3e22c1f8d4db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -29,6 +29,7 @@
 #include "dc_types.h"
 #include "dc_state.h"
 #include "dc_plane.h"
+#include "dc_probe.h"
 #include "grph_object_defs.h"
 #include "logger_types.h"
 #include "hdcp_msg_types.h"
@@ -2105,6 +2106,14 @@ struct dc_surface_update {
 	struct cm_hist_control *cm_hist_control;
 };
 
+struct dc_state_update {
+	struct dc_stream_state   *stream;
+	struct dc_stream_update  *stream_update;
+	struct dc_surface_update *surface_updates;
+	int                       surface_count;
+	const struct dc_probe_updates *probe_updates;
+};
+
 struct dc_underflow_debug_data {
 	struct dcn_hubbub_reg_state *hubbub_reg_state;
 	struct dcn_hubp_reg_state *hubp_reg_state[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_probe.h b/drivers/gpu/drm/amd/display/dc/dc_probe.h
new file mode 100644
index 000000000000..ebf33b162b63
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_probe.h
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef _DC_PROBE_H_
+#define _DC_PROBE_H_
+
+#include "os_types.h"
+
+/**
+ * enum dc_probe_type - What DM wants to probe.
+ *
+ * Each value names a measurable quantity as an abstraction. DC resolves it to
+ * whatever HW measurement block fulfills it. DM never selects the HW block.
+ */
+enum dc_probe_type {
+	DC_PROBE_PEAK_MEM_BW = 0,
+	DC_PROBE_AVG_MEM_BW,
+	DC_PROBE_MEM_LATENCY,
+	DC_PROBE_URGENT_RAMP_LATENCY,
+	DC_PROBE_URGENT_ASSERTION_COUNT,
+	DC_PROBE_PREFETCH_DATA_SIZE,
+};
+
+/**
+ * enum dc_probe_target_state - Target lifecycle state DM wants DC to reach.
+ *
+ * DM sets this to describe the final state DC must reach by the end of the
+ * commit. DC performs whatever HW transition sequence is needed.
+ *
+ * @DC_PROBE_NOT_MEASURING: probe inactive, no valid data available.
+ * @DC_PROBE_MEASURING:     probe runs continuously. The latest value can be
+ *   read back at any time and may differ on each read.
+ * @DC_PROBE_MEASURED:      probe performed one shot. The result is latched and
+ *   stays valid until DM transitions back to DC_PROBE_NOT_MEASURING.
+ */
+enum dc_probe_target_state {
+	DC_PROBE_NOT_MEASURING = 0,
+	DC_PROBE_MEASURING,
+	DC_PROBE_MEASURED,
+};
+
+/**
+ * enum dc_probe_scope_type - What the probe is scoped to.
+ * @DC_PROBE_SCOPE_GLOBAL: whole memory subsystem, no stream/plane selector.
+ *
+ * Only GLOBAL is implemented. Per-stream/plane scoping must select targets by
+ * stable id, not object pointer — dc_state copy semantics would dangle a raw
+ * pointer when the absolute-set commit removes or replaces the target.
+ */
+enum dc_probe_scope_type {
+	DC_PROBE_SCOPE_GLOBAL = 0,
+};
+
+/**
+ * struct dc_probe_scope - Selects what a probe measures against.
+ * @type: scope kind, only DC_PROBE_SCOPE_GLOBAL is implemented.
+ */
+struct dc_probe_scope {
+	enum dc_probe_scope_type type;
+};
+
+/**
+ * struct dc_probe_state - DM-authored descriptor of a single probe.
+ *
+ * A plain inline value with copy semantics: no allocation, no refcount. DC
+ * resolves each descriptor to a HW measurement instance and diffs the desired
+ * set against the committed set to plan the transition.
+ *
+ * @type:         what to measure.
+ * @target_state: desired lifecycle state for this probe.
+ * @scope:        what the probe is scoped to (GLOBAL only for now).
+ */
+struct dc_probe_state {
+	enum dc_probe_type         type;
+	enum dc_probe_target_state target_state;
+	struct dc_probe_scope      scope;
+};
+
+#define MAX_PROBES 1
+
+/**
+ * struct dc_probe_updates - Absolute set of probes DM wants active.
+ *
+ * Mirrors the plane/stream absolute-set model: the array is the complete
+ * desired set. DC compares it against the committed set to add, remove, or
+ * transition probes.
+ *
+ * @probes:      desired probe descriptors.
+ * @probe_count: number of valid entries in @probes.
+ */
+struct dc_probe_updates {
+	struct dc_probe_state probes[MAX_PROBES];
+	int                   probe_count;
+};
+
+#endif /* _DC_PROBE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index cbbc1fb4b3dd..c42626101cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -622,6 +622,7 @@ struct dc_state {
 	 * @stream_status: Planes status on a given stream
 	 */
 	struct dc_stream_status stream_status[MAX_PIPES];
+
 	/**
 	 * @phantom_streams: Stream state properties for phantoms
 	 */
@@ -645,6 +646,17 @@ struct dc_state {
 	 * @stream_count: Total phantom planes in use
 	 */
 	uint8_t phantom_plane_count;
+
+	/**
+	 * @probes: Committed absolute set of probe descriptors.
+	 */
+	struct dc_probe_state probes[MAX_PROBES];
+
+	/**
+	 * @probe_count: Number of valid entries in @probes.
+	 */
+	int probe_count;
+
 	/**
 	 * @res_ctx: Persistent state of resources
 	 */
-- 
2.43.0

