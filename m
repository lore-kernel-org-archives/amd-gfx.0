Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56CC4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 22:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2D720717
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NO2ygi8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2D720717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C296ED6B;
	Fri, 25 Sep 2020 22:03:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21646ED6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 22:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRPLnuEbzn/zEBM4WL/b9KpCCJxprs6wNm7PRJZztF23ovFK7bNYqGBJqz0S+m3gz3hKu5qxgN/aIGp+Ln3GCH3VNaIOPVeH0QQYGnNdBdX4TW0e/F/8wwm2Fzmc5/bNLkW9uqOLm0TCo9qqscR/5zeI2L10ZUqdXZvNm9y6IE9pNEWqi9vriKF4J98ROhl3KUcHse8+obKzY/hxoWvlTewQ17x266YSoG1F8V+fLnES/I6/3r6JMVIEsjAqdzqgz+/QiBOVamP3Wy8FuUZxY/dFokgxvTmBvMNdAsZFZS9Ep/gmjOkzhoTIFrSZMZb6rXiTr0NtLhn0AMvlB1n/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXK2Efs48YyGSGz96iSWSri8Kdaz7M8QMacAA3LmB0g=;
 b=gqK1Vh8T5royl79yk6YWGJkwc668qPAEnRWgPVyh78Z1j3FeGr1PHsCnbMb9KaYe567A3YypuEP9nRkS1wvSkPQwpFu81VCFL7kET44y4s2QZp7HTRJ5gOvJLePjfL7EPof2qMzIHmdvHLvKaaehAw7R1t3vWKuXRyfEytekQARmI2f7SruuGt6RJUz4VR7E5n4g01snwNPzm3Dsx7OVaSvayXY156miO8z+MJl8OIwj4aJxvfewNOnsBwY4n5HpjJRZeNNnZfEDAHhHSyER3z2uSoUA0QPVhEGJDmUoIkWNIb8kaijqmyYnd0OCLzr+ptXzpEXlsQXa+x1OlJD8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXK2Efs48YyGSGz96iSWSri8Kdaz7M8QMacAA3LmB0g=;
 b=NO2ygi8bVK14FsDmiVVfrYRGMMMOJFJ4gGQlwuzf+o8o7vO3Qnjatmbn/GyN24Ok8N0IqlNw97QlrOP/q+cAfYrJtsOfa0R/pCnBZ0HhE/1DLCpu2bbGaGoOPFlqUsZ8z3DX+bAaGEx3FUJJ5F0cwMVKfgk5pbv6OM0SjseVQIQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 22:03:42 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3412.021; Fri, 25 Sep 2020
 22:03:42 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow users to
 get number of compute units that are in use.
