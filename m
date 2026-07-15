Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042F4C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9748D10F0A5;
	Wed, 15 Jul 2026 13:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u31oCY1M";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B65910F0A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQsmy5Urv+CF5Kcv58MexwF07OP4wuiGBMSncAzuyd98wLX9C+6LXqvnqAmBBlYzcKKJISsbQvbjubbHMjdNygrPeBG/EH6bppmKe3ZnVgr0Y7fHHE9ux1QUZ2MhFYqKTbH1sG+gcQXfVxTlEVrgw0jd1LgWjq55PFpjqlJvasegciKHbfP3tKeMm4KZtY5jE2/TSv73JbKJIQwK+i+ovKD1v0PCiR1eoMNaOpMmNBJDfFxqw9s81LkSe7FN3bboohi7+q9U8XtYrvb+iGwLXwyo2HMfUR5xL6szt3wQt6JeOFWpVpJZZ2kyv4gKfAcWgvu8WI26hBPUQ56F2QGFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYsdaI+mc+yRdx35fLqCany9utoC9knWc3aacPdNczc=;
 b=crJ+cpWNM/uXHtd7FSyBWxCn9S7774J8+Ual+wSzfQaexQbs5eF5sIp+Q2UaX+8J86LviOxZ0avRqtQUQdahG5Z30Fw6vBt0rW69yq9FeMmK5DHaGE0118QrYhVrcZzw0KrVjFAt9rTbJCUXiZzCbj6UaLtLGitcX+bKUELsuCTXUHMRkknydnmB0PCBdkPuudemhcOd65IkUtzSahjdUDpRXpYghusBG1qvKh5FuiuC0K2h8OAdtalZwRE6QAwZ+PiTOxkS2ZMoyUH26saK69dOZd4CTN2yLovXA/GhFWNuXLvPGK8DJMg8uZe7hMLvTp9BDVA/pSYmXgoAEh7aiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYsdaI+mc+yRdx35fLqCany9utoC9knWc3aacPdNczc=;
 b=u31oCY1MDlfvSbi9I4SPjPZgiSjtntwWe8U/7n582vMAB/Kn6bQW2yI1ilOSBi4tYq5hUqK70iA3sVHDAni+WQI86tE0koLCeYSldPaveD7pkPHkwj2KD90w/j9Ko3+OqbUXehPRzOF8PdTc13zGFtmNU4rQtXBg+Pnc3XktdrU=
