Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041BFC83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E4010E410;
	Fri, 25 Jul 2025 02:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5n1C56Xu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9604310E410
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoLVa2qtc3BlTKNJQpSPVcI76pjMV1kSzlChMbk3Ba3UWGTDhIfk/pmizA7VS9usLCS1lk88GGiAKYRsQJAlB3vOq/o0KTjEA4oWoF9LK1B3w5kWr0Fyg6y8r2pa4jJNaXGEU0971V1c2jgyaognQFRO+z33DhRcQOHs3gYvjkmdU3SRZvhhG+MPDJfylbrE07N44+xAX7aJpBE9Rm7S5MirQF+SJ+Gub4oprbQaQQ828V422u9mkSfB0MbRfNoSEIjqdNGY+syCa90gMSoaoW5A0/jyMMghggYIrLFrhmV66o3d2nLYpfQNpftLbMbwe+XlZIoRoy+a1L0NEhRL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w0VldiW14XTKd9HhH7O8qMW2d3MjkFRTH1sZsBRw84=;
 b=kMUzSvBE+Mnf2T1jh5KBSGYYFerZdD+ZRRiKRv225mtxqcRmQhTBXDX2rth+sPbEAHTNmfng54r8CmgCN4jco/GQNdHnOI5OizUPbOgJstwNZSiwTOa7FAXPIdexb3THaxIWUqGVBy6Yq8LtICn5cyiHsL6rpiR74xC7d2aMsRZcFMYWpul71mkmbPuMrLiQ9vodcSMQq8bRVfsxhS971AM1h0dfaKNUJSSH1Ijllt4QJCFsZrjzaH6MiLk+1CA5HHWpr1KGh309g+xOT2+KcoWqM8/bO+jRDsDtipy9MhopfYmmA9G3mAPsIgL8GbIJCenfMNrt8iefUN1MnMSzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w0VldiW14XTKd9HhH7O8qMW2d3MjkFRTH1sZsBRw84=;
 b=5n1C56XuI0KiIoR1dx1Bcext5TM8SRvD8IhlrlDnYnRelh8EVWQtyCg/tqTy8XI0bEdSGYTeEEnctzx9l25UiLlOcQx/8kmCZgYGi2fRaE1f/1N8yOE/8eg+5BQGCHSsUOrvZpzI9UHCI0mBpjigLbYPZzNPe7xJ0frmQTnap8E=
Received: from CH0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:610:e7::31)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 02:43:47 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::18) by CH0PR03CA0236.outlook.office365.com
 (2603:10b6:610:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:47 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:45 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 9/9] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Fri, 25 Jul 2025 10:43:16 +0800
