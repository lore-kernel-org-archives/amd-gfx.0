Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48060C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D451B10EB5F;
	Tue,  8 Sep 2026 11:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0mKXSz/v";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D98A10EB5D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb/JC0Yu99ZJ21R9Khm/MHPJP1O/4L1DoIkUKFJF/mgql7+VaHgHrS6jd9O2ejf/UFm/FfcWV2Pzz3rQZGXfUgT6Enp2uuT/8DDNdVWSIoELwz4S/f3XCRQZgx2d2BsDSV2Dm0NCxWAAY2F4RmpWQAAsyzEh1eVWFKj/0297Ugyu9Vo4bcfwHIpRJ3FvSLiig4FUhJAsxRpzhKHnmLsDiFMicRxmt1/Q57Hi5AFw8GxG/HSQn15EtlGj1hFMioN4VWCNtL4Aa9qU8nRFLY0NiSUiAT+7T6aZ/Y0natHQPANFabn8ZUZCflZoryZCTqecJm//D9S5IxPAtF4CEYP2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaR4PKl7846cCOCBK50M0zaB3uGW6GDfwWZh81w04RY=;
 b=iWvh+3U7J3qiZeK60GdOv3PGas/oNqAzB+DrMXaHEghJPqaAFWCpEsDEXDOYpPLX8X4Lce+jQRO0WZ95XbdVtqXA5k10TXIaVYEidqwbCN6/IgtyUUmT+D9fq2gHtbXzhThOMz9g4Wua0psKZP+7gHrCapyoTk76iypCqnRELswNLstBLsbviF4IhhLq8wWWeDrJqR/24LC96Go65mdyqww7newhXlEJh2QmNrAcX5ReTgbaw3sT3BJ0Q3dFz/QwcmeTPYfv0NsyJiK2TSowWJlIjOG2oya4a03DrxQlFMMpc4nnT9ziQzPhetZX7PlftSrtE/781R97hNlnM8rjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaR4PKl7846cCOCBK50M0zaB3uGW6GDfwWZh81w04RY=;
 b=0mKXSz/vT+OVZACHAJ3P/X/C14ha/vGdib4CooenVkK3P1M6WNbMwb4nzRt6XiltSRP51iyPZnwSE701iodrwGuXZOe6BfWa1gn6UZuS7yHIeTuHcTe36mgubdSdTvNPoOwn8yFWa4seipOJjuxZtThpzKefjwWssS1JYqLlZzw=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:39:45 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::23) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:43 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:34 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, "Rafal
 Ostrowski" <rafal.ostrowski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 40/66] drm/amd/display: Decouple HUBP_UPDATE_PLANE_ADDR from
 pipe_ctx
