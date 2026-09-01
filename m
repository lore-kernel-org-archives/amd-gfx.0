Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67036C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AFD10EF10;
	Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbuqiUqu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E546D10EF0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvHWa7nz3MykTUrP9gTeI7XWd4Yw412bdon03BnDlkgs6g4aZWc6TgLanBFS67HLPOSqc/VAYEOvEiH3RnUMxlXUzvHEYG69Fe+oyFIXNBjIPufUzVL795QFJxFqK8JVfekziLa85YC67tRLDGOLs+cyWBnQKS1Ds8NTccBh1qJqaLnq6G9nY4r0AZ4RZHSDAXZiF1RQ6OnJOuX/kEieCNSg8tmViETLF1NguNfrCiY8OmFhQ8+cfHFmJrw9ekrEXsGmWbpM/IRJKqeoXMq/d2zVKD/9QMaaT/OTt5mwQAU1wt3GVEMVdwYYzhHRB0MDShMCCaW8mgGxLi8PZObtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO+3WWEhM0M1XnI/wzJEk0QD6xDDo0bWJJptzLWycSU=;
 b=IjrM4XlwwtT7Vb7/rkouVSyXn07Q9wet8ZIlpDeOslim+PcCF7+QhFIs17arNAC43GFIaxnGDcxQ61MN/OFeWSKL16z/n967UV5OWpB31628iZkloiQVjubZp86lhoTBytwy7Y8Li/HRg7fYd6O9SIXKWnOBlQd+4sRcGR2XdscabSmgVcYtKYNYtiAa2NKzqbrunrcJgNgzrMlkUbwqnZA+vLyyJ8knttww7yCuvZ5UMFY9IQagcSFbgKP7TAP/mWrWoyZhftI5yk1iVE5jfvIm8A1Zxx6BsnL50JeynA6SbtFxWQeDPX38EYkrjuNnik415jm/lxO5DAk0xYAkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO+3WWEhM0M1XnI/wzJEk0QD6xDDo0bWJJptzLWycSU=;
 b=YbuqiUquFzYac5kqyyvSWOxmR/5uPQODW8+wFJwwYeqn3oOHCpLnS0z+hEFOdTauHWqrXW6ZuMEdcnaExzBup6iXRkNrb6meNfE8O7ESi7atXc2LqQH2NWhHnbxRwTm5YMZP1MUeEJT/lfBySNoE6+u4gXBc8B8ybLMCWaHehzs=
Received: from CH0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:610:b2::17)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 20:11:05 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::63) by CH0PR13CA0042.outlook.office365.com
 (2603:10b6:610:b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/31] drm/amdgpu/gmc: add new callback to lookup vmid to
 pasid mapping
