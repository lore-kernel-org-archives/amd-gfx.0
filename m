Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB3C41513
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B8010E6DD;
	Tue, 11 Jun 2024 16:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fs8Kisev";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9690410E6DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWzNI8BM2Ya9g5lmgd+PBH+QbInKkGX2AsRGi1ZHT59g3GGaEFE8L30eg4m6weWS3L78qX7v1CMjJZxo2pHyZyKzEtPUbnrZiIhegazPgL4aFMDKE7XXfxJ13bAOEgHGJjcVqHazJxFkw4Er+86jWSfhRkzGjRp66sOVQIRDZ9/9YcOMiMo0l4M8bQTkFDGmE1iMf/VmggJGR4qRDEIufBi8eS96YCMTGfLZ+K7Xr1swyVA9dh9ylqKff9y+tzhboNsOb6TgOZs7JUD+UUqvKGMLzjiOBa8KKs/Q5/R4Hn4+3G0HZgh3Pk6JrInSdch1hFAIr2NGmE7BveOx5dHH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5gATWz9wGdN48InIXezmRyLtM1A/Nzhs6aQ4wSFIZA=;
 b=X5KCwVXkWJUnoTgyML8cIYuhrzKhQwMpM05sPQ+jQT1jMAPMwktKmpMKmpDsLdqDpzx40YaGiJzaA5KfNAn/Guqe+oJKIp8+lrgIzVBzBfb/Egf36dFSZlbO8exhgONNK7XvmhXUU8bEjz6mTGEAHSU4/fc4aRzxG0en7dSDGhlqJRiWpo7NQbrh8TaAOXDBGPjIcKSJAdu7g8RFqQyoSc3E4WZgBcmJiq7qp4I/pT9f4e9WR/XupGXEfnirufP64SRXhCkXWfrpMQFHhtn7Fmx/hfD/jwTcwejb9kFFnUW3qbnsXrEoKxz5SX8a1SprMiD4sl0IpCBNPyoSbEQMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5gATWz9wGdN48InIXezmRyLtM1A/Nzhs6aQ4wSFIZA=;
 b=fs8Kisevq6c174/e2Tw4C7mmuDOSpYZ9Y+CxxSckueWaJvMNjjVRa26yObbIrhxQ9m6VepeZky5Y6oh46Ue74aHY47aYv908+Qb8kRbhFlRq2pDKZ0Uk7XSY6EcZMg+QmVGmP9QCkSrqvdCB7cEC+hfzmvOZvMgT4kgWWvYUILw=
Received: from BLAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:32b::19)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:45 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::3c) by BLAPR03CA0014.outlook.office365.com
 (2603:10b6:208:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:44 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 23/36] drm/amd/display: Check pipe_ctx before it is used
