Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA99C55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E019B10F006;
	Thu, 30 Jul 2026 17:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Si825cfm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE38510F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Ip0tnqsfmJswOXUzyepwGY67QDl4hZPWytPEKNzbpIDZfuQXwc4ADqnU01O5NPu/q/uGsBNmY87hnfmxCa8RuFIrN126feyGL5//VVQNgclKik25mz5g9dFfOgmYzhHJ486bYMZOvCGrF9gZjopsTkjFH4SU9MBk/cFsKXBT0bYx7Awtis+YXarqvpNey3naQ+/hcqsfTAYgOQUsuL9c9mJbOhr3ifSsS7ggFt2www29o8vMq00GLBweNLqJButdDoNMtLtvOFdkQJuNThp1n2JtbOnsydjYZBpb5o/+B4erb6Lwch7EOUfP4Hz0ZTegEwEefxFh0E3nF30FKv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB64A9TR1XQhneyaPmU1bM6UpppZw9JP+GiQwKD0+Ws=;
 b=P4Q23fxCtFzNTf2HKOAE14C/vve2ZcbGXKba+ISJ171wBFzPO9+3RLyUZKM5hH0hzrLschvu76T+HoDhlkQBmdiUgVt3nncRt7X3thNCinZmDWMgTT85URxYRSVmmDX2Z2re7IvCn5nco6MDtivmK2u0IlUef15dm7TIANvpd1pxS4q21Sadb9SPysXaRGnh/tChl+N3d4bq266n2qoNfvIz52DRA2noz4O8U34oHCbUHLqi+6wyyBcKqlwPZUFZHu14/rCSJD6FMUNEvi6NJoCpgQnix0sCO/FaZfJx6Yr4AJQBjlnKmvezN2aRB5lgppofh8nPzeSNjAETvSvdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB64A9TR1XQhneyaPmU1bM6UpppZw9JP+GiQwKD0+Ws=;
 b=Si825cfmjgTlAlNQelfPCyDRSOp389gR1OH7uAg9YsAZKJMelp+uDiM/7b2LHtUbAqe7KFlsfKUttndiOxkQL/x0K2MPYRVNkT1r+9g99YuYWbZmGSLDwbAfxPYmq6RFnJz0UrX/Hk+uugAfbHf8YNWnw1Mc5S1EA+Rdzw9ofl0=
Received: from BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:27:53 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::80) by BL1PR13CA0068.outlook.office365.com
 (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.9 via Frontend Transport; Thu, 30
 Jul 2026 17:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Thu, 30 Jul 2026 17:27:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:27:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:27:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 12:27:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12.1: implement tlb inv semaphore
Date: Thu, 30 Jul 2026 13:27:40 -0400
Message-ID: <20260730172740.1268133-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcac931-e132-4865-07ba-08deee5fe2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 573uqh/FRaCTkqkfTOFODcZRE8ToJcCwTauxPjiXPTMgpzr6mrCGhnm2EEE3qUcY5ax5+k3ttDgQGfCr28BM+HR913JmCxqTWH5P1HA1QApTf3M+JheBOPi6Acl3ZzxtJgLgLcq5I7oRRp+J/dRJ76SV+5LYeZQDDu74YpFipfXlzQ01YfxCr9eOZQ9julxjUhv0+tSbIawafsSlqZI4EdPKzO/M2u376EY09MvWuudJYG9ACQVPTP/R+G+yYJZ8ieh/szDxB6fCAnWoKB/hz9ynEpavjqtR8fzw5afZwJrld2trYoY40S2YYeYWrwxyqWbd6sJqqpVu7tVhyiYC+AIIfV06Xc3jdEw3ZotfwSf6Dx23RzEQGm1zHxXOPV0nrIzOllCA6sx3UhgVfWeP9LlcRptA9GMtaNJmRFeonFez3R+YlgVur7vIUs+rF8fzAxkW+apE0Cg0nv+1oC0RNmvxXD9y5TZmE7y86NYsVTzEV02wYh1ROzaE376aIzZDLQcl2VaLpvnihbdkhyp1gHTC9ZHrk+Fap66FkA31KLBLoC00jwf3c261h7dTkJbIMQbWDK33j4sWNw9I77sARICrMBZAZ8VdwwRb7FxijVv/PVkWDfQpNnklcKY6Az8OZBnWgCNgUJ6rZAQ742iE5/RhP1ZK+X7GxDTcjSBXsCvfjjmPFSlGxv2yhqW5ILw69Z4ZK6PIZkjU7CpfJHORmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4dYyGTIZyHo6gPQe8gt7OLqZWcQfKnFq6IuchjDTggtbKLIyVvjBU+p/AmliRw/IczizXvU3sYyvycg0eYbpGaDyvwAriMh67YVT0j/oQHO3W1acSWvTpoUo8+M4Z4JL7V+7ygw1s2e93Ez1dOK89/ae3d9sFcv/jj7u8Nu7kDM4CCJ8qkCl3IES0cUAIZTFlqNVQCvJWeZbJFlPp20OW01PerMiIhT42duS6yytjKb+Y7EoGVoi8w61F0I5M+LSQoHCW1DhkySMBwbFsf7jelDWcm7fuTc1JDNbjO8MLVdYOn3JX8uglT8wwCmofxht94ekduDFNiqbUqcb528RDjTu5xT48HFPLEflu49wGBs2Zcn1uNpSOjE3MCQIW2bGwnWW/GHO1vvGLaZfQ+zMs9jaVNQ3zyI1HsRdDXl2SHQ8VQrnEsjfuzT6XEmruMTT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:27:52.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcac931-e132-4865-07ba-08deee5fe2d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711
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

Needed to properly lock the interface before using it.

Cc: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 855cd29cbffaa..bdf6788b85b58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -267,9 +267,24 @@ static bool gmc_v12_1_get_vmid_pasid_mapping_info(struct amdgpu_device *adev,
  * by the amdgpu vm/hsa code.
  */
 
+/**
+ * gmc_v12_1_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v12_1_use_invalidate_semaphore(struct amdgpu_device *adev,
+				       uint32_t vmhub)
+{
+	return ((!AMDGPU_IS_GFXHUB(vmhub)) &&
+		(!amdgpu_sriov_vf(adev)));
+}
+
 static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 				   unsigned int vmhub, uint32_t flush_type)
 {
+	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	u32 tmp;
@@ -283,6 +298,19 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_lock(&adev->gmc.invalidate_lock);
 
+	if (use_semaphore) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			/* a read return value of 1 means semaphore acuqire */
+			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, hub_ip);
+			if (tmp & 0x1)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout)
+			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+	}
+
 	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
 
 	/* Wait for ACK with a delay.*/
@@ -296,6 +324,9 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		udelay(1);
 	}
 
+	if (use_semaphore)
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, hub_ip);
+
 	/* Issue additional private vm invalidation to MMHUB */
 	if (!AMDGPU_IS_GFXHUB(vmhub) &&
 	    (hub->vm_l2_bank_select_reserved_cid2) &&
@@ -431,10 +462,17 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
+	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
+	if (use_semaphore)
+		/* a read return value of 1 means semaphore acuqire */
+		amdgpu_ring_emit_reg_wait(ring,
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
+
 	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
 			      (hub->ctx_addr_distance * vmid),
 			      lower_32_bits(pd_addr));
@@ -449,6 +487,14 @@ static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    hub->eng_distance * eng,
 					    req, 1 << vmid);
 
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
+
 	return pd_addr;
 }
 
-- 
2.55.0

