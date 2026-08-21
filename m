Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8247CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E1210F341;
	Fri, 21 Aug 2026 16:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v90qOPqH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E99110F341
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isl2hxM0wVA0gNJE9ZCKtE4oSSUn8ysGi9cMoOsV3FpfRxTjEQzd3DuPy9yONuS/L1KvQzkMjBnAS6FTiDno1bTZ1gW8qj5cO7LUBynzq6SKzyMC9MEI08pMyRRCET4aqviumc/EjwpICdMSov0w+LGcNb/9EddRl7TSLgsGPuwKhU6Lvj3zrT4MOxW83iAXgcjhbhhlu6PHwkdzutQNNX8WD9DtXGeJqqbk3E4FbtpIsdbqNV6HY5mpe0fnfwuXQi20ocYnx2maSatmzPK+OGppvfthoGnB0a8vwXopUWzv9MnFSsD5ovG9XyzNAW+vdetpTIiaOJSp1b9ypnqpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRhUV313v9bS1EyEj2S8UrRDM75prTGHTzqWRM6bG5s=;
 b=pC5Hue8y6x/lDZrI4oPihuHvoVJSz1e3qqE8ZUWQ1iKueQx8JMCugrPx1AybXJayOZOFAoHdvddQdtXYugfpKoreZ4qHhH/YvQ2cl+ggtLAUscq4EvzpHq0Fz8FChZX+kVd9ukGSUCCiMptG08Aw4+wcYhnZ/paMR9QJ74YyNsljEsY0kT6tcUgPv/nD8UdUnbGUt4Rr7sKY8I2YM9WDcyfplArT1rLlx21sPIl7HjFY5o9QpPkfBMmHobC6ZDYEssK4GIWzFq6WNaRUZYGak99e+O0TwdkgdfzZI7RWyZMpM7q5m7Ds8upG3gDmOiOI2FaBkFK43vhi1G3LTengtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRhUV313v9bS1EyEj2S8UrRDM75prTGHTzqWRM6bG5s=;
 b=v90qOPqHiEhnDXQpQFNASVWe2vEPGQnt9/56WFaMvoRVYiLKWL3lFTznq8S4z4iNwwBQXefoeQ6tucuESZ2+KFefLRd7X/PHO3aL9eQ8TmgxHN2XyhoBta1e59sNzQE/zNoG5Pcf+3xskfjl0/gzm1LmAsjrsWBAoEvT/Yfz//A=
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:05:49 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::66) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdkfd: Don't use DEVICE_COHERENT on GFX12.1
Date: Fri, 21 Aug 2026 12:05:37 -0400
Message-ID: <20260821160541.752029-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ff2f8-3d38-4579-a1f6-08deff9e115e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: fwLjLVI2N9NWmcT3WRd1DRJylnnhMQwkYuxi31TC/+RZEhlWPOzh81V/WcPrtIgkefkoQ0ReHcBrMLOR+a9SdeYlncys1XjgcuWeeFbE3LNdib/7rC0j8Ea2Q3GQuv5kuvTMfo3PYyBCDLBCtgK4/MO7w7eKM6E8QEJ+EYZ8kSdsqqwfVswRWLN93hLGITXvgutbAXCrAsP4T++k4Yn7JHP2Eq4nn635DWONh2uIL40nCg5fCJLvuUtCt/wCQ1brv2eMWSJPNe0mqseS4fmvK8HKWcxSvAUH2vaUktetPU/HVmhMSUMnsLTGNwPLnJV656FG8piOZnVgwMRgr2DD4N8nRg3Zi8aKbaiNocK18Gf2RnGhO6BAK2F4JbBy+r5PbKmhF5YbKqgHh35KgymYeYrYePobrGbqzuc2t1RvS29NBx8gXf6R/SlEfyoPoGF4oMPVAzevOpUKlSjbNuxhdqyFsDmGNfmBlHXFGp93M4dvax5oi7OjVwHRInTjpVLTUsdF8bA34xbuWxUi5kOJuwAe5SySmL1tS5hsqm7aJvlOIDmRlRzZwL4MKXs+raIiN4swBNzhbRqdaXgKOBqsYQcgE9T4RxqKsK/0lDkze8v0bbcQwVdqWCEdBs1QGDR98bR9rcLpWIVHZQ6d+GwQa7jIeeDoOz16pb+8hgPEG2CYMq5WFCtXfdlodGx/IEAJEm5SwBvW4ecaWg5E7eTCRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ueu7430G/R6DNvBKvzaEJ51uY1o5cVweQhuF2OuB2dU6DlORp9U7JpzVhdJ5JKeyBQWb03WaSWtkX2IijvH9/yOoqpQ09wB3kihOXsUX71scJPYn6nzqQXyuyUAtxl12Kfy4afViqE2Su56IEnVeWyTsrkBLMCBBNv6P5arzlma1N097z/BuXKFsVn9O++Aro8jGZX4CecuUzbxFWPr7JhHOnDWFBQ7b8anOA6kyXVOHJk1COOT/Q2nUgbMRlJsO1kwkATW+jS2KVFM1VfuS/fJeQyC4Gfiivl8L//Ypi4uVz0c0Bgvm3Oq0GFMmGL5lircKNUcTcPcWeUBUzNLxh5mAtd2PN+LFWl90GNPHM+Zb3thJbQGgtQDYPQKTr4huxrzD6T6dvZcXQPhE7BjDJdx4uJPhD9b0Shu9Ilr8ifmg3teAjO/vJs3+6++R4t53
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:49.3417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ff2f8-3d38-4579-a1f6-08deff9e115e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

NICs attached to remote GPUs are unable to access VRAM coherently.
Hence, use DEVICE_PRIVATE for GFX12.1

v2: Squash in Fix migrate_vma DEVICE_COHERENT setting

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f5af1dd3b70e2..4b0ce078a9c9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -711,7 +711,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->kfd.pgmap.type == MEMORY_DEVICE_COHERENT)
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_COHERENT;
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
@@ -1045,7 +1045,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	 * should remove reserved size
 	 */
 	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.xgmi.connected_to_cpu &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(12, 1, 0)) {
 		pgmap->range.start = adev->gmc.aper_base;
 		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
 		pgmap->type = MEMORY_DEVICE_COHERENT;
-- 
2.55.0

