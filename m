Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB31EB8FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FFA810E647;
	Wed,  6 Sep 2023 12:52:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65F510E647
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjy4DwrxzBLMJgE2nNk4fChb+r0YnB76yoe9xsd3AzsAHaFN6BWj18eb7cx41k8KeU5am254KVR4F1t+zbMpV9HcM7DDvb2gBw696Rk/HMqErJyJqqBkY1OUcRXZsbUgfnGOUGWt7Fx7N5kdMgUetLvtH72EhOtiilrBmcfDhN7SpFY4eEuW9Nm9a7fKw+O6X8LbRlHQ7z25jzPhiTtK3pItLs0BXN6nio7xgRp4+tsd3qbfPY4MPeJsTUWefq8RHA5IXxroK+mmSTfkNPVrZOGAVwoP77CBhlg66hQlWx+BlvWF93d+T6i4D+z5xoKBvAjh5fh2CUWT8ntuxHMaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CoFV5Wz9eB6TLMk6NBvmm0IaOOZiqOPdMN6Hjdbzxc=;
 b=c1PdroiNXlfylJ4g4HMywARkiWZEkwd54BacGpwAxZDpV+q18qEnvfpD283LAbmcqBgd9VES8m114buK7R5pEtJBQ7gsQxReNSOiPmV85DEhLWvibhVg8wd48tVJ//uEF0huAb5xQIBKtiG9uzL5UgEPgUhfxCIvhO/1MRJHwR1oeqasm1BW0/Nov00fnrSL4esekZm4geT/g449gRDss005/vYPMwSjbFvCrpLhuEQMrpd9rvj7rMkXceKaSV8I6+zLXVyN+RIgoEf6nR2XA7D5cmm8AgK6DvoiEj6aTAkFe/yCz7WW32bh9uK+ig8ghA53/EK+toZDpN7OyD1Gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CoFV5Wz9eB6TLMk6NBvmm0IaOOZiqOPdMN6Hjdbzxc=;
 b=nG98dSdsYxj1Uv+BF/lsCAmwK+4KSojoNn2zY/2HsYSEGChm2DFGqEQ2xZXLtbdD1S5TrKu2nbkejzky7ZUboEA57feABIKQ3GHTx3no2qW+xm2NFHzpFA01BHSWUrQ/8qy9ryavKqyCCEic1x9U0M2yR3+RCPRh0paRIsBceN8=
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:52:09 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::18) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 12:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:52:08 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:52:03 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/28] drm/amd/display: add seamless pipe topology transition
 check
