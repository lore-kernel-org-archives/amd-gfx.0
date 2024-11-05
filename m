Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5CFD2B92F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DC410E5B2;
	Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chLExFo0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7E410E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFhBAKauvdvmDRL+e9P4LKsIh0OHZNFx77VeLxG8uIpPODn5IvBcIsP74OxFBlG/clykBQ4IBPPLcrgGhHw6gpzv8HBoSZ5q0Xc+aVijr/D4aE5//qNqGirYUIe8Qi+pkIgcYLGNOXjpS7d2JWSBBavyLkjDEzSfK44AZcKQcz5P/ZTMBCGGnPxCp9D1HgDJ2cbdF9lRoyS+OXkM1qa+qzVNFBReOQ5zwkmxM8zo4cUmlCROpwl1Hg8bb0erQ6zzcjcCvdsxwwHYNGGWZ1HCrl7yAZuKa0LW4n6B9O7T9NRlNNv9AE7Fh3ZQtmAPmMaGvB9Rp7K9plEQoe2G7AJHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s8uyzpbSJ8HnSvSeho+ldHVlzr4Opp+ovXYF5xb1oM=;
 b=mWshRumKYDMi2lQvpETsRndmQcWvdFoedmdLPMai2NMNv+CNtc7o1FrikEXMriBh0p7MBPlIj66jOopExmDpsip2mFezWzWH7kTdgBPVje2BnlEl8Wkyg6aCg6HJ3kXLkTOpXouBY74LGC+UeQuEePxDpsyVyfHdsgwTDEzR0HGAbYp3V/7R58+g35umt04AH2fTTITAxj6MT9+cPPtApVqMm4cXssTTrAS4VPU5lSolWZC2PynwvFoOWtX557iUaTJKVT0cXTYzJC5ZCBzAbIuAXVKg3s0QPxbOpusbjL+m/rwe3xjaQ8WtVz+G/D+mHixtm1yAz8b4agSebyg5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s8uyzpbSJ8HnSvSeho+ldHVlzr4Opp+ovXYF5xb1oM=;
 b=chLExFo0BVUynHa5/SiGWVhsiuYea3F2rFBnQPVQcKGKGfDG/NrFfnc/HOYG3EO9cbgl9tGSurpakDkvxKz4jd0gYG3WZb6DOOYJIzmIDXPtdUwGjGphm3uqgvFqa3dMVi5/BcOtEyXLXZOWvb+ZBVPWWDUgiL4PPzAiJR9iABg=
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 14:06:43 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::a3) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amd/display: add clear_tiling mi callbacks
Date: Tue, 5 Nov 2024 09:06:22 -0500
Message-ID: <20241105140624.2897662-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105140624.2897662-1-alexander.deucher@amd.com>
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c14013c-f0d0-468b-db64-08dcfda31396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HEsDFlA1BSOMgF3qn1PNd/KujWHomtpHtBvOaEzcdVguowQ8orn3+QYVKgSc?=
 =?us-ascii?Q?DfmPN4CugKKT9QOQj9q0hkWUQD+H7kFBrwEJYi8RYC2/qlpze+RKVWzO9wAB?=
 =?us-ascii?Q?FIQMeIme7ALYL3kTukumL/jvZA3wO2AysSAi9qwdemGl7XxsVqvSjK7xLCpV?=
 =?us-ascii?Q?YjIoPseLSbu8V1v99NZ7yGYnE7/D9FBqnC/ZDYPKmADbq4ksp4atc3we5KED?=
 =?us-ascii?Q?n07yl83q7iC+6OtSj+YxAzMS8pHiGID/A8RJRgYWlWof/5JYfSp4RCJD4GP7?=
 =?us-ascii?Q?de8xSyEyx9pqZhuL8pg5obidXlyJo5CG82smR7s++balFkvGvWE6Fn46eB4N?=
 =?us-ascii?Q?VsTar6uCmllrajNGn1hAVQte/mPqjkiHCr6SVOQnmw9hxnhN4O7OBZKgEzJp?=
 =?us-ascii?Q?1RJKCZvYoYZWZLv7jDVvhuxgKHvc1z0+lcd3APWzcksQu8mwA57XZA1WimGx?=
 =?us-ascii?Q?w2xtkZSiGJoZ7LOrqYkmovtb231w4VXAKKt7qKJq0ZRjBBRDhqwOx68aTzab?=
 =?us-ascii?Q?aD/oTtDZZk0++2od7QKyDzEvfgOyY/yfhzsbfjasjBGZTq9XNxnL8m+1MljL?=
 =?us-ascii?Q?d72sO6uMqwddVHP38ep5Q8eNp0Su8v5V53HOl8NaoIHsZj/+pj3L6c9n51nV?=
 =?us-ascii?Q?f68sO5PIbZZ08e3C/cOcVT6rGEs7U1uHMLNmUuth+T83zxZDK1inVaYR5rIZ?=
 =?us-ascii?Q?nDBPzuOKfqGbW/Q2up5oiHC2h6TS774XCn/mbD7KkSjwIg8jbpYn2zeCi6NT?=
 =?us-ascii?Q?lL/EI2tbJY+b+lFDvwoJSfmeqyfGkr6DMFr7uOSKoJR8X9j/0FpZ8Iao9EFs?=
 =?us-ascii?Q?XMGog9joiryR3/OL+iNfvi7Eg/pZdPvtW4aV+FyrUC4s+SaNPq/nmgLnl01x?=
 =?us-ascii?Q?mMwGem/P3UseC5h/xu03S4PFIOxbtCdDWGocHNNc44C4f31LJktMb6DgvVpN?=
 =?us-ascii?Q?Axd1tLhr/o0yZtNepapvcJ7VdM/ZX5qY3ZjyjxO2AX8QARmS0ohDTrao2kXA?=
 =?us-ascii?Q?YAm5keU402sbathilTeDKR1JOIjqnmolIJSWS40nAX4lREyiVfxsA2fEC45k?=
 =?us-ascii?Q?WVx4r0joAWaUvMevm46AjbrRigp4nR9IrAyV/aYpa6EL0S2QjTNU35sfugtX?=
 =?us-ascii?Q?gx5VbRBdUIjN6fyS2SqA+Js+qs3cQJfWWlXvdDDf4QrGby93anYn0x6onAtO?=
 =?us-ascii?Q?h/S1EdJF/jXzYIkt2jgA1ArefMsQ06N9JqJsNNu+kTXCvCrr/AKlXlBENgEO?=
 =?us-ascii?Q?PPJixHeZPMuMrI22PPm/TgeReZ5k22MF/g+QJg+Ik7oChq6YS0fBuaYFoW2c?=
 =?us-ascii?Q?5f+681YbGLnPhyENtr4bLZStTIGhGqJQSxtuWJZg9Zo053YZC0r4qyiCBirW?=
 =?us-ascii?Q?DEcwGGBDbLf27HJspWcfbS2iTH6CUcJNOL+A+moQHirWlnLxzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:42.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14013c-f0d0-468b-db64-08dcfda31396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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

