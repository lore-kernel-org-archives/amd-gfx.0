Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2329C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 00:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E232068E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qWPM//JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E232068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494AB6E137;
	Wed,  2 Sep 2020 00:21:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698C26E137
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 00:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhUmMI1HE2eHqpSdXIFBAXwK+AexauQzYMgZJzlSrHlf+h/chCoiMJMgBq4K09su3N8R/0CohhXWhggc1DMVvGZFbf0adGBjyUL8hKGe2V3y9Ljnjjxmsp9HXzKjeC6kfRcoVStQ5NdYfGUEzyQihve7qKBWfjm/ty5tpDLVkr2Qc8JjWbD/1ayxeBlR+mA28K7ByTl2pDNiYNllQtLAQ/Xvkzu78Dlc9pQsWz7fG4z4bKS3niS2nsCDlmmXC+UIkAu1hoH929gy4X+2xcco2BVRAIID5H5/5rnHgvkBk1w5jY8rE4eVTqOuDk9DyEHKKTE5gHxoVh3ghjG6RJi/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZWJ98FWki1sfUhqI97R+plgjbO7AWdorC+9NgHTrIA=;
 b=eHQBHOG9jXGk6t8a1pFO21CsNRBenkkg/FPAWhQwjQ8sVmPC8T2Wj/mxjIBqHtEQvXcuDiQGvHdqjYGgEEAcoKFlvew6wm/0KDBdcGXZi0mOEsUXnFy4ouQXWLU+IL3ePLdiQOa3a4RpVi3xfcz3F5s8ap9LblLTcxzVVT8nLzyLvKf7kCNVZaGNDC1N3jpyBTJXQpZO3ElJ0+XQS+kE3zuZV4LeYyAwOMZ0apZRJhMd30TYMSyEQ9aEnf92QT6AOHUIlFUH0tYANp29iWj9+m9aSA4+4toIw4lufQwFrsa5VKzTs13u50JTgRiYXDypClPm2wEzw2sun7rWuH+uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZWJ98FWki1sfUhqI97R+plgjbO7AWdorC+9NgHTrIA=;
 b=qWPM//JZijXi5+fiGYI3j6sX1GbkiEwXIHyjDXkIopkaJd5FNetpfuF/5hckrjqNEkP0HRBqCaBCCadJ/Tpi/h3L3PDPVrulmgNzcMxa3oYAPb63ymepUiMM/2dszXKR0JzyL+656c3PEBSQ071bR6arZrBkEUc5fh43azToXQ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:21:18 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:21:18 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Move process doorbell allocation into kfd device
Date: Tue,  1 Sep 2020 20:21:05 -0400
Message-Id: <20200902002105.31071-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:21:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a35778d5-13ef-4002-e7ca-08d84ed61c7c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3172AB60AD65736B64242787EE2F0@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/JKMzbWhF/4Uc15dvBc99eFnSEufoePBz7k7FvsE4BBLb0TGHSn6Qshd8oEaUVPbs6DbMesPYsf7zGxNcJdzoPdfqL6Hh1dEo9wFaDacnihlZidU7ViuPilbARLg3Ia9SYwbH6Kty+aYSJ1g0wO+6OXFL3bLFapRjH3C47lcwXcbqX5uF6CuuKZIVVeK2eiGWQztwSnJTTo3tImI4Gf5O0SjWnY+Rt8oYGFQu6ukNqX7hIVJq9A4+Emn7pPYdOaq2orLLinftPvYUYLiIMJNPpbcU+AyGpeOaYWj8j2i1hbdxSUjjxYPrE+Y3R5luIyeNf9v3wxrXaljaS/9mLvNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(2906002)(66556008)(66476007)(66946007)(6666004)(44832011)(26005)(8676002)(6916009)(52116002)(186003)(8936002)(4326008)(1076003)(316002)(5660300002)(36756003)(30864003)(16576012)(83380400001)(6486002)(2616005)(956004)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0N+aC04tVpqLxRP/f7cy3NQn8ZVK/Te0dduWLQBWsLmoprm3UFK/dWzLQfAosyKkLJsO8fHqk84gPkg5X8H9R6IgNSV6C7xPHa4JnfMeHK5NL8awVCe3cd/+CElpQRkUP4uSIcz4DXJ/KafenAbs7Uu7t/H6pj4jOUqZ8iTRaLe4EXBm5Rhl/I1kIRTdss0BAJERwBtZnakHRMDhk9WPrsLL9TVeYvYD0djyDeXBAAHaeLFjUsUXjR/qWQZjUFEOZ/LLjmmyE6s9fg3nAV/KJ/Y+7IQgkfbzgcro/3MIbfUN/s2cxc14wpXr/k7iE+jrpp0IUAkLTgPoJzYqh4fnc5WsqzFZqRKrlTxSIhdFIQr7mdkNduFARCGjHcLMDE5cytV6DSbVYQAuI4cnzV1GbUo4Rb8JTytGzvARocF6POd4k8jNDN9fmzIIgn57HdYkJKCAGlivTEQzdjMggkNwKuOuYXkCD6S9VS9bWZfy8LLPaW9qtCT5ZngruDlY8qTT81/4t7Z/owY41uoP+hKaRWWsulwWXua57RkMX9XTbn4RJtJhFkXsYFgXMl7Hpt3ur1PAN3Qk9O+UFxtC+zPdPIWIPusbBPNY+f76daZ5qWwSQyXFv7dYMkKSrpcJvuT5CHotD5nEIZ7wJwKifzU6OQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35778d5-13ef-4002-e7ca-08d84ed61c7c
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:21:18.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EYyFCOOel2zcKVUr35jxlyKPGnwXvBlO532FiAgCBjxpoImfF42H+nMP/Y3ooIyS/lKnnepS+P04rwKk69zfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move doorbell allocation for a process into kfd device and
allocate doorbell space in each PDD during process creation.
Currently, KFD manages its own doorbell space but for some
devices, amdgpu would allocate the complete doorbell
space instead of leaving a chunk of doorbell space for KFD to
manage. In a system with mix of such devices, KFD would need
to request process doorbell space based on the type of device,
either from amdgpu or from its own doorbell space.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 30 +++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 37 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 17 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 ++++++-----
 6 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b7b16adb0615..b23caa78328b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1290,18 +1290,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		return -EINVAL;
 	}
 
