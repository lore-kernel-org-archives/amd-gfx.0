Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5585C83F11
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Aug 2023 13:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE9810E096;
	Sat, 26 Aug 2023 13:42:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3460E10E096
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Aug 2023 13:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDr6/bLD7obcEgzLY8GUuSY15pu6Uq0GRycQupPu+HZlWq/G0KY0dSnmz0GY7slU1EbgL5SpUfnksHphAa0kSP/TzuNTacdeRpPHX/yboVpG4gLkgHLXljzb0HD2joUWYPHUBFaPK1Jf9l+hBO4wuT7Rq4xckoCKyxVixvRSfEiGeY3LmMCc1RzyhRyW8RzPQDkXCFb6UGb3iwQ907i9TezvcIgrW7XIbNCoazPDvoqKJ7rLuiSemkOLIjsTyCrZFh+xU+qMhdPBUhr36DjEWIlHMlrQ/vqhCyMfVFkRE7K+/ONceywOHu5g2Cs70Oegvn6RSk8OAC57RrdWxwzOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9qhB3zL6O0kxoOGxp8j+i9+Li5psWyQAThs70nZfuY=;
 b=mN5HxJiTgINWgLJ8jp3aNAqZNd4NQULP28AcM2Gmrr+op/iRHg5e0EmFebpOdjs0ntxO3SYc6PopEw0hP8Zs4eCzxMy/uqXVMzNJkcxcG+OKk9K0z02fsTJ5sQ/PbzHinT5km/gEM/XFwnKXkWSyHSAvIQcCe43M0rJcdzUO05OO17HHrC+0ITLvtunPALL1kdMezq0nrORggLvg17afexEubbu14HGhd6zUJC1TnzR5SXNsNs+eZr/XMyL0muN23U2p/mAa5vEGA/vke529bSkLw+l0mnzLMix8x/FLo1nrz2sd/iBZ44uD/VkROPNX/i7Rffx72jOt54TdamESYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9qhB3zL6O0kxoOGxp8j+i9+Li5psWyQAThs70nZfuY=;
 b=PGne+6fs4pJyuoTlMtRt+vgPjuYqQ/wYpJ0HFULam2eru8BH9yGIS0SHSOKAxswfruBgvuQyV4UOK49I4PaSj7qahB6+/qtHF6+c6BZhCTES50n4yXRaJhg+7SAAAtct9Rv6VK45AhcvMfJpuS5K2HG6Zj0h0URabltOog720sg=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Sat, 26 Aug
 2023 13:42:05 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Sat, 26 Aug 2023 13:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Sat, 26 Aug 2023 13:42:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 26 Aug
 2023 08:42:02 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Replace pr_err with dev_err
Date: Sat, 26 Aug 2023 21:41:48 +0800
Message-ID: <20230826134148.1735570-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f1530b-7116-4dbf-bd40-08dba63a3c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZI96midnrp0ul5J3YK023Lg0rncHkDr9B1VVm9sClKhp9lFUQZL68dhPPQgsuJaKHFyEEjsUmwMlkQApMs9WP8J+QVDN6x9sMCMw46cu3miNgwsntTmQ7BttOF4vBfj6JWqdSL88pBFPtCRBaInrmZmnDQFc3Ta2KIO0FI3Li+6QD9+GPWa3b16cmBPrjXqk40ZSWm3HMST5iEN8OFJzkIUZy2h5+H2SFzHqiLvHxCNQWiKoruhWVHYDWw1DeJ+Qh2NOlvaPDi8CKpRE+XaD84LPkFupGdyA68u1H+SjYBwSM+NVPnhN+uVv95KGqv84cBQuT6sHpX27mOmWQMJ1wwiDxocOyXnb+QM/2J7KuT84uJhK8USrvFswY0YU7cme+sgLedFHPuzB2o20W2or0vdLlbvEZrU665+xRJWwYJEN50ddZHzCbuhb6tPBBmzubQVPCjPodo2ItaFn/3+35dzzwksDLgFnbfmVE7tuBQr+tNv/o3xBtvO+tMCAEObMVLxof1mtES/cYtrRusumAT2a3jpUgBNHmwBSXQgM4x8Ckdmp0yQQukut9ykBhWX6ZQrwf51zbjIfUfMCWagI3bQyJXpET5Z0OuwcpgZdprSkqRb/rwUC50MTAHxkT8yvOxHlcDfaTEd30KIpFViP1kMzk3N1FHCXa8Md/EfKe1dVy0ll0T0/E4JKxrLReK6gq36UJjyeo4mzOrwobye3JnPeQxKXFh3R8HgGYSwj96HGLeLGILMreDVNSbEEoibb3HipXYIt5sp35gqE53a/dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(8676002)(4326008)(2616005)(16526019)(40480700001)(26005)(30864003)(316002)(41300700001)(6636002)(110136005)(70586007)(54906003)(2906002)(70206006)(1076003)(44832011)(478600001)(66899024)(6666004)(7696005)(40460700003)(36756003)(47076005)(36860700001)(83380400001)(336012)(426003)(86362001)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 13:42:05.1858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f1530b-7116-4dbf-bd40-08dba63a3c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
Cc: le.ma@amd.com, Lijo Lazar <lijo.lazar@amd.com>, asad.kamal@amd.com,
 shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace pr_err with dev_err to show the bus-id of
