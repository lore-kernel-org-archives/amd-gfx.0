Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53264C77B6F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11FC10E8AF;
	Wed, 12 Apr 2023 16:26:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D21A10E8AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO5U9/sF1FOYkvRfYqXZLlx2cjJenEtulqWqvjbmMtXKvCQalzUPG5qABhYWe2Pt/yWbQXdoKS1KDFrjs5mIG8cZ032wbhawSNoXNPFWT+XylbJ/f8P4aYbancKgulUhG5b/UauxxEFBBAvPQfttTUfjWN6EvUo75sGDSQdezY4c6WoPSLQbA+u1JmbtoOGto8y5o4DAHUAtu47CUKeZk87bVZ7naZU2AGcd0FAmlbh/BRrR+aZSSueLIW9NcauIzI1rQHloGHm/54mKoygHTYXxmjaziMtvXyWvwGiFw0NklsKndHoIISMftsFu6aZhGnkMTb4Lm90SweE3m7iVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zozvn29oJThU8VgwFBuNXgXT3SJTToIvajEyjtFKfUU=;
 b=Y46kID8tcl4QwOL1InepQLAa2o2rK/d2f1b5YCBN2v1ocZZv6VW5WHq1R1XnHq6zpWRDW6uBcic1Unux0YiqLeE/nQPGE29UDdcq4IvmyAxLNT14b1kqEal2TYuJxOePu4xX+Jly9n+c27o/HbxBnXxUYlLQRH+1rXXRhyfBskjHgxdYnWo4wUG5xkyjvRHoBfX8iGIsm1N2AI1oC3r/UPxgiFxaPNDxBK+W67RjvVTY9ktZ7SrdrU8MT697x2avZKOCqgxYgXAfWlSIQdUa1OucpzWahobDGnjIfSFkhl2sdHJzpWuuJrAhpeKGRZpEU4QWnb/4670FdzcSiRz3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zozvn29oJThU8VgwFBuNXgXT3SJTToIvajEyjtFKfUU=;
 b=iU8kIubwRfLdNwUxOjdJArex7Ezsu4cSOn4eOya6UkFQD7rQkDTq7ApyKJCXquORc3ZSWWcU2PEFB27LWi3az3g3b+QpXQMdMcYxhNAFRf28INBawEb8p0rT7LgTzjXc6gc2MEzk6AHuFlGxCLG2sp4O/xa6QZtuu26k0vq8n8o=
