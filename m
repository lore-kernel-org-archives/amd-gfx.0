Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B69FCDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B938410F194;
	Thu, 25 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FcXn9Xv6";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1147F10E18E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWb6Z3KAJNr/oVFritV1MJD9K3sOuvsQx/7JVAbgiZT1Yju26elM4yLohgzdYqgN5kZxb3KJAZ1yMWRQHGNS4IjsGUk2QCT26aRkj+VYK7wWb/knfO92KoHIKq+a2bQIyK4MyQRRpIQJjhO48R+ZeIdpRW+xdJRmRsp7i84DIJcx9VnFrQtyo1aiY7kkE7DaZTJ2Ct/Wb3iCgcY9+XAZre3Q9P0TzeJuQE8u3LT/QlcrDmDxqxMd5s+Sc8amcI0qy/N5c2Oq7CJQ/6okzOxL14XqdJppu/aUzWsfVE57uanJhdVExWT6AgRgLOR5WNhMHEZf4jaWW5q3wWuzcM/KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=mxohz/bQPSh6Pu5425Pb0PA2JDI3li9bQaU5VSgEQh88BSvTyqW2+mY85LZB19+Bh0T+ulffnL74LCL2Ldh2qiuoxLGIClGpzykDspfQe7hkKimTkC0CdRfNGiYsIXFuZMT+t1zZHhp1yui3UacezXZkdWpZlm/Uj5BRwq7aZJd97ClS02IbnAlzDmbzRv4ROh4Q8oylnRHrbutVgfPvmNV25GfSBvB1wRFfM05Bn7eBwlrT8gKgts/1VXg0KJQjKxoj5H6qPCvuHV4t6neKm8sn6qRndEibZmvReUpVMYtEcTehHk9uM2hqn37Kz2IMPtsOnknT9brJkGXhwlmE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=FcXn9Xv68Ukf+56g4c4Ur5gplq/FNzUNRxiyB/W29DO9bu8iNtFeprVif+5xYEdO4Iwc4SzUg4N4B/rtkisJrjt8SAaUSrEGB/R0iFz7r/xEAJYkbM0IHbArs1ixOG7u+540taoC05fEraO6V+0m8DHsbp61dt31C4R/l9W/QCw=
Received: from PH7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::11)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:06 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::97) by PH7P220CA0024.outlook.office365.com
 (2603:10b6:510:326::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 08:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:06 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:04 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 28/44] drm/amdgpu: retire legacy PMFW eeprom RAS bad page
 handling
Date: Thu, 25 Jun 2026 16:19:21 +0800
Message-ID: <158a8e07fd67bf94ee3b5ef5c7c1040f16942d16.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 115f3407-1ba6-47f8-916b-08ded292b41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VpD3eVQhlGan3pExvjF3J8ufLS4iPBk2tJlrzFhdCO29tm1ORd0yTjiffSGaRnhQUkgOpuJlxq/WqpY41yNkapoXvidg+VbOsEt2HAFntuFyfdjpW9h6hVCc+V4Hil1omoDc1BbTg61/lQ2ZUqdVTi2Ta0C506K1Z9JcejRYk4tHhSrzck7NaD7Y6eWrHvxA37dGM+Yi8e/d4ANOxZDiPqiXslapidrWCDqqCb15btjU0KFUDh1NVCpsOo0TuCrkTCZEgPnIabuXIXkxDiCJr9fT7hVH7tGOQYaX1fRunu59+BJz2fHdKGIk1F2u5xdR7XdjFa66vf5znq0vnpa8Zt1BX/LA8yLCb3ajvpS7Nv0wUDwK3mI5BVsIVR2Aa8XA4ObA7NoOgsHFasswbCr4mMSXBItZCpCGyEKQY77c0kCATxMvD4Z0nI3/a9k5uphOaS8/SXcUMp8/Eq7JN+IS689hMVMJYfp4if+iIsvNDDz6YyXMrdWRHIuVvxRaHRXxjZF6DdIM9OhCfZfNJta1HIEVdsaRXeNfpS5PCmgkmWoIhii4jMrU7eOZo9ihJazerPym2xz7/vyyVDL7l3p4krX+aadDARE7w9MAzDd42KMXCz6QZ6KxNhai/3WQpMi+XmG+u0JPzh8hQeqqDvQ9XoiSpohfJidbVWd1avKsHFKbO1BO4+bLBJlKLu7GUXkVikkE0c0dbY06Vb1N7V+sZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XAIhmdv/SImdXo5xlANCYhUKbEvzcrESGEQAtcIsDnHDHFis56cvoW94MMecNH8r9Z0f2TlOj2AYloVR9L+aYdalqjKdzKWdpMo3m8Xd5jdar4OfJ0NOoTYVExyjgfcDIOxENPgaEYrBULQI5C88bJ3a/vtapSZcHxyZRPGhM/tgyR3p0yj/zUKCcOCt4fOCdrSF1y0eJPaqs1ueb78jOZQYECQ8pqtew5gksprLhfiPyL0qsxmDioCeJusiRG5aNH0z0TJWOr/HLUkqkv1+ShcS+MvNjwC/rjXwRMw8JHxbZ0izCnlkTQBT/SSagAu+BVbXKngNi7WCIe8CcWsGZrGP/HeMBNl2ztvqcndvhdBO8ewfMzfhVPzJKxqg/b+/3AE3Rcwccj7eOU+atQOePvG1igxSixdPNJJEu9NlJuH2qzCvL9gnIMsC5O68s35W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:06.1677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f3407-1ba6-47f8-916b-08ded292b41d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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

retire legacy PMFW eeprom RAS bad page handling

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 33 ++-----------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 292d76021644..d28e8958b0ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -916,33 +916,6 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
-static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev) || !con)
-		return 0;
-
-	control->ras_num_bad_pages = con->bad_page_num;
-
-	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
-		dev_warn(adev->dev,
-			"Saved bad pages %d reaches threshold value %d\n",
-			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
-
-		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
-			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
-
-		if ((amdgpu_bad_page_threshold != -1) &&
-		    (amdgpu_bad_page_threshold != -2))
-			con->is_rma = true;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -961,15 +934,13 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !con)
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_append(control);
-
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
-- 
2.34.1

