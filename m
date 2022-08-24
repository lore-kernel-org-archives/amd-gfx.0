Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8987EC04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F3210E1C2;
	Thu, 25 Aug 2022 07:26:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352AB14AC32
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBvjmt4NSK5Bu09LctgrhxplgUSZpyoLvMEmGobTQlqERFOnSDggk6pyIVcGCykSFDbfmXCjNMkBO6xrNTE20+0pMpEBNU//7mdMUDjcNf4DgKQN/FCw23fX5i6dno7krbIijcnylXUPsYZ3+Bg1OGqpVGJQ2K4DuYildm1oAXUF+rZUMj5JeLNk0spO8MBZFw0eRXshcH94nCHg8Uf2gKUi12J6TTfTff5P9cuOFzzlFAcF6e4/dbOvAD28tuKdJKOZBlTMo9JmmylITv1OuE1nwWjIElCHprGqwg6n6gFeQw7bxAh8wTka5qhSGf6MP9eX9qdoyXjepodzY7YMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5z+CCmT4VjUedTqDGm8n40ZplonxqcesOIAAVCSlZQ=;
 b=ZFh7mGu3081bqAeSujxPTntTTOkqtP881Mh47LzLVKHAXVTycHBiXtarLCX6f94FPBs33edhuSblwmhVUM8CiRbCx1nmnUSoAAna0C4ez0tskxC/ny5cFxqYvPy90DN2QjLJu1kbJ7Anpp6VVb0/+p12y8moP06m5NujFgyM/jcpKQfT5y+DaHDi7A0/w6G2AsLmdmnuYblkU/kMikGiGzULcfz70pB3vJIzBgz28sJ08+nmEP+7KwuHJpNKvayWNMQD/WtY178rKMz5lUTHbevmuojYEbW8RD+BfVzMk2qDgxGtqLL+h8zCM5eSfXZ8xICtx8m8utqSJPik5JDbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5z+CCmT4VjUedTqDGm8n40ZplonxqcesOIAAVCSlZQ=;
 b=DL9anVwea6cDQLDWfnZ0sM80ymzugq2Yw6ZOORk0QBtL9DjvhkmNvP+f5icj4372TmJ4RC4jkgTzYspo9YjcHu6wlZ1INLsEbI/d5XkR6+9BD0qcAOmWTFpFvo941vO0YoML81GDzTcIUoWt3udVdit/jTCPUTi2tbQc8oLDsS8=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 20:01:55 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::81) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
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
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 20:01:55 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 15:01:54 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use kfd_unlock_pdd helper
Date: Wed, 24 Aug 2022 13:01:32 -0700
Message-ID: <20220824200132.116030-3-daniel.phillips@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 945d30ca-5132-4cad-3bd4-08da860b7ed6
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D042CiPojAqAkpVhWP9Y4FbTSR/2nevqA3/SMXQMMUrDVEJ8QRxAxS1GY+MrrPbWSgoH5DRg6ao2tGdIRgy5JYs359W0eapTW3NX9CXhiY2HrHIQ/7uBJPlWKpVEljb2dNUjKiYgj/n6uGS6Ghu+/PuCKzhYZvsnyec5DYgnR57i3RdHkbCfjn/VBnWnBQDPfnjamknvlCnlmZ7sXxiy36DvFnX0GHOqK1ghouu00E7rKKBlJUQZSG5QTgVYGKofb5FdC9goV7y4WNIThQSWkJmStlx5Rv+AURkQc1UovpTpMcN6O+q9IsaMfgNR0yJx0Cq8UkEeQr+rYbK/dw/a6lkLmhxF2nYN0COnjuNNeOAv2SgCliRKbEphy1b11yseMZ7EUsCroP9fHJQ0yKDEqhaN5HRmGcuAE83zojc8yQ43w08NVMil1Xps7enPUB2CgdvE0z3bL1mNYRstXKmj309oMylpEo/aS2qwJq6eMF9j6aY9k4eb0IKVy71NqYwWPUVbsQ3CSPdm5MgiLWrFgSm9nMZTs2SsNL7Qvvkqo3fkfnIufqTksgzlpHvBggLzWAwh/xWIns61aFqVa6SGw/v+b4XSc8tGfazhkU0WkFJPAK1lzHGUQQaHghUBShCGOu6I3jnEzJTYT0sXrXB7Txjv2BDxkjqDB2tNmfNtejysaUkP/STb9LoBNjFI5VYnFJBtYeLj2TcWs4Gf+wLuxyScXGDQZHuFxHcbyQre9n5+Y1Zst8G9w6mNYxJ+Bwo5PKXtA5SHXfUHE0t2gpjBz7hKawUBEdWdnb8R/U6H03phn6rr4HxP9XJXp60LvGWU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(40470700004)(2616005)(40480700001)(478600001)(7696005)(86362001)(26005)(82740400003)(6666004)(81166007)(40460700003)(83380400001)(356005)(336012)(186003)(16526019)(47076005)(1076003)(426003)(36756003)(82310400005)(8676002)(36860700001)(70206006)(6916009)(44832011)(70586007)(54906003)(2906002)(4326008)(8936002)(5660300002)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:01:55.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945d30ca-5132-4cad-3bd4-08da860b7ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-OriginatorOrg: amd.com
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

