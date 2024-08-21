Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1F8C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDC510E6FF;
	Wed, 21 Aug 2024 22:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8ifmR6x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF3B10E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH1xH9hV954a/HJiKahtYcfCeGMST/MZ2/m8BmGH5W7zXnefTUfZxsUmCZlIQcGJ0mU1u62tVjHoljOMp+zM5L79UwNuwJ/DA9XLE8pFbB01kQvw7qgEsF7rU5rApsUCefijj1CVN0rXGkvav4Ki7GQNiPhwK4saRq7lPv3DfDpZwPCKy4dmBaW96fvHIUT24XujI9cXnKYjkad0gB/4CVh9N9ayx/MvQKZpY2Ydsvm4g9m16H7O2ZcEfn6m6IHa7RKLIeR5/Z0KCrRDK6SLkSvjf7Tkd2FpxiqT3eFvUw4+GWv1IgRbxfJll67G9gPY6vDo2K9en1Vm0spb98R/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BkiuVhwb3dSCE+mo26ISux9BWXsjsUkivXZmZRLa+g=;
 b=jz3duMSmmvUgwGKtVpc3mHEqCsTPEyHMstpw/d5F/QdJP49X0lUrONNAjjwPsZZ4Xcf93rnVv/NBbtdmaD4zm1cByWJG1XXHndvsNUetf0tY+RGiIBa9svHSLh2FHzUrSqz9hKr6mSYE23HBWzsr5nRnYxKpQla1yNN4eEVLqJpQ/Is/U//A58/3809Pehj9eYAA4qelI3FW1/e56nfbnTDccS4n25Lgwef3tOkf1SnrRnrUTR505iKMj9euSNTRxEHz0RKPxro8Rt2TdXu7w26yw7iFUNx1PoLaW5mekto9epPTRvw6BzsEPwLbWw60z9R+m2onUvLhS1w+jE6ogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BkiuVhwb3dSCE+mo26ISux9BWXsjsUkivXZmZRLa+g=;
 b=J8ifmR6xIibdkWxqEq3aU4F8pbrcXvPWPkD3Y0JkwcXMDI3cQlEC8VsyNXRSbtd5nihyVxPNLkTiLV/nCGcFaOy4/VCYr4EhaZ/uXf1OoNFAm9r2N+NZykddBbO/1EHffgESIUcBjMkDycKJCyxjGG1H6ACgmjHsLQvEiG0e0kg=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:37 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::ac) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:37 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:35 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Fix MS/MP mismatches in dml21 for
 dcn401
