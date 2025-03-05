Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD3CC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCF610E6E8;
	Wed,  5 Mar 2025 05:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZVO2aJdV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AD910E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEZ2nSt/gxiPkzRIyxEknG5PAT6f8+ljtucOYqZN3l+wIv2ubZ1X9v0Ui4TKp3Gyc54q9Yz1+pvhQ9oc7zSeZoJqgfoCUQiQ5NhCsxgXMWxKq887yGTvk0OW5hbRfBxGyeRorTBxB96jrbLPj/H6GJSc6seToBseu/glFv8QOPszjVEpxQfS0vugcard/OV7sV+0JtuCIbj124WMTDE+aycEsNALpBtqjeIY92S/L0KKRpcA/e9DdSICbm9DFyEnIWhn6sV7Q9Tv7RRLXxV/D+h39XkBwXSdhmQK+RCZlrcSAji2dCv4dw7+yalrkGTEw3NUnkNcANBOpZkbSaSJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/ZSa+LSDR6l4nmHwWwt3aiG8kaPqaBdUKXa83tQvdM=;
 b=vmd8XCZrw/223/rkhNEK9obOHnhSVgMZBD680vFeTO6stX6RvSTnCF978oe899MAYcaaseE3n6vd7ZdZJqY9332BHiTZJld3pj9fK9DuDL6LbPP+5EjgtTsRRaEf0ap/TrQT6dkUZKRv1VlALD9x4MAxEaEUQ3h1VtNGj0n8VtjEViCA/2yRzhEg9ln8idciCx5a76BYDcNGZ3rcLyH6J5SI+fOwP+WSwK53JjvcXxUElN2yhpJV5lxOwGXBE4RmpdjTcCQDxwwQ5EN3Fk4hk1NF9mh+/C6RTtHtU4YxEAc7I9oJfKUvfPR50OrJqgHQYkXgEQuMuQvmPtz0N6QdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/ZSa+LSDR6l4nmHwWwt3aiG8kaPqaBdUKXa83tQvdM=;
 b=ZVO2aJdVaiuHHJSo/WixPKW+kDjSHYCpOxqDq6+xotR6wSBEi80ialYv67TB46j9Nx8zy4sJvlp8jbtwlf1g2signfppQFA/GJHu46Ozm0q4+sz9EXBxGaTmvgnA8X46sQ78NrxomHGLelfzIX+N16JMBvEipcQtXRTwLA82MvM=
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Wed, 5 Mar 2025 05:16:21 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::69) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:20 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:16 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zhikai Zhai <zhikai.zhai@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 15/22] drm/amd/display: calculate the remain segments for all
 pipes