Trivially changes kfd_lock_pdd_by_id ... mutex_unlock to use the
kfd_unlock_pdd helper.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 38 +++++++++++-------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index bb5528c55b73..cf5bfd928b69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -381,7 +381,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		 */
 		args->doorbell_offset |= doorbell_offset_in_process;
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	pr_debug("Queue id %d was created successfully\n", args->queue_id);
 
@@ -401,7 +401,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
 err_bind_process:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	return err;
 }
 
@@ -587,8 +587,7 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		err = -EINVAL;
 
 out:
-	mutex_unlock(&p->mutex);
-
+	kfd_unlock_pdd(pdd);
 	return err;
 }
 
@@ -612,8 +611,7 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args->tma_addr);
 
 out:
-	mutex_unlock(&p->mutex);
-
+	kfd_unlock_pdd(pdd);
 	return err;
 }
 
@@ -650,7 +648,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 
 	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
 	if (pdd) {
-		mutex_unlock(&p->mutex);
+		kfd_unlock_pdd(pdd);
 		/* Reading GPU clock counter from KGD */
 		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
 	} else
@@ -883,7 +881,7 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 
 	pdd->qpd.sh_hidden_private_base = args->va_addr;
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS &&
 	    pdd->qpd.vmid != 0 && dev->kfd2kgd->set_scratch_backing_va)
@@ -893,7 +891,7 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 	return 0;
 
 bind_process_to_device_fail:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	return err;
 }
 
@@ -967,13 +965,13 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 		goto err_unlock;
 
 	/* On success, the PDD keeps the drm_file reference */
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	return 0;
 
 err_unlock:
 err_drm_file:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	fput(drm_file);
 	return ret;
 }
@@ -1095,7 +1093,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
 		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
 	args->mmap_offset = offset;
@@ -1114,7 +1112,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 					       pdd->drm_priv, NULL);
 err_unlock:
 err_large_bar:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	return err;
 }
 
@@ -1256,7 +1254,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		args->n_success = i+1;
 	}
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev, (struct kgd_mem *) mem, true);
 	if (err) {
@@ -1278,7 +1276,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 bind_process_to_device_failed:
 get_mem_obj_from_handle_failed:
 map_memory_to_gpu_failed:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 copy_from_user_failed:
 get_process_device_data_failed:
 sync_memory_failed:
@@ -1346,7 +1344,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		}
 		args->n_success = i+1;
 	}
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 
 	if (kfd_flush_tlb_after_unmap(pdd->dev)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(pdd->dev->adev,
@@ -1370,7 +1368,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 
 get_mem_obj_from_handle_failed:
 unmap_memory_from_gpu_failed:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 bind_process_to_device_failed:
 copy_from_user_failed:
 sync_memory_failed:
@@ -1512,7 +1510,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 		goto err_free;
 	}
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	dma_buf_put(dmabuf);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
@@ -1523,7 +1521,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, (struct kgd_mem *)mem,
 					       pdd->drm_priv, NULL);
 err_unlock:
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 err_pdd:
 	dma_buf_put(dmabuf);
 	return r;
@@ -1540,7 +1538,7 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	if (!pdd)
 		return -EINVAL;
 
-	mutex_unlock(&p->mutex);
+	kfd_unlock_pdd(pdd);
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
-- 
2.35.1

