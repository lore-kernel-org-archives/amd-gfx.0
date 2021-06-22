Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D780C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CD8613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD8613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C247F6E50C;
	Tue, 22 Jun 2021 13:32:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2E06E509
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 13:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2iAl5cyY5Al+7KKQYvE2mRB1O5hyRq0Pfu0eJvTuLsAX74sSZbHVppSMNIteMoVjwSzghIvdJ9VOVRDTyuUwQJjC4SHZvBXlX+DIruKZIxGyyr09I8fe3MpPdqk6i60NRzkIAcO1MxbGvKIuzO1buFoIrEzVaIoIdRzKxj9Jf3UEI5un1/qSqveFgNNIOTTrDlX2GCGB6OQ3E54p5W7o5UnTQOtprKHkFg9Z9ODHYYYCFJZGpHanJnHLOmubpIvEyswR62mgb0REj+z04iBGF7guQzII4c9qxvM8Sw6QhX7jm1mhKapyyOMgyc/ZHjhOQRToWIA3m7/B3vT3rNLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JebiV9GODYOIdmxqF49rIJvZ+3G4wDHP2XIoE+c4uYU=;
 b=E+J3Kf6vPn6++RBozNRRDJGEi5bQO+NX58q99ekcc08RNWeRIbaJUZKepKBARwBbytng4als5YfIcxjlc1PYqIXqHaJMFBKxlfsf+isT47cuh8X7G7HM/DrM7HeA5TqndqzyphtasVFOQK1M6HQCNM4WE60DLOmdNNkP/KZLfRxetRcIQn0NW7zUKIn+2tqHpivzAigShmotZVjI8F3KbgZeYbEaHc+KIRnJq8DyqNSxBbQXBpVOvJxIY611caoP0OKMxyF2BJb67S90cfKkdaZQzICIxAA7ZPCHYac5KaQJBo9vX4uS/CkMypzPGBoM57kyMZsrfNCaKZxni0XwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JebiV9GODYOIdmxqF49rIJvZ+3G4wDHP2XIoE+c4uYU=;
 b=i6/hGnC03EwiGmuMefwJHCf/GW43SVSdMT11EkL6Xazoovh727WUhl4RRHj+iwRMYGXDTLSoV5I/e2+WRN5DC6aHXUWA0QhfelkZHVyZ2tbXHFMsgUoprP5Q/mmlRGRWiCIlvLfvDIGlWWnomQFsvoCaE0QeE2OKJaR6iXVcgbE=
Received: from MW4PR03CA0026.namprd03.prod.outlook.com (2603:10b6:303:8f::31)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 13:32:36 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::a6) by MW4PR03CA0026.outlook.office365.com
 (2603:10b6:303:8f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Tue, 22 Jun 2021 13:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 13:32:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 08:32:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: implement counters for vm fault and migration
Date: Tue, 22 Jun 2021 09:32:13 -0400
Message-ID: <20210622133213.21393-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622133213.21393-1-Philip.Yang@amd.com>
References: <20210622133213.21393-1-Philip.Yang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd6fc9d1-a77a-4554-b891-08d9358232d8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5041:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5041AB4E46262A136F52BB68E6099@CH0PR12MB5041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LaY4FoodWw1ynCeU3ARvKGpQlvMCMmjtykphnop37cOdJdRJXN5dUZXpipA19NzSFmDU1swy7Ry7j8LiK92w5lzTbuc7O6mIDby+w33JuVQpxgYQ13Ggaw4JkqpT2agKZnE/9rFIfFkx4IiOa3bcDn0Rh45eKSYjxROHYM84p9UIph9s4eU80OkMjbaCYl4tudbAWrSghjAS619KOGt7n3+UNiVuzqrVU8QDQQRVvZi+plF9QGVhVwjnYvnHKtyTtNQXeoX1g/eIAFLRF27FrdqKeDG5nMajcNn8yZMggkCgZspB0GUyJCG04dyqJXvoURDiquUhnoNsLwMR1HjIizpX1lxpCcpW513aY1vt2AsMkfK7lQeiZj4rydAt7QdHjU5pGMQYXVJgUp5LDKOyf/U5nDSSYjVOVPjAEatHlN3g600JegTnw/h2lLwP7cGPem/ltrTR66SW9uW9WP3OD0VgE5zb/iZESvhRb9VHM1gnTt1OFnZwp1eTNVgyI8ZOJcOJKL+6ZjFYLObvNLJ7eoG7aV4in5Ufobw9uvooraCh9mNo4pWf7blZlWOZZk8L/qA/aJvFDuiKM9R7367GQaYafWg8jSh/QJBZ+yluVsy2TAQcv/2/r686ptDTK08YH79eg+ZGZDyXJ090Li5yDa8v99tCaYm7W9mrvF9X93I0VuLuOggDS5+HeFLsBFC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(47076005)(6666004)(6916009)(1076003)(4326008)(356005)(5660300002)(82740400003)(2906002)(81166007)(82310400003)(83380400001)(36860700001)(16526019)(26005)(7696005)(8676002)(426003)(86362001)(8936002)(478600001)(70206006)(2616005)(36756003)(316002)(186003)(70586007)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 13:32:36.2981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6fc9d1-a77a-4554-b891-08d9358232d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
 3 files changed, 40 insertions(+)

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
index 5468ea4264c6..f3323328f01f 100644
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
@@ -2315,6 +2333,7 @@ int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
 {
+	struct kfd_process_device *pdd;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -2440,6 +2459,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 out_unlock_svms:
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
+
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
+	if (pdd)
+		WRITE_ONCE(pdd->faults, pdd->faults + 1);
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
