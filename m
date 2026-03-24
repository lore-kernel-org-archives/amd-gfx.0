Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473AAFEC11A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB63910E5E2;
	Tue, 24 Mar 2026 21:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpvB1ev6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948D310E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATJ4Vv6pTpvFN5og9Hu+m5UCcs8acGhgvqJx1DdNkTzzMpnwp9b6cOmkKX5ifOmB7I80R9TElvdVpdI8KQ0eFin/+BjoBVyIXLEOKn07mCkLvrZsiZVvH6B6JqHVjB7y7vqM95UbDXw5eJrF4tTMlN1DLoUQvEQNp5/1nkOCIU4lgnwiQyqQwzKSYHUeOOjfkuKk52nB1jyiOK7RP4mKG05zkT7FuT8rjbanAIMw6tVW8FnvA4iNzLZ4MLca0ltEA9PKwOfG9TI62OseL05NE88bDWjKgHNGaV7KeneLA0yw/j26AgRTukRhKOJkKumRCMFRDiwOO/ZD7/W6xQsBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2bytwXHfyyxRFYGwEc+0ZhkvOu+0HHH/UTFoYqAky8=;
 b=Cjnb3jAZjMWr6ng+CakDGcLg2QtWpI9byS9eNNZnV2N3lUp/6SdGXrVVK8KxgRCKRH/ukQyfvJs/tLvX5MqOaO6JXNQKUSIj40xmLvK7SPNAFKmmHTrJEMI2q3r90qND/lRUcKaAru2hPJz10Cei8zPy5luwY7Vb4FJhuKhwefE+5gd+W9YuvP1HohtXL5HCLeoSQwVfNR2xe64bsOiNHfsv5VTNqU1F6x2U40W4sGhMTREg+sevFl48pV0UoISu0NUXAzgDMzrBeUO9nCxeravP6C4J5KwcvbFQ1SQU3GdeyvKTRXoxAzTUKeIWExOTaR3+y3zJWhwNzAy85qSkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2bytwXHfyyxRFYGwEc+0ZhkvOu+0HHH/UTFoYqAky8=;
 b=UpvB1ev63u6skvzCf27L6DWjq9Dem7CLAl+bwSRMeG6mCSohGuHkg16XkA6BqF5l3cTypHJubzuGJBAgGQsoMawD+YyLFroM8t2EbyZQu+0dpgrgNKARA28gCY+xgrF0gVbHTt3BdNE4DJ2d5ANp6gK/SjFbtm34eUFji5qtsrM=
Received: from SA1PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:2d3::20)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:56 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::a4) by SA1PR03CA0009.outlook.office365.com
 (2603:10b6:806:2d3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:52 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:43 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and
 amdgpu_bo_free_gtt_mem
Date: Tue, 24 Mar 2026 17:20:18 -0400
Message-ID: <20260324212030.822932-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a9df15-67a9-46e7-9cf0-08de89eb3aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8AlIgh//x6TAsoJDbp1WKhIhvhYWCMyxNaCfoNOaR6HDS8b9GCRe9QGP0aglxWWMPL0r7LeQ0Fe7ymSMN7Gu9kjtfyPaOniV8/7a8Gs3vEjgsUCGpBN5A/Ca+obUEfTNe6x8FKdzYee0FEt4I2iAayT6q7EejiONRrR4l4ginK8g2SvD0+Y8oiw4HJGViOofo7RHrwHOTgAbPDPI046/VGeQ+BYH7QUIwvTRImSftYm+9CI4auW2aAUM5o8rs4UhLNpLXMiugccMtAY7ucxQw5ZxBogE0rG0HKn3uFXt5SJxAeoNsuHlVHPyx36ro6vdzQXASv0HzbRbGVyUTSV0OTOAZiS04TjRkOFOxYWhqx+NmzPKbgK1wiQMC/dYpuc/ZpcZzt/7ZEh9O0ZBu/fPa/kzHM58xYRqXZGnOuAG4ZJSxiLCpbGzKdeBtT1iJIUbxNL+MC9clLnXIMsv01n0df8dIgkI3eX7X9HbQxGuo6/r52L9fe5pPuNaNXEJgFhUeIQ3UfpWs3Sy9an28t4QbIAEOgNnvJW/nOwAQ0619jIZaMwIXhpFoSdtKitsf6UnFOB4HOsMmJQzgFmC/DOlO77+9VFRiO9lcEaDg86O8ByL//zn+3RgvL7mUdW0yN4RaEJfO6hPcosUEaYSEVmuqTjD8JMfwecPUeEi5q2Z8uTJ9NI4xqaOgn47K/Zsr2eMEOUwn7co3WBSHaMIlvq1zInNwanjrRCc8pnH71Irls9A2uUqCut/0FXz7UGk0/as0c9IFoxR346Zk+SgR0e1NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SRaFLLNG12DQyC8RWhiH7CXT0RkwSYeijXjuGaVsQWHy96VLQBROwBhBONI1eu5NnpUQgB47ucA8rN82EFVO2t9pRSyaNO9e6pWRsGL7VQqns95xcJX80qHArdGw4wFiJesebml2Nv5PNw5ymg4+lcDbZGonPT5vWT94dqNRBXTdyVBbaKk9I2o/fRXqZHngybAuSw2w43ua4N6pgfy75V0cbhEMzfDPNWChu/Xsor8m/z5SSEO6oTrObHkok0QAG1hNKY+87CvYzeLry/7JOxKRx5BsnPn+biPulfXnwi3X1dVV9ag9MY7StKfe2Nr4Ie8wCofKU3UToWBzFH8/FIp6LMBeUJNJGhPeZsipBKRy6ZwTApafTFoXY5TOXfO6NbzqqJsq3Bg+IYrS7tFGiV853SumBMmWXpuDAtcKw6n5NmCXldg+w/VDVlt1bYAS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:52.6582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a9df15-67a9-46e7-9cf0-08de89eb3aa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 97 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1fb956400696..993171979896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1696,4 +1696,101 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 
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
index 1a3a7229de56..7b88693eb6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -720,5 +720,4 @@ void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
 		list_for_each_entry(mapping, &(bo_va)->valids, list)
 #define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
 		list_for_each_entry(mapping, &(bo_va)->invalids, list)
-
 #endif
-- 
2.34.1

