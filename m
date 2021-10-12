Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0434C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727E86101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 727E86101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3416B6E995;
	Tue, 12 Oct 2021 13:55:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E89A6E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB5Gtmb4uPHr7gE6GMOB3Oc+gXkVedXz3Fhp/JN5GH7+n/yhE5tMefAzJlloDvrw5Os/oIYRxxhDhAK+xtEFsIWrSXKDCvRyndyELTdHcB42XYiKWZ9XbwzQ7iSaTfhYqr5ZFMvlCHGb1itbqBV9c8SgrOhSU80Viu0f+CHeJGXXLLv42bFjhSmCziNXdbaJLSO4hfB6DGEtCuYeoUGrwzcq1QE1onX/9jkfAGGK2GFj5kDa/Nzpe2nFYZqDW3JlHAzKZROrJqBTKhDltCenObnhtg8UwoCSj4BGfsxMgEQw4A0GnZbbeBSBkvsSV7jhp2BPrklCVqDviL20wtORzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw0VYbnogpy9+gYhNG5MoO75hq1uyshJBQltRPyksRg=;
 b=GBoqIG7ktx+zAF4GB9qNXAELg0cCTeiOFxK3j+luamEwMUi221+onDhcCDEZ60LrBe2izlN0KPnuBDRejntFZ8Rd6s2TtKHFNBSWqVUnlE07LRegqElTcsyx71vUtUV11MX7wmp+VgGncN3W697bSBJdR33vf4jDYSYgBdzDTQzt9kR6N2WbGSHyZ0cEcfSOyZOvzRE4WkE37mVSwKIU4ax1rzFrgaNsDpQbWleCgYrKAzMJ9ZlgujLYj/Mt6hkJYYPqt7+d/cdx1MikN3jOgbGWSCz9HyULw9s05K2ODrUwn3RfW/HrXBT6zgqYp0OMXr+CvHCtbqHUgylFn7u6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw0VYbnogpy9+gYhNG5MoO75hq1uyshJBQltRPyksRg=;
 b=t3C58A7KQjLxmaifPVxJpNw+SNDV1/xTCbiG8EO9pCTbIST1hsGxXXpdLLj1fTZqPHtQJCNZFmhK37gSJ29x/XSd+nuhj3j6ZupUJT+nT/NzN8AAquKKZ8fuNeH2SiOdAEnB+hioDQwZ2OLbSLr9baQ7u4ciVXwQJWEiRVI4opk=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 13:55:45 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::54) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Tue, 12 Oct 2021 13:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 13:55:44 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 08:55:43 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/3] drm/amdkfd: handle svm partial migration cpages 0
Date: Tue, 12 Oct 2021 09:55:26 -0400
Message-ID: <20211012135527.28083-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012135527.28083-1-Philip.Yang@amd.com>
References: <20211012135527.28083-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4adbf01-e62e-49a5-ffcb-08d98d87fca3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5489:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54896208BC047899B8B2D2DEE6B69@CO6PR12MB5489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygkIZxmyUlZ3iHEcfyAEjinf1hB5wtGP2BIYnvdmVYkBOLjSxkRJTud4xwCkah1ivSP7zN2eeAktoB0ge1/SxYWZtsmgPP5jrXHLtI0nWlLlh/oy7fxF1CaXVGRhAA+NZUgGVN7mYMM9qS1nZtHik1d/XvJ4mXPQrCUcKOFasM5K1IEh3e0IP7cLdzuXsuPNVWTBuLZn9fDLxMMa0CxBdvbHiTxEH322eYIVkavOCrsMS9cf0pa75ZykMtQOdKGRsblPbBPsQpH534nUsYTA5jvSSW+yEm6CXVV60q3csaeL6y6a0jZ2kRc4v0mtaH3ET9tgvVfwyYdil2FJOX0GOspj8k6to+A4zWY91vTuT31sFaHweXTjOlFlf3MW3BCdKHqFYvrU+i6hqjM3J9+FV+2kWZqs+A8ToIccEtkXfuftciTU9o6jx1s2qU/jIiOk7kf7spGgMYtFGKujZmDJhWMdGT+syurQTt+CQdVnrsJKdPb3LFxd8LSCC1oRDbXWULRcDSC8yShycK64HkIItZNmeEC7XE1/PqtQHg1K0vryoiKHhlBBh+BQsT6xDdLaqvV4D+1VqvG09c+JUqdP9Ch/iDMjahV8wpNh9oiHZsz78Jlvcu1bwGl5dXKraVoms3Aj6xBGgK2RilV3CZkmI+QOa+DtVYh653yU2v8EvpIUI5AF7dOwhtnDJdok38v+5dtFf/N7me5poblrcvRpoBDjjPt3KukWKPzmnXZbn/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(36756003)(6666004)(426003)(316002)(16526019)(186003)(508600001)(336012)(7696005)(36860700001)(2906002)(26005)(82310400003)(8676002)(356005)(86362001)(70586007)(70206006)(81166007)(1076003)(6916009)(8936002)(4326008)(47076005)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:55:44.7904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4adbf01-e62e-49a5-ffcb-08d98d87fca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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