Date: Tue, 8 Sep 2026 19:31:33 +0800
Message-ID: <20260908113338.2433445-41-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8008b3-8adf-4f88-dabb-08df0d9de16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EpVrg8weE8xOGJCmJV5FdZ/PIDmn/FNi76AO94qWY+VC7qHr8dcRxlItsATJGc2XzfX7MdLF4+ReYIokclN1Z8XnXYIf6O4yPqsjM8Y6bUWh9bJNDasibyMHFQ3RiOZqnvduAFCr1XM5QzsW+Tg315S+ZxyDNPVfBkuKvVhCB0+RhEXpGBeFbT/A4UPFTRYc0Z7Egdbc3GsW1gcTbQ92AxyfY0rYgjR6uJ8PleCv7F91xnpvW5Joyep18Kl7UQzxBiv5OSthwS58JncLw/q1YzpYPbw//HYgu2zLJMlXnHWH5L/35Hyv5KHLjBc9RupJisR1JGJuF57ib4nV9Zg9kld1fhBvp0tkVaF+Q0xj9vHaBZ5Cc4EHUjso5aQDN83oDnfwXQF+L5PVxSHF1ExwUtbjd2kXIVg7qqRnNN/oyIFJ1xaONFaYT/i5rNldUwQtbkgzeFPgu7jVOTW/h6LfUNGiYh59uivGGZ96PA7P30UOTGoymu2+Wo71XW4GZUpsmXDfq0x7c6bqXbT0uygKl3pGAvb88ASmg9nBkXGVPsHgQUV4xZOFul9r0aWoKDVzqoZACVC30bQel1Klg2QYvoV6mKuISgjvx8xZwD3h1pdUe65BBe4N5FVv2APldts/IFFQeuu4ZW+U94zHtXkmCZzASf6v4/eUn+iXqyjHHLtWgqmXDGnyxHShPmqGfFl0F6tWeqJgMDOIatFIz2A5ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KgDam/jS4+i4rfiKuj/ak58AieVhZaj8CmlBPf+ibnCcgQSjO5qim5pSLelUxGzHHPdLJCg5QGIwWKHolWn88Sbue+CQ261hoxECyWEviMtsZLW8aEJxusCBwaZ1KfdwiMQZ4HR03DRwS0clxo/xoV6jqCDDfh16/HndHA2O5aIMP+d7rh43lBGBNbH8jIz5YT20nZZsAKsRzW0flH6lgGPQlo8fDrYqG+fXAbTpotjlLgGhsA5stk8OA1IqWI8eJkcHra58tDumW4LCPIKBhgxIJ/H0XdKI7mJKEWBvfhagbgZmHWEClm+qjrXsnxiRFqnQy8b3iBKoOuDZGLKmusBCTzhQ4ny/3rSWOAZ010X7o6Gj+UsDDZ/dnHHtMJIskZvFJKDxcNej2JdcYCNgurmyqcnlXDoDmjt5kspt06zJcFSG4hUYQQZAw7O6LjMg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:45.2303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8008b3-8adf-4f88-dabb-08df0d9de16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

[Why]
Every HWSS Block Level Sequence operation should have flat parameter list
and an explicit instance pointer. Global state should not be accessed at
execute time.

HUBP_UPDATE_PLANE_ADDR does not adhere. It stashes pipe_ctx in its params.
Pipe context is mutated during execution.

[How]
- Adjust HUBP_UPDATE_PLANE_ADDR params to hubp_program_surface_flip_and_addr
  parameter list.
- Add a build-phase hwss vtable entry - prepare_plane_addr_update that does
  parameter preparation and all global state mutation.
- Execute hubp_program_surface_flip_and_addr with precalculated parameters
  during execution phase.

Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 26 ++++++++++++-------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 25 ++++++++++++++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 25 ++++++++++++++----
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |  1 +
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c | 26 +++++++++++++++----
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |  2 ++
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |  1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  9 +++++--
 22 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7262596c470e..ccc58d42e0ab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1471,7 +1471,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 					block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
 					(*num_steps)++;
 				}
