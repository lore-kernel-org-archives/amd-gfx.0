Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139B3C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA8410F0A8;
	Wed, 15 Jul 2026 13:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4zeEDsFs";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AEC10F0A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJPAnExYEIzldBMnRZbIsj+DcKjjLeLNTTwD6IulNR0LTWlV0IYpYaHc2QdVU/lCp2BB15uOaSAQR9vgBJDCxqFOU/CqSiR/BsbDHkaqVW2JuzTOt5k47FSUtV1ozw1Ybm3KpAUeaTsQwQsLc3JC9RNKUqKiEYmi6NP7p3zbz3rFk41DLlzMNvkGPopHsjjYv4fUjkMS4mfKH92pfVyUHmnRdRCY7lhF/RJ0EKA9AG0ehLooU9WRfLLrNLeBm6GxGhb+811aFs1xdib/fxSKvdv41a9+0urLlsP1SX/ptBPJIgqcSKOk/4LOxhyTBwAGXmQzh3h1smi5BaRv+LoUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63zxcPkDUB7iOx2gJJRLq/4su0QN5Zk7kcu8TF0EetQ=;
 b=P83orUX6fNWninD75nvtarCvcycAkL3LN7G7d6x5jvuId5Bo3+a2kV71sfXYgOHgAwfBMrGyqzUzZqnMSGIaxxfQ3oogz64Np8pfeXqOtZGP3Bi40F3Ddh4T1XjIxIcK1nAQF/sb9vP+Ra8JKUnpsYXCVXnjQsomQx3Sh5+vx9QPVc3y1JjnGz6r7nbKeWGD4CUyRQBbcuuHOhwMgY8+dRhbhmSJDZfnuPVJG0D5En76Pb7Oi7ZZpnwEHuXsLX5112I29psMVZpMSoaHYStwRaq9tbw3GW71V72Msg8eRtHM8YP7SNUj0mxy1QtIoMzqQ4U9vk+1i5QxgrvF0DbMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63zxcPkDUB7iOx2gJJRLq/4su0QN5Zk7kcu8TF0EetQ=;
 b=4zeEDsFs7LYjyWJPj9mnybYcTL9MzdhvLoWPzc8kEFuS9NAeiEYafNK8dJ8s0Ey/Jahtx4J3NY8fDNao+tG1FyFWxC4E29PKx2YCXoXhhJThBE6hJO6xyttvWQtC/ZIqHM+qoKvop1tBorHnw+f8bFO5/I0FG35vbNKNXl9JmZk=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:48:24 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::ab) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:09 -0500
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
Subject: [PATCH 53/70] drm/amd/display: Refactor dc_validation_set array into
 single root struct
