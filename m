Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB7ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9974410E7EF;
	Wed, 14 Sep 2022 03:29:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF60D10E7EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qsw0vdei1e2Zi5hDoFXHIiTfP4lc+Z0Ztc0Rsps8UJC6r/m2mznbsUfHCuS81yf/7gn7IJPHOilTEBsemm2/OZNKHEcmHJwCOB9Hy+jtd0yq2sXEqQnyzVBRBXkXOFtHc5zEgkKytr7aysz/ys6dRPrTLd0vTUlGN1rzahUuPlSFPXJ1ab61DG8xA+MLNOvgyE33HtZeaop2LPArzf3mHAn2Ms6TkZX9PBV/6glK6fCdk1HhEBwowz2dkUbxSM0BGmFizZ0u6TTtdZ558vRksAo+07FMhFZ+dSS/7ZzG7wvwo3x7YI1AZ25rCyHEkzE8OAR8dYtkwKjURn7OS6oFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ijor3YFc05UyA8CtRdonVDWKEueofgqpgM6Qmfb+l8=;
 b=NZkYVADFg9b0rM9UTrJ6acWVo++GpeSVzMtTfWv0RjcDLcFUkXObkw/qVfMBsUa5Ai2+1OJwEVbFWwyB336e873DOml12cY2KKF1Uf1dSoaOuSpKL/eAtH9x7lfxMuKa/Wge0eCtsIUUSnGk3wdg9f9eAbG5llCG0yow6v9pn987/25jXrqBHRW9Vnpwn9xsSnQJXfJdLkNX2X4Jbr4tq5OEmGvpPcfBT7ZR/JG9e8yWxhZxM06ufruA1WgeBaZG+G5aV4LGHM+trhP/icRYNiSD4DA8ZPCV0gJiylhp+ffF5zMgJD0knJnQyUQ7p30oYW+idzK1M8DVxssHW3jIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ijor3YFc05UyA8CtRdonVDWKEueofgqpgM6Qmfb+l8=;
 b=1KR1eoTwMQ/t/QZ6PORmaXOePUGaSuibJMReH9VTv0ExgR27A+Bzyp+/8JZNliF2LB4vfAtfJvkZZ/L0PGv3DPFWMUkO/Q4E0qpKj0yBUjaNQjBacsJS8plux2XPFy4J3Qepd+pSm6TqPGO8EWnTo/k0o884iukeG5zgorQa6LE=
Received: from BN1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:408:e2::34)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:29:26 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::e) by BN1PR13CA0029.outlook.office365.com
 (2603:10b6:408:e2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:29:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:29:25 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:29:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/47] drm/amd/display: SubVP pipe split case
Date: Wed, 14 Sep 2022 11:24:08 +0800
Message-ID: <20220914032441.1075031-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 14176437-1972-4e25-3381-08da96015309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le7WQME4u33LLGL1U70HSMZqzhosqNS0LCJs4l0OFo2lmG62fQNt4Ch0YMBUTzMeVQFi8kAWBHKrXxyVsR1VsOKzrGjFJ7ydVlHhXXcIlUASxb8b8FfWk60EBVPfiH580IMlZi0mf679VDzfeRy81Sc/4j5sPmK6HhcszaLCbSwwqJe6tvgUKFnxLa/0JkJroMngDnoDsBPbg7ufN/cW+//fyWnNWeJGltJaQghzwGUCpKEPLzTaESECY0k09HJkZx+g4CZ3pPYVZQ6EVQFX1r1Ac+K8XIWLOtDQWvx5zlQ3wtzpz4OAWKVkK+eLHlm3HZW5fgGRjU+prW5qcUZEWqYqQ/hQSlpeBV449NOSCnVAp0fTh46mjWVQFYiZttirmMplHekA5fe69d1C6AWv6x/ZNnUtF4ZSyYmIDoH4iPsf2c2oWP9l7a+WP3Nc9HBX97QQN3tNr5F/E5gcvwLOh2+S3UVgrV82ZF5fmLShnPO09fLt+tIfsHr7L2xdYM/p1QydlTDouJ13HFFhYjzDS+Q21WMcq8sNFt//9OBehXNkj1jiNIBQdl/KdLBII8D+mFhEu6TcDURx4W9oepZL8VgL762XzhrntmsOAD8n1YT/mzzX0jzXxg0ZkBc7E331x5l/nECnMlvT/bU1jM6BUwXjGsu8+eb5pM0JJhEECjeHSkKPrSiT01ptOMtc4GyJ7IWr+TulL+duj0QOSfEOAsncQ7ox1BBKygnlJKltIiwCGJMcvtbC95tcPe9I2GdAdkiiAEkxZkjLm8fnQopD2HMcnwyY1oiVzfmi8MqaF/VYdsd1T9Ic6rbRNKM/bH07
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(6916009)(26005)(6666004)(36860700001)(186003)(70586007)(47076005)(70206006)(5660300002)(81166007)(426003)(82740400003)(40480700001)(356005)(82310400005)(478600001)(316002)(36756003)(4326008)(7696005)(54906003)(86362001)(40460700003)(2906002)(41300700001)(8676002)(2616005)(336012)(83380400001)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:29:25.7967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14176437-1972-4e25-3381-08da96015309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
For SubVP pipe split case, pass in split index for
main and phantom pipes to ensure that the P-State
sequence will force P-State for all required pipes.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 29 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 ++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 18 ++++++++----
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index df5ad02fc4b3..f09a3ddcf30d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -674,12 +674,32 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
 			div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
