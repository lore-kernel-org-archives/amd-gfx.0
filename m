Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C22C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 09:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEF110E03D;
	Mon, 20 May 2024 09:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XlHUbTlX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F04710E03D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 09:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZnAFc1LLO4X/HTe058/iQLNsEj9VkLC+iqa3alMjihfJnEnkd93C3Bcq2JDPB2lkDWRX8mNUcisOzB97oagoBx9SeQKRBxobdJsBR6xlK73yYVFRWhBuKNcEwq3FfIVdfVKfkp9IdtewxjGwY+1TKXc4Z7Cu0Es4eoW3aVpgIyAeZNp5l3T0SEglXyO1bZe9nuKT2xzd5ZOrohGLmXPSFXifUw+hWtQiIWvw7lLN18cmfdPtoCFi1NbdGRC9LNjSPB5o1keDZhnUQwgeyAcWVaGxp6R5KwzMN++4b7TriRePG4HLo+9bgw5IKIGo8RVP6qJrfD6hFhpRSBbwc1dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ48vZOgA3Gj+1LpDc4FZ7zYK89qlYh71fwsmSKz/1g=;
 b=FmxHHVfv9ZToErplIU501izzcvhptnbVuFKxVefKGvgXPWxlj2kFlwTOhz0XKZN7goCDaJ7EJg5ji2fPHpYnuwMOOk8vdBuwMnmMWS7+7vSipZNG2ouUwKm6Lxs0IxjwsM8RepCuwP+wF5tLgZeztmxq6ARVPABTKSqFTbJKKYp26WLYfLabAYHtbY/lzUI0v50/8LuH8MMhmCPQVurjl7JEPUe9DQb6AY3Yq386t5PbfHKKitt0rDxt/N30gmldsjWpBN1mSNwyzAFE1Lre1waP8kUpkWOE7sDfDAMjkVRzoeROGoopQNpANoy8CDcgdRt6emboKz9FuqO1m9djDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ48vZOgA3Gj+1LpDc4FZ7zYK89qlYh71fwsmSKz/1g=;
 b=XlHUbTlXiSyOptPFv2aA+ipWDVvDMcTWMs/k7l9m5zi7awCJge481aMXrtQZnDUMfS5vjnXjaGZl0mJTeK9UJnoput6Eup3KTtzCQ/017PUqFRob5mMDqX5WLfhqkjc3e/WWgOldaxPU3+ohePK9ecIiqH+kaM/Ua3z//ERCpPc=