Date: Wed, 21 Aug 2024 18:01:46 -0400
Message-ID: <20240821220156.1498549-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aeb239-b30a-471b-cf23-08dcc22d3fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R1RfJDgrd8e2SmHJo3/s2JsBcxMtYoOlrdPsOXTsCst+s3pMZmnvyntYQ2KN?=
 =?us-ascii?Q?pB7+m4rKcv2L/0u12V1a1zv+viHyYNO7EIw1quRs7WGRHJZgis8LorxEgQ4K?=
 =?us-ascii?Q?MmpXjI0Pnnf6tGmuQoRTl5rkLOCZd8Xkz1HOFChviTTg9get6HpkXrzJnWBG?=
 =?us-ascii?Q?kL8jBPHIyxTJMeS7YKpyyM59wQ3W8gL49A8Mv5fke7CTE2nuXOyaoDLjA+Tc?=
 =?us-ascii?Q?R9qKSXBPCWqp1EFc7t0Xb2Yf3bCqxiwr2hEIXA0OZxSD98OrPda6BwyNpidn?=
 =?us-ascii?Q?wYxRE/6YOo5SthF2gyyLr7Et46C32WWTxWT99DBMyWArjm7CHhX0Z4WDhxnJ?=
 =?us-ascii?Q?58NxKqzM+Ic0vsGorKcAKaHs8Rqr6EEYfHDC2v579DaoMfilq+coYsFgng98?=
 =?us-ascii?Q?NRpDVFSelS0hG5drC6WaZ2hgeG1KpUpoCjbhfBKFkNSC4faIhflVCy4m0lz0?=
 =?us-ascii?Q?xMMivy3948+PrHDkyukdmKni2/6GgmYV3jW/8cG1Zu1TTxRmGnJQrzch+ODq?=
 =?us-ascii?Q?HH88x7KnFSvnCww88LAYzNh2rTWjENsnvN9iBfIPvZDsGUTjAMhR8WroZJgm?=
 =?us-ascii?Q?9bIhA052bPMXc+d2XFGEqdsZXfYUyY8TL3MWZhumOhb6eCq33oCT8oNG+ppi?=
 =?us-ascii?Q?nuDvku3OUv0mDRf9E5DL4RjlDd6lRME5NKNG/S2RMRcDrxgZqmdTD6E3tdpV?=
 =?us-ascii?Q?76AcsOrX1FwbI8tWNLCOdwFDa6ONJ6bSDeh6hy/opJVXSlewdsBK9GxFciO4?=
 =?us-ascii?Q?/apKhQeXo1ZnGKMWXJ8gtXe5gFM7icXi+u8yYtjGeM1OB+k2xeyG7HcUKDXo?=
 =?us-ascii?Q?GU8e7d9HhVZr7rqwXEORP4dLx6AHwmcdI+8k3LaE4CyFeig0W5z9RKr0r7iL?=
 =?us-ascii?Q?oRf8oWU33gKcqrg9T6JPPcJXkiKf8UWMTK1Z3WhgeAYRmFgey5gogF3pil2r?=
 =?us-ascii?Q?C4vICxwGHIUnhmnImoJJhD/cWRbalWE5W2S/JSnPdpWJsGINxFWjqbpL+3yJ?=
 =?us-ascii?Q?9oWZ5Ge7BTgjfSmsAot5751PIbp1G+QXA8+c8u8uX0tu2g/s0HGZejoLnTb9?=
 =?us-ascii?Q?+kpDqcFlIix8z5PWn2l16bQl722IRMKgW7ThxSI5XbsdR637Bsu5kHKZAN5X?=
 =?us-ascii?Q?d0aYTjVPkhsuKuuyhyzu9mAeGfO6UE/MnwH6/Bde/uTW544ES2VWe1DxW8jO?=
 =?us-ascii?Q?nqFQbHB9AB4RorthZVLRJX8MeNa8qiD0Ho9mQPbbogfrWjbD/bz+YjIbQqPa?=
 =?us-ascii?Q?fH2TVSHXjYN+6r6SC5WLawmtCto/sb4lf4x/gvJSrIys4OG8U0eHb7KVBEwh?=
 =?us-ascii?Q?1oQMXuHBln1rDVFifyyYYTiD48y7SveghUz0Or0sgKow0o2mE41122TktWPG?=
 =?us-ascii?Q?r2ez8vQzwiXzOmhPVgdGRLwJzKF/WUeG6N/u0HF5E7R+WhI91YRDBTr8+9Op?=
 =?us-ascii?Q?9zDYHNVpeOoX78FUr+ridnJ0lul2oZda?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:37.6749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aeb239-b30a-471b-cf23-08dcc22d3fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
Prefetch calculations did not guarantee that bandwidth required in
mode support was less than mode programming which can cause failures.

[HOW]
Fix bandwidth calculations to assume fixed times for OTO schedule,
and choose which schedule to use based on time to fetch pixel data.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 47 ++++++++++++-------
 .../src/dml2_core/dml2_core_shared_types.h    |  5 ++
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index e2c45e498664..b158b2781239 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5056,6 +5056,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 	s->trip_to_mem = 0.0;
 	*p->Tvm_trips = 0.0;
 	*p->Tr0_trips = 0.0;
+	s->Tvm_no_trip_oto = 0.0;
+	s->Tr0_no_trip_oto = 0.0;
 	s->Tvm_trips_rounded = 0.0;
 	s->Tr0_trips_rounded = 0.0;
 	s->max_Tsw = 0.0;
