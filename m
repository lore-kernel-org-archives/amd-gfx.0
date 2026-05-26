Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EDECD6E41
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5FD10E67C;
	Tue, 26 May 2026 14:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbP8FOpI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D7E10E66D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk6jB6YBMIq81c40loYRRcn616LQEZK5DJ3vpMlre8tceHermsEF3KcdwujwR8+QndsKoAaI2QDdCWLicXixG7VHC3VvHp4diiuP6SjtfkwiCresOGtsLlh/yeoV9pCh5nwi+dGcrm28i3vLnaafB42KmUeXQHrryqRRrblaMz4aQb/QOwWpOWjyoofqxvS4AzDp6wPkveinQ7UtdlSDrVm38G6s4eEd6bXxnGx08ul+c9TP/XXmmAXgAPJQq83b/DRnkN7vAICMerbp+4bHaBifvS5FMkX4Ly2uDgjtpgjW/OshLbm2k8SKdyHLOOc95QKE58OHXdoxt9YK+Xn+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gesbGdeR6Wv6XCfb5j0x5HoEFnPVFZmHp/J0Zcq+f+g=;
 b=QPVH6wvDWrN+UOvwwuXcVs9shzqpnWjUn3seQrK/cu89mv4I6+GgVOZl+w4trczf6+uFjhLAZKTLvSWFBuKB8PwUQJNITg0nRfT8YFYgKzBXeLJEuLtojxpp1GkxEb1Qsj/wEikvH+l9tvvkCSCxy9oOrGnSFlUMDQD6Tv+TmxUPsaZ6gNxrGTRTe6upsyYi9fKQhdtElmsY7Oeh4ze7CqDBAK0BYllibXfcXZnp0R56+9//Aa06CT2Un5eNF03Fw8lORo8aYMqz47ZQmRaD/uCyn0BXJDBBvEAbMyFhwE4qlnGGlA2xFl9+78wxsKHMNh93UvpftGeHJ76IYxHRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gesbGdeR6Wv6XCfb5j0x5HoEFnPVFZmHp/J0Zcq+f+g=;
 b=lbP8FOpIiBJ0esEdD+uqWnn9pwBRNwLTpmQkpTo9ikntv2JbaV7LzX7CUiwtM45kWAehBXNZjqcJIrBcwwnTZm8UsyB75jb8EroY60AYAXQcCGK19/AWLd4mR/6o0Nep2SFYGREbq9GBp1m++GcicF8I5L5yI9OrlsWSRZeNqwY=
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:11:55 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::a3) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:55 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:51 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and
 amdgpu_bo_free_gtt_mem
Date: Tue, 26 May 2026 10:11:17 -0400
Message-ID: <20260526141129.592886-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4ec911-9d79-4a00-a00c-08debb30be07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|6133799003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7rD5uaVCuXb2dwS4X96gYTEhz6SiUGxAi6ONCgaLXdJKUaAGpu0lxiPo9Y+52WPi+Fya/Yjd4AY75VQNScHM8P9peLZfdtQUWpQfa8j6alWW6o+G4WBaG7d0LxhWJje/bT1hO6UoRe9nzQet0UISvvOV2RW9mwP869YG9ohjBghRCALunXbDsd5Hvd/lSsVYhhzvpEuOwRj2uOdLKZE8Al7HmSE+qDpjNQkvKTT44OcEyk81nXTuK7UJShac0QOe9cZ13rBGJ+BS3To/RkM8bp4t93ga1+7nCK7TfoeMoaHlj92JFbjwbXZqUufWyox2VNbq8dO4vGp0PXKWYouecyLrhtPD6Me0Sw0Rp06Ma00fT0lFDImEkPoAV/wA6XMZ2yhDu/AmaM/2acamt9r1jC2UnyYqNFrMuSqC1Y0OjSF2P6jOTgs4Q4ws6/N2dtEiH8ocpMdTrZBSgM2Ve4rtt/r5aL48MIHgxb71FeC6IzbAXgqOSydBWg5Wgr8x3KnGSxpR1KtATESrJ7w1Zrt22AZlRYy48zAiee5lYn6O4oVZL3b7tT52x1G7p5HDZV8dSaiBk87oUiGQGO1ZQMMpITLTK0OCaJTAkuHE/t3rGIKjYl5NGqJaQcthxpupl7I2P6L83y612oyO5XJjqZSzPnbwQp2jB+yvd/Z/3uPGTcS5dXXVdDZAN1ZKdPZnhVjvK5yHuGT1ZMOlwb3EFWQutV6sCrAnUrnGnVfAgnUZvwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VBDVPDL7x8hx290fuUvaJHVgJNio2mCUdFB+tme/cMHo4Om30var8W7it8H6PdEXFgdoHpcGEsd3zyrjRTVFloeBoV2ssdFwIH0ViBGBDOwnMmiVURLDAv8271po0SOsBAKI1Vf1fq6xufBm9+28mvfLac5a6r/m1Iy1HLBVeQp04XaQ50LB4LA2vGulMnm2tCzy/kjv+C7ppuaExA6rdd4+C3GwRO+A9PFX7Q6dopuaP+VRhLHJOcfV4UgObyaV3if+zd+uk+a6QtW0VKvMhOwvfcucJL8g5wgo0NupOpZKDPSX4apAQi9BP97NycjXiQigOvVDH+BDNA4oZ0SGLFz7IS/EJEliFjn5e/YuIBm4Nb4bhvl4Tzt0dj6sHM/7GUSdoV570pBXI355KM/V09WMuW2WxJWq2/uWbUN7QEgHC4SSTtjYwYE/S+C4cWRW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:55.3758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ec911-9d79-4a00-a00c-08debb30be07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

