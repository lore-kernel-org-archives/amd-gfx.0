Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8D5C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB90210EB75;
	Wed, 29 Mar 2023 15:48:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA1410EB76
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPoAA6aLhNmvrCHnJ7C/mT1l9o2hfTQD2pUpxkpLhexko6oSUP+aYTz0a5Px606yLyAAwoHsO35Hd077h/J26rhHQgTAuT89hwm1hoadxQP9K9Zj+4SvIAA82oUb+HzESHEbZWvmg8y+Vmp13OT7VLfNog8+xp1PrLrZtzPjbT0J+sPqdEsHx6a8NHU+gDkkJicM//4gyHKiSZaQGHz1tfS22ZvAklDFYBIYZAhiKLZ6nlq9PUyauWc8ASkIFQA+avEVFcNepgL0dxBSLZ0lAWRAfalpzWNqSh3wJtGNr28Y34oJXlyl+k2QOiQCPKXXzz98qyBDVsSCMUDJcLe3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRzdhh+t/yYeAWE7CIpTB8yzYIeM+AmU7/w+vfj5ld0=;
 b=DUzkfQ0C2by43Z0WrM66Gv2628hHmb4u+Tvo+75tNI1tgAA1V7fZMN/6smeGLVB/Sm6y9Saiqkg97g9Sf+DJ9C4rSxuCWEXgB177d/Pi2CAA52NoCEG8/abnyRaZJTNh5CjNAQA/whtmW3YCKEKOoFsHCrmd/65/txWpPRwVZKM4n+bvmK0a9UVRmJYNVwV3XQRPiQ/WNgP2HMgUWWdfk4p3X21am79gN54hpf6YvxsEivpPZPrziThSK6XbU7YEziF2UG+htR3vIk8lKxLV/fPCPpGsy2LBhgvMzGu4bZRGR2OprNZQJZVnprAQs0XGR78ZZoLSkJgsCEnZYOudjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRzdhh+t/yYeAWE7CIpTB8yzYIeM+AmU7/w+vfj5ld0=;
 b=t2tOJ37BhOy67FmZ6/VkiGDkz3wuQ1QnwxxkxLzX35CcICsd5VWKUvghBS/HWjv90d8kQ6t4X1SVWI6IY6/gMcF1sFUMiKJp0GT5+dNcTd8cDwzzNumEiip8OeVdCtxMKfxYZ3Rowz3Znc8BYBvhpiTfcX7R1izwAUXx9VnrO+U=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 15:48:37 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::26) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 29 Mar 2023 15:48:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Date: Wed, 29 Mar 2023 17:47:50 +0200
Message-ID: <20230329154753.1261-14-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: f7185b1c-d531-48e2-c429-08db306d0f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psiLe/CPD8h0YuHwDM2ZTsEcgMMZbNafxxT/eC3G8YrEdx4p6Rt+8mYjWhF//mwrWcm3GreXQYmhNhZAnGNznV5ps6TyP0ct5dChf7QxgmhDsglqB71msLoX7589UJX0PZTdELyvOFpmMujrKWOEAtID2N0R2ePIUucwyXjt+iz+Bc1ky7TjIoQcAZfYrWcOPPY8LHSZANd86KIVugwSWdsm0pLWJczpqPq5P2OC1p0GiFxa7U8B8On3/Vb6OprmkNd/kh50L3UVQcMaY6X+TJr+qAmxKt7TAfEkkPnTQbT0FHytHtHFi9C4IA3BTdSlyajnCA7VkSZzqai59EpdMeflsxSh3dkgcE/jwuCAViAqB5P2T7jRGpEiCuYk2RDDihj3SpQCliRdIxxxZ+2IdA1z7yzxc51KWOMN+FRuHhc3umkhSGH9voNXgmX+gPe2vKTYzhzdvDYGVYkx8miFyzN2dI7hfFxeOK1y0U4W9veCfWKhV/7/BGHyAHmG03ch5IWxXlqTAbbRIRnP4Tnx2vvHhljnWvnDwoNbirJ75QNcUheuztgRxwXHqZ+IhHBsWJSp7hnA8FQNdwT/LaHp82BznbaZ2i8zrHcWCQmQoeHiLJhdVyEp3NnFipSBtPNsxI1+Z9rBzC21umOjMUtL0kCx/8YjfIgzQIzGpVWsxEQ7mq47rD5H86WvB3lfAjQFNEDmR3eWGXAp1pSIsItpd7s6KgJxOPB28AeNKMrDbY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(2906002)(2616005)(83380400001)(426003)(336012)(6916009)(8676002)(4326008)(70586007)(70206006)(7696005)(478600001)(54906003)(1076003)(316002)(26005)(16526019)(82310400005)(186003)(6666004)(44832011)(30864003)(36756003)(86362001)(36860700001)(41300700001)(82740400003)(81166007)(5660300002)(40480700001)(356005)(40460700003)(66899021)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:37.0434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7185b1c-d531-48e2-c429-08db306d0f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a new doorbell manager object in kfd pdd structure.
- allocates doorbells for a process while creating its pdd.
- frees the doorbells with pdd destroy.
- uses direct doorbell manager API for doorbell indexing.
- removes previous calls to allocate process doorbells as
  its not required anymore.

