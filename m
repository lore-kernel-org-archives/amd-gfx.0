Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93DBC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AAD10E8BE;
	Wed, 10 Jul 2024 19:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G5RbLLjv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEFA10E8BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXCKTgca+4XQSlWVelO1Ml9h0XWM3VonsOt6vkJ7vHobHSuxzryhltQDSRFFEMwUKAKiyhPaQPICUr43LZU6PrYaUr9MC3Zm5fOfKnnB9r5+50P/22G2pcBl7CTWRx60nD0EVF/ArB2pint6ao/ot6vvEu1bSQRRAVLe/oXeO6Q26d7lSb26XqYIJ/Akk7RAfe/YKUzcyr5hCNrPAvN1gpcnJA39FS2P2RXSV/53/bcxOWmTEdPGwVYv3vBR/AewlONSNlQAamHtveMIAv/hIcpf9sYb7umMwUEhRiDD0XbRIfGbC8P5CK6eDWuNkdJ0Zs78L0VpKwb2qiuNVjJh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rRnGQCB7TRvAmbClMG/I8biEjG91lgpuXpdm+BfVtk=;
 b=VxrHEXz+EtA/M3WJqB4W8TUVH199RcenUeBDo8YUCjcjLtNCQEPqzOJaTfKrB8qJB4MP6Hf6k+Uetu5eB2ScMZcQVPtb3dwFbAdBuExHeNbt886RzyBpsaR+/0Cb38S9rin+IK3we2batuyBHDp/sGylLJYdOoz1vmLqSX0NcAQ9mI2xGrI7g0ZdaHjBdx5T/bJGgsvQGnj/+Vd/wZJSPVozXe3zYDdPn8ZH/jzhiiaA06m2FVUNrnjUWCmPci1weVRiKdHnkdQ32VUtk8sORdrsoRZecIwkDxfjLxZka+vC60T6TsvNY5VqJNEp1lxOdSr2occT9UPCf+T4Sr5Yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rRnGQCB7TRvAmbClMG/I8biEjG91lgpuXpdm+BfVtk=;
 b=G5RbLLjvQUb62zcawGAv4GCfmSSKorwjf8XW2/n0ZhPKQDsJJ/IQygVEBt27/BVScA6DZWL4gYYnl2Flow6Eg08JcIbL2S9PMPhpC3iYqZHgGPRTQiUpc97/KQtovMXcjC+N2LzaBaLhkz8W75dhXnNTe9azJSc0CGIXbnqD6Hg=
Received: from BLAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:32b::34)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:07 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::65) by BLAPR03CA0029.outlook.office365.com
 (2603:10b6:208:32b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:03 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:57 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 37/50] drm/amd/display: Check null pointers before multiple
 uses