two helper functions for allocating and freeing kernel-internal
GTT (Graphics Translation Table) buffer objects, intended for use by
the SPM ring buffer allocation path.

amdgpu_bo_alloc_gtt_mem():
  Allocates a TTM kernel BO of the requested size in GTT domain,
  PAGE_SIZE aligned. The bo_ptr_size is set to sizeof(struct amdgpu_bo).
  After creation the BO is reserved, pinned to GTT, GART-bound via
  amdgpu_ttm_alloc_gart(), and kernel-mapped via amdgpu_bo_kmap().
  On success, the caller receives the opaque BO handle (*mem_obj),
  the GPU virtual address (*gpu_addr), and the kernel virtual address
  (*cpu_ptr). All intermediate steps are rolled back cleanly on any
  failure via a chained goto error path.

  Two optional flags control BO creation:
  - mqd_gfx9=true: sets AMDGPU_GEM_CREATE_CP_MQD_GFX9, required for
    GFX9 MQD-compatible allocations.
  - is_uswc_mode=true: sets AMDGPU_GEM_CREATE_CPU_GTT_USWC, enabling
    uncached speculative write-combining CPU access to the GTT buffer.

amdgpu_bo_free_gtt_mem():
  Reverses the allocation by reserving the BO, unmapping (kunmap),
  unpinning, unreserving, and dropping the last reference (unref).
  Handles NULL gracefully and logs an error if reservation fails.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 97 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..0a163b5e850f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1701,4 +1701,101 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 
 	return size;
 }
+
+int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
+				void **mem_obj, uint64_t *gpu_addr,
+				void **cpu_ptr, bool mqd_gfx9, bool is_uswc_mode)
+{
+	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo_param bp;
+	int r;
+	void *cpu_ptr_tmp = NULL;
+
+	memset(&bp, 0, sizeof(bp));
+	bp.size = size;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	if (is_uswc_mode)
+		bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	else
+		bp.flags = 0;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	if (mqd_gfx9)
+		bp.flags |= AMDGPU_GEM_CREATE_CP_MQD_GFX9;
+
+	r = amdgpu_bo_create(adev, &bp, &bo);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to allocate BO for amdgpu (%d)\n", r);
+		return r;
+	}
+
+	/* map the buffer */
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to reserve bo for amdgpu\n", r);
+		goto allocate_mem_reserve_bo_failed;
+	}
+
+	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to pin bo for amdgpu\n", r);
+		goto allocate_mem_pin_bo_failed;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (r) {
+		dev_err(adev->dev, "%p bind failed\n", bo);
+		goto allocate_mem_kmap_bo_failed;
+	}
+
+	r = amdgpu_bo_kmap(bo, &cpu_ptr_tmp);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) failed to map bo to GTT for amdgpu", r);
+		goto allocate_mem_kmap_bo_failed;
+	}
+
+	*mem_obj = bo;
+	*gpu_addr = amdgpu_bo_gpu_offset(bo);
+	*cpu_ptr = cpu_ptr_tmp;
+
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+allocate_mem_kmap_bo_failed:
+	amdgpu_bo_unpin(bo);
+allocate_mem_pin_bo_failed:
+	amdgpu_bo_unreserve(bo);
+allocate_mem_reserve_bo_failed:
+	amdgpu_bo_unref(&bo);
+
+	return r;
+}
+
+void amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
+{
+	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
+	int r;
+
+	if (!bo || !*bo)
+		return;
+
+	r = amdgpu_bo_reserve(*bo, true);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) failed to reserve bo to free", r);
+		return;
+	}
+
+	amdgpu_bo_kunmap(*bo);
+	amdgpu_bo_unpin(*bo);
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 912c9afaf9e1..0102d43b2edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -353,5 +353,8 @@ void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
 bool amdgpu_bo_support_uswc(u64 bo_flags);
 
-
+int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
+				void **mem_obj, uint64_t *gpu_addr,
+				void **cpu_ptr, bool mqd_gfx9, bool is_uswc_mode);
+void amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1bbfa8744e01..ed9a228f5cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -747,5 +747,4 @@ void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
 		list_for_each_entry(mapping, &(bo_va)->valids, list)
 #define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
 		list_for_each_entry(mapping, &(bo_va)->invalids, list)
-
 #endif
-- 
2.34.1

