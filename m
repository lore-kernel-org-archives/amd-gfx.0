Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40EC10E57F;
	Wed,  9 Nov 2022 06:16:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7248610E57E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG3+RU+gsG7oPCENiruv7OToJ+MqlhXFTOkUWgIJxhZL5gqFFGXj/Q7/jp5I/wqiT1Y+j0FCRwBAa4tN3fTA1vlALZkwVx+wYvJoqDe7LzkpA/3p/U/mfPOWdpemx0bpH9609nAPmhA6KuwtScGRlewds6enUDzvhCfDSM5i2pbLlZF6W696GlcLaF/8eNcUbM/I9Y9bJB9DGZaeXQpp/U+N2A8gCtfrfakhnS9vTxnNf9bDidbz3wXzZJNM83bOYfMnQ/HrlGrPrxqX+pM2K8Bu4zCc2maJGpPFP6DVFncShe3NBBXIjXJ8tND4/iFSUpVUPE9Abo7xT9urHG0CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8znoN4gL8vmpI8G+JJglmgJjjs3lI2ZBO4lWmJFiS8=;
 b=MRFWR3FtP9SuBSqhNj10k5fSt0TEOz6E/w1u2qzWV8JA2P4HDBKBz1f2hwKafgjXARVwA6zT+vPWp4DcS86c8EH0IdQlzu+87Hxb8yQhuPTWv5cq75wRDuKsyr1fnak1BRkBI0PZsqpHVkPYjsegyS89l9uA4sxlzGLsTNPNBY2DerYOCkdwtvAmVs6t63YTZvPZKL3AEMF49Iy9byeuqS+URKDuartkPmVd/j5MM7TUfS7IaIEQkSJfOHj2xuXmkc1jupXyP4vVhmihl489Fc58wPW5H8ySvqCx6fQk4O8a2sSXUumgwUqpOl4Xn2h8RDXRthPwpt4g5b4Bh7n0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8znoN4gL8vmpI8G+JJglmgJjjs3lI2ZBO4lWmJFiS8=;
 b=C4hP/1k0mJUKKeM5xvww6xPcZF5LE076138uzo75Cjiz4hkpQTJEk0uoY0mlq5xtX+v4Z0hH7nC1qFw4NDOka7Kqntr3I64q4n5mqDphtSw3SxS/3NMknh8GQSurJ5TQE4Nq+igOSMPrbBha8tpTv3OHvxD50898LPIQTnYMSq0=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 06:16:42 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b0) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:46 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:41 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/29] drm/amd/display: Workaround to increase phantom pipe
 vactive in pipesplit
Date: Wed, 9 Nov 2022 14:13:02 +0800
Message-ID: <20221109061319.2870943-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 08661093-4a38-48c3-c39f-08dac219f7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZdnuA3pNymKJYx+1ka0Qb4ZAaKXxRHqXTJsuVRedosoPwh0sinxEIFhhlZ8FMY7bR/D41GiAb3QeBJLxV1s6bBO1Ep1QrgZpdUxvu1lEYn8k6zyV/HeHd/pWaHSvEs3rLdC5WTKjlcQx++o48abq9K+ju+L4y26kiv4LBfu4mlZav35k0FzkcyKt3qEIdQceVOcO4I5PU6MFdLl1qSR767zgT4CCtxHf1cOynRs5XGS3oCr+cMdP8kXj34XHkcyz4WoJ3BcP5y2dvYdA5iQ8WU1XCWtAv1+jxjbXHUflgUhiqEmzk4qLU/RnH9x+f27Km1mmWw3FKLr17RPqOULRug2HgwkmmrTBg2Rrb/vOQMyvrtiKG8bC1tInT13cVQB+YHK3Ob3Gf6v7xpXUUaTcQEk9l3nHeAIt0LuANgyKl/8WsEatIOxMEiepqqfusss0hrlS6LUCHoOmU01W/v9CP2fwSgvFsNlzWmyYcQ28ENW5G8Ggw99LyfQsZFwjaZ/7gWRPT19lk2n00X6qOpRQhIcnSossM1IkBUl9+PgpUWU8gyjnpbu0PsSty7MegqE56wiHYIPH+D9mbCbiDYojL8lwClsrNkFK2BiXA1jKxdNWYO1CfGqJ9erq4PjTl7L33nAHPu5vsaPnvZws/ipmfniUoUYx++UlqFfDuB1UuK720g3Zdwn72GSNgLDzySIy6jWYDEufxEfc0KxqxasiFukjBBy03R5yNkvnFsW0KCZQ+jYABXky86QIxWB5pAilapliLLPY+EeQt4Y+LznhS9Wy1Of5gxnSO8T7VsL2foCGLI1dvs9YL0OUpwp9dvm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(4326008)(426003)(5660300002)(8936002)(6916009)(8676002)(54906003)(70206006)(70586007)(316002)(6666004)(2906002)(81166007)(40480700001)(41300700001)(356005)(83380400001)(2616005)(7696005)(478600001)(336012)(86362001)(82740400003)(36860700001)(186003)(47076005)(26005)(82310400005)(40460700003)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:41.3719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08661093-4a38-48c3-c39f-08dac219f7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain high resolution displays exhibit DCC line corruption with SubVP
enabled. This is likely due to insufficient DCC meta data buffered
immediately after the mclk switch.

[How]
Add workaround to increase phantom pipe vactive height by
meta_row_height number of lines, thus increasing the amount of meta data
buffered immediately after mclk switch finishes.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index dadaac249836..0b1e721be33b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -531,9 +531,11 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 	unsigned int i, pipe_idx;
 	struct pipe_ctx *pipe;
 	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
+	unsigned int num_dpp;
 	unsigned int vlevel = context->bw_ctx.dml.vba.VoltageLevel;
 	unsigned int dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	unsigned int socclk = context->bw_ctx.dml.vba.SOCCLKPerState[vlevel];
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	dc_assert_fp_enabled();
 
@@ -569,6 +571,11 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 	phantom_vactive = get_subviewport_lines_needed_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx) +
 				pstate_width_fw_delay_lines + dc->caps.subvp_swath_height_margin_lines;
 
+	// W/A for DCC corruption with certain high resolution timings.
+	// Determing if pipesplit is used. If so, add meta_row_height to the phantom vactive.
+	num_dpp = vba->NoOfDPP[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]];
+	phantom_vactive += num_dpp > 1 ? vba->meta_row_height[vba->pipe_plane[pipe_idx]] : 0;
+
 	// For backporch of phantom pipe, use vstartup of the main pipe
 	phantom_bp = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
-- 
2.25.1

