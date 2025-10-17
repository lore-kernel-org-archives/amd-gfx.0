Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F58CCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02C510EB76;
	Fri, 17 Oct 2025 08:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDbQJOop";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B7110EB77
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEd10YgYlVjMgpHXwLu8KdpARS7fSS3pYDHvAZY0IYHJ3b0xS5pWn864R6WOKwyubetIUHLy35cHPzZKCOTdl6+wrLkoZTACE6JlvR/bweF2K43Cy3Ljq7T7ppzeOvUP77iOFKPsPFGJkTlEs2SBrNvYTtUNrQ6bdyVgG1WHXMeeGRCunfwbCiPLpST1RMWKJ80u+8hnT37EY/ODyIIGlHiwadHE4NOOPn0skO1/laa/BGyKp09+DFNUOGjchRoZvdd73yrhW6Mph2uJsHoTnrsIKHkhOVHcKg30rExC5/iybr9hpn371aK4sfiBF6Gvx8l3VF+HlnH4b9mnXQntyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vdSWXVAqc9MK7hlxdG/BxGcyO652fyyyW6bIsiBJWs=;
 b=A9ZSmE9V/H9Kx28SCZc03wXZ4AmmmgL7qLhmbXeFNBFK+nLyegoFJ/qx4kSijidtLkr/1eVoSu9pia+xRF6M+hOnA6Duj0TwafiGll1EhhCvRMUyO4XaD7KtM24jlvjY6WYjEimP65G/A+RyDSMmkyD7tyIp37Q5UkcBLSJdK/BoIU16pHbGKkKlg6pg7NQELJqLSVjRWuxtzJg+hbLbd8saXmSuAwg978VjOc3qPmrZI1Ufij6Xb2tvm5iW5GA0rDgkn9aCr4V8SXNInpHHf5kPoSSuXxbkAW5bm8V4kgEvMJVQYFN56SBzLjp0N4amlMucRgT5w6tc4NbNKHNWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vdSWXVAqc9MK7hlxdG/BxGcyO652fyyyW6bIsiBJWs=;
 b=PDbQJOopSGryDomjJHEFyxRaEz72PFwu7tpq9++cPV/cUcjc6TCs6FV6brB2hgps64k62PtF+LjpDwnvGTTZ5QE4tgl2Z6qeyo0McqbCJ5O/l7y23UBIuDWoZldhl4gKgn6eS1rLrN8HuEnkfdkiUFoe0TAB1SyTGEXhTekMkm4=
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:43:40 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::26) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:39 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:37 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 18/18] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
Date: Fri, 17 Oct 2025 16:42:22 +0800
Message-ID: <20251017084222.54721-19-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: da1c2c90-90a7-4708-9e3f-08de0d594547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7mkGI4ns4HWPNPwEjEpbezANUQCArEvdIwbchXvTTOsjXTb1yLbmHrD+n3c?=
 =?us-ascii?Q?dKwvbcI9vhhngfHYVe8KAOkh91BYexmc+y1j/kV0dbPMlsnFNFIZHHJnJVaL?=
 =?us-ascii?Q?JkhkFS8QA4zrHhvKauESeIV6AUzaD0I6zpGcQTEh1mqSpa+R8pFgJr1AeUMb?=
 =?us-ascii?Q?1FbqmMWuPxr5wRYuMmZ5cCRISGFT+Bq0Ulvos6ybiIq/Vrt6vpqOFK73CLde?=
 =?us-ascii?Q?kmNE/Q0VK6a6qdNcmjVcd/NSqE3ukREtC4iJtliImggPf/8i3Y/0xXw7Z1Ks?=
 =?us-ascii?Q?gsIhxGPMm/TXNtPKk2BkZ3MLsRRlZx2jRlIVJjAOE3e8xuIIANax7o9BI5mb?=
 =?us-ascii?Q?7Wv0OKvJ7zDfONYcT70gTYPacHTum7KjXrh79JapMQayhL8KK5LUZozcxeia?=
 =?us-ascii?Q?OL6Yv1QkBA7gWHZMkovr3MlqNLpi0IfvXN93frTPPHaA9vor3IonjaqU6K6k?=
 =?us-ascii?Q?/oL31mVuIsLv3W+zfWeb7/InDetQW3HshGUFkdvZFCIi9vhDfH7WXEtNZogO?=
 =?us-ascii?Q?rO9wHykeDY87i8vRjqZLhsSZuG5wdB8SoVtQwwEQmgp3CAzDoBLtLWKpG1cM?=
 =?us-ascii?Q?P8ZJxsqYcV8p1E7HmlQpVO7Vv9rXKko0SPPpWx4Fdp2RXXl4ht6xWi8H+9Sd?=
 =?us-ascii?Q?rg71cqDwyn0eRa+EjTK55ADM04/PRzabumCCHHseZ/P7CzlgHueCyBeRkT3Q?=
 =?us-ascii?Q?nMwL7EiCRoefrq5xYTgYKOk/omrxPr1lVc/I6KjfYyweJOjbCK993V73hLoz?=
 =?us-ascii?Q?Dx2z2ZmZScK0oxttt/OL4XcC7rwtaOC4ssxdGJi/Jm6cNx3QrfvK/OFJi6YQ?=
 =?us-ascii?Q?E4Tbpx55ddUgIB3CX4vdklysAUQ4MXl2VhA4M4JBT9dbxmfDZQcFziJy/7/g?=
 =?us-ascii?Q?gCkMI4EnSrKp0r053QvlUwVWFQVhzNuRig9W17GzFrnq4+mg4HT28cQgL/KL?=
 =?us-ascii?Q?+bxTUCbTnapA42mbLPnQA/Z7+Yn7OP+Mvlu8DqQ8e/m3BR9hoVEIbtSDLBph?=
 =?us-ascii?Q?KlW6hz3NV3c4OGwY4gaDdPZTOhEe5u+Ga02kha+Fdqbk7v6cVLwKyqk2kKzJ?=
 =?us-ascii?Q?UfF2conf+3JgtxkRRCdeOSEHx7252wOECBrGXDr0iQzDDRkEeexGIWS57gbs?=
 =?us-ascii?Q?rPsUabccvBCmpdED7NAD4pQZN1GtX/4MXF5mSPxZxEyEuE/ZdKtZof5yAPF5?=
 =?us-ascii?Q?B+/aZzD+lbHZ7933FSkdhXzSnJxgxyW/nQrpytfNQevFXixnSwt7lgYJztC8?=
 =?us-ascii?Q?eV1JwnaAolntyHMhcXlo1WClmCPU9Q/Yzin5mrh+2F5+zD5sBJ8wWUqfnRY/?=
 =?us-ascii?Q?64/0sfx6kw0Xr7adgWWtaUxBHsqX+X+6DFGxmz9IGL7fburBdYs9+dBoPPXe?=
 =?us-ascii?Q?cp//pRskgEKQpOeAgWfDBka54Bn8Si/rfdynPvmblmlsg/bJCNrmj0cS07KI?=
 =?us-ascii?Q?MU4kt5cJVbNKg4jwPzzkZysgk6t8Zs+q3oorZfnHOQf02QKRNsgpKaw9JsMJ?=
 =?us-ascii?Q?rhwxn54iN7tLXxnSPj8Qi92EghOoA3w12vdOSLZ7muaaydZVUwyzCqvAGvcK?=
 =?us-ascii?Q?FLb/kD2lISIIV+YBfaU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:39.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1c2c90-90a7-4708-9e3f-08de0d594547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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
index 7c02e8473622..8fe58526bc3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3140,6 +3140,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
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
@@ -3258,6 +3296,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4237c859050d..578f9f217e16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1055,6 +1055,7 @@ struct amdkfd_ioctl_desc {
 };
 bool kfd_dev_is_large_bar(struct kfd_node *dev);
 
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 629a706e2a13..bbb72a77bed5 100644
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