migrate_vma_setup may return cpages 0, means 0 page can be migrated,
treat this as error case to skip the rest of vma migration steps.

Change svm_migrate_vma_to_vram and svm_migrate_vma_to_ram to return the
number of pages migrated successfully. The caller add up all the
successful migration pages and update prange->actual_loc only if the
total migrated pages is not 0.

This also remove the warning message "VRAM BO missing during
validation" if migration cpages is 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 92 +++++++++++++-----------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b05c0579d0b9..dd0fd52d0158 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -376,7 +376,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
-static int
+static unsigned long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
 			uint64_t end)
@@ -413,33 +413,38 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			prange->start, prange->last);
 		goto out_free;
 	}
-	if (migrate.cpages != npages) {
-		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
-			 migrate.cpages,
-			 npages);
-	}
 
-	if (migrate.cpages) {
-		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
-					     scratch);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
-		migrate_vma_finalize(&migrate);
+	if (migrate.cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 migrate.cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", migrate.cpages);
+
+	if (!migrate.cpages) {
+		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
+			 prange->start, prange->last);
+		goto out_free;
 	}
 
+	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
+	migrate_vma_pages(&migrate);
+	svm_migrate_copy_done(adev, mfence);
+	migrate_vma_finalize(&migrate);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
 out_free:
 	kvfree(buf);
 out:
-	if (!r) {
+	if (!r && migrate.cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
 			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
-	}
 
-	return r;
+		return migrate.cpages;
+	}
+	return 0;
 }
 
 /**
@@ -460,7 +465,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
 	struct amdgpu_device *adev;
-	int r = 0;
+	unsigned long cpages = 0;
 
 	if (prange->actual_loc == best_loc) {
 		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
@@ -491,18 +496,15 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed to migrate\n");
-			break;
-		}
+		cpages += svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
 		addr = next;
 	}
 
-	if (!r)
+	if (cpages) {
 		prange->actual_loc = best_loc;
-
-	return r;
+		return 0;
+	}
+	return -ENOMEM;
 }
 
 static void svm_migrate_page_free(struct page *page)
@@ -603,7 +605,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
-static int
+static unsigned long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
@@ -640,31 +642,37 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out_free;
 	}
 
-	pr_debug("cpages %ld\n", migrate.cpages);
+	if (migrate.cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 migrate.cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", migrate.cpages);
 
-	if (migrate.cpages) {
-		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					    scratch, npages);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
-		migrate_vma_finalize(&migrate);
-	} else {
+	if (!migrate.cpages) {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
+		goto out_free;
 	}
 
+	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+				    scratch, npages);
+	migrate_vma_pages(&migrate);
+	svm_migrate_copy_done(adev, mfence);
+	migrate_vma_finalize(&migrate);
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
 out:
-	if (!r) {
+	if (!r && migrate.cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out,
 				   pdd->page_out + migrate.cpages);
+
+		return migrate.cpages;
 	}
-	return r;
+	return 0;
 }
 
 /**
@@ -684,7 +692,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	int r = 0;
+	unsigned long cpages = 0;
 
 	if (!prange->actual_loc) {
 		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
@@ -714,19 +722,17 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed %d to migrate\n", r);
-			break;
-		}
+		cpages += svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
 		addr = next;
 	}
 
-	if (!r) {
+	if (cpages) {
 		svm_range_vram_node_free(prange);
 		prange->actual_loc = 0;
+
+		return 0;
 	}
-	return r;
+	return -ENOMEM;
 }
 
 /**
-- 
2.17.1

