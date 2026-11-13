Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BA606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=14JrdCKH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1EB112609;
	Fri, 13 Nov 2026 14:57:49 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B91710EC25
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLCLZNCzkCp5MCkfh2kOyv0vut6iHOAqb/JEkUYOvg74Gaikj9Lx7tKFu6+0Rgt7EJ/Efy9b/xMy3sDsZa+U5wAgjgZwFFLuifNdNfpfndJ1EISeEq3ba0yISeig2hX0wFnQq/6W9OIXM0xIYhqIw1xlBnaycfoJnuchd0sQtMEWGtXPu3jN2gqp/OKzJIloYPQ02NtYWNFxDAXJtn3NnJHGGeKx/ePgpgatLQ/lL+3866NpMMcDgWJf0stncv8MCcMicRbsvxw5Gwnp4p+zMytksaPWbByRZ1/HrZMBmIxWG86feTJ/Dqf8ied2a6SkgJyI4FCvwy6RzJo50tt2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLo3tiYkCUuZL3wFNyjN939si4pXUQAXFiawnZD+aXw=;
 b=l/RBJil9c9HhiU8MYsWrAc/ngY1aMCGbwkz5PEOws4Da4Z9mLoQmaYVaW2ClUAyosb+WNyXbU78Yw+VMmh2w9gCXN/TuGeKF2EYnD1pHp7bus15LL6gU81fsGMJpqRvxSAgQgTNo0bENsQZvjR/uVLQB/4RSMYead+Pydd5SDnwhwsNPDN6Y3zCBD+RtMIC/NA72pK4iB+hoJTuQXtAXjgBGBg050uqKIFbkOMRD3MaKTjgTCUVIBamB5NHHxzVGWxrHCzZ8m9hmDByckGj4SyB4Rb9UkTFuXYQZAm7WQ77BgCi8cq0MYxo/COioHYt08yp9eWkI8ElTADDKg+K9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLo3tiYkCUuZL3wFNyjN939si4pXUQAXFiawnZD+aXw=;
 b=14JrdCKHOvQyBnSaOngRs7ZNuZwbjKdnP+gSP5xDomo91UwiUErUak6wzUbSNaFtclmXFJmuIequUlp6VzkgoD7EzRCHBxSbFbApQdxcpmyHUIkhe99zil5o9gVwt979pfO3lmw0GgA9Cjt6K6bZhOdiDfI120jUz8ienNoCZ/Y=
Received: from CY8PR19CA0033.namprd19.prod.outlook.com (2603:10b6:930:6::9) by
 SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 14:57:36 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::45) by CY8PR19CA0033.outlook.office365.com
 (2603:10b6:930:6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:36 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:35 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:20 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: fill the A+A VF PDB0 through get_vm_pde
Date: Fri, 13 Nov 2026 09:57:00 -0500
Message-ID: <20261113145702.323968-5-Zhigang.Luo@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b95b3f-fde7-4c3c-d31a-08df4196742f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vCKW4be2+N74oRyYK7+X7TckQiGZq7oYDiCf0mS4pNt+sll9vUWVUWSc/z1KRnBTZQWsOxRPlC2HYcbJcDw8FkSZaZOT8FSCvfJkyfX1YYG1HkuPUhl8GgOpEhHUIZYbcfOqzlxIEpevl0040c7uhcIy/fxZQkHzKzmLmDqHpnOlSI+mP+4v/t0ogTFjUCySV3pkK+Uz+bpV0ovbXmcH1In6zMITlGTN4AaApzf8fTojaztwV1b+Pyqe3/b+p61+PoRrGpMXukNJjoqwyp+Kbr8gjeayWyUytnAKuQD2vQPswUJaaERhQXLzmxz/E8GoeRrG+MxzZWsMyDevUFrhHQe4LwFXoxKlYBminoCbmH1ZuWA4Lbemmg/SUsrHkZlzK997gQUQ8mzTCmXAnsJPAs0RYimCBk8GLfRvn3TlpexlNwmhnl20hHHC+UnpUr7h/HFFBDOqk/vBj/XddnIrk68AGfMQQtB6buYgKX2blAbLFG72La6D40E+e15pxLNQxwwhHdqUsFzqE5EmQBrj/EkyO87NdZa8tZq/VzCjYzbMABOZjgJuD4JrSrwHa3GPVuasSTJroBmJh2E5Mu6E5mf9qpum1B+S7k45beW+O1je9RiyRiGwSz19qlle1xlGkANY5nKm+EQQOUYzLjzw69iic9UJqgH52vwQ2nwQXMZ6EViXH3VnTct1CX0s6j13JTQTPtG5pUhlh/E+AeyVyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TVubl+nZ+aMlkb3adsRPgZ7bAqMYDAlsYnKTg2fE54MDGTIwwwebJKsxBeGaYW4n42hPYdE3413WGGswGrA/vhJIXeG98dSBssZBm0g5UWpxM4101vT/rGzZFHkK/WQ3D3QHkLyzrxLT3nR3Uq2Jx2i4PnrZ5WNrRkeooy1gWug9FZ0HdTEIxjtPz6wUB+23poo3iT6zQxzo/wCJk1dWUowHSBut9rmAZOmuqNBTfTVD1cqZBci4snA+FsdA30/jMrLi4cpQYJwCjtVpQtaRkG4OZ3P1B8qN6kXKGbOo0JZeLtj+txiIUY41yzT4ywm4QEEOKDRKA1lqw9Z2I513H5QbTuWhMI6zgibyE1piO5fN3LRM1il3tV50fz99BZ9Ub0MU2w+BX/liHR4sTaV0I1KAzYpokRPgC8/rMCEMrKB50f2yZGblMkdHuHSQfKZ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:35.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b95b3f-fde7-4c3c-d31a-08df4196742f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
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

PDB0 is written directly and does not go through get_vm_pte(). Route
both entries through amdgpu_gmc_get_vm_pde() so they take the same
SYSTEM-bit path as every other GFX 12.1 mapping.

The VRAM entries are PDE_PTEs and already hold a physical address, so
the translation is skipped and S is set for SPM. The GART PDE is given
the GART BO's MC address and translated once.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 659e89e5e78f..04cf02dd22ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1272,7 +1272,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
 	u64 vram_addr, vram_end;
-	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
+	u64 pde_addr, pde_flags;
 	int idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -1290,10 +1290,16 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	vram_end = vram_addr + vram_size;
 
 	/* The first n PDE0 entries are used as PTE,
-	 * pointing to vram
+	 * pointing to vram. PDE_PTE already holds a physical address, so
+	 * get_vm_pde() skips translation and sets S for SPM.
 	 */
-	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
-		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
+	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
+		pde_addr = vram_addr;
+		pde_flags = flags;
+		amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &pde_flags);
+		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr,
+				       pde_flags);
+	}
 
 	/* The n+1'th PDE0 entry points to a huge
 	 * PTB who has more than 512 entries each
@@ -1301,8 +1307,12 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 */
 	flags = AMDGPU_PTE_VALID;
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
-	/* Requires gart_ptb_gpu_pa to be 4K aligned */
-	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
+	/* MC address. get_vm_pde() translates it once and sets S for SPM.
+	 * Requires the GART PT to be 4K aligned.
+	 */
+	pde_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
+	amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &flags);
+	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr, flags);
 	drm_dev_exit(idx);
 }
 
-- 
2.43.0

