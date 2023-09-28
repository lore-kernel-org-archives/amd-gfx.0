Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83032E732E9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 20:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16ACB10E3E9;
	Thu, 28 Sep 2023 20:06:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB8710E6A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 20:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx2/jLwNc+m5ZF2VMeqTz9g7oyyVodqSl/y6d+EhhU8/+s3o8jOcvgwItsD81I66jyXQSceiVF0gmJxMbyoMDriSO+VlSGCf4smDRi9lFpMI6/mXyZahWnUPFIXmuJmKa49Mvmk52TIrjwyfjW8LGmG5wKXlGgU8pxx585dlveS7t7fuTdMAQcoNidcmFRitSSo3cIVD1JKMt0rpy+yjPKl/TLCWwPhKZHp6glUHGOh8+s6mvIq+0acHJrngOldyLdunOTGjRmw74NmDNklDG4wSYY04+35lh825PlJzx43AttwzItlIlRhORLTz3swtXvwZBHwrvI5VjIlkU5EA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JevVqlZToSH0euv5xo9z08g63nFvbVgDZENKdxGvQ+0=;
 b=TNc9DM/vs3w0XcvrN2ohTm7pQBTA6aftWVsCm/q7rkBex+r9mmElfs6zbvEltYKKLq5HdkmlO4JNqNaRGEpsnu/MZLlZyC2yL6vvT5XmnRAc5hF4UFOHPfD9JCOHT6bQ/udUly3+qngSWNI8u2RcF2BfUFq25E7GMT1n/QWm4SbkwJ8EHFvWceNEsSf/9Bxy2RZkqjc9vZ0j3IAwBOT9eFooNMsg8KBpbsZeVElo4hdp0VHddlzmVLA3IMC2Vi7qMpj/g5LqU0GzR5eYDKW2RYxV+GPlp9L0JMswT+HcC6hEAtCU2WKMc2kHqez7DD9Vc3y6nYWB7dBRlXhvjG48wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JevVqlZToSH0euv5xo9z08g63nFvbVgDZENKdxGvQ+0=;
 b=bVoFnYMemAyWwuBHdKRxMbAJ4T87JV6cuCy8uR8Z9YRPxMsmF3PdBbicYMEfckT9bTCTFgPR/uUC29Hosa6L1SSzpOIYde/Mi5s9eqYiOzRCquMo2UP5t7bmNhwk4OYTu2/47bYz1SD9q0gMlc0fIOQZm1HIF/UcsV7AFnIOZ/8=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 20:06:22 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::37) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.11 via Frontend
 Transport; Thu, 28 Sep 2023 20:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 20:06:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 15:06:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add cached GPU fault structure to vm struct
Date: Thu, 28 Sep 2023 16:06:05 -0400
Message-ID: <20230928200608.2857534-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928200608.2857534-1-alexander.deucher@amd.com>
References: <20230928200608.2857534-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 040c7939-eda7-44de-f37e-08dbc05e6323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Efz2YuYsFJ5kH5+jXs+wARgMrXlsJKKqR8PGB919rNU8lcM+VtS3uZ3ci7LrtXlJXhSMTIESUVKwmXKH7cNnHNksMacf8T4VDdV3JfAFdkMYpXEXINT8IJVZB8wVQD/EnefFFO/4dljJcmfqPUK/GZz+QhwhpKQN05D3aPtcN6oqNFhKiM8rh4V0VdP0iXcHOSfdnGIWIuXaTEURYpgJSwUoW6lAN/hm/2Leg/Y6PwH+HtTUa2spKb3oi9oynfCAAtjgwUhJ5mgY6y1h4fDo3Mq5tJQcfvN53xeJfltNdh/Q3aB/7NGDltHt3jOa+LiETdwNmppmgAFr7kFiQU3UAKPBtFQaU+Uy5cv0/wjCa/XrFK/iC2583r5gflcFF2SVNTFnWdZ0m68Z0HhjfOMHATuVyXEMDw0e+wq5Ln0eeRnvtOLVJaoJfh5oosUvK1vnW0w1M6Dro1LQxmmVGLLQZav714IpkM4S0mGJmcjpj5rqBaTOXxXRv06B+zG9OVplOAvD4zG7+QVJ9NixNQRDPaGDCXgVfWH2UQLPcSOugY4fcSQeMsK7wlzVtQDombPa1bZoXiWhsQOmXMbizoAHsHuuQ2l+tcMvZ8kX1SvA46nYWv3GaMe0kVQIymnbop5tHsyS21VAN6hDzF/YJZb+PCKKW7/1VrOLN4Ri/pCG8XRqt+3EIFzILC4xa8Q6fYJd9wxWxHvWI6Ms5J2711khDFvJrkzbTKruh/gqKdiMKjHlU56NRCy55HrK6a6aRlpj4HvXo0sezu+XG0JfRj8lbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(478600001)(86362001)(70586007)(2616005)(316002)(70206006)(8676002)(6916009)(8936002)(1076003)(4326008)(7696005)(41300700001)(426003)(47076005)(336012)(2906002)(16526019)(54906003)(5660300002)(26005)(6666004)(83380400001)(82740400003)(36860700001)(81166007)(36756003)(40480700001)(40460700003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:06:22.4254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040c7939-eda7-44de-f37e-08dbc05e6323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we get a GPU page fault, cache the fault for later
analysis.

Cc: samuel.pitoiset@gmail.com
Acked-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 18 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8ce91f69bbeb..91e36b0ad062 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2730,3 +2730,34 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 		   total_done_objs);
 }
 #endif
+
+/**
+ * amdgpu_vm_update_fault_cache - update cached fault into.
+ * @adev: amdgpu device pointer
+ * @pasid: PASID of the VM
+ * @addr: Address of the fault
+ * @status: GPUVM fault status register
+ * @vmhub: which vmhub got the fault
+ *
+ * Cache the fault info for later use by userspace in debugging.
+ */
+void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
+				  unsigned int pasid,
+				  uint64_t addr,
+				  uint32_t status,
+				  unsigned int vmhub)
+{
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	if (vm) {
+		vm->fault_info.addr = addr;
+		vm->fault_info.status = status;
+		vm->fault_info.vmhub = vmhub;
+	}
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 204ab13184ed..2bf328d9e04b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -252,6 +252,15 @@ struct amdgpu_vm_update_funcs {
 		      struct dma_fence **fence);
 };
 
+struct amdgpu_vm_fault_info {
+	/* fault address */
+	uint64_t	addr;
+	/* fault status register */
+	uint32_t	status;
+	/* which vmhub? gfxhub, mmhub, etc. */
+	unsigned int	vmhub;
+};
+
 struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
@@ -343,6 +352,9 @@ struct amdgpu_vm {
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
+
+	/* cached fault info */
+	struct amdgpu_vm_fault_info fault_info;
 };
 
 struct amdgpu_vm_manager {
@@ -554,4 +566,10 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 	mutex_unlock(&vm->eviction_lock);
 }
 
+void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
+				  unsigned int pasid,
+				  uint64_t addr,
+				  uint32_t status,
+				  unsigned int vmhub);
+
 #endif
-- 
2.41.0

