Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C3606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lFVzrK9i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157B410F2D1;
	Wed, 18 Nov 2026 15:10:12 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2820D10F2D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXuC4jWPBujjRFdPDtzYVm8OzNGw4b3H61PIBO+YpLe6Or3FiLFk1P0g+5+4v6Q9TaUrXUp9U2Gc3nn49RKrioUV2vSCdBo/MT2Qs0xcoS4GoiT4bxdf/w3MrJ7c+YBIOu/HOreQgTy+zh2G7ybSgzYo/RaWufLMBEdvmflbz9amGr1cwMfarchfIKarVWULqVDXn6V6WDvzcXNi4yi9EqCHqzVy8i6oBzyVLKPpwLwKfxqSNyD7kwwuzebXvScosi/oJld2ewy0P7EQkMwuE0C3aZdivwBXc4QRyfijKIVdkDi9ktuYfwOmSQ3IDUktigKNIyOWPK2thkcl0IXgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYQXtLojRIuJ4whrOvi2yhNB3OFdexUHsTz+wDJrDWI=;
 b=VKzsX622atXkCkO8hMuHHbEAQPsSfg56hRuvjd2aQNdeudB8xE2eB5wXqm2qlsqpRZGd5iRnk+8ZIkvI33bWdsGIhalU4VsUGdUigpTXj2NJHM8mtexLxUt32L0NS9w9ubId4uFsXyVjVj4MwUct24x353iHZBjuqaiHEAej/liy0zNXds7Fyp2RcVgZ0sRToobLihhhVwA2MGNBDIp+g/V/A+vxrY03r1WdcuKVaaA+/4/eKUQZ92tGykCT+dm9F4rSY5NZ9MvYhWLQbl8UOjzybFeJzazV8926Aht+akCcs+2w6eH108IafcjVdEJKysimTR/QuiAoGv7St+qneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYQXtLojRIuJ4whrOvi2yhNB3OFdexUHsTz+wDJrDWI=;
 b=lFVzrK9iA4Grqe6OKTTMyISI3PrTkliQ16ro9/UA4U8fsDu0HllLqmOcGevPqVssTY1OtGbIE3+qy+4g51eWWXtk45Sk1sI1ouJ/l1GcXOS8bHMtEjkiTvy22dh5oPbNMoVcZ/xexhoIwfHxl8hIvWOTGDBXDeyK2B/dSFxgfPk=
Received: from DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::17) by
 MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:09:56 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:8:25a:cafe::a8) by DS7P220CA0093.outlook.office365.com
 (2603:10b6:8:25a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:09:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 15:09:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:09:54 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 09:09:54 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram()
 error path
Date: Wed, 18 Nov 2026 09:10:44 -0600
Message-ID: <20261118151045.134908-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: d463acff-6408-473e-05b8-08df4586009a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|261009223027099003|11063799006|261026140227099003|56012099006|261026121527099003|10067099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ociyTl41bGBlalcLdXN23ugBDyNu19WBtHwr2KEJHsCLre/ix6PX9aY6qxAEfLtYkwT7GFRXXhMjdkhQ/SupN6ueKtHBIvbwCSrfps+MjxZjr5u3WUJmuxqmVJHBhCPJS5IgPjgugkCL9HL6JRSJNGKGuKTXfisI2FoFZqjShREiDkR+3VpVGOKkxDN1NTT+Z/UV4JEqTY+vXUAOexjz7ANNymlsi1brLKcygZkFbFyVE+TQm5GB6yNhI4XCGMvaJUXQ89TnWVkKnkdr1XB50HVy9lxtI6dn8bizC8PbhH7GTMlI3pmj4eUWP7xRnGrGSjOpgk6bSOUf72tTtBIlqyfPOmztqfcCICH6jy/llFh6I04IpKNi9v3sJbsUaoAkYoNAwAVqRY4SiPK3qJwAD2szWupzHzDXeaM0RQYeP2dEQ79wgZU8CNZ5oYYI0tZAtTeqqvjlhnD82X4SeCejm+AYGMB4YhMF8C70u8odTNSYIW1f5xKy/r81nvFMjLjlxvkECvfLgQ8ZbMpVlJt8Bn4A4k9k8pnVk9YpMhzyMgPuhRmRVG/hkmvcd1LXbifx0c1ags05ZBU2qZ7plSpbZfN7Ikg7hyTycSG2Lk62lLrIRfyvxUYB1PUDd9YXgkTh7ILnFk0VasO8rKsle6BTkhSW1EjCqS90Y92K8jvh/o7b9NFs1vIIVJAoH06N2MOS3pZ2mzGYKNCJyKIFHqeUHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(261009223027099003)(11063799006)(261026140227099003)(56012099006)(261026121527099003)(10067099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UzVGz0bFH9hHnEpLfzyklGxu0uj6idZYCZmWLULK8VQa5t/H5onT4oMTdvw0rQSk9FynQa+hCyIhoRth55faVXlAbv5frVQQ9KQdbJRlyZmhEjRQuXI7gMBgRAwlF6GhAinJAw7105r9AWJkX9rfi36lotnDZ7y+42lTspCOVvWQSYpwz4pVxZIZr5fhSMelhcd5wCeNUJseEKATLUHdF/lnbCt40Jvnje6ipPW84zZCm9BYemDBSxPieCbLZYMSl0d5v6xNYkLYBrQa5uDtXehHng/MtJY0T2tL6TI1z8El152u+d605dF7jPvftBrGOTBPttGyMxo3k6fmJu9zl0kBeoV7KOzIsgUs73uDXY3TsKb1IkbToZWe4JCVNxE2VFX/DUBxs5DkA9kPxJHVgphw+L3GY5nhwdkdfVegw/II0s+vyugurRVm9n1rch7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:09:54.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d463acff-6408-473e-05b8-08df4586009a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xiaogang Chen <xiaogang.chen@amd.com>

The destination pages were freed while SDMA copies queued earlier
could still be writing into them, and while they were still DMA
mapped. The mappings were only removed later by the caller's
svm_range_dma_unmap_dev().

With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
a page that may already be reused.

With an IOMM, the GPU still has a valid bus address that points at a page
now maybe owned by another user. Any SDMA write still in flight, corrupts
that page.

So, wait on the fence first, then dma unmap before release buffer.

svm_range_dma_unmap_dev() sets each entry to 0 after unmapping it,
so the caller's later svm_range_dma_unmap_dev call skips them.

Not drop the fence there. *mfence still belongs to the caller. Later
svm_migrate_copy_done() puts it and second wait there returns immediately.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..78a2aab81c17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -716,6 +716,18 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			put_page(dpage);
 		}
 
+		/*
+		 * Copies queued before the failure may still be writing into
+		 * the destination pages. Wait for the last SDMA fence (copies
+		 * on the entity complete in order), then remove the device DMA
+		 * mappings, before the pages go back to the allocator. The
+		 * caller's svm_migrate_copy_done() still puts the fence, and
+		 * its svm_range_dma_unmap_dev() skips the entries zeroed here.
+		 */
+		if (*mfence)
+			dma_fence_wait(*mfence, false);
+		svm_range_dma_unmap_dev(dev, dst, 0, npages);
+
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
-- 
2.34.1

