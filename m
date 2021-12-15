Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C417C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 18:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E492010F83B;
	Wed, 15 Dec 2021 18:55:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7410F836
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 18:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVNnVjAsCubebkxhhmMldeA1v9TExfhZzJ8NIe1piRHZ31L4YSS+vBZ3FZPgWFNDrScOMrqW/+ijM/L8zZfOFOJkDF6msshpoosFaoXOQ8EGMrqWCWfy00aL5m/H/GpOUTDYvm/ZarlMr1syttg6fAz4hjFiO+sSOpcNR6zMifs4DIjWkWmiGenNH2DKBghw9ppPZYDQbYlbu5ubu2jbky1EzLgjCcXeTdFnh4KYNFSYcSn5atexDYHghE7G6htKZRu7Ynf3yfT/pttJM1hblmVHsUdgVKQ5+2lqNajxheWswnB5e67DAGwsTas8V23Fat9RCT4R9vssAWXSmQBT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAaH2ghl+H+sTYN5Dk8NFUGcCF4c1MiqDuEs9jK97oY=;
 b=Dq/rzP1VaNZXxxsyE7E9KThspitLE7iX9ngJyUNtR1y5PAoL4FzlcbxIuo9U3lqnlEypdKSVmAHCtvs9MfWveTCEtUCj3fF22EwON6Q8/ErvjTI70Mlk4iHDW5pCnj0R3gUo9K6o8Z//B2tj6wskHoi5GvrAVCjwp8I/lZ5ihXRwCkjtp9pJsGu6B/q6Mr1eP4qLqHylcqAJNpomS8mC6r/i7jwkbmylDwdlDABJ+YUeuWJTA3C3eAg/46Jm6o/y6QKGaWgwA+4ZHnNB7mUprva4jwkC+QV6uwwBOW8cjEDH07+J6OIPpo8A2j69cFD6fffVcfbUKWHID7dE2qqFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAaH2ghl+H+sTYN5Dk8NFUGcCF4c1MiqDuEs9jK97oY=;
 b=34VOIiXwGl9otQju7BxIQU7sPJgkPqCt05DA2UVxPB0SQ+NcpdxNKCOQLVlaUXJG0t5vczu+NIrBAwHAbdKfOs+F1vNgWKds2n1hhAdNDVwu7/bDq5xtWQzYxlDK6HeE5xDVGCekkqde7kEO4lL119QKMy60zApoi2bNPaqkuC0=
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Wed, 15 Dec 2021 18:55:27 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::81) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 18:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 18:55:26 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 12:55:24 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Modify indirect register access for gmc_v9_0
 sriov
Date: Wed, 15 Dec 2021 18:55:07 +0000
Message-ID: <20211215185510.15134-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215185510.15134-1-victor.skvortsov@amd.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8bd586-352a-4478-d245-08d9bffc7552
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB534338CDD67354D084EE807E8B769@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89LQlPSV9du9yWd1XmI7UZhgq5ty9IKda4qPR2eGZAUmBVzanAOq5DSQKMvj75YyX9GKq252/5cKOYak07WVWpZjSUUuaNTSJepPuFyYSyjUZCwG3ufJb+zgARgT5WVGaTtiPGT87ZbAWWGGJs87N5xbvYxAPudM1iREFHoWadhT5E+h41xt0eJ0nr0n2Ju9VjeeqmTRCkwydHGWeLrM40D6Q6kctrT6XNKD5wC+lHozQ9WvA2vyN1rEaoCJGBZrsL59j0GwjoOlNH0TtT6PJLQJrXT4SlvEEs8utVEzWFaG9w9qw1v9uEbfGkuy4qgSWIfSx/mP4W24JIT4Ur09B3UOxIHsJ+lv1ojqU9iIpBhYPxjpC5FoK1/xNI5aLxvjQkIUSgzh5zxsDczb/cyGffrAWIgXa/Tk+TAXpxN/12EtJY8cyJ8TVljV32qJLM8suEAo3XCLDBOzjvV9zZvgYA6RUh/IYd28a5CMAMaol4MTv4jBYRv/yE1vJW/IUmh/THCfVcFcCwa6pKKZyvbgxJj0P73e+tmJYlsGgL/8F3EgLWGUYDm98Q63ueUcvXQjppN31dc3NPgJiOHvQ705BdpdHSatY77FevFLxIscPyf0eYAvOrXnxUTmsGcgwZVhtYkLkPmD/QJvB62dGFUaqLwRgJP2nhHZmJ27YLfHvfujQbafjiFoBsWnGpLm4Xp3vFgNzlZfpWZM6Wp7+HVMsLZdKSfLe+wpkUGBRGnF5OmzRtoASjPJ+lYq8E4Jxcpz/Mp30QTL0DfGosH/S3Jqy9JdqlHVDFltxRUAQDG+0no=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36756003)(8936002)(83380400001)(40460700001)(86362001)(2906002)(2616005)(81166007)(508600001)(36860700001)(8676002)(426003)(26005)(82310400004)(5660300002)(7696005)(44832011)(110136005)(70206006)(47076005)(316002)(336012)(16526019)(4326008)(70586007)(356005)(6666004)(6636002)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:55:26.9724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8bd586-352a-4478-d245-08d9bffc7552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 45 +++++++++++++++++++--------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..345ce7fc6463 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -478,9 +478,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
-				tmp = RREG32(reg);
+
+				tmp = (j == AMDGPU_GFXHUB_0) ?
+					RREG32_SOC15_IP(GC, reg) :
+					RREG32_SOC15_IP(MMHUB, reg);
+
 				tmp &= ~bits;
-				WREG32(reg, tmp);
+
+				(j == AMDGPU_GFXHUB_0) ?
+					WREG32_SOC15_IP(GC, reg, tmp) :
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
 			}
 		}
 		break;
@@ -489,9 +496,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
-				tmp = RREG32(reg);
+
+				tmp = (j == AMDGPU_GFXHUB_0) ?
+					RREG32_SOC15_IP(GC, reg) :
+					RREG32_SOC15_IP(MMHUB, reg);
+
 				tmp |= bits;
-				WREG32(reg, tmp);
+
+				(j == AMDGPU_GFXHUB_0) ?
+					WREG32_SOC15_IP(GC, reg, tmp) :
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
 			}
 		}
 		break;
@@ -789,8 +803,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng);
+			tmp = (vmhub == AMDGPU_GFXHUB_0) ?
+					RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng) :
+					RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -801,8 +816,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	do {
-		WREG32_NO_KIQ(hub->vm_inv_eng0_req +
-			      hub->eng_distance * eng, inv_req);
+		(vmhub == AMDGPU_GFXHUB_0) ?
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req) :
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -815,8 +831,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				      hub->eng_distance * eng);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng);
+			tmp = (vmhub == AMDGPU_GFXHUB_0) ?
+				RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng) :
+				RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -827,13 +844,15 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+		(vmhub == AMDGPU_GFXHUB_0) ?
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0) :
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
-- 
2.25.1

