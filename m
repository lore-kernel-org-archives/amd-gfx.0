Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065FFC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 11:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A80810E5D8;
	Mon, 20 May 2024 11:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="By7FviCr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F6310E5D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 11:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDhJOnFvQSh42NcTCjck6e9oTIENnJRbMiIA6zS0XpzgRAywiXPoM2kuEtZ3Rq3nbEtpEhMaPnfsO3GzfYT3z8+LNbiRHLpL4Ikjug3aYwqQ0mJMDsyjskMGKB5vYJDffBlD62UxBNJ+AqFE16ZPk14AaAgC4KYYj831/cXW3dwGBrQv7bH4lmEeUh7475Sn3XE1hw5/t+poicPjlmHwyRgKX0KIKiYRGFgtySm6nH8i8eVCcvBG6xywR9ImcUlXoGcDQxA/C+lsVIF15FQgrxCtJ3Nmf3AMJvi8XAN5XeR4kbtN6tKReEzD10b3XBk8J1pnSOLW0kAccBd2GByT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tjmGjpl80Aj2S3sgs8QiZmKv5oSBdcz8J7V3abqPh0=;
 b=gFlcdmJbKyuduYdChxMIbHjsg0EN9npGlh8iWtIs+wf3BAmoyrfn3RCGGh+Xo2jcDirW0ulmXIMUWueOKszbgm8hwDYZqUyGN/TffqlPcgi9Bc26yvDDMtNAxtyYfnvo6dP6Z/MDeaWeY5GqNXLA5kitB2IvFhwGqeU64YWIO4dQzv8v6pXyjewx0xmpjJZR7G88VyZ+wbcFeyZ4e/3a1Hb5zzGoXFPDZePeF2COD1lTFmkGhkKOS3ZerD86XAVzdM1grca4DpJBusBtNd7Ui3qHfCYskZE+GacUdvW2S8AreDgy5rw/H8yAF4zSORZpjuAxAZZJ4ZErKvHqYI7RbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tjmGjpl80Aj2S3sgs8QiZmKv5oSBdcz8J7V3abqPh0=;
 b=By7FviCrCOHM27WGEesuwhfn45GSQ2BnJOC/Wh2LRHWO8tjRKveOoywdDnLTOcvGwwcfPe1o2Pw2CnBeFGQXQSIkxiqxALnTKj6EgiEVCcqQiTZ2vllUSi6q93xIFV3Jl7M8uwd+xVVHcHRdDLVL1hNVBMSh4ZcUZRX2xnBhAhE=
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 11:14:19 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::1b) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Mon, 20 May 2024 11:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:14:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 06:14:16 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 20 May 2024 06:14:15 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the inst passed to reg read write under
 sriov
