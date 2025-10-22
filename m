Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F54CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E59F10E6D9;
	Wed, 22 Oct 2025 07:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBuSn2b+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028CD10E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc6zHnMwpeuH0ZjQS9OBp4A1hSIDJT9c84igSDQJWBV4a2F63GBqHvd8DsNhIwlr7Uf329TAc2tMJOeCvsaRqnOjDZUmhEsoy3waOsrOAato+Cc14XWApdHyYkKAUJDDlMpRAhWIT2lAhkbOwREfiHIiyCDLYAw4HxCwtv0LyG1kUAbwQX/OJTvmHPS/WTyNsrA1jyodgsp09XPZPu2Sj1btUYM6IvIG9MzGgM8mmDdjrvl41GBWeJ2Z4vqRpbAsbPa522+Sl0ibDNONmFrRQu+FLGGfQHU3me38rgkZbkS6r7+oqxMvYvx7gtsLaJzEpbbWEWgIxe7+bqWn2Ksv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DudMBEWf2LWYmp8mU5muspHvMestm28SrnmaMRTJt2E=;
 b=OWnkU5EymSuiTWRJZLZSCtLcWhFCheF6hZSx9fQA79B8OfmmSQf29N/9amKDPDllhIzZHK2Ulh6UyYbqwI8POyuHIaJ2y27U32a+HJCgLVh8J+oVn15nctlAAyGofsLaPvzE3f5M+7vYkQKeYhxVR65s39A1vYEbLLevfVtbCLTGzZGf1uac2EXqJevEwB8UJfVm3ORXyMTII9cbf2Ls/AS+rEohXrbZmq2bv9UOVZCtxlUWiQ+siZ2PfKaUTLITwknzoh88+uAfhSCfdbZWbKq2dtIxLiAx6ua8TgXzaVtrlfwIJJGWHG1oP7IVsnLFAs9KaTcerzl+Sk7CslZgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DudMBEWf2LWYmp8mU5muspHvMestm28SrnmaMRTJt2E=;
 b=oBuSn2b+PrCdCtZMiS0Z1Uv3q0+2t3lyGfqSPFLRBiO5lBQtqQ8pbOtvsjmPhywcUHJTVoTNxMquv9O0wQgCCSu8KuifBro9of0YbakEPqahvvP3kjxiGdClyUuMrreR3zCQ40jYflyYM4CD0OKRyKO9bI8SlFcFNWqMrHLfocE=
Received: from BY5PR17CA0010.namprd17.prod.outlook.com (2603:10b6:a03:1b8::23)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 07:31:23 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b5) by BY5PR17CA0010.outlook.office365.com
 (2603:10b6:a03:1b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:22 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:21 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 08/18] amdkfd: identify a secondary kfd process by its id
