Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D37FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BF9112C02;
	Mon, 22 Apr 2024 15:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20D9RugT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E71112C02
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIjxj0KdwKPDZuiHtcLmgXL0asj9qxMi/rIfMlg9OF/eFX5YIxdfEz1mCfuOhNH5LFr2o8ykCXheWnl7druJ7iW9gcUREavqLcuovaJdToJTYK3Ogp6douq3dtMdOLRxGv4z5//1CttJlsdw0oQTYTYI+XfKsgFPfqeZKUYgi+3Wq5T9rfY0qaaP/ktgz+5VTfwj5VvzovKjm4xHlQ5CydMRRjt7mcMul6H2DA02/O2K5f1f9LES87hIw+obFNRjABiPk+11POSo2V1PwNjmk9JuwWcd/q+cMs75MIlhhhTrZIKmwZoDVBwaTkIz5y/hsy4UZCIsl19aZ3ZOTrWiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17KClMXK4koi76I0T8wCH/at3AB13GVbLeFm1ZjAj1s=;
 b=itB7586/1nL3FD7lNezHKYA2OtBCjnaGqqvd3YpyL5uFDirPNgNz/gMt0CjxG7qHxM0zyIZ7PivQFZhIq+cXhTpz991mebUGhKD3rqUnp/0vW0DpSWKuNyXt4qfnmUV0yKsr/0KYqLU3S1XKaeassT0c74J1RZFIZcJAq2CjjhkIdGrDZ4JT7TCa5fOfoPcXwYbYAQLGCMagaB+oLH2MC4uikXOqkWjKO/Zv8v9ilWu2psczpR1Rj27TJNYTas9z2U1GKn2RAX6g3FhJrdHJgiAcSvBLG8LPLAw7UhJ+eE4Ik0hwlGZPxHoj4eCdjdAI1Tq73KAhAG3hiiFVXxbAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17KClMXK4koi76I0T8wCH/at3AB13GVbLeFm1ZjAj1s=;
 b=20D9RugTcLQGZFT/cXXjkcSfB/6Kg/NJHuM49+jWtPbM1j02shw6aAY/mv6GUan6BXVDzMjgy0Z3RsOKzahHFfEj/UIzWu2PwDxV0h4FdMsK5FmCHNjFp2MG3W72y8dgHkmZRDaxXmfJEZ8JarM7Gpw6yFAUE92fhkmVoV4xoh4=