Received: from CY5P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::23) by
 CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Mon, 20 May 2024 09:14:28 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::9e) by CY5P221CA0053.outlook.office365.com
 (2603:10b6:930:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 09:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 09:14:27 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 04:14:23 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>,
 <felix.kuehling@amd.com>, <sreekant.somasekharan@amd.com>
CC: Aaron Liu <aaron.liu@amd.com>, Shane Xiao <shane.xiao@amd.com>, longlyao
 <Longlong.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
Date: Mon, 20 May 2024 17:14:09 +0800
Message-ID: <20240520091409.2435612-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 842a46cd-63ca-496d-e55d-08dc78ad4005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zq9YZxzkSt8DuL3MPg2uN5ciV/77djFyZCfx4kl3iYkFgUcPtUT1qi6LEcbY?=
 =?us-ascii?Q?1+7kgcbgI36x7wfHa/ANHnUvozIt4WOqMI+Bmqm0l3ydHuzXGRg7tMwhBsMk?=
 =?us-ascii?Q?PNxPZjJqqFBrcoCspNeZAHDgs0/kSjQO41tdG1XhBkmnXaT5uf8A2r6qmx9L?=
 =?us-ascii?Q?azqqAE1zaE8nrzOOIP1KlXhK3wcdFuk08kg+b28Eg2gS+4SlKeehTFEFWMyM?=
 =?us-ascii?Q?Xqc5bhb1rKb5nPsAicQnlp2uM8eV7QO8lcrFMoG9xK9RWjpn0kjNN3q9WiaW?=
 =?us-ascii?Q?BPuLwnmaoiyeLCJabyVygCpTY3sD7IRz8wyc+N4PFZZmfkksLjyv8tPaXbHc?=
 =?us-ascii?Q?MTGtkYfzT2VrW7T0WdVHPU062x8tLedlUpZeOis+axmtAfPdvBVF71eZG57e?=
 =?us-ascii?Q?qluDcUQlkH48nDCXnIJE+1rKlwYSLG16sDQH6NKER/XF2bbAgiScDkciUaQS?=
 =?us-ascii?Q?aCOgK8++rcUW53xSOkJuW7qck141k6Y9eK6wBrcOR6pEGwttjcsb6f5ZMN6b?=
 =?us-ascii?Q?qYEhHOIeb5YhYO3QErNrHLLNuOYgIblXzUWCyVtlTQU7oVRSKarum79VVMIJ?=
 =?us-ascii?Q?KiyENpdgLpvEu0LSCsFvxHKLQkbwACny7rPnWIkflDYZJI4khdBHsG1KqjTB?=
 =?us-ascii?Q?vmutqlxD5WffTNJPNz256LoZLvFfnnIU0SgVGu52DfkAqhySaBsjMySrLbE2?=
 =?us-ascii?Q?wy/m58NextDXQrxq109YA1J7bZOdXtH+E68E3Evg37L6RFABfMWg+rKB36Do?=
 =?us-ascii?Q?TGYlTFoGIpJcJl/AJUJ11k1cqegmVs2anps3DBi0AMiBTHz8T79EtQiTav5L?=
 =?us-ascii?Q?jQp5JaA2JEkMbRXMESiPYObeuMB4P51Oz6C8rj7oWpvyZJWnOr/NZti/Ze6U?=
 =?us-ascii?Q?qgCBi8Z86GGpW6Z1ItBdxFrd5fEOkBGjEjqwFWmLA0Wtdl8YQp66rwaywvrB?=
 =?us-ascii?Q?BsFdC5JxrdD9d8oYv/ZlFVJeSfUj6IP8aPVk6s3uV747cN2GK1q/plcvSA7n?=
 =?us-ascii?Q?cfFEWPs0dVq2yq8Y9ixZjNo1Wk2HJVl0lUewQKidnGzU8pQGRNCe44TTvhc+?=
 =?us-ascii?Q?i1UACYMmhMP4Tjo5envBDfj54Q9VgWKcOhZOERkc81hpzorzh1EDkCN3X4+4?=
 =?us-ascii?Q?rjQCLYWd+cG+2Oy4xv2oxwwJWfg9bpF85ZoVr/QauVX48X9o5jTkdUZnJz/9?=
 =?us-ascii?Q?b47lUNgnFsWsHygOhfFeg8700+cNTDyn8BZcdQzY3J6QrKSngG3jyu8cmCkj?=
 =?us-ascii?Q?2lo1YNJd/Li6XqtrR4Ag8mdhd4N81zWW9/KoD5PK0TnM9y4fRF+IIgyoMJYz?=
 =?us-ascii?Q?5+e6B94By5oIEdDLv7apfpkhcwAq/xeYiMJrwu4Lk70zxnsaziWJ5QYqtqI1?=
 =?us-ascii?Q?C2G1toc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 09:14:27.7477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842a46cd-63ca-496d-e55d-08dc78ad4005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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

This patch changes the implementation of AMDGPU_PTE_MTYPE_GFX12,
clear the bits before setting the new one.
This fixed the potential issue that GFX12 setting memory to NC.

v2: Clear mtype field before setting the new one (Alex)

Signed-off-by: longlyao <Longlong.Yao@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bc71b44387b2..99b246e82ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -116,8 +116,11 @@ struct amdgpu_mem_stats;
 #define AMDGPU_PTE_PRT_FLAG(adev)	\
 	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
 
-#define AMDGPU_PTE_MTYPE_GFX12(a)	((uint64_t)(a) << 54)
-#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12(3ULL)
+#define AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype)	((uint64_t)(mytype) << 54)
+#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12_SHIFT(3ULL)
+#define AMDGPU_PTE_MTYPE_GFX12(flags, mtype)	\
+	((flags) & ((~AMDGPU_PTE_MTYPE_GFX12_MASK)) |	\
+	  AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
 
 #define AMDGPU_PTE_IS_PTE		(1ULL << 63)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e2c6ec3cc4f3..f2d331d0181f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -461,17 +461,17 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
 {
 	switch (flags) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_WC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_WC);
 	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_CC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_CC);
 	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_UC);
 	default:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	}
 }
 
@@ -509,8 +509,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
 
-	*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
-	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
+	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, (mapping->flags &	\
+			 AMDGPU_PTE_MTYPE_GFX12_MASK) >> AMDGPU_PTE_MTYPE_GFX12_SHIFT);
 
 	if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
 		*flags |= AMDGPU_PTE_PRT_GFX12;
@@ -524,8 +524,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 
 	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
-			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 
 	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
@@ -534,7 +533,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 
 	/* WA for HW bug */
 	if (is_system || ((bo_adev != adev) && coherent))
-		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
 
 }
 
@@ -707,7 +706,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 		return r;
 
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
-	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC) |
 				    AMDGPU_PTE_EXECUTABLE |
 				    AMDGPU_PTE_IS_PTE;
 
-- 
2.25.1

