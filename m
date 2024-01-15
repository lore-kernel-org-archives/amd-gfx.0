Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878ACC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3359510E3B4;
	Mon, 15 Jan 2024 22:51:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB45910E3B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBcsQlAhtb3o5kAtb9Fx+WDAC3LJj3mLEVXjC8qoKMTT7Y5EdvoY3Yflls+T/BV/UoCdo2smBZCC9zFgfb+7N4qD6EqiUqktPVgP3M8wpZpUzfzBphbilDHvk5q7BXgY3tU0uox2CPQCYAJY0BGaQtSgcQ7dPQwTBHH1IQUby2g5ci3LfEDlEHQyzzPDso18DSQSPHz3mfe2H+fISq/+lqQRH8JlQHkM48oahbZV8VvejbRCwuUdnwzl6r4E7nsE3aH/yIyZyV4FqaZ/ZcM0hR5yxe5cpGXVzrJ1s8P5AGLgITFmk0P4r2XgRHbmSFAk61VeBgpdI8WDlZ6BIviDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK6+YtIVQekO9uPCsoG1HPpU4IvA3A2IEaKTwmw1MhU=;
 b=LOricnvNmRXPvgLBWjwndPICaPVWLTI4YLXsMraZ2IeAtPz8Ue5hpYbIsXYQXf6VkKiM/4sQZL0Vo2FXlWWWIArktPdWsSRsC93NannZAx69L7xogPxUppWtZblnU46iQPDZHcY1G1q9khjiB30pvGyh/Fy/nwDDi+QBWLqkT5BAtYDJgIcfGJHzwWMcEVRmWcLToW7Nb0UImCil7B9+wJa/FOfYrsfbq161mtNTUDRZ62ftcMPgxtFzUNTFApAAs2ccBeHYPeeovAotUrzzi2FcrTooQwb2tF8vJk66aIm8kY+AhuIXUOLY5/Lz1YHz6fShDi2dP8h5TdIQ/9gpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK6+YtIVQekO9uPCsoG1HPpU4IvA3A2IEaKTwmw1MhU=;
 b=p63fVviDCg1Kg8L2BHR/tS70bzCxT/kmgkB5dARDETSrhM3/dEDYd03y9hgKHOpM2yVGmQeVG2wL/A6nM+/6FdED0k+Fyuu5An6aaVb5H09ffsAgFKSpLJuEvFHY+m7AH3iYPXCTMR/3gHXalKQ43u/HKovCvKVOF4Vomh0A1JE=
Received: from SA9PR13CA0168.namprd13.prod.outlook.com (2603:10b6:806:28::23)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 22:51:23 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::85) by SA9PR13CA0168.outlook.office365.com
 (2603:10b6:806:28::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:21 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/7] drm/amdkfd: Add helper function align range start last
Date: Mon, 15 Jan 2024 17:49:45 -0500
Message-ID: <20240115224950.3300-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 79298bda-dce7-4a95-d8ad-08dc161c7ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUoHp4JU325T3o4Ex9JqiSLb7XwSFpAizy+cUvRJTr9FG/nRpVbHO2g8AQK4Eg0utJbI+Unouu3qeWUY5MRdbTiia3KLPnBhaq7h4saDjOu3n4AlLwkWNACOeM5Cwkh7NuOAKpuUI1D38b27pbU48WQQq9syeZ7FQ73Ob+64TTiHbOrJQhWRDbVJR1k2QC+PDU3rltDqaIhx2kWUg9WEyVFEh9GBcTK+V/PaFI6ZQW/w2o7Y5409jxScDZTFZr/Gxu0veAEdDme5/DsdywGweps61w+B9Quh/Nt3ssGSD7H3mhzXyNM25Iv16ZKc2HwoyAmP/Vye6xUZKlfJFOkStGI8u65NzHNWugHOvcn4NoCWj6lZc2XKxKxgzR5S/wxDeW1k4jMM1hf+U7dQa5nGVfLWpyOprrV1t+afTLevvKYmivC0Go4Fk2SNZ1j6JzYJtxfQrFBkf4SsA4c6EAztD9JwNjpaOAvUk6QS8CLiBu5ZE7h0kiScLB+Ed/CSGLr9MkQ+9guF/HT2uvpJjlrVZXEAWvn0iXAE1XlO5o6sTok5mCbonSzqwZeeEpfRQ1moi/P14/85HTrEIgnAwt8Ns5I8Q2EtDlLaW8VmMO69GpgGPWoj+Rnr0Vn6MfyIa2DTbzU9l+zUnyCpdyMOAsvSrEmWcVe8gV4PhlqiWPkzW3+YvfgcOx8TjFoEbOkPZeD6nxIxmgiSonFZi/eOjkDrmU3NyEvdA6i6b4MKSa/vT8CvZllsEr6PY17E+6iUrz2rMKtvaJKVubOA4FwKzukd7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(426003)(336012)(356005)(6666004)(16526019)(26005)(2616005)(1076003)(7696005)(478600001)(36860700001)(83380400001)(4326008)(5660300002)(2906002)(47076005)(70586007)(316002)(54906003)(6916009)(8936002)(70206006)(8676002)(82740400003)(81166007)(86362001)(36756003)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:22.2571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79298bda-dce7-4a95-d8ad-08dc161c7ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Calculate range start, last address aligned to the range granularity
size. This removes the duplicate code, and the helper function will be
used in the future patch to handle map, unmap to GPU based on range
granularity. No functional change.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 10 ++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 10 ++++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index dae05f70257b..64eb9023d66b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -986,8 +986,8 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
 	/* Align migration range start and size to granularity size */
 	size = 1UL << prange->granularity;
-	start = max(ALIGN_DOWN(addr, size), prange->start);
-	last = min(ALIGN(addr + 1, size) - 1, prange->last);
+	start = svm_range_align_start(addr, prange->start, size);
+	last = svm_range_align_last(addr, prange->last, size);
 
 	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
 				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 14dbc0fd51a9..a2c96f5760ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2698,10 +2698,8 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 			 (vma->vm_start <= vma->vm_mm->start_stack &&
 			  vma->vm_end >= vma->vm_mm->start_stack);
 
-	start_limit = max(vma->vm_start >> PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
-	end_limit = min(vma->vm_end >> PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
+	start_limit = svm_range_align_start(addr, vma->vm_start >> PAGE_SHIFT, 2UL << 8);
+	end_limit = svm_range_align_last(addr, (vma->vm_end >> PAGE_SHIFT) - 1, 2UL << 8) + 1;
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3043,8 +3041,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	/* Align migration range start and size to granularity size */
 	size = 1UL << prange->granularity;
-	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
-	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
+	start = svm_range_align_start(addr, prange->start, size);
+	last = svm_range_align_last(addr, prange->last, size);
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd..806bcac6d101 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -159,6 +159,16 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 	return svm_bo;
 }
 
+static inline u64 svm_range_align_start(u64 addr, u64 range_start, u64 align_size)
+{
+	return max(ALIGN_DOWN(addr, align_size), range_start);
+}
+
+static inline u64 svm_range_align_last(u64 addr, u64 range_last, u64 align_size)
+{
+	return min(ALIGN(addr + 1, align_size) - 1, range_last);
+}
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
-- 
2.35.1

