Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7BEC02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5F310E638;
	Tue, 21 Jan 2025 19:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVeQNpAM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F54410E638
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMAQKy0pRAVMsh2QyvwAsQuKi5yQd4TIWv15lvvJmjHNxLzrLXqGgsK36tY24n+hDMZn8MufcKWB9S8PIQwrBtbR+RH9iQgpaCxc3qHd89p6WFpu2EhBrg6W2x3+lInE8C7/QnllNt6LbgaYJ3u2cZJSQIw+NhQbspZE2Kw6PosipN5P1NPAEHwS88NhpJhNsiYnGx5QrqBaov/K4UUBTQ+upyCY5Yjrojt+ZzTKILPg3LvOkMs2OJyzTzVgcZhrdRuyyID4Jydo9XkwvhpHXuaMAoJ66m/ItOAANkzzT7UwT8k/EG2XudDN25Xe9tjDnv1P7q3YIDDPOZPsy12rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv/y1+F5YHmnbeumalC/fiP6Rgvc0fCyDbl+RYbmiGA=;
 b=soI/JlvqMDwZry4SOFKo2GSeDboXgGEuNyPAt6RvEo/f0j4P+6xCgE5RjJN31HWCdS6tMQjryX+7hvgrwBOMyarq6quDykx5+1Ce4OayhkCcl6vgaBGc7nsZt78Q0tHngFPDD2n1pAiCfBaCU6XUOgv9cmWD9o38W/GXm83PrO6RuohqSDz+z99CJ/U1PPWnHV3qoqCvlIKK9dwPtkjn20Hh2U31knMHQvUIop8va3RcJIsfvaHkRjBVuIOYzNP+bwpMY4yvmZXv2+TrBQeRuQ+i7hw+uBd1LZ5mlObygM/gO6DiXhKHTNZo9DvqxdsoyPMgzmESeRvOfrjtpNlzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv/y1+F5YHmnbeumalC/fiP6Rgvc0fCyDbl+RYbmiGA=;
 b=nVeQNpAMftjSvzpdPh7OSJOCWpJZdIk5+StbLfqEvgzDXcP+DkoYR+kBQDZf8wyzM0FdJC4Caq2zxA3fh6DR5LtYuvu4HfQlZMqhHFZSECkLPufZyWUhe99DYRixVKBwUFD5A7y8VGG6OxC6BevNiuj466cvm2wy6sKRu+lj4vo=
