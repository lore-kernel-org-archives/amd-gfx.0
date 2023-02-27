Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E4C64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 23:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B76610E225;
	Mon, 27 Feb 2023 23:09:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1B510E1F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 23:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3lWUUPOq3tIZwIfq4XfxV+KBexH2XmXEJSx1KaSUR11bHkE8niPEZmyYet3nr0MP2WEaB6+grmp22mJgDZ9oC2McOlxnwP3lH0HsjqwQ8p/BQF95FfpklIPzsribkjw6gWA5UCAnaz33J7hf8Ud8tnKZTZ629+JGXn+9WW0PdYFUsdwlZjOZ+kpQcWtniIbDXUm05pGF4+KWFZ9HZord/pv3jjWVq7f/N9+JuJqvsUCDMsi8IUySvpAp7gEOuCBLx66IRuH2pBOCeV7ke+v5AhWwuoK312dp2KLwqMHe9fkAczZwjVOrDE3pbfmcADAP+3OyFdJZtIQ7zlNVDcdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsjajFqMAKmNUDaujeM4kUFVugPFpnE7hg6QVQ3aakM=;
 b=nJhRd+uJ55CeMJiE4PUQl1Gq+cunwXo5fhxLGTLO4p8K0p33yxfxJf1rfAqprpOnGx7OaVSWHlEF699u3brfTK9FDR+/wMPbHA5ic4U2tpC9CerIy3N/ZBIGYwUHibaiuYypSH9naluvhgh/h+gBN9ymxAzjaGqvDTttpiMdNYdOWBrTFqXfZc2veB1CYeswBJZxEjnJLCAt1mTG1t+kqc6cEz2YsjKPsRuEt4UgaYmwWFH1QHgHYA/DHyqG+u6kYhAuGZIQdZdx+rsgeZ18PvrouHuyZWZvmWw0rKgpgRBsIXcGMrsYGXWcE1pZ5x7do9+71RpgF0drfKvwmtD7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsjajFqMAKmNUDaujeM4kUFVugPFpnE7hg6QVQ3aakM=;
 b=2E4MC7tXQpgCz2l0t4hpeSsx4J1VIs6tB+HqNwcm48szg7SfVxzkjHwdN7fbMDiEG9uQPslFeSLKETn5kKOsu15jYCOK+annbTo8FReJsc0gbFwIozk22aUzZs212WBV7G0LBqE/nc0hAX2Tz8pGLsFKKcvylVz0JSmttv2Yzts=
Received: from BN9PR03CA0280.namprd03.prod.outlook.com (2603:10b6:408:f5::15)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 23:09:53 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::85) by BN9PR03CA0280.outlook.office365.com
 (2603:10b6:408:f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 23:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 23:09:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 17:09:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 17:09:52 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 17:09:46 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Cal vram offset in page for each
 svm_migrate_copy_to_vram
Date: Mon, 27 Feb 2023 17:07:12 -0600
Message-ID: <20230227230712.1145501-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6bde5c-780c-40db-17b1-08db1917bbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0y73KiTG7W/YLU/LxVyKmqlTQh/LThNNJZteSSiU5iN7E0VEOGBQP2WyHM370+9ZUnUsqtfl3Jb3lWF+A9Ti+ZQutOc2voivKW+y2cjYz433/ofFLdigswHfruh+q70HndoxQft9vJ8xFcj1OhQQwFjn9v3AsQUitBdWnpcGeCAMqTy8E+/x36W10f60SvT6h0kId3ovfZ90BxnW9UFWI7VFspFQYOGJkR/tYfkoaG9519xmFWP1H1CnzGIWJEN9pX1jufgwXsV+5H/d4uF8NJGsJ6bTgsLUbmlV2JqRSY0rUi3V7IKVxqWKKYRj8d80xwM53a1Rk4KBMUsnrDWNIkgWGtgjR/B8f5gk2qZY8Q41/B3nR2FbKwY/QsG5NhF0dRbDLOmMAiCIV06TyEhanqV9lPz67mvfRR+94ugN7Mz/AkCLi1vFuf1s2fA84Cd5YTRcxlAYcTCkeEshqxPgcZ6Uj+Nw/RGvWAoQMsfibbUzbwoIM6pJzQ++85eLB+88dbuy7ZWRTkhrp2quL4jm0lgNKUBE+bDP2DOfeu0IWHgkAL00j5uKWAQnYDhHRWV1VKtyKEByRlQlKGNeHiVyIjdZfLiuKiA4/pmu0g+P9HXOoJDzBbjbG86epvCDDgk7FqMq4z4BCuo2Ua7U2ChuWYq5USLKtNbVX3ddAmwyOXIKqWwdNBRQWsGK5difcgIi46HERYyCHo0AevWcuTWKPNRKygRu0Vcv+Q6/aqOQSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(186003)(81166007)(82740400003)(83380400001)(316002)(356005)(6916009)(70206006)(4326008)(8676002)(41300700001)(5660300002)(336012)(2906002)(8936002)(36860700001)(426003)(70586007)(1076003)(40480700001)(6666004)(7696005)(26005)(478600001)(47076005)(2616005)(86362001)(54906003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:09:52.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6bde5c-780c-40db-17b1-08db1917bbd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, philip.yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

svm_migrate_ram_to_vram migrate a prange from sys ram to vram. The prange may
cross multiple vma. Need remember current dst vram offset in page for each migration.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1c625433ff30..60664e0cbc1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -294,7 +294,7 @@ static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 static int
 svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
-			 dma_addr_t *scratch)
+			 dma_addr_t *scratch, uint64_t *cur_dst)
 {
 	uint64_t npages = migrate->npages;
 	struct device *dev = adev->dev;
@@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t i, j;
 	int r;
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
-		 prange->last);
+	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
+		 prange->last, *cur_dst);
 
 	src = scratch;
 	dst = (uint64_t *)(scratch + npages);
@@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out;
 	}
 
-	amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
+	amdgpu_res_first(prange->ttm_res, *cur_dst << PAGE_SHIFT,
 			 npages << PAGE_SHIFT, &cursor);
 	for (i = j = 0; i < npages; i++) {
 		struct page *spage;
@@ -381,6 +381,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			migrate->dst[i] = 0;
 		}
 	}
+	*cur_dst = *cur_dst + i;
 
 #ifdef DEBUG_FORCE_MIXED_DOMAINS
 	for (i = 0, j = 0; i < npages; i += 4, j++) {
@@ -403,7 +404,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end, uint32_t trigger)
+			uint64_t end, uint32_t trigger, uint64_t *cur_dst)
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
@@ -456,7 +457,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages migrated\n", cpages);
 
-	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
+	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch, cur_dst);
 	migrate_vma_pages(&migrate);
 
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
@@ -504,6 +505,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
 	struct amdgpu_device *adev;
+	uint64_t cur_dst;
 	unsigned long cpages = 0;
 	long r = 0;
 
@@ -524,6 +526,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
+	cur_dst = prange->offset;
 
 	for (addr = start; addr < end;) {
 		unsigned long next;
@@ -533,7 +536,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger, &cur_dst);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
-- 
2.25.1

