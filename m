Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBADECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6FC10EB57;
	Sat, 27 Aug 2022 02:50:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE32710EB54
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgroUe0lg7U6w0HvvZa5mzokwf3qTNKMlVZupreeaOzIUQoWVxePCQgc8lJbH/Eu7QeebqRaLDzQ2S3V/k32D8l2NOY6cwZdY4L2ZKDXulIvMdqOTbX3tyCWjU+UMACV6s8xZKOw3npnhy/nb5rVL5X2yRZ6U/AueB7p+gvgJt6HMeskeNA7lpckF5RL9Go9umtirDjUhReSrDw4I44EBVmbiJJ3hWJCZ7bxFrJZ9JMIiFE3+Kd4GeqWDhUbWfzMvyJrPwfm4TSJm+dMxrwE1xi/fs+y0xelp/Ws1doS6RWOSUG7+cpBQiMNY+RoOSB9BQBAKV4//3Wd9rwSVhs06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmzlAaPebDib6Os5vr9N5H7i9F+wcwiDynD8q5zoCA8=;
 b=kLl9Y53OT8UdspDosLCxZI1A6PDb9M1o/4zm8HH1nNOQqNjTbSPZpvlcQ0HbE2LAZg52AUEaF8CkwEs94UVTRd4A/dYKklriSfpXJVmWAn2i7C+fQACjaVLXVBXe1KItjbfJWk1jDCA5m+yIRjk5VXmTIea6pxgCzEknMxZFbKiL9CjwfOYTbx36JNH68ucAWKIO3wB7haNJePZ7XpmR6SuPVNOJ+jaTa2vfwTWS9jBLFoqqQF7aNWofN8Eo7jrcH/Tc/W8IEMydqiTQ8fX0eThEKltn+bGFaIkQy9tKwHZ/2wzyXvVWUFhPZ2mA9SYGvkj9N+42YK2SeF83yVAtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmzlAaPebDib6Os5vr9N5H7i9F+wcwiDynD8q5zoCA8=;
 b=fV7VjMHGs2j6ztat36UHsOQCsdoxPgLHBAJZNfY5b8vg9yOZWUvJp3R7wHWZrgzR08sW+56NbPVhtmqZjx9c/nj1sQvf5cbbZJa3SU1wRtuDsh/3i+iMMi2RUnAHao0aBbwj+CSGm+gGsAAgiq06qwXrwKqTZyay+DY9f5e0vmg=
