Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7EEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 17:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FED10E077;
	Mon, 19 Jun 2023 17:38:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF0B10E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 17:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjeHNo4/bQhGs6W9VZ5cmfgKThKAvqL78VX63Jui4/ZRrHcsY4IC3nixF9i/C+B0DITZQ9Vvad1jaODxB+pS/iFZnfNQPZN0++tTXkKVbsStiQoB5xKUjm285tZD2BaBZ53fWcZjoRZeNk66qqvfnx7zmerv6i65yaZw8y5bNuGX6sdaFbJxSe6Qxyfo8jW+eLwD373n5vwOOmY8mIwLzoq5TkNNd3TXYJ33A+nB3pGI98pnkJtydHRSW9YzNJIlpcl6lRBANp9HhKAyez1C99dlvUJ5J/7Q39FcBps0KV11Q6b/PJi+FKpkMXeiqUewrZc6j122vUgtF7lH9NO5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk19l0bpHe6unuss/+aaAX3s47vg+KiraYhq+5DQjZg=;
 b=H4MiRXkt2crWEeYzZo1asAWK88ySIkdztYafpEUsHZoigB+8hCC4QGrDB0buDZEeRGvTSu2IwqBnHvsKvdKFxB7qocWrRvi4TspnrwtshdyD2JJghjIoFS7eRWBirVDJ4t8ehkzsQICo8ejQl7V/J/pZwiR/uAOIWfBVkURVuSlzZ/8D1G8ay+Tt0RP5yI9Gs4UBKH2TXXHr8MIIkvoMOnDukj0ZDKWypnC5jFIl/2wqMgX36HOBtGD/QKQs9A19umzicrs/ymMlA7GqtKI5afPtM3MtfkQW/fOkahcBp60od+2Y6IS2CAJih1N+iEeYRzRk4myMY+d4/h8AD1KXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk19l0bpHe6unuss/+aaAX3s47vg+KiraYhq+5DQjZg=;
 b=kR0Jq2BX3jV4Gy1jegfuKhWETpiqHP53fiuFcQasz6EPvJ85nRQEwPUC2SUDEVbZ6XDSLGGgrnv5w6rcmLRy1IpqPLEIYHA5kzglIPs4kSKU7/p6upuNi3tzPP0fOqRlKd8c9xGTjVHh5gt/L7QbBrMs+MrO4J9b4epQ7huLyJA=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 17:38:52 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::b1) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Mon, 19 Jun 2023 17:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Mon, 19 Jun 2023 17:38:51 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 12:38:50 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv4] drm/amdgpu: Update invalid PTE flag setting
Date: Mon, 19 Jun 2023 13:38:25 -0400
Message-ID: <20230619173825.1461932-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 587be110-c719-4a93-2910-08db70ec0c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SFw1MzF+tjwhIz49rB2aQcsO/M/kOB9cDoSuHYkGfsApuNuzN/8DEC9cAQWzuaTuKhSEV9G688tQrSxfLlKq073AHIA2PAVXSyMZmKbWLOIjNj8C7kmr1L2rup77SkhsgLUTz2nrAvwzIgnhyl+4VrFsZIXbGT/6vNTrt3k+2FQh75khH6QvX75D8gxt3sUoBoQpR3MLoKklfTonxRsTNW2iiMTSKoLA7cZzUyG0uiwXGRS2S6i2mObZsDAKxxQ93xs7ClNb7aHb93d7o7ZoxAv5gLS8ki87Bmcu5+hHe0ZLKsCWPCT+MzUx+VwGdhphNL9tW8PxI8+5pa6OQS1aVijLgVIbH7warUgr5n/J+16IqnliP+KY8nKYC2BB/kgRXG/ZPMMQU6AHiWdbHTCfWOKLb/sJTa9hB1GogSyQQUGPHCl/s8cw/eqCsrCfKcv1qXZE9KVbN8xC5Ebtwi4oboO4d2ZqqVmSHPV1aeiLNVeCtSONJam6VZrxuGBamfzeN5Oc8lbR88Vqr2mpZOGLvT/5zA9ASkARW6zSlYTQUSqAytKpmbhcBoP/H3ygG/VvYsfN40A5NPP3wNIfLerA46bNbh3GacZ6ApyZpk1tDyFsFmvmAYEF6hpopDRZrj+QopLqWB3Uqe1LijN2juWMokJTwXEvH63+oee3OfisBCka92o4/FBafAXA5DH/Dh+ouW9olAN+KBro7mZwQw9rZHtAmhQkOO1V/us6ru9aavc1jYL/kwQjy9DyEFyKmOAQSFyYyqiqHrNqvYbJdoaZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(7696005)(478600001)(54906003)(1076003)(40460700003)(26005)(16526019)(186003)(40480700001)(6666004)(36756003)(2906002)(15650500001)(8676002)(41300700001)(8936002)(70206006)(70586007)(6916009)(316002)(5660300002)(44832011)(82310400005)(86362001)(83380400001)(47076005)(426003)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:38:51.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587be110-c719-4a93-2910-08db70ec0c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the invalid PTE flag setting with TF enabled.
This is to ensure, in addition to transitioning the
retry fault to a no-retry fault, it also causes the
wavefront to enter the trap handler. With the current
setting, the fault only transitions to a no-retry fault.
Additionally, have 2 sets of invalid PTE settings, one for
TF enabled, the other for TF disabled. The setting with
TF disabled, doesn't work with TF enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update handling according to Christian's feedback.

