Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A377ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC45C10E833;
	Wed, 14 Sep 2022 05:14:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE5410E833
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXLBrJr6E89wmNiUHPQ+U/oET2XdrSt4cpfRQWSQ9reAJijbeCQcrYYoUr+K+5jhycj+A5uGVnBCWo4oa4Gqozl/PpPlpTgW4CigQ99Ef7vfW4XEtjyrnaIKCOKSAGJuzt0nHyNBwMEU0yf6CmjT4ZKE940rkneYTJPjOSt/Rx7YMTvnZkZQ2w5lMagxGYHIOQPYak72maywQbn+dYlcwKPL84OGgxFMw3vV4qwcFo4AHixzD70wHrgx0cV8zh2HfzWyYbULV0INJPBrVx2yFRYpnzdL1ieLp8B/7U7MzK8ZOq2L/b+ZCEOBpCBG90o8p0VHPzljbWbwWfMYWzFDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ijor3YFc05UyA8CtRdonVDWKEueofgqpgM6Qmfb+l8=;
 b=jREXBTfrKW/YwnQlBG14GlJTi1FVYFCHe2geDlSXm/meCnfSHlkft1eQz7JIGWbNswz8w/VTawto4xP6q8Mbq1ygiKx6BY+qRPKr6lsCDrMnfT4wYK6tQ+0jnPp6diyKuna48+w+vjzF508ZsF5byREu7QKuwLmQEmVi+X1c7JIfJoAmXvb1Klkgdn4k7Bc1iMsW9isr2zctexNU2AjRmMqsl1TaeaLyIMPO+iLRQbdcBCdxOU6oX/Xi/nDmU5kQZ0Y1Y1PWzxutgr8jSVH0antZbUFiXxx8wbOz0I+rgFAYApjaBt1BnnuJwfb/0Mt/hDds9h/voBHHbXGvyJoysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ijor3YFc05UyA8CtRdonVDWKEueofgqpgM6Qmfb+l8=;
 b=KywBGUbNK0nX+I1tgI39fiCh0RGPZSUJrE71KICHrnhOTl2l94FQgBpLkQTUohLM/jJ/1s1Yi9C1moUfpDg6/tJ3OY6UGkwN8io4fiwiXHAMq4DYiHhqw59ODSFpcQAaYu5K+/QOXo9Xew85xc9ESvMaYN9alWZAyf7SzCHXH5Q=
Received: from DM6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:5:15b::14)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:14:12 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::2) by DM6PR18CA0001.outlook.office365.com
 (2603:10b6:5:15b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:14:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:14:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:13:38 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 14/47] drm/amd/display: SubVP pipe split case
Date: Wed, 14 Sep 2022 13:10:13 +0800
Message-ID: <20220914051046.1131186-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e81feb-53ba-4705-a7bb-08da960ff5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLofFXoiC4/od1ekz0619ChSZLEWoMaXg5vC1cCuZ0bKzDChvLiAiIPS0HEIb55/jiJct0YTcPX77PokhgoK91MGxrT/TkZktmR5bIFelp3zBLJfNrEHKHghvRCA7UuebHEIpJ0uhX3XkZFHbdV1VjRH+FrCOTrvZQEv2lepz/PYNNq+ZcAplXP/pA5ya59R2kY+pl9472G3zX0SAViWiYMMzkp8nWe22FgWZyhCqNUBEdnSUNr0iWpWKbGVaRlIk7Mj6Jms8L0yWTUk7AfsJnYZTbsJ2rcSpXdSxfv/74eitwj5TyGRbeG9j48a/ZR6TXbHN70shf5hXHzHYWu09quI9F/ji6AdNlonUWBjqavXY7roSpXWOJhdA//CQgcXsEdqA8mKAUTcyfCGIBSfVwZ10fLbtvhSXxS4X/BHOBb8D3Qb2cnxXEcrhOSiDGmuc8m3xDZC/rWHyuZBRcckGiYM27zD2QKpeaCSvWU2TNuGi8t4Qk+brTI2xEfxAkLe+7+UatDhFs38y3Nw/OZ7IUr0ZNoY4mVzb9EllGgCZ9KU82mLMLSLGMXM6GPNBaIzguYNCFdEvE6GVVew6QbU3UKGYN89NxNhKBzLcbo7aDkAryfNad0qtiEWTeMamDuDbkF1bh9MS+QtzWCVxDwt5sfvlI3DgAZ44LorpJp3FRS8+jlqJ/rahz076zbk/s7IzOlb9AZTnzN4zqxcacrIR+LQlppRAArtDOFYmQoQtexN55NbsXUQQ4dhhx/PajrIBVuwUfh3YGrhyUDRQ1kS7vqO8J1Jlgfqid7oe1CM0WgRqCZy8tq7DdenN0CaD76w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(8936002)(81166007)(356005)(5660300002)(82740400003)(2906002)(4326008)(8676002)(1076003)(36860700001)(2616005)(478600001)(70586007)(70206006)(40460700003)(6666004)(186003)(426003)(26005)(47076005)(82310400005)(7696005)(336012)(40480700001)(41300700001)(54906003)(6916009)(83380400001)(36756003)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:14:11.5686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e81feb-53ba-4705-a7bb-08da960ff5aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

