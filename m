Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B18C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17DE10E703;
	Wed, 21 Aug 2024 22:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ycfE7q62";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDAA10E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr1DgzWt83CdyhWWpbavGSWee9Sf8gAAne84ju0uafHf0Gf6cAHfSpOITBhM/8feyAJaGk6f756G1VLgkpmJHn9DhGeELsVKbySUI8eOocBL3s8hKCs9mx/NQqw8xCqksEzmLIytvOMq7RPaXBafllCFbI7Rbq3ZOs+/g0e87MqXvBeDBzvfSBqukreIfpkcyDxmAP96d22HFCsSSQ/W5gU7aro/DUK8pBfMIC2q9z11I1Et/N+fzWd1rP+FhdxKxBhVl91Pde0ACxFwZkOj9ISQIvzxH9xpHgveQFwiFyqSGEXMgkCvvGpaExvZKC5uZOZHkbJbdBRsTpoOraLsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3mcADqB8LXkFc4uWP0wSKBrZG367Ifp9pOBhdMxS4M=;
 b=ybQaPcibT2jCJsXTgDYDAuK8S9LIG6bshTHcof8rIqsfOIkQ3W2+m+I3B1nlApeYtZQE+Swg/3937uU5fMBh68mUlfRs/+M2g4+cY/omCBHHQPHWHFGXZceGFZZPhU3TbasGcusAM/se4gdAytNMZ1trpEglZjDqO66zIv6EyP0+c6J3h/CFgufpEBbytzyq8SG7KWd8jr+Boj2CtznK2gYoMAA6CzdoWVqrj5gMTmNy83xeVnZjThu7Bx3BQ7c4zegPmw+v9eHttwLTTc/IaRAhBeBGHL0czi2Vf2RllI7SfVW15dCPI1ksOn2C9AWwIJpLxmCrealuXnr+hocUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3mcADqB8LXkFc4uWP0wSKBrZG367Ifp9pOBhdMxS4M=;
 b=ycfE7q62ALcBm6kqLVksWnPLkJK4I5OOYihi7LultbPyjV+jsQweXTouufX1CRmCOlziLWyh0jxDTlM2mQ0ga2Hvbu08S870cfdamK3PKC9VSQ0JtJlG2PPWRxRyVTckpyOzFLSoudWSbxlONMhD26HlPuTRyR1o7nwTXs5TVJ4=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:35 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::fb) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:35 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:33 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, 
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Wait for all pending cleared before
 full update
