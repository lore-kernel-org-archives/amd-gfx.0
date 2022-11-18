Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6FCC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B5B10E794;
	Fri, 18 Nov 2022 17:01:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9569810E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOJymM2WMqe6rggT1eIjdgATnTnqYq89uTnn10tzubnYw1p1dNNttk7ZnoL3830Hedw6dx7mZ/6rrOwW5u8qPp8On+hGt8vWznzs6IVa0FnjDkxz/T5kkofYrCJ5cKO/xjU19JmVA7zLC2z6UXN7ZKJnyY1UjCL1scSU1IcpzyuA6XJi3fvnGM1qlHnmNmNCjZKkEOTf51cTO+0L8dfRq59e+eVOdAhb3V1bCM49bi5bERfag3hA9LIYk00osrRFNsVbMDFPiW8hC7Ll1sTWH/KN+ItvS/sKaDqOfoJz9MqTycuf2/tsPtIMo09hBHHorlHNjRxvmSfU+FoMTlkTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nch+upXnrPxwdXafZ2ch8WgEgT2YBmKQ0wqlSGssF38=;
 b=C5uSOvboXVEo0dqgwyc04Z1jc2HA7eFS04V0jLx5h1JiJvChkImZR1iF9l3i+Ub28/h6PJSV54G8wDyLQ3krLGmTmHeugG3MV4KMj7Widrape+2bcfUdPZAucffLV4uFKnn0MR2eVPRmJjF+4ujeU5abEq+hpjwwPyboXzdht1kouNGb5qaaORKKTcWvPP8yXyXXT9emcKWpeacVv8sUAt4S+SMtkxjk/cK0YIEFZxGba/1mK9UYwOtZl91J0W6lK+QulilgV8L/SGygKm5wXpn94Be/w8j97EZbjbk2ruTi5C1XJqK5eF3YZxAnDIFXNWAwh84KOVFOQ06Na7XEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nch+upXnrPxwdXafZ2ch8WgEgT2YBmKQ0wqlSGssF38=;
 b=HoqI18VsKPV1ya+KQt/qZ0ur+t5QCGpnaHxdZkh0zCmm20G41cR/qwdegkRoVORs6vKXKGHhDHNmtpv97hWPmNrJp9VKu3ZZ5z7lMnTAwGtdR7kVLPDkJZEyS2eB16EapAs2wYnkVdY1eA4IpispmYmQx3zFbkovOnVs3eNzEo0=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 17:01:11 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ef) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.18 via Frontend Transport; Fri, 18 Nov 2022 17:01:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:09 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:05
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Retain phantom plane/stream if
 validation fails
Date: Fri, 18 Nov 2022 20:59:29 +0800
Message-ID: <20221118125935.4013669-17-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b38990-bb42-4943-9318-08dac9867ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnAxMljtg/9LsXMravgjOJxYgy8XhL7zmPbaRvHTPnO6npXGr0L10TNo2VhqB0uQff16hYjs3uHKzPv/AMntXjpsY6eJl3yf3GQSI7ySUgN5+fO5KBb7XIAtqRRpp8dU1mRWMCjiuo61LRkT4BKbypNSHB2eWTKSxTriBZ/9lYWsf2Htcs4xDGEibevEZwn712JnF6uQsg04PSZ6m2XdMDxirw/35XfJNVncaazPd+FX31b+n07PKyN9PFg8Wm5NGdA2mmt3xl7tzarNr4aE5HYoSr9zbwa99eIgFW2XI3pM7Z813S/gWiDz03DvYIliHle0ak6Bmm4Diji2sLTN0kDi+w5Hjw1z5eWgV0TxADSeY2CD8IuGEqHYN9uwpzDrlATeUHQC1Vzv3PVoTZIKB9KT3ablZqknNYFUWZ6nkM6tdt0bTRI53nwoKkcc4Tlz1vGWvuI2ENoVtaNrAlKfe1yBloEhGdqCdkYIrzglwnsQLguDC72wkQJrNNoeoACmyeimQpASYTKKQjoADCuT8oHYkJL8aRYYoEQ6ovX8h8UoShFkaCf19ry8NvqpvMSnUIrVS9cO+Adz55f4n3oKQEldmZ2fBwLmTXs9mcFz7Sf9RdNGB00Qs66vdvlQm686Y2f/Y/QveB6WLoY+HNLZVerH6Xhfg8pHIcA/CNvDWNECfKORBqoYXJWw/eODxt6IO7oBk726YxGgNKLb2Pu1Ggi0eAxgCL9Vu45SBtH3HaTxL39wG1zA55TU+h4I4yEeSBieNVZ56ZlTlpyW7dVopQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(6666004)(26005)(70206006)(4326008)(8936002)(36756003)(8676002)(70586007)(2616005)(5660300002)(1076003)(186003)(336012)(7696005)(6916009)(40460700003)(316002)(54906003)(83380400001)(2906002)(86362001)(82740400003)(40480700001)(426003)(47076005)(36860700001)(82310400005)(41300700001)(81166007)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:11.5929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b38990-bb42-4943-9318-08dac9867ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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
- If we fail validation, we should retain the phantom
  stream/planes
- Full updates assume that phantom pipes will be fully
  removed, but if validation fails we keep the phantom
  pipes
- Therefore we have to retain the plane/stream if validation
  fails (since the refcount is decremented before validation,
  and the expectation is that it's fully freed when the  old
  dc_state is released)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 +++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 5 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 42840ce9bf4b..4aec13f0d5ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3098,6 +3098,19 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	if (update_type == UPDATE_TYPE_FULL) {
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			/* For phantom pipes we remove and create a new set of phantom pipes
+			 * for each full update (because we don't know if we'll need phantom
+			 * pipes until after the first round of validation). However, if validation
+			 * fails we need to keep the existing phantom pipes (because we don't update
+			 * the dc->current_state).
+			 *
+			 * The phantom stream/plane refcount is decremented for validation because
+			 * we assume it'll be removed (the free comes when the dc_state is freed),
+			 * but if validation fails we have to increment back the refcount so it's
+			 * consistent.
+			 */
+			if (dc->res_pool->funcs->retain_phantom_pipes)
+				dc->res_pool->funcs->retain_phantom_pipes(dc, dc->current_state);
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index c40dccef6843..827eef7e1787 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1721,6 +1721,27 @@ static struct dc_stream_state *dcn32_enable_phantom_stream(struct dc *dc,
 	return phantom_stream;
 }
 
+void dcn32_retain_phantom_pipes(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct dc_plane_state *phantom_plane = NULL;
+	struct dc_stream_state *phantom_stream = NULL;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe &&
+				pipe->plane_state && pipe->stream &&
+				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			phantom_plane = pipe->plane_state;
+			phantom_stream = pipe->stream;
+
+			dc_plane_state_retain(phantom_plane);
+			dc_stream_retain(phantom_stream);
+		}
+	}
+}
+
 // return true if removed piped from ctx, false otherwise
 bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 {
@@ -2033,6 +2054,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index f6bc9bd5da31..c50bb34b515f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -83,6 +83,9 @@ bool dcn32_release_post_bldn_3dlut(
 bool dcn32_remove_phantom_pipes(struct dc *dc,
 		struct dc_state *context);
 
+void dcn32_retain_phantom_pipes(struct dc *dc,
+		struct dc_state *context);
+
 void dcn32_add_phantom_pipes(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 06f144189e9d..b66fe62cbd99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1621,6 +1621,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 85495ef026f5..aac1b3989c95 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -241,6 +241,7 @@ struct resource_funcs {
             unsigned int index);
 
 	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
+	void (*retain_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 };
 
-- 
2.25.1

