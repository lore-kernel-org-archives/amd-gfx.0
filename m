Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FBC4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C2D610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80C2D610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4090A6E94C;
	Thu, 19 Aug 2021 13:37:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535316E94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksQBs7UYcY6GEo1yfA6ZAd9d/ayui7kK3YiKyMPtJFUeK8RlHFJ6ZMNOUg+qAahv7RWAQu7X8YfII0eD3g7uSF2pAeW+EjHNoebigAyFi6utrueo4pLq9N0YhtX6aSotR3jN5QDW7lfM3iuMEayyS2xanW+0clFrH4+ihc55BQcPb1s/26UQpH4VZWMur6EaskXEZ9NApxvR8jS6i4WR+8ByRcZlXwDKL7o5npRp/4SsQEsoSgfGZJs0+coyNTGIfZJmeUnq2t6rRYQXcebh+jLvYIl00fy7UkNITMUUHzySTAlzXDLCzLc00N6CzaSkRRexDMGAv15ZTUyLWdX3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL0ttmUSyrPhRnxmiaW8xussYpmivlA21Fuq2eYgx+c=;
 b=M5dgBxj6YXGodUxewQ3i6pjeMYNIP+C1xkJBnalOxkiggRVHoazprgSwu3I9bsYwqDrm0IM9GRlm03t5/o3ps4pVmov46bQVJTVThZkAbaDESalz0wJ7g6mSfvD6icqUerthXXdarYSwMKScN3lkevC2aLosTy9Y9RhdDOA4nLIjaRVfj+8bNAdAAP1VGIoBKLS9D1eWopJl/tGAKoCrLMcEki5YhQPS7MK1LLykrqMaYpJC/MsHQrLPTrPuim1FXT+DZ9UAM/q78nvvCnmZoD3Sj5THq6aSqOg9wkzacOLMKrBRywXHlOgzgLSnL45Dh+Yb86dvmkE9R2OaJkS0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL0ttmUSyrPhRnxmiaW8xussYpmivlA21Fuq2eYgx+c=;
 b=qWleAwbk2aT7Lvhm5V/fDMo6kuRKn5NPWQjmsN2R6R6tJzMw9Lu4XlAnQBJDJMyzAMZjdZt2YlFv/MMcXVryWDv2ud8CMK3QMEM14wG4pTG224uHAbs/ja/J0jVml9pC09Vfo9++lpYzVoSJXtIfeNYzBA/9TG3gYgVzEtnoHvg=
Received: from MWHPR2201CA0043.namprd22.prod.outlook.com
 (2603:10b6:301:16::17) by BN8PR12MB4978.namprd12.prod.outlook.com
 (2603:10b6:408:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 13:37:51 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::4d) by MWHPR2201CA0043.outlook.office365.com
 (2603:10b6:301:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:51 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:48 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 06/18] drm/amdkfd: CRIU Implement KFD restore ioctl
