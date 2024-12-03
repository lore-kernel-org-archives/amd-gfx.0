Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C871E74ADE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A3610EB6C;
	Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFiH+eqT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0914C10EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txte2KqnnqaGZYPJxbvAgum3pjM7XRVxO+sLCjEe890IbSBay0QWTlw+cH9+PRgW6TUzMncZ0jYWXbEEUWqvjhMPrmbhoMXmtj9szscFKHa0bRjHz/63uggopijjJaemigQj5hJFV64mZ5fHkjCI8lycqBLnHdzQ8qGH94zA/ygwuZyvLRMTLWCDy89Gvvlw7o29+Hot8Kh9UrQGrpJBK3jg1XEkM0FVwvhB3cdvtn+xOO1+3jxHHXSF0Ltn4DX47FQGYG9CjtoScOYIuIGpiNAuFxVo2jNr2SYcN3p5bNwT2CWKkXdk5k6CsxttETTC2J7iICX+DmpMjhDB0+N+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYJXk6pOeQf3s2ECnui/+PoqiYsSN9/EDZQRgTq/ApU=;
 b=JPwM/adf9XqybCMtPBzwZGZYPuofD2wwXR+pJQb+r1l5kpvB6EoAaU5E1diDK7gtphzOw3mIzVgLL63jd6R8w+tRCm5IOhwidKND+Qsl9twh4hBPPU6qPxDX2pkFO/giU+bFQ6FvIQ/lcSp1fcocAlATEc1JdHxLFr9Gzzp10PTMXVcn+fS4Sty/dWrtrZWq1VjFBoyPRM61FK6igd2tEZiKRCy7sZXe4nKl28ihLid6KOP+7JGqmJud1XA2FZnDAev7VP3FDxIKGcp2Z4EZtepINC336b6TW3FJUJlp430n7NgDVLN+HQbreSS9r8Hj/s7LNJtFqM0w6XWzW6IA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYJXk6pOeQf3s2ECnui/+PoqiYsSN9/EDZQRgTq/ApU=;
 b=TFiH+eqT0u0cdR/IEzy9tXDF94/+AtEc6dWoOvM7oYHTzxxyVYMRJ9FdM4ZL/qngWlB73iic4sJQjOtYCn7oXTJamrOp8ZUwoPTAmu7GDKfqhdJYSWauKeiaXAzZzUVJDDT3zQzWfOO2YxDsk8jcdYNCW/5nM8FSWo3sHtJYQ18=
Received: from BN9PR03CA0342.namprd03.prod.outlook.com (2603:10b6:408:f6::17)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 21:41:44 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::4c) by BN9PR03CA0342.outlook.office365.com
 (2603:10b6:408:f6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 21:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:43 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:42 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ausef Yousof
 <Ausef.Yousof@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/19] drm/amd/display: Overwriting dualDPP UBF values before
 usage
