Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55445C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA0F10FF59;
	Mon, 22 Apr 2024 13:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTMmBqMA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEA7112B0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjsyqueBNk7fkgHH3N/bMD50ByXc7AOsD9hpRx3cBPCgwhJlwgaaDoTJRuI3udPgDP8RpVldlPeDFCM5c/psBSNAbg8wL3RU1r8uaQZDbkR5RqFcDHlIkqnHkprCEIAhRHHUsIb7IdFDv4N7W1LqfMIMWwVtHRj6XSRF8zR65v4IXi4Ii6qoveTaJnS3WDVo6LAWevYUId8vSUQZOkNEQNfxUAz4wWg9iS23xWKASUzjyUKM3AES07mhax47uCB7stEsD/4R65Y8Ltv02lDhYnbnQ2YKrXh+A883NgXuRZOZ/T4kvGjVMp/BwMNTlYdm56WcP3ATqvIZDoKbjBGxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vNLV9VWT3HCtqfpjkADAEnCruVdrP/XUbqmB9MuVAM=;
 b=LrZBHfztTlIWnMKMsjtTAE/dseqIvBaHAORbo1M9ckm7DZzViXxTXk0rr0UdzYavLh6A6dO1I7F8PnqjQGPdTnTl8q0pOEcSy377Lf4K7FCVPeFGk1b07BizvgAyBML+DM/CByFBuRU2ImjAbqnQ9wWjAwTjzKLbIrDAnQ0/kepPavGhYHkf1WYEqbQWhDuAxWPVoa1WEyMX3qSGG3cx29Bl1Ck7K/bFzjszF7JddijJ9ik3JHpXr2JPF+auWYdbzv4jipt8rl1kZBi4HHHdBUjX8NvfpVh+c6t3yJZGpHTmOGP433CW0ifu/mx5KkGZYnCUFV38eZkRYrFzsjg/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vNLV9VWT3HCtqfpjkADAEnCruVdrP/XUbqmB9MuVAM=;
 b=lTMmBqMAyl8v6XF0IgEjA41nKnH56YrZw+hHCQrSPtAObTboRrEvDt/YmKOdImuV3n3Bq5Av008lp7hIV9SEx1pcYb7wa0T3Kq/ymp83XY4dyHXfE3Hp05rMXNOw9u6RtACi3xBzEOxABhmcqyVL/ghWHrXUK8dITc6C0+RBmKY=
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:59 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::cc) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 6/7] drm/amdgpu: Skip dma map resource for null RDMA device
Date: Mon, 22 Apr 2024 09:57:24 -0400
Message-ID: <20240422135725.11898-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: a201820b-77fd-42f5-c009-08dc62d437f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ephC4P1cjRt9jlxxQ7MxuDoPbAIRto6hjFsqCy15675fkEb4jvZyGCw/KNOy?=
 =?us-ascii?Q?WdGq2sQTRsortbcE457egLW5Ba5PafPc8fmerdzEysgD0G4wlovrIErXxtNK?=
 =?us-ascii?Q?Pzx7bkAhHGtBhMLu5Ei6QOyPZSzdrB23o6mzb7Juz0lS+w2hqzFux+Sktr1j?=
 =?us-ascii?Q?W29E1SSEa8No+aN2zKy/SUconP9xWxciGS5gx5+ZidoUb0n5xhk7ZSHsrR8/?=
 =?us-ascii?Q?JS7Hp13lATrtHneap3Ds2eqHDVwo8Y7iJaQWAMfv4xutfbCwU+Z821yEDqFL?=
 =?us-ascii?Q?mPqGkxoct46wod64GwFwMUXP6DT0LwkMUIuO8MvKY9Z9l8WxGnJLRXjnPHzr?=
 =?us-ascii?Q?sWQeOmZZK0oH9mKALIvG4ycRvZrSiYkCzcPBFL97OTkOHXMAovxtIxI3fOQL?=
 =?us-ascii?Q?VALEndnvZ9BWPrr3YXZZzJJlV2TfrgYyWc2nOJxPqe6pV8ZKpOtLvsRm+H94?=
 =?us-ascii?Q?4BLhpunzfVwhTR4jPJgFNVg7Nr9YP15wu0LQnsbv5iZHOd7BnMuaMqy8zhnO?=
 =?us-ascii?Q?otn6ng2MGf/JwanygkrC3zagUeuLlAzZSDhZibova3ql5IrRtdq8uoxgP8TV?=
 =?us-ascii?Q?mfReGkjPPWCYZXkmyjH1StSPSeB1dNqe5s4iyRo4/Ih6jgYzNKMoFf5VSbB/?=
 =?us-ascii?Q?D4BTtj7+CKVAnWtq95O6c1tn5IOzrASGWDwB/EtDIPKZzhk7Jd0m8arWoGAD?=
 =?us-ascii?Q?d8Mo5ViNd/FWYvSCIVecMYQfVOMdBg3I2YwT6s6y8dL+pDkZXKY+RCiQu8fl?=
 =?us-ascii?Q?QqStlFR1F8gIs4+G4EHU2kpX0WQdJX9QI5JCiNC8daCXKnJbw/9LvZ4o9GpT?=
 =?us-ascii?Q?YUkBRKskM2meuX8nqouQaFu4T5wk6K0j4DheTlcnICwfFsmhPGsrzhv+Yvqb?=
 =?us-ascii?Q?L3VcpMDz18Qxp9QjHdN5pVN0pKWZcp3jEIG4kaF5+4noNv0794nF55oGgk7Y?=
 =?us-ascii?Q?/lus6F/A90VA+F8h2bmG/vnqEl6axYqmO3GWkfB9TFMaQ8YYnWNTA/siZeZs?=
 =?us-ascii?Q?3VwF6ay0SMJR2AlovagL0IcdECJE49fcALETNi4t1n4XKeHzcovgGVSJMvA/?=
 =?us-ascii?Q?JF0wNzHOa4VBnS1OVcxd97CgNW1PCiDrWSS8DIxskCFxK/dUTL1d9DGr6+t5?=
 =?us-ascii?Q?7smlb0fcsEglBtl30e5ZEbKzhPf62uipYG/82pcEzXPneRZcRxQL6QMgwsoR?=
 =?us-ascii?Q?7TpGJQPbEz8HJy1OR1uLODzQH1eWxOgtZCMrJP9nDu3wDZfXXmU5q3nBbQZa?=
 =?us-ascii?Q?0Xoy2Q5AgsVqo3vuaPFYCLQuX7wzrs07fJXfJ0bb6Mvcvnr2zQfN5Bl8MNAw?=
 =?us-ascii?Q?J307qTUMLeDrS2LdVLBrUORohsjI4KcdG3ADWFObdm3S34TrqrUw6PKiJKl3?=
 =?us-ascii?Q?LdjTwnyLmz4t9w1qDIgWRSieKVtK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:58.8930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a201820b-77fd-42f5-c009-08dc62d437f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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

