Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D7C79F8B
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 08:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B460A10E5CA;
	Sat,  5 Sep 2026 08:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e81bPWJ5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8225910E5C9
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 08:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n955rcO7JRPYFiattYdDNYlT4ZCKK8ORzF3LXuai0bwdQWYiHecJqi7GP9g7McZA4/fYjBafrnCVGXYh6XiPiXR/5ZHVJSKijZZeCl9XgmQJqawmw6Kmv71F/KffgiQFfjqtq7TBK41dsNw4tTcdbkq+oS2QGukp70kKXSNP7z7mq65QjdaESj3sHNcmNtzMp0D4IzqZMb8VviNHwigpuQceFUXi5EtTEJkto/34PyrYuW7rHzN1PpDFS/Ek/AfVBzZ50dq1S5JOsNTCtUp03orl/yVpfBSCLH+U5Yvc5EHiZtOK7P+XyU243IvVRfXf/IIwIPZxO9CMJ4AOmP1PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKmo0dc0In7gZAsi5jc7PPxku9BQNEmQ6hL20uElpLc=;
 b=CGn/Co1tWUjrQdvByfqVUX6yBrZQu2kTixpUsSRMWf3VymFKxEJaebJrxnqZp8HOpnxCjLP65C4lVEGPo+xUYButc0vodx3CHV+8FMZdI/TlrU/JFSUfyprkRYuspBuhWuRjSGjRejdNziz2u8ddB20XBf9fhVegHBBArIffAlYP/znVvpM534hPIqDKMiuxnTKG6FP8y8KNxRsJz1OHmJny7pN9ujpCpuvSeZO2VBiz5X2dNgT1PLFzT+3BuNzzePIzy/PIY2ZnQ7Gg2fFAYaQ1ZfTozpR0q1ZnUiT/OLVAu7s9HjdqpLs817otRZQndiIVG31I26DfW0rTz1ez8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKmo0dc0In7gZAsi5jc7PPxku9BQNEmQ6hL20uElpLc=;
 b=e81bPWJ5FzghOFqe6fdCXXd+MxAUtWZSXPYFNhfJgxTqsZEySZOD1YslxSkHd+H14+BINC2IAIqvb7EK62fKG0VUYE8ScKFfSrZnyRIpjS0JCelaTzzqr7Ez0yLwREL8NLdevV3Yz2/BFvYTEM5iZtf1oStQOFSQhe909LCCgIk=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 08:20:10 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::3d) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Sat, 5
 Sep 2026 08:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 08:20:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 03:20:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 3/3] drm/amdgpu: Extend second-level trap handler to kernel
 queues
Date: Sat, 5 Sep 2026 13:49:35 +0530
Message-ID: <20260905081935.338775-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb93767-71bc-4d55-9288-08df0b26809e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6wNYylrQcnfH0vE0w8PwNstI7mTcHFIo+Kr03D/zruB9EIoIX30WXz7oL9usLYifBNEbj7zcdlG0o8yViJiHNTDd0f73+wN7pTrujl8JTU/O0ql+wqxFMjwBlAm7j2e8XS4hrsZzUz5/nSg1kbh5Nj8RUhRIvprOWm2pvbGUMkYjFaTAiZc9pacPk3DbUVW0WKFkFMhx8zFKcw+zfSCA5U2T04oYaLVM0g4XKCtUercw2c3KtKqATk5NB9VcDJlqRkgkoRxOhoPDnf0qO6ZRYg5ZsdS+N0toShPdrzUZcq03koBfMpv+Rl3Hwywf/rHk/PQ2ty8jV5dWYljn9c460RVBAuKJT+tABnwpTsJUrJyhB+b62ZaRZbzilwbom4bNpBQr/4gHgYcD+Ypsd+QHNpB0wnNg9Puf7oYKmwjPF1/QGb2P52rpHqqasTuH2EWeZbU7BwKxPzPAKNHQSXL//OOhBPB4BpAyOzDmQLbjblYLyO0D5MpGwwY7IAWcWnge6o3mS8/ZLcSYqEboXkptjBOxjQfMh2AVdKZTMUyw83ApofbU5w5kOqimWnl7osCRVsWcX4zE0av1ipUnLNJg3O6tkr9OSSa5MDiOq2m441zSpcx6KVSlWW9ZioaESVIgIrfnDh6V3iGmV6jouex3cg7wG28knSBGERKI7T01+N5zNK/ZMVjfzISadNvqJVTvK1Ldjdvdmokdiuc7wFV7uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KAIslk7QkYWveZolL1iNrnuFYfhMUtwG/3Do1pcMgIAZVbaFZp6GvIWvEheSIhIkZKCzvoOREcxP2aRlDqyxkxlTzNKo6h79kEqrIYeqYyRbc0e89ah8S+Ala2l+kYzmAsAq7OBdVIfyaQy3H0pYm3gaG8jGZSoE2M6ETv5dxlD9b0o4umiT0YrOLMwfXgg4kX1ricuPHpkFMvE6rNVqhic8sEb5fQSNrmdgXYs5gTUJo+0ZxLNClsX9umVYRPVtx4Sbl8B9qxgKBK30/fnoh6gEG1tNB8szTlqJrQT0v8mxwmqs54qm4CabedqXT4R0g+O2BZo+AF0grFypr3Q5qy+Ms4G/t1ANPAh87uJ9dUDzCHKh966381jdaR1bqNSkwzDpo4L27eIEeWCzAPTtidaWHyLejy+HEs4/ytmPEvoz77fCgwb6otAESs9SEZ6R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:20:10.3361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb93767-71bc-4d55-9288-08df0b26809e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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

