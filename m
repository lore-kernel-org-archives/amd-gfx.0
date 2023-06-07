Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1A4C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBA910E4DC;
	Wed,  7 Jun 2023 12:17:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5F410E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/emr9mz3QZn3eZwqMi2KWw0ib0gKyxMgqUy9w77QS8u0tnDhK2Tp65s83n2LRQNQyn1k5JAQoFaYVXcll9Qn29f1n8SLrI+OVNsx9hzYHdE0dK4gtnk+Eg6gUxsMJy8dooC8mgYursI5kE+vc0WYpX8aLuSObNkWyl4oNJY3bYLLhRarmVfUBeCP9dIznNQDnLvYXfkk+g7AywkavD9E+QL+sSxD9DqCTI1Kbho8y3f8RG66JtsSBlLnYVB5kK7L4K+8eddkbqXn4bY/sj8KjP812R0HoELo2AhXQkc1qgSPclJ0+4gMSQ+SDNGwZXZXuOormp5zFqIVNti06yUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz3RVnfuIDKPALPYL8noKqpdNCRc39joY1ttfCwG2yI=;
 b=RjJb6VgzM2OkLnVzDS4Q53Wqx7Yp1U/IMNHwsHCXIEJ4iIKhzkiyZcS0Tf7cAlnBRL2pAakv95o3YhcTnVmpcob9usozgvcm0xCf4RpULquhXFcbKIm3Y0HVEY9wuIzU+A+ujbo1drKjha9o4yZTDI5Ou3hlqJY+rzXI29ovRbCJSLMuGeQecGPa0PqkHYjGrQBB9A/AVpfoE4K8MSZ8UjU9RTei0jx3ap/xQaVsDAJRSiW/QruJEHHta8pMnZmzgp58VTdPZ4q+0+OQhzMxftNqdhteH/E8sVD6ADf2+vICyJWeDciBf9hyDcgcDBwDfMKwP/xBaD2hvo9p+fGxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz3RVnfuIDKPALPYL8noKqpdNCRc39joY1ttfCwG2yI=;
 b=wImjLFAldqnPU4Vk9Z9LEqL6b1MlKzsb9vkwJk79Qve/qLiZ4C5rN7MasGaJOEjtAohH3BdOXVciaNkgW95NplgfIn1ovzbWCFsaVazSGGGlsn/k2OjzKQVSrwwHOybNZW756KI3SN09UbamqeZ2zWzK7KkxPw4bQYRcMVADr9k=
Received: from DS7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::29) by
 LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:15 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::f7) by DS7P222CA0008.outlook.office365.com
 (2603:10b6:8:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:15 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:11 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/20] drm/amd/display: Include CSC updates in new fast update
 path
