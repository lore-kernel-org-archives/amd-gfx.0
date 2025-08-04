Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F42C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4278E10E443;
	Mon,  4 Aug 2025 11:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJ0ELfMT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B1110E443
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkHGLZO0bqzfdDKrB+11DXppKTAEDuiXJYT686NPqwmzI3MkoMq8Ln6mfdx6IDENCGKp7IFGUdUghQpAiW4kqoQc0rNtx0o53/4UqbO/1CXhbDgQHNubYTOTFrJ+fYUS60sROnBCqNIfsreHZ/E8fCVzOX2KW6XKHWgjuJ4oS+Lv7zMhr/p4yUbHzcOY2MbHKpzpUpOQ2BXIRYgLFWJnFbN6pUezCpq1XoTmHzN6XuMsHfnA9CFTm3f4gYuR3ZSzEwSBCCl1e9oNJk7NKHrf6/XaffsZjs//Dc56WA0wbkqCzSoqQYIbNTFMg9xDZqr6/9PhIno0CWOy8NX4vOsysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Abbz/TEp/C6lzYp3+htnOwWY+7yUgfdGaqWmwXM/Y=;
 b=EWp6DJSXpsx69CTUaY+WOFtrxd/6O4xpZZg0hMX6LU5xaeDTQwxLtKHnPom4maDjdUZBcsbhOKr9a87JeoiPunOOGBGD4uYFCImIHvwdTjMzFTwxgu+MjrXHC6Gcktm1HIlzVGonTmJ9+rJHEAvzT8sANzujiw72j+SN8jGeKIIlZkVbfLEe8vDwcLQT8lyqAU9/LnsfjTQWpiZ4fXKF19GLNWWM2B+5Z+JvbiXvKDa5zurF1TQWWL1nYx0L3RilIoqN2z/v9RT1h7IKOIi/kk1P/FSSjYTUKnBqq+UUmaFgzORmJ68F2PA5n9O2ziYaNHJe3aSNyApwOI5OX9y1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Abbz/TEp/C6lzYp3+htnOwWY+7yUgfdGaqWmwXM/Y=;
 b=AJ0ELfMTbXYaT0soeqK7qD4AxTKsMSiKE43wvux2bGH41ynsK6LRKnldRU0oRuazLNYWADtdlosUwZxdMRZ/PqYHxa+YtU9sHz2vW33yWtNhMnAcElDaZ6x/uGb1TKn+xIoHcmxU90cJ/GMSWYYVt3dtI2cRTzFse/B9dpHuvTo=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 11:06:53 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::78) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:53 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:50 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 13/13] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Mon, 4 Aug 2025 19:05:50 +0800