Date: Thu, 19 Aug 2021 09:37:01 -0400
Message-ID: <20210819133713.4168-7-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48c194b3-e723-429c-0ee8-08d963168a62
X-MS-TrafficTypeDiagnostic: BN8PR12MB4978:
X-Microsoft-Antispam-PRVS: <BN8PR12MB49789EE0C666F46BA5E6F07995C09@BN8PR12MB4978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDhX9IF5iDMHXcPd+cnP99wUzhHTAc3g01iFPvbcb6EQ8GarmiRlLhku0U9L/UJcjxhOxhEmrfm8J34IT8U9fb0nbxJ+dZKy28XwRnMUQlbtkXnv7zgKtV4tJ4Imukqz+noYIXO1DToMmTTkhyL9gNEenrWYNxyZEWeIxi1AA0ovFYBD+C4ZkZL7bXTMZHZxVq0OFAG6c3H2xlr+9Cwamzq4divo75VCoGQuY59tvgYJDSAwTNkuVRdW1YnjmkWV8JXKnGsrqJMAitQ6iNtEcRXzx9XhpDUZYYkvIMr0px84AxaCeR9fSnpWVFZy1hM27nyQTErop/rWhFkIoXEa8gwjpsPGDnIfkMryeTAZidp+0Hq3Ixb/vkAfykjyKzrZMQ7GPN+2xWYFovdyVKG9ErQm1J1NobR3uzmBMGxaPmfCHdSg1NJ0HoHSPhT7QJ7Ggho09EcEWxA4d9s/zsW8ETdgWV/j6XYQL5mwVw4T68wVfaLoOimdzv156JIy3VpVmLC5QC5RWq+M5u7JvMzCzK2VbNx7UfLOTTypV0KXr1n3QmREBEd6yAWf4iDlv+fMrMFSKd3uHX82LjVN3QnWskZGKqPyiB6q1j23AZ3ojp3OcyQCea/v/wqzRp/yKRcN3pc+Kkfwss3BOgDYRdR8eSfFns04I8QY35jZedt1jBXGwi3yHlhS8o9y7tViGjKJxYhrWQR0YjZOhqgU2kMmcPqJNti7STmNagzjU9EVndxIYugi3SkKbUDw3NUWCJFJM588xUFiEPfeDbfBqyuZZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(1076003)(34020700004)(7696005)(316002)(6916009)(82310400003)(4326008)(2906002)(81166007)(478600001)(8936002)(70586007)(6666004)(36860700001)(5660300002)(83380400001)(356005)(8676002)(336012)(16526019)(36756003)(186003)(47076005)(2616005)(86362001)(82740400003)(26005)(70206006)(54906003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:51.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c194b3-e723-429c-0ee8-08d963168a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4978
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This implements the KFD CRIU Restore ioctl that lays the basic
foundation for the CRIU restore operation. It provides support to
create the buffer objects corresponding to Non-Paged system memory
mapped for GPU and/or CPU access and lays basic foundation for the
userptrs buffer objects which will be added in a separate patch.
This ioctl creates various types of buffer objects such as VRAM,
MMIO, Doorbell, GTT based on the date sent from the userspace plugin.
The data mostly contains the previously checkpointed KFD images from
some KFD processs.

While restoring a criu process, attach old IDR values to newly
created BOs. This also adds the minimal gpu mapping support for a single
gpu checkpoint restore use case.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
(cherry picked from commit 47bb685701c336d1fde7e91be93d9cabe89a4c1b)
(cherry picked from commit b71ba8158a7ddf9e4fd8d872be4e40ddd9a29b4f)
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 284 ++++++++++++++++++++++-
 1 file changed, 282 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d548e6691d69..2dab1845f9d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2010,12 +2010,292 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 	return ret;
 }
 