Date: Wed, 5 Mar 2025 13:13:55 +0800
Message-ID: <20250305051402.1550046-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 5082f711-f0c3-46b1-7e7e-08dd5ba4ddb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uDek9x2v7blms3Jm/HmHgELACrtmvdXWT5T8bWum4+ZhxuA9IxL8Mpg7t6GE?=
 =?us-ascii?Q?EJQf8sxMTOysmtTtzrDBN/7DX0ovJO3qYoMuTcUFel9pP10D0U0tIJtFHACt?=
 =?us-ascii?Q?aHqEITcxVabQrrrD+lcrU6QTr2huyB+qhcMdOK9VOzay/6mfr6wAG4YQj03X?=
 =?us-ascii?Q?InnSfhjxOq54yiODoAZmS6DvHhaP/t4Hh8Vd5kgfYqE5VthST+e9bteFSq1c?=
 =?us-ascii?Q?F/cSDwpBDgQb48hGecHySbzPaFFEsF5Pywe7dP0OowUjKqxqxlWa6pb4D4s/?=
 =?us-ascii?Q?4RwJlhTuKVQXcyuKpJ7XvJsiyd5Ww/7UPGTSIxo9bHmyQsjE/TF1T7UvjOLn?=
 =?us-ascii?Q?NgXYh/rvKMl+rmjH5aPpfT0oycEqgI9XwTd+V0Hm5neE8ZMm5UUw4lIhCWa8?=
 =?us-ascii?Q?hOEN9Ib2LZvTRELMbsxYPSVRITNALqqk4X0+KAS4qCCJL4iAbjkvBCuK8Ewc?=
 =?us-ascii?Q?f0t0P3+5S2kvE7ZgGljKzIStMBYROhVZQBRMTSw9gSs4TXeJPJS7I4/LqSQj?=
 =?us-ascii?Q?dTNuxOCA80ECqbTOaWr5wgv7UC9m4h9jt8ms887MMCwLbF9YcOX0NjP1DuQo?=
 =?us-ascii?Q?xextGBsKNHDs7MMcNGaVL1ktumEtm0el9HWQzsUnz/08REN1MZQGJrCxUpqf?=
 =?us-ascii?Q?4sgc8g0BuSaPnd0xpJq+B4g4mvRMzM8jtvFssnn5I879gAIY8UP5DZKQ9k+r?=
 =?us-ascii?Q?u2ZURGEF+oXQRD7ZILamrjrWQKw8mb+XKZSIk0mYR2T8MgHppj8wXkWBDzyQ?=
 =?us-ascii?Q?KEzbdgfr4vibCryAZOjM8qpL15Xu5V24OE7/gZdq65nHAagF0vCahmvmCypN?=
 =?us-ascii?Q?VOORo2g5qv+oA9OJbv89GgTZq0Yyduq+TM/Tl0met+3/hAncP7f5urdsgW4q?=
 =?us-ascii?Q?2Mq0TtHvFi0k9jrPB07PSGwrMXUF3PWC09lvhxpaHY/yo1wcBAszRH6r3fhH?=
 =?us-ascii?Q?CWzgI5zW3p76V6yKwhayC9I6O9u5xoTD9VL6M+H/dQDkSfwB522dysGPQcGE?=
 =?us-ascii?Q?FqeAQGwyKWnKzBGmskj69DPWFnYPXKhmgowlWq5xU5Fq0k0mfbBe4CPcheC3?=
 =?us-ascii?Q?iJkyu0j3AoPDyKeJdbhkqg+mjYiqxTGHMmijS7mcoD2c7gsis1Nv/2rus2zW?=
 =?us-ascii?Q?4v7Sb4F/GYHLaDE928HShwtqWBReuMODAwiLWhoyzh3SLL9/xXToasOCnRcf?=
 =?us-ascii?Q?+4rS1UNUFisrQH7h8U7Iom2irIa9bInqD16KDR1Nr5May6BaV3iMlBg3Ult3?=
 =?us-ascii?Q?p5c8yjdGj3oH6nS9BrqL+S5j5XHuL7fwtYw9tyc2xkuuAH7b58O1rn6SkoZs?=
 =?us-ascii?Q?6P8qzzcXE2lklAOTahEkoMcyiJRoFnTgSSek7G7z7Yb3SKOy3Fbdco3WnCiS?=
 =?us-ascii?Q?f54peoPmt7T4FYcMQMCz3y2zvYsQdVnQ3K86315bT/8soFy6kVKve8/IO4mh?=
 =?us-ascii?Q?/4LyevpLJJw2c8ydjqBcjISA9AymGKuYO4hEUUhbRm14guurBaZ/Cs3BDrmM?=
 =?us-ascii?Q?zEWd4UCJNvX+/zE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:20.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5082f711-f0c3-46b1-7e7e-08dd5ba4ddb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
In some cases the remain de-tile buffer segments will be greater
than zero if we don't add the non-top pipe to calculate, at
this time the override de-tile buffer size will be valid and used.
But it makes the de-tile buffer segments used finally for all of pipes
exceed the maximum.

[HOW]
Add the non-top pipe to calculate the remain de-tile buffer segments.
Don't set override size to use the average according to pipe count
if the value exceed the maximum.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/resource/dcn315/dcn315_resource.c      | 42 +++++++++----------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 14acef036b5a..6c2bb3f63be1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1698,7 +1698,7 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
-		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+		if (pixel_rate_crb) {
 			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
 			/* Ceil to crb segment size */
 			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
@@ -1755,28 +1755,26 @@ static int dcn315_populate_dml_pipes_from_context(
 				continue;
 			}
 
-			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
-				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
-						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
-
-				if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
-					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
-							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
-				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
-					/* Clamp to 2 pipe split max det segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
-					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
-				}
-				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
-					/* If we are splitting we must have an even number of segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
-					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
-				}
-				/* Convert segments into size for DML use */
-				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
-
-				crb_idx++;
+			bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+					|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+			if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
+				pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+						(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+			if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+				/* Clamp to 2 pipe split max det segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+				pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+			}
+			if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+				/* If we are splitting we must have an even number of segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
 			}
+			/* Convert segments into size for DML use */
+			pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
+			crb_idx++;
 			pipe_cnt++;
 		}
 	}
-- 
2.34.1