-	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
-		if (args->size != kfd_doorbell_process_slice(dev))
-			return -EINVAL;
-		offset = kfd_get_process_doorbells(dev, p);
-	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
-		if (args->size != PAGE_SIZE)
-			return -EINVAL;
-		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset)
-			return -ENOMEM;
-	}
-
 	mutex_lock(&p->mutex);
 
 	pdd = kfd_bind_process_to_device(dev, p);
@@ -1310,6 +1298,24 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
+		if (args->size != kfd_doorbell_process_slice(dev)) {
+			err = -EINVAL;
+			goto err_unlock;
+		}
+		offset = kfd_get_process_doorbells(dev, pdd);
+	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
+		if (args->size != PAGE_SIZE) {
+			err = -EINVAL;
+			goto err_unlock;
+		}
+		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
+		if (!offset) {
+			err = -ENOMEM;
+			goto err_unlock;
+		}
+	}
+
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		dev->kgd, args->va_addr, args->size,
 		pdd->vm, (struct kgd_mem **) &mem, &offset,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e71a0543f98..a857282f3d09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -583,6 +583,8 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
+	ida_init(&kfd->doorbell_ida);
+
 	return kfd;
 }
 
@@ -798,6 +800,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
 		kfd_doorbell_fini(kfd);
+		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
 		amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
 		if (kfd->gws)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 560adc57a050..b9d1359c6fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -191,9 +191,8 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 	}
 
 	q->properties.doorbell_off =
-		kfd_get_doorbell_dw_offset_in_bar(dev, q->process,
+		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
 					  q->doorbell_id);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 8e0c00b9555e..5946bfb6b75c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -31,9 +31,6 @@
  * kernel queues using the first doorbell page reserved for the kernel.
  */
 
-static DEFINE_IDA(doorbell_ida);
-static unsigned int max_doorbell_slices;
-
 /*
  * Each device exposes a doorbell aperture, a PCI MMIO aperture that
  * receives 32-bit writes that are passed to queues as wptr values.
@@ -84,9 +81,9 @@ int kfd_doorbell_init(struct kfd_dev *kfd)
 	else
 		return -ENOSPC;
 
-	if (!max_doorbell_slices ||
-	    doorbell_process_limit < max_doorbell_slices)
-		max_doorbell_slices = doorbell_process_limit;
+	if (!kfd->max_doorbell_slices ||
+	    doorbell_process_limit < kfd->max_doorbell_slices)
+		kfd->max_doorbell_slices = doorbell_process_limit;
 
 	kfd->doorbell_base = kfd->shared_resources.doorbell_physical_address +
 				doorbell_start_offset;
@@ -130,6 +127,7 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
 		      struct vm_area_struct *vma)
 {
 	phys_addr_t address;
+	struct kfd_process_device *pdd;
 
 	/*
 	 * For simplicitly we only allow mapping of the entire doorbell
@@ -138,9 +136,12 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != kfd_doorbell_process_slice(dev))
 		return -EINVAL;
 
-	/* Calculate physical address of doorbell */
-	address = kfd_get_process_doorbells(dev, process);
+	pdd = kfd_get_process_device_data(dev, process);
+	if (!pdd)
+		return -EINVAL;
 
+	/* Calculate physical address of doorbell */
+	address = kfd_get_process_doorbells(dev, pdd);
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
 				VM_DONTDUMP | VM_PFNMAP;
 
@@ -226,7 +227,7 @@ void write_kernel_doorbell64(void __iomem *db, u64 value)
 }
 
 unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
