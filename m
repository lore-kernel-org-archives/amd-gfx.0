Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AACDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 14:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B038410E1ED;
	Mon, 16 Oct 2023 14:49:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1080210E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 14:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrp9xQU+T8RI6KZlkWvqAA+jeXvKIObHUhNsD5Sj8+fCXWQuDgCcCYSEIOVhmcT9+DfyABPPcRg8YGIB7HE8dnYlSiLHsV3mg7x6kr7+gG7+DGtiHcPOmCGSpkcwuPhx11sXqSh1NH8f5KSSy5We3inmai00/5wX+lgP46b+O7hGlKXTHPXosQ2aoa8PiDyX7rQJcmldE9tENQ0iW1YaIYy8BiiPKGEYHXxgTvblNAfD+sBB2sf2NHWvtUEd0Z4ZXUebq6Q+3VF37JLMJQ611EOGDzITwGv2A6z30kdRy5uwUPcu3sNU831HErpmuPdiu2plLPGYg2mEkFg0uC5AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0HtDLdZ5P3kUt5Y4hrntn3k4eUpPiGTI5hGg7ZAAFw=;
 b=ITTIu4z1f5GNv9xDD23wzv/0Xh6FFzeUMcf8GEHdoBTJ7g82LEjVuGZjngJCCEUJwDe53TKc+sUh7ewHXb2fVx6QOgpJE65bn5F3KbHtiD8gO7dSQFzE5dWU5YhblmDITCFyTtXsa8+mFliQIcKZ66HHAa+jf/7TDkl32Lw2ow4sVJDHmp8SrFHN7+ROOIMIFHALootuvwX7NxyYgOKeO4xBKPDNyGJ+T+Ouga5nJnD9LAolqmPsPUL0JKNOGDsckYzz+grHjLSE0LfQ3PjvxNfIHf8HQrRl2drgqLBuBrivkVU4xoJjG4qPlo83ML9eX93NE9rpSHu/+BsGAHijwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0HtDLdZ5P3kUt5Y4hrntn3k4eUpPiGTI5hGg7ZAAFw=;
 b=BRLoxFTGCamJDofzOxOTRxED7UB8lurwDSLobglSTK1jMTpFB4h8OEcY9od533/G9HXvuh6KvXmmUPUSnWNHr5IcKGv0HYrO+vSrSocPQ/nnDvWAkRdXwRLZ0FRE5qwg/HZpQzZea/uXZ3VDqHL++hS345G6j3gvK9Pwar4NcZs=
