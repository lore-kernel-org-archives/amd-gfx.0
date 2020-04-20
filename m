Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC5C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 01:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE3F20936
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 01:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kPtH+0qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE3F20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC6E6E129;
	Mon, 20 Apr 2020 01:59:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98536E129
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 01:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVhulG0eLITDXA5RQemze6MeKP5Q7EZu9bzTx2Zfyzpocfj1VR1vhc7qlC0fdTVo+62bZByP0BSwJHcs2vShcUCjpAVBSRLjc9WX+fMb6pPjQME7/WjyFg2lnCv5YbqJjHVIrNXTRoKJmaXcrE8bw29pOIenuAisnDUmT6iLPkXfLyduOSo5vATEFhpRCH3TH5jkyy3o+a3wl3JSEXesHqDqPviZbd2hW8Xxoi/aOnV2tbZhleMno+0OYKwS7IXoL1Ef7DzwEPVJLgvfwryzK0jcw9y3wCTGdh+UE9ryhASNVBGZZ8rA3FjAdet3efzZQGzTHoLPRLxhNIXcVRzYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVrnnqhwak+cbH7DRAYxc+8LGhFT+MFokr76SB47KB8=;
 b=Qt80lBgR+yQhbX2ixgB6wbyM/DpEr1e9OQ/WQZt6oVL4M+pz0bHUeA+HwGNIK/E4bBTfS6radRQZtYpcUCRMm7M4y3m4mjLkV3TFkIKdOcsB9/abzopzbYW+IL/5R5f23w+q+Wc2ktvSI3Yaao0tTw9kYbNi8V448C26d9RvaVkuykLUHf3O+oSz+FOBJD/axzpbKC0ZAEm6x9ej1amW62EN9A7yqIuT623eg1Ata3afspx/PJe2bJq79n3MnoUUB36mg4iHQSeAii4tto60e7HgHaorrlhunFi6TkoSLmxEpYd/IKbdwxjK5jae0r5fuM82pS2EyIpT6vII0QT1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVrnnqhwak+cbH7DRAYxc+8LGhFT+MFokr76SB47KB8=;
 b=kPtH+0qnCDc9ozWGFe03Ypnd/tyi6h0UMeq7AGruQK3IYa+qxCkg3gnu/xwqy4A5y0gMIhC/bKAxG88ooY2A/cuI6g4miPnErqWRr0litxxXVHC/9FdU90lxZp/CxHf03Xj8ymZBlPKwLn16AFWviQnNBiFjHK97PVuxcvhoVCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mukul.Joshi@amd.com; 
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 by BN7PR12MB2770.namprd12.prod.outlook.com (2603:10b6:408:32::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 01:59:25 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 01:59:25 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Track GPU memory utilization per process
Date: Sun, 19 Apr 2020 21:58:31 -0400
Message-Id: <20200420015831.13632-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 01:59:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 980d52c2-5ca3-49e5-8562-08d7e4ce734c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2770:|BN7PR12MB2770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB27702C8A716913B6DB8D039CEED40@BN7PR12MB2770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2836.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(5660300002)(52116002)(7696005)(2616005)(36756003)(956004)(81156014)(26005)(186003)(44832011)(4326008)(16526019)(2906002)(316002)(6916009)(6666004)(66946007)(478600001)(8936002)(8676002)(66556008)(66476007)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jvG85+od8kdDjnQHPNw/5H07rEIRcRaybPKEMv11LkPZPTshln9YNnPD0pMDEI9zu2oHq60KfQ4ZyW2o2r7sjCRDnA3U30FTlxHSGEQNejVjC4qK7Fdxh+waDydVy8C4UQy/VWfYm5JPDpKmUxl4LlCNOW/krSFUNwCFWdb70WU6bk0ieA4w4lNBT7W6yS2mx1Yz06US1SmB1UZbHwSoc2WN77agFaIWylagRRH8jCsznkTrZ1TxcaoaSvZpBxqJkcqjZuiVmlROnf/GIVfXCdWCnXc9grKXIbxZsT4/YJzBVQCX8nq6SESKJkhEoRNz57KYw2rviqKafI24kN41tXaQnAQWKgl03Z7sA0HkQcmyddYux7sp04VtkgYbymwvgpuS5lbdDHIKc3mL1JrDIG+CuIME9+GIG3Rj1oL/NXHhX6eedDDhZyXHOkXFxey
X-MS-Exchange-AntiSpam-MessageData: 7LOyomwAV7kcpnzMnHPs/hecOdxWz2i82/lvQ4EZdsjjJKnJbN0P+9GRIDwwOZ1Weg7WZOCPRfg4G4aWJ5ci+/577MMrjkSRgwVfOU7Kqymmg40IKUwoS+z4jx+GpfFo/458i+UdJDeE8rKdu1b9RQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980d52c2-5ca3-49e5-8562-08d7e4ce734c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 01:59:25.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APJQpLi5mWR5sI6VW3ZpoBxi9n3x+2fW4n9zKIUIfj6MezWQfTeMKb/H/BMAw/sV1Q8blOqyg1nt8ISltIQFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2770
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
Cc: mukul.joshi@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Track GPU memory usage on a per process basis and report it through
sysfs.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 51 ++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a12add..91d4f45730ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_object.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1322,6 +1323,9 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_free;
 	}
 
+	/* Update the VRAM usage count */
+	pdd->vram_usage += args->size;
+
 	mutex_unlock(&p->mutex);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
@@ -1351,6 +1355,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	void *mem;
 	struct kfd_dev *dev;
 	int ret;
+	uint64_t size = 0;
 
 	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
 	if (!dev)
@@ -1372,6 +1377,11 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
+	if (((struct kgd_mem *)mem)->bo)
+		size = ((struct kgd_mem *)mem)->bo->tbo.mem.size;
+	else
+		pr_debug("BO is NULL\n");
+
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
 						(struct kgd_mem *)mem);
 
@@ -1382,6 +1392,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
+	pdd->vram_usage -= size;
+
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return ret;
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
index fe0cd49d4ea7..c7f1e5d89bd9 100644
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