Received: from BL6PEPF00016416.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:4) by CH3PR12MB8546.namprd12.prod.outlook.com
 (2603:10b6:610:15f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Tue, 21 Jan
 2025 19:40:19 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF00016416.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:19 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:14 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Peichen
 Huang" <PeiChen.Huang@amd.com>, Jun Lei <jun.lei@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 12/14] drm/amd/display: refactor dio link encoder assigning
Date: Tue, 21 Jan 2025 14:39:17 -0500
Message-ID: <20250121193919.3342348-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aadebb6-0dca-4b79-b523-08dd3a536ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0KDBItQIr352vYcEn1U7kdjmAVyWfucMbdx5Y8GBrAPHe9NwbtIvDYT6WjsV?=
 =?us-ascii?Q?Ce1qvHg9a1raIT+WoGrcMc6dJnp3T7AcM0Ay5dFtwL66pyIIer+nkGAGgTun?=
 =?us-ascii?Q?kN8v/ryQ523APd7fYdp3kKnuRekF+rJEsOSHnOTPg+cx/QpAVPSUwcH+8+m5?=
 =?us-ascii?Q?Y0k9ib6VWG+bXyoUYfU0P26bLwquOUUVjMsM+KRM6Jp8rrkBGMFn5EzpXU0/?=
 =?us-ascii?Q?PAV6vT5ku/QElX32Yy3uJD65ci/WtJuC8BEgOBXyAHr1Rf+MKiJsz7BL4GP1?=
 =?us-ascii?Q?2ppab9kQV5N5JmM60TrEtwpu6eJ/ziguT95X1ZWzDNHOiIj9k+Y7/JMmh27F?=
 =?us-ascii?Q?Hjog+PdboUDiRjIzcbnxo3lIvUoePJQzhUEZy2xa4SxxztDYr5MsifVWFyMO?=
 =?us-ascii?Q?b0FhDOQkx+sk2TuBq5bKWkt5VssYSXFrR+S9ociUO0IbGgHdXnXhUg95VxZU?=
 =?us-ascii?Q?qH6TrygfYwyNPVsPSK/m2nmxnUiPY5b4V3hCGvhGQEO+7kAY1FLLTYaofHbH?=
 =?us-ascii?Q?qrp2LTRowK6vLkj6pyAxUByvU64HPG88Ej1Fi0yRDndSp9SDS9j3aAzFxdJF?=
 =?us-ascii?Q?Mv+W4jmulsCtLxhJ5LnBqNJmPkCVwK2G1FummXUL8Fqs0dpBO6uwmS56omRU?=
 =?us-ascii?Q?mV5W3Ad330P6ji7Nex5I6sF9XqnjQfOZC8ilXOEgFKYFuuXwZh3bfrNK9qm7?=
 =?us-ascii?Q?iPRY4BqX7GBZBhMkp+qrMHyRs3t9aBqOrpeL8J+7PsDZwktItLInMSihEkYj?=
 =?us-ascii?Q?50fxOJ6mupZiN5L+laybKABtkJD8p9RfKcYNgX7nFojKBknJLSgzemFgVZd4?=
 =?us-ascii?Q?t32wYNpoHlhJnQtZ6Ksn/MghfibZe88TcMCC84zjxWmE5S7i3kW/7LSWNXYy?=
 =?us-ascii?Q?Oaglc9otNHDy5eDow++5Wyr8le5tF1ljvp66oioZqGxEK2fdv9/9E6st0uAU?=
 =?us-ascii?Q?Eg49oUmzLBScu6rZXHZdA0gqpzVI45f/wPaLhDqhv0o2l5x+aRIMS82/KJCh?=
 =?us-ascii?Q?L2ytDJ0ZYMsqFlAODZ3sH5QeW9TpQkcx7Rak0TRhlifWQQ9CcqezZj7kuELF?=
 =?us-ascii?Q?y+VI4/a3UuPUxTlK6xudkEGCeWnd5Vnb9MY17G0nFlcZ3gc1jyYkAQQkiLT3?=
 =?us-ascii?Q?lq8BTAEhHS1o3XlKhHjMTc0SYOlMuaMRFAfOSwTqG8tarkPOflVpHAUrycGh?=
 =?us-ascii?Q?SFK8BO5lGUK9VRSAbTw978uG56m91HNEkhWKYCTqBpAaNX6BBEBarixg65La?=
 =?us-ascii?Q?uYmgRBl7LfdM+FcSI7DEmpvBdYAZRbHCk8LxMZTaa6sCyuO4USO8F8caXphg?=
 =?us-ascii?Q?U6Y3odroeVeLGIghZWTltw4p6uZ8TrwhKcjBHW5AgsbO/ifTRXC78z1gW03H?=
 =?us-ascii?Q?+tVI1vYAgRJrkVAFwwQZEXgVYMrXaRWkuJXQ2Uj0q84Rjy/8wFtV7yZ2zHC7?=
 =?us-ascii?Q?OrpMVC7Yj21nxOntdOE3ZQmLoP4j0FgK2UQfJUvcG1gzn9rRdpTM6nDy805W?=
 =?us-ascii?Q?hfnt4o/CfZneLxk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:19.0989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aadebb6-0dca-4b79-b523-08dd3a536ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
We would like to have new dio encoder assigning flow.
Which should be aligned with hpo assigning and have
simple logic and data representation.

[HOW}
1. A new config option to enable/disable the new code.
2. Encoder-link mapping is in res_ctx and assigned encoder.
is accessed through pipe_ctx.
3. assign dio encoder when add stream to ctx

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 202 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 4 files changed, 206 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3ebbb59a22e3..e22a056af4a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2267,7 +2267,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	/*
 	 * Only update link encoder to stream assignment after bandwidth validation passed.
 	 */
-	if (res == DC_OK && dc->res_pool->funcs->link_encs_assign)
+	if (res == DC_OK && dc->res_pool->funcs->link_encs_assign && !dc->config.unify_link_enc_assignment)
 		dc->res_pool->funcs->link_encs_assign(
 			dc, context, context->streams, context->stream_count);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 72c88fdeb28c..9d2f24cefeeb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2683,6 +2683,162 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 	}
 }
 
