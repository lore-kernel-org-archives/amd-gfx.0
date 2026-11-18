Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D7606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bwFxb3yw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB1B10EC09;
	Wed, 18 Nov 2026 15:10:07 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887B010EC09
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE/xN/qAEI2Op12pjdkXgIgGfTW0f3lTUjLlCDuuotMJM5hLdtpNdZakzlFDpgtZn+ss9BQq0O9+cdgnSGyQafrcnZMgzfziD6AN7a90AzEiQ7Y+sijbN1dAKz+oPZogwSv7wglPSfm0x4936kw0mASdsMe9ROr6BFbDj2GGh2pAUt87m6jh2Gt1fzxEtxV+ioaLVoTM48cKyy3srahIzbkw08CwSfvx/YbZ/MQN6nPMw/DUgHeQmQqor/O0VSwZlCbWxPbv5kyPG5s3Jq+7PDfRb8si0HPhEtjJBzI7f9TZyPYluZdlLABf/l9G+TjNAKUnrhDOueKWCY5podlfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwqy9Dkw8E+EtExxR87UbgPOkyzJnHG57/yLSCrUpL0=;
 b=X0pP80rm6vltjVuqgQzmzD2VFjVqRIoarwkape5+6O4IOXRFtrGmVDH1aWrqvEYmkPyUTLFhu0/JJJY3UyfaihNidshmV3CSbleDqpMUTpFlMQP3BeiHw7ISHibHfcm8xU1rnbF3svAtIUQXKmzvV4W1wy6bJjT2qZ94htAqqTGsNNmT/kB2iQGVa4GW69mIgunoaexPS0yS31cU2OQvKfW3lw+okZ41aFL4Oq+DfDWwFbjoLyIY5QpUVw8zSMRPz+lJg/7NbfuCHfH/2nPGR2kxwZWPbyJvw/8mKHu6PudKWETTaQW+k47Q6VYcSlXQMx8iC1ARxrfA5GvigGbDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwqy9Dkw8E+EtExxR87UbgPOkyzJnHG57/yLSCrUpL0=;
 b=bwFxb3ywMjaG0KYgP8Ofy4wcY360n6hYn+AOPI16pMn02n39Z4hM2dFl4SBAtQ+ddceUXSOTjU9rBeexvY6bar/k9n2wVHfdqNBhmorYMzzdI7gQyOu/R3DFFuVJtHPaYKNg84pDURf67vjbzCCraZfIFHzuGQcIor7SjwDMX20=
Received: from CH0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:610:cc::30)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:09:56 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4c) by CH0PR03CA0085.outlook.office365.com
 (2603:10b6:610:cc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:09:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:09:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:09:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:09:54 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 09:09:54 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev and
 migrate_vma_finalize
Date: Wed, 18 Nov 2026 09:10:45 -0600
Message-ID: <20261118151045.134908-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118151045.134908-1-xiaogang.chen@amd.com>
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f6a27c-2eca-49c9-1c94-08df4586011a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261102123227099003|261022075727099003|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5A0sF85vOhajd/TCE8EaRWpvK35k5xbNp2gocm3yla/o1xQJyiLGMEMSQ8M0q92UmzttFNeq49h7x7eg9uoh9pYRnC0DsbT/8H7zrp1zhb1/Y3HgN4seOfB/GpZ/Wo3rWwYo8yns4vUNRB/mNYQAgfjhQiyT1wHaHw5yXGNR1XZk9+ME3L1QPUlnu2hP6uXUnPPtuLKqYCU7pdGuK1zJ3Fj9SvL6CWItJWULsivOLRg5ko84WVQJK0XxUyPR6GsBxrjXoH+VMszmagOoQVKwY1GWalST91vF/SqAckaXGT6CP/pKo3lzcl/7H21NjF/1yc5vNKQDDvqISv4JedRy1TWfv7p4XJ3Ylc48EaJzHNQCk58n4VrA1nc/MMYTTUcdE6yBkFWMlljyEaxDMI4uZOHMb+QrLYrAh3e5W4S9IRHLXGOs2HTJgDhLX/hrmP+QLkspViQRbzeMPGd9qgK4/vEuBEMEcC3Np9P/Yj98zbfOQb7C90nGKVSAD0Y+R5oT8PneXR9MjB8iDUc3crWDhPIvkbVbJpPF6sMN9Cnm5s2q4M4MtFbucyv3H44Uycls6vNKvVhrpsCaq3AFXu+6VQt4F6wZowDZtwLfiWnG0yQJYZC7Z0KdP31kN1n1n1nz7rlyYJ+7iMo5G6yDE6aBW0awGnXzbQ6GozoEU8yzlbF9oehHK2cesmJSndM+gRyKJHSLXaWmI5IPYyObsDyMzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261102123227099003)(261022075727099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vVBOGg4LnV51HB2S6zu8ZNi3I5d/cj3Z2dpRDDsLVjIqZ2yMkb9umHA4OmqIBiU4PmN2tTjjIr1BiJdcgNqizmrlAh5JVEHc4nI8HLnRFRV6GSu2i2Tbc/YIa2jTxu5KOq2m9bpnfxzJvR2vkyknxhr7PLbXBjOu+USEgvRdTxkREdNXeMHqbL6QtQDYcK094I64eY8jX7Ic8RHIwlnQQShbT/mgPz1lHpgI40iZf1NdSicwYq4n9NInSlryJrmD3NVAfQXgvFFIpGWFXtYvFFx3Y8/1Cj2lNzmQi6LkE13e08iMwGMOxmDNHcZ+k/KhZVbYxn8uKd7NTU+vlFBJbudWUpLCn+n5mMjOhtNNXjIgpqQKHQkP8+jdD/x7Vuy7A1wtnJED3n6H0l11Aly6w4D4cSPFKjUEx90bHF+/3zQY8HMEMoJlx0Sv0jtM333Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:09:55.5752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6a27c-2eca-49c9-1c94-08df4586011a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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
the bounce buffer back into the original page, and by then the page may belong
to someone else. With an IOMMU, the IOVA stays valid for a short window after
the page is freed. During the window GPU may write into the pages that may
belong to someone else.

So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
direction to make dma unmap happen before sys ram pages got released.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 78a2aab81c17..4bcdedd91d2e 100644
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
@@ -838,9 +837,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		 mpages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
-	migrate_vma_finalize(&migrate);
-
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
+	migrate_vma_finalize(&migrate);
 
 out_free:
 	kvfree(buf);
-- 
2.34.1

