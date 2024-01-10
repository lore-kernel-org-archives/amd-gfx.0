Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA1C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 22:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A0410E676;
	Wed, 10 Jan 2024 22:03:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4B510E676
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 22:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHQbv//MGTXzs4vnKO4YryrOgvY2ZVIbmh31xIvFEIxL5dao/lIEWD5/XsZcqm8agdg4RBSlMWvgJvkRbGkDjMIVioIyH7Cpf+MXEx45l3d5R7UPUOGa27XL6J7nMwyTVYa4jY+X+d6pBU5RdMTA2Hyftc0Mm6KX8s7afruQCgmQEUfnsc7fP3jyqS3MXeGq9Va1I3mkvsInGxOd4+o2XooqwvGx+95EfjqdYTWFfld9yyr32srhIeX64W3n2TOcNF1z+H5EyK3XVED3s8kIchbqVDGHENQ0p/9RkjnYDNpduEcH0Dst92Soxj6ZF8mWYl492CgjyJZxFbSWeuJGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia1vAiNxZGpsVfy2PWROQDLKj+gxxarsXlm7J01f49k=;
 b=DDqy5fJMzV9YXV6ADLS8eWl7EznxtD10CmjkeRZoHtqqKlbJFW9Qi8DOYStMmIvcBEbOwiLgDIdwdo2malfk2nde7A6f+0jV1zJn1JJyns95h2Eo29rN2cHUAhgGBDOcr5A1SS+E3aYVD0wiX2dT6vjEmzfz1Qa5hXr+hEI0I/RuLurScte593cD01ciZ0FH2BVQxpnxhk/MlFA+Pwa4mj83WpVb1EipMheXzyqmFbRqABRPsZFGbDOaVSWIr84E9RR0e2vfZywUF1dNkBVl3sytsA809FkyfZmc4mC3WONOb6PErpgxteuiNa/9GuGw+k4DFrmpE3ps6BTVqJVv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia1vAiNxZGpsVfy2PWROQDLKj+gxxarsXlm7J01f49k=;
 b=1nExcilQxja5ovPdEzCBtmeT7BBy2P6PO9dhOPviHkpvPjcet/bWoxePOPjRWBnUcigCHo9wnGyFY22BLalUENMf1MJ+1useUYSFtHVhbvOZ38vVfywSG4v0NDDtWPPiMpFwQywn2J+KkF+XYgoGQx1hNK/H/jVqea1VSn/Llz8=
Received: from BY5PR17CA0017.namprd17.prod.outlook.com (2603:10b6:a03:1b8::30)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 22:02:59 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d4) by BY5PR17CA0017.outlook.office365.com
 (2603:10b6:a03:1b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 22:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 22:02:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 16:02:58 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] amd/amdkfd: Set correct svm range actual loc after spliting
