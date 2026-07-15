Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5407CC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E634910F0A6;
	Wed, 15 Jul 2026 13:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXRuX89S";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5590110F0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlBaHt9tL1uUPahL3fcq6ci2OK3Org9de1i75dpcVsT67VM+9ldAOXPYerItE7KKY5Oy+hciaxotNe+Gbfzf0/2924PrVU5fVCb2GQHMDhx8NekGLvglBeArQJbSF0dkaqTrSMlCvOY+fNuaMIS/wfksKGk4PULlWsqhknsEcOpKalGi5V9hlLOrVnfrw5XDDu3scGibNhNurLdYnRUqcjDZvSm7mVcTndCpQFRfOumDy+7WJNeK+EKuKjO2RHfPfzNbIUTCha6+xNIhgXYhw4puquxzbnBVul+5qVqX+PCHmBMT2+hQ1Hzth4LFCYYcIEnrY8pjcikMkI3C/WUUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj4KcpWFjc1vXSwIqy3PZTe803GPqn3bdrq5I2GGidM=;
 b=D/wGL/UNdcpOuACqGsA4FuI78i69KBOytPEWQqvXefkwHbPalf/K41IFM9X0SbG6+vY1uGCymdOsAoqY6gAlOaw92xjh8viUD1VxZdbYyF2atekV61Dzjj8E/qN6QAS22eY3hwi1LUKhVbzwcrq+DXN11LPtLJbmQNzg2GD/DfHtju3zWGofSFLZW6EhzmT4RC4ktkcx8f+GrnKDu6Rh/wQDmE6eVHqHIL6lLGbdOAAVZz67RWDgpZwlRMYZus4cWKmxiXMqOYsb906ErUt4NuQfWl63tkx4nrOrloXuLhEMTFyf3bfhRwZXs9W0UITkjP10FufkFYc0AJhodh/37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj4KcpWFjc1vXSwIqy3PZTe803GPqn3bdrq5I2GGidM=;
 b=mXRuX89StwTXdOj4tIi8JZ+GYQYAQARh5DeZG9K56h0CEpA4UnBLQn7Fc21fQxg1rskfQN6syAGzOf+2NT0WDgwfhuAMpKJU4o3LLpemb85dEPR0+ZxPh/1dOVxWN8EjxGS5UYJdIvaTNS/xmNZ8YnmYwR05Y33fLrtRFGSeGkc=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:48:27 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::6c) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:48:09 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:05 -0500
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
Subject: [PATCH 52/70] drm/amd/display: Introduce dc_update_state unified
 commit interface
Date: Wed, 15 Jul 2026 21:38:02 +0800
Message-ID: <20260715134432.1975118-53-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: b12cce3e-47f3-4c16-240c-08dee277be56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZcaMNJ11dJfMY6lOE/w54UNqYNeadrgwUIb9lHquaPHdk7x8Hx+kkEXAHlM6leIpMtHuDlwCoyRYzy+YwvHCxcfQOLnU/0FcuWJANYTu6nTxZHNHjegySq36xSV6+TxtH4gwvZb4wXIPURnHIKNIFWy81dPpUgEkFStKgTr8qFTX9pRFs8dohSqbbqqyxZJFdrJJzjbqwB6Q7UfjWgxPtkb/5wGXrwIzX9vK70AtCCXtZ1JMNxUWZPW5qcY1pDWAdhar54t1SA7Kn/W7BjOGCCWgkrTiZ+UrgpByCXQ2u4x+NgQbu7TiV7D7xFnDJeVCE1dOiNoFG9iDylnrNYIVCygJwX1227uPKoccar+YFLWAEv6hTvfLjn18zAo9BSEis99qIqqDy2RPJIQrrV9n612dplKjcrm5lRylyIY3QVYfn+Ys4FbTOtQEVWBbeJrXtzqGzmJAGeWrOKbLCqTgV7YZO+EXckatqIiuYzeNG4YewzQMbcTi8OY7BYMu27J2kgWAyKK7MLALVXCRUjmNCUnHYXHaq0M0lQSI54r5oVXpY0mmHQwKF5wxu4DZISMXvqt7ldnEE9YLZ6HTrXnD50S+H0EF/hQDHE0jB260a6XhId157xAhoZ/ft9/sJdvNjX49J4cnxa6ttsxJzenp0fKtMwrT1bad9RZpTAUqdZqyEMLT1jf00qTuvNxTrDC/HwktI4FkIi8JIT80faj9hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0lS0JHnGi1ptonOrrNl7e3t+Wyn4cGWdLmPcOrTLbVfyR9QwSivWxBuUM6uZ7szisR7/Ibj/Z1UrfrY1yOTA39inVhIwT25XdQC3YmoVkV277zhF8oyS2hwktMd1jQOu3f8Lf8z8GdCKNi6yxJuAn8+sMGWUETUeqkSUXplmoLx5CkSmAqudOoQVwY4FYK06Iws6xzseg7/r/gCSBjsCQaQ6VCeYZWqUt2uEVKuOvnHQe3Kof1GOxnaRg+e4UwhLR2CeBfXXd0zPOPusXsBheEpRWAa0shJ9sHsUQ4kHqRWhCQanauZ8sfOW102fhr4q03W7TacO/AByFiB996O30Fos08FPEO4AsRBZyRGDEj3imT89lXrpbL1/b0QRnw4zzMWxXXo2hkxNWlmbKag0GZwTdrfOxJpSBDQDeDVfATrBbkPmzsozMp4QBuWBqhLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:25.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12cce3e-47f3-4c16-240c-08dee277be56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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
dc_update_planes_and_stream() is typed against surface/stream arrays only,
leaving no extensible slot for future object classes. The public entry
point names and signatures need to stay stable as new object classes are
added.

