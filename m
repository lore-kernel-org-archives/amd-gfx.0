Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC64C4450F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753D210F0A4;
	Wed, 15 Jul 2026 13:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8CDHwI6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6AE10F0A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0ar9cZHm1lZuH6ZIQ93IO1mhbuob00neS8YhhB+AmSbtJA9yn7Q5Rx1dFxygzLUWBlKGzaAfIlLitixRzEiThh1dg9MfHpeyIxVJlRQbV9qWx6Bth/ISZvnVxIYPtZPPXtZEQ7T502hBwsfEFAvawF/uvtfpyWGLcuMPW/1HyPu01BfsXBpnGkxTiBd2Qc/bl1w/XMAH4ARKKiSJkWSSmHPbKzXC/LHspfGWvR5hrxyLjRQs0AX0Bk32CVzZpOfBJibPGdP35ugzhvoD6TvskjTCZdiTLSjz3iCvppMLfAKYHIOizTDgWJ5SLbrcUew4iUGlMzOUdnrh+X2WrznkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wAPWQV7ISid8C6tFwJQfwevux7hwxLEzUIUxl5fyJM=;
 b=smcdIsOWGnVFP1VB0G5jB6c1ob0t7sCZ4Q4Hp9MuDOblldrFbSPIw+gsnmP6JUz959lUKywMcnU4EhD0Rza2xSueO5fvdBI9BDLf9N0ZX1Nop+927G7UD1izIFI1zcgzeWJLC23BOYlMDKCYBIdsGWUmYKPBUc2x9IkR9r7TMOZtcw0OoR4qlvAAIrge3KMqAxOOrjiyD7UOkdrbmuZMbx51qn+vdT6Mqwx2e908cFBLnQwIN8MGtn/vy0iwoFazp+q/RWZWwaMn+YTfrXc6VUrDaaZHNkbE/GmIY5kJ6P/bM7o9xglfiBQNNQKr5FSou6gcn/eab4HdFDv3AkdvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wAPWQV7ISid8C6tFwJQfwevux7hwxLEzUIUxl5fyJM=;
 b=K8CDHwI6DMU2wGH/k0Ev4d715UajuecFM2Bl3j+CgLp960E6bVMy6gL3TKxXV8OXXEkeoYY2Gk/XVrh9DSDqgprck+CKHezP0d7C7hN0SqLdABrofCyBz7MGVPl4eh+TYgoE7xDj7I/JG1PgJe0cHchQeSqFJF6Eqrxxhj94xhM=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Wed, 15 Jul
 2026 13:48:26 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a4) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:17 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:13 -0500
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
Subject: [PATCH 54/70] drm/amd/display: Introduce dc_state_get_status unified
 status accessor
