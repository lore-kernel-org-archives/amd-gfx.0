Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F1CEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3444110E302;
	Tue, 20 Jun 2023 17:16:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4003710E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcBQfp5o7/oeAlOvGNVazQIho/lTBzh4mmYDZIyNKcZoBog7IKnokmEwpyEuyqRvd2wdILnVA/yvuAhRiTFWllaRSMalqcZ9GFeo/nGmFaXAqyufN2AFVau8B6+wA+WOzN9C7ufOY22UByttUQfzS1wQCvB3+04ZXUyZydxQOYOmsZw8tWxafQ7ffUplrrC6/ri4JUNh+Ivno+CnGx5pwjsp2axtLXBVMysL9j5ZXeaFuhap2h4GLO9BmXvDIrzcmQFySYwfNqyUUkgNMSFR7xF1rpatHa9TDeSorXyaBK6bFzs8f4biZsHuQbCFULMwzgSFHTO1TjKGNeZ0zi1LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UGRDcvdEvdFE4BP/JRBc/V0iccCU/4V9vR4Zz8uUfk=;
 b=YjPLguEHmhzTzYyFJYpU1CueLWBDExXZQb4130sbQ+dF8WPzKhaJqDoiWREh9bvJXS21jOljlD6geBHZjqyiNsWQEiPKgbSKvvgRxPWjCPb5Vl3mWhAkOYjflnUMwYRwPWT5E1zBc0Kil+ocJlL7zztBQR7POaqSD1dhkxyUYQIUvjOROscqlP3ETab1/XUAtBh5nf5h37qrAper0jE5IVnyUXYOnoLyKJZDD9AfamRFKGdVjYA/iyZHx1FfNO0p6tGlMP4erIWfctgcmAzduYtnAaNlOq+Xy6ZnJplSN5TCSMnY/0Ik0bq+MAH1DtqP2yagz5ips2Cx9EpKUumAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UGRDcvdEvdFE4BP/JRBc/V0iccCU/4V9vR4Zz8uUfk=;
 b=z/rjjX1mWySIIx0wbwHHtKFG6JVbsEU6cMmO9pwqQjMi4Aatg8iuB4M6wC2zRQy0ur/Ek7voDhMD3oHzq4M32e6zrwHWDmAvAmJxA+viUNig4UqwK+ijdLGLg031wPUm1OWZVV5alWSs4+t0CixCwoCTbiyo16+ULFHhe8G7U2I=
Received: from BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:39 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::ef) by BY5PR04CA0029.outlook.office365.com
 (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Date: Tue, 20 Jun 2023 19:16:05 +0200
Message-ID: <20230620171608.2131-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: c395489c-195e-4a8e-ce93-08db71b21bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EATjim7naczZl5rDwHYMtJuFJx6W4UTpiTys54wMTvhvEVkhg2wkmrkHuTFhj9R+4cpE0tO2v2V7kBrbivKf6gwx0m9U2vSn17kYriHUzHNVjqMNbn05ArCUbcbizAcszI7sqQH/7AKW+IoOVo81XTlkqGoZiYpSWiXbXHgEPo65m8I4TQ/LRCV1ixZd88Evn6bIfgPtFmJ13PlYhaAKcCH6B2REuIMhbfqdQVecoo+kdsiX6vCgtMQDQv8FMR54BtBEckuI77twFnyNkMzitwuAuImR66AfeyvQWA1EQwntO5mBz98sewquolvbEq7LAVTWofxJDU9ayC0QA8s9ZVWTws0Vawaoo7KHusVWbtMJPAk7fiasGnMDdUHUHZJIovFjGtIruE8cOU8P9zNPmHOcFc0ryeRsZjQy/u1LPBujftfu5WBoWvTbgxOrc+pewK5q1ubdg1ueahu3fASu9XtcQzMth98KmTQvdFTjvjcnxl6VnUDjJVx2hkCkyLm6enlEVR9JgDxgAAGxeZkw0jmJlXnB+8FLQBO5WziSqu4sRDwsiPqgKHlKn1RU6+RujulEdox0XIEKxOz9VnQmFH3OYi/zD30ARijUmNiluIOPJvsvajM9vH0i94QE7sJyxoMzG86HiJyZ7KUeaBHCxPxHwNdAUYOUpsrQa41mgwQ66oiDRZm5KYE55dBmoHjCUZSJL6ARqT3VRX7jlk4iMksJxwn8xoLVwCAsK403wJ3n8m3uNvpQ0Y1pxMU37nZ93wG1aaqIeDdY9Yf5tdTJ9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(7696005)(478600001)(36860700001)(16526019)(186003)(1076003)(426003)(336012)(66574015)(47076005)(36756003)(83380400001)(82310400005)(86362001)(2616005)(81166007)(356005)(26005)(82740400003)(40480700001)(4326008)(6916009)(70586007)(70206006)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(30864003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:38.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c395489c-195e-4a8e-ce93-08db71b21bc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell object in kfd pdd structure.
- allocates doorbells for a process while creating its queue.
- frees the doorbells with pdd destroy.
- moves doorbell bitmap init function to kfd_doorbell.c

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
V3:
   - Do not allocate doorbell page with PDD, delay doorbell process
     page allocation until really needed (Felix)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  20 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 103 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  40 +------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  23 ++--
 6 files changed, 108 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1b54a9aaae70..5d4f4fca793a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -327,10 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	if (!pdd->doorbell_index &&
-	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
-		err = -ENOMEM;
-		goto err_alloc_doorbells;
+	if (!pdd->qpd.proc_doorbells) {
+		err = kfd_alloc_process_doorbells(dev, pdd);
+		if (err) {
+			pr_debug("failed to allocate process doorbells\n");
+			goto err_bind_process;
+		}
 	}
 
 	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
@@ -410,7 +412,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	if (wptr_bo)
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
-err_alloc_doorbells:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
@@ -2239,11 +2240,12 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (!pdd->doorbell_index &&
-		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
-			ret = -ENOMEM;
-			goto exit;
+		if (!pdd->qpd.proc_doorbells) {
+			ret = kfd_alloc_process_doorbells(dev, pdd);
+			if (ret)
+				goto exit;
 		}
+
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7a95698d83f7..834f640cf807 100644
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
index f7d45057ed32..c9ca21e1a99a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -232,48 +232,97 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 
 }
 
+static int init_doorbell_bitmap(struct qcm_process_device *qpd,
+				struct kfd_dev *dev)
+{
+	unsigned int i;
+	int range_start = dev->shared_resources.non_cp_doorbells_start;
+	int range_end = dev->shared_resources.non_cp_doorbells_end;
+
+	if (!KFD_IS_SOC15(dev))
+		return 0;
+
+	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
+	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
+	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
+			range_start + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
+			range_end + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
+
+	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
+		if (i >= range_start && i <= range_end) {
+			__set_bit(i, qpd->doorbell_bitmap);
+			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
+				  qpd->doorbell_bitmap);
+		}
+	}
+
+	return 0;
+}
+
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
-	if (!pdd->doorbell_index) {
-		int r = kfd_alloc_process_doorbells(pdd->dev,
-						    &pdd->doorbell_index);
-		if (r < 0)
+	struct amdgpu_device *adev = pdd->dev->adev;
+	uint32_t first_db_index;
+
+	if (!pdd->qpd.proc_doorbells) {
+		if (kfd_alloc_process_doorbells(pdd->dev, pdd))
+			/* phys_addr_t 0 is error */
 			return 0;
 	}
 
-	return pdd->dev->doorbell_base +
-		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
+	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
+	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
 }
 
-int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
+int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
 {
-	int r = 0;
+	int r;
+	struct qcm_process_device *qpd = &pdd->qpd;
 
-	if (!kfd->shared_resources.enable_mes)
-		r = ida_simple_get(&kfd->doorbell_ida, 1,
-				   kfd->max_doorbell_slices, GFP_KERNEL);
-	else
-		r = amdgpu_mes_alloc_process_doorbells(
-				(struct amdgpu_device *)kfd->adev,
-				doorbell_index);
+	/* Allocate bitmap for dynamic doorbell allocation */
+	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					     GFP_KERNEL);
+	if (!qpd->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
+		return -ENOMEM;
+	}
 
-	if (r > 0)
-		*doorbell_index = r;
+	r = init_doorbell_bitmap(&pdd->qpd, kfd);
+	if (r) {
+		DRM_ERROR("Failed to initialize process doorbells\n");
+		r = -ENOMEM;
+		goto err;
+	}
+
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
+		goto err;
+	}
 