Date: Wed, 10 Jul 2024 15:36:54 -0400
Message-ID: <20240710193707.43754-38-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d7367-5e66-4a2f-f92c-08dca1181a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2N+UqtZCDrmabfrgzNkiBn66Ucc30dS59qOaDGEmtTSTfWA2obgHvS7vvA3?=
 =?us-ascii?Q?Y+zIiA2OIN0RBRHPlWcixEGgPN2weHGlhR3bg71/e1I+2uIzlvA/vCNOOoMo?=
 =?us-ascii?Q?Z8YS8/VpNOEiFxDt8mRstHoTvJ3w33FdPEUof8k+seIi2INwUUjBQpFbz8D5?=
 =?us-ascii?Q?K1xfSb/68584unf8tWvHulh6Z7LmT+BNXqxbHPz2S3YZJf7GYU29IYytJMiU?=
 =?us-ascii?Q?ALS/YynkzJDdXnXvduvIIdBzovrMBQMSjFfPTD5eyh0oNg28kQ2wbQCnZqrZ?=
 =?us-ascii?Q?hohw1DWN50WFDu1aWKsZwf7jcNDU0b5pCmAVW7nUHMPVr3wUeo5o06NoITRj?=
 =?us-ascii?Q?D+6TqPYI5jbFZ32xWrxT1a+8aJdjMe7agqhi3pibGX9xTjqDfgL8+Po7PU85?=
 =?us-ascii?Q?SmPve2TvmqtAnMK0qR8vAgQpufESdgKMRXXBKtZHNJGip9w2prvXXraXOKtW?=
 =?us-ascii?Q?Q2lmG+W7uNPpvi49EpiOzhrS7aPRCm5Ai/O3AGR9c/LgV3Rc0T3C3S9hvJSM?=
 =?us-ascii?Q?O5rJ9Rlwgrr4+3FlYxR2OiRpOJJW1LX5A+fxDuCsfayr/en1cwHtVMPBSvp3?=
 =?us-ascii?Q?LbpzAxhtAesFr7pznh9FdLKIXEkjvDmFC3UL+zVTih+qzx/YAQbqxnut9wIJ?=
 =?us-ascii?Q?lv0x4o5YTYwbg6w3De6l9vL5PbAcpNlNCUe5hON6lovJYg62cV2y+HS4w79H?=
 =?us-ascii?Q?BEoiYE91RDLPZgdi1ZWDpEsoxHJwgrPLFUH//+WX9k3NgJJMoTFeWIDTMUN/?=
 =?us-ascii?Q?em+s+QYFAf/5dIWJi6CL/+v6jHSE+X9maD6uqgI/eqAiclayS2nxpSvKyPXe?=
 =?us-ascii?Q?qXZ93zvSPMlJNzdJepib8aWPi5KM0tIKatyyCR4qt5AJDpyWqawmVC1y3P3x?=
 =?us-ascii?Q?POB9LVd/NQUM26hSRt164srUPPhtj+BP9+I5IsPXT/jIGFKeNk2d3LT2JbyT?=
 =?us-ascii?Q?foSxUGrr96gYoy2MCR6ULxvkQt+a7L7P1E8bLNMyFfwgUdKicqdR0FkDKCpq?=
 =?us-ascii?Q?63QIxr0dpD9dudr9BCA1O37SNKAlhR6e4Ijb7QTjFzqZ3fMG4dSwcGxaYik4?=
 =?us-ascii?Q?oENZuzshGBaSPXhhKn5Hb4Y6LP6taS1uj75Gnikqh+4VKuOZWEB1nIGKZz6q?=
 =?us-ascii?Q?N71Hj4ZCNFbgp9b8+gudQ159M1io3aNSlDowXgNqKn+/yZvywOBHCVsyQDdZ?=
 =?us-ascii?Q?oYctSWNjzQMGGF1mmMXxLLgTDpYYn3HHmhnHsfy3EJzTXPA85ZUVYx8k0Cv9?=
 =?us-ascii?Q?MdQnX/YLRU542Q3z6GObaIL9zEK0Kwv0VwMBKyNfxtA8f8/jheUmNh9JCt0R?=
 =?us-ascii?Q?ZE4i36Kj7dkJmt4pGUvBs1uouuw0BIGXCxK0i8s5D7x7+qatHcMXyDni9cTU?=
 =?us-ascii?Q?NwVcgPQ1Euh/PS56CAEodlo5sVrKVI/TaTxo7BphiEQHeCEVjkngDuTb+7bb?=
 =?us-ascii?Q?Qdc6AlxtX00IiZXX1JHYcKu3D5h7tcUc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:07.4767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d7367-5e66-4a2f-f92c-08dca1181a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Poniters, such as stream_enc and dc->bw_vbios, are null checked previously
in the same function, so Coverity warns "implies that stream_enc and
dc->bw_vbios might be null". They are used multiple times in the
subsequent code and need to be checked.

This fixes 10 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 96 ++++++++++---------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  8 +-
 .../display/dc/link/accessories/link_dp_cts.c |  5 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  5 +-
 .../dc/resource/dce112/dce112_resource.c      |  5 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  3 +
 .../resource/dcn32/dcn32_resource_helpers.c   | 10 +-
 7 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 9e42a0128baa..5f9b6e8ef428 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -636,57 +636,59 @@ void hwss_build_fast_sequence(struct dc *dc,
 	while (current_pipe) {
 		current_mpc_pipe = current_pipe;
 		while (current_mpc_pipe) {
-			if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state && current_mpc_pipe->plane_state->update_flags.raw) {
-				block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
-				block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
-				(*num_steps)++;
-			}
-			if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && current_mpc_pipe->plane_state->update_flags.raw) {
-				block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
-				block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
-				block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
-				(*num_steps)++;
-			}
-			if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
-				if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
-						stream_status->mall_stream_config.type == SUBVP_MAIN) {
-					block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
-					block_sequence[*num_steps].params.subvp_save_surf_addr.addr = &current_mpc_pipe->plane_state->address;
-					block_sequence[*num_steps].params.subvp_save_surf_addr.subvp_index = current_mpc_pipe->subvp_index;
-					block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+			if (current_mpc_pipe->plane_state) {
+				if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state->update_flags.raw) {
+					block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
+					block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
+					(*num_steps)++;
+				}
+				if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && current_mpc_pipe->plane_state->update_flags.raw) {
+					block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
+					block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
+					block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
+					(*num_steps)++;
+				}
+				if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
+					if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
+							stream_status->mall_stream_config.type == SUBVP_MAIN) {
+						block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
+						block_sequence[*num_steps].params.subvp_save_surf_addr.addr = &current_mpc_pipe->plane_state->address;
+						block_sequence[*num_steps].params.subvp_save_surf_addr.subvp_index = current_mpc_pipe->subvp_index;
+						block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+						(*num_steps)++;
+					}
+
+					block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
+					block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
 					(*num_steps)++;
 				}
 
