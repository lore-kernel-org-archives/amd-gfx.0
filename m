Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FA7CCD1A4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB1E10EB6A;
	Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4IhK99fq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E2310EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCz3m/IGO4/zyLjLLf21vZ3vHMuD58CfRevWRkG6Au4KouUxUtPNU+yrpgeYcZPF1JFwdnYvF5A6jBIRmhKE9NTir6tixHcXic8tBmZ2urU6yO0D7ahVlB+4T9k0WcrxMI0zaPhI76jtD8NobQJ2/i7XJBhzdjhrvtqbjvWqqbHoZ3mVq5TftUQcFcno+64ofST8XbC1lHYXJaeeTF2XSMYRgrqcJkVR7mWaXYEz8fMvPFd9nlSGsMtsMW8Q3u3eVBffpCh60cLXvziqWLYEqa8Mz2IdhWc0DuSjzREx0eaTiLdNOQMOD5GporF2TZe0V8ctvVQo2JKzrfPvuZZA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTy0CdCK+jCdKoRLdWRuJAsP36NsTkdiuTD/eqQ5LOw=;
 b=D2pZ10NohviW71oOT+2rzJBg03SL36CiiaZBrFjAdCP/uzBc4DgdtCTROqRbLZAZ7MzKrD6jRu10Eo8P45cax8iPS6d8JaSlp7fru3zE1ASCgOmCrJuyE+LxNtWIRFi4Cd+/5lOy+sMBx8CC+0ZmyNOE1nyERSvruWDfGyS74e6CIB9DJIQvMMITaw/iYCcst6BSkrm1rTs2esiUm3kW3qF2qaMtyUsKKk0jgNRVBZKlIO13ju5A5zjCy6RraAtS67ihlpEIU/kR2TxEQjIlDaSwDjBguRSQB0SoWmNtM9eASQNwXPCzR1VhGESMwTrcBL5fxZoYW2QqkcBfZKTy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTy0CdCK+jCdKoRLdWRuJAsP36NsTkdiuTD/eqQ5LOw=;
 b=4IhK99fqINw3IQ5dcfqCCnl50+864k8AAaLh/HqP/Xouy+BtuUff4hD5C0lOmYAJ33l/HDKdPHMymzTdLf5UzGULo1OogVh3unay5Jaubzdd6+GYcAYwPGuztQl3CDtyom5D/g+l+/9soqteWw9TPWltblP4PIT0Bi2T5xZEkbw=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:43:23 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::ae) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:23 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:19 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 08/18] amdkfd: identify a secondary kfd process by its id
