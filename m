Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7171CC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 17:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23AC10E7BF;
	Wed, 17 Jan 2024 17:56:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6488F10E78F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 17:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWovqECqUEiej6H8xZGtkvPoFYNSbZFsCeGoAx4ydDVH+h47+A/5s6VTE5vhEV2zoZZd7zk8jHViNd7w7g3Er+V1VQQp8GNILLZXOxxb87DKOwp+T5uB1ot9pJTzo5o1dgOJWzGAJ7eLb6eYGrgatuoSSY/MKHHQ0Qwn3M1CEPxCfYd3er7kE+XFcy4E8GfsOnL0Ze4FFshAtO2XbraZpfZdiazz0ehS73wti8UX6zUA72YVqFvHUk8S459nE9qOTuqCz8yeVmKiUKp2U9q5XUWak20fVYakkmVbU0MEkAUd5MgcbAiKJwmKyQiPNZ3RQcGZcgvccUtXIOsOaR3/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwBLMSqxR8H9C6PNI/7JsfHKalCMWbUCJ5WGH8FtwHM=;
 b=OWANndHdBmTCbiB9X0pn8vXOIOUQPPlJ5ur7lmAjnHKRwd3Z3XIc0qQYuvi6yKUPr99PyGwWUbbFuMJ9pa5M+M4WAsZV3em/PN0aZoIuXmxmseLDVPUZVJURVdgwP/mBemsr5d0lynC4qF7DnUUMTi7AE5jUpGVcNSFbd4xHYncalTj1eZKIcrnovyEb288mqyjWeKPK1XK7YcmwHG7/vxtTxa5Fxv5wDPfHt1YH9hnPR6bxEZ1ak77hus9QRQ+Ql/MFU4BO8qPdvqrnoLXQjJzexa/uFda1kGwKEoH4+JRsbERCi9ljLeoc54EUZZnqRcoEAw2D/idqynSkQiZTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwBLMSqxR8H9C6PNI/7JsfHKalCMWbUCJ5WGH8FtwHM=;
 b=yzP4DVmdZS6C4TB1S4FijsxdzBKiRWs+kdjAgmox3aHNKwqCzYyTsfrbyzLQ2OZtn4XITFJ8vNNOFruNRkIPzWhDBcN4E4vZlbjE8Z67AUOWdc4jW07qPK0tvtDW4xnhZxnn5IHt1gfioa25Dc5B7HXFjE54YC2Nv5llBIa4haQ=
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 17:56:48 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::5f) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Wed, 17 Jan 2024 17:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 17 Jan 2024 17:56:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 11:56:47 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Assign GART pages to AMD device mapping
Date: Wed, 17 Jan 2024 12:56:40 -0500
Message-ID: <20240117175640.1386413-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: bca53c46-2875-4e46-a334-08dc1785ad1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFFlw9TUUWAYSpkjlKuW7L3CsJ4GDIQQm3JmuJbckf4Y65yDMeWaSRMTeQ85T9KvK9nv5l8rtPjCcMtpr4ThYRhitgRxAL+cdbj5m0i0SA2zkjJ7XzMqzDSFT2OxDgWwezDDEbi0ee/gz2SHDYkd3iXgynNwL/cV7D2XXEM+aSSlwlzVnoCJ+p+nmjmgZNS4KebaZ8Iro5PxiCxN85qCuGwYrZNbOX0uHtCXU3El18ys6vPvTmzydJnOfc1DZioePSNAE4s7pDd1wZhnNZ2dYYQLXio4NgKdqJHXEo9mtEkc7hctHQko+5SiY4gd7XvbKtmj7lzKqNfD1ZiHtiPWh8ZrmU3W43QZUiBZcMVAym5JyInLo4b34AT2K/j+KHAkPNU0PlnLiaGRXeRjq+wq/qOtKSL4xvJS6XQkJ/LBGBV+Uzst92DNUiZh3z6f5KRJ7OS92N5pH3ZbkE/cYeUOwap59IUn2AMRtps8vJ2Zc6OeMarVEt1x58VyD9PGY7gfGRkdmUkNjXSjceT83F6LT3HZDLqQvC6txyq4nt9B76kLkx/Dr/LXsgM7l5t007pSNOBl5e+IVm5FSljVtFhkxA3yA+e8Xl17rBsRyKeR3/5si3VD+mZjO7BwWqXPHWamj3CiBGyQZY9Qg/kOiujKM3k+Mvw0vGBSKyqRdhdgtCDbhnLIk2OrB2Om9KtRqyiiOJuMHcMBEzLQVFleixgo6OU+E0oEESvhIz+PX/RbYwoA0sTZ273BMa27+2MgZrVKJQzayzCJ0gkpVQHt5y3mmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(83380400001)(5660300002)(81166007)(4326008)(8676002)(8936002)(356005)(2906002)(336012)(86362001)(2616005)(26005)(47076005)(426003)(40480700001)(1076003)(36860700001)(40460700003)(16526019)(478600001)(6666004)(36756003)(316002)(70206006)(70586007)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:56:48.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca53c46-2875-4e46-a334-08dc1785ad1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows kernel mapped pages like the PDB and PTB to be
read via the iomem debugfs when there is no vram in the system.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 73b8cca35bab..f0bdbcc7b1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -121,6 +121,7 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 	struct amdgpu_bo_param bp;
 	dma_addr_t dma_addr;
 	struct page *p;
+	unsigned long x;
 	int ret;
 
 	if (adev->gart.bo != NULL)
@@ -130,6 +131,11 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 	if (!p)
 		return -ENOMEM;
 
+	/* assign pages to this device */
+	for (x = 0; x < (1UL << order); x++) {
+		p[x].mapping = adev->mman.bdev.dev_mapping;
+	}
+
 	/* If the hardware does not support UTCL2 snooping of the CPU caches
 	 * then set_memory_wc() could be used as a workaround to mark the pages
 	 * as write combine memory.
@@ -223,6 +229,7 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
 	unsigned int order = get_order(adev->gart.table_size);
 	struct sg_table *sg = adev->gart.bo->tbo.sg;
 	struct page *p;
+	unsigned long x;
 	int ret;
 
 	ret = amdgpu_bo_reserve(adev->gart.bo, false);
@@ -234,6 +241,9 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
 	sg_free_table(sg);
 	kfree(sg);
 	p = virt_to_page(adev->gart.ptr);
+	for (x = 0; x < (1UL << order); x++) {
+		p[x].mapping = NULL;
+	}
 	__free_pages(p, order);
 
 	adev->gart.ptr = NULL;
-- 
2.40.1

