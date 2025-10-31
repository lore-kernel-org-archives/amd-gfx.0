Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B448CCCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 03:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EE710E079;
	Fri, 31 Oct 2025 03:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jhR9+Rj/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E34A10E079
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 03:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ac8nYqsJKFTkKgZ3mPS/DA2cQZKKF8PWUen+0vTbZObMJ6y+gzZuNixll4Jb5giQwneVSkT7FmNB4ZvgVyfKEEMx66gDF6CQwZI6mNL4QTO66Jjy2+qoZetzQ7b7Lqq9SYLSJB0FYROA70YUtw+Ace421vy1k2cEamEOynuxlGV1JGNJHF3eb4E9ZkFYKcTFBJnBU5ykjqM3mYuiBQU6tqGHkxwpMvSJKmhdaWDGT4vAScU5uGd315KYtXvQngPclLAyeKQ3OuIbn138Iv0WBL6JDBPTk4qwuZyrXlAIzrZ3iZHf0hZr8bwM6B5YM9wNzff2WukiIbKwMLobGrRMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1kg2rAAAnvXrVmhXYHQAIiDWUk7k61fHW3hBAygscI=;
 b=d8UNl3WsTNZrR/yxwW946azilWVyGfm5aiWjudnZDA0z0O6eeM73TlLNNCBCT6xsCTlykUz3ivsUXjG4TmSN98pm+oIkDmPMl0fvelRgO45tGYgmsViupZQ6836p4LXqDsUb5FKiAVuF9YVWDZuTKFfIkBne1xYUNL37qxFkxox9gP/dZ9WmJGz+TJayyRfru2M1mF9/Fb5UtCxRD+f/qwTPijDV6Qn32iRBouYS1+BQ7ajIqkJ0jhnl+5N1oR1hEawt4e5iMj0bvwXNZM+ayip1hVcVTnVsC9BZvxF6yasasFpZnED1t1IbsdXzMGhMtCNUBVeovFyfvc3ntzDGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1kg2rAAAnvXrVmhXYHQAIiDWUk7k61fHW3hBAygscI=;
 b=jhR9+Rj/umkSxcCrdig3qHjxjhvS4wzfseyqIzFQ1xu5ZUrTUeU9bRm908uZef6dFe6R0oxs8y/mSeQ25yR7XWL6wlFCdxU5x8LGefppO1TZlDYaQx4CPSd8Tpdye9c+Wvgy2TCmR6xFWSskU8XL16gFayeGSjciL1iAURqphj8=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 03:32:51 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::5d) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 03:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 31 Oct 2025 03:32:50 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 20:32:48 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: remove pasid under kfd sysfs folders