Date: Wed, 6 Sep 2023 20:28:31 +0800
Message-ID: <20230906124915.586250-27-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fead6dc-71a8-49f2-6a65-08dbaed8149e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5fTjNYXaiSK4cUOfqA885Z8U4j2MSzTz/B5R8taBKhGggkE2fnOWYfifB018NpfN51OHwnqQLm+f2ypwMaNd3rHsC2DgEQBFCS/mLWlaHF1QbeyeT7nefrxDgUIM51KjW33EsvbtS+VdbN3c3m3nf332LhFuhXx4E3dA07OmVYpbR+7GTKQGMw+PL7uCzM9w41Oj174z+rSvezihySe8Msvb0qonrzLAlbsopbAb+d9i5HCHFhQIAj5AkKlm0wAirKaVhPZM2X+z9epjXvlLqYKuR/adlI+iz5c5URJoXnmxxmDYVxYsZQBqO0cy3v4aoX/CvISfLAC/Z6Q4UfySyQp4JuxK6HTVJ/jiKuy+zXAk+fqLkOgqIcAKvjM5JKVHXlyMSWzSuWi24KAkq2n1ZRGJOWTHznPZ1FEOy8D82BJU6rxkPZnZjgVQyHVyjdAWbYDRPMARNubZDHjXnwQYsgcaO7ow/agzxsBmV01f5aDxOb91QrPMaTp8jpOg8AbsdH71betjbVMuPBWV/PjabEK6m9BriI2ci7emc7zkrTa3zO7aZtrCxBjSBr/Jkdt+OjYXgfeUKQfKNUuSnZ+xEmmST1/u9Skv59JH6jUDiLkyBDGoaKLai7fYi5UlHiZjy9uXiP2MJaWh6bZAb9MS+5v1B2fdFEsUHRIz8xYh5hO9EeZ6VGsl0Ea2EjsQHMj3+xglIF1uMFhT9ZsL9Wu2r789XYJ7x5l41ZZKAIDaslbMHMIubCLkjnoTeR8JhFA/ew9eNKIJ2PN+rHqKmSNJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(4326008)(1076003)(5660300002)(8936002)(8676002)(36756003)(44832011)(7696005)(2906002)(36860700001)(41300700001)(6666004)(26005)(2616005)(16526019)(81166007)(82740400003)(316002)(6916009)(356005)(70206006)(54906003)(70586007)(47076005)(86362001)(83380400001)(40460700003)(478600001)(336012)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:52:08.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fead6dc-71a8-49f2-6a65-08dbaed8149e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We have a few cases where we need to perform update topology update
in dc update interface. However some of the updates are not seamless
This could cause user noticible glitches. To enforce seamless transition
we are adding a checking condition and error logging so the corruption
as result of non seamless transition can be easily spotted.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 52 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 ++
 5 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a857de5ebe85..f91d0f6b0d7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4370,6 +4370,14 @@ bool dc_update_planes_and_stream(struct dc *dc,
 				update_type,
 				context);
 	} else {
+		if (!stream_update &&
+				dc->hwss.is_pipe_topology_transition_seamless &&
+				!dc->hwss.is_pipe_topology_transition_seamless(
+						dc, dc->current_state, context)) {
+
+			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
+			BREAK_TO_DEBUGGER();
+		}
 		commit_planes_for_stream(
 				dc,
 				srf_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index cae5e1e68c86..018376146d97 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1619,3 +1619,55 @@ void dcn32_blank_phantom(struct dc *dc,
 	if (tg->funcs->is_tg_enabled(tg))
 		hws->funcs.wait_for_blank_complete(opp);
 }
+
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx)
+{
+	int i;
+	const struct pipe_ctx *cur_pipe, *new_pipe;
+	bool is_seamless = true;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		cur_pipe = &cur_ctx->res_ctx.pipe_ctx[i];
+		new_pipe = &new_ctx->res_ctx.pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, FREE_PIPE) ||
+				resource_is_pipe_type(new_pipe, FREE_PIPE))
+			/* adding or removing free pipes is always seamless */
+			continue;
+		else if (resource_is_pipe_type(cur_pipe, OTG_MASTER)) {
+			if (resource_is_pipe_type(new_pipe, OTG_MASTER))
+				if (cur_pipe->stream->stream_id == new_pipe->stream->stream_id)
+				/* OTG master with the same stream is seamless */
+					continue;
+		} else if (resource_is_pipe_type(cur_pipe, OPP_HEAD)) {
+			if (resource_is_pipe_type(new_pipe, OPP_HEAD)) {
+				if (cur_pipe->stream_res.tg == new_pipe->stream_res.tg)
+					/*
+					 * OPP heads sharing the same timing
+					 * generator is seamless
+					 */
+					continue;
+			}
+		} else if (resource_is_pipe_type(cur_pipe, DPP_PIPE)) {
+			if (resource_is_pipe_type(new_pipe, DPP_PIPE)) {
+				if (cur_pipe->stream_res.opp == new_pipe->stream_res.opp)
+					/*
+					 * DPP pipes sharing the same OPP head is
+					 * seamless
+					 */
+					continue;
+			}
+		}
+
+		/*
+		 * This pipe's transition doesn't fall under any seamless
+		 * conditions
+		 */
+		is_seamless = false;
+		break;
+	}
+
+	return is_seamless;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 616d5219119e..9992e40acd21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -120,4 +120,8 @@ void dcn32_blank_phantom(struct dc *dc,
 		int width,
 		int height);
 
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index eb4227926006..1edadff39a5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -116,6 +116,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 	.blank_phantom = dcn32_blank_phantom,
+	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 1ccdb7359894..e0dd56182841 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -410,6 +410,9 @@ struct hw_sequencer_funcs {
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
 	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
+	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
+			const struct dc_state *cur_ctx,
+			const struct dc_state *new_ctx);
 
 	void (*calc_blocks_to_gate)(struct dc *dc, struct dc_state *context,
 		struct pg_block_update *update_state);
-- 
2.42.0