Date: Fri, 17 Oct 2025 16:42:12 +0800
Message-ID: <20251017084222.54721-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fe62b2-fa1e-405b-b2ea-08de0d593b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7aT5KQ9zE7lLHAiP0PzGI3Mi4+ryTI1TgtGIc/ew8setnCIzm5UrzaG7W5lq?=
 =?us-ascii?Q?e1eEFh9dVNPDNZN4xmYzD4Eym6+6Q5Gemb9aN2mbsIXqIe+DynDv2AgQEyDb?=
 =?us-ascii?Q?103HeAO1wclMV2xr6Adfnzhsc4LZePQCJ8SQqYpYHJYTj/itmfa5qbAsRAKu?=
 =?us-ascii?Q?4EMI/BCwzem32PSfoYNnbh71TdxLTvGRObuuQRs+BHTNomAKlVCXavB0hRqQ?=
 =?us-ascii?Q?i1n5ATVRa+UbKece9pozQWCjGPG10Phjr187/sRr38lNbJoG3fhcCAscfZLA?=
 =?us-ascii?Q?2xDM+ZEXyWxMqerIh1hauK42Km5luzolm8drXUZ4jGhtgNCEgQ8uexCYxYMt?=
 =?us-ascii?Q?W2Bmw4a0zGjBs/24GgANQal4XDwsmw1J6fIPghrffrc9lib6IvU0oMWcjVvs?=
 =?us-ascii?Q?xdVvdy6UyMmqF1K1ejoLKBWSl9b2ctVk0O/8octowhoLLISmdpvURliMjeLQ?=
 =?us-ascii?Q?Z0QVSNuZtndoUQAM6sVhNopdWSzD0kTOsbaa4wrYqFuy1RrN6SWTbv9NdlvW?=
 =?us-ascii?Q?ZfT3LnLWjRFXU2HCNunBI9OdfLh/1dM+I0ttI+cSUw2X0jX3IT766Hh48XtR?=
 =?us-ascii?Q?O1xlhAfYfYmFT40S6ABj1mQSC9e05aAruQks8QqU8gARFrF7QP+YIFhIV1Y1?=
 =?us-ascii?Q?mnAc7oGHA5G1T2PgCuxqwUI2b9CVGcUhsEj3zeJhip9m/xWT9x8WrkKIH5tV?=
 =?us-ascii?Q?RcNbUp1D0wdmKZy34SYBzrGe2G3Lm59ZOOWFx1h1Q2gkcmfD8pI8nry5jSuL?=
 =?us-ascii?Q?+3axfGjoLwoK67PdhOVqzoxq/f/QPnOExJ02Zmm1OAQgn36s4VGnxkAVgUFT?=
 =?us-ascii?Q?cxP3oyfBLaH1+/U4vMlzu88Pxu9ndFSRc+i8n0biKbFFuVP0XzDok3bprYes?=
 =?us-ascii?Q?PiWKAjAPZ7oYtqiM767SDxub02CxvG76/FGDQiHcUV0k4WBhc4Pm7NVZzSAl?=
 =?us-ascii?Q?Qig16XmxzycafweowVjUis0FaiJ/V5Pi58BihZj87SI+ilaR6Nq7G2MMB0tP?=
 =?us-ascii?Q?4jql2pLML92VVEdw7DtJIAMcXWeFpQhcrPxlhAupGwS/nsX0l4KgRQ/gpdfT?=
 =?us-ascii?Q?qPxQ9t5RiLUDktbYnZwaMTdjoTCeSZtlvCwOAX8sTSub65xKrvp3xI9txNSU?=
 =?us-ascii?Q?I2rjq3DD4fMZ02Kk3GGMXtcJ7/3elxCQZnFwNx+7UghNTIvymFqzF1NQmJW2?=
 =?us-ascii?Q?+VAiWhdIwByTrtnCkkUFtitCc4C+GLyb93YOXmXUkEIOqSONtD0errpOgx7W?=
 =?us-ascii?Q?Vu3NHsNpZ+yyRk4wAyXDjBeHqUUabKikn2chHigpfy254RG5fdgdfTVWEszn?=
 =?us-ascii?Q?uOWVS1wtQO9g4O2tnyXiVez3hEaP0vESu3LdLj4+REnSH8EwTbFt1rTnoiNR?=
 =?us-ascii?Q?C6C4EPlvw3N0gv3il/ifUtoj8AOQxhiygFHdD/5qfog6hUAwyKf57zVlzjNU?=
 =?us-ascii?Q?q24zElD9AANqbbK3XW9oP+2kYXR/tk5Huex5H8wqmqrL8cvByeyhqO8/83Tc?=
 =?us-ascii?Q?oOiKYNxOGwUFF+o7xEpZ5JHXPuneM66CFr3AGBA2Pu7McVLfWdiJcOU9W1jJ?=
 =?us-ascii?Q?aqpvy4XhMK+ggT30NtI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:23.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe62b2-fa1e-405b-b2ea-08de0d593b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

This commit introduces a new id field for
struct kfd process, which helps identify
a kfd process among multiple contexts that
all belong to a single user space program.

The sysfs entry of a secondary kfd process
is placed under the sysfs entry folder of
its primary kfd process.

The naming format of the sysfs entry of a secondary
kfd process is "context_%u" where %u is the process id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 919510f18249..9de658119cd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1021,10 +1021,16 @@ struct kfd_process {
 
 	/*kfd context id */
 	u16 context_id;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
+
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
+#define KFD_CONTEXT_ID_MIN 0
+#define KFD_CONTEXT_ID_WIDTH 16
 
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 995d27be06e3..157145c94314 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -827,6 +827,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process->kobj) {
@@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn("Creating procfs kobject failed");
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process->kobj, &procfs_type,
-				   procfs.kobj, "%d",
-				   (int)process->lead_thread->pid);
+
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   procfs.kobj, "%d",
+					   (int)process->lead_thread->pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+		if (!primary_process)
+			return -ESRCH;
+
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   primary_process->kobj, "context_%u",
+					   process->context_id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
@@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	int ret;
+	struct kfd_process *primary_process;
+
+	/* already assign 0xFFFF when create */
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
+		return 0;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return -ESRCH;
+
+	/* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
+	ret = ida_alloc_range(&primary_process->id_table, KFD_CONTEXT_ID_MIN,
+	     (1 << KFD_CONTEXT_ID_WIDTH) - 2, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	process->context_id = ret;
+	ret = 0;
+
+out:
+	kfd_unref_process(primary_process);
+
+	return ret;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&primary_process->id_table, process->context_id);
+
+	kfd_unref_process(primary_process);
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&p->id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1601,6 +1664,13 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
+		ida_init(&process->id_table);
+	}
+
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err("Creating kfd process: failed to alloc an id\n");
+		goto err_alloc_id;
 	}
 
 	kfd_unref_process(process);
@@ -1610,6 +1680,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 
 	return process;
 
+err_alloc_id:
+	kfd_process_free_id(process);
 err_register_notifier:
 	hash_del_rcu(&process->kfd_processes);
 	svm_range_list_fini(process);
-- 
2.51.0