PS: This patch ensures that we don't break the existing KFD
    functionality, but now KFD userspace library must also
    move to creating doorbell pages as AMDGPU GEM objects
    using libdrm functions in userspace. The reference code
    for the same is available with AMDGPU Usermode queue
    libdrm MR. Once this is done, we will not need this
    patch.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 16 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 59 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 26 ++++----
 .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++---
 6 files changed, 58 insertions(+), 80 deletions(-)

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
index ecb4c3abc629..5827db9b18a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -362,7 +362,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 		/* For CP queues on SOC15 */
 		if (restore_id) {
 			/* make sure that ID is free  */
-			if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
+			if (__test_and_set_bit(*restore_id, qpd->proc_doorbells.doorbell_bitmap))
 				return -EINVAL;
 
 			q->doorbell_id = *restore_id;
@@ -370,20 +370,20 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 			/* or reserve a free doorbell ID */
 			unsigned int found;
 
-			found = find_first_zero_bit(qpd->doorbell_bitmap,
-						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
+			found = find_first_zero_bit(qpd->proc_doorbells.doorbell_bitmap,
+						    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
 			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
 				pr_debug("No doorbells available");
 				return -EBUSY;
 			}
-			set_bit(found, qpd->doorbell_bitmap);
+			set_bit(found, qpd->proc_doorbells.doorbell_bitmap);
 			q->doorbell_id = found;
 		}
 	}
 
-	q->properties.doorbell_off =
-		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
-					  q->doorbell_id);
+	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
+								  qpd->proc_doorbells.bo,
+								  q->doorbell_id);
 	return 0;
 }
 
@@ -398,7 +398,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		return;
 
-	old = test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap);
+	old = test_and_clear_bit(q->doorbell_id, qpd->proc_doorbells.doorbell_bitmap);
 	WARN_ON(!old);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index df259f2cc58a..7d29653bff81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -228,46 +228,41 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
-	if (!pdd->doorbell_index) {
-		int r = kfd_alloc_process_doorbells(pdd->dev,
-						    &pdd->doorbell_index);
-		if (r < 0)
-			return 0;
-	}
+	struct amdgpu_device *adev = pdd->dev->adev;
 
-	return pdd->dev->doorbell_base +
-		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
+	/* Return base of the first doorbell of this process */
+	return adev->doorbell.base + pdd->qpd.proc_doorbells.start * sizeof(uint32_t);
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
-
-	if (r > 0)
-		*doorbell_index = r;
+	int r;
+	struct qcm_process_device *qpd = &pdd->qpd;
+	struct amdgpu_doorbell_obj *proc_doorbells = &qpd->proc_doorbells;
+
+	/* Allocate bitmap for dynamic doorbell allocation */
+	proc_doorbells->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
+							GFP_KERNEL);
+	if (!proc_doorbells->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
+		return -ENOMEM;
+	}
 
-	if (r < 0)
-		pr_err("Failed to allocate process doorbells\n");
+	/* Allocate doorbells for this process from the PCI BAR */
+	proc_doorbells->size = kfd_doorbell_process_slice(kfd);
+	r = amdgpu_doorbell_alloc_page(kfd->adev, proc_doorbells);
+	if (r) {
+		DRM_ERROR("Failed to allocate process doorbells\n");
+		return r;
+	}
 
 	return r;
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
+	struct amdgpu_doorbell_obj *proc_doorbells = &pdd->qpd.proc_doorbells;
+
+	bitmap_free(proc_doorbells->doorbell_bitmap);
+	amdgpu_doorbell_free_page(kfd->adev, proc_doorbells);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0ed33416c35f..c97ed8e7e02d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -658,8 +658,8 @@ struct qcm_process_device {
 	uint64_t ib_base;
 	void *ib_kaddr;
 
-	/* doorbell resources per process per device */
-	unsigned long *doorbell_bitmap;
+	/* physical doorbell pages */
+	struct amdgpu_doorbell_obj proc_doorbells;
 };
 
 /* KFD Memory Eviction */
@@ -1006,9 +1006,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
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
index 51b1683ac5c1..68d0310c2d53 100644
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
@@ -1449,15 +1448,11 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	unsigned int i;
 	int range_start = dev->shared_resources.non_cp_doorbells_start;
 	int range_end = dev->shared_resources.non_cp_doorbells_end;
+	struct amdgpu_doorbell_obj *proc_doorbells = &qpd->proc_doorbells;
 
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
@@ -1466,9 +1461,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 
 	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
 		if (i >= range_start && i <= range_end) {
-			__set_bit(i, qpd->doorbell_bitmap);
+			__set_bit(i, proc_doorbells->doorbell_bitmap);
 			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
-				  qpd->doorbell_bitmap);
+				  proc_doorbells->doorbell_bitmap);
 		}
 	}
 
@@ -1499,9 +1494,15 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
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
@@ -1529,7 +1530,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 						false);
 		if (retval) {
 			pr_err("failed to allocate process context bo\n");
-			goto err_free_pdd;
+			goto err_free_db;
 		}
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
 	}
@@ -1541,6 +1542,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 
 	return pdd;
 
+err_free_db:
+	kfd_free_process_doorbells(pdd->dev, pdd);
+
 err_free_pdd:
 	kfree(pdd);
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5137476ec18e..693688d789d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -348,13 +348,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
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
+		*p_doorbell_offset_in_process = (q->properties.doorbell_off
+						- pdd->qpd.proc_doorbells.start) * sizeof(uint32_t);
 
 	pr_debug("PQM After DQM create queue\n");
 
@@ -858,12 +856,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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

