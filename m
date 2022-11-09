Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F4AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0D510E575;
	Wed,  9 Nov 2022 06:15:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AE110E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVU73cSFqbVHm4I3Wb7cdE/RYOoyLcDwq9uDwN901cxjexU6nMXc180RjYMxKPpLZ9X/Idcfac75p5ZJtT4V0V/JxC7qZOG6X/IZT3IMa8eks3xxMY0nu1lDoCrrfetMTxSucWIWdbVy3FhBGkc7iN51JexXBPl2v1PkKYvSczd+MYmhAHlLMVfh7jn/ASRsIW7fwQYHTnL+hDQOKzScpwMcPmLSs3uh3m43cKTvoFSVBhbQJQxDGqsZFwI6NpOQerVjzWlw+5h8vrb2lapHC/q8C5KWGhAQJfrix3iNPR5T9led9bYpa/AgP5lOzGnxSeyhYzZ3slJF4EVlQBOsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KWkgpc6vskvr1Z7LfjjB0DocqdbHwdG5IgUpubwYaM=;
 b=ckJ9uCmCVS7JNUfEO9Neyzltyya6YO8HHjOTPjKyfBss//dLzHLMn3qYh6yIADOE2qVSBN6OAtdXejv34H8+XwofVosaYndMPz69XgsX/SOn6sRA55CHihTHEi3oYjvetWE2CmT5V7pHswvTpQ8+qntkTOKo87gZkMNOcXtsMpZug+3BcOqE/ozNJdJncc1bEp1iM0byzE8v4GOp9OlV6tIeeI5BSk1EIz03c/zLqcIveb4LrDj4AJrfsFGIc76qhhol9GGMxYsGWXOkvxLcmgMZ02nxiFq9hxzUFsZZIDlKRcOxpZcFpxclqnANM6ouIrnRxW3JVx9FzjdO1bZS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KWkgpc6vskvr1Z7LfjjB0DocqdbHwdG5IgUpubwYaM=;
 b=vK5vBKYu8VPtFUWXRIN273xTS0HcsWHWo+7gIG8bFhzFGsD3XejVAL+Tdi9ErphRjUkTT3v2iw+a+FT5II53KkOQBtDSSc/yqXQaelijLawMy59GmWPwYCP8Po5ChGyi63aBn9CeJCrTrMNdN2jIuXCfzLqFEpZC8ck8Xb/7sSM=
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:29 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::c8) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:17 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:11 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/29] drm/amd/display: Program pipes for ODM when removing
 planes
Date: Wed, 9 Nov 2022 14:12:57 +0800
Message-ID: <20221109061319.2870943-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 263c9207-84bf-4f65-fa3b-08dac219cc54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYPC/msWd7NXMzL7rJHPAlXz43InEdAQKk6WqnpPB/sKPIsls8T/Oyswj5gqr2qi9X0UxKiV9oTKgnm0c18lt6cAylvgW+ZS+Pvku9ej5i3kcfQWR7NkIt67gxGrW56cD0svX3mFdFQPyqsFSfwHasprvJbSRtBvqSBbuPc1hiJ6trqc+SoeYemWG7tbPaui5znIDrJ/NRCskYCUBxGUgytP4pkYXGfj9mcOvFw1BTB8wKp2PUh31MMJCG3uHce5bLIkTEDidQpgve2WCM5nvBwH1w6C5ukJJ1mAHlhAMD0doov2KX2TotRv2mh4+rR7iHJQbe1dJEY/RceOwiGPxLbiQBIIO+GWVm+Jx8Hg6FlI74WYUEXwUvduIxBDDPsIKEAwethBlVgfTbbzylCHEf0GOT+OtEnC41irlkv8kqNmy847E6mUcgWij8uo8HicZ3xxrJ+F0Y1TBohgCDj+lgAYV/Hdn6wNE6GaAZVy4lwcb68AGeI7I3q0tNxEQINbmjgK4tKdfvBhMGbDAfHGAGocb1gEF6caqziWdv93+iLFsoggvObZ9xIK5+H4OLT4cxLQVXFLFiYkjnVBguhUFB192toxPL1P9nRteLYCZtqEkRl4GKq60DTuqMSWGh7d3cVTsLmLnGfpJI/mqXkiDh4uvHhOWeufiY3RTUxYkyZyBNZVsWjO7iBtuwZXlzvVQ7/qt9y4s8ycNUxOMmKN6aVKYZpmo0YNTZREVGrXdrd2Vzzq+V5kiI3pmdzJ80xPA4PDdTCwD7nh3E7TN1p9t4/ZsHDocXXalKjYOQW3DyQsmi0Ts8TN6Zg2eJnU6JTs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(2906002)(86362001)(70586007)(186003)(47076005)(40460700003)(83380400001)(426003)(40480700001)(336012)(70206006)(8936002)(5660300002)(81166007)(356005)(36756003)(41300700001)(478600001)(6916009)(36860700001)(2616005)(1076003)(26005)(6666004)(7696005)(8676002)(4326008)(82740400003)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:28.3032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263c9207-84bf-4f65-fa3b-08dac219cc54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Software state expects pipes to be configured for ODM, but due to the transition
occurring on a plane disable, the ODM enablement code is not run.

[HOW?]
Update ODM when removing a plane, and dynamic ODM is active. Also acquire pipe
lock when removing a plane.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 11e4c4e46947..587b04b8712d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -97,10 +97,12 @@ void dcn10_lock_all_pipes(struct dc *dc,
 	bool lock)
 {
 	struct pipe_ctx *pipe_ctx;
+	struct pipe_ctx *old_pipe_ctx;
 	struct timing_generator *tg;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 		pipe_ctx = &context->res_ctx.pipe_ctx[i];
 		tg = pipe_ctx->stream_res.tg;
 
@@ -110,7 +112,7 @@ void dcn10_lock_all_pipes(struct dc *dc,
 		 */
 		if (pipe_ctx->top_pipe ||
 		    !pipe_ctx->stream ||
-		    !pipe_ctx->plane_state ||
+		    (!pipe_ctx->plane_state && !old_pipe_ctx->plane_state) ||
 		    !tg->funcs->is_tg_enabled(tg))
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b465a83bde6f..64fcb378594f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1834,6 +1834,17 @@ void dcn20_program_front_end_for_ctx(
 			context->stream_status[0].plane_count > 1) {
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
+
+		/* when dynamic ODM is active, pipes must be reconfigured when all planes are
+		 * disabled, as some transitions will leave software and hardware state
+		 * mismatched.
+		 */
+		if (dc->debug.enable_single_display_2to1_odm_policy &&
+			pipe->stream &&
+			pipe->update_flags.bits.disable &&
+			!pipe->prev_odm_pipe &&
+			hws->funcs.update_odm)
+			hws->funcs.update_odm(dc, context, pipe);
 	}
 }
 
-- 
2.25.1

