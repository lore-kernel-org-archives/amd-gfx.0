Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45560CDB485
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFED10E414;
	Wed, 18 Oct 2023 17:42:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C390810E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVYJxDZ4QlhFisuxweDn6G2dY+TwDxwfdCcfzfgp1piEMn8OMg0d0lS0pFO8tI0HHEpYRZFoLzrQnB58HE+Qvn9nKw/jQMBUWfx8wawMJjIKpAKhijnnn6Yn2mQk6r70NbFRSWR+1L/4ErX2RCk/dicfEHVJI/NCcMatF3Ejxm/EzibehBZB/u9GvRJ6yUVOcXAqwR1FMhu8jfgPxfvbdOxzP2BN1Dan8ltnMUwWy8YWuJQPDu268bfRyeAq3o5j2N3GFoAVpzw33FFshLC7l3gIfdcZQ2dp7txPIrehNa0ViSYUcrO4wqEwQUn6wA9guhhoo8lHQeXipAleNTytRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvZk7IEcr8+UYEa5FyZooydwEqP9UQjn9bF/eFn2RCY=;
 b=CJ3ZMZKGuf7Nzxf93H3OO5TsnEn2xm2U2vmgbHzX7j1m4OtFNnTHcH53H6q8NPPbOc3CTzVmyXXB6s2h5mu7orIrdalcSLvGp7VrcrhwKOHtfEWRG0qUS1QOUiVuXvwUky4yAlDCTfwa/WdnGfFn8ZD+abxOK4dx5SYWbCy73Idv1UdX0A+CBXCWeL/HPtmSa5dTKcE+9NCxeD39HbqsK2HRQCtDS+GuQNj/pYy8Yy5bLFx5n370NQPjSLgVJLVW6DzPapVWEPDmEJ6H1ab6oPV9pkTlrqbmJZeLCBa8BKhbQqT00wjKfEoHGk7UDU8bGEEwSvcCJiQwVWYEo8qtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvZk7IEcr8+UYEa5FyZooydwEqP9UQjn9bF/eFn2RCY=;
 b=qk8kPhb0jslb6MTwxp+xfHBfphvfE7F3yrszCW0Ghe9IlPlqwOJXmk7KaaX4FX/IcAekmu/2x4TNMBeIho/rXRpYlOr9lVKU8pdeUatBm0Bx1SstSBENHQA09C3Dny181BSYTrciHJQIyAk7vZSj6lkJXHeQpRdv6iADNtWnZVw=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 17:41:56 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::13) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:41:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/26] drm/amd/display: reprogram det size while seamless boot
Date: Wed, 18 Oct 2023 13:41:09 -0400
Message-ID: <20231018174133.1613439-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ea2ff9-a2f8-4e3c-432e-08dbd00185cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9j1Lc8u2YVqcgq+ihId1ApozG8ycd9/2B9yfJ/wf6cymVOh5HJkek+ujrtmLWOcSO6S8AceYGURyXmiNfsFH5sbgQ8H4/N+e9d6YNaggEGZ/lkzOlRH7iWrjE1eI6Z+t9CEYTwRPOH5J8IhgVjgkTRDa5d1zCxxZiqKrjRn8pzVUIr68EWg7NO4FdYHnQqG9WRibARux0xnc8YwNRoDR0sC953W3rApCaSyTzWpLpdvhYtpzHb/EosVmuDJJ6CQfIngCYswoRdyqQipyigjDzsuTg0B0xKXpWtbH17qho7eOjSegIF0aeNGhVPXk+e0/RpS7TlQ/GJAWIlAoxfGdknuCEwTMIdkf0/Ou/4rqqU5c9+S5Yh0KNbrg9uWI3N5C62yFYHvK8tpENVD1pML/OpgbR2koiPunxyITVIXKv1YKfK7/oB6bDxun5EeLKqNwW/ads6AhpTFX4T4kTY49VTBM0MZlcHMn738mAY3gPgKzkLUjlm+FkRoefyE5/Vlsejiqd947mjpJp3gikD34e9SJgTNELyiX1cESzSKrriFTeL65VMRNiJyo3R4qO7u5fG0LzjGoKiRE7z3dQpBd0e/yG6gEpkCdabWb+T90qbisufLKGmdZTMHtK6fL/yPUdtSYtqEQDZWzbvc9KZByabYJvXhqdWir6CNV42RsE/xYX0SMhbphSp3+j/LZ5YiMc698a5B7Pekj2cAS1k8A64XvL57Cr7pQ7dfMzjzg8VVln51XgF8seJLXXkenxPpW6gE4FRhaC32lAyGBmhHKaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(26005)(336012)(83380400001)(2616005)(426003)(6916009)(316002)(478600001)(47076005)(8936002)(1076003)(4326008)(36860700001)(41300700001)(2876002)(2906002)(8676002)(7696005)(356005)(6666004)(81166007)(5660300002)(70206006)(70586007)(54906003)(82740400003)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:41:55.9886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ea2ff9-a2f8-4e3c-432e-08dbd00185cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
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

