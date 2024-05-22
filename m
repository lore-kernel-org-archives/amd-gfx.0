Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52037C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 05:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B7310E618;
	Wed, 22 May 2024 05:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZ4Po5N+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1791C10E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 05:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5E0mWDnt4audNUILfDyUYkl1t68VLzpwbZebUvmc217O3LVnn4lHVBT6FYwpEc9DAYQ0QPhx2flnuCLBXcJaeSSnLmb2sWgJvmrLELMwuId3PcgmyK1hb9WmtftOtaikL/CvRBAqcnWLycAVDu00CSPZg95T2koYRZhI2zlyTsQ3vyazmsMX9PVnSOithMV/oJ9DFZ88xB1Q8qXu2Z8bFgqyYcygfJ+dkO2cmWp6YR9FWGUE2P9X1j9bG0rXogcepzmjmZH2DMJkcM5Q2fRMgDHGTZ0sDhgg0cYsr6Ya5j8y1ZQF31N/T/1HkXkj/3RzPaUuFAoouuWBQgLF0SqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3cZptlPkwSMX3MDp72kpSegIqrlF+KfiOqqvcxFXXE=;
 b=RXfMVCA7Jy+AKGtdT2U5gmoanjzbhm56qOPdFqDgjBhfkOp3SutFH+MzDrRQCVdgggbIHH4gacWBamxZtnx2KwtVYi9LFAF72DbT68BMm45JBdfy1h28wpW+ps2obtnw3sxPDIb0xlu4JQqYQa/heEVj5C9ogrTeRvQbtD6M5zf34Sl3gqRMEX0l74lfiFrTqvANnGCQwj6mish0JjEgbxODamUA89gZPFws1fOaZJhL0cxjgbEGIkAOBsv0AVbCnCxpEH/cK75JaDHdUfojp+ucQzZKhdqgWcpQ664jw32ZgTcISxqyccQN9DQG9o7OWBNyHbmKkuSZNYrHZ0aJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3cZptlPkwSMX3MDp72kpSegIqrlF+KfiOqqvcxFXXE=;
 b=aZ4Po5N+bculsYi6x3pYBRodgU91dMittYgYZt8SKPlwqDs90jLtO8pfMNhGaGtT/+FHcyl0DV2lhmMb7c6kOXT3C6+LR48keAX/NCQu2DtG/au0sgWha3QkHq/QA7HDfzf73N7Hid/L8ctyp+Sm+KOWWijYj6BMcLqA/HL/kQw=
