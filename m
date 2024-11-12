Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84065D597AA
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF8310E66B;
	Tue, 12 Nov 2024 21:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kf5iA9S3";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5541910E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQJkUAQmklaxee/tIAdwzpAeAdWJF5TIlTg2zFnvcvtbm3jj97ClGMibDpXZzByhImK50wc1vmrjFRVHEHEaCw9fHNPlVTrIaL1IOItWlU2Scz13g1vbe1SpyJNTgLlaqQNbL/b2yj5bMAFnvWg35It8kTEA8214jpMgdUSN2MnvhVFmki+KSrgom15qTuYCwTRWQWaGQnmZeBEKzWw91MtOfICZ9fziLi4w167h4O75RwgChh+HRA5sc+je5SVzsHzT+kh6yYEH3Iye4+ziXUVT0KcswmPpLB7ZyDtlxW8RttH9pjGpqQH/LUy6aOFcovnXyYgJmQOuOZfme7NgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7fpLcZM5AN2/25sbtSiwcA+MuUY5ggs2MhrdpSeL9U=;
 b=vfzymaTpdsPZgERpgX0v+QtL0WKJeCDmNfk4BSBk/+w010u3FY71mqdKCkc6JR8vldi3fnIJq1IPo7Rjm+lV3euDufEgzKKO2WvvPvoVsiCa6abKCD2uah2V+ZDRlzoh1jKqXtTd1xO+eBnS96zJh4SDuEveBJYXTJxkTDwY6+2raKRTVv7AIPbNoYXPNZi1wZ72mNCH9wT7JYwa76QXyL8i2QqXZhBn/7eyfgKDaEtqbLcLB7QNdNqanNp5Ck4BrFqjpCLO5DFBrgSU/hYPWxrY9ZZba0nIZEy7iokNAyjTPnK5dIUtPfdKUh4zHVtsMPY1U8AD6FeoeUx9xWqt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7fpLcZM5AN2/25sbtSiwcA+MuUY5ggs2MhrdpSeL9U=;
 b=kf5iA9S33gg9kj7lz0YS/X3vCu0kpEcs6qJahxiRcRL5qr3DnTZDDRQeZLPGQELg/LxaCiWJTso9BuSvza7958t7meEMzJ27dn5sw4l08tGrc6UKlpKXBgLajvSRDMi6WJK5ITDHintffUx4IeqVc5nTbsvB41vdYO9kCd6aAZs=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 21:37:33 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::69) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amd/display: add clear_tiling mi callbacks