Date: Wed, 15 Jul 2026 21:38:03 +0800
Message-ID: <20260715134432.1975118-54-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: e85c89cc-cac3-4777-3413-08dee277bdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nsZlrEVxZ1TUvbeY/fHYlrJSAsHlGNRd3y3wNIAK1GlY4SA5YUDWbGXDDRk4phVO0bXy6NvqDFZlSmhNBTYPECJ3yBf76A/QV02VEkDMEiJpXADWNqiSMvpSx3KqOmrnOfKBdWBnbwwJPhnAwwuCf6trGLRSRo4mbCIEajLpVo1u2doQpPGdWB3D/8omdswMtRy4dZA7KJ6T2tyf6mhUX/8oB4G4mmWv08nYsA2izQbMSOXkcNFeB1zPfQECOnnfPb0kcMsNx1Ot4w8//x6CZHQn6JhZW7oCte2WhmVPRvRcEJr8/6llJL/Fx2x5uFqBPOMdl7sd5ayNXnjWv/yqdWQUXrBxlybDw1ii4rh+a1rxMGjlyXVLpMUFiIfu/X765P/x88dPsel8bjwJkguOe0vgU/NJG9YNWCiYbdLXEHHHvK3u+CFMQdBribCwbh/jWV0IIxxSndXcZwLj5XYTNcRltvP36ZeDHAueQMl8wnyv3H8BQXgBgG+2mjZyJlFpAG4ejX3PJfxB7y18+99q/zyJViNvOuQZyTjJ+9YC+kuSNc3CRAGgLvxd8PMOY7AkDgGDZZH/Lw0TchEBUvdRI1JMhFp7UQzq5/7Zwt26TJ2Dtx/MWLAdbxwi4+1XY3uSrT4ShXJFexczl2ff8EY3n4oOpGDZbtTjDlJsSqfdEK23Bf7lj59gKii1pl9LIW54H1dyIMl4gzYA2geApldgCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FFVxNmIH5RosZ4sFHd79bT0EWM2TjlteSKyhY/0OksVzVVShsKSjNM//i/1JDbW3tYYdmCK/Cjw+j1s4VKQq/M8pXlNWxXLSLo93wrWVhBywsmbwmRgwJuqN3cn8lrft2iRuHW/L6WkD5my97m68l9oGXDt7mO5h8Y6f3Iu9X5hYfS2MpehYJpd7MOmYX7WMfmfcSAe8feqtIrllZgPlO/CAGT83tvz+0hLTDdCC5od5/06llap01hhS4hDfthyrTzA/u0pZSx8UIb5874m2AUxXa2PjIrZz+F7n9BdNfKZZwqnpjOm1OImLExwDSCMfVkHiNkN1zcy2VGZaMINTUtJN7pGRjhpghTxTNdFuyFhsU9sp8WoEO7vSfRAkx63m7IqqV+emjonhG1T3DTg3ZnOlnf6LrOsN/ExfYCiAsAKnW5OhHZkTX8PoqwWfbvnT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:24.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c89cc-cac3-4777-3413-08dee277bdca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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
dc_validate_with_context() took a C array of per-stream elements plus a
separate count. This flat array cannot be extended to carry global objects
without widening the signature further.

[How]
Rename the per-stream element to dc_validation_stream, and make
dc_validation_set a root struct holding streams[MAX_STREAMS] and
stream_count. Update dc_validate_with_context() to take a single
const dc_validation_set * and propagate the new shape through all DC-layer
callers and helpers. Remove the never-implemented
dce112_validate_with_context declaration and the orphaned dce100
forward-declare.

No behavior change.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 11 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 60 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           | 22 +++++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 +-
 .../dc/resource/dce100/dce100_resource.h      |  1 -
 .../dc/resource/dce112/dce112_resource.h      |  7 ---
 6 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f1805b03f0db..3fa577a02df1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2479,7 +2479,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	unsigned int i, j;
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
-	struct dc_validation_set set[MAX_STREAMS] = {0};
+	struct dc_validation_set set = {0};
 	struct pipe_ctx *pipe;
 	bool handle_exit_odm2to1 = false;
 
@@ -2512,14 +2512,15 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 
 		dc_stream_log(dc, stream);
 
-		set[i].stream = stream;
+		set.streams[i].stream = stream;
 
 		if (status) {
-			set[i].plane_count = (uint8_t)status->plane_count;
+			set.streams[i].plane_count = (uint8_t)status->plane_count;
 			for (j = 0; j < (unsigned int)status->plane_count; j++)
-				set[i].plane_states[j] = status->plane_states[j];
+				set.streams[i].plane_states[j] = status->plane_states[j];
 		}
 	}
