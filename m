Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42289C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B497010F720;
	Thu, 24 Sep 2026 18:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHQ4T/Xo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F1B10F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilU7907RntCsHAZZuOLeNzeJvsqD1SMNPElfBdn/GSWEyvHCtc2+5XggcBJrgvEPZOCwpjI/UoMmPbdT2NYCLHd+KUBfekd91mUwb+G6YgTR0UHeu5eEf4YfhqCzPEApziAh4xcCgcNRmptLeQGIffdmvKCT61S1JHM+4YfoCTCDj5kHclx+AMS/J4ut7DJskDbUtngfRQ5SsJhTF0UXqQ7mqilDt5xcCE4vw0tz5FHgrmkT7H6JOXh/UCAbj9SavQcPHQdQHS2VYmKnqYGCWpTXRaLm1PXyDRbrdfw1JGFZMlI4IsJeFKpamRoUWX7ErPnj6poNWzuo3PfKpMJbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov58xHiokiVGya/JkZOz5OgMnwxc+Pb/nMue71J3t/I=;
 b=v7AUkPBAWt/UYze7y4KJBML9h9lGY5u2KnDq365gjrWz9C5T0sBPbE5+L6o+CVQ0GTId778kTjFZRGHGsqr2685a6l+hJzzdyC5BNlZbEaJhfS/mAfImGxfTqjZI8Ro1X4lthaEToQY3G+IsgHXIE80Z0na9AV+nO6vLM2YqhVn50zOkN9upA5cE6e0bZaP66RMv+xz8+sWNP1z9F+jvSiZ1KnM7ju0xt21V0otOvwElwglxyvA032zySFCZBYuZFhDq0n3CGK17WSE0DrdlU7aV2SaKKUG7D2D2iaymKOgsSCC68Oq1GvY3OAL+uP1Lcd1XeYSZ3hvaT4kE3DHB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov58xHiokiVGya/JkZOz5OgMnwxc+Pb/nMue71J3t/I=;
 b=zHQ4T/XoFUUNje/Fyf9c7SjhHJNkZCZzlvoRi+UPba3THo7yCqH7+iRi4YzsFG7o4gSBbu7PHj2eg9IIF4T5Kz85HDjzfFHLUEJVLq0pgZyxHuZOkCCfoEmwynYoyiCB2n/mLCkjB9m76wRYS1WVqHzxNFjLMaO5Rj9o1w0josM=
Received: from PH8P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::23)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:30 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::2d) by PH8P221CA0006.outlook.office365.com
 (2603:10b6:510:2d8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:30 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:14 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 19/34] drm/amd/display: Rename
 HUBBUB_FORCE_PSTATE_CHANGE_CONTROL wait field
Date: Thu, 24 Sep 2026 14:45:32 -0400
Message-ID: <20260924184824.596894-20-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b1f1cf-8ba2-4e2e-1306-08df1a6c25e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I1bVwM0D95anGSw9YryhN5RTPtkzEtmK9BB0su1td7+V4SqsZuneNNRnLayO2PYcWrECMO/0hRPVkvvFcO5pqBdBJJY6d3L+t7JHQdxwg2OAxbNr7U/NrzO+nNnTZaR4cEoc/DSAeuebRk57swdx+9Zp/Uur4Z0dcYcCQ5O0XO0nNpWX4y5kwAtmFAJI9C7aW2CiFDEBz6I06+JnZZve1PU/Exq7cKFKCenhuqZDTg90r/TGbRu0ZHSKZNZV0GZpSOpTznxQD4hQdARcvlgEFKgXbSiZbQx7lVkcEus2VCgqEW9X2LQugxLsfMIgPnkk7k0Rme1f62fFoIZ5G2c6SUMlMgFnAyjTV31KTqOkadyD/R0Udql9ieJ4lXhc/qFwV5dGIaq3FrRBFkhILTTKeO9aSIjCSrNkAj2NtQSTQbnDCUqVS/nHuJdZyfSfiVE0IRVOj4haIOpEBEo+Ge8ZqE1jXaAgPOXYuZm4rLG6Yp4zKWMtldBNGKN8h+HaHpns0hqzedJwaHxo5fqgiS1NIBP4XuifmHf1HO2NT/Q+g6Z6hy7ZbdaxPzdrxGsJbjY4uzNphDOjlBEz5svLofiGNeYWY/RPa+0IZP/XtfBEyA9HVaX2tEoGKCXPTWVsOWlNFXscRZsLWqbTkwKzHcDfctUZu1Supp2FYF+dsn9gtsltY8CBO1PbRE/+1hlOBT+Ul/FnMPkwTMIwrwHG7cMV4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pMZ+8CczzHZznOItbmGbV7+/F/1yWqjSO974PNNY0Nu1iXnlQ3yqIH3O6Jcj+gC5PGLewYcXVCUkJRYyfZ+oP+e4gAUp8jKtxibXuScaiKlSPKUyRZQJfGZZ5AdY0+DMiuk3Yg+ZJ22UxXFBoPaGE74lqKbKhoh0/+82Bvo6hfVE5o3V981IVqSFB+HogSOgQ8Sd3z0Hq1Jxk+J2MH7Ye7R0qtVAvn2IEEul+EsNeMUzFgryXknkqLXyIWO47MC/5TbwivhKobbE7uumrufZpjPOMFMFvTSUD5QX28+dFUvS6nAgVYx0i3ESoNxP5CkX3fQoNbE+9vLORjJtKUibhXQDeoQ3QwOFgqTpLcruavxeeGy9V5EuUkDGUQ6LmUG5vPWR6QCge4jQfQVpOIJnQ+mgszn9C1rocMlUSAtHejb+GmOaR0gFMnjUOuULduif
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:30.2871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b1f1cf-8ba2-4e2e-1306-08df1a6c25e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
hubbub_force_pstate_change_control_params::wait was passed as the allow
argument of hubbub_funcs::force_pstate_change_control, which drives
DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE. Sitting three lines above a
udelay(500), the name read as a timing control and invited the wrong
conclusion about what the field does.