Date: Fri, 31 Oct 2025 11:32:28 +0800
Message-ID: <20251031033228.2230-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ab9d66-cc24-495b-9db0-08de182e2b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lX1ozTn0cGd9eBznxzoPJ0UvQBLr8rh4bByCzB3lBsRbS3NSLuYmSJTfjNcv?=
 =?us-ascii?Q?+ed8Qqz/3aksKSl59TNu9HTrA225MYxUDln5Tq0QC+Xp4cyIo4SVpiy/6W/S?=
 =?us-ascii?Q?O9K1F0BBvvkR3s9EW/qn6j4QfdflCxY8hagJeTDtu+M63W745PhFuKb/LXVQ?=
 =?us-ascii?Q?n1wOMMFYnIaIOw7hm0hh+cicmyKkJnSZKDZtGJAG/c2ikvOwhEbkC7lSR3JO?=
 =?us-ascii?Q?pJ1ptToPOhKN2bnaeY1QyB1Zxv7h1VZKs+1JPtpoijyLybdOi8tffFnZv7py?=
 =?us-ascii?Q?kyaxP5ivm5D6eyYUd2SZziLMrZzC5CgMhweoYPt2GU+Zx3JfRiICDzKxlVIo?=
 =?us-ascii?Q?OF1yR3G4P++GgpxjS+w+xFnM/gteChurw6Q6qkfB7PG7v/do1BZWETEANyPa?=
 =?us-ascii?Q?2tJl0TK8whrR7Hnm9P/iSnn4RPH5ekxhVWJlFNQHL+2SmFDf+KUW1hbtyxxg?=
 =?us-ascii?Q?OxooWF4r3D6yHUCudzOIOAIQceVc33anJCxmL8Bf65ayY0LV61goTorfGL2u?=
 =?us-ascii?Q?HVBXqKrBo20aqKECd440CaPfTTm2FIkkMp/JMXyf4nKP15hNccWpTRv+xOQW?=
 =?us-ascii?Q?nm1RDZ8HwPlXpxYYsB0zuguW4Cu00QzBPKJAKV0ZXHPWFFeCa92xBREE+ass?=
 =?us-ascii?Q?nlUegNW2TX4xZiwr1GXfgjV9xsBZGSqMlvC39RGq/N1YKM4sxt/DK6peHjPM?=
 =?us-ascii?Q?JLH1fRJP2SFvtjKIK2mM8nveaIsg5gBFXJ5iC7aYdd2peF14VXs6ICpAVr3a?=
 =?us-ascii?Q?ognQ9wXyeaRKBP3wFtVV6FR4ALUTURqyKg2ox8NvgGhrV09AsukrOvGgmN+e?=
 =?us-ascii?Q?MBZ7t0kpe0nomMdz6HbZTDz1P+xVuHNhqLlyueeG5GM8KKOhbGTUCYxyQv/e?=
 =?us-ascii?Q?zUSYwQ5tBMC0F85Si0ZBGvA5gaBae8ehNVBJ14H5GrhrRWMtzeYWOMzR0FTV?=
 =?us-ascii?Q?r4J7AvjKl8dKHxtK2Ftk1XLarkyhw9OkZzgwBi6/DNBCZ/A/sU1siP5iNGhG?=
 =?us-ascii?Q?WinSJUejoQ3w0gOBg/l1PJMBZORWStiihDtbTwwt4zis6DjDKA2Gjnxku26J?=
 =?us-ascii?Q?HqgPt0osOpu4lQAvKbEz53bJdT6ptYyrCuGT5rsD4Z2hOtVuqg/3f77d/oum?=
 =?us-ascii?Q?6Ias2UTHVk7jOLl3pkay0a2gixTX7ajlH+GmOJBUfupNkRYDacs4CoWQZrTQ?=
 =?us-ascii?Q?RjFv43Mf5hXfsh/lDWS06oJrBjzQqX9CQdTVLkNYz6r+BppOe6Qet9T0PriH?=
 =?us-ascii?Q?8+Au7R+vIwZV8EDa9eCSzgrIjDgktwdazR6POqrPYTv0iIVDG3sofCMT76w2?=
 =?us-ascii?Q?FC3juHlvbKOhMsKUL4KbkSGYWu7uaeasxbdsqxCtGKJ7tvUxlr30sg0vwuCY?=
 =?us-ascii?Q?qqxK+E+jY0+zr++iKXy1lFgic2fH2i9qRJBj0IogGBCtghmow/npSqNxbmvl?=
 =?us-ascii?Q?mRBr/8ZGoAa/a712Qx3nW2y8z8GK8+ibKe1MEeGDxKH9vGKgeWoSbnakw1wy?=
 =?us-ascii?Q?9tx5r6diYP8UZXnKcUO/bIdLJpDO9NJMITXLhIhDZAmZ0ih3L6XRMeEXKMTL?=
 =?us-ascii?Q?y8aLreibuGaAf7N1ctE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:32:50.4814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ab9d66-cc24-495b-9db0-08de182e2b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

This commit removes pasid under kfd sysfs folders
because pasid should only be used in kernel internally,
should not be exposed to user space, and current
pasid under kfd sysfs is buggy hard-coded 0.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 7 -------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +-------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..d69079cab1e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -983,7 +983,6 @@ struct kfd_process {
 	/* Kobj for our procfs */
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
-	struct attribute attr_pasid;
 
 	/* Keep track cwsr init */
 	bool has_cwsr;
@@ -1100,12 +1099,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 					int handle);
 struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
 
-/* PASIDs */
-int kfd_pasid_init(void);
-void kfd_pasid_exit(void);
-u32 kfd_pasid_alloc(void);
-void kfd_pasid_free(u32 pasid);
-
 /* Doorbells */
 size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
 int kfd_doorbell_init(struct kfd_dev *kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..f45780502f06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -328,9 +328,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
-	if (strcmp(attr->name, "pasid") == 0)
-		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
-	else if (strncmp(attr->name, "vram_", 5) == 0) {
+	if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
 		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
@@ -888,9 +886,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 			goto out;
 		}
 
-		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
-				      "pasid");
-
 		process->kobj_queues = kobject_create_and_add("queues",
 							process->kobj);
 		if (!process->kobj_queues)
@@ -1104,7 +1099,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	if (!p->kobj)
 		return;
 
-	sysfs_remove_file(p->kobj, &p->attr_pasid);
 	kobject_del(p->kobj_queues);
 	kobject_put(p->kobj_queues);
 	p->kobj_queues = NULL;
-- 
2.51.0