Date: Wed, 21 Aug 2024 18:01:45 -0400
Message-ID: <20240821220156.1498549-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 51db4fb5-7981-47f2-aa43-08dcc22d3e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1U1UklQ5anQ3QXaaMDrTsl8sahFIQFoxL+2/pTWK5WKedWac8D3njbURyO+?=
 =?us-ascii?Q?QEkd0kSfdCbtgO8Im0rvbOde+5kAfZ4FnWoH/b4bEme38Q9kCDnSCKBj94Ui?=
 =?us-ascii?Q?rKtw0u0GgYov4EG6mUBcShGeGN9co8PRcSqS9FJy86kRSKh2oEEvjL1itAD3?=
 =?us-ascii?Q?y6lulYHlNPaquiL6wosUtvdqfEb8JVt8t3RPeOIMQc2kyqPKWfEzKpF/NkhR?=
 =?us-ascii?Q?oVp7L3mN2GNRH61edAhzIkzLw9/z2qbrkG5Z8Yn+vK/VydXZEf6TJSLb8Bw8?=
 =?us-ascii?Q?i/COeA5sVmppeqk7JlHconZU1FVaGRtLV9NbjZZ8xBAU4ctTCIpKkECA6tYb?=
 =?us-ascii?Q?WUWI/+CNJKJ6ZjsQdhOuxlNlnlvWjEEDqD82xnJ3IjxE4+nuvPx55wwkv9/5?=
 =?us-ascii?Q?XTuHidApFGP9ZbM0L2E7XQj9ljYU8rEaKb1t/BfipF9Q73q3Ar+Wn3rYe5lC?=
 =?us-ascii?Q?vf7ny0FlZYZX177xC5BnOTKsg8UX838IdshKaEt/nQmZ4R8jD6CoiIgpWfBL?=
 =?us-ascii?Q?/XyvBrIdVcmDmlYnKKGSvmRY6J4NQckPDfwaUm6p7KrJvR+JAdPgyjvd6qPW?=
 =?us-ascii?Q?f3bRNAwAZ1/iTXeO80UGSsY/egLmdO5pGsX+yAs691ENclVjXJ1822kVdrgU?=
 =?us-ascii?Q?RVwslAQPUp1XyOFX1TGv3WmvfdbrPE77B66uNBzNbnT2FoTBM7mqPPJ5Dnt0?=
 =?us-ascii?Q?8fwKunOY7UWfq3o/P6/T8bBG8pq0eI79v9e7m77e2Vg6raCA2soCu1A5hqvM?=
 =?us-ascii?Q?ZDl9nftAenL67oYTtW+j8A4BuGuDaSc2bvCJeKMD797YNpJLzHKzHGThU/hi?=
 =?us-ascii?Q?uiFC82FmQpwQy5V7Gdw8zyim7AaSDkesqmjUfYFrIZZe97uu+2FIEW8EmfiQ?=
 =?us-ascii?Q?TgkzibNpci75Wf7ogmnLAchWObFNyx7dPO7NBK3t418vV9I0mTbm5HidDwBP?=
 =?us-ascii?Q?k890Y34DeIVvLqcg+s/3rYyTSfISF3ltEzq1zzXIQzrC/5RcEVSTGZn00aC8?=
 =?us-ascii?Q?788YIhAk4UcPmkes4QioCOy9ilmoGK8QVtm8Z/xisZTOZV2jH05SCom0lmjJ?=
 =?us-ascii?Q?0dbUxIz+ETP0sAhSvaAo+dwX4IVQ+hZmBMxDrea6Tbx7KvmT0OfiPVak6nZ8?=
 =?us-ascii?Q?IbmMmYmal7hi+NFApJ0ETgumJYk+8r5bndOfFeFgHwtM6W/HeEDG8Rlyt3bR?=
 =?us-ascii?Q?pb5HsdM4rdWM8/DLSEFWTLQi1VdRXCUVeSIKGbIab0SsfLGpqZVT1GOr4tnn?=
 =?us-ascii?Q?hX9CpLSbrxVrBJmughVw8GJquj8iGzEtv4N8NkU8A6rghNKtbZTbPBlH9owS?=
 =?us-ascii?Q?6P6djxTujsw5KnHCdJC090vbJqsM58lDG2mT0KGm3r+oa/O28sfvDWnDgrQ4?=
 =?us-ascii?Q?AblAwDqJIDTUxhTDreFh+MPVPcEB9UluDELoY0eP/ZuIfLoCh9685y8Lti0F?=
 =?us-ascii?Q?joEHfGdrkKZlImnCZuwAgdUV9eAjbJwo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:35.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51db4fb5-7981-47f2-aa43-08dcc22d3e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Before every full update we must wait for all pending updates to be
cleared - this is particularly important for minimal transitions
because if we don't wait for pending cleared, it will be as if
there was no minimal transition at all. In OTG we must read 3 different
status registers for pending cleared, one specifically for OTG updates,
one specifically for OPTC updates, and the last for surface related
updates.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  9 +++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 27 +++++++++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  9 ++++
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |  7 ++-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    | 45 +++++++++++++++++++
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    | 13 +++++-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |  3 ++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  9 +++-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  9 +++-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 16 ++-----
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  7 ++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |  6 ++-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  6 ++-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  5 ++-
 24 files changed, 161 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7ee2be8f82c4..2cb9253c9bde 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1071,8 +1071,13 @@ void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_con
 		if (!pipe_ctx->stream)
 			continue;
 
-		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
-			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
+		/* For full update we must wait for all double buffer updates, not just DRR updates. This
+		 * is particularly important for minimal transitions. Only check for OTG_MASTER pipes,
+		 * as non-OTG Master pipes share the same OTG as
+		 */
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && dc->hwss.wait_for_all_pending_updates) {
+			dc->hwss.wait_for_all_pending_updates(pipe_ctx);
+		}
 
 		hubp = pipe_ctx->plane_res.hubp;
 		if (!hubp)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a80c08582932..b383ed8cb4d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2255,9 +2255,9 @@ void dcn20_post_unlock_program_front_end(
 			struct timing_generator *tg = pipe->stream_res.tg;
 
 
-			if (tg->funcs->get_double_buffer_pending) {
+			if (tg->funcs->get_optc_double_buffer_pending) {
 				for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_US / polling_interval_us
-				&& tg->funcs->get_double_buffer_pending(tg); j++)
+				&& tg->funcs->get_optc_double_buffer_pending(tg); j++)
 					udelay(polling_interval_us);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 42c52284a868..d5458dae6d30 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1185,3 +1185,30 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 	if (!dc->clk_mgr->clks.fw_based_mclk_switching)
 		dc_dmub_srv_p_state_delegate(dc, false, context);
 }
