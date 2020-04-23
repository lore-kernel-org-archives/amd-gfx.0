Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95EBC55185
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 03:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7520A2073A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3VAy10EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7520A2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AD489F3C;
	Thu, 23 Apr 2020 03:14:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054C389F38
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 03:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAXY5t7hbj47mpnKqSsWLjqkR4MUhx3eLpeoRAr0pnBXNmfKNhfHL5XbQpYXN7OHwymsPnlQBxEmot8XctusQOXiRK/URY2SW9VANvURSOu+uJg/ZPWfVyKmz/TcxqS3XArN6Cu80+3pMuhTtN/gsd/W+Eau7Id2PQgBREUdt9QL38FxNCGvjNTljFOo/aPkLRTDtWrxt9K9AYhxxgts1RX/0C8BYxRWUruDdxEeC4YZdVeQZwDItiMixaucAz35GperRfp8S9BWyGv79wcyAOCKedHpaZA01EEGUwkvgZj+4Wbbk9pqDTMjCfpnLWSJm3sQgus4OfonmcWFNJeMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtPnrnO4z0C8O3UtY3SJxEoS3NzxaX0eHU0l03LijoE=;
 b=Y/XhXM//C6KtS1NbeXAAcMJlMKv8kSrbcdjet/XCxdw9PTzwV8+WDRO2d0V8lzT8dlGbAF0/RLTJDblyGs46jU/OapxT1fPpq0V8eEH5zBtYPFZy9UTR1oEP3Pa/dQiWZahTbdLE5LFa9HwM0YNfNO4CF6rzPz3ZyYWfazPi8BDJY/eK0IPx/JTuTslL4o6o4ipXXPKeIA2HIXotNLDyJRkCWMiCvM2w42hyl4jez4Lrvnm9KqppX7tL0/WCeaxZsOhBLs9Qbiqwkk7VDz05BFtD/BGU5L6fcInWgIzN0cQXaWfwLBL8VCQcIHPVgVJL0Ec95DkWzgFGZbupu5j4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtPnrnO4z0C8O3UtY3SJxEoS3NzxaX0eHU0l03LijoE=;
 b=3VAy10EMc1pmeXoj3NwpX1YhaDGJDRpSwOls1M/yxEFWs5jIk9XdZB58F+W7I+NSHfeuKlrdWtBuH/y2KRD8WDLeYu//KxA8Ko8c9tyPmwO58cG7lxQ7EtioruVJGFnVRvUKMgAOvgSOy4RSh8b6GgGhF6WUjz/RKaKdJDMSy0E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mukul.Joshi@amd.com; 
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 03:14:28 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 03:14:27 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Track GPU memory utilization per process
Date: Wed, 22 Apr 2020 23:13:59 -0400
Message-Id: <20200423031359.19673-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::29) To BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 03:14:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38f734b0-87b3-41d4-2976-08d7e7346e45
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:|BN7PR12MB2708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2708EB58BCE6128F6FD8B103EED30@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2836.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(186003)(5660300002)(8936002)(956004)(81156014)(26005)(8676002)(44832011)(316002)(7696005)(52116002)(66476007)(66556008)(66946007)(16526019)(86362001)(6916009)(6486002)(36756003)(1076003)(478600001)(6666004)(2906002)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdZ2ORbrgNzU5lXJ9CfvkeB9oHolPEdfZbRA7jV+FGopNquECDP0mJBJFyTIKyoVae5BZMBSbo0TIaz+q8pY7dCnYX9RFY4KWG/Z8hHhlT/tgvX3TQx+D5/GP6xPOMYYLFx4jnOK1ScGWspe44F41EPbAZiytYtStizqTPQRrfQMXWoX28nkpz+rUSlh5gDshm0bWwLERc6Wt2H0zQsCiORzVZqHd5yegpVNwudm/z0AbknQisbboXkx7RL41rwUe2UuP0E4XOE8FuwCWSpr0kwcqngaYcLwhgTEVGkxkqdnKUiiu9PLci4HoH4HmUF6+Uq6xrSOOSvoC2bV0Ra1HF2i1WOxGUGps8rKb0z48dR/xvX2eZbsMElh+3AOi7Umq4JUhjLTIZ46/wbJsc2VAQ78O1SPae0v6A3OwRpJ+JR2PdZF01Vevd2gi4WtPw+8
X-MS-Exchange-AntiSpam-MessageData: 8z3xAF94NLTRBor03cHBu6JyH1srgxPozLBW5c0Xid2Tr9trPxUOhC3GUv2pf4gdO8+eDGL/nm8VdJtGr9VlrhI9j5u+X4X2Pd4+b+UigzDNGg55FBLKuUth1kUwDwtSsOs9maQ7Z/VDmU7FKN+zoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f734b0-87b3-41d4-2976-08d7e7346e45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 03:14:27.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkosTu1X8KGJ9jIG0/pn2yuRhObJ68cLlXSiejfVjes9ONhInWxwP3/BqEtjVp11IErUe/6s+K90NYkBPb0v2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Track GPU VRAM usage on a per process basis and report it through
sysfs.

v2: 
   - Handle AMDGPU BO-specific details in 
     amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
   - Return size of VRAM BO being freed from 
     amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
   - Do not consider imported memory for VRAM
     usage calculations.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 17 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 57 ++++++++++++++++---
 5 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d065c50582eb..a501026e829c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -65,6 +65,7 @@ struct kgd_mem {
 	struct amdgpu_sync sync;
 
 	bool aql_queue;
+	bool is_imported;
 };
 
 /* KFD Memory Eviction */
