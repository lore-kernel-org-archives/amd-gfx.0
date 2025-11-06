Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2C1CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D488610E817;
	Thu,  6 Nov 2025 06:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXP96TMT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D420810E816
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttV6wETPP1vjY69DovVzFKCjGERonRu8c6AQp4nFI8nrS1rlrDrWBSAM4LOAy0GBG6xx8/QUVHBWnM1XkOeCzlt+vlCTY2etwSEY/srikhKlaxRZQCDItSrjDWt/dXdcv6umRAdlhMRHnY9VnN97m3hynId+SaqqimctElNoN3wPRap2FJt+y6s5v0HV705eNpkbRgKtdVILPZ7pp/XFKfL95ZIIwwJVfPcjGfI+lShHOQrhU5CPPccI8bosdKnki/XohLcKJcHWkrrKf/+90lSd6Bkf3tOEZfM+qV6GRGCBluQ1BbbW+KY6pn4Zh4h00Vmkx8g1zERf0ujXkWUB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV3nbnghX452vjd5uD8hIz0r9RMF0VdK+18TZPDKLXo=;
 b=gJFnD3mA3a18+VnlFVzw29woPrGLwcabn9tcebRrraXJnNrBJGgyDV4DHHP+I54U+wnEIqBj21S0UKxt+mN36DGqOKbTVvbUHkafbJjlb67v8YZJZQs+VCajzOoiCahJwvlN6rmudcVq0Tr1V0hj4+WjiBaYRxP2AD0u3awyAPy1oOUD2U2frzr4GZmaZZEaH8jJsvtxQx6Q6FLD1fWBDcWarbWdo3rakcvG2FGq5BHP1C+ERX5xKaR7ZYUSg9kiH1KelsqJ/isrcG6/iZhu+P7tgBtOF+KoJZwakp4f35iKSOM0ctses2WyGbe3tIJUqhMqpLr0OHniPWFnH9SnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV3nbnghX452vjd5uD8hIz0r9RMF0VdK+18TZPDKLXo=;
 b=hXP96TMT/DusheDm14vP7K/KNlO9fRByjPPDKDajNJuGZDRKdj0BQCeM0wKo2rthNAnJFZlwvd4XW4rkhAga9vWt7ThSBtBP8EF1T2wgKi8KiJscnuQfdkfYzzh25aD0xJTSegTwvefj/yvdmcVFmQ4m/HRQGI8YpcXpjv1fdc8=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 06:08:37 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::58) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:37 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:35 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 18/18] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Thu, 6 Nov 2025 14:07:39 +0800
