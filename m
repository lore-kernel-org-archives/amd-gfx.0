Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC934C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F9E10E6D0;
	Thu, 25 May 2023 16:52:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C247210E453
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbd72uFIA6+9iLNOj8xNOPeErTdAHPcLPPj5+1Gvm/YNWrxt65uaS3klT2nBuLqWBdUUYg4Od8LZaMVo1KUuYH8p3eKylcs8YTmkQA7o31eh5G28n4CDfhrf4H61ktCUsp9nrPHFWOyT1Dx0FaiR0ZzY6whm2jd/FCxEWK9YwohBAEfYXQAYp9tmQuh3rS9CUR4TL4VWeDv8r5oc8ziLAB3GbgxFpD6tckNJXbckkDXphMTAxuxiQdjg3qp67Ik6xkQbFydyM/kGngV02TW48B0STjj7QZq+okaCNAaZ5oVp1oHBrRC/MlP7QUlq587lNMWfyIx0gtEG3ES/BclYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuQ+FpOwDS2kXgcQKAImYM3YWcDfMk9eGg47YKch29s=;
 b=k+0++wEF9vQok2dk9K0LQtcZ4UPmECpBgIIL5VHiHuGY4QigB9DCE7x8+AhCWIoR7Jt3yibyY9rPu1a55JJUcJ2ydVIhNOHU8lPt8lC2mghskpFv7kAY9zaaEiRaasO/I89fBTVOqxL2ngT29bwuXo77YCiIFsALI83ty1MTMZfzlVRllCc1HMJ7W+WRL0iGWop6MwgNicLphcSo5UIqw79p2P3b9qkt0UsOs4LKV7UHYKpzT+/2tj+jMl6gXRl6ThtWg5oR8SYLcQXO3YqhNQ/xezavDrR0pzjkHqMljddj7jRTond+kiEWSnKNAqJYYF/LUstKfU0PZfUDvm5oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuQ+FpOwDS2kXgcQKAImYM3YWcDfMk9eGg47YKch29s=;
 b=uHbv2TPSbvYJW+sdw4zhMfeKgfbfMUbn5yxBIEuCqxa25G44BYcSQm1Lo7NkpCLz09X1AyZCanWoyw+Qh4PV6m7GmONs3bdXa46Ml2Gcq+dNfLq6cQFJ0iE1plbSmjFrRZxLnrwPQDSqDANCzjfnSAU3TTTWvcEZ2x1h0ilXxK8=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 16:52:41 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::5b) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 16:52:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 11:52:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add cached GPU fault structure to vm struct
Date: Thu, 25 May 2023 12:52:17 -0400
Message-ID: <20230525165219.544671-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525165219.544671-1-alexander.deucher@amd.com>
References: <20230525165219.544671-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|DM4PR12MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 893a4046-9744-4db8-c8bb-08db5d407436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqX43qwtEOKIctes3AR2l6AK2p+RiTDFNXrBWFFzVoT6A1XYNq48gkV42WmMb2eX4LnyQyb5bqkkhC6mLHj7dPUJ7N9o75zJH+Qp2/s74i8SPZa/P8h+tMhNX7HlLmpHbmsX8PxQJK4TV1oXt7j7BJUArzz1so29pNaV/PQ1MFQZThpnQxuOJOGUpQ2YUuytJeFCg45h11TycBFEj8gVcaWG0QouYayKS3aLxQrXBF/2RaQAF6iSg8mL/Q+fQLAMrEu1q/BmY+IidcoN5tTTkbRITGjzgLGp8HvLzYr6UwzfQj04AwDxq6oLP/S7fiqQ6ZsFuVStjGRNjhLYtN/+K5qpzdig6O/fLo/nqmIypz+j+BgOi0P+e1uGQ0qP1T1Bvt3KrqwGOrNAXQglF1pjD6Pmfs8N4JN672Az1b7B3En1jecYtvifdaxPusWtAYe8+Umkj1BCWYJAQQpfDWH0mfHYjJenZhCJEKmwnZy2bJ7THAh5yUFbUovboECrDgGOKTvcUGHhsMIdpxfQB2R7yKY3ZBtXKbShgmpbp+eXTDGtE+4I8pqbDWn+eYVc+BK2KU105C69NFcRKP4HuDesvF4d6jKyklwAmJfHphkqUJC7uTQOWY3+YFaMZqgOFUfslJXDGmjPskNCt7DPPKqiZSc6Og5pgdycQYQASMHg1/l9swgS47NHYA9K3ta9j2J/ZiVWh2PxOSPhOeSV0U76wCf3lnjs43I1dZiABoOsI2j55XnYjcFq9rFQTAKKZVWAVeuOlLuPqqen+uvDt+AO9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(2906002)(4326008)(7696005)(6666004)(41300700001)(82740400003)(478600001)(70206006)(54906003)(70586007)(40480700001)(2616005)(336012)(81166007)(356005)(47076005)(8676002)(40460700003)(316002)(8936002)(36756003)(86362001)(16526019)(6916009)(186003)(426003)(83380400001)(26005)(5660300002)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:52:41.1625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893a4046-9744-4db8-c8bb-08db5d407436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we get a GPU pge fault, cache the fault for later
analysis.

Cc: samuel.pitoiset@gmail.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 18 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 22f9a65ca0fc..73e022f3daa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2631,3 +2631,34 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 		   total_done_objs);
 }
 #endif
+
+/**
+ * amdgpu_vm_update_fault_cache - update cached fault into.
+ * @adev: amdgpu device pointer
+ * @pasid: PASID of the VM
+ * @addr: Address of the fault
+ * @status: fault status register
+ * @vmhub: which vmhub got the fault
+ *
+ * Cache the fault info for later use by userspace in debuggging.
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
index 14f9a2bf3acb..fb66a413110c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -244,6 +244,15 @@ struct amdgpu_vm_update_funcs {
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
@@ -332,6 +341,9 @@ struct amdgpu_vm {
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
+
+	/* cached fault info */
+	struct amdgpu_vm_fault_info fault_info;
 };
 
 struct amdgpu_vm_manager {
@@ -540,4 +552,10 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
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
2.40.1

