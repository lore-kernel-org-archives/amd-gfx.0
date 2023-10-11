Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47663CDB476
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 18:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2FAC10E06B;
	Wed, 11 Oct 2023 18:22:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F7510E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 18:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4Y1KtCOO3xhzygRsJhO1qZBoX2Z3Y7UYGaoV7Rhz6fVjfVWNfkFRgjowBzLzRmJrDGlNLtpupDGHNaQhBrwMwhofSU/HSpttplEAxJxtaiZD3lM/evV8JdFkzfsSRAJSVeeqLJEuQn89lJzWQEilPLuhfE0s1AznPSrWybPL+YCyEGePitjQLiW1JHMYYpw3RjJwrzXBdzA3w7H/cmZ34OjI8Us8T5zaURS5S1Ek54k/8jVnTGn0vDCx45HWBZ3XMTwywVuxyEgddSWxH8fOr82fQ9/mznhWEK7ssc35OUAI1ghui875BYE/KesLgW+g/ROeQXwD4eV6TaCe71d8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wny5DNLpnrap1S++nU3LFMF+LpMV/+bU33wOUuwb8KE=;
 b=AGauFHBx3DFE5ndcrDBmnrQDwgiXEIj4GZsEA066etk6ZVbvzmeaEtfS4P0WxKdZNu5FMKo/6O7TcO1YHbW9AsKM0slUIa2jakc8YRiBM7ITPudqLk+aakMiXDN2xdg+4mMtwCFk7gTepGjjHn34Y/n5JYNXvwi/Gdos9x6aHk70X7+VAla97gz7v/Xmbcu3/Vy3AqP5bhhFDqUyEnpxTZjJSWQctyjGK8hIL0MJuTR78kkJM5RjIt3elNP19esAg7HYOaQ9+jyRZDMGNVKaGQmwObFaPRwWRh1VRupMxOiy7brZsHAAjn8FyUyzWKX61gvuvhHx0l6xNmp+6ZwkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wny5DNLpnrap1S++nU3LFMF+LpMV/+bU33wOUuwb8KE=;
 b=T+ImnWt7KMIL4aBy3eY6VQyYp0/NFwE/uLs1FnV3gEE8ef4Ork1RlZxJPtSO01GnG2t+loESRcODESZyj/YRyWmmSvbyi4Z7AtVxW1bB7AsrdX3DAIGpckLPxK7wNXLu4/9C9H462k9xCGhS9/m+11jM3Ju9F8Dt56aEoIeFfUk=
Received: from BL1PR13CA0274.namprd13.prod.outlook.com (2603:10b6:208:2bc::9)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 11 Oct
 2023 18:22:51 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::2d) by BL1PR13CA0274.outlook.office365.com
 (2603:10b6:208:2bc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Wed, 11 Oct 2023 18:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 18:22:49 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 13:22:48 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Date: Wed, 11 Oct 2023 14:22:34 -0400
Message-ID: <20231011182235.569096-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4e1180-7597-4df8-bd34-08dbca87138f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lonVCgEWnlV/rZGcvM4cVM/I/Tgvxv88anDMPuCrYo/H8Rq5YDRiTHrQNqwfzpQ+3ZULGDIjN0XmYqAuObgs9FGOdlWB8o6GI3Nz+BrLx9mHQj4vtelk7HvaUENcPvZuHrg/i8deoc4q7T/K/NxfHXlKt8ny+QFE/R5R0LE8N6WHcXR4Yqq6cxsN5p9GEEfcHZZiiEuoCEE83d/RP8tb4KKBTxUopXc1c73uTAz+VABtO3+7f5xBPIBwOfLP5gvIAsajioTlC+4vRLS4OUJ4uLcNn/J7f1m3I+k6W80I0/rWCuzmxlXSFEOHJuAorhF2Pvhrv6/2JM9/d2JP1UuLjQw90eWwG/dB5Pe99I5+JjF2++g4egCK7ujW0cvqW5Xaew0nGOD51Tn61ivt1+FD7BwcN9G/8UFYQhhkJ81nN1NX+/KzUZLpZkuV2sDTKjr/rzQECib/rokR9xkJCqRzCsQsbLHWfFyYPIpNxQs4QGMil9LjTqCQZwCEylowag3douJhrP74zxksB/UvsawBWNY49hjHOVy6oqDkgdME4a64j2G4Jd20E6sWmaqfnbXybkxltHblxIVV3KbnZwnflpekOn/lgFqhEmrI6NRQb/8zWgFo+vJfrE3FSfzKDrqEDkQ53vyaoKmfVvz/YmdGjEDIhLChWWDEcWV9uKgcB8ZNjk0jIBQTA/ipXlcdezEb8FtuOphXAppxCExXZvf7wrVVhWZ6frGth2j8Sc3kXGtzC2ppgld/1fvERt7CMQlSfwwzCyHDD+BvSchFSChRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(478600001)(6666004)(40480700001)(47076005)(2616005)(6916009)(1076003)(336012)(40460700003)(426003)(83380400001)(16526019)(36860700001)(26005)(70586007)(316002)(70206006)(8676002)(82740400003)(41300700001)(2906002)(7696005)(4326008)(5660300002)(81166007)(36756003)(356005)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:22:49.9702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e1180-7597-4df8-bd34-08dbca87138f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dmaunmap can call ttm_bo_validate, which expects the
ttm dma_resv to be held.

Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3ad8dc523b42..dba4f6b7a2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -302,7 +302,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a15e59abe70a..808deec8aa58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2094,21 +2094,31 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
 {
 	struct kfd_mem_attachment *entry;
 	struct amdgpu_vm *vm;
+	struct bo_vm_reservation_context ctx;
+	int ret;
 
 	vm = drm_priv_to_vm(drm_priv);
 
 	mutex_lock(&mem->lock);
 
+	ret = reserve_bo_and_cond_vms(mem, vm, BO_VM_MAPPED, &ctx);
+	if (ret)
+		goto out;
+
 	list_for_each_entry(entry, &mem->attachments, list) {
 		if (entry->bo_va->base.vm == vm)
 			kfd_mem_dmaunmap_attachment(mem, entry);
 	}
 
+	unreserve_bo_and_vms(&ctx, false, false);
+
+out:
 	mutex_unlock(&mem->lock);
+	return ret;
 }
 
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 06988cf1db51..21d4e7d46238 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1442,7 +1442,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
-		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		if (err) {
+			pr_debug("DMA unmapping failed\n");
+			goto dmaunmap_failed;
+		}
 	}
 
 	mutex_unlock(&p->mutex);
@@ -1455,6 +1459,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 get_mem_obj_from_handle_failed:
 unmap_memory_from_gpu_failed:
 sync_memory_failed:
+dmaunmap_failed:
 	mutex_unlock(&p->mutex);
 copy_from_user_failed:
 	kfree(devices_arr);
-- 
2.34.1

