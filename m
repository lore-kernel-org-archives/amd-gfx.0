Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C53C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 19:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203D910E76F;
	Wed,  1 Nov 2023 19:50:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962D410E76F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 19:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J53bd49iKxJsBRP3QACpsBobVmFuT880OkyEEV+DdOsyEiSsCr0+BI8XV1NmAeO3i06PwS7dQlF7YVZJwi36r3YiacTbs6qu+4fdmtxoWtjjMpHX/RmAUWuDFpshxTAriQokEfGXZJi7/HAn1zq6TR/4yrMdCyCc71GrI3DnIwY8mM1M+EM/Tniw51MmtHVpuFGD1RMAZqZEQ8vkA/pL+hUjak5Q/zmU3phkUL2PJlFKFcH5tEaMVF/4xfa/y9h/RG7IXLQPFhlWISlwpS1wHFIVZZYHV27t9YOQNHser58UgTTZp0k8lCO3IdkFZoc3m3yyACdsZFFjb4l9/uLCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eu+LddD8acED4KoWJrZMCEBJBDGrc1WUPvK10tsNw4=;
 b=Mir3iG6sSPup3mxp44JJ56Ii2xZjfXmNgUAyJbpfQDuTeIrxAnUmj+q9N78XvYln2cFrTPNXbGDwG8BBlg9NgCNIhsT4kMXkv5fft1QsKGgZmDTjYF/l5VmYJIgG6DP/a0zibW73v8/wgKoJ0GCV1gQc9xYx45JsLqBynvuNMkO6OyE24Uh3SmomVt1E3XEugevTxiREkntdCgiJQQmbNcrnC/Te1AfRT4pBDIczigC0y3Q3BqlJj+/+iOthkLsWncQl8ex4L4cwAN66CVSDkxX9OmtOqVL9fGd+Ni1NA5CaiBYpu+c0C1DW/3VGIE0aw9k+y+oGqJhMg3xRwfHqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eu+LddD8acED4KoWJrZMCEBJBDGrc1WUPvK10tsNw4=;
 b=rzCwDzdUHHnrT5JyfE/YcExE8dYxscehf2+i+nd5dNoiWDOtSB+ntisRp9fqNUeDtjbtgKvsiPiyPfa5tpvho0Esi9C1NYvRrcs71hxef8ch0+/sTZUW+oJMYjgsFhlukbPxrZjtC677mcTSrBmmOeJWqlBZgrKHk66vHJI7coU=
Received: from CH0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:610:e4::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 19:50:13 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::73) by CH0PR03CA0194.outlook.office365.com
 (2603:10b6:610:e4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 19:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 19:50:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 14:50:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/smu13: drop compute workload workaround
Date: Wed, 1 Nov 2023 15:49:58 -0400
Message-ID: <20231101194958.3526118-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac29b31-9319-41d1-5784-08dbdb13c32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaVsIoyqo7a31AiK78y7Ar1LDdx4kc66Q6TilZRfofAKDmB43K3TNGgHfTjH9871v2oRSBI3P9hTwmCdNMTyU8VzNuFYrwF8aPoheUnBxLoLUKw8itbxFCYx67/6N+xUpmVtDKW/DxXoIcwcCJ0+UihMGVTAQap4EHQYw2rHqzoWBQOwIpFYkSMfCNpYX20Syzt4OhH4wQUA9jAlmBV2INqNTVhog0eOmjnLUzLUciG41+N6m2DhEPN1v8lT7LyLW/UVG4p8+lCUbQYi7BCE3VvSHCgiBwc4H75nRciQzlcW6RCyPdGgVoqlJGwEZWCy2GBl6n1w/Os/ys8w9zoMAAMCFsPVqYP2CFjqMISsw2cXp9GKICRDz0wz6hnIKt/r5nmiPpZvlpuR0zJWTYSrG35SoNRJfLywjWXGbpEZch2XTFjbOTwxm9jolnDpqPcCQ51rIWM9LqmsFMPSHfP7c+P7JOEwK80k4N3rLZTgzfaO5Llkt+Pz4gASkd2R//gCVyUzCyW9EvQcu9HxecX74X0im5ZSQm0RZkKOeRHzSZPhwoA5vTWnxTfcya374Y1R4la/70sqNnnbTK+V6WTiJuTOMacQl9JZVI1jYgtL80tjeDklE8SKH3UC3FLhlYdJLMb+hD84weBxHCZhq1ql5InE7FJ0b1bNAGxl85ohq8U53UeJ09j09KktW7GhphEWexnToJxi89g4+UwrVlZLCnSz9L8zje8rbLrFTHT+L6j6o7/OsUi+WqkWI+OkKKagWbZP9C0mxuaw+pxhZl3H/OnGp0dvNDMkYqWYbHHBdpd5rdJSS6Xmwb8anPwGGrRg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(478600001)(6666004)(7696005)(40460700003)(47076005)(4326008)(5660300002)(83380400001)(36860700001)(2906002)(8676002)(8936002)(26005)(1076003)(16526019)(70586007)(6916009)(316002)(70206006)(2616005)(36756003)(336012)(86362001)(82740400003)(426003)(356005)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 19:50:12.5660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac29b31-9319-41d1-5784-08dbdb13c32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was fixed in PMFW before launch and is no longer
required.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 32 ++-----------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ef0c30075658..82c4e1f1c6f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2530,38 +2530,10 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
-		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
-		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_COMPUTE_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-
-		workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       PP_SMC_POWER_PROFILE_CUSTOM);
-	} else {
-		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-		workload_type = smu_cmn_to_asic_specific_index(smu,
+	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       smu->power_profile_mode);
-	}
 
 	if (workload_type < 0)
 		return -EINVAL;
-- 
2.41.0