Received: from CY5PR15CA0106.namprd15.prod.outlook.com (2603:10b6:930:7::8) by
 CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 14:49:48 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::87) by CY5PR15CA0106.outlook.office365.com
 (2603:10b6:930:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 14:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 14:49:46 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 09:49:44 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Date: Mon, 16 Oct 2023 10:49:28 -0400
Message-ID: <20231016144929.807268-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b3b80e-c358-4119-b58c-08dbce5723ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/DSi0tOMnkV+9oP01j6C5Cclo1zo2zIKq+0NFQEMNITALDShda5ETpFEOzX68Dven5bBJ1YUDUl1LIo6UHDLqJ4Eqv3h3+8hoABQy8A5JCMbMoeZ4C2eg8SvPBCsKpNhou8RJisihh5jumGk7Oz/zWrm+ERn4sD/t04RNiUFcEkbksud0PiXDn5AauuqPYCB7Ne1IujsDoEExYdsnhBsjfmHipCkNnd2520z39KoUNFVLG8wAmnSPHBzfNX5bt6A5m+vmKakXdP7Kp38Dx4uz2MVvim0e02iJPBxRSXeekpKQWMja0kJ//vkbMEBjbqdstZGJb1lt7G7B/3IyRwMHZQlzG0wmmZyGah0iXqOdZQ3r8g7GBNfAMwnwYaq7zEIOy7j7HXP+gxtw/wLVF0YrwBTKlAtkuM8D9NR4xHNSLGK8X2LnHjUN26esvMGmMZ/5X3GmR7txNK7z3JxkpZyXEFSQ7R6qnbDmdQZQYKMAuGudi1wHxsQzY1s2PSEoJ/vvkRvm99/g/V66Bv7BCvBFNhvX8nI5rnUGP4thJtOnRHgI8JMXhxsbj6QI86xQaZL08cXB9mYOnpoKj4jGMObxrdUiMXEsRrk83alHVMLTy2Z6YYjHAq50QCfH50vcGLSXz61kzOlh1AyhLYkfDc03HDdjIYkeWTORGWP9aWNsaFKM1oxUFuJQGqAqLmHwoONp07qG00Wzx+IamUfCYRgbGSlHmhRG8OkUtg8bAQuszJ0x8YjkBm5ue5UL4IHpz8YSFc8Xw3IJgEkEHh9qNs7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(36756003)(40480700001)(8936002)(4326008)(41300700001)(8676002)(83380400001)(47076005)(70206006)(70586007)(63350400001)(1076003)(63370400001)(2906002)(6916009)(316002)(5660300002)(36860700001)(6666004)(478600001)(7696005)(16526019)(2616005)(26005)(426003)(336012)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:49:46.0588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b3b80e-c358-4119-b58c-08dbce5723ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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

Because the dmaunmap step can now fail, the unmap ioctl UAPI
needs two new arguments. n_dmaunmap_success tracks the number
of devices that have completed dmaunmap. If a device fails
to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
the number of bos on that device that were successfully
dmaunmapped.

This failure can also cause the sync_memory step of the ioctl
to be repeated; it is idempotent, so this should not cause any issues.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 14 +++++++++--
 include/uapi/linux/kfd_ioctl.h                |  2 ++
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3ad8dc523b42..781642871900 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -302,7 +302,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv, uint32_t *num_bos);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a15e59abe70a..cbd6032f3d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2094,21 +2094,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv, uint32_t *num_bos)
 {
 	struct kfd_mem_attachment *entry;
 	struct amdgpu_vm *vm;
+	int ret;
+	int i = 0;
 
 	vm = drm_priv_to_vm(drm_priv);
 
 	mutex_lock(&mem->lock);
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->bo_va->base.vm == vm)
-			kfd_mem_dmaunmap_attachment(mem, entry);
-	}
+		if (i >= *num_bos) {
+			ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
+			if (ret) {
+				*num_bos = i;
+				goto out;
+			}
+
+			if (entry->bo_va->base.vm == vm)
+				kfd_mem_dmaunmap_attachment(mem, entry);
 
+			amdgpu_bo_unreserve(entry->bo_va->base.bo);
+		}
+		i++;
+	}
+	*num_bos = 0;
+out:
 	mutex_unlock(&mem->lock);
+	return ret;
 }
 
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 06988cf1db51..a944e255de4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1379,6 +1379,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		pr_debug("n_success exceeds n_devices\n");
 		return -EINVAL;
 	}
+	if (args->n_dmaunmap_success > args->n_devices) {
+		pr_debug("n_dmaunmap_success exceeds n_devices\n");
+		return -EINVAL;
+	}
 
 	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
 				    GFP_KERNEL);
@@ -1434,7 +1438,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
+	for (i = args->n_dmaunmap_success; i < args->n_devices; i++) {
 		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
@@ -1442,7 +1446,12 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
-		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv, &args->n_dmaunmap_bos);
+		if (err) {
+			pr_debug("DMA unmapping failed, acquire interrupted by user signal\n");
+			goto dmaunmap_failed;
+		}
+		args->n_dmaunmap_success = i+1;
 	}
 
 	mutex_unlock(&p->mutex);
@@ -1455,6 +1464,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 get_mem_obj_from_handle_failed:
 unmap_memory_from_gpu_failed:
 sync_memory_failed:
+dmaunmap_failed:
 	mutex_unlock(&p->mutex);
 copy_from_user_failed:
 	kfree(devices_arr);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..edeeac370201 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -467,6 +467,8 @@ struct kfd_ioctl_unmap_memory_from_gpu_args {
 	__u64 device_ids_array_ptr;	/* to KFD */
 	__u32 n_devices;		/* to KFD */
 	__u32 n_success;		/* to/from KFD */
+	__u32 n_dmaunmap_success;	/* to/from KFD */
+	__u32 n_dmaunmap_bos;		/* to/from KFD */
 };
 
 /* Allocate GWS for specific queue
-- 
2.34.1