Date: Wed, 7 Jun 2023 20:15:44 +0800
Message-ID: <20230607121548.1479290-17-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd6e03c-ec8e-4c1c-58a2-08db67512171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yhp1hWW4ELm+O5YWGySSghHUQ0XoLEEKGohKKjWfULvqvckPH3IdoFLJKOrc2whyQiQKRUcZ7NqqkpGsWvg/xvV2Jb3fRKHxalJlugqI79pNjh4lrdp4+EYQ+ItgUoS4hygUIbscZ5ATSqg/g0mo7hU6RKazd4GAudjf8NThbR9XHSiAVZJnauKqNkucOb0bAeDO4W7rxI2+RZ1ulmeRSLpq3bkJx6fPgIDdWdZPyzZylm9o/l5X2e7KBp/SNgl0bsi1C3ayh0dGQ5gsUvlnTFZG47L/ZQEkbfag0BBQ536P/C2Bkf6SubPoqNMQR/7eRJdbOzEOHFQGIb8+edqHg96NFgYKknwBHehBIuNz33TtG7Px0Loqe/Bcs82uErKaizWcM7RAJ58VJjJHOo0M24voxZ8t+gN0vNYddCbx9f2huPMQeVy6XBB+ePU0cQXyIo+PNuCY4x03TceR2wBqc6I3hmktkyJUuFvhVDEgOrtFa3RzWQMWmq6Z+GEYxe0N0DyBtR1Zl6AxAWP2tQ2UfU+v2rZa55rFmxVryWTnFiYjOTfS0Qudi+q/yQdmy84Zv3Nuqw3x+1IG7EWaT5kqeM0kRyWMpH8CdjC0fjTLCydul+SyNUkXOJ6y2A8rqSRCg1dwJXMimYnE/CehZ/MN/Cmb7DXzDmFHFxq2uXtxxf4IO8NjKtGgP+ewOGTWtjnijVox2tCCw+PInBX29bgPW2t+HkEqhi5p1tP4rLhl4dlrLcFDLw3wbGi1poeYgZBIpO+54f4svTUFBmiFDBxjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(6666004)(83380400001)(36860700001)(16526019)(186003)(336012)(36756003)(2616005)(426003)(86362001)(82310400005)(81166007)(356005)(47076005)(82740400003)(1076003)(26005)(40480700001)(316002)(54906003)(70586007)(70206006)(8676002)(8936002)(4326008)(6916009)(5660300002)(44832011)(41300700001)(2906002)(15650500001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:15.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd6e03c-ec8e-4c1c-58a2-08db67512171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Missed color / CSC updates in fast update path
  which caused Custom Color to break.
- Add color / CSC updates to new fast update path
  to fix custom color

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 70 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 32 +++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 182c42c63bc5..d7d00fefaab9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -562,6 +562,29 @@ void hwss_build_fast_sequence(struct dc *dc,
 				(*num_steps)++;
 			}
 
+			if (current_mpc_pipe->stream->update_flags.bits.out_csc) {
+				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpc = dc->res_pool->mpc;
+				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.power_on = true;
+				block_sequence[*num_steps].func = MPC_POWER_ON_MPC_MEM_PWR;
+				(*num_steps)++;
+
+				if (current_mpc_pipe->stream->csc_color_matrix.enable_adjustment == true) {
+					block_sequence[*num_steps].params.set_output_csc_params.mpc = dc->res_pool->mpc;
+					block_sequence[*num_steps].params.set_output_csc_params.opp_id = current_mpc_pipe->stream_res.opp->inst;
+					block_sequence[*num_steps].params.set_output_csc_params.regval = current_mpc_pipe->stream->csc_color_matrix.matrix;
+					block_sequence[*num_steps].params.set_output_csc_params.ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
+					block_sequence[*num_steps].func = MPC_SET_OUTPUT_CSC;
+					(*num_steps)++;
+				} else {
+					block_sequence[*num_steps].params.set_ocsc_default_params.mpc = dc->res_pool->mpc;
+					block_sequence[*num_steps].params.set_ocsc_default_params.opp_id = current_mpc_pipe->stream_res.opp->inst;
+					block_sequence[*num_steps].params.set_ocsc_default_params.color_space = current_mpc_pipe->stream->output_color_space;
+					block_sequence[*num_steps].params.set_ocsc_default_params.ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
+					block_sequence[*num_steps].func = MPC_SET_OCSC_DEFAULT;
+					(*num_steps)++;
+				}
+			}
 			current_mpc_pipe = current_mpc_pipe->bottom_pipe;
 		}
 		current_pipe = current_pipe->next_odm_pipe;
@@ -661,6 +684,15 @@ void hwss_execute_sequence(struct dc *dc,
 					params->update_visual_confirm_params.pipe_ctx,
 					params->update_visual_confirm_params.mpcc_id);
 			break;
+		case MPC_POWER_ON_MPC_MEM_PWR:
+			hwss_power_on_mpc_mem_pwr(params);
+			break;
+		case MPC_SET_OUTPUT_CSC:
+			hwss_set_output_csc(params);
+			break;
+		case MPC_SET_OCSC_DEFAULT:
+			hwss_set_ocsc_default(params);
+			break;
 		case DMUB_SEND_DMCUB_CMD:
 			hwss_send_dmcub_cmd(params);
 			break;