Received: from CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 22 Apr
 2024 15:31:09 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::6f) by CH0PR04CA0023.outlook.office365.com
 (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:09 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 "Daniel Wheeler" <daniel.wheeler@amd.com>
Subject: [PATCH 29/37] drm/amd/display: Separate setting and programming of
 cursor
Date: Mon, 22 Apr 2024 11:27:38 -0400
Message-ID: <20240422152817.2765349-30-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5e2b6-d38b-40bb-1070-08dc62e13c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JGp7p+LoX8SfLqsPWp1NH112YJtDdWdIVgQH0CzOHUXB1UgDhyVe1ztK6cuJ?=
 =?us-ascii?Q?3l0WbkzaQJREpO3BcRsepoyc+vrQSyldvc/pfF2B0/15iTz4VLDuiRzgmaqH?=
 =?us-ascii?Q?yRMOGVdqQ6oEaKHALz0yz9HmdnDSt0cg4BydNfk7ZB6VBuSKdOQPp0zrNw/n?=
 =?us-ascii?Q?gZug49nBVBEMkhpM2LVzT3idC2XwUb9ZiPBjDeipkUKtBFoUI3PkUWCCqB8Q?=
 =?us-ascii?Q?IOpA9OeDmO0Z/H61xn+SI5DifOFgzbu+K9711BJ69wWYQqTL+LPJSDsOiFv2?=
 =?us-ascii?Q?QaArLAyiach+0lg/8qIOdt3Jo4RqoiN8qohJletXSitmV3QfOvFTiiX0r9Gz?=
 =?us-ascii?Q?StWHpIlGSGxwHTKLgLVlrMH/ubPnhi+ph/NkezQ8aNbvHWcMgU66wbxOqSla?=
 =?us-ascii?Q?ifCWKR+on1kWY7q3rD6RDHaWgUAvhm8cyHKpFaJ6XJn3TQLiGVCn3ssN/WYz?=
 =?us-ascii?Q?bfjF9hhRWwXBezKjvUuXM3l+ZdhiVvCn8eUeoAtYChaMar0S2Giv8iOrJZME?=
 =?us-ascii?Q?KZ1vWY6fQmsUiGdB3yMLEQmKg11X0mGjDu/PI5QBZStLw9goDubXQsU3RK9G?=
 =?us-ascii?Q?HS556Mp35qIOi3yYheaErL2M/XPDawf/muQx9Zcud/Ztti/R00BfVVo/Ui0a?=
 =?us-ascii?Q?q0U+f2H1FGy9RLtDx+7rANURqewZFF3kwsQa1U4sz9pi07VuU2gDZosbOlJT?=
 =?us-ascii?Q?ZdVBQtCuMD56XZfeXuVMVowHsdChdKFFQ4w0/7P2rBe41GrS0EuRlzvq746G?=
 =?us-ascii?Q?YR1uLvNbCVh2ljGbjjpLDAaUAwIX5fUUQSBKcZ9qreDf74/Y8HLrbcWX1zJc?=
 =?us-ascii?Q?EIjcD7vKWaXcyG80cJli+hZCaCNnAdDly8lm2HpjDouF/0e/PH5/fnsh8QCz?=
 =?us-ascii?Q?4bf8neHH0gHVwNzojLD7HXW/+kcRGoIegEATa4eBtrnTk4DApnk+nJWZCKry?=
 =?us-ascii?Q?uusYzaw+i1XUPxQmqTIL5RjUzsCYQOY7jeukDD5JITXJ5GqIEv08a4ALvtDS?=
 =?us-ascii?Q?n4EavYt135m6Q6r8Wdbu0STctBQE7W3MoonxQhrH2WkbRdz5dhrrZziWrcyx?=
 =?us-ascii?Q?eBZn/Up59Ms5TzO8dfBltEr33PjFpY5iGjeT5tWSbInaZ4oz07fajSYJAj5u?=
 =?us-ascii?Q?B4vDL4lW4s7dxzKXH+FvEaHKjW3xvtbmKllDeLC7aZpq6stoxni+19s8wuj+?=
 =?us-ascii?Q?SdBK5GcZudxPSXwa7w5usRfuchZHh0dgmNjBLburDOzPGsBohcrUzZKk5ujY?=
 =?us-ascii?Q?iLljjfWSj1KC0EUy2SQE+KlXr/hEcTrLIML7RWlPAENv6G4i0g/KfNswzWu/?=
 =?us-ascii?Q?4f1QOr+zQ4JRZBXHcYsX01M2b9kpnlUCO4ejMpt83ScGrjYgQvUezEV5J+fY?=
 =?us-ascii?Q?svt7OlVabX3pasyNSdb0iOMiOMLM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:09.6744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5e2b6-d38b-40bb-1070-08dc62e13c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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

From: Harry Wentland <harry.wentland@amd.com>

We're seeing issues when user-space tries to do an atomic update of
the primary surface, as well as the cursor. These two updates are
separate calls into DC and don't currently act as an atomic update.
This might lead to cursor updates being locked out and cursors
stuttering.

In order to solve this problem we want to separate the setting
and programming of cursor attributes and position. That's what
we're doing in this patch. The subsequent patch will then be
able to use the cursor setters in independent cursor updates,
as well as in atomic commits.

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 87 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  8 ++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  2 +-
 5 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a5dc0081d4b6..7481440ab124 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8964,7 +8964,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 			memset(&position, 0, sizeof(position));
 			mutex_lock(&dm->dc_lock);
-			dc_stream_set_cursor_position(dm_old_crtc_state->stream, &position);
+			dc_stream_program_cursor_position(dm_old_crtc_state->stream, &position);
 			mutex_unlock(&dm->dc_lock);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 49531434f9cf..3c03f690852c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1269,7 +1269,7 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		/* turn off cursor */
 		if (crtc_state && crtc_state->stream) {
 			mutex_lock(&adev->dm.dc_lock);
-			dc_stream_set_cursor_position(crtc_state->stream,
+			dc_stream_program_cursor_position(crtc_state->stream,
 						      &position);
 			mutex_unlock(&adev->dm.dc_lock);
 		}
@@ -1299,11 +1299,11 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
-		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
+		if (!dc_stream_program_cursor_attributes(crtc_state->stream,
 							 &attributes))
 			DRM_ERROR("DC failed to set cursor attributes\n");
 
-		if (!dc_stream_set_cursor_position(crtc_state->stream,
+		if (!dc_stream_program_cursor_position(crtc_state->stream,
 						   &position))
 			DRM_ERROR("DC failed to set cursor position\n");
 		mutex_unlock(&adev->dm.dc_lock);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index d3201b0b3a09..3ac1fec4bf53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -268,7 +268,6 @@ bool dc_stream_set_cursor_attributes(
 	const struct dc_cursor_attributes *attributes)
 {
 	struct dc  *dc;
-	bool reset_idle_optimizations = false;
 
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
@@ -299,20 +298,36 @@ bool dc_stream_set_cursor_attributes(
 
 	stream->cursor_attributes = *attributes;
 
-	dc_z10_restore(dc);
-	/* disable idle optimizations while updating cursor */
-	if (dc->idle_optimizations_allowed) {
-		dc_allow_idle_optimizations(dc, false);
-		reset_idle_optimizations = true;
-	}
+	return true;
+}
 
-	program_cursor_attributes(dc, stream, attributes);
+bool dc_stream_program_cursor_attributes(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes)
+{
+	struct dc  *dc;
+	bool reset_idle_optimizations = false;
 
-	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
-		dc_allow_idle_optimizations(dc, true);
+	dc = stream ? stream->ctx->dc : NULL;
 
-	return true;
+	if (dc_stream_set_cursor_attributes(stream, attributes)) {
+		dc_z10_restore(dc);
+		/* disable idle optimizations while updating cursor */
+		if (dc->idle_optimizations_allowed) {
+			dc_allow_idle_optimizations(dc, false);
+			reset_idle_optimizations = true;
+		}
+
+		program_cursor_attributes(dc, stream, attributes);
+
+		/* re-enable idle optimizations if necessary */
+		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
+			dc_allow_idle_optimizations(dc, true);
+
+		return true;
+	}
+
+	return false;
 }
 
 static void program_cursor_position(
@@ -357,9 +372,6 @@ bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position)
 {
-	struct dc *dc;
-	bool reset_idle_optimizations = false;
-
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
 		return false;
@@ -370,24 +382,43 @@ bool dc_stream_set_cursor_position(
 		return false;
 	}
 
+	stream->cursor_position = *position;
+
+
+	return true;
+}
+
+bool dc_stream_program_cursor_position(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_position *position)
+{
+	struct dc *dc;
+	bool reset_idle_optimizations = false;
+	const struct dc_cursor_position *old_position;
+
+	old_position = stream ? &stream->cursor_position : NULL;
 	dc = stream->ctx->dc;
-	dc_z10_restore(dc);
 
-	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
-			&& position->enable) {
-		dc_allow_idle_optimizations(dc, false);
-		reset_idle_optimizations = true;
-	}
+	if (dc_stream_set_cursor_position(stream, position)) {
+		dc_z10_restore(dc);
 
-	stream->cursor_position = *position;
+		/* disable idle optimizations if enabling cursor */
+		if (dc->idle_optimizations_allowed &&
+		    (!old_position->enable || dc->debug.exit_idle_opt_for_cursor_updates) &&
+		    position->enable) {
+			dc_allow_idle_optimizations(dc, false);
+			reset_idle_optimizations = true;
+		}
 
-	program_cursor_position(dc, stream, position);
-	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
-		dc_allow_idle_optimizations(dc, true);
+		program_cursor_position(dc, stream, position);
+		/* re-enable idle optimizations if necessary */
+		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
+			dc_allow_idle_optimizations(dc, true);
 
-	return true;
+		return true;
+	}
+
+	return false;
 }
 
 bool dc_stream_add_writeback(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3d0adf8838ca..8dd65a95d84b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -484,10 +484,18 @@ bool dc_stream_set_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes);
 
+bool dc_stream_program_cursor_attributes(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes);
+
 bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position);
 
+bool dc_stream_program_cursor_position(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_position *position);
+
 
 bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 				struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 40391dd16944..701001ae99be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1038,7 +1038,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 					/* Use copied cursor, and it's okay to not switch back */
 					cursor_attr.address.quad_part = cmd.mall.cursor_copy_dst.quad_part;
-					dc_stream_set_cursor_attributes(stream, &cursor_attr);
+					dc_stream_program_cursor_attributes(stream, &cursor_attr);
 				}
 
 				/* Enable MALL */
-- 
2.44.0

