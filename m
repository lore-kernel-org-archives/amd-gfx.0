Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC12CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694A810E58A;
	Tue, 23 Sep 2025 07:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ExqIbdjG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE6E10E589
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+7znS8+i+pdeiK0aNUD70rDNiyIz66tlR1wOEJ3YxieHTb5saCx2WLCgDNza4ELjVxnxHrTuv7TTK8m6D47ugOm+hiWFw+agxegILx6YuzWCBKSlKlZ6yF2307+eGy6qDzvyC9XW6KzIYLsApYkREqtyeVVrt3XHuR9eS66QFCdzmhXmCIcmEzKVufcI0HxHEayl7ShqJXBDIyhIaVHgXZGJYjPBzVhWY25HHzoyxE6SzZM0iHvYIzwXcQnJnDZvCg0LHMcNEbK2i7VuLv2K9KutIhPIwDAADxjzZTg1gurQH4QoXgHlOcHBJp8TvKyBHGBc7oLXj/gvXCvuvB5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EiNbNLuBtP0iiNkErIEHGdvyR2KhljGw/IhVd1B+Bc=;
 b=nyVsfS7rMxsVSXg+PerY1o5CiHH1eio7sNBKxq7knKMu7QJ0Ba5TGrtV0JFk7dPoDSWFCNzUKOdOxtbUEKZbiivwJxqjC2EHcqTFS5aAQLyG3DeFN/sUz9CRJy8+Z9FyqWYFfO2AxZ2h35sLLc/av3zuPu6pb1OqOV5wRjKvdNnUcgBbtEz9NO4GG9eugvr1JgFkTXYF53Q67z5I3TfikElnod/CSh68RsmIL+wTVBfjD0gZcVdJ/lKhkAxRVgrjofAZCDsVyAaHhc6qKqCVa0OKWooMIRX2JRM2+8GYeZ7BjrCYd+hyjt6klstuvH6IgqUMOmpqihJV5JnWoZ+p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EiNbNLuBtP0iiNkErIEHGdvyR2KhljGw/IhVd1B+Bc=;
 b=ExqIbdjGR2VXAK901oFi1xsrr6SmBIkqzC5WijubomuWtZpryk2DHihNdWFWTIlZXXthjRzNH6/z9gwL7BryBlBbSnwGrXNM9mMskLLW4NjiLKZxfe/GN5ib7pdnF75OKYCynimREeXRsjtfM6is1BJiqUQpOciQ/MHelbTFrqo=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:27:10 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::9e) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:27:09 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:27:01 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 18/18] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Tue, 23 Sep 2025 15:26:08 +0800
