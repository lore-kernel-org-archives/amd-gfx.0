Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C0CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEB110E4E4;
	Thu, 19 Oct 2023 13:32:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6638E10E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxQP4Z5x4gv7BD+V57hU35Br8nJFZbPGL/hFiWxKZh7ag1i5PT/P6HnH6LTlClKxYfp8ugha2QdsCzX3U6AADxKhilE5yQOhBAhu0tXCo8PitIZHmm3pDTaHTEjm5LUo7qzTSxUMrP52MD/XVeWRBrfppXLOK7L++si4uMefsmzFHgNoqfAZOgMPkWXbw+YtfOyYyWcE9NQ5Svg9s5HQASRJPHLpO4sB9cpsw8GU3NGzui4LITsJK8uKO5t+wpQmJXn+z6XIyp7Aar+jhwqFaTw108EKiyUAS6idvy/o8RS5F9J7GG9PTE/axogMDsfUt8c7ssiDEIdfFLdTemf+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvZk7IEcr8+UYEa5FyZooydwEqP9UQjn9bF/eFn2RCY=;
 b=abLzNwf0TpsoTO74zU/485PmNrSnopD9pjSFBEbdW+G9+1qBb6l5piW3Tb+UkAvnrCkzbbdyr9BoDk75rEvS9lgm3NdfrEUUA6NNSKYdnk8ZQKhfLyzkv24W4XYz2CI8eVg9KYMESTm6oLY3P2akndpDPLvTQQbJmjKfPu6ebL7Ikspf6J8Le7YXNJcP0E0H00un+g81otzgFP1szq2Sd8Adg01+K/XVpqTqs3Ydie4ZK0koRteB/eMwA0JfKwjGi6n5NR0m9oalBy7OGH4qwSm56LvLqTSvWVEhSkuHbjktstQ5sFIbZWJ4UwC4y99P7/JgXeH/qoEpZkUQYxW5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvZk7IEcr8+UYEa5FyZooydwEqP9UQjn9bF/eFn2RCY=;
 b=1y/ey/MhTJBDe1/p6Uo9uBfpEKacQIaQHwrBVpRvsMi7Ul2NgZQUTR1XdydTxakPCFE22omrPsjt1Zj4c8TDiF30DPD8MPUl4HW9RYyc/x2mVOONnZHdf4hNb0W1bGCG1RiNxOa8o0OXboq0B2NArMhhgIlxh+OD0wpykACLGE4=
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:32:32 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::2e) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:31 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:30 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/24] drm/amd/display: reprogram det size while seamless
 boot
Date: Thu, 19 Oct 2023 09:31:59 -0400
Message-ID: <20231019133222.1633077-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: a50e894f-bbfa-4007-14a1-08dbd0a7d8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2qLMVGrOXc/X3P46LxQhS95j8VS/k4Vyz/wB6V1Ut0CsTDtx7ahqrqYA9i7fn886ZTyh2+98INcsXNA/pjBBfjQBZX5PkIDSm4nHOfzEGbVe/+eISfNIMrCQQbXdSpSNPquHP9cLpQ14065TlrEAKnE79ru4ENm1m+vPc5LQGAEu0PYMeaMdnCdlZpOotscjX+GOKHLADKqAVzRpwurhNnMg4Csf4+R+xiWjqIpec8GGR79tXZclrVEpuLsOwn2+V0z6u8wvCU12rBu3DLo9+1ErJUVsAMQpmBZ3OuJAoj54TcKpTqVGZm0rBQME86YYPCSkvsDIf0egnUygknjYTx4ArPURKqvirPGBMbVlGqePiZf4XJoYcpycD0ujh5ZnxzSBw4oTNWF2kgPUVPpkdpzSH6fa+O5RdCbjhv3JoYojoU1h+uxArshbRjeG4pLfeLMsCAA65o7kLTa1kX0ZUcinsGuiRx5bJ4ljqeTRzpXAmQLZx1N3VontW5ubxPMZ66kZF9yjgLgGyzkGL+McCj245SYSnmiLhwdlQtyRZdHHv7f2RbBuzQ1Avag9bXiMlq9eOhRN0EEjEpRYlzCFE1VVfL7pjc8q8ld26Db+JEp1QqEY2zDSQp7Be1Ba742ad1qBXiN7sxW1OOCNyI/LuIR9tYy+j5Dg6mrA0Jgp4GH3yvf93UH8GiGHGvRV4WWKt82SYj3DPsT6XzJq+soC8qPq8hnj7LCOmSkRpyn04RXYZ38lNinuiGMHtVpCvNeLvCiXsKBu4Uelp4LxWZkIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(6666004)(478600001)(7696005)(2616005)(54906003)(336012)(41300700001)(26005)(83380400001)(426003)(1076003)(2876002)(316002)(2906002)(47076005)(5660300002)(4326008)(70206006)(70586007)(8936002)(8676002)(6916009)(82740400003)(36756003)(36860700001)(86362001)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:32.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a50e894f-bbfa-4007-14a1-08dbd0a7d8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Hugo Hu <hugo.hu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
During system boot in second screen only mode on a seamless boot system,
there is a chance that the pipe's det size might not be reset.

[How]
Reset the det size while resetting the pipe during seamless boot.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 23 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  9 ++++++++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index f6b59c29cee2..5b5b5e0775fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -109,6 +109,28 @@ static void dcn31_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigne
 			+ hubbub2->det3_size + hubbub2->compbuf_size_segments <= hubbub2->crb_size_segs);
 }
 
+static void dcn31_wait_for_det_apply(struct hubbub *hubbub, int hubp_inst)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	switch (hubp_inst) {
+	case 0:
+		REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1000, 30);
+		break;
+	case 1:
+		REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2->det1_size, 1000, 30);
+		break;
+	case 2:
+		REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2->det2_size, 1000, 30);
+		break;
+	case 3:
+		REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2->det3_size, 1000, 30);
+		break;
+	default:
+		break;
+	}
+}
+
 static void dcn31_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -1041,6 +1063,7 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.verify_allow_pstate_change_high = hubbub31_verify_allow_pstate_change_high,
 	.program_det_size = dcn31_program_det_size,
+	.wait_for_det_apply = dcn31_wait_for_det_apply,
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index c339f756b8e7..5daedd893923 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -585,6 +585,15 @@ void dcn31_reset_hw_ctx_wrap(
 				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
 			struct clock_source *old_clk = pipe_ctx_old->clock_source;
 
+			/* Reset pipe which is seamless boot stream. */
+			if (!pipe_ctx_old->plane_state) {
+				dc->res_pool->hubbub->funcs->program_det_size(
+					dc->res_pool->hubbub, pipe_ctx_old->plane_res.hubp->inst, 0);
+				/* Wait det size changed. */
+				dc->res_pool->hubbub->funcs->wait_for_det_apply(
+					dc->res_pool->hubbub, pipe_ctx_old->plane_res.hubp->inst);
+			}
+
 			dcn31_reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
 			if (hws->funcs.enable_stream_gating)
 				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index cea05843990c..901891316dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -188,6 +188,7 @@ struct hubbub_funcs {
 	 * compressed or detiled buffers.
 	 */
 	void (*program_det_size)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_in_kbyte);
+	void (*wait_for_det_apply)(struct hubbub *hubbub, int hubp_inst);
 	void (*program_compbuf_size)(struct hubbub *hubbub, unsigned compbuf_size_kb, bool safe_to_increase);
 	void (*init_crb)(struct hubbub *hubbub);
 	void (*force_usr_retraining_allow)(struct hubbub *hubbub, bool allow);
-- 
2.34.1

