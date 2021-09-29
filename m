Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0627DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8E661452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD8E661452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BF96EA58;
	Wed, 29 Sep 2021 12:01:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E566EA53
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBmEtLiD8UyKAGQvA0iY9nguPweY0VzRt7kYOcsqcC9VBKbIhdcTz7/P7ZfFvBhANtn3JHSOV6ZqMKeM1mul6j8lxEIMk0ha9LpwSD2oUxXxRDlYBPwCfhivZjZWdJZWqRjzdFWdkEEedKGgvDa5zad9/dzzKRysJFRF/drw/a9mhGwiu8RUgk3TjdUtI2cizPwngrz1sKDqGuT1xT6QvSen3bTBBp110Mq+BzwrRURMSMNko1AZ2VOGvNHMOe2XBmNtgGH+cI+pWQwGvsgrnhwgDg3cpySuHSZ2Y0IMyBA7PTHVyR5Y8RdeIOokZTtuWWGpFFH7PbBHSD9TUtwA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nzEza5H9mA7A43KUZHnh9zcioJ2sZQq5jeuAaJvdlss=;
 b=irgrkOuwZ/kPks4E8LRa7ubO/YJxka7ya2UtV5oh9C0loTHlb6zHsh48STRQTOxwzbhGbxBMYG5tm3po4GAojUHjBqHJ4DxKdk8P0srHQU7wfZ14a/7MwobPHZK2fXxpFAdYAxebmtqLclaZAIgMA958M1iCC7a7yHV9MrQhHOgFcuRjwh6GZLR8nzpQPnshShwmPDUzLWIsVlm5J7tXX6mfBaFxWIPniU0yzrmelI3uigVOJwBAQPFbMl120gbeUQaVM5SMhkWu+nJoCpyIUq/hczbyWxEgnT7vUGPmmVTVwjzgfJ7/sg9245a4D1EWNc4IU8X3pwyQPjHHacCsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzEza5H9mA7A43KUZHnh9zcioJ2sZQq5jeuAaJvdlss=;
 b=UhARHghSxOdCkFIcikDGTFt2WyWYHVm+moPq7fcj9eLqFW5QwUXWgkXe2ZurhxbOl7365XLpxiWoSipSv4CuxxWFiwCZ2WvCDR4yaMHVBDU6tUodfD4UB2Kckt950SnVKCXg0iURaGGy+ndezMWR19JeSmgh14JgTBaiCKeLpW8=
Received: from MWHPR12CA0062.namprd12.prod.outlook.com (2603:10b6:300:103::24)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 12:01:15 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::1f) by MWHPR12CA0062.outlook.office365.com
 (2603:10b6:300:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:14 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:08 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v3 16/16] drm/amdkfd: CRIU export kfd bos as prime dmabuf
 objects
Date: Wed, 29 Sep 2021 08:00:38 -0400
Message-ID: <20210929120038.6485-17-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f908dfff-50b4-4cd0-5ee8-08d98340d665
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5172A6A222851DEDA4ADD78C95A99@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2U1AzA8flE2tNeipkLDpWcRz7AIHY5h5nF9v/la1n1+aWtbADVP1qRxwGFRaNPzKWKRpbauFv9Pqjs97V97GCCf8frczFL0nx2yPhzwmhHze0Ghm0tSBl5RQjD16Go3tOx1rhm6JorjCNcDrCF6rAeZF9QES5OWnNiLEjA+Z7x48gLPqzBqABa1GnXTjeE1MSozZMbrQGOfQOhuv12M0OP/nx6LcCr1pFj+b/bIqZDhRwk9YPCZjLnhCA48Bh6ZIre+VwY3P/BncrCOsqiDJEIuBO4xuCX/yfwidosJe/acnLeprg/XRj26LrerdO+LmH+xtlCX/+KpZnXjGjchcuUydmzMch1TNVF7SQNYYfNCBcymEwCm+pQNOx/FSZasdpiusYfRejIkQroJjQB6SjzZ+bepoPt9heNT63il2XeqIb82rgsU/EzAKx4kz3EbX6+/2HfG5cet5kfPKMRt9uDmw785uenaRQz2O+k0XEGggk+W78TTVVRr8AgWkb5625KvZS23BtDUrcvR2bCw+184dGldwecAUHHP2hduW8qHC8S2DZStx+GmiiEq1euSNEMg9iAZ9kLo5UmNvv0Y5bvBKyGLPb0YrAl7R0Uygz0EI6AonMzEUZFXj0asOWnd/CGC40Q/Zi2+WBBzlm8sxGq12YgYUr2welXewJMf3zIOKfeggd4GVq2YO+BXP/61GzBLcrUwbuUVdNTM1J13ylHFpoybXdvw4jzSDPsQBP/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(2906002)(6666004)(36756003)(82310400003)(4326008)(70586007)(70206006)(83380400001)(81166007)(336012)(426003)(47076005)(356005)(2616005)(186003)(1076003)(16526019)(36860700001)(26005)(5660300002)(54906003)(508600001)(8676002)(6916009)(316002)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:14.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f908dfff-50b4-4cd0-5ee8-08d98340d665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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

