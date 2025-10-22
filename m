Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F8BCCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736DA10E6D6;
	Wed, 22 Oct 2025 07:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDbn7KYz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F126310E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlIDRSSaGkNTVXla2gLT8c9s8V6tL4EKwLmQpQRWkdi5zC3xTDtyv1TM22o00nKmIi6I1S031AF/ZQrRWIiMDNGh/j5O6PHlkHsrVxbaP2YGXrfbAQsqaWA4u1ReQrZzaZFA0Y2sewEr6q/vus7R7DcRBfyuCh0tzdiXMJqXOC63sr7QKn7/0DDZHgfvTmz1A2DTQkEUhsLGeVoltgxC1akv4BFqTKadodZvGfGkJW1e6CrY9lf7bTbtApkyz4UJArPE4xTmRcd0P9l3ND2SsU8qB7iSAyqbJiqMOdQ6PWPFu1xca82FoBCeq97GHf4gbdUOU6p1HXU1xU+S57eJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=U7oZnd54q/lTtlVUEZsNLQJsdZUULHnHmkhw5kFTJz0zuhX7M83jxBNkACUyJzMu3dHSPg8RGf7TmfEiyE95JJ8w+CFmC+K5BJ5D6QtKccFg0TDCMrCFpJqMqM8q2wPILMZKvOaAD8Cof7Cot0y3iZ/hFAzFBELhQfE8WiUDmyA22gMsfrpI/z8BUeSdx5Q5xnKpXPfjp3gjToonYfkFigaU3ezIqtqs0ac/CtsIXqJ8TbPUaSV9dFIrt99HxnEmpi4zsVEePrgdwlFRPNKu5La2j9UZsF7TqFZIs2/zURW6iHpnpjdEBzrpRDTfHHWbqGkel37bhAcYgmpEjLydcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=UDbn7KYzdTl+XkJCtNhyZah9IGiyTUIPYJZcPxgTV0rbjUCG7mGkoaBRTYSfT2VjS1ErOZCSg1Ci0xyiYQKUFkBujcO1gRBOb8ez3TWpe1jp7XOT7R1kkrIRrFeD9E+eyMcLxsdLsFBe1FCxq9YBobo5dkGAKB0hRxHxWaPS1mk=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:16 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::53) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:15 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:13 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 04/18] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Wed, 22 Oct 2025 15:30:29 +0800
Message-ID: <20251022073043.13009-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ca1da4-5b90-4c75-238c-08de113cfbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHkC8DRGGLC8vGmhEZV14mDhwBXpsd2Pp9iutqpTAVOZevTiL5/T21Wq8VM/?=
 =?us-ascii?Q?6HcmYK35IMtJz9A1pbh//WbTNmVT5fd7nZ5XWJtw598UyuaOtJDwwFpwWcOE?=
 =?us-ascii?Q?2gZXnps9MVHjr1ynZNTqtPl4QZ71aiH/WY7CndgGsi5SOCYgTXKpMDUPPPV2?=
 =?us-ascii?Q?KUrC1OJrUIf8eIXn8lLzmEFJ1xrfVCm6JNz+zw17bFZ77YKsqyykz4vr10rb?=
 =?us-ascii?Q?ZC/zktTWaJSPjjlmz9SttKDHYfQ1HzT5D+/JVaMfdcwOXhjTA9AFL1q5egrg?=
 =?us-ascii?Q?dEgmwFwSgLB2p0g66BW7aUeSOkjnPXAHoBK1hjF89NYBgK7iTJRygUKzgngi?=
 =?us-ascii?Q?Tp3IcLYvbV3AqWhDjCrzjZHJZgEIWo8xwbIOJSeRSZ9+soVy9BLFytPQVmMf?=
 =?us-ascii?Q?IAO6JAmyYXrajZnF05pA8Ud6yfV0OCXTpCwYItTCHt4ZeqQwd7B8lahaj4FH?=
 =?us-ascii?Q?fpkVfeckSxoMWV3R5qBs6p+j+REqnMplwDl939JZ2uTdS5cTwvJsRyeIiEGw?=
 =?us-ascii?Q?R32cwr7y3EiC8dAFN8//H+vAd2Vgt0nmtXrCpeBO/4uuIw1+nLtFAChDND6z?=
 =?us-ascii?Q?+aL14ItbFZ7wUtneZZWhAQPXEuQmvoxMuDOFJMwTIQDAxAEEurGqhn6YeqpC?=
 =?us-ascii?Q?ioCcPdBzpfgIQCx8MZGpZMVyLEjqGNOcvdOFDttAkCF5g1NC7yD0LdGM+fWK?=
 =?us-ascii?Q?BN8ky0+ZNWgy1bJJZhaBGGN1Xo80dP7AjJ35E9x4jAn52FGfAsDiJhI/cLyJ?=
 =?us-ascii?Q?66btyvsPBoNwj0VHhHOegPsWND8CZSMEF+tkzKj89RXUV1acy8D/5g9xPYmG?=
 =?us-ascii?Q?b4Z8bpe5euG6mGjNulHTCFCpTS8rGZt0yvRheJhJcMpz2Dvyji0+qo/ecjR8?=
 =?us-ascii?Q?3zKc0HUW3306/XmwzUJkrvTh/QEonmpvGuyhxsbHQGNtckzz9BXopmGjpMib?=
 =?us-ascii?Q?cqBxCyP4qLGshrKbhRBIHIxnbD7isoBA3m2DeD1gp/IguboYS69sDgidt3QA?=
 =?us-ascii?Q?4H632GhDdwquRK934oAXG+GhLoEvsVu2x+TYNaixHan0zUrraexsnaXoZ5yl?=
 =?us-ascii?Q?JJvBVENtsbCqYbhdBpEVT8tiXofqg45WDGUNVWHn52GjiCNeYv9XeSzliL/E?=
 =?us-ascii?Q?aWcr5evUYUCoeF8yVippFaebUmNiR0GeF2G4VPe0eUmqO7gdBS1xNaz+K5OM?=
 =?us-ascii?Q?Hakh2aGrucO2iXzw86CB2xOkM0GqaxgRi6+SLJER7jRe4tq7Z05FhV9i2/E+?=
 =?us-ascii?Q?V6j33IL4zP99jU6QPU7TJXmH2R6Zcrpl8Gak5NnxGt3JL7wQwFOVh6hwEWnt?=
 =?us-ascii?Q?YGStPk6bOaTF/O34g2CRsMYL95YPRKBYZcexNaGb8T+Rw7MY3ev705Tdxck8?=
 =?us-ascii?Q?SM0QcSCHBFKqV77UDaoUy9bO4cAJOofRCpDYD8DywOCzKYIupCdQ5zry1ddy?=
 =?us-ascii?Q?KqBBN+KNat+bWrsB7P4Gj4CUnmzO1RSkdrpIv4RWnvLSTU4N2hVrc0IOrEKW?=
 =?us-ascii?Q?kdHb0WTGoDLrpPJt/DjmdwXBOsoRxdoemg2gI/MZuuft7TJ7yIZsYBxq9vUv?=
 =?us-ascii?Q?P0hThERFoeLMMcC4YsY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:15.1215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca1da4-5b90-4c75-238c-08de113cfbc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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
index 729330f8a384..cfedc0c5892c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1054,6 +1054,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
+int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 051000e79e95..83fe571b801c 100644
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