[HOW]
Renamed the field to allow and updated the add helper signature, the
executor, the core_gtest dumper and comparator, and the affected
core_golden entry. No functional change.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c   | 17 ++++++++++-------
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h  |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 5e41792c622a..e2cc5ab40b3b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2775,13 +2775,16 @@ void hwss_add_hubp_program_mcache_id(struct block_sequence_state *seq_state,
 void hwss_add_hubbub_force_pstate_change_control(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
 		bool enable,
-		bool wait)
+		bool allow)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.hubbub = hubbub;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.enable = enable;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.wait = wait;
-		seq_state->steps[*seq_state->num_steps].func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL;
+		struct block_sequence *step = &seq_state->steps[*seq_state->num_steps];
+		union block_sequence_params *step_params = &step->params;
+
+		step_params->hubbub_force_pstate_change_control_params.hubbub = hubbub;
+		step_params->hubbub_force_pstate_change_control_params.enable = enable;
+		step_params->hubbub_force_pstate_change_control_params.allow = allow;
+		step->func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL;
 		(*seq_state->num_steps)++;
 	}
 }
@@ -3598,10 +3601,10 @@ void hwss_hubbub_force_pstate_change_control(union block_sequence_params *params
 {
 	struct hubbub *hubbub = params->hubbub_force_pstate_change_control_params.hubbub;
 	bool enable = params->hubbub_force_pstate_change_control_params.enable;
-	bool wait = params->hubbub_force_pstate_change_control_params.wait;
+	bool allow = params->hubbub_force_pstate_change_control_params.allow;
 
 	if (hubbub->funcs->force_pstate_change_control) {
-		hubbub->funcs->force_pstate_change_control(hubbub, enable, wait);
+		hubbub->funcs->force_pstate_change_control(hubbub, enable, allow);
 		/* Add delay when enabling pstate change control */
 		if (enable)
 			udelay(500);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 9ad18c9dcff9..6f3ec43bf3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -498,7 +498,7 @@ struct hubp_disconnect_params {
 struct hubbub_force_pstate_change_control_params {
 	struct hubbub *hubbub;
 	bool enable;
-	bool wait;
+	bool allow;
 };
 
 struct tg_enable_crtc_params {
@@ -2276,7 +2276,7 @@ void hwss_add_hubp_program_mcache_id(struct block_sequence_state *seq_state,
 		struct hubp *hubp, struct dml2_hubp_pipe_mcache_regs *mcache_regs);
 
 void hwss_add_hubbub_force_pstate_change_control(struct block_sequence_state *seq_state,
-		struct hubbub *hubbub, bool enable, bool wait);
+		struct hubbub *hubbub, bool enable, bool allow);
 
 void hwss_add_hubp_program_det_segments(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, unsigned int hubp_inst, unsigned int det_size);
-- 
2.53.0

