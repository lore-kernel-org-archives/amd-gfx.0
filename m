Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5CCE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7C910EDF4;
	Thu, 12 Dec 2024 14:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3ftw99z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912FD10EDF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClP3Ksj/FPc9ClTAERuXcqQB11QsXCM0qLP/QTEEJ9QvgtMtPRSsALrsw1jh8f1pPR/Spl6oG4LpFLjQQkc11RAQ+Gp4gijXZVlOURetsRUf1kNNvGOUoC7asfhijtCzk0V7w7XmqmAQspGihBgEH/jFyWhblW4Gbbj839oD1E4jkrthuczBUAeNl7oAvOA0uXv+RerL3LOo1kfNgaPPg4gQJ6YnFwg/o24/TzzGwCtwlPycUpIVMhjI2aUE012JjIxw5cM0Qbm8dd8vIAMH0JQuh2mIQKLJyPs5NazwsGX6ZT1Q4yFXRDC/ydY+VixaI+n7NWuyxB6ESVOXT4gKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF08QGlDcO+vEsYxJj0fphvLx1NggD3CKRr8G3gtjmk=;
 b=kTWLcYlfWqNP+4jBo52POcMwK5Bt1zM85K1+7al+sZNXGZSIqUOr05nRp43MRv85BWrFydwL4qooGpgqn8vi6WeKYoyTPPlMmHT8ALGcZ5++Z4406hKc6whcj76ujMv54P7+pVwTmMk0z2GyyMvVzv6dRtBGdz3zBeDv4UwrzxjDv041YGQ7fsnknOvklkXgmKD8Ily81oDeXjcllReYiHknjrlicwXGYndpbkEJvUmntd9XF9HQa4lw+aIIBJmfIrcAwE1h8IFVUlBVeZ023jLcSe2fRLfvrPWF2+oyNWzcI58hQASss0YxR3PtQUOeESXDiKK07YBuSpvY8yvt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF08QGlDcO+vEsYxJj0fphvLx1NggD3CKRr8G3gtjmk=;
 b=X3ftw99zk0YrdKOZJvEDFM+VDsd+tUIAS+q0D0r+DCNo2gZaBBb8yRtzCYErB5zscTmkJyCFBKd4MbihPeWXQk6zv939SM8eV7Ha6Bwk45x5GcZbK98C5AcFiyRbS7ArO8ZAkexEAZdnrwl4oaGM0m6H8sjHsyLzv/IjE/CKpy4=