[How]
Introduce dc_update_state() and dc_check_state_update(), both taking a
dc_state_update root object. dc_update_state() routes stream and plane
updates through the existing pipeline. Keep dc_update_planes_and_stream()
and dc_check_update_surfaces_for_stream() as shims that delegate.

Change dc_update_state_init() to take a const dc_state_update* and rename
dc_update_planes_and_stream_{init,prepare,execute,cleanup} ->
dc_update_state_{init,prepare,execute,cleanup}.

Rename surface_update_type -> dc_update_type and
surface_update_descriptor -> dc_update_descriptor.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 188 ++++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h        |  19 ++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  21 ++-
 3 files changed, 155 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 188615873791..f1805b03f0db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -151,8 +151,8 @@ static const char DC_BUILD_ID[] = "production-build";
 /* Private functions */
 
 static inline void elevate_update_type(
-		struct surface_update_descriptor *descriptor,
-		enum surface_update_type new_type,
+		struct dc_update_descriptor *descriptor,
+		enum dc_update_type new_type,
 		enum dc_lock_descriptor new_locks
 )
 {
@@ -2793,10 +2793,10 @@ static bool is_surface_in_context(
 	return false;
 }
 
-static struct surface_update_descriptor get_plane_info_update_type(const struct dc_surface_update *u)
+static struct dc_update_descriptor get_plane_info_update_type(const struct dc_surface_update *u)
 {
 	struct pipe_update_bits *update_bits = &u->surface->update_bits;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct dc_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->plane_info)
 		return update_type;
@@ -2883,12 +2883,12 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 	return update_type;
 }
 
-static struct surface_update_descriptor get_scaling_info_update_type(
+static struct dc_update_descriptor get_scaling_info_update_type(
 	const struct dc_check_config *check_config,
 	const struct dc_surface_update *u)
 {
 	struct pipe_update_bits *update_bits = &u->surface->update_bits;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct dc_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->scaling_info)
 		return update_type;
@@ -2939,11 +2939,11 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 	return update_type;
 }
 
