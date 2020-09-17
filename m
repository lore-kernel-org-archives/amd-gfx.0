Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD59C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960CA21D90
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I3/fOngf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960CA21D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0286EC62;
	Thu, 17 Sep 2020 17:11:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4306EC62
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 17:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfGOhLuhwlcYUP+Yj9XX3o/VMrAYwOni0gEVq6dWNFu2uE2wHwG+YjGtj3h31htr+4WTgNANwE+RhWWn9tS6CUkk3ApPm1aOBxdTKDdqOQtciTymlxFCnAUKwx/peHm9YIELdT22ry7rOD8dhsOHnpaVjYkrqjvAZt5yJviuZTvpLkWE/MsbjHigmgYboO2HHACfm9Y5cugKqUJRW7FUuacHoBHHEbHZExwP5uUKZsQMSIVsBSXr9NXkpWkfibnsf6xIPGk/62NTuEEHk84UEBZEoO27i9YD2hVaDDFo9+UgBmAn1pOXsCh9ORW9dY2RRpPeXPYf9aIGhhqpeobxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEMDA95P3CIa/NIA5IGX+vTZC5gv7HIfVofxwD/HVLU=;
 b=mqb9KL88FxZYQXOslXIzngDJqnG2wwp37Uqs6bG+2YHOsm7b241bgw+11WEqdLPQAu+ElsjBsVHBBSJvIGMx9RM+IkAH5ccfOjj1PHhKoC/DiD5ncY6FcHlziH1xr48xmirlbAHpCRx2HB9Zdv9yTyT0ob7UaYlen8hMMnTc72jDYcDvzr8pCAxTBLFqqWAcyf8wFRFIZEgIoiwth1rPXGdzYIRFJpApfWlfE3T4rkDUQo2Qru+JGDHg3W1Zqe35yknlrgzYmbE2xJUBVySW9eGY1f9HzW33XwmeBYeb4FU90csvhZJUhUrc9cIkcdoENIyAzi1ZxzhqMYNLeVnvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEMDA95P3CIa/NIA5IGX+vTZC5gv7HIfVofxwD/HVLU=;
 b=I3/fOngf3dTXDXWV1awCPghWG7tRfhITQicfVA2NeChhsPROYordFeOONzW6HIGNL3fpvNUqExecnJ020wnSMDwQjCIvPKKQENc406ymoJO7oQIXWl3HlAxqwyxvAD+HvESC682fbHyYHVm/dpM/XdT8dFu6mDkAqcR+8KsSjl0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 17:11:33 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 17:11:33 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow users to
 get number of compute units that are in use.
Date: Thu, 17 Sep 2020 12:11:18 -0500
Message-Id: <20200917171118.2579-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: DM6PR02CA0091.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::32) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 17:11:32 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1e71edc-e91a-409b-8157-08d85b2cb9f6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27360E6094946C72C4C6BAACE33E0@SN6PR12MB2736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4YzdgsBCcXSc4aF2alBJ/ylsutetDNIz4sFT052TjQlVS7I12b117jaOD8eKxV0HO95rWM7aTU0d6WJszP25S6nUD/Jrd5KM3bin+RJcj+sY/w8lQoYiwCx5RRMTXr42mjdskDezk50oc7pRCbNue2R4SW+zh3GyvmJ4E3GDRD4B0Spw4dNsINb7xUkqgAOyRPUyKL630IJx+390OvRhsWGH0LgQYMdmsVBebKD46dSMzw9uXdIJk7YMKgju1z4TAeFoY9Kpqp7ZPOO5v4N9GKP+8atu5sBO0phqDyibb72xfwagMqhkqn4WN8yYtrsYfolA2GZAzb3kAzh/SaeI5iWkR7AKJeQsdy9Sk0+NfEZKk1OdBLGk6DhRF2jUagg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(316002)(478600001)(66476007)(6486002)(6666004)(86362001)(5660300002)(2906002)(1076003)(66946007)(66556008)(36756003)(26005)(2616005)(16526019)(8676002)(8936002)(186003)(83380400001)(4326008)(6916009)(956004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EBRJXuU0VtqKicP6ofelbDpGSAqtyNh5vDpGwmAZl3eLaPwiwBrEYasmbuyi4cccAzXMdQuhhtTAulDQgl5Zqy8iMeAY22o5qkspB6QpdNEPjcm66wIXY8neB7unvggRYhesh6K8DdjrcMqPaNcb0/DBvqkEsUTTF9vMLr0i2IhHiZpkqvNnE8XuapoaYMP3quBOgxJC50S13PMLqbPQtz3rxEq5cmEzqpmZUteJ0oY+r3orYj9WKEbJKOCWxGaa+kNuTzEGAc5xCn2OaJACYNrcxvZ0FVk9KgKTVkrV2yGoLJunkQm6L1djXzJgjZ0uiajGlU//UbnF5Cr15qlpDVF4YbFQO4iWC2GevH0ZC27mWKvKhBRNb89kRJBtTDxh1YxsQShvO9N0u/35jxDGhXWeHDPsT8IZxQ+yEkl4sCtpWbZUoQN90Z9ToH+vVe4YvWc3N9OG+zXgmMXCp81TaDU1EIAydhUGbuVGOlI0wDa6c3r9QJdzWph+GCGBgvbmXcP2Lv4dvZwBNjcF7L/1AEiNj6LkMJe/tkllnRNiD3dRz4oBj2X1cU6vcnpibLf0rhmU8CDDHoZD9Tpjnk4gg5AuKraRqKcdM+cQdSrsnFZYpR1QesWhUNmHFvisz5OV4MIieWkXIEC7YrURIa3LuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e71edc-e91a-409b-8157-08d85b2cb9f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 17:11:33.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbv1uqUfAbN434xlSWAFmKOUp63d4lAIOC99l502Vi73ulgST0xeZr1AWr8tHJXzul6sCT7aONwK87hZo7QMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
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
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  28 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 101 +++++++++++++++++++----
 2 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 023629f28495..2ce03586d0dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -631,7 +631,7 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
-#define MAX_SYSFS_FILENAME_LEN 11
+#define MAX_SYSFS_FILENAME_LEN 32
 
 /*
  * SDMA counter runs at 100MHz frequency.
@@ -692,6 +692,32 @@ struct kfd_process_device {
 	uint64_t sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
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
+	char cu_occupancy_filename[MAX_SYSFS_FILENAME_LEN];
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a0e12a79ab7d..3baffbc828b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -249,6 +249,63 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
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
+	struct amdgpu_device *adev = NULL;
+	struct kfd_process_device *pdd = NULL;
+
+	/* Acquire handle of Process-Device-Data associated with attribute */
+	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
+
+	/*
+	 * Acquire handle of Gpu Device associated with attribute. Determine
+	 * if ability to collect CU occupancy is defined for this device. If
+	 * so acquire the handle of process which encapsulates the PASID of
+	 * process. It is possible that the process might have zero work on
+	 * device. This is determined by checking if process has any queues
+	 * @note: Ability to collect is defined only for Gfx9 devices
+	 */
+	cu_cnt = 0;
+	dev = pdd->dev;
+	proc = pdd->process;
+	if (pdd->qpd.queue_count == 0) {
+		pr_info("%s: Gpu-Id: %d has no active queues for process %d\n",
+			__func__, dev->id, proc->pasid);
+		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+	}
+
+	/* Collect wave count from device by reading relevant registers */
+	wave_cnt = 0;
+	if (dev->kfd2kgd->get_cu_occupancy != NULL)
+		dev->kfd2kgd->get_cu_occupancy(dev->kgd, proc->pasid,
+					       &wave_cnt);
+
+	/* Translate wave count to number of compute units */
+	adev = (struct amdgpu_device *)dev->kgd;
+	max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+		adev->gfx.cu_info.max_waves_per_simd;
+	cu_cnt = wave_cnt / max_waves_per_cu;
+	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+}
+
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
@@ -279,6 +336,10 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 		return snprintf(buffer, PAGE_SIZE, "%llu\n",
 				(sdma_activity_work_handler.sdma_activity_counter)/
 				 SDMA_ACTIVITY_DIVISOR);
