Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E450661152
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E450661152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1AA6E3AA;
	Tue,  9 Nov 2021 05:56:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F0A6E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 05:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZTYUZ14NKO3Z5vchKSged2BDjf4xV5apOm5PG5P/d5w55CQrfKxTgDlLTFbVQmHIII8zPJG5m8zpu7Q7EazphrLVDNcOKeC2j8QZZwW9e8Uu3JDFZW5lntLT3w1T+CJ7HkergDifLXF6CaPS1dO4eXA86xvhoIKiKlq9OzeRFeCax6ZImtzb52SaQPJLt3w3ast6MJM358GZZauzW1oj55XPIPxyW46T1h9Or/huCrx6zqx4a3ZV9Q4Ftzn4kBMJnAAkIaEAl0qZzOA7UV+u8EYZUrzL59TTvN4Ac35W3GyE+LF5BxdANywkACYv8n6vM9elYpL5/xeptoVZpTkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUOEFFCYMiTTjhOBFFwySvm8R6It2GRNA3RR2QAW5jA=;
 b=M5XIygwgTIF4cWPl+76ReM6x4hh4tCdgVyff4PzJ16fDwxBQRTvQaZCiwwlM8lmJxVLWeNVGYOvs6peBCKX4L1Da0D878cYR/bjuViBW+6n2ihz4MmOe+ohDQzi7ouB/nEhjTnxgDW4AGqX0xj/z+9nldaYym4UXcjDuo2XwYTV486vocpPYreFMd1c9mA/WmRrQbzb1UMLlz8Hyn4NImfe6zrvZz1wZMUNPNwsnshXp6OH33u9uB8LDrt+fH443C/SJhZL9E/QSVWlUBKZPfJTUiC0qd2UjPNKg8OtGGd2giXAQDA/JK/Zrl+OtO/4jEqfGbHSzm36kZ3Ez5fNhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUOEFFCYMiTTjhOBFFwySvm8R6It2GRNA3RR2QAW5jA=;
 b=UebmOs6SQUbCECFnBC6gBbCXH8QBe/qyfj4gElkB3UCphl4b9FzWhRpsWU1G/YbiTBtqhdtgoM6cofexpgE4EEWUsCKsmDq3SCGYzotTuage7IQvl8Lo8C7ay7mIIq1kdqqCJHdgrqTJ23e1qgohNDSsFFqFxoL5WnRDFipK2+Y=
Received: from MWHPR17CA0095.namprd17.prod.outlook.com (2603:10b6:300:c2::33)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Tue, 9 Nov
 2021 05:56:44 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::28) by MWHPR17CA0095.outlook.office365.com
 (2603:10b6:300:c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 05:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 05:56:43 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 23:56:42 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Date: Mon, 8 Nov 2021 23:56:27 -0600
Message-ID: <20211109055627.12682-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e47304c-58ec-447a-9668-08d9a345b52f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14188DF6ADAA0BCF7B18CC23E3929@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBSMrFsBuAxeDJDcrgHV6MDxnGnH4QS3TYJCqV6tvbcOmhHIv0FEP6QS1iM3S7gILH0wu810fSWiqksWhSQ/kfMe9TrWGEolgA7q3N/Ekyj4KJ1Ed8Nq6h4qtPYfx3+N4jGQKuDxcvkuSOYqLJ2TEnoOVBGexq2uDoLruXfnZvBJUQCU0g2gBlID4h4NTuNatt/bVh3jYnxSSGsvKg4y3eOaKqAx7uoostDyZBsD2o93JKYeekC8R2AEj27kz3Zp6cLwDkFUfvJbuQdyabzid0YF9Uy1gaYUUM2SP4kZBSi/LNx6ZFw4p+iYKQrROqQL07gCnd2Cqvbb1k1LIEGYphRS5zynz+Drbps/e9/6cU0GBP448zA4jGYN3UVjBSvd3oL5O95yQqOwkbPE7E1HwiJg7n3jWbV5yMalK3R6iEqZdO5iFPkmyGifC3fIXqu91LRowjCigx/OAWHoQkp3x/91Q1VfHjF3p408PE3njNikdqzGoBvF68QQjrQ/MFcS0/1gWsgQ2C0XPdMXjT+rkYGcQmws2MBECOYJ2mSiciKME7KH82dEw6rXOlNwK+CXq4E19sbmjRRyGmoFJqrZ3OZ2jE2b07OLuXRkPRadflLykbp3JyWArEY8sMbZ2ZGXspqHeOuoA6IVdI2pId9yg8Gf/B/ydgVnje0jcju3tqRV+5Ex/cryXqK8azE7odivrWGB+rZbgXLaqrUZUEXa1VZye5qBbtHH34UyqV6sMrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(426003)(2906002)(186003)(1076003)(2616005)(86362001)(47076005)(36756003)(336012)(70586007)(26005)(70206006)(16526019)(4326008)(8936002)(6916009)(7696005)(8676002)(83380400001)(5660300002)(316002)(508600001)(81166007)(82310400003)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 05:56:43.5852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e47304c-58ec-447a-9668-08d9a345b52f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 08675f89bfb2..adc27c0031b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1297,6 +1297,56 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
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
+ * Will return -EINVAL if input BO parameter is a USERPTR type.
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
@@ -1523,10 +1573,28 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (offset)
 		*offset = amdgpu_bo_mmap_offset(bo);
 
+	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+		if (ret) {
+			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
+			goto err_pin_bo;
+		}
+
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
@@ -1559,6 +1627,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
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

