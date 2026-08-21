Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467CC5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C213810F33D;
	Fri, 21 Aug 2026 16:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eT7LbS1T";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9583310F33D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFVpO2H9C53UDwCq/h7aaFH2CuHLTJNq0ozbK59V8+TwmePS3Ad9eCwKIKHw4hgC5uyEw4FyHmIp07mHPtN/ZoGR820ZhvxvQP6rUHHUKdWIaIcVsb1FoYQ5JR18z+dDKHSptXR/6rfDF09E36fVDVgbvsH6LX4RwC72i3KSJ+vCkurmClmm7805dLyz/EtaE8BU7W2rdIvDRTQzw2Y9KMZtNKUFIZccgsjth/g5alTp9PEKU5pZScLQzk30udH53yePDkVWYTKIvQa4FOlLdC4yywPd2PLRLBxOvPMiRPSwyo5OSxaHMtz+hiQ7Y2SiAY8GH2JjoGETHqexGehKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUr1gMO6D0HsHE4BX6yRONrZSjriX56Hxqm7NodCx2c=;
 b=lWADMYDWCIh9/113DjcQW7TEebOjG/OGEXUPJ84Z5HxdB3bV/j2/rGgv2PIu7LsERNR+sp+UiH+mo0s1ohkGb+s5qc29u8wR11+eqVtvGTDaLHB1apMJhEOf8qs5uwZ7b37Jx2spd6sOm4sNlpGdI+Mw9XrxP7oVw8nyTFg/amkeuMGUKxgLH7Ri6rO+UmFl55CpX7hf3XCpvIINGsi9zCkKvhGZ6CtQROjYGvVlkhvO9/nMltI4bQSrC08+Kd427kNkj8S+vsSvX1pb37y45Zb2V+4y6MIrcu9qn+Mr/zjBxMFpFk8Y5agvrO1aQjXTvcAcWWI3pAEWp3uvXF4i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUr1gMO6D0HsHE4BX6yRONrZSjriX56Hxqm7NodCx2c=;
 b=eT7LbS1Tl6wnDQXhWl50Q5EA96QNabGsYjlYbee12OtNWA1N7KvRYrQKMcVXhbOLIe0Akz2GRwGlPcpRjex79fyn+IJzdr2pIVy0FzMzNVbc7x68coHsKI3s+Dkd5Xq2NQgup2vwp8yLzy1XHm3ML6h4IUR0B+TS+QjYzh8Z9qI=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:04:50 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8e) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:04:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:04:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: LSDMA supports multiple threads
Date: Fri, 21 Aug 2026 12:04:37 -0400
Message-ID: <20260821160438.751766-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b025a64-236a-44af-f75c-08deff9dee6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t9s5i/Yu9MmPbJ+mk1W/CC/719klAdBKKXyqWGkupFAce1nJSTzv/nil6j7UNN/2uYP/dnM5sW4xM4rXL1VJ95vKnG5XwigakC1iKWeEiE3OtSUEb0XJGzXrCoQCSV9ET96UYza2Hm1IALwnzhXHqspZqy4MRsXwdPubddi+nAM9qc3l52Q0+3HiACc3NpqYcSVfYLyJYg7FtECaa8yGxaNT6hrwqCXxK35TFEMXo/s6QOaTtbvO3kqDUhWaxrRAWm7NSigbp1ll13WGfsp/526Zg/diWH+1BHUOPsLFxU8kMH8rkvekNkR2mMRwsBonnt9zoIV2x1mZlpK0mz35gBibK/Ljw2DTW950r6w+u2/SIPFKb6g/SYHn0LXmjf0YQMufxH14Nvl1hug7ynJzulGMLrCYq6IFsN7DECUPqxKdWVuewxHyXFRUkJY5qZK9uPSHPQOeeh7AXQ9Y+a6uolqKPb5hd/gvGjE9aS1eW9/BqqsQBD7dxNGYSTw0HPYFb1CFbRTgWG8GZSbQeTUFOWXbs12+HeZbsHB4QhHLib6AJs9NExcoWE1/73E2vyvqLFIuD64w8Xp3OpAAaqB++U2d9P/qg0uVrXhGggSlFFK1xo7jJlcisa4OJSfhxXYeoDXyI9CLFLn59ShHRIsQYYA17uRCpCCL6lxJvVXITWMzLM+rbW/ebtLzOdFRDlwo93L3mvnbff0zoJFhl3oMJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l7dDQdZ3Z2Jt2EZ0rEeMgGE2d6ZEbGftdZODMoE8uW+zw4rRSegfc2n+5vXuRBG1uNoBcGC4+LAw9oO2RhZwK4OaGvfZqtoSXVGjVSjha1rrsenFNZzQwMu99hYgFJhEuqCylrzFmGJBGf7f6VJooJsJ1SeGiEZI+XYfiprNGiEAs9ebh5z6dLTUNt5/7MPEu+8v/7sDNgVKaOAT4ds8JbmJ2MKKT7JmkNTkLogGr9RivV4rNUPMtCT1Sig44uJVXktOXAseug1uIlPLVQ9Yg7/xNkPdMFCe21oQMoYIzHVc27HHXo904++FTpvLLj8F5u4k3yaotuWvKi2ZgcW2Q0tQ6oii+r116q7e0qIw1UiR7oq8tqYrtCA2OA/O8VBS39FTDhzVIZ5tw7lAbXOrKAz0uDNMyi9TY0C8eD6iugNBnjIVB9yYx6TxBetN2K1t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:04:50.7140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b025a64-236a-44af-f75c-08deff9dee6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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