Received: from BL1PR13CA0066.namprd13.prod.outlook.com (2603:10b6:208:2b8::11)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 16:26:38 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c9) by BL1PR13CA0066.outlook.office365.com
 (2603:10b6:208:2b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Date: Wed, 12 Apr 2023 18:25:33 +0200
Message-ID: <20230412162537.1357-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|BY5PR12MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: d58b1f81-2c85-41cb-4cfe-08db3b72b06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DECO6W9e+IM7QX8YvCs2o56k9yfxU94XYWkWx0yicqxWbe56Esybj26vNLBj/p9Rp2aKHBtoZKiWq6dIgaXigd5IUo19GgL7buyulhP2bdymA4R4pX9jn98yuNVJ1MqMmEfT8eHeiHdLuEz2R+ivzGn5kcMq+cj//v4Dfpjd+FBYtCemPmkX63CdYFJ7p6qUtQXnMYHRWoqQUraQ5Wy1gVgUi0AADPhu26MmUUjbyliSthYANKaRQ762T4UzwRiMtKHZU+5YTlsc4tHbYjuWhm7R8Vt6Ss5e4qFtAYHBj+vE2/wBHSqi7LBSJgPfVWBDgEffIYNreSSPK94Wtjne0TRlU5+mOvDGxPFJDEo+iVXOUTPTXDJq5KcdshdR/unHp792uWIOpjJXpE5FQHh89BbHhudkXaM8L64we0549CmDydDm6D20Ms3Qv+6BgNhrsZ8brkRO7nYUWR9EicXWXL/z0vdVF6v0TdyVoSw7Ksjs0DvjXg5LV0aqyerwIRrk4oj/NGyFu1EoW9DGADjOTzikEIHJ8dhJWVTuyZhGXKq7o+M8GxGiAqEVyh47LIEViHoYPrTN5N4QL9ERiXFbRQ7jwWcCI2cvnzrh4zjb3VlshpMIPc6kmLD1TYNg0H7hX0XXWreeMwIaVlCC29DbU0eG5MVqE+x0bf8kWJ2bRBQeJvF/doKBjoWk/sltNJFO6aiWgH2sH4MmWH7tWQdTRRtbrSOUSm7lqB/f5Y2rfqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(426003)(83380400001)(70206006)(70586007)(47076005)(2616005)(478600001)(7696005)(16526019)(26005)(186003)(54906003)(1076003)(44832011)(2906002)(36756003)(30864003)(5660300002)(81166007)(356005)(6916009)(82740400003)(4326008)(82310400005)(41300700001)(40460700003)(8936002)(8676002)(316002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:37.4721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58b1f81-2c85-41cb-4cfe-08db3b72b06b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell object in kfd pdd structure.
- allocates doorbells for a process while creating its pdd.
- frees the doorbells with pdd destroy.
- removes previous calls to allocate process doorbells as
  its not required anymore.

PS: This patch ensures that we don't break the existing KFD
    functionality, but now KFD userspace library should also
    create doorbell pages as AMDGPU GEM objects using libdrm
    functions in userspace. The reference code for the same
    is available with AMDGPU Usermode queue libdrm MR. Once
    this is done, we will not need to create process doorbells
    in kernel.

V2: - Do not use doorbell wrapper API, use amdgpu_bo_create_kernel
      instead (Alex).
    - Do not use custom doorbell structure, instead use separate
      variables for bo and doorbell_bitmap (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 65 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 +++---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++----
 6 files changed, 64 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6d291aa6386b..0e40756417e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	if (!pdd->doorbell_index &&
-	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
-		err = -ENOMEM;
-		goto err_alloc_doorbells;
-	}
-
 	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 	 */
@@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	if (wptr_bo)
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
-err_alloc_doorbells:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
@@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct kfd_process *p,
 			ret = PTR_ERR(pdd);
 			goto exit;
 		}
-
-		if (!pdd->doorbell_index &&
-		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
-			ret = -ENOMEM;
-			goto exit;
-		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ecb4c3abc629..855bf8ce3f16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -371,7 +371,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 			unsigned int found;
 
 			found = find_first_zero_bit(qpd->doorbell_bitmap,
-						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
+						    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
 			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
 				pr_debug("No doorbells available");
 				return -EBUSY;
@@ -381,9 +381,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 		}
 	}
 
-	q->properties.doorbell_off =
-		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
-					  q->doorbell_id);
+	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
+								  qpd->proc_doorbells,
+								  q->doorbell_id);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 82b4a56b0afc..718cfe9cb4f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -227,46 +227,47 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
-	if (!pdd->doorbell_index) {
-		int r = kfd_alloc_process_doorbells(pdd->dev,
-						    &pdd->doorbell_index);
-		if (r < 0)
-			return 0;
-	}
+	struct amdgpu_device *adev = pdd->dev->adev;
+	uint32_t first_db_index;
 
-	return pdd->dev->doorbell_base +
-		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
+	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
+	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
 }
 
-int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
+int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
 {
-	int r = 0;
-
-	if (!kfd->shared_resources.enable_mes)
-		r = ida_simple_get(&kfd->doorbell_ida, 1,
-				   kfd->max_doorbell_slices, GFP_KERNEL);
-	else
-		r = amdgpu_mes_alloc_process_doorbells(
-				(struct amdgpu_device *)kfd->adev,
-				doorbell_index);
+	int r;
+	struct qcm_process_device *qpd = &pdd->qpd;
 
-	if (r > 0)
-		*doorbell_index = r;
+	/* Allocate bitmap for dynamic doorbell allocation */
+	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					     GFP_KERNEL);
+	if (!qpd->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
+		return -ENOMEM;
+	}
 
-	if (r < 0)
-		pr_err("Failed to allocate process doorbells\n");
+	/* Allocate doorbells for this process */
+	r = amdgpu_bo_create_kernel(kfd->adev,
+				    kfd_doorbell_process_slice(kfd),
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_DOORBELL,
+				    &qpd->proc_doorbells,
+				    NULL,
+				    NULL);
+	if (r) {
+		DRM_ERROR("Failed to allocate process doorbells\n");
+		bitmap_free(qpd->doorbell_bitmap);
+		return r;
+	}
 
