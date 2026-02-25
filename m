Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6950AFD45F1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0951C10E844;
	Thu, 26 Feb 2026 00:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG80tTKC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFC310E844
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQhL+qmjl0cg+da19lXIc6lZV0FOa/6EkI/861RIRC/ZkkRWXzuFT12ZxJgh4PeujPoJkztdx51HbYZPaZqjy+5UWVsUNmmS9a52Q8hDtvdxSuMii7cQxzp7jHUDHZu6/aLdR3trYxoCDraacc70W8R2ccHvSNWcCJAEXyepvYYZRo1lrac/WLV+wxRDElWpIB5p09G29B7W01QjE3/1PBvJu9olEKJ9SnXzzmyExXsDX6gNQYseL5cDU8wjbBPlzTkaN3zIJgGbAXDKSm6am0f+xAnnTdT76T8lCh0nnkuYkccBiiZZX3DYWyPrAEtfWec4t7CEBzf4YXpZDVRMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP485VHJ9b9Zu/e2cfPDLAR+rfaXW89xrwKVe0l06Jw=;
 b=JTw014gWptYrl9W9ISLwNJTIVER8ldbSrhrHutNcDl0ZYOkTKm45mryVjJgN3UWoAxFYO3crETjI2LFEQtOlR2YX5aasoKYVwnYmSp3Jz0CFUek1cgh2r3mG+GRAIS2EkMm983b095i/3fzZ7eMsJfXeAt1BG2lcMe7fgB+103uNERy22R1wYTe+z0/I3x6gnE5OUKRPPPnarO0MAkcBUWKyrdKLfan0+uuJjlUYYddkvlZ3O2Vhl7bbZhZ9hL1W6HO8tVg6PIcVOsd7rs7Ii5j0uEjJ4ze1ryuHpdpc0e/0V68cCCW/1p9oiZNLf3Bdh63klOsO014X0RoNlGQNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP485VHJ9b9Zu/e2cfPDLAR+rfaXW89xrwKVe0l06Jw=;
 b=dG80tTKCa+ko5SAwm4JxNRFdmyi66ViuLXfWgFhXa9WR/ad1TCBoBaP85hKO+73kjXcvTiipAHmWDKOFBHB5A9jTqbi2P3U+a2KN7elPEFc6tLuS9+nFCXY/eUyiB3pz3aslCL+woeYO4kVIPOQEwlSOunc+lNzVSVdCxtKxxkM=
Received: from SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::23)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 00:02:50 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::d1) by SA1P222CA0117.outlook.office365.com
 (2603:10b6:806:3c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 00:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:02:48 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:02:46 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 6/8] drm/amd/display: Remove always-false branches
