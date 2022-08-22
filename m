Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E4BC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 15:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC7610E3D9;
	Mon, 22 Aug 2022 15:30:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F7093D6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 15:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0TSzpzWmlTND/uLq1wVKpox9p1J+P3vSTM8QdkA5g3e20A6nMKSMDH0nmc2Di4/PzWS2KUg7DbdKacmp/Pyz6RQMCjYCnFoURM9vwsueEVwrOc+dwU+FM+15lvqIqqs6ub3s3NYBuAzP20/Sqm2PKLaHAw4/LL1fEH7Cm0b4ksieptDvr1MAoRj0SE3OuhhxHZba7tCQtsj/F4uorFnXzyWiftEJ4A8Da9LTy3ZURRx7wkM0S/lbW0939R6PSIIS8Z6sNJNORQG74LoQ0Qvwn83RQn0qR+Tqly5NHzPkQQAcXlm5xE3Dq8UV/StaLauOQVL8B4AVDyssEpNGLgU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVmWE1aFkQfAjGHPmB/I3nEyJymX1zFebH9lvubFLg8=;
 b=hJwsmknTB2KasN2dNsUoUM7i0JQ/mVty+f0QNQowjnhyauwokI/WOplTYLiV1W+ko5BRVEPDY/bCPU2lpUhD7WL9C9sdfL8rAgQEWyHONKy3BwhWYf9FEIIKWjqh4zyM03PRRgGSy6VJ9xnuQ2iP76Xs/qNJuE97rPNTsoAaP3HYhGU5eo5Z7mghfqNrU87Oun1MVh1UyFGmkpn72+zB2a4ZC+RgCBLYCwuRcnn7SgFQ5sYbqSAiNyuz257CUW5mnkF/Md1alK2cqPTX5LqVbjH30QDPGOHFULMAAaP6mrvGvT8ngBzlm037Hkpsibl8BHbJADABvvyqpS2UMo0lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVmWE1aFkQfAjGHPmB/I3nEyJymX1zFebH9lvubFLg8=;
 b=tmQRCWDl9o1mbCNAD17LX3rtUA1ELKE5Y7kQuHLxhe+Mst452dB17EUT07XMLdfEjkHMFAQ05HxSDIDkl4idNbq+cZ2BI/esTBc280kynVvM6S//h/Zge9k2LPb1HfXSo8wvUT/ZLvneS13LJT3ncs1F3Gv7RweI1asXmgHG5RI=
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:30:20 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::36) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 15:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 15:30:20 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 10:30:19 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more places
Date: Mon, 22 Aug 2022 08:30:03 -0700
Message-ID: <20220822153003.6349-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9992d490-8cf4-47c1-8918-08da8453396e
X-MS-TrafficTypeDiagnostic: LV2PR12MB5989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKKSDRvGE5bgTnzY7oiw0fhPvli+piAXzWg41u6UplRsnPGmWo1f3iraGijCxF45Izn3ZByQkVqxciwDjI1oTd8hC/ovD98Cf0aoJgHP2yzBW8RCa9I2geQwureFagKtUmBwz279q7DRmnEpR4eYg1XcdhrH6Vv+9uwYsfe7IB0+ea7dnZkMUactnoLfNBab2tFmSANczFXC57XWiVV2Mp4pm5ah7Owd6f7YzITSeIdrTR/gTvoFzKKENlaw5IdBV0Apz57y8W6ANkFw9H4s7bN5I5acumE2yKS01rAIM67NHveq+57t9WctTdyuSxAShCioNYXdnCz47JBkF7HrVFmB2jt3RdYrGA6JEm65ziKeKQQKrKVs2uuiKq3WaAvfxAtOX/jMYVgkmhk3ZY3eWuRFfmbYFw3H7486MxrthRybV2QU92YSAHt/eyMGujcAintI/kpE6BQ4ix1bcCuHYXLFf3fkt9OlFDMGnGYUFTl2c5Zwe5kkV2F9MpmKMSARwhF8niiG9KuJJQVILfkikyf9l2pnmikxMnsjzKI6eKzmtLAaMu5iqZUDY/ioN7IxXtpIPW7wG1sr4o/oKsRo6ZihYCHKcYF0Vm7bf1ve67Rgj9i7LlM4q8QkVY3Y1EyNu7QRcQq9ZhMvGr5SLcV0M+YKv6iGLK6p5rWD5OsNcFkNsPerF9MVHz5iVdbqQKO27cjAMbStnWLgjYFjqgZBCQ6Yz71f6kwGM720wSl1VbkNRyWO1nHqE4WBmXcM3Yo/Qq71GCedUauryLjr9JxwrSwiXeaGHju8UnmU34CV0A45xOywZ1HlHg/vk+PuhRQx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(41300700001)(6666004)(7696005)(478600001)(1076003)(186003)(16526019)(336012)(2616005)(8936002)(426003)(47076005)(26005)(83380400001)(2906002)(5660300002)(44832011)(40460700003)(40480700001)(82310400005)(316002)(6916009)(54906003)(86362001)(4326008)(8676002)(70586007)(70206006)(82740400003)(36860700001)(36756003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:30:20.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9992d490-8cf4-47c1-8918-08da8453396e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert most of the "mutex_lock; kfd_process_device_data_by_id" occurrences
in kfd_chardev to use the kfd_lock_pdd_by_id. These will now consistently
log debug output if the lookup fails. Sites where kfd_process_device_data_by_id
is used without locking are not converted for now.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 96 ++++++++----------------
 1 file changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2b3d8bc8f0aa..bb5528c55b73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -75,6 +75,7 @@ static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *
 	if (pdd)
 		return pdd;
 
+	pr_debug("Could not find gpu id 0x%x\n", gpu_id);
 	mutex_unlock(&p->mutex);
 	return NULL;
 }
