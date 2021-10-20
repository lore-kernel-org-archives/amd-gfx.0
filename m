Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2630360F24
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2630360F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19CE6EA16;
	Wed, 20 Oct 2021 22:54:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E5C6EA16
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 22:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaDh46Og5LtMe6SEEIhmv92CFiOWlq4Uww3CRJaEgCv0rvh+tCJqn9akEMPcsuZKDyPvIKF00WvFtQcgVRwINNIN1oP8PnrzstsmruNHqLlIeLRYh4ZkA4MDNFbT9K1nG3vlyXiWt3xHXTH2hs4u2lCGFhCkJcHCF3hGvE0+OTyaL4e+QcL+Ac7ahXw+1OPv65+BLLNlYPhWjhDCabXf9/DmbOP+07t2C1OcH8uVZBKzwD3rhOGiLCgmpGTieW6JeealXF0M7WyIyY2XzZvuVwg4jyyH/mvywJQMeRuJz5zRaJxpHQVAIoR8tvAE9e4gNjNgVnxWfSSZDxV5uCOrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVYPHuKhUbDdb+U4yQ+THXbWCGBNVai38/6RvAjFQUA=;
 b=E8VqgSxjGZBKHLRtmS/n/0pZlMZjXWrU+XjzEPgifjsBsLK0WhkSfXS/tKNgaIaLKOJqcJU6+TKctolkEAWzOAoEVcWhjaeXGTzt5KhMNCA3bZjtij+Za2d/leMLkH3aXR6c2xbA2L8Y4OkuCBXTz1cmtNvsmeiGuqR2an0oqZ07IGJaTalllpClelklpCZu2FzZ10VRxmUz49+GdnYnJn4L6B8Ae0nxZsvKfImPOlWZhSfhibtTFhbvonahDwPzVGBBGFmU33NXaFr7DRfderkGob/+1QrFk8Yy3EXIUJehieM3pAALkx6XQa/I6lOaOd21ji+xXUHIc/cKEF0gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVYPHuKhUbDdb+U4yQ+THXbWCGBNVai38/6RvAjFQUA=;
 b=nxk3HRx55At98DrvpMSN0FR/38dwWoySz71I2YArDf1biXF8MMR7PCgScWuzSeIpu9dUKE1Byv/5FTH5noLtHGqj4bLXKHrar0fAU26JchRgIoAG0tR/8kxeqVJ8HpuD+gJceICU9I/qP/4as7Cz8fRJDo5Xr0UYWokMXPB1zu8=
Received: from MWHPR17CA0094.namprd17.prod.outlook.com (2603:10b6:300:c2::32)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 22:54:01 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::f2) by MWHPR17CA0094.outlook.office365.com
 (2603:10b6:300:c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 20 Oct 2021 22:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 22:54:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 17:53:59 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: svm get successfully migrated pages
Date: Wed, 20 Oct 2021 18:53:45 -0400
Message-ID: <20211020225345.32533-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a60596c8-fa42-486f-20af-08d9941c81ae
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4965BA62950A278F5C1DFE8EE6BE9@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZvkAyXQMKHdxTbu2ruVYJeZZDieA7z279Q2Ow3tn3CXdht2TkBcAFxNDTH5zharYzVAm5418lO+SQUPWWbWkB6KUaFiYWBIu7YVbTUiLbTb/T3cxb08b8cESvaMsUkFfggRfmUcGhxOvpBtNEwM9cWd6R6T0Q/QXUFr06rpDqWiGlaQXwgoG7DI6r5VN4bqLamswATv0Mn3LvmRpoyGI1mjiUtJMIKyEIThz3FFBfW0vJtCeoLHemxH0Q4HrrmqqZFFvVjKt0RQtCnNvxApnd1ZMm3mLU26XwM6YeJXRmdWxgBDrWNZ/C1+hkRcE6OMVKFjgRmnlGQll6svgTTF6NHhzqABMrZ0IywayTA7VnhMwA6eFSFb6IYHMIl+uadDIp2ykgugXoytlDAN+HVqXJX1IfPyDs1eczrVVQwvQpK7q7MeVZUgWa9zfeS663/GXmPZchT1hZaAF5CvELc6eYA1GVR3stDuVmswduiSKxqg/lLvy6bpzEV+KU54RaTTx9tun72AZ+2UgABNQTWU4QfRd5Q/fYCHCqG7QpU2LuX0ru7WFQZtMxyMAlUq0RsKKqH+2e9uVqyYbUW+V7UK7/Uka5MMbf2AUmrd7R82ts3vMK6+0fasD2CrCOid9mijqipE4BX6Rqs8NTPj0oo+SdPS6Dj/iXBbMCv5eW6AKlk1zt3zhR0Fszj0OtskgfcO96l0fEEyMoOZnH7uOSWgClV4/z5XTP+q6mdhPvTvoMw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(186003)(1076003)(70586007)(26005)(36860700001)(316002)(4326008)(81166007)(6666004)(36756003)(356005)(7696005)(336012)(86362001)(82310400003)(16526019)(83380400001)(508600001)(5660300002)(8676002)(2906002)(6916009)(8936002)(426003)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 22:54:00.3774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60596c8-fa42-486f-20af-08d9941c81ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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

Not all migrate.cpages returned from migrate_vma_setup can be migrated,
for example non anonymous page, or out of device memory. So after
migrate_vma_pages returns, check pages are successfully migrated which
has MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag set.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 33 +++++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 147300a161d0..22ab9c940157 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -268,6 +268,22 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
+static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
+{
+	unsigned long cpages = 0;
+	unsigned long i;
+
+	for (i = 0; i < migrate->npages; i++) {
+		if (migrate->src[i] & MIGRATE_PFN_VALID &&
+		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
+			cpages++;
+	}
+	if (cpages != migrate->cpages)
+		pr_debug("cpages/migrate.cpages/npages 0x%lx/0x%lx/0x%lx\n",
+			cpages, migrate->cpages, migrate->npages);
+	return cpages;
+}
+
 static int
 svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -385,6 +401,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
+	unsigned long cpages = 0;
 	dma_addr_t *scratch;
 	size_t size;
 	void *buf;
@@ -428,6 +445,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
 	migrate_vma_pages(&migrate);
+	cpages = svm_migrate_successful_pages(&migrate);
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
@@ -437,12 +455,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r && migrate.cpages) {
+	if (!r && cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
-			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
+			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
 
-		return migrate.cpages;
+		return cpages;
 	}
 	return r;
 }
@@ -619,6 +637,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
+	unsigned long cpages = 0;
 	dma_addr_t *scratch;
 	size_t size;
 	void *buf;
@@ -663,6 +682,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
+	cpages = svm_migrate_successful_pages(&migrate);
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
@@ -670,13 +690,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r && migrate.cpages) {
+	if (!r && cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
-			WRITE_ONCE(pdd->page_out,
-				   pdd->page_out + migrate.cpages);
+			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
 
-		return migrate.cpages;
+		return cpages;
 	}
 	return r;
 }
-- 
2.17.1

