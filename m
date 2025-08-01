Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D2C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A8F10E802;
	Fri,  1 Aug 2025 08:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OnA6eUut";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABD410E808
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSgrCZqsZioW0I6o3TC9Eu1IO4SLWK9JEs9WfaUttvMjn5CkfBOZeWsxxVuvjYTVuV1dfppQWtBNue+5Z4sduV8l2u3tISpnvIUORjhV1YNNUgt8BaQoNUP5i2VUS8xiiO25GTSwJbbug5hLbdV6uvHRRAaysWdmzIn+qlZdKNTe/tJvvqnEr0qEbUEXfWLo97CenK5WTqF9zJ2U7U0yssgGusReLmaEFTWDkHUtLFwDVVqUl/WcmQBD2yXrLT85aLw0Lnw4DFRLRQVxD0zxhYzVfFWnKPwkrthGIYaB+52Hebzx1VHpg1MNVnMa1kgoyqF63nICyzn4//6tN6MsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Muvgxfg2Z/apYzkLvtyf7ZZGi70MDMCk3d0igqiBMuU=;
 b=WM04osgYDO1Sx2GSmoFlOqihbqfOEyF69ROkm8tjI0QmQFlTuSRKkXmeZFU86jo06n+keZn1fGEPRhFUv5VauOnllFFm62c0mJZuamMkiPQNf6zByM0DD/JpNeRnLJr9nWLTMhWnGIXaNbJccAtSbs8K/vHinNw08yEwxINsEEoqktlnhxCBSENI59F8RZWxnA6KAAletlhxlcdVZbox6tbZYtGwHs/Menz6lRsQyOeL/UIpH/qcL3TR3OU9/OqwFNZOQEOCmXoQ1U5ujx5+p8rkcZLSZrsb+a7BrLUwh1LAgRzLXElUEK4Rpa1l7HfKxgeX2hubnMyWQB8o7sHHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Muvgxfg2Z/apYzkLvtyf7ZZGi70MDMCk3d0igqiBMuU=;
 b=OnA6eUutbjKsTjWYbiprXT29SRVIljiRuglBMcWYonDexK7qWsq92YPiwFGctk5OBHg+pEMrAvg7GCa3UphOq7whtOQ4DGxCydMIp1BYmlbEoQIjORafeZAh9kI6ugybi3L6REjje5nz8ZVWyKfnn1Eq8Bbujj94aoVJ9zMqqC8=
Received: from BYAPR08CA0050.namprd08.prod.outlook.com (2603:10b6:a03:117::27)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 08:56:38 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::26) by BYAPR08CA0050.outlook.office365.com
 (2603:10b6:a03:117::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 08:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:37 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:35 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 10/10] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Fri, 1 Aug 2025 16:55:56 +0800