Received: from DS7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::15) by
 MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 13:48:34 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::4d) by DS7P220CA0083.outlook.office365.com
 (2603:10b6:8:259::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:28 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:25 -0500
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
Subject: [PATCH 57/70] drm/amd/display: Make dc_state_update const in commit
 path
Date: Wed, 15 Jul 2026 21:38:07 +0800
Message-ID: <20260715134432.1975118-58-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a7fdb0-16d0-4beb-c179-08dee277c396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QZWfjNo6Sb7E3CyWed55UthYGZkHCfmZv4tHAX+tntFzrx3du/KVEUgsZ7IHggH6P5FqUrY2IwNrPAUAy9f9SX+782MAfqnZMEO3TqHoTrMAk/MxP7/X8BB7k1qKvSpUR477+3wcNobLosdYTOOyeXjM9+SmSMuRQXl9I9zM1iR5jrkCxvR0Eo0t1ktILCnZJjLkT/W5EzhQGKy1YhT+X7snA5yq2msmVKsxYlXkUwiv3vlcstssV1B+l6Sh9OV45Xz0X8P97Cu5cu4O3H98KDm28nod/0Fo1BWJncBX9DXnGufU0npE+V/dBfjF6HkoGe1lZtsvWu2ffDlPBGNAnLY5HUX7LoqdKtKzu5pOIwHpbQj2C0lGsVm7g1LLUqD5x6fw66ryoanJiP9mtQ5ZxFkLE/qpcTtnmOSqXyN5A/r71wUi+HmXLF2rc9QVITQ2W2uSvlg6dX/h0KgA29cKtImG8UqG5+tKfoqKz7Csobcao+gvLen6AIm5vhQKTQ819gVywPzlZaEgag6hl4VAxtSClFtaKFhT299917RsYN47pfoNraj+nHcddNonnV9gBSi82R9dyIqu681tp0/E/1gLgw5R/gXzn23sCG+NpWnEEVkFJNXoWhNrSgv6odgLNnUPmEO/G26iyJ89MJz9mBD+vLYoYg/26o44kQcfIaz32UwN0ddZCqKw1cpQP3Er3NijlVikrTGOSNm1eqQGUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Ma09WUUwE0VeqrcXJ4Djg9ox0h1hpYUhcg2SxGF6eR2QcS6xAeujWbokSa6bnD2YwP3vSrkIJ+Uq78/hcMrPcjnvIMFWdfda7IYK1ZCQkzC4VNAYAksmYgGbqLtcVV0vKou5ZhKE9FQdlFHsJeNHLgcDGCcfm43iTLbsHewUElzk4RvC7Wa4063QbfCsfCgmNUsIuBF+ZuvrySt5QqKpeuwGs7ekfko06TE/XeOBOTQXBn0mlI/pIHSzvj9obmZ4lWSBepRQg9J7kE5IkEXw0ELjrMZJ8XYroi9WaQmiIc0eUdg1bdAHniqf4lgoOwAUSKgiidq9grPiPfgBvfmR/9efZcSlF4UoHs3pFyxs1sopfwRwdaVHUZ3rgNrsnuyX3P9CHNQGJnjHPhmQL3Te4db65b4i2cVqE3pfzaMNNDcpPKhIB+rjGAHUd4LWoLa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:34.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a7fdb0-16d0-4beb-c179-08dee277c396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
The state-update commit path only reads the caller's update
descriptor, it never mutates the dc_state_update root. Making the
pointer const documents that contract.

[How]
Add const to the updates parameter of dc_update_state and
dc_check_state_update. Mark the single-assignment locals in
dc_update_state_init const and replace the memset plus
field-by-field assignment with a compound literal initializer.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 42 ++++++++++++------------
 drivers/gpu/drm/amd/display/dc/dc.h      |  4 +--
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2bd579340b64..318c3b28e918 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3282,7 +3282,7 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
  */
 struct dc_update_descriptor dc_check_state_update(
 		const struct dc_check_config *check_config,
-		struct dc_state_update *updates)
+		const struct dc_state_update *updates)
 {
 	struct dc_update_descriptor desc = {0};
 
@@ -6264,7 +6264,7 @@ static void dc_update_scratch_release(struct dc *dc,
  * @updates: root update object carrying stream, plane, and probe updates
  * Return: true on success, false on failure.
  */
-bool dc_update_state(struct dc *dc, struct dc_state_update *updates)
+bool dc_update_state(struct dc *dc, const struct dc_state_update *updates)
 {
 	struct dc_update_scratch_space *scratch;
 	bool more = true;
@@ -8525,11 +8525,11 @@ struct dc_update_scratch_space *dc_update_state_init(
 {
 	const enum dce_version version = dc->ctx->dce_version;
 	struct dc_update_scratch_space *scratch = dc_update_scratch_acquire(dc);
-	bool has_stream_or_plane = updates->stream || updates->stream_update || updates->surface_updates;
-	bool has_probe = updates->probe_updates;
-	bool surface_without_stream = updates->surface_updates && !updates->stream;
-	bool stream_update_without_stream = updates->stream_update && !updates->stream;
-	bool bad_surface_count = updates->surface_count > 0 && !updates->surface_updates;
+	const bool has_stream_or_plane = updates->stream || updates->stream_update || updates->surface_updates;
+	const bool has_probe = updates->probe_updates;
+	const bool surface_without_stream = updates->surface_updates && !updates->stream;
+	const bool stream_update_without_stream = updates->stream_update && !updates->stream;
+	const bool bad_surface_count = updates->surface_count > 0 && !updates->surface_updates;
 
 	if (!scratch)
 		return NULL;
@@ -8544,20 +8544,20 @@ struct dc_update_scratch_space *dc_update_state_init(
 		return NULL;
 	}
 
-	memset(scratch, 0, sizeof(*scratch));
-
-	scratch->dc = dc;
-	scratch->surface_updates = updates->surface_updates;
-	scratch->surface_count = updates->surface_count;
-	scratch->stream = updates->stream;
-	scratch->stream_update = updates->stream_update;
-	scratch->probe_updates = updates->probe_updates;
-	scratch->update_v3 = version >= DCN_VERSION_4_01
-			|| version == DCN_VERSION_3_2
-			|| version == DCN_VERSION_3_21;
-	scratch->do_clear_update_bits = version >= DCN_VERSION_1_0;
-	scratch->new_context = NULL;
-	scratch->flow = UPDATE_V3_FLOW_INVALID;
+	*scratch = (struct dc_update_scratch_space){
+		.dc = dc,
+		.surface_updates = updates->surface_updates,
+		.surface_count = updates->surface_count,
+		.stream = updates->stream,
+		.stream_update = updates->stream_update,
+		.probe_updates = updates->probe_updates,
+		.update_v3 = version >= DCN_VERSION_4_01
+				|| version == DCN_VERSION_3_2
+				|| version == DCN_VERSION_3_21,
+		.do_clear_update_bits = version >= DCN_VERSION_1_0,
+		.new_context = NULL,
+		.flow = UPDATE_V3_FLOW_INVALID,
+	};
 
 	return scratch;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0913fab7504c..743dde3d10ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2125,7 +2125,7 @@ struct dc_state_update {
  */
 struct dc_update_descriptor dc_check_state_update(
 		const struct dc_check_config *check_config,
-		struct dc_state_update *updates);
+		const struct dc_state_update *updates);
 
 /**
  * dc_update_state - Commit an absolute dc_state_update.
@@ -2134,7 +2134,7 @@ struct dc_update_descriptor dc_check_state_update(
  *
  * Return: true on success, false on failure.
  */
-bool dc_update_state(struct dc *dc, struct dc_state_update *updates);
+bool dc_update_state(struct dc *dc, const struct dc_state_update *updates);
 
 struct dc_update_scratch_space;
 
-- 
2.43.0

