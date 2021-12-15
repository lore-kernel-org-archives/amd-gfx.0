Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33695C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDCDF10FA13;
	Wed, 15 Dec 2021 20:45:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B990110FA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFWbdNkOsGH7AYXWTcbduyNGX95nGT3eQSPO+ShYUNVoTby9tX9ZLpI1Ueml1Ly4GlM4g/tQvo3ppyIuW76U9g55peIXU8KAsASd8rm+I5Exm0lMDSKVRFLzxZOrtFLSi9slJrbSE3LCwmnsr4DE61yYxSR78nSNhI1IythXxJvrZIGVtrP/mkc4NjbxhYFlvrvUfZ9N24iE5/YeqXsrIAO9z+/ZZ0IxtlO1Tg+siuTkr9urn/qjWaiRt0TFR4COZLLseRjc7kUgY58GvhMfJi8KIt5d6owMNpqiVlXtd54jYWiwMb+mwYdaWX2e7gnhv9ehUuNPWcL/Ym+Dk7K+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Mk21wBoEUSUWcLyBwj/LKFbdee7SNy0qj2j7NexvXc=;
 b=BREgWc6vyAVlZP0MrJh5dDrHHjF+wE4BeXwf7Ng1AQeOHSQqanGo53xm6oKiNij4c6PVXeCq/Oo5+t9Qr912lNAkNNvB2E6m9qCjuAyfruHUgse0bvGIQNhZW0jBi4OB+F0dR1/vaddeg9UmtwSBL6st29yK215PskmLAQdffo6BhEideKedo3SuGuhwTKWl8OG0aNX6+tEi9U1halJHTbZLuYAyh3erpLUX+vtuic1K2XuZyADTnVdXSp/5mRL7NrANvQ3Acyk2lRHR0I1KWagZ7pWaP22ZI79nXADWy2e/Lg/D6enrgfGmv56bQ5mB8lk3MxTovX+pA9sMIT1w5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mk21wBoEUSUWcLyBwj/LKFbdee7SNy0qj2j7NexvXc=;
 b=SbgS+j+mtKNtzIYtJkPdoBFtQnnnt7iVHuF393p8ojL3wylVv4/492+/PSNE0pr7F2eJaYPJdDgcZy3JiZMJzghIbDlEP9HnBRVNC5Zwav4obGdGRzypxYIRBpT0wbDhmwEmmX3AwBPfr4ksuQGyxIIoE5ezF+JR2vdfi6b7050=
Received: from DM5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:3:23::19) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 20:45:05 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::3b) by DM5PR13CA0009.outlook.office365.com
 (2603:10b6:3:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.12 via Frontend
 Transport; Wed, 15 Dec 2021 20:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:45:05 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:56 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Date: Wed, 15 Dec 2021 20:44:36 +0000
Message-ID: <20211215204439.7216-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215204439.7216-1-victor.skvortsov@amd.com>
References: <20211215204439.7216-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a988eb-eab8-4da5-d30f-08d9c00bc64b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203D41CCBEC28FEC5E9D5AA8B769@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luxh4Q3BvuvDZguz4aWO/ch05OkiYCuYRkzMHy2lwIMk652a7nA9PZ52wfsQXPQTm0+PxycWDlbuLBXcH1OCFd/xZRX4FkV1oKZIbQyc15xPko/G5HWKSr2W6SrjJksBNzm547f2CNJD9qWNSfMKYbjXY23LYc+x3msRHpJ/o6BNJTQsOgWdpWMGftC9dDZDXOtrp2VameSy068ZcNTN9hPkRztY5LUR7U+Xfgu4aAc4ieAJ1S76ga5Nv8a0TimzWEQofSmOtfHbozbPPulv5YgFR0K+Pscvh4JEHpxqzYkMWFStI5oiZHI0QonwzUIrYYeGIbiARLctrJfeYbX8FnK1qrEq4KMdyRPzLbEdiWXsguKhQNiBOHmbcUSe26JN+g4YqfF8lGrqWmcap7f/xtEs56gy9tO4OJGoJnOJio9Fo4Ffe0YWRsUuQRsJuix+XtCc4GndB4vTZTGfjqul4KR1bChOF3Cj7Ajem47SSR+YtNv3RQK6Vowq8Rbvk5JoYVIKEVonX2kyVVHhBNkKx2iWMANgLR3ehd7hrEa2vlSqSUiGAkgPD+ctHswwvVTlUXT3TslOQsPsdZtUUz/XD8G08zOQob6hK2F+8GHD/yvQ0pKySk6iFEhRJZEgz3EkbYQhEnemk1Sg7viF4AVKckPVlJxsDUUst5XKeBJnYCZUSzPFV/b1tEO6xkw71aNGQM+zXNvtL73tEp6vwCxMCWWYN5xyRaaLeKZmOwd85vNvTx0Whr9m+qm2VVA+f3M5VzcYam2JVJLq4hes2GVfTHEA4D8iDVRKJF25s2h14ZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(44832011)(40460700001)(426003)(36860700001)(36756003)(6666004)(508600001)(5660300002)(4326008)(70586007)(2616005)(70206006)(2906002)(8936002)(110136005)(6636002)(81166007)(7696005)(336012)(8676002)(16526019)(186003)(86362001)(83380400001)(356005)(1076003)(82310400004)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:45:05.2818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a988eb-eab8-4da5-d30f-08d9c00bc64b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify GC register access from MMIO to RLCG if the
indirect flag is set

v2: Replaced ternary operator with if-else for better
readability

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 57 ++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..e85a264c971a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -478,9 +478,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
-				tmp = RREG32(reg);
+
+				if (j == AMDGPU_GFXHUB_0)
+					tmp = RREG32_SOC15_IP(GC, reg);
+				else
+					tmp = RREG32_SOC15_IP(MMHUB, reg);
+
 				tmp &= ~bits;
-				WREG32(reg, tmp);
+
+				if (j == AMDGPU_GFXHUB_0)
+					WREG32_SOC15_IP(GC, reg, tmp);
+				else
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
 			}
 		}
 		break;
@@ -489,9 +498,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
-				tmp = RREG32(reg);
+
+				if (j == AMDGPU_GFXHUB_0)
+					tmp = RREG32_SOC15_IP(GC, reg);
+				else
+					tmp = RREG32_SOC15_IP(MMHUB, reg);
+
 				tmp |= bits;
-				WREG32(reg, tmp);
+
+				if (j == AMDGPU_GFXHUB_0)
+					WREG32_SOC15_IP(GC, reg, tmp);
+				else
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
 			}
 		}
 		break;
@@ -788,9 +806,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore) {
 		for (j = 0; j < adev->usec_timeout; j++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng);
+			/* a read return value of 1 means semaphore acquire */
+			if (vmhub == AMDGPU_GFXHUB_0)
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+			else
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -801,8 +822,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	do {
-		WREG32_NO_KIQ(hub->vm_inv_eng0_req +
-			      hub->eng_distance * eng, inv_req);
+		if (vmhub == AMDGPU_GFXHUB_0)
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+		else
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -815,8 +838,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				      hub->eng_distance * eng);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng);
+			if (vmhub == AMDGPU_GFXHUB_0)
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+			else
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -827,13 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	} while (inv_req);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
+	if (use_semaphore) {
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0);
+		if (vmhub == AMDGPU_GFXHUB_0)
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+		else
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
-- 
2.25.1

