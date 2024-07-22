Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEBC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 01:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DA510E0FD;
	Mon, 22 Jul 2024 01:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJn2ZdKo";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F07510E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 01:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMkczQtf4yX4Uxd0mByzp//76uues36Q+eDbv85XSpFe8T8Sj4VfdN2Wyq2eviXsMTTg6mm+OSYexAmd8Qn/lqn05Doz1C4kYdrSDDgI/yE0xVnWdtEBKebDo7l/dYn7LFbl+f10rLZI4KsqPpVN3IMqwFrf6Bnm1R57yqETxLreBZgpNt7OASIN4oeQVcFs8d0Vr783o6vyhAOPiRS+H/RjAKkzXMunJ4hcUblPu7BkwvihR3bNZA+3YYfjgoDjKCpyqEfTlUWpD7a8Rel6qOCLvJdvXhCknYrro6TRRrLLDVbiF2DQyvqHn2aWuJswU512nOoqYAHUKeh5sV7rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYNmgbd4q9HmtlZQd8Hiu3OP27D1kvWxuro4Bf8c6ak=;
 b=sOnMzfuRRLSt37N9czOgpucopFN6KbpeohMWtYlJIqmRKOhSswnTRw29VrMdfa/XomUwbnT6dqc7yxv500zuXEXXQ2MfaTlfADyLXu0B6vRKnUeshmaCJdcRi+3PuIaNaN9aKiPL6uwJOcf3bgnLCRTBWwsA0QDQAK0N43CcwfOnzCOlYbN7F/iIWkPuq3XNSz3CSIy/Bs9kV2v5O1w4nTiOr3NR9g/fyAC1MDk1b7gmC9MypFOdoFGnqMo5yx8i+9qFJc2ECJU2AumIz+eo8NnsVgUgM2VDPaYFVbJIbC1ck+pveT5K2brXbYHlT0nen6+SU87Rx8RH++y2CrqyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYNmgbd4q9HmtlZQd8Hiu3OP27D1kvWxuro4Bf8c6ak=;
 b=HJn2ZdKoxkkWa14311qzypfc0BG/UlIyutNm8ZI50Or4eaqCJQdlDG9ZueX/iuf2T7J1jfReyyrtW+c1xAHhjMkxymGK9BtYySeJHnoI/MCU6dOPEqhGSN9SW0F4WIzATz/7brMFnKKUNn7jZ29NZTUONFP9LEZ+j/htL2Sow2o=
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Mon, 22 Jul
 2024 01:48:03 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::d1) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 01:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 01:48:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 20:47:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Add null check for head_pipe in
 dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Date: Mon, 22 Jul 2024 07:16:46 +0530
