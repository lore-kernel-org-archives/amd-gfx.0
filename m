Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA0DC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC2E10EFD8;
	Wed,  2 Sep 2026 05:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMCrkx46";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76CA10EFD8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO5M5siYdetNCa9fjc/YfNOh+wmUEr5aSCk2iPnguWl7worOiK9Cp3u454iKICbSb3U7Qq3INHD4WLUnyuUFehRj4JrQzkvmT0aVuyytPYhn/9wspkVzBS/wcWvLonrMAdT3JOCfScEZm8nOyPjekKiz8RLbui3lNnluhj9SZ/7IKePqyyG/CPLf05DrGRQ/4LMUdinVd5kABEczgEvRv1fVfPmHzFx/cCiuxYKrVs9BxcQCdE2FOpCkOld7lPx1gb2t1R86jiNs87MtLrxTHgIrEKYB6RhaVaxMAx8d31NUKPouOoHlu9HApcLqHrEFWyGAkwMF/BjdIs4TWHgpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BUSynYUkzhNELyL8WY2MalAbBJptUFK1YnH0Qxh7eI=;
 b=ZsiLlUQttk2VS94TM1HGAcXCW+CTPFSKL4HOiqEml4Uqn4tKZXt/ApCXBO79nWfnAtKw50YHcshzLTzAAzQRskzXnkzgMEIB7OJaYSXPd6pAwAoqwllpF8R7XR2IIzttrWPpH7UJIdeo2hlq1bqK0EoHaFrKGr9fgmFjkDjb0a0WFCElozPzqlJeLFAalsLVXHXUkf6zsk6nryYfzkcFFtNXoNzspVjBZ0720zFqgRAhDgEkevbCGCaOmYG7Gep3CAyaYvjN810LnUjzekRRZ9GSsGFfrzsQdYXQTrLemnanpcTYz8NmiVm0ZVTAchF5c1K66FNpgyNDVwq6TiAS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BUSynYUkzhNELyL8WY2MalAbBJptUFK1YnH0Qxh7eI=;
 b=RMCrkx46QsMt7rz75loOAYR+bQebRxbri99YmlQHSUdYURJm7gF3wqljSS65AcniNSK8n4/EtwU08LGYb7lYOGyYNjMpGfcv1gs19t/AzlcV6Uw5xiSYYUUyFgdVsvC2nJ65BTteS5+z2pb37zAli3HwvUWMwXQXJr1I8V2OSfg=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:08:37 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::83) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:33 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:25 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <samson.tam@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 28/40] Revert "drm/amd/display: Fix CalculateFlipSchedule
 Calculation"
Date: Wed, 2 Sep 2026 12:58:50 +0800
Message-ID: <20260902050411.3473916-29-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c68d58-803e-4ad4-2d48-08df08b03def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ke9t/eM95Yj1vKLXX9AGYIred8rYLOAMwl+G6UMr1QCkdk5+09r5QkHblZu3UtANMUxgA5lA0B4ucQiHqM5fcht4LYrnsISH1jPwH8yvaqGPaNFCn+lSDrNEIy0+6J5tkNmSD6znv8TimVb3ErQdxs8AW56mbKiPV2Ny3b89VTy7Fju/0xAOYs1v2a2hUyIaKT9/XDTyneqid72ekx+uuysulWu//m4zPZrEslpGcmBujaweK66+6hMLZr0PhWV4s5ro6EZFMqNGjpSKPde2tcoCWUZJ95/IvVrS72c0J5yzFQfjLxoPBRM26B9xUDchYbQtZy8AAU8unrRa44BeVlxsNnskWrsaP22ccBCiZeEFFwc0fy3gnBuPKZFx9qxtOieDSMHVOVb/njuqVjJo6oY9ta+u9eg8QxjRs8RWrumlcFUJ2J11dfYojsEgQAiAMqDlJXzD920AUEuyL/nlyYu2A8nOyZjw/Z4dRbyBxSvLM9wQtL0APB34MnBCqsyW9tZvYN5GfKG8Wg3dzYwKbOD2BgQxVIumgWUJGpwSmr2aHXsPOmHstMyHWTHADDqlIy4Q5X7TR5Xl+pRjky17mSubJLB1+7ryP4Nkr+kdZu8BsxevewFMzavgAI2KNvK2690/tgilRRhPJ8t4RrXHK0HzPspFIivOv1Mm8gdiE0lqno5vFD1mQbb6ripA6actiZK97cG7oBDsRU3rcm1FyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w08GFpnX/36yn27/1t8Fzaiv6pI14+E1cFR33y9dkel3gXId/eeHkww3m2t2RmuVSWXz6/z+DcFXjXDJra20WLvPILL4LTA/No9ckAjPD3ir8KCzH4oys2HA6barC7K33RjlNRvqc0gRAwYAhSxGpjkKcEg3NgkZCWhPFQ750hVkI4RNPCgHGNNqKIATBvl0XJK3O8EuyIOkIftYsEmy8dkU2nCkgZtJ0OS8sTkCNSjRn5slA43OVkNh1/ehEyPSRCi0ksO8AEHiP3hL9XwYxrihJswRHtoPcNoWJsziRrgMSzzRyieAAw+F0Kn0B3zi31pFzCVzykNvEbFFCiEc3f8xVgHvbGWFqJEGHoDRN8doObkQnJg7M8v9lDhoxrX8DIXqh7DRo2IZWb5sPqzUQXg70M/PQ3glzdQMzaFGQQb4zqFnztrcH70JDkjJ1N8z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:35.5874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c68d58-803e-4ad4-2d48-08df08b03def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

From: Samson Tam <samson.tam@amd.com>

Revert commit 067059c28ffb ("drm/amd/display: Fix CalculateFlipSchedule Calculation")

Because it causes some regression

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 608bbb7287cb..64417736a4d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6648,7 +6648,7 @@ static void CalculateFlipSchedule(
 			l->lb_flip_bw = math_max3(
 				l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget,
 				l->hvm_scaled_vm_bytes / math_min2(l->vm_time_budget, 31.75 * LineTime - Tno_bw_flip),
-				(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / math_min2(l->row_time_budget / 2, 15.75 * LineTime)); //use bandwidth for a single row
+				l->dpte_row_bytes * HostVMInefficiencyFactor / math_min2(l->row_time_budget, 15.75 * LineTime));
 #ifdef __DML_VBA_DEBUG__
 			DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
 			DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
@@ -6675,7 +6675,7 @@ static void CalculateFlipSchedule(
 					Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
 					LineTime / 4.0);
 			l->Tr0_flip = math_max3(Tr0_trips_flip,
-					(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->lb_flip_bw,
+					l->dpte_row_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
 					LineTime / 4.0);
 
 			*dst_y_per_vm_flip = math_ceil2(4.0 * l->Tvm_flip / LineTime, 1.0) / 4.0;
-- 
2.43.0