Date: Tue, 3 Dec 2024 16:39:48 -0500
Message-ID: <20241203214120.1161810-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c47714-7ed5-4efd-7c12-08dd13e3481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iggAlPQp4g5c9ga1gpADceFq7EjKw8jKZLNRwkpB6uW3G7HDagbcHscp7evO?=
 =?us-ascii?Q?qzSl0cmmHtmekZgAFBYsTP007g4FMcrs9LX7XmOnD6c4qjcianjREIZKRyIH?=
 =?us-ascii?Q?1KXQn4WK2B/U18WulpiZlB82i2ULvGZB1XhxpTKAHaEM0Ybm678aEaw+13M/?=
 =?us-ascii?Q?gl0UqKDIO2t+gVCYWqgas6fR8I/rjiIz1z1y/XqG+o4Pi6Oa19S3LWejZewh?=
 =?us-ascii?Q?RzrL3IbU8FOUxipd0Fcork+lIvL0bdnomXXQW2w8a4ifsLEMbOmmjtUmQ8h9?=
 =?us-ascii?Q?6GMspSgTt8kTtNKci5QsTglD/v9Fb/+22Rdou8QajGwCYvhTUfcd7qwG9B92?=
 =?us-ascii?Q?ipheswc06GqOHKGLCpAyIIi+Bhs6iyTfrQf0U9PLDhaDsaxfZMX8XELu8s3e?=
 =?us-ascii?Q?wJ0exVQZPVVzz6L86ZHNzqV9dcCGv3vJ+HPMZcRXdopekRYiz45cinTZtVfl?=
 =?us-ascii?Q?BTVp9s95xYV1z6SJibYAmb10G9yxEVIffp7Fy0UN7BXTRump0Fe2MdtX8EhM?=
 =?us-ascii?Q?9TYQpkpkqb8g9FpEGx9BTBvrW9zS8e/D3kw5wgWNhasAGcwzAg3rlN65rCE9?=
 =?us-ascii?Q?juGe2eL2y+reWSvQEvkJxDDA/L94HqjmMptRfbpLQaWeEZI0m/sJnZkKK/uI?=
 =?us-ascii?Q?vdRQtDA9PgH7tAOEd/tCmrw0VgG5LQjXh27e9hvQaBdeH5D7BWc7o1D3qeyD?=
 =?us-ascii?Q?i+DQHqZ81pdVxLJBJyLv2miDALyHBC1d+2DJy9lIQ5tFOYV5fja7zwSN4P60?=
 =?us-ascii?Q?9XEEUG0sexwzWZxqq1WmtwUbd4fcMp5PQDCTyW+i9yhS+39ETkkadWdUIpH3?=
 =?us-ascii?Q?jujY3arRk2zHR1OU+FadDHbAC6iaf+nnotGy1sMIFXrRKarMq3w7Sxf1elT6?=
 =?us-ascii?Q?GzviO6X/CgICY2zTUaA6hMKhDEN/JZn6OR84IsYWDhchn4ijRXyC+VjuI39N?=
 =?us-ascii?Q?rGmATB2+/E8QlLru8K7afhQOgnTJAaGzAyCm1wNWU6SUDgHMFQ9TxdDKH27x?=
 =?us-ascii?Q?7b4n8wOlLr3tK13wFXCALrqcbOmCxU3KKKLJ2D5nY+IGvKOa1I28q99xtcWo?=
 =?us-ascii?Q?OIkKwwknymbLBj2FY9SocpXUTDte7u5fKPtzHVKSEOt7H/GgZkzBZ25EMlJa?=
 =?us-ascii?Q?COCpWXPTnIYMWUH5j5yQmk4LyST02tEcuu8uH/FmkYFNUvyqvWfLTLtjMalB?=
 =?us-ascii?Q?ADUDqZ/ALzJFMxSTNudc/vc7owNE35wmMBZF4SUcdNqauJHF52wWeGwlPsA3?=
 =?us-ascii?Q?Xtefnxxzaq+0sbIETk0l8mjsXEgHdxNk1fGVRLdWzFSkcD8wfvY/vkoa3rWE?=
 =?us-ascii?Q?h3lM6UttNZQ7Jx+v/+2Eqwu14M3UtLa1o0BnNf+B6R5vYMQCH2trYf/arGb2?=
 =?us-ascii?Q?HRt6KDKOGOl2vTFCgDERrcJiTo9/a/jsq/4HoVC0Ign3I5cBmdDZLAWpKckb?=
 =?us-ascii?Q?5AIqR13zQG6I5IAFlf8Id1gSW64fmVLL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:44.4052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c47714-7ed5-4efd-7c12-08dd13e3481a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[WHY]
Right now in dml2 mode validation we are calculating UBF parameters for
prefetch calculation for single and dual DPP scenarios. Data structure
to store such values are just 1D arrays, the single DPP values are
overwritten by the dualDPP values, and we end up using dualDPP for
prefetch calculations twice (once in place of singleDPP support check
and again for dual).

This naturally leads to many problems, one of which validating a mode in
"singleDPP" (when we used dual DPP parameters) and sending the singleDPP
parameters to mode programming, if we cannot support then we observe the
corruption as described in the ticket.

[HOW]
UBF values need to have 2d arrays to store values specific to single and
dual DPP states to avoid single DPP values being overwritten. Other
parameters are recorded on a per state basis such as prefetch UBF values
but they are in the same loop used for calculation and at that point its
fine to overwrite them, its not the case for plain UBF values.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 30 +++++++++----------
 .../dc/dml2/display_mode_core_structs.h       |  6 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index be87dc0f0779..6822b0795120 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6301,9 +6301,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 			mode_lib->ms.meta_row_bandwidth_this_state,
 			mode_lib->ms.dpte_row_bandwidth_this_state,
 			mode_lib->ms.NoOfDPPThisState,
