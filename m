Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E30606A339
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0bfZ5kAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0179112637;
	Fri, 13 Nov 2026 14:58:24 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F99610EC25
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1Locbcorjfj/3d1uO4Y16KQTjF2zSGANNYBThsZ6q/uXL8lpPuz0vvFXAop0Oqzfgmsi3iSHlTJ/GdllNAyxFrQ+jq5444o6iZ/iVy5Y9boJ6+PSpRJvqtfJClrrULPAJuFOU8AieVLjnithvOcLoelrHgxloHwloLwxtSeTzbzj51kCRYJZLEX5BaBmCDinelhbkJ8GjkgTRhwIuSzxdnQpDNyDPudN7MCm5LbsW1WMOZKF9++QRzvMdY6t5Oi+Auby57xDvvKmXSGB6H6sPvz6rQI+91u70fPPOxIjeHg6oSyU3OeeURNo/Dez6FbD6jw/AFFDrqVEU+K9qJ0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74bcG1pd2QpNiyIvNqmeEhNkFkoFXDzN8N83sg3t8q8=;
 b=X6iCWFAM3afLcMzTXv9IOwPyVWc09PfHdmWkyVKTffFlfOE0RQt9UmGxhor54V77+O8ZuVse/2FumPVJfDtygcHNYNEr5ItTRq/NSktkdDYS4p1gPz48YTGyr0W3JqdYUiirgClelZ2PlXuFSPKcnktHAq4PegSw4myqRIrLKS03rpgtnOescgmK0cbVhDoONmVYg9Pkpw3nxFoZ60c+67YIQHSxxeQpaaUzhWreLXqhVApJdF8wZeN4nu9tfEAOpMPwUfSDNCOs/ECWVhAmh/JanrXZo7y41NuxKeBlO7GjvP/O274vIPuHLRiwqYCrVGlR3Yv/OHSUPa6YJsq3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74bcG1pd2QpNiyIvNqmeEhNkFkoFXDzN8N83sg3t8q8=;
 b=0bfZ5kAQ0Fj3ONyZTBL9aJ5AWOlc9QHPxu0zCk7p3Il3ULuQ3EctoxT7c85XiTtgYYI3uWORj1HfaHX5VV4HW3iPCylQo6qwoheu31Rc9bgrwhZKGPfTlKbQJuMfrIyCHHpvEWivXGhEZMsl5MRiOSz5+yg0m4H6Pgsl6nRvCRw=
Received: from CY8PR19CA0035.namprd19.prod.outlook.com (2603:10b6:930:6::17)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:57:32 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::4c) by CY8PR19CA0035.outlook.office365.com
 (2603:10b6:930:6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:30 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:20 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
Date: Fri, 13 Nov 2026 09:56:59 -0500
Message-ID: <20261113145702.323968-4-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb5009a-be5e-4504-fe25-08df419670cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|261009223027099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: YMaG91PGsqqSc5PJ/RM+SigGC32mSM1ATyoy3sX/waS7L/ibNNN0QiUqERKT0t6BnQz2tnDofaCC334PVPsabqZembC/vYXvJiJeZceslKbhf41JcfWnoaDQk3QZkOQW8DCbDfQQKq4W+m4kDBz1unXzPTFumgk5Qys/eLm1JSJFyvsTMC4dp57EBALC4Ectc5EFOsdF65udYPWvkDfpny1T6IHgCrkaMKfad5yqYTFyvs7WrSHUakyY/7t49m1W8sZpp+Fpn1M65KAWOPsZIT9XGP5sZaIXIzvXa+JwCP6Z/kofnpYJFMbcz2KoKceQnicTOvE7SPC5nJC2CUsZR3woAzWtCKBwgA+V/idjTHGnGj/bvZ7CdLp6ng8Nmermabv8y+gUa6zvAqoB7zNqa4CsU+81XIgswZynrP1ojAdKTCdD3x0FMHlc0IuiPMp1NbF6rLtrm3DhpR75iHjm8XT3qVoE2qC7tcdeg5kBe+L32df2Ecf4/zsMLxMSl8RDMNMx2jx3e9gMqeCQUgTZKWtHMOLMV761/f9D5WqxqgtnISv34IL5HtUNcNx1xz1EEHcf62NOMMD5Pw/oDNjYQT+OUjtI1E2J55EG1CEGOulPNPj9YLKupE7q8ijm+RUyYd+lw+3wgoC/6WsTotGAPStlwlUcSTPcekST0lkG6kQmMZQz32B3ciX3VaPclFs6bXoc/4xEMT1RVJR530dMBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VUKjAHATBogFc5XQBuqq9fT5i5NXOQHVzPcnPGMGlHca/5oTQECkxu3FJ58iRocq3EDBUFq9UMZatDumXQEGMM9lIgG3McakznafvOdxAn2sApNGuk46tar1wo7iWTH71/VBdFrCnDv/he4wsLZevG1w+cKA9ZU3BGcGmwFsBhdDpHL8ocaXMJ0uNfIZ1YlCt786JsT42B1fr6/QoUeacyhO6J4JjRwJQiXcFuNTguoTiRtsK1mEip7RhXIz28u6WejdS6zMlseY860sJESuXkQ8AH/HG8oJs5uizSXPWHJvIu1/9B28JagQedhNg8TkeY0w8gxMaRTdVFYdkakJq4UpiIL+VdzZ1SULRfqGT8ciQ9JkHN+NgCSd4EX+ABpLdHc6VbbiP3kuLayLOztuKIvUyDRm9glVxXAlKQzs/ICzwKZy519NBWapZpSzsRsp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:30.2299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5009a-be5e-4504-fe25-08df419670cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

gmc_v12_1_get_vm_pte() sets the bit for a VRAM buffer object. SVM
calls it with a NULL buffer object, and svm_range_get_pte_flags()
sets the bit only for system memory, so the NULL case sets it for
SPM VRAM. NPA mappings are left unchanged.

v2:
- Set the bit for a VRAM BO inside if (bo), and for the SVM NULL BO
  in the else.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 76391fca6c62..7ac0d9c6f280 100644
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
@@ -758,6 +764,10 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 
 	if (bo) {
 		mem = bo->tbo.resource;
+		if (amdgpu_virt_vram_is_spm(adev) &&
+		    mem && mem->mem_type == TTM_PL_VRAM)
+			*flags |= AMDGPU_PTE_SYSTEM;
+
 		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
 			dev_dbg(adev->dev,
 				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
@@ -766,6 +776,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		} else if (*flags & AMDGPU_PTE_VALID) {
 			gmc_v12_1_get_coherence_flags(adev, bo, flags);
 		}
+	} else if (amdgpu_virt_vram_is_spm(adev)) {
+		/* SVM has no BO. System memory already has S. VRAM does not. */
+		*flags |= AMDGPU_PTE_SYSTEM;
 	}
 }
 
-- 
2.43.0