Date: Mon, 20 May 2024 19:14:13 +0800
Message-ID: <20240520111413.2070726-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b243a4-66a7-426f-d3f4-08dc78bdfdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ihZfUyyShwkReWiBS/lId1zzw04C40WHItY9SRtazr49Qm3eh+rEMR/IzuKt?=
 =?us-ascii?Q?KvWJb1fIMmvXDaB7+t5o7laxitwBtN9t5anH5o5GxF11PxRjxjx8New369ka?=
 =?us-ascii?Q?0YOOFSnGY2KUyEouL37gjeti/jh7WvGR4ab9SgbfVtGzNjy7bl7sepiJJFh5?=
 =?us-ascii?Q?HsrAtYwq6GuPwRGTkFwbQiMnZivEPwgaL+OGyqi0+mOs3/EGmmw9XrwlAaoa?=
 =?us-ascii?Q?lpgngjkXAl8onGZja8Bu+7TftsGXhcCFHlPc0+knzVCHkXaYGJ3mP4ONoGK7?=
 =?us-ascii?Q?za6VNbHFWW7MMvANauYEKaHhWz6ZHXMiPawLGyYURScBK+6Wi72/VPmj10hI?=
 =?us-ascii?Q?A5BqSclGzHf7YcpiTaAo0KBz/iwNDVeirr5E7Zo0lXx8QfddRXSkOdmaz4Fj?=
 =?us-ascii?Q?IU66nY0IyTxbgGYa5DvOEK1/WI4WOhRuAfqa4WKAxUBsEpnP4No1ETAAmaDa?=
 =?us-ascii?Q?424Okfy5MckHR1BEDhUOpUdP/xoe4QtNXvb0vXARsZf198ivmYRMnEy34cHo?=
 =?us-ascii?Q?ser4xvGWAMOIdAsGO5Eb6qmmGGhiEIyUiw/SKDffCwpfpjjm+qjgbYYAbSP0?=
 =?us-ascii?Q?4iTw6W0p5tEOhjpGtl1hHLoQJ2vDZIpd9GmbDRjiqJX0h3fw2SoOh1qn65b/?=
 =?us-ascii?Q?sbcqwa8PJbUYbahnf9CvHxDnydObXD2/XmGhUkZkK23U0uWliWLhoduaqKaJ?=
 =?us-ascii?Q?tohGYET+oVkrscQ7dIrfDju7fcCVQpKqAqFy8X7DhlnbC5cK2ri+DBdPFaQS?=
 =?us-ascii?Q?NXyqL/WIeu3lAkykFzxy2YbgLJOQzaJe5dWD0i8ewb/BoAgMLguIFRYXXUka?=
 =?us-ascii?Q?qyivP/qSn0EdH5d80CXzNFZTJDjqbgZgrYESxzCUFKu5QtNaOuzXCjX6cXPq?=
 =?us-ascii?Q?IG6jmWQs8wev5IvDE9VyLi9mBzYsI8ZtogypyimZoS+AtLGLP0234gI3kMsq?=
 =?us-ascii?Q?7VTGHe0/BFTC0rJBZ2LrWw3STSaYnoOfvK4yLNFhBomuwSWB765tlPkzUJbz?=
 =?us-ascii?Q?jxZnRuIlDYngrPpYHK8H7BdNCgQCdq7+4XKoEU0nTW3yeFtsDZ6vr7JYWrUh?=
 =?us-ascii?Q?eYAYR3R5nF7kasNfocbnQpjtA85hIHLHFLwoAS8mvBC1XHgGem9NUQauYM+v?=
 =?us-ascii?Q?A7dG0QcoWznwKrQAUITiICkCcwKQktyRZ2Uh3mGBUwfjFWmaZmIztAgztuQ+?=
 =?us-ascii?Q?taZCylI8KFXkG1txPVSPxiaj4lUfHieo5bpVrruzymRimWG2Ya0d3n7mtEni?=
 =?us-ascii?Q?3iPwbsffUmAJxPYUt9e9X/ywdPsDpBYr3xIWrgqd0c9P3T0LglVIPsysfM6q?=
 =?us-ascii?Q?55CaJMWmiMm7pFEkCPiajddt9FgXSJgonDfpSOjwMV9rdli2kVvil0MgdShL?=
 =?us-ascii?Q?v4sG01E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:14:17.9746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b243a4-66a7-426f-d3f4-08dc78bdfdbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

the inst passed to reg read/write should be physical instance.
Fix the miss matched code.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  6 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 26 +++++++++----------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index a5c7259cf2a3..319e6793053a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], GET_INST(GC, inst));
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
@@ -493,12 +493,12 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high, inst);
+			watch_address_high, GET_INST(GC, inst));
 
 	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low, inst);
+			watch_address_low, GET_INST(GC, inst));
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 5a35a8ca8922..76be23dcea31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], GET_INST(GC, inst));
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 07b299ec7169..349ece5a27ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2812,16 +2812,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, GET_INST(GC, xcc_id));
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, GET_INST(GC, xcc_id));
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, GET_INST(GC, xcc_id));
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, GET_INST(GC, xcc_id));
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 094c08cb98e7..aca842668c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -496,14 +496,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
 				else
-					tmp = RREG32_XCC(reg, j);
+					tmp = RREG32_XCC(reg, GET_INST(GC, j));
 
 				tmp &= ~bits;
 
 				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
 				else
-					WREG32_XCC(reg, tmp, j);
+					WREG32_XCC(reg, tmp, GET_INST(GC, j));
 			}
 		}
 		break;
@@ -524,14 +524,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
 				else
-					tmp = RREG32_XCC(reg, j);
+					tmp = RREG32_XCC(reg, GET_INST(GC, j));
 
 				tmp |= bits;
 
 				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
 				else
-					WREG32_XCC(reg, tmp, j);
+					WREG32_XCC(reg, tmp, GET_INST(GC, j));
 			}
 		}
 		break;
@@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		inst = GET_INST(GC, 0);
+		inst = 0;
 	else
 		inst = vmhub;
 
@@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, GET_INST(GC, inst));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, GET_INST(GC, inst));
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC, inst));
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC, inst));
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -904,9 +904,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, GET_INST(GC, inst));
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, GET_INST(GC, inst));
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, GET_INST(GC, inst));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC, inst));
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.34.1

