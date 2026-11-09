Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06988606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PxPOQyUr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AED710E69E;
	Mon,  9 Nov 2026 16:27:01 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA4510E3E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 16:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg+tlYklS+EbJmrgdkXu9vSeQMBcNJ0E7SVwIi6lUIPYvDL/DQWOkRkNYCPymKLloha4Ehkz7EMeMp0G8+4Jc6vaBM3t9ExYNB2k14taJvrhduUqZ6Q6uGNPLIk29UKYr9zz27Zl0ONlFuk49GNTk2qxQTQznzGTQKjVotcPKdP7EndgM0565gNmYnZuLG78OcbA31tkS1yC2PL9wsxXjqUPyaVQpYy1igXgJMivDS4oEVL+R4kLUrMDi+hq7QPfyahdw3weeJeZywiR+FF02r2/p3mt9bure9zMFneVmq+9D/5eaVARKG/hd6ci6C2kTZ/O2D0HaM19GOiOABBfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8brxyELkK4EoKkjZARBMjeK0RsfBrJrUD7kXIOf2mlY=;
 b=QqI6vo0iO2unjtaPD0LJx1BRrfgno4N1t/+vZ1nutHB4vBpAQ9XPINXkU8fwrnLaM1KgnT4fcDT3l2kbEhqluIaAV3DWGiHnu7TDXmMLMRtzty3lSOtN0lMDD7+tf0yoDqzogrPsjbbkwyMtxok6NARLCbZh+iE1gezcviD5y7P1VhUjRQVCVAiW0vQK5jtAxoCxuL7x4kg23lAQcBAriofPuTZB5UdWPdi2wvzjLg4zvuLL7YWBqbxP434oga1ZU25WcPb0WKKaRsEcnb7NUIo/nRpBYZsb/3lII5zSI/RdUkcnIDs8AF6ULEqtnmZk/O+UoBSFHTV8GgaVG521pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8brxyELkK4EoKkjZARBMjeK0RsfBrJrUD7kXIOf2mlY=;
 b=PxPOQyUrDyfzOZr8FdTUjKzr4QYZNcqnKhD9sogBmTjbuh2UJlM0f3ygRJ9FSyBqV+AfPXbtacg2s0nbGZ07MiP+82zAJxD9KBumtGBP4h4Zd15qPwoedQKWmUTEIno1iv7C6Oc/iTmBsJ9ouhFV0xYb8hhBR2JhBXbNdiYVOTc=
