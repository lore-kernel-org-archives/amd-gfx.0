Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA153CF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131110E757;
	Thu, 19 Sep 2024 18:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mwDhot/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCA610E756
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkc090icINqm1c894oNa3cq2+MUw5tSxy+11r3jMTdTZysupu1GUlYwlszp2LMiYIesQollkza8BhJhJ/va3XWvza86gYuzZhH2lPQSl/rzlTu6RpBlbcSnTGKoxi1riUvEyy2YZYJcM9JeBpqXjbxEvTv3maYn7S7HVU0v+zKkx0xXRoetcxVCivE6KDUCoa2TOdgitLfgfwIpLTPPQcr8lPFHpH+lhOq5hQmeqAo9m84SvRUQ1/lDR207pQyPOVfcCiSijm7bgASdR+tIjhHt8Cx25SWnZrkFgAb84iuEPor/at3J8pXQy51WV9tdAb9QxQg0cEcv7DlQ3txFnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYPrID7FGLhMQ3eWYocR6xN0zpR/LNKb5e8WEnFtrWk=;
 b=oFy/vpz48OfbyXbibnLfTVjnrfG6jdSiLX4hWR780MzDR5QiUvjtVpxj2bJzYaGOiNVOATMEEvvXeXt1PDzTxPJc7yND9JwFYxvgCAvQD3Je5I4mL2IMBp890yvmNteY3iziLgAZWHLHLGVVsQTKmJ0/2J1lrfvKt8VVHrHYWblUa4bZfkpLluuYB8TlJkPdz/kNuWL6NHItM+CDrwd72nsq8N4qw7JXPDZ3uSv6OLzOARk08sIX+2Hg9hu8hvVmsy7/R+GI9CmxrtEg3qXucIEVYdjk2uEQgLnJNNoS5fVS/rPQazWv7c7RVCV4GT/eJ84ZPhyDhkEfkAtQpfrk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYPrID7FGLhMQ3eWYocR6xN0zpR/LNKb5e8WEnFtrWk=;
 b=5mwDhot/HsZWTSi/pN+U3njsLnJroK+CKJ4s8P1iRrtFE1Dn/18CaWT5V0RyOUhQM4PfgmOGtUTjQmIWJ4ThXWPQ52SNGIkyKLHdW2zGs8/cV2S7oG4E92yeLXqwq4nYnkegEVVCXpJy+mdTbL777SvfuxxJvzr/F5aB41cEdWE=
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 18:34:48 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ed) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:47 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Kaitlyn Tse <Kaitlyn.Tse@amd.com>, "Harry
 Vanzylldejong" <harry.vanzylldejong@amd.com>
Subject: [PATCH 06/21] drm/amd/display: Implement new backlight_level_params
 structure
Date: Thu, 19 Sep 2024 14:33:24 -0400
Message-ID: <20240919183435.1896209-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0b78a0-a58f-4a86-e00d-08dcd8d9bdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M6MquHyr9y+TGdklji74aOb1YQ0SUUhAVuj9jTlYUeo5eJOptL8RT66E0fAh?=
 =?us-ascii?Q?xrqB/nBt+t5dtxDDUPYJnfoGGyKcPU8TWZRyuTJhWLVPzFcmJvWDfzlVOtyi?=
 =?us-ascii?Q?rFMCH7h0JX0Jb5PJnWLOTINtPRrQWoGadH7Gd+lF+YzS9JIUfa+hX4SqdhUk?=
 =?us-ascii?Q?4JqLDZ8khAfXiwUoGsk2gxa5lKNPc9jYx4e1ypbLTPq3+mi+LfBXjqW+YUey?=
 =?us-ascii?Q?rwvoNo2Cq4UmcHvHkRcVogAhRzh46skAb2z4uGeA/ecPoC5h3m8+0NCwrEmo?=
 =?us-ascii?Q?fDNsOemfiOOo1ogm+4ERWMsGknXjNppBASmzeXIgNf/g/POLf7qUSZNvTr6n?=
 =?us-ascii?Q?yXKS4bnSdmBl2fqfF45UgngFiC1kRt7jEyTMv+CDHQsjfyvTQJR64zEf9Zgv?=
 =?us-ascii?Q?UdjuxksrZzqnWeVT8Mv6U24YT+5/nyLFQ0ihNwnwsQlPeSJCz6si3/IZtdeg?=
 =?us-ascii?Q?rl/puI5DKMdyHV+QT5B5DC97f8vuId9YBVB3vBXZ9hCdZNymHVFCUqzhlMq9?=
 =?us-ascii?Q?M84QhVsu7MHUvPJjP0g/Ty6ZlAuugpYF3RyYtmBliDUHhkKJKfxS1oXypvda?=
 =?us-ascii?Q?UhMq0pLUSFNc2VAdu0Ft5Y8gQtmckKxSoy5EBHtgzya0ztE0pQKuQScyaip4?=
 =?us-ascii?Q?axjB5H1bRJ7aqlll7uRsDhD256inhJlLtHCZu50Vn1CNaz0I6tHNpfhWkpCu?=
 =?us-ascii?Q?FHI0OFhdppkfoFcsOB9toQPkJghZQIpvR9xdM6Ftx4sX/Z4jPf30ccJjaVqG?=
 =?us-ascii?Q?jkzQ/OBvkZ8kOjSMIhYBVC5Wlm3G7lXnprpAJTB5qF2If3ipbPu9QITF73RV?=
 =?us-ascii?Q?j98a+hcFpfKenheARnLArk5iuBl4k3IhOg1ZPbwVkJpIaXp19szrq2C8e0Yv?=
 =?us-ascii?Q?jZQNfoa2yDWBo5qJvmACLY8RSf8c4CmpWVI3YqrZGL/eCzr40Zhqo+BXO9+q?=
 =?us-ascii?Q?HYZbBNXut+sYXk6/Agn2bbi1P4I9Ye/lsGGkAK+qG7jmManuWngXEZKoSNGr?=
 =?us-ascii?Q?zI9X3aAMPt8f9uJajkpMmMrKdq/vxtI7coKi4OhClTMiFtW9EU3LMHcuf3yX?=
 =?us-ascii?Q?0vVpKqu+E0Af62M6LVfUojIHUsTbqpsNn59a8liD3aHNcPKZrVuMyno+siJ/?=
 =?us-ascii?Q?8eknHK0icRP6eM40fhftGTqpdnz7ouL5cbnQeuvl0DZfLeoRpOj4X+R8KelR?=
 =?us-ascii?Q?9ezSNxk/iQKWhKGfehJ7E2Com+umgRkmZA+FyitrhfAmODgoNGPZml+kJxTB?=
 =?us-ascii?Q?ip78ompFS0Ohp6zrp1sjz2OaZ+8F3c0WVxNFmQ2FNGE23O1WwEvbTgH7yUz3?=
 =?us-ascii?Q?omx3lFTbEHiis7XwK85AjXRJ0Nb9XTlX87H1FaY9gjdZUhzSAVDB89H7YB6m?=
 =?us-ascii?Q?z6EPFPz36L+C1JVJKlnVrcQqYbIS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:48.1302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0b78a0-a58f-4a86-e00d-08dcd8d9bdb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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