-					struct kfd_process *process,
+					struct kfd_process_device *pdd,
 					unsigned int doorbell_id)
 {
 	/*
@@ -236,7 +237,7 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
 	 * units regardless of the ASIC-dependent doorbell size.
 	 */
 	return kfd->doorbell_base_dw_offset +
-		process->doorbell_index
+		pdd->doorbell_index
 		* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
 		doorbell_id * kfd->device_info->doorbell_size / sizeof(u32);
 }
@@ -252,24 +253,24 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 }
 
 phys_addr_t kfd_get_process_doorbells(struct kfd_dev *dev,
-					struct kfd_process *process)
+				      struct kfd_process_device *pdd)
 {
 	return dev->doorbell_base +
-		process->doorbell_index * kfd_doorbell_process_slice(dev);
+		pdd->doorbell_index * kfd_doorbell_process_slice(dev);
 }
 
-int kfd_alloc_process_doorbells(struct kfd_process *process)
+int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
 {
-	int r = ida_simple_get(&doorbell_ida, 1, max_doorbell_slices,
+	int r = ida_simple_get(&kfd->doorbell_ida, 1, kfd->max_doorbell_slices,
 				GFP_KERNEL);
 	if (r > 0)
-		process->doorbell_index = r;
+		*doorbell_index = r;
 
 	return r;
 }
 
-void kfd_free_process_doorbells(struct kfd_process *process)
+void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
 {
-	if (process->doorbell_index)
-		ida_simple_remove(&doorbell_ida, process->doorbell_index);
+	if (*doorbell_index)
+		ida_simple_remove(&kfd->doorbell_ida, *doorbell_index);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 023629f28495..93b51de14aa0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -314,6 +314,9 @@ struct kfd_dev {
 	spinlock_t smi_lock;
 
 	uint32_t reset_seq_num;
+
+	struct ida doorbell_ida;
+	unsigned int max_doorbell_slices;
 };
 
 enum kfd_mempool {
@@ -692,6 +695,8 @@ struct kfd_process_device {
 	uint64_t sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
+
+	unsigned int doorbell_index;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -729,7 +734,6 @@ struct kfd_process {
 	struct mmu_notifier mmu_notifier;
 
 	uint16_t pasid;
-	unsigned int doorbell_index;
 
 	/*
 	 * List of kfd_process_device structures,
@@ -862,13 +866,14 @@ u32 read_kernel_doorbell(u32 __iomem *db);
 void write_kernel_doorbell(void __iomem *db, u32 value);
 void write_kernel_doorbell64(void __iomem *db, u64 value);
 unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
-					struct kfd_process *process,
+					struct kfd_process_device *pdd,
 					unsigned int doorbell_id);
 phys_addr_t kfd_get_process_doorbells(struct kfd_dev *dev,
-					struct kfd_process *process);
-int kfd_alloc_process_doorbells(struct kfd_process *process);
-void kfd_free_process_doorbells(struct kfd_process *process);
-
+				      struct kfd_process_device *pdd);
+int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
+				unsigned int *doorbell_index);
+void kfd_free_process_doorbells(struct kfd_dev *kfd,
+				unsigned int *doorbell_index);
 /* GTT Sub-Allocator */
 
 int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a0e12a79ab7d..28bbdebb4703 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -781,6 +781,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfree(pdd->qpd.doorbell_bitmap);
 		idr_destroy(&pdd->alloc_idr);
 
+		kfd_free_process_doorbells(pdd->dev, &pdd->doorbell_index);
+
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
@@ -833,8 +835,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_event_free_process(p);
 
 	kfd_pasid_free(p->pasid);
-	kfd_free_process_doorbells(p);
-
 	mutex_destroy(&p->mutex);
 
 	put_task_struct(p->lead_thread);
@@ -1012,9 +1012,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	if (process->pasid == 0)
 		goto err_alloc_pasid;
 
-	if (kfd_alloc_process_doorbells(process) < 0)
-		goto err_alloc_doorbells;
-
 	err = pqm_init(&process->pqm, process);
 	if (err != 0)
 		goto err_process_pqm_init;
@@ -1042,8 +1039,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 err_init_apertures:
 	pqm_uninit(&process->pqm);
 err_process_pqm_init:
-	kfd_free_process_doorbells(process);
-err_alloc_doorbells:
 	kfd_pasid_free(process->pasid);
 err_alloc_pasid:
 	mutex_destroy(&process->mutex);
@@ -1106,10 +1101,14 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	if (!pdd)
 		return NULL;
 
+	if (kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
+		pr_err("Failed to alloc doorbell for pdd\n");
+		goto err_free_pdd;
+	}
+
 	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
 		pr_err("Failed to init doorbell for process\n");
-		kfree(pdd);
-		return NULL;
+		goto err_free_pdd;
 	}
 
 	pdd->dev = dev;
@@ -1131,6 +1130,10 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	idr_init(&pdd->alloc_idr);
 
 	return pdd;
+
+err_free_pdd:
+	kfree(pdd);
+	return NULL;
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
