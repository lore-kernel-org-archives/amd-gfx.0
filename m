Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 00:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BD0611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 00:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60BD0611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4B26EA38;
	Fri, 17 Sep 2021 00:51:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166AB6EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 00:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgANbYNUwyx+N8DEmRUAAAEn5th3i9qbUlONQU5SjvQyAaXb5qWL/11t2JToDkJQ0u975fQ2cOB5rmT65NsbgQe6zH3muNtFdJ1nmu7lYEVS3zv92KhO/thNE7EpkzbHAtRhQ6J+ex0SuvssVtLzSL9P1b6a6OnHFQueym+ylX2BQoRfPEM7XeYuYKZYdNIFZVZq9bEf+wFnAQAVzSYRq8A7PjmVFXrpq9o0XG3bEu+HjH0XM1ellWdqLOgZ7gWNb0JlR1rPO/pSVmuWIfuZmazpUSdvQkszk37Z9Rq/vQvH4E6Xa+w5fm1Jo8s3nxydpzvozUK0F8CxLNSBKdGFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tkSRSDs8b4GTZdhI5s2RubY12QnMgc+8auXL9xNeE4s=;
 b=EjEDM6R/6tEuJ8Y6d53VKx04e7WNs3y7xjMSH0fWjDwCUKBuAb1yExk3dNvN9etP5KduRDfPFz4Pp24uQfzSASAcbjx4DjH5kUAxV0dzUfzx4choNzQI1ndhl5w9hp/t1rBxbG95kZi3I/RGylKFNgTJWXu+i/yE5rkg12onVXAb+0oM5toyNtVBanlDDQd+ahCXOjsbNmEVHx6BkPULWwlRPDhWOYo9YDkHYyYjR5DhxKZ4JFcaco/Eqzp5WHdik8BwgODw9sD50CbAZ7+dPQ1z6nycM+KFgBTslheAks0aJfUbvQfM3ekcDL35jAOxeAbthurAOOkdw/eza4tA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkSRSDs8b4GTZdhI5s2RubY12QnMgc+8auXL9xNeE4s=;
 b=WdMybZdfj/x/OPzT1d7qFor+Pta9+t2g2zthJNvW7qT4p6jYAbnqwNWEj36YrZlWIaArNd7TuoCpUcVbjyGsqWMwsX7TZZH0lpEBTuO5daKbUhxYgDu87cMU3BAfNYolQ61jirdDeDShI70ovdHI1kxlyCGCC6yJOnZknOepaOE=
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by MN2PR12MB3647.namprd12.prod.outlook.com (2603:10b6:208:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 00:50:56 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::c9) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 00:50:56 +0000
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
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 00:50:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 19:50:54 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix dma mapping leaking warning
Date: Thu, 16 Sep 2021 20:50:37 -0400
Message-ID: <20210917005037.18526-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917005037.18526-1-Philip.Yang@amd.com>
References: <20210917005037.18526-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 059b163b-af7f-44ff-9dca-08d97975355c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3647:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3647A5E0A4D5FD610D9D6FBAE6DD9@MN2PR12MB3647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThkP1Nyh9pjJEYwsWYcd0V+cRaycyLtx6aremHj1oL3DzM/YZr9WCbd1Zm7cHkFQnzT7kfKHVqFY2sQWhB6Cl0dr7XAw21xptXh/LKmPA0OsnE0IKTEBuV3kyaPSs8cf6jad97IwhIuK/aVig8m5r2pX5xXV/rkXTCubQAw1NTu1AmrZoxE9psM9cD5oOsSCt7TryW12UcVfTARUGIpCnpxCTtpHToWVYS3Zr9MP+9rqocOY49cWVST82Z3Rn6ZPXNOsnbRPMqd0Cax/xdQ7F9flSfDvmXXRLCSiaQEk/pUiuTIlCfas1VmNn8TSY1gHX01zhFXijw6kFYkDR7/N+SYk54+spY8z8z1yceoEQXl9psnnGV08RzlNhRsWglxK4LboMjjxukkL/+yBPgm4YV3uzEOvjqK4GDCc0mORxL2iUg8WgTEic+HcxUUQtCwmBJ8p7qeFC+Qy5nqof2zbel4mqjBSdkPu1d0F79XjYwUckSqrbPtpeSEM4+HvccSSdoqEZg4uJTpJXsyGcQx2zn/fyk+g3qQN9NXYapaUimEmLh5P3rk78PMW41asAEa3Lkt6vU/jPykaCh4g4NvPu+ZzqsNQ74pU9cDO20mzT0kmnWUeRBHC50rGt3G4q9cVJTYSZdPs7loTHaXyDosyd/d/3EySao7bt8jedYhmgzLKjmGbJTpsUgbe/l/Or8DRz6yfOPosfExbU4W5e24SGgu3jiGfOd6+cb+efZHLmVs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(7696005)(47076005)(316002)(356005)(2906002)(6916009)(86362001)(82310400003)(83380400001)(2616005)(70206006)(70586007)(16526019)(8936002)(508600001)(36860700001)(336012)(426003)(8676002)(6666004)(26005)(5660300002)(36756003)(81166007)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 00:50:56.2593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b163b-af7f-44ff-9dca-08d97975355c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
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

For xnack off, restore work dma unmap previous system memory page, and
dma map the updated system memory page to update GPU mapping, this is
not dma mapping leaking, remove the WARN_ONCE for dma mapping leaking.

prange->dma_addr store the VRAM page pfn after the range migrated to
VRAM, should not dma unmap VRAM page when updating GPU mapping or
remove prange. Add helper svm_is_valid_dma_mapping_addr to check VRAM
page and error cases.

Keep SVM_RANGE_VRAM_DOMAIN flag in dma_addr to diff VRAM page and dma
map system page, amdgpu vm update will mask out this bit before adding
flags to update PTE.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 57318edc4020..763c74d60c8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -118,6 +118,13 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 		mmu_interval_notifier_remove(&prange->notifier);
 }
 
+static bool
+svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr && !dma_mapping_error(dev, dma_addr) &&
+	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
+}
+
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
@@ -139,8 +146,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 	addr += offset;
 	for (i = 0; i < npages; i++) {
-		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
-			      "leaking dma mapping\n"))
+		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
@@ -209,7 +215,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 		return;
 
 	for (i = offset; i < offset + npages; i++) {
-		if (!dma_addr[i] || dma_mapping_error(dev, dma_addr[i]))
+		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
@@ -1177,7 +1183,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
-		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
 
 		/* Collect all pages in the same address range and memory domain
 		 * that can be mapped with a single call to update mapping.
-- 
2.17.1