-			mode_lib->ms.UrgentBurstFactorLuma,
-			mode_lib->ms.UrgentBurstFactorChroma,
-			mode_lib->ms.UrgentBurstFactorCursor);
+			mode_lib->ms.UrgentBurstFactorLuma[j],
+			mode_lib->ms.UrgentBurstFactorChroma[j],
+			mode_lib->ms.UrgentBurstFactorCursor[j]);
 
 		s->VMDataOnlyReturnBWPerState = dml_get_return_bw_mbps_vm_only(
 																	&mode_lib->ms.soc,
@@ -6458,9 +6458,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.cursor_bw_pre,
 				mode_lib->ms.prefetch_vmrow_bw,
 				mode_lib->ms.NoOfDPPThisState,
-				mode_lib->ms.UrgentBurstFactorLuma,
-				mode_lib->ms.UrgentBurstFactorChroma,
-				mode_lib->ms.UrgentBurstFactorCursor,
+				mode_lib->ms.UrgentBurstFactorLuma[j],
+				mode_lib->ms.UrgentBurstFactorChroma[j],
+				mode_lib->ms.UrgentBurstFactorCursor[j],
 				mode_lib->ms.UrgentBurstFactorLumaPre,
 				mode_lib->ms.UrgentBurstFactorChromaPre,
 				mode_lib->ms.UrgentBurstFactorCursorPre,
@@ -6517,9 +6517,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.cursor_bw,
 						mode_lib->ms.cursor_bw_pre,
 						mode_lib->ms.NoOfDPPThisState,
-						mode_lib->ms.UrgentBurstFactorLuma,
-						mode_lib->ms.UrgentBurstFactorChroma,
-						mode_lib->ms.UrgentBurstFactorCursor,
+						mode_lib->ms.UrgentBurstFactorLuma[j],
+						mode_lib->ms.UrgentBurstFactorChroma[j],
+						mode_lib->ms.UrgentBurstFactorCursor[j],
 						mode_lib->ms.UrgentBurstFactorLumaPre,
 						mode_lib->ms.UrgentBurstFactorChromaPre,
 						mode_lib->ms.UrgentBurstFactorCursorPre);
@@ -6586,9 +6586,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 													mode_lib->ms.cursor_bw_pre,
 													mode_lib->ms.prefetch_vmrow_bw,
 													mode_lib->ms.NoOfDPP[j], // VBA_ERROR DPPPerSurface is not assigned at this point, should use NoOfDpp here
-													mode_lib->ms.UrgentBurstFactorLuma,
-													mode_lib->ms.UrgentBurstFactorChroma,
-													mode_lib->ms.UrgentBurstFactorCursor,
+													mode_lib->ms.UrgentBurstFactorLuma[j],
+													mode_lib->ms.UrgentBurstFactorChroma[j],
+													mode_lib->ms.UrgentBurstFactorCursor[j],
 													mode_lib->ms.UrgentBurstFactorLumaPre,
 													mode_lib->ms.UrgentBurstFactorChromaPre,
 													mode_lib->ms.UrgentBurstFactorCursorPre,
@@ -7809,9 +7809,9 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.DETBufferSizeYThisState[k],
 				mode_lib->ms.DETBufferSizeCThisState[k],
 				/* Output */
-				&mode_lib->ms.UrgentBurstFactorCursor[k],
-				&mode_lib->ms.UrgentBurstFactorLuma[k],
-				&mode_lib->ms.UrgentBurstFactorChroma[k],
+				&mode_lib->ms.UrgentBurstFactorCursor[j][k],
+				&mode_lib->ms.UrgentBurstFactorLuma[j][k],
+				&mode_lib->ms.UrgentBurstFactorChroma[j][k],
 				&mode_lib->ms.NotUrgentLatencyHiding[k]);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index f951936bb579..504c427b3b31 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -884,11 +884,11 @@ struct mode_support_st {
 	dml_uint_t meta_row_height[__DML_NUM_PLANES__];
 	dml_uint_t meta_row_height_chroma[__DML_NUM_PLANES__];
 	dml_float_t UrgLatency;
-	dml_float_t UrgentBurstFactorCursor[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorCursor[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorCursorPre[__DML_NUM_PLANES__];
-	dml_float_t UrgentBurstFactorLuma[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorLuma[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorLumaPre[__DML_NUM_PLANES__];
-	dml_float_t UrgentBurstFactorChroma[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorChroma[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorChromaPre[__DML_NUM_PLANES__];
 	dml_float_t MaximumSwathWidthInLineBufferLuma;
 	dml_float_t MaximumSwathWidthInLineBufferChroma;
-- 
2.47.1

