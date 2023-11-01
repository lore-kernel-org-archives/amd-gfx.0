Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C495C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA32910E77E;
	Wed,  1 Nov 2023 20:09:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F079810E77D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaqt+/xtCVsra9fABw4n/guSAFz2SLxHikpTwbLMcMua1GowOTDV+ejrXMH8VHuQdo90Z62gVb5UDW5w40r7PwOoebWotzpPlBT+Zbfc0UceWxbw8TUf8N5mrtyQBYsdLU5Ixpjl4bh4jGyW+MJm5VlNpZRoLJewcZq/r9ONv6n0fa2ZUg03Fvvjv8NgewaRdelJsz++f1BvyYT+1J+Lk9tgJZdJ9dCVdDLn5I7QIfYxTBPaUEu+y4qOr0Y1w4kGs3laeylgJTdyIRQTLa5/+CnaO7MDjS54aZNyOXRbP3zGpoRULyP6A3WdJOTkDoCOXVLJd/ensPZASbbI3u9mgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gb65GgVNZ7rdEF9p0IDwWNuWGaY9WiByiyEV02j9AY=;
 b=jQ70nnitfCzCrkNChHWTCIJSQTQl0WXP40yOd8187ZI8FrhHqV4xb4KYs21mCXGGSbZnnlZglq02/LA9qC3yFT3DoONZdBtzi+LapcKU8K2uyzW86AC5F+1HjIF81x8d25RzGITrdNvTN7+hRfpfchp9pXbktRJo2bUkM58LlyOHEuixGZi+MWHB/M6Y5qnhuRp5aK7jx9NGf/+ftMlGKzUfK2VJShNcG55G7TRYNhRCZDpcHEE9DlScip7MALKZQHO8pyEx5gI5x3Mi7z8I25MgTrOBAPJQ6Rnnu9S5x3cr5AvaQgmonP5SlSKVmQYG/Isu99osSU52P5WDd0o5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gb65GgVNZ7rdEF9p0IDwWNuWGaY9WiByiyEV02j9AY=;
 b=oVtLxO3w4zzX8TOFKg3EBMSiIRXwznq7nseMUsiVu0UGNvkVitMunQH60dWwQMxEJhvpUTElLNjoMLDfZmfIoirBwdi7L3n0VH/aJUa+LtJ9KwGkeYOIubJD/sSwAXf3jfW2R/l43jDwcbbQifOXv4zej7+Km5nBu4S093Oj5F8=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Wed, 1 Nov
 2023 20:09:00 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::2) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:55 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:54 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Remove references to unused dml arch
 version
Date: Wed, 1 Nov 2023 16:08:26 -0400
Message-ID: <20231101200832.995436-7-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd05e54-ac42-4caa-af0a-08dbdb16634a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEVrUu/z6dW4nRFh5QNvd9ya8vKmjY34uTeDRXQaW8n28ON4/FpRIAtlXaWZI3N8/tmX9wrgEQrh+E6E1thsFi4xM/m3A8Y/YiYfTqpdDMyihaRrq42vwvmJ0x6otnk6FflzRTxJ979UCwImMJxjUyIFr27wXjXP+59UJKrX9gkE9AqwvGaaNnV+CfLwMki8owO20iV7zCsZz7F64G2jC2EJmmmJm02hufbrhXJN9mak0fny/u5o53+5sL969EaY2+2KURtn1T9KofeZuyhVPC9tMC45752F150uXwB3B5AfnhWxgORwgJ40wyDnLM/XL9ermLcrVpezja4k0EeI+wpZ80y/UalfFzy9/qdwDnwVxnzJUYLEsAnQZ8pry8jYViQ+gABJ7DJ5R9LJ4+XJ+VdCahyfKU3FbCkDYxzckI1cNe8iDCveaZCFcIhqVN1vp1zX6mxMmM0s3bTVRpUNx+86Rlxv/bc7S78f2lQc6/cZohcVoRdvJgsk+ZSer4Zq2BRGOiC78M87QUjeCuryHtTwsZOZn6qqJYXq2V4hzq8NqqetrNjIMjLWDf3AL9TR9kqneA6ba79eb+P0Yr49KDKRdncJr8ZVCdb0a+ULzX+LH3QysunzOpiei9bJIbDdPmECU6gb9Gzp97dGF9xs2QlrSVo4GDw3GizeedD6ZkknWK/rE2jKvcPYhXxfYUUunv0fFHFAPZGKjTlFFFfUfMDUBis3ckLbGLLEP5RVOxbWTFnelDOsTL9WvoAJViidHB1MwAtUXmHhaEbxYiYYfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(36756003)(40480700001)(40460700003)(54906003)(70206006)(70586007)(356005)(81166007)(86362001)(82740400003)(36860700001)(47076005)(83380400001)(316002)(426003)(478600001)(26005)(2616005)(336012)(6666004)(2906002)(7696005)(6916009)(4326008)(41300700001)(1076003)(8676002)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:00.1221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd05e54-ac42-4caa-af0a-08dbdb16634a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

Clean-up the code to remove references of all unused
dml architecture versions since only dml2 is actively
used.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../amd/display/dc/dml2/dml2_dc_resource_mgmt.c  | 16 ++--------------
 .../amd/display/dc/dml2/dml2_internal_types.h    |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index d2046e770c50..82a1152e18b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -911,26 +911,14 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 	unsigned int stream_id;
 
 	const unsigned int *ODMMode, *DPPPerSurface;
-	unsigned int odm_mode_array[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0}, dpp_per_surface_array[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
 	struct dc_pipe_mapping_scratch scratch;
 
 	if (ctx->config.map_dc_pipes_with_callbacks)
 		return map_dc_pipes_with_callbacks(
 				ctx, state, disp_cfg, mapping, existing_state);
 
-	if (ctx->architecture == dml2_architecture_21) {
-		/*
-		 * Extract ODM and DPP outputs from DML2.1 and map them in an array as required for pipe mapping in dml2_map_dc_pipes.
-		 * As data cannot be directly extracted in const pointers, assign these arrays to const pointers before proceeding to
-		 * maximize the reuse of existing code. Const pointers are required because dml2.0 dml_display_cfg_st is const.
-		 *
-		 */
-		ODMMode = (const unsigned int *)odm_mode_array;
-		DPPPerSurface = (const unsigned int *)dpp_per_surface_array;
-	} else {
-		ODMMode = (unsigned int *)disp_cfg->hw.ODMMode;
-		DPPPerSurface = disp_cfg->hw.DPPPerSurface;
-	}
+	ODMMode = (unsigned int *)disp_cfg->hw.ODMMode;
+	DPPPerSurface = disp_cfg->hw.DPPPerSurface;
 
 	for (stream_index = 0; stream_index < state->stream_count; stream_index++) {
 		memset(&scratch, 0, sizeof(struct dc_pipe_mapping_scratch));
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index ed5b767d46e0..df46a866f801 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -104,7 +104,6 @@ struct dml2_helper_det_policy_scratch {
 
 enum dml2_architecture {
 	dml2_architecture_20,
-	dml2_architecture_21
 };
 
 struct dml2_context {
-- 
2.25.1

