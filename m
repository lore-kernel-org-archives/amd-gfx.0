Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8735AC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0E610E42F;
	Wed,  7 Aug 2024 07:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GR6apIlJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99FA10E42F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STOjHi3w+uyMYM5AnOpE08a5A07cZIcccaRD/FABD8cy1uFsymN77AcIcZuZqD//pur+IczkT89JJ/Rzf561Zg572hMNcOr6WhyHsMCQ5nOUJyiJ0zNG8S+HyGA6cSCWh4g62FMKp3AE7aG/gpg451tKpkz7+b5nJbbp2va18Izmnzee27JSQqiAjWKDsGlZDJaTE152nbDcU9f5B/GueMw+DNGxtWgdwluT0n1oENNCkd2mbFgNNIq2YNRpDCTHpDtrHLrA73DA8wcBB1UJ427SmY77zn2qURz6I7n+Lp2sagyId9cB4tlf/0/MlMAmrG3IYZu4Non8ir8PdTkmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T79TFtldJMfRh3JXRf/ERg8bJrR2NPD4ZaqsiA5iH0=;
 b=hZqocKz0HmzV+vgEZs52c31IzlMWxd801FBxoxn87Fe+UoxwJV4hBCTbaVUQBHNbzZT6BxiunEGhOhydDBgZMhsXlftB6pTXIebvY0DxIyJc3kMAjir/U+2OoMlRGD5AYc9hZLu1H1k4aInH8L7uouErJxsJMns7yPtoWasMaTWDEdt0/9V0Ek6iRxKfVNfpveJ85hiZTa/thp3lcunX2YblZRciUq6BG0n/rLcCtqgqUP9Gk1GaieuTqH6oqgP6wUOP4E+xuw+040tOhCroE8ZguKhopoSOuRZsN0lgzaE9PAZ2N5avMaLhH/xQ/pszCeaMJ7JUThYEcYz/w2WNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T79TFtldJMfRh3JXRf/ERg8bJrR2NPD4ZaqsiA5iH0=;
 b=GR6apIlJb9X7VgZi2H4Hx8e9/BnyhBD3d+2FDSG3w6ygGAmSNNOT3m5xAF2xJTy4BTAjO35DYj6KZ02aTRNnXvqkJuK0RgGAJpAeWOokXlDOfMU18l8giRX7YVuEk/MsJq1ffr7wlu+p/9ukRyOZ7vKngDcwhwH830LUhGDVu0c=