Message-ID: <20251106060739.2281-19-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b73e2fc-84a8-4a13-c2d3-08de1cfaecbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TC8rLDvVTTdM4Dk6sz7q+ysM/CPJlh5thxzz2qfEVAF+bdvxMBjGzd0lHBsT?=
 =?us-ascii?Q?AYVYRCkb0NDQzYBThBmq0AIWnp4CCl7EKgHWWSwtuoTuGAT61PTDd+Bs3PkG?=
 =?us-ascii?Q?kwcz2SVJXxPh+lygpk5Hd615acxzUpzyAjYSo0ojViyWSG1qj72b9dBrOtMt?=
 =?us-ascii?Q?6jhFGHicKWQvvjkWpM5csdK/5c+lsnkcZ8GQhE1raWeaiDh6FnKbVOY1+/e8?=
 =?us-ascii?Q?9Q4MqMnsocaVs0Q7XZHurI57OeLgj5Kbd4hWjHCR637t5r3Z9YjXd7nvDoR7?=
 =?us-ascii?Q?1IGqkSisNONyDT0Dv7bSuOXZB/Ns3VnYz5vMv7EusmzCcmSJzeqHRtwV/5FZ?=
 =?us-ascii?Q?Fad6InRWxMYvTEtuXgzF3DgpuUS4fkvJFBJsTHPvtFp2HUtdL1T2QsAILPL+?=
 =?us-ascii?Q?9XOngii+GUgHN0qQPnhPis9Y9dJDruADw62uZvlD5OREiJrZb9+62EZfEcGw?=
 =?us-ascii?Q?7M5R4o+fjBW/snbBT9p0toNTXG24hMrcXLSrZix7EQZb/TNgBH1zaT3Sb/TH?=
 =?us-ascii?Q?PGD1wdxhR6SEjoijqb5iuEqy3qbr3txIxJ1tI5sv5+4t9gKLTmgn7JtqcqMI?=
 =?us-ascii?Q?9vR/QCZAbcYPvo6run8UTiT+z4rqdawIUHeGPM8M7uLQK/sDacg8rZtj562I?=
 =?us-ascii?Q?hg/ufL4tT+MfYkbGun5Bi/aPkvJKKrCP06MfkX3Ge7wWIympvBGMspIHGUfj?=
 =?us-ascii?Q?IzY3uWXsSQKpkM/yLlNDYIgJWtap4CjbhEO3jx5Qyj5p2PKWNiUU4//8Yw3+?=
 =?us-ascii?Q?5e6U+qI3S7UYXquTqTf86aGWe5gNHEyt2d5vgyxa7RksINc1T3AZj44Nz0gT?=
 =?us-ascii?Q?YNzq/dBkGTmxljo3tHI7gcp0Ru+jSDvyrWwqKJx2+t2d0l1zIkhAntnl78jH?=
 =?us-ascii?Q?FV0GRFURsRerd+C6vYhLKfmKGjkPuSwaBEV9XEcqGP3rQu1e49RfJ2aemdVF?=
 =?us-ascii?Q?JvzYOCLsf0kUByZLUnkdMpjsdE5VotbIAJScjMls/Z6dKszY7S9bE6c+82Qc?=
 =?us-ascii?Q?5MZNIuDGxVGHzICoBDj+x3JbVmC/4zrXOIuGc4kuaULK15NyLXpkg6bSUdp2?=
 =?us-ascii?Q?FCxNr02EkfoYe8pJ23badyUW9l9MSgWuxW5Y03gXQVnWw1bZYBIZMNhgIGtA?=
 =?us-ascii?Q?BSDhkKKnddJ4osTA2a0JhB64xhCSFXoVfpkgi6aENS5E0/SUCcYlDTnxy+qz?=
 =?us-ascii?Q?Gpkkx77nC0cwwGN93FVtAkno81Vb5x1Bq1U04soiTaz8CMxWB1LwMW2HV2zM?=
 =?us-ascii?Q?mOTr8E/mfJlOaqaaverp51Ke4WOChHnOPquhNwZRGzC2TrHkveN4vgX1ErU0?=
 =?us-ascii?Q?lx4EppQj/oJKAcXKZOOZWuc1HE8+kApoG5UsvVa7/hju4ZrcQjEXXM67njLe?=
 =?us-ascii?Q?Uww/UCqFmydvNnBpk9eNWcO9mPgGPss6eq/aczHxkqp3ND1WnS0IYEu77b/q?=
 =?us-ascii?Q?DvzpJjvHJFJJmv7hlCAjSatb2kQK6qjKb5KamhsYDPfBSu+2ZFkBU/ZkaasE?=
 =?us-ascii?Q?nmH1W1y7oeBfvIQuQ6P9NWQyMGJp0ZVfDIMqt/AfrGalvTZ0YlUR1mu2nO8w?=
 =?us-ascii?Q?2+nTjxslCoSxEO7NzFE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:37.1045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b73e2fc-84a8-4a13-c2d3-08de1cfaecbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 45 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  8 +++--
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ad5ca3fd847c..a72cc980ae17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3146,6 +3146,48 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
+	/* Each FD owns only one kfd_process */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+		return -EINVAL;
+
+	if (!filep->private_data || !p)
+		return -EINVAL;
+
+	mutex_lock(&kfd_processes_mutex);
+	if (p != filep->private_data) {
+		mutex_unlock(&kfd_processes_mutex);
+		return -EINVAL;
+	}
+
+	process = create_process(current, false);
+	if (IS_ERR(process)) {
+		mutex_unlock(&kfd_processes_mutex);
+		return PTR_ERR(process);
+	}
+
+	filep->private_data = process;
+	mutex_unlock(&kfd_processes_mutex);
+
+	ret = kfd_create_process_sysfs(process);
+	if (ret)
+		pr_warn("Failed to create sysfs entry for the kfd_process");
+
+	/* Each open() increases kref of the primary kfd_process,
+	 * so we need to reduce it here when we create a new secondary process replacing it
+	 */
+	kfd_unref_process(p);
+
+	return 0;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -3264,6 +3306,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 44ecdaf02657..02def4f830b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1054,6 +1054,7 @@ struct amdkfd_ioctl_desc {
 };
 bool kfd_dev_is_large_bar(struct kfd_node *dev);
 
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4350552e9648..236015993902 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -68,7 +68,6 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -1578,7 +1577,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
+struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 5d1727a6d040..84aa24c02715 100644
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
2.51.0

