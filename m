Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDEACDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB0E10E002;
	Thu, 19 Oct 2023 13:33:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1667510E4D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf+1ews+a+XDNSj+uEV6dQ4uXbXV/oNhPph8M75zRtICn91UQgLNqwiYogiCXMVDnJ47eA04M7xknk41J0xPaojImlwG1Y6xM36Ygkiiu/qVoxzmJ9hw8lMqptb+VULmDNTmWFP9JnnxMAS4oi2Pf0UkLzdsx1q6e/k2OHqPqLu2TErQGFX79Oa6egs8dhL+b2sZzK3La0t9WD4xEpb0jlL04pmTcRVg034BJ288PRsdg8BqUastxZLvqS7mGmnKEz0vxhySWNxyRtLQdAkGriIO9FHyX9JiYzsxzfKu0K3kCIOR4kf9pUrboj/w1lTlWWBRGESTGLzJDQezuD8BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3+moArg/GnShMngoS4gHkLFIbwEqxVDM9P+jmGnbhk=;
 b=XFyyvSnpGnR0a4P/DYLxXh/RudAnlTFhvpDk1cG6gMzaaTh2tJFU+NRc2QcmoQf/JPZdog5Fs+G8F9UggF1L8VkLrruA7PLtQlS3GB58LmQdxGqx7jOElab3BOYmxk34M3AUhVUWNQhAYav5kcB9Alg3BNcUOJPYrOh+eiF3hO0qd/gC1ey7moS0/ins69dCXTTW0pmBkcwAHe25u2jW52VNR9f4EalVy/RKZTVyyJyefde44zhdZfa3RsFu43KBEZbH8uOBAQut1PRDRvFigQfGWE/dCmYlO/QQzPkNP13/OOffuHt0dWPFHZ9PCFIs1PyDUI/nJ8RBrIkXYaj1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3+moArg/GnShMngoS4gHkLFIbwEqxVDM9P+jmGnbhk=;
 b=dctnjB4a/op5ZRIH7NY7xr8lnM2lpn4apjmOkrtzVrsSDYblBoSB+cCZXzUZb8xOfEjuPSCCv4AmdTJ0wdl8p0ecFSXzDhFk0yztU6hP7MsFFN/tkA0dTCGZ/jnmpV4UZo0Ab0z0Uj0l5SeQB443CKE/qoAiNF5zzfgwcaGkEgE=
Received: from BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) by PH7PR12MB7793.namprd12.prod.outlook.com
 (2603:10b6:510:270::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 19 Oct
 2023 13:33:02 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::15) by BL0PR1501CA0018.outlook.office365.com
 (2603:10b6:207:17::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/24] drm/amd/display: add pipe resource management
 callbacks to DML2
Date: Thu, 19 Oct 2023 09:32:06 -0400
Message-ID: <20231019133222.1633077-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: e37a373a-61a6-41f4-e086-08dbd0a7eab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIVrCtNBHdwmoRo3Lyra6EzfPBAjkqLM46hJJMjax8BHRe+p0bHjtR3YvccrWqo7uGT+WCAJUkuyKxIkMse89SlfYJq5hWu6VM8HZmSsmOepp7Wn+sucPNZ+uWFTU8o03IYpHBemHNaCN/QScdyHwaJZi1cMnojNqKrJdgsNyRskuKqa0m/lZkQcO7Xhd+ZYjMY6zSs8PbLuOwoYfITJMMpKtSkj5X9YeB9JSiawW4lWiz+tDetKdYrFpx8+ZmrmGmhZKH7zPcF8JsUDMyAUqDvdSWhVXOvvzgfr4iVMT/QUjjoN5VSY5cDZDt1dQ7jNtbxdL41ZmHDbdUJ50xXogYoQybAS9Xgaknd/ErpHCIvEcV2cySpN9XhkHJwVzjMGcJV4fjwGmzVx4jhD3+79Mvbv3rB5Eiy7XxfcSNdYfEvsy4LBiTu0C04sWmgid8jEKjYqL+EAKn23upkoPJfbMlyG0rYMHfSyQRAts1FLkclpnNkdduO+LeQvGMUvMDiynQuewbcoMPYsCzFBWvIn+kqCuPftJYB2uwZxJccaY/cPtBXOTRAjyQC9jsGHSVfg9xVoe0UDR7XPyuu2HdLCx0z324ryNXBNhDK3dfkQnkEScx9Em7XSgsitedAcfjT2HiDczUUaUimHXTHoZ+p8v1X/E7AUPuMG52MlM7kB5ChsWxJW9z+3zoouFXYJiDjJr8+mWLHePlZ/FtSL8ynEZiHLOG4n66Y3Tif5bPw/JcKWREfZ6J4plIxvKBxzf0bfsNmJT6A1pF9HW7r07CqP3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(70206006)(83380400001)(40480700001)(7696005)(70586007)(6916009)(356005)(336012)(41300700001)(86362001)(26005)(2616005)(5660300002)(1076003)(8936002)(36756003)(316002)(82740400003)(81166007)(54906003)(4326008)(2906002)(40460700003)(47076005)(426003)(8676002)(2876002)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:01.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37a373a-61a6-41f4-e086-08dbd0a7eab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Need DML2 to support new pipe resource management APIs.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c |  5 +++++
 .../drm/amd/display/dc/dcn321/dcn321_resource.c   |  5 +++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_resource.c |  5 +++++
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.h    | 15 +++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 81b0588fa80b..02d3168f1673 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2445,6 +2445,11 @@ static bool dcn32_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 
 	dc->dml2_options.svp_pstate.callbacks.dc = dc;
 	dc->dml2_options.svp_pstate.callbacks.add_plane_to_context = &dc_add_plane_to_context;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 44caf6711589..9f6186be7cd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1998,6 +1998,11 @@ static bool dcn321_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 
 	dc->dml2_options.svp_pstate.callbacks.dc = dc;
 	dc->dml2_options.svp_pstate.callbacks.add_plane_to_context = &dc_add_plane_to_context;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 4e03c9d663de..682bf93049b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -2082,6 +2082,11 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 	dc->dml2_options.max_segments_per_hubp = 24;
 
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index f3b85b0891d3..c3d5b84ee914 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -71,6 +71,21 @@ struct dml2_dc_callbacks {
 	bool (*build_scaling_params)(struct pipe_ctx *pipe_ctx);
 	bool (*can_support_mclk_switch_using_fw_based_vblank_stretch)(struct dc *dc, struct dc_state *context);
 	bool (*acquire_secondary_pipe_for_mpc_odm)(const struct dc *dc, struct dc_state *state, struct pipe_ctx *pri_pipe, struct pipe_ctx *sec_pipe, bool odm);
+	bool (*update_pipes_for_stream_with_slice_count)(
+			struct dc_state *new_ctx,
+			const struct dc_state *cur_ctx,
+			const struct resource_pool *pool,
+			const struct dc_stream_state *stream,
+			int new_slice_count);
+	bool (*update_pipes_for_plane_with_slice_count)(
+			struct dc_state *new_ctx,
+			const struct dc_state *cur_ctx,
+			const struct resource_pool *pool,
+			const struct dc_plane_state *plane,
+			int slice_count);
+	int (*get_odm_slice_index)(const struct pipe_ctx *opp_head);
+	int (*get_mpc_slice_index)(const struct pipe_ctx *dpp_pipe);
+	struct pipe_ctx *(*get_opp_head)(const struct pipe_ctx *pipe_ctx);
 };
 
 struct dml2_dc_svp_callbacks {
-- 
2.34.1

