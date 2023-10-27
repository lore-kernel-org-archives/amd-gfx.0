Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C9C25B48
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4036D10EA3D;
	Fri, 27 Oct 2023 20:06:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547F110EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrCdn9ABgbTqUfT2u9z0EIK+MHLRaLrl9Yov7l6mepYecBYuy+iXeKnatByF0qI/J+djDB9+GENSjbdelxXrWoDAIfc7T8S//ioYoF9LihpzU6pBRzVFTjkMmAyWhvwXtREKwNVXhwpv9MqFrO2D4Q3ISit8BQPYVjcJvwKNHnP1GQ/K0l1fW4hqzTV3KLjmVb66JTMxnrq5lM9EM7mAG7UyakjwNS0enQA1Vm1ptGfHJN0clxSFmg+YA8rGRH+qc3rOErE28YQZ/zserpTesBalGAk43a7jI4JhKbiHoASkOPg+rn8nMoJyTd5o3Tc6DeaUbkhV17OaCpp3qE0/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0ZYYJxVEC4792kpWwGZn6Q5TAMXHgJbXdlfgXRSNhs=;
 b=jfjZjTnvPdcvDSjwRd3kNP1EDeaprjTiqHnFsUbpCqcfSd/mYHhS2U6YmsGwr+llEQg0GLEc4u3PzQ5M5h/hO8wCZ2RWfo5sfe5V4nNq/u+iaPiBHg7qkuU5mh91yoiGz9s0eISe533dHG7SSgizF8TUNGRzNT2TF83RT3r+5TxCU9SQVIgVN0ypmEyg0k/163RGiMBIb4RhuJh1R8OXnS3bnEh4NOifmT7Vap+CVcPkUHhvds6+BTSwQ9dJAAbDlLXiGG0hHESmQewefLBIRdqzhykar5zzqv5DQoy0lSlWlu8lia7UrxAVaG0nNLj3fCypr1sr4COUVw+evBl81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0ZYYJxVEC4792kpWwGZn6Q5TAMXHgJbXdlfgXRSNhs=;
 b=kvNG51AnC03r0X2ckpYSHouAcF5fq1Iv2b5bEObwa2ZnOVEFhrjEyUxuxtbSalf1Vh//di5IemYt6tSns9u21cPjQB74RuOrJGs5qAl45/azHs8Y4Xe0FbLXvOu2KfOhecZ2pbqSbNhOoDivoPEIqXWf65WWUt+4juybya3ywew=
Received: from MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 20:06:47 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::77) by MW4PR03CA0013.outlook.office365.com
 (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Fri, 27 Oct 2023 20:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 20:06:46 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 15:06:44 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ (v3)
Date: Fri, 27 Oct 2023 16:06:14 -0400
Message-ID: <20231027200614.2249-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ef27e68-be40-fce4-1f04-680ee74833d8@amd.com>
References: <3ef27e68-be40-fce4-1f04-680ee74833d8@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7860ab40-37ed-40dd-f837-08dbd7283f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnUxg+glqgc6B9/dpqk9zJwMn+MGzXBfxeut63QFya3a8ZBwGgX2iazBD+jDZTBtQ9v+7zGr96P8lDdeSPTVv3ga/taz95qAB5jUDr5TfkIUxd+gJdhHe6lwANPkOfk2T9bxfsk6O/x7AA5HK6i1vAtterDdUWYS1MS3OhU/nsQ90SgRLHDdv5O0VQbePNkCAVTi1bPRI2DNLTdihNEGGP1hDmmEGlyymGE0rYGh/UuZRofekCluUGyEJQIUlp+MhSCY2DJvOpSSxpL5SIVuSYs/4Y1X1mVP6hTcZkhYoteGSyLXxRa1sn3koTs1J9mMQtvqxDcaQTjMNuYKQARDq3yRQpDT8+xeOkAdoYMyt2Drx/WnecikCeE8wUk2IYhcSnfeWGKAgZ3oEjcREFuacpV4zMrsEYOn+Hbqtvh364FwE8Q/a6Xl0ocV8Vbc46AETp2YoRK4Tp0v5vM+cLY0TqDEyh64SJ3eb8f4jG8FWJ48U8iBnc9zFChwk/WGQFZZZVJuijD/WO80kEWDfNI5QwMoYR0nL+hK6K1acVuufo1bWi+4ORggHUtawC/+b+AtwCFZHTr2ET4ZqPzSf+MbQtW4B9KXBw7YCmrYeXTwXt5x3KscWZN7+SVVcl5uz8UUiVp+bdPtxO+GhDietGj7jqhLf8YLa6+5+A6qgHvrVqhgNXzqoUTqyu83O/UjOLzL0xdSV0JS6v362JacS5J8HUy7UF8GfzpI2ICqRJkxdjQjuJ4Ve2MJHy/cManEJRh90BGIgxOFnrgCdPcQqJqJ1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(6916009)(2906002)(7696005)(40460700003)(4326008)(5660300002)(8676002)(36756003)(8936002)(40480700001)(54906003)(41300700001)(478600001)(70586007)(6666004)(2616005)(1076003)(316002)(86362001)(26005)(426003)(36860700001)(16526019)(336012)(70206006)(81166007)(83380400001)(356005)(82740400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:06:46.2978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7860ab40-37ed-40dd-f837-08dbd7283f56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
when programming other XCCs.

Add xcc instance parameter to them.

v3: xcc not needed for MMMHUB

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3a1050344b59..0ab9c554da78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -856,9 +856,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -869,9 +869,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, 0);
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -884,9 +884,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, 0);
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -899,9 +899,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, 0);
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

