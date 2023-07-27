Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDFC0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F00010E5E0;
	Thu, 27 Jul 2023 18:11:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2997110E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUD3gBb9XsOC7LUYE4Sk68FZ2sIxjGf31fTL6fwNzXNGw1NzxCWxkdrJjGWE8G3VpjuaMcVg0YFkj+ZNitEESFcM+h683vze59Z9dMX1lI94lKsQoHMAHsyyKqfT6c9JkkrtM/ru9bhB/HI7cmorz994oJ3QfkzqPO2TomNT7k+ebeL7vh7AtRec/umwf5BgPJF2gH6e9CMxfO2zMUN4S08fODiZibP8KNbtV2NyVpr/yO7KkP1zCUja+vUy7EAwi9LSuK0oPamzixnRILGK82IPS0UWXcgvjAu8tyuvhiUsqeL88mQI2OU3NwOIC8Jn5p6TOOAiePeDXgZJ4fdolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEYuJMVhmm+PafGgTW7SPOExfScLyM2GHOKZP/qJPs8=;
 b=cwnCy9XgCelu6lkzEUe/Xpckl761ff84dZxLLIKmwNyKsT/KYguBtCylyclQWd0GtsNl7VmvUurDYwBrhJemVfMo4Gl3o29OXhw/pe2Myk0zNuhqadSXZmtUiU3aH4ObxN8C6M0J5pGe6FBloQ0zWdgXosqr6W7dn6FvR5XWPeZUOe59+e1d04hKqOurLCHBDQDveGha/yRxvI+Oh2lclaB8HrSfK0fPs0niMC8ZbXSakq22/RCJrh6xRcSRdrH2TRuvgVCdh8/ZH+NSS9li0oV4In+gd9u0y+VXTS9s6bEaIAIUglTN1Mw0jIVunDwFWLbEaF0a+9ySng4t26E/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEYuJMVhmm+PafGgTW7SPOExfScLyM2GHOKZP/qJPs8=;
 b=fK9wstILN2vB4E/thLgW+5iSWjol1Mj61/SJyYdHCZ+fERrOov91av9HP6b/ixyl5BW2B+rM/71PIlT/pdmZp0YWAybSYRF4z1jgaBYSXZqJJaYw+g51Ss4+WdsolY/CWe3uSrcbkVwgnZQTC9YOhQ/aQM7uIAciG74LCyanZIc=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:11:20 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::b7) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:11:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:11:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add cached GPU fault structure to vm struct
Date: Thu, 27 Jul 2023 14:10:45 -0400
Message-ID: <20230727181048.1222388-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727181048.1222388-1-alexander.deucher@amd.com>
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bccca11-45fb-43ce-ad6f-08db8ecce0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6sZ7E9BP0muPU++YaS4EaCQggwUEzHY4Rsuk0L8DXUGceLrtyfD2uBjj0w6/vfZHKJnIK6SwozMKJTl/rxLexiAEp8Be2hV3uhJ+7m7aJ/CjK41T+iCUpgw0f6MT/V8jPwoTNGJnIVgqOXJBgRtAeOYfH9tm7aPKm4g2N5P7BKezaTxHk/pKbXf4XYDjsmFeYgzxzlfHSEsRyhnhoq2YfoIYtvSABCktb8KGbXZgCeDu4kc9rKUqev1UjoaibI1gm4S2k5oVN/L4wW5uTSUGpKe07ko07ifrwoeFo7bH3/cBU8/cEozMmdNng5iSXWLC98Mk8/jD2joslPrpsilQzgh4nvfZDkq4hzWwbLbXsqWdWH+g0N4yuPBgkUqyZif6jcztgbxX5y3OrlmLsmdi57+SD5UPUl8Zi37AZl8uocWTIgJJKSono1mNQetgs9fVj0WHxZoxTJH1JeWVI6DlhaHmuVeD/z5l6sDw7yU51TOrSWfGen/gYRf0vdVWW3DIKUjRMS/kAnZA+P8tiBprVDKeEhYJ1Q6M3AKq1kxOCzKaURBHhow6QCJxTHf1dpV1dJRXWb0pd06enoDSGsoitYvgjHmd/2Vij87H5K6eZGZHq6Y+dTDF+6b5iOIX/G/koYGbXE976fFGnjUxPUzvv0V1c6UDtYz85j6GbMSai3yT7DirTsu1TG6Kb8rcQziI97Qguxwd8b0KOgkuQ44hZq4Lo5zi/3N7QQXcfFE+W3QBffYC2mHcE8dBoObMfuYgxaX8Si8DqbxFEu2dPGhqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(86362001)(2616005)(8676002)(5660300002)(54906003)(426003)(8936002)(16526019)(40480700001)(478600001)(6666004)(7696005)(6916009)(316002)(40460700003)(4326008)(47076005)(70206006)(70586007)(336012)(1076003)(186003)(2906002)(41300700001)(26005)(81166007)(36756003)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:11:20.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bccca11-45fb-43ce-ad6f-08db8ecce0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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
index 74380b21e7a55..36908dfcba6e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2734,3 +2734,34 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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
index bca258c389191..bab185c5eb128 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -250,6 +250,15 @@ struct amdgpu_vm_update_funcs {
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
@@ -341,6 +350,9 @@ struct amdgpu_vm {
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
+
+	/* cached fault info */
+	struct amdgpu_vm_fault_info fault_info;
 };
 
 struct amdgpu_vm_manager {
@@ -553,4 +565,10 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
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

