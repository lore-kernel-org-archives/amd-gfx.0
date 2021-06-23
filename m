Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C472C48BC2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9AF6101D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9AF6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F366E925;
	Wed, 23 Jun 2021 15:02:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4816E925
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 15:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAgBmHeirGPesrdX8s9Fu28Et8B7LCVyrmC6M//xkExHTp0XIv+F9LLRUewl2zZ1Exp5cXN+G2vYiIR5WgiVu5f+Xu3WLBj46tQCMcJugfV37XGjlZDctRG5M62bs0Qbw5GeW0/XvYqP3WTkkJvMh0Rc4V89fAxrKzRpNNXzhr8i0X4QdKqhUff+OAVUvke5CTtVOvrxdxmUxyiEauZL0EpInePlYmfsmfmvoPZxzHw1msUGGGLGYmWZjSJnqRQamzpAEclU6xCLHBJ9NTkxPu6sgvOkieY4tRdaQ23aiOXEGqNIb2kPa2hJuzMO7eNqq+Wy9IqBcieNVXJsrfxvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3ffcohINWm5u0/JZukq3oJiHt/oGONZL6jUZOBjusE=;
 b=NqWEoOh8Vr/g/6KxL14SRI6ImkTjqU4FRHKnVy/5x1MY1h0KycIvxKjQMTQcD/1HgJht0C/jTN2Gv1WLOPdiDryEmO0tNE1rvPJlgTZ7515chvSKK1OuaxQZRi/0dR0jr40E/QKYJ/Scw4DRXyN+bicnsWaf2+NgryLX6S8FjEb0ZG4M0nOR6z8995ExN2Ibo5VBoncTWSvFNl6YbPofq+Ov+giHd40cRCdOO8ZoAWAtc9isTlmKtgegDFAGgNZuM9fd0/ZU5tMrLj9AZXjktBQ/AIS1jtVdeXDVXq62VHRctqxubD1EmZtLWsNWXi31NrjCI1xLMVNA7tl/bV3VEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3ffcohINWm5u0/JZukq3oJiHt/oGONZL6jUZOBjusE=;
 b=D6q1EF+iODDAVkTXKpHto6kUCrMSWUIUHbFSglcLfXryR9Gz/lu61RJjXxPrMVHeH8A92ciJXSUxhCeIrYLiyXZ2Nr+aI59jFP5gkhdXd2eQljYa9faxwWbGwH1MQtEG7+IESZq4PkFXwptidsUulFf5JDHHY5xjwlALwx+0J8s=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 15:02:17 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::56) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 15:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 15:02:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 23 Jun
 2021 10:02:16 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amdkfd: implement counters for vm fault and
 migration
Date: Wed, 23 Jun 2021 11:02:02 -0400
Message-ID: <20210623150202.31811-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622133213.21393-1-Philip.Yang@amd.com>
References: <20210622133213.21393-1-Philip.Yang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 189a0aa2-9880-447f-3a0a-08d93657e47a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747C9470A68B8F041164344E6089@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmNoGdnkecSWnmhgu7JHiRvMBAjA37sigzSJsKZTFzIGakKFcRgSnnINRSKKjNvFdcwpNDalGk2GHZIvbhZ9/NFtvE8/WLo/MDRZSaj5BsA/MCvZvnDj1NK4q0V3OXAR07oVDTdi3WgBdpHHxoVzG4xZnV8JUfHxWle3sOgTOdG1Va4MFFSHnt0SAI75rVdlvfRmpY8N8xmZ+bD7aLjjMIjQ13pwnENYuopquAmEGXtn/ARb1pmsOezapN2S9ic9H5d+o/ps308wRPxXrrvMQgFKssxjKDSqLvaxl+VAnvhB4kNK/qQZZgbVuEae252cwvodAPzfmzdmcOdjtHX3ZkNisFGCdAd72ftWXo+Ps9g4zYzFvRXCheiNKWPMaZeagLrrKIHCEFyHZkvHwEWuJhqCF6mLyFA0LTtU2BSYsZYUqaZ2KsK01UCQ1JqScPZ5lcc0qLOHbUxs/VzLcHbhg5GNbKQyRJeuSwixQdV1ReerOqbBsMa/akA12YwKL6fBsDvJgFkp0mM8e3wDAPL8/+ComzQoSBfz1Jg+cg1U1t0yErDhLYfYphj0QjrMIbNXBCzKfTCCg9I2rW6E8Mewq9iZ7+gqTJb+AfSzWmDMPpwkP77QoZ283pWfojeL+RbuaMQrF8eRAO3oWvEMd34fmyy9h1DP5UEXmmzDocMFz88uD5pfygIB1UqYiD4cDGum
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(4326008)(16526019)(186003)(6916009)(86362001)(26005)(36860700001)(478600001)(82740400003)(81166007)(336012)(1076003)(426003)(47076005)(8936002)(36756003)(8676002)(2616005)(2906002)(5660300002)(83380400001)(316002)(70586007)(70206006)(356005)(82310400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 15:02:17.2376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a0aa2-9880-447f-3a0a-08d93657e47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add helper function to get process device data structure from adev to
update counters.

Update vm faults, page_in, page_out counters will no be executed in
parallel, use WRITE_ONCE to avoid any form of compiler optimizations.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 45 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..45b5349283af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -413,6 +413,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			uint64_t end)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -473,6 +474,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
+	if (!r) {
+		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		if (pdd)
+			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
+	}
+
 	return r;
 }
 
@@ -629,6 +636,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -678,6 +686,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
+	if (!r) {
+		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		if (pdd)
+			WRITE_ONCE(pdd->page_out,
+				   pdd->page_out + migrate.cpages);
+	}
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f5ebc00b349..00b46846a5e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -564,6 +564,24 @@ svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
 	return (struct amdgpu_device *)pdd->dev->kgd;
 }
 
+struct kfd_process_device *
+svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
+{
+	struct kfd_process *p;
+	int32_t gpu_idx, gpuid;
+	int r;
+
+	p = container_of(prange->svms, struct kfd_process, svms);
+
+	r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpu_idx);
+	if (r) {
+		pr_debug("failed to get device id by adev %p\n", adev);
+		return NULL;
+	}
+
+	return kfd_process_device_from_gpuidx(p, gpu_idx);
+}
+
 static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -2311,6 +2329,27 @@ static bool svm_range_skip_recover(struct svm_range *prange)
 	return false;
 }
 
+static void
+svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
+		      struct svm_range *prange, int32_t gpuidx)
+{
+	struct kfd_process_device *pdd;
+
+	if (gpuidx == MAX_GPU_INSTANCE)
+		/* fault is on different page of same range
+		 * or fault is skipped to recover later
+		 */
+		pdd = svm_range_get_pdd_by_adev(prange, adev);
+	else
+		/* fault recovered
+		 * or fault cannot recover because GPU no access on the range
+		 */
+		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+
+	if (pdd)
+		WRITE_ONCE(pdd->faults, pdd->faults + 1);
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
@@ -2320,7 +2359,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range *prange;
 	struct kfd_process *p;
 	uint64_t timestamp;
-	int32_t best_loc, gpuidx;
+	int32_t best_loc;
+	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	int r = 0;
 
@@ -2440,6 +2480,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 out_unlock_svms:
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
+
+	svm_range_count_fault(adev, p, prange, gpuidx);
+
 	mmput(mm);
 out:
 	kfd_unref_process(p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 0c0fc399395e..a9af03994d1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -174,6 +174,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
 void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
+struct kfd_process_device *
+svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