-				if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_bits.addr_update) {
+				if (dc->hwss.prepare_plane_addr_update && current_mpc_pipe->plane_state->update_bits.addr_update) {
 					if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
 							stream_status->mall_stream_config.type == SUBVP_MAIN) {
 						block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
@@ -1481,10 +1481,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 						(*num_steps)++;
 					}
 
-					block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
-					block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
-					(*num_steps)++;
+					hwss_add_hubp_update_plane_addr(&seq_state, dc, current_mpc_pipe);
 				}
 
 				if (current_mpc_pipe->plane_state->update_bits.lut_3d &&
@@ -1713,8 +1710,10 @@ void hwss_execute_sequence(struct dc *dc,
 					params->program_triplebuffer_params.enableTripleBuffer);
 			break;
 		case HUBP_UPDATE_PLANE_ADDR:
-			dc->hwss.update_plane_addr(params->update_plane_addr_params.dc,
-					params->update_plane_addr_params.pipe_ctx);
+			params->update_plane_addr_params.hubp->funcs->hubp_program_surface_flip_and_addr(
+					params->update_plane_addr_params.hubp,
+					&params->update_plane_addr_params.address,
+					params->update_plane_addr_params.flip_immediate);
 			break;
 		case DPP_SET_INPUT_TRANSFER_FUNC:
 			hws->funcs.set_input_transfer_func(&params->set_input_transfer_func_params);
@@ -2345,9 +2344,18 @@ void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+	if (!dc->hwss.prepare_plane_addr_update || !hubp || !hubp->funcs->hubp_program_surface_flip_and_addr)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.update_plane_addr_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.update_plane_addr_params.pipe_ctx = pipe_ctx;
+		struct update_plane_addr_params *params =
+			&seq_state->steps[*seq_state->num_steps].params.update_plane_addr_params;
+
+		dc->hwss.prepare_plane_addr_update(dc, pipe_ctx,
+				&params->address, &params->flip_immediate);
+		params->hubp = hubp;
 		seq_state->steps[*seq_state->num_steps].func = HUBP_UPDATE_PLANE_ADDR;
 		(*seq_state->num_steps)++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index fefc9dea7054..270b6f2d4377 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2060,7 +2060,8 @@ static bool patch_address_for_sbs_tb_stereo(
 	return false;
 }
 
-void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+void dcn10_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate)
 {
 	(void)dc;
 	bool addr_patched = false;
@@ -2072,10 +2073,8 @@ void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 	addr_patched = patch_address_for_sbs_tb_stereo(pipe_ctx, &addr);
 
-	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
-			pipe_ctx->plane_res.hubp,
-			&plane_state->address,
-			plane_state->flip_immediate);
+	*addr_to_program = plane_state->address;
+	*flip_immediate = plane_state->flip_immediate;
 
 	plane_state->status.requested_address = plane_state->address;
 
@@ -2086,6 +2085,22 @@ void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_state->address.grph_stereo.left_addr = addr;
 }
 
+void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct dc_plane_address address;
+	bool flip_immediate;
+
+	if (pipe_ctx->plane_state == NULL)
+		return;
+
+	dcn10_prepare_plane_addr_update(dc, pipe_ctx, &address, &flip_immediate);
+
+	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
+			pipe_ctx->plane_res.hubp,
+			&address,
+			flip_immediate);
+}
+
 bool dcn10_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
 	struct dpp *dpp = params->dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 30c213f2e8d6..5cb109040d3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -73,6 +73,8 @@ void dcn10_program_output_csc(struct dc *dc,
 bool dcn10_set_output_transfer_func(struct set_output_transfer_func_params *params);
 bool dcn10_set_input_transfer_func(struct set_input_transfer_func_params *params);
 void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn10_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate);
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn10_reset_hw_ctx_wrap(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index 47ab50a3fab1..07e92742c11a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -39,6 +39,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.update_plane_addr = dcn10_update_plane_addr,
+	.prepare_plane_addr_update = dcn10_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 0998106c1da0..a3d2385bc731 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2777,7 +2777,8 @@ static bool patch_address_for_sbs_tb_stereo(
 	return false;
 }
 
-void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+void dcn20_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate)
 {
 	bool addr_patched = false;
 	PHYSICAL_ADDRESS_LOC addr;
@@ -2792,10 +2793,8 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	vm_helper_mark_vmid_used(dc->vm_helper, plane_state->address.vmid,
 			(uint8_t)pipe_ctx->plane_res.hubp->inst);
 
-	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
-			pipe_ctx->plane_res.hubp,
-			&plane_state->address,
-			plane_state->flip_immediate);
+	*addr_to_program = plane_state->address;
+	*flip_immediate = plane_state->flip_immediate;
 
 	plane_state->status.requested_address = plane_state->address;
 
@@ -2806,6 +2805,22 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_state->address.grph_stereo.left_addr = addr;
 }
 
