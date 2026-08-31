Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FBEC61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0AA10EA45;
	Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYOphWht";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29B110EA5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St23mwwptcawNHN67GS9k9JWBjTpoNKe2fu8sE8nLaubAzX5gQ4dDGR2UOQdBCeZTVpX504f42mDbTfkHBFQ6WtafCH7E1QwYgLzFVMrADCSm0yL4HN+tVmpSJKxUgK6+h+zj5Wfcvjw3+CY+QlAyEsmaWudPb0J6WlznKT86VRc8g+HzRcufDBd2s+8anGxlCJz2HRpTDKdpluwBklP/Pmqx1bZV/85ANAL94ql1d4lhf9NEyuuikj/CxBAQYrVNdPReGVvWgBO7AYKuvvkC5wLd82ixKcWaW+9od6+yMX1rjAwuOPdMU0UcO5KyBIIVPnjpRfYlLSBRKTKNiJEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQaRLPLvqmK+peSpwQyTx0ZBN2cPMaFS28rnHmQROsc=;
 b=jhKb9jrYPLGMKx7P81Idfoz6iFk4/DfRmh1Jvu/ZHHuypauxPo69jcpIf3SVmnNnbcqO2xOYn/ARhhRQqFl50sWxoHu6eAzJvL+1FRy0kZIm7mBJMOHh0YD1re3pJdDtVCdCgMYMnDcR7uXYXOKaWHjdv1Ibx3pSekiuUeqACx1nIspl08fTZAbkVrplY7aIg+EhTYufADr1vm51efIPhsyAqHJAu5lk3Dtfr3+dxtsrWQMNZbzXN13Hg1UHTT2Azw73zQwPB9kUhcvzcdUY1xDVmYaAzmJpjvd/Nh9AGG5f0p00hRkENPfzBWAXFN6Rg1ms3KgfKa+nvKjmXA7t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQaRLPLvqmK+peSpwQyTx0ZBN2cPMaFS28rnHmQROsc=;
 b=AYOphWhtUL1bCblXm+PI/A6DPRRefZE7wpGnihMX7F4ippeVIr12PWhd9i/q6pR730OtOY7JInmV6zLhrM0goa6saK71dsb4TXKeRCyDKoxM49umPC/gjazP8kgIydM1JIiCdwz+VYRkC6UKWw20xZ7PLBYoTDWIbc7V4QCmVIk=
Received: from BN9PR03CA0143.namprd03.prod.outlook.com (2603:10b6:408:fe::28)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:39 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::7a) by BN9PR03CA0143.outlook.office365.com
 (2603:10b6:408:fe::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/95] drm/amdgpu: Reserve VMID for NPA VM
Date: Mon, 31 Aug 2026 14:26:46 -0400
Message-ID: <20260831182754.1089811-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a9a476-30d6-4577-f2e5-08df078dad54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fp4h85G6xCxCoTIeWQe11+1pcCrIPI0NucRO9SM6Mh2UDy1DifHYltvhloK0uBsFUg1NQbTW6ISsCly62Oa0kF9BEno2F85WeUgXxMSYqmtoP8DjmLzZgFXfg1YomJ1Fnvm545BN0PK7ibONmgzthRySS6WMTpfN1mHwNNjgDVmOxJImOuvUIZ9vwH2iZi70Gut3rzMSgqWoJ6QlARjYSO0ecOx6mMOGcV5Nu+RJIqIOTlChSGtlpZ+PpWy21ZZxDoyPDBNlf6iJbYtHutAe3IbEJH8MSaP5RaPLmZnBjc2BUqRWEj/fOLi6Sg4/gD7xhk7NTQKwSreCF52FuuG1QJ+ZsH4yAmx4AhsVV8fKlYmAhVOOWxcKqTDgf+BmjuB8nHk90ZII/ukaVIbr+FzPN5cjQwmixohqzHcmr+ySgz6ObwopfDrl/zuZxY9D57yl/xW9+zP0rwLxNQH8mAjSVe1RwgnM8FkqTNdIsBziy/qQhmRAXAIdLSPBmX07t0HHMltbM7Acn0oP0i8jKvRrK0RTZb6qUEtiHmQoWx0FPc6ZuM6PklUYSWSyM8zzKVLd4N8iH479F89ZcguMkTx5wX7WDIswcU1Q8LpkV1pqZFt8k4O8ul+L8HZwDo1t+2K9r6nw4iupojmH44iEwVWDzsRke8j7jOi6DUjAoY1eDiVlXPxRwjDlVuxh6aa9a9viBHa7bxNUvRTHE1rCeAcVSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+ObsJtGsiMJGkIH92exIs010jMlBnUYzxo04YvhCMOzksuLQEu9tQSwsmpxdgwYy7RUYMNF8llI3qL2L32ZTdlKAK9HotgquzkWN4SxuTI+V/7lZVhkAtOnX5A18MH55moKygW4AROrdzXaIxidjj8xUyLUQb0VwFdK4RtL5jztHKvjlcl7T/yyRLkUygd7V/kNorpZMSDvfMSXHEvDxLcySDn69pMe3ZcHSA0qVBDRG7sBTM08kHcOvXtGav8sB2tvtNH5L/A6A2hyregbzJ4LoeQxMJoER8WqtTPkXlgRQrKOM0NchOFg+MsO9mwFaAs3o7XXL/VgZpKCiOZrBOORq0Y5psAEakl4KGPYbXah8rp2us0vXjJ5+70TF74jYBiWHKSY5cjRXTHdaRQHKyxBgjScWc9Ifn5B0/5fyjjmRhfRjAY4Y3/w4Tnf3HqP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:38.9281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a9a476-30d6-4577-f2e5-08df078dad54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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

From: Mukul Joshi <mukul.joshi@amd.com>

Reserve MMHUB VMID 15 to be used for NPA VM.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3533d677b4a20..7a0ee19a12b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -411,6 +411,7 @@ struct amdgpu_vm_manager {
 
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
+	unsigned int				npa_vmid;
 };
 
 struct amdgpu_bo_va_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3ae3ba42c6b0f..0cc73982ed6f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -814,6 +814,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pte_addr_mask = 0;
+	u32 mmhub_vmid_mask;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -958,16 +959,25 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * VMID 0 is reserved for System
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15.
-	 * On GFX 12.1, amdkfd will use VMIDs 3-15.
+	 * On GFX 12.1, amdkfd will use VMIDs 3-15, with VMID 15 reserved
+	 * for NPA and therefore excluded from the MMHUB VMID pool.
 	 */
-	adev->vm_manager.first_kfd_vmid =
-		adev->gfx.disable_kq ? 1 :
-		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
-		3 : 8);
+	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
+		adev->vm_manager.first_kfd_vmid = 3;
+		adev->vm_manager.npa_vmid = 15;
+		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
+	} else {
+		adev->vm_manager.first_kfd_vmid = 8;
+	}
+
+	if (adev->gfx.disable_kq)
+		adev->vm_manager.first_kfd_vmid = 1;
+
+	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
 				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.55.0

