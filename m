Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A001AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA6364DEE
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6364DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024D58912A;
	Mon,  1 Mar 2021 11:12:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327A18912A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 11:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl2FpBhfJ62X/x8iW9j+bNdkXYATq5KnotFyFFwWpYA+pBu99Zmw9pj0lrj3Ld0uPo9Liqu+X6Y9e84xvCXkaL++fTBjSFU4jrxuNLagNqNf+dWyv8BLzjB62i0x8UL6FkWMnOejgwwuv3UNDh7Kio1pFPPG95RUe/vDYi4HMWmJvz3L2uCVDJXWxv6b+otFTplyTBHXhv5oOtDL7AJpmpROsq6OsUILbS8zaI3Z0JBmFE0tBVlDQnV4i+ghLOm9vb7NMdBz1cAc05ZAhwgarYS2z0kpDvPv7yY68U88XGTiyikEczVkjFvIyTttFbCBcx6TeYGDdjGCgrSH7ZBl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM+tubIRN4E2qVjbOgwD1gRCFRfJKKCZ7hvZwm1EkJo=;
 b=mXmZ8vhLF+2+eQ+tsKAcb6SfWmRJmKUHbRtNXP9pSILMabz3kPAobc1+6oVSmd6vF//xHJGrTTf4KepvFSeOfd1rOoC6h8HrOmDzgd4LzbU+S2vcXMRg8svtYLzuQ9pbLXPmHFuS02m0FrR8CpejnpnDU/T474CJ9QjXxqcaP2hfOQijwoNjz7zo9ksofOPzGivTZBvLEZYko334nR6hTx+g3pM7AK9f3E6O6Cu/yC4StDSYpOoOoAhdQyffr78XdauaUp/OncdCWLdyDAl/F9yhvfuhpBy0wLe1ijj8bBNgsP+ESBtihPHJIALkdEsJNddhrfAdsJ7OxFIOfHkGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM+tubIRN4E2qVjbOgwD1gRCFRfJKKCZ7hvZwm1EkJo=;
 b=B7C+sdl3eQo5A66JrVPhU2lm3UoHttlH8ynLd7Rtm4yOPaZOyHoYH3eKYfAB1blbWvvUVshETVfWfCyugUEB2Efnnopi/T5MUn5kTI/8ErnL0V6M6wl2l7PZegGo1Aqb3GCGkt9Jl9Fe7iA040w3E9GDT6UEYGyfglM+QJYUVkE=