Date: Wed, 25 Feb 2026 16:57:45 -0700
Message-ID: <20260226000048.68030-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b7fdfb-5772-425f-4b69-08de74ca606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: pnZe7eilmZPPfpWZQaGJ6nE3k8pO0ChFAyR2le8GpLPKBOeOZtXVvtx1yCQ4JF4cb7lwrYLG3OJeqIUeT6Ry0qAVWsynqDX9DyJQV8KvCQ7F8c0L7bSNcIvSihP8EHGBxSLfW/ZyrF+M6PmHeAlZdldZnAI0/rqxTuj2gIbUOuT0Nee6nehavT/smuPbeKmdn18t2p4IYm+mUbrW/GGXBVhhtb4+6OV8YGKmTgLLXkou9QZ/A8hx13ldPRuGgHfGLXu4gtOd+oTStglo1swUxp1WMvzMc9pt5CyHh3BoqR4FjpWjTrTUCXIJVJvW+OzyJUoTpmtNo6HKlSVecGsy2hn8BeE0Crr+OLj+B1AoHd+fps/pWHaO0SmmjxU4oGF/JX/1ee7tkIMKSLS+wUjH28jQBmS8kdZCfFFm2MmVosT+oYk1Cyhx+Ne6WbqpHpqcUI0SWPqu9ovbJm9oked9a/+jYQg/s8scuJIaWdAlZzg0jjsjd9IaCM8m642mDTVci299zHqgtLIN72xnnHUlIe3K3/0k2n9cRiRwuV1ioXA9qMU+fX4c3lhajwkckQrOB/mB61Q1tr66VQPdoy6e7oJsJOPZqgyFt3VJAO4b1HJxPi7cIr2FKzmn/uhT7Y4lBhH8Odvle7Gvh+UzEiyuECivd0C2QwUNE7jKmyNtOeVqWdhvtx90dRS6663uLgEeHU4vjf5XX7/0jiM8rQR+8DmSneerAMyUAFnVgIl3naqZkKTimqGIEWKBHIcpaXWfTmstOnaVxvkAha5Lsen7FMdbM3LYu274ekqKPCDfiP2aCmLTjLGeQKqpMmcCP9UqBHlgE9VqJiScOn9APE/tsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rqBAa3VmMx0eoQ0ux1ig1sR3APeNuoFzrymgomOwmz+Mel7rzqeIW8ry02SbYCf/IoLxPNBTQEeG0Y81Njl0zgZeDEjfnJs/bpWLtOA0GTAL0xfAbfde116q1ZSz3sAK7OiOH+omNKYATyp5HPKsXh8P1I9sovYcq1dx+P/WeZKLIB/Vf5rPYjQ6Rs+7SQlzTVdjxGOZF/kU+X6G5HnMtpJfMN0lb122nbxoN0w8FumZH1fD8g9+BpDZOZ7NkBKyDRaE6qkA8bKUxym8BNbvnqqfb3eyDw6hQuRy4yTz2+VbLf3upYVShVLoyncJUHSb25RaFOJsqIY/X29IqfdDtRP578J4Epdvnj3s1/NeCmpxJPrP4kYsr33uLpeoQBCN68vPMeuwQhMUxl2of4L9kMAS15+j3As3U+J1Dbt2ziGcUlWSHCP2MZXWYERb2NQL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:02:48.2683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b7fdfb-5772-425f-4b69-08de74ca606f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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

[WHAT]
program_prealpha_dealpha and hpo_frl_stream_enc_acquired are always
false and all branches depending on them will never be taken.

This is reported as DEADCODE errors by Coverity.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c    | 5 -----
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 6 +-----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
index 244c91b762b0..c126fb9d5bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
@@ -132,7 +132,6 @@ static void dpp42_dpp_setup(
 	uint32_t alpha_plane_enable = 0;
 	uint32_t dealpha_en = 0, dealpha_ablnd_en = 0;
 	uint32_t realpha_en = 0, realpha_ablnd_en = 0;
-	uint32_t program_prealpha_dealpha = 0;
 	struct out_csc_color_matrix tbl_entry;
 	int i;
 
@@ -256,10 +255,6 @@ static void dpp42_dpp_setup(
 		CNVC_ALPHA_PLANE_ENABLE, alpha_plane_enable);
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
 
-	if (program_prealpha_dealpha) {
-		dealpha_en = 1;
-		realpha_en = 1;
-	}
 	REG_SET_2(PRE_DEALPHA, 0,
 		PRE_DEALPHA_EN, dealpha_en,
 		PRE_DEALPHA_ABLND_EN, dealpha_ablnd_en);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 0d9871f9864b..f0e1ed0f2949 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -1078,7 +1078,6 @@ void dcn42_optimize_bandwidth(struct dc *dc, struct dc_state *context)
 void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state)
 {
-	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
 
@@ -1172,12 +1171,9 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
-	if (hpo_frl_stream_enc_acquired || hpo_dp_stream_enc_acquired)
+	if (hpo_dp_stream_enc_acquired)
 		update_state->pg_res_update[PG_HPO] = true;
 
-	if (hpo_frl_stream_enc_acquired)
-		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
-
 	if (count_active_streams(dc) > 0) {
 		update_state->pg_res_update[PG_DCCG] = true;
 		update_state->pg_res_update[PG_DCIO] = true;
-- 
2.43.0

