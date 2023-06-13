Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2EEEB64D0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC5A10E3AF;
	Tue, 13 Jun 2023 15:07:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C652010E26F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN1v7NdRFRphE2O/1iaU+cOmsVGkHyDbqboHuua/SPzqZCn8rudbiSHVkEtCLKjjILJCn/R+kQ8VfZgK/sazmGLLgkovlt3GjMDb94ivRx0Vf32q3ywsHHu/mWElbiRn6/reR1+S30XLZWJDSm8bdrqmj61kfAKXc7YvOVmQwVQg0Qe7H5tPA0gpoV1PZxijGV3HL83NpXedy6nAb3FKTz3LOQkcP5QrSmV+M4wA3nLSseePiXE73/aGkf64WhypKX2m2ljkWJDbQkUeArztq442dFLgFQiw2sddlUl+viF+pjeJ3nZdZCbR3kt5xK47E+VxXkMxzYNFf8y5D6tBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2PGVPyGdMUHAqahIZ7C7rQnSeOMJS6G8jWpZo4oPiY=;
 b=VFpn1y+woe05lmsO0y8TTAZFLShFGX8BEWW5gnmFYlPdiM4QTXyDw71jexvD1nQV3BrAYwMfyMXT5Rfb1R/Av3PANRP2Q+AUXCHzdc9gLGhmUoBB319KVLx7Kk6zmAGsAQlH2BrHWJQdfFz78fiD6nSTQs5xqaTZu9qAIir19dTYXnGlKcMpyuA63j/MY8aNjJTWQGeINGxYJwHqMuLze/uepQVd68QAGXKnNwBYRxoWToZPVybnWO29dury5sVp3dkdc3jBdheF6ax0kJs0cO+eJrdTjuE/9+OAsPjiCNJ7xqSfcbN0Ex0ea/seaJ/RC1OKr/1jAuGsdN+K977EkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2PGVPyGdMUHAqahIZ7C7rQnSeOMJS6G8jWpZo4oPiY=;
 b=3nWEhNcC8bOHpbbWM8Lo1+kE0xA9XGEElHvZ8+eoOG64voVucK5NgHL7Lk5WsGFyCavFhVGXkedut08+x+KsCYq+aouYe+652SkIxMiUGHPZphbSgPfrBcYgDgw6J7O8iyCvbml3a/8sIP4OxJo7Cm7B48oSg7WZOkcZ3Nm2VBA=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 15:07:46 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::ed) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:07:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:07:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add cached GPU fault structure to vm struct
Date: Tue, 13 Jun 2023 11:07:10 -0400
Message-ID: <20230613150712.1703987-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613150712.1703987-1-alexander.deucher@amd.com>
References: <20230613150712.1703987-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf6f52d-e7d5-4ee3-d549-08db6c1ff258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXpjbKcGpdPe/MPiH4JcwnkxIuRauU0z6wfhta72o1Fj98Ko/tEnnyVrjiYzFP6TowfLr0zYYysGvEkRC36T4EIYfoWMVaKQeF/wifnplzfETre4HLh3GTl3gIZLNmaQ+UpJuQfOxtKluVZtS7P57NlFOueIzQK7RrbM+0itiIlc7KewumHVMWdjvQzSGFVI7UGgu2YT/DJlKEnJ/F8S5ofUwp1Rlj4N5psLhel/pQL7ViTR9zGsnPznZu9UqRARHmA6UMo48WzMQC4KreWCrEMLzerU74onj/4ni5l1P2g4UcQw0JgRiYvA1SdB3HSHZ3eKmpYnNwHMDv+PdSTkcld308W/7S01GvUkEttX6Lpo+YFsl+eYAm1fxxkow+B+0xttnWSF/NdSQeLP3SuDr+N9or5nv6IlgaIa1FsGDqXaKJ61wiuL+0IwLZ9TfIK5FaZV+jj/b6vdTJXY6/YRt+4F3iZAIZbRLzV+xkakohs7CplYhmgrdpbu1PgrP0vi1V/B7cTVFJeJliGnJh7d5CSXyQySvTDjVQGrSBWcB9edJEJ+kl4nfQc2seMsA1DzDoIlot5bRFtEvkINh1LUGfqtqbJdV4rglRX1mXLrPTjX4SK06LxNuZs4OaN1+TP+QTwvo2mryGiYlwJIoEP01SRI4FyVOfFD9AP0nMqms5er7k0p0AlSk4ym9UDmQkjAI7e+MwONZCLVJ/uTp6sBgj/E2rhMlziFUIkAINpob8O4wxx2/EudZjFja7YfFISjtm029bsSYGSM5dEhjXuo6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(4326008)(54906003)(6916009)(478600001)(316002)(70206006)(6666004)(70586007)(7696005)(40480700001)(5660300002)(2906002)(8936002)(8676002)(82310400005)(2616005)(356005)(41300700001)(81166007)(82740400003)(336012)(426003)(1076003)(186003)(83380400001)(26005)(16526019)(36860700001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:07:46.8282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf6f52d-e7d5-4ee3-d549-08db6c1ff258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
index dc80c9c8fd14..5423f66a9ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2640,3 +2640,34 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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

