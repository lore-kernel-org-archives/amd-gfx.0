Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D115C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CB461220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0CB461220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4C56E0D0;
	Tue, 24 Aug 2021 19:40:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFDC6E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrgk6gUwKpv30GjMLRn7xdQEJwzASHd4g0I0ke7oOYaQ9wHAj7VEzOK2e7JLe6ZDWWmCDPBlEacmKHkzPfxsYti++sftexDH021RvgaRAIvss4XilQGpQC02o7znbIdKLjCJb8uFnweU3WBbIlGQV+k06it7vFArYJEZ4nOJyejIDP0NJm9o7om50HgkBUZgo+pPFPbM88/lENYcEULO6RoiIAZsREQIFgL7tBwbyCCqsBkUuHVGmX/MkuV8bTioIo05cKEslfu8P7IyCnj/7rmJCFSfCeYezsbi9qXWojExoFceCTFoNN+AD0VjuoOBeS7N4NvgmVXUaMNJ3iWKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeAmgjl6gqfnKqzotAiLOQ7dHQJ6lI3ezes28cgG+OI=;
 b=OZT2zT3uFiUvxQVcl2K6H8ebHGejBs8b/pU9B2dcjRSIMlDOYfKQB2QDTbLpBHWTPeauBImeoGhArMHYcKugcRQdyOPi1YQ9AMzuAZYcugZqBoqNxA2daGibyPv8StBMEGFYDVnRNxHlPQpS3uMwhyv6h0pb5eoWIOrwN8GsdQwMIH9lr9GnnNJE9w4BthqUutSDHWQGSKZD+DWlD+7ZUUHG1hSSg5Mlcga4atSb3AdrwTH7oxxQ3nKnqCyVqYrCed1oK4d83gYBHlROvmwHfNfD0uHmaThDdEfH1sHnngV2nIhEMcCkoPVDREoCNqwDtsYbezdDKwz9BnWc/x831Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeAmgjl6gqfnKqzotAiLOQ7dHQJ6lI3ezes28cgG+OI=;
 b=hXFWUhtbZO2ZgbGJb6jyEpgYnRQy1MWz+s3pl5Oc5lan3GmZqU405eIqqlNkzVwZf+AFOnO2RrhyGQIHDI1Mp6eRzQKgCgtTe2SGItXR4iXq3UBtC7DV7L8elsRj8JfdDhmnL/0JyBJIERgcDgY3u0wPNcy3DffGH8uAntGj7rQ=
Received: from DM5PR15CA0029.namprd15.prod.outlook.com (2603:10b6:4:4b::15) by
 BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 19:07:42 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::d9) by DM5PR15CA0029.outlook.office365.com
 (2603:10b6:4:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:42 +0000
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
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:42 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:38 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 18/18] drm/amdkfd: CRIU export kfd bos as prime dmabuf
 objects
Date: Tue, 24 Aug 2021 15:06:39 -0400
Message-ID: <20210824190639.6288-19-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82bc2ef2-a2d5-4b12-7a21-08d9673272ff
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5207CC8F61A1837DAFEDF51F95C59@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJJ7I8FRIAkp4ilYtyuDK08mQcZ2e7i00hmrCagKnM5EBLrkzEd6xSvb9BkUNM9TmpVxt5pAMZfZYsum+pxV5mz+QD/sOX/isUvtqJhGtoLdO/h/CSsd42x5AGbvnqODe96TZ309JgkO1irqP/FGTxcVOd1dCjmC1pIwLolEQJtGJ5COMgT7d6vs4qSCfEs8jFlMnH2ZPH1llGnFtAZ2fWtKAMD3FojDVL4RG7dv8t6NWYaNGlU+a+K0Rcov89eVQ2DGzId6O8R6pO04k9jyyNujET8+QG9BsAtIAXM80YNtZEfID9cGIl2D5q5BU3LzeoMnkmVXhKlDxPUUhgTTgMiCaaOTQ48vXASxjr1+H12tws7xj6h4M2JJGAS+JnIAYmxhBistmPHHJWKlhnYh5IODpq/6fSwncQLX4GxezXPhHE3e0rkaLg9yH6aJU/1Jli6Bt1zFDYxHDUfeduDy3QMz6Y7EKstqa8ZKmgEpDcwucJEOcKGI8VwTIqLIzHzTdOObWsop0e9zjke6607VLZ/2Qe0avzzmZISEX90IjSi1MtO2UFrmxW61YMXkxRe+JIqPOd/BWkZloiWCzoSNzGD0eaxIXntjyLF4xXaGb76POTK/CsjVgXKCsRjXE9dqMtMns8G3rXUvnI9OeqMjeJtlRACuo2fChrCzzOmALqNG3dulkErpJAR+7im+2zsnANy1E9xO/7KznorTZ+vohUvm66O8IHPE57s/ezJng0k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(7696005)(83380400001)(478600001)(54906003)(26005)(1076003)(36860700001)(4326008)(316002)(86362001)(6916009)(70206006)(70586007)(426003)(36756003)(81166007)(8936002)(356005)(8676002)(82740400003)(2906002)(47076005)(16526019)(2616005)(336012)(5660300002)(186003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:42.4047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bc2ef2-a2d5-4b12-7a21-08d9673272ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2d79bb6082dc..1a1039cc7f55 100644
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
@@ -1899,6 +1901,33 @@ uint64_t get_process_num_bos(struct kfd_process *p)
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
@@ -1968,6 +1997,14 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
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
@@ -1997,6 +2034,11 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
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
@@ -2243,6 +2285,7 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
 		struct kfd_process_device *pdd;
+		struct kgd_mem *kgd_mem;
 		void *mem;
 		u64 offset;
 		int idr_handle;
@@ -2390,6 +2433,16 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
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
+
 	} /* done */
 
 	/* Flush TLBs after waiting for the page table updates to complete */
@@ -2414,6 +2467,10 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
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

