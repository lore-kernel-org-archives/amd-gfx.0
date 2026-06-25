Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D9CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 10:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA5510F211;
	Thu, 25 Jun 2026 10:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24+W9G5C";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BC310F211
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 10:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S69RBeoOX8Ibr/DOJmckx2GWIiokVngEZTCSXGbrxfyC8rUHdjrwZHqKV+GIdNYhvtUqJbv35jmJaoHpfvk5opd7KmqRpP7MZJII6s61SkW541Mkisn9uMFNWZeSoAUQjPgKIAMI8KMb5G1Lkis7U1fSEBihzLosazXw3HdN0fmAoq1Bf5vMDQJMJ9oQZh+qYnMZ66maFfxyCRkKmB1Z4qGk+aklrpLxJl+cCqYFn3ymJ0F4F6ReUQemCASTCjtUA3ICliNGrv2w4YAg8jknpj0+yXxjnbfKDwPgXtl/9bwEA+G0zmHoTwFBUJ6ZaAK4ISYoPrIkRYcKuux8oSF65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RgtRmHEcyCvXVjUg1/g7ySPr/6ZrOqjVrJyF3lCpcM=;
 b=DNxEMQR8E19YJXVxaFeYWvQtuMAQ0lbdnuyQfTIY2fU71o3skl+7wT13mSPRHECK46sR1sr4LB5rmzLFqFmfdGP3Q5iNE8ygbQcVNStOihJH8+ipJJZOd2lf4lHlcbiMrag+itx4HnPfKOgf3jLWjSGuD9fLckLx6Fttf5CZ9DReBb2FOKiX+b2GNILnhttUj0g2FSb2nQR+OhFIxUSsUsWcjyLsdXmfyZPYd3R+6dtM3G9rMX8Tt8v8xxjY269dAtgF5CiFgAwF0x1+lGZMKj0iMIHFeg5J66qLigu1Gaq6Xek0U4bgCCfiZkFWi0qUaGt4ZuZ0neiaNE1zlYYdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RgtRmHEcyCvXVjUg1/g7ySPr/6ZrOqjVrJyF3lCpcM=;
 b=24+W9G5CQFCx4jSsCarnMDIZ+RLD8iuFLIuIRzmdL0lRinOliESYXA2zZIwv5vD5piGMNHeWV2wfT9xPKFXUN7ZpassFjOoKHO2GmwQ3yg6mKHcrNvgpCb46cHIgoc/ylyKrvutFpPD4R/pMnGOpZ9mCNfZFhsMUVT5SCGKhc4k=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 10:02:13 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::75) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.5 via Frontend Transport; Thu, 25
 Jun 2026 10:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 10:02:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 05:02:04 -0500
Received: from kenneth-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 25 Jun 2026 05:02:03 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled
Date: Thu, 25 Jun 2026 18:02:00 +0800
Message-ID: <20260625100200.147004-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b2d86a-b723-4240-1e17-08ded2a0d476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FIeMbgBnK5Yye/lP9e2IBZN38Q8QvZ2hGNgCl0uG5kTbuR9GVynrRSaRC+TDH5XpUTocvR3Eu5jDxbt0wnRG8kJUFR5kegb2Pr44MVrZJpXwMFEewNjX4520+xrJvk8KFp51EA8iPklRaeIctYchzIBMn/KViMR8ccqjQWkmTzRcSCzhcPi3OeEY9Rfjn6pVDRTvuwvL4dR18eJSKbuurGMITUi+Cc8FCNuv0+FOo/aONkGScnvU3rwf2q1NPLLRedwNSklsL7NFbNwXXeIq4eHBnQCm7lot8VKDzpRaBJA07gqjnQ9WEZyXfpCc7ApwnwwvNvxcj3guwnmq1pRiU1sB+KWhEL9l0VYDzkYdBtBMEuwwaZ4hogcOyfjvBJbcjiPZZuXqqeoxxlqfJIuj22w+PBeAayjsK5dXo98zIE7snYq4Ao+Y5x53JCWUCx2YTEuMs+4Xk1Y12XAzAasuO7rK5st+0goLrLgVtrSvThMNo1oQIf+zwrQn3jniIY/k9UOUR2NYwWWUJzSzJCHbkSayMiKHEFkilyDQhwV3of/SxX46qRL0Gi48XBK/x1Rn2mPVsrtv2PzPCur1JhX8xjcM6pWWVjoJFm3o0UkgeiqOMWGpo0dOooveXu9psYr7MeB1Uiko/rfCLmGMJD+cdOCUhGgvqhzOZwzuvA4aNYz4N4WZPg732MhXdMyzM1u2GUgK5OaKGV9mMSojCisG3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(13003099007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eIBVHFA3NKgx8H2CjSqls7GrZQ2zIK1ZqYGneUoCdJb9UY/SsTjqA1GnZouhTQ0Lz0h68UfcUZqBVndXDQRrVS+JyPjHJfVmNf88jQLTCQI4T+mXGVs1o7mgxCNwoVObcYAIUhdCVi3cLkAHWyGhTderkmX0HGn4I67ADACLK+GnrZprGcM4OAzojlBOf7OxsN6BHFJP1DJseBjDsLBmHxSi9r1KXBsn0Z6x6j8qkKtN7Vn9K4LlgAHBaGT7HGyEJ4/t8rPOt0XH3qUTOzFqz4hJDlHdxcjVmf8j+Duc4KmRJNDpgmlLnhdvZuiewhekzrtROdgXJ0WH9uhLrOF9QwYWzB5PJgriFjUpa9H8fAohozYhq4sfteYabXoLpjeK8cN+v4EjMDZhFsYn7s7t7Qof8mEO2e6Ut2sjj3wPvsUmOJN0DK0KSCvUev0nPS7C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:02:13.3562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b2d86a-b723-4240-1e17-08ded2a0d476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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

Disable ASPM on VI if PCIE dpm is disabled.
This is a workaround for issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/5370#note_3528027
For the other projects, ASPM are still independant to PCIE dpm.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70d07ca187a3..9a8f9c74b474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1333,7 +1333,8 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 	 * It's unclear if this is a platform-specific or GPU-specific issue.
 	 * Disable ASPM on SI for the time being.
 	 */
-	if (adev->family == AMDGPU_FAMILY_SI)
+	if (adev->family == AMDGPU_FAMILY_SI ||
+		(!(adev->pm.pp_feature & PP_PCIE_DPM_MASK) && adev->family == AMDGPU_FAMILY_VI))
 		return true;
 
 #if IS_ENABLED(CONFIG_X86)
-- 
2.34.1