Message-ID: <20250804110550.261311-14-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6213ca-cd70-4f3f-1f8e-08ddd34704ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lDJqS+XlrgpSEoaNIDfdJAnfpzAh//O918CgiJ6xv7KzbY9UeUaVBYgsDaJz?=
 =?us-ascii?Q?JVFlPQE0VRlvyYBh+PDuQrSIH1XTJpxVBezmjzJ1yZKDLdj+Za7XWDC6KpQP?=
 =?us-ascii?Q?54HWOYkXWlLpgJBN1P1I47GX+EQL93nEnBqhU57tj9F9JIlIFN2a6D+yTPw+?=
 =?us-ascii?Q?dvsbllEvrjz3jj7jw2QcRFn1o3W50kUtLPKNFR+BDB/Vy108MdzsAWeAW+Uq?=
 =?us-ascii?Q?fRUNfTmLfUEnX+AF7h+Zq2QSJc0R7kxvpzieX7B9U2dQXaId4+ueQmN/iz42?=
 =?us-ascii?Q?kN66LehCfZa2SENe3RDe0c7x4XEApGtZ+Iaal9RcD8QK3zaYsOfnRLzp2i7E?=
 =?us-ascii?Q?T/W+S/Q3Lh7l54nTGkKGlT8XNZw5jY9j6+P+WMXNK1eigrceCZLVH7bWQaWa?=
 =?us-ascii?Q?ji4Eu8RZ4L1Cmwm6Yy3xG+KvXZ1XELGXBkNqxm3JOgKoXzJnnJqwW07Q5akf?=
 =?us-ascii?Q?zxaAonBCTMGszA9qq5NMZPXTayNX699Yhb7UZkZWcFnGso/AR5nUkPoco/RW?=
 =?us-ascii?Q?T0chLra9zT+PIGmf5V/+nw5nFDtN+JkNghzGWxEwNYDRADEbQVJWHOyclBze?=
 =?us-ascii?Q?4Tv0Isqx6WmHplaf6MMBgjsKr5Wa4uS4mMVdGI4k2gpUgRzx+hMAkBNW9BHF?=
 =?us-ascii?Q?HtWMX2iLCsnOA45TSKxYtpkVpVAM8C2h6S8OfIjiYoyIvY5+lHYsLMz4CipD?=
 =?us-ascii?Q?4YSyTu+f3fdPbzfiKkMH2do08bAABg+tK+nOaCi5y0j87SQGcOjVRv2GaN8+?=
 =?us-ascii?Q?Eex3Tqzpxt2efH8W18NK/BjvcK46R90ufVsuiYdyRc2gqQC2rvJNZUDbIKs8?=
 =?us-ascii?Q?ZeJVcbeK4QOQL/9SmhFguTw/Ne00Eu4F39V9Z+6WuLQBug6AerJNWHaA9J9A?=
 =?us-ascii?Q?gSMBc0jXvxmy2Y9121AHMsARiMsZznnOevWRT7DjlCFWl26oRLOc6L8ZaxXg?=
 =?us-ascii?Q?SgDPGbQZgNmOZWCtzip0yW9wsHcyD7JPXkil90Z2z25UEXU6KfYoRya1ehT6?=
 =?us-ascii?Q?LiK/k5dax03zDrIn0QHDiEx9TrB0elovEUCFwVfOst+KXImU0jIdMHV8WpzQ?=
 =?us-ascii?Q?TKZPffI7F8A8+qPeoy5LTw3a4400xlCxtqLnEX/rXr+wCCn9rJSN9L58Evj1?=
 =?us-ascii?Q?gTvOktbb9ELp44NFjKj7wSpm9chbNW006rJ+Kp7H9I1p7h96nho7oXuS3GtU?=
 =?us-ascii?Q?CwsYj44wU6kDMWbqL7/b0Fg/alguNeAH23zleFsSAWb4UHubbFfA8JbuhLHC?=
 =?us-ascii?Q?97zFyo51Kis58rguG7Ro/kDnXkmSb+BfmT5Sw/ESTTMqwUY0z2/Gu6VLia7j?=
 =?us-ascii?Q?ta9FcU8npzME3hJvOM5xTV91Ns/iYPvwDzARyiTaXA75+NdD1YeoNqp3h+fQ?=
 =?us-ascii?Q?BJZaFNV1RrdaCkdCcY5k6EOVULtX8ePGXYl0jFlWAIdAqhhaWpB7QIjgLn1S?=
 =?us-ascii?Q?JnKzh7NjxDJz4Oen0tYfzKI1jsoiM26huVIRysYIvOSw7ljTS9uzTIIajyWu?=
 =?us-ascii?Q?/qor9lxdbBoQHqiiRYvlkMVUVcNWNSRtoRFd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:53.0586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6213ca-cd70-4f3f-1f8e-08ddd34704ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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
index 662b181f1fd2..aeb5d4b31e9f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3135,6 +3135,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
@@ -3253,6 +3291,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 25534473c28f..95c7292bdd02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1053,6 +1053,7 @@ int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0c3f0cc16bf4..f51e3f4aaf48 100644
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

