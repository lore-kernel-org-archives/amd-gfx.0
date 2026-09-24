Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC415C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683B410F748;
	Thu, 24 Sep 2026 18:47:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kv8DrzVp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ADE10F743
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpcm8L983ZBKtFUW21F3/bCnKDRm3pk9LunG0K96UYtjbLf50gbu2ZxVOTnUOB4/yXldWvOoGoBhxgeGfp2N43WLreemHBe1uYVdNeBLGiMX/aQDMUHDG6WslbXJVrfjzg/VoOSXFLk4xb/IN/wI2faFOVLfy0+YFORWIdo07kYPmiV9licxgNxYOrhKLnR3dHuyDtjsxtJ9RL6mQnJ/G3LjrnjPu79p7vIxoOEhfE0zmZa5bc/6ZLfM5Oely6buvBefw23whwspNnPsMVy6mDEh1V8GGGGpNEc+cXask0sIvGZJwrzL5gwTUql+4UbFw76G+2QB6tu85ebHZtelsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVamjYWl3sBabsLVwMBYZXDGTaB0QiPl6jQ3zLg0xuo=;
 b=PVGUDG2qINW9y+FwZggKqYy1uV5vKp7ONU5QdoFSPJf8cb06Mno4kXT28s3/Qyvw3Lqcl+pNVE/OqCYKUobcW8PuVPAPlS3kNxH+iMD3m2KfONSKNaNdHl/+pbAzyY7Toex7ifaXIgtcbO0uGsenIqYTCz9KwviDmAFTO01cH1PDaSGGE1w60UMpfFpsFg1GKzxX71oGy4ZD1v+z8yOWzYqWXtJ/wkWK3/LmjUG2sdh8dDgLurpppcJLHW0DeflZLsoISrJ677+gVx8CxGLgKYARFGhX9ltYqPbw+V5f1EacgFiocH/C17X5lICtYOKQyDn9IeilzCEiTGV6WHqOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVamjYWl3sBabsLVwMBYZXDGTaB0QiPl6jQ3zLg0xuo=;
 b=Kv8DrzVpw+F8SfiJaaNA6sDOlo2O7VgRDgS6AIsWGtwuLydqs7HfSCB8Tipph+VQA5uUzPXgkG2aMDzt5dwwO4PSeKzCbprsbb9aik4HWgJbCh5edI3o2aPqKrhcAHlxjXOvzQfNFLa0O+f3eaBszye+R+HpKYLtmgNDAFDaBGM=
Received: from PH8P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::16)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:33 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::44) by PH8P221CA0001.outlook.office365.com
 (2603:10b6:510:2d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:32 +0000
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
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:32 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:16 -0500
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
Subject: [PATCH 21/34] drm/amd/display: Dispatch HUBBUB_SOFT_RESET through
 hubbub_funcs
Date: Thu, 24 Sep 2026 14:45:34 -0400
Message-ID: <20260924184824.596894-22-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 7327bfd9-5d6b-4716-796c-08df1a6c2763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4tj3R1rzXmV6evwemxvy92DXzRmf5+HJYUGkK5jT8djgyYGjBpFyRqr7MxZqQ+Yt3CwtM9CjhZjJqvyyA20tbGVAl0KWrBiDOEnhqlVfCOihLpg7wL+MrkaFfqmLNmEocJCBBOG00lv3lN6wHNEG39wYTZ7dBoQ7mJkvud0y/n8VUISofXMD+x2G7ZHTFH6ZyXFlVzB9WfP9hyuIXNKPZdR+0D6OZDqeD9uHKxezKX/m9BaxNICWZrfTmArBoyOVW+DSs1/kgdZPkCmg5YChFXh+6HDJNznkfn/mtRBzLS1k2fM7OUkLJXY6/kfyM98No0UeKcI1lFlMXAV1ajezpWThaRvTE/Rpa7gVpLxPIfRZHrc3e7/0zd4oiyNNPCraKZ3HJh1VIL4n+79SD/AxG+IZUz4zakdUiUilYIklyvtJgt4lJjWeTQ2QrSRooGTKoBN6rv5zjexFf9NmfhexuUquj5i/dMIW/2mK3x52B4YG/7n6prQ1974uCGP3NWJibw9FoIXxVwr6BG7GQRCtvHFTrSvHR5hM8KlahaCKJNnSyHUHdrlLUWo1PAHdG/kVC+B/InBWRr4nmKVrwtytXG/0yF9r2sNAWj4NkXiM03g6iwM5Cgf7dLmBpo5v93y6cXJrIaLicEJE4067xG2pqBy+773gz61JK4jDt8vjzdM0OGof1OgNqnKKiCwCaIvj6FZDeQVYDByFycJbb1gj0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gVuHzxMj+/jUeeqbSy7s8YkVdObGl8qp+i1xOVwTG8N7rEkXdoJQNF72EWdb/Unc+714axedZRsBiAuzTlbJrNurJbcwbHj30DqZ3HiCphaywsKFdw4F6u1ZEgYuj73+8RmIE2LE+ZGiaNgyn0NThoolOyA+tFdo7wEaG6O8xVPi+SXJOIF3k35xYGwoaWVkRmcMbWBND5pTAjZR0R91zxOrLewvrLSxyBVvgc9zaYkLtSYOhmQcCyIFBgpS6C8rerNEpzpE2sdJolODz4QcL2nQOHsgL2E+ABjZhe9ZAtwfShGf12ilcWEqaeQer499J4ezSAkcH/20RhGwLKQOZGgkzdA1eb6GRaYgUy0aAyVMEfP484WWymqNxb173ycaa/Ko5OuGbB8trAlhNrAMpMQspPjMX9LiQ0uQ951H5QBLnzgX71yrE7z8qhM1tRRE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:32.8269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7327bfd9-5d6b-4716-796c-08df1a6c2763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
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
hubbub_soft_reset_params carried the callee itself as a function pointer,
so the step was not fully described by its parameters. The core_gtest
dumper could only record hubbub and reset, which means two sequences
calling different functions compare equal. It also forced dcn401_hwseq to
name the dcn10 symbol hubbub1_soft_reset directly, because hubbub_funcs
had no slot for a soft reset.

[HOW]
Added soft_reset to hubbub_funcs and pointed hubbub4_01_funcs,
hubbub42_funcs and hubbub60_funcs at hubbub1_soft_reset, the same way
allow_self_refresh_control is already shared. Dropped the function pointer
from the params struct and the add helper, and had the executor call
hubbub->funcs->soft_reset. The dcn10_hubbub.h include in dcn401_hwseq.c is
no longer needed.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c       | 6 ++----
 .../gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c    | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c  | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c  | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 5 ++---
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h          | 2 --
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h            | 2 ++
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e6d10e3bd6e9..ccf5ed47ce62 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3822,8 +3822,8 @@ void hwss_hubbub_soft_reset(union block_sequence_params *params)
 	struct hubbub *hubbub = params->hubbub_soft_reset_params.hubbub;
 	bool reset = params->hubbub_soft_reset_params.reset;
 
-	if (hubbub)
-		params->hubbub_soft_reset_params.hubbub_soft_reset(hubbub, reset);
+	if (hubbub->funcs->soft_reset)
+		hubbub->funcs->soft_reset(hubbub, reset);
 }
 
 void hwss_hubbub_perfmon_reset(union block_sequence_params *params)