-	if (r < 0)
-		pr_err("Failed to allocate process doorbells\n");
+	return 0;
 
+err:
+	bitmap_free(qpd->doorbell_bitmap);
+	qpd->doorbell_bitmap = NULL;
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
+	struct qcm_process_device *qpd = &pdd->qpd;
+
+	if (qpd->doorbell_bitmap) {
+		bitmap_free(qpd->doorbell_bitmap);
+		qpd->doorbell_bitmap = NULL;
 	}
+
+	amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 42c215782d72..d0abfaccf8c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -664,7 +664,10 @@ struct qcm_process_device {
 	uint64_t ib_base;
 	void *ib_kaddr;
 
-	/* doorbell resources per process per device */
+	/* doorbells for kfd process */
+	struct amdgpu_bo *proc_doorbells;
+
+	/* bitmap for dynamic doorbell allocation from the bo */
 	unsigned long *doorbell_bitmap;
 };
 
@@ -1013,9 +1016,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
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
index 07a9eaf9b7d8..bb1281a4feef 100644
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
@@ -1496,38 +1495,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	return ERR_PTR(err);
 }
 
-static int init_doorbell_bitmap(struct qcm_process_device *qpd,
-			struct kfd_dev *dev)
-{
-	unsigned int i;
-	int range_start = dev->shared_resources.non_cp_doorbells_start;
-	int range_end = dev->shared_resources.non_cp_doorbells_end;
-
-	if (!KFD_IS_SOC15(dev))
-		return 0;
-
-	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
-					     GFP_KERNEL);
-	if (!qpd->doorbell_bitmap)
-		return -ENOMEM;
-
-	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
-	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
-	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
-			range_start + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
-			range_end + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
-
-	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
-		if (i >= range_start && i <= range_end) {
-			__set_bit(i, qpd->doorbell_bitmap);
-			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
-				  qpd->doorbell_bitmap);
-		}
-	}
-
-	return 0;
-}
-
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
 							struct kfd_process *p)
 {
@@ -1552,11 +1519,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	if (!pdd)
 		return NULL;
 
-	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
-		pr_err("Failed to init doorbell for process\n");
-		goto err_free_pdd;
-	}
-
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4236539d9f93..5eff74015d51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -344,17 +344,20 @@ int pqm_create_queue(struct process_queue_manager *pqm,
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
+								       pdd->qpd.proc_doorbells,
+								       0);
+
+		*p_doorbell_offset_in_process = (q->properties.doorbell_off
+						- first_db_index) * sizeof(uint32_t);
+	}
 
 	pr_debug("PQM After DQM create queue\n");
 
@@ -858,12 +861,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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
2.40.1