-	return r;
+	return 0;
 }
 
-void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbell_index)
+void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
 {
-	if (doorbell_index) {
-		if (!kfd->shared_resources.enable_mes)
-			ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
-		else
-			amdgpu_mes_free_process_doorbells(
-					(struct amdgpu_device *)kfd->adev,
-					doorbell_index);
-	}
+	struct qcm_process_device *qpd = &pdd->qpd;
+
+	bitmap_free(qpd->doorbell_bitmap);
+	amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0b199eb6dc88..dfff77379acb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -661,7 +661,10 @@ struct qcm_process_device {
 	uint64_t ib_base;
 	void *ib_kaddr;
 
-	/* doorbell resources per process per device */
+	/* doorbells for kfd process */
+	struct amdgpu_bo *proc_doorbells;
+
+	/* bitmap for dynamic doorbell allocation from the bo */
 	unsigned long *doorbell_bitmap;
 };
 
@@ -1009,9 +1012,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
 					unsigned int doorbell_id);
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
 int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
-				unsigned int *doorbell_index);
+				 struct kfd_process_device *pdd);
 void kfd_free_process_doorbells(struct kfd_dev *kfd,
-				unsigned int doorbell_index);
+				 struct kfd_process_device *pdd);
 /* GTT Sub-Allocator */
 
 int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 51b1683ac5c1..217ff72a97b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
 				get_order(KFD_CWSR_TBA_TMA_SIZE));
 
-		bitmap_free(pdd->qpd.doorbell_bitmap);
 		idr_destroy(&pdd->alloc_idr);
 
-		kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
+		kfd_free_process_doorbells(pdd->dev, pdd);
 
 		if (pdd->dev->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
@@ -1453,11 +1452,6 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	if (!KFD_IS_SOC15(dev))
 		return 0;
 
-	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
-					     GFP_KERNEL);
-	if (!qpd->doorbell_bitmap)
-		return -ENOMEM;
-
 	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
 	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
 	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
@@ -1499,9 +1493,15 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	if (!pdd)
 		return NULL;
 
+	retval = kfd_alloc_process_doorbells(dev, pdd);
+	if (retval) {
+		pr_err("failed to allocate process doorbells\n");
+		goto err_free_pdd;
+	}
+
 	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
 		pr_err("Failed to init doorbell for process\n");
-		goto err_free_pdd;
+		goto err_free_db;
 	}
 
 	pdd->dev = dev;
@@ -1529,7 +1529,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 						false);
 		if (retval) {
 			pr_err("failed to allocate process context bo\n");
-			goto err_free_pdd;
+			goto err_free_db;
 		}
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
 	}
@@ -1541,6 +1541,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 
 	return pdd;
 
+err_free_db:
+	kfd_free_process_doorbells(pdd->dev, pdd);
+
 err_free_pdd:
 	kfree(pdd);
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5137476ec18e..6c95586f08a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -344,17 +344,19 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		goto err_create_queue;
 	}
 
-	if (q && p_doorbell_offset_in_process)
+	if (q && p_doorbell_offset_in_process) {
 		/* Return the doorbell offset within the doorbell page
 		 * to the caller so it can be passed up to user mode
 		 * (in bytes).
-		 * There are always 1024 doorbells per process, so in case
-		 * of 8-byte doorbells, there are two doorbell pages per
-		 * process.
+		 * relative doorbell index = Absolute doorbell index -
+		 * absolute index of first doorbell in the page.
 		 */
-		*p_doorbell_offset_in_process =
-			(q->properties.doorbell_off * sizeof(uint32_t)) &
-			(kfd_doorbell_process_slice(dev) - 1);
+		uint32_t first_db_index = amdgpu_doorbell_index_on_bar(pdd->dev->adev,
+									pdd->qpd.proc_doorbells, 0);
+
+		*p_doorbell_offset_in_process = (q->properties.doorbell_off
+						- first_db_index) * sizeof(uint32_t);
+	}
 
 	pr_debug("PQM After DQM create queue\n");
 
@@ -858,12 +860,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
-	if (!pdd->doorbell_index &&
-	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
 	/* data stored in this order: mqd, ctl_stack */
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
-- 
2.40.0