Date: Tue, 1 Sep 2026 16:10:23 -0400
Message-ID: <20260901201034.2960437-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: fc076ab9-1995-4142-9cb4-08df08652726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7ye3VuMDaA12JvjYrHoPrCERAH1AF646Llhxk/4Zn2RfFXHh9ThIZmAgvrjVbwiouHhxaf84M8x+NajnABETaDzmdKAfF6W8xoqqc9ytOLjS7AnjHTQ4R2F+YESS4TlupOolmVP5UsNIzpxUZHK0HlS6/m794qkGbm2fDXILyul5XAFT+dUlyqntVc3B0BN0XpRLx3UUTYKdxBUqce0jxOVj/p5obAl8Y0HcZdmDOkK+K5bXRUdvFrJfiUdXxljDprXfLL91l+XgZB7AONdMqSYsPCKN2xGbHrB/5qKcO8J/NLVtcZSrMJRuV/qi1V7DcvuDmRnPfdac1TgHQP7AkIRDnHcurJmihjxtcNjZKBs79Df0OfYzILtNcudNqxNKXGSwiBJ17KJJ0Y1oF6VBRLmO9uUEByOHoySOfToz34Bofc+WbeOGtw/yNeqlUwYCypIBl9+smgya7p7TndQ+Cuy95NpwD2HGUtT5pYhcMTmaCK9ZDjdOTK5fLrng3IjRZLLnAkZr0xe+BaG5VU8Wv1f2nXjzpGljnWHrDr7UQfZVZPRrzZA25muJ7mnYXo7VOvz56csRmFfzODffFdRJYjSZDhRqNmUbFFcrsgxHKo58XzwauSMbof7/9/X6vp1muaWu7q721n/vcJvsdiGvd5Iig1TLxwQmvxd91IyWUQiWNymUISzfPFj4ErXO1C3wbQmvavbOXF1mgRWYRm8mBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y9l4LuLioPBq80AfSEPNCZ+RCOwqqZgbWpW/3VkoEdGto4cisZ+b6lPbH1if6REi5TPXYzhUqS691wpEJHIrGe1xuypP5jPuDmHxLEVPkXeCQe3mskpcd5IUfUtnKvNWieGUab4dOcRfBaLMdkoberC4BmUk0kNs1FHS4+rbzpeFn3qIBQrACX0/OWHs/lvNbu0TMeZlRSZkQN856sQ9f4j5iftk+v3oLq57KGSz0kKVfnrPtq1o4+rFVtkUtrd6KuLnhC6l5m2jkuPGlm6Wr3F584GOwzVB5QA2l4ohcs3HJjeocY3WhzygbLyRfoU7QAkuc46+DHO4XyVQpmkKLJnbf4fqL+ch1q5qmBGEpw+izDCXr2vKT167Nv7hc9cLVjvbgpwpTlmk9hpo981GkqoSjT93Z2BaYCStdNiYK6al+Rdq3pPeWuwSbmqwCiW3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:05.1014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc076ab9-1995-4142-9cb4-08df08652726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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

Look up the mapping so we know which vmid to flush.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 ++++--
 6 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 204cf1c360896..27785b1b38ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -171,6 +171,10 @@ struct amdgpu_gmc_funcs {
 	/* Change the VMID -> PASID mapping */
 	void (*emit_pasid_mapping)(struct amdgpu_ring *ring, unsigned vmid,
 				   unsigned pasid);
+	/* look up the vmids for the pasid */
+	bool (*get_vmid_pasid_mapping_info)(struct amdgpu_device *adev,
+					    uint8_t vmid, uint8_t inst,
+					    uint16_t *p_pasid);
 	/* enable/disable PRT support */
 	void (*set_prt)(struct amdgpu_device *adev, bool enable);
 	/* get the pde for a given mc addr */
@@ -384,7 +388,8 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
-#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
+#define amdgpu_gmc_get_vmid_pasid_mapping_info(adev, v, i, p) (adev)->gmc.gmc_funcs->get_vmid_pasid_mapping_info((a), (v), (i), (p))
+#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags)	\
 	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
 					   (pte_flags)))
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 23d9fe995a2b5..0028639448956 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -204,7 +204,8 @@ static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	uint32_t value;
 
@@ -346,7 +347,7 @@ static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		bool valid;
 
-		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid, 0,
 								  &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -555,6 +556,7 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v10_0_get_atc_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
 	.get_vm_pte = gmc_v10_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 098e1340554c5..b34bd7881726d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -200,7 +200,8 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -338,7 +339,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -546,6 +547,7 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cffc818880d12..9179dc0787f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -196,7 +196,8 @@ static bool gmc_v12_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -374,7 +375,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -581,6 +582,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 6c0d2689cc05d..3fa1ec3dca273 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -668,6 +668,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_1_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a91d0ddb6e729..0019706b0b2a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -727,7 +727,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 }
 
 static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+						     uint8_t vmid, uint8_t inst,
+						     uint16_t *p_pasid)
 {
 	uint32_t value;
 
@@ -889,7 +890,7 @@ static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		bool valid;
 
 		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-								 &queried);
+								 inst, &queried);
 		if (!valid || queried != pasid)
 			continue;
 
@@ -1302,6 +1303,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
-- 
2.55.0