failing device with kfd queue errors

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 116 +++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 2 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b166f30f083e..cd6cfffd6436 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -232,8 +232,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
 	if (queue_type < 0) {
-		pr_err("Queue type not supported with MES, queue:%d\n",
-				q->properties.type);
+		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
+			q->properties.type);
 		return -EINVAL;
 	}
 	queue_input.queue_type = (uint32_t)queue_type;
@@ -244,9 +244,9 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r) {
-		pr_err("failed to add hardware queue to MES, doorbell=0x%x\n",
+		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
-		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
@@ -272,9 +272,9 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_unlock(&adev->mes);
 
 	if (r) {
-		pr_err("failed to remove hardware queue from MES, doorbell=0x%x\n",
+		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
-		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
@@ -284,6 +284,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 static int remove_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
+	struct device *dev = dqm->dev->adev->dev;
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	int retval = 0;
@@ -294,7 +295,7 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 			if (q->properties.is_active) {
 				retval = remove_queue_mes(dqm, q, qpd);
 				if (retval) {
-					pr_err("%s: Failed to remove queue %d for dev %d",
+					dev_err(dev, "%s: Failed to remove queue %d for dev %d",
 						__func__,
 						q->properties.queue_id,
 						dqm->dev->id);
@@ -443,6 +444,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd,
 			struct queue *q)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int allocated_vmid = -1, i;
 
 	for (i = dqm->dev->vm_info.first_vmid_kfd;
@@ -454,7 +456,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 	}
 
 	if (allocated_vmid < 0) {
-		pr_err("no more vmid to allocate\n");
+		dev_err(dev, "no more vmid to allocate\n");
 		return -ENOSPC;
 	}
 
@@ -510,10 +512,12 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
+	struct device *dev = dqm->dev->adev->dev;
+
 	/* On GFX v7, CP doesn't flush TC at dequeue */
 	if (q->device->adev->asic_type == CHIP_HAWAII)
 		if (flush_texture_cache_nocpsch(q->device, qpd))
-			pr_err("Failed to flush TC\n");
+			dev_err(dev, "Failed to flush TC\n");
 
 	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
@@ -708,7 +712,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	pr_debug("Killing all process wavefronts\n");
 
 	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
-		pr_err("no vmid pasid mapping supported \n");
+		dev_err(dev->adev->dev, "no vmid pasid mapping supported\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -729,7 +733,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	}
 
 	if (vmid > last_vmid_to_scan) {
-		pr_err("Didn't find vmid for pasid 0x%x\n", p->pasid);
+		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
 		return -EFAULT;
 	}
 
@@ -821,6 +825,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 {
 	int retval;
 	uint64_t sdma_val = 0;
+	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mqd_manager *mqd_mgr =
 		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
@@ -831,7 +836,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
 							&sdma_val);
 		if (retval)
-			pr_err("Failed to read SDMA queue counter for queue: %d\n",
+			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
 	}
 
@@ -850,6 +855,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 			struct mqd_update_info *minfo)
 {
 	int retval = 0;
+	struct device *dev = dqm->dev->adev->dev;
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
 	bool prev_active = false;
@@ -875,7 +881,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
 		if (retval) {
-			pr_err("unmap queue failed\n");
+			dev_err(dev, "unmap queue failed\n");
 			goto out_unlock;
 		}
 	} else if (prev_active &&
@@ -894,7 +900,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 				 KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
-			pr_err("destroy mqd failed\n");
+			dev_err(dev, "destroy mqd failed\n");
 			goto out_unlock;
 		}
 	}
@@ -1088,6 +1094,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				      struct qcm_process_device *qpd)
 {
 	struct queue *q;
+	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd;
 	int retval = 0;
 
@@ -1121,7 +1128,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = remove_queue_mes(dqm, q, qpd);
 			if (retval) {
-				pr_err("Failed to evict queue %d\n",
+				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
 				goto out;
 			}
@@ -1225,6 +1232,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
 	struct queue *q;
+	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd;
 	uint64_t eviction_duration;
 	int retval = 0;
@@ -1265,7 +1273,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = add_queue_mes(dqm, q, qpd);
 			if (retval) {
-				pr_err("Failed to restore queue %d\n",
+				dev_err(dev, "Failed to restore queue %d\n",
 					q->properties.queue_id);
 				goto out;
 			}
@@ -1474,18 +1482,19 @@ static void pre_reset(struct device_queue_manager *dqm)
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int bit;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
 		if (bitmap_empty(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
-			pr_err("No more SDMA queue to allocate\n");
+			dev_err(dev, "No more SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
 
 		if (restore_sdma_id) {
 			/* Re-use existing sdma_id */
 			if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap)) {
-				pr_err("SDMA queue already in use\n");
+				dev_err(dev, "SDMA queue already in use\n");
 				return -EBUSY;
 			}
 			clear_bit(*restore_sdma_id, dqm->sdma_bitmap);
@@ -1504,13 +1513,13 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				kfd_get_num_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (bitmap_empty(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
-			pr_err("No more XGMI SDMA queue to allocate\n");
+			dev_err(dev, "No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
 		if (restore_sdma_id) {
 			/* Re-use existing sdma_id */
 			if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
-				pr_err("SDMA queue already in use\n");
+				dev_err(dev, "SDMA queue already in use\n");
 				return -EBUSY;
 			}
 			clear_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap);
@@ -1562,6 +1571,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 {
 	int i, mec;
 	struct scheduling_resources res;
+	struct device *dev = dqm->dev->adev->dev;
 
 	res.vmid_mask = dqm->dev->compute_vmid_bitmap;
 
@@ -1582,7 +1592,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 		 * definition of res.queue_mask needs updating
 		 */
 		if (WARN_ON(i >= (sizeof(res.queue_mask)*8))) {
-			pr_err("Invalid queue enabled by amdgpu: %d\n", i);
+			dev_err(dev, "Invalid queue enabled by amdgpu: %d\n", i);
 			break;
 		}
 
@@ -1625,6 +1635,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 static int start_cpsch(struct device_queue_manager *dqm)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int retval;
 
 	retval = 0;
@@ -1671,7 +1682,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		retval = pm_update_grace_period(&dqm->packet_mgr,
 						grace_period);
 		if (retval)
-			pr_err("Setting grace timeout failed\n");
+			dev_err(dev, "Setting grace timeout failed\n");
 		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
 			/* Update dqm->wait_times maintained in software */
 			dqm->dev->kfd2kgd->build_grace_period_packet_info(
@@ -1881,15 +1892,17 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	return retval;
 }
 
-int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
-				uint64_t fence_value,
-				unsigned int timeout_ms)
+int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
+			      uint64_t fence_value,
+			      unsigned int timeout_ms)
 {
 	unsigned long end_jiffies = msecs_to_jiffies(timeout_ms) + jiffies;
+	struct device *dev = dqm->dev->adev->dev;
+	uint64_t *fence_addr =  dqm->fence_addr;
 
 	while (*fence_addr != fence_value) {
 		if (time_after(jiffies, end_jiffies)) {
-			pr_err("qcm fence wait loop timeout expired\n");
+			dev_err(dev, "qcm fence wait loop timeout expired\n");
 			/* In HWS case, this is used to halt the driver thread
 			 * in order not to mess up CP states before doing
 			 * scandumps for FW debugging.
@@ -1908,6 +1921,7 @@ int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 /* dqm->lock mutex has to be locked before calling this function */
 static int map_queues_cpsch(struct device_queue_manager *dqm)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int retval;
 
 	if (!dqm->sched_running)
@@ -1920,7 +1934,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	retval = pm_send_runlist(&dqm->packet_mgr, &dqm->queues);
 	pr_debug("%s sent runlist\n", __func__);
 	if (retval) {
-		pr_err("failed to execute runlist\n");
+		dev_err(dev, "failed to execute runlist\n");
 		return retval;
 	}
 	dqm->active_runlist = true;
@@ -1935,8 +1949,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				uint32_t grace_period,
 				bool reset)
 {
-	int retval = 0;
+	struct device *dev = dqm->dev->adev->dev;
 	struct mqd_manager *mqd_mgr;
+	int retval = 0;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -1959,10 +1974,10 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
 				KFD_FENCE_COMPLETED);
 	/* should be timed out */
-	retval = amdkfd_fence_wait_timeout(dqm->fence_addr, KFD_FENCE_COMPLETED,
-				queue_preemption_timeout_ms);
+	retval = amdkfd_fence_wait_timeout(dqm, KFD_FENCE_COMPLETED,
+					   queue_preemption_timeout_ms);
 	if (retval) {
-		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
+		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
 		kfd_hws_hang(dqm);
 		return retval;
 	}
@@ -1977,7 +1992,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (mqd_mgr->read_doorbell_id(dqm->packet_mgr.priv_queue->queue->mqd)) {
-		pr_err("HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
+		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
 		while (halt_if_hws_hang)
 			schedule();
 		return -ETIME;
@@ -1987,7 +2002,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
 		if (pm_update_grace_period(&dqm->packet_mgr,
 					USE_DEFAULT_GRACE_PERIOD))
-			pr_err("Failed to reset grace period\n");
+			dev_err(dev, "Failed to reset grace period\n");
 	}
 
 	pm_release_ib(&dqm->packet_mgr);
@@ -2061,6 +2076,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+	struct device *dev = dqm->dev->adev->dev;
 
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
@@ -2068,7 +2084,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
 							&sdma_val);
 		if (retval)
-			pr_err("Failed to read SDMA queue counter for queue: %d\n",
+			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
 	}
 
@@ -2349,6 +2365,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 {
 	int retval;
 	struct queue *q;
+	struct device *dev = dqm->dev->adev->dev;
 	struct kernel_queue *kq, *kq_next;
 	struct mqd_manager *mqd_mgr;
 	struct device_process_node *cur, *next_dpn;
@@ -2382,7 +2399,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 			if (dqm->dev->kfd->shared_resources.enable_mes) {
 				retval = remove_queue_mes(dqm, q, qpd);
 				if (retval)
-					pr_err("Failed to remove queue %d\n",
+					dev_err(dev, "Failed to remove queue %d\n",
 						q->properties.queue_id);
 			}
 		}
@@ -2437,12 +2454,13 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 static int init_mqd_managers(struct device_queue_manager *dqm)
 {
 	int i, j;
+	struct device *dev = dqm->dev->adev->dev;
 	struct mqd_manager *mqd_mgr;
 
 	for (i = 0; i < KFD_MQD_TYPE_MAX; i++) {
 		mqd_mgr = dqm->asic_ops.mqd_manager_init(i, dqm->dev);
 		if (!mqd_mgr) {
-			pr_err("mqd manager [%d] initialization failed\n", i);
+			dev_err(dev, "mqd manager [%d] initialization failed\n", i);
 			goto out_free;
 		}
 		dqm->mqd_mgrs[i] = mqd_mgr;
@@ -2552,7 +2570,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.checkpoint_mqd = checkpoint_mqd;
 		break;
 	default:
-		pr_err("Invalid scheduling policy %d\n", dqm->sched_policy);
+		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
 		goto out_free;
 	}
 
@@ -2590,7 +2608,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		goto out_free;
 
 	if (!dev->kfd->shared_resources.enable_mes && allocate_hiq_sdma_mqd(dqm)) {
-		pr_err("Failed to allocate hiq sdma mqd trunk buffer\n");
+		dev_err(dev->adev->dev, "Failed to allocate hiq sdma mqd trunk buffer\n");
 		goto out_free;
 	}
 
@@ -2649,17 +2667,18 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd)
 {
 	int r;
+	struct device *dev = dqm->dev->adev->dev;
 	int updated_vmid_mask;
 
 	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
-		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
 		return -EINVAL;
 	}
 
 	dqm_lock(dqm);
 
 	if (dqm->trap_debug_vmid != 0) {
-		pr_err("Trap debug id already reserved\n");
+		dev_err(dev, "Trap debug id already reserved\n");
 		r = -EBUSY;
 		goto out_unlock;
 	}
@@ -2695,19 +2714,20 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 int release_debug_trap_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int r;
 	int updated_vmid_mask;
 	uint32_t trap_debug_vmid;
 
 	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
-		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
 		return -EINVAL;
 	}
 
 	dqm_lock(dqm);
 	trap_debug_vmid = dqm->trap_debug_vmid;
 	if (dqm->trap_debug_vmid == 0) {
-		pr_err("Trap debug id is not reserved\n");
+		dev_err(dev, "Trap debug id is not reserved\n");
 		r = -EINVAL;
 		goto out_unlock;
 	}
@@ -2844,6 +2864,7 @@ int resume_queues(struct kfd_process *p,
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device_queue_manager *dqm = pdd->dev->dqm;
+		struct device *dev = dqm->dev->adev->dev;
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
 		int r, per_device_resumed = 0;
@@ -2894,7 +2915,7 @@ int resume_queues(struct kfd_process *p,
 					0,
 					USE_DEFAULT_GRACE_PERIOD);
 		if (r) {
-			pr_err("Failed to resume process queues\n");
+			dev_err(dev, "Failed to resume process queues\n");
 			if (queue_ids) {
 				list_for_each_entry(q, &qpd->queues_list, list) {
 					int q_idx = q_array_get_index(
@@ -2946,6 +2967,7 @@ int suspend_queues(struct kfd_process *p,
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device_queue_manager *dqm = pdd->dev->dqm;
+		struct device *dev = dqm->dev->adev->dev;
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
 		int r, per_device_suspended = 0;
@@ -2994,7 +3016,7 @@ int suspend_queues(struct kfd_process *p,
 			grace_period);
 
 		if (r)
-			pr_err("Failed to suspend process queues.\n");
+			dev_err(dev, "Failed to suspend process queues.\n");
 		else
 			total_suspended += per_device_suspended;
 
@@ -3081,10 +3103,11 @@ void set_queue_snapshot_entry(struct queue *q,
 
 int debug_lock_and_unmap(struct device_queue_manager *dqm)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int r;
 
 	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
-		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
 		return -EINVAL;
 	}
 
@@ -3102,10 +3125,11 @@ int debug_lock_and_unmap(struct device_queue_manager *dqm)
 
 int debug_map_and_unlock(struct device_queue_manager *dqm)
 {
+	struct device *dev = dqm->dev->adev->dev;
 	int r;
 
 	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
-		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		dev_err(dev, "Unsupported on sched_policy: %i\n", dqm->sched_policy);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3d9ce44d88da..b315311dfe2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1343,7 +1343,7 @@ int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
 			   int *num_qss_entries,
 			   uint32_t *entry_size);
 
-int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
+int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
 			      uint64_t fence_value,
 			      unsigned int timeout_ms);
 
-- 
2.34.1

