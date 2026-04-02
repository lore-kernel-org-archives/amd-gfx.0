Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EE7D6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2884110F2F2;
	Thu,  2 Apr 2026 18:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bcAka+L";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4A210F2F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOyOKVySOu5++zuy9wWOM+01gsB2zZvjpXxmFA+yHXdeY4ia4WRjgn2+3uTCnCObETgpmWdq9hycLAuKh9WI/SBIS8/iNXJiIdQ8pefpMztFo/jOFmUIvu2/mOgaZSvWurtEFatBNN029Tg7y1qIOEkWZs6+ooF8Q8iAniLCvKnUXNRGMrmvV+C+NZQalOA5t86kkrjrXX9h5T9cxm+NpEOslugX46ozl+rRg7D5J/oRHvdafNYSd/h8egu6ehQiAAwNJdJOnX5FBaMGCYekURSCKGrz9AyPFNXK5YLfPtRdWSIk+TWlH+pomV0pBjuVAgxpeJ4cWhvKgagAhA/niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbfagTX63xvYwp5blh8EEfSzhNfRUT9WvD/kDKPYVfI=;
 b=H1mbqsAhQEnkkPA7KQAffLeUZE+W7A8ToZ7wRhZVb5WpiMY4C4Iv+1G9D7pFEJoS4yit3xDwbyX1SkRHg4YA2ukrrmTdvWP6yMBE3W2ctxdGhYQu0X6r6JPg/DIarqyFLrKk2gn0kye1R/4C+G1e5KN+0JB3AZ0Vb/sgt3sAhZ0Oth8fUrmnswc8Xl+m5jIsoKu5KBCOfFyJouDC852nw6OgZ6Kw15lai+X8Fhg8b8yharnRi6imX+ODUlAh62T95pIFrC1WCHVEe/CVzBnjeSc0tx+pnsUfWWWT6i47Yiz2xlWcXy5m2W1IMChLP7cbAHTZMoqnVo4EIeZpxbVApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbfagTX63xvYwp5blh8EEfSzhNfRUT9WvD/kDKPYVfI=;
 b=2bcAka+LENq4hgoF/jnkAjTqFKrKPIS5Ms2q0CkNsSLZ+dhGTFnqUc/vvpoFr7R6UVX1a5kt0oER0Vu5/yYrslmY1tUNq7ojgSrDjeBHoXU475twe00aaJs2ZQG1nlw2O9V5fUrZm1Ksdj4AJPqHGLz8wVL04nsSAxna4TTjv1g=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:34:13 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::bc) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:09 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/22] drm/amd/display: Pass min page size from SOC BB to
 dml2_1 plane config
Date: Thu, 2 Apr 2026 14:33:05 -0400
Message-ID: <20260402183314.1388755-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4fc159-367d-42c5-d512-08de90e6702f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003|20052099010;
X-Microsoft-Antispam-Message-Info: PQ0tnysoN+hY6P2V/BB1FfERZTokzlRLSLWMWhKcsDcQukvAOM/3UJ01q1v/HFjrGc2PBN+EOz7esmVx/yRqjOu1u1PiC8uPLuns3DBuudgycp/V6gSGCEJAjzq1Ok1LMxyB2HodRtdlxpKfjlLCT5NY/hSvn15aoTzGDw7+4pdgBawH2Qw8BjC78Y23AOoM9Zeh7GgjrVjGCM4VimxPsrTYqHSYptbfKue7GkiAriztq7wrsyRWTdGCxHgz+YJMhujnZhA8yD3DgPcGHu2zN1xCUqIDbYEd7BZtH5p15488ZxzjxE+sGoGpXf5BJCsUUr9jCI3fIsIKQ+OceYIipsAxJadIteDIzX6RYTDrVozOyUTtcR0AddkHNFBUrTz6fEGUqzqRMtjfp622QMUzyZww/BY2G5s1JrxU0Y5xjWTn/e76RgnLNDrrhL77U54TLCrDvirdjbe54CKNq7P54mj6KM97j55HA7BNhcO5cgdkPo9aZ/1peXmWJa+Oq1AEtHN1S24FSdgTvOVfzHg28SaDMbmHfkin0r3ZV34vwkVju3wd2WjjhSyrazjGeMAt5ZUKQzlR6RJwRmE1AIbeFdvq6ucoRv/Tvc+MK71w66NDHJW6L+9ryat6jveZjBPGVs2gflcf65xpTEnmUCnO16hoVOAF+RaVFS2vobCrhSkJ8LrQkqvNRajDdJ6D0rnklAM5tuAf/72fZZa4ZVd1gbqBL5QEvEAvcvjUS2PAjKvLE8eybiFx/IleKUj8qxFF3MVI2TkodziMeRObWM9/EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ChPTbUWy5YnLlMQgYvI45nDkKqSEKNZTFTXJso/0YxV/ailmdtkulFkaRpGmUvSDj1PBaH6+ajCRjUVyx1gYQ/4TrS7dw4n11Y0Ga86wWmD1LWH17w2Bhj6sm6UXINZmIaIUvZZ+avIrpQpG8k03SkB2gIhfzjDh/6umLfdZwUdrqIBAKQxHisM0WGyE4yGL7JL+0ISsqT0tlohmYZ1EAy16am2LcK89RQHDkle1TziPe5l7vErpyUkJLQf+wVe4bl7lVGeWahiGrve2nMotHOsHN1uny/zRi/TvJz+cmehqlWasrdOyHuMVJlNpYK7XEz8DV4wb/d2qXbUFd2pZZPyCrmlRnD2VjnLANqA8DNuZCPxl+V4oQkRlIrIK9DhSotsYTqNBj7Zu8Ugawn1rVRAtFlbAPK4J5wCCu9eYSBAtbhi+4kEpllGFKa77/Tsl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:13.2004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4fc159-367d-42c5-d512-08de90e6702f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Like dml2_0 this isn't guaranteed to be constant for every ASIC.

