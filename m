Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B424C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E1110EE46;
	Wed, 26 Aug 2026 23:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/3FM2UF";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C97710EE46
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7uAysVdBJWrZabOCNXnpNR73LsinGYLGqcKGx5cHGQlWE81MgBPgGJmGTK4Gw6YmczJLL75crJolEo6Zp1jA/ZpFczrS0vjB9DK6djtaIYhqZY7OtEY4aY3uc32o1+TwqlJW+nomKj5U+uyGOtJuScy6LaiRFr4IXy7jpueW22XVknBCBiHNEqLysWlPr3908PkbzFt32bdfR9srPjUsLA3l2beLRhwk8u6IogCP60/HA4Jjrb+ItK5NQ+xRydeBBuCFr4ke8acoGj/asM7RrkG3m6PlAEV+Zj/mtONdoAvctiYo4nKW7EoXhxdlFn0It9RE6Af3585wWjEgVfCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xkYGROHcN9QKnMNMrl0Q/zqmWDr+Ft6UX0zR6yglX8=;
 b=aKLFmEBCFTjmvLP6d31RgOJJCa6SrqPciO4ioRasQpVQ06S9F19ECD6AmyEe/roNHLD42lD37hOR+vZa2C2KVTmdiZSWA+ALg6oWs9Ckk7ElPeVzQZ04OU2plv4dZA5/mH60k7xcFeMEd71paihfVtMNAP19HgO99VvCAmnnNsOk412siVNZYFKI3NGzf/gfo0nuNFmPX3+/TfFo/ybhT03vORlP3HbgSELrhvMVk4dAhihDVk8sBzhsrolhYQd+gLuIdOCtF+wWsB9wHMhxu534Qi6jUseKnJGtiAQDRb8O0qIGE1L9GBnacfY82Hfevj5ZE0cHiJebhTDvAYKUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xkYGROHcN9QKnMNMrl0Q/zqmWDr+Ft6UX0zR6yglX8=;
 b=J/3FM2UFwvmwo2y0aBpKuPna8Y+fIbuOUY1ha7crlSgHRCWwMpKiA7Qyf0MlcxLBe1ZpRB4VII7LBnWLnuJzg0+r4F3DhjV1y25rL12DCXUV0TwdoP6Mtf4bumfHHUtZHH6Yz30vWV1n4YfUTu3HLLrGY65vusRmxS22sfP/mQk=
