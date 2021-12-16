Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DAEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D50D10EDAE;
	Thu, 16 Dec 2021 19:42:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8E110EDAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnn00mpwExh4Z5Mr3Jg72wLvrsuznjQcRqSc+uWRon9qmcYd3gkcb/fCvR7SvmU+uFf9cBs2vP/LE5Qjd3jsq5gYBhDw0FhnqeB2o3pE8Lw4j8Qa0F5yvdllBkRvzDsgfnPXFFqIJ2qxCIUhULpDvp6OfEuAw26iF2hKmROuiyndrYC3UnjJj/rMzaFfBhu8y/Nco8FLVWNqnmOZf5aPeCIT+L0bPzM7KyaDEJCDbvm6MFbZg7E/zhSVCsGGIAXAi5CifaC3Myx7bXVqQdkhd42isfhsd/cyqnaelBDI/TbiewfY+EIWvtAfDkxjNbK0OgxAI7lBNToWAsDq565UqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTB+XERhYPiDafzvLRbl6eXmeOzi6PpTj1JRtLUUdfY=;
 b=VKcXu/E1wClBYuWBAOft08FoK86Euk14SeRWaZDLGneAVsoslFpHr+O4W4UbVXdDGJzUDlPpZSTzZnKYHlZhTxOFCbHH9sxDIuKqYI1DhKr+qi/qp9oSTcmr/tzefgXvSqgOlqNIxMdRks7tx0wtMLHMNazJYOLzAsS3JUMsOGAxQJ5FBAm+t7Y4L3yQzchzHwTJJeDQa0kccRGjka21HxrysUGL58dS1trrU+jdN3WYIRYDm+sL7XG1uTi4T0bpr3UvFwK0xd2DciJQXlShe2o4EXGbgBO5Pu2PjNl7no+doN8oQNvEv0IQpsvOk726U1Z4uN90qM/0bEkbBbzbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTB+XERhYPiDafzvLRbl6eXmeOzi6PpTj1JRtLUUdfY=;
 b=FydGi+O8DeborJqKGKUpYlrvQaD+ATAq+vJhYdlCGToF/8cvjYQ3LOlpWte2vea1EQdOq4y8jEx2NIiDHrVTO+Uyk4kZ9g5DaxsblMTN4wYpBLWvojEOJjDvzeNnijmkRddpWi4tYu6Plz/ztTX/Dk8Q2/Bk6zblayNUnjP1lvs=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 19:42:52 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::51) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:51 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:50 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Date: Thu, 16 Dec 2021 19:42:30 +0000
Message-ID: <20211216194233.3839-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216194233.3839-1-victor.skvortsov@amd.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718c4164-a151-441e-8733-08d9c0cc3f4f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15499AECED2C281FF235AA088B779@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChF3smegvsBsviGTagg8VCSxvcO2Ke0qJ8VRUMcU+L1kJPSGOBNWU7jTJqF75IdwGBblnRIVqXVGeaO7RKoq2iBQH67/hUUY68OaDPkb4JL70TzqebVWTAhbarFmXm/5lcjImDt+tZaliozb5N1fIK+3CTqyAWCRKWKqEUWkJ8mPhUnqMhUZjewGbZ2ZstrYkCXWgv4tArUqgjhq+KeFxiIaFpsjoEezlU+SqHp7agujedfljUPu2dW700+JIcl48RuePbpbWOBDskNbe07zQNdEGA1wlXc+ODkR0boEl3oVRTiEhal+tLrytc/TNDZwU86KkvtG1G43CFXYJcIkaMgUjcaBU85FcWKLtOjEdesTOL18qxXyrTsQuFkU1dQK6FazGOt9odKr/Ure5WOU3ocBS9QG+j8olsq8xVgyCMq4XrbF+SFvZDfb3fhDUm/aV/Cwv+Csl+N5owepj8mc+OCS8NVHgdZNE5QN2Bfr50xpyflfLAkAcJW/ZDIkR9WcqZAtjj7NMALRZlMg8iwpKcMT1RCcngoNY58QqZM3A8JGvmeMMKCTMmdROy2fERyeLlFskRO6w5oCKnztlYogLkgGDzUDMuEk3fwr9Akv6ZGa8UJYUfIF6fOVy9LAc6dEbAdoOrOlVPFTaVjl990lbmueKP5ZXAMxsDgGL3QtJC3Dlw41Jy8Ofy7PvCKthT6D0LZw7quOlk60SO5UqysIphGvIQGlUIQPJNx011aX6/92fRxU57wpZH0I2CexOm+352nxSoaY6VRxaljzGQdOgWrl0FAQTK2ytBZqocd9Vek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(1076003)(426003)(508600001)(83380400001)(5660300002)(186003)(110136005)(26005)(40460700001)(36756003)(6636002)(47076005)(336012)(16526019)(70206006)(70586007)(356005)(8676002)(8936002)(86362001)(2906002)(4326008)(316002)(81166007)(44832011)(2616005)(82310400004)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:51.6892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718c4164-a151-441e-8733-08d9c0cc3f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
index a5471923b3f6..2b86c63b032a 100644
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