This can cause corruption or underflow for linear surfaces due to a
wrong PTE_ROW_HEIGHT_LINEAR value if not correctly specified.

[How]
Like dml2_0 pass in the SOC bb into the plane configuration population
functions.

Set both GPUVM and HostVM page sizes in the overrides.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 5d7b6c399470..476030193f14 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -389,7 +389,9 @@ static void populate_dml21_dummy_surface_cfg(struct dml2_surface_cfg *surface, c
 	surface->tiling = dml2_sw_64kb_2d;
 }
 
-static void populate_dml21_dummy_plane_cfg(struct dml2_plane_parameters *plane, const struct dc_stream_state *stream)
+static void populate_dml21_dummy_plane_cfg(struct dml2_plane_parameters *plane,
+					   const struct dc_stream_state *stream,
+					   const struct dml2_soc_bb *soc_bb)
 {
 	unsigned int width, height;
 
@@ -433,7 +435,8 @@ static void populate_dml21_dummy_plane_cfg(struct dml2_plane_parameters *plane,
 	plane->pixel_format = dml2_444_32;
 
 	plane->dynamic_meta_data.enable = false;
-	plane->overrides.gpuvm_min_page_size_kbytes = 256;
+	plane->overrides.gpuvm_min_page_size_kbytes = soc_bb->gpuvm_min_page_size_kbytes;
+	plane->overrides.hostvm_min_page_size_kbytes = soc_bb->hostvm_min_page_size_kbytes;
 }
 
 static void populate_dml21_surface_config_from_plane_state(
@@ -504,7 +507,7 @@ static const struct scaler_data *get_scaler_data_for_plane(
 
 static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dml_ctx,
 		struct dml2_plane_parameters *plane, const struct dc_plane_state *plane_state,
-		const struct dc_state *context, unsigned int stream_index)
+		const struct dc_state *context, unsigned int stream_index, const struct dml2_soc_bb *soc_bb)
 {
 	const struct scaler_data *scaler_data = get_scaler_data_for_plane(dml_ctx, plane_state, context);
 	struct dc_stream_state *stream = context->streams[stream_index];
@@ -648,7 +651,8 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->composition.rotation_angle = (enum dml2_rotation_angle) plane_state->rotation;
 	plane->stream_index = stream_index;
 
-	plane->overrides.gpuvm_min_page_size_kbytes = 256;
+	plane->overrides.gpuvm_min_page_size_kbytes = soc_bb->gpuvm_min_page_size_kbytes;
+	plane->overrides.hostvm_min_page_size_kbytes = soc_bb->hostvm_min_page_size_kbytes;
 
 	plane->immediate_flip = plane_state->flip_immediate;
 
@@ -786,7 +790,9 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		if (context->stream_status[stream_index].plane_count == 0) {
 			disp_cfg_plane_location = dml_dispcfg->num_planes++;
 			populate_dml21_dummy_surface_cfg(&dml_dispcfg->plane_descriptors[disp_cfg_plane_location].surface, context->streams[stream_index]);
-			populate_dml21_dummy_plane_cfg(&dml_dispcfg->plane_descriptors[disp_cfg_plane_location], context->streams[stream_index]);
+			populate_dml21_dummy_plane_cfg(
+				&dml_dispcfg->plane_descriptors[disp_cfg_plane_location],
+				context->streams[stream_index], &dml_ctx->v21.dml_init.soc_bb);
 			dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index = disp_cfg_stream_location;
 		} else {
 			for (plane_index = 0; plane_index < context->stream_status[stream_index].plane_count; plane_index++) {
@@ -798,7 +804,10 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml21_surface_config_from_plane_state(in_dc, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location].surface, context->stream_status[stream_index].plane_states[plane_index]);
-				populate_dml21_plane_config_from_plane_state(dml_ctx, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location], context->stream_status[stream_index].plane_states[plane_index], context, stream_index);
+				populate_dml21_plane_config_from_plane_state(
+					dml_ctx, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location],
+					context->stream_status[stream_index].plane_states[plane_index],
+					context, stream_index, &dml_ctx->v21.dml_init.soc_bb);
 				dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index = disp_cfg_stream_location;
 
 				if (dml21_wrapper_get_plane_id(context, context->streams[stream_index]->stream_id, context->stream_status[stream_index].plane_states[plane_index], &dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
-- 
2.34.1

