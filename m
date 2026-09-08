Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECAFC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A11710EB75;
	Tue,  8 Sep 2026 11:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJwxwseY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40CF10EB75
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhBJc0T9JcvDREQn6wXHqNMDrXErhPVixpj6pupF/SKmPRS1z842eOf3VO/CaLWjdwgPQM+k3REWknk4rER5eQEhL/f0QlRvVHmZIg4SVFbeSI4D+fdOTLD5vGXPpQkYcrs03szDYU+Ymv8HYSPTr9jQPhAY5fxsS8OGB4PIpOB8a/6DZRj5oObqWoNDlNNjHS7hyuRvn52SYTGFxWDEAGgyJcH4Z/Bd4NzmM+YSfXIA8t972ywUsFi2eBEpAR/2XOSzgmZmXxv9OivHHB6NhiVQbWS/I+B1A5qEYRBjRMrCqXOAu3mr2TFo+vB2cbzToGzBCbm3rUC28p+TYVkEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuG1zCrSV4hprCqIncKC6g/G698pKHjQ2oteQ74CO5E=;
 b=A5FkgW0ieLsdhZ+7DP7rT3ce2BSwTByRhvY7Q/1IkxKBYkJ0V31wK4UzRWu2FmM6ftWYDtpTApMaFYKcLeiJNQSujidJVESqlEGQKrSEyInH9kK0dZ06JnjJU9b11Wf+nUgJp1sVr1YbbxZyWctraC073OeV31wK66L1y78r3g9HtrJ1FefScv5694kf8LyBLZkuYJiG58ApKZ8SuEFQP8H6UHE6G2XmdDfl9wWRgbELiS+1BJObCtRf3uXKx0JLfbfqykxM11drU1f694XPFBgr+UMq0HBu0h4OmDhsgghLOEA3li2+oCu03WxEa4KKM6NpP8L713Ha8m9PNxsNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuG1zCrSV4hprCqIncKC6g/G698pKHjQ2oteQ74CO5E=;
 b=xJwxwseYo2dkf94sj3CCFkjslcfDpJRvnaUw0e9ZgxRfP0W5DbmhYSt0I7Wb0uCQRy8S4faUzyoUvi1vQwN1FfXisLS1BkXcxJKRdHmvgLkM+pIlCqE34D16zHYaC8mpVmC9JK7clBrYv9jciI/cj6/FkGS2M01IPd9wdj9W2h4=
Received: from SN7PR04CA0169.namprd04.prod.outlook.com (2603:10b6:806:125::24)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:43:31 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::2f) by SN7PR04CA0169.outlook.office365.com
 (2603:10b6:806:125::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:43:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:14 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:43:05 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 60/66] drm/amd/display: Add condition to skip MALL
 calculations if there is no MALL
Date: Tue, 8 Sep 2026 19:31:53 +0800
Message-ID: <20260908113338.2433445-61-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS0PR12MB999265:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ad8a91-8201-4d44-5b22-08df0d9e67fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TO2k7nwPGtHw4j8btRy9zy8Lf5Y/ZTLiTdtIQ6PkWKj793TPfXPV7tE8jINhEzW4fGHWVZbUA/+SQe1CbnBr9mfSItowAJwwW4DZ2O2qXRxsYYa8wO0Uy8eeC32GHYrcx2SZ2eTPBq6Dp3PwN7FsSDgEImHxJ+MUQ7PFHSRWx+Rusy5PrzfkoOpwmPYzZKXuAeESUEzsUbBO+CQedvMh7/lUAzlBHs9lr2x5W/8CZl2vJtJwPmaFWo6kOXLo73XSkKSJPlLgt1jICqIcM3A54dXWshwvWDiy3pqDlawE0eUrmL6DyG7WbO0r8Sa4ZNEqumRO32p9ubJA8yj8FXCifkSBzvb2GCmKkZSZ3wCIM5wM2wBIeOEOY5wneWg8ZCsGDXWdO2/9sxGHcF1I8iIFQE1v5x4AWh670UCYQRGCOqmZK/ucPEE4P/LeUsGqX42HZNN6T9Yd47xmDWUxtnbc9lBqIUKx6Dq2m8DGcHk1bqM/dk++vQA0C8YM96J6xhVXIQti1h9lkEM5B7ErUXBjdS9mYNrT/xPaXRqno07jlC5+uItEHMeF5VEDWGDsYnJ0UuP7WCaydvY1SzddHMGrwptPRsasnut0aHnVTaYa383uZzUEFof3ptodGBuoJpEV63LsAn6WxH3N0Hy78pv/yguVufFveH2yTSasnretUvmnF30UPN4YORvh/soxFQBKDvNKg7cHvKvL13+vf/9mtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kWds34mOt7LEFs5gDhmE1VQZIwV7JIXq9Pyoj/pvSYp3I9EgH0eMUWZbwY5C/+Gp/4qXAHpMDZVg4BG39XM/4FohdexbJde2B3WpCaVAupwQ1R5xPuRJApmlYf7Mk9lS/yySVf7y7X9ccHGpehYAd0wpqIfAkKIVupGreCHPWQLKj6R+VV1/yrmOI/Rdwm30HzAh9lCxMN9Ij0ymQsLEUz2KybBFm5gXRUPGaxUWQRaiLGzp++cnDSDAA6mDyRRmJh/vkVMtb1PcWQRxNhZdv8PpH4jhswW7S5sjo/QwxtgCsCCxeo1CxnQb9AP3aE/5y7wGLy48rlCn/O13EzTO2w00wKt7C02g2fGTJG192bTOQZxICmBvjRz15M9qjT3T7oeQ4WO9KLWKqDbwjlfH87GM+sbZ3wNNNOW4AIhNKtST7zBeIJaTzMSLfk9N0SE6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:43:30.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad8a91-8201-4d44-5b22-08df0d9e67fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why & How]
DCN42 has 0 bytes allocated for MALL, but this results in a 0 <= 0 comparison in
CalculateMALLUseForStaticScreen(), which blindly returns true.

This causes DML to calculate with is_using_mall_for_ss[n] = true.
Example:
0 + 0 <= 0  ->  true
        |
        v
   is_using_mall_for_ss[1] = true
        |
        v
   use_one_row_for_frame[1] = true
   PTE_BUFFER_MODE[1]       = true
        |
        v
   dpte_row_height    :     128  ->       808
   dpte_row_width_ub  : 196,608  -> 1,204,224
        |
        +--> DST_Y_PER_PTE_ROW_NOM_L = 808
        |
        +--> N_groups = ceil(1,204,224 / 65,536 / 2) = 10
                 |
                 v
        REFCYC_PER_PTE_GROUP_NOM_L = 8416 (0x20E0)

Currently, DML does not plumb out the programming for PTE_BUFFER_MODE and FORCE_ONE_ROW_FOR_FRAME,
but even adding that programming does not enable the mode to work with these values.

The simplest fix is to just block any opportunistic MALL calculations.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 47d63dd69a90..64afb67054d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2001,6 +2001,10 @@ static void CalculateMALLUseForStaticScreen(
 #endif
 	}
 
+	/*  If no MALL is allocated for DCN, there is no need to calculate usage for static screen. */
+	if (MALLAllocatedForDCN == 0)
+		return;
+
 	SurfaceToAddToMALL = 0;
 	CanAddAnotherSurfaceToMALL = true;
 	while (CanAddAnotherSurfaceToMALL) {
-- 
2.43.0