Received: from DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) by
 MW2PR12MB2428.namprd12.prod.outlook.com (2603:10b6:907:6::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Sat, 27 Aug 2022 02:50:20 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::8d) by DS7P222CA0021.outlook.office365.com
 (2603:10b6:8:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:50:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:16 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:12
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Don't choose SubVP display if
 ActiveMargin > 0
Date: Sat, 27 Aug 2022 06:50:22 +0800
Message-ID: <20220826225053.1435588-3-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6bda88-9a64-444f-fc53-08da87d6e1cc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2428:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVk4FHeUza9FKvFmmjhOZOhM96kuJH7GOrelj7zkL9Lf7c3PLnPBHN1cALaibZbHBLFx2JtIytYTXzCnunw+5VyN08fXo9LI7JX+W2LEd0jGjbxi43ejWKbzNhv/nuhoUxoF7GHRjJ5Rc7HH+7hwebyJoxy7ySuRjKAwb54Xtu18MZpXwWFdqBiZA9Mgq4TGfP34eQfejIbT0IGiIov9Gh2KBQ9iuw6dhLGbCmPQZ92vpmFUC31cPwtWW5Q8BBwUMfnU2/GsZGTsdGtXbhC/ofGhhGgJ6zXee6AxjMKgkIOaeiOe6/FZwqphvWwuatmMgsA29WwpYiVFcrhVlsl1ivm58HITPKGoHXVKXSLUTBnuX/JQF3hxhxmfBu855FgJV/3a4qvsMFTVJgwjqebWjwPG5E0uZ9xk2MjFX+kbTb86lSgKUdLziMNiT/S6ORgv2IoHGOiceGDsMSOZzesOT5Oo7OtqOQ1ZKhz6r8yVPIoX1gHoaGs9Qw0Q5RBqpMierAMa9iIOq6Nx7xHcBXhtbMNwiqSk/RmZz+7/8DpiH9FpiBlUuktYcAJiZ5A42Aid0UM0xurpH9W8XW0cBcsJr6Ucs2ST39M02yl/xE4GKLcNaxvQqf1ywVPXbLbYvhsj6yJIR8BNRpJSz6itak8sX+gFQDk6EtjCFe3eY3QlFYjOW1s4gg3hR2jP1N5jz2xohAWBgVTCAT7DGdxbPxoLFe6bC9uQAvLrf8xZzthqGKLlEoVChPovjc7rkZrKYo4SW2u3I14rQUVTJzOv7K83uCas9VX0zJtohEYsvIHXoDN1kV6Q2r9ARhmdnTRU7N61zSYHJfLmiIehbrrsLgMVnX/WNqeW5wCk6Xx78SHMXc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(40470700004)(6666004)(41300700001)(2906002)(26005)(40480700001)(316002)(36756003)(7696005)(478600001)(2616005)(82310400005)(86362001)(54906003)(81166007)(336012)(36860700001)(1076003)(356005)(70206006)(5660300002)(70586007)(40460700003)(426003)(83380400001)(4326008)(8676002)(6916009)(82740400003)(47076005)(8936002)(186003)(43062005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:20.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6bda88-9a64-444f-fc53-08da87d6e1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2428
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
There can be SubVP scheduling issues if a SubVP
display is chosen has ActiveDramClockChangeLatency > 0.
Block this case for now, and enable Vactive case
(later) to handle this.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 21 ++++++++++++++++---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index edefb3fc1c3c..e72213a20e75 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -560,6 +560,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 	bool valid_assignment_found = false;
 	unsigned int free_pipes = dcn32_get_num_free_pipes(dc, context);
 	bool current_assignment_freesync = false;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -573,8 +574,15 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
 				pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
 				/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+		/* SubVP pipe candidate requirements:
+		 * - Refresh rate < 120hz
+		 * - Not able to switch in vactive naturally (switching in active means the
+		 *   DET provides enough buffer to hide the P-State switch latency -- trying
+		 *   to combine this with SubVP can cause issues with the scheduling).
+		 */
 		if (pipe->plane_state && !pipe->top_pipe &&
-				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120) {
+				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 &&
+				vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
 			while (pipe) {
 				num_pipes++;
 				pipe = pipe->bottom_pipe;
@@ -998,8 +1006,10 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 
 	*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 	/* This may adjust vlevel and maxMpcComb */
-	if (*vlevel < context->bw_ctx.dml.soc.num_states)
+	if (*vlevel < context->bw_ctx.dml.soc.num_states) {
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+		vba->VoltageLevel = *vlevel;
+	}
 
 	/* Conditions for setting up phantom pipes for SubVP:
 	 * 1. Not force disable SubVP
@@ -1085,13 +1095,16 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 
 			*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 			/* This may adjust vlevel and maxMpcComb */
-			if (*vlevel < context->bw_ctx.dml.soc.num_states)
+			if (*vlevel < context->bw_ctx.dml.soc.num_states) {
 				*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+				vba->VoltageLevel = *vlevel;
+			}
 		} else {
 			// only call dcn20_validate_apply_pipe_split_flags if we found a supported config
 			memset(split, 0, MAX_PIPES * sizeof(int));
 			memset(merge, 0, MAX_PIPES * sizeof(bool));
 			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+			vba->VoltageLevel = *vlevel;
 
 			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
 			DC_FP_START();
@@ -1421,6 +1434,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 			memset(split, 0, sizeof(split));
 			memset(merge, 0, sizeof(merge));
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+			// dcn20_validate_apply_pipe_split_flags can modify voltage level outside of DML
+			vba->VoltageLevel = vlevel;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f831855db022..3040428a7304 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3617,7 +3617,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						&mode_lib->vba.FCLKChangeSupport[i][j],
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[1], // double *MinActiveFCLKChangeLatencySupported
 						&mode_lib->vba.USRRetrainingSupport[i][j],
-						mode_lib->vba.ActiveDRAMClockChangeLatencyMargin);
+						mode_lib->vba.ActiveDRAMClockChangeLatencyMarginPerState[i][j]);
 			}
 		}
 	} // End of Prefetch Check
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 492aec634b68..da8acf59ccac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -312,6 +312,7 @@ struct vba_vars_st {
 	unsigned int ActiveDPPs;
 	unsigned int LBLatencyHidingSourceLinesY;
 	unsigned int LBLatencyHidingSourceLinesC;
+	double ActiveDRAMClockChangeLatencyMarginPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];// DML doesn't save active margin per state
 	double ActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX];
 	double CachedActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX]; // Cache in dml_get_voltage_level for debug purposes only
 	double MinActiveDRAMClockChangeMargin;
-- 
2.25.1

