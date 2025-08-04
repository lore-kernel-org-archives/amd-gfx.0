Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2387EC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FDC10E437;
	Mon,  4 Aug 2025 11:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJWuzfZq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591F110E437
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2qWCLPHcOzaG5DRSFi1g5Pzq6qluACqmFAgkYRWAadLab0wJAn9geeyxwns4EcmcUk9+COxCZjvo9Vydw8Jxmb3yl3wyY+7L+3GiUfaHCuh/7AZojzERW4tQVVuy8h4hU2gFVr0Glm9lHALi7SsSRLD4XRxyQat30+OFtwlg8pSiYkZIHgW3hM9Rjo7MmskeuDiQWCW4zcaMtLYDWQqUTXGu0UV1epGqGSxMTbaLLafj/wll6HdRPkwEOdEOZtfWafzPzQ8ccSUBp4y0xqC1YdybRcHQKl9pUTDCRh2CPgWaNeDmd63xevOz1iVSt9lbvLXTxTnWRNxOCay6lBd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUWFJmZKQB0zC5vJRFUm1E53SaN6czEe6WcdaqJCvKg=;
 b=wCZ48MLGxI3tWyOvlHtJ7L87lxBzWyGp9E3CXu7w8JNfr+J5vAusJTwpjV/Yem9DvjxUicvLO9yu3pBGHjdRleABRmF4vGTuufbcsluYpjzJJqCppgHqCzkSwdsGUzd8ar1bf8gat8Gmhhx9LpohJamKqkkAfkjyOV50HrvuSGtBsTHGYyjFqINlU07VrJaKYAtkuo0/BLjFh31aulQnQFuBzLj5YPo6XX14hVNEX23s+k9m6leeNiddoHXb0QBGd/8aQczIqLXC4A2zqkyOZKEP2Ywq4wMiyQrOpxFI4uu6zrNKX9fg06RTla1kUFfLrLsdw43tv4VGcYAScug7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUWFJmZKQB0zC5vJRFUm1E53SaN6czEe6WcdaqJCvKg=;
 b=JJWuzfZq2rARqa2pXpvtZOJ7HMD9gOl2ELP5JW/fTkvlfVPIJbCy8VeDKvaiaRyCsgfjaVaVL49Ax0AlcScwXtm/p9QnS9+AlCvoiBr2nNL2Nf/k/jYY/WGT4wJHGlG4lJUgyY3bDuKSAZXE5foBj77UJBNjqNl8kBmcYwzeZaw=
Received: from SJ0PR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:332::21)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 11:06:35 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::5a) by SJ0PR05CA0076.outlook.office365.com
 (2603:10b6:a03:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Mon,
 4 Aug 2025 11:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:34 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:33 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 04/13] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Mon, 4 Aug 2025 19:05:41 +0800
Message-ID: <20250804110550.261311-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc96df8-dd77-491b-6039-08ddd346f9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHCIF09EPCVWDW9eJ0zhivTLOu4a6NXh7teVtjTIGu2ex+KLgH1iBzfshxY0?=
 =?us-ascii?Q?9pHDgMQJQsoGveRONoPFUvDO3FR2B81imwK8xFvTEevwx8nqXKI+KmJjzjs+?=
 =?us-ascii?Q?bOmSh0OpPRA+JanSGp4freCBIuuG6xE5pxwveQiBtV5SzpYsafzP/ghX8nn9?=
 =?us-ascii?Q?KqEpUKIhSpR/3S/3ByJJ1JKAUj+hSzLRDca1bSS/fvJq9PcK8wp87JOGP9pr?=
 =?us-ascii?Q?ujNPjk3Dj8OstIIHc8HlwqDXcIegeoZdapihK6FUDaNEmsDskFl8L/P8dDJv?=
 =?us-ascii?Q?VJD0ZXuSvPEz8piqNQRH0f3YClN/lbrhYtrBomZIha1ZiF+7sgt4FtbxfKyR?=
 =?us-ascii?Q?U5YDGofKXsi3ot6A0dQc08uW/pA9TgrpLqVAijcBip7/qHkh77/5r+JMPajw?=
 =?us-ascii?Q?DY7ZRLR/A+bZOqVZxTi0S5hf8YnXHYiN6Icw8xmQZX8VK9JIAyt8Fu2ycwO/?=
 =?us-ascii?Q?gOx6JkuosLb6H1rQsDiXUzaHqmzrrn/A+hoqlmaWLAT+amCgP/MnfuWT87H7?=
 =?us-ascii?Q?pa0SOOmDppF1avBJOC3T5XKPhDuksSkIUcJPgGId3D3wSAmyr0B5a02e0hoa?=
 =?us-ascii?Q?tf79dm6HIY/6Y1+wlRILzK8qftOxQwv0IkB26nsakJn7Jj8wNd3EXW+Ayz80?=
 =?us-ascii?Q?75vnrC+9BEDkpizgzQVwtMG/a4TLMjJFMqOSNerhDX8aXDCt28CM4AuSq+oc?=
 =?us-ascii?Q?rW3szHTXZ2c2id8KFK4eTYdz/eUXc/fJ/OVeGpXwFn61MlREiyvUp1gVKI+v?=
 =?us-ascii?Q?XTWSfA/II6plrCp5Zh4WCt5Uy6O/7EzTa+5+2Qv3R0HT05ziT5L2DSgUp8e9?=
 =?us-ascii?Q?+wJPiubCgI2yR4nWZov0OGOOzl2TcukZX6eyV0BYryIDYsxM8MVlX/q/oQTu?=
 =?us-ascii?Q?NQoI/alnz0W7p3Utns0pimgUmBXk/5lJ0lZUf1y+D074vcle4Tm5OB0cOTJb?=
 =?us-ascii?Q?zCsnH0mqLq3jFTljgC5BnY1iAYGqqEP5FwjSn3YPKFbqTIMIVnfeSa5jdA71?=
 =?us-ascii?Q?aBQvb/Jata/leNwlChc1b2mFUT+PqvIFUiCqIGwx/Z3iI/BzEN9+dQl1BNQj?=
 =?us-ascii?Q?LJ4RpcGputYs3Pwgofru2k6Pqu+YP5xTi24h8kjyMeqLYnm3PO9oX4FOTHJz?=
 =?us-ascii?Q?g1tW6K+j+kUQ2u8mt85oNuH2R1wkQSIKsb0oHOn3aafvwTVzl0t9YVjHjG19?=
 =?us-ascii?Q?02hxRtiMQNyiRbtVzMTNWbCAw2CbA1e93lNEn3CV4i7vhrYbqzp8S4FaXErL?=
 =?us-ascii?Q?ve5GK7XiBNrlM/YDzkORaijYf7/bNyTUhC09Z5CeLDShsaL2+qQ97W9I8vmq?=
 =?us-ascii?Q?aO2C5JWot2aMTHxBqWWwZGX6FVxM7e3dcP28czPqhdjFd+j48wGX1RAy2exr?=
 =?us-ascii?Q?awndC+b6TE5HCG+PNbSszz80IX/ssFqBR5w5IlRxFWBtYA3KXZ9EzvnT3WVf?=
 =?us-ascii?Q?va54RPMw+WEr0W/Th3tIfiQDg9QFOOk8p7Gqw7q+HQ4+JY45jFkxrHR4e+1G?=
 =?us-ascii?Q?pbKcsUtw3giteVyv9dpUCTMJAQ3LrDqQr/Ww?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:34.8691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc96df8-dd77-491b-6039-08ddd346f9e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

