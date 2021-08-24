Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D85FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24916138B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B24916138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462C76E0CB;
	Tue, 24 Aug 2021 19:23:31 +0000 (UTC)
X-Greylist: delayed 946 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 19:23:28 UTC
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown
 [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C3C6E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIJAV/ZOZiwNhHgj9S2EQ8tWim1VE2R5x+ZtBdPqae5w2qssak0fa7pLoVRtAMS2ZhmiWmplBQaJTAtFI+jJweqJ0Ne9kHvbKLgr0RmqaUq3BQz/yD3yePbwAvz6lNpSN2LAB631lIcdHEoM7FlwYrwWnSAXdMQe4fBEmgKOvdLehYHu/dBzFM9Ym5M3p0SMlAarOn8lsBpcurkTaWLc7ssbjTJ6lWjg/LKxLeJitqxKcdRwJnL3zkrL2qfXzDzf2Mab1UFPu534zK1ts11sX5Sps2pSI41kYrzzzCqB41h2VM0FP2+qb/oxMN/SQryv/7LtO52AaDkCMSjsSZBKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP7FB6wrg2ggNE9o8iblRLVo50Z7Xj8zhVxW4TrNBcs=;
 b=WjalOm4BAoxfrYLu2GITrXNXMqw1SDrb7Ldmob8SI2z06aSyJGM42LQ/uxrg2vJoNZz6ce3B2k1J6LsnbCOr3nHYA5JeKAYzlv6k2yG1zuOYEDRMRfonrX2TJJreymp+KamTOwBbcj5+V9qPASIBaxeDfeGxE3OpevhmQHYrCZ5cAQMG51D2u+k58gcwdPphOt+c8KUpD6Ihh50aswAg3VNUEyTkIlaKO/qKMc00eVlAmeqR7VIphj3sC9sJhdvU+DuQY8C8Bne52+OsJHTgluun7dHCSWAdpWut/wJiDNRKSH1sQPtG9cgMbJ98sSZRHhMVNT1Fr9U2T2+Pz08R3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP7FB6wrg2ggNE9o8iblRLVo50Z7Xj8zhVxW4TrNBcs=;
 b=eMpf/g3yNZjCc/jJjHrVAEmM2kt5e21FU4OOvcyu97f+VpcAp1oJDOFOpg8MEjKfEn8oPDF0wpxFUpa1v5r8pIERrUfO8GtMTd5BjdI2Yfdx31emoQHhzgq1gco6ps6VkCt+wIvI3Xk8YsSuMu8EhcO5SL0nVsX7X3+BppulNQc=
Received: from DM5PR15CA0041.namprd15.prod.outlook.com (2603:10b6:4:4b::27) by
 BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 19:07:38 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::b8) by DM5PR15CA0041.outlook.office365.com
 (2603:10b6:4:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:37 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:32 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 06/18] drm/amdkfd: CRIU Implement KFD restore ioctl
Date: Tue, 24 Aug 2021 15:06:27 -0400
Message-ID: <20210824190639.6288-7-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea81a8a0-2ac9-45e4-e0ef-08d967327010
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3924EE7220A942FDD00BAB2295C59@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwNnQPGXYil3hEEnlrgg4IjhH+5YMsW48wTwpC8TR7EOBVy0vtUhjAl27goD8j+BhEEciqwewoEdTJ9mkD0MT3HBLumD6+HE7IAU16FgAziH0n6rW+t4ZN4HK5T3WXCQfQ4eTxhGFOx/CEwBa3U666xodsNxOplohdSGTRnIgxTZtCElC2j8PNDQCRo+YKxK6zWFzm9+QHjgFLRI8RMB4djGlE2Lzs5SCejahSVJl+8wg4ud2kHyZyTi+U46Q0rHHthQwqsRXoGcezR5XetUgcZ/+SdaEsK6qUmBclI3qvbeDHG/IvvXydC/QHFuQsH+87dDJ74hHzwv3grirP3EjVm2oj5xir35aP3OpMqQxRdI2wrscFB6CvDlezMS6hC2CLCCAkbwNgchvhNhP/h9W4UilYv+eZBrZ7MSTKS3FPlvJphy7JIP76TzHt5aX3sE2ZGyxAqZwsTFzQUgk+t5/hOZiYgiO50WcuRD3xhWeh6Ce77qpvrJTh+TAEsUJVEptoMEo5K7bQOucf57p8yM5NGGdDAZrElfRjmm6C0+GRYMrs1LarRKctRCwmmv2grlV2brAOlmOcwY6MOILXKC3pplnn4s8lKvdVjHMJGetsxGz5+Gtl+jSKp3rJyNCK/eZk7RATX/wMlXtHGKFmfkRaYy03Pfj54NvGH76UoIjfCClJzL1z9CZQ/eG9hrYkWaaEEwLDSsqMaWGZMlebMtssldzj2x+nACASY1CgNLHvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(36860700001)(82310400003)(7696005)(70206006)(70586007)(4326008)(16526019)(186003)(426003)(478600001)(86362001)(336012)(5660300002)(316002)(8676002)(83380400001)(54906003)(8936002)(1076003)(47076005)(2906002)(82740400003)(356005)(6916009)(26005)(2616005)(81166007)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:37.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea81a8a0-2ac9-45e4-e0ef-08d967327010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 290 ++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40efc80f3604..59b5c4131f48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2016,12 +2016,298 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
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

