Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49384C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F4010F47B;
	Fri, 21 Aug 2026 19:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IgE9ihp1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA04610F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPAaiFecFqnzPkjwjd7AHmX70alYZAWUrrVgnTNYTgPjMhMyN8p7PV9BA9RDBwvBx+AXko9iUZqlW1jPO2nN4Rrqd4Be8l5vMNgTCiXLLf/iDgihGnJS8NbiaUKIv8NRy2nZSwi1ULebkpZTFNqNkw+lRa5NbvwxuITmwLPGlqQI/mY3Dv5wzJojco8O35OaXfJZ/XYuCY2QghJnNZjlRH3AJOxiF+lDVB0Bcf/4psQe9WPbtxovHfNYjW7fefMb1a2XtkSmXzC/kTXZGeGjokBbWFOdpmJMqQAFideqxXeGVm+erN9F7y2mozfXSXyZ0+Jw4ibIkC8G2hlfv4GbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRImHAPoartQcVEdrY8SbA7McZ8LYHWYKnxi4s0iL3E=;
 b=H/fyo8U3Z3ZXAOFM3fPNQf4+XhS4lZ8SfNVeWfUfiEmNq0yPXHKvhRG+WKajjERvacd3JO/tN0Ffv6kir3soX1xykZ7LS3YlsjzXTzEPm6Hkn8L9vkqsIhMygqcQ5mVO1XGayy9598Ikuj+92HsoY5xz7byBjviI0x8XbsTQdHYs3CGA7UUCywhp9RTcykbI5jq07B3mDsV5+WFyPlXlBQ6tF3Pij39BhJwjAOkahhBs/X3z7FKkUgIJ19eXy0MfcFzkfVD4ofIhtnsYoYo8W4k6SC1DE+1vtnY+3lCp4jTpQFvQRkCB2GOaRW+oSK/9GCs40WupBdiIxpybiATfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRImHAPoartQcVEdrY8SbA7McZ8LYHWYKnxi4s0iL3E=;
 b=IgE9ihp1e0esnCQWqGe3RPohxkjBRUfDlbJL8apqMfyOpUqI+e7ZHEm1V1uhKe1OpsWsT2pgWtFGQWTucgnhuxtAceWFwMKofkc1MgxpfViZr09isdW8JCxVaqYrfNeM+zgUPkEMGjKmP0asluGPJkn5DkhQPHapeG/cgk3c0bo=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:38 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::93) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 19:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/95] drm/amdgpu: Reserve VMID for NPA VM
Date: Fri, 21 Aug 2026 15:33:50 -0400
Message-ID: <20260821193458.808626-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b7b186-3040-40b7-d5a0-08deffbb6056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Txnp57/lvBzpkWxtYPhj+J7IKkEjutFpzeLymGdxeyeUujlU5drvPmquz+k9dzDWb6kGdqGGfe5cVnFq0lH+gFVglBHfJaSOc1NZllLMBWR0OaPo+oEULIR8W+v/sOQDKFYpV3TyCeNaWQehx8UQpRGTU8PXObd619Rymfk6wnsR0QfYSY65+HdtSFnHb1zLBRE0EZ256QISzAC7OQ6ad1lW04c9nxJZlh7hI2v+80bXfB36LDbaYlB0d1pLMZ1vhiwBoXvwqXWST5vad17YoBeuZx1vuR6cbbHKzosVfAjVt8F56ftS3h7a4hngBiCq6+UTQTe58Ik3OA0AjK2mk+Zr5UWFL//RGTBchuVxuG5o6Oc2VXJzMdXp+stWDKhNoYdmleeJCtAIiVihokirdC+D9STYZJs7mxnDQLRBmnoVGBDEd3Ez7fyV3dLrHbtbQwFUUlD4p16vGi687ZCOQvOikYB2EPPf085l5O31RebDfa3aHrAGWIBLZ9l5DnjMu7guDHkIOj4DnlC+nViMvP8t6KwMqbk7iGdWKLlZWvSV1GEB9N+XYErvibsZhhOj+PhBi8kJkHSmyHRgcgX6y8K1qBEauCG107HYMW3Dnq+kzZLtcVgsiXm2a18o6U+MvfAoStuY4TH87CNl9n603uFVTndtyAGBUWxxmM9iN96q6GL7cmYUTFDyTUXLvmfdAW3wycTH6KL1axK9e3F5CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z7c3Cq0uiLNcHgomtN/Tu0/C0A6hit55TWU8H4IpT0mFT57PHDN8TFOHsUbqi2lY5vc2H4m7X7I3DJ2oQHVY92RwS6f66WKO4CutyG4RA9WZKIab7CJ3fgAQBMa7MiaIMXbcF8AkEe4A8zYkDzbfTkDTVPtutVCkZkcSkhzNQJa3CJbyGkTkJWX6LAW0dIiCpfhASJTq8ZN/zIppOzAvc+AqTY7MHGv6KXOKue+LoImRaFrm5mm8yN9SucEfai0DgZHybvaUhrGXme1rm1cyIgjds24FCGVuUMwPUX+/aaJLSx6mAXicHEZ4ZO53hZb1IWEFrKb0S8Av/EnrRHzedNT7zSFWveAs/bMLYLneEkr4VWQGWCbyDYPUd/WjEVo8NJ9XfGNlNCSNuqRXUKiDsm4QHBVkkIygrhuxxxjFXi916yQ6X4bircbDBofwRmcS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:37.2663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b7b186-3040-40b7-d5a0-08deffbb6056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
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
index 253ec6fc018f1..9dd7a17731f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -485,6 +485,7 @@ struct amdgpu_vm_manager {
 
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
+	unsigned int				npa_vmid;
 };
 
 struct amdgpu_bo_va_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cc4eb05215ea1..1a32b436617c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -809,6 +809,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pte_addr_mask = 0;
+	u32 mmhub_vmid_mask;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -953,16 +954,25 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
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