+
+	/* Sysfs handle that gets CU occupancy is per device */
+	} else if (strncmp(attr->name, "cu_occupancy_", 13) == 0) {
+		return kfd_get_cu_occupancy(attr, buffer);
 	} else {
 		pr_err("Invalid attribute");
 		return -EINVAL;
@@ -432,27 +493,37 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 	 * Create sysfs files for each GPU:
 	 * - proc/<pid>/vram_<gpuid>
 	 * - proc/<pid>/sdma_<gpuid>
+	 * - proc/<pid>/cu_occupancy_<gpuid>
 	 */
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 		snprintf(pdd->vram_filename, MAX_SYSFS_FILENAME_LEN, "vram_%u",
 			 pdd->dev->id);
-		ret = kfd_sysfs_create_file(p, &pdd->attr_vram, pdd->vram_filename);
+		ret = kfd_sysfs_create_file(p, &pdd->attr_vram,
+					    pdd->vram_filename);
 		if (ret)
 			pr_warn("Creating vram usage for gpu id %d failed",
 				(int)pdd->dev->id);
-
-		snprintf(pdd->sdma_filename, MAX_SYSFS_FILENAME_LEN, "sdma_%u",
-			 pdd->dev->id);
-		ret = kfd_sysfs_create_file(p, &pdd->attr_sdma, pdd->sdma_filename);
-		if (ret)
-			pr_warn("Creating sdma usage for gpu id %d failed",
-				(int)pdd->dev->id);
-	}
-
+		if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL) {
+			snprintf(pdd->sdma_filename, MAX_SYSFS_FILENAME_LEN,
+				 "sdma_%u", pdd->dev->id);
+			ret = kfd_sysfs_create_file(p, &pdd->attr_sdma,
+						    pdd->sdma_filename);
+			if (ret)
+				pr_warn("Creating sdma usage for gpu id %d failed",
+					(int)pdd->dev->id);
+			snprintf(pdd->cu_occupancy_filename,
+				 MAX_SYSFS_FILENAME_LEN, "cu_occupancy_%u",
+				 pdd->dev->id);
+			ret = kfd_sysfs_create_file(p, &pdd->attr_cu_occupancy,
+						    pdd->cu_occupancy_filename);
+			if (ret)
+				pr_warn("Creating CU occupancy file for gpu id %d failed",
+					(int)pdd->dev->id);
+			}
+		}
 	return ret;
 }
 
-
 void kfd_procfs_del_queue(struct queue *q)
 {
 	if (!q)
@@ -767,8 +838,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			amdgpu_amdkfd_gpuvm_release_process_vm(
 					pdd->dev->kgd, pdd->vm);
 			fput(pdd->drm_file);
-		}
-		else if (pdd->vm)
+		} else if (pdd->vm)
 			amdgpu_amdkfd_gpuvm_destroy_process_vm(
 				pdd->dev->kgd, pdd->vm);
 
@@ -815,7 +885,10 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 		list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 			sysfs_remove_file(p->kobj, &pdd->attr_vram);
-			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+			if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL) {
+				sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+				sysfs_remove_file(p->kobj, &pdd->attr_cu_occupancy);
+			}
 		}
 
 		kobject_del(p->kobj);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
