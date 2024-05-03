Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1087C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 22:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A7C1131FF;
	Fri,  3 May 2024 22:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8r5bRwO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A7F1131FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 22:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjqT4E+AgF9gp7fuXGbnaaJciFYpsXGNb0EyBzgv999kg0BW8M70rTvtf8oxAhsXPllzATNwZuDc+FM8aL+Ym49wfRhkP73aRJX5N4kqmZxFx1kuERyUK5sKyFzgBvoyYIy8EtYx1uohFwdRwPLWfzV3772QP00jQ0531g6dDZoRO7FGpvgaUPGAfKdtf7oVp0kfyorYEP/JPSwrqNOKHZ+fiMEuNZl61PFmlISw/ZS2KbAZXiuA7WK7WZtaAKtp34nGLftt52IkkYKuQdgFjJYjkybTMQTmnhdvwGT7eQp5mMdBtXDweiOHo3S3vVdYHDCtNdSf7T/Jx1YRIohthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqgGDp54LUbq4k/RjOAe0dJV/g8jj5QYZhbyWTbkbFw=;
 b=gYHa/iJPIZdUb9B3GbaM4B/LkZu4czuK5C9tyWEwu7V8nnkkq+hp7ciVUGXPvYeph0uZJimnxiwgbpiU6iLUSylfEAfOQ7wy6H4Tv7GDXXro2NPl+UPD7IsitagckATw86p0OKjGlsYawcjlNMJpwzEmwBxrD1B+Y4EwWil7dlXlRh8mfJv07MGgKpkh1Y7szJYubOzEegRmVYQjqLOsLI6dtGRWvu2PR8u/P4ErpniiDIoPEgLZ2K5OzgGd7iCIBQ6qoJ7nd/zdA5D6W97hrPXYIznoxxupDzxiZkOP507UfvXyDXmehS/zgWfU0o0j16TvGIE7tZU85urHUyEo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqgGDp54LUbq4k/RjOAe0dJV/g8jj5QYZhbyWTbkbFw=;
 b=g8r5bRwOQW9vY149Sf/1idZYG4opJS3bvk9wA/ED8DUFfLLoAyjgnOb4eFNKhWql8F7Ylr2OkgmbhOigj33HehQef3xKIJFFw3gCvJH7rQ8bZ7rBm8teCcQ/KpoTOvcXrgWK7kLuLSjtfUXjIgN0imb42u7eYJXliHPBFL58BiU=