KFD creates sysfs entries for a kfd_process in
function kfd_create_process when creating it.

This commit extracts the code creating sysfs
entries to a separate function because it
would be invoked in other code path like
creating secondary kfd contexts (kfd_process).

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 66 +++++++++++++++---------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b95f37c1af8..0818705820c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1043,6 +1043,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
+int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 88421e57a072..bce7e35a15c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -825,6 +825,44 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 	kfd_process_free_gpuvm(qpd->ib_mem, pdd, &qpd->ib_kaddr);
 }
 
+int kfd_create_process_sysfs(struct kfd_process *process)
+{
+	int ret;
+
+	if (process->kobj) {
+		pr_warn("kobject already exsists for the kfd_process\n");
+		return -EINVAL;
+	}
+
+	process->kobj = kfd_alloc_struct(process->kobj);
+	if (!process->kobj) {
+		pr_warn("Creating procfs kobject failed");
+		return -ENOMEM;
+	}
+	ret = kobject_init_and_add(process->kobj, &procfs_type,
+				   procfs.kobj, "%d",
+				   (int)process->lead_thread->pid);
+	if (ret) {
+		pr_warn("Creating procfs pid directory failed");
+		kobject_put(process->kobj);
+		return ret;
+	}
+
+	kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
+			      "pasid");
+
+	process->kobj_queues = kobject_create_and_add("queues",
+						process->kobj);
+	if (!process->kobj_queues)
+		pr_warn("Creating KFD proc/queues folder failed");
+
+	kfd_procfs_add_sysfs_stats(process);
+	kfd_procfs_add_sysfs_files(process);
+	kfd_procfs_add_sysfs_counters(process);
+
+	return 0;
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -874,31 +912,9 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (!procfs.kobj)
 			goto out;
 
-		process->kobj = kfd_alloc_struct(process->kobj);
-		if (!process->kobj) {
-			pr_warn("Creating procfs kobject failed");
-			goto out;
-		}
-		ret = kobject_init_and_add(process->kobj, &procfs_type,
-					   procfs.kobj, "%d",
-					   (int)process->lead_thread->pid);
-		if (ret) {
-			pr_warn("Creating procfs pid directory failed");
-			kobject_put(process->kobj);
-			goto out;
-		}
-
-		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
-				      "pasid");
-
-		process->kobj_queues = kobject_create_and_add("queues",
-							process->kobj);
-		if (!process->kobj_queues)
-			pr_warn("Creating KFD proc/queues folder failed");
-
-		kfd_procfs_add_sysfs_stats(process);
-		kfd_procfs_add_sysfs_files(process);
-		kfd_procfs_add_sysfs_counters(process);
+		ret = kfd_create_process_sysfs(process);
+		if (ret)
+			pr_warn("Failed to create sysfs entry for the kfd_process");
 
 		kfd_debugfs_add_process(process);
 
-- 
2.47.1

