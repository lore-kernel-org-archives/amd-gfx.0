Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE7C4727C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 16:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04DC20708
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 16:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yrWdPYs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04DC20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5161289D42;
	Wed, 30 Sep 2020 16:16:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAA089D42
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 16:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T85ov80WzwYZJP+PdEanWRveDoIfgXZC1GRb9ZxOdQftnY3FMEwPhhjL61K66suSq5V2KGlHWSQV0/PUyrClgVgNx1M/9Bex5tT9+NtdwqJo8oxoj3x3OAhKEq3IKmw2ppySzn0iokaK0xlnPnejfdYf2lmwtCJSvYr0ofljstmSUraFobMJ40vt8r7/gdiqRfC5z+uwXZY5KPJ3JTTtCFxA5/CYl9OYx3aBljFVqByEYAwRF987JZOBuBT40b4e5lDm5u1NyJ2omHBV+WQupi6fCxaX6euf3zk3aAaV+xhhjrJ4PcxOF7emN5QWNi/3k1kIaMgUkZVfgIW8JbHHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q9HPKIVPTo7eZBDEfdHSwFHRUSpHxGy0ZJ09kCs4kM=;
 b=YTPuNUkS/2UsmhRzTbhsi77X54sXsbfH3FaWXglTKln+Av80iQrOLY79yF4DHwPKPIKa4dAW4ogrhwfIPSFgDghYMW1mPldjjrHdc9TZzUvin/rf3bxycSd19eY4Fs7w/gP9MvDDl0DOxsyWXtVjI6skQW+9MIrORwVBpCu2CgNfaVMAQxZ2VMkCMuayGrclGvOoWQRu5gCsNpnukT2bSgG823dLycoU7vYMdSvHf9WMGjF47OzQI7vAmptLWFhLrCrDqtl+IUeyySL3/0TU6KRJFY7BOhB1tJu62bjyev3JC2ZlTrnEsegLgBe1goOjfvxOadMCNPLMauQrfgBELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q9HPKIVPTo7eZBDEfdHSwFHRUSpHxGy0ZJ09kCs4kM=;
 b=yrWdPYs3NvvPdVCgIpOKcP7zidNaUzO20ROJKMHVDUMmusj7J/eETyK/M8uoWfLVs22q/bTG+QfWqr05Ywm8ZA8kmqbZf5nAqrIq6xmEEsUn2zM/1uKQnX3ilYpgz2H0zXtjE7v7F/723WZJ2w/Jvx9Jv+3MtcgR9/XdHDcIBVc=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR1201MB0043.namprd12.prod.outlook.com (2603:10b6:4:57::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21; Wed, 30 Sep 2020 16:16:54 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 16:16:54 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd/amdkfd: Surface files in Sysfs to allow users
 to get number of compute units that are in use.
Thread-Topic: [PATCH 4/4] drm/amd/amdkfd: Surface files in Sysfs to allow
 users to get number of compute units that are in use.
Thread-Index: AQHWloW6E1VSIjz5iEWAcm0Ulxib6amBXQmw
Date: Wed, 30 Sep 2020 16:16:53 +0000
Message-ID: <DM6PR12MB27615B8CBA5371C8D4F9689D8C330@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200929172635.25037-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929172635.25037-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-30T16:16:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7afd92b7-63f1-49ab-9eef-5b84729950e7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:f5c7:44e5:3b68:a5fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0c11349-1d43-4abd-63f5-08d8655c3ef4
x-ms-traffictypediagnostic: DM5PR1201MB0043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB004365FA78D419D5DFF2451F8C330@DM5PR1201MB0043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 786FF1ctWG3ZXYQMxSbf8zkDC42MPQ6CiO4myvh4O5FwaM4NnTUwOje92Myc7bq16mRqRCsw1GrKIDyKmIGQ8OPXYNjIEx/IpEpeXxbGUelSusvg4I/ZbI8934kX1GY5WLLsVmDvKDBcomoXR/DLIZ31IQv29ryyQQyNnCY/11U1YkqID8HHdnN+G1Ddw1GQ2Hx6reCSpcreClUXE2wY6stq+FxEGQd3n+w7kye3ME14hzMQ1j/X8/LbuOSOe7MDga8X1Lkzsp4V9s6lrDn1aK0eNq48b6dy+LJEvzS8a124SdKXu8cAvGh+c2C+qIxk2Ezt3mpKc1TPBJKm7a8BN1g+Le4MoTYU2baH2p/X8qVrXNkDlL9uONC2ihhGEJqgZY84GO2v4phHCKc34qB1s9SbM1CouW1gJoq+TOC1ULE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(110136005)(9686003)(4326008)(316002)(2906002)(8676002)(86362001)(8936002)(55016002)(45080400002)(71200400001)(6506007)(53546011)(5660300002)(186003)(64756008)(66446008)(83380400001)(66946007)(7696005)(478600001)(52536014)(966005)(76116006)(66556008)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7VFJcaCe41Gg4SRiZIzpPY1hRypPel72Hl/9ttS4bgn/qx4ixxEEMeqv6bPrK7kBMisMVpmbD0GebV7CK1x/jbEmF57nS+XtDDkhscDmolMI5NlnQJLkj/n0wRtwazEsrG9sEg1Iw2B5wJ0lq6F9bgz31g4AYrCKDFaZfsxgT96KjlG7JKTShkmnFTehplcAASJ7LCbI2crboKznQRLXzHBp7WR6fAbCJkOpHJgQddQkrYw/9hnrJZAN/FpyzVTvQLcWqKiZ7oy7wyZaSm2KagOdrdCIwXs07OYIJd0Scg3AAY0fxpw4bn9s8RvGzKOPhmQYlBajwRR/WnaT3zeG9X8BgnuLl1U2q0BOI1cJjSvdFzneF31CAK0E15xsSOmnH3IazMMQEyz4jt7NaJg94xDSDVU3f+avRapiIN/nUqUxRTcQ8bnhltz9DCuP7yONQsDCQvJFUH31Xlfi3TH1wJ92J/6gi+18TnQvuXGeodX2HX7rLvPMaw23UvLeXKsezlCJJd5U6g+dZjHgqX9hS/wdqg6OyQWwN1Eh0I9ntxib9bxNmHslTrAiYHzcngS5G6Ol/VS1u5LMwXo/MNyarqd3l5LwEc8tJSeAK/IjBvsIGEgZmiYf2A4sTcsMRs644AFhwXo5AikXoEXU+/+zlhNLjVtddiBy+GJmczWUJBHHu5LRkDIQ8uuWLRkvFzVG5yuNTaD13hQosWUEvyv5SQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c11349-1d43-4abd-63f5-08d8655c3ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 16:16:53.9176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTA3rujYMr6wcJlmgFW9Nnrok2QK4nq7ygkG5Cehtd5v9V4vSi8H15sJf/8XdEgR5HHatWvRc4fezlk6ZjGrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0043
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
Sent: Tuesday, September 29, 2020 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 4/4] drm/amd/amdkfd: Surface files in Sysfs to allow users to get number of compute units that are in use.