Message-ID: <20250923072608.252345-19-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dce45dd-2432-49ca-5539-08ddfa729b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OQOY7xIxBdYvchyDcpU0yTgcVtDKLP5kK+hVsvl1MHENz1y1JdReCI3BHnDS?=
 =?us-ascii?Q?8kaVjCjEHRMfcXmSv4SF7oqgfjALHEg2CAklZn+NBUBP6Sk1id+FUQDcG2tD?=
 =?us-ascii?Q?aMurcX7ZAeD3HcGCvUXeJG7Lwf49ACqFm/g1JeN8/zP2d6+p+HRqUE7cvnJZ?=
 =?us-ascii?Q?JT+tdbNi8s3PyI5qBZ7/fadTSNZ239jdNTEFm/S9pI8gH+Vmf8J7NB1mGGvJ?=
 =?us-ascii?Q?vB9ORGIZMpUVl6hMXlhvjfgvJhm7FOPCq/0WQkiai9u5LqMKe2oVBfofNRfL?=
 =?us-ascii?Q?RtDm0xVt3u7laUKxK8uVPUdxag890FOPsbabh3hjuGZ7SLcPUB+8AEdNa3ZZ?=
 =?us-ascii?Q?Dg2+SDagoV6DTk3aThOUUX62ljeExFSlR2bdsHTEHavIySkhpXmFNpnUvaSb?=
 =?us-ascii?Q?5Z3XKx/t54XPzQPJn9p1bN+WzjA6TnE8VFA+EDXz4nLJ+DUD7XyjBlxL3mgE?=
 =?us-ascii?Q?31+tz4nlfXkIWP7AbafHAQEk9FptVQ/FyXmoLOhGkS/B2XRK5c/nPM3xw/1r?=
 =?us-ascii?Q?AB91uBYejNqVHwv24oX3+T59HnE/tw21LrpBBVdsscdirmAp+K6QYyzTN/wZ?=
 =?us-ascii?Q?mGfj70jBTZWoGom/4XlNe3n+11jeMwFVQ3mXrFPonF/YbpwaKpCg/45YM4t9?=
 =?us-ascii?Q?6t33raQvPqGmZqu2gMngxD4HPKN3qD1SqKcMM7IVYAVMJMwgXOG904mVxxZJ?=
 =?us-ascii?Q?Gx6REhEgbMqunHtWRV/XVZDQqwuuank56IkyrYZqPNMrNd09VvJjPsn5Qo+e?=
 =?us-ascii?Q?DcFiYQXQOEDrHgsZfrPxLGGktw7CcKLeWBVJTFpc0DfvvEYpaEG4ErqO8Uaj?=
 =?us-ascii?Q?IDMJfBa/NBSzcEe3UozUXPAepvqn1dYPKWChm14krG8aMtJCVVgUrTTeUzx3?=
 =?us-ascii?Q?UMJi6ro7wo7hPiZ6TB77z0MlbK3wH48IycnPYN9evyzyM3Im/McaElPwTS24?=
 =?us-ascii?Q?oEEmhlNTSAPTGgs6SjA79oTc5juxN2hJIbLJG7JOUJ/lBWqDU2KqaxWuxFAd?=
 =?us-ascii?Q?4a61uJ/o3OcpElCP/HvWn5o4q/Ubhp+Xm2t0Ut4Ghvl7oJqMUZ5zNa53aGyN?=
 =?us-ascii?Q?J7blUIAVX6XljthbDNN3xln7nZgs7Y5UdoOhNnjwyt6pg/+ndBc4PaqPA7eW?=
 =?us-ascii?Q?eY4FqY032+R5nYXizzpVJ8kgPvwhtiK0U16Zx98l2ipx0BW2esTtilrVbDrF?=
 =?us-ascii?Q?xyFYkWipFlusmTNY/iaPkcqblj9z1MuE2xnFh1OltlRmiZVAjMM+VQ5tuYYW?=
 =?us-ascii?Q?iubTrUe0AzSp7gB4SdykfGbUeD0bc3cZzrP0SemPdLRO7wUI4WHdIa9WLEMh?=
 =?us-ascii?Q?kbDlzszL/yYC49KOLWTuV+doqdQzkr+i/7lZk4ipLFrfc7kiqsvfvXyhdxom?=
 =?us-ascii?Q?o93IuN5doplAhXGkIj17p3P9SoMhRxkL37dQtO98usaU6POuLKQibSDqdJ/0?=
 =?us-ascii?Q?hurFoqan063t5/uKXZMyl4BQgHtWd7qAL0GaXHLtvQp1H/nL+dfwuhyXUcfJ?=
 =?us-ascii?Q?niqKtdpT7X7LzSJeHW7D6zISisBJ3DCxpmyV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:27:09.6833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dce45dd-2432-49ca-5539-08ddfa729b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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
index 2df095e25c2e..a228cb32591e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3164,6 +3164,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
@@ -3282,6 +3320,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 65cf4c366124..9bab74758cf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1044,6 +1044,7 @@ struct amdkfd_ioctl_desc {
 };
 bool kfd_dev_is_large_bar(struct kfd_node *dev);
 
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e469ed951579..6ca7081cb817 100644
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
2.51.0

