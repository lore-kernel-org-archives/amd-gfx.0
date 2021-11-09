Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF76161054
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF76161054
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5508A6E098;
	Tue,  9 Nov 2021 01:38:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEC36E098
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 01:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTp/2IhySvTwnywHWlrjePP+N8tlXaD94wscDTEKvmjeY8FggtA7SRDlRjCsIykriOqjPApnT2boXRoxhZUdZ/R1cNnKqye+8ujpp4B0heNdX7abSgb9aMHKrkioldLPVWdAa+q6vFripuxzaYP9O8FxRHbXjPmp4V90EGqjo7ZSubzDo582OWigxjfrXBdXDbRUcnlDFpfUeDCKPt7cNhHF869VftBhZicks2V1qfPLwsnjcMGvbsMmo+j0Q0JB8eJzM+smVkDi2CNIlnr4adKz6rcF8VYnVwd2v+6CAHHO+BN3ZC9nzEnBYlsKuX2Unrn57hwWVX574dE6AW2TEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdyJVOA7FfBRMTmY6ZYM+Ff9jJwSun7zxGwYMVgSCwc=;
 b=A8Ev6Hx2zuWAAuZOVA5Mmnu0D+83g9bk8BXndlpUIohCor9cm+CVzcclQXxjlS2k7dSKprcPXPQRFzf8BVGK0Kn+/YxEgeJV8Tq/4/9gBONJMnXWwYaJcTQw2Bwm+hOSNcHWEiqXoc8jbAWgVZcAuEqbxpul/OBJlqHdrkTjzzy0AeIjNfhhjZ1Unc9V/MR4Q1xq0l9XdiOR155gGa1IlKOSaF0mWbRUd+zashuXT/0SRK4QpvSC2X98+UwRA89zsK0xyQEBhSMUn2UDt+YgMWVIYSqJWUT0qcXgZlRKQiU/JL5Plu+o/bs3q0cIJ8VzGDIA6ChDXZ+yiSgquTP3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdyJVOA7FfBRMTmY6ZYM+Ff9jJwSun7zxGwYMVgSCwc=;
 b=YmR3Vb7xG8mmxoQhx0leUIXCshu1+R1K7yfRtZ3vk6FwTkSUpRjqfK1FhvG6ETbOmFKDH87ciTPq272AJILSf/u1OsbDY1uWUa71SBW/MmOsivI8Ib+PA/7WbE6EZ+XbZhOv4+ZBgU5RsH4EI4GKLVIYoRtasyJpJeZH164kSlM=
Received: from DM6PR07CA0089.namprd07.prod.outlook.com (2603:10b6:5:337::22)
 by MWHPR12MB1439.namprd12.prod.outlook.com (2603:10b6:300:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 01:37:59 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::bf) by DM6PR07CA0089.outlook.office365.com
 (2603:10b6:5:337::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 01:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 01:37:58 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 19:37:56 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Date: Mon, 8 Nov 2021 19:37:44 -0600
Message-ID: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4504beb0-affd-48f9-4dca-08d9a3218f59
X-MS-TrafficTypeDiagnostic: MWHPR12MB1439:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14397EF15687867277FA45A7E3929@MWHPR12MB1439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KpOS9N3RCiV8yYePAJA00oH/lKXp9yG6g8n0NQFGJ2x8xx54977k/SPnQK8EcTFmVsPco4ODu9VRC3HYicv3rxQutN8PqU3P9qrf3AfOKhgzSXogIZ+K3KvuQ0qFbQM7Wa/cgMM4KwIcm84diZmx/PeZ5VdNBCEe65uLeelfNm+k8GIGHKAqR4FqggCnz6HZ0LnQ4w3AFh+xTzD898Z0CK3IGZZVmOGK8sRd6srYss3dZ8eARJozGnInsK7uFp6ay+tEXrWsV6MddGTxXdi1J3z5N71hyF0jOWx8mXWoILKtTIdTWmmTZmI4HFyj2MpqOUimIfQcXH/8MocfR+409E5k5U46Cr7JFx46ZaVTMWuQwsu/Ev9TPK16UTr4/gq0BAUmv0cRmTrOGF8C4TAxw0I3z0v5HN9IcA2rVwSv/0+0EEqWZXmUEDwhdKdhvAKXFJQqasLNiekp5hzpRO/nSGTgEtm/XPjtG3cNF1pDTh6xasaJxngylFlcuqEECZkTM036hLVA8u1E8Ieii6RNNw0qIljLtLmKlwvytGNdM7Eu29GFnNymHYzZYCJe0Wk0m9TWyLBOsoenrzooQsVBy0mihwVtkgGikmUATqSooiGxpJRROSQ0w/nevSWxqf3q8uzDqaYEZy/WUB5QP9D5ZxRGtjFTZTIHq5vbcom427WlG0sroZmwom5hjRmSo3kkB05dcOPOHXVIOiQ8XiE/K6mk4ZjzIN48uh601yz4p8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(8936002)(16526019)(8676002)(186003)(82310400003)(36756003)(70206006)(83380400001)(47076005)(356005)(81166007)(70586007)(6666004)(5660300002)(508600001)(336012)(316002)(2906002)(4326008)(86362001)(2616005)(36860700001)(7696005)(1076003)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:37:58.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4504beb0-affd-48f9-4dca-08d9a3218f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1439
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMIO/DOORBELL BOs encode control data and should be pinned in GTT
domain before enabling PCIe connected peer devices in accessing it

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4c1d6536a7a5..d9a1cfd7876f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      uint64_t va, void *drm_priv,
 				      struct kgd_mem **mem, uint64_t *size,
 				      uint64_t *mmap_offset);
+
+/**
+ * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
+ * @bo: Handle of buffer object being pinned
+ * @domain: Domain into which BO should be pinned
+ *
+ *   - USERPTR BOs are UNPINNABLE and will return error
+ *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
+ *     PIN count incremented. It is valid to PIN a BO multiple times
+ *
+ * Return: ZERO if successful in pinning, Non-Zero in case of error.
+ * Will return -EINVAL if input BO parameter is a USERPTR type.
+ */
+int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
+
+/**
+ * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
+ * @bo: Handle of buffer object being unpinned
+ *
+ *   - Is a illegal request for USERPTR BOs and is ignored
+ *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
+ *     PIN count decremented. Calls to UNPIN must balance calls to PIN
+ */
+void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
+
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4fa814358552..f4ffc41873dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	return ret;
 }
 
+int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
+{
+	int ret = 0;
+
+	ret = amdgpu_bo_reserve(bo, false);
+	if (unlikely(ret))
+		return ret;
+
+	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
+	if (ret)
+		pr_err("Error in Pinning BO to domain: %d\n", domain);
+
+	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+	amdgpu_bo_unreserve(bo);
+
+	return ret;
+}
+
+void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
+{
+	int ret = 0;
+
+	ret = amdgpu_bo_reserve(bo, false);
+	if (unlikely(ret))
+		return;
+
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_unreserve(bo);
+}
+
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					   struct file *filp, u32 pasid,
 					   void **process_info,
@@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (offset)
 		*offset = amdgpu_bo_mmap_offset(bo);
 
+	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+		if (ret) {
+			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
+			goto err_node_allow;
+		}
+
+		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
+		if (ret) {
+			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
+			goto err_node_allow;
+		}
+		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
+	}
+
 	return 0;
 
 allocate_init_user_pages_failed:
@@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
+
+	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
+	}
+
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
-- 
2.31.1

