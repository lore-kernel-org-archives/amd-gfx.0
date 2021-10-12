Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6093C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 21:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8DD60720
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 21:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A8DD60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AD26E833;
	Tue, 12 Oct 2021 21:01:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB556E833
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 21:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP+9yetPXY78iy0FbSRuU3WzKLJsNPdYpzF6i/DeSZpEjVvXIbAC3Vp2T39P0gjI2iCSiujH75kPVQFxsLxOn0h84h83RbMyCV7Vjr/bq9bQvKr1br3Kv4oc5Y+D0PQMZaoheA6EnFCoBqLgR52uXmhot43ACu5hIjhyYgHIBk61l7sv4AsDgjh88tQ3T0/oLXjDEPrgmTGtt5PZ6uNJLFDTXi22ZjVIry9OlmibDT1bvYapBAiqa0QO/MPyRaRod+eOEl/qgBVqJUyOAqaNM8EbCoseFtElWwnTSWQ9VNZy2Wu5UVSabak41pzT5XnpHmEAMIBJy6i0gcZa/MshqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okCXgedIj6GFK+cayI/nubY2WI2bCImjJUyp1vYHPbU=;
 b=jbeqO8YQRwdlgFXfbX3Xfbj2CSTrFggVrS2OwUagY0Z+5qoPXwE9avICmdShlzreA7EIyEh8Zh74hzhBu68QDFK2TlZ6Rfj3lljfhoQxeVyR6A3lCde8LpRu/ckpEkChff7vPp937iftif2fkQiU0IE3kGTZSZfk4IOlEEFpE8rSV7bj8Zk5E4FuPjzUwJEWABeMuJdxmbhxKWgBc3Brol5cnkzEml2CAnkf1TOetCQJ/50XUDUOiriFQwiEFX3zVR4LjFFqTLFziwHzghhXFPd29lFYRhSCJzhIApYZzlenK9OvpVnFIjuKztC6Chu+qKvV2c+WO/Bn/2QPwl0sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okCXgedIj6GFK+cayI/nubY2WI2bCImjJUyp1vYHPbU=;
 b=u7N7naW8B+g2KneJAe4XwnkqZGN0Vq5TRoxZHULUQaqJKx6EwKG212HAOP/XZaLqWeqszMlamNUPhdrvrOr6KoWhopXnQ/NqUq5uhpbghl1+wxlZ26rpKQLcL6lZj21WOVe1lBiEx8dLHfBrDHqX62YQCASGjnn/fjKbZSOELgQ=
Received: from BN6PR1401CA0003.namprd14.prod.outlook.com
 (2603:10b6:405:4b::13) by DM6PR12MB4106.namprd12.prod.outlook.com
 (2603:10b6:5:221::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 21:00:59 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::c6) by BN6PR1401CA0003.outlook.office365.com
 (2603:10b6:405:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Tue, 12 Oct 2021 21:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 21:00:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 16:00:58 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: handle svm partial migration cpages 0
Date: Tue, 12 Oct 2021 17:00:44 -0400
Message-ID: <20211012210044.32069-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012135527.28083-2-Philip.Yang@amd.com>
References: <20211012135527.28083-2-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aaf7e97-57fe-4505-4543-08d98dc3649f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4106:
X-Microsoft-Antispam-PRVS: <DM6PR12MB410645F6F275741A06C89531E6B69@DM6PR12MB4106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrkuNymcLb4I/xk06+kzrOvoL/8GLlO7uAbFt32oyYW6qrYvBGP7JKMp5FsJ30KpThMSMJUoeuTV6TJlajNX/be6YJ62gik0oUBr5lek6MMfrOucSZ94bkyyJhb7MEU/1bE+R/J6GfgGKGJEAiaCS/+wQwxV7fCmvcs86uteKyJw2rwrLZZJGqHnw0si5l38UjzJ0TT3Mh/pliWD3ItLqFjoKQV1V8rmTIGf4SueEdoWVwfAA07ghejDIf2NC+rF4W+2/mYIQk4J/CnSEyciA9Me2yDA4CiQW64EfCXiC7ksitoV1dLfKAj+BKcYcH2blGzKCchb8yN7TMTvMRRqvu7uqQlMgwOB+7MMbaYos4nGaXRM06T8Rf2FG2i4hISPUBsEANJQKe0XStA3IVel6jmoAy7MVd043YcO1QciNEd4LItgZzbe9LbKy7S/6T8nsFRc2ToUH9HKf3g16UZuTS6PFAtvA5V3YMdjHbzKvigq5BTuIVGGgN6ufK4RTcsC7mGhLEwoHttHNTY0YgLygQqL5FDkwad4TMeg8rindSwwH7VtyGLVgKS1Mamkb7WUUVjdzPwGCybBBxN1STYOcsxolv5TGpiE+ehPA3aG7K/PKoXIaCLsB7PAtNakuY0yshIyFbmpK5tOda2UI/G+i5e05WmMwb1xN5l9+Eb4Ag+fPZIByk3YLCuca+0O1lgcEGUQ4/4JTuFxivwV597Q3hminyEYjclfNcrgSWgKpYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(47076005)(82310400003)(2906002)(6916009)(36860700001)(83380400001)(336012)(4326008)(6666004)(508600001)(7696005)(36756003)(426003)(1076003)(8676002)(2616005)(70206006)(26005)(316002)(186003)(8936002)(86362001)(16526019)(5660300002)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 21:00:59.5504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaf7e97-57fe-4505-4543-08d98dc3649f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 90 ++++++++++++++----------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b05c0579d0b9..d37f20b17586 100644
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
+	long r;
 
 	if (prange->actual_loc == best_loc) {
 		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
@@ -492,17 +498,16 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed to migrate\n");
-			break;
-		}
+		if (r > 0)
+			cpages += r;
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
@@ -603,7 +608,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
-static int
+static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
@@ -640,29 +645,35 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -684,7 +695,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	int r = 0;
+	unsigned long cpages = 0;
+	long r;
 
 	if (!prange->actual_loc) {
 		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
@@ -715,18 +727,18 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
-		if (r) {
-			pr_debug("failed %d to migrate\n", r);
-			break;
-		}
+		if (r > 0)
+			cpages += r;
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

