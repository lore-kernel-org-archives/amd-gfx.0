Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA1C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4BC10EC9A;
	Tue, 18 Aug 2026 20:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYwiMzES";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D31510EC8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piuffM31BLz8NCX5UwbrYsta8WSxexOkWsy8Md1UgBdRjkal9vSX87GKQ9IdcsNhy+Rs7jBqcLdbXE6y33tN7BGVP4HzTWfBeQChaGUeZ99SttPGY8zcLhINp7pPFptZa/fLXJq+GK4DqiXI7zvFtDfIuRknN33ZAUoY8ap4lNEasvr8+l9fnfFCCg9zDDTz+heze1KWg/PkYW8kzM26mWcbHTz2RC7kwzcHZlJpTJ/9AdOGdkNtnKPUX1Pre3H+Zks5GaR2SyVcaN9jRq6O6NrVXXmlELDwn5291LOmNtS7JkoKYpa1PbtDQLcdT6/Tss4Inbw/Piy9Ypfc9QOnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAPDOQzJK7qX1E+6AVmPA1xgTnsTXokUOfgO8DFpdQU=;
 b=HiZ3hPR/UKmK5qJdVHHWN6roq+4x0fJyh48wEZ42+wBqPFHWM7jIgfxVqVzADC1r/8a9P53Cdoc6sJx4THq2DaJPz157tx3Zv/onsnpcZKS7S11HBFlxcYWhL/BA/iIBEHrnYbThaNPikVZ6gTXwsJowpv0pQsKnguUQevsO/MwgCGv821xmOzsQPTuGer3J+wb/7yrE9zoPE7dQaCSp6SgRMUVbrEyKBbxcigXnusgUQVBTYUPekJcOSfen1pja0UL2BInTbB+DMgBOGP4dOkFH0Y28Mlzh8fqFUwDqzuz4q00ClDNrvixTTNawkwZ4OO0vavyIAgHqd4nv9XQUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAPDOQzJK7qX1E+6AVmPA1xgTnsTXokUOfgO8DFpdQU=;
 b=FYwiMzESfzeFNEaMeqZctho0TH1xKhID5TOc5IyLoozefMDCcLRDYsONtu3jd1K0VT9Ygmkqv6jJIP5uN0G+RdX/2IsuG1wYFD0l+zd9JqG/OF2En0emHPP9h4jqPPgy3T2UmVBsh5UNhWqU5qRmUwaPFrhrknJzWpV1RLGlbZg=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:20 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::5b) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:05 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:04 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 16/82] drm/amd/display: Fix CalculateFlipSchedule Calculation
Date: Tue, 18 Aug 2026 16:15:08 -0400
Message-ID: <20260818202139.4172592-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 549027e4-223a-4e49-2422-08defd66676e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: F4duLCngKoSB/h97uGLJJlnyJCRmkyVXpR7rSDI7rjw8FFIzntwZovLSHsJ0YLxxVg0iyfeyUWAMGmjeVoZDNjOKtEv6OSCoqtAkOfq+xPz0zrEvstypKmJIS5gk3Mb7o3ojcZ1D6flzTG9kuwxx9m0KxZLjt5CZVxedv9qP3r64EGPCxTbEZjlYN0te9s4Za8jd1agn3ZWj1apHh4j84O86SlKq34B28jVjFou59j8dBPZNMJ4aMBhmBj+kkPqk5cHYYlV8DvfAcKobppnnbINqU/kRYcg446EjFOzoXLISpaRMtgT1Z8SCcxiOZFsM6nx/+If6x/aGMbQez0V9E5aTkATDzeQeltGjr7BciHlsmg0gREdS4/PLbrmAi7dy5EqSGB/e+qFk+XRHAAVgqo2hqZTuUnGvzi4Bakz7KDsa4DO1G4z8btIvqyDQCXkwC6iVKfg6ebn2UPJUo78/+BTgGWZpNlddkGcgNEgJlPM2I5AunVYiteWWrgOf1XZgzv1OByfcvb9EfDuPNz6A5KC7CKNBNskBx6fUEKVGi7bJ7f+rHaArW8fDvsO4q6+MNzMOu9SO1re1/Jt6+dr00H1z2qzwkgZYFjMo0UhH+rU1ltY3IZy0ZyB/9dU2FbsUvzPWprqpBrKj5CUAtJ28Y9Cw7LwouM33ROIDKQHSNAP/R6aMcnxfrnHulDybaFoUyUwQUgrmEwGm7XKtn4BfCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eYGC9Cq5ZILFQaxiDnkjUGEM1K3G9Lhk3zAttKsPxcnOm2qNbgkJz5q8PWg3YPF9/aFSVgvoOWK6kJ5QQ3s5GvCoZiLJuDJKoiG2/cvpriyvzn74+ZYZIPn12flpEZ72e1aDjPWq2PylrqrD4p20COFLuvB+qBTOeKLELbM4U3JieKXMj0ee6KDYm/bBinEiUptGohARowbSkwtcX1t9fQZipy0ZDBWn3ts/fknr3cvA6zWtuBInIBFjJwJKefeS8sNBsj4xTUvz2hd50iVrkvnvitJ3cs/LV2q1E3AgB7OmaMJAlecYZHS+f4bBzF+WnO9OoFQ9CPa9xa8GLyyRm1KAvF/qX+64zhazE7fSEVB8J5DES8LO6YQ1g903yOkrcFjvfkizbS5cTdF0/H16bqzT1XAWn1A1VQwUwXfgTpg664bgZCHfs8m9cR7hNVDN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:19.6519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549027e4-223a-4e49-2422-08defd66676e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Row bandwidth contribution to lb_flip_bw was refactored to only consider
bandwidth needed for a single row.
row_time_budget is for 2 row's worth of time but only half is needed when
calculating the row bandwidth used in the lb_flip_bw calculation.

Also add meta row bytes that was accidentally removed during previous
refactor.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 5a1b710b9ec8f..9a205b0e15989 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6654,7 +6654,7 @@ static void CalculateFlipSchedule(
 			l->lb_flip_bw = math_max3(
 				l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget,
 				l->hvm_scaled_vm_bytes / math_min2(l->vm_time_budget, 31.75 * LineTime - Tno_bw_flip),
-				l->dpte_row_bytes * HostVMInefficiencyFactor / math_min2(l->row_time_budget, 15.75 * LineTime));
+				(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / math_min2(l->row_time_budget / 2, 15.75 * LineTime)); //use bandwidth for a single row
 #ifdef __DML_VBA_DEBUG__
 			DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
 			DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
@@ -6681,7 +6681,7 @@ static void CalculateFlipSchedule(
 					Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
 					LineTime / 4.0);
 			l->Tr0_flip = math_max3(Tr0_trips_flip,
-					l->dpte_row_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
+					(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->lb_flip_bw,
 					LineTime / 4.0);
 
 			*dst_y_per_vm_flip = math_ceil2(4.0 * l->Tvm_flip / LineTime, 1.0) / 4.0;
-- 
2.43.0