Date: Wed, 15 Jul 2026 21:38:04 +0800
Message-ID: <20260715134432.1975118-55-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe42d79-5c9d-4e3a-d423-08dee277bece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: zuIsVCg/OlxRWPLKwNOEVj00YZ00/vCsABYR/Tvx4QdrW2MD7bi5lpcUQMouv9gu0uNsrDZNpndK6Jqd0sh5SkFAa3P3++CYUjhx0ghRzem/DumzT1KHLwQfKzHeee0PwR4genVFS06WslbCC6eYl6PIWkiJV8/dxY2A44PbLzZlGC62Kg6MpAvITPSSL/ZJrEn5xUeAXqMzz1zVmLxvJGIBrNqVcFt3PE49D9XXqGeIORkbSOrGNfUV8bH8q7nh2pCgZz8w1trLxmsBE5/EDQvbkwgLYbwTRzBt701yv864DRt2hOLRpSOJD+Z0vlvq9fcV1ncWkJRUmh3QWnk8lXBmhZcUCB6779cqAQyf2OLoQVT3Hat78KH3Lp3tC3p3CDS9l2qp9moQqa1+SZguy/PNBjkW7KFh7TIZPUN0Sp2WyXxyCqB+dLKG2DUlLfMwr0w5ZdTT6I5w1S4DQ0pOWLFo8ByXVBStG7t3bFi+f85ORCnz6o+44eWWAGpYbazjANSyUcQHO8p1/OdH0gMwlJMeOW/FUVQw4v6Ho+VgydxJXVbZAs+nGM/eSDwbAV2IAR6be6ngZYRh72uo7ZKx7uF2MlrmXh3sRLKaC8TdrZOq3/w6+3FyoFnCxS411IJb+JpKYOXJMmlGCB5jL1TafZx7miaVHYF5sNyUrXV/CoIpO92asHXLupSbSPOEf+R39P/59hTqS1vRaE5khQllZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(3023799007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sE9TGF8y2NPdemB1OyagMM3YKA4lSRbTudFL0E65hjFmyoMWyc6Zg/tkmbsFYpG5ps+HYZMK1Wd3CM3GP3sO/uEsK9QMG+IBi+Rtbc9L3sXhdL4hft3jIuY7gufzmU7Wl3tCQkgDzOtVbTTya4nz7fAn9LXfJ1tXrqfeI/FZooAsVGaUe1b7OcfMsw5fRR7fBF5JzST58dHXcU8lOWOj05CHMdUMvNHGIKwlAkhM+oWHnrKShSRguTli/p/TJ7ItEBD3Y/upWmhIHEEGYGHjSJRRTH9vCMNjrOKuNkwFcf6ZXpizVLJ0JKHyeJWyjb75dSbLeguSIkB03HoIjpg0/uIGCPBstat6vfbaWo/Mqjh7YEvLasVYbvFLAnoGw0Q5EsVSCVHSBGvb51DibGms34nqiOieJo9MwsRU6dCKOzEcJ/RQU9SRXMySpJS2HQix
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:26.2135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe42d79-5c9d-4e3a-d423-08dee277bece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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
dc_state_get_stream_status() is typed against streams only, leaving no
extensible slot for future status classes. The public status accessor
signature needs to stay stable as new status classes are added.

[How]
Add a dc_get_status_type bitmask and the dc_get_status_options /
dc_state_status structs. Implement dc_state_get_status() to populate the
output object per the options bitmask, and make dc_state_get_stream_status()
a shim over it.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 57 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           | 44 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  7 +++
 3 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index a5df0101b504..03cb40e94d58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -25,6 +25,7 @@
 #include "dc_types.h"
 #include "core_types.h"
 #include "core_status.h"
+#include "dc.h"
 #include "dc_state.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
@@ -682,28 +683,56 @@ bool dc_state_add_all_planes_for_stream(
 /* Private dc_state functions */
 
 /**
- * dc_state_get_stream_status - Get stream status from given dc state
- * @state: DC state to find the stream status in
- * @stream: The stream to get the stream status for
+ * dc_state_get_status - Unified status readback for dc_state.
+ * @status:  output object populated per options->types
+ * @options: selects source state, status classes to fill, and optional filters
  *
- * The given stream is expected to exist in the given dc state. Otherwise, NULL
- * will be returned.
+ * Return: DC_OK on success, DC_ERROR_UNEXPECTED if options or state is NULL.
  */
-struct dc_stream_status *dc_state_get_stream_status(
-		struct dc_state *state,
-		const struct dc_stream_state *stream)
+enum dc_status dc_state_get_status(struct dc_state_status *status,
+		const struct dc_get_status_options *options)
 {
 	uint8_t i;
 
-	if (state == NULL)
-		return NULL;
+	if (!status || !options || !options->state)
+		return DC_ERROR_UNEXPECTED;
 
-	for (i = 0; i < state->stream_count; i++) {
-		if (stream == state->streams[i])
-			return &state->stream_status[i];
+	if (options->types & DC_GET_STATUS_STREAM) {
+		status->stream_count = 0;
+		for (i = 0; i < options->state->stream_count; i++) {
+			if (options->stream &&
+					options->stream != options->state->streams[i])
+				continue;
+			status->stream_status[status->stream_count++] =
+					&options->state->stream_status[i];
+		}
 	}
 
-	return NULL;
+	return DC_OK;
+}
+
+/**
+ * dc_state_get_stream_status - Shim for dc_state_get_status.
+ * @state:  state to search
+ * @stream: stream to find status for
+ *
+ * Return: pointer to the matching dc_stream_status, or NULL if not found.
+ */
+struct dc_stream_status *dc_state_get_stream_status(
+		struct dc_state *state,
+		const struct dc_stream_state *stream)
+{
+	struct dc_state_status status = {};
+	struct dc_get_status_options options = {
+		.state  = state,
+		.types  = DC_GET_STATUS_STREAM,
+		.stream = stream,
+	};
+
+	if (dc_state_get_status(&status, &options) != DC_OK)
+		return NULL;
+
+	return status.stream_count > 0 ? status.stream_status[0] : NULL;
 }
 
 enum mall_stream_type dc_state_get_pipe_subvp_type(const struct dc_state *state,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bc2ed23407cc..2da89c7470de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2127,6 +2127,50 @@ struct dc_state_update {
  */
 bool dc_update_state(struct dc *dc, struct dc_state_update *updates);
 
+/**
+ * enum dc_get_status_type - Bitmask selecting which status classes to populate.
+ * @DC_GET_STATUS_STREAM: populate stream_status fields in dc_state_status
+ */
+enum dc_get_status_type {
+	DC_GET_STATUS_STREAM = (1u << 0),
+};
+
+/**
+ * struct dc_get_status_options - Input selector for dc_state_get_status.
+ * @state:  source state to read status from
+ * @types:  OR of dc_get_status_type values selecting classes to populate
+ * @stream: optional stream filter for DC_GET_STATUS_STREAM. NULL means
+ *          populate status for all streams in the state
+ */
+struct dc_get_status_options {
+	struct dc_state              *state;
+	uint32_t                      types;
+	const struct dc_stream_state *stream;
+};
+
+/**
+ * struct dc_state_status - Output-only status object from dc_state_get_status.
+ * @stream_count: number of valid entries in stream_status (DC_GET_STATUS_STREAM)
+ * @stream_status: pointers to live per-stream status entries
+ */
+struct dc_state_status {
+	int                     stream_count;
+	struct dc_stream_status *stream_status[MAX_STREAMS];
+};
+
+/**
+ * dc_state_get_status - Unified status readback for dc_state.
+ * @status:  output object populated according to options->types
+ * @options: selects the source state, status classes to fill, and filters
+ *
+ * dc_state_get_stream_status() is a thin shim over this function with
+ * types = DC_GET_STATUS_STREAM and a stream filter.
+ *
+ * Return: DC_OK on success, DC_ERROR_UNEXPECTED if state is NULL.
+ */
+enum dc_status dc_state_get_status(struct dc_state_status *status,
+		const struct dc_get_status_options *options);
+
 struct dc_underflow_debug_data {
 	struct dcn_hubbub_reg_state *hubbub_reg_state;
 	struct dcn_hubp_reg_state *hubp_reg_state[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index db1e63a7d460..acf461225e9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -74,4 +74,11 @@ bool dc_state_add_all_planes_for_stream(
 struct dc_stream_status *dc_state_get_stream_status(
 	struct dc_state *state,
 	const struct dc_stream_state *stream);
+
+struct dc_state_status;
+struct dc_get_status_options;
+
+enum dc_status dc_state_get_status(struct dc_state_status *status,
+	const struct dc_get_status_options *options);
+
 #endif /* _DC_STATE_H_ */
-- 
2.43.0