To test RDMA using dummy driver on the system without NIC/RDMA
device, the get/put dma pages pass in null device pointer, skip the
dma map/unmap resource and sg table to avoid null pointer access.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 9fe56a21ef88..0caf2c89ef1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -705,12 +705,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
 		dma_addr_t addr;
 
-		addr = dma_map_resource(dev, phys, size, dir,
-					DMA_ATTR_SKIP_CPU_SYNC);
-		r = dma_mapping_error(dev, addr);
-		if (r)
-			goto error_unmap;
-
+		if (dev) {
+			addr = dma_map_resource(dev, phys, size, dir,
+						DMA_ATTR_SKIP_CPU_SYNC);
+			r = dma_mapping_error(dev, addr);
+			if (r)
+				goto error_unmap;
+		} else {
+			addr = phys;
+		}
 		sg_set_page(sg, NULL, size, 0);
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
@@ -724,10 +727,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	for_each_sgtable_sg((*sgt), sg, i) {
 		if (!sg->length)
 			continue;
-
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+		if (dev)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
 	}
 	sg_free_table(*sgt);
 
@@ -752,10 +755,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sgtable_sg(sgt, sg, i)
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+	if (dev) {
+		for_each_sgtable_sg(sgt, sg, i)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+	}
 	sg_free_table(sgt);
 	kfree(sgt);
 }
-- 
2.43.2