@@ -5176,13 +5176,11 @@ void hwss_add_hubp_disable_control(struct block_sequence_state *seq_state,
 
 void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
-		void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset),
 		bool reset)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_SOFT_RESET;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.hubbub = hubbub;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.hubbub_soft_reset = hubbub_soft_reset;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.reset = reset;
 		(*seq_state->num_steps)++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index d948525bc09e..957e8f5a6475 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1239,6 +1239,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.verify_allow_pstate_change_high = NULL,
+	.soft_reset = hubbub1_soft_reset,
 	.force_wm_propagate_to_pipes = hubbub32_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub401_init_watermarks,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index b8657de84d31..036276c17562 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -530,6 +530,7 @@ static const struct hubbub_funcs hubbub42_funcs = {
 	.program_watermarks = hubbub42_program_watermarks,
 	.allow_self_refresh_control = hubbub42_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.soft_reset = hubbub1_soft_reset,
 	.force_wm_propagate_to_pipes = hubbub32_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub35_init_watermarks,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 843a0da4bdd7..07282b78972a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1926,6 +1926,7 @@ static const struct hubbub_funcs hubbub60_funcs = {
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.verify_allow_pstate_change_high = NULL,
+	.soft_reset = hubbub1_soft_reset,
 	.force_wm_propagate_to_pipes = hubbub60_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub60_init_watermarks,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b7680326f495..73f969fd1b33 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -30,7 +30,6 @@
 
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn10/dcn10_cm_common.h"
-#include "dcn10/dcn10_hubbub.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_cm_common.h"
@@ -4161,7 +4160,7 @@ bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
 	}
 
 	/* Step 2: DCHUBBUB_GLOBAL_SOFT_RESET=1 */
-	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, hubbub1_soft_reset, true);
+	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, true);
 
 	/* Step 3: Set HUBP_DISABLE=1 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -4186,7 +4185,7 @@ bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
 	}
 
 	/* Step 5: DCHUBBUB_GLOBAL_SOFT_RESET=0 */
-	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, hubbub1_soft_reset, false);
+	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, false);
 
 	/* Step 6: Set HUBP_BLANK_EN=0 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 821cd0de7271..9c32418be8f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -602,7 +602,6 @@ struct hubp_disable_control_params {
 
 struct hubbub_soft_reset_params {
 	struct hubbub *hubbub;
-	void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset);
 	bool reset;
 };
 
@@ -2416,7 +2415,6 @@ void hwss_add_hubp_disable_control(struct block_sequence_state *seq_state,
 
 void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
-		void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset),
 		bool reset);
 
 void hwss_add_hubbub_perfmon_reset(struct block_sequence_state *seq_state,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index d68232f10f3e..b33273b61abd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -216,6 +216,8 @@ struct hubbub_funcs {
 
 	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
 
+	void (*soft_reset)(struct hubbub *hubbub, bool reset);
+
 	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
 
 	void (*hubbub_read_state)(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_state);
-- 
2.53.0