+static int criu_restore_process(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args)
+{
+	int ret = 0;
+	uint8_t *objects;
+	struct kfd_criu_process_bucket *process_bucket;
+	struct kfd_criu_process_priv_data *process_priv;
+
+	if (args->num_objects != 1) {
+		pr_err("Only 1 process supported\n");
+		return -EINVAL;
+	}
+
+	if (args->objects_size != sizeof(*process_bucket) + sizeof(*process_priv)) {
+		pr_err("Invalid objects size for process\n");
+		return -EINVAL;
+	}
+
+	objects = kmalloc(args->objects_size, GFP_KERNEL);
+	if (!objects)
+		return -ENOMEM;
+
+	ret = copy_from_user(objects, (void __user *)args->objects, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy process information from user\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	process_bucket = (struct kfd_criu_process_bucket *)objects;
+	/* Private data starts after process bucket */
+	process_priv = (struct kfd_criu_process_priv_data *)
+			(objects + sizeof(*process_bucket) + process_bucket->priv_data_offset);
+
+	if (process_priv->version != KFD_CRIU_PRIV_VERSION) {
+		pr_err("Invalid CRIU API version (checkpointed:%d current:%d)\n",
+			process_priv->version, KFD_CRIU_PRIV_VERSION);
+		return -EINVAL;
+	}
+
+exit:
+	kfree(objects);
+	return ret;
+}
+
+static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args)
+{
+	uint8_t *objects, *private_data;
+	struct kfd_criu_bo_bucket *bo_buckets;
+	int ret = 0, i, j = 0;
+
+	if (args->objects_size != args->num_objects *
+		(sizeof(*bo_buckets) + sizeof(struct kfd_criu_bo_priv_data))) {
+		pr_err("Invalid objects size for BOs\n");
+		return -EINVAL;
+	}
+
+	objects = kmalloc(args->objects_size, GFP_KERNEL);
+	if (!objects)
+		return -ENOMEM;
+
+	ret = copy_from_user(objects, (void __user *)args->objects, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy BOs information from user\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	bo_buckets = (struct kfd_criu_bo_bucket *) objects;
+	/* Private data for first BO starts after all bo_buckets */
+	private_data = (void *)(bo_buckets + args->num_objects);
+
+	/* Create and map new BOs */
+	for (i = 0; i < args->num_objects; i++) {
+		struct kfd_criu_bo_bucket *bo_bucket;
+		struct kfd_criu_bo_priv_data *bo_priv;
+		struct kfd_dev *dev;
+		struct kfd_process_device *pdd;
+		void *mem;
+		u64 offset;
+		int idr_handle;
+
+		bo_bucket = &bo_buckets[i];
+		bo_priv = (struct kfd_criu_bo_priv_data *)
+				(private_data + bo_bucket->priv_data_offset);
+
+		dev = kfd_device_by_id(bo_bucket->gpu_id);
+		if (!dev) {
+			ret = -EINVAL;
+			pr_err("Failed to get pdd\n");
+			goto exit;
+		}
+		pdd = kfd_get_process_device_data(dev, p);
+		if (!pdd) {
+			ret = -EINVAL;
+			pr_err("Failed to get pdd\n");
+			goto exit;
+		}
+
+		pr_debug("kfd restore ioctl - bo_bucket[%d]:\n", i);
+		pr_debug("size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n"
+			"gpu_id = 0x%x alloc_flags = 0x%x\n"
+			"idr_handle = 0x%x\n",
+			bo_bucket->size,
+			bo_bucket->addr,
+			bo_bucket->offset,
+			bo_bucket->gpu_id,
+			bo_bucket->alloc_flags,
+			bo_priv->idr_handle);
+
+		if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
+			pr_debug("restore ioctl: KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL\n");
+			if (bo_bucket->size != kfd_doorbell_process_slice(dev)) {
+				ret = -EINVAL;
+				goto exit;
+			}
+			offset = kfd_get_process_doorbells(pdd);
+		} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
+			/* MMIO BOs need remapped bus address */
+			pr_debug("restore ioctl :KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP\n");
+			if (bo_bucket->size != PAGE_SIZE) {
+				pr_err("Invalid page size\n");
+				ret = -EINVAL;
+				goto exit;
+			}
+			offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
+			if (!offset) {
+				pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
+				ret = -ENOMEM;
+				goto exit;
+			}
+		} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+			offset = bo_priv->user_addr;
+		}
+
+		/* Create the BO */
+		ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(dev->kgd,
+						bo_bucket->addr,
+						bo_bucket->size,
+						pdd->drm_priv,
+						(struct kgd_mem **) &mem,
+						&offset,
+						bo_bucket->alloc_flags);
+		if (ret) {
+			pr_err("Could not create the BO\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+		pr_debug("New BO created: size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n",
+			bo_bucket->size, bo_bucket->addr, offset);
+
+		/* Restore previuos IDR handle */
+		pr_debug("Restoring old IDR handle for the BO");
+		idr_handle = idr_alloc(&pdd->alloc_idr, mem,
+				       bo_priv->idr_handle,
+				       bo_priv->idr_handle + 1, GFP_KERNEL);
+		if (idr_handle < 0) {
+			pr_err("Could not allocate idr\n");
+			amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
+						(struct kgd_mem *)mem,
+						pdd->drm_priv, NULL);
+
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
+			bo_bucket->restored_offset = KFD_MMAP_TYPE_DOORBELL |
+				KFD_MMAP_GPU_ID(pdd->dev->id);
+		if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
+			bo_bucket->restored_offset = KFD_MMAP_TYPE_MMIO |
+				KFD_MMAP_GPU_ID(pdd->dev->id);
+		} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
+			bo_bucket->restored_offset = offset;
+			pr_debug("updating offset for GTT\n");
+		} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+			bo_bucket->restored_offset = offset;
+			/* Update the VRAM usage count */
+			WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
+			pr_debug("updating offset for VRAM\n");
+		}
+
+		/* now map these BOs to GPU/s */
+		for (j = 0; j < p->n_pdds; j++) {
+			struct kfd_process_device *pdd = p->pdds[j];
+			struct kfd_dev *peer;
+			struct kfd_process_device *peer_pdd;
+
+			peer = kfd_device_by_id(pdd->dev->id);
+
+			pr_debug("Inside mapping loop with desired gpu_id = 0x%x\n",
+							pdd->dev->id);
+			if (!peer) {
+				pr_debug("Getting device by id failed for 0x%x\n",
+						pdd->dev->id);
+				ret = -EINVAL;
+				goto exit;
+			}
+
+			peer_pdd = kfd_bind_process_to_device(peer, p);
+			if (IS_ERR(peer_pdd)) {
+				ret = PTR_ERR(peer_pdd);
+				goto exit;
+			}
+			pr_debug("map mem in restore ioctl -> 0x%llx\n",
+				 ((struct kgd_mem *)mem)->va);
+			ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->kgd,
+				(struct kgd_mem *)mem, peer_pdd->drm_priv);
+			if (ret) {
+				pr_err("Failed to map to gpu %d/%d\n",
+				j, p->n_pdds);
+				goto exit;
+			}
+		}
+
+		ret = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
+						      (struct kgd_mem *) mem, true);
+		if (ret) {
+			pr_debug("Sync memory failed, wait interrupted by user signal\n");
+			goto exit;
+		}
+
+		pr_debug("map memory was successful for the BO\n");
+	} /* done */
+
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (j = 0; j < p->n_pdds; j++) {
+		struct kfd_dev *peer;
+		struct kfd_process_device *pdd = p->pdds[j];
+		struct kfd_process_device *peer_pdd;
+
+		peer = kfd_device_by_id(pdd->dev->id);
+		if (WARN_ON_ONCE(!peer))
+			continue;
+		peer_pdd = kfd_get_process_device_data(peer, p);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		kfd_flush_tlb(peer_pdd);
+	}
+	/* Copy only the buckets back so user can read bo_buckets[N].restored_offset */
+	ret = copy_to_user((void __user *)args->objects,
+				bo_buckets,
+				(args->num_objects * sizeof(*bo_buckets)));
+	if (ret)
+		ret = -EFAULT;
+
+exit:
+	kvfree(objects);
+	return ret;
+}
+
 static int kfd_ioctl_criu_restorer(struct file *filep,
 				struct kfd_process *p, void *data)
 {
-	pr_debug("Inside %s\n", __func__);
+	struct kfd_ioctl_criu_restorer_args *args = data;
+	int ret;
 
-	return 0;
+	if (!args->objects || !args->objects_size)
+		return -EINVAL;
+
+	mutex_lock(&p->mutex);
+
+	switch (args->type) {
+	case KFD_CRIU_OBJECT_TYPE_PROCESS:
+		ret = criu_restore_process(p, args);
+		break;
+	case KFD_CRIU_OBJECT_TYPE_BO:
+		ret = criu_restore_bos(p, args);
+		break;
+	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+	case KFD_CRIU_OBJECT_TYPE_EVENT:
+	case KFD_CRIU_OBJECT_TYPE_DEVICE:
+	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
+	default:
+		pr_err("Unsupported object type:%d\n", args->type);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	mutex_unlock(&p->mutex);
+	if (ret)
+		pr_err("Failed to restore CRIU type:%d ret:%d\n", args->type, ret);
+	else
+		pr_debug("CRIU restore type:%d ret:%d\n", args->type, ret);
+
+	return ret;
 }
 
 static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
-- 
2.17.1