Received: from MN2PR06CA0025.namprd06.prod.outlook.com (2603:10b6:208:23d::30)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 22:06:52 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::34) by MN2PR06CA0025.outlook.office365.com
 (2603:10b6:208:23d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 22:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 22:06:51 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 17:06:51 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Ensure gpu_id is unique
Date: Fri, 3 May 2024 18:06:39 -0400
Message-ID: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 617f367f-be37-44b8-bc2b-08dc6bbd563f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w5gx5lf7XGyQFfZHl2HkooKvd5/AfJPwKw4GXH6xJkzgI80njsuYoQa7Nz8z?=
 =?us-ascii?Q?Wkyq5/CxrA/hNHoPzIJUt1n2HeEBdRjn3+a5FoBC2eYAVCZy7q2AWiNxOiD4?=
 =?us-ascii?Q?7R2uCRoj/QQ9luwkREIsnAMAr92piSz3nbg8jE0I5sMz5cfhSH0jMkguNhs+?=
 =?us-ascii?Q?cFexABV9aDnQwCZKmiGzY11ebjFkKgJ9lQ7NGWgoXFxkX8t+e+6ZwAyL5qEz?=
 =?us-ascii?Q?SPS2RGxdrf37c2Um11JHeXsCpNTCHLS6Mbd8iC8nMe8k0rHO4AeDQoKAhIQz?=
 =?us-ascii?Q?roE/TqNu92zne+PQ4lyzCenM4jtP+eubCNVYBBZ7/9xG5quJU2enHNcScAi9?=
 =?us-ascii?Q?n5UYoUxtbhOFsCbM9Ya5Qj8eG56Okivpqe6nrHbOyF6ki43AD/Dnt6uSaJNl?=
 =?us-ascii?Q?zNQy5NiaMjl+ttv/rh1G2In4bbTRaWvl7Bb9PEqhCtdHB8jlWQEJL4W9zmka?=
 =?us-ascii?Q?sbXZHPyMgJfIc46jdFuRpq1UyYPRVA4acuVxboH/DAKY39zz8T551J4vR55n?=
 =?us-ascii?Q?7rqfMcWcjsA9KgJghhs9xEuS40Njl2ria06B317ebbMhIDnggo2BLX6Awjws?=
 =?us-ascii?Q?cVsB6oim2cGqtwAQgOIyYFc9zLIH1AU6sgS+fCHB4lf4qraNgH36zwv1M5PB?=
 =?us-ascii?Q?twFiwkDLWB269qj51D3pFIdDbwZMtIGGlojlpbnZV4WhQvyFQWJMRrGuVw2v?=
 =?us-ascii?Q?Cg0N41LCSO+jd77QIfBJE+Vj6UmhsrxSPUWFAX1/CMl8QK/ev+XXqqCRYv1s?=
 =?us-ascii?Q?oV0on/a9T7nj4RKQHlw+RAIxZGORFv9ch8C14Fu2ksXfjVTisQ8cL1d3BkG5?=
 =?us-ascii?Q?QCkhB1P31KnJ0J8tgStrFFI/yvTVw5rShhjtkB+RarbD/BG4hPKOqdyY1nMT?=
 =?us-ascii?Q?VW/4dR4h9k773N1MSshrjL7SzCaWI4+wtvorksDKAb3CNT7+aP3mlN3aM0tZ?=
 =?us-ascii?Q?QSr/gYaQfyOcoWJ7IC+IbgWHbs7GGO65saTgww/nSo6NVM5Dv1Ut/Q7M101c?=
 =?us-ascii?Q?S8olf0M4k9JyYOT0xRYfUegEDrDgGVkWqBwqPnf6t2DZtwUxbjep+78zeb+H?=
 =?us-ascii?Q?4yFhNFyzbzbrMRrLwC9CWWVYDE50OBbfgrEv60RVWnnLB6eXVKLTzdPDWYrG?=
 =?us-ascii?Q?4Cv3Qx9anZqTfXp2TrVnOOsFUIPGZy8+pkr3fGLEIgxP3a/098OX0AZtg9q5?=
 =?us-ascii?Q?/pFRsN0ILSuYWAW7hs+BPgq9gN+6awE57ydsbxo4UrVYw7IcC8BHQ13N6rin?=
 =?us-ascii?Q?ERfJzOeXCG6fnvXvGPrC2AeZm5HMacmuTd4x2IuR9EH4TwoYXEVUC24MgNSJ?=
 =?us-ascii?Q?R4wcCTfH0eWYj5wJI/0IL/cBEU0/yerYYtetOfVnchFoeHiCQj3ypUAj9UzU?=
 =?us-ascii?Q?VYfzXLmrahDmLoIw7ZeD8Vc/x8CK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 22:06:51.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617f367f-be37-44b8-bc2b-08dc6bbd563f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

gpu_id needs to be unique for user space to identify GPUs via KFD
interface. In the current implementation there is a very small
probability of having non unique gpu_ids.

v2: Add check to confirm if gpu_id is unique. If not unique, find one
    Changed commit header to reflect the above

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b93913934b03..01d4c2e10c6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	uint32_t hashout;
 	uint32_t buf[8];
 	uint64_t local_mem_size;
+	struct kfd_topology_device *dev;
+	bool is_unique;
 	int i;
 
 	if (!gpu)
@@ -1115,6 +1117,28 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	for (i = 0, hashout = 0; i < 8; i++)
 		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
 
+	/* hash generated could be non-unique. Check if it is unique.
+	 * If not unique increment till unique one is found. In case
+	 * of overflow, restart from 1
+	*/
+	down_read(&topology_lock);
+	do {
+		is_unique = true;
+		list_for_each_entry(dev, &topology_device_list, list) {
+			if (dev->gpu && dev->gpu_id == hashout) {
+				is_unique = false;
+				break;
+			}
+		}
+		if (unlikely(!is_unique)) {
+			hashout = (hashout + 1) &
+				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
+			if (!hashout)
+				hashout = 1;
+		}
+	} while (!is_unique);
+	up_read(&topology_lock);
+
 	return hashout;
 }
 /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
@@ -1946,7 +1970,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
 	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
 
-	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
 		dev_warn(gpu->adev->dev,
 			 "Won't add GPU to topology since it has no drm node assigned.");
@@ -1969,6 +1992,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	if (res)
 		return res;
 
+	gpu_id = kfd_generate_gpu_id(gpu);
 	dev->gpu_id = gpu_id;
 	gpu->id = gpu_id;
 
-- 
2.34.1

