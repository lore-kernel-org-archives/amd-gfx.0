Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C62C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF94610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEF94610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FBD6E986;
	Thu, 19 Aug 2021 13:38:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BF06E978
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anSl8sRNs64buaQ9tuLeBGhPhjjlNy/LMxpPw830+YoiRHRiu32D9prfE5q+YVzOJOLmZF5JKzxKDKEJiaitawPDVSbwBgyOD/svbDdt5WYCMrPKxSMMm4LVuuqTlTs3C+bKrRSKgxlz+Ml103BDXh0164xuP0ByNta///r765ePzT6nJNoYFibFd5YNNEjE9INR77w+rqVL+DNdH6W1r/zlWwktUbjrWbfWT1lwTcZ9rHUMb85yLqZYnqwnZ4GyFQx/rwAEecvNX9dyoQC9V9FjG9TeRDh6xYaVolwsuLJAiBuRSs5dzKIyYC/jMg8oPKOz2XndavyxwXMfqvggQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGakVmddpVrZ3mgjVx11P2mHx89lQuQ2U4LLL/WJK8=;
 b=Kxrw6jcaswtt+n3Foa/WTF/XGfKJnIVywg7rxIYRABoRx1f/6cMzhjM2pHayT5Mx6xPsdM1BOaCGWdcE8HtWINJyBA0Ly30rZLDH/Ju/4lfsIN+fOux2Wo5629fyVkkLR+JFwq7DtiRdu9N8KIafB5/b3tQihptDsIEYKOrfHkV3izqgp9JXYcw1AQhjsXtXPGCbiex4B+aXfLqJ5/MjuGCfzaa9uAZzlG/vKrJwqdPYOON75KJKZmprVjFZ1hya2ASYBxF+kdDYYLx94XrczzGyLxZZbhnlRK6FXASa94++riE7RbdzSeQyrm7RLwM5L2L9cWrRp/mhzXWfiUmQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGakVmddpVrZ3mgjVx11P2mHx89lQuQ2U4LLL/WJK8=;
 b=3jsvv/pyamKoIvQlLkAJWiOXHZfBezDt9NtOFIFJ735BuXRyEL/TdZ0X946By4iAF7dysCuH5mC4P3baWHiDivakWjqaQwhPGUkGgANDIVp0N6c+/3/pyP4sfogzaI2Kf2qyC/QU8e8do62pKF5Ceb2iajuI9M5w5MEyUXTQorU=
Received: from CO2PR04CA0173.namprd04.prod.outlook.com (2603:10b6:104:4::27)
 by DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Thu, 19 Aug
 2021 13:38:00 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::92) by CO2PR04CA0173.outlook.office365.com
 (2603:10b6:104:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:38:00 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:56 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 18/18] drm/amdkfd: CRIU export kfd bos as prime dmabuf objects
Date: Thu, 19 Aug 2021 09:37:13 -0400
Message-ID: <20210819133713.4168-19-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec281f49-5c89-400d-8497-08d963168ffe
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24706EAE1C085AFE5398E4B995C09@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPRf9rVVb2ICE/ZzMsSoAjdSx1gP7UyU5k1940xKqTSH50lhlvhq0iusx/odV0PNWvZHrHL8c4i0vmqy/J/JdV6SepZogcJXXT0dLK+LhOEH69aIxatnkEfYrQfSzutcMsNYOE3ld08vuP5rgOhM9JUAuMWUBxd08G4jLnlKN1fSbmAH2kK+x/UQTxj6gZiEhrEAW3QKJ9vfQ8RVbcuRLg6FRrZ6r2xi6fF5cBkzFHFZkf7NlUX/Jxa+ZJNQ7qfkR+krjFgP6PkiJCBggoseTSwJ3Y9iZjM+3tboNIH54Q60R7vNYAzsX9MXysAm7Ks8b3MGSjCJfJFCsgTEJZyijD0A62mFdlArsxp8IM6a1zpZFFcvaY5xq3Spt6xDMVCYlDijmVUQdcApHzazFiJYlbVAdlspzewkjyq1rtNRyg/1J8C0c0iP1acjUai9gcQ/1Tk2bMfQ789hRcAkgfRwhjc35dSZPJwbU7EOtIHcZwsntrc4ycHOPwsa4mqtYr013TfrR0CxbIAieftHM4Ol4HTOCQLb9/QAn21RRNhSIk7HPKOhylQWzwmMaSY/rqduFNxqmP+c8dFd17330s9N9/Fv6JUKsavdsfzbb7C+V5H6939qUspIfK88SOTrOUM4kh9Vel4JmyGURX8GTxP3j1v07pobfyNoK/0DKeoRmxOkedQVqE0Q80hAWn/qS6lt76SRL89+s14axTZ9lLR3sugIH7mvVhSU0owKgcBQP75Jm1O2n/69oW+VsTzGLZlUpSvphpo/5vZVetbhqGD/fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(16526019)(82740400003)(356005)(426003)(26005)(6666004)(1076003)(83380400001)(5660300002)(186003)(8676002)(2906002)(6916009)(81166007)(2616005)(7696005)(8936002)(336012)(316002)(34020700004)(70586007)(36860700001)(478600001)(86362001)(54906003)(4326008)(47076005)(82310400003)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:38:00.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec281f49-5c89-400d-8497-08d963168ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
index 90e4d4ce4398..ead4cb37377b 100644
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
@@ -1900,6 +1902,33 @@ uint64_t get_process_num_bos(struct kfd_process *p)
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
@@ -1969,6 +1998,14 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
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
@@ -1998,6 +2035,11 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
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
@@ -2516,6 +2558,7 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
 		struct kfd_process_device *pdd;
+		struct kgd_mem *kgd_mem;
 		void *mem;
 		u64 offset;
 		int idr_handle;
@@ -2663,6 +2706,16 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
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
@@ -2687,6 +2740,10 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
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

