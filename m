Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C0D1CA15
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 02:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C383C10E069;
	Tue,  5 Nov 2024 02:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aWUhmMYd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41E610E069
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 02:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDQAs0YitOXjFv7asXbG62Sz5/n7jgPcx5gphWlAUvFVsgjst+f7NJTB6HqbIcPw+QbJKeb0NoGBxfqOc84BRz1A7ybCyzDnfuAE7VDzAiNIqw6xCXWEqSTdovsQ78mrfRttjmQH7xr7RHxlXhT4LvvlZbCoZ2mhCtvusKS4YG61rW2xsRBHCQ0AZAa6yaKHsv5U3FulbImDDiD2sF2QRi+EVJG3c5vzT04rCTNQM0W3BCf0as4+aFXMmhx8KI/s1Gya9DE/ns4dzNwioEuDXQPTcGHGSwIiAdKHvQxgE0MUWPLwnCSguB2wBRpK+M2a0eiCnJRPNbaOqLvIbueNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OD9Al4X1PrwCLwfvEzN6eGpR4uGq40dPXFgB3zogro=;
 b=jjw/jQUFaEpzU2LGA4cY5ZLBB54o/6KXZXyj3FFIbVTFHVa3biIu2aNeUaECVImMCwimIa1CPOXv5V3g6/xiGUy6FCXGhhuD8H7D1XLdSVEBri/9tvUo1pl9EGeDP3rV/RUsmsk98fo/13UiJ0RLfkg/WD0jR7QgaOONJsVEyclM+6hq/8YBain2xKzHANYUa+UaZ7YrxYnuOp8qKr5e1lPmQeVFeuAwc1vUOaAzddNENZ964kdHPwRix0rIwWD7u28GZkDQKmR+bQm7+P2Htlcu3YCuUnNh8IaSxwiPLL2v51c32HeKVvMK43fPP9dUhqwO9qBp3c/ml7bya2s6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OD9Al4X1PrwCLwfvEzN6eGpR4uGq40dPXFgB3zogro=;
 b=aWUhmMYdqGZtiMgqsWQQHgxHXqAbKRYqbLrVRuUgD5rI3X65fyZkNzuel7jDRBG0KZMzxNQpCRybjFjdic3Hyi+uypRWtjcnvyNUYBqepuGsL12vEu8PwcgvP0tJ1oD0h/Uda3jBSaa7TNOYwKPoSwbPp0Fy/zFME12fUNhI3k4=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:33:50 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::3b) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 02:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 02:33:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 20:33:45 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Harish.Kasiviswanathan@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
