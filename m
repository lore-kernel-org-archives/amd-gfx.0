Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E63861264
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E63861264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014846E1E6;
	Thu, 11 Nov 2021 21:13:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B68D46E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 21:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzCaD5dG1IsJlQxXZU1gBeNBk7MwAyaFDud7AqBmN65Pi/qkg2GrnDOuDY7dgpJkrOCxd9l6EWh/iuaG1c3NbxmCotQ343piD02sWhHkHahUKa6uE6WueCdkdh6PCRn0yyPjtSC0eK1+VqJFvMYLR/YGjp3pU0bUmIZTwugo77AUWpfcW+7RBtVbVilt9gMiOB27YFELDLPF+GIdY2grq8e84jPX3KEBeG3m2vDbCM/JdjBlDPfsR6rYnu5z7L0ypFAruMU87Oc5ybWnvpQDC/gh9vlL1FEMHbqsI8TcvBkUPqk6w3RU6RZiFFA2jUBGzKVZsNxa5SIlRh8C6mfNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDDcYfVDkpTvAqlsWypU27TN5Yx4SU/PqhN2LO2NAkc=;
 b=ci2rp/7d/+4YF7I1BBnppJB22pNZTQecg/yUf9DhYED5HxUUC3IJb4stbMOb4ejNBEGPXAbS9SdDU/RAwaw4oyudKlw5/Y6PK0hk8p0pkvt5Y/N7uCdMz9p490PtKy2DHL8gpxSaVV+xzkZG7/o6JIgQR8kgtvZ18ohn1bInSuQkU4nwyDExjWem553M8COfCFVnGBQIO4vrhv5hCql6eTj2eTaOZ09ZbY5ikesnsNt7RPKYRmRLhr93MABVKjnXWoW22oyFLMCKpPq3/6o0oBd8rXW4xU6iLZvtP+3tRIcfDKY3rRV5plotEyCtf78jtHv0pM9MtNKa65Pc05qcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDDcYfVDkpTvAqlsWypU27TN5Yx4SU/PqhN2LO2NAkc=;
 b=hetTC4+oqetptXN6ByifFPeaA3GJ4SHOTLNCrpW/EhNwqrHcI/+t2Xqu9XUN/YOz7QcXiiu6TGCPds+Zec+STSNiieOwtBIYJKHY5YMlxsoKnlVnQjM2ujWrspUhd1rTucH5r4sCzLCuCgVt/FXoiYs6m/hMZ8SzdfSKjfquXRE=
Received: from DM3PR12CA0116.namprd12.prod.outlook.com (2603:10b6:0:51::12) by
 MN2PR12MB3600.namprd12.prod.outlook.com (2603:10b6:208:c6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Thu, 11 Nov 2021 21:13:23 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::71) by DM3PR12CA0116.outlook.office365.com
 (2603:10b6:0:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 11 Nov 2021 21:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 21:13:23 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 15:13:14 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Date: Thu, 11 Nov 2021 15:13:03 -0600
Message-ID: <20211111211303.12291-2-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111211303.12291-1-Ramesh.Errabolu@amd.com>
References: <20211111211303.12291-1-Ramesh.Errabolu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c60a3016-67f3-4c23-7b87-08d9a5581866
X-MS-TrafficTypeDiagnostic: MN2PR12MB3600:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3600621DABBA9700F73A712EE3949@MN2PR12MB3600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5l6ZQ7x/SJ2JAhUAOikWtDjWBEIBJYY2y8a7A45Y8mFCqarCTyZMdTZyGrFhipL8z1nocXc8qhwnt7xHHEqho5QSURN2bJ1y7l3f0fKCEWdNLknXqumlr/kphcITpS40orAT1eVlLKVZivlFAzHWwGVy1bmMpaop+oLjn4jVnAB0K5kzoxPAM1XoAijB0m1uanAUGmY4NRvzCHST0ugF2lty2ZLQdm55Jb1S8guBnff8My5Ew2+NkC5Dre9IBUZEp7xu3EgRkVFnHj1s6m6wlpBbqe4OZrOYKpBXix5PrXs8qswfDin6xvfAD+5CilHrViZM2Qi7kC6+hkEDftRYqR6lPHfnnpoa0NZh7NbR+qPJz6nqS7chcNC4HtvUUBQxhvgFgkF6lzkvVmzv8Q1J+6PWRiCI9ZG9ViwknwgeTFOw90fqHcsSpBNSGEVQ8/y+jZwIRry/lI4dipLcvuot5xSZDNH+EvMTVjFjIr+VOWOqYs1PFctGlGLR5c43GhxU7tmXUxBXNf6OfpmYent4q1IRkTLdA/u8Lqpw6yBFUPdBAa6D57Z4p1IIZzqAIaa8NELIl0CQ1BVUVempfzjDI+edQ1T/Ee7jO83eO7K+D1tkYJQjFxM3UOh403PDYwhDoVV+WsJTArRnFQmr9o8cxRdB+OYxlbTmsJgbmYJIHwUMquf2KJ454EyRGzOMhAbjbBrhqm+zTTf2QQyRMOuEAl3L3pIpZxhN3Vmj91iBzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(6666004)(7696005)(2616005)(70206006)(336012)(8936002)(1076003)(5660300002)(36860700001)(83380400001)(2906002)(16526019)(36756003)(356005)(86362001)(47076005)(26005)(186003)(70586007)(4326008)(82310400003)(426003)(81166007)(508600001)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 21:13:23.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a3016-67f3-4c23-7b87-08d9a5581866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3600
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cfc84af682b1..90b985436878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1295,6 +1295,55 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	return ret;
 }
 
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
+ */
+static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
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
+/**
+ * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
+ * @bo: Handle of buffer object being unpinned
+ *
+ *   - Is a illegal request for USERPTR BOs and is ignored
+ *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
+ *     PIN count decremented. Calls to UNPIN must balance calls to PIN
+ */
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
@@ -1521,10 +1570,22 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (offset)
 		*offset = amdgpu_bo_mmap_offset(bo);
 
+	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
+		if (ret) {
+			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
+			goto err_pin_bo;
+		}
+		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
+	}
+
 	return 0;
 
 allocate_init_user_pages_failed:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+err_pin_bo:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	drm_gem_object_put(gobj);
@@ -1557,6 +1618,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
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

