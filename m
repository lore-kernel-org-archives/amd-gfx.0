Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B15CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B80C10E83F;
	Wed, 10 Sep 2025 05:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h09JbT/k";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2835810E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsu6Wgmggka/X57QtChMgfbWinrZGUwQ1RSkJH4Yl72y7wtUhEwYasHdKXnaQNa4SHtJ/tb35zl/93AbeS7NBftfIoXh1X6KYCj3rokiBtT/LcFHiz/zCvo2F3PHle+qNnqVT3Ew978rDFvfF1fcCv16STS/VL8cqug+zlUYgtJYd4aFXNkEIUhHxskt8rP5Spcwn9MTzbgac/Rf0kZ8INcmtWFO+koyGhKCzIKqD8EcSbEwlsbAkPAVFWGoL5PLhv/hVyauFFvsHAXYMbym8tS72ym+1ZxxT7Egu10EcLgH6DMSxNDzfgy886e4UkPIXGvCBeAdZUMQppywenpNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b44sihuSJAs7YcraT4jzFTANVY9/y4CyXfn0N4y1eNk=;
 b=pYQNV2hV8W1hrrQk61pqN4K5f33jkAk4CqmLDuvjIVwGrgcZaPLjXEYbFYd5xEBFc9joEeXbfnz/FlM51Sl8OvTYBQvqzzdpXqh/6h/S6kVu0HGqjXCIGXCqKAwyRBsRsBbmFdGO+fH00PWwIuYQeGo8IUUForKq+ppt3/V7WxLu2GCYzT9+IK3Vuds4bg8Dhc905nrSj575/GjWASVp0fkFsPg+tq1dPZSThbVeQbs60N2s7nxkn//laB5eLWusJJPBwpk7s/PWEwk7uyrV9qnbjGMs4b4xW7pTE1IUfGekrWMBMDl6CmqrDZuEF7N8Uijs/AVCagMPc7IQTdBhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b44sihuSJAs7YcraT4jzFTANVY9/y4CyXfn0N4y1eNk=;
 b=h09JbT/kHGGJTG9l+tdjff5CYrvoydQTlxAud5SAnQ2V7UCvNjoKy4v2K8xH0ZWySRNA+bAKoLDys236E085J6yGoos0Y/JYNl44SnQXFdh1ZTspO4YVF8xtWZS5iCWeVb9PKFu+QqukThTNP+Px0+57aQkKgZoYNoXxfVbQl38=