+	set.stream_count = (uint8_t)params->stream_count;
 
 	/* ODM Combine 2:1 power optimization is only applied for single stream
 	 * scenario, it uses extra pipes than needed to reduce power consumption
@@ -2543,7 +2544,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 
 	context->power_source = params->power_source;
 
-	res = dc_validate_with_context(dc, set, params->stream_count, context, DC_VALIDATE_MODE_AND_PROGRAMMING);
+	res = dc_validate_with_context(dc, &set, context, DC_VALIDATE_MODE_AND_PROGRAMMING);
 
 	/*
 	 * Only update link encoder to stream assignment after bandwidth validation passed.
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b21d41df0fab..d9492a460c2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4325,8 +4325,7 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 
 static bool planes_changed_for_existing_stream(struct dc_state *context,
 					       struct dc_stream_state *stream,
-					       const struct dc_validation_set set[],
-					       unsigned int set_count)
+					       const struct dc_validation_set *set)
 {
 	unsigned int i, j;
 	struct dc_stream_status *stream_status = NULL;
@@ -4343,18 +4342,18 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
 		return false;
 	}
 
-	for (i = 0; i < set_count; i++)
-		if (set[i].stream == stream)
+	for (i = 0; i < set->stream_count; i++)
+		if (set->streams[i].stream == stream)
 			break;
 
-	if (i == set_count)
+	if (i == set->stream_count)
 		ASSERT(0);
 
-	if (set[i].plane_count != stream_status->plane_count)
+	if (set->streams[i].plane_count != stream_status->plane_count)
 		return true;
 
-	for (j = 0; j < set[i].plane_count; j++)
-		if (set[i].plane_states[j] != stream_status->plane_states[j])
+	for (j = 0; j < set->streams[i].plane_count; j++)
+		if (set->streams[i].plane_states[j] != stream_status->plane_states[j])
 			return true;
 
 	return false;
@@ -4363,23 +4362,22 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
 static bool add_all_planes_for_stream(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
-		const struct dc_validation_set set[],
-		unsigned int set_count,
+		const struct dc_validation_set *set,
 		struct dc_state *state)
 {
 	unsigned int i, j;
 
-	for (i = 0; i < set_count; i++)
-		if (set[i].stream == stream)
+	for (i = 0; i < set->stream_count; i++)
+		if (set->streams[i].stream == stream)
 			break;
 
-	if (i == set_count) {
+	if (i == set->stream_count) {
 		dm_error("Stream %p not found in set!\n", stream);
 		return false;
 	}
 
-	for (j = 0; j < set[i].plane_count; j++)
-		if (!dc_state_add_plane(dc, stream, set[i].plane_states[j], state))
+	for (j = 0; j < set->streams[i].plane_count; j++)
+		if (!dc_state_add_plane(dc, stream, set->streams[i].plane_states[j], state))
 			return false;
 
 	return true;
@@ -4389,8 +4387,7 @@ static bool add_all_planes_for_stream(
  * dc_validate_with_context - Validate and update the potential new stream in the context object
  *
  * @dc: Used to get the current state status
- * @set: An array of dc_validation_set with all the current streams reference
- * @set_count: Total of streams
+ * @set: Root validation object holding all streams and their planes
  * @context: New context
  * @validate_mode: identify the validation mode
  *
@@ -4404,8 +4401,7 @@ static bool add_all_planes_for_stream(
  * In case of success, return DC_OK (1), otherwise, return a DC error.
  */
 enum dc_status dc_validate_with_context(struct dc *dc,
-					const struct dc_validation_set set[],
-					unsigned int set_count,
+					const struct dc_validation_set *set,
 					struct dc_state *context,
 					enum dc_validate_mode validate_mode)
 {
@@ -4426,8 +4422,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	for (i = 0; i < old_stream_count; i++) {
 		struct dc_stream_state *stream = context->streams[i];
 
-		for (j = 0; j < set_count; j++) {
-			if (stream == set[j].stream) {
+		for (j = 0; j < set->stream_count; j++) {
+			if (stream == set->streams[j].stream) {
 				found = true;
 				break;
 			}
@@ -4440,8 +4436,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	}
 
 	/* Second, build a list of new streams */
-	for (i = 0; i < set_count; i++) {
-		struct dc_stream_state *stream = set[i].stream;
+	for (i = 0; i < set->stream_count; i++) {
+		struct dc_stream_state *stream = set->streams[i].stream;
 
 		for (j = 0; j < old_stream_count; j++) {
 			if (stream == context->streams[j]) {
@@ -4459,10 +4455,10 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	/* Build a list of unchanged streams which is necessary for handling
 	 * planes change such as added, removed, and updated.
 	 */
-	for (i = 0; i < set_count; i++) {
+	for (i = 0; i < set->stream_count; i++) {
 		/* Check if stream is part of the delete list */
 		for (j = 0; j < del_streams_count; j++) {
-			if (set[i].stream == del_streams[j]) {
+			if (set->streams[i].stream == del_streams[j]) {
 				found = true;
 				break;
 			}
@@ -4471,7 +4467,7 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		if (!found) {
 			/* Check if stream is part of the add list */
 			for (j = 0; j < add_streams_count; j++) {
-				if (set[i].stream == add_streams[j]) {
+				if (set->streams[i].stream == add_streams[j]) {
 					found = true;
 					break;
 				}
@@ -4479,7 +4475,7 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		}
 
 		if (!found)
-			unchanged_streams[unchanged_streams_count++] = set[i].stream;
+			unchanged_streams[unchanged_streams_count++] = set->streams[i].stream;
 
 		found = false;
 	}
@@ -4488,8 +4484,7 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	for (i = 0; i < unchanged_streams_count; i++) {
 		if (planes_changed_for_existing_stream(context,
 						       unchanged_streams[i],
-						       set,
-						       set_count)) {
+						       set)) {
 
 			if (!dc_state_rem_all_planes_for_stream(dc,
 							  unchanged_streams[i],
@@ -4557,7 +4552,7 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		if (res != DC_OK)
 			goto fail;
 
-		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
+		if (!add_all_planes_for_stream(dc, add_streams[i], set, context)) {
 			res = DC_FAIL_ATTACH_SURFACES;
 			goto fail;
 		}
@@ -4567,9 +4562,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	for (i = 0; i < unchanged_streams_count; i++) {
 		if (planes_changed_for_existing_stream(context,
 						       unchanged_streams[i],
-						       set,
-						       set_count)) {
-			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
+						       set)) {
+			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, context)) {
 				res = DC_FAIL_ATTACH_SURFACES;
 				goto fail;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f06539df7f0a..bc2ed23407cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2182,9 +2182,9 @@ void dc_post_update_surfaces_to_stream(
 void dc_get_default_tiling_info(const struct dc *dc, struct dc_tiling_info *tiling_info);
 
 /**
- * struct dc_validation_set - Struct to store surface/stream associations for validation
+ * struct dc_validation_stream - Per-stream surface/stream association for validation
  */
-struct dc_validation_set {
+struct dc_validation_stream {
 	/**
 	 * @stream: Stream state properties
 	 */
@@ -2201,6 +2201,21 @@ struct dc_validation_set {
 	uint8_t plane_count;
 };
 
+/**
+ * struct dc_validation_set - Root validation input grouping all streams for a commit
+ */
+struct dc_validation_set {
+	/**
+	 * @streams: Per-stream entries (stream + its planes)
+	 */
+	struct dc_validation_stream streams[MAX_STREAMS];
+
+	/**
+	 * @stream_count: Number of active entries in @streams
+	 */
+	uint8_t stream_count;
+};
+
 bool dc_validate_boot_timing(const struct dc *dc,
 				const struct dc_sink *sink,
 				struct dc_crtc_timing *crtc_timing);
@@ -2208,8 +2223,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *plane_state);
 
 enum dc_status dc_validate_with_context(struct dc *dc,
-					const struct dc_validation_set set[],
-					unsigned int set_count,
+					const struct dc_validation_set *set,
 					struct dc_state *context,
 					enum dc_validate_mode validate_mode);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 945cdcefb7d4..b64ba8c0adb1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -577,8 +577,7 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 		const struct pipe_ctx *primary_pipe);
 
 bool resource_validate_attach_surfaces(
-		const struct dc_validation_set set[],
-		int set_count,
+		const struct dc_validation_set *set,
 		const struct dc_state *old_context,
 		struct dc_state *context,
 		const struct resource_pool *pool);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
index dd150a4b4610..bc130793348a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
@@ -33,7 +33,6 @@
 
 struct dc;
 struct resource_pool;
-struct dc_validation_set;
 
 struct resource_pool *dce100_create_resource_pool(
 	uint8_t num_virtual_links,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
index 3efc4c55d2d2..f2493945b8f4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
@@ -35,13 +35,6 @@ struct resource_pool *dce112_create_resource_pool(
 	uint8_t num_virtual_links,
 	struct dc *dc);
 
-enum dc_status dce112_validate_with_context(
-		struct dc *dc,
-		const struct dc_validation_set set[],
-		int set_count,
-		struct dc_state *context,
-		struct dc_state *old_context);
-
 enum dc_status dce112_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
-- 
2.43.0

