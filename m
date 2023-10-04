Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C67AE8FDC2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74A410E081;
	Wed,  4 Oct 2023 00:56:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1711F10E081
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WElghQ5FYPUmtMBh8b+YbIlSXj20ifmIf2wIOqn6AjjOIe6HGKafjwKa/flnIeXjsOE9ae47HrYAfTmN8NuRwOV66MREMOOY/KKmdiKoHMacCtIqMIwQUK2oOOjqu5rcRI0svHn4HOI/DLVpa8SQ4PGIoLlsnHH3M34rKmMeX9HK37hKJmTyPuGFCTwqxTsfivwQX9nWUFOm6cdGh+8GBiG4qpY5XIqYxptii18Fz8wP6l6dk9hvi8tzxC1l1LZQ2kFoLDVVW9ArQtOPMf4IUFgUlQ8XogYBz2X6a3u+9DdsOPL1KhSzM/FNsnuLwElAvH59G2E2NSeqv5ljV5U1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfG+9ehUUb6aWR8buuHG7enRNuMGt3FYQ/OrOI6tn2c=;
 b=C9og2ISV6pFvNWY0Q7TnTAJ+dUiq6YbxjhsOHVlJYThDcOkiMx10X8MRl7Mu56zYmQ6PCda3ZXmh25XaGTcWnnpoJDUrR1WvAEM5T67X9zLkI5I5S2tfZWNsvunCupzrqs8yYEqBI+SbnSdNRJBlD3VU4Uiagqj0v6+hVcYfY6mbHwKA0iYWl3Tu8HGbAIk+fZm3jy4yBE6M+S35UMuA8h+xFc5SwWRpRrRY3a0miHFDTXc78J4WgD5QzOSUVvhNKEKku4grleUaFrqEwwlXG8LbxikwPyeUr1fY+Dqbv4k52FcQBfEjefPm9NXa2NDEZ+BhJu46cx4s7jiJ/ONWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfG+9ehUUb6aWR8buuHG7enRNuMGt3FYQ/OrOI6tn2c=;
 b=aW9oYm5i/35myzmh/SRgLJJN7e+cSZgjdVIaWDqk78vF2LSb1EoKLlKbsAdabLxohSwvoDraijZ1x0uZSQGmLyYNypMghwsVP1dTW6sOKESkhuhO+iqwHnnz52ZyEXWNgF6JNCFI4Hy3L2+V9/EUvRD1Qx+Ck9sOcrhYPaQoXyQ=
Received: from MN2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:208:e8::23)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 00:56:41 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::70) by MN2PR20CA0010.outlook.office365.com
 (2603:10b6:208:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:40 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:40 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ (v2)
Date: Tue, 3 Oct 2023 20:56:12 -0400
Message-ID: <20231004005616.108476-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004005616.108476-1-victorchengchi.lu@amd.com>
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc34d83-8df5-403d-7a89-08dbc474c545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJp/2Q7qrlWGsDun2z1fGvSBaSMeR/Ayx1jyJEtpAIjP7KRAUhkb1cCtz99VGYu4/tNKI9Np0zv2du4yC3PofaqbPKTdpA1TEbmlkgozx5UE3VhoGhyPUMJmkOUkSUSKjApWtoo+ZnZ0w/OefitmwZZbGOlAnPsggrCSgS9ubqDyOEjM0fkzN/HtPeo7DbSk1+gU/UDn0V9ws/Ho7ZB7j4j6rWyq8z9EPZbmojcHXlVK/nGIKUzyXYMeeNGbIuNV6yW2IigItU+cfWGBUgAvBawOT+7t8FcWWrIbe/cg1PHGM8KXYdPGEWJw2/HZl9sCuu7Bahsnoe3jZ2IZGY8TSMpAIYQWKViZoEDcaL31hqV6X9oFByCC8LOpGGu6xfxjR+R+S6wfBZYC5Bebjwg1Q7PhN6mDOwNWXc1YnXIYhWc3qTBNIVgJh/cYQRGZeqduKOGfC+Wpxf8XbelABBqclajZeWAwi7TIra6KoGr1bryNjtIlJ4Cg4x/XXQ8I4X1z6G0s3M81DjqZ5Fdf/ffWrUrMzqvIY2taTTJhYiaoyMhNTZzAHekq5dPnQqp8OqRyY6K+t3Q/vtSc0BhxBzpYKJKcPOm8qXg8wTOvK278qkGL5vktRq/b82mO8iefM46poHE3iZg5RuQnIeAEWc9dDNVGhx5PW+O7/p5BhUaNag9bVQozI4auO0c3oFf65LKOJQx55HQbA022nf4C2jqE6zETepTfQ4g4a458uzaYuG2KSgt/QQlajf34z/xBVrkXw8uwfG013I2znKRUSNBZkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(40480700001)(70206006)(70586007)(41300700001)(6916009)(316002)(54906003)(478600001)(16526019)(2906002)(8676002)(86362001)(5660300002)(8936002)(4326008)(83380400001)(36860700001)(82740400003)(356005)(81166007)(7696005)(6666004)(336012)(2616005)(426003)(47076005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:40.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc34d83-8df5-403d-7a89-08dbc474c545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
when programming other XCCs.

Add xcc instance parameter to them.

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6b15677c0314..24f6e070603e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,9 +853,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, vmhub - AMDGPU_MMHUB(0));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -866,9 +866,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, vmhub - AMDGPU_MMHUB(0));
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -881,9 +881,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, vmhub - AMDGPU_MMHUB(0));
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -896,9 +896,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, vmhub - AMDGPU_MMHUB(0));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index da683afa0222..c75e9cd5c98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -69,7 +69,7 @@
 
 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
 
-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg, inst) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
@@ -86,8 +86,8 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
 	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
 
-#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value, inst) \
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-- 
2.34.1