Received: from CH0P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::25)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:25:54 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::f9) by CH0P221CA0015.outlook.office365.com
 (2603:10b6:610:11c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Thu,
 12 Dec 2024 14:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:25:52 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:50 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: Add mqd for userq compute queue
Date: Thu, 12 Dec 2024 19:55:27 +0530
Message-ID: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: d664e90a-0bde-4a1b-11be-08dd1ab8e1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6E5aMIVceMk+RV9UVhliX9JEus4Feu5U41a8C+gSKlc+E+WvhEU5oT6K17uY?=
 =?us-ascii?Q?v82/qnv8mQJSpsbViNKN8T4oti/vJ232wp7z2XuiO4O+S8Kz4dBHe+Zy3Fnv?=
 =?us-ascii?Q?cjQCm1JC3p0UaNHvu/cCA2478AAlT6se4tHrXIgfv1t9f8pktwVwJOrtdaNc?=
 =?us-ascii?Q?76j6r37nZrK4O0VubxCxrLQenDK0VVKy9QtJZbMflMPg2deWXTBB+hzUHWBz?=
 =?us-ascii?Q?PWz03AK03XqNhPtmtWEC7Kl39OoiketfP/mNkRP3QFddrDPKo6vUfgT7SRwD?=
 =?us-ascii?Q?ZEfanD8CyjAisl8YCoFZoEciw2bblwSfsDsmW6XdqxM6TeGqy+66Pt8xGU0V?=
 =?us-ascii?Q?Gfo/gFXcnnrCjgqGHZWhNerdzcPxY7OGMcFGRKVuN/Yxw0agyBjr+J2wjUxH?=
 =?us-ascii?Q?5g5QzeR+9FsD+M1sL5R+leGqSInN9QxY17PRy1YkxtorqLmqxN/UoUoYfxHM?=
 =?us-ascii?Q?+YhMWByUGdDh/L6pI33iJ/rAjZICgnhkRpkdBAZcbURMFiwNlwnFOeE542jB?=
 =?us-ascii?Q?pOMUdwU0+ObhQqjXIRBZv+jb4XiUn0gBMWguN/LEZLSndKg1yDw/au1MeF42?=
 =?us-ascii?Q?CU9RH0ZBCV01MujvLExbnw1UmwYkZdkwNW5npiluVbqorqtdypljrU+IdhF8?=
 =?us-ascii?Q?b4OCXsmJgbjLq1LytGKNjdLaGcUthavOTW5l94Vndb66V0B5SjP0j/wByXGt?=
 =?us-ascii?Q?ocPSXm1VN30tB2avY9G3hsBQexeIH+toa6eYicMGG0Bz5sm4CI6gA+F3kvIj?=
 =?us-ascii?Q?BgQ7WjqWpX/EsgMpF1sJK8DVEIPT6sthgdmUvdlJVipxhatXfri7UYQWmy0A?=
 =?us-ascii?Q?G/Ov8we8RSGiKJxwNAYq51V6Gpfiulds5tT3+5camz/XsBvGvd1NMvB6le2v?=
 =?us-ascii?Q?luWKu8z4lpWGAkFxo9kUthWLOBeqft/jftWq+FlIahTSJmCJjdA+Ey6dsG5H?=
 =?us-ascii?Q?1kRMHCywagyP/uVOY8r56AzxxXeFT6BmXo5cQvCximpEw370MDpunkuLyBMe?=
 =?us-ascii?Q?KtH6S8WmboG+B4o8QQXV9ngRs298+u4pasvNatjLqQIsATubhZetHCmVqaM4?=
 =?us-ascii?Q?/pOfw56SENun+C0Mgn9NME/LfFtXVd3UaAKy3QTnQP9vMK4oeU5sa+5kE1FF?=
 =?us-ascii?Q?3pNOLgji0yBWED9AeliFC1zkxKbt1o0SwKW6Lasr5AhU+Rz+fItIUpuZ8bFG?=
 =?us-ascii?Q?ryTsSppg7SIWNM2C+5bokgcV+JIviWrqe2nQimSrIfYBkW39uEUXQhVridoM?=
 =?us-ascii?Q?6LXjdJ/+76tlpivx8qbOZ6nYjzZKPGJZFE9oaZ93mM4UYYiY+mWADjImR7DQ?=
 =?us-ascii?Q?f+fccy3EcOdxQxrM17DiHZUKtSmp4cZ0yV5G+QocUndK3D12Yq/t1Jf5tsgQ?=
 =?us-ascii?Q?6NPv/WZnq9x9ueLR01MQOann0K0kqbQiFSBmWTud7Tb8iFHi45NWNRyHRyCm?=
 =?us-ascii?Q?7Hn04Dik5EzPjmrOihzfMx5MSNOgZM0w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:25:52.2361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d664e90a-0bde-4a1b-11be-08dd1ab8e1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

Add mqd for userq compute queue for gfx11/gfx12

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 4 ++++
 drivers/gpu/drm/amd/include/v11_structs.h | 4 ++--
 drivers/gpu/drm/amd/include/v12_structs.h | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 67cd42031571..b9a672c51cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4255,6 +4255,10 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
+	/* set UQ fenceaddress */
+	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
+	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d0697b0869e3..8c0a4f3a4914 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3177,6 +3177,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
+	/* set UQ fenceaddress */
+	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
+	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index f6d4dab849eb..3728389fc3be 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -1118,8 +1118,8 @@ struct v11_compute_mqd {
 	uint32_t reserved_443; // offset: 443  (0x1BB)
 	uint32_t reserved_444; // offset: 444  (0x1BC)
 	uint32_t reserved_445; // offset: 445  (0x1BD)
-	uint32_t reserved_446; // offset: 446  (0x1BE)
-	uint32_t reserved_447; // offset: 447  (0x1BF)
+	uint32_t fence_address_lo; // offset: 446  (0x1BE)
+	uint32_t fence_address_hi; // offset: 447  (0x1BF)
 	uint32_t gws_0_val; // offset: 448  (0x1C0)
 	uint32_t gws_1_val; // offset: 449  (0x1C1)
 	uint32_t gws_2_val; // offset: 450  (0x1C2)
diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/amd/include/v12_structs.h
index 5787c8a51b7c..03a35f8a65b0 100644
--- a/drivers/gpu/drm/amd/include/v12_structs.h
+++ b/drivers/gpu/drm/amd/include/v12_structs.h
@@ -1118,8 +1118,8 @@ struct v12_compute_mqd {
     uint32_t reserved_443; // offset: 443  (0x1BB)
     uint32_t reserved_444; // offset: 444  (0x1BC)
     uint32_t reserved_445; // offset: 445  (0x1BD)
-    uint32_t reserved_446; // offset: 446  (0x1BE)
-    uint32_t reserved_447; // offset: 447  (0x1BF)
+    uint32_t fence_address_lo; // offset: 446  (0x1BE)
+    uint32_t fence_address_hi; // offset: 447  (0x1BF)
     uint32_t gws_0_val; // offset: 448  (0x1C0)
     uint32_t gws_1_val; // offset: 449  (0x1C1)
     uint32_t gws_2_val; // offset: 450  (0x1C2)
-- 
2.25.1