[Why]
Allow user to know how many compute units (CU) are in use at any given moment.

[How]
Surface files in Sysfs that allow user to determine the number of compute units that are in use for a given process. One Sysfs file is used per device.

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
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 17d909c86f50..2807e1c4d59b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -249,6 +249,52 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	}
 }
 
+/**
+ * @kfd_get_cu_occupancy() - Collect number of waves in-flight on this 
+device
+ * by current process. Translates acquired wave count into number of 
+compute units
+ * that are occupied.
+ *
+ * @atr: Handle of attribute that allows reporting of wave count. The 
+attribute
+ * handle encapsulates GPU device it is associated with, thereby 
+allowing collection
+ * of waves in flight, etc
+ *
+ * @buffer: Handle of user provided buffer updated with wave count
+ *
+ * Return: Number of bytes written to user buffer or an error value  */ 
+static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer) {
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
+	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt); }
+
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
@@ -344,6 +390,7 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 
 	return 0;
 }
+
 static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				     struct attribute *attr, char *buffer)  { @@ -359,8 +406,13 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
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
 void kfd_procfs_del_queue(struct queue *q)  {
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7C00d660dd712f484026ed08d8649cdb27%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637369972149551613&amp;sdata=Da4vCNUBzXOxuCLmzKy18bi3B3alZGA2qLYq9z33LYY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