User queues already support a second-level trap handler registered via
AMDGPU_VM_OP_SET_L2_TRAP. Kernel queues had no equivalent because the
first-level TMA for kernel VMIDs was not writable by the driver.

Now that each VM has a per-VM kq_tma_bo mapped read-only at
AMDGPU_VA_RESERVED_TRAP_START (added in patch 1/3), the driver has a
CPU mapping (kq_tma_map) to write the second-level handler address into
it. The TMA layout mirrors the existing user queue TMA ABI:

  offset 0  (u64): second-level TBA virtual address
  offset 8  (u64): second-level TMA virtual address
  offset 16 (u64): debug flag

When userspace calls SET_L2_TRAP the driver writes both the per-process
user queue TMA (trap_obj->tma_map) and the per-VM kernel queue TMA
(vm->kq_tma_map). When CLEAR_L2_TRAP is called both are zeroed.

The evict -> TLB flush -> write -> restore sequence already used for
user queues covers kernel queues as well since both share the same VMID.
No additional synchronization is required.

After this patch RADV on GFX9/GFX10 hardware (which uses kernel queues
because user queues are not supported there) can install a second-level
trap handler for shader debugging via the same SET_L2_TRAP ioctl.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: Ie692cc9e6d8334f4124e3297f0520629140737ff
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index e913488ca3fa..cf6dcbb903d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -717,6 +717,23 @@ int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
 	iosys_map_wr(&trap_obj->tma_map,
 		     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, tba_va);
 
+	/*
+	 * Mirror to the per-VM kernel queue TMA so that kernel queues
+	 * get the same second-level handler. The kq_tma_map CPU mapping
+	 * is valid for the lifetime of the VM; iosys_map_is_null guards
+	 * against VMs where trap is disabled or kq_tma_alloc failed.
+	 */
+	if (!iosys_map_is_null(&vm->kq_tma_map)) {
+		iosys_map_wr(&vm->kq_tma_map,
+			     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
+		dma_wmb();
+		iosys_map_wr(&vm->kq_tma_map,
+			     AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, tma_va);
+		dma_wmb();
+		iosys_map_wr(&vm->kq_tma_map,
+			     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, tba_va);
+	}
+
 	trap_obj->l2_tba_addr = tba_va;
 	trap_obj->l2_tba_size = tba_sz;
 	trap_obj->l2_tma_addr = tma_va;
@@ -749,8 +766,18 @@ int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
 	amdgpu_trap_clear_l2_handler(vm, trap_obj);
 	trap_obj->l2_trap_removed = false;
 
+	/* Clear kernel queue TMA as well */
+	if (!iosys_map_is_null(&vm->kq_tma_map)) {
+		iosys_map_wr(&vm->kq_tma_map,
+			     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
+		dma_wmb();
+		iosys_map_wr(&vm->kq_tma_map,
+			     AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, 0);
+	}
+
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_userq_restore_all(uq_mgr);
+
 	return 0;
 }
 
-- 
2.34.1

