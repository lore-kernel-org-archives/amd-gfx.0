Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 13:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0940410E104;
	Fri,  3 Jun 2022 13:59:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A47A10E20E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 13:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRg3RENQmX/aGQDpU9fmY1tG4OW9m2rn6wBT5mNj46NW6JXC0ns9NelRW/B2/9RMhoJvJQSOgsGLMR95JAHvBJvYoajItOU+lH++nREgYyHvrE3PWhofX8b20c6T+A864C0rs8MmZcKe1wEzgWSTJtZuY9m+l6qks1jkvT2efwsphF7OtmVZcvsxe7SMYjH0ZF4RYiugr2HK9yhcNkM0wMW1N7e8eEx1jYhsbwU+S+NKf6Z4oKdNmwn1ZGeNd85LB90FwF+q85wYG7+K9CHViPJsX/yd9ONEV8H83bmmvcJ4aG+Qm4nMOTqbDv5goNabsU0e1Wud9UY+dSXRzw2RHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKmh6PJhL9nnNnKXThixR3A/rE7kUfX5tW6BBtTVYb0=;
 b=VPLIjZYjTqRHn4qrQxLoFUROjn8HnvM0L/aDAtk/45UcJ2bwlAsJ0w5YLRHBvgcODbBzz2EG04P4BWHyscaYto3fW9xsKSVKrKizZ6RmiWzeP5+OwHgbjau/xk1kG5Hb5LAFpex00vjhhnoigcqyCJq2MgmtRr9gLEdr/VR23GGS5Z/MjE5VZRORFWli8jY8o6XqozhhnNkheDVNJIM4omLwtpr2v21a9eB/IWTorHbmaMEuk8H9l+Q7+6zvkRvtGxpptzPQ0sV2JVoXBjh1oS1U/24qF+onCPzqTc8Ke0U2sRDfQkakqaUpWC3BuDud5hWJm3pYIHpfnJRsGC/dCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKmh6PJhL9nnNnKXThixR3A/rE7kUfX5tW6BBtTVYb0=;
 b=dyLaHPAK0dJ4Fhqe0ul6Vh2RmHaUj+ghM/joqCOlYCZqPFdeBiDLzxkdBSrZ7upIAdncte8GKmcR54DtkigtoMDxZFW+XvdSj92bbyR74YdhvsBCglSl0hd4X1cGwmGOwihCTVVDqsHOp0Ls+B4zFcr5PU1IGkru02RGTulyvHM=
Received: from MWHPR02CA0019.namprd02.prod.outlook.com (2603:10b6:300:4b::29)
 by DM6PR12MB2745.namprd12.prod.outlook.com (2603:10b6:5:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Fri, 3 Jun
 2022 13:59:28 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::a6) by MWHPR02CA0019.outlook.office365.com
 (2603:10b6:300:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 13:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 13:59:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 08:59:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Fix partial migration bugs
Date: Fri, 3 Jun 2022 09:59:06 -0400
Message-ID: <20220603135906.20912-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d46975-d046-48b9-0989-08da45694647
X-MS-TrafficTypeDiagnostic: DM6PR12MB2745:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB274561FE2E682566F32EF3C2E6A19@DM6PR12MB2745.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNK284cNG+vvr1HS1GOa361QDDkxkGgE5cvEPgE6rdwF5Mwx3/88EAsppw1m/KwjoEtwr5bH5EM9ryf4+Zfpe9Ze9gy0Vcj25FCZVPYeYn5+Mc8Z3g8jnNWpQ16xqLdth+8Wa472j7ZO7yO/aHuLkzk4IGNkBQKhZdfcoJKUJMFk6BOeyGL13Mc3iowjw5yzd3Q/jhgIa6l17Qo4TthXTnfMyHsUWFNt+valj7ij2vf0c0pejIFs4oCHzFTpdHMHgMBVObF050ThMEAq2m7r0c360k5w0SABryZOY5IKYk7Nf4H8B2oodofqrsWclABJjFVGx15usdk4YsdqZCT2UQo2tBbyUUbi7VTlT2B+gTZF87WbaS3WquKxvOlS6fYvnmMdDbL8yI5j0ZpQogawSdYlaaLzUQ2U0/X3HId7cmr5lLN84GWuivsPWxvX5QfovFndV0RcBxF11VpNANCMCXu3lGsK0OiMoXv3v1ys1FOaLJWmNrwjnBk/JtA1oXsz3jBnFPyk0BAOc/MEjMXBn3bZPcgSMpo5d7qD0BtdjVpz6Y35XcI1OVIjSIfu3j7xMKuP0O4qrfsacgtQNYruN7XSpAsCagzO3ASqqZTE9x0PYMtAaWss452WHdeHw+YoE+bUZwyVpJnTvK8rOq+7b0ZH/CfUR+b6HXYnN1La1Xv3NrDQQRiboo2XUBSRUkWGBvobCeNq1Tpkc7S096l/sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(356005)(86362001)(54906003)(6916009)(2616005)(26005)(47076005)(336012)(8936002)(40460700003)(426003)(2906002)(16526019)(6666004)(7696005)(83380400001)(186003)(8676002)(70206006)(81166007)(1076003)(508600001)(316002)(5660300002)(36860700001)(36756003)(82310400005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 13:59:27.7414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d46975-d046-48b9-0989-08da45694647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Migration range from system memory to VRAM, if system page can not be
locked or unmapped, we do partial migration and leave some pages in
system memory. Several bugs found to copy pages and update GPU mapping
for this situation:

1. copy to vram should use migrate->npage which is total pages of range
as npages, not migrate->cpages which is number of pages can be migrated.

2. After partial copy, set VRAM res cursor as j + 1, j is number of
system pages copied plus 1 page to skip copy.

3. copy to ram, should collect all continuous VRAM pages and copy
together.

4. Call amdgpu_vm_update_range, should pass in offset as bytes, not
as number of pages.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 43cd47723946..d03135a1f7e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -296,7 +296,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch)
 {
-	uint64_t npages = migrate->cpages;
+	uint64_t npages = migrate->npages;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
 	dma_addr_t *src;
@@ -344,7 +344,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&cursor, j << PAGE_SHIFT);
+				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
 				j = 0;
 			} else {
 				amdgpu_res_next(&cursor, PAGE_SIZE);
@@ -590,7 +590,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
-		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE) {
+		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE && j) {
 			r = svm_migrate_copy_memory_gart(adev, dst + i - j,
 							 src + i - j, j,
 							 FROM_VRAM_TO_RAM,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2ba3de0fb8aa..d6fc00d51c8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1295,7 +1295,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
 					   last_start, prange->start + i,
 					   pte_flags,
-					   last_start - prange->start,
+					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
 					   NULL, dma_addr, &vm->last_update);
 
-- 
2.35.1