Date: Tue, 5 Nov 2024 10:33:32 +0800
Message-ID: <20241105023332.172404-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acd9f25-a252-403a-20a0-08dcfd424800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W6X+P1V77Fk/C/ZZxqA52DEQApxb7fAqeGM19U3Zu/NnkVh1UJv38L8YtATB?=
 =?us-ascii?Q?xKMoVHNv/oA1c4T6afe0ogOARyd5xBn84HL6bSOgzpClzlSP0rSKoZW54Hvt?=
 =?us-ascii?Q?beC4SmCN45hZnndI6FIJkBV9vySvyeaU9ysc1QbjKQne2RGRS/3Gbyv+gb8N?=
 =?us-ascii?Q?HqkiJbSRKR+kU+gGKB8ICdkPmgaQcpSJdJDPp9DPXq1b0yFijnM9k2Pc4tiC?=
 =?us-ascii?Q?aRT2y+9o33GOsBTN8oAkb/CNwEgeIVvPFkOzYFeoxaKRZVFb7s4A/SqBvBN1?=
 =?us-ascii?Q?bNkOFtSjko2lLOgUTpJ5gNvsb+FqoLF4jG6Smh6btfb0Ma/E8BqKgqMsfoT/?=
 =?us-ascii?Q?9cI0MzAC2MA+7OJaJ5Ai/tN4vkmrDz7R1CX9h70rybZylilxFfQ2VjzH07AL?=
 =?us-ascii?Q?SlZCtX3yYIFjSTHBOvcT5RzZWIFa2Jn+y6yTWUObRvA+s7GUWvYwIWs7hqK9?=
 =?us-ascii?Q?75V7s/lgzgM2BiGN1u7Mwe4IVrIajP+3ERpR/tgjguBNGpxpFLV2LMJ6kG4X?=
 =?us-ascii?Q?cL91qm3ouE9qeR65MotzJ3SfcTQ8B9nujZlejgX9bDdedgC4RbooDIG0E+X9?=
 =?us-ascii?Q?adOTNmGD3OCiP0XNxYXkAZTIMNONaWGAdB4iuC5CQYVXP0H6mo7CcHoe7K1j?=
 =?us-ascii?Q?g98FWYFgDcflhdRlFrpO4oTVRJKHWC0uFovrHqmNXFLwNuMlcEw+wDqUuUnz?=
 =?us-ascii?Q?wYuD8mAGpGvVhe1OwmJYQLul4nEGA1FtFrkBygnON02kKAcsXmaIHNxemwso?=
 =?us-ascii?Q?C4x4QGNz+9u2z1yMwtfTZwE7E56cl7ThrKK3AE/iTvDJF14psR9+RcHA14uX?=
 =?us-ascii?Q?TQIDmN9XnDQr3JmVVS+SsqmYQh1YWiknBx0r/5L57z1jcOWeh83m1hfa+AEx?=
 =?us-ascii?Q?k7tj65PXMP+Whm2ieLiOKzZhXGTkbuChBj6kZHvCnmsKOHNHzw/iMvMKaJK8?=
 =?us-ascii?Q?akWXXCytVXRRtLucc/lkZCV/U0dlMedFVvKAXL5LKErDzxKluVNkej4IKbxN?=
 =?us-ascii?Q?A/Y2EcCj4AsbSP8JV8kfjdXotM09ghwGMYXlFR5wLPzHLghE8hnlNIHQCk/Q?=
 =?us-ascii?Q?4SL+DxSbqTb/gMYySNeyxJP6wpKh0acNwfxSLxCnerMmD0raIEe2ViZUrttw?=
 =?us-ascii?Q?ha1Hxo41XSJHwjIWGqaf7n9zBjramLNkBSogTnS8Z1vrtH0+u3mK/6V7/Pfa?=
 =?us-ascii?Q?dgTKaUAfkcm7+RCInAi3BhU6kslWKkaUZLWtwsV6Fbv9NxnF8GBgRNqY2uOU?=
 =?us-ascii?Q?BQIrgat8OfGEhTI1tNPLkAnnVswXkOMwriMVMfP0eBaTwE0k8Uk44KruL44u?=
 =?us-ascii?Q?JevSH/bMc+89JudrbNLezPlvh/JMZb4iwKVYWR5qnNuO49UUuu02RskJ9Kr7?=
 =?us-ascii?Q?P4N+D35Q34HGKr1dorJZmZuCvuctoTtOve/pDSJChy/jQbs/Gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:33:49.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acd9f25-a252-403a-20a0-08dcfd424800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

The SVM DMA device unmap direction should be same as
the DMA map process.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index eacfeb32f35d..9d83bb9dd004 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
-	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
+	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, DMA_TO_DEVICE);
 
 out_free:
 	kvfree(buf);
@@ -750,7 +750,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
+	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, DMA_FROM_DEVICE);
 
 out_free:
 	kvfree(buf);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e2911895c74..c21485fe6cbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -233,9 +233,9 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 }
 
 void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
-			 unsigned long offset, unsigned long npages)
+			 unsigned long offset, unsigned long npages,
+				enum dma_data_direction dir)
 {
-	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	int i;
 
 	if (!dma_addr)
@@ -272,7 +272,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
 		}
 		dev = &pdd->dev->adev->pdev->dev;
 
-		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
+		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages, DMA_BIDIRECTIONAL);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bddd24f04669..5370d68bc5b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -182,7 +182,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
 			     enum svm_work_list_ops op);
 void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
-			 unsigned long offset, unsigned long npages);
+			 unsigned long offset, unsigned long npages,
+			 enum dma_data_direction dir);
 void svm_range_dma_unmap(struct svm_range *prange);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
-- 
2.34.1