+
+	/* TODO: Uncomment once FW headers are promoted
+	if (subvp_pipe->bottom_pipe) {
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->bottom_pipe->pipe_idx;
+	} else if (subvp_pipe->next_odm_pipe) {
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->next_odm_pipe->pipe_idx;
+	} else {
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0;
+	}
+	*/
+
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
 
 		if (phantom_pipe->stream == subvp_pipe->stream->mall_stream_config.paired_stream) {
 			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->pipe_idx;
+			/* TODO: Uncomment once FW headers are promoted
+			if (phantom_pipe->bottom_pipe) {
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->pipe_idx;
+			} else if (phantom_pipe->next_odm_pipe) {
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->next_odm_pipe->pipe_idx;
+			} else {
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0;
+			}
+			*/
 			break;
 		}
 	}
@@ -724,7 +744,9 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		if (!pipe->stream)
 			continue;
 
-		if (pipe->plane_state && !pipe->top_pipe &&
+		/* For SubVP pipe count, only count the top most (ODM / MPC) pipe
+		 */
+		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
 				pipe->stream->mall_stream_config.type == SUBVP_MAIN)
 			subvp_pipes[subvp_count++] = pipe;
 	}
@@ -737,7 +759,12 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 			if (!pipe->stream)
 				continue;
 
+			/* When populating subvp cmd info, only pass in the top most (ODM / MPC) pipe.
+			 * Any ODM or MPC splits being used in SubVP will be handled internally in
+			 * populate_subvp_cmd_pipe_info
+			 */
 			if (pipe->plane_state && pipe->stream->mall_stream_config.paired_stream &&
+					!pipe->top_pipe && !pipe->prev_odm_pipe &&
 					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
 			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 86ab3a71c67b..ab56f14d6247 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1906,10 +1906,13 @@ void dcn20_post_unlock_program_front_end(
 			 * can underflow due to HUBP_VTG_SEL programming if done in the regular front end
 			 * programming sequence).
 			 */
-			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				if (dc->hwss.update_phantom_vp_position)
-					dc->hwss.update_phantom_vp_position(dc, context, pipe);
-				dcn20_program_pipe(dc, pipe, context);
+			while (pipe) {
+				if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+					if (dc->hwss.update_phantom_vp_position)
+						dc->hwss.update_phantom_vp_position(dc, context, pipe);
+					dcn20_program_pipe(dc, pipe, context);
+				}
+				pipe = pipe->bottom_pipe;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2b3ffa300f25..7ff7cd8b5c93 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1160,17 +1160,23 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 				vba->VoltageLevel = *vlevel;
 			}
 		} else {
-			// only call dcn20_validate_apply_pipe_split_flags if we found a supported config
-			memset(split, 0, MAX_PIPES * sizeof(int));
-			memset(merge, 0, MAX_PIPES * sizeof(bool));
-			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
-			vba->VoltageLevel = *vlevel;
-
 			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
 			DC_FP_START();
 			dcn32_helper_populate_phantom_dlg_params(dc, context, pipes, *pipe_cnt);
 			DC_FP_END();
 
+			/* Call validate_apply_pipe_split flags after calling DML getters for
+			 * phantom dlg params, or some of the VBA params indicating pipe split
+			 * can be overwritten by the getters.
+			 *
+			 * When setting up SubVP config, all pipes are merged before attempting to
+			 * add phantom pipes. If pipe split (ODM / MPC) is required, both the main
+			 * and phantom pipes will be split in the regular pipe splitting sequence.
+			 */
+			memset(split, 0, MAX_PIPES * sizeof(int));
+			memset(merge, 0, MAX_PIPES * sizeof(bool));
+			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+			vba->VoltageLevel = *vlevel;
 			// Note: We can't apply the phantom pipes to hardware at this time. We have to wait
 			// until driver has acquired the DMCUB lock to do it safely.
 		}
-- 
2.37.3

