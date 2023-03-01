Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D4C6FA9D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 16:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100DF10E304;
	Wed,  1 Mar 2023 16:34:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82F110E304
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 16:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjzPMDgkO12CTgSCbu1PK/xiw60grrUI7InR4m7hlKZg6Kx9GG0OFiertIAUVcMM37NgfUJaxaeAAkyGYb2SpGLiRsHkh0KQX9GVoT19VwFO4Tjtkd4348LTp2Ht6KyMhuyfUQEIRL5bVQljhEcLBMR5ZhxzTXUDIutQ6lfMkcjzf17QsaUCM02igEp/EBSWEbOOPxgM+YGSUa/zOJhtAniT5vOP85XPZY0Pyxr7wSXlBRBHHP/mBcMNqpUPMGLofCl1IzHkMhQEgtViXrphQsoUnvhFKvTexHdAp9GB0jNH4+3OF/q18dd4b0jzIMvi+0bFAFLBMn0zBxWfkXyypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI7wOekLufA+vDFO4IgWF5BakCSYFTvXvapEXjOjgME=;
 b=MANjKzm6+RbNV1kdE6cUWDfn8nhRAZDdwU9Zx+0SeQmB09LHCXEw/+WILW7Lmw04MTgrgau/hBKZ68doilYPHSnmfq519OyYMqjpU1VQLk2iKwWLC94r2Lzm0yzRsU3CkaAutbXkFsVY2OlTJxSk7WK8xlGElMuRPIUVIGz4W6a87tlzQnodjNYnD8ag201jEHNO/193PL+qenTYPM6ehO62Yq+2nXkPYSBUUp/Nbgd3C8MOBotLdfJtTiuNBeB3pezmDP/ub954OVOW/9qjOZdtg210tkShfsK5ewS6nlLNGmU33MB/daNkX5n5VAQoDyF9Jo9MqWNJ/SwIv5EjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI7wOekLufA+vDFO4IgWF5BakCSYFTvXvapEXjOjgME=;
 b=CclIJdVWttcYwk79QNHc6XR8VW9ip3VsI4NkTdTfdN6d4iuLSsGaCpr9INe0zjUHyqBjMPtMlgFbbWI5DUNrIEr9TIqYI/m1kHAk/OR0mm8VdIJJYo0LI6J7/EHG7QYdP6X7rIOlSUkN7YwHa4o7l8+Cnz73oRSWZlZCFZPnTq0=
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 16:34:48 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c1) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 16:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 16:34:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 10:34:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 10:34:47 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 1 Mar 2023 10:34:41 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Cal vram offset in TTM resource for each
 svm_migrate_copy_to_vram
Date: Wed, 1 Mar 2023 10:34:30 -0600
Message-ID: <20230301163430.1782358-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 275f37af-7ff3-4fd4-26bd-08db1a72dfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9W9ATwCd4XCVDwKwnedmzJUweDU1Ks5JfrZtuQW45H0kuUtLJULx3RfsEJ0o6DAAq6MsNoIFpTOb/Lu96q+bP9HhUrTZAe1yVOdB6/b7qLUVuiNCuxkdOFexIs28A1VrV6KAAd+MZj+pqVejVykUjb3Mo7xg460MCDDEKMja6fD/BFYhyJzn+aDdNpq59AZeZjNqzcLthHPEPnwC0XW60JRobX4Spygqxandqo8TLp3b85uc65NOtOgBXFj5ky9eZfKTvDNtV6AmpROY/GWFU6xOqQaXyXk5AL/5/pdl+5HlKOv0V++f+FZWv0s25fXgb2vITcG4moUSzP8Gr0v5yQlnuNIRkxiS92QM+uZDohBmVnPI6ZR1trP8Ly7E8tjuh1cy+Nwx7rB4IGeYcvWFzBPL6bDf2/rWsvJ03liTzOpTK7ZrxD4h/dznElAjdl8YOL6pcXNT4jhaZEEC2+Ngd8mi+KcFuFvDXGtbIAn877B+gd81IUTlSj19//Tp0lDvUy/mBNSX8riJqVSMMP3UZSb07JRRJgA9BTbtS3S4l7Sn9l6gMTjHWM2Y063Ht3YxH1hJ3g+0BDfvzzeHCGI8BCKrHGDgj/4zPHuSlG6c722+MFlEuRpTMr92y+uOnlY+SBb5L0D38/Txl91e7MUQpH8GzEU+5AozjCxd9xCDmYDEKjdsadDcdvzPj9d7YGrMG8GDbRq0RqDGm5bEvbYQpc6IPFpor/lA+RwzolfxPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(54906003)(82310400005)(316002)(478600001)(5660300002)(86362001)(7696005)(2906002)(41300700001)(8936002)(70206006)(70586007)(8676002)(6916009)(40480700001)(81166007)(82740400003)(36860700001)(356005)(2616005)(26005)(186003)(83380400001)(1076003)(4326008)(6666004)(426003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 16:34:48.3673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f37af-7ff3-4fd4-26bd-08db1a72dfbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

svm_migrate_ram_to_vram migrates a prange from sys ram to vram. The prange may
cross multiple vma. Need remember current dst vram offset in the TTM resource for
each migration.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1c625433ff30..373cd7b0e1ca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -294,7 +294,7 @@ static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 static int
 svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
-			 dma_addr_t *scratch)
+			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
 	uint64_t npages = migrate->npages;
 	struct device *dev = adev->dev;
@@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t i, j;
 	int r;
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
-		 prange->last);
+	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
+		 prange->last, ttm_res_offset);
 
 	src = scratch;
 	dst = (uint64_t *)(scratch + npages);
@@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out;
 	}
 
-	amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
+	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
 	for (i = j = 0; i < npages; i++) {
 		struct page *spage;
@@ -403,7 +403,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end, uint32_t trigger)
+			uint64_t end, uint32_t trigger, uint64_t ttm_res_offset)
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
@@ -456,7 +456,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages migrated\n", cpages);
 
-	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
+	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
@@ -504,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
 	struct amdgpu_device *adev;
+	uint64_t ttm_res_offset;
 	unsigned long cpages = 0;
 	long r = 0;
 
@@ -524,6 +525,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
+	ttm_res_offset = prange->offset << PAGE_SHIFT;
 
 	for (addr = start; addr < end;) {
 		unsigned long next;
@@ -533,13 +535,14 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger, ttm_res_offset);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
 		} else {
 			cpages += r;
 		}
+		ttm_res_offset += next - addr;
 		addr = next;
 	}
 
-- 
2.25.1