Date: Wed, 22 Oct 2025 15:30:33 +0800
Message-ID: <20251022073043.13009-9-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f81501e-ff35-4f6c-3fe0-08de113d0069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?POB3YCHofArwn+FoyxjjI8AfrUhOblTVhLXtHZmdPK806JCPmwaCUe7kM0r3?=
 =?us-ascii?Q?OdplLvft9N7fv1iyGrYYaQe3FWYFrhv98OcpmoLE2uKJrcUB8TyJW86YosWw?=
 =?us-ascii?Q?0S5ct4XHgOh/azcCYDj5w1zM9eXk3eJqbvTj0Nxs1X9+TXCUpj6lc1b56C/p?=
 =?us-ascii?Q?uzyetPV1VZn+x4TJNsozfy2gEtA5xiRpbUpmLsjHozjFR9373gOlAuUuyk9g?=
 =?us-ascii?Q?mfKFsMvtXPNy+Flj6ENwuV3LorTuz7qSHIIetXNNmuKKLRYOE28CPk5y+KqY?=
 =?us-ascii?Q?N/fIzNuk/nSQqW2haT7aSHIm3wH/yVjxsQjFJS4yEp4c9GoaRwN3l4ohQ/Rb?=
 =?us-ascii?Q?9iFFj75m+oyoErc8qzQxuU/9HJk/AQ2P94eH0RcvCcBK4PInYL6FhnmUOxY6?=
 =?us-ascii?Q?LoOjvJKYJ1nBoGfOj4+McJEcLmNnT59ybNY1xtBhmpcvx9jInmoiYW1p2daj?=
 =?us-ascii?Q?wmPFbn6XaS4vB3Xw/1hMKQzzo2J5tty/iQ3p0jfvln98sZecu9d2fIzgz8l6?=
 =?us-ascii?Q?8HKN6At/EX/7az5A/zrtWSIbIWtbm3lIAfB2R+zyrlHRfvIp0huKhbjbmIcF?=
 =?us-ascii?Q?VdzS5Ayko9fFw5mmnnPN2uLUiJLO1rHXYP0bEB92CzoVqVWUzHcTORpPS/Mb?=
 =?us-ascii?Q?hMmpQobaXyd7oNx7cCfrNJwe4pQXht4gdEMbdfE+oTJTbgwR5Yc0kYVHqDpF?=
 =?us-ascii?Q?zaad0Ws80RItayzV2Nt9ADaU+lwzWY9fuihjcYCgcFXqfOZl6awT1aKKdc27?=
 =?us-ascii?Q?KQvmjC3HmWYaqzwfqIs3lc80s0phktiUQnZc6LRcFcfUA7UxPnn56cGTuYeO?=
 =?us-ascii?Q?jn9UpTb/UYCg1hp9KPwSvf7+hM8/hkD8Euwc+bmY+WOJIBzRNnZLbcgbV8dX?=
 =?us-ascii?Q?3pZP9ieQ63/sTjIy4ZZunOdgMoFRbWLFhglwA8uqwkl4Yf/0XVmEwGgVg16t?=
 =?us-ascii?Q?F9Ce5fv2qpHIKTh9uVygVhGBIYhD/fSd3v09ML6Y1kxMHkyhjlsHNVw/P5Fe?=
 =?us-ascii?Q?9z9DQz3CLBMIKxUyqyCxgEvDIY6ITstLk+C93MkR6n7kUhCN/ZLzh6OQFI/I?=
 =?us-ascii?Q?UH5TBGDnkGWiDhujVUg2nYy9eqW3S7mCtjybtVVgRukZJCm6MC2v+pCv0TId?=
 =?us-ascii?Q?z+SMPDmMHu/gVl8R8zJTrrncUTDjs614OOLlaemEt9F+8c4dltBJ2RQrUCai?=
 =?us-ascii?Q?lqbJ9J7qBZZS5NsT2XLVmsSglW0p62IV01ilBqtk+/qLr+6f8zNOU4eeww3L?=
 =?us-ascii?Q?tq/i9VefP7O+iRjvSetEjvAx9+bQ8gLUE5p7mwADSwsGfcA7G/alBY36RpJ5?=
 =?us-ascii?Q?dFwUxVkb+q9GxtkZpxFZSS84upjvpjT3eQkhugQS+ftjDpPRXf58qClnZM7U?=
 =?us-ascii?Q?sGKIDYF/cMhdPM0UGBuo4XMiVDZ5FJFJHzb4imzL2y3Fr5QVy9BJAT7+alYG?=
 =?us-ascii?Q?LKWWg2oPEDSS5aMNHSoGutREl/S+xXgpChD7aYcGZv6U1oHGJcPqsqGaPoND?=
 =?us-ascii?Q?E/dAi6l5bC41PxRtGdGzBT19vsTH2pRoBXpnZrpAgysQVnsnGzHOhKblDIRF?=
 =?us-ascii?Q?7Af8eRETcAJDrOz0tj0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:22.9424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f81501e-ff35-4f6c-3fe0-08de113d0069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 919510f18249..30b0b45bcc8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1021,10 +1021,15 @@ struct kfd_process {
 
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
 
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 995d27be06e3..f1e8ce61290b 100644
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
+	      KFD_CONTEXT_ID_PRIMARY - 1, GFP_KERNEL);
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

