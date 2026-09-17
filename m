Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBAC982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A65C10E6ED;
	Thu, 17 Sep 2026 11:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xyOT5EH1";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB5D10E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWtLNbgBWZuaeXHcfcW6NsSw73o5QPTX08FmXRRYQDu8HfCjvesZIxfncvF4KlS7EDSxozvxmYYm+k3/54G781CFYKUppyPEjesZe26KaWJHgkmdLyoe4bDvcTRu41msUJmirnXmT+JDVshUIFJtg0fjtvc0yfFYYk4HjvLaUbqRZmQP4ADelMyJxCeSE55GvSmRGu1ej535mZpBp56uylO/RqpirQAIFVkc2/077v9L0Qmh66CS8JKEG+QywmE92XEQ2/5iemNlQJlmlsDZU5GukTMNedn3WfF/YbFxFVmAUVsUhqdGIeJjW2p/5Na4dxDtiRoNTJi6kv6dxEVuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHIDc+jnlPyPnqrHKtmWoNHmMu2PWWdJOJ4djPskYm8=;
 b=StzIyUbwIHFdoHZT4bgi10/GJIpkGAB2gB0ltG5w5SuMrHKp7XxjL5aDYEtqQodkWMFmvTuaERHLwspXt2QO8CzgTL6XCP3TW+zK1G3WoGRRtIEi5Ycv1STlDPURSlGJ/ZOplQYTbsaolc++HDWMRoM7AQp/k7D6h1omV2AIkU/YR22Lo0s7IZkEU3tPVajC0GzoZTh1kVCfVO6Oxx4CriJRQw2VvVTbgwLNrIQVkgwRi+rUk1rIk8xedBTPjwI7Rn81PDU1BU+Ptxi/jC3XId9Tpocuodr5YN/PGHSpEBdI1nicO/IVJAsKPtDySraXolQv40fikpo62NrYp5/dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHIDc+jnlPyPnqrHKtmWoNHmMu2PWWdJOJ4djPskYm8=;
 b=xyOT5EH1byyZMI42FwPu2aN/kph3qJr2FGA+VVvCcIZ1BP6KN7dLOyt81bCAjDV182cUVvuSk55z8udz6aLxc2iWFJ4I80gaeHDQiGp38ionASrLcPEboY0FDGj1qqcLDOv9v17lY7CfUXbCAxrgd1UYI92xhrHHEGAHOKd5knA=
Received: from SJ0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:a03:39c::33)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:02:49 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ac) by SJ0PR03CA0358.outlook.office365.com
 (2603:10b6:a03:39c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:49 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:46 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amdgpu: allocate and fill dummy PDs/PTs
Date: Thu, 17 Sep 2026 19:01:48 +0800
Message-ID: <20260917110158.296198-4-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: a8223b00-5cc1-4242-2881-08df14ab367a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: RatoSra62h3QKUTpKzWpQX+fgQFZ+0CSGzqaAgp8z4Umxrwnb4WTxWinYO4M2ed6tW21IvXkGOjaQ5F01cRt/djx/u+6OkPG+363x3q5MSNkF1ijg4GWfmtH3XPFwO6dfRzvji0W0hTMp1Z3+xYw4+c7Gy32lPkANyM5pUbabSnxKyNrJ+NGa1gTRQDc9l5OYdzhwa53BoGAqIgZaZ0rzW4OkFeOXrJ7Zx3UZZkLrBuURLwIEa3LFydhEP6s4HKiDarRvx76KkaPOD87hS6E9juQPB+WFR6JYrFY/ueNEbpJc4MYbCAgVn3MSa04JofxiSIBaZ+PCspC5QHZY2vkwevJEujBQhgN+wHe+DJFTnUydOHDh+jNMzZldqkr8VPU4m3qOkMrHLRi2wjrFfP9Sc0sLMmBhw7hQAZGn9JRmSAxA5mgVjB3XkDwSY506Gyy1+HJ102dP+/wKuOxFglQxP3QHvH7gv+RyC5NTMwmzcABrcuxIk3LZ5eNADRQEgn0CbSH2nemxM/xWiXk5tzxymo+aVmY5oLeYdQ+yaOpb9bamLewPU07058Fq6I8ngOsFwMuYHBHmbvZaZq8l00EubvFLqqRbibjtkr7ePL8oHI4AJErVH44f3XJm+C4hDlSkhtwY8xB7sq/B8T/3SF/npIMx1KEoMNP/KF+DN4rVfbgVNpfi6jAvbfn8D5PmdTsAz2z5asvrVzo/H3FuHamqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d0Rc5ctkM+EbW7tdZlEKX5zS3ERFPv2VUa0Qi7edhErQLqQ0SQmMyUMpiA5p9uA9zJHRvB90qiIDDMaQ1GEtcC03+PHU3BDwymNLpeltCCJY/8Sz79/WuCfryGaXGR94R6DMYuhVUtpZb+meGVertobjLUc9ZhlsUNAr3kwN4dTIEwBX30NfSoPA8p1QGapa+Cb0YP25/+n5ECOHIsghBb9Az8JGRjfjKRrOWT8quYsgYSukLdSI6zNKHiL1IWrOoMOToRmGMZlyLleh4ca2OcWmKP+05d96nU/NmpBfBq7QpuC1tUm8/8yFzT+NoAShtcGCwqYkr2K2AxcQaI+j4pO2Ji8Y/5rB9r0ELfGPSdulpPfYhVB8T3InXF7s0tYECeD41n5R5QqmFQtSWuh8q6Y68hJjIJqcvND0RuTIIEmLOtZsr0Toks6MJbRR5U/l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:49.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8223b00-5cc1-4242-2881-08df14ab367a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Allocate some PDs/PTs which just point to the dummy page.

Those can be used in page faults to redirect recoverable page faults
to the dummy page.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 57 +++++++++++++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 517490946a9c..5675925ca656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2843,8 +2843,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  *
  * Initialize the VM manager structures
  */
-void amdgpu_vm_manager_init(struct amdgpu_device *adev)
+int amdgpu_vm_manager_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* Concurrent flushes are only possible starting with Vega10 and
 	 * are broken on Navi10 and Navi14.
 	 */
@@ -2856,6 +2858,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->vm_manager.prt_lock);
 	atomic_set(&adev->vm_manager.num_prt_users, 0);
 
