Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D035C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B65510E226;
	Thu, 25 Aug 2022 07:35:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7945C14B332
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4yZo+8VRWz+veokA7m+ZXzRuGiIqDtPG4EQSdzyR8ThnAsGG49llrZsCPxsQBV0aR6ImBc0q2gFGdGqyLeb5avUSiu2n/h7R0vnG48ocrJfK9oOGm5UxZ8Jlkj/iMgcTGOTZFy0X7YE5+x558DfNLlAi6J0/gd1L4Ip46T0IPYuEZS55pEJRxAqSEQj4sDlTk1WcN9/Q4UQa2ZDWnUiyZjnRUwEitIy2vSQuuieWN7KPmkEsW0DwK+g3nwRc4fOObSQzyIApzGOdsaT6nrWtTj/I1jzrWpawJ3H8lhIBcPvdD5OMfTFhkUedeh0RNLktVeNYDAXzNMYQUE7KcKONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WHaimEGT/amXygxz5CpJzvYg9QxoN/1rM1MHrLUDnE=;
 b=iWIBeqNagnrpvjEbTrqrdEH4sDoFSIR27YDvjnVdXKfIpzRcZlAC7tRxV/53C/nYpgXhswe6RAxokJAtlNbGYK9Ov7ARGdpdBkEMpYM0Dy5ImOp4DDeiH1zBT7Y0QRu8K5JNjPvKOv55P1sqm2fkJHqgPXrlhCncBiitIiVMIvpabS5Kj3rP04kKRBsYc5IZb2DdRJ8m+pbfcG3DIf116ZuK4ePxYhmd7cksesILANcNq7c/F4PI67kJIbKZMVINeNxisYh/yexemI+E/RUrnKoIfJgIsIBAfAiepjWAPnzdmQvgtilYCuW4ZQeD9ZN7pZXs0oGpzUZbXA/BcK+lRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WHaimEGT/amXygxz5CpJzvYg9QxoN/1rM1MHrLUDnE=;
 b=LgTzLzBwTW6w7LXff6XYj9gSqdncGyDDB9sdad/qpXEWHyWCf1MkK+znGIRkyAK9vdrMuP6MGXW5qk5QUaDbQ9nizGBHt9SwxyXLMp3jolznNIIFZG0rH1fglCHWfv4aVp8GcxpOuB8WVwmLTv4OdDycfDpd38c8BDsgipkWUJk=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 20:01:55 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::7a) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23 via Frontend
 Transport; Wed, 24 Aug 2022 20:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 20:01:54 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 15:01:51 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more places
Date: Wed, 24 Aug 2022 13:01:31 -0700
Message-ID: <20220824200132.116030-2-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824200132.116030-1-daniel.phillips@amd.com>
References: <20220824200132.116030-1-daniel.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5607c4-28f6-402b-1b09-08da860b7e72
X-MS-TrafficTypeDiagnostic: PH7PR12MB7380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qrRq4PFCw8HNMnOocYoh+O1sv/JswQTVVxe+tQfje5VPgNKYQIFhFCXEwAvwkefiTWzKMFITfvKrRX0YrOLLrAxDc/seHmzN76+wxPMdEEhPNAgvFlx5OHCi7dIZ4MJD5Zuor3MuQl6RatrHNZcY8JhZA+vo0NaYD6tse8RGK2CNrwPjePYcvV/XixyXXOYONbpKFVlBBBA9RIYwF4UtuFCjkDo76zCuAM5Qy8MHmKMtnZg+reTSUnsu/Wljz1lPIUpEFokeZlwOzcWoYbPuZDI+UlFAKvPeVigCv+jtd5ngpI11y3JjVyehKWWeFrg5FDG75jydYXUYNtKu1+kiDbKArRHd6Zvku5yOjo2tNv1gdkkygSeiKKfyOXbYUZG2sUd7ZBKm2j9+TmTTNvsHO4f9RYaGoqDvf+834SY31fM6SV/L9fSiH7xDSSaH0X7JvMs4mPdpaE1C9y278P3MPEvsev99fEXdDNKsaVSuzIKgagVCKtcqjKE7WlgjfmYJt3hL9Xowng+b5ZF3e6QPUogMc+ynfVNG/QFd6MMf3e7HEW6LgVi+9W+I6T226IfAHBzfwYec5JVlc/OgvZzaIbpD/rim+4fiawfBSrmuMBiisk/yxYEbxp3pXIZKsy4C15D9P56dkwV3k4FUWI7M7pLHf7xtDpSgXE2TKMfoJb+5t4PVWK0ardHIFXhbnFgCv9dV6EcdaoFtMxcY3oCLS8wLR8IkfdwwxoXw2FhoPDb45dYZU713Jdg5woE9Ko/0mXf6zsQ/6RZEZCzyn4kqs8PrFBh5ydl97OTazN8GFty8pcEjmD9bRehHEEdR2Mh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(40470700004)(36840700001)(356005)(7696005)(81166007)(54906003)(86362001)(4326008)(40480700001)(8676002)(316002)(6916009)(82310400005)(47076005)(426003)(36860700001)(70586007)(1076003)(2616005)(336012)(16526019)(186003)(478600001)(83380400001)(70206006)(40460700003)(82740400003)(26005)(41300700001)(44832011)(5660300002)(6666004)(36756003)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:01:54.8641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5607c4-28f6-402b-1b09-08da860b7e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Cc: Daniel Phillips <daniel.phillips@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert most of the "mutex_lock; kfd_process_device_data_by_id" occurrences
in kfd_chardev to use the kfd_lock_pdd_by_id. These will now consistently
log debug output if the lookup fails. Sites where kfd_process_device_data_by_id
is used without locking are not converted for now.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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