v2->v3:
- Remove ASIC specific callback (Felix).

v3->v4:
- Add noretry flag to amdgpu->gmc. This allows to set
  ASIC specific flags.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 31 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  1 +
 9 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 56d73fade568..fdc25cd559b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -331,6 +331,8 @@ struct amdgpu_gmc {
 	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[16];
 	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[16];
 	u64 MC_VM_MX_L1_TLB_CNTL;
+
+	u64 noretry_flags;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index eff73c428b12..8c7861a4d75d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2604,7 +2604,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
+		flags = AMDGPU_VM_NORETRY_FLAGS;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9c85d494f2a2..b81fcb962d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
 /* PDE Block Fragment Size for VEGA10 */
 #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
 
+/* Flag combination to set no-retry with TF disabled */
+#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
+				AMDGPU_PTE_TF)
 
+/* Flag combination to set no-retry with TF enabled */
+#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
+				   AMDGPU_PTE_PRT)
 /* For GFX9 */
 #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
 #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea1a64be44d..24ddf6a0512a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -778,6 +778,27 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 					1, 0, flags);
 }
 
+/**
+ * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
+ *
+ * @adev - amdgpu_device pointer
+ * @flags: pointer to PTE flags
+ *
+ * Update PTE no-retry flags when TF is enabled.
+ */
+static void amdgpu_vm_pte_update_noretry_flags(struct amdgpu_device *adev,
+						uint64_t *flags)
+{
+	/*
+	 * Update no-retry flags with the corresponding TF
+	 * no-retry combination.
+	 */
+	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
+		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
+		*flags |= adev->gmc.noretry_flags;
+	}
+}
+
 /*
  * amdgpu_vm_pte_update_flags - figure out flags for PTE updates
  *
@@ -804,6 +825,16 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}
 
+	/*
+	 * Update no-retry flags to use the no-retry flag combination
+	 * with TF enabled. The AMDGPU_VM_NORETRY_FLAGS flag combination
+	 * does not work when TF is enabled. So, replace them with
+	 * AMDGPU_VM_NORETRY_FLAGS_TF flag combination which works for
+	 * all cases.
+	 */
+	if (level == AMDGPU_VM_PTB)
+		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
+
 	/* APUs mapping system memory may need different MTYPEs on different
 	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
 	 * to be on the same NUMA node.
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0c8a47989576..13b89f78d07d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -751,6 +751,7 @@ static int gmc_v10_0_early_init(void *handle)
 	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c571f0d95994..c68ecb7dfa39 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -651,6 +651,7 @@ static int gmc_v11_0_early_init(void *handle)
 	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index acd2b407860f..027b14603037 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -942,6 +942,7 @@ static int gmc_v7_0_early_init(void *handle)
 		adev->gmc.shared_aperture_end + 1;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 85dead2a5702..581ed922dbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1056,6 +1056,7 @@ static int gmc_v8_0_early_init(void *handle)
 		adev->gmc.shared_aperture_end + 1;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67e669e0141c..ebdbc823fae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1622,6 +1622,7 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
-- 
2.35.1

