Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2DACCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DA310E6E5;
	Wed, 22 Oct 2025 07:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NeWrXa3t";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DA610E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIKz+jpJmbpaBLMez97BUfuDXRyRVWh4+uqw2zIsr8pbf2OYoTVoblFnZNCWg6sY4vGUxW9+oSat6+n1IYw8y28EY7T6bGFlRCQZDu7dGDs8uy7oXYz/LO+tE7T2WZcoEBxcm1XG3XrCDenN6k8sIvgFOodMbrjhsV22MY7KzuPxUs9Yqy6J2sTC9eQOW8r0SQHfTFxVECjz/kH/rdxUQ63AQnMtrh17mWrmKHN1ug/MlnPKepUCqgQiExvnYU40KQ8v/Qs+aFvlvAIaQkYlX7G3OMCB1RnrkTT9HEMzr1d9A1qpG5SAmUcOoWsr7Tg9p9v7Wr0tl7+zQAg1RzPg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIhdM15VZZzSxNMdtNoOkmqIdzR8Zzy1HMqxYFItqJw=;
 b=khe0epP03Zk0GPrA2jPSZksl/s4E7z9puE9Fi1UmOgR05ccc93ZDZCq8Ifjkk+mvuCq7NDrnuZ9NIldVd+t1t5roigtlAiq9lM7TGyhAJi6f9Ih2SmejuCx4lsIB3dN+RBOftAMhmDwAX8wWs2Y2rbYSCvFSZpsa1s44WU4++31R/4cnqAqhGA1yrZlIgUHXpPShV33sgQLytEa/T0MsAowLg1nVpmHMcuDZyuL0MdCYFbhqWg7C71B414Ac9k2GdBmHMoj53WrJh1aR/8P9MMeRVQukwCZky8CGuHpgi0FUl3FyXLHpCLruSbSXKLCHbUp+tc2dyTECQxF75nMtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIhdM15VZZzSxNMdtNoOkmqIdzR8Zzy1HMqxYFItqJw=;
 b=NeWrXa3tkKtug4Iyl/jl80lkKCi+4bnNpoSjseF9osLtm3h7LnH84lgzpgSMywRmPCVnpq6qd6GS5mCxiVJ0rUVuUCaBBfUhdzvd0Xf4QvdpeJR6KXogkRJIuG1DX6ymoH3/Bypf5Am5IRpBFa7Co90a90r6E0A7ZE7nlI6vEfo=
Received: from SJ0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:a03:33e::14)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 22 Oct
 2025 07:31:41 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::44) by SJ0PR03CA0039.outlook.office365.com
 (2603:10b6:a03:33e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:41 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:39 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 18/18] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Wed, 22 Oct 2025 15:30:43 +0800