Received: from PH7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::7)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:23:31 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::20) by PH7P220CA0008.outlook.office365.com
 (2603:10b6:510:326::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:23:31 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:23:26 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>
Subject: [PATCH 23/59] drm/amd/display: Remove pipe_ctx param from
 MPC_VISUAL_CONFIRM
Date: Wed, 26 Aug 2026 17:04:54 -0600
Message-ID: <20260826231519.881949-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e981ab-17f0-44c5-ffcf-08df03c90ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1r/grf3QauE6ba2gMzNXbHRMFQvj4yd/7OP0LV04T/gcQeSiG4dfWcUB2zT0Qdm6Ksn622dd8Vt8hmBkQRjXfEYoGtWtx4WQWrDB82VkEWrYrTlwDv4up4fZLbbSbncoBWojGk+lqKVgSL/mUUgh4c3T8/aTVmTjzfaGy4jLJWiDqP7fljTCO047WyX0pQCalxZ60OWl4TSbq4SUiGjOT8B3qpFC9T2D7yhK5ywxNeSbs+frGHCooeVknsjZOExrNyI4uang3E5YqJNxB1W8M2Mkbw0JfMo4Cefvsl/St9XmoYOnB7MniMpMxNNKpSC7sy8Zt3vkfJ4wFcxUyZVInFoM1r6IfVn1HxQjbCoxx1QVyjYNy845EAjBSTT+O7tJwa1gLn2oDg5YD24XgnCmdFB8Pbw5XzCDAiDUQPEVbuoUir91SZkmB6EowW7zoLWRZoWS0MTuXdr2Pvy1Jnz0uoPW1NAcpDRRQXAn6aZrIdnBfeOhLyiVpDtVV56o10qTwQzZy1lohV7OR1bJVHP9PWMXHUDgVrvtxtDCqBRlD1wTHBD7SuBO9Q1ZuUhoYCrpXd991k1mc89paNzVzmG1EZ6EFPb+cy2YVcBuDl5y+E0w2oZYZm3ZHkIgm67t+/pRGHMkAKirW6l8dfIH3rSTbW/BQXiWM8EE4KJ8tHF+9LFpvMsQiHaSjoNnxASPMfp9WfoPMAhPuvvRiAwpqfiAqQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u+TvLKRPfW9HvMnKl+hplMrRGvARNsLMeewFUiHXuTyArwsAItW8DFkvbYejQfMWIlftP9rMwYqFTfaNHnZ6Y3wuQDjt6kJPaOlmYJyi12NTposyeFkmPqYp7XiLnrSs7O495dJzeqYYZU2n3l3lvoe0e5ndktwp4McV8X0swV/tGhU0K6c6jQY1NisAjioktow6FEFXB/ptofykA3xUKok6HKcnCWiWKOdPhy9q40SPGq4VqWa9AWiqHoJ3FqzmUV2tq0Z293WCBcQ1JAEtNZaJgQ/agAwhEXlHZ7ytHYYDzPct7Uwu+u5pJ8RD9Zey0A0ARqBhRgLpWam1XcelF+srFED+m3cKnFpg1pAq39qOGoF5eUvCDBKEe/fHID65zLSy8cvyJBi1o24gBHLPmjYF+fFMNXBWLMASs4H2rBJmGngO6fYMHs4DjcKPxxP6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:23:31.3612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e981ab-17f0-44c5-ffcf-08df03c90ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[WHY]
Hwss executors shouldn't be coupled to complex dc structs such as pipe_ctx.

[HOW]
- Use mpc function instead of hwseq extension.
- Swap pipe_ctx for tg_color struct as BLS param.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c    | 16 +++++++++-------
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h   |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7ad30a1f2978..0e2c85b28e7c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1628,8 +1628,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 			}
 			if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE &&
 				dc->hwss.update_visual_confirm_color) {
-				block_sequence[*num_steps].params.update_visual_confirm_params.dc = dc;
-				block_sequence[*num_steps].params.update_visual_confirm_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.update_visual_confirm_params.mpc = dc->res_pool->mpc;
+				block_sequence[*num_steps].params.update_visual_confirm_params.color = &current_mpc_pipe->visual_confirm_color;
 				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = current_mpc_pipe->plane_res.mpcc_inst;
 				block_sequence[*num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
 				(*num_steps)++;
@@ -1787,9 +1787,11 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_program_upsp(params);
 			break;
 		case MPC_UPDATE_VISUAL_CONFIRM:
-			dc->hwss.update_visual_confirm_color(params->update_visual_confirm_params.dc,
-					params->update_visual_confirm_params.pipe_ctx,
-					params->update_visual_confirm_params.mpcc_id);
+			if (params->update_visual_confirm_params.mpc->funcs->set_bg_color)
+				params->update_visual_confirm_params.mpc->funcs->set_bg_color(
+						params->update_visual_confirm_params.mpc,
+						params->update_visual_confirm_params.color,
+						params->update_visual_confirm_params.mpcc_id);
 			break;
 		case MPC_POWER_ON_MPC_MEM_PWR:
 			hwss_power_on_mpc_mem_pwr(params);
@@ -2495,8 +2497,8 @@ void hwss_add_mpc_update_visual_confirm(struct block_sequence_state *seq_state,
 		int mpcc_id)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.mpc = dc->res_pool->mpc;
+		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.color = &pipe_ctx->visual_confirm_color;
 		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.mpcc_id = mpcc_id;
 		seq_state->steps[*seq_state->num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
 		(*seq_state->num_steps)++;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 83d9d699e929..e7ab30e041d5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -163,8 +163,8 @@ struct program_upsp_params {
 };
 
 struct update_visual_confirm_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct mpc *mpc;
+	struct tg_color *color;
 	int mpcc_id;
 };
 
-- 
2.43.0