From: Kaitlyn Tse <Kaitlyn.Tse@amd.com>

[Why]
Adding the new backlight_level_params structure as part of the ABC
framework, the information in this structure is needed to be passed down
to the DMCUB to identify the backlight control type, to adjust the
backlight of the panel and to perform any required conversions from PWM
to nits or vice versa.

[How]
Added backlight_level_params struct and modified existing functions to
include the new structure.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Signed-off-by: Kaitlyn Tse <Kaitlyn.Tse@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  5 +++--
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h |  3 +--
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 11 +++++------
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |  3 +--
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h    |  8 ++++++--
 .../dc/link/protocols/link_edp_panel_control.c        |  7 +++++--
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4fbed0298adf..33d6233677b9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3142,9 +3142,10 @@ static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 }
 
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+	struct set_backlight_level_params *params)
 {
+	uint32_t backlight_pwm_u16_16 = params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = params->frame_ramp;
 	struct dc_link *link = pipe_ctx->stream->link;
 	struct dc  *dc = link->ctx->dc;
 	struct abm *abm = pipe_ctx->stream_res.abm;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index ed3cc3648e8e..06789ac3a224 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -88,8 +88,7 @@ void dce110_edp_wait_for_hpd_ready(
 		bool power_up);
 
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+	struct set_backlight_level_params *params);
 void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 void dce110_set_pipe(struct pipe_ctx *pipe_ctx);
 void dce110_disable_link_output(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 1ea95f8d4cbc..fe34d1a1e91a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -242,8 +242,7 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+	struct set_backlight_level_params *params)
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
@@ -257,7 +256,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
-		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
+		dce110_set_backlight_level(pipe_ctx, params);
 		return true;
 	}
 
@@ -276,10 +275,10 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	}
 
 	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
-		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
-			frame_ramp, 0, panel_cntl->inst);
+		abm->funcs->set_backlight_level_pwm(abm, params->backlight_pwm_u16_16,
+			params->frame_ramp, 0, panel_cntl->inst);
 	else
-		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, panel_cntl->inst);
+		dmub_abm_set_backlight(dc, params->backlight_pwm_u16_16, params->frame_ramp, panel_cntl->inst);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
index 9cee9bdb8de9..a7eaaa4596be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
@@ -50,8 +50,7 @@ void dcn21_PLAT_58856_wa(struct dc_state *context,
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx);
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+	struct set_backlight_level_params *params);
 bool dcn21_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index b8c47e4c51c1..b3134c85df39 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -174,6 +174,11 @@ union block_sequence_params {
 	struct fams2_global_control_lock_fast_params fams2_global_control_lock_fast_params;
 };
 
+struct set_backlight_level_params {
+	uint32_t backlight_pwm_u16_16;
+	uint32_t frame_ramp;
+};
+
 enum block_sequence_func {
 	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
 	OPTC_PIPE_CONTROL_LOCK,
@@ -365,8 +370,7 @@ struct hw_sequencer_funcs {
 	void (*clear_status_bits)(struct dc *dc, unsigned int mask);
 
 	bool (*set_backlight_level)(struct pipe_ctx *pipe_ctx,
-			uint32_t backlight_pwm_u16_16,
-			uint32_t frame_ramp);
+		struct set_backlight_level_params *params);
 
 	void (*set_abm_immediate_disable)(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 3aa05a2be6c0..e974a2fcc099 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -523,6 +523,10 @@ bool edp_set_backlight_level(const struct dc_link *link,
 		uint32_t frame_ramp)
 {
 	struct dc  *dc = link->ctx->dc;
+	struct set_backlight_level_params backlight_level_param = { 0 };
+
+	backlight_level_param.backlight_pwm_u16_16 = backlight_pwm_u16_16;
+	backlight_level_param.frame_ramp = frame_ramp;
 
 	DC_LOGGER_INIT(link->ctx->logger);
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
@@ -546,8 +550,7 @@ bool edp_set_backlight_level(const struct dc_link *link,
 
 		dc->hwss.set_backlight_level(
 				pipe_ctx,
-				backlight_pwm_u16_16,
-				frame_ramp);
+				&backlight_level_param);
 	}
 	return true;
 }
-- 
2.46.0

