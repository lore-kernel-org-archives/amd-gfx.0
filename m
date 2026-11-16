Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589D606A32A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wXN3arsn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52E110E096;
	Mon, 16 Nov 2026 19:47:55 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524BE10E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oToThzwitfmfYoqFOpXZv17is/geAYQ635KYEPdqhWbbSlyIFOJPo/Bm96h3c/Bvh+jDvau0hQyLQTcYaMsINU5Lp5QdVGEIIArLafJ+C4Afdf6y/cfLXrdLypPVRbISJKIBDnAMifZSwOIGVWWkFq82TbV7jFj2aJnp8D07ygS1pHunCghijwAEwUY4asIBDNcBZe32q4T4ULKlo3Ri8d3pirQuZbO5CyE4d0vtu8GJbD3DnBalmh4vVnwPxUGSF8bGVUbyb/rgCCCgmBqYj5/YXcHs2S3pTLrG2q2Gal19sGGlnHNn5uz+Ks1pfpMKGEX5o0jrgHQQFfrF7dFOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUUr0M9pwm15FvAXtPz4Pwm5DkW3ypJCRD9WhaukiYM=;
 b=O1NsWVMSOpVB/ZMxRZ1OVx3t5/8BdfDWvQw1AvRvCPZWqDsQQIxapcsMctOOnRagoPpVCqCuAx2uOYqvC+6WsWjzXAJqQV3Gd+XK6iHxkysvxw0/S3/tgrDOcXGUPxwyfRdezG+sfDQt58aojrIzcCsDu9SWEXtDG93Z51+X/PEvYcAseYtWi2WxYMd+b2toO+RaGzc45ms2IswEBgjeZfI1+cYsrZQ2DPTK8ZvfGzj6thumkWvxHHbnUMxlOkHg2EZb3ONrWgy4k6mBHBnHm6RogLJKDjUoUJX8yzAbi3eXjN9PZMqVV0hlkIKnwG4irAwIzesfqUnAb8dNdjOX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUUr0M9pwm15FvAXtPz4Pwm5DkW3ypJCRD9WhaukiYM=;
 b=wXN3arsnifGPnt43Mi6RS6UFXKoy+x6F7ek15uFC9cVeobah4pVbKc/C/87tgzWwTTX1PCHlSaNOI8SWq1vtWfB1SqTDZCKcxf+/kFXL3QyJ0I6SN0QwOxXRjrSdDOqsjkDVfWnhzQsCYEGgSPL9zCLjKUQnR4N++VqlgQiN+4U=
Received: from DS1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::16) by
 IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:47:45 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:8:242:cafe::36) by DS1P221CA0025.outlook.office365.com
 (2603:10b6:8:242::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 16
 Nov 2026 19:47:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 19:47:44 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:47:43 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
Date: Mon, 16 Nov 2026 14:47:26 -0500
Message-ID: <20261116194727.397571-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: bab7577a-27ad-4d85-af2b-08df441a7bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|261021121427099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: NGy6SLTMY0G8XzRuziuDZGvvDHyXN7tlbSwUieFfOcLJIGl4WHCol0OkJupivDWRPrWpQa56Z/6pZA2mW8YMBOgOT5LJ0DgQFNpJPNj7qazC9aZaN+zPTK/1fT+nBpqZsblG49yau8DdnT7N+mCs9+whf8ZULYtLSIPSyE+R90+pPFSqvJ68eKQlKkCL2Bx94smPGwIMEalLi7Z9GQ/axCpQLVc9C4VWQYEhPAVwP3r0nBUXILVQj3Sd9K3mUZztBXy0+fzCALX5oeuggqBYc/ZhCB6AGWvRLHjhpbw+HVFVyEfmW3p+NEH0FXX1grZ5XdSe22yPnfy7FHohJBpjSzyqa6asVSeIq1dCRHK93MIyohPkxVwR3teb/YgDQ8AbviALtgNoddWUyHe22AYSnI/WPIzQcOcL0hmNyxOGu/yPZD3j4CFzcQ6eQUPv8/C+r3djGOHGP09UA7DER366glqJQ2DeWRLYZy4l/axA4OZFHo2xFYE4UuJrbrrIqtvIZuj1Bxvk2oCTSIPyzG1rw2EmAs3R4Mzt3vTI2TIAMhp/69wKVb2ud77prP5qT0lgtsEgsXaZzXQcjHgssm9iYcYIW4V8opxR+crCW4MdOa9P46wWZNwZIPjuDp4YiotCTcr8MCsotgZDYxYahN3wRjR+tKe34WlM1XlpHMPNX1t7kiKC4IIwvN54vPKblSJyajIWpTY5GcH4uMyOr51miw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P95s8O485m9/XTRgbpfWgnM6kVu4GtVXILecQ2bUZhY3CKTT13HOtEKbcyzAOsemXVLXm8nnDviVhn2lHekADqvIFOmJKUBxUm3GHMTAPperL4DJEEk6RqfbO8s3PPyKGvBZxTingKVlxEl8gMANBnKEjbJ8rKSziC/9Am+s+EKhcYs8BkdYeT2AYGI3nI2qniGZHH8z/naOIC9HLTbFc8vPBtdRzNskGcjabyrpLXck7a7iB3NNR2rOK0P06ZzSNZ4ImPOxsYMRrowuOQALw71hXLt1nb4G0KHFv3IjOCo+7t5cyqjOblWGRLqV1Ry1mBKeJcjrDzWccGBO3XnFbVpO725ACR4mNKVvHEzlrkbyaE18YldAh4iBC8vvk4cEjLe/U8bIR+iszMXeSicMfJd+7qcil7g3dwMQCjjfxyMJELFRfPvowjf2GUX1+F1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:47:44.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab7577a-27ad-4d85-af2b-08df441a7bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836
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

v3:
- Set S only when AMDGPU_PTE_VALID is already set, so PRT, clears,
  and NPA stay unchanged.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 76391fca6c62..507a9c52ccd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -586,6 +586,13 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 		*addr = adev->vm_manager.vram_base_offset + *addr -
 			adev->gmc.vram_start;
 
+	/* SPM VRAM is reached at a system physical address. Set S after the
+	 * translation above so that translation is not skipped. A cleared
+	 * PDE or an NPA leaf has VALID clear and keeps S clear.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev) && (*flags & AMDGPU_PTE_VALID))
+		*flags |= AMDGPU_PTE_SYSTEM;
+
 	if (*addr & ~adev->gmc.pte_addr_mask) {
 		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
 		*addr = 0;
@@ -758,6 +765,11 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 
 	if (bo) {
 		mem = bo->tbo.resource;
+		if (amdgpu_virt_vram_is_spm(adev) &&
+		    (*flags & AMDGPU_PTE_VALID) &&
+		    mem && mem->mem_type == TTM_PL_VRAM)
+			*flags |= AMDGPU_PTE_SYSTEM;
+
 		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
 			dev_dbg(adev->dev,
 				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
@@ -766,6 +778,12 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		} else if (*flags & AMDGPU_PTE_VALID) {
 			gmc_v12_1_get_coherence_flags(adev, bo, flags);
 		}
+	} else if (amdgpu_virt_vram_is_spm(adev) &&
+		   (*flags & AMDGPU_PTE_VALID)) {
+		/* SVM has no BO and sets VALID first. System memory already
+		 * has S. PRT and a clear have VALID clear and stay unchanged.
+		 */
+		*flags |= AMDGPU_PTE_SYSTEM;
 	}
 }
 
-- 
2.43.0