Message-ID: <20250725024316.9273-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e35a753-2b6e-4b02-889e-08ddcb251494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3vuZOcE95Lx6Jyby/ukhW4P/ADAXZUMAdLdB3l8FArmj1FlKD6FgujgDNlcN?=
 =?us-ascii?Q?y9eYA6Ybig9ATf1O8WOMO1kStJ8rn/gYQvXDyqCEHAq/V04s+9M4EhIZ+qIz?=
 =?us-ascii?Q?RxwMV0m0kFPOY4GkJ/UvCspdP7TbiqLg2brYbIhpbIwrv9k9p1yOozDvcrU6?=
 =?us-ascii?Q?UCJm1gOl5iHnVCvFzaSQ4G+vrKXjYzOxOfArun+hVvLF5bPWFq+UZeTMCM5F?=
 =?us-ascii?Q?yLUa0ZE8Npegjn9qPxA1E2VD/kvPlDp+koomUryUNjqXmvqzonQdQwc3YDKl?=
 =?us-ascii?Q?9r8ZggLtDKa4VFpnPxokldeA+9cpHcvIE8pERLFsfRju2huIrokwxFKB+La6?=
 =?us-ascii?Q?vpJp/FvOFme2/KKXSoS0Ye34TjGjqjs+kjQ80umx+MwNBuiVqFsFC8E/j8Dx?=
 =?us-ascii?Q?3KcjJ5mnobEKU/c9li6LAH+jUOfSQBrlIHiUsaBbHwvtu6FLDTpLY6WBgAre?=
 =?us-ascii?Q?bbaieJyW6Xg9CjTVVynglsNBSre01KCN0da3kOds47X2AlMs8zs+Ho1LGHZs?=
 =?us-ascii?Q?UXl60LB7NYJksMYTcA3M3Nv/bohNuQ9uNWbxns9GprpFDOOel0ROSovbapA7?=
 =?us-ascii?Q?PuWTYAWH0QkhQw9yb26pE2oyC73IV3ZPT+FGTCZ9W6IBap3Q0zJv20b/8DZn?=
 =?us-ascii?Q?nB0KvVBFBIjhk7czSAd+mzuBLf9lhTzanj243eqwnVviKT4EpF6T8SkOpgsM?=
 =?us-ascii?Q?wCwtAW/5EhP4OzWtHJSGBRVZOum0uDkQ/4Qyx5z7psknoQW+tdWJaB22PWsv?=
 =?us-ascii?Q?i/46UGQBzy0RihuktUF9GLtAQPXhpwsaA/fTjWKzfJQyF39Wq1wsK5X40C+n?=
 =?us-ascii?Q?GZNYRP6VfVdLogRfiNAsH09Rb5iT4ow7zW3lQ3XtfUaLLJUG9YTVrOPBdKLI?=
 =?us-ascii?Q?kbGMQ7guALr22FhCyzFM8JUP8hYem8ikQ9iOlhWplC0ozZqOA+2rNV8PvdB1?=
 =?us-ascii?Q?rnOO5Jbv1v2tR1kO61Gl35XebaN8WHaXxb81lQurBRV4ybxVkK7S9loCitXL?=
 =?us-ascii?Q?6gpBvYaaxNlcnSTkl0aEkWEDBF9JqRelzVDi9Skb7AI2U+eIoXpoFDPc/0mj?=
 =?us-ascii?Q?PqZVapvlwY/tT8cmk+7JqqjBMGlp+u1qx3YwqNc3heR5uDzKGAhlffvghK8N?=
 =?us-ascii?Q?t8XTfpIa5ATXNttWTmnp8Xk2OvyIfSlDEbmdLgu2DD5vR7FAEJ4nIIE2gQc8?=
 =?us-ascii?Q?TLE2a0IoNdu1o1y48NuAdTDRGwnxFmbOdoYaVCby4tcMoHLGQEeF+FBynv7q?=
 =?us-ascii?Q?7NlyhLClhD4ywWX7A/dFSxkM/HsejwZI9MkjqvWQkh8K3SrwWa9yKY18PUzM?=
 =?us-ascii?Q?4KTAp26YCjrrQIc856wAVclcht/Nny1v9m3+kJpx7DCtemtmeWolN3Uba4+8?=
 =?us-ascii?Q?wLuuCY/+88ycPh5dBE+vNNolm20Lny20qAx9AQCSuPVWoZaX1Vc5BMfVr4e0?=
 =?us-ascii?Q?My/KUrHiLOSrT2cy0m5UxjWF54vIEc6c95G38OKrf1QITlCpdFcbiRYnF0ji?=
 =?us-ascii?Q?lUMG4dLjNpimYkUbKlUkPQVkaym37D+cy5Om?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:47.5429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35a753-2b6e-4b02-889e-08ddcb251494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
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

This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
that creates a new secondary kfd_progress on the FD.

To keep backward compatibility, userspace programs need to invoke
this ioctl explicitly on a FD to create a secondary
kfd_process which replacing its primary kfd_process.

This commit bumps ioctl minor version.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  8 +++--
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5b22e1c47b2e..f9c43ff8a89f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3136,6 +3136,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	return r;
 }
 
+/* userspace programs need to invoke this ioctl explicitly on a FD to
+ * create a secondary kfd_process which replacing its primary kfd_process
+ */
+static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, void *data)
+{
+	struct kfd_process *process;
+	int ret;
+
+	if (!filep->private_data || !p)
+		return -EINVAL;
+
+	if (p != filep->private_data)
+		return -EINVAL;
+
+	/* Each FD owns only one kfd_process */
+	if (!p->primary)
+		return -EINVAL;
+
+	mutex_lock(&kfd_processes_mutex);
+	process = create_process(current, false);
+	mutex_unlock(&kfd_processes_mutex);
+
+	if (IS_ERR(process))
+		return PTR_ERR(process);
+
+	/* Each open() increases kref of the primary kfd_process,
+	 * so we need to reduce it here before we create a new secondary process replacing it
+	 */
+	kfd_unref_process(p);
+
+	filep->private_data = process;
+	ret = kfd_create_process_sysfs(process);
+	if (ret)
+		pr_warn("Failed to create sysfs entry for the kfd_process");
+
+	return 0;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -3254,6 +3292,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6e12c705734..a2b5081fbfc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1051,6 +1051,7 @@ struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e1ba9015bb83..15a8de2275f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -71,7 +71,6 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -1598,7 +1597,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
+struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 04c7d283dc7d..1d206ecc831e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -44,9 +44,10 @@
  * - 1.16 - Add contiguous VRAM allocation flag
  * - 1.17 - Add SDMA queue creation with target SDMA engine ID
  * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
+ * - 1.19 - Add a new ioctl to craete secondary kfd processes
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 18
+#define KFD_IOCTL_MINOR_VERSION 19
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
 #define AMDKFD_IOC_DBG_TRAP			\
 		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
 
+#define AMDKFD_IOC_CREATE_PROCESS		\
+		AMDKFD_IO(0x27)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x27
+#define AMDKFD_COMMAND_END		0x28
 
 #endif
-- 
2.47.1