@@ -311,14 +312,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 	pr_debug("Looking for gpu id 0x%x\n", args->gpu_id);
 
-	mutex_lock(&p->mutex);
-
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
-		err = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return -EINVAL;
 	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
@@ -405,7 +401,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
 err_bind_process:
-err_pdd:
 	mutex_unlock(&p->mutex);
 	return err;
 }
@@ -566,13 +561,9 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		return -EINVAL;
 	}
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
-		err = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return -EINVAL;
 
 	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
@@ -596,7 +587,6 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		err = -EINVAL;
 
 out:
-err_pdd:
 	mutex_unlock(&p->mutex);
 
 	return err;
@@ -609,13 +599,9 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 	int err = 0;
 	struct kfd_process_device *pdd;
 
-	mutex_lock(&p->mutex);
-
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		err = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return -EINVAL;
 
 	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
@@ -626,7 +612,6 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args->tma_addr);
 
 out:
-err_pdd:
 	mutex_unlock(&p->mutex);
 
 	return err;
@@ -663,13 +648,12 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 	struct kfd_ioctl_get_clock_counters_args *args = data;
 	struct kfd_process_device *pdd;
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	mutex_unlock(&p->mutex);
-	if (pdd)
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (pdd) {
+		mutex_unlock(&p->mutex);
 		/* Reading GPU clock counter from KGD */
 		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
-	else
+	} else
 		/* Node without GPU resource */
 		args->gpu_clock_counter = 0;
 
@@ -886,12 +870,9 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 	struct kfd_dev *dev;
 	long err;
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		err = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return -EINVAL;
 	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
@@ -912,7 +893,6 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 	return 0;
 
 bind_process_to_device_fail:
-err_pdd:
 	mutex_unlock(&p->mutex);
 	return err;
 }
@@ -973,12 +953,9 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	if (!drm_file)
 		return -EINVAL;
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		ret = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return -EINVAL;
 
 	if (pdd->drm_file) {
 		ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
@@ -995,7 +972,6 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	return 0;
 
 err_unlock:
-err_pdd:
 err_drm_file:
 	mutex_unlock(&p->mutex);
 	fput(drm_file);
@@ -1063,12 +1039,9 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->svms.lock);
 #endif
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	if (!pdd) {
-		err = -EINVAL;
-		goto err_pdd;
-	}
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	if (!pdd)
+		return EINVAL;
 
 	dev = pdd->dev;
 
@@ -1140,7 +1113,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct kgd_mem *)mem,
 					       pdd->drm_priv, NULL);
 err_unlock:
-err_pdd:
 err_large_bar:
 	mutex_unlock(&p->mutex);
 	return err;
@@ -1231,8 +1203,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		goto copy_from_user_failed;
 	}
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
+	pdd = kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
 	if (!pdd) {
 		err = -EINVAL;
 		goto get_process_device_data_failed;
@@ -1304,12 +1275,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 	return err;
 
-get_process_device_data_failed:
 bind_process_to_device_failed:
 get_mem_obj_from_handle_failed:
 map_memory_to_gpu_failed:
 	mutex_unlock(&p->mutex);
 copy_from_user_failed:
+get_process_device_data_failed:
 sync_memory_failed:
 	kfree(devices_arr);
 
@@ -1347,8 +1318,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		goto copy_from_user_failed;
 	}
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
+	pdd = kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
 	if (!pdd) {
 		err = -EINVAL;
 		goto bind_process_to_device_failed;
@@ -1398,10 +1368,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 
 	return 0;
 
-bind_process_to_device_failed:
 get_mem_obj_from_handle_failed:
 unmap_memory_from_gpu_failed:
 	mutex_unlock(&p->mutex);
+bind_process_to_device_failed:
 copy_from_user_failed:
 sync_memory_failed:
 	kfree(devices_arr);
@@ -1517,11 +1487,10 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
 
-	mutex_lock(&p->mutex);
-	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
 	if (!pdd) {
 		r = -EINVAL;
-		goto err_unlock;
+		goto err_pdd;
 	}
 
 	pdd = kfd_bind_process_to_device(pdd->dev, p);
@@ -1555,6 +1524,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 					       pdd->drm_priv, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
+err_pdd:
 	dma_buf_put(dmabuf);
 	return r;
 }
@@ -1566,13 +1536,11 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	struct kfd_ioctl_smi_events_args *args = data;
 	struct kfd_process_device *pdd;
 
-	mutex_lock(&p->mutex);
-
-	pdd = kfd_process_device_data_by_id(p, args->gpuid);
-	mutex_unlock(&p->mutex);
+	pdd = kfd_lock_pdd_by_id(p, args->gpuid);
 	if (!pdd)
 		return -EINVAL;
 
+	mutex_unlock(&p->mutex);
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
-- 
2.35.1

