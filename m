Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7A606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hGlGEa9K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C9B10F970;
	Wed, 21 Oct 2026 06:28:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3F010F96A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ5j+zJxcT+onEbzzyMiWveXZgKz+Dr49fLQgwZgpTmPHHeHmzeMxyXKJyg72DXXvBTNTn/FfmF/bnBSN/4b20qjOIAjIPvUaLlvLOJMr8JbsTnwBZnqPA5dQWNZkfD1RIQuV5+GuRi2HgbRQvbVKcOHj53UihhFO3nbjUnLP3s5bEU3b9CH/LOh+aKEzEUPGSe741B7VInKPPKq+SwK9zt+iTLIzwzZVg/zV1eRX6oIDnttPKwXl+nPJcx6RzOq+QBjepJRng+p210rQhGBs7EhFai2+4A8CcbOcEaQW9RSQxn3kqBCvhVuoKm9EVtKfHqEd0VqXeuiQvjddwKN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbX8L2WevYQeCJbarbBGPPch87ZOT1vhoW0CNLytZsM=;
 b=pL2MrZROHPTiSwYUSzKaxPmXFB7KBb/pJS0tAIRvWYw57jKqIRVzpmJiWcTnICZ8zjLYo3anhkjrNe2rfqaWQDsEA6AYpRNzYGeq7BOPXAFjeC6eqGPaI2Q7GHKksAc0qXhYu4RZwwl5Ql4pRzz9A8gulk+D8gbkhsx1aF5ynDVrt8IJ/OeaSIBpt/t/g0mE7BZtYLKuGlp6SYneiqBNaarK13CQGn1vd+INj9WmFK3e7FtbnIjCdknHDX8FIuUaL+T075Cz4sFXEli4dB1wPAuhjqSX6pLGut4iQIRRV0RXyPQyyYWwh8jpXmFBvknfNY/FPt6zFAzYMdvo0kcVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbX8L2WevYQeCJbarbBGPPch87ZOT1vhoW0CNLytZsM=;
 b=hGlGEa9KGuyYUT2vIF79RAnVOX6OJVd11JI5x1muSpUc2CvKuvd7XQIrYK1e27Zmv6kP2yUXZDK4KpMsBBZ2pRy/StXGP0Ie0qHwuFpS+xs6JFhPglIyeAMsO9LZZ7JHiNIGRhVEuqAD95h8+Y3jxGIq+IQlLI527B+cjaujUD8=
Received: from SJ0PR13CA0207.namprd13.prod.outlook.com (2603:10b6:a03:2c3::32)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 06:28:16 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1d) by SJ0PR13CA0207.outlook.office365.com
 (2603:10b6:a03:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:28:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:15 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 46/49] drm/amd/display: Add debug option to force MPC combine
Date: Wed, 21 Oct 2026 14:22:52 +0800
Message-ID: <20261021062519.674697-47-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 7789d71d-6474-4c37-0b5d-08df2f3c7d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lMPzJ0iT41HKmED3lcBAtiuryuTjR+FvyndP3meqdQtJucwKa44b2/+iCrSXkJlvR8dkmvX3o1BfQJqS3lNJc7v30qfhlgqJ1P3f32j5koXyKnyAjXf29TfRRqm7HiEX79TNOZ32C06YrIkeCNevejNf9h9SiXfkMS6yoYWi5vvmUREiBQGi98TdDJ/r7I5k4owyXnZ/X0kCuyC6QHQLPUu4BpAg+AwzSTOFnugCt95P9ec9Ur+o8DEbqbfqfoTTtTBIkfM/Du2N8eVxPqXVBbaS/IGP7xEplxaiHwjobS86nsaYl9Ne3X9RfmGjWNuovdZt7NV/CFq3DfIQ0LN9giroo/ecMU+/4N24jruuwG5avX6tMrn6NNsDmuSIoF6ab7bmuddqQ4zQL8XzkU8ftspPRYPdjAhUsjsZySHUVam4mq4wNVTYckkdqoIPMiGYiJ1EaAGvJBKnabyaGlo1GvCycPYnbm9CqGf9zp8yPi3o9WB/EK5Z3vHMKpATAEYmluKjFfnjqI2ox/J7R2INe2G6ODyqOcje2ygBZ5k+9XOOts6jKtEJRDj8JaayKTDcIDsAUcW0bUwYlRpzKWxnHlsdA8grlxPmQu6It7eY5tiL9pPvpzIcjpe+58ruwqPjSS36lowLFswx2+Or6/4RJD0C7wrt18PcTX5Vyr0ih/2cM0tKartehK/WzYRX05ftENxDdKnx2l8KI3K+QliP6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sI6XCQSL6dv0ANrDQhlstFbotKVELwCiNVDe6e6qe6ybfcYWWUtGmIRBOQCnL8E0uv6OV+yMiysSGug/t6etH3k8QNjLIAFvoT5z7yjOgEw6G6/X0mp9Sy6M1howi0ZqaZyDf/PFFimZ0+du7Q822fbUNpvMF1/qNrgtgBr3GQ4uQSAdx7YxO1ewKeI4FNh47eCv8RJC+jl6HzBQBCjs8JUarUvHFqBgT5/2q9ET7+ZsO40CLzjF6k+TgF6I7VnIWQJ/eTBzzG+uB18a1M0Q0Vp5iIri21gtQC+tZ151tHc9F4jvJ9ZQ1AJtClLrSBBzSJQfk+/Ijft/N7b/Obw76CvpM7F7zYBcvJ3ammxwFXRIPbcPpkRJNwyLtOdJ16Bv8kGHfY7pvxqdc8zFhQZQN/4XVKbFvmq6RH/f2EDtYczQab0rA6jMg9EoBPXHKt5j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:15.9064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7789d71d-6474-4c37-0b5d-08df2f3c7d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
DML2.1 decides the per-plane MPC combine on its own and there is
no way to override it. A forced override helps debug and isolate
issues that may depend on the pipe split.

[How]
Add force_mpc_combine to dc_debug_options. At the end of
populate_dml21_plane_config_from_plane_state, apply it to the
plane mpcc_combine_factor override when it is non-zero:
0 = auto, 1 = single DPP, 2 = 2:1 MPC combine.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 6 ++++++
 .../dml2_wrapper/dml21_wrapper/dml21_translation_helper.c   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 51472d6849cb..494ab208cadf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1102,6 +1102,12 @@ struct dc_debug_options {
 	 */
 	enum pipe_split_policy pipe_split_policy;
 	bool force_single_disp_pipe_split;
+	/*
+	 * @force_mpc_combine: Override the DML2.1 per-plane MPC combine
+	 * decision. 0 = auto (default), 1 = force single DPP (no MPC combine),
+	 * 2 = force 2:1 MPC combine.
+	 */
+	uint8_t force_mpc_combine;
 	bool voltage_align_fclk;
 	bool disable_min_fclk;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 7181fc71e4c9..6a9f822b2b33 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -828,6 +828,9 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->composition.rect_out_height_spans_vactive =
 		plane_state->dst_rect.height >= stream->src.height &&
 		stream->dst.height >= (int)stream->timing.v_addressable;
+
+	if (plane_state->ctx->dc->debug.force_mpc_combine)
+		plane->overrides.mpcc_combine_factor = plane_state->ctx->dc->debug.force_mpc_combine;
 }
 
 //TODO : Could be possibly moved to a common helper layer.
-- 
2.43.0

