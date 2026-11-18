Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AC606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QClr/Vp6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70DD10ECE0;
	Wed, 18 Nov 2026 22:57:51 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B01110ECE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD/D3gNMZtvloFYE56B/fyrVBUGov9S2NNZSwTiGMh1xsu/uE3Kj+BYo3LyS1ZE0ETneDgduU9d2hIKkibiaglxlxDdHHB281ru22Z2wGKvDIb6q2cTiz/LuFh2dNRSED8S0+Y+any9Mt+6gh3bQPDTd2X6hEhrzpQW4VZ4EtkjoDK5tFOWpXZTwWM0fkLhcMqV2osKu9zyDqhyFGNkHIV8hqeeb5b4nObqO9kt88/iv9r3mB3csPvWIwYtWwwcSnbsxK9+0KGryJvy2wIguNGAuQhRxRu5ByCDrK8LMdavoENrv8xwKjPGlQ6Abt98+uGrsrZHxtbGAVvRzAP2B0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9beOhzBgXCdcGqUDFSQyKNvPZqqsOTuTutm2dIfv2E=;
 b=P5AD1C1DCRUdDUJ+Uc16mRFHYni64wVpLQQRdh7AhRIJP5XNfattehS2CtXGcDdERNTBRPYdA5Q21F074nodBcq86363XrTuYhEPVG3CWpZcNi272aZDQL4eJOnxbTpKA5HxsIVMC3FV+mGL4SWAPybR14TiViFZ1Dt2tGXgUgk3u/Wcr65v3jMnq64Ci8VgROJbLuFW5Te3J90US9hUPx7pKRTv1Yeq/78sXDuoXO6oNtQ8B8Pwy+RRFCabCq0yN1Q845zb45pZtx3lrlJL7zeJ5Iur+KJ+wmMQXcKaHfC3Me7Yqnb8iItkFsmHd7tJ40dW/lYdyTgP5I2lGXDtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9beOhzBgXCdcGqUDFSQyKNvPZqqsOTuTutm2dIfv2E=;
 b=QClr/Vp6NdWmAjkq8u0+PkKY5gfCKw8xPzHk4XmNkzR7Gy83QFM688sx4PVF0WVcmR9UPBh9pnjWpuFa1nb1ZLjSkrJc0vXqSEEtIXHI0u8RFBOLLIT9eCpVBVBuQmolZ9bdoj29Ru3ENM0NPggXoXed813HHBQiWtS0Vz+FfhY=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 22:57:39 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:5:1e0:cafe::94) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 22:57:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 18 Nov 2026 22:57:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:57:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:57:33 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 16:57:33 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev and
 migrate_vma_finalize
Date: Wed, 18 Nov 2026 16:58:34 -0600
Message-ID: <20261118225834.60743-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118225834.60743-1-xiaogang.chen@amd.com>
References: <20261118225834.60743-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: fd13907e-7245-488c-3e4c-08df45c755d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|261026121527099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261009223027099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: qRo1afx8YNZZvrC/B64CH8e/w4tnSiMiGh+a/HZ+XpLwuDZ/JA4QfLs0cviWx7kQwoWF7RllGao2lWrio4PJ5ptZCxf9SNaIir67Vphx64xLpXcuaVV1gndwIjR4dgslC5A1OBDbLMtOTLdo+gYYhNBIDkYYHIshUi2+SHh10rKd978jsjlpy0Izdm0ZdlvT95VB5sJ9X1kCE42q4wMwksztQx/YhsmFcxuAmPHD0uNHWAllWKby1txlnzsvgRP8qSOQQpzMe1asvR83zGlLslWru5/KvHSmBSNRxBf5WXgcWJYHIvLhZfvnJ3WGOLsHO7bnP/sWUTwO/mggRqXvyA4N3ggi/HqWfhlzfGrGxsu7LnJwUMAkW2uTYWQQ+zO8T56zldBTA9beoLNnwZ+8vwMM9bayZ9jdG0BsovIqs+3LYkbranCcGPSTS4sXiwtvvOAXiuGnJEkhqQ9eO6XNyxtxkT5r/SxOv93LXqY3Hu7YI/Y3WiYM3pqSsP19t5M1IV3ZN//SFrjR6s7KTIvz1+CCjTJEteExoiucJi5VgPM9BUaeCKEmfdJx2Tmvi2hVMRkCsaT42xZeU9d9Y/qGdl+upEDnHr2Fb64nwwlQw+f9azoH37pXnIw8+7FAU5k123g3mk2bJSxzxyw7WjA5ZVlvbuNWWX2NeVBNSG74PGsFEZgVbDgJjH5b6VALaOhN31eKyYtPQykCghhcCwMXhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261009223027099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TEbxYMDQ1T9KfCH4WZw9OuqMTNuN4Ht/ZvF/rWB8e8MFcC6FUEbE7OK0E/OKXGXbQMNwE5pu+iKtHn6Rdpce47WY4rHnvN6P/B3fvgL53Gc+YzLk4YtJ3qRIHYijj11KspZNOgiGLWCnUkEavjHpZRpYbsYObktp6r6v22rVhYoo6T0L8okiJHomNdcbYyWNJOQuF2OZm31Smc7lAL//jb2jPs3jzjjyUrMV2GX12fcdkYPN1jePwoQMMqKKbx7ll79xC5/3KLvL9/u7DzeAcqNaYzxhuZ5KUVbIVJUr3OEme+BId3kIDRPE9lZu9sLFYnWKMMQ5TAoV8BYXtojvsLABTSnFDU5M5hF6sh2iKMbGg7ozUd2d23K+Y6MTgj5HANVI3Daphuq1pZW+RKtOXWuC2uGmroS3z+rI8SgSwvP3i95VPNOzvizXFrcUIpjo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:57:34.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd13907e-7245-488c-3e4c-08df45c755d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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

svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the old
system-RAM source pages. Only after that they are DMA-unmapped.

svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees the
newly allocated dpages, and the unmap comes afterwards.

Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap copies
the bounce buffer back into the original page, and by wthen the page may belong
to someone else. With an IOMMU, the IOVA stays valid for a short window after
the page is freed. During the window GPU may write into the pages that may
belong to someone else.

So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
direction to make dma unmap happen before sys ram pages got released.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 9254d64588f0..6f1e2a68b3c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	migrate_vma_pages(&migrate);
 
 	svm_migrate_copy_done(adev, mfence);
+	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 	migrate_vma_finalize(&migrate);
 
 	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		 mpages, cpages, migrate.npages);
 
-	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
-
 out_free:
 	kvfree(buf);
 	kfd_smi_event_migration_end(node, p->lead_thread,
@@ -835,12 +834,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		 mpages, cpages, migrate.npages);
-	if (!r)
-		svm_migrate_copy_done(adev, mfence);
-	migrate_vma_finalize(&migrate);
 
-	if (!r)
+	if (!r) {
+		svm_migrate_copy_done(adev, mfence);
 		svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
+	}
+	migrate_vma_finalize(&migrate);
 
 out_free:
 	kvfree(buf);
-- 
2.34.1

