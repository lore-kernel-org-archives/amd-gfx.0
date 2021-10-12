Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FD960F38
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7FD960F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4426E02F;
	Tue, 12 Oct 2021 22:39:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2126E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 22:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC3k6J/0O9EzH1V2thGwNiLPjLEyekeMtUBHe9lV1WRbE68n/l4iJGW6t9I9pk/gk8ybtwkPpol3YfKlT50hS6UtWIfIigx3umQhqvWYb1dBAzJgGb2ETi3gjYgP0kj3N13NbeQDr3+lPDt1mbhczxDH355o6KxlX4rzMHfj0TszC15DflVNIXNzXwTe9TC6Qq+0vFEfzVeVLdVnBsJkpGZHx3SkxH/1nUhaKbcb99xhbft3bNW+PVCRDW1fOdK/sKBgZE0xbGxs82SCkPLjGwYP84JGu39vg2proFKdW4tmLZzzC8eZ+Bu1NJ4q9hd3M8/zmw1lsON0dmDPtvl+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIuS9Fdc+oyKkgwUHBIHOz/AHOblTkN/vXhceD4j7Zw=;
 b=F3bZNQXqNjHFcVC/O2/Y5FIbyxoWhYX+Po/8HYGRE2cObePSBdiy/cBLDUQEHQh4+G9ixVJIajkw+1K9pvG5hOx6txtJjzhcoOMy4kCgWaTSe7EPQRzKbwYUdBkUj8WP7hO76VeW/aOwknyRQHbVf4V8NEEIImw3gzYFOFUe60bWFpDpRE1Avd0qex5lalQYfYMmo8iVT+n9syAZXSvBeBZPKBTuHnCzUURg+DZdkUvf/JQgbOJ9cnfcVp9kygZXAjo1WReC4550CIQdWQs+hfXvVBf0OqU0y+elHkutxHPfRR5cqDkLQcqIqAHXH6OOeQ3bhxslNSQ5nJkOGmJQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIuS9Fdc+oyKkgwUHBIHOz/AHOblTkN/vXhceD4j7Zw=;
 b=w6aGmySr3jmxMAz3WeL7283r+AjHgD9JQYsHD3kMUy0Zl44u3IYT8/W0mY5l2k4mXJSM0IdS0LisBTuNrvzZQKLc+3Wfdm8WpVYeqNl04Oq4bPxE8dX+zW1YLajJERSkbEk9C6/IZ6YNIm9X6gLaHpQ6fFp5+FJbpMAT8ujZQ60=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 22:39:36 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::51) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 22:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 12 Oct 2021 22:39:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 17:39:34 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 2/3] drm/amdkfd: handle svm partial migration cpages 0
Date: Tue, 12 Oct 2021 18:39:22 -0400
Message-ID: <20211012223922.19832-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <46fd7abe-bd7d-e2a3-1aed-b3028828d178@amd.com>
References: <46fd7abe-bd7d-e2a3-1aed-b3028828d178@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c885f8-0dcc-442f-19e7-08d98dd12b38
X-MS-TrafficTypeDiagnostic: BN6PR12MB1585:
X-Microsoft-Antispam-PRVS: <BN6PR12MB158575F318FBA71A20CD66C7E6B69@BN6PR12MB1585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQED2f6A12J4wdA3S2+ZlMATtwGDSCsAmtr1W1vWEEt9uct1HqkZ38XTI6CxghdowKUU/uz/TIRjjvOUFpLz93k6YzrkR6EfwvOdjmdVjjJHFpTJcMvbXubVCW4oPAtmrq5F65FnQcNZjvQ0buF4crA3UwrubcAFqD4pSD9G7xOgsj8fpmLkolmxD3uZ+y6cowq4yIsq9ysPjeDHZ2awosUuhXrPW0bge2n4pMuluS4aIBo/iI8x7w5lKYvvm5ygNQiC/WASNz8DbFlobM1k7auw+IRzAERcsvAsxiGuCFslRKDjxN1jIirtYFDdU+QDb9KRyVKJn9wfRo2KA+VFYqIptPX6JXIbJyeRnAlINv2LP9tyQT5HdgqmGh8QYo1sqkatKPLKJR769ZZxAUAUNtlPG2rtAbpOom2kltMIfQTOD8CJJFfXohxTzV27RHWGPZPVi3Je4rHMkrz7S1ph8jjiVRg2KF1F7lPAiiJzuvnzfkA+3y3xjqtZr4NYvRcxru2JyT+00OevdEt5Ni2mRyU/nPAW+zqDK8FS7zfB6Db3sv/3cEi/O7QEG81roY5DP7UDAb9KDzHbo1aYztpLRHHk013epFZ/TmIbyI904BvlJ68h4vtBAOc7sgnaGwAOm532YR/4X5Vv4pYjV+aMpuxHrSDPS/Nv2lXc35hA25AyQAyzKzkLUPicOV40a8GvWe01pYjdCSr+wPLNfV3texSo90pOxz5W1I48rGuz0Bw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(70586007)(6666004)(83380400001)(36860700001)(16526019)(186003)(26005)(8936002)(5660300002)(1076003)(36756003)(8676002)(86362001)(6916009)(7696005)(70206006)(356005)(508600001)(2616005)(336012)(316002)(82310400003)(4326008)(47076005)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 22:39:36.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c885f8-0dcc-442f-19e7-08d98dd12b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
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
number of pages migrated successfully or error code. The caller add up
all the successful migration pages and update prange->actual_loc only if
the total migrated pages is not 0.

This also removes the warning message "VRAM BO missing during
validation" if migration cpages is 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 86 ++++++++++++++----------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b05c0579d0b9..537e32f77eb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -376,7 +376,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
-static int
+static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
 			uint64_t end)
@@ -413,32 +413,37 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
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
 
+		return migrate.cpages;
+	}
 	return r;
 }
 
@@ -460,7 +465,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
 	struct amdgpu_device *adev;
-	int r = 0;
+	unsigned long cpages = 0;
+	long r = 0;
 
 	if (prange->actual_loc == best_loc) {
 		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
@@ -492,17 +498,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed to migrate\n");
+		if (r < 0) {
+			pr_debug("failed %ld to migrate\n", r);
 			break;
 		}
+		if (r > 0)
+			cpages += r;
 		addr = next;
 	}
 
-	if (!r)
+	if (cpages)
 		prange->actual_loc = best_loc;
 
-	return r;
+	return r < 0 ? r : 0;
 }
 
 static void svm_migrate_page_free(struct page *page)
@@ -603,7 +611,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
-static int
+static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
@@ -640,29 +648,35 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
 	return r;
 }
@@ -684,7 +698,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	int r = 0;
+	unsigned long cpages = 0;
+	long r = 0;
 
 	if (!prange->actual_loc) {
 		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
@@ -715,18 +730,21 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed %d to migrate\n", r);
+		if (r < 0) {
+			pr_debug("failed %ld to migrate\n", r);
 			break;
 		}
+		if (r > 0)
+			cpages += r;
 		addr = next;
 	}
 
-	if (!r) {
+	if (cpages) {
 		svm_range_vram_node_free(prange);
 		prange->actual_loc = 0;
 	}
-	return r;
+
+	return r < 0 ? r : 0;
 }
 
 /**
-- 
2.17.1