Message-ID: <20251022073043.13009-19-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 308cded4-62c9-4236-e096-08de113d0b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q//c6D4a9zly/IYOFYkkCoN/eDFt63iwfJVESD7i/kHUkngklVwAoTuyyNPC?=
 =?us-ascii?Q?MUxNyygGapJIVNWCLbB0Mt4fjvO4Mp84ZIdA4AqPKx2oHHPOUQ27Qw79NEw+?=
 =?us-ascii?Q?pNpfw2qg1pOVQAvU0QsW4oXBRJuBAtcVoaFC9iCd41uV68sfLN8NkNR5m2Cp?=
 =?us-ascii?Q?ldEGl2wsi4Q1s6/XAfIJdKnnjs6srQ738TrtMUGAQIYv0qWgR//b348MlATa?=
 =?us-ascii?Q?9dCZ1/bcmKLBjH3AqL8QbfNnmluFLwizqzX2TeR00pRtucrgt1Tp3p1rRkp5?=
 =?us-ascii?Q?zNM0BVtwkziWNnTWz4sFufTdRg+cJuEZTeOfX5KdWq6HfTzwqVmaW2wQN9rl?=
 =?us-ascii?Q?z++bRF7hT+SFCl0Ljtb8T47ucCEKcCzixlvUgMq1N73zZDV69HmqIQGr7OSY?=
 =?us-ascii?Q?8w1bdzB70GcSN5VFar6YWM4xhb/hilr0bwGUob9N1c8zABPrvktAY9QnmPG7?=
 =?us-ascii?Q?uC2mq7hQCRL0WIeEPLcHBUG/AeRD6rjQFVcNeI/aypYy1sB6cZc+4qjMdTZT?=
 =?us-ascii?Q?TlLjF1JxQnH/MF01yhEp8kBJfWNDT+ceWJo9VScrvZPRAhN0E2OF/HcaKLLZ?=
 =?us-ascii?Q?RGI55aQUoNG2G9+1+3KXeKJ9d1pe17XaP3Dgds6FtN+aFPxDxaTNB3hRwBo/?=
 =?us-ascii?Q?c1ULXZlv6FajbrnlbVj9pu3ddnnno135ZNY23XffsjM2DiHosouO2d0VPqY8?=
 =?us-ascii?Q?3JltHFbqyzoUUjaKSThCqcojhiLmsE/O7jSoIuBsput4K3jHvOUysfv/n17/?=
 =?us-ascii?Q?D9eGyxpjpV+wgTJohfTflnmuHqpDMPJFGdAPrY+E7SCjnMThOKTMpozvSUK0?=
 =?us-ascii?Q?giqaU5Gq7SsRvgOnVwtzEvaBQue9i1Y3LJ54xUd2nV3vLBGdEVDOYALN2yXo?=
 =?us-ascii?Q?aANnMk4i3EZOow/RKn08hhfELr1rrnhnfwE1jqa5O6Ps8WNnYyIWk5PcmoHJ?=
 =?us-ascii?Q?JUGzQKgpnUWgXqU19rrli6WD6yeAk5+6kbm2ooqFH2njc050NeSqOVG5VFhz?=
 =?us-ascii?Q?GS0PKtjfjCrorpou7u0/lfYPXk+UqUShPovxxFHbOmnT3KLDujOlivyx706h?=
 =?us-ascii?Q?Dt/0tnvcYohodyJ65jonkYeaJs5wGNVRM+YO0NwEM9p9BmBp6d8S/VWRPx3A?=
 =?us-ascii?Q?YVVxvVLun0Abrfl8cmTlRJB/vDehXBljyagmBoaHEmC34oP53IWwWjVBXLBP?=
 =?us-ascii?Q?na7U+kWOqrMCLdoIQfyxoTbFRELE20QnUiyPqg8SeQr8NHumnzeJX6M3y9ia?=
 =?us-ascii?Q?4py8nesld4xyoTtyC0xxKn/yzTdn/YcH+Es6+X9Szs4yVS+ZwjSidd2mYTb/?=
 =?us-ascii?Q?c/0yReD4oIE798q6wMA5dfBw3RhkZcbxXfOquL2yLaBDqnxi9Qf2LT3Ikz6N?=
 =?us-ascii?Q?HB8zBTEnQovFbj2YAUWuCm398HOrwMS6pQccW1Hx7BJKaY3BqdFBRkXXAys4?=
 =?us-ascii?Q?Ozp+iDeGqteTDTT1wPSk7K2v+oqOZDZ5EmT7dGCn4G/zrsNUDOzzQh+fsHs1?=
 =?us-ascii?Q?+uJJNm/02BHb9a1QarmV+OzihdFAF88P18Z1QpIbkLibzk60PLniMtv0l0qh?=
 =?us-ascii?Q?pePe4Ep+H+q+LGcGVvc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:41.2317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308cded4-62c9-4236-e096-08de113d0b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 46 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  8 +++--
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ad5ca3fd847c..04862fa820f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3146,6 +3146,49 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
+	mutex_lock(&kfd_processes_mutex);
+	if (p != filep->private_data) {
+		mutex_unlock(&kfd_processes_mutex);
+		return -EINVAL;
+	}
+
+	/* Each FD owns only one kfd_process */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
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
+	ret = kfd_create_process_sysfs(process);
+	if (ret)
+		pr_warn("Failed to create sysfs entry for the kfd_process");
+	mutex_unlock(&kfd_processes_mutex);
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
@@ -3264,6 +3307,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
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

