Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040CBC47423
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F645208FE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h2QC9sH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F645208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9EC6E7D9;
	Tue, 29 Sep 2020 17:26:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8514D6E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 17:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4eV+KyFZQviXn++O6Rgb5VexBOrfESjQi+U/JyTsBhXgXxea3rOeOVzLEjVOHJ8DREUpKy+Nly2c9IHdNZWbHsQFNP/ay6RX+Gjok/RZWMDtB6VCdyWQ0zyetDmo6agNMMXkz6baCJqNb1DCGw1QmGbE+T1/UIoqCBH/6JAOz/eUfb5kDxqcQXdAvClhgQo6ANM2WpwzswM9HykwqvZWt/NhvJLU2S3nvQ4oT3KPIZHcHIYJzUSrcD0bERvjOlYmv1e1bypNYU28nUYls312BHzfRxEIsZ5C1mcFrkEAqIQpnOTnjUzmc05mHHsV4W/2YmOfweci36OjBWyXie/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=179X3feUOkpJbO3JjDNuHh1HvC9Oe+1Y9FV8e8L4rRc=;
 b=Kw7hxY+m/zSWJrTbYJavD5tGwJ9R5BwwWMqcOeFnEwTArok+nEAXyi7ykb6O1ypAKdbppBgNvXCG2AZzKclfcat7hA1BY3rAjwTnzzdNxgYvko/qb4VG3Cn2c7HmWYrirMReaoLt+oHDCp4mTyc5X0pOVdCHVe0f9EcSQ7sZk22pAVnoHMVzDNP9PmfhlaDcVoEvx2QEgc56NVU3N0Qd8e5oWPworHT7bktWw2nPiSi+2uXwnvajZ1VqvAZlZIGju7t3s2U9NlhpfyoDVndRMfrC+srYQQzJumiAse3zhqh3htMPtuDhctxEw/aI1dtbUIdpfYUH3AHABCg82FOLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=179X3feUOkpJbO3JjDNuHh1HvC9Oe+1Y9FV8e8L4rRc=;
 b=h2QC9sH6/+6gnEenvjM3NmIcSMTZQ2aJf2CD6EDsGe+z1T4+PXKT4u4Wjmp9eny01M+h8kqRK/DMgPNnjrRCW5HBAhGeiXKOEv1GdfRrgJI0mZVtptapyjwe9pRUugsCyCFBrLsi03Viz82ClsXbfk9nejYzHAmJgqjfCVO18lE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 17:26:48 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:26:48 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/amdkfd: Surface files in Sysfs to allow users to
 get number of compute units that are in use.