-				block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
-				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
-				(*num_steps)++;
-			}
-
-			if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
-				block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
-				block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
-				block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
-				(*num_steps)++;
-			}
+				if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
+					block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
+					block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
+					block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
+					(*num_steps)++;
+				}
 
-			if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
-				block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
-				(*num_steps)++;
-			}
-			if (current_mpc_pipe->plane_state->update_flags.bits.input_csc_change) {
-				block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_SETUP_DPP;
-				(*num_steps)++;
-			}
-			if (current_mpc_pipe->plane_state->update_flags.bits.coeff_reduction_change) {
-				block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
-				(*num_steps)++;
+				if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
+					block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
+					(*num_steps)++;
+				}
+				if (current_mpc_pipe->plane_state->update_flags.bits.input_csc_change) {
+					block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_SETUP_DPP;
+					(*num_steps)++;
+				}
+				if (current_mpc_pipe->plane_state->update_flags.bits.coeff_reduction_change) {
+					block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
+					(*num_steps)++;
+				}
 			}
 			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
 				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index dd652436a539..bd7b186fb2e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2284,6 +2284,9 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	if (!hwseq)
+		return;
+
 	/* P-State support transitions:
 	 * Natural -> FPO: 		P-State disabled in prepare, force disallow anytime is safe
 	 * FPO -> Natural: 		Unforce anytime after FW disable is safe (P-State will assert naturally)
@@ -2291,7 +2294,7 @@ void dcn20_post_unlock_program_front_end(
 	 * FPO -> Unsupported:	P-State disabled in prepare, unforce disallow anytime is safe
 	 * FPO <-> SubVP:		Force disallow is maintained on the FPO / SubVP pipes
 	 */
-	if (hwseq && hwseq->funcs.update_force_pstate)
+	if (hwseq->funcs.update_force_pstate)
 		dc->hwseq->funcs.update_force_pstate(dc, context);
 
 	/* Only program the MALL registers after all the main and phantom pipes
@@ -2531,6 +2534,9 @@ bool dcn20_wait_for_blank_complete(
 {
 	int counter;
 
+	if (!opp)
+		return false;
+
 	for (counter = 0; counter < 1000; counter++) {
 		if (!opp->funcs->dpg_is_pending(opp))
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 555c1c484cfd..df3781081da7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -804,8 +804,11 @@ bool dp_set_test_pattern(
 			break;
 		}
 
+		if (!pipe_ctx->stream)
+			return false;
+
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
+			if (should_use_dmub_lock(pipe_ctx->stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 50459d7a0f85..81e335280e0f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -64,7 +64,10 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
-	if (stream_enc && stream_enc->funcs->disable_fifo)
+	if (!stream_enc)
+		return;
+
+	if (stream_enc->funcs->disable_fifo)
 		stream_enc->funcs->disable_fifo(stream_enc);
 	if (stream_enc->funcs->set_input_mode)
 		stream_enc->funcs->set_input_mode(stream_enc, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 88afb2a30eef..162856c523e4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -1067,7 +1067,10 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	struct dm_pp_clock_levels clks = {0};
 	int memory_type_multiplier = MEMORY_TYPE_MULTIPLIER_CZ;
 
-	if (dc->bw_vbios && dc->bw_vbios->memory_type == bw_def_hbm)
+	if (!dc->bw_vbios)
+		return;
+
+	if (dc->bw_vbios->memory_type == bw_def_hbm)
 		memory_type_multiplier = MEMORY_TYPE_HBM;
 
 	/*do system clock  TODO PPLIB: after PPLIB implement,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ee009716d39b..6eaf3cfebcb7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1651,6 +1651,9 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		else
 			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
 
+		if (!phantom_plane)
+			continue;
+
 		memcpy(&phantom_plane->address, &curr_pipe->plane_state->address, sizeof(phantom_plane->address));
 		memcpy(&phantom_plane->scaling_quality, &curr_pipe->plane_state->scaling_quality,
 				sizeof(phantom_plane->scaling_quality));
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index d184105ce2b3..47c8a9fbe754 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -218,12 +218,12 @@ bool dcn32_is_center_timing(struct pipe_ctx *pipe)
 				pipe->stream->timing.v_addressable != pipe->stream->src.height) {
 			is_center_timing = true;
 		}
-	}
 
-	if (pipe->plane_state) {
-		if (pipe->stream->timing.v_addressable != pipe->plane_state->dst_rect.height &&
-				pipe->stream->timing.v_addressable != pipe->plane_state->src_rect.height) {
-			is_center_timing = true;
+		if (pipe->plane_state) {
+			if (pipe->stream->timing.v_addressable != pipe->plane_state->dst_rect.height &&
+					pipe->stream->timing.v_addressable != pipe->plane_state->src_rect.height) {
+				is_center_timing = true;
+			}
 		}
 	}
 
-- 
2.34.1