+static inline int find_acquired_dio_link_enc_for_link(
+		const struct resource_context *res_ctx,
+		const struct dc_link *link)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->dio_link_enc_ref_cnts); i++)
+		if (res_ctx->dio_link_enc_ref_cnts[i] > 0 &&
+				res_ctx->dio_link_enc_to_link_idx[i] == link->link_index)
+			return i;
+
+	return -1;
+}
+
+static inline int find_fixed_dio_link_enc(const struct dc_link *link)
+{
+	/* the 8b10b dp phy can only use fixed link encoder */
+	return link->eng_id;
+}
+
+static inline int find_free_dio_link_enc(const struct resource_context *res_ctx,
+		const struct dc_link *link, const struct resource_pool *pool)
+{
+	int i;
+	int enc_count = pool->dig_link_enc_count;
+
+	/* for dpia, check preferred encoder first and then the next one */
+	for (i = 0; i < enc_count; i++)
+		if (res_ctx->dio_link_enc_ref_cnts[(link->dpia_preferred_eng_id + i) % enc_count] == 0)
+			break;
+
+	return (i >= 0 && i < enc_count) ? (link->dpia_preferred_eng_id + i) % enc_count : -1;
+}
+
+static inline void acquire_dio_link_enc(
+		struct resource_context *res_ctx,
+		unsigned int link_index,
+		int enc_index)
+{
+	res_ctx->dio_link_enc_to_link_idx[enc_index] = link_index;
+	res_ctx->dio_link_enc_ref_cnts[enc_index] = 1;
+}
+
+static inline void retain_dio_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	res_ctx->dio_link_enc_ref_cnts[enc_index]++;
+}
+
+static inline void release_dio_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	ASSERT(res_ctx->dio_link_enc_ref_cnts[enc_index] > 0);
+	res_ctx->dio_link_enc_ref_cnts[enc_index]--;
+}
+
+static bool is_dio_enc_acquired_by_other_link(const struct dc_link *link,
+		int enc_index,
+		int *link_index)
+{
+	const struct dc *dc  = link->dc;
+	const struct resource_context *res_ctx = &dc->current_state->res_ctx;
+
+	/* pass the link_index that acquired the enc_index */
+	if (res_ctx->dio_link_enc_ref_cnts[enc_index] > 0 &&
+			res_ctx->dio_link_enc_to_link_idx[enc_index] != link->link_index) {
+		*link_index = res_ctx->dio_link_enc_to_link_idx[enc_index];
+		return true;
+	}
+
+	return false;
+}
+
+static void swap_dio_link_enc_to_muxable_ctx(struct dc_state *context,
+		const struct resource_pool *pool,
+		int new_encoder,
+		int old_encoder)
+{
+	struct resource_context *res_ctx = &context->res_ctx;
+	int stream_count = context->stream_count;
+	int i = 0;
+
+	res_ctx->dio_link_enc_ref_cnts[new_encoder] = res_ctx->dio_link_enc_ref_cnts[old_encoder];
+	res_ctx->dio_link_enc_to_link_idx[new_encoder] = res_ctx->dio_link_enc_to_link_idx[old_encoder];
+	res_ctx->dio_link_enc_ref_cnts[old_encoder] = 0;
+
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+		struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+		if (pipe_ctx && pipe_ctx->link_res.dio_link_enc == pool->link_encoders[old_encoder])
+			pipe_ctx->link_res.dio_link_enc = pool->link_encoders[new_encoder];
+	}
+}
+
+static bool add_dio_link_enc_to_ctx(const struct dc *dc,
+		struct dc_state *context,
+		const struct resource_pool *pool,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	struct resource_context *res_ctx = &context->res_ctx;
+	int enc_index;
+
+	enc_index = find_acquired_dio_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		retain_dio_link_enc(res_ctx, enc_index);
+	} else {
+		if (stream->link->is_dig_mapping_flexible)
+			enc_index = find_free_dio_link_enc(res_ctx, stream->link, pool);
+		else {
+			int link_index = 0;
+
+			enc_index = find_fixed_dio_link_enc(stream->link);
+			/* Fixed mapping link can only use its fixed link encoder.
+			 * If the encoder is acquired by other link then get a new free encoder and swap the new
+			 * one into the acquiring link.
+			 */
+			if (enc_index >= 0 && is_dio_enc_acquired_by_other_link(stream->link, enc_index, &link_index)) {
+				int new_enc_index = find_free_dio_link_enc(res_ctx, dc->links[link_index], pool);
+
+				if (new_enc_index >= 0)
+					swap_dio_link_enc_to_muxable_ctx(context, pool, new_enc_index, enc_index);
+				else
+					return false;
+			}
+		}
+
+		if (enc_index >= 0)
+			acquire_dio_link_enc(res_ctx, stream->link->link_index, enc_index);
+	}
+
+	if (enc_index >= 0)
+		pipe_ctx->link_res.dio_link_enc = pool->link_encoders[enc_index];
+
+	return pipe_ctx->link_res.dio_link_enc != NULL;
+}
+
+static void remove_dio_link_enc_from_ctx(struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index = -1;
+
+	if (stream->link)
+		enc_index = find_acquired_dio_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		release_dio_link_enc(res_ctx, enc_index);
+		pipe_ctx->link_res.dio_link_enc = NULL;
+	}
+}
+
 static int get_num_of_free_pipes(const struct resource_pool *pool, const struct dc_state *context)
 {
 	int i;
@@ -2730,6 +2886,10 @@ void resource_remove_otg_master_for_stream_output(struct dc_state *context,
 		remove_hpo_dp_link_enc_from_ctx(
 				&context->res_ctx, otg_master, stream);
 	}
+
+	if (stream->ctx->dc->config.unify_link_enc_assignment)
+		remove_dio_link_enc_from_ctx(&context->res_ctx, otg_master, stream);
+
 	if (otg_master->stream_res.audio)
 		update_audio_usage(
 			&context->res_ctx,
@@ -2744,6 +2904,7 @@ void resource_remove_otg_master_for_stream_output(struct dc_state *context,
 	if (pool->funcs->remove_stream_from_ctx)
 		pool->funcs->remove_stream_from_ctx(
 				stream->ctx->dc, context, stream);
+
 	memset(otg_master, 0, sizeof(*otg_master));
 }
 
@@ -3712,6 +3873,7 @@ enum dc_status resource_map_pool_resources(
 	struct pipe_ctx *pipe_ctx = NULL;
 	int pipe_idx = -1;
 	bool acquired = false;
+	bool is_dio_encoder = true;
 
 	calculate_phy_pix_clks(stream);
 
@@ -3777,6 +3939,10 @@ enum dc_status resource_map_pool_resources(
 		}
 	}
 
+	if (dc->config.unify_link_enc_assignment && is_dio_encoder)
+		if (!add_dio_link_enc_to_ctx(dc, context, pool, pipe_ctx, stream))
+			return DC_NO_LINK_ENC_RESOURCE;
+
 	/* TODO: Add check if ASIC support and EDID audio */
 	if (!stream->converter_disable_audio &&
 	    dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
@@ -5013,6 +5179,28 @@ void get_audio_check(struct audio_info *aud_modes,
 	}
 }
 
+static struct link_encoder *get_temp_dio_link_enc(
+		const struct resource_context *res_ctx,
+		const struct resource_pool *const pool,
+		const struct dc_link *link)
+{
+	struct link_encoder *link_enc = NULL;
+	int enc_index;
+
+	if (link->is_dig_mapping_flexible)
+		enc_index = find_acquired_dio_link_enc_for_link(res_ctx, link);
+	else
+		enc_index = link->eng_id;
+
+	if (enc_index < 0)
+		enc_index = find_free_dio_link_enc(res_ctx, link, pool);
+
+	if (enc_index >= 0)
+		link_enc = pool->link_encoders[enc_index];
+
+	return link_enc;
+}
+
 static struct hpo_dp_link_encoder *get_temp_hpo_dp_link_enc(
 		const struct resource_context *res_ctx,
 		const struct resource_pool *const pool,
@@ -5042,11 +5230,17 @@ bool get_temp_dp_link_res(struct dc_link *link,
 	memset(link_res, 0, sizeof(*link_res));
 
 	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
-		link_res->hpo_dp_link_enc = get_temp_hpo_dp_link_enc(res_ctx,
-				dc->res_pool, link);
+		link_res->hpo_dp_link_enc = get_temp_hpo_dp_link_enc(res_ctx, dc->res_pool, link);
 		if (!link_res->hpo_dp_link_enc)
 			return false;
+	} else if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
+				dc->config.unify_link_enc_assignment) {
+		link_res->dio_link_enc = get_temp_dio_link_enc(res_ctx,
+				dc->res_pool, link);
+		if (!link_res->dio_link_enc)
+			return false;
 	}
+
 	return true;
 }
 
@@ -5318,6 +5512,10 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 			remove_hpo_dp_link_enc_from_ctx(&context->res_ctx, pipe_ctx, pipe_ctx->stream);
 	}
 