+
+void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx)
+{
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	bool pending_updates = false;
+	unsigned int i;
+
+	if (tg && tg->funcs->is_tg_enabled(tg)) {
+		// Poll for 100ms maximum
+		for (i = 0; i < 100000; i++) {
+			pending_updates = false;
+			if (tg->funcs->get_optc_double_buffer_pending)
+				pending_updates |= tg->funcs->get_optc_double_buffer_pending(tg);
+
+			if (tg->funcs->get_otg_double_buffer_pending)
+				pending_updates |= tg->funcs->get_otg_double_buffer_pending(tg);
+
+			if (tg->funcs->get_pipe_update_pending)
+				pending_updates |= tg->funcs->get_pipe_update_pending(tg);
+
+			if (!pending_updates)
+				break;
+
+			udelay(1);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 6a153e7ce910..4b90b781c4f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -96,4 +96,6 @@ void dcn30_set_hubp_blank(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
+void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 2a8dc40d2847..0e8d32e3dbae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -108,7 +108,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
-	.is_abm_supported = dcn21_is_abm_supported
+	.is_abm_supported = dcn21_is_abm_supported,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 93e49d87a67c..780ce4c064aa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -107,6 +107,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 3422b564ae98..8e0946fd5b7f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -121,6 +121,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.program_outstanding_updates = dcn32_program_outstanding_updates,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index a2ca07235c83..73a632b5ff89 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index ac9205625623..b8c47e4c51c1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -462,6 +462,7 @@ struct hw_sequencer_funcs {
 	void (*program_outstanding_updates)(struct dc *dc,
 			struct dc_state *context);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
+	void (*wait_for_all_pending_updates)(const struct pipe_ctx *pipe_ctx);
 };
 
 void color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 3d4c8bd42b49..4e08e80eafe8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -342,7 +342,9 @@ struct timing_generator_funcs {
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
-	bool (*get_double_buffer_pending)(struct timing_generator *tg);
+	bool (*get_optc_double_buffer_pending)(struct timing_generator *tg);
+	bool (*get_otg_double_buffer_pending)(struct timing_generator *tg);
+	bool (*get_pipe_update_pending)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index b7a57f98553d..40757f20d73f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -202,6 +202,7 @@ struct dcn_optc_registers {
 	uint32_t OPTC_CLOCK_CONTROL;
 	uint32_t OPTC_WIDTH_CONTROL2;
 	uint32_t OTG_PSTATE_REGISTER;
+	uint32_t OTG_PIPE_UPDATE_STATUS;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -566,6 +567,12 @@ struct dcn_optc_registers {
 	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;\
 	type OPTC_DOUBLE_BUFFER_PENDING;\
 
+#define TG_REG_FIELD_LIST_DCN2_0(type) \
+	type OTG_FLIP_PENDING;\
+	type OTG_DC_REG_UPDATE_PENDING;\
+	type OTG_CURSOR_UPDATE_PENDING;\
+	type OTG_VUPDATE_KEEPOUT_STATUS;\
+
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
 
@@ -600,6 +607,7 @@ struct dcn_optc_registers {
 
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
+	TG_REG_FIELD_LIST_DCN2_0(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
 	TG_REG_FIELD_LIST_DCN401(uint8_t)
@@ -607,6 +615,7 @@ struct dcn_optc_shift {
 
 struct dcn_optc_mask {
 	TG_REG_FIELD_LIST(uint32_t)
+	TG_REG_FIELD_LIST_DCN2_0(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
 	TG_REG_FIELD_LIST_DCN401(uint32_t)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
index 364034b19028..928e110b95fb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
@@ -43,7 +43,8 @@
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SR(DWB_SOURCE_SELECT),\
 	SRI(OTG_MANUAL_FLOW_CONTROL, OTG, inst), \
-	SRI(OTG_DRR_CONTROL, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst),\
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 #define TG_COMMON_MASK_SH_LIST_DCN2_0(mask_sh)\
 	TG_COMMON_MASK_SH_LIST_DCN(mask_sh),\
@@ -53,6 +54,10 @@
 	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
 	SF(OTG0_OTG_GLOBAL_CONTROL2, DIG_UPDATE_LOCATION, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
 	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index abcd03d78668..4c95c0958612 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -271,6 +271,48 @@ void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 	optc1->opp_count = opp_cnt;
 }
 
+/* OTG status register that indicates OPTC update is pending */
+bool optc3_get_optc_double_buffer_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t update_pending = 0;
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_DOUBLE_BUFFER_PENDING,
+			&update_pending);
+
+	return (update_pending == 1);
+}
+
+/* OTG status register that indicates OTG update is pending */
+bool optc3_get_otg_update_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t update_pending = 0;
+
+	REG_GET(OTG_DOUBLE_BUFFER_CONTROL,
+			OTG_UPDATE_PENDING,
+			&update_pending);
+
+	return (update_pending == 1);
+}
+
+/* OTG status register that indicates surface update is pending */
+bool optc3_get_pipe_update_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t flip_pending = 0;
+	uint32_t dc_update_pending = 0;
+
+	REG_GET_2(OTG_PIPE_UPDATE_STATUS,
+			OTG_FLIP_PENDING,
+			&flip_pending,
+			OTG_DC_REG_UPDATE_PENDING,
+			&dc_update_pending);
+
+	return (flip_pending == 1 || dc_update_pending == 1);
+}
+
 /**
  * optc3_set_timing_double_buffer() - DRR double buffering control
  *
@@ -375,6 +417,9 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.wait_drr_doublebuffer_pending_clear = optc3_wait_drr_doublebuffer_pending_clear,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn30_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index bda974d432ea..e2303f9eaf13 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -109,7 +109,8 @@
 	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
-	SR(DWB_SOURCE_SELECT)
+	SR(DWB_SOURCE_SELECT),\
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 #define DCN30_VTOTAL_REGS_SF(mask_sh)
 
@@ -209,6 +210,7 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
@@ -319,7 +321,11 @@
 	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh)
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 
 void dcn30_timing_generator_init(struct optc *optc1);
 
@@ -356,4 +362,7 @@ void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc);
 void optc3_tg_init(struct timing_generator *optc);
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
+bool optc3_get_optc_double_buffer_pending(struct timing_generator *optc);
+bool optc3_get_otg_update_pending(struct timing_generator *optc);
+bool optc3_get_pipe_update_pending(struct timing_generator *optc);
 #endif /* __DC_OPTC_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
index 1a22ae89fb55..d7a45ef2d01b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
@@ -169,6 +169,9 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.wait_drr_doublebuffer_pending_clear = optc3_wait_drr_doublebuffer_pending_clear,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn301_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 30b81a448ce2..fbbe86d00c2e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -99,7 +99,8 @@
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SRI(OTG_CRC_CNTL2, OTG, inst),\
 	SR(DWB_SOURCE_SELECT),\
-	SRI(OTG_DRR_CONTROL, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst),\
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -254,7 +255,11 @@
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 99c098e76116..0ff72b97b465 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -98,7 +98,8 @@
 	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
-	SRI(OTG_DRR_CONTROL, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst),\
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_14(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -248,7 +249,11 @@
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 
 void dcn314_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 00094f0e8470..c217f653b3c8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -297,18 +297,6 @@ static void optc32_set_drr(
 	optc32_setup_manual_trigger(optc);
 }
 
-bool optc32_get_double_buffer_pending(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t update_pending = 0;
-
-	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
-			OPTC_DOUBLE_BUFFER_PENDING,
-			&update_pending);
-
-	return (update_pending == 1);
-}
-
 static struct timing_generator_funcs dcn32_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -373,7 +361,9 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_double_buffer_pending = optc32_get_double_buffer_pending,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 665d7c52f67c..0b0964a9da74 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -177,7 +177,11 @@
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
@@ -185,6 +189,5 @@ void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combi
 void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg);
-bool optc32_get_double_buffer_pending(struct timing_generator *optc);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index d077e2392379..be749ab41dce 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -67,7 +67,11 @@
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_END_READBACK, mask_sh),\
 	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh),\
 	SF(OTG0_OTG_V_COUNT_STOP_CONTROL, OTG_V_COUNT_STOP, mask_sh),\
-	SF(OTG0_OTG_V_COUNT_STOP_CONTROL2, OTG_V_COUNT_STOP_TIMER, mask_sh)
+	SF(OTG0_OTG_V_COUNT_STOP_CONTROL2, OTG_V_COUNT_STOP_TIMER, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
 
 void dcn35_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index a5d6a7dca554..db670fc17264 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -493,7 +493,9 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_double_buffer_pending = optc32_get_double_buffer_pending,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index bb13a645802d..1be89571986f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -159,7 +159,11 @@
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, mask_sh),\
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_EXTEND, mask_sh),\
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_UNBLANK, mask_sh),\
-	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh)
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
 
 void dcn401_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 7901792afb7b..86c6e5e8c42e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1054,7 +1054,8 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SRI_ARR(OPTC_BYTES_PER_PIXEL, ODM, inst),                                \
       SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
       SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-      SRI_ARR(OTG_DRR_CONTROL, OTG, inst)
+      SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
+	  SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 /* HUBP */
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 514d1ce20df9..bdafa7496cea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -536,8 +536,9 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
 	SRI_ARR(OPTC_WIDTH_CONTROL2, ODM, inst),                                 \
 	SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),										 \
-	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst)
+	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
+	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst),                                 \
+	SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
 
 /* HUBBUB */
 #define HUBBUB_REG_LIST_DCN4_01_RI(id)                                       \
-- 
2.34.1