Date: Fri, 25 Sep 2020 17:03:29 -0500
Message-Id: <20200925220329.31071-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 SN4PR0501CA0059.namprd05.prod.outlook.com (2603:10b6:803:41::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.18 via Frontend
 Transport; Fri, 25 Sep 2020 22:03:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6106388a-55d8-45fb-9934-08d8619eddae
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB243163C670388D0A278D84F9E3360@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7w047psHkav73gcjVoQmoka0e004X7JcucBWBzaChBbid7/BVW6vksBvfD3HcBCjdJhP98uunxCPlHZ624GGlO079+286BZFzgqRccc9fD2BcYZ/9Wc0L81QC25chB13ol/SRYAwKSpWYcrhs87+7z0JUu/ir8nOKYt86AotQ4ARYC7Rq6nP/tMNlDCzU7pC4k/j6bKOkOJP/V4DD6hOgvVtMkRhOlMmiyDO4I8wFzaGLjYmralrnYt1/I6lPfJ3o8wsHiuBo8+TzO6OJXUgRPQtOZduQGAhkIocw7PSJ1A6gW0V80mvbqZuFZ5iiJc1cezeFFD3JIPXBd8899yOViTTH42/Af9k9lcnIFB9yYdrctJbJz4j0A9JOyp7JSiF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(66946007)(66476007)(478600001)(66556008)(956004)(5660300002)(83380400001)(1076003)(6916009)(2616005)(8936002)(186003)(16526019)(316002)(52116002)(7696005)(6666004)(6486002)(2906002)(36756003)(86362001)(4326008)(26005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6m1a0CBqOb06JL/2XZKdvPivU+ZoWe5xPrWnMarISB4W6kBFX3o1Ix4nxwFPohIaEpqx8r5KL6d+w5oc0sBxzEeglcD7iUMKjEck0k971IrQWRLHDfJf1vggPhh7nqA1SNWD5MiDgoo+jrVvmvj3QG7ZPT42jLNaXg/UnDQwOS6RFRNdz+0eZ7+SfT++brwS6WhVh+FTooHT0Wcdgh9uxkCfngWQALEokrMbcRewSiUU+Rng2r2pcxfjC9KxhjOdRLufxxTdvUTrEtIHCRxx3ibIsh0NTAiP+W2/0Yc0v/+HMSNndk8pfblE2JQnDE+XEJf9GAALBoa9zJI9LL4tmGjFGL3KnaUkQDAKDX6c1YadaojLKIZHKmz/VR+u3Y6Zbo4B/5fGxvB67DAMw8h4YMo2BRm3gqXs9pgSNsf7MBTmPXGP0FBMznKl8RtzR4UiweoWi2RDsBTeoRgjb7EQCyv0RDME5VAi5gIbnCfUIvxDADoGWQYoL0u+Xe+5nCExqxXdzEURInx1FRvMcKnZdzmed7pjlwTl0BSC94gR3Pxh5wG44776ks41H1GRzLovfx7xDaCH1F9SKUNtiPJzbdoz/5WW2rrL/XCIsve2xCkogKBPwtXGl56LTv9MOsN661vVx/meX4pa7VJBosqFRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6106388a-55d8-45fb-9934-08d8619eddae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 22:03:42.6538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpiZ69NQ0rr01DBeupNMXv6UPh38fdV8GQytjyRsxOEzUMAaVpUaGit+iAgb3/yvE2+MBvPFRMIpX8Q+/yjiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow user to know how many compute units (CU) are in use at any given
moment.

[How]
Surface files in Sysfs that allow user to determine the number of compute
units that are in use for a given process. One Sysfs file is used per
device.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 25 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 68 +++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 56f92cfff591..3df2b9936458 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -705,6 +705,31 @@ struct kfd_process_device {
 
 	struct kobject *kobj_stats;
 	unsigned int doorbell_index;
+
+	/*
+	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
+	 * that is associated with device encoded by "this" struct instance. The
+	 * value reflects CU usage by all of the waves launched by this process
+	 * on this device. A very important property of occupancy parameter is
+	 * that its value is a a snapshot of current use.
+	 *
+	 * Following is to be noted regarding how this parameter is reported:
+	 *
+	 *  The number of waves that a CU can launch is limited by couple of
+	 *  parameters. These are encoded by struct amdgpu_cu_info instance
+	 *  that is part of every device definition. For GFX9 devices this
+	 *  translates to 40 waves (simd_per_cu * max_waves_per_simd) when waves
+	 *  do not use scratch memory and 32 waves (max_scratch_slots_per_cu)
+	 *  when they use. This could change for future devices and therefore
+	 *  this example should be considered as a guide.
+	 *
+	 *  All CU's of a device are available for the process. This may not be true
+	 *  under certain conditions - e.g. CU masking.
+	 *
+	 *  Finally number of CU's that are occupied by a process is affected by both
+	 *  number of CU's a device has along with number of other competing processes
+	 */
+	struct attribute attr_cu_occupancy;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 17d909c86f50..26b716b5eb23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -249,6 +249,52 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	}
 }
 
+/**
+ * @kfd_get_cu_occupancy() - Collect number of waves in-flight on this device
+ * by current process. Translates acquired wave count into number of compute units
+ * that are occupied.
+ *
+ * @atr: Handle of attribute that allows reporting of wave count. The attribute
+ * handle encapsulates GPU device it is associated with, thereby allowing collection
+ * of waves in flight, etc
+ *
+ * @buffer: Handle of user provided buffer updated with wave count
+ *
+ * Return: Number of bytes written to user buffer or an error value
+ */
+static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
+{
+	int cu_cnt;
+	int wave_cnt;
+	int max_waves_per_cu;
+	struct kfd_dev *dev = NULL;
+	struct kfd_process *proc = NULL;
+	struct kfd_process_device *pdd = NULL;
+
+	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
+	dev = pdd->dev;
+	if (dev->kfd2kgd->get_cu_occupancy == NULL)
+		return -EINVAL;
+
+	cu_cnt = 0;
+	proc = pdd->process;
+	if (pdd->qpd.queue_count == 0) {
+		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
+			 dev->id, proc->pasid);
+		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+	}
+
+	/* Collect wave count from device if it supports */
+	wave_cnt = 0;
+	max_waves_per_cu = 0;
+	dev->kfd2kgd->get_cu_occupancy(dev->kgd, proc->pasid, &wave_cnt,
+			&max_waves_per_cu);
+
+	/* Translate wave count to number of compute units */
+	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
+	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+}
+
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
@@ -344,6 +390,7 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 
 	return 0;
 }
+
 static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				     struct attribute *attr, char *buffer)
 {
@@ -359,6 +406,10 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				PAGE_SIZE,
 				"%llu\n",
 				jiffies64_to_msecs(evict_jiffies));
+
+	/* Sysfs handle that gets CU occupancy is per device */
+	} else if (strcmp(attr->name, "cu_occupancy") == 0) {
+		return kfd_get_cu_occupancy(attr, buffer);
 	} else
 		pr_err("Invalid attribute");
 
@@ -466,6 +517,7 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 	 * Create sysfs files for each GPU:
 	 * - proc/<pid>/stats_<gpuid>/
 	 * - proc/<pid>/stats_<gpuid>/evicted_ms
+	 * - proc/<pid>/stats_<gpuid>/cu_occupancy
 	 */
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 		struct kobject *kobj_stats;
@@ -496,6 +548,19 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 		if (ret)
 			pr_warn("Creating eviction stats for gpuid %d failed",
 					(int)pdd->dev->id);
+
+		/* Add sysfs file to report compute unit occupancy */
+		if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL) {
+			pdd->attr_cu_occupancy.name = "cu_occupancy";
+			pdd->attr_cu_occupancy.mode = KFD_SYSFS_FILE_MODE;
+			sysfs_attr_init(&pdd->attr_cu_occupancy);
+			ret = sysfs_create_file(kobj_stats,
+						&pdd->attr_cu_occupancy);
+			if (ret)
+				pr_warn("Creating %s failed for gpuid: %d",
+					pdd->attr_cu_occupancy.name,
+					(int)pdd->dev->id);
+		}
 	}
 err:
 	return ret;
@@ -537,7 +602,6 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 	return ret;
 }
 
-
 void kfd_procfs_del_queue(struct queue *q)
 {
 	if (!q)
@@ -909,6 +973,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 			sysfs_remove_file(p->kobj, &pdd->attr_vram);
 			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
 			sysfs_remove_file(p->kobj, &pdd->attr_evict);
+			if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL)
+				sysfs_remove_file(p->kobj, &pdd->attr_cu_occupancy);
 			kobject_del(pdd->kobj_stats);
 			kobject_put(pdd->kobj_stats);
 			pdd->kobj_stats = NULL;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