+	if (pipe_ctx->link_res.dio_link_enc == NULL && dc->config.unify_link_enc_assignment)
+		if (!add_dio_link_enc_to_ctx(dc, context, dc->res_pool, pipe_ctx, pipe_ctx->stream))
+			return DC_NO_LINK_ENC_RESOURCE;
+
 	return DC_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 019459dfd6fe..06d9cf0a7edc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -473,6 +473,7 @@ struct dc_config {
 	bool consolidated_dpia_dp_lt;
 	bool set_pipe_unlock_order;
 	bool enable_dpia_pre_training;
+	bool unify_link_enc_assignment;
 };
 
 enum visual_confirm {
@@ -778,6 +779,7 @@ union dpia_debug_options {
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
 		uint32_t enable_consolidated_dpia_dp_lt:1; /* bit 6 */
 		uint32_t enable_dpia_pre_training:1; /* bit 7 */
+		uint32_t unify_link_enc_assignment:1; /* bit 8 */
 		uint32_t reserved:24;
 	} bits;
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 652d52040f4e..37632be09e09 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -376,6 +376,7 @@ struct plane_resource {
 
 /* all mappable hardware resources used to enable a link */
 struct link_resource {
+	struct link_encoder *dio_link_enc;
 	struct hpo_dp_link_encoder *hpo_dp_link_enc;
 };
 
@@ -500,6 +501,8 @@ struct resource_context {
 	uint8_t dp_clock_source_ref_count;
 	bool is_dsc_acquired[MAX_PIPES];
 	struct link_enc_cfg_context link_enc_cfg_ctx;
+	unsigned int dio_link_enc_to_link_idx[MAX_DIG_LINK_ENCODERS];
+	int dio_link_enc_ref_cnts[MAX_DIG_LINK_ENCODERS];
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
-- 
2.34.1

