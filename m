Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FC4CDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8172110F181;
	Thu, 25 Jun 2026 08:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wu2al5uZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60C810F180
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1yJicWetI9aqHUwWOIyIQoNlRvgX1aDekfFH/BIga67SfxR+OQEi6+gRSwkBDJZ2D+1PvSqLZBSjkUJt2/3g5q5KJHzpCzJirtNniK/zTIcLDhEEb7vga9c45Ep0FDI/Zhmue70VCV7p+cN/NNoQcwVRvahQ4OEQGqyBFR93vKr9tzszMzWCd0ITw40aSs12LyIEqzkBLHKizfB4NBQdSJy6rUAH/uxyi6P62+8qx03cEPDoENR2reDB4SiH2TrDLVvkaLPN+Y6m4ai0HWFbHizf25/ZVJ7bVfBqttd2CHbK/oQB42gwRew73EfO+Pck+R0z20u8CGe8Ei01OSqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=ZAVBudqdRCtGZqrRJzcz6wI4cSkIz5gLHDVgmKzWlQ/OM7nJN22GcVGEZ1ieLmVIPRrmoSJITcNdhOpXSAjtPiya0GmkcIA0/VRLZURPrH4tO3gIaaFXby7pou/B2lFeH2RRflC5nSPKqK6m+k+Bx7C8350C3c0wxwNXfC32aIyEC4+sKGqFgAUy6LDSFlXjKbSzL3dyysF4Qg7njZ+KrUfjdgnNLxVhvJb79v+0cHfiNnz+QFG7PCoyDZaHuzuDV9XF2t6UjJMCo5xe/hba1ceKqqCRoxZVV9agCtORzsJCw07KUS209W2Q82ZNJ4s/Heo0KaZKpTDjHO4giBxwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=Wu2al5uZlfMg1XmM1+juyiOqZ1cp8Db1ocwqB/9F/rlVgOm9r9WFEBvNvlAdsY5i0myy1vUQYD3+TO4l9SAxzYf2RqRBKhko1R7KR7iYrlMPaBFJJPN+poENHOe8GxEyC9ZBeU0OF6QwAIaasBlzVjXllfpRBSqzClv5UkdMbrk=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:48 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::69) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:47 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:45 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 19/44] drm/amdgpu: retire legacy RAS reset/query operations
 for XGMI v6_4
Date: Thu, 25 Jun 2026 16:19:12 +0800
Message-ID: <467dab13edc9acca6d394330e0e301677866de9a.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a951267-f5a0-484a-4a85-08ded292a913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VkcSa0e4uUrpkjd5n8//BElcQpLj2c++giukgTAQkaXpLTI3d+JE78qu+6fqgmLdAMJHAZy0DmxCYsr9aEVYtxGv6zHLnf2/vlx61B2gxvwADJjoZJP6MpdROC0s84+Tnrnanu59LP9OLIc4PPt/DfjeeGVqNH76EJSTNr8jDbg70TEH6rbVYMzO0OhMmgiNcCIr012Fn07AOxEqa5Ok/cDGklmeEz6ic3wwPOduai8plu+O0OOfnP+ynUy64I3KFhC/FEfQJxVZh8QWpq5b/02CQOdY83KdVKMplspNx8Au5P7p9+g7VNPMfSz7oK2egG/iqeq7qTxmPZtrto79cfH23TCBAnjPEr2DUG2dv48qDHC8wXdBAOYbgl9txDaSd0UGagw/L/IcVXwrnISWYp6kFeEDjr9NO1OmZ0kpPPzEnA8lAJA+QJUX2upfgCmvl5uF4SEKcGR8sqEAu/uLDERIeaPAnjX7hwxp2l0mPkzeQf5YGdytgPQTc5sbwMg+ZWz3BLmK6YAk0ruJbO/krzqyi60lKcYfzTf7QSYNneYP3rjxQYV6JzP1k2/FFD/YXhbS3hkUtOUXQLuRsU+X6t9QBSdeb08EqK0apIANpoCdwrzg0yOjDIL20P9o5Q7OFM9Id82D/GOywttssUIJwlTze8hpAfpIJPt6ek2sVnJLqn7iTlDHLOIgf3UjGy6LXNGuEEEBhOfsUueF9qmrcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hZEBk6yrs4EZW/A2EBqrUg2IH7F0+r0T0tVpC7+rnONyPE+kADyEaOOOBVwcGfQcL2JVxAhh3HPscZ65NOu4Sgb9Zyss8tHgaSMCoVV4A1iLZFuoN/4dvGVJjIORTjNj+XifXZpKvwgyckFXtVCWFqslNQb+60h/Srb8X8EPu8UpRx5F5Dzg2fob5jAzq1SByGUxoSkg8VHjuS4hM1UekMlzCgjRAfGECipw6sY0SqIIWY5hl6vmKURBORNhH84fMXF7MFotBVRUgqLaY3zxiDmv94nmCPNT3zPkKcmtWbPWO6uht9T/JA9pgbTfV8YwarkAnaLIkYDcBW55NObxYmnkfrqS2rkS+1Rv+JFhASLAabUQ2KfPTMwiSIs7wSw1HYr1jNX4huW0SuRGTxG1TvozCctWFV/7XVRHVTuJtVd68yyYgISZMgkDdR7HyFaO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:47.6466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a951267-f5a0-484a-4a85-08ded292a913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

retire legacy RAS reset/query operations for XGMI v6_4

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 49 +-----------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5fa706915d49..59c76fe3c56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -106,16 +106,6 @@ static const int walf_pcs_err_noncorrectable_mask_reg_aldebaran[] = {
 	smnPCS_GOPX1_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
-static const int xgmi3x16_pcs_err_status_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000
-};
-
-static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK,
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
-};
-
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -1165,17 +1155,6 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++)
-			pcs_clear_status(adev,
-					xgmi3x16_pcs_err_status_reg_v6_4[i]);
-		break;
-	default:
-		break;
-	}
 }
 
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
@@ -1193,11 +1172,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 
 	if (is_xgmi_pcs) {
 		if (amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 1, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 1)) {
+		    IP_VERSION(6, 1, 0)) {
 			pcs_ras_fields = &xgmi3x16_pcs_ras_fields[0];
 			field_array_size = ARRAY_SIZE(xgmi3x16_pcs_ras_fields);
 		} else {
@@ -1235,7 +1210,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 						     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	int i, supported = 1;
+	int i;
 	uint32_t data, mask_data = 0;
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
@@ -1299,26 +1274,6 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		supported = 0;
-		break;
-	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		/* check xgmi3x16 pcs error */
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++) {
-			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6_4[i]);
-			mask_data =
-				RREG32_PCIE(xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[i]);
-			if (data)
-				amdgpu_xgmi_query_pcs_error_status(adev, data,
-						mask_data, &ue_cnt, &ce_cnt, true, true);
-		}
-		break;
-	default:
-		if (!supported)
-			dev_warn(adev->dev, "XGMI RAS error query not supported");
 		break;
 	}
 
-- 
2.34.1