Received: from BL1PR13CA0431.namprd13.prod.outlook.com (2603:10b6:208:2c3::16)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 05:35:55 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::cd) by BL1PR13CA0431.outlook.office365.com
 (2603:10b6:208:2c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Wed, 22 May 2024 05:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 05:35:55 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 00:35:52 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>
CC: <hawking.zhang@amd.com>, <aaron.liu@amd.com>,
 <sreekant.somasekharan@amd.com>, Shane Xiao <shane.xiao@amd.com>, longlyao
 <Longlong.Yao@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_NV10
Date: Wed, 22 May 2024 13:35:31 +0800
Message-ID: <20240522053532.2896100-2-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522053532.2896100-1-shane.xiao@amd.com>
References: <20240522053532.2896100-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7c0731-7a88-4bec-7d3a-08dc7a210d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IIaHernx9LH31PXsTB0vxwsQPPKrAJ3+Hd4Xchtc3nb6zm9N60tRxwCJb6EM?=
 =?us-ascii?Q?bBZQWCAn9+syG96vXRqovBW1N8q710nP1RDxpBsaNfgee10F6K9llrB6kecf?=
 =?us-ascii?Q?yQa78k227ytbYSZAZ3yBHN3VR8jw2r5ut5kLLBRsvY1PTvpDYS6u+2W9V1Ga?=
 =?us-ascii?Q?E3dx/XBs+I5LCb5filRvICFbeKNmgHUbJizbG896rXRR9NEF99EeJCYvEX0a?=
 =?us-ascii?Q?rdEuyHn550TR560HhA+vADmj5qunrgdX9eI2iJ3UBLGn4NBPnAznaKYjXTiA?=
 =?us-ascii?Q?rf0WK9/3vK6P0Agc0Afv5H2vlvqv4UJOYCXru2bnTdZ7Cr+9mhz8apvYdiT/?=
 =?us-ascii?Q?j3W5P33kOOAuA/NrF4PY/d85zVyd/FnPCKfRfXXzUl/y6ofQxOa401pOEXab?=
 =?us-ascii?Q?Yl3vlZuFmG/9vDos2iukBpgfgxZVmR2M0vK8x7wQ66cRAe8MU2cpOr4JheX9?=
 =?us-ascii?Q?kIIwuWwBldeoq8h96wMaWMVJI86ksR191z04YfWm2avGk5BuLeQeend49Pe3?=
 =?us-ascii?Q?H2MuDhtyOSzsM8OBdRYpOK/pXRZ8LawhQzxBWJAwLC+NaAZRcTIWxQ0yhul+?=
 =?us-ascii?Q?6p+GqZDaVXZFl3HRXmP+5YzEokd22+GbYfpAHdciimDbRVq41HB/+y29mhBd?=
 =?us-ascii?Q?5ZjxegNtRZLqAO9w9KOB/BLD5Ga0TCyVNh1gvWaiOcVAkKDf79OiEi4pEeTn?=
 =?us-ascii?Q?wyqAIoLWAezaNXYIO0KuKFq8tiwtzE7V+PStwtpcfSFDdkordY8AoHbbRmrp?=
 =?us-ascii?Q?X8GUCEHt5ANjxwj4Hz0QqKFiljvF99l9V1VAUgAHwmJ6RqlBBjkUpUllfAzA?=
 =?us-ascii?Q?9b49khCSRfMiXoCpqX/mGot8iaBj6mkPjuvwnoR2mucWII/Spf/YlBArwTOO?=
 =?us-ascii?Q?G2DvbGM1JmGAPurMuG4vuWMh1n9R7s5lvuqMX68XfYyCnyP1/hwqkMyk3rGr?=
 =?us-ascii?Q?QvwBWuvJbnluRz4YrwfRrCM/HE5iaqTEh4UtY55xklEj5dlz4ed2cI3SsMK9?=
 =?us-ascii?Q?IUjQSij/TiRgVGQJ7rW6xbigf15KyBPMuSmCmAt6FcJdhvauj5Qmcp3VccTF?=
 =?us-ascii?Q?8dRPBOyV7b6CXNoegrJCE3wTGz7YBxTrjZ12tUcz3BtYXycqK3y59Qcu1I6y?=
 =?us-ascii?Q?88nKmKcZDGLRP1HdFDREihiWLwwyeRdST5RIZ+81Q/g69eiLg+qNtJan/tgM?=
 =?us-ascii?Q?3uc0Yeivab3jNQnQ0HBj8U9NmfVAk1pJD4lr4kctGFxrooXfXVZqmsy7AGO2?=
 =?us-ascii?Q?eSA0Oaq6xFLK0F4ZCv9vWC1Ndf3wpE+haiNEVIdpvxysVY77yv22ljK7cXiz?=
 =?us-ascii?Q?Qj/p8+Qn692N27l1wzlSbq8t3rJbQR+k1IdPl8dY1ciFuUTNrdVTYy8KvmwZ?=
 =?us-ascii?Q?VgkIxLc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:35:55.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7c0731-7a88-4bec-7d3a-08dc7a210d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

This patch changes the implementation of AMDGPU_PTE_MTYPE_NV10,
clear the bits before setting the new one.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: longlyao <Longlong.Yao@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 17 ++++++++---------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b5f81e7e6356..0c4a01fad851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -108,8 +108,11 @@ struct amdgpu_mem_stats;
                                 | AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_CC))
 
 /* gfx10 */
-#define AMDGPU_PTE_MTYPE_NV10(a)       ((uint64_t)(a) << 48)
-#define AMDGPU_PTE_MTYPE_NV10_MASK     AMDGPU_PTE_MTYPE_NV10(7ULL)
+#define AMDGPU_PTE_MTYPE_NV10_SHIFT(mtype)	((uint64_t)(mtype) << 48)
+#define AMDGPU_PTE_MTYPE_NV10_MASK     AMDGPU_PTE_MTYPE_NV10_SHIFT(7ULL)
+#define AMDGPU_PTE_MTYPE_NV10(flags, mtype)			\
+	((flags) & ((~AMDGPU_PTE_MTYPE_NV10_MASK)) |	\
+	  AMDGPU_PTE_MTYPE_NV10_SHIFT(mtype))
 
 /* gfx12 */
 #define AMDGPU_PTE_PRT_GFX12		(1ULL << 56)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..f0ceab3ce5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -473,17 +473,17 @@ static uint64_t gmc_v10_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
 {
 	switch (flags) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_WC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
 	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_CC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
 	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
 	default:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	}
 }
 
@@ -536,8 +536,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
-			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 }
 
 static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
@@ -763,7 +762,7 @@ static int gmc_v10_0_gart_init(struct amdgpu_device *adev)
 		return r;
 
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
-	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_NV10(MTYPE_UC) |
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
 
 	return amdgpu_gart_table_vram_alloc(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 527dc917e049..cad883783834 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -438,17 +438,17 @@ static uint64_t gmc_v11_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
 {
 	switch (flags) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_WC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
 	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_CC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
 	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
 	default:
-		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
 	}
 }
 
@@ -501,8 +501,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
-			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 }
 
 static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
@@ -723,7 +722,7 @@ static int gmc_v11_0_gart_init(struct amdgpu_device *adev)
 		return r;
 
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
-	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_NV10(MTYPE_UC) |
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
 
 	return amdgpu_gart_table_vram_alloc(adev);
-- 
2.25.1

