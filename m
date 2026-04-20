Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E75CF588EC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 15:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FC210E6CE;
	Mon, 20 Apr 2026 15:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MZYFsvPS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A9310E6CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 15:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJBGng7TU7sAavfGbGWZo26E5VHAm2LnM0agyo53l/C/aJ3W4dA0gbeQy0sWNLiNH6E0VnNTF9Rl8qekLE67gFXSoODVU6iWBHIXAqIBM2wKscaDDiqrMD+JRFtbVgpZBIxBK3tB9avZeuENjUEGZap9JkKS53CfcYzGDiU/owXUwb5k3aH3ZyiecyNOAmf96W6zrmI8MfXBYrJh22rYeHGJaXz75A7Vq1JrXmKKZOX1bMWRP8xl6Dj8AQW0jXsknhRl1sZl5jX29oEz57+HJOw+wYYqjYxwTwC+VuO/RJZnPwStifUn7XYP660ZylpRv4HruywZlp2MtTj4GdtGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PtbD0qi2XbshYOpp0yLgHGdFRHhZMcm26v1XKCcwXc=;
 b=C013aRRTfP+emFoBlnhrIlZ1VmMAu5sCMBGA2AXp+yLDJ4X5W+VNGZaymP7pfKhOwqMG+OoXKLfI4TJ0FxdUaZ5nzjofepdlXdLtIfGvaOqyokK+LusYTTQiWEbX5BVDCKfEcXzswoYtFaAAlDSz3a5sdymjB705CT8VNrWRqLfz780IsoBjJ7+wlIQK25EHCVHVPzvfYRvGCcHREIdEnxENmUa85GFOur4Z7T2y6l2IQAom+Dy43U7WdUsDkS1I5o7CYZjlUx8JCU2RUeTRLftrjADRRS98npV+iBkJ2grsvfRflPoAUt+S3PQ1iqKmTGXuBjp/5rgkh4kX8Befkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PtbD0qi2XbshYOpp0yLgHGdFRHhZMcm26v1XKCcwXc=;
 b=MZYFsvPSPnc5Z38BUTkcKSL6EUTTpliqP1TP+ZXDbJEnAaSyuBo/g09YQvvZ2AwjlDcxcIyK5pS952w3zDXaDZa9V7x/9k7vxUFrFucldWxcZKq0pw8zN9KuK40E3fU3p5zgE1eWu4tnis62weG+p4GMI9FmWn05En58dMIvDFM=
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 15:58:44 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::e) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 15:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 15:58:44 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 10:58:43 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: Make all TLB-flushes heavy-weight
Date: Mon, 20 Apr 2026 11:58:22 -0400
Message-ID: <20260420155822.718805-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 402cee07-dae7-43cf-5c43-08de9ef5b333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tjcCqOuyMNyS81GjcVna7JJMmXpUc67prql7yo6T+VEweTVPAnFeQTusqAhVwI9DCIFzUf221WaZ/G+dis1Z9eoyJCh7aUrjx8Cicpc3OGfltDhi/x1GpGd3y2c2ylJ24TnPre359yw+3vaB2pJo2ARJj8v6OGhC4cujWiZ9SKlF9MprVKH24ada4nyiGIYOB25KOrAJXKtd0zandc5aS6U6/si6YG0Dte6m8SwVcH1HnRL6xJTxxrNUS7r5eQzsYOK4hJJ1tqAZY8k46OmLMw3puCO17xSsSZAN1Yolsp6dUoCd98k973l5ONwdaT1qnLNL9ddZkKOtsPfiSX6opDsyBZRM11Y3kXsfCY+u3LFOUOUZajEBZN2NBdcICzuTFisSpGqhnALtKx9w9V/qssJPeGKSSjxaWYTBsXJ9IS0G+8YBzsMiCl/FcXxbAYBLpmWma9QFcxvG8xfc+/FUcDIYiD04kdM+VkBsXW0u6BYnQ/akWuYCeeevnO06URgCaI3KS7IDDByIbeilfKiUKsgdH4OWj8uyzSQ5zFpKLRcFQkDBhBb4NFfq5HBlOYxI557/gwNHhqxtz/gZVocHywqneykCim/zUfcQenCF2K0Vry5jJ/h/5Egwd9M2fRTmk9E4gm8fC7gFILyN4mua3P8ktSHLzxDfWR91IOBMCjJKSSQnAGk4lCHfoAPdDl73xDUJxoF6b7F3iUwod3bRBix1PilAOPIzFDpLIiIEaBlqVX1RToJSQTi7Ufp0GAoOhJ1wHLKxCEM8pPIX55M+tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6fZ8c9ShnOAmN0QgJTNcmiFEYLjcsPqlqiXTCAK+HywkTaJ+otDyIhkIsHYiYPmSUP26yz0dF6VUtH8Z9mGbJKErydigoZFm+n9a4sMVcfDlnXCyGTxxMJdg43T3RfaFNGic8iSh1l5FbmDYJYaOzhBLXnHO/ZatGnkTvGzIJyPLVk32PbMkL8yDB4A893GBT6hgmTbRusnJDyNn1Y9acPHcTdvKTcjZ50T7kc7deAac7iSkF14UcjJP1/KcZwkMMlZtL2x8QhwzhcGGJy1le3gk3XvjRSRvviwmmSijuKDTxN9wohSsoRS3V8ORN/QA4eGBKSGbe0CROBzvPRoGPRu2CGi1rz/oSlRp7eWEes5T8XGxszhDjv4JMWvMpD4Ywvaow0PSuDVI/hg+qQ3mr4g/oTOh9KXsgzkURadkm9xwEk8vMq1v51z3Ddyyyoak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 15:58:44.3421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402cee07-dae7-43cf-5c43-08de9ef5b333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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

With only one sequence number we cannot track the need for legacy vs
heavy-weight flushes reliably. Always use heavy-weight.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                  | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 16fb39259911..0625104a7693 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1358,7 +1358,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
-		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(peer_pdd);
 	}
 	kfree(devices_arr);
 
@@ -1453,7 +1453,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
 		if (flush_tlb)
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+			kfd_flush_tlb(peer_pdd);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
 		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c1f668f12732..8d9bf4334090 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -595,7 +595,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->adev,
@@ -633,7 +633,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			dev_err(dev, "Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -1307,7 +1307,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->adev,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 53c26b1a25ca..dc8787dc399b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct kfd_node *dev);
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
 void kfd_signal_process_terminate_event(struct kfd_process *p);
 
-static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
-				 enum TLB_FLUSH_TYPE type)
+static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
 
-	amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd->dev->xcc_mask);
+	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
+				    pdd->dev->xcc_mask);
 }
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 015eb61f3440..5090f8c15428 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
@@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			}
 		}
 
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
-- 
2.43.0

