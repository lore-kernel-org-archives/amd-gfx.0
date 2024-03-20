Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A7CC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 10:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0333C10F580;
	Wed, 20 Mar 2024 10:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7K1fDG9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0689E10F580
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 10:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zep5Wxx/PC5SKv4WX1k6u4uBO/8aEm+XeJK4EVxU+ho4OCFQeMkurbsH5ROlTVSsgy35JwmgqZcLMMJVDFZxp+xWN0W/u9UMgvA6lw904IrbM+lRNp1mq0sC6VBPpbTYmLTMKOC39FHKrBRbp4pzzwKKTUSqmi6l1ZD7wD7WlIfWdFjRiGxgCA8WsHNAkvsU08r8uPO3a7RPEOOLer60aGjcP1oQ1okrtVXwPxz4jqxTLiBht8auSallgPyT4VVjnb+oQ+hL/yqj0ClMVXnXfL0p3Ei82Fjmvz1jBsS9eNoGGpIn2KNsi1QCDSLCbLCmKZy0aaQRV97cDRk5+7En/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be23aGg0aX/U5sVxsok/WF5LAj4bfmV94uz22gTMQq4=;
 b=dKHTUUqteR6zR7aLebBkwDxMLKZKFG1TwXvEhoflM0U0DDFeDdqEzjk5/RgYTqEISz91CLKHB9Cs6C44zTHdxsJ4m5wcvdZeOJuL4+9Gxv5dQ/ZCHOkTtwp5pGrB1ffzWJKdypmJlB7s1wBTYygRqgcl+i81U2iI0nmPrdiRt0Df/z/3ZwRDHpLuTxvybX8RdaKtLmalb82BzxM5P36E20heX9HA6CnoHbe3r1BD4U3K1RFMVef64gPP0zbnltWy7ilySZ74wDx5Xa3L8nNlyR9OkQbNnt92qvcImb1SjpeJNZ7OqC+oHKbuBHyoEy7826OSoKboWflUtIS+IlLx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be23aGg0aX/U5sVxsok/WF5LAj4bfmV94uz22gTMQq4=;
 b=j7K1fDG9/x7vVhIyveE1pdgTuTY69QivqoN1WPOJZ4/7L/5L/13/Ehc2zwcOZsuSik4sCCKUv+LhJqohsFUNiexPCyYtotPFXKMYyhy2YKhl46pKKiwuNgHWBoM+Q+FBPVxgq/kaGNHLWu0INwgFDy97E+qIN5nhhMilF/d+/bo=
Received: from SJ0PR05CA0198.namprd05.prod.outlook.com (2603:10b6:a03:330::23)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 10:09:41 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::6d) by SJ0PR05CA0198.outlook.office365.com
 (2603:10b6:a03:330::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Wed, 20 Mar 2024 10:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 10:09:41 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 05:09:39 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the runtime pm mode error
Date: Wed, 20 Mar 2024 18:09:26 +0800
Message-ID: <20240320100926.2614497-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0cf3c3-d28a-41bd-4a9c-08dc48c5dbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrMSDkS4k0LJU5otqhrVzXuwUke9O49PvqtLal8rNqiXXXYpxaiErKZbotJZHszhq5rMAw/Tc7RrgtpFU73Z24ZZbwCdRigSHfrHX4mokFSLwtts8uoNyyYJYUybNxV2FRyq0ZxwIz5WcWYgkELVnLrS49+cVBKl0JhL8uHDWq0exlddhQhIj0XW3Cl1Gl0NnXIyHBX0yGE6jqdtM1g5twiCm2FGElpc1U2XVuG8SUrfV3NAvKcQ4/Bgd8iY4Y8rQCN/8Ipqf2J0B4p39R92i8Ok/xOJzWbGIR/DWwStBtFRHvbLBgayzF42wfVZ9+Q9SBGLhrlFxbYaRB8rrtGBgqL/MpT4Ezm8lWvFX33qwCTeE2wf/8qSIJytc43/lZNB/4zFd38WA4ETaMfQzK2kEqGNHCPAQyVQgpfaNDDJPeNNZMAjAB51TpCEplCCzWLB0cslNGe1t3+oBOD0YfRQpx3FhcZMPhtOS67+7GzN5ejLfQSwoOGq/mlV92OvfYu3CNwQWTi0FOy9Gmp9YPZxco7xZ2dBM5Uz0yTeMjjTq/MBHMX08Fh04nWnZr9zhIRaQqyY3CAnkqmHZxkSPRCZgg5a+xXpTn/GFl1J6Rou4x62cITXqXktDTMm2D104//Mz2UROYhb9nFDg2lRdzplbsOEny2fPD+aVAYVC1Xjpg796fVxbA/k0RwKaqV/Jrx9N9WPh0X+h77IIWaSfKNOyMO0wGDNWTQP97+9RUXuzTuZntuMVqd58WSychcYbl+G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:09:41.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0cf3c3-d28a-41bd-4a9c-08dc48c5dbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

Because of the logic error, Arcturus and vega20 currently
use the AMDGPU_RUNPM_NONE for runtime pm even though they
support BACO. So, the code is optimized to fix this error.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++-------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1f92fb1e7421..70cf2d0c7683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	}
 
 	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	if (amdgpu_device_supports_px(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
-		dev_info(adev->dev, "Using ATPX for runtime pm\n");
-	} else if (amdgpu_device_supports_boco(dev) &&
-		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
-		dev_info(adev->dev, "Using BOCO for runtime pm\n");
-	} else if (amdgpu_device_supports_baco(dev) &&
-		   (amdgpu_runtime_pm != 0)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			/* enable BACO as runpm mode if runpm=1 */
-			if (amdgpu_runtime_pm > 0)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		case CHIP_VEGA10:
-			/* enable BACO as runpm mode if noretry=0 */
-			if (!adev->gmc.noretry)
+	if (amdgpu_runtime_pm > 0) {
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+	} else if (amdgpu_runtime_pm != 0) {
+		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
+			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
+			dev_info(adev->dev, "Using BOCO for runtime pm\n");
+		} else if (amdgpu_device_supports_baco(dev)) {
+			switch (adev->asic_type) {
+			case CHIP_VEGA10:
+				/* enable BACO as runpm mode if noretry=0 */
+				if (!adev->gmc.noretry)
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			default:
+				/* enable BACO as runpm mode on CI+ */
 				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		}
+				break;
+			}
 
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
-			dev_info(adev->dev, "Using BACO for runtime pm\n");
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
+				dev_info(adev->dev, "Using BACO for runtime pm\n");
+		}
 	}
 
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
+		dev_info(adev->dev, "No PM mode for runtime pm\n");
+
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
 	 */
-
 	acpi_status = amdgpu_acpi_init(adev);
 	if (acpi_status)
 		dev_dbg(dev->dev, "Error during ACPI methods call\n");
-- 
2.34.1