Received: from BN9PR03CA0641.namprd03.prod.outlook.com (2603:10b6:408:13b::16)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:26:52 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::97) by BN9PR03CA0641.outlook.office365.com
 (2603:10b6:408:13b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:26:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:26:51 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:26:51 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:26:43 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray
 Wu <ray.wu@amd.com>
Subject: [PATCH 02/15] drm/amd/display: prepare dml 2.1 for new asic
Date: Wed, 10 Sep 2025 13:22:04 +0800
Message-ID: <20250910052620.2884581-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af92492-d74f-48db-4b37-08ddf02aa636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tBqxYbA/k//hgStiqB1VGLE9gmVNRZqNu8bc+HGObEGI87IEkwKA4dhEAKxc?=
 =?us-ascii?Q?EYG1/BoQCPBiKAc3HEUVDssjQv88DDwx+HMoRMhWSM4AzhDUkdZ1lkxDhdNL?=
 =?us-ascii?Q?dqgQ49pLuI8Ls3BwZ93CcyisGePlPZPVxGZNr53b31HIZboIrm1djzi4Xczm?=
 =?us-ascii?Q?QQBu5SVgT5n3p+gCfDREj05APxP/ls2+Fo8Ho4q+XQKzRcHsvGCqWUJMmbnz?=
 =?us-ascii?Q?HZjn/yfCDeSCN14Z1hGr4KGjCGHCOvg0EzyrarNgYDzdzHR9RZ8xtqWfOjqC?=
 =?us-ascii?Q?QcBJ0pMWREzEQNuIwTys/xI4XIRdlvGQeiTf0A9uGcT/3hl0Q0ZE6wQWVK/P?=
 =?us-ascii?Q?f1deMF7kyhcgm4/ko5ZWi376ZkOV610tDYZIwZ+UH8USHiEUcW8nAiHzD0bD?=
 =?us-ascii?Q?vz31vnmbGiOEgJdbW9msmmtD5TU+KeVnzp8SvRP/M6338ULUy/LnwqL6EyhX?=
 =?us-ascii?Q?gxwYsbmz8dIxtQkC/Du0IOQFVFdixh9RE9XvPyEjHCaUf9DbKslKLtUWDOTR?=
 =?us-ascii?Q?M4Ov6cE5XYApbM2V9DdHBI9uqz+OulBzo6PkxBIfoda5LaJFn0nFC/RXHMN8?=
 =?us-ascii?Q?NfeM9Q0Cse5oRhEj5cYTFKpxshq1mvNmnE6d+STsQPwKAy52H8Lg/wVbJNll?=
 =?us-ascii?Q?9X6Uwj1VtqG1pUccw1gTR6Apm/gl64VGt+3OVczH5YbdTXzS3RIJ9hsOCIvu?=
 =?us-ascii?Q?GOgHS7F8QiZwENgwkjjqRwjmotRSdq04wQ9gJ1E2dSDEr4hhTTC/lpUEpyXA?=
 =?us-ascii?Q?14Is6q1wKnU6pPVPcoPdtc9eOOJAaN9Rz5v3dJkPuf76HZKTv/6xkegPt+Pr?=
 =?us-ascii?Q?IhsqJe/f9s5ExVqkegjrxgbvmdQ++3KlC0gPq6vMB18bzwt/f2LC47coISsB?=
 =?us-ascii?Q?Fjw+7YB8XMBo+W32FtPEN5uEB6M1FXq9zNguwogb+GbA7CaOujYmGzvt4S5F?=
 =?us-ascii?Q?0LyAvhfJ4zjKCJLRM0aJ3kX1munKlaMkIvJXG0ARQ4Uuc/08xOTgeAZguM6+?=
 =?us-ascii?Q?uRDjnqdBTKfQfL0JAMONTKgeLvxB30PvNeKW90BsCrNUrTdFH0CqI4fwUm28?=
 =?us-ascii?Q?YsZJ/OmwDm2yZ9sBfwjf+qnSxWDyRuvhrBrwRyvS/fa9a67tLzH2CVzhiunI?=
 =?us-ascii?Q?/v8+Jh/pH/mc366BHEJZLlUEjoOw+0GzgZXZKNDmTLqWVlvttvsacrYwTRqV?=
 =?us-ascii?Q?x636cOQ7pIU1NcX7jYNE+7w/jXxKWvf2WINU97b+4sj65hzSNy6qv5dx/smH?=
 =?us-ascii?Q?0wq1tGDQs4NZFWjmyfelpHcIzsCRwa5QOVgxBVpi/fdKxll39H1ma5+mHaoD?=
 =?us-ascii?Q?rAR1BA07kKTYc2ZNQfnUtOkaUB1qyns2lmFZLb41m5cFIxxeQ+B0d+wz/sTb?=
 =?us-ascii?Q?fjff06Xmk3urF2jS5lD+4KQGlKG26TLpjk0BZ5YzvaMM5Wt7no10MAifdpKu?=
 =?us-ascii?Q?njLLozPLjz0HnryLa+Ql+f5WJQ9g5ujsd/QdyTo6zvy2nklDlYJksEkI+3/6?=
 =?us-ascii?Q?SHPhKUVG4xRxRUCfyni7JNN1lRJPhlN03edH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:26:52.3896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af92492-d74f-48db-4b37-08ddf02aa636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why&How]
prepare dml 2.1 for new asic

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c              | 2 +-
 .../gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h   | 6 +++---
 drivers/gpu/drm/amd/display/dc/inc/resource.h               | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 883054bb18e7..c61300a7cb1c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -211,7 +211,7 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 			return NULL;
 		}
 
-		if (!dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
+		if (dc->caps.dcmode_power_limits_present && !dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
 			dc_state_release(state);
 			return NULL;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 7de10a95cfdb..41adb1104d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -16,9 +16,9 @@ struct dml2_instance;
 
 enum dml2_project_id {
 	dml2_project_invalid = 0,
-	dml2_project_dcn4x_stage1 = 1,
-	dml2_project_dcn4x_stage2 = 2,
-	dml2_project_dcn4x_stage2_auto_drr_svp = 3,
+	dml2_project_dcn4x_stage1,
+	dml2_project_dcn4x_stage2,
+	dml2_project_dcn4x_stage2_auto_drr_svp,
 };
 
 enum dml2_pstate_change_support {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index a890f581f4e8..4e26a16a8743 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -45,6 +45,7 @@ enum dce_version resource_parse_asic_id(
 struct resource_caps {
 	int num_timing_generator;
 	int num_opp;
+	int num_dpp;
 	int num_video_plane;
 	int num_audio;
 	int num_stream_encoder;
-- 
2.43.0