+void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct dc_plane_address address;
+	bool flip_immediate;
+
+	if (pipe_ctx->plane_state == NULL)
+		return;
+
+	dcn20_prepare_plane_addr_update(dc, pipe_ctx, &address, &flip_immediate);
+
+	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
+			pipe_ctx->plane_res.hubp,
+			&address,
+			flip_immediate);
+}
+
 void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index c7bf79fda54c..9711b8bc9083 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -41,6 +41,8 @@ void dcn20_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context);
 void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn20_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate);
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 bool dcn20_set_input_transfer_func(struct set_input_transfer_func_params *params);
 bool dcn20_set_output_transfer_func(struct set_output_transfer_func_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 1c6c4e19bdda..c4de9cf11c23 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -40,6 +40,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 9f4bc2a49873..916b6804e8e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -133,7 +133,8 @@ static void plane_address_in_gpu_space_to_uma(struct dce_hwseq *hwseq,
 	}
 }
 
-void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+void dcn201_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate)
 {
 	bool addr_patched = false;
 	PHYSICAL_ADDRESS_LOC addr;
@@ -149,10 +150,9 @@ void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 	plane_address_in_gpu_space_to_uma(hws, &uma);
 
-	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
-			pipe_ctx->plane_res.hubp,
-			&uma,
-			plane_state->flip_immediate);
+	/* snapshot the UMA-converted address before the stereo patch is restored */
+	*addr_to_program = uma;
+	*flip_immediate = plane_state->flip_immediate;
 
 	plane_state->status.requested_address = plane_state->address;
 
@@ -163,6 +163,22 @@ void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_state->address.grph_stereo.left_addr = addr;
 }
 
+void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct dc_plane_address address;
+	bool flip_immediate;
+
+	if (pipe_ctx->plane_state == NULL)
+		return;
+
+	dcn201_prepare_plane_addr_update(dc, pipe_ctx, &address, &flip_immediate);
+
+	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
+			pipe_ctx->plane_res.hubp,
+			&address,
+			flip_immediate);
+}
+
 /* Blank pixel data during initialization */
 void dcn201_init_blank(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
index bab5d9e6912e..dbcaa0a3a02c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
@@ -33,6 +33,8 @@ void dcn201_init_hw(struct dc *dc);
 void dcn201_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings);
 void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn201_prepare_plane_addr_update(const struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct dc_plane_address *addr_to_program, bool *flip_immediate);
 void dcn201_plane_atomic_disconnect(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx);
 void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index 95dda06b6b17..be1fb2366c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -41,6 +41,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
 	.update_plane_addr = dcn201_update_plane_addr,
+	.prepare_plane_addr_update = dcn201_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index b8ed664e1bab..20c6e7d7c897 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -41,6 +41,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index b655c01f013b..f62f1c6efff8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -41,6 +41,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index dfacc59166cd..a62434138eca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -43,6 +43,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 3c2e2162da11..30ad41d08d6e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -44,6 +44,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index b50ab468b8f8..a53e7fb6f23f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -46,6 +46,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 225128962216..7e68029f1e12 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -44,6 +44,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index c9125cc25d15..69fa91aeb836 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -48,6 +48,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index e6f7d57cbfed..3ceaa4590148 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -47,6 +47,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 783415e4e3a1..5ac79c32ee48 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -23,6 +23,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn401_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index b074aa9a21d9..faeb365dbcab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -26,6 +26,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn401_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index d2fae89dfa05..4aaecd6f8bb7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -25,6 +25,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn50_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 4cf61eb647dd..4b2c801421d6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -92,8 +92,9 @@ struct program_triplebuffer_params {
 };
 
 struct update_plane_addr_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct hubp *hubp;
+	struct dc_plane_address address;
+	bool flip_immediate;
 };
 
 struct set_input_transfer_func_params {
@@ -1457,6 +1458,10 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
+	void (*prepare_plane_addr_update)(const struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_plane_address *addr_to_program,
+			bool *flip_immediate);
 	void (*update_dchub)(struct dce_hwseq *hws,
 			struct dchub_init_data *dh_data);
 	void (*wait_for_mpcc_disconnect)(struct dc *dc,
-- 
2.43.0