+	r = amdgpu_vm_pt_alloc_dummies(adev);
+	if (r)
+		return r;
+
 	/* If not overridden by the user, by default, only in large BAR systems
 	 * Compute VM tables will be updated by CPU
 	 */
@@ -2875,6 +2881,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
+
+	return 0;
 }
 
 /**
@@ -2886,6 +2894,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
+	amdgpu_vm_pt_free_dummies(adev);
 	amdgpu_vmid_mgr_fini(adev);
 	amdgpu_pasid_mgr_cleanup();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ac3b8e8525c1..826406522b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -409,6 +409,9 @@ struct amdgpu_vm_manager {
 
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
+
+	struct amdgpu_bo		*dummy_pd[AMDGPU_VM_PTB + 1];
+	uint64_t			dummy_dst[AMDGPU_VM_PTB + 1];
 };
 
 struct amdgpu_bo_va_mapping;
@@ -420,7 +423,7 @@ struct amdgpu_bo_va_mapping;
 extern const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs;
 extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 
-void amdgpu_vm_manager_init(struct amdgpu_device *adev);
+int amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 447195cc4593..16cc0d5f5894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -125,6 +125,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
 int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev);
+void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index b85b70a1a428..3a6449d60988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -963,3 +963,60 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	return 0;
 }
+
+/* amdgpu_vm_pt_alloc_dummies - allocate dummy PDs/PTs
+ *
+ * @adev: the amdgpu device pointer
+ *
+ * Allocate some dummy PDs/PTs which can be used to redirect page faults to the
+ * dummy page.
+ */
+int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev)
+{
+	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
+	int r;
+
+	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--) {
+		size_t size =  amdgpu_vm_pt_size(adev, level);
+		uint64_t addr, flags;
+		void *ptr;
+
+		r = amdgpu_bo_create_kernel(adev, size, 0,
+					    AMDGPU_GEM_DOMAIN_VRAM,
+					    &vm_mgr->dummy_pd[level],
+					    &vm_mgr->dummy_dst[level],
+					    &ptr);
+		if (r)
+			return r;
+
+		if (level == AMDGPU_VM_PTB) {
+			addr = adev->dummy_page_addr;
+			/*
+			 * TODO: We want to have separate dummies for reads and
+			 * writes.
+			 */
+			flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+				AMDGPU_PTE_SYSTEM | AMDGPU_PTE_EXECUTABLE |
+				AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE;
+		} else {
+			amdgpu_gmc_get_pde_for_bo(vm_mgr->dummy_pd[level + 1],
+						  level, &addr, &flags);
+		}
+
+		for (int i = 0; i < amdgpu_vm_pt_num_entries(adev, level); i++)
+			amdgpu_gmc_set_pte_pde(adev, ptr, i, addr, flags);
+	}
+
+	return 0;
+}
+
+void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev)
+{
+	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
+	void *ptr;
+
+	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--)
+		amdgpu_bo_free_kernel(&vm_mgr->dummy_pd[level],
+				      &vm_mgr->dummy_dst[level],
+				      &ptr);
+}
-- 
2.53.0