@@ -718,6 +750,44 @@ void hwss_program_bias_and_scale(union block_sequence_params *params)
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 }
 
+void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->power_on_mpc_mem_pwr_params.mpc;
+	int mpcc_id = params->power_on_mpc_mem_pwr_params.mpcc_id;
+	bool power_on = params->power_on_mpc_mem_pwr_params.power_on;
+
+	if (mpc->funcs->power_on_mpc_mem_pwr)
+		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, power_on);
+}
+
+void hwss_set_output_csc(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->set_output_csc_params.mpc;
+	int opp_id = params->set_output_csc_params.opp_id;
+	const uint16_t *matrix = params->set_output_csc_params.regval;
+	enum mpc_output_csc_mode ocsc_mode = params->set_output_csc_params.ocsc_mode;
+
+	if (mpc->funcs->set_output_csc != NULL)
+		mpc->funcs->set_output_csc(mpc,
+				opp_id,
+				matrix,
+				ocsc_mode);
+}
+
+void hwss_set_ocsc_default(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->set_ocsc_default_params.mpc;
+	int opp_id = params->set_ocsc_default_params.opp_id;
+	enum dc_color_space colorspace = params->set_ocsc_default_params.color_space;
+	enum mpc_output_csc_mode ocsc_mode = params->set_ocsc_default_params.ocsc_mode;
+
+	if (mpc->funcs->set_ocsc_default != NULL)
+		mpc->funcs->set_ocsc_default(mpc,
+				opp_id,
+				colorspace,
+				ocsc_mode);
+}
+
 void get_mclk_switch_visual_confirm_color(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index cc0a3a992f7b..02ff99f7bec2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -114,6 +114,26 @@ struct update_visual_confirm_params {
 	int mpcc_id;
 };
 
+struct power_on_mpc_mem_pwr_params {
+	struct mpc *mpc;
+	int mpcc_id;
+	bool power_on;
+};
+
+struct set_output_csc_params {
+	struct mpc *mpc;
+	int opp_id;
+	const uint16_t *regval;
+	enum mpc_output_csc_mode ocsc_mode;
+};
+
+struct set_ocsc_default_params {
+	struct mpc *mpc;
+	int opp_id;
+	enum dc_color_space color_space;
+	enum mpc_output_csc_mode ocsc_mode;
+};
+
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
@@ -128,6 +148,9 @@ union block_sequence_params {
 	struct program_bias_and_scale_params program_bias_and_scale_params;
 	struct set_output_transfer_func_params set_output_transfer_func_params;
 	struct update_visual_confirm_params update_visual_confirm_params;
+	struct power_on_mpc_mem_pwr_params power_on_mpc_mem_pwr_params;
+	struct set_output_csc_params set_output_csc_params;
+	struct set_ocsc_default_params set_ocsc_default_params;
 };
 
 enum block_sequence_func {
@@ -144,6 +167,9 @@ enum block_sequence_func {
 	DPP_PROGRAM_BIAS_AND_SCALE,
 	DPP_SET_OUTPUT_TRANSFER_FUNC,
 	MPC_UPDATE_VISUAL_CONFIRM,
+	MPC_POWER_ON_MPC_MEM_PWR,
+	MPC_SET_OUTPUT_CSC,
+	MPC_SET_OCSC_DEFAULT,
 };
 
 struct block_sequence {
@@ -439,4 +465,10 @@ void hwss_setup_dpp(union block_sequence_params *params);
 
 void hwss_program_bias_and_scale(union block_sequence_params *params);
 
+void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params);
+
+void hwss_set_output_csc(union block_sequence_params *params);
+
+void hwss_set_ocsc_default(union block_sequence_params *params);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.40.1