Received: from BLAPR03CA0085.namprd03.prod.outlook.com (2603:10b6:208:329::30)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:56:14 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::57) by BLAPR03CA0085.outlook.office365.com
 (2603:10b6:208:329::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:13 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:10 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Unlock Pipes Based On DET Allocation
Date: Wed, 7 Aug 2024 15:55:27 +0800
Message-ID: <20240807075546.831208-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e0a190-4350-441a-3847-08dcb6b6693b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4A3QN3J5G3sBxFQKtsLCWoiJfdADgouASJbIRct86+iykWc+1xK3OSFlZqZs?=
 =?us-ascii?Q?Jr9eIk00eM8jhhQc8xatDxNKrJu7fJ7heeFoledLe7YL3j9suKqkbYveg/SY?=
 =?us-ascii?Q?j/kmKwUtbDNJt3DUZf7oScpw85iCOwuAZ3kw5LW83+kPSQw32NI1Sr7Zh8fk?=
 =?us-ascii?Q?w/4e0cC9jhXBGkz6syzKiB3eurH5JGADNMfONuAxzMnEUQOE23ZojuvBVFMg?=
 =?us-ascii?Q?IjZBmliCJJsm4AXWsdEc2fj4YIoGaJa0IdPelmDb7AOErsIR1KJk5C45+7Zr?=
 =?us-ascii?Q?MD82l7gDhpx3e21nzcroiReZ3FhSBcVEXjhUYprjrcTWh/uC//noBu5X/Z7g?=
 =?us-ascii?Q?iD25djbZwlENoYp9Qpk+qHvMtUotCVsdiz7cnu5bAqaiYcVMLmotuZbLVjC3?=
 =?us-ascii?Q?+Pj4buzi2UYtAZrYOcnXO3iiBfNRAPKYTQrRF4SgC9KwZzMyJEtmnNMeVr4U?=
 =?us-ascii?Q?bPGWyilrD8Gv6e3K+GCdfuTVOVwpFdmPW0hugZfi1J5NZTtt7wyhm5HGcl40?=
 =?us-ascii?Q?7Ilst/LbgvsjIhKNWlLozQfOwqn76A6HrHyT0abwsw5CDK7btyp4gao13zer?=
 =?us-ascii?Q?030LUpZPfbS+KhTdRdfU2le8FgVgqQewoPzfn0NWrY0XxSPezXYm77em4T0s?=
 =?us-ascii?Q?PJPUF/MH15C+yXMru+/g+OM1tYG0h/QpRQ9b8X3nuPQi6XKQATdJYiTjgE14?=
 =?us-ascii?Q?HKZoEsPHV4667oXg25OBfJrIkFQyxG+UOQm4HNy8MDx0LP62A5M4YJZdhg8K?=
 =?us-ascii?Q?K6toLL/rgswj56tf97pL9WX4jRcQw1zL+20KzBkpwoj4WsfESTdVH+bSmaSx?=
 =?us-ascii?Q?PtfUEOp9sAwjeCZVraG6PWqrIiGnORWf+ShUDckkdcfmYiGVH/1+ZvPdoqop?=
 =?us-ascii?Q?ELkmd3hzanyZbVzXC7v//+jNzIvRCryRJina8PRK39PvMw0j471I8asxkGr/?=
 =?us-ascii?Q?7sqRosP4GvcInsX+C7hL11Haw9vl3EkoAKuqtEQPKp8ZlGYNVlCSntTzAv6d?=
 =?us-ascii?Q?39bLkm1kqupbvrCv1BQD4rb0wedLHyuNLlaQDrCf4TpArmGAtKVlkg8cTZrO?=
 =?us-ascii?Q?aLQmgbwjDlrvfDv/OJH1Lzvwvr/wcn/R1GZ9IJBaQUGxY9EIf49DpPrVFdZi?=
 =?us-ascii?Q?tRv9R2r7u1oPralSQvUullsWC4vypociC9E2G9Pp9Zr53wNW2ad9tUbROex4?=
 =?us-ascii?Q?Z7aanfRYuH7rB4PoyoCzMnywCLJXzhSWBJoWceu5eSnFINXDEC89d/T6Th2c?=
 =?us-ascii?Q?BIAUJKE3yAO/06t02kAFZ7IepqCrBJLNJRpfk8A99nK8hASpLxDrHlgJHOn/?=
 =?us-ascii?Q?y06KFaJt7lcclCv7R2CnC2tYbiZO6M+c1o47NByOKj6XZdYZpsasxmhuvyQ3?=
 =?us-ascii?Q?h2ZzOYUcPPQAXwkCz+OsewHcVC8JIOUHYd37ihgpEr601hkVLIoEhIxvI82F?=
 =?us-ascii?Q?Z0rfQ1RqEX8QAvmYesGJMwx6pZ4fLxRH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:14.4778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e0a190-4350-441a-3847-08dcb6b6693b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
DML21 does not allocate DET evenly between pipes.
May result in underflow when unlocking the pipes as DET could
be overallocated.

[How]
1. Unlock pipes that have a decreased amount of DET allocation
2. Wait for the double buffer to be updated.
3. Unlock the remaining pipes.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 ++++++
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 23 +++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 91 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  5 +
 7 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1c379a6b1b4c..b38340c690c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5275,3 +5275,31 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 	dml2_options->svp_pstate.callbacks.remove_phantom_streams_and_planes = &dc_state_remove_phantom_streams_and_planes;
 	dml2_options->svp_pstate.callbacks.release_phantom_streams_and_planes = &dc_state_release_phantom_streams_and_planes;
 }
+
+/* Returns number of DET segments allocated for a given OTG_MASTER pipe */
+int resource_calculate_det_for_stream(struct dc_state *state, struct pipe_ctx *otg_master)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+
+	int dpp_count = 0;
+	int det_segments = 0;
+
+	if (!otg_master->stream)
+		return 0;
+
+	int slice_count = resource_get_opp_heads_for_otg_master(otg_master,
+			&state->res_ctx, opp_heads);
+
+	for (int slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+		if (opp_heads[slice_idx]->plane_state) {
+			dpp_count = resource_get_dpp_pipes_for_opp_head(
+					opp_heads[slice_idx],
+					&state->res_ctx,
+					dpp_pipes);
+			for (int dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++)
+				det_segments += dpp_pipes[dpp_idx]->hubp_regs.det_size;
+		}
+	}
+	return det_segments;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index d36f758971a8..37d26fa0b6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1170,6 +1170,28 @@ static void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned comp
 	}
 }
 