Received: from CH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:32::30)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 16:26:42 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::4f) by CH0PR07CA0025.outlook.office365.com
 (2603:10b6:610:32::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 16:26:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:26:41 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 10:26:34 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
Date: Mon, 9 Nov 2026 11:26:14 -0500
Message-ID: <20261109162615.167236-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109162615.167236-1-Zhigang.Luo@amd.com>
References: <20261109162615.167236-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 86091dbd-6e9b-43c0-3e42-08df3e7e3cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|10067099003|11063799006|261026121527099003|261102123227099003|56012099006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Z1+YHXY3AiPU0i+PeBf3lVWrX/7atrgJp4yAI1pKFUmuw8daAcMtdpyZQ846IQLHBwoy2OSTzfClhEZcVoDKJX7wTp5q07UqoXNMYeKrstJrhnPEn4+NYjjKU+wqZtQCFmyBK6M3pFlSLEok/rNH9jC2l5VkwT3fmsKAD5UTJ6S9iA38b2wcNAEwJ+cGCmyNHE2zmQIK+WoulNkvFNUUeXYjkpv9HSohV5aR6klU3u9EA52eP6aBmoOcQnlctxwtAoy4gxjvuPn7r+EDCTOKfzXNwCnMC2WYiIwuZAiJ4vN3waxRBxZHaQp4or8VJ+9SBxDD4pEAygy88JmvrcBDp7BGBPzBanzlPZwh+O7Pnfmx3NBbRS7ckN8AUYDZNVe1JNjNmTfBLqgW1Zw9itg7vpPxHpAv4o2EEsOAr3QVYpIGfG3xVPkAOC7RnccaeJeIQ5SHOiHccNoT9md5peO03cYlI/MA/jm2g+tVB4g/j0SzOFrAm8cEs0sNzISPGOH+2iKaCgJ0Vs69w43SRuLj1uZezcOh/v+OE/+7r5e6cB4oe64IGxeQyJML+jqHr/KqVEoQvJxD9ejsGH4STxtQKNMvrbOa222cFDVRNwQfEUOJkngTeihLm9haV5MjKFZnUHMaALXGvBfUCj8k5N/jM3VgbbjQz3WVk2zdh+eOhg9KoR5I3PhOejq3bpioyum6rNiS61ShKiMlkxiZxBL1zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261026121527099003)(261102123227099003)(56012099006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vxlo1CJ+Jl8WrVkh3XSrG0NQqNJrjlRB8aprt0fKrPbLgS1BxwOqNIDV7PlHfc1cPc5dM4YIDcQp2xIOpN9NvsGY/FwkR6Ws5G8zArzTS9WO2rKcgumjvlyY55fRn5oAuFudY/ApMvc7NRTAbG4D8KCl5eh+ve5nBtmQonyedrJZXW7cWIOv5P91dNDcCoAT0j8exuNh1SGkWhb9Oi42IyB6E3X4byt6YtTNGERs1Xt4uxa+xQZL6JcxyZKm8OC3NfliN7RAOzaKexBlQv4LzDlxuaP3CelUnV66HbFZgvsOOEgT3DUVU/rvq3jonL+HINLVGmwpIvKsrOFzNDBqv7uSujrThAMadCj8GGGliEJfyQcU0vnM/rrBALihz3tI99Bd+DgzdgqiPd2Z102FBnEjreWA/UyPA6ZIr6mnyBgX/SA5GoNK4tQDKIHk9xWY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:26:41.5325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86091dbd-6e9b-43c0-3e42-08df3e7e3cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
address and skips that conversion when AMDGPU_PTE_SYSTEM is already
set. Set the bit after the translation so the address stays physical.

gmc_v12_1_get_vm_pte() covers the graphics and SVM PTE paths. SVM
VRAM ranges call it with a NULL buffer object, so set the bit there
before the NPA flags, which still clear it.

PDB0 is written directly and does not go through get_vm_pde(). Set
AMDGPU_PTE_SYSTEM on the SPM VRAM entries and the GART PDE. NPA
still requires PTE.S=0, so clear the bit in gmc_v12_1_get_npa_flags()
and amdgpu_ualink_peer_remote_init().

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 659e89e5e78f..f76da74abfec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1281,6 +1281,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
 	flags |= AMDGPU_PTE_SNOOPED;
+	if (amdgpu_virt_vram_is_spm(adev))
+		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
@@ -1300,6 +1302,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 * pointing to a 4K system page
 	 */
 	flags = AMDGPU_PTE_VALID;
+	if (amdgpu_virt_vram_is_spm(adev))
+		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3bb426b33af9..11f022c56667 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -6171,6 +6171,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_ATOMICS;
 	flags &= ~AMDGPU_PTE_VALID;
+	flags &= ~AMDGPU_PTE_SYSTEM;
 	/* PTE.X=0 turn off RPC checks for RBs, wptr and doorbell NPA address */
 	flags &= ~AMDGPU_PTE_EXECUTABLE;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 76391fca6c62..3bd86028f304 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 		*addr = adev->vm_manager.vram_base_offset + *addr -
 			adev->gmc.vram_start;
 
+	/* SPM VRAM is reached at a system physical address. Set S after the
+	 * translation above so that translation is not skipped.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev))
+		*flags |= AMDGPU_PTE_SYSTEM;
+
 	if (*addr & ~adev->gmc.pte_addr_mask) {
 		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
 		*addr = 0;
@@ -616,6 +622,7 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
+	*flags &= ~AMDGPU_PTE_SYSTEM;
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
@@ -756,6 +763,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		break;
 	}
 
+	if (amdgpu_virt_vram_is_spm(adev))
+		*flags |= AMDGPU_PTE_SYSTEM;
+
 	if (bo) {
 		mem = bo->tbo.resource;
 		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
-- 
2.43.0