Received: from MWHPR14CA0020.namprd14.prod.outlook.com (2603:10b6:300:ae::30)
 by BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 11:12:43 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::a3) by MWHPR14CA0020.outlook.office365.com
 (2603:10b6:300:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend
 Transport; Mon, 1 Mar 2021 11:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 11:12:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 05:12:40 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 05:12:39 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 1 Mar 2021 05:12:38 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: block hardware accessed by other threads when
 doing gpu recovery
Date: Mon, 1 Mar 2021 19:12:25 +0800
Message-ID: <20210301111225.11330-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c86899-e639-4100-4fa2-08d8dca2ee7e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27119CC49BEF62698B60F133ED9A9@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wehukZSuLDXxQ5Xvky5EBVC+CUePgF+Ci9rmqFWLU+2OAOQAt1Hzwptxrj3Q6AdUGZMUXeWvksvBXRC7ZyTiQkqFnlaGNZO5Tmhjx5CxkD08XR1iyRGUDfBcSbaFe0dB9UQEff8ZGwndXRLP0eTOLgMTAPjrLmYjJPQLMr1S7qrAlPr+jOKS9V4f6m5J1A5JVTBXTV6RgevFDvN6GKLn928i/93GWV/hnxIaD08UzpqkI2KEC5ddKQku1BzBk2Cg96N5qmCIAfKdXE88wXnLkAmtUqjpc5uyUXDTDIOON0vBBseknFYsucU91Kr8MMipct4hUs/nzvIkPU3LyBaMn6Mu5i8sFATNkICjcjVpRMIDHTQNUhNn2mdXW8FHHQ2xT4AbFFgq9tcrz2H7+WAVa9IdR9xbZvMrN/kqVpaRK5Xb79e8Y+6vrWph1jIhpHoZnGOJgflzPbZyMWubd1neaNH0sXbwBD5LKKuMJD75JwkhK6navhPVqm38742y61yWwoEDdOtDeVs9pA4OT4PFuaRRPxL+Ezviy8B9WKIj1JhcAHTd9PqVYBp34G7oHDbaWWkbGvw8kVLHY7eBi1uah7pK8QMeX0Qq0MDLGY7QOwKBPytmPDNS4aBT/GsxiYos/soOZmpTl3BCAhJdkrDsf29gJ0qWT2kU8m/SYURNp0qbF4lyRBq3ScQnjfUG9KQRjohLkaZ3J2zoi8taWhht1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(36756003)(86362001)(316002)(47076005)(82310400003)(356005)(2616005)(426003)(81166007)(6666004)(336012)(478600001)(83380400001)(82740400003)(8936002)(8676002)(6636002)(2906002)(5660300002)(1076003)(70586007)(7696005)(26005)(36860700001)(70206006)(4326008)(110136005)(186003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 11:12:41.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c86899-e639-4100-4fa2-08d8dca2ee7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When GPU recovery thread is doing GPU reset, it is unsafe that other
threads access hardware concurrently, which could cause GPU reset
randomly hang.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1624c2bc8285..c71d3bba5f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1033,6 +1033,7 @@ struct amdgpu_device {
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore reset_sem;
+	struct thread_info *recovery_thread;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
@@ -1385,4 +1386,13 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
 {
 	return atomic_read(&adev->in_gpu_reset);
 }
+
+static inline bool amdgpu_in_recovery_thread(struct amdgpu_device *adev)
+{
+	if (unlikely(adev->recovery_thread != NULL) &&
+		adev->recovery_thread == current_thread_info())
+		return true;
+
+	return false;
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71805dfd9e25..7c17a5468d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -401,13 +401,22 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 {
+	bool locked;
+
 	if (adev->in_pci_err_recovery)
 		return;
 
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
 		BUG();
+
+	if (locked)
+		up_read(&adev->reset_sem);
 }
 
 /**
@@ -424,15 +433,19 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
 			uint32_t acc_flags)
 {
+	bool locked;
+
 	if (adev->in_pci_err_recovery)
 		return;
 
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
+
 	if ((reg * 4) < adev->rmmio_size) {
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_sem)) {
+		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_kiq_wreg(adev, reg, v);
-			up_read(&adev->reset_sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
@@ -440,6 +453,9 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		adev->pcie_wreg(adev, reg * 4, v);
 	}
 
+	if (locked)
+		up_read(&adev->reset_sem);
+
 	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
 }
 
@@ -451,9 +467,15 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v)
 {
+	bool locked;
+
 	if (adev->in_pci_err_recovery)
 		return;
 
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
@@ -462,6 +484,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
+
+	if (locked)
+		up_read(&adev->reset_sem);
 }
 
 /**
@@ -496,15 +521,24 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+	bool locked;
+
 	if (adev->in_pci_err_recovery)
 		return;
 
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
 		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
 		iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
 	}
+
+	if (locked)
+		up_read(&adev->reset_sem);
 }
 
 /**
@@ -679,6 +713,11 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 	unsigned long flags;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
+	bool locked;
+
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
@@ -689,6 +728,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 	writel(reg_data, pcie_data_offset);
 	readl(pcie_data_offset);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	if (locked)
+		up_read(&adev->reset_sem);
 }
 
 /**
@@ -708,6 +750,11 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 	unsigned long flags;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
+	bool locked;
+
+	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+	if (locked)
+		down_read(&adev->reset_sem);
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
@@ -724,6 +771,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 	writel((u32)(reg_data >> 32), pcie_data_offset);
 	readl(pcie_data_offset);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	if (locked)
+		up_read(&adev->reset_sem);
 }
 
 /**
@@ -4459,6 +4509,8 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
 		break;
 	}
 
+	adev->recovery_thread = current_thread_info();
+
 	return true;
 }
 
@@ -4467,6 +4519,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 	amdgpu_vf_error_trans_all(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 	atomic_set(&adev->in_gpu_reset, 0);
+	adev->recovery_thread = NULL;
 	up_write(&adev->reset_sem);
 }
 
@@ -4609,7 +4662,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	dev_info(adev->dev, "GPU %s begin!\n",
 		need_emergency_restart ? "jobs stop":"reset");
-
 	/*
 	 * Here we trylock to avoid chain of resets executing from
 	 * either trigger by jobs on different adevs in XGMI hive or jobs on
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