From: Philip Yang <Philip.Yang@amd.com>

Add mutex to serialize LSDMA PIO copy and fill operations for
concurrent access from multiple threads.

A mutex is used rather than a spinlock because the underlying
lsdma_v7_1_wait_pio_status() polls with udelay(), which can
busy-wait for up to usec_timeout microseconds.

It is optional to call mutex_destroy for clarity and debug
correctness, it is no-op for release build, leave it as lsdma
block no ip callback funcs to call mutex_destroy.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c  | 20 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h  |  1 +
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b61c641b5be4f..1503bbf473c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3849,6 +3849,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->mm_stats.lock);
 	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
+	mutex_init(&adev->lsdma.lock);
 
 	INIT_LIST_HEAD(&adev->reset_list);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 4d1d4994ea3fe..05bc281216bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -48,23 +48,27 @@ int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
 			  uint64_t dst_addr,
 			  uint64_t mem_size)
 {
-	int ret;
+	int ret = 0;
 
 	if (mem_size == 0)
 		return -EINVAL;
 
+	mutex_lock(&adev->lsdma.lock);
+
 	while (mem_size > 0) {
 		uint64_t current_copy_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
 
 		ret = adev->lsdma.funcs->copy_mem(adev, src_addr, dst_addr, current_copy_size);
 		if (ret)
-			return ret;
+			goto out_unlock;
 		src_addr += current_copy_size;
 		dst_addr += current_copy_size;
 		mem_size -= current_copy_size;
 	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&adev->lsdma.lock);
+	return ret;
 }
 
 int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
@@ -72,20 +76,24 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 			  uint32_t data,
 			  uint64_t mem_size)
 {
-	int ret;
+	int ret = 0;
 
 	if (mem_size == 0)
 		return -EINVAL;
 
+	mutex_lock(&adev->lsdma.lock);
+
 	while (mem_size > 0) {
 		uint64_t current_fill_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
 
 		ret = adev->lsdma.funcs->fill_mem(adev, dst_addr, data, current_fill_size);
 		if (ret)
-			return ret;
+			goto out_unlock;
 		dst_addr += current_fill_size;
 		mem_size -= current_fill_size;
 	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&adev->lsdma.lock);
+	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index c61ba58c5ee0d..e9a0237efd80b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -25,6 +25,7 @@
 #define __AMDGPU_LSDMA_H__
 
 struct amdgpu_lsdma {
+	struct mutex lock;
 	const struct amdgpu_lsdma_funcs      *funcs;
 };
 
-- 
2.55.0

