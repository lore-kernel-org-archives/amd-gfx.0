Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EEDC04ABF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE7710E533;
	Wed, 20 Sep 2023 17:58:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75BA10E498
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYw7AHbBGjMxEKDVXEjdGQlQoJ1xWiGmRf1zuAsGi/2MXRAfyIi2EXP7yw9J/+GQwSp4RmxDfMzlK8a3pk9HaDYBImLsapLqe4dARxb7ezAolhanUi3q74uq9tPzpNKlDHMZuJz/4sJDO1Q41r84lkRHkMDHUEd8Ybmfnmu9r3+v5rt5gQ2LyEmCsHdj3QryafWa/pC9wqESUgrF3g7tjdG/QWlMyx9sS+wdZKkhchYQHcWdyKQQx0px+Ky5RaaGH7z/Ct7CSkGK2EmrQrmYNSwJUdSxRCM5JqgrJ9QGWh7IpV7dRzWgSduN7bsNkwOx9hhqQ9j19ICDKZExjcu2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0B+ZgEXXDxxKyKejiw9N2sFBascDrD8TEGJb6ndZiI=;
 b=bocrSW1I6lI63DdiI9Td3epdEBOeezgIKhJcrNsQJWEifP0YPO51a6D2Le3vroGQMSO/pWDexPN0lq4mUduSXkeqXsnVWoJ1AlEWOWPMrhlw+H4I5EajXvDmO76YWAY/2PyXXwnrC6lbnZNVXgDu0ItkQwRJZdiE6RN3BHELOMkBemVx5z69Zeuhh6GhR5TxZnfUVEgmHTFrgJOAvmC3vkoaEQk3Km2cmb4aVvh4pyAFnJY/fxKhB1m7+ODqVgY6MZjCDij6+CN4PwDyf1YZbH8b4xIGsBHF3dUqEsdPytKRBEZjHAPSDvd4kEOjT6MMbXTzZW41lfgrPcIUb6oFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0B+ZgEXXDxxKyKejiw9N2sFBascDrD8TEGJb6ndZiI=;
 b=TzCLW/fXWrFaBqZTRl6Og0YAdcAwsaz+SBrUjkIiUvmQB4b/uiXlPl0wyp92UlwTtT4JZooBlPlcd0Ct5+1dq324bfm+Lvjuf9X1QCtpP7vtUBte7oIBALP4ExV6wDm2ddGX6bQJpqFuuibEqP/ZYVdqyGQPjdCstEaPw4w6f9A=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:58:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::c7) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.3 via Frontend
 Transport; Wed, 20 Sep 2023 17:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:58:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gmc6-8: properly disable the AGP aperture
Date: Wed, 20 Sep 2023 13:58:21 -0400
Message-ID: <20230920175823.3099627-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b6eb14-163a-4aeb-04bb-08dbba034178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBHC0EwEQAdCTTFyu3HwAlcjC0PGfquw7EQydavn8eAkb9PrvQQJv5SxDpSt3PaaoXzvX+zjCSpCyDuV8F0K7tNwd5aWm4tWbI0ByYTrBti1xdM9s5ooVzXhgUZbHmKRpnCrc7nR8rNZL8qkXPyRxADCN6iMDg2l0F7r1hoz5ul1ow7wLFm8Cp7fqwv+eOfslX5yUPz25BJBJKY/4Asmdz6Tlbv+3ddpiPYOtv4Th/lTmv9z/jeDYHae4aRgnKwQVnVCaDt5mf59/iv261u/S7e3pQgcQhZraYkzbNbbgAK3ien9XegqWrrUCzvTF77E47VHw77XLZg1E91bkZS+Qa4xW0lkdg5Gu9Sz79Tscq8LyQ0p3LoBiPMbsyaKAB/PnhVsIt1/C3Y1xjRs2AtWKFlVGYTTCvbDScwvhBW7qFXbYo8+Xps/XR29589XhvkUSwjD0D/JM2dG4xmTFciuv0TJ0WbsUhEJ/zUWz1H/AehqYAC9K4+fHfJCPOQy1o5s4yf9FzlfesJqhQWn3u4BDM+9C1adFgO+9YcZrSufMSatjOedqPh4E7zjY4jlWJxzm5AW0UO4hYaTPjdXx+MnHghMYlfE24ZY0X7JHTNmZv+ZJTT3RCDgcF4Ao775ZXsCWs7wwRAAu0dJygtY+IMTIl0N8K8BvrfPj0lK1jTlAMNzbOek00vIwaU/CapCIPSXwPR+pW9yhxNyJOo8PZQ7OhioUe4oPRfXDN8QVjAdd3mo/Rkhy/Tti+5c/tnUX0sCzWSiZTJAkMKgwfavg1Fq9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(336012)(426003)(83380400001)(5660300002)(26005)(4326008)(2906002)(2616005)(316002)(1076003)(70206006)(16526019)(8676002)(6916009)(8936002)(70586007)(41300700001)(356005)(40460700003)(82740400003)(36860700001)(47076005)(81166007)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:58:54.8016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b6eb14-163a-4aeb-04bb-08dbba034178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

The BOT register needs to be larger than the TOP register
for this to be properly disabled.  The lower 22 bits
of the BOT address are always 0 and the lower 22 bits of
the TOP register are always 1 so you need to make
the upper bits of BOT larger than the upper bits of BOT.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 5b837a65fad2..07579fa26fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -253,7 +253,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 
 	if (gmc_v6_0_wait_for_idle((void *)adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6a6929ac2748..e77e5593e1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -288,7 +288,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af235202513..6acf649469dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -473,7 +473,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-- 
2.41.0

