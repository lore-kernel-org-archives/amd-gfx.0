Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790EAFEE4F2
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 16:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428D10E00F;
	Sat, 28 Feb 2026 16:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZhdtiZH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2765A10E00F
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 16:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skLn2YfLyiT3rbMFmnIVqUkYFM128ezr+FHB0hC34ZwK7ZYcGMKvAdWVysdYT7Za5ieD2DQt2EVXZITODYBH27cTGd2TQBVEu0eOpkDmKx3zlqVD5VyLCFqSzmhPZeoeRW/BDi+EgtPA9KIKpJ06WjC1GdLZVpKVwH5BXfkqqLiR6squjDNtB9vJ869qLEDSWCPb+BkbRZBH3bcqW9g/Cxm3zeASRro5Dv0NkxHFk0R+ww3Vlir86mR22ppeQLOPRn2eGOdYhNgq9oQTZZSJicT1a1UUXMTob5ZS2SX3J5g7WOt0IzCDcFjbVK40zXhi41YbrEAC+XLipOCsVn0gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x3pTrCC3Z9lyMdV9ymqCG4kIBmDou9J9y12rw4Qz7w=;
 b=RJ36l03awWVgyKIfywSvH1Eo20yZ0wa9MH2aZLt98l23taoHZaarsxwe76Sfp85tsiwoE5rR1neTtrbf7Ci7rtpmUSipMSk9dIquEijq4ZjI1dAr8qif/NSICrR6NjBjIyD5TLSgkrWeqFSYZWV1Zc5RXSnDNznG0iJN9DnQ5goap/DCl8ew/JACcV7jy7sZAqLKUV6SovT0WBiANgXdbXjq3ltZ1YLa+zyPwxrMP/olIzPKurpDD5ONh+xb3pscxygwSMkPUB+y2KNHCMcdD7VvTyG+dqIgJF0pjoWhsyR7LqRfZbumBEMaxNsEauv3Z/EfJCv8BhATubsrUHIPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x3pTrCC3Z9lyMdV9ymqCG4kIBmDou9J9y12rw4Qz7w=;
 b=lZhdtiZHUVUDLqdyKd969CoVkbJGzqb400PBe+VAvLV2oHsTxfCPagnpJYnJAbMKy0d8xtTd2S8zKeeRDd+/98nR8gPw60LwYGzZwz6MZyxlif0XCuGMQ/h/NozUVhmX59PrcXaisN7rZmFAZRSre3obNdvDQ7Sq4pmmQyrjj4I=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 16:27:01 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::18) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Sat,
 28 Feb 2026 16:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 16:27:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 28 Feb 2026 10:26:58 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Fix mutex handling in amdgpu_benchmark_do_move()
Date: Sat, 28 Feb 2026 21:56:40 +0530
Message-ID: <20260228162640.1697925-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7124dd-fbe6-4215-97e1-08de76e63371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: pRI0fyiREysryF8fpU9gIcdbSBmLg9mpEU24RMD/qdvsG4pH8grZzqy7c/ZjRd0akxtDh9Hx41l1oTg6ot0kMpo/dx6p3Tx6evBErSWC/c5QkLOW1FjQdBLUsEoTd7RjjzsbIKR0Fodiq9iGcbi1HVjcnBT8NjmQ7Jaas/+uAbYLHhBnefVVEdjterkKvYWFcuczk+p921VQYt/1BjIHB6Akrttj0eJ566cJrBrKkZtlzuPlS82R6LPLawCQ+QR9Ti2hfORzyJeUGylyWlCWgTUEFBfsULxNjxuZEOy3G/HYW1YUML3bGMFU4r26rzwEgyFV3cotAScuc5fyi+e3kBNvItyeyx6TiYp40nkhC5aHMbfdym9lgFXqvEoI53oyNLL1puXy7fV+RV7iySLQMh4Y91fM/2Gx52Jinhqkycv5QxI9GWZdbQf/fVU8vHRlPFtdLvw5w7WUwdPjfglExZCDaoBYjiA4pl2M3sOlceyzaDrDjqpsRvs6tIcskrs8VIAcdI2eubsp/iPrL9LfkmV3IkJleks0CXOAurZWlw/CD4dny7GbDR9j2biJlVxen8vNt02SvbSCcxQxARpE6HfPeWhu17ZRunYL3UF5QfVQjgpg+Nkm7TpTqCONn9fB9rIHCAWtHeS52Vg4uwj4vXBZZTaq9ipxLZ1SoixS34FH8ajDG08PoM5DSWic/xrhCrWmw9pQ19scQIe8Hvj2iMs2zshVRMmPk16FOAavAaGuYlaPw+fXiCwauqb/H2O0SSOvcCBoM75qw2vhyT7FIk0LDk3Cx/r0JRwQ5LiLxdES1jyw1WEPwy3jet9C+Zt7Uw4CHmwL141XC2/xNZX1Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bPwT7d64rnKMMk0EWO0DHl7Oc5pwq81fk1JSSa0rbphLxCHgH58VKpb/53X1nyPw6jLJeHTdrCjGtcpvNx0lkA/lJ991QRPbx8wCj+5A6SkDVL6ntgShCPDLxDq5fvC/SLt+Oo8GpLRgWfHDq0oqyj25YfxR6+ltGLHmQ8JKG710+y5qx1kQdjCyhKNDBLUlG8U+P3A/CotxpsRWe3128uJeNuYgPd66vIyWUthGwk/+1Pp5DbG66l0Z1cfW68KQRzCxYvhQEmjmrd3XQe0tB/MvCq46+5CQE8cgKbUcK7KLXR0SnJoKQXY9dTwU6IRiGoPC4Th3iXmBJJdmNG/BQQqfFJB4YKm/RUkq4/PkaU2iwZ7gynjfv8n0eS+d4WBLCTACxbWMS/yj/MNSazIUIS2jJZCePh3Vk8LJhKY6WoFwb6WYaJFd9aQKSrTuKm6B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 16:27:00.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7124dd-fbe6-4215-97e1-08de76e63371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

amdgpu_benchmark_do_move() can exit the loop early if
amdgpu_copy_buffer() or dma_fence_wait() fails.

In the error path, the function jumps to the exit label
without releasing adev->mman.default_entity.lock, which
leaves the mutex held and results in a lock imbalance.

This can block subsequent users of default_entity and
potentially cause deadlocks.

Move the mutex_unlock() to the common exit path so the
lock is released on both success and error returns.

This fixes:
drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:57 amdgpu_benchmark_do_move()
warn: inconsistent returns '&adev->mman.default_entity.lock'.

Fixes: 64c9e5ec16fa ("drm/amdgpu: add missing lock in amdgpu_benchmark_do_move")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 98ccd7ab9e9a..024d1fe36716 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -33,7 +33,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 {
 	ktime_t stime, etime;
 	struct dma_fence *fence;
-	int i, r;
+	int i, r = 0;
 
 	mutex_lock(&adev->mman.default_entity.lock);
 	stime = ktime_get();
@@ -48,9 +48,10 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 	}
-	mutex_unlock(&adev->mman.default_entity.lock);
+
 
 exit_do_move:
+	mutex_unlock(&adev->mman.default_entity.lock);
 	etime = ktime_get();
 	*time_ms = ktime_ms_delta(etime, stime);
 
-- 
2.34.1