Date: Tue, 12 Nov 2024 16:37:13 -0500
Message-ID: <20241112213716.49355-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2d7289-3310-4fd3-9e05-08dd036237bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdfueuHRlvMo356SwVuMJc23x2TIPcSfXWA2H2r+4VaBeuDRYRHB5/3pZz8l?=
 =?us-ascii?Q?Ls50NUTZLcNyZob7mCKkBAUNDW5anZPOzekHdJRAjx/mdAAkCxitfA+Iu4ih?=
 =?us-ascii?Q?KSjwS2y0B9M1wEFUHj3rC6+j33YwgQyrgrlxd9ZkabeCTW5+wU7xFgVZfKgr?=
 =?us-ascii?Q?WbicSlebr+EsHzqAn54tx72wrVXMY6+r3gZib8o97Jdp4AwzikkT9ZPTOIgL?=
 =?us-ascii?Q?UpH+6qijWYCTGqn8xfYvGRQDpN2Za9Zf63RLO36CTsVFEHd5tyCl4BXCM0Sr?=
 =?us-ascii?Q?Qlj9QodpF8jhcSitNdnWjj+4lUp8oZ2eid4ThCVYY2UJWyrTJ/BXtftnEM1j?=
 =?us-ascii?Q?Dz83R5zPSm58ATiIaQj7edgETXv63i7p/3z6Nu5MLltEAxEg1e8R+cDEinhL?=
 =?us-ascii?Q?OFORpriiAMZUJAw8NL8XF4zvTgXMBxmMdC3IJn+rtjGEKo6T9dKNwAZQOqfj?=
 =?us-ascii?Q?0NIEO0ILOwdaXrGIs/q8zaxM0ttZiuGZ6Ywk5VsmYhwVFX8Oe+QiQ45+9MEZ?=
 =?us-ascii?Q?semUWrC9qfRPOzd882P/akqEjnemcqHqqfI9ADzYAq8YKMs92qDm4qpRCJ1g?=
 =?us-ascii?Q?oup9EGLAor8dXKaBHDpeSYqYao2EBMSyKnuH4PzUgyepzkpFEpJNlREyOMUu?=
 =?us-ascii?Q?MhAdObq88NL19TQZ+M9s8mAq9D6UsNBW8fcVR4P+iOWMdyBpiDwVux7cGYWs?=
 =?us-ascii?Q?ZijjfGGqfuas7dpCNBCJG84xToABzSAYrXffDwQURRZdw+hJr1/hvzMo2PQM?=
 =?us-ascii?Q?WFtN/ed8/xLfXQOdzz/g8ugZybyFgzg9cIAIRZvZpWkgvwBJlQmhDrGXtxAH?=
 =?us-ascii?Q?BP/GPJVu4J9JM5UPeCfBfLpSCQ1tUkoD6c1d8lgzTVz7zCyAjvQF5qS+o/Qd?=
 =?us-ascii?Q?1u0vvW580jXkRPJiWrLfIx/RjEcBJzp5PJXVhUFZK4NGtoe/sn2u3yxUcfO0?=
 =?us-ascii?Q?2Qk1SyUg78Z0o8a/dNel4bfTOYAHYFnsXl9ML30i5qtWczbOP+DB7Fdp5EJX?=
 =?us-ascii?Q?r5M8am4eJVtSLh1Px9h8pu2rgO+PeMW5bLK56tXPl7068IljrRIXcvSa7Ap7?=
 =?us-ascii?Q?9Ze7oMkh+f9/8n5dGm11JDr3PuZrL6TRfUkp9iXsq5I9N0ZnrtSIJ7943zvI?=
 =?us-ascii?Q?il3AtrP4mBMVzkY1ADlkTYGu+mzbB3SbR9lqGRO1L5TSp+O5zbMvH7e55lqR?=
 =?us-ascii?Q?pFdzdK+9mKINmBz4kBgYXnD1x/Sk2oT8AJe+CryjrFHLEIQBk1/jDt67XWtM?=
 =?us-ascii?Q?mZxNf+MlM+xMfCduHliSC52qqstKZ7lC/6OuA3s8NYGJEZst4sdaXhkuOIrz?=
 =?us-ascii?Q?qzX0GCygFK2YYqOT6nLrA7uehc7fJJgJycsM9hVtHh66z/4Pm+WbZshIFJhM?=
 =?us-ascii?Q?rEc4SjxzjB2zCQG17pxBrUyUICbky/r4xmlJzlD+CuXF0iqAMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:33.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2d7289-3310-4fd3-9e05-08dd036237bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

This adds clear_tiling callbacks to the mi structure that
will be used for drm panic support to clear the tiling on
a display.  Mem input (mi) is used on DCE based display
IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index f5e1d9caee4c..ebd174be5786 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -481,7 +481,6 @@ static void program_tiling(
 	}
 }
 
-
 static void program_size_and_rotation(
 	struct dce_mem_input *dce_mi,
 	enum dc_rotation_angle rotation,
@@ -627,6 +626,27 @@ static void program_grph_pixel_format(
 			GRPH_PRESCALE_B_SIGN, sign);
 }
 
+static void dce_mi_clear_tiling(
+	struct mem_input *mi)
+{
+	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
+
+	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_SW_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_ARRAY_MODE) { /* GFX6 but reuses gfx8 struct */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+}
+
 static void dce_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
@@ -884,7 +904,8 @@ static const struct mem_input_funcs dce_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -897,7 +918,8 @@ static const struct mem_input_funcs dce60_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce60_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 #endif
 
@@ -910,7 +932,8 @@ static const struct mem_input_funcs dce112_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 static const struct mem_input_funcs dce120_mi_funcs = {
@@ -922,7 +945,8 @@ static const struct mem_input_funcs dce120_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 void dce_mem_input_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index a8b44f398ce6..4f5d102455ca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -187,6 +187,8 @@ struct mem_input_funcs {
 			const struct dc_cursor_position *pos,
 			const struct dc_cursor_mi_param *param);
 
+	void (*mem_input_clear_tiling)(
+		struct mem_input *mem_input);
 };
 
 #endif
-- 
2.47.0