+static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	switch (hubp_inst) {
+	case 0:
+		REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1, 100000); /* 1 vupdate at 10hz */
+		break;
+	case 1:
+		REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2->det1_size, 1, 100000);
+		break;
+	case 2:
+		REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2->det2_size, 1, 100000);
+		break;
+	case 3:
+		REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2->det3_size, 1, 100000);
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct hubbub_funcs hubbub4_01_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -1192,6 +1214,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.set_request_limit = hubbub32_set_request_limit,
 	.program_det_segments = dcn401_program_det_segments,
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
+	.wait_for_det_update = dcn401_wait_for_det_update,
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 44c1184868e0..22c7afbcfc4e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1663,3 +1663,94 @@ void dcn401_hardware_release(struct dc *dc)
 	}
 }
 
+void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+	int dpp_count = 0;
+
+	if (!otg_master->stream)
+		return;
+
+	int slice_count = resource_get_opp_heads_for_otg_master(otg_master,
+			&context->res_ctx, opp_heads);
+
+	for (int slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+		if (opp_heads[slice_idx]->plane_state) {
+			dpp_count = resource_get_dpp_pipes_for_opp_head(
+					opp_heads[slice_idx],
+					&context->res_ctx,
+					dpp_pipes);
+			for (int dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
+				struct pipe_ctx *dpp_pipe = dpp_pipes[dpp_idx];
+					if (dpp_pipe && hubbub &&
+						dpp_pipe->plane_res.hubp &&
+						hubbub->funcs->wait_for_det_update)
+						hubbub->funcs->wait_for_det_update(hubbub, dpp_pipe->plane_res.hubp->inst);
+			}
+		}
+	}
+}
+
+void dcn401_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock)
+{
+	unsigned int i = 0;
+	struct pipe_ctx *pipe = NULL;
+	struct timing_generator *tg = NULL;
+	bool pipe_unlocked[MAX_PIPES] = {0};
+
+	if (lock) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			tg = pipe->stream_res.tg;
+
+			if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+					!tg->funcs->is_tg_enabled(tg) ||
+					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+				continue;
+			dc->hwss.pipe_control_lock(dc, pipe, true);
+		}
+	} else {
+		/* Unlock pipes based on the change in DET allocation instead of pipe index
+		 * Prevents over allocation of DET during unlock process
+		 * e.g. 2 pipe config with different streams with a max of 20 DET segments
+		 *	Before:								After:
+		 *		- Pipe0: 10 DET segments			- Pipe0: 12 DET segments
+		 *		- Pipe1: 10 DET segments			- Pipe1: 8 DET segments
+		 * If Pipe0 gets updated first, 22 DET segments will be allocated
+		 */
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			tg = pipe->stream_res.tg;
+			int current_pipe_idx = i;
+
+			if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+					!tg->funcs->is_tg_enabled(tg) ||
+					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
+				pipe_unlocked[i] = true;
+				continue;
+			}
+
+			// If the same stream exists in old context, ensure the OTG_MASTER pipes for the same stream get compared
+			struct pipe_ctx *old_otg_master = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, pipe->stream);
+
+			if (old_otg_master)
+				current_pipe_idx = old_otg_master->pipe_idx;
+			if (resource_calculate_det_for_stream(context, pipe) <
+					resource_calculate_det_for_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[current_pipe_idx])) {
+				dc->hwss.pipe_control_lock(dc, pipe, false);
+				pipe_unlocked[i] = true;
+				dcn401_wait_for_det_buffer_update(dc, context, pipe);
+			}
+		}
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (pipe_unlocked[i])
+				continue;
+			pipe = &context->res_ctx.pipe_ctx[i];
+			dc->hwss.pipe_control_lock(dc, pipe, false);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 8e9c1c17aa66..3ecb1ebffcee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -81,4 +81,6 @@ void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		struct pipe_ctx *otg_master);
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy);
+void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
+void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index f4eda4a55ea7..b5f63675afcb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -38,7 +38,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.interdependent_update_lock = dcn32_interdependent_update_lock,
+	.interdependent_update_lock = dcn401_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn401_prepare_bandwidth,
 	.optimize_bandwidth = dcn401_optimize_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index dd2b2864876c..67c32401893e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -227,6 +227,7 @@ struct hubbub_funcs {
 	void (*get_mall_en)(struct hubbub *hubbub, unsigned int *mall_in_use);
 	void (*program_det_segments)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
+	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 96d40d33a1f9..9cd80d3864c7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -639,4 +639,9 @@ struct dscl_prog_data *resource_get_dscl_prog_data(struct pipe_ctx *pipe_ctx);
  * @dml2_options: struct to hold callbacks
  */
 void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuration_options *dml2_options);
+
+/*
+ *Calculate total DET allocated for all pipes for a given OTG_MASTER pipe
+ */
+int resource_calculate_det_for_stream(struct dc_state *state, struct pipe_ctx *otg_master);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.34.1

