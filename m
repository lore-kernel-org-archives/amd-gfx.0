Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8698C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D3261462
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6D3261462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B7D6EA4D;
	Wed, 29 Sep 2021 12:01:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FAD6EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJeDcBjTNA/EVw5rurRxUJyxdFYe8nP754AZWVosFlFYgNB9/r+7J0KzVOjfRb67EmsExhZ0GFTvzavc2FWK/KZVBGQLRIrAUiRETryXFRFzdpCh7jTyzrgJxKkRuIk/Q3XNa5W5LjJyoZmgQoLFuS4WXf8Ig1r7DC7kfce/jpu8pIvgKDtMHmq7Of3eEWOWDgoKVB3AGybFkaAi6SCaDh7suLutdaviErbjmt57jPQKJbQXicd5D/XGfbw1lvt8ewR3sd8C9bvIUoIsoM14NmLyc6/oLqDl0OAxnTo6ZEs4l0vqg/yYOJhtCjMvr3hZqIxUUy8PGm+E1KQ7ZRdUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qRNRzHKzqsMMjwD0UIFNMd9vD7l5RFqfDrWY106/Qx8=;
 b=A6dPTfStr8kHG6DuJnRmRYxMo46Y86IwDDCqVpqPzbkxZ378VpXS2dlsrnPE3llCFLGSbCZrja9aVux3of1bGfBDKC0UJrCh7gCtZBZN56PEdktObjlKQNsXoXceypKwER94So/Szs9FHh3SnA+WhiDTVpq0MekQD0NJhfEP+EHrvfUsVNss1O2GRSxX426HJO/hruvC2kGTUHbxHw974Knr+CfqNN2GHZ9VF/e2IQURataZjr3obRIAyFdzoj1XvE1ABEOmDkK9R/GpASnbi8W7c9OP0Xl6B5EMqJnRXHg6pDQNT03Si16UKjiXETXB/orEdVbp6OaZ7E6l88dxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRNRzHKzqsMMjwD0UIFNMd9vD7l5RFqfDrWY106/Qx8=;
 b=uHvNwbxFKHrbSd21zWG7fXDKB2H7jdjENuTKpEqN2mqRelTdBeqvwa5AxAjcUQEwXaWb7KYAJbcDPSR9IE3yEuPYK3tTtrNqxI4T2WibUY8fc4qaqu7MAh5ihawHZLFILvTmqsRIDTZGqaLbO2JKvhZFKaUou/dTo5DGmw4ueIs=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 12:01:08 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::d) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:07 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:03 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v3 05/16] drm/amdkfd: CRIU Implement KFD restore ioctl
Date: Wed, 29 Sep 2021 08:00:27 -0400
Message-ID: <20210929120038.6485-6-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f6448b-3061-4b30-732c-08d98340d266
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2836E3A9B838D01F7B4F377295A99@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCkLSnPZOrQm+SiyphCrXSW32lKxXj75+J01A1XnYIeuf4X19kxP7D3Yfyz99ETPzElFgFHx9lc3RJGFdGx2nHK7sjE3B8JpIAmqrG2vv/eeD75UgKGRmTPKSXE3vFNNtHERsPn3OTMQwbeKdpT7qggvTfsZJwYUyQ52qkRrYVYoEvmcVF9MKpbk6awMeRI9f7XpAPdcFcpA+d7M+ZBUZWJKPryCXt0KTiVNDqb/5IOrwOUARasWvlS1cTta4dzSsJKnOv8LxkD8QyGPhhNGrbg8dR6P9JQYiUQyq/CTaXyw28nL3kbfckrc5T54VAX5NYb81C60SJNLv2bkXKLYXLFFAqqoefDAM6AUKodFNE0OXZLNhQkVF4w7iSRfT4hQvjBhLPOUMcZTxwD1du+d31InQk2MwVaiFc+4hdoGgd4b09SSWpmECbLhCfWguiDPELVylXoqgnI2tIasbkRzJOap5h0goE4TM0ULbGIExhOkFh9EHe03YZGALZofAY41PIsA3mABlSTaHzXkHl0QX6lyokwae7sXxEpj+H5uhypM1BYwwUff0mAAcquHeRw1Z6hPZV6Ef7kyaUx/KNAvwsq9Z9Yhe2/hCT5mO0hDXYNYQNDxrf7y+Je4j5EMRnDSF3yuy19+rBqv1we0b0PHrrohzanSFi4TfFIlCqK5dfPCx60ADD/yEjAH+KQdaLt4mm8VjMbT4Tr+au382ztDg6Q7r5lGWXnpKUVprFurOws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(54906003)(47076005)(86362001)(2906002)(1076003)(316002)(82310400003)(6916009)(508600001)(36860700001)(356005)(6666004)(70206006)(426003)(4326008)(83380400001)(336012)(70586007)(2616005)(186003)(5660300002)(8676002)(36756003)(16526019)(7696005)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:07.9188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f6448b-3061-4b30-732c-08d98340d266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 297 ++++++++++++++++++++++-
 1 file changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cc3d8fd1d26f..e5a6a98eae45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2053,10 +2053,305 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
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
+	struct kfd_criu_bo_bucket *bo_buckets;
+	uint8_t *objects, *private_data;
+	bool flush_tlbs = false;
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
+			bool table_freed = false;
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
+				(struct kgd_mem *)mem, peer_pdd->drm_priv, &table_freed);
+			if (ret) {
+				pr_err("Failed to map to gpu %d/%d\n",
+				j, p->n_pdds);
+				goto exit;
+			}
+			if (table_freed)
+				flush_tlbs = true;
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
+	if (flush_tlbs) {
+		/* Flush TLBs after waiting for the page table updates to complete */
+		for (j = 0; j < p->n_pdds; j++) {
+			struct kfd_dev *peer;
+			struct kfd_process_device *pdd = p->pdds[j];
+			struct kfd_process_device *peer_pdd;
+
+			peer = kfd_device_by_id(pdd->dev->id);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+		}
+	}
+
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
-	return 0;
+	struct kfd_ioctl_criu_restorer_args *args = data;
+	int ret;
+
+	if (!args->objects || !args->objects_size)
+		return -EINVAL;
+
+	if (args->objects_index_start != 0) {
+		/* Partial to be implemented later */
+		pr_err("Partial dumps not supported\n");
+		return -EINVAL;
+	}
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