@@ -5293,31 +5295,38 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 	s->Lsw_oto = math_ceil2(4.0 * math_max2(s->prefetch_sw_bytes / s->prefetch_bw_oto / s->LineTime, s->min_Lsw_oto), 1.0) / 4.0;
 
 	if (p->display_cfg->gpuvm_enable == true) {
-		s->Tvm_oto = math_max3(
-			*p->Tvm_trips,
+		s->Tvm_no_trip_oto = math_max2(
 			*p->Tno_bw + vm_bytes * p->HostVMInefficiencyFactor / s->prefetch_bw_oto,
 			s->LineTime / 4.0);
+		s->Tvm_oto = math_max2(
+			*p->Tvm_trips,
+			s->Tvm_no_trip_oto);
 #ifdef __DML_VBA_DEBUG__
 		dml2_printf("DML::%s: Tvm_oto max0 = %f\n", __func__, *p->Tvm_trips);
 		dml2_printf("DML::%s: Tvm_oto max1 = %f\n", __func__, *p->Tno_bw + vm_bytes * p->HostVMInefficiencyFactor / s->prefetch_bw_oto);
 		dml2_printf("DML::%s: Tvm_oto max2 = %f\n", __func__, s->LineTime / 4.0);
 #endif
 	} else {
+		s->Tvm_no_trip_oto = s->Tvm_trips_rounded;
 		s->Tvm_oto = s->Tvm_trips_rounded;
 	}
 
 	if ((p->display_cfg->gpuvm_enable == true || p->setup_for_tdlut || dcc_mrq_enable)) {
-		s->Tr0_oto = math_max3(
-			*p->Tr0_trips,
+		s->Tr0_no_trip_oto = math_max2(
 			(p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) / s->prefetch_bw_oto,
 			s->LineTime / 4.0);
+		s->Tr0_oto = math_max2(
+			*p->Tr0_trips,
+			s->Tr0_no_trip_oto);
 #ifdef __DML_VBA_DEBUG__
 		dml2_printf("DML::%s: Tr0_oto max0 = %f\n", __func__, *p->Tr0_trips);
 		dml2_printf("DML::%s: Tr0_oto max1 = %f\n", __func__, (p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) / s->prefetch_bw_oto);
 		dml2_printf("DML::%s: Tr0_oto max2 = %f\n", __func__, s->LineTime / 4);
 #endif
-	} else
-		s->Tr0_oto = (s->LineTime - s->Tvm_oto) / 4.0;
+	} else {
+		s->Tr0_no_trip_oto = (s->LineTime - s->Tvm_oto) / 4.0;
+		s->Tr0_oto = s->Tr0_no_trip_oto;
+	}
 
 	s->Tvm_oto_lines = math_ceil2(4.0 * s->Tvm_oto / s->LineTime, 1) / 4.0;
 	s->Tr0_oto_lines = math_ceil2(4.0 * s->Tr0_oto / s->LineTime, 1) / 4.0;
@@ -5595,6 +5604,9 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML::%s: Tvm_equ = %f\n", __func__, s->Tvm_equ);
 		dml2_printf("DML::%s: Tr0_equ = %f\n", __func__, s->Tr0_equ);
 #endif
+		// Lsw = dst_y_prefetch - (dst_y_per_vm_vblank + 2*dst_y_per_row_vblank)
+		s->Lsw_equ = s->dst_y_prefetch_equ - math_ceil2(4.0 * (s->Tvm_equ + 2 * s->Tr0_equ) / s->LineTime, 1.0) / 4.0;
+
 		// Use the more stressful prefetch schedule
 		if (s->dst_y_prefetch_oto < s->dst_y_prefetch_equ) {
 			*p->dst_y_prefetch = s->dst_y_prefetch_oto;
@@ -5603,25 +5615,28 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 
 			*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
 			*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+			s->dst_y_per_vm_no_trip_vblank = math_ceil2(4.0 * s->Tvm_no_trip_oto / s->LineTime, 1.0) / 4.0;
+			s->dst_y_per_row_no_trip_vblank = math_ceil2(4.0 * s->Tr0_no_trip_oto / s->LineTime, 1.0) / 4.0;
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: Using oto scheduling for prefetch\n", __func__);
 #endif
-
 		} else {
 			*p->dst_y_prefetch = s->dst_y_prefetch_equ;
 			s->TimeForFetchingVM = s->Tvm_equ;
 			s->TimeForFetchingRowInVBlank = s->Tr0_equ;
 
-		*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
-		*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+			s->dst_y_per_vm_no_trip_vblank = *p->dst_y_per_vm_vblank;
+			s->dst_y_per_row_no_trip_vblank = *p->dst_y_per_row_vblank;
 
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: Using equ bw scheduling for prefetch\n", __func__);
 #endif
 		}
 
-		// Lsw = dst_y_prefetch - (dst_y_per_vm_vblank + 2*dst_y_per_row_vblank)
-		s->LinesToRequestPrefetchPixelData = *p->dst_y_prefetch - *p->dst_y_per_vm_vblank - 2 * *p->dst_y_per_row_vblank; // Lsw
+		/* take worst case Lsw to calculate bandwidth requirement regardless of schedule */
+		s->LinesToRequestPrefetchPixelData = math_min2(s->Lsw_equ, s->Lsw_oto); // Lsw
 
 		s->cursor_prefetch_bytes = (unsigned int)math_max2(p->cursor_bytes_per_chunk, 4 * p->cursor_bytes_per_line);
 		*p->prefetch_cursor_bw = p->num_cursors * s->cursor_prefetch_bytes / (s->LinesToRequestPrefetchPixelData * s->LineTime);
@@ -5741,13 +5756,13 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 
 		if (vm_bytes == 0) {
 			prefetch_vm_bw = 0;
-		} else if (*p->dst_y_per_vm_vblank > 0) {
+		} else if (s->dst_y_per_vm_no_trip_vblank > 0) {
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: HostVMInefficiencyFactor = %f\n", __func__, p->HostVMInefficiencyFactor);
 			dml2_printf("DML::%s: dst_y_per_vm_vblank = %f\n", __func__, *p->dst_y_per_vm_vblank);
 			dml2_printf("DML::%s: LineTime = %f\n", __func__, s->LineTime);
 #endif
-			prefetch_vm_bw = vm_bytes * p->HostVMInefficiencyFactor / (*p->dst_y_per_vm_vblank * s->LineTime);
+			prefetch_vm_bw = vm_bytes * p->HostVMInefficiencyFactor / (s->dst_y_per_vm_no_trip_vblank * s->LineTime);
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: prefetch_vm_bw = %f\n", __func__, prefetch_vm_bw);
 #endif
@@ -5759,8 +5774,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 
 		if (p->PixelPTEBytesPerRow == 0 && tdlut_row_bytes == 0) {
 			prefetch_row_bw = 0;
-		} else if (*p->dst_y_per_row_vblank > 0) {
-			prefetch_row_bw = (p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + tdlut_row_bytes) / (*p->dst_y_per_row_vblank * s->LineTime);
+		} else if (s->dst_y_per_row_no_trip_vblank > 0) {
+			prefetch_row_bw = (p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + tdlut_row_bytes) / (s->dst_y_per_row_no_trip_vblank * s->LineTime);
 
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: PixelPTEBytesPerRow = %u\n", __func__, p->PixelPTEBytesPerRow);
@@ -10738,7 +10753,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 				mode_lib->mp.UrgentLatency,
 				mode_lib->mp.TripToMemory,
 				!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k]) && display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.drr_config.enabled ?
-				get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->ms.uclk_freq_mhz * 1000), in_out_params->min_clk_index) : 0.0);
+				get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->mp.uclk_freq_mhz * 1000), in_out_params->min_clk_index) : 0.0);
 
 			myPipe->Dppclk = mode_lib->mp.Dppclk[k];
 			myPipe->Dispclk = mode_lib->mp.Dispclk;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 13961c2eb634..cbdfbd5a0bde 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1187,11 +1187,15 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_locals {
 	double prefetch_bw_oto;
 	double Tvm_oto;
 	double Tr0_oto;
+	double Tvm_no_trip_oto;
+	double Tr0_no_trip_oto;
 	double Tvm_oto_lines;
 	double Tr0_oto_lines;
 	double dst_y_prefetch_oto;
 	double TimeForFetchingVM;
 	double TimeForFetchingRowInVBlank;
+	double dst_y_per_vm_no_trip_vblank;
+	double dst_y_per_row_no_trip_vblank;
 	double LinesToRequestPrefetchPixelData;
 	unsigned int HostVMDynamicLevelsTrips;
 	double trip_to_mem;
@@ -1199,6 +1203,7 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_locals {
 	double Tr0_trips_rounded;
 	double max_Tsw;
 	double Lsw_oto;
+	double Lsw_equ;
 	double Tpre_rounded;
 	double prefetch_bw_equ;
 	double Tvm_equ;
-- 
2.34.1

