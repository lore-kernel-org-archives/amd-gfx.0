Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA60C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 03:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16B611ADA4;
	Fri, 20 May 2022 03:05:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5269C11ADA4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 03:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBFU8SeIGmouRngFs9VkEbnvG4JpiU3RaeVxqGRFzcAI5gYyFimF3H09Dj4jjE69xFM/TLTKOeQj/d4ZaI4x3cbtl/XFQubEDRSv1qzWO7yUG/U137sSd3OQJP3xw+EjPo4t8tK2rMKdJVGs7dkZvnEoIFQjbzim1Cqg72V8R304GnXdakd47RHf/eV9QQVSJxJWDfKm4+p/KgcSYKET1Pf7PyheFzY7zEsMcge0LoAxdxBY/6SbI3pGYSjp4vwD6zXnSq3ve9KBcwUh6tgyUGUh5UTsQJmNg+7BxEZle/n66Y1nygY7NmPfVW+GLzFi/HhCkcf90/0CXA+PjPpIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E8pyGrjO/FXElMWHI4wG09k0xIMWK/EYVh5X0mTWRs=;
 b=CxZz2+khAQ44zHRJKOuka6+RaGGhY8/HwuOD8jKyYMxBxKx7pSKT78O+9vd+ORlI9E7UB7qFESO4Q3gwvwm2wPX8kiq/SqbtmDH64VKkz7ehx/mK0GI7DQNzgmrWSx8ZNZKHob/zfx0Npe0+18KQRgxzxygMnBQfIkTgiMUFC1syqBsOAXQMnG4gU71goHLZ9UXPtpknc68aNgf3yWICOC6suYYlV8F2qCYuNf4PHtO2LpkB9vMikxfRKMAgnU6jwaubBMm2CHEnaTvWtRnO3uDppzGOZ6161zLbMViUYgukPXBLiiGtWcd8GBfdMSI2G9bpGwWjWmODovBvjdXG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E8pyGrjO/FXElMWHI4wG09k0xIMWK/EYVh5X0mTWRs=;
 b=s4VoE53H7JwsnGgLnBnSq3gH078DF9BagUbXNW7v79ib02IQ7XzwHcw2aBdweDqiK89s/q8wMiwNeeg48/uow6Pjw78+onH2Dt3NBoWCSXHAgfTYRfiOmwvYuBYUPX6eugHoFgxZ7cPqCD4UynOQMaS31KiUHEYEmKRphwxm5O4=
Received: from BN6PR19CA0107.namprd19.prod.outlook.com (2603:10b6:404:a0::21)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 03:04:57 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::54) by BN6PR19CA0107.outlook.office365.com
 (2603:10b6:404:a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20 via Frontend
 Transport; Fri, 20 May 2022 03:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 03:04:57 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 22:04:21 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: introduce two work mode for imu
Date: Fri, 20 May 2022 11:04:04 +0800
Message-ID: <20220520030405.1308133-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1169a926-f592-4dd7-d663-08da3a0d8558
X-MS-TrafficTypeDiagnostic: BY5PR12MB4934:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49341271747C9F1A038B26ADECD39@BY5PR12MB4934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wq1821Z29eHBAoMUeP1vU0Bukuu7eHgNriw4adjem+hHl0RPwrGEvBTmu6F3F8ltgACyKtyet9/CwAzDwhndIDvCa8TBjJbHueX8XP0NACPAufo2plXomgdJOD7olc5MLfbH1cTlDmGoQXBZGr9kp7Xwjdy5l38TS3Ftj+oXL/A6uEJn2mOLvzHgOpxbXj3UpTxC2qmdMLd/Pmuzd4NXSqZB8ReXzhhMoTYGGIcqt4krE8n5Eo/hkx0o7D8JXM41YMwUGSab+1EXtN9s5reRbAT8i1SoDiM77LoXCd+BcdBsEsoDRqU5ytYW9gtpox2EoHheHVsSlXhHcp+ZFNDdrJaUhi90S0lMzmOzveOH8wEqCiwCD7Epa25g9ILmYImgxAqq8yIqtCrHrus4weiFolzxZgGtwXjem7p9BFA8BjznmMp0CB92cxaO+Qh0AxKOdX1QQqF1nZH2NvHX9SgBucBSOp/6UyjYlMeLvHvgHMzLMdVuALYFPFUZXcEU4oyg/Vihpi5K5NeqIMmCo/1ytDLdPokrCMM6FL/wqPihHKwUgoi+G+s25ekhyJhzj8vEzWiDNQpNhvUbyorQTzMLzPeVkDknOPweNjO/wGRgCTjdOQ2Ox8LkiwV2DYn0BZfdpjnDIIBWrBj3iAeEOVjkKGvRIRrzZMfT9DD1TmX7VS6MMHFtZETMy/ECW81QtB4iFA2S1rsBfNvx9SMVNcnLfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(82310400005)(70586007)(36756003)(2906002)(336012)(40460700003)(70206006)(5660300002)(86362001)(83380400001)(4326008)(7696005)(8676002)(26005)(356005)(508600001)(16526019)(1076003)(47076005)(6916009)(36860700001)(8936002)(186003)(81166007)(426003)(54906003)(316002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:04:57.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1169a926-f592-4dd7-d663-08da3a0d8558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IMU has two work mode such as debug mode and mission mode. Current GC
v11_0_0 is using the debug mode.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 30 ++++++++++++++-----------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 56cf127cdf93..cfc4a92837f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -24,6 +24,11 @@
 #ifndef __AMDGPU_IMU_H__
 #define __AMDGPU_IMU_H__
 
+enum imu_work_mode {
+	DEBUG_MODE,
+	MISSION_MODE
+};
+
 struct amdgpu_imu_funcs {
     int (*init_microcode)(struct amdgpu_device *adev);
     int (*load_microcode)(struct amdgpu_device *adev);
@@ -46,6 +51,7 @@ struct imu_rlc_ram_golden {
 
 struct amdgpu_imu {
     const struct amdgpu_imu_funcs *funcs;
+    enum imu_work_mode mode;
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c0a3fc7aaa6..e331ea387ef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6291,6 +6291,7 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 
 static void gfx_v11_0_set_imu_funcs(struct amdgpu_device *adev)
 {
+	adev->gfx.imu.mode = DEBUG_MODE;
 	adev->gfx.imu.funcs = &gfx_v11_0_imu_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 5d2dfeff8fe5..da18d6724125 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -125,9 +125,11 @@ static void imu_v11_0_setup(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
 
-	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
-	imu_reg_val |= 0x1;
-	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+	if (adev->gfx.imu.mode == DEBUG_MODE) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
+		imu_reg_val |= 0x1;
+		WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+	}
 
 	//disble imu Rtavfs, SmsRepair, DfllBTC, and ClkB
 	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
@@ -144,16 +146,18 @@ static int imu_v11_0_start(struct amdgpu_device *adev)
 	imu_reg_val &= 0xfffffffe;
 	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
 
-	for (i = 0; i < adev->usec_timeout; i++) {
-		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
-		if ((imu_reg_val & 0x1f) == 0x1f)
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "init imu: IMU start timeout\n");
-		return -ETIMEDOUT;
+	if (adev->gfx.imu.mode == DEBUG_MODE) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
+			if ((imu_reg_val & 0x1f) == 0x1f)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "init imu: IMU start timeout\n");
+			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
-- 
2.25.1