-static struct surface_update_descriptor det_surface_update(
+static struct dc_update_descriptor det_surface_update(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *u)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct dc_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 	struct pipe_update_bits *update_bits = &u->surface->update_bits;
 
 	if (u->surface->force_full_update) {
@@ -2954,8 +2954,7 @@ static struct surface_update_descriptor det_surface_update(
 
 	dc_pipe_update_bits_clear(update_bits);
 
-	struct surface_update_descriptor inner_type = get_plane_info_update_type(u);
-
+	struct dc_update_descriptor inner_type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
 
 	inner_type = get_scaling_info_update_type(check_config, u);
@@ -3097,13 +3096,13 @@ static void force_immediate_gsl_plane_flip(struct dc *dc, struct dc_surface_upda
 	}
 }
 
-static struct surface_update_descriptor check_update_surfaces_for_stream(
+static struct dc_update_descriptor check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct dc_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	/* When countdown finishes, promote this flip to full to trigger deferred final transition */
 	if (check_config->deferred_transition_state && !check_config->transition_countdown_to_steady_state) {
@@ -3226,7 +3225,7 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
-		struct surface_update_descriptor inner_type =
+		struct dc_update_descriptor inner_type =
 				det_surface_update(check_config, &updates[i]);
 
 		elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
@@ -3238,20 +3237,57 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 /*
  * dc_check_update_surfaces_for_stream() - Determine update type (fast, med, or full)
  *
- * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
+ * See :c:type:`enum dc_update_type <dc_update_type>` for explanation of update types
+ */
+/**
+ * dc_check_state_update - Classify a dc_state_update by locking / re-entrancy requirements.
+ * @check_config:  ASIC capabilities and display configuration context
+ * @updates:       root update object describing the full desired commit
+ *
+ * Determines whether the update requires a fast, medium, or full lock
+ * by inspecting the stream, stream_update, and surface_updates carried on
+ * the root object. Perfmon classification is reserved for a future slice.
+ *
+ * Return: dc_update_descriptor with update_type and lock_descriptor.
  */
-struct surface_update_descriptor dc_check_update_surfaces_for_stream(
+struct dc_update_descriptor dc_check_state_update(
+		const struct dc_check_config *check_config,
+		struct dc_state_update *updates)
+{
+	if (updates->stream_update)
+		stream_update_flags_clear(&updates->stream_update->stream->update_flags);
+	for (int i = 0; i < updates->surface_count; i++)
+		dc_pipe_update_bits_clear(&updates->surface_updates[i].surface->update_bits);
+
+	return check_update_surfaces_for_stream(check_config, updates->surface_updates,
+			updates->surface_count, updates->stream_update);
+}
+
+/**
+ * dc_check_update_surfaces_for_stream - Shim for dc_check_state_update.
+ * @check_config:   ASIC capabilities and display configuration context
+ * @updates:        array of surface update descriptors
+ * @surface_count:  number of entries in @updates
+ * @stream_update:  optional stream update
+ *
+ * Packs the individual arguments into a dc_state_update and forwards to
+ * dc_check_state_update(). Preserved for out-of-tree and incremental callers.
+ *
+ * Return: dc_update_descriptor with update_type and lock_descriptor.
+ */
+struct dc_update_descriptor dc_check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	if (stream_update)
-		stream_update_flags_clear(&stream_update->stream->update_flags);
-	for (int i = 0; i < surface_count; i++)
-		dc_pipe_update_bits_clear(&updates[i].surface->update_bits);
+	struct dc_state_update root = {
+		.surface_updates = updates,
+		.surface_count   = surface_count,
+		.stream_update   = stream_update,
+	};
 
-	return check_update_surfaces_for_stream(check_config, updates, surface_count, stream_update);
+	return dc_check_state_update(check_config, &root);
 }
 
 static struct dc_stream_status *stream_get_status(
@@ -3269,7 +3305,7 @@ static struct dc_stream_status *stream_get_status(
 	return NULL;
 }
 
-static const enum surface_update_type update_surface_trace_level = UPDATE_TYPE_FULL;
+static const enum dc_update_type update_surface_trace_level = UPDATE_TYPE_FULL;
 
 static void copy_surface_update_to_plane(
 		struct dc_plane_state *surface,
@@ -3737,13 +3773,13 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type *new_update_type,
+		enum dc_update_type *new_update_type,
 		struct dc_state **new_context)
 {
 	struct dc_state *context;
 	int i;
 	unsigned int j;
-	enum surface_update_type update_type;
+	enum dc_update_type update_type;
 	const struct dc_stream_status *stream_status;
 	struct dc_context *dc_ctx = dc->ctx;
 
@@ -4152,7 +4188,7 @@ static void add_link_update_dsc_config_sequence(
 static void commit_planes_do_stream_update_sequence(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type,
+		enum dc_update_type update_type,
 		struct dc_state *context,
 		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		unsigned int *num_steps)
@@ -4323,7 +4359,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type,
+		enum dc_update_type update_type,
 		struct dc_state *context)
 {
 	unsigned int j;
@@ -4726,7 +4762,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type,
+		enum dc_update_type update_type,
 		struct dc_state *context)
 {
 	int i;
@@ -4846,7 +4882,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type,
+		enum dc_update_type update_type,
 		struct dc_state *context)
 {
 	int i;
@@ -5929,7 +5965,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *context;
-	enum surface_update_type update_type;
+	enum dc_update_type update_type;
 	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
@@ -6014,7 +6050,7 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type)
+		enum dc_update_type update_type)
 {
 	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
@@ -6046,7 +6082,7 @@ static void commit_planes_and_stream_update_with_new_context(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type update_type,
+		enum dc_update_type update_type,
 		struct dc_state *new_context)
 {
 	bool skip_new_context = false;
@@ -6114,7 +6150,7 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *new_context;
-	enum surface_update_type update_type;
+	enum dc_update_type update_type;
 
 	/*
 	 * When this function returns true and new_context is not equal to
@@ -6160,28 +6196,61 @@ static void clear_update_bits(struct dc_surface_update *srf_updates,
 			dc_pipe_update_bits_clear(&srf_updates[i].surface->update_bits);
 }
 
+/**
+ * dc_update_state - Commit an absolute dc_state_update.
+ * @dc:      DC structure
+ * @updates: root update object carrying stream, plane, and probe updates
+ *
+ * When stream is non-NULL the stream and its plane updates are committed via
+ * the init/prepare/execute/cleanup pipeline. Probe commit is reserved for a
+ * future slice. dc_update_planes_and_stream() is now a shim over this function.
+ *
+ * Return: true on success, false on failure.
+ */
+bool dc_update_state(struct dc *dc, struct dc_state_update *updates)
+{
+	if (updates->stream != NULL) {
+		struct dc_update_scratch_space *scratch = dc_update_state_init(dc, updates);
+		bool more = true;
+
+		while (more) {
+			if (!dc_update_state_prepare(scratch))
+				return false;
+
+			dc_update_state_execute(scratch);
+			more = dc_update_state_cleanup(scratch);
+		}
+	}
+
+	return true;
+}
+
+/**
+ * dc_update_planes_and_stream - Shim for dc_update_state.
+ * @dc:             DC structure
+ * @srf_updates:    array of surface update descriptors
+ * @surface_count:  number of entries in @srf_updates
+ * @stream:         target stream
+ * @stream_update:  optional stream update
+ *
+ * Packs the individual arguments into a dc_state_update and forwards to
+ * dc_update_state(). Preserved for out-of-tree and incremental callers.
+ *
+ * Return: true on success; false on failure.
+ */
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update)
 {
-	struct dc_update_scratch_space *scratch = dc_update_planes_and_stream_init(
-			dc,
-			srf_updates,
-			surface_count,
-			stream,
-			stream_update
-	);
-	bool more = true;
-
-	while (more) {
-		if (!dc_update_planes_and_stream_prepare(scratch))
-			return false;
+	struct dc_state_update updates = {
+		.stream          = stream,
+		.stream_update   = stream_update,
+		.surface_updates = srf_updates,
+		.surface_count   = surface_count,
+	};
 
-		dc_update_planes_and_stream_execute(scratch);
-		more = dc_update_planes_and_stream_cleanup(scratch);
-	}
-	return true;
+	return dc_update_state(dc, &updates);
 }
 
 void dc_commit_updates_for_stream(struct dc *dc,
@@ -8114,7 +8183,7 @@ struct dc_update_scratch_space {
 	struct dc_stream_update *stream_update;
 	bool update_v3;
 	bool do_clear_update_bits;
-	enum surface_update_type update_type;
+	enum dc_update_type update_type;
 	struct dc_state *new_context;
 	enum update_v3_flow flow;
 	struct dc_state *backup_context;
@@ -8417,23 +8486,20 @@ static bool update_planes_and_stream_cleanup_v3(
 	return false;
 }
 
-struct dc_update_scratch_space *dc_update_planes_and_stream_init(
+struct dc_update_scratch_space *dc_update_state_init(
 		struct dc *dc,
-		struct dc_surface_update *surface_updates,
-		int surface_count,
-		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update
+		const struct dc_state_update *updates
 )
 {
 	const enum dce_version version = dc->ctx->dce_version;
-	struct dc_update_scratch_space *scratch = stream->update_scratch;
+	struct dc_update_scratch_space *scratch = updates->stream->update_scratch;
 
 	*scratch = (struct dc_update_scratch_space){
 		.dc = dc,
-		.surface_updates = surface_updates,
-		.surface_count = surface_count,
-		.stream = stream,
-		.stream_update = stream_update,
+		.surface_updates = updates->surface_updates,
+		.surface_count = updates->surface_count,
+		.stream = updates->stream,
+		.stream_update = updates->stream_update,
 		.update_v3 = version >= DCN_VERSION_4_01 || version == DCN_VERSION_3_2 || version == DCN_VERSION_3_21,
 		.do_clear_update_bits = version >= DCN_VERSION_1_0,
 	};
@@ -8441,7 +8507,7 @@ struct dc_update_scratch_space *dc_update_planes_and_stream_init(
 	return scratch;
 }
 
-bool dc_update_planes_and_stream_prepare(
+bool dc_update_state_prepare(
 		struct dc_update_scratch_space *scratch
 )
 {
@@ -8450,7 +8516,7 @@ bool dc_update_planes_and_stream_prepare(
 			: update_planes_and_stream_prepare_v2(scratch);
 }
 
-void dc_update_planes_and_stream_execute(
+void dc_update_state_execute(
 		const struct dc_update_scratch_space *scratch
 )
 {
@@ -8459,7 +8525,7 @@ void dc_update_planes_and_stream_execute(
 			: update_planes_and_stream_execute_v2(scratch);
 }
 
-bool dc_update_planes_and_stream_cleanup(
+bool dc_update_state_cleanup(
 		struct dc_update_scratch_space *scratch
 )
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3e22c1f8d4db..f06539df7f0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -519,7 +519,7 @@ struct dc_static_screen_params {
  * underscan we don't expect to see this call at all.
  */
 
-enum surface_update_type {
+enum dc_update_type {
 	UPDATE_TYPE_FAST, /* super fast, safe to execute in isr */
 	UPDATE_TYPE_MED,  /* ISR safe, most of programming needed, no bw/clk change*/
 	UPDATE_TYPE_FULL, /* may need to shuffle resources */
@@ -532,8 +532,8 @@ enum dc_lock_descriptor {
 	LOCK_DESCRIPTOR_GLOBAL = 0x4,
 };
 
-struct surface_update_descriptor {
-	enum surface_update_type update_type;
+struct dc_update_descriptor {
+	enum dc_update_type update_type;
 	enum dc_lock_descriptor lock_descriptor;
 };
 
@@ -2114,6 +2114,19 @@ struct dc_state_update {
 	const struct dc_probe_updates *probe_updates;
 };
 
+/**
+ * dc_update_state - Commit an absolute dc_state_update.
+ * @dc:      DC structure
+ * @updates: root update object carrying stream, plane, and probe updates
+ *
+ * When stream is non-NULL the stream and its plane updates are committed via
+ * the init/prepare/execute/cleanup pipeline. Probe commit is reserved for a
+ * future slice. dc_update_planes_and_stream() is now a shim over this function.
+ *
+ * Return: true on success, false on failure.
+ */
+bool dc_update_state(struct dc *dc, struct dc_state_update *updates);
+
 struct dc_underflow_debug_data {
 	struct dcn_hubbub_reg_state *hubbub_reg_state;
 	struct dcn_hubp_reg_state *hubp_reg_state[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 8b164edc9c51..a866688ad9db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -409,29 +409,27 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_stream_update *stream_update);
 
 struct dc_update_scratch_space;
+struct dc_state_update;
 
 size_t dc_update_scratch_space_size(void);
 
-struct dc_update_scratch_space *dc_update_planes_and_stream_init(
+struct dc_update_scratch_space *dc_update_state_init(
 		struct dc *dc,
-		struct dc_surface_update *surface_updates,
-		int surface_count,
-		struct dc_stream_state *dc_stream,
-		struct dc_stream_update *stream_update
+		const struct dc_state_update *updates
 );
 
 // Locked, false is failed
-bool dc_update_planes_and_stream_prepare(
+bool dc_update_state_prepare(
 		struct dc_update_scratch_space *scratch
 );
 
 // Unlocked
-void dc_update_planes_and_stream_execute(
+void dc_update_state_execute(
 		const struct dc_update_scratch_space *scratch
 );
 
 // Locked, true if call again
-bool dc_update_planes_and_stream_cleanup(
+bool dc_update_state_cleanup(
 		struct dc_update_scratch_space *scratch
 );
 
@@ -518,7 +516,12 @@ void dc_enable_stereo(
 /* Triggers multi-stream synchronization. */
 void dc_trigger_sync(struct dc *dc, struct dc_state *context);
 
-struct surface_update_descriptor dc_check_update_surfaces_for_stream(
+struct dc_update_descriptor dc_check_state_update(
+		const struct dc_check_config *check_config,
+		struct dc_state_update *updates);
+
+/* Shim: packs args into dc_state_update and calls dc_check_state_update(). */
+struct dc_update_descriptor dc_check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-- 
2.43.0