KFD buffer objects do not associate a GEM handle with them so cannot
directly be used with libdrm to initiate a system dma (sDMA) operation
to speedup the checkpoint and restore operation so export them as dmabuf
objects and use with libdrm helper (amdgpu_bo_import) to further process
the sdma command submissions.

With sDMA, we see huge improvement in checkpoint and restore operations
compared to the generic pci based access via host data path.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 10f08aa26fac..75fbdd84d2ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -35,6 +35,7 @@
 #include <linux/mman.h>
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
+#include <linux/fdtable.h>
 #include <asm/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
@@ -43,6 +44,7 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "amdgpu_object.h"
+#include "amdgpu_dma_buf.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1931,6 +1933,33 @@ uint64_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
+static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
+				      u32 *shared_fd)
+{
+	struct dma_buf *dmabuf;
+	int ret;
+
+	dmabuf = amdgpu_gem_prime_export(gobj, flags);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		pr_err("dmabuf export failed for the BO\n");
+		return ret;
+	}
+
+	ret = dma_buf_fd(dmabuf, flags);
+	if (ret < 0) {
+		pr_err("dmabuf create fd failed, ret:%d\n", ret);
+		goto out_free_dmabuf;
+	}
+
+	*shared_fd = ret;
+	return 0;
+
+out_free_dmabuf:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
 {
 	struct kfd_criu_bo_bucket *bo_buckets;
@@ -2000,6 +2029,14 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
 					goto exit;
 				}
 			}
+			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+				ret = criu_get_prime_handle(&dumper_bo->tbo.base,
+						bo_bucket->alloc_flags &
+						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
+						&bo_bucket->dmabuf_fd);
+				if (ret)
+					goto exit;
+			}
 			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
 				bo_bucket->offset = KFD_MMAP_TYPE_DOORBELL |
 					KFD_MMAP_GPU_ID(pdd->dev->id);
@@ -2029,6 +2066,11 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
 	}
 
 exit:
+	while (ret && bo_index--) {
+		if (bo_buckets[bo_index].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+			close_fd(bo_buckets[bo_index].dmabuf_fd);
+	}
+
 	kvfree(bo_buckets);
 	return ret;
 }
@@ -2276,6 +2318,7 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
 		struct kfd_process_device *pdd;
+		struct kgd_mem *kgd_mem;
 		void *mem;
 		u64 offset;
 		int idr_handle;
@@ -2427,6 +2470,15 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		}
 
 		pr_debug("map memory was successful for the BO\n");
+		/* create the dmabuf object and export the bo */
+		kgd_mem = (struct kgd_mem *)mem;
+		if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+			ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base,
+						    DRM_RDWR,
+						    &bo_bucket->dmabuf_fd);
+			if (ret)
+				goto exit;
+		}
 	} /* done */
 
 	if (flush_tlbs) {
@@ -2454,6 +2506,10 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		ret = -EFAULT;
 
 exit:
+	while (ret && i--) {
+		if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+			close_fd(bo_buckets[i].dmabuf_fd);
+	}
 	kvfree(objects);
 	return ret;
 }
-- 
2.17.1

