Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF96C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4270210E6A8;
	Wed, 10 Jan 2024 21:56:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0182110E6A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEPqF19jO6Iv0Kg43bdlbv6JjjAQk/hZgDu3xo65GAcAEsiGFkdtifD+1rCJtLajTBM1xd4yBvuDCKNSnYcWhJpmJGMZVgZRW/0DsochVQhCizCXDYckEJOAu2/QxndMAYuyqJqo/50C5p+EsU+ZsX+rwGXtSlcTtrW2Zhu+sUSxgBVK8sW3GJPQAXs7fmCFan2ra5vRpeKUtxaHjGVCwuQl4uewZdvoel0I3otThznoFkRwF7Dw1+MGZj2aW8kiKVJE0XwGs65QOgDGTriiXyL1RedH9A3ofU3spxgJmeU2ni0in6N8ldu3/BBGiOwotPGkjWk5jiOiqClIBYe8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMz8Aw72JbjgTshh5v/DL8QRk/p6fdU7STZR1kKTigo=;
 b=e+q6sAqzW/rBFpYyrH3oLrvW5BLMUg2j3vbqu3lvvlezejOeiOyCZHQ5XLy/R1sxA/8FM/Exa1ibWfMnUJg7f+BviBjE5uyARE09rj3yhNVKue70G/c8SQmIrq88zSCgteMCKiX1/TIj6Y1kvXeWkRR0B+OmrDbO9ZoLdv7Rr9Ux+AU3aad9y8vFM7tvE0AzyGpheuxHvT7+KpLsOYvD5aQZ6cRqN0Js5kUwafL8OmKRxeK4GC6JowU8KJFWUwPXhjCXsS8fbqh7ZqbQt7pr4Nqh4jFwaFcGWZOwla/149bet3wG80vfrEZIboylvlLjkTDo3BCs6R+JmduFQB/eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMz8Aw72JbjgTshh5v/DL8QRk/p6fdU7STZR1kKTigo=;
 b=E43kepyLGvgUcNxIjZhamjcq30RbWTzGsLmVaKjNhIHP2gK859KKWiUbl6+6wdqeP5k2R+2OkC1b64vkFpveOW5EyPHocWJfMPCJrT7R//tdNW/vW7QvdOSA2X4LssOmNJh5iP8Sy8kUEuj+KupLm/3FyrU1YngpsFh79VM8gcs=
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:56:53 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e4) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:56:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:56:50 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Fix dml2 assigned pipe search
Date: Wed, 10 Jan 2024 14:52:55 -0700
Message-ID: <20240110215302.2116049-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f290e0e-e8f4-4c36-ae2d-08dc12270e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lekAujmjkFpiZpQehWD7Lp7UrQ4MAHKWO1Vsy6H9fUcFORJHu4MsbFtDpaxLtx3g74QEIQgmPrxa2Y357kqN7l7kjTbEYNmfWueSPOcQDm8WjhfR9tXec5WYcOLc1fIjEMs15xyHl6hLW5zNnGwUE9xg0Qil8BvqSNQMkE5vzXYNt0TuY82jh7dBlnMgnYW5dXhrMLR+UvGdBJze10GwbO+GD6S+32T4Wa+I0NNWto3fODC5VqnTucmqdblCrFtMNACaYNjSz7T/+gmnEOTFaitGexL6HqHrAJT0W83pj1gtxJUADdhG2UZPEKjRbgeOsi9yOgr4wGJbWkOUnW8j9xXaE/VDLt8Tzd9hzveBapgCjiQSXhEO5iB+e2rflrtGJuBvzxgm3hS5GS6i1OPi50SVIWXCspNaraM8K0UGNZBp4wg15nAn0ZMx6oW3b1NVuiPwbmTC7oNfCfPvuQm9zEzDUBh7L0OOSkGgNYM0HG/3J5IKihv+BijKKOVWHSbt9tWDzlKgDzg8h5/fpDKL8358vMSMFWkon9dGncOpwzmPo//ZEoaKCz7mRETPpx8+8cacOX0KlNK7IMaCmNeN2W1hwCZj/tgFXkEryCEiOyq7TCiHaqfEA0+bNfbkmXnMzwuWn7BJdehyhRQL197Eh15krTCoC5UgTaI42Yx58CMgeMzpSl3VBkMnbKQrTVQC7UkPBLkaA5NdsxH5lppds2grnWb6dVc9lvRRacWLT5uNIAp6c9/4f8X9VFgd+aDCZQXjk+6uvDuFQrd97uQgzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(82740400003)(40460700003)(40480700001)(6916009)(70586007)(36860700001)(70206006)(7696005)(81166007)(356005)(478600001)(54906003)(316002)(47076005)(8676002)(2906002)(8936002)(5660300002)(4326008)(1076003)(26005)(2616005)(36756003)(336012)(44832011)(41300700001)(16526019)(86362001)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:56:53.0455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f290e0e-e8f4-4c36-ae2d-08dc12270e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & How]
DML2 currently finds assigned pipes in array order rather than the
existing linked list order. This results in rearranging pipe order
on flip and more importantly otg inst and pipe idx mismatch.

This change preserves the order of existing pipes and guarantees
the head pipe will have matching otg inst and pipe idx.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 36 ++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 0baf39d64a2d..a0ce681b26c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -141,14 +141,28 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 {
 	int i;
 	unsigned int num_found = 0;
-	unsigned int plane_id_assigned_to_pipe;
+	unsigned int plane_id_assigned_to_pipe = -1;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(ctx, state, state->res_ctx.pipe_ctx[i].plane_state,
-			state->res_ctx.pipe_ctx[i].stream->stream_id,
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id_assigned_to_pipe)) {
-			if (plane_id_assigned_to_pipe == plane_id)
-				pipes[num_found++] = i;
+		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		get_plane_id(ctx, state, pipe->plane_state, pipe->stream->stream_id,
+					ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[pipe->pipe_idx],
+					&plane_id_assigned_to_pipe);
+		if (pipe->plane_state && plane_id_assigned_to_pipe == plane_id && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			while (pipe) {
+				struct pipe_ctx *mpo_pipe = pipe;
+
+				while (mpo_pipe) {
+					pipes[num_found++] = mpo_pipe->pipe_idx;
+					mpo_pipe = mpo_pipe->bottom_pipe;
+				}
+				pipe = pipe->next_odm_pipe;
+			}
+			break;
 		}
 	}
 
@@ -566,8 +580,14 @@ static unsigned int find_pipes_assigned_to_stream(struct dml2_context *ctx, stru
 	unsigned int num_found = 0;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].stream && state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id) {
-			pipes[num_found++] = i;
+		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->stream_id == stream_id && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			while (pipe) {
+				pipes[num_found++] = pipe->pipe_idx;
+				pipe = pipe->next_odm_pipe;
+			}
+			break;
 		}
 	}
 
-- 
2.34.1