Date: Tue, 11 Jun 2024 12:51:26 -0400
Message-ID: <20240611165204.195093-24-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c06559-c512-4a4c-0edb-08dc8a36ea8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGDU3i148KwDCnAd8emd04pKKSbPw6oZwFVkDJtW1Qf6jLi1oV6MfqaqaWPV?=
 =?us-ascii?Q?WtFgp/zsMUNX/ZqT5YPCkobTe/5ftUDbEXOz5+rpCuihvKsmJAWlehyMGmlH?=
 =?us-ascii?Q?Z17pFsutp4JVFkSK6s9ExIlv/l9OGxMVfXOylNCIywyOqwsc9xemX3jLN+By?=
 =?us-ascii?Q?13VJ5DMjcpsZs16Zlnr9ecNPntIx+kV9Pz2RO5QEBExtXgM8ZeqTIAKzROUZ?=
 =?us-ascii?Q?aUrxcPD8PN7qctTKT6nQbrIiT/hDGb+0574m5EHeh3ByRQ1Nc8p7KIDEh98X?=
 =?us-ascii?Q?r9042Te9wbVm5CmcSuDde/FeT1i1B51Xco/0RhGaO4SDdIVzT+fOx6mdfdKz?=
 =?us-ascii?Q?3vRgCKj4wyNRdveuBwWf3FEtQwM3ch4A6mF2QYyW4YZFpbHpObr888QNLG8a?=
 =?us-ascii?Q?mQrCw/AjBdQU0DI8WPmOFMf0Lt/MDVfuAjQ6aT4562YsH4vZbWJKQJC+Gc+e?=
 =?us-ascii?Q?P8vqA+SmnXooeOVEVfqak9EBLkl7ne9ugAm8idZzDcboWmTji5qxLySffF6C?=
 =?us-ascii?Q?ZKKZz2eNTpub+nfruM0MIZVgAtrMS/b/ACnyZu+OBy1009nysJiur5YtSQTM?=
 =?us-ascii?Q?xVjdrQ9na3gUVDKT8httktxDPw9XAiDgSsTFvYHWDwq7N2GF7FyaN8y6e2mH?=
 =?us-ascii?Q?6aG0P7r0f1rdzfgVFCbrWpTLMg/bnjCTdqtvtceZPdXbKJ6lgi7hM+pUJX5d?=
 =?us-ascii?Q?tE2MgKtYx41f/KCmVgSB4raVdNOkQS9BIr0aFGCqCpUgRB5Qi2HAa/KWZk/z?=
 =?us-ascii?Q?nnWgA/K6naAhBDK48ngbF0iyJbaPrZyZE64dskAFIsSZZrlAmSRtUgZhY8iz?=
 =?us-ascii?Q?L/8Pw1L4Phv0AlE90vLkCketUF5jjV04BXLvzX1mqboJFqdIXDs/q75opvEL?=
 =?us-ascii?Q?BeCQI3A4o5cakvbIKw5cnejgBipOls5Ep1hrJDIzsTYgc24eWP2UbINJFNol?=
 =?us-ascii?Q?GKmkMjUcz9+/HVXq+UyRDvw/vjwHZpRqLrq1Ia1UEW/CaPCrjgi8LRfTGGwg?=
 =?us-ascii?Q?dmgCZ1WeBEXsoHJ0Iq8xBKm7KvlHucjnWodY86yvOjrBVjYDp0kchJcg1z2a?=
 =?us-ascii?Q?I9HpM+Jv0pDizzje0BizUd5nez13Wmba6pECi0I1jXq/7yrY0A+CaIO1Kbt1?=
 =?us-ascii?Q?DMmI3lESMYLP49eFLLGq500pMoQw780Elg8wkllG1YH4S62ojbTp2bVOzJS0?=
 =?us-ascii?Q?vIoLzOKRgn8r4tG+Q5o+O3BWzzOB0uCB1SO7J/C10xwC8uBK08r3gkf4cl3R?=
 =?us-ascii?Q?Vl6qJswhP/mCrMEef1E+4qcGvTAq5jJktOV2by0Sk85a6tWfoGCwvb8V/Zrk?=
 =?us-ascii?Q?0nQqpQGXvED05jJTvR2da785YhjwYYneYPVfBrOyBMvyvp6mU8qFXjffgBUk?=
 =?us-ascii?Q?Xr2XG/JeKtxoTYvldVQTegEax9ORi+s8PTGFvGDUfiTCDwJEjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:44.6990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c06559-c512-4a4c-0edb-08dc8a36ea8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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

From: Alex Hung <alex.hung@amd.com>

resource_get_odm_slice_count and resource_get_otg_master_for_stream can
return null, and their returns must be checked before used.

This fixes 4 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c    | 3 ++-
 .../gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c    | 3 +++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 76b849bdd914..87e84b0a3d48 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3127,9 +3127,14 @@ bool resource_update_pipes_for_stream_with_slice_count(
 	int i;
 	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
 			&new_ctx->res_ctx, stream);
-	int cur_slice_count = resource_get_odm_slice_count(otg_master);
+	int cur_slice_count;
 	bool result = true;
 
+	if (!otg_master)
+		return false;
+
+	cur_slice_count = resource_get_odm_slice_count(otg_master);
+
 	if (new_slice_count == cur_slice_count)
 		return result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a63b5dcba3f5..7abf8b88ca91 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1177,6 +1177,9 @@ static void init_pipe_slice_table_from_context(
 		stream = context->streams[i];
 		otg_master = resource_get_otg_master_for_stream(
 				&context->res_ctx, stream);
+		if (!otg_master)
+			continue;
+
 		count = resource_get_odm_slice_count(otg_master);
 		update_slice_table_for_stream(table, stream, count);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 87c7b13391bc..d276458e50fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -120,7 +120,8 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 	} else {
 		/* stream was configured with dummy plane, so get pipes from opp head */
 		struct pipe_ctx *otg_master_pipe = dml_ctx->config.callbacks.get_otg_master_for_stream(&context->res_ctx, dc_main_stream);
-		num_pipes = dml_ctx->config.callbacks.get_opp_heads_for_otg_master(otg_master_pipe, &context->res_ctx, dc_main_pipes);
+		if (otg_master_pipe != NULL)
+			num_pipes = dml_ctx->config.callbacks.get_opp_heads_for_otg_master(otg_master_pipe, &context->res_ctx, dc_main_pipes);
 	}
 
 	/* if phantom exists, find associated pipes */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 486b222083e0..6eccf0241d85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -905,6 +905,9 @@ static unsigned int get_source_odm_factor(const struct dml2_context *ctx,
 {
 	struct pipe_ctx *otg_master = ctx->config.callbacks.get_otg_master_for_stream(&state->res_ctx, stream);
 
+	if (!otg_master)
+		return 0;
+
 	return ctx->config.callbacks.get_odm_slice_count(otg_master);
 }
 
-- 
2.45.1