@@ -219,7 +220,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		void *vm, struct kgd_mem **mem,
 		uint64_t *offset, uint32_t flags);
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem);
+		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size);
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *vm);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0768b7eb7683..fe6615a06cd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1277,7 +1277,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem)
+		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	unsigned long bo_size = mem->bo->tbo.mem.size;
@@ -1340,6 +1340,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		kfree(mem->bo->tbo.sg);
 	}
 
+	/* Update the size of the BO being freed if it was allocated from
+	 * VRAM
+	 */
+	if (size && (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM))
+		*size = bo_size;
+
 	/* Free the BO*/
 	amdgpu_bo_unref(&mem->bo);
 	mutex_destroy(&mem->lock);
@@ -1694,6 +1700,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	(*mem)->process_info = avm->process_info;
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 	amdgpu_sync_create(&(*mem)->sync);
+	(*mem)->is_imported = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a12add..aac2cdb65eb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1322,6 +1322,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_free;
 	}
 
+	/* Update the VRAM usage count */
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+		pdd->vram_usage += args->size;
+
 	mutex_unlock(&p->mutex);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
@@ -1337,7 +1341,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return err;
@@ -1351,6 +1355,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	void *mem;
 	struct kfd_dev *dev;
 	int ret;
+	uint64_t size = 0;
+	bool is_imported = 0;
 
 	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
 	if (!dev)
@@ -1372,8 +1378,10 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
+	is_imported = ((struct kgd_mem *)mem)->is_imported;
+
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
-						(struct kgd_mem *)mem);
+						(struct kgd_mem *)mem, &size);
 
 	/* If freeing the buffer failed, leave the handle in place for
 	 * clean-up during process tear-down.
@@ -1382,6 +1390,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
+	if (!is_imported)
+		pdd->vram_usage -= size;
+
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return ret;
@@ -1726,7 +1737,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b311c7..e7918fc3cee5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -616,6 +616,8 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
+#define MAX_VRAM_FILENAME_LEN 11
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/*
@@ -658,6 +660,11 @@ struct kfd_process_device {
 
 	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
 	enum kfd_pdd_bound bound;
+
+	/* VRAM usage */
+	uint64_t vram_usage;
+	struct attribute attr_vram;
+	char vram_filename[MAX_VRAM_FILENAME_LEN];
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fe0cd49d4ea7..600759949802 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -79,18 +79,22 @@ static struct kfd_procfs_tree procfs;
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
-	int val = 0;
-
 	if (strcmp(attr->name, "pasid") == 0) {
 		struct kfd_process *p = container_of(attr, struct kfd_process,
 						     attr_pasid);
-		val = p->pasid;
+
+		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
+	} else if (strncmp(attr->name, "vram_", 5) == 0) {
+		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
+							      attr_vram);
+		if (pdd)
+			return snprintf(buffer, PAGE_SIZE, "%llu\n", pdd->vram_usage);
 	} else {
 		pr_err("Invalid attribute");
 		return -EINVAL;
 	}
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", val);
+	return 0;
 }
 
 static void kfd_procfs_kobj_release(struct kobject *kobj)
@@ -206,6 +210,34 @@ int kfd_procfs_add_queue(struct queue *q)
 	return 0;
 }
 
+int kfd_procfs_add_vram_usage(struct kfd_process *p)
+{
+	int ret = 0;
+	struct kfd_process_device *pdd;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!p->kobj)
+		return -EFAULT;
+
+	/* Create proc/<pid>/vram_<gpuid> file for each GPU */
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
+		snprintf(pdd->vram_filename, MAX_VRAM_FILENAME_LEN, "vram_%u",
+			 pdd->dev->id);
+		pdd->attr_vram.name = pdd->vram_filename;
+		pdd->attr_vram.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&pdd->attr_vram);
+		ret = sysfs_create_file(p->kobj, &pdd->attr_vram);
+		if (ret)
+			pr_warn("Creating vram usage for gpu id %d failed",
+				(int)pdd->dev->id);
+	}
+
+	return ret;
+}
+
+
 void kfd_procfs_del_queue(struct queue *q)
 {
 	if (!q)
@@ -248,7 +280,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_dev *dev = pdd->dev;
 
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->vm);
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, NULL);
 }
 
 /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
@@ -312,7 +344,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	return err;
 
 err_map_mem:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, NULL);
 err_alloc_mem:
 	*kptr = NULL;
 	return err;
@@ -411,6 +443,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
 							process->kobj);
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
+
+		ret = kfd_procfs_add_vram_usage(process);
+		if (ret)
+			pr_warn("Creating vram usage file for pid %d failed",
+				(int)process->lead_thread->pid);
 	}
 out:
 	if (!IS_ERR(process))
@@ -488,7 +525,7 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 				peer_pdd->dev->kgd, mem, peer_pdd->vm);
 		}
 
-		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem);
+		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem, NULL);
 		kfd_process_device_remove_obj_handle(pdd, id);
 	}
 }
@@ -551,6 +588,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+	struct kfd_process_device *pdd;
 
 	/* Remove the procfs files */
 	if (p->kobj) {
@@ -558,6 +596,10 @@ static void kfd_process_wq_release(struct work_struct *work)
 		kobject_del(p->kobj_queues);
 		kobject_put(p->kobj_queues);
 		p->kobj_queues = NULL;
+
+		list_for_each_entry(pdd, &p->per_device_data, per_device_list)
+			sysfs_remove_file(p->kobj, &pdd->attr_vram);
+
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
 		p->kobj = NULL;
@@ -862,6 +904,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
+	pdd->vram_usage = 0;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