Date: Tue, 29 Sep 2020 12:26:35 -0500
Message-Id: <20200929172635.25037-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 17:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a4eb165-697e-4a81-6e8d-08d8649cd8bf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23821CEC018A4C7444663C54E3320@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qj3uCP1c3k4N1pF3BwOuyFVMwpqUPiCxvhHQQRZutDWBTNYzn332KlFvF21/Bup+dcl/QUHd+d0/NUib0YOQL/op3+MKIPCgomkNI9hyoJVaS0RXdFL+UGMa0++7hwKaw53+PJvf82cpdxd26Cx57ojmBoVDd0rPaXNtOP6mot9rGwPviZHcxiz3J9jXMzuiPFfLpriBGM+FSmeyGqivzkrQZ1SGxgmtrlsdOmtrt+o8I0nQZVptpnzjYqQyNqMXhUFbjuk58rIBofEo8yd9jq6V8sbszzxHuCTYjbHdEkXXLfNSBGdGo9AIkke3ZzimQ/ZVMqkIU/HooOsn168V2Wwy/5leC/K2qJRL7MhXZLL9zk3zGQYVA0ZsIP3PfgD7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(36756003)(6916009)(6666004)(8936002)(1076003)(8676002)(83380400001)(66946007)(86362001)(16526019)(186003)(26005)(2906002)(66556008)(66476007)(4326008)(478600001)(956004)(52116002)(7696005)(316002)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e8rSooimTghfgeIzls1FysA7a3nmUq8XAxlxomzE+5otXA8RJSTEepl7yZ03dRqMMMWzKEDEWzeLQOfVLqBi/b+Vnyh5wV+UrpqOxiQZ22E9kZ+yT2Mre8q3rkWN+m2DSIB/frGEALlx9UJkeXJSFwnO/a+ultPP336HMVN8PXmqQbLf7kOnz7fmlUu9irfqyh71pxqGqgPuDolWO2TpNAEYSJzIr9CpgQ0rfAFQvB9E5/2sFVwxxSiYKz83vJQ87yq0fgTYCPdDr5zAt4BGnG3cJUprXRuLSokM0dQUvkUtr4iHUx88eeNfgn5trWdNALCR7VexP6Yh07Vr7XzK26kz2IruOKxYDfjrdGJfcj1qLIQ9kCH1FrEL05JRTT1PKlx2UBduYAUcqUJGJByRpCy4P0NTTXoc9dBY1KM6Vf+BFoCz+bJUNMSwpPMGEvx1M6NzVg04uYs/m9rJnjP6Gx+6CsrDR6SsZrhuH9RPXNTYzv5pRPjdvQz/p0JeqkYfe6dsqcOoIa5nEEEC7oEzkP8esNbX6+RKZXSJhSfPMXihxYHzwqObOD8BIzthBw8RUu1FwydkjndmanqyBHV2KyPY7L+phXjaYMHJwdFIhKfOv0Q2akOccmFzBL5U4TmBrcaEIKHHlKm/L4xCGsaW/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4eb165-697e-4a81-6e8d-08d8649cd8bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 17:26:48.8994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbUgwKKYZTWjMrBX2W6GehmhNBTDu8tPGTnYYCixJ54bJeUWSi6SKCtr4kFpOKphQQZ0Cz5hCVAZCvwP7NdZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 71 +++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 56f92cfff591..b7be5c5751b7 100644
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
+	 * that its value is a snapshot of current use.
+	 *
+	 * Following is to be noted regarding how this parameter is reported:
+	 *
+	 *  The number of waves that a CU can launch is limited by couple of
+	 *  parameters. These are encoded by struct amdgpu_cu_info instance
+	 *  that is part of every device definition. For GFX9 devices this
+	 *  translates to 40 waves (simd_per_cu * max_waves_per_simd) when waves
+	 *  do not use scratch memory and 32 waves (max_scratch_slots_per_cu)
+	 *  when they do use scratch memory. This could change for future
+	 *  devices and therefore this example should be considered as a guide.
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
index 17d909c86f50..2807e1c4d59b 100644
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
@@ -359,8 +406,13 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				PAGE_SIZE,
 				"%llu\n",
 				jiffies64_to_msecs(evict_jiffies));
-	} else
+
+	/* Sysfs handle that gets CU occupancy is per device */
+	} else if (strcmp(attr->name, "cu_occupancy") == 0) {
+		return kfd_get_cu_occupancy(attr, buffer);
+	} else {
 		pr_err("Invalid attribute");
+	}
 
 	return 0;
 }
@@ -466,6 +518,7 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 	 * Create sysfs files for each GPU:
 	 * - proc/<pid>/stats_<gpuid>/
 	 * - proc/<pid>/stats_<gpuid>/evicted_ms
+	 * - proc/<pid>/stats_<gpuid>/cu_occupancy
 	 */
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 		struct kobject *kobj_stats;
@@ -496,6 +549,19 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
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
@@ -537,7 +603,6 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 	return ret;
 }
 
-
 void kfd_procfs_del_queue(struct queue *q)
 {
 	if (!q)
@@ -909,6 +974,8 @@ static void kfd_process_wq_release(struct work_struct *work)
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