Date: Wed, 10 Jan 2024 17:01:43 -0500
Message-ID: <20240110220143.25973-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: e41d1198-1ad7-4937-b7f2-08dc1227e872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wUMXqFug4OsOk7+Nw+hAQs+SzSJ7t2wtkTthBSKEeBlrmxVZlw9LKT60pqcr3wlSiQWMAy/0BIRXGdP/0gspHP/gYrShCJKXD4sbMZqiXTPszpNhfhZGosFldVYhEL6paDmMSlPUifRMsXxXWjz6TsbQzLNIYgyiMlaNlaLMKRAZtOAFOasEJjdXkBFLB4gfMPF0kTv5lOGD0dV198hjTeyM66tDZQ/a73aXWHY+qMg1pe0T0l7dDEQKInKpJrqZ6T+DZmTfAvInIsEPANQ+X6ONr5m8RJV0WGXH72r2az1ed63YTpGIUgkKy4uBlbrcGjw7ZmqtfrFBiYJpZaiHDgSIVcQyvOu+S2B5NcijOQYSvOQRYU+ieZI3qCGWB91g5vJ/o3MGLnSyp7WTEZQX/8zCAmMznkcWiQVIcRYt8Zvaa7sy+Od6a7+GaeAfdZnGEDR0V806UJgsodPb2aVFxK21BLDZpdk5ijiZ8ESV2yhLuFury0DMXUHnjg6ZhED7KBvzi2P2lOIqm7hYDJ6Vtz9QV75OjTHFdFu+MkaRNjD/+1d7vQDG/+ePv9vckLIRpe1/aHHy/H+TSqnElju17cg7r2/F2DKSMroMXKcsIx67IjY7zc8H/HxIOKcYIpKAB1IsYmUqgbWuDk86a/zvJxIyzcYqHc3rN9yPKxILe9tIlZnSPKdgxgWs8tSc0K/BKAbI5/smQCq5RkQJTv3HuCcC6ysXIWXmWlYAOfwMD6ZNKSuDCUJtIBGtZJtv6mtOdkzlsygJWR4Ml0wMckBoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(1076003)(26005)(83380400001)(16526019)(426003)(336012)(2616005)(6666004)(7696005)(36860700001)(82740400003)(4326008)(5660300002)(2906002)(41300700001)(478600001)(54906003)(6916009)(316002)(8936002)(8676002)(70206006)(70586007)(47076005)(36756003)(86362001)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:02:59.1374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41d1198-1ad7-4937-b7f2-08dc1227e872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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
Cc: Xiaogang.Chen@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While svm range partial migrating to system memory, clear dma_addr vram
domain flag, otherwise the future split will get incorrect vram_pages
and actual loc.

After range spliting, set new range and old range actual_loc:
new range actual_loc is 0 if new->vram_pages is 0.
old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.

new range takes svm_bo ref only if vram_pages not equal to 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f856901055d3..dae05f70257b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -563,18 +563,30 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
 			dma_addr_t *scratch, uint64_t npages)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	struct device *dev = adev->dev;
+	dma_addr_t *dma_addr;
 	uint64_t *src;
 	dma_addr_t *dst;
 	struct page *dpage;
 	uint64_t i = 0, j;
 	uint64_t addr;
+	s32 gpuidx;
+	u64 offset;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
-	addr = prange->start << PAGE_SHIFT;
+	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
+	if (gpuidx < 0) {
+		pr_debug("no GPU id 0x%x found\n", prange->actual_loc);
+		return -EINVAL;
+	}
+
+	addr = migrate->start;
+	offset = (addr >> PAGE_SHIFT) - prange->start;
+	dma_addr = prange->dma_addr[gpuidx];
 
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
@@ -623,6 +635,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
+		/* Clear VRAM flag when page is migrated to ram, to count vram
+		 * pages correctly when spliting the range.
+		 */
+		if (dma_addr && (dma_addr[offset + i] & SVM_RANGE_VRAM_DOMAIN))
+			dma_addr[offset + i] = 0;
+
 		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cc24f30f88fb..35ee9e648cca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
-	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -980,9 +979,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc && new->vram_pages) {
 		old->vram_pages -= new->vram_pages;
-
+		new->actual_loc = old->actual_loc;
+		if (!old->vram_pages)
+			old->actual_loc = 0;
+	}
+	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
+		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
 	return 0;
 }
 
@@ -1002,13 +1006,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 		new->offset = old->offset + npages;
 	}
 
-	new->svm_bo = svm_range_bo_ref(old->svm_bo);
-	new->ttm_res = old->ttm_res;
-
-	spin_lock(&new->svm_bo->list_lock);
-	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
-	spin_unlock(&new->svm_bo->list_lock);
+	if (new->vram_pages) {
+		new->svm_bo = svm_range_bo_ref(old->svm_bo);
+		new->ttm_res = old->ttm_res;
 
+		spin_lock(&new->svm_bo->list_lock);
+		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
+		spin_unlock(&new->svm_bo->list_lock);
+	}
 	return 0;
 }
 
@@ -1058,7 +1063,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
-- 
2.35.1