Message-ID: <20250801085556.8504-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 825784e2-b2c5-421c-1c7c-08ddd0d95306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LC3WFxNUSK37u4k1asncJ0enhVHe9XBBxzTgd5lcNFR0OEq/gSVbv+oErhyQ?=
 =?us-ascii?Q?leIbw8yAsMb7Wfmv1UJqzAEZ0E6TXTsGMaAhbMXH+Yhtr+nSHhbWT7ya1dUy?=
 =?us-ascii?Q?ktbEg+tZgt1/8b/1qcly7TSsbFvMdlC3R/gESueUy/yhJRknouq6jdISLBtc?=
 =?us-ascii?Q?oCBzRf/4IaOmmL48opOK7bbY5yLDe+tx6axaAVQTMqXrWdbCm5FmdbIn35JO?=
 =?us-ascii?Q?KkLrDOv4WFzz8uy1NnOcBw8erQ+H6ywcD98HmsYjFDOfz/2JpZrw2zLfy9tQ?=
 =?us-ascii?Q?RzxLj+MKyVlGdHR0P/dYyAsF4Mze+nnfEPpfv8jtZC8NX6qUQAk1AEul44iA?=
 =?us-ascii?Q?akLwyaWWWMAkiCpRD5dV5PYOaQb12e1u313SecHxVC2b4KjfqGmVObTBEt4M?=
 =?us-ascii?Q?1sHAlKmYEJ3yD6j4AjMsvlg9KP1fP62Bq7SoQXuXbMW6d/0YihMrfzr8ThIr?=
 =?us-ascii?Q?3zuY8Ei7A8kkJ17yrmoiNe7Jjgvyx9zx0q8fU7RyShs1RCrarjTpazoZ2e25?=
 =?us-ascii?Q?R1cpCcCGkCl4xe7R/1zsV2FxqM1mTsYUQ+MTwba6n0q/avtPcowbmn8mVTgD?=
 =?us-ascii?Q?HQLPg6oJvUzCP0C1FItjfluGu77edwIdKNEASzO61vm7HauokPo2kQfOnkx4?=
 =?us-ascii?Q?NqdssUajR2Gl+IN+k/kEuf6daRykwJnJSMtnzawCfDw9eNZcrDIzTsuqoAU2?=
 =?us-ascii?Q?qzDRUrjaWJuqiVNOgpY1z8QBTI5JxSn9D5JAjpf7TtXV/7eHK2ZBcJUjVA21?=
 =?us-ascii?Q?VwvJx2idwfteuW6B0yWZteCc2QqJ2kJfTiMkj1gnNW4y6Aol14zakzYbq4RJ?=
 =?us-ascii?Q?9DpEIWkaAEKuaR+6SO+x6VI+QduhxJBR0AjD6kF1tUIY8l6Jq7K5Z4tCZdZQ?=
 =?us-ascii?Q?kvvt8jjHYIQobjwoX0A8LkgdKxksUthmF16QBSAYSF1HApIVRUYEJfT0lGm5?=
 =?us-ascii?Q?M1I+hPDJkyUXcxq4WU9BmBjBMUe0mX/+ELdSM5X0jMqOXJGdBsVeGh6SG6If?=
 =?us-ascii?Q?whk9KJxudOjuJm5r8lcG8+KsHJ4AxayZ9xkZ2hLdlyjhCFMG4SRnKVfH/jW9?=
 =?us-ascii?Q?QVKnc+OhymWjmJXpKliUMvSQybm4VIWo74M2po578DKflZqYwlgDtSoAeV3V?=
 =?us-ascii?Q?RQJn1dA0XUSuJfxNC0mrX30lJp67oD77LHE0O0kz7n/wllhQfJkOD6vTEwaU?=
 =?us-ascii?Q?KIzJb4uAQdcBE2yhdzJnBDp2lSIcniRLmQfpDPFuh+L9BnzGLjd7S11jzQBQ?=
 =?us-ascii?Q?hOl++43KJScPL6eTc5ZSYtqU4FB50dQfFXaW9WimVW2abz5YrrZpGtx5TU9o?=
 =?us-ascii?Q?jsQczmmaDzBKX9Wlf5AhkkTQ7F3Uy6ZZRKzXJRLm5C2QICc84/erqgS7yMsF?=
 =?us-ascii?Q?LAM1f+tPDIE8KJErMpY3fMasX3JQ1L/5sKmttsoXuampqXD8fx6sbXHrZT10?=
 =?us-ascii?Q?V+UjVXEJBw62s2wRH1cD5Gnldq3V+RZE41SRqm+h2zqvyO/Zp3uuU50V4C9V?=
 =?us-ascii?Q?cHR/iRLR6KK5VLODvZ8aaPzW01WgJV07RwLo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:37.4514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825784e2-b2c5-421c-1c7c-08ddd0d95306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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
index 9e95acd23889..161875fb56b1 100644
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
index 67ebdaa9995f..2502d20db477 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1050,6 +1050,7 @@ int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2d01356627ef..5c6a2604bea0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -71,7 +71,6 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -1580,7 +1579,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
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

