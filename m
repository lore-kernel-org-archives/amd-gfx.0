Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6F5CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F011610E576;
	Tue, 23 Sep 2025 07:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpqZjT+K";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53ECE10E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi5tIGkHyPIoQYLj9FlXHsjpCKpvlay76aRjGh/RAPNCS0/cFCx4xdUbOz5Kx9JvbF8nIQa1gRgrTEOe8VnMzo/mz92b7LLJEZ7t/5gFqR/g2ax4C9KA4nbFKIBTM2/9btib+Hcckz+4cdm9DIp9l3c1/0fVkZUO3KK77jE49TN8cpyae/dMYf/brh0He5gTxAdIAuApv1oGCU2O9TG42PY/9SVUKLlJzg7tAvgyarK2MOvTVnoTKw1SQhuM/2X4BgvF0+MG3Qrf8/aO84zwPzuoSnVU1BgCwhuO02w8MKplZwAIrsVNvYPolf3pLWYi4AWNPeMPHmCyMZ83G0qc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if9SjjfOiZU8qU5SSQvmZWFQc+VkfSdPTWxw6EjPZRs=;
 b=GVKSsSY9oNUqgs1Y2cf0TBL7odpLgCdonxgDu8c/Q6ezEQFmlHcTqWJtjsUcHNJPIpPgztxHPBMRxgV7EQeOzif2zV/fjgnVYlhYtE+nc4sFgYxDKhRHkvhgkNl14HKF1QHJ7PL2hPAToRbD1EFV6Ud5PYI794r/UFJJ3CeiSD+1yoRsYfY6PfXZHqUy82Db4KsF6IXNeGYje2AFeCkC5cZvh1nJAkaJsdbDy1n1mMJEsr7q1pkT72o9Ivy/0kNaVShf/JmT3NCGHMPYR7CVPrC6lxrfjrlbSwZB/i0lcVPOU5f8uo4rngHfMmWR2RYbWuVp07mOACzjmDbapPXcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if9SjjfOiZU8qU5SSQvmZWFQc+VkfSdPTWxw6EjPZRs=;
 b=QpqZjT+KP0PgC6v4QKRRJbXs/Mt+nlWhiYDOM3aqZXoM4SI93eCLD1Noql2jJP/KcZtCF6/sVVRXT2KrJPhp4/WZ/tZocd48i1/gXe1CeqVI996AQ7C1Sqmub4G23qvrDNXFK3R8lRLRuj54kSEZuCdTWRVgGicEld/XRcYQ2FA=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:42 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::be) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 07:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:42 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:36 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 04/18] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Tue, 23 Sep 2025 15:25:54 +0800
Message-ID: <20250923072608.252345-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 976fefdf-a52e-414d-0186-08ddfa728b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jgw4nnnCxtlTMEuhqA/NqV4d8p7e1zZTEnpsJpP44Y+9Pr1a6NSSZtOTEskE?=
 =?us-ascii?Q?rE6lZMrrEcZGfBmMTLHtrc9esQyEKrSziuuKlmiH7lKmLh4C15RvwzNDZk1w?=
 =?us-ascii?Q?KcMmMlmFi33O54A46u6ZunWAEs0kl2d2dJXAS6VCouspP8s5KyEQZmPTHAgC?=
 =?us-ascii?Q?GPa8OkSTdVV1OfUN5hQF37vRAe8bDvv0PilNbMvOEsW1scLEcSqGhSWsXc4A?=
 =?us-ascii?Q?/ZEAWUQ0KVc5/XORx12GxZgNEquoE+ucq9tmNg9DmY5DzdFPs8KoqTIWK9UK?=
 =?us-ascii?Q?LM51BkqKAd4rOxG/NpMACMMMI/KIK67sJ63PyxSmq2iRyqeCjNUbAGOEyL/r?=
 =?us-ascii?Q?Yv9F2ofomVt3mJJ0uHaxf8liYgX5M37EjqbaRDJc3yJJOactdsXHPYB5GgO8?=
 =?us-ascii?Q?6BuoWwq2iYl+Btx4UF8hPqcIImFPGO4O0I0l55sKlDJ4dE/a8kJuPhFjhl6j?=
 =?us-ascii?Q?obVhWqMLv60h5YZsI+jT6knd1w+ixx/pmlfMBkjxWtmNDnlFwjVvmTqlSJLM?=
 =?us-ascii?Q?SYDkOUkM8PxAO++4LaDRtnoaO8DpyXEQ6+Z/iDQ02uKzvcpyCotvRD7HctNh?=
 =?us-ascii?Q?YoXnSgm6Iu1JfyMcQJrTKvu8DDrPyoBopjiEpmuCBBx6uVL980WgrXViPvLp?=
 =?us-ascii?Q?DV/MjLpjtglk4i87h1VMDi5txGaf1/2V9cTzHveVCfJ3sCef13KXrv++py9p?=
 =?us-ascii?Q?EyD0SkBSpaFa+wItLxqzi9hvTvKkj6U9WtLpnJ8XWgomVaSLpF1695PSD2AW?=
 =?us-ascii?Q?sRmt0oLVFRWflC9BSLK8pRs+Ex308RQe+Gpt8Lk8L7yrdZ/tWo7gSkgPd+VB?=
 =?us-ascii?Q?XiQOr8/gHxmqTtGc4f8jPSZoiGTPL7lpKq7S7aolqrmttbDCSxt0tawLiOza?=
 =?us-ascii?Q?QFARHRlqoqvM6PMeB+d/0rMSDCHAVIjaFeM6VyT29Zr7/0wUoJbt5TqJYlFQ?=
 =?us-ascii?Q?w4v4mQNSRt4LLDVd2HsIjWnHXi781kWX+WmYJcD/SZnUHEIRRzeztzcAT7GP?=
 =?us-ascii?Q?9elyLmlAPiQcBeMsKxNKKDolkzgzs3W2qWdJBpNrLAUrnI5cnRr9KPUmgxJG?=
 =?us-ascii?Q?hAAYT9OEYCGV8tcXgdZ82Dw0zOeFXv7/XDl8Ae7KcPxoh63bOk5RU+kQ0Cdw?=
 =?us-ascii?Q?3+irsCLEU+HFTJ5P5HqvZs9kK5tPGLtdSao0RSfjGTm1N18iKjCa0mDnC4WB?=
 =?us-ascii?Q?e5CdoIVjGGqqvKeCVmwHU4AZo7fsT7NIdWeFVs1Eprn9KSDg67A2+OPSGR2V?=
 =?us-ascii?Q?l27AM5kTAiQsFPcOBxdQS1LnVx+VWwW6QiQT0nbA9/mx0v137CqK9fRsuKGN?=
 =?us-ascii?Q?O1wuuH2JdZg5AARMNqN4WCCF2B6xlL74MqGeMbi+vszqEkyiGbst7MQDV5+t?=
 =?us-ascii?Q?TOhAIESyEc+S3Y/njd37pvm6oIYH6djR5jowQShuJrfOUFEkheeg0rft0/Om?=
 =?us-ascii?Q?+btC7/k2U0gu/8E+6JKXCdl6umjW3v3F5icdK21veYYUPQqgbMD5kBrTA4HJ?=
 =?us-ascii?Q?hNB71LgNrj3ATRy67zek48bE8FEs4ZbRS1iZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:42.3265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976fefdf-a52e-414d-0186-08ddfa728b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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
2.51.0