Message-ID: <20240722014646.3558293-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
References: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: a309109d-9200-4868-efcb-08dca9f052e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aOJY4LXp88Zx2a2LJmkc1pO75mKH+r7BnhEZq2bqoiuphmFvQvPk3MPEtufU?=
 =?us-ascii?Q?9u4HQoOBq6VDy+uzdi5x0pNc0KR6BXy5yNHzlbku+HOMPrGdQtSACXK4G9wm?=
 =?us-ascii?Q?Oqp5QuCIzu6AQelh8M8nOVFXRyLt4hIfPGCEC7l/JHzEBM0FjrOZmaHHrgTZ?=
 =?us-ascii?Q?v26wEcRbD1KfOJCoxD9o0JCiUC46I8s5m7+AXlWilWuhfPHpaJuzL5wXP0sr?=
 =?us-ascii?Q?P6iaC3BZnQZty18pKqyyutiyEjCB+8FAXh+VoJ4WVWkoDh+LEeikRnGcAO42?=
 =?us-ascii?Q?G2pdiSGCd+/gbHLqvF55ym1sjH7o61tYWJnRHGjweZXe7IUkEhazB04zYLks?=
 =?us-ascii?Q?94WiDtg41LyINlGjLcffA0qoKxK2RKCQctmZtEUiHEWvGpHxMzIBjw1shBlI?=
 =?us-ascii?Q?AzeEo/92oBoCpvdSf9aKpDYbASdFCwnpbwEul9NHNHO5TTz0wF4PSWlmsVD2?=
 =?us-ascii?Q?j/lAJFf5kISoHMriqZdiZ5u7taHg908KcsFQw7qaL6O2Tb/cs0zUjt4uIJG1?=
 =?us-ascii?Q?ZtkNXpHgXa7zFdWgSf39hwq9iLONh5oGF3N3ig6fGKnMUpQl+DPk4SVdFBZW?=
 =?us-ascii?Q?Ra043RZ703ht2uOtha7lXR3bu8MGh1wOEA2eIAq4xu0Zd4rYXFfcpG1AUOL1?=
 =?us-ascii?Q?WLgf8MPAy450xgNU28hFbRpIKYMEHHQMFqVe3yp1WgEo/J5E0/8EoEsZL3Hh?=
 =?us-ascii?Q?0CNFnqiTZMX7XXLmKgpjbslD9hJkX9pjNyvaX38ZBOtuBcqAhe/rlJwCr7Bp?=
 =?us-ascii?Q?Q7R2bnUK3RrrGa/sAMCbik/5sPDOy6qaWr5x1JQgeetvrn22tCK4Wygd6Mj9?=
 =?us-ascii?Q?Y1k+UIhc/PRv99cFLgEZaROtlPs4sfL1XJz0nBvVUwPLD1FLYeA/AK5G8v8C?=
 =?us-ascii?Q?WBdFso14jiSk/XNb4z+trZWi4suI0q8/8Wz1+jT/nLqcg5htoPPUyTvpEKk8?=
 =?us-ascii?Q?fhNjjSwBbvTb//vQHP5d7RDaiupaYqODb7A3ro8G1FzLdKGWejM7YwMpvBdU?=
 =?us-ascii?Q?boiB9aipL+UHmaPunVMXpgj28iiRbvd3t9M4djlaYMu77+lQmdVARZ/9XsI2?=
 =?us-ascii?Q?3ZwbEgtXNFYRHuzZXlX82GxysOCYIjQW0cQxLy5CbEwpHJXcGLFXcCmL0CaJ?=
 =?us-ascii?Q?8X+XianPRXuJqNoDofWBgKBPnyY46DdEFvjBKuKWhfq7gOpYFb+W8Zy60zi9?=
 =?us-ascii?Q?XFVxWLIq07eOzCNtutNJUOUVKcPKfPh/jljBVhGBMbpwAFKlTIaVmdjZ9w5h?=
 =?us-ascii?Q?rniyee/guD0b66qc11mKvwW5PkiTlgMobAuUOXdT2fLBLFZMsC2L+IK+F1ye?=
 =?us-ascii?Q?tfHJ8s7zLbjcNnCq3CPVyUvLguCEy964sbLa5fR4Htk4OTsJQhkUgnN1T6Lf?=
 =?us-ascii?Q?IW2I2xoE/ALYvc+ikZKvh1XkS82c+HhbfjSbMiN5LiPxwyQ39NsjC9dwIlSf?=
 =?us-ascii?Q?4LlK+53Ah88ozty0U8ToB1ta29xw3ydl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 01:48:02.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a309109d-9200-4868-efcb-08dca9f052e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
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

This commit addresses a potential null pointer dereference issue in the
`dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
could occur when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2690 dcn32_acquire_idle_pipe_for_head_pipe_in_layer() error: we previously assumed 'head_pipe' could be null (see line 2681)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 6eaf3cfebcb7..a124ad9bd108 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2678,8 +2678,10 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
 	int head_index;
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	/*
 	 * Modified from dcn20_acquire_idle_pipe_for_layer
-- 
2.34.1

